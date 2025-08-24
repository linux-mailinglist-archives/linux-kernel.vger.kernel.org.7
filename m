Return-Path: <linux-kernel+bounces-783554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 633B4B32EF0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 12:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21CAB444D5B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 10:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AA421885D;
	Sun, 24 Aug 2025 10:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="SuCWFfED"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76A21D555
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 10:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756030782; cv=none; b=DtdEFH+URLK48ATpG+SAEHrBflpGyQlPfn+ukx5w649QqXUx0FA0lzxa9ikkaHY1kVoxRaxOI/GnTnsy5yElCtew8/ai7JD385q9dxwwWXD85GNSwalKCCYHyNNCOyylk4k2vn389lkHz0jU9McAhDEOu+9oRvDw5ztveYIiy9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756030782; c=relaxed/simple;
	bh=lMoHdEFeo4fHF672LOmVGZEsHVdVgj7UzDG6HcXQFpg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SUx+iGoOvykvHrgGUa34z8A32vJTD5ftNNHwa2zm0mU9MHIB57wUB1iJM94eBCnLKnZ4oB0r8VINk6rWojLp5uvntGW2PNlOSfzQGZUqBWUiP7YtpIHcGTziGMzqGU1ohK9L/+BH28/yY4MmVc561W6lx9IQJ01GS1vJ5weG9fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=SuCWFfED; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A775040E01A1;
	Sun, 24 Aug 2025 10:19:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SDkrQ2EtEOLx; Sun, 24 Aug 2025 10:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756030775; bh=p5M0aw0zkbqybNB6kRZvfXXr212cpihKrTLk6HqTA5I=;
	h=Date:From:To:Cc:Subject:From;
	b=SuCWFfEDUC4dTIIrXgrQGYjTTKh+tuFuUTOt1BwwtOS8DGi4tGOvUwTBJfuPdKdWP
	 GKxbo99nTIWGlzzfKkx4sJrLwflikpCtHK18YD+yZBcSDzq8EiVS027u6VdJlTeb13
	 /wTeC+NkBdv7710URoRk8Oqf5EJtDC58xrwsOIPhdtkse15QeYIkTKGo3UAx6UG7Kv
	 iBvJxlgpOenEG1Yt3lc/BqPmbgW2U9TxxVjTeOK8G0KxM+y4bO7qSztrm8THdW4nrO
	 Te6Dm6LV03iWLPKLOdIIuI2LBiJEUQwcD3de7uemq02CP7eM6k2srnskpIqRxAQy8i
	 Ne+gQEoMIaS5am/PLR79FiX5b0lha1HWbJ17rdvOPaLIwjSlF++Ae8Nuvpf+pFl5aN
	 Zz3/nUQJG0g6uBght6J+uK6acxhDtApXaasgA1AChQooZawEQNocchDtgMsSvtK5iV
	 dFoCi2MPEITYBGB1HEucWvH7lBxsjWi4Smh7N7FlNBfhU26BnD7iLDj/C0wfDOAKMj
	 MSxaxtYPgHDE9xSxDyz3nGMAiFzKTIh1ir2jLSjq1goRm/2v/+JjZ7ZLBNsbq98g6C
	 8OtyHQaCJhRYJ95Nub3C1NdwtY74MSl9GcKoit4tUgOAfo+MrDqaZHL6xza+AHCJGU
	 hiGJXmF8pG7HVfm8J6HyiXz0=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 58EDE40E0176;
	Sun, 24 Aug 2025 10:19:32 +0000 (UTC)
Date: Sun, 24 Aug 2025 12:19:26 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v6.17-rc3
Message-ID: <20250824101926.GAaKrnLixrYKcVosGm@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the x86/urgent lineup for v6.17-rc3.

Thx.

---

The following changes since commit c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9:

  Linux 6.17-rc2 (2025-08-17 15:22:10 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.17_rc3

for you to fetch changes up to d4932a1b148bb6121121e56bad312c4339042d70:

  x86/bugs: Fix GDS mitigation selecting when mitigation is off (2025-08-19 10:38:04 +0200)

----------------------------------------------------------------
- Fix the GDS mitigation detection on some machines after the recent attack
  vectors conversion

- Filter out the invalid machine reset reason value -1 when running as a guest
  as in such cases the reason why the machine was rebooted does not make
  a whole lot of sense

- Init the resource control machinery on Hygon hw, also in order to avoid
  a division by 0 in addition to actually enabling the feature on hw which
  supports it

----------------------------------------------------------------
Li RongQing (1):
      x86/bugs: Fix GDS mitigation selecting when mitigation is off

Tianxiang Peng (1):
      x86/cpu/hygon: Add missing resctrl_cpu_detect() in bsp_init helper

Yazen Ghannam (1):
      x86/CPU/AMD: Ignore invalid reset reason value

 arch/x86/kernel/cpu/amd.c   | 8 ++++++--
 arch/x86/kernel/cpu/bugs.c  | 4 +---
 arch/x86/kernel/cpu/hygon.c | 3 +++
 3 files changed, 10 insertions(+), 5 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

