Return-Path: <linux-kernel+bounces-802828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9634EB4577D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C858D7C5342
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A85534F48C;
	Fri,  5 Sep 2025 12:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qiRCjuFV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EVkLMxg1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4577C34AAFF
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074535; cv=none; b=JpT7oe3w/ioeMv2oUJtKm+CfQoByv4/qsNLUKwdiL/7niS6QyUcrXg60Q0At895TF7TLNfSsHFST+GWrTfctxMtIp+GrfIxImbkNBg5PfpYt8gmFDFJ/5RAmk2NoPjvC7f19CX/LJvK4li38aJgSjSQlZ1k84MGoNaptxWRDf14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074535; c=relaxed/simple;
	bh=E54gyw0AGLBY5Iv7Mdbwe+8baprlamI06AECAPTiiIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UOJwoz7mAI6A1zeaO1gZU3/y5wsWiiZaDkjb01BDX/8MYeHLpsMP8gngt+/Zv6Y+1v9Bcy5JQMMomjSEoNX5AUkAxPESp/oaKfs0IXlZgKZ8cw0x5InkvB0d3Ucacz3hUO38faAj2sabeL3qvyPRpT86pTHVGIVB6PdzpG6kcPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qiRCjuFV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EVkLMxg1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757074532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cfexTI82Y9dSPh8MK3LjQNX70lfzP/67Ss1JC9lednk=;
	b=qiRCjuFV4eqUDx6bmPFaepZPhPVp1ce/Z3+MK35n/wrx+S5owoPELDeFJBlvHlbA/rzzvE
	mfSYI3kQLP71bvx996nzAovD1A1r2c5dne5Eq7EMw50dbi++b3hfbRFtlOEedmv16oDQKO
	qSAFWwTLzHiG7pBH4a6vC33FY43HQswxQEWZTaJ1mAWzTI1sSa+LZmU8dFze30huO5wC7X
	Ik1lpUPsl07slPcVXyvnj5DQWgYALweRaX5ii8CPSmqqWTdnMVvROedmTrGo0P/9ZGc04u
	0zNzF+W6oc18mCsZ4JvqRvD5EX2kDU4DC1na3QoIUP1xTD4d5obR5P/BG2NdYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757074532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cfexTI82Y9dSPh8MK3LjQNX70lfzP/67Ss1JC9lednk=;
	b=EVkLMxg1/MZ6myFVxG1ORkUgwUEebUIOH5pEOQzXfsXckyFrruvjslzJJMm9anO7N3UpA8
	ExxUDKVnviw/m0Bw==
To: Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Sean Christopherson <seanjc@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v5 04/35] x86/cpuid: Rename cpuid_leaf()/cpuid_subleaf() APIs
Date: Fri,  5 Sep 2025 14:14:44 +0200
Message-ID: <20250905121515.192792-5-darwi@linutronix.de>
In-Reply-To: <20250905121515.192792-1-darwi@linutronix.de>
References: <20250905121515.192792-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A new CPUID model will be added where its APIs will be designated as the
"official" CPUID API.  Free the cpuid_leaf() and cpuid_subleaf() function
names for that model.  Rename them accordingly to cpuid_read() and
cpuid_read_subleaf().

Note, for kernel/cpuid.c, rename its local file operations read function
from cpuid_read() to cpuid_read_f() so that it does not conflict with the
new names.

No functional change.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/include/asm/cpuid/api.h   | 6 +++---
 arch/x86/kernel/cpu/topology_amd.c | 2 +-
 arch/x86/kernel/cpu/topology_ext.c | 2 +-
 arch/x86/kernel/cpuid.c            | 5 ++---
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/api.h b/arch/x86/include/asm/cpuid/api.h
index 44fa82e1267c..2b9750cc8a75 100644
--- a/arch/x86/include/asm/cpuid/api.h
+++ b/arch/x86/include/asm/cpuid/api.h
@@ -131,12 +131,12 @@ static inline void __cpuid_read(u32 leaf, u32 subleaf, u32 *regs)
 	__cpuid(regs + CPUID_EAX, regs + CPUID_EBX, regs + CPUID_ECX, regs + CPUID_EDX);
 }
 
-#define cpuid_subleaf(leaf, subleaf, regs) {		\
+#define cpuid_read_subleaf(leaf, subleaf, regs) {	\
 	static_assert(sizeof(*(regs)) == 16);		\
 	__cpuid_read(leaf, subleaf, (u32 *)(regs));	\
 }
 
-#define cpuid_leaf(leaf, regs) {			\
+#define cpuid_read(leaf, regs) {			\
 	static_assert(sizeof(*(regs)) == 16);		\
 	__cpuid_read(leaf, 0, (u32 *)(regs));		\
 }
@@ -228,7 +228,7 @@ static inline u32 cpuid_base_hypervisor(const char *sig, u32 leaves)
  */
 static inline void cpuid_leaf_0x2(union leaf_0x2_regs *regs)
 {
-	cpuid_leaf(0x2, regs);
+	cpuid_read(0x2, regs);
 
 	/*
 	 * All Intel CPUs must report an iteration count of 1.	In case
diff --git a/arch/x86/kernel/cpu/topology_amd.c b/arch/x86/kernel/cpu/topology_amd.c
index 42d91aa9b23a..0e48509301c8 100644
--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -80,7 +80,7 @@ static bool parse_8000_001e(struct topo_scan *tscan, bool has_topoext)
 	if (!boot_cpu_has(X86_FEATURE_TOPOEXT))
 		return false;
 
-	cpuid_leaf(0x8000001e, &leaf);
+	cpuid_read(0x8000001e, &leaf);
 
 	/*
 	 * If leaf 0xb/0x26 is available, then the APIC ID and the domain
diff --git a/arch/x86/kernel/cpu/topology_ext.c b/arch/x86/kernel/cpu/topology_ext.c
index eb915c73895f..60dfaa02ffd0 100644
--- a/arch/x86/kernel/cpu/topology_ext.c
+++ b/arch/x86/kernel/cpu/topology_ext.c
@@ -71,7 +71,7 @@ static inline bool topo_subleaf(struct topo_scan *tscan, u32 leaf, u32 subleaf,
 	default: return false;
 	}
 
-	cpuid_subleaf(leaf, subleaf, &sl);
+	cpuid_read_subleaf(leaf, subleaf, &sl);
 
 	if (!sl.num_processors || sl.type == INVALID_TYPE)
 		return false;
diff --git a/arch/x86/kernel/cpuid.c b/arch/x86/kernel/cpuid.c
index cbd04b677fd1..b55fe9c7359a 100644
--- a/arch/x86/kernel/cpuid.c
+++ b/arch/x86/kernel/cpuid.c
@@ -59,8 +59,7 @@ static void cpuid_smp_cpuid(void *cmd_block)
 	complete(&cmd->done);
 }
 
-static ssize_t cpuid_read(struct file *file, char __user *buf,
-			  size_t count, loff_t *ppos)
+static ssize_t cpuid_read_f(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 {
 	char __user *tmp = buf;
 	struct cpuid_regs_done cmd;
@@ -120,7 +119,7 @@ static int cpuid_open(struct inode *inode, struct file *file)
 static const struct file_operations cpuid_fops = {
 	.owner = THIS_MODULE,
 	.llseek = no_seek_end_llseek,
-	.read = cpuid_read,
+	.read = cpuid_read_f,
 	.open = cpuid_open,
 };
 
-- 
2.50.1


