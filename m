Return-Path: <linux-kernel+bounces-746041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6B6B12247
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A85D37B2671
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD00C2EF2BE;
	Fri, 25 Jul 2025 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ZcduIwGZ"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CD42E5B2F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753462035; cv=none; b=dSmhuFQNz3ZZPm8CXlnJPSl4pzTNGgpxdW9VR2HGXZOYMVQWhr3c7uXGphb02vdKrXLuwhOjJdSGubvZucg65eIhxJPB47j6B3wDqjINJneutJ6sy4bD6Lk9uvgOd7xtx27p7CFtQuFQDlfgOVGBCQDBhF4BxYzeqaDQj7Ai+3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753462035; c=relaxed/simple;
	bh=jkKCZG+haMLK5mAib4dIcJKwt6C+7EOrDNBhMzDTtZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAmF2bAOLEk3CQmkBgjp+Huj2ajTZtVwQGMU9j4ba34g+umATCcCYdmffXb52UT2M8hYttuqzJ1Yblt1Z2vDlf26dSAeWbHXP800DzA3x6MGpeC/kuaWcJFyTcATn2vXogKMw2BeRXEfRBfrwzkNG68f6dY1CTDDVhnZ0q+VBJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ZcduIwGZ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-748d982e92cso1609306b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1753462033; x=1754066833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vHLTqitS8m73sB1NoWWs/yPMz8aTSpmBU53QgGw/vVs=;
        b=ZcduIwGZ8tedXpK4odtG3K6fj5PBBERor+hyeXw8Y6UoFuioV8A+Wywx3j08da052z
         1jILruS24UQTC5DsGgv0lsxbpuV4OfTazNXsV0LVBKID3T/lWkzmRoSpCqP74i/FAOXm
         lGPcm+TPBvB4sBST+XmtfV9B7HTxG3kgbANC+BTIbRhx8SavNAytQdczUMSVm1YP7Zs5
         OfOmPHSNUuHXGXaGBZUkOmc2nhDkxc1xYSNShWszsCcDOz4RXWwYRhiZWZyCnFNJM/8i
         /8b/6FTEqyIbEfYm7xfl/arPi5AzRZrR2fT4bzy4IBgeHD3esNH+OFA8JfDMZzTgex4M
         SyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753462033; x=1754066833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHLTqitS8m73sB1NoWWs/yPMz8aTSpmBU53QgGw/vVs=;
        b=IkXDnRVGrDw6AoMXL7YBvUnL8L2xNci7R65QzvHNapnjbmzz4Qkop3AesQnxEHLu+n
         ynHuktOdvdxoURB00tkh45c93CqMgEgHTqTxDUa+tNzQ3gcMbWxsg/nOXNnODZI7WO8W
         26uTMBSSeNEIBDCbZtSlEPaRVEURUjY0+tVTV08xrQsGESa2UTUAnZdnEOLO5zrjQAsy
         QRgsiip6UdEACBkPnR1VM7uu5O8JCUtUPGxUTty8WywHOWTwe4WqLZfJCkFuLEABK9Gy
         ohhQTi+7ZcbpQitdrfA1WY5eH8VkP8y3BXR2vBj0O2B1Agv5FUKvVPYlRWIkGUhOFKZr
         +oog==
X-Forwarded-Encrypted: i=1; AJvYcCWC3K1/quo9vofLJX3zLFt3yTcpOHofjYAu5vznXo88texBgVO1kGF5XPvBEi+mdosh2M7baGNXhj+eEB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3qbRPHdLVzTKaNSVmWzw89PhTPTMYFNhXjRwOSAb0Z2HWpkQX
	HMaXKqeoNqarptCcR9JyITRxvVDXGuLaOkadMBttvfpJTYOGqa///0X3JviRURLHFAQ=
X-Gm-Gg: ASbGncvkHaZJq0AlPnvHOAsWdQLICczzGe61UNSsMJQQTokF78DYY+Zw5SMwXmpY2pr
	5PyvfneShczz+R/CT/AaENkcaawzQNKImfxjVgulZw9kD6WLm4dBi4267/YZJWVMsSaJA3BcSVU
	5SrJ83J6SB3GAl2aGN0nNOYZlqO0FwJjH4X0FHyQp7k1t3YKjWuVHeKB3KYqxhy3C6goSFboged
	0s7oVbPcWMAmBopHWf39PvIa1DNBgwt7jvWLNItZkeyCPs1EABWOVoDd4EGJk4+kTSmyjv+1UyD
	4Opsh8LG0yeLJfNzxwhAI01vjW13dXiCXEhTPBxUluVz0tk25bS0VnzGWt+6Cm56a5uhtBz5H+E
	iuL4MJ+GGuwWZRTm5489DhbEjQrQHD16k
X-Google-Smtp-Source: AGHT+IHxx3Jq+s72rQKTRVQE8Bq7kbAijuZ/ZVTSRX63AJDAbUraG/5Y8poHwWgKyEfuOloxC+qeAg==
X-Received: by 2002:a05:6a00:1790:b0:74c:3547:7f0c with SMTP id d2e1a72fcca58-7633626d5afmr4307957b3a.3.1753462032636;
        Fri, 25 Jul 2025 09:47:12 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640b4d15cfsm119033b3a.119.2025.07.25.09.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 09:47:12 -0700 (PDT)
Date: Fri, 25 Jul 2025 09:47:08 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Will Deacon <will@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Monk Chiang <monk.chiang@sifive.com>,
	Kito Cheng <kito.cheng@sifive.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-mm@kvack.org,
	llvm@lists.linux.dev, rick.p.edgecombe@intel.com,
	broonie@kernel.org, cleger@rivosinc.com, apatel@ventanamicro.com,
	ajones@ventanamicro.com, conor.dooley@microchip.com,
	charlie@rivosinc.com, samuel.holland@sifive.com, bjorn@rivosinc.com,
	fweimer@redhat.com, jeffreyalaw@gmail.com,
	heinrich.schuchardt@canonical.com, andrew@sifive.com,
	ved@rivosinc.com
Subject: Re: [PATCH 10/11] scs: generic scs code updated to leverage hw
 assisted shadow stack
Message-ID: <aIO1DOrhUTolFWO6@debug.ba.rivosinc.com>
References: <20250724-riscv_kcfi-v1-0-04b8fa44c98c@rivosinc.com>
 <20250724-riscv_kcfi-v1-10-04b8fa44c98c@rivosinc.com>
 <20250725161327.GC1724026@google.com>
 <aIOz_wxxCr8tPgXz@debug.ba.rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aIOz_wxxCr8tPgXz@debug.ba.rivosinc.com>

Sorry forgot to respond to rest of the comments.

On Fri, Jul 25, 2025 at 09:42:39AM -0700, Deepak Gupta wrote:
>On Fri, Jul 25, 2025 at 04:13:27PM +0000, Sami Tolvanen wrote:
>>On Thu, Jul 24, 2025 at 04:37:03PM -0700, Deepak Gupta wrote:
>>>If shadow stack have memory protections from underlying cpu, use those
>>>protections. arches can define PAGE_KERNEL_SHADOWSTACK to vmalloc such shadow
>>>stack pages. Hw assisted shadow stack pages grow downwards like regular
>>>stack. Clang based software shadow call stack grows low to high address.
>>
>>Is this the case for all the current hardware shadow stack
>>implementations? If not, we might want a separate config for the
>>shadow stack direction instead.
>
>Is there something like this for regular stack as well?
>I could copy same mechanism.
>
>>
>>>Thus this patch addresses some of those needs due to opposite direction
>>>of shadow stack. Furthermore, hw shadow stack can't be memset because memset
>>>uses normal stores. Lastly to store magic word at base of shadow stack, arch
>>>specific shadow stack store has to be performed.
>>>
>>>Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>>>---
>>> include/linux/scs.h | 26 +++++++++++++++++++++++++-
>>> kernel/scs.c        | 38 +++++++++++++++++++++++++++++++++++---
>>> 2 files changed, 60 insertions(+), 4 deletions(-)
>>>
>>>diff --git a/include/linux/scs.h b/include/linux/scs.h
>>>index 4ab5bdc898cf..6ceee07c2d1a 100644
>>>--- a/include/linux/scs.h
>>>+++ b/include/linux/scs.h
>>>@@ -12,6 +12,7 @@
>>> #include <linux/poison.h>
>>> #include <linux/sched.h>
>>> #include <linux/sizes.h>
>>>+#include <asm/scs.h>
>>>
>>> #ifdef CONFIG_SHADOW_CALL_STACK
>>>
>>>@@ -37,22 +38,45 @@ static inline void scs_task_reset(struct task_struct *tsk)
>>> 	 * Reset the shadow stack to the base address in case the task
>>> 	 * is reused.
>>> 	 */
>>>+#ifdef CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK
>>>+	task_scs_sp(tsk) = task_scs(tsk) + SCS_SIZE;
>>>+#else
>>> 	task_scs_sp(tsk) = task_scs(tsk);
>>>+#endif
>>> }
>>>
>>> static inline unsigned long *__scs_magic(void *s)
>>> {
>>>+#ifdef CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK
>>>+	return (unsigned long *)(s);
>>>+#else
>>> 	return (unsigned long *)(s + SCS_SIZE) - 1;
>>>+#endif
>>> }
>>>
>>> static inline bool task_scs_end_corrupted(struct task_struct *tsk)
>>> {
>>> 	unsigned long *magic = __scs_magic(task_scs(tsk));
>>>-	unsigned long sz = task_scs_sp(tsk) - task_scs(tsk);
>>>+	unsigned long sz;
>>>+
>>>+#ifdef CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK
>>>+	sz = (task_scs(tsk) + SCS_SIZE) - task_scs_sp(tsk);
>>>+#else
>>>+	sz = task_scs_sp(tsk) - task_scs(tsk);
>>>+#endif
>>>
>>> 	return sz >= SCS_SIZE - 1 || READ_ONCE_NOCHECK(*magic) != SCS_END_MAGIC;
>>> }
>>>
>>>+static inline void __scs_store_magic(unsigned long *s, unsigned long magic_val)
>>>+{
>>>+#ifdef CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK
>>>+	arch_scs_store(s, magic_val);
>>>+#else
>>>+	*__scs_magic(s) = magic_val;
>>>+#endif
>>>+}
>>>+
>>
>>I'm not a huge fan of all the ifdefs. We could clean this up by
>>allowing architectures to simply override some these functions, or at
>>least use if (IS_ENABLED(CONFIG...)) instead. Will, any thoughts about
>>this?

Yes I don't like it either.
I'll do something about it in next iteration.

>>
>>> DECLARE_STATIC_KEY_FALSE(dynamic_scs_enabled);
>>>
>>> static inline bool scs_is_dynamic(void)
>>>diff --git a/kernel/scs.c b/kernel/scs.c
>>>index d7809affe740..5910c0a8eabd 100644
>>>--- a/kernel/scs.c
>>>+++ b/kernel/scs.c
>>>@@ -11,6 +11,7 @@
>>> #include <linux/scs.h>
>>> #include <linux/vmalloc.h>
>>> #include <linux/vmstat.h>
>>>+#include <asm-generic/set_memory.h>
>>>
>>> #ifdef CONFIG_DYNAMIC_SCS
>>> DEFINE_STATIC_KEY_FALSE(dynamic_scs_enabled);
>>>@@ -32,19 +33,31 @@ static void *__scs_alloc(int node)
>>> {
>>> 	int i;
>>> 	void *s;
>>>+	pgprot_t prot = PAGE_KERNEL;
>>>+
>>>+#ifdef CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK
>>>+	prot = PAGE_KERNEL_SHADOWSTACK;
>>>+#endif
>>
>>I would rather define the shadow stack protection flags in the header
>>file and allow them to be overridden in asm/scs.h.

Yes that's good idea. I'll do that.

>>
>>> 	for (i = 0; i < NR_CACHED_SCS; i++) {
>>> 		s = this_cpu_xchg(scs_cache[i], NULL);
>>> 		if (s) {
>>> 			s = kasan_unpoison_vmalloc(s, SCS_SIZE,
>>> 						   KASAN_VMALLOC_PROT_NORMAL);
>>>+/*
>>>+ * If software shadow stack, its safe to memset. Else memset is not
>>>+ * possible on hw protected shadow stack. memset constitutes stores and
>>>+ * stores to shadow stack memory are disallowed and will fault.
>>>+ */
>>>+#ifndef CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK
>>> 			memset(s, 0, SCS_SIZE);
>>>+#endif
>>
>>This could also be moved to a static inline function that
>>architectures can override if they have hardware shadow stacks that
>>cannot be cleared at this point.

Make sense.

>>
>>> 			goto out;
>>> 		}
>>> 	}
>>>
>>> 	s = __vmalloc_node_range(SCS_SIZE, 1, VMALLOC_START, VMALLOC_END,
>>>-				    GFP_SCS, PAGE_KERNEL, 0, node,
>>>+				    GFP_SCS, prot, 0, node,
>>> 				    __builtin_return_address(0));
>>>
>>> out:
>>>@@ -59,7 +72,7 @@ void *scs_alloc(int node)
>>> 	if (!s)
>>> 		return NULL;
>>>
>>>-	*__scs_magic(s) = SCS_END_MAGIC;
>>>+	__scs_store_magic(__scs_magic(s), SCS_END_MAGIC);
>>>
>>> 	/*
>>> 	 * Poison the allocation to catch unintentional accesses to
>>>@@ -87,6 +100,16 @@ void scs_free(void *s)
>>> 			return;
>>>
>>> 	kasan_unpoison_vmalloc(s, SCS_SIZE, KASAN_VMALLOC_PROT_NORMAL);
>>>+	/*
>>>+	 * Hardware protected shadow stack is not writeable by regular stores
>>>+	 * Thus adding this back to free list will raise faults by vmalloc
>>>+	 * It needs to be writeable again. It's good sanity as well because
>>>+	 * then it can't be inadvertently accesses and if done, it will fault.
>>>+	 */
>>>+#ifdef CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK
>>>+	set_memory_rw((unsigned long)s, (SCS_SIZE/PAGE_SIZE));
>>>+#endif
>>
>>Another candidate for an arch-specific function to reduce the number
>>of ifdefs in the generic code.

Yes I'll do these changes in next iteration.
>>
>>Sami

