Return-Path: <linux-kernel+bounces-881147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 641D4C27903
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 08:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B64FD1899F91
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 07:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3DF299922;
	Sat,  1 Nov 2025 07:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+djXzyS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16198232369
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 07:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761981996; cv=none; b=Vof+49Mwdf9NjQcBODGrXharDGq+ZvYGovVxByyHkVBU3ROTW8Bo7T0l84SbHO2/FNgwq00H7PlPCRoK2L9vdtx0TjQeSfVIf/d24IF0GXJ8YgnfloBAB6ZXercNIS0T0V7d3+7UtHUPr902wEU/6k0qOGSbZEr8WUvBce+0+DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761981996; c=relaxed/simple;
	bh=Y6CupxvvSomkDOtUTC8nawCChBmoqTrTLdlqF79f+7E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=onXmPQlWH0Ydes+CFuAhcdRYpd/aA91Jw+6nCtXdGcl8VBDRJjNLnEzzcGh/R0Xurwo3k2B0uabXQN96z6O0zYxdqwCLFh3+gUe6TMK7bC1oxs6z97LRLa76ibBxN9lCQmaKcMOVVu2Vvpupin9HGKopeXuHItgrotp/whAbYNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+djXzyS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E51EC4CEF1;
	Sat,  1 Nov 2025 07:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761981995;
	bh=Y6CupxvvSomkDOtUTC8nawCChBmoqTrTLdlqF79f+7E=;
	h=Date:From:To:Cc:Subject:From;
	b=o+djXzyS5jLL9cpnfYWHtNKlvZa3azVaHkBqc3GpE8TrgwBS+FYtn5rJBSMH38STs
	 7Q560cfefRL8peqBueTrH60PHaAfA0jXc+DTy26p7mQn85lHiqsY4tvMxZAyVwj9+s
	 NMSqGV0FQYsywO4XondFPmQMrMUfd/84yI35qJtCpHGi7vu19P3xJ+0aSyPTBlnF7i
	 STiP3XnY2Iz9CQOnW8cx+wrm7AEtSARV6LL1t5gU87j2PhFsIrxS8gffxqDjItipUs
	 Q9XmQfwCps53sB7vwgL4FYTdg5Exr+stlpoAFHWG3b1KafEguVrHNEahx5w7rCuJOR
	 rvMxqz9vaI1iA==
Date: Sat, 1 Nov 2025 08:26:26 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [GIT PULL] x86 fixes
Message-ID: <aQW2Imsfgixz_jBc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2025-11-01

   # HEAD: 9b041a4b66b3b62c30251e700b5688324cf66625 x86/mm: Ensure clear_page() variants always have __kcfi_typeid_ symbols

Miscellaneous fixes:

 - Limit AMD microcode Entrysign sha256 signature checking to
   known CPU generations.

 - Disable AMD RDSEED32 on certain Zen5 CPUs that have a
   microcode version before when the microcode-based fix was
   issued for the AMD-SB-7055 erratum.

 - Fix FPU AMD XFD state synchronization on signal delivery

 - Fix (work around) a SSE4a-disassembly related build failure
   on X86_NATIVE_CPU=y builds.

 - Extend the AMD Zen6 model space with a new range of models

 - Fix <asm/intel-family.h> CPU model comments

 - Fix the CONFIG_CFI=y and CONFIG_LTO_CLANG_FULL=y build, which
   was unhappy due to missing kCFI type annotations of clear_page()
   variants.

 Thanks,

	Ingo

------------------>
Borislav Petkov (AMD) (2):
      x86/microcode/AMD: Limit Entrysign signature checking to known generations
      x86/CPU/AMD: Extend Zen6 model range

Chang S. Bae (1):
      x86/fpu: Ensure XFD state on signal delivery

Gregory Price (1):
      x86/CPU/AMD: Add RDSEED fix for Zen5

Nathan Chancellor (1):
      x86/mm: Ensure clear_page() variants always have __kcfi_typeid_ symbols

Peter Zijlstra (1):
      x86/build: Disable SSE4a

Tony Luck (1):
      x86/cpu: Add/fix core comments for {Panther,Nova} Lake


 arch/x86/Makefile                   |  2 +-
 arch/x86/include/asm/intel-family.h |  6 +++---
 arch/x86/include/asm/page_64.h      |  3 +++
 arch/x86/kernel/cpu/amd.c           | 12 +++++++++++-
 arch/x86/kernel/cpu/microcode/amd.c | 20 +++++++++++++++++++-
 arch/x86/kernel/fpu/core.c          |  3 +++
 6 files changed, 40 insertions(+), 6 deletions(-)

