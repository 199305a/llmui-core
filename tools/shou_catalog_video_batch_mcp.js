// MCP browser_run_code: pass filename to this file. Page must be learnCatalogNew.aspx (課程目錄).
// MAX=20：跳過 bullet_green，其餘 _720p（非 .docx）依序新視窗播放至 ended 或 ≥95%。
async (page) => {
  const MAX = 20;

  const apply2x = async (popup) => {
    for (const fr of popup.frames()) {
      try {
        await fr.evaluate(() => {
          document.querySelectorAll('video').forEach((v) => {
            v.playbackRate = 2;
            v.play?.().catch(() => {});
          });
        });
      } catch (_) {}
    }
  };

  const pollDone = async (popup) => {
    let sawReadyVideo = false;
    let allComplete = true;
    for (const fr of popup.frames()) {
      try {
        const s = await fr.evaluate(() => {
          const all = [...document.querySelectorAll('video')];
          const ready = all.filter((v) => v.readyState > 0);
          if (!ready.length) return all.length ? 'loading' : 'none';
          const ok = ready.every((v) => {
            const d = v.duration;
            if (!Number.isFinite(d) || d <= 0) return v.ended;
            return v.ended || v.currentTime / d >= 0.95;
          });
          return ok ? 'complete' : 'playing';
        });
        if (s === 'loading') return 'loading';
        if (s === 'none') continue;
        if (s === 'playing') {
          sawReadyVideo = true;
          allComplete = false;
        }
        if (s === 'complete') sawReadyVideo = true;
      } catch (_) {}
    }
    if (!sawReadyVideo) return 'loading';
    return allComplete ? 'done' : 'playing';
  };

  const done = [];
  for (let i = 0; i < MAX; i++) {
    await page.reload({ waitUntil: 'domcontentloaded' });
    await page.waitForTimeout(1500);

    const hasNext = await page.evaluate(() => {
      const links = [...document.querySelectorAll('a[href*="directory.aspx"]')].filter((a) => {
        const t = (a.textContent || '').trim();
        return t.includes('_720p') && !t.includes('.docx');
      });
      for (const a of links) {
        const par = a.parentElement;
        if (!par) continue;
        const img = [...par.children].find((c) => c.tagName === 'IMG');
        const src = img?.src || '';
        if (!src.includes('bullet_green')) return true;
      }
      return false;
    });
    if (!hasNext) {
      done.push({ note: 'no-more-non-green-videos', round: i });
      break;
    }

    const ctx = page.context();
    const tabsBefore = ctx.pages().length;
    const urlBefore = page.url();

    const label = await page.evaluate(() => {
      const links = [...document.querySelectorAll('a[href*="directory.aspx"]')].filter((a) => {
        const t = (a.textContent || '').trim();
        return t.includes('_720p') && !t.includes('.docx');
      });
      for (const a of links) {
        const par = a.parentElement;
        if (!par) continue;
        const img = [...par.children].find((c) => c.tagName === 'IMG');
        const src = img?.src || '';
        if (src.includes('bullet_green')) continue;
        const t = (a.textContent || '').trim();
        a.click();
        return t.slice(0, 120);
      }
      return null;
    });
    if (!label) {
      done.push({ error: 'click-failed', round: i });
      break;
    }

    let popup;
    let sameTab = false;
    let found = false;
    for (let w = 0; w < 150; w++) {
      await page.waitForTimeout(100);
      const tabsNow = ctx.pages().length;
      if (tabsNow > tabsBefore) {
        popup = ctx.pages()[tabsNow - 1];
        sameTab = false;
        found = true;
        break;
      }
      if (page.url() !== urlBefore) {
        popup = page;
        sameTab = true;
        found = true;
        break;
      }
    }
    if (!found) {
      done.push({ label, state: 'open-failed' });
      break;
    }

    for (let attempt = 0; attempt < 3; attempt++) {
      try {
        await popup.waitForLoadState('domcontentloaded', { timeout: 45000 });
        break;
      } catch {
        await popup.reload({ waitUntil: 'domcontentloaded' });
      }
    }

    const end = Date.now() + 2 * 60 * 60 * 1000;
    let state = 'loading';
    while (Date.now() < end) {
      await apply2x(popup);
      state = await pollDone(popup);
      if (state === 'done') break;
      await popup.waitForTimeout(1000);
    }

    if (sameTab) {
      await page.goBack({ waitUntil: 'domcontentloaded' }).catch(() => {});
    } else {
      await popup.close().catch(() => {});
    }
    done.push({ label, state, sameTab });
    if (state !== 'done') break;
  }

  return { finished: done, max: MAX, rule: 'skip-bullet_green' };
}
