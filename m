Return-Path: <linux-kernel+bounces-650383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FC4AB90BD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 22:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEDA9502BA8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 20:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E06629B796;
	Thu, 15 May 2025 20:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N9omGqi/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eaNcOIgz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4324729B786
	for <linux-kernel@vger.kernel.org>; Thu, 15 May 2025 20:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747340515; cv=none; b=T7RmhUH+IvXscxWSNuyUyZfrPUnndp3so3Z6rrYxhftp3iUoMY0wFK2LHwbfWUKOYGlxSaEORwAeWbuHWGhg/RoPeh+4lcGusacpIuTC581OTaJrwFSGsjqnAnNgRxy8gVadi5Ua6BnEY8nU8KuH8BpYHIj0lYUlQSUrpOaVae0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747340515; c=relaxed/simple;
	bh=mJfCC/iRmdk2M7MvZLIWog78RJ8ElfIQyxW4zW2+VQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a8SlIA8MV47sSBDyZKc4hZMj6ZJ/MpeBaT9aUJN46lvj1u6VKiLz3CrU0KTowd45v57qCq0S5IYe+Dy+um4ZevlzwLsFAOSzQ/PZrrNGCjsiqFO0Ks0Eb3VtwjOvwa4AqTWB32UgDB2n3n8C4AXdmYfthD/0w+6PUjOLmtxEosM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N9omGqi/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eaNcOIgz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747340511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HoF1rv0y4osaBn1doVAbQf/kbyat3/wfg/xnJwdsyfA=;
	b=N9omGqi/zjnrKBhcHLykxO4+HAUpCZcOQ0V3XHHYV6EvYUI0u7q+Gqk55w54UB9QKA1Q6b
	Q2Kve/nRypdYVr6vu5p+FL3nAkRcNnUB5dEnDz6VtAmhGtDLOU1TnOwmadk4NQ/rNVeeDU
	7I5kAjNS6QH1au2CVx27fbMYEtjVda/gy4mCKziou+HMp6yZXwRcX8WaX7PKJ9GU7fTFdg
	gmDjXXj+2Av4lznceuvs01WGczq9FBtjTgLq1BpaJn8R69Bjx10vSNxl/MJEZqlmXZbxAc
	KVXRD1Fjw3a5S17WBtSbEOd6bIZWw+CfShoitikLtWbjly2kkEwRXdsck3kXoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747340511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HoF1rv0y4osaBn1doVAbQf/kbyat3/wfg/xnJwdsyfA=;
	b=eaNcOIgzD2aIyZRLU9+dakO2rnoBRDD9OQ3W3JENFmSW1Yhz0YSPLz2j+8e1XCAONdoDn8
	WQY08vW5GVlixJAw==
To: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v2 2/2] x86/cpuid: Rename hypervisor_cpuid_base() to cpuid_hypervisor_base()
Date: Thu, 15 May 2025 22:21:42 +0200
Message-ID: <20250515202143.34448-3-darwi@linutronix.de>
In-Reply-To: <20250515202143.34448-1-darwi@linutronix.de>
References: <20250515202143.34448-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to let all the APIs under <cpuid/api.h> have a shared "cpuid_"
namespace, rename hypervisor_cpuid_base() to cpuid_base_hypervisor().

To align with the new style, also rename:

    for_each_possible_hypervisor_cpuid_base(function)

to:

    for_each_possible_cpuid_base_hypervisor(function)

Adjust call-sites accordingly.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/include/asm/acrn.h           | 2 +-
 arch/x86/include/asm/cpuid/api.h      | 6 +++---
 arch/x86/include/asm/xen/hypervisor.h | 2 +-
 arch/x86/kernel/jailhouse.c           | 2 +-
 arch/x86/kernel/kvm.c                 | 2 +-
 arch/x86/kvm/cpuid.c                  | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/acrn.h b/arch/x86/include/asm/acrn.h
index 1dd14381bcb6..fab11192c60a 100644
--- a/arch/x86/include/asm/acrn.h
+++ b/arch/x86/include/asm/acrn.h
@@ -25,7 +25,7 @@ void acrn_remove_intr_handler(void);
 static inline u32 acrn_cpuid_base(void)
 {
 	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
-		return hypervisor_cpuid_base("ACRNACRNACRN", 0);
+		return cpuid_base_hypervisor("ACRNACRNACRN", 0);
 
 	return 0;
 }
diff --git a/arch/x86/include/asm/cpuid/api.h b/arch/x86/include/asm/cpuid/api.h
index ccf20c62b89f..44fa82e1267c 100644
--- a/arch/x86/include/asm/cpuid/api.h
+++ b/arch/x86/include/asm/cpuid/api.h
@@ -188,14 +188,14 @@ static __always_inline bool cpuid_function_is_indexed(u32 function)
 	return false;
 }
 
-#define for_each_possible_hypervisor_cpuid_base(function) \
+#define for_each_possible_cpuid_base_hypervisor(function) \
 	for (function = 0x40000000; function < 0x40010000; function += 0x100)
 
-static inline u32 hypervisor_cpuid_base(const char *sig, u32 leaves)
+static inline u32 cpuid_base_hypervisor(const char *sig, u32 leaves)
 {
 	u32 base, eax, signature[3];
 
-	for_each_possible_hypervisor_cpuid_base(base) {
+	for_each_possible_cpuid_base_hypervisor(base) {
 		cpuid(base, &eax, &signature[0], &signature[1], &signature[2]);
 
 		/*
diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
index bd0fc69a10a7..c2fc7869b996 100644
--- a/arch/x86/include/asm/xen/hypervisor.h
+++ b/arch/x86/include/asm/xen/hypervisor.h
@@ -43,7 +43,7 @@ extern struct start_info *xen_start_info;
 
 static inline uint32_t xen_cpuid_base(void)
 {
-	return hypervisor_cpuid_base(XEN_SIGNATURE, 2);
+	return cpuid_base_hypervisor(XEN_SIGNATURE, 2);
 }
 
 struct pci_dev;
diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
index cd8ed1edbf9e..9e9a591a5fec 100644
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -49,7 +49,7 @@ static uint32_t jailhouse_cpuid_base(void)
 	    !boot_cpu_has(X86_FEATURE_HYPERVISOR))
 		return 0;
 
-	return hypervisor_cpuid_base("Jailhouse\0\0\0", 0);
+	return cpuid_base_hypervisor("Jailhouse\0\0\0", 0);
 }
 
 static uint32_t __init jailhouse_detect(void)
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index f3642226e0a5..921c1c783bc1 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -875,7 +875,7 @@ static noinline uint32_t __kvm_cpuid_base(void)
 		return 0;	/* So we don't blow up on old processors */
 
 	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
-		return hypervisor_cpuid_base(KVM_SIGNATURE, 0);
+		return cpuid_base_hypervisor(KVM_SIGNATURE, 0);
 
 	return 0;
 }
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 7f43d8d24fbe..ecd85f4801cc 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -236,7 +236,7 @@ static struct kvm_hypervisor_cpuid kvm_get_hypervisor_cpuid(struct kvm_vcpu *vcp
 	struct kvm_cpuid_entry2 *entry;
 	u32 base;
 
-	for_each_possible_hypervisor_cpuid_base(base) {
+	for_each_possible_cpuid_base_hypervisor(base) {
 		entry = kvm_find_cpuid_entry(vcpu, base);
 
 		if (entry) {
-- 
2.49.0


