Return-Path: <linux-kernel+bounces-859375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B068BED6F4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 19:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D306F3A464A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E3D25FA05;
	Sat, 18 Oct 2025 17:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpDZTuSP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA6923BCFD;
	Sat, 18 Oct 2025 17:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760809970; cv=none; b=d+z8P1lqvQZg04zb6TnNjgxWxm10q9dBE83GboxqVr0cjUlmRrpJWZg2WZ/wkwP93pBi+zZ46prlO4Qcn48XvrDAdBxbSyhP5l9yMwhUNUUlVBR7kFPX44h89HcRPZfvSvOpEcVhwjG451PDyyktnYD+Xp4Q1Fmp8XJIrbHNk4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760809970; c=relaxed/simple;
	bh=1cU9a8sYkJdXpA+th5ZVtswTz4K/NZYD/UAAtbUYJ+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=boTa2T90y0mgy7sNU8ojg7zcpQYhy4BWsP5qtyqgqXkEUM+xMYaRZZcrbGfT9fiUuGxMrTTEUrnVCHmh7wuvVCHixWzNu+biGE0ILRyzrqXYceJT5X2iBN/XTGhmQZEZK29mwuZ4gdHO5j5E5k2chK+OxRURIyol2j/5jjC/or4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SpDZTuSP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB00FC4CEF8;
	Sat, 18 Oct 2025 17:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760809968;
	bh=1cU9a8sYkJdXpA+th5ZVtswTz4K/NZYD/UAAtbUYJ+U=;
	h=From:Date:Subject:To:Cc:From;
	b=SpDZTuSP+5pSrV+mlBUpCRSnHMT8ygs4j7P+OAVfcrOdYhrJTaUsQJrUeQ63lEOvL
	 rTMPW0oivx51UJE1h05t3viz87Ugc8Bx+CgxnHSroY55WqTIZRLHPoNiwCNHxn2irt
	 HM2URobfxl6UbEMpvAU820qO3EGfen+lxjZxcMY5kO0MTJUNRlPXea3oiKrpC+6m2B
	 YvAg3iTsqZFhPsolw5FLaqlJuwCaSEfoFM3XK2EuoLkYPOfMxoezAfkHLmoAZoY4eK
	 cT8mTGhsCO+xUbav3WRKnD1JFNJZiRHr0/hEdVt6chPdWs+XSBQhogiuceaxdl+waG
	 jL+tFXSNrjLOw==
From: Nathan Chancellor <nathan@kernel.org>
Date: Sat, 18 Oct 2025 18:52:40 +0100
Subject: [PATCH] powerpc/vmlinux.lds: Drop .interp description
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251018-ppc-fix-lld-interp-v1-1-a083de6dccc9@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOfT82gC/x2MWwqAIBAArxL73YJrT7pK9CG61UKYaEQQ3j3pc
 2BmXkgchRNM1QuRb0ly+gJUV2B34zdGcYVBK92RohFDsLjKg8fhUPzFMSCZYbRNT9a1GkoYIhf
 jn85Lzh/fNNbHZAAAAA==
X-Change-ID: 20251018-ppc-fix-lld-interp-1a78c361cd42
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Vishal Chourasia <vishalc@linux.ibm.com>, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1957; i=nathan@kernel.org;
 h=from:subject:message-id; bh=1cU9a8sYkJdXpA+th5ZVtswTz4K/NZYD/UAAtbUYJ+U=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDBmfL7+9rfyrYIeMV1LFeq7Hez26xN0KX/1/aJe6wy/Vv
 iVNq+ZzRykLgxgXg6yYIkv1Y9XjhoZzzjLeODUJZg4rE8gQBi5OAZjI76uMDO/d6zX5PimpfVPM
 vtyn8Wqxi/aZkgXp3nVcfzd09ksttGD4Z2h5svVzodO6T3eXcT5pjDxVbDxZRerHXuY3SyXcJD3
 LmQA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Commit da30705c4621 ("arch/powerpc: Remove .interp section in vmlinux")
intended to drop the .interp section from vmlinux but even with this
change, relocatable kernels linked with ld.lld contain an empty .interp
section, which ends up causing crashes in GDB [1].

  $ make -skj"$(nproc)" ARCH=powerpc LLVM=1 clean pseries_le_defconfig vmlinux

  $ llvm-readelf -S vmlinux | grep interp
    [44] .interp           PROGBITS        c0000000021ddb34 21edb34 000000 00   A  0   0  1

There appears to be a subtle difference between GNU ld and ld.lld when
it comes to discarding sections that specify load addresses [2].

Since '--no-dynamic-linker' prevents emission of the .interp section,
there is no need to describe it in the output sections of the vmlinux
linker script. Drop the .interp section description from vmlinux.lds.S
to avoid this issue altogether.

Link: https://sourceware.org/bugzilla/show_bug.cgi?id=33481 [1]
Link: https://github.com/ClangBuiltLinux/linux/issues/2137 [2]
Reported-by: Vishal Chourasia <vishalc@linux.ibm.com>
Closes: https://lore.kernel.org/20251013040148.560439-1-vishalc@linux.ibm.com/
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/powerpc/kernel/vmlinux.lds.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index de6ee7d35cff..15850296c0a9 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -330,7 +330,6 @@ SECTIONS
 	}
 	.hash : AT(ADDR(.hash) - LOAD_OFFSET) { *(.hash) }
 	.gnu.hash : AT(ADDR(.gnu.hash) - LOAD_OFFSET) { *(.gnu.hash) }
-	.interp : AT(ADDR(.interp) - LOAD_OFFSET) { *(.interp) }
 	.rela.dyn : AT(ADDR(.rela.dyn) - LOAD_OFFSET)
 	{
 		__rela_dyn_start = .;

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251018-ppc-fix-lld-interp-1a78c361cd42

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


