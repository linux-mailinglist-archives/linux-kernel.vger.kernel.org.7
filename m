Return-Path: <linux-kernel+bounces-729022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 456D2B030A2
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 12:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2322D7AD59E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 10:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF4026CE06;
	Sun, 13 Jul 2025 10:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="boMY+xsk"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0121F4181
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 10:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752401546; cv=none; b=u0XOzHC+Vb/IZi6S/dTHaJf7/aAsbuY2WcBuFGh/GqZGFj/cUT1D6/gGFlS9e2XDgjfC4Aex3sEmnmX5pOblCetTsjiwvt2MKSOh7QeibMUMCXKT+lMalL+1aJhrqb/x96Z94/24QvlnoJIUR5ul2oojT9yqLZmRe0n1ddPPRlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752401546; c=relaxed/simple;
	bh=OHV/xgKN+rjFYFf8dUvKWwHVVdsbNrEKHk1qHeSN3a0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=f4dsjIA5ynZNlvvKgaFsXFR7PbcK4fXbBCE1A30HBjV2pSsNACCTw1BAk0CAKlZViqyfsqNha3BuWVROxLyjTPKFdOfnh0XMxz8Q8bl1q0RCeQA9TWpGYCOha8LfeW3qreMs1N/CxlShWYp3LqOl5SAiDm1gDm2uBXsHe7zGD8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=boMY+xsk; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B056540E01FD;
	Sun, 13 Jul 2025 10:12:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fFfUqxjcv6sn; Sun, 13 Jul 2025 10:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1752401538; bh=nmwx7vW50Xkq0mJfIv8autzFMqtSL2hA9+DJRT+fip0=;
	h=Date:From:To:Cc:Subject:From;
	b=boMY+xsk5dtH5XM5nC2oVZDBHtY0BMfIU5Nx6QyIziU2XWll/JmaHyoK6XA/4fgpL
	 fAQyEDpQhDbxdiwZnHx2KUex78NkUMSeM+hO/TVVvQvYjWFDq4fF+D/ta8360Rxkb3
	 VkhlJA6RRSVhBi1v8Rd0Rh7Sx708cdgGL9DFtPP548cHTUfg3/ZbSgqBQ8IQyrVs9I
	 7J3FiEHt2kORg26/c5LK9J4r/WxbN+Jgqm9XkNpq7MINXBXAidrj17UD4H4+9Pii8R
	 IyVTjN6qPoQ3fu1nLxRRwBC8+faLysUP21lergyJM6H74gBXROcnweWuXW7qcV4tOZ
	 CSXZAmT9uPw1rSsOj1/i1q/BPSzbeX/gxkVe8Hm7jp8ys8b3oZuE7MnSrHRb9fF+iL
	 cUq8awW5nqYji9HYnOGc6hmAqpMJiaSPwMCaDmXgJz7b2hkN9hI0hsy1IRHMheitJb
	 hpJfzyJvUxVPbRgPnyphJ7+rfYDNraOFF6t8mbOgwG9CfAc4vvcJnIHG9RJ6UWxv73
	 GhG0ubWgLyNwcyDQfkPrJ/YVNvSIewVdAtQ/x2we6fbtNWNPjYT8uJtdNJRmQBBRVC
	 MEYG4tfmE38idVLyD9sDASP3x21tWeXE5Bs+B/lfQvQ09K3zl/BF13sUlO2l4fe09B
	 gv+bziVjVjMmD1ZMcgVPb0VU=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6FD1E40E019D;
	Sun, 13 Jul 2025 10:12:15 +0000 (UTC)
Date: Sun, 13 Jul 2025 12:12:14 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] irq/urgent for v6.16-rc6
Message-ID: <20250713101214.GAaHOGfkN6wjED7LW-@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the irq/urgent lineup for v6.16-rc6.

Thx.

---

The following changes since commit d7b8f8e20813f0179d8ef519541a3527e7661d3a:

  Linux 6.16-rc5 (2025-07-06 14:10:26 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/irq_urgent_for_v6.16_rc6

for you to fetch changes up to a8b289f0f2dcbadd8c207ad8f33cf7ba2b4eb088:

  irqchip/irq-msi-lib: Fix build with PCI disabled (2025-07-10 23:46:05 +0200)

----------------------------------------------------------------
- Fix a case of recursive locking in the MSI code

- Fix a randconfig build failure in armada-370-xp irqchip

----------------------------------------------------------------
Arnd Bergmann (1):
      irqchip/irq-msi-lib: Fix build with PCI disabled

Himanshu Madhani (1):
      PCI/MSI: Prevent recursive locking in pci_msix_write_tph_tag()

 drivers/pci/msi/msi.c               | 4 +++-
 include/linux/irqchip/irq-msi-lib.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

