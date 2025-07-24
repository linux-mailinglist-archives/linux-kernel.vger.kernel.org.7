Return-Path: <linux-kernel+bounces-745093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E130BB114C2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 01:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B59CE1CE4317
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869DF24C676;
	Thu, 24 Jul 2025 23:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="GslRK5w3"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DD924BBF0
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 23:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753400250; cv=none; b=ZFcNV/mvW9kTLSx+6CNJSpEfnkRZT8H0BuYPF/pcaI5pihDpR/8Jrk+9q9VawRdjXeDLfOJQkAGVLOlj+O9tA9Qb6pK+VzTuUosF0vcRVnZ1iPszb5wp23W8c19mSf4zmyMPTIUdyh1PMExsjFZ/T0w172Dck8SOt/n+wSqFQJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753400250; c=relaxed/simple;
	bh=r7Hy9gi7nORQZAig+hEOF4zSbnrKY8DTDlN8xa1//dY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hf0dOWxTcfSBe2xoGx7WFwC+sSbHaPXzggbkVY5N71GA18os/mjSsIbnQRV1DRcxec2XsMcJBmHcxgp/JNtdC1U9v30p0mx4/JR3wk3FDdHRjzhJ2m+L2GjdqbaFHcdhPEhaP+bMmh13t9OdYcCnYOUX+ff/HdJeb6UxIR+LRvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=GslRK5w3; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23f8d27eeeaso14503555ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1753400248; x=1754005048; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jnGfibRKNEJZsKsgrkgY/LkGeimQVZTGPU49pFGQkew=;
        b=GslRK5w3A5VPITfKTcs1Y0VMhzzTotPcnnaZNc+hTl/KSJeRVW51yuIh9/kVMZL7sA
         svc/LWdXagnMmbPTDkN97UvPntZI7r+EmlnE9jAfhpheGotpTqmzKuOc8Ieu24DayM0o
         2ELSjMs0b0wBmEuMgBjzNiGzkzrJdJ7PyyU/mVQKBLEzJzmsJkkK9+ATEX+Ez9tt32C+
         IQD+GFpFnmWRru8C60q7TjwPxlZpfiXUx2VjvHKtaxoJTroF2q3JNoH6Jk4vX8vv+3kr
         micXTQ42DI15nDxZFfF/2/11MsKTP3qnl0wqClnx+TjNoiX+qwkd1gc/vhBAjJfEbhdF
         9tTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753400248; x=1754005048;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jnGfibRKNEJZsKsgrkgY/LkGeimQVZTGPU49pFGQkew=;
        b=UdAOSglT66LTAI60sglBHwDN35wTKXSvFlXiiNdL+U2gA9PBFSVRCCDexfyBTBTkI+
         dY+vACZ+iGrEfMvsNDF/UQVFVySHl6ktYorkKKbsveNYxgJdu49Clt0Gf/OaLCmKArYA
         devpe9U30RqzGlo/gNKbd4hqkEVngRKNePsC6HgLVEjER3HI1AGwCorWyrS18UCAtzVi
         wVX34g5JaZzI5xlI5Z+vAOifSpOgAVamdWWJUndxADfYIzUUdeDL/joo9rutOLeaVn19
         HRvJQTUf51Hc3Xu1VGfoDZasv+mjxciTrGWjCBlsOn+J6SC/w2eVjDUNuCNNLakKx89X
         7G2g==
X-Forwarded-Encrypted: i=1; AJvYcCUD50NHi29f2M57tlYgGgWHPuNCd9IOkV1c4wPUWmSl4EqGp4oLOsD4mU/qy6tfwwNx/PTiUwBliiMFz8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YysD0xumKw42zd1HZmYm54Zv6o1VdyAvSrFpQ2qTIPb6X1RDvY/
	ctNa+mKYnYrVaKO6MsQh+qcNfweikO2jTxrPQcNuan9+14OvFU5aikx6lbgeCbHtuek=
X-Gm-Gg: ASbGncu+6yKGkVVcEyMkCkr+YleuqeCQA9GPp+SpzzKHk+tsOhgSSnNDEneSQw8MbX5
	fQacJjf5EOkkedPfCxKVoNHRGKLSx9EG4j2MJ/b0KrZvYKzVSlZwYJXS/tgOjQegTb7Eyr7ulgD
	z9xHPXZuZBr0BhxlM3of2DvzC08Ki3+sL+fvRE9xKa7eh33TCvb1z3queu6qihSBJsD9BbQTi8v
	SYmCa9lv0cSI2gGYO+B0Bu5JOOs5seLdUXC621G3r19CtyXNmPg05VftlSLEXi/qM5Z+oA8zDMt
	EPow9Yth47t/eVUy/QMGZfewB2nyDAXDQUaYIFp4kfTtqplUwA1R85Fz+ea2trUmFwvHbSL/biq
	OAUlSZjMOfr0HpAWqGUtn1GFwlnQa9JhR
X-Google-Smtp-Source: AGHT+IGkF9wRjCt3t8wgcEzoS0u0I/CZsVHEJO+NVtX/XmjUgLckj9jfIg2rldjVpQc+NplTKJU2kw==
X-Received: by 2002:a17:902:f707:b0:235:c781:c305 with SMTP id d9443c01a7336-23f981932f0mr136844375ad.24.1753400248250;
        Thu, 24 Jul 2025 16:37:28 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48bc706sm23598685ad.106.2025.07.24.16.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 16:37:27 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 24 Jul 2025 16:37:03 -0700
Subject: [PATCH 10/11] scs: generic scs code updated to leverage hw
 assisted shadow stack
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-riscv_kcfi-v1-10-04b8fa44c98c@rivosinc.com>
References: <20250724-riscv_kcfi-v1-0-04b8fa44c98c@rivosinc.com>
In-Reply-To: <20250724-riscv_kcfi-v1-0-04b8fa44c98c@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Monk Chiang <monk.chiang@sifive.com>, 
 Kito Cheng <kito.cheng@sifive.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-mm@kvack.org, llvm@lists.linux.dev, 
 rick.p.edgecombe@intel.com, broonie@kernel.org, cleger@rivosinc.com, 
 samitolvanen@google.com, apatel@ventanamicro.com, ajones@ventanamicro.com, 
 conor.dooley@microchip.com, charlie@rivosinc.com, samuel.holland@sifive.com, 
 bjorn@rivosinc.com, fweimer@redhat.com, jeffreyalaw@gmail.com, 
 heinrich.schuchardt@canonical.com, andrew@sifive.com, ved@rivosinc.com, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

If shadow stack have memory protections from underlying cpu, use those
protections. arches can define PAGE_KERNEL_SHADOWSTACK to vmalloc such shadow
stack pages. Hw assisted shadow stack pages grow downwards like regular
stack. Clang based software shadow call stack grows low to high address.
Thus this patch addresses some of those needs due to opposite direction
of shadow stack. Furthermore, hw shadow stack can't be memset because memset
uses normal stores. Lastly to store magic word at base of shadow stack, arch
specific shadow stack store has to be performed.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 include/linux/scs.h | 26 +++++++++++++++++++++++++-
 kernel/scs.c        | 38 +++++++++++++++++++++++++++++++++++---
 2 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/include/linux/scs.h b/include/linux/scs.h
index 4ab5bdc898cf..6ceee07c2d1a 100644
--- a/include/linux/scs.h
+++ b/include/linux/scs.h
@@ -12,6 +12,7 @@
 #include <linux/poison.h>
 #include <linux/sched.h>
 #include <linux/sizes.h>
+#include <asm/scs.h>
 
 #ifdef CONFIG_SHADOW_CALL_STACK
 
@@ -37,22 +38,45 @@ static inline void scs_task_reset(struct task_struct *tsk)
 	 * Reset the shadow stack to the base address in case the task
 	 * is reused.
 	 */
+#ifdef CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK
+	task_scs_sp(tsk) = task_scs(tsk) + SCS_SIZE;
+#else
 	task_scs_sp(tsk) = task_scs(tsk);
+#endif
 }
 
 static inline unsigned long *__scs_magic(void *s)
 {
+#ifdef CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK
+	return (unsigned long *)(s);
+#else
 	return (unsigned long *)(s + SCS_SIZE) - 1;
+#endif
 }
 
 static inline bool task_scs_end_corrupted(struct task_struct *tsk)
 {
 	unsigned long *magic = __scs_magic(task_scs(tsk));
-	unsigned long sz = task_scs_sp(tsk) - task_scs(tsk);
+	unsigned long sz;
+
+#ifdef CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK
+	sz = (task_scs(tsk) + SCS_SIZE) - task_scs_sp(tsk);
+#else
+	sz = task_scs_sp(tsk) - task_scs(tsk);
+#endif
 
 	return sz >= SCS_SIZE - 1 || READ_ONCE_NOCHECK(*magic) != SCS_END_MAGIC;
 }
 
+static inline void __scs_store_magic(unsigned long *s, unsigned long magic_val)
+{
+#ifdef CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK
+	arch_scs_store(s, magic_val);
+#else
+	*__scs_magic(s) = magic_val;
+#endif
+}
+
 DECLARE_STATIC_KEY_FALSE(dynamic_scs_enabled);
 
 static inline bool scs_is_dynamic(void)
diff --git a/kernel/scs.c b/kernel/scs.c
index d7809affe740..5910c0a8eabd 100644
--- a/kernel/scs.c
+++ b/kernel/scs.c
@@ -11,6 +11,7 @@
 #include <linux/scs.h>
 #include <linux/vmalloc.h>
 #include <linux/vmstat.h>
+#include <asm-generic/set_memory.h>
 
 #ifdef CONFIG_DYNAMIC_SCS
 DEFINE_STATIC_KEY_FALSE(dynamic_scs_enabled);
@@ -32,19 +33,31 @@ static void *__scs_alloc(int node)
 {
 	int i;
 	void *s;
+	pgprot_t prot = PAGE_KERNEL;
+
+#ifdef CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK
+	prot = PAGE_KERNEL_SHADOWSTACK;
+#endif
 
 	for (i = 0; i < NR_CACHED_SCS; i++) {
 		s = this_cpu_xchg(scs_cache[i], NULL);
 		if (s) {
 			s = kasan_unpoison_vmalloc(s, SCS_SIZE,
 						   KASAN_VMALLOC_PROT_NORMAL);
+/*
+ * If software shadow stack, its safe to memset. Else memset is not
+ * possible on hw protected shadow stack. memset constitutes stores and
+ * stores to shadow stack memory are disallowed and will fault.
+ */
+#ifndef CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK
 			memset(s, 0, SCS_SIZE);
+#endif
 			goto out;
 		}
 	}
 
 	s = __vmalloc_node_range(SCS_SIZE, 1, VMALLOC_START, VMALLOC_END,
-				    GFP_SCS, PAGE_KERNEL, 0, node,
+				    GFP_SCS, prot, 0, node,
 				    __builtin_return_address(0));
 
 out:
@@ -59,7 +72,7 @@ void *scs_alloc(int node)
 	if (!s)
 		return NULL;
 
-	*__scs_magic(s) = SCS_END_MAGIC;
+	__scs_store_magic(__scs_magic(s), SCS_END_MAGIC);
 
 	/*
 	 * Poison the allocation to catch unintentional accesses to
@@ -87,6 +100,16 @@ void scs_free(void *s)
 			return;
 
 	kasan_unpoison_vmalloc(s, SCS_SIZE, KASAN_VMALLOC_PROT_NORMAL);
+	/*
+	 * Hardware protected shadow stack is not writeable by regular stores
+	 * Thus adding this back to free list will raise faults by vmalloc
+	 * It needs to be writeable again. It's good sanity as well because
+	 * then it can't be inadvertently accesses and if done, it will fault.
+	 */
+#ifdef CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK
+	set_memory_rw((unsigned long)s, (SCS_SIZE/PAGE_SIZE));
+#endif
+
 	vfree_atomic(s);
 }
 
@@ -96,6 +119,9 @@ static int scs_cleanup(unsigned int cpu)
 	void **cache = per_cpu_ptr(scs_cache, cpu);
 
 	for (i = 0; i < NR_CACHED_SCS; i++) {
+#ifdef CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK
+		set_memory_rw((unsigned long)cache[i], (SCS_SIZE/PAGE_SIZE));
+#endif
 		vfree(cache[i]);
 		cache[i] = NULL;
 	}
@@ -122,7 +148,13 @@ int scs_prepare(struct task_struct *tsk, int node)
 	if (!s)
 		return -ENOMEM;
 
-	task_scs(tsk) = task_scs_sp(tsk) = s;
+	task_scs(tsk) = s;
+#ifdef CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK
+	task_scs_sp(tsk) = s + SCS_SIZE;
+#else
+	task_scs_sp(tsk) = s;
+#endif
+
 	return 0;
 }
 

-- 
2.43.0


