Return-Path: <linux-kernel+bounces-830547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 428B5B99F37
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CFF01B2574A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4733A302766;
	Wed, 24 Sep 2025 12:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsCayz9K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C9C2417C2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758718779; cv=none; b=GXD6C+etHTgsonE7U49rsDWs4G6510V0LyGAUldmimbDe1YKChqv0MBKrbl0qFDjq9OHcqvceXTWKTq35K1Kq2H8tR/5wZJsv/dcdBSpPI4lDPqlkcKx8jH7NoHwBysUReVtqY+EgfW0tByaTm0EwQdOgNEOQkMFO4+7R/lxOEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758718779; c=relaxed/simple;
	bh=Mm3E9wpAC2pz0RwWTK/4R4XcdE74NMqEvGmJGZ8H6GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L0N/2HGqGU+UMZBKz30hB3HjO5/zPmVntJNolGnFu0QIzTucNxSp977GxwBOPopqzBcqsfZ/vIa8gAy+qicmv0ye3D67K4YuFuhksMgTeDhAl2IC822EJzEGEbRE6Rk9mPMsbdoGBJ2ecrji+5Z0RdEAuRjvSNJLVIV20KLbWnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsCayz9K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F26DC4CEE7;
	Wed, 24 Sep 2025 12:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758718779;
	bh=Mm3E9wpAC2pz0RwWTK/4R4XcdE74NMqEvGmJGZ8H6GQ=;
	h=From:To:Cc:Subject:Date:From;
	b=RsCayz9KBnLIf26GVHI7qsR/ZI4vbgIOnxq9mv6ySQql2/4mZIvonidHDhesYFQR3
	 2E5aiXAeZiu2/uZo4hVifpOGXbz2YLksqpM4Itvb9rBz9/LshGe4LydIxzdh621cVR
	 wXoUFe3wwBbBOwe1WAXrvRfOx1//hYOXVuSzRtc38ebfyRKPepmu0u6q7l80B4e9ha
	 3ZxvXHpgQhYfRoRF+ljUx1wlny/PGEHGJzCdjzW3OFI2m0lc0pITHtc5GV71pi1FB/
	 gKb5QedV76iHZMMafBSQZSAv6JLU8D0wEmOZgCDKS2JnzlVCKc90ibmqOEIoo53jNn
	 J2CYofGyByU4Q==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH] x86/cpufeatures: Make X86_FEATURE leaf 17 Linux-specific
Date: Wed, 24 Sep 2025 14:59:35 +0200
Message-ID: <20250924125935.15070-1-bp@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

That cap element was supposed to mirror CPUID flags from
CPUID_0x80000007_EBX but that leaf has still to this day only three bits
defined in it. So move those bits to scattered.c and free the leaf for
synthetic flags.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/cpufeature.h        | 2 +-
 arch/x86/include/asm/cpufeatures.h       | 5 ++++-
 arch/x86/kernel/cpu/common.c             | 8 ++------
 arch/x86/kernel/cpu/scattered.c          | 3 +++
 arch/x86/kvm/reverse_cpuid.h             | 1 -
 tools/arch/x86/include/asm/cpufeatures.h | 5 ++++-
 6 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 893cbca37fe9..96acb669bed4 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -30,7 +30,7 @@ enum cpuid_leafs
 	CPUID_6_EAX,
 	CPUID_8000_000A_EDX,
 	CPUID_7_ECX,
-	CPUID_8000_0007_EBX,
+	CPUID_LNX_6,
 	CPUID_7_EDX,
 	CPUID_8000_001F_EAX,
 	CPUID_8000_0021_EAX,
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index b2a562217d3f..41191769f5a5 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -407,9 +407,12 @@
 #define X86_FEATURE_ENQCMD		(16*32+29) /* "enqcmd" ENQCMD and ENQCMDS instructions */
 #define X86_FEATURE_SGX_LC		(16*32+30) /* "sgx_lc" Software Guard Extensions Launch Control */
 
-/* AMD-defined CPU features, CPUID level 0x80000007 (EBX), word 17 */
+/*
+ * Linux-defined word for use with scattered/synthetic bits.
+ */
 #define X86_FEATURE_OVERFLOW_RECOV	(17*32+ 0) /* "overflow_recov" MCA overflow recovery support */
 #define X86_FEATURE_SUCCOR		(17*32+ 1) /* "succor" Uncorrectable error containment and recovery */
+
 #define X86_FEATURE_SMCA		(17*32+ 3) /* "smca" Scalable MCA */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18 */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c7d3512914ca..3ff9682d8bc4 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1021,12 +1021,8 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 		c->x86_capability[CPUID_8000_0001_EDX] = edx;
 	}
 
-	if (c->extended_cpuid_level >= 0x80000007) {
-		cpuid(0x80000007, &eax, &ebx, &ecx, &edx);
-
-		c->x86_capability[CPUID_8000_0007_EBX] = ebx;
-		c->x86_power = edx;
-	}
+	if (c->extended_cpuid_level >= 0x80000007)
+		c->x86_power = cpuid_edx(0x80000007);
 
 	if (c->extended_cpuid_level >= 0x80000008) {
 		cpuid(0x80000008, &eax, &ebx, &ecx, &edx);
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 4cee6213d667..b4ae4d86646e 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -43,6 +43,9 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_SGX1,			CPUID_EAX,  0, 0x00000012, 0 },
 	{ X86_FEATURE_SGX2,			CPUID_EAX,  1, 0x00000012, 0 },
 	{ X86_FEATURE_SGX_EDECCSSA,		CPUID_EAX, 11, 0x00000012, 0 },
+	{ X86_FEATURE_OVERFLOW_RECOV,		CPUID_EBX,  0, 0x80000007, 0 },
+	{ X86_FEATURE_SUCCOR,			CPUID_EBX,  1, 0x80000007, 0 },
+	{ X86_FEATURE_SMCA,			CPUID_EBX,  3, 0x80000007, 0 },
 	{ X86_FEATURE_HW_PSTATE,		CPUID_EDX,  7, 0x80000007, 0 },
 	{ X86_FEATURE_CPB,			CPUID_EDX,  9, 0x80000007, 0 },
 	{ X86_FEATURE_PROC_FEEDBACK,		CPUID_EDX, 11, 0x80000007, 0 },
diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index c53b92379e6e..61d1f89f095e 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -75,7 +75,6 @@ static const struct cpuid_reg reverse_cpuid[] = {
 	[CPUID_6_EAX]         = {         6, 0, CPUID_EAX},
 	[CPUID_8000_000A_EDX] = {0x8000000a, 0, CPUID_EDX},
 	[CPUID_7_ECX]         = {         7, 0, CPUID_ECX},
-	[CPUID_8000_0007_EBX] = {0x80000007, 0, CPUID_EBX},
 	[CPUID_7_EDX]         = {         7, 0, CPUID_EDX},
 	[CPUID_7_1_EAX]       = {         7, 1, CPUID_EAX},
 	[CPUID_12_EAX]        = {0x00000012, 0, CPUID_EAX},
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 06fc0479a23f..bd655e100395 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -407,9 +407,12 @@
 #define X86_FEATURE_ENQCMD		(16*32+29) /* "enqcmd" ENQCMD and ENQCMDS instructions */
 #define X86_FEATURE_SGX_LC		(16*32+30) /* "sgx_lc" Software Guard Extensions Launch Control */
 
-/* AMD-defined CPU features, CPUID level 0x80000007 (EBX), word 17 */
+/*
+ * Linux-defined word for use with scattered/synthetic bits.
+ */
 #define X86_FEATURE_OVERFLOW_RECOV	(17*32+ 0) /* "overflow_recov" MCA overflow recovery support */
 #define X86_FEATURE_SUCCOR		(17*32+ 1) /* "succor" Uncorrectable error containment and recovery */
+
 #define X86_FEATURE_SMCA		(17*32+ 3) /* "smca" Scalable MCA */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18 */
-- 
2.51.0


