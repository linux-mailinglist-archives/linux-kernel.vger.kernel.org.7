Return-Path: <linux-kernel+bounces-833890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3427BA34C1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30BF31C04723
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2052D593F;
	Fri, 26 Sep 2025 10:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZCdlsNDu"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A817149E17
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 10:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758881352; cv=none; b=fDNODlZv2Ydp/zm90SMXrazrGLQDVEiiCpc0vs4DFUw+aifzSsjFE9aPGg4M2p9ivh/3/Ym1/FxaKS7saCyyjC5Ekvwu5X1N7sVLMWn14o0dckYgvIJ+gaCldZQSXBCOCBZ2pMHgG4Iv1XJpNiq/AUMnLnxrEneK2lICLMVia2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758881352; c=relaxed/simple;
	bh=aYKlmBairyD9cxv/lIsQhKHRFhxtfapxr8y79SRhWCA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lk49xYEev3ObQSpRSWXZtvgixhetjPiq4YyV9xGdNd+srxM46ynIGnhQONCPRBeT3HsMrZ5CrtuppayI8d8qricB/yx4w79OtyhClPMwpbOx8BaQg0QesOdsjgDrraDJ+mEc4jIuOwgVjOCCqMUG5j5cN2DCeUQHu7ccaUX5R0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ZCdlsNDu; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3CFDE40E016D;
	Fri, 26 Sep 2025 10:09:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4NAINkbVlcdx; Fri, 26 Sep 2025 10:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1758881346; bh=+ybvvjGX5LbwACTnmhexd/+7Owr5B1pcS4MEBmEVaXU=;
	h=Date:From:To:Cc:Subject:From;
	b=ZCdlsNDu0PzRpsxtbe31I5/gapyq1RXwhrW8Lf6KkuQWTSywZ9PZ1n5Z1UeMtkjrJ
	 P60IA8mY88GfN2tsqFI5vrhJDoSg+lNDyXdMaaUngsy5IEiCMNCL34UuCPoTlpZVmk
	 93LnC6UacHJ+O9mpjp6QtdTZZtxXsLtUkP7tGrqeeOrjZ6sDx4PjKX90vMhEoF5xHf
	 DpHVtzltOT+xt2s3XG1EsbJQMXE5QtxTXNAgrTwj9Q51fj7BiyhKtdBdQN1q/otfTk
	 Si1zroE3hEWakBXpNF3nd8msrY+/EJQyH6Uzho4pikRIW3Rg+iBz+vWWvZDJR4W1Nr
	 F+Rv1WxY6QIiCkFwnU+ALdO/wZ7F1bjcsNsUAWb+4XyNP6KOM8AdBeacXp7jod/YJD
	 Vs6PHnBDqbMwkJUuVPiupcaddrIdy5rPHzN0ZusL1257U43amZ0X9GDa3HM6rU1Qq/
	 M4dfvtoyrQt45GLUJanH0tENDL3dCREPLchhuDNN1gQYE8fhWcpTAgvuTH801G4siI
	 L8e0C0Tfck6t7kxGOuSnYh4j+iF9AsvTCvZMVeZDauqp5vDMwbFPEVPAgiznYaPF/D
	 NCAm3Y+hmnMGWwQzdah2pZ6hfHCPGmbwZemCNJkDyJg/NBDaYFytweuq0v/Ocm0Nwy
	 UbLimbw4XJ5iG/bwgtFwYrjA=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id E097C40E016E;
	Fri, 26 Sep 2025 10:09:02 +0000 (UTC)
Date: Fri, 26 Sep 2025 12:09:02 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] ras/core for v6.18-rc1
Message-ID: <20250926100902.GAaNZmPiC7PTIVfWo3@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the RAS lineup for v6.18-rc1.

Thx.

---

The following changes since commit b320789d6883cc00ac78ce83bccbfe7ed58afcf0:

  Linux 6.17-rc4 (2025-08-31 15:33:07 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/ras_core_for_v6.18_rc1

for you to fetch changes up to 5c6f123c419b6e20f84ac1683089a52f449273aa:

  x86/mce: Add a clear_bank() helper (2025-09-11 12:23:30 +0200)

----------------------------------------------------------------
- Unify and refactor the MCA arch side and better separate code

- Cleanup and simplify the AMD RAS side, unify code, drop unused stuff

----------------------------------------------------------------
Borislav Petkov (1):
      x86/mce: Cleanup bank processing on init

Yazen Ghannam (12):
      x86/mce/amd: Rename threshold restart function
      x86/mce/amd: Remove return value for mce_threshold_{create,remove}_device()
      x86/mce/amd: Remove smca_banks_map
      x86/mce/amd: Put list_head in threshold_bank
      x86/mce: Remove __mcheck_cpu_init_early()
      x86/mce: Set CR4.MCE last during init
      x86/mce: Define BSP-only init
      x86/mce: Define BSP-only SMCA init
      x86/mce: Do 'UNKNOWN' vendor check early
      x86/mce: Separate global and per-CPU quirks
      x86/mce: Move machine_check_poll() status checks to helper functions
      x86/mce: Add a clear_bank() helper

 arch/x86/include/asm/mce.h         |  11 +-
 arch/x86/kernel/cpu/common.c       |   1 +
 arch/x86/kernel/cpu/mce/amd.c      | 163 +++++++++----------
 arch/x86/kernel/cpu/mce/core.c     | 315 ++++++++++++++++---------------------
 arch/x86/kernel/cpu/mce/intel.c    |  18 +++
 arch/x86/kernel/cpu/mce/internal.h |   9 ++
 6 files changed, 236 insertions(+), 281 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

