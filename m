Return-Path: <linux-kernel+bounces-833875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB608BA344D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB0CB624F02
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F1225EFBF;
	Fri, 26 Sep 2025 10:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jKNarGAY"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC83E2BD031
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 10:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758880804; cv=none; b=MPusI4zZIwdJnLraQ0DBIZoqc9jkRqDgwo6Me1JNz35tzqYy6DpG72WDc/PNOae6TRzBaJhuSB2FfplQk1rVyDVKG0dj0PHL0kuSuYGEQVowafyA6/sU4zDw45n0lS7OC+WKbTxiUGdbTNlrcjDJK6DJsuAT3X5fFd+7x3Dcx8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758880804; c=relaxed/simple;
	bh=uWbM69PKcAA71KiLD9EkbzIltv1ivqDtmCQS5aznZ+o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HdGRnycIO6b9FD1iOf72sjP1TkDmLRiCoD6xO/BnNVmnSbJ/ABw5Tfz87GelrNsxdMtJuwIxY1qwdvc2Mmf/HfXJvSIuXiZlxdMSXMA8wIAp1Pa5j/dcgfvjWJDQdfMuXvSUScg6r9rxHdGcjPuOr1x13n05w3ifyEo8xTdye5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jKNarGAY; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B1CB740E016D;
	Fri, 26 Sep 2025 10:00:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dSWDeF-ekk8w; Fri, 26 Sep 2025 09:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1758880797; bh=n1VlRLe0YUyVX3vNDxLc+ZhKSnj+6+FQq7BIebNHjTc=;
	h=Date:From:To:Cc:Subject:From;
	b=jKNarGAY5o164jyiSfRB1YTyVKLCv/xlP62DT/mLVef2V0VJHLAVBueXqKVa7VglA
	 z1bEaenafgkEqNL+/738uwFkCQ2NSijOqTcqb8yYhhl3K61jSlYouyptVdU9mOo9a1
	 pQ0jzllYmKRCrh9n//abu9Vwpo1uUACHXa6pTcQ2WPE7CDLGejxs+5ZvWywkV3bTYb
	 9X70UjSBVzhfZDnYu91rxz01GXzWvr67bVg6cYHvub4T48j65/pU/G5HSGeu03faGF
	 2N5WU+6JJ9Jym5spczA3ngmvCHNFQ3EYKoypXTRpX/3uDeGbLo8mFx/x+ExadZBEeq
	 j18EcgGYKlsB3L9ATp1K9Q++24xvKJCjvHTMc6OwptLG18W+8NXdq9uK98m3Tjs6YK
	 zEosAVgb3GpKVrGfJaT3y/8CZKpBSfrPF/eXtAEH0XMFumcf8A8UtIkD5YG3DI/EpC
	 njAy3FgWzeZlAw1DPJRaYtynsJDmioW/FtohRXbB3pVuTH3XUez3LPw7sikbsFDJEM
	 YZsS6QVH8qcygxvlxwkH9PROFbd7S8kSWh8bXG4GRk1LHZENZsKhwVVdU8oUHl08LP
	 W1tjHzFrJuvqWGFYPwmldGT6sCcMnvtMsK8gBELFdXpPPhJHvIL13NgyPSUI/Wv6ZW
	 O1zbhgNObUW1ZDr9p4GaN+1o=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 2FFB440E0176;
	Fri, 26 Sep 2025 09:59:54 +0000 (UTC)
Date: Fri, 26 Sep 2025 11:59:52 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/build for v6.18-rc1
Message-ID: <20250926095952.GAaNZkGKIuQKymGBtv@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the x86/build lineup for v6.18-rc1.

Thx.

---

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_build_for_v6.18_rc1

for you to fetch changes up to 2c6a28f3ef729ed2d5b174b4e0f33172fb286bab:

  x86/Kconfig: Clean up LLVM version checks in IBT configurations (2025-08-17 13:10:39 +0200)

----------------------------------------------------------------
- Remove and simplify a bunch of cc-option and compiler version checks
  in the build machinery now that the minimal version of both compilers
  supports them

----------------------------------------------------------------
Nathan Chancellor (6):
      x86/build: Remove cc-option for GCC retpoline flags
      x86/build: Remove cc-option from stack alignment flags
      x86/build: Clean up stack alignment flags in CC_FLAGS_FPU
      x86/build: Remove cc-option from -mno-fp-ret-in-387
      x86/build: Remove cc-option from -mskip-rax-setup
      x86/Kconfig: Clean up LLVM version checks in IBT configurations

 arch/x86/Kconfig  |  8 +-------
 arch/x86/Makefile | 25 +++++++------------------
 2 files changed, 8 insertions(+), 25 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

