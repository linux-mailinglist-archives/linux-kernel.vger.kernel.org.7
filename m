Return-Path: <linux-kernel+bounces-859658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F16BEE383
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 13:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3F2C4E4FEF
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 11:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAB72E542B;
	Sun, 19 Oct 2025 11:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="WGMUgZUg"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C46F23816A
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 11:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760871942; cv=none; b=mucSTuKkgZJ2nKnTxez2i3RlKcWysNKsN6kd9prxXPkhKMvI1yHIkY+ApOf1rnX7Vzo7gDMb0bzoyR1Ss/f//CmjQ4soFZFYMQOYta1RIVdsOLbpaDzgznBTx3PBeKpo5OQiuwX6DOPUS+aDVed0vWYDZHQ7Nnc0gRF4X+iDXUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760871942; c=relaxed/simple;
	bh=mtppI3GbvGPYGuvfggEn77JfbO5GpD7vmhaWxV6f9mc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Y4+gsJp7rgrkS2hzm5S4HDQlEpEyymsZf9XWCsT4twf4N0+eJkVz8iw45Py+6sORK31Y/CBialegDc/1TlaunqVhgAOboeOpz+xkNEuOgclXQrZuR75i6l5VFxPwa2nzQY5R+QgFU7Y0OUcJ9fUu7Ym9FF37iI/Q9k1gOhyl0so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=WGMUgZUg; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BC75840E016D;
	Sun, 19 Oct 2025 11:05:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xeqCWeU5drBr; Sun, 19 Oct 2025 11:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760871923; bh=Nc88c/F5pSROWALM8RaKBBRpvx6fbBnNjh6nyxvR64k=;
	h=Date:From:To:Cc:Subject:From;
	b=WGMUgZUgv5TdknuZ8oH+p67qLb74GcABWTbS7F8FyYZsOLKv8yUCLBC4nMYD9h9bi
	 BCZHaZC2coALW9rXBBrW/Zmwb/OoP4KryvrS39TYXe83F0/gvTt73lj7i8N9rt9F+y
	 lob1y6GRdRZS2GMjJs1NhGLRVP+4Hqxo7ELGlrfauwIGjFlUW/HjIlMzfwFzZLmYHv
	 cKfY0evJDqq4VVF+1sudRT6XiwVFGA6/Zv6NuWbSASACKcR87cmYzvWtmKoXxhaEeV
	 WujFnONcE4W31Fipk+mOPMZRxFDDzwz9nI60aDiYZJ2pUvqsYoVfQ4slIfyP62KBDT
	 DNDPQpBYjxLPocC8XpMJA6TqmqSkF65fwAPeijxlRi0BmPRdW5RprBb0Hx5xeO+E98
	 EQEh27NXBolaLL0sdoS3id1cqrToDq18ZeK2keoBhpBKfQhFQNjtbdspWchb3Mx98n
	 mo3zp0Sba+MzLwtaELrYf6VQMIVjCyqdHkBfUXQEOleRi51M2QJKfAM29IGDhnwDr6
	 uJfweFj3ViXMOlvDu4cVnOJnkk24DpysXvFkOXWDLXP48I02nVldl040DtXcu4TDhx
	 b/KuH57CUNSF65W//UqXSOPD3insrdC4Nq6qSIsqiE54L8ZsfyaoN2pQY/1DACgAab
	 SX8/2M26WKnUEVPaGg8mnawQ=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 6F1BB40E00DE;
	Sun, 19 Oct 2025 11:05:20 +0000 (UTC)
Date: Sun, 19 Oct 2025 13:05:12 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v6.18-rc2
Message-ID: <20251019110512.GAaPTF6LixGcvVysQ7@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the x86/urgent lineup for v6.18-rc2.

Thx.

---

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.18_rc2

for you to fetch changes up to e6416c2dfe23c9a6fec881fda22ebb9ae486cfc5:

  x86/CPU/AMD: Prevent reset reasons from being retained across reboot (2025-10-15 21:38:06 +0200)

----------------------------------------------------------------
- Reset the why-the-system-rebooted register on AMD to avoid stale bits
  remaining from previous boots

- Add a missing barrier in the TLB flushing code to prevent erroneously not
  flushing a TLB generation

- Make sure cpa_flush() does not overshoot when computing the end range of
  a flush region

- Fix resctrl bandwidth counting on AMD systems when the amount of monitoring
  groups created exceeds the number the hardware can track

----------------------------------------------------------------
Babu Moger (1):
      x86/resctrl: Fix miscount of bandwidth event when reactivating previously unavailable RMID

Ingo Molnar (1):
      x86/mm: Fix SMP ordering in switch_mm_irqs_off()

Rik van Riel (1):
      x86/mm: Fix overflow in __cpa_addr()

Rong Zhang (1):
      x86/CPU/AMD: Prevent reset reasons from being retained across reboot

 arch/x86/kernel/cpu/amd.c             | 16 ++++++++++++++--
 arch/x86/kernel/cpu/resctrl/monitor.c | 14 ++++++++++----
 arch/x86/mm/pat/set_memory.c          |  2 +-
 arch/x86/mm/tlb.c                     | 24 ++++++++++++++++++++++--
 4 files changed, 47 insertions(+), 9 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

