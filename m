Return-Path: <linux-kernel+bounces-746035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1015AB12237
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 946BB7BE33A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB4D2EF2BC;
	Fri, 25 Jul 2025 16:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Dy3HU3y5"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFA92EF289
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 16:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753461766; cv=none; b=VTDw3FdTruXUCsyFAhnzXKA+oTrnaqP3ijKt7dmOhJzUClSASX25hJcSHhmLZuVv7F9G7mW8RgyTOMKeeLzPar6YJJMQ7SguqEQurw+NU0gD61YldN+BBgkxErqvOa1Aetw+o2sYBbK7tYFicijdKck6KyMsLQwptSPkE4RbGa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753461766; c=relaxed/simple;
	bh=NyQAVWuyGsER+ZPMGIz2n6bZ7ZmxlkxyOnWznpQlJck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a98copjDctl7fxrvXBljdOmw5xdiUaBze2n3VI06JG+/DeR7tRmo/PhvHg6sT/maffZzvrScbY0csAR29VLmzgkZbiebd9bSvAkMCKmhfFQJUPZLvXgBKmUEkiaIB819mDpisllV3H+1zn9nX0xT/F1qAbs40lT5IiZsW7siVf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Dy3HU3y5; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2349f096605so27885855ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1753461763; x=1754066563; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8y2TNoIk2wdBhLwSEjjylt9WbC1a8YKSz5ABVX4y0Uk=;
        b=Dy3HU3y5jLzEh5FRfBSe3li/H5uFR/hx117/R8OQrd2140T9BZNalytvIWNnzcoLKi
         VRMYhiihO9+NVLoIPgiez4XxM2iAEaKTMvLdXmGkB7zxrDB1SBgKtVDRnUUb1lc65/O9
         j5J1mTFktXXE/MrATg6yWJYpBT3GhcbXCbaenby0FAmWp3g/My38uTX8yYejKI2buVjs
         l1/j7w+2sSXkQKyNzd3GfiNUIYHDlLB2CWOWWlpP1jhrp5cJyl8NSQLznl9C42TmvMoS
         01QcgsLNqtYRimkEOTzezmBPihrpaO1zOu59IiO95ELB4Kp5Qnx7gFLAA8xGhw2B3kyz
         Q0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753461763; x=1754066563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8y2TNoIk2wdBhLwSEjjylt9WbC1a8YKSz5ABVX4y0Uk=;
        b=eJqmdkY0Z7n78/ha19GyCjjR9f9kHoVTeJLocn9VbetJ6hvY4cfWYSjTj5Oda0YFBg
         +J+XzNoMcKxGNk2bZdxmxL+JB3EUfrJfGfnU5Xyc7YcqPkuxpxG4aSxp8WIRS4yaUK7v
         NggtjuZRQvbN5WrD6Gs2HR3HMTLGFvhwO8VmwL7UtjQUpBy1EYMBDTvQ+4zIEpH3nLrG
         C0OwaL6XXubv72AzzX/5BvbgYjBgI2dhPY2JV1XRTHJ9exkcDNrfgCDThV2o0ZteGUO8
         AaKJAUVpHD+58pthA4zeCP6U5/oFCAh2gcxWLPrsO+flCLp2PURc+fXYth6cCJrluSPt
         /yZw==
X-Forwarded-Encrypted: i=1; AJvYcCXnE4RpCdCo1d3O40H2mONLzBwNRNJuuvOqHpoGJTQgdcMArJQ3H6fus8C6tssl7yU6N5Ci679ReEu+LqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJnirReW12wuQZxGpgqpsjaMVytipm+pw8yujaFpfH24FuxAiJ
	zakrW7OSZ2vMJlbc1NYXxd6f5NEDafEPJgUEjncKc+/WoBI/QZ6Zb5CsHyi727SAjDw=
X-Gm-Gg: ASbGncvjL3RofZ5JDHXOU7Gcp3CdkUB/fq5RwrNJzipDodXpKhTbNvEbnwc9BT7W9nV
	lA5eTLSUhkbfEfI5aB67Je+nFtzuwSUEaPo40QOXs8Y4o0DM/fTQ1BWSjFPrIJGeATJ1T2cM1RU
	cLJTtpy3+nJ4YAwMONjcOGE11/FQ/yLfOzI0p/K1UdRBj4Gtf11ssEhivOBz+M14KAOB7jGS5pM
	IBE/YhiJCmQvEg41cc9Qdqi8fZg58JnabV3HWFV8E2/QrWYq+3YXr5Y3XJJiTRsE9Tdvqix5szg
	MyRx8OpRXvTysmi3PwzW29UXysi+9lig0Ml1W4sZhzZnz4aKInloJQHXgX5SOeZNOmjN1seSIi6
	i6/wmSeOGSCuFLLRZHYGAMTOGAopjst4u
X-Google-Smtp-Source: AGHT+IESsSEPy/ac8F6mWdBj6vdPwp9s3VzEdxE6SjFz3Dg1QtfJX8WaXR44J4QcA36ULd9Dz05/pg==
X-Received: by 2002:a17:902:e891:b0:236:94ac:cc1a with SMTP id d9443c01a7336-23fb3179530mr40948875ad.27.1753461762804;
        Fri, 25 Jul 2025 09:42:42 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe30bbc4sm1244165ad.29.2025.07.25.09.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 09:42:42 -0700 (PDT)
Date: Fri, 25 Jul 2025 09:42:39 -0700
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
Message-ID: <aIOz_wxxCr8tPgXz@debug.ba.rivosinc.com>
References: <20250724-riscv_kcfi-v1-0-04b8fa44c98c@rivosinc.com>
 <20250724-riscv_kcfi-v1-10-04b8fa44c98c@rivosinc.com>
 <20250725161327.GC1724026@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250725161327.GC1724026@google.com>

On Fri, Jul 25, 2025 at 04:13:27PM +0000, Sami Tolvanen wrote:
>On Thu, Jul 24, 2025 at 04:37:03PM -0700, Deepak Gupta wrote:
>> If shadow stack have memory protections from underlying cpu, use those
>> protections. arches can define PAGE_KERNEL_SHADOWSTACK to vmalloc such shadow
>> stack pages. Hw assisted shadow stack pages grow downwards like regular
>> stack. Clang based software shadow call stack grows low to high address.
>
>Is this the case for all the current hardware shadow stack
>implementations? If not, we might want a separate config for the
>shadow stack direction instead.

Is there something like this for regular stack as well?
I could copy same mechanism.

>
>> Thus this patch addresses some of those needs due to opposite direction
>> of shadow stack. Furthermore, hw shadow stack can't be memset because memset
>> uses normal stores. Lastly to store magic word at base of shadow stack, arch
>> specific shadow stack store has to be performed.
>>
>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> ---
>>  include/linux/scs.h | 26 +++++++++++++++++++++++++-
>>  kernel/scs.c        | 38 +++++++++++++++++++++++++++++++++++---
>>  2 files changed, 60 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/scs.h b/include/linux/scs.h
>> index 4ab5bdc898cf..6ceee07c2d1a 100644
>> --- a/include/linux/scs.h
>> +++ b/include/linux/scs.h
>> @@ -12,6 +12,7 @@
>>  #include <linux/poison.h>
>>  #include <linux/sched.h>
>>  #include <linux/sizes.h>
>> +#include <asm/scs.h>
>>
>>  #ifdef CONFIG_SHADOW_CALL_STACK
>>
>> @@ -37,22 +38,45 @@ static inline void scs_task_reset(struct task_struct *tsk)
>>  	 * Reset the shadow stack to the base address in case the task
>>  	 * is reused.
>>  	 */
>> +#ifdef CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK
>> +	task_scs_sp(tsk) = task_scs(tsk) + SCS_SIZE;
>> +#else
>>  	task_scs_sp(tsk) = task_scs(tsk);
>> +#endif
>>  }
>>
>>  static inline unsigned long *__scs_magic(void *s)
>>  {
>> +#ifdef CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK
>> +	return (unsigned long *)(s);
>> +#else
>>  	return (unsigned long *)(s + SCS_SIZE) - 1;
>> +#endif
>>  }
>>
>>  static inline bool task_scs_end_corrupted(struct task_struct *tsk)
>>  {
>>  	unsigned long *magic = __scs_magic(task_scs(tsk));
>> -	unsigned long sz = task_scs_sp(tsk) - task_scs(tsk);
>> +	unsigned long sz;
>> +
>> +#ifdef CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK
>> +	sz = (task_scs(tsk) + SCS_SIZE) - task_scs_sp(tsk);
>> +#else
>> +	sz = task_scs_sp(tsk) - task_scs(tsk);
>> +#endif
>>
>>  	return sz >= SCS_SIZE - 1 || READ_ONCE_NOCHECK(*magic) != SCS_END_MAGIC;
>>  }
>>
>> +static inline void __scs_store_magic(unsigned long *s, unsigned long magic_val)
>> +{
>> +#ifdef CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK
>> +	arch_scs_store(s, magic_val);
>> +#else
>> +	*__scs_magic(s) = magic_val;
>> +#endif
>> +}
>> +
>
>I'm not a huge fan of all the ifdefs. We could clean this up by
>allowing architectures to simply override some these functions, or at
>least use if (IS_ENABLED(CONFIG...)) instead. Will, any thoughts about
>this?
>
>>  DECLARE_STATIC_KEY_FALSE(dynamic_scs_enabled);
>>
>>  static inline bool scs_is_dynamic(void)
>> diff --git a/kernel/scs.c b/kernel/scs.c
>> index d7809affe740..5910c0a8eabd 100644
>> --- a/kernel/scs.c
>> +++ b/kernel/scs.c
>> @@ -11,6 +11,7 @@
>>  #include <linux/scs.h>
>>  #include <linux/vmalloc.h>
>>  #include <linux/vmstat.h>
>> +#include <asm-generic/set_memory.h>
>>
>>  #ifdef CONFIG_DYNAMIC_SCS
>>  DEFINE_STATIC_KEY_FALSE(dynamic_scs_enabled);
>> @@ -32,19 +33,31 @@ static void *__scs_alloc(int node)
>>  {
>>  	int i;
>>  	void *s;
>> +	pgprot_t prot = PAGE_KERNEL;
>> +
>> +#ifdef CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK
>> +	prot = PAGE_KERNEL_SHADOWSTACK;
>> +#endif
>
>I would rather define the shadow stack protection flags in the header
>file and allow them to be overridden in asm/scs.h.
>
>>  	for (i = 0; i < NR_CACHED_SCS; i++) {
>>  		s = this_cpu_xchg(scs_cache[i], NULL);
>>  		if (s) {
>>  			s = kasan_unpoison_vmalloc(s, SCS_SIZE,
>>  						   KASAN_VMALLOC_PROT_NORMAL);
>> +/*
>> + * If software shadow stack, its safe to memset. Else memset is not
>> + * possible on hw protected shadow stack. memset constitutes stores and
>> + * stores to shadow stack memory are disallowed and will fault.
>> + */
>> +#ifndef CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK
>>  			memset(s, 0, SCS_SIZE);
>> +#endif
>
>This could also be moved to a static inline function that
>architectures can override if they have hardware shadow stacks that
>cannot be cleared at this point.
>
>>  			goto out;
>>  		}
>>  	}
>>
>>  	s = __vmalloc_node_range(SCS_SIZE, 1, VMALLOC_START, VMALLOC_END,
>> -				    GFP_SCS, PAGE_KERNEL, 0, node,
>> +				    GFP_SCS, prot, 0, node,
>>  				    __builtin_return_address(0));
>>
>>  out:
>> @@ -59,7 +72,7 @@ void *scs_alloc(int node)
>>  	if (!s)
>>  		return NULL;
>>
>> -	*__scs_magic(s) = SCS_END_MAGIC;
>> +	__scs_store_magic(__scs_magic(s), SCS_END_MAGIC);
>>
>>  	/*
>>  	 * Poison the allocation to catch unintentional accesses to
>> @@ -87,6 +100,16 @@ void scs_free(void *s)
>>  			return;
>>
>>  	kasan_unpoison_vmalloc(s, SCS_SIZE, KASAN_VMALLOC_PROT_NORMAL);
>> +	/*
>> +	 * Hardware protected shadow stack is not writeable by regular stores
>> +	 * Thus adding this back to free list will raise faults by vmalloc
>> +	 * It needs to be writeable again. It's good sanity as well because
>> +	 * then it can't be inadvertently accesses and if done, it will fault.
>> +	 */
>> +#ifdef CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK
>> +	set_memory_rw((unsigned long)s, (SCS_SIZE/PAGE_SIZE));
>> +#endif
>
>Another candidate for an arch-specific function to reduce the number
>of ifdefs in the generic code.
>
>Sami

