Return-Path: <linux-kernel+bounces-779644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1BBB2F69B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C152188CD97
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BB130EF62;
	Thu, 21 Aug 2025 11:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uaHLmxt2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DE33054E0
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755775665; cv=none; b=cr2Y2xQBcFpaAkw1U++oTNCMh747CiprQyo/MoDV0DnKhMIYsVkpi0VkPeLfh/3rdab2gs8wJfh6as2wXciWERIQucWkORBXzn6OTJAdNfmRIUM2t397IEMLmFfDVNfm+gtGdzAznvtL66NDBBk5w82XMkjILrPj/rqSU2F9gUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755775665; c=relaxed/simple;
	bh=TeLiY9rWYgwluzznmA5sBvokJ7kYB4xX6yAp004tkOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WIA6O9+buFE7quN6a9vkaXyNVxxl8oMgTzrbgeRb6SvhjPiLGBm6g1/HKjHtest3G8K0QUP5RI3Wyulst59Xz3OrLnqqqBVmjgG8RlGlHirvi2RDoXBlLseyNZlFiFdaw7ts3Le6BrPc/d65YNC28pWCG+4PlxZdnDfi2Ww6Q/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uaHLmxt2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3263AC4AF0D;
	Thu, 21 Aug 2025 11:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755775665;
	bh=TeLiY9rWYgwluzznmA5sBvokJ7kYB4xX6yAp004tkOU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uaHLmxt2ngLqc4XdyTaJFkv9X9g0lcA5Z9u5bJc2CKTFebgLtws/IxWUVYTB4/he7
	 KwHF8rvP2jP7Cszdmgi0gpDM0++ZDDp2wv3LAZ8X1Bf2O3/8yDbPNg7xpCYsA49fC2
	 yJ+TFi4wXMdPFswab+cKObwNqr/QBh/LBi73aYWIoxAQ29Giyw1b1I/aN2rdCYyjK4
	 mEcrKGwlrqCgGTqQnZkS9GVJ1yF7awn2q6FB2HEFtDboM/pQgj959x8aZRXyPSvOc2
	 V//jTV3J5SdSAiwWV/w4IK5NZ86BduJ2huSiJ3wsVCmjkykQ8pmWKRyeztfGpCP5/Z
	 nlaOOZwUWPtpQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A42CA0EF8;
	Thu, 21 Aug 2025 11:27:45 +0000 (UTC)
From: Simon Schuster via B4 Relay <devnull+schuster.simon.siemens-energy.com@kernel.org>
Date: Thu, 21 Aug 2025 13:27:38 +0200
Subject: [PATCH 2/2] nios2: implement architecture-specific portion of
 sys_clone3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-nios2-implement-clone3-v1-2-1bb24017376a@siemens-energy.com>
References: <20250821-nios2-implement-clone3-v1-0-1bb24017376a@siemens-energy.com>
In-Reply-To: <20250821-nios2-implement-clone3-v1-0-1bb24017376a@siemens-energy.com>
To: Dinh Nguyen <dinguyen@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Kees Cook <kees@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Simon Schuster <schuster.simon@siemens-energy.com>
X-Mailer: b4 0.14.3-dev-2ce6c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755775663; l=2259;
 i=schuster.simon@siemens-energy.com; s=20250818;
 h=from:subject:message-id;
 bh=ZGFd7PEXdNZQ3XvGm96hBqrgf0z3Sn12r48TmNzThTY=;
 b=F2nKl2igsmfyyDF/eUV0oYb5mlZJyimIpk0NXRJVrpnKfItiOUjRR+lvhtzDMtKjVJKvuPs+u
 3hz69QALEOGCg5dAKDF1klwR3WkvjnC1lV0TyZQ2blO79aj8xnAMWyK
X-Developer-Key: i=schuster.simon@siemens-energy.com; a=ed25519;
 pk=PUhOMiSp43aSeRE1H41KApxYOluamBFFiMfKlBjocvo=
X-Endpoint-Received: by B4 Relay for
 schuster.simon@siemens-energy.com/20250818 with auth_id=495
X-Original-From: Simon Schuster <schuster.simon@siemens-energy.com>
Reply-To: schuster.simon@siemens-energy.com

From: Simon Schuster <schuster.simon@siemens-energy.com>

This commit adds the sys_clone3 entrypoint for nios2. An
architecture-specific wrapper (__sys_clone3) is required to save and
restore additional registers to the kernel stack via SAVE_SWITCH_STACK
and RESTORE_SWITCH_STACK.

Signed-off-by: Simon Schuster <schuster.simon@siemens-energy.com>
---
 arch/nios2/include/asm/syscalls.h | 1 +
 arch/nios2/include/asm/unistd.h   | 2 --
 arch/nios2/kernel/entry.S         | 6 ++++++
 arch/nios2/kernel/syscall_table.c | 1 +
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/nios2/include/asm/syscalls.h b/arch/nios2/include/asm/syscalls.h
index b4d4ed3bf9c8..0e214b0a0ac8 100644
--- a/arch/nios2/include/asm/syscalls.h
+++ b/arch/nios2/include/asm/syscalls.h
@@ -7,6 +7,7 @@
 
 int sys_cacheflush(unsigned long addr, unsigned long len,
 				unsigned int op);
+asmlinkage long __sys_clone3(struct clone_args __user *uargs, size_t size);
 
 #include <asm-generic/syscalls.h>
 
diff --git a/arch/nios2/include/asm/unistd.h b/arch/nios2/include/asm/unistd.h
index 1146e56473c5..213f6de3cf7b 100644
--- a/arch/nios2/include/asm/unistd.h
+++ b/arch/nios2/include/asm/unistd.h
@@ -7,6 +7,4 @@
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SET_GET_RLIMIT
 
-#define __ARCH_BROKEN_SYS_CLONE3
-
 #endif
diff --git a/arch/nios2/kernel/entry.S b/arch/nios2/kernel/entry.S
index 99f0a65e6234..dd40dfd908e5 100644
--- a/arch/nios2/kernel/entry.S
+++ b/arch/nios2/kernel/entry.S
@@ -403,6 +403,12 @@ ENTRY(sys_clone)
 	addi    sp, sp, 4
 	RESTORE_SWITCH_STACK
 	ret
+/* long syscall(SYS_clone3, struct clone_args *cl_args, size_t size); */
+ENTRY(__sys_clone3)
+	SAVE_SWITCH_STACK
+	call	sys_clone3
+	RESTORE_SWITCH_STACK
+	ret
 
 ENTRY(sys_rt_sigreturn)
 	SAVE_SWITCH_STACK
diff --git a/arch/nios2/kernel/syscall_table.c b/arch/nios2/kernel/syscall_table.c
index 434694067d8f..c99818aac9e1 100644
--- a/arch/nios2/kernel/syscall_table.c
+++ b/arch/nios2/kernel/syscall_table.c
@@ -13,6 +13,7 @@
 #define __SYSCALL_WITH_COMPAT(nr, native, compat)        __SYSCALL(nr, native)
 
 #define sys_mmap2 sys_mmap_pgoff
+#define sys_clone3 __sys_clone3
 
 void *sys_call_table[__NR_syscalls] = {
 	[0 ... __NR_syscalls-1] = sys_ni_syscall,

-- 
2.39.5



