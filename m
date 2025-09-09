Return-Path: <linux-kernel+bounces-807632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C928DB4A75D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A7E23A9957
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA52A287272;
	Tue,  9 Sep 2025 09:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WnN4WZnC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA657285CBB
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409245; cv=none; b=pgUzBVGvrmDHhuLznwqbVSJBhBiQB4JOs+KxSU08QInepoi93fcOEAoONV1ricAPisCq0TZKu/tUwcwFnjbFaKhGHl2GJaTaG2uG0+xl0yezCkzhHglQWQv5a/MpYirnz3aM6nyR68K2sbRp9CCgJI0dmeywuic5STobMZ0yUuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409245; c=relaxed/simple;
	bh=/HqT7PFhxdZC/OOgqkRWOESzEPTHWx/dRV/ph4/t2TY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JlFFI5Ic27KBmin8Wpqymbr+tGdHikxIQ03xdZKizM9H2XJArUU7tXIvqCknGvLqvT7YowHWvQ6el3+2yKeBvGY6NBOTHPj36JySBTCkbMW96TvIzVx6kyc9TEisbrJb9cOOSlaaCnNUgqnvrcYuDXJfpAyfVK06QHfojZovY1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WnN4WZnC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757409242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/IUdjMztn2lEK5HOnU9D0CF10p+pvtJH5MIMXBxLW58=;
	b=WnN4WZnCN9L6XZ8KpTuaFuShuJAk177LcXneJLpvhFNovuWB2PLkKxpw4J9MmVwJHNZ4te
	Iyd8Ec3F8yamTmcz+TH8iAq4YnE64EVANC2VjG+12GT1u11RLnn5cxikBP0DAvEHVZazxw
	6CalgVhWxEa59b7aYz2VHDBh9hFbIEc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-QXSkYwU0MOWUXgdRjukT5A-1; Tue, 09 Sep 2025 05:14:01 -0400
X-MC-Unique: QXSkYwU0MOWUXgdRjukT5A-1
X-Mimecast-MFC-AGG-ID: QXSkYwU0MOWUXgdRjukT5A_1757409240
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3df3e935ec8so2494232f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 02:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409239; x=1758014039;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/IUdjMztn2lEK5HOnU9D0CF10p+pvtJH5MIMXBxLW58=;
        b=wc12zlZz6m3ibtgGhZZDal1gAEVxaJsF0+2DA0QhJwdeH21PJwvaD1FtsdERfcenLt
         F7NJkKbJ2b5P4hNez26RwxlGcvlFqo+3l8EObnRt6OGL7exRhpjxVd/hFegtWM16/KBN
         1WIHb43EThA8nIWSwN6AgpyzVv5QA+NcARocvpoCMXmRyMQX5xmQtyR/JJlE1dI+8Qqn
         e/8MpuNjTJ3del7GU0sKTLBl6s2Q9uwaABPbeuRRGpq8HF7Sn/8zgmoPFG8spx2ffoyp
         DdNLvcGHktBT5uxNR64+/gTWD2dJLrWodVCJ+s8pCYYt7GjXf85M2BpG7xwQBjHKJu8t
         JSqA==
X-Gm-Message-State: AOJu0YyTuG9bLIgYkH5G+RV8Nko7GH92xDWYxmVHPbBbkxjWxZhpmRGV
	r0vtb9qGrspwizEykQXfQ/PVfi304BYXHp71wjIxIux2GtMm90l95O10kvTOnUG3jCfOZVNWhN8
	166MQUcpOFEL5drb2RvBGfcR/GcNVK85wqHfzPf4jbnIC1HRqjqCuuXjEfLw4RPQRe/4lC+9eRA
	==
X-Gm-Gg: ASbGncv9kCQA09cJ6zjzXHxW2fB+FadQvOHDDVgNRl+j89G9Zm+MPKdDZSPNhZFzXQp
	sty2lOf4HndDNJsoDsFjpqHk7YyGZXFJrWcCfN43sZkJv5GhBMs3wDf9Z3Ub4avxiFm1CjXKTzD
	eBS2GvLW9GjgEx1adJ6yKyvq9VQLpmoROHJVLn2JOXAcyBJ7brg02BR8lr4/4qmQjLfLWddU06H
	zH0j1L1o+VJQ/XLWfdliBt4nxyCo8luqBIVwH9FBTvzbzayfZPY1wWEzG0707iGlfFJfOLNfGrj
	9ZUA31ftZxnWYllTt7nNOhzVVg4EG3mcnV0sNEpfdlX39s5DCc2kOFS48RPdxKgWFvEemS4MAzA
	0aTROgMn6hBNUq49O6b1lhVVwkdnL/s2v/vdSwL48deFk/NKx+F1u+F4GL2p3++6mt8k=
X-Received: by 2002:a05:6000:3101:b0:3e3:59cc:65ba with SMTP id ffacd0b85a97d-3e64374208dmr2787707f8f.50.1757409239531;
        Tue, 09 Sep 2025 02:13:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhnq/C72ezwSRJLO4zISvano2xfvFhth932RgVfDh+sCEuObRa/4tJAM3JVWrXDipaf397Wg==
X-Received: by 2002:a05:6000:3101:b0:3e3:59cc:65ba with SMTP id ffacd0b85a97d-3e64374208dmr2787666f8f.50.1757409238983;
        Tue, 09 Sep 2025 02:13:58 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f23:9c00:d1f6:f7fe:8f14:7e34? (p200300d82f239c00d1f6f7fe8f147e34.dip0.t-ipconnect.de. [2003:d8:2f23:9c00:d1f6:f7fe:8f14:7e34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75223f2e5sm1797097f8f.52.2025.09.09.02.13.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 02:13:58 -0700 (PDT)
Message-ID: <aa28c1a7-82fc-42af-9904-a4d4db078a19@redhat.com>
Date: Tue, 9 Sep 2025 11:13:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] x86/xen: support nested lazy_mmu sections (again)
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov
 <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
 Juergen Gross <jgross@suse.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org
References: <20250908073931.4159362-1-kevin.brodsky@arm.com>
 <20250908073931.4159362-5-kevin.brodsky@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250908073931.4159362-5-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.09.25 09:39, Kevin Brodsky wrote:
> Commit 49147beb0ccb ("x86/xen: allow nesting of same lazy mode")
> originally introduced support for nested lazy sections (LAZY_MMU and
> LAZY_CPU). It later got reverted by commit c36549ff8d84 as its
> implementation turned out to be intolerant to preemption.
> 
> Now that the lazy_mmu API allows enter() to pass through a state to
> the matching leave() call, we can support nesting again for the
> LAZY_MMU mode in a preemption-safe manner. If xen_enter_lazy_mmu() is
> called inside an active lazy_mmu section, xen_lazy_mode will already
> be set to XEN_LAZY_MMU and we can then return LAZY_MMU_NESTED to
> instruct the matching xen_leave_lazy_mmu() call to leave
> xen_lazy_mode unchanged.
> 
> The only effect of this patch is to ensure that xen_lazy_mode
> remains set to XEN_LAZY_MMU until the outermost lazy_mmu section
> ends. xen_leave_lazy_mmu() still calls xen_mc_flush()
> unconditionally.
> 
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
>   arch/x86/include/asm/paravirt.h       |  6 ++----
>   arch/x86/include/asm/paravirt_types.h |  4 ++--
>   arch/x86/xen/mmu_pv.c                 | 11 ++++++++---
>   3 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
> index 65a0d394fba1..4ecd3a6b1dea 100644
> --- a/arch/x86/include/asm/paravirt.h
> +++ b/arch/x86/include/asm/paravirt.h
> @@ -529,14 +529,12 @@ static inline void arch_end_context_switch(struct task_struct *next)
>   #define  __HAVE_ARCH_ENTER_LAZY_MMU_MODE
>   static inline lazy_mmu_state_t arch_enter_lazy_mmu_mode(void)
>   {
> -	PVOP_VCALL0(mmu.lazy_mode.enter);
> -
> -	return LAZY_MMU_DEFAULT;
> +	return PVOP_CALL0(lazy_mmu_state_t, mmu.lazy_mode.enter);
>   }
>   
>   static inline void arch_leave_lazy_mmu_mode(lazy_mmu_state_t state)
>   {
> -	PVOP_VCALL0(mmu.lazy_mode.leave);
> +	PVOP_VCALL1(mmu.lazy_mode.leave, state);
>   }
>   
>   static inline void arch_flush_lazy_mmu_mode(void)
> diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
> index bc1af86868a3..b7c567ccbf32 100644
> --- a/arch/x86/include/asm/paravirt_types.h
> +++ b/arch/x86/include/asm/paravirt_types.h
> @@ -45,8 +45,8 @@ typedef int lazy_mmu_state_t;
>   
>   struct pv_lazy_ops {
>   	/* Set deferred update mode, used for batching operations. */
> -	void (*enter)(void);
> -	void (*leave)(void);
> +	lazy_mmu_state_t (*enter)(void);
> +	void (*leave)(lazy_mmu_state_t);
>   	void (*flush)(void);
>   } __no_randomize_layout;
>   #endif
> diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
> index 2039d5132ca3..6e5390ff06a5 100644
> --- a/arch/x86/xen/mmu_pv.c
> +++ b/arch/x86/xen/mmu_pv.c
> @@ -2130,9 +2130,13 @@ static void xen_set_fixmap(unsigned idx, phys_addr_t phys, pgprot_t prot)
>   #endif
>   }
>   
> -static void xen_enter_lazy_mmu(void)
> +static lazy_mmu_state_t xen_enter_lazy_mmu(void)
>   {
> +	if (this_cpu_read(xen_lazy_mode) == XEN_LAZY_MMU)
> +		return LAZY_MMU_NESTED;
> +

You mention above "preemption-safe manner" above, so I am wondering,
what if we get preempted immediately after doing the this_cpu_read() and 
get scheduled on another CPU?

-- 
Cheers

David / dhildenb


