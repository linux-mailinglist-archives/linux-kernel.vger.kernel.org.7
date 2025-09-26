Return-Path: <linux-kernel+bounces-833894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF69BA34D3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3507A1C048FC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDA329DB61;
	Fri, 26 Sep 2025 10:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="AXfTs7tc"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE5838DEC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 10:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758881507; cv=none; b=LCWYXQ3KLA5p6ZwnAPTg3EV96AY/FUPLPr8MN67QxiQXHlnnfZHpKeSlpTIaBh+/eFmsNsh2Z0Lh4cRambvLFH35F2JgrWmqSYCSLdkwaLzAo/84B7KLNsfpjV5jzOxosateAnSweC9247q7Q+IDpROPtbFS1sKMO2nSlQ40gCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758881507; c=relaxed/simple;
	bh=abpBrcjqTiRxgMrgBBLtfw2nJfI8IbdQPpIUhMO8Ioc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DreUGWlT2/lypgtwBrC1Ajvj8LkB8FxAjtzBWm6vbxnACfsCu34qpuLg/dFbIELdR3/ruyRpOTvlcW48sOPNB7jpgXP/YPiJXp4c6/YdL6YbFrkerxOw9moiEq0+/mftHr03LZUgGtbBWiV7M6StK7E/hYouQPLXblIXG6X5Yzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=AXfTs7tc; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 16D8740E016D;
	Fri, 26 Sep 2025 10:11:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PkAH1R_TxWjE; Fri, 26 Sep 2025 10:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1758881500; bh=Y+waRUxQkRK3VCsqbWCe1fnvftj+yQzREv46JEjshyo=;
	h=Date:From:To:Cc:Subject:From;
	b=AXfTs7tcA5tnGp6U1KnWL1XUVieQm6hciJdy08twLQP88JvollM1Lnc5NVsELJ67i
	 OKispeFJXWZ6Sbd9mo8mVPxi0kTdAQgeP45elLPV3MvSL3nW9dKT0FucTImBaR5IUT
	 lsmtmGyAdToQfan5SAtuzYuV9gMbQ+rg+BDJctOSRs3LD4T8N7mopnEV/eVB2xMLsc
	 Tk/33sOkA8BOv2YjdbXnx1NPjkb95pbwYGLpafM7umslDBR5gaAC/D3VyAzi0JVTmg
	 9iGX8QUTPNfqfxYEdE2g0wk7FjF7d+8VsCi21EhfVIxuGMaYRhATcQLfU4+9eQxu1K
	 6N7YZKN9B+YFWr/htuSAa+wU5yIb07hubaycsPkCJA9hPt+Ryr/4utP7v3MigwHTB6
	 O9lEjzLku1rXzdxBK6ZBlx7W2GPkSZspohy08gPK1HnEcCHbDjca+3YdNTUVeBprwf
	 u377utzRQj6jN1pRYYTAjA9B1fiB4+yA+H478FvqIal8ILmMyOR1hAe//rgjcTs9xR
	 6LH1nVgjhQW9FigMrZSsgeq3Yi8G/hysXvZxGe/Ixl7j4hN9ord3iLdNgzHWZJJaqD
	 CmtP01YHqjsVjC7Qp+RTJwYelfhiDPVGLwTs1hONN9XUMW0LXaVt0/fDLvDqCtfLSF
	 WBkT/QfPhcJY0Y9n0in2A3Wo=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 7C0DD40E016E;
	Fri, 26 Sep 2025 10:11:37 +0000 (UTC)
Date: Fri, 26 Sep 2025 12:11:36 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/bugs for v6.18-rc1
Message-ID: <20250926101136.GAaNZm2JLV-DqtF1IC@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the x86/bugs lineup for v6.18-rc1.

Thx.

---

The following changes since commit 223ba8ee0a3986718c874b66ed24e7f87f6b8124:

  Merge tag 'vmscape-for-linus-20250904' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2025-09-10 20:52:16 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_bugs_for_v6.18_rc1

for you to fetch changes up to 930f2361fe542a00de9ce6070b1b6edb976f1165:

  x86/bugs: Report correct retbleed mitigation status (2025-09-16 13:32:18 +0200)

----------------------------------------------------------------
- Add VMSCAPE to the attack vector controls infrastructure

- A bunch of the usual cleanups and fixlets, some of them resulting from
  fuzzing the different mitigation options

----------------------------------------------------------------
David Kaplan (8):
      x86/bugs: Add attack vector controls for VMSCAPE
      x86/bugs: Use early_param() for spectre_v2_user
      x86/bugs: Use early_param() for spectre_v2
      x86/bugs: Simplify SSB cmdline parsing
      x86/bugs: Remove uses of cpu_mitigations_off()
      x86/bugs: Fix spectre_v2 forcing
      x86/bugs: Fix reporting of LFENCE retpoline
      x86/bugs: Report correct retbleed mitigation status

Josh Poimboeuf (1):
      x86/its: Move ITS indirect branch thunks to .text..__x86.indirect_thunk

 .../admin-guide/hw-vuln/attack_vector_controls.rst |   1 +
 arch/x86/include/asm/nospec-branch.h               |   1 +
 arch/x86/kernel/cpu/bugs.c                         | 412 +++++++++------------
 arch/x86/lib/retpoline.S                           |  75 ++--
 4 files changed, 214 insertions(+), 275 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

