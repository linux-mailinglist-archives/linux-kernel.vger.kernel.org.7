Return-Path: <linux-kernel+bounces-888386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57679C3AB0E
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C746461D74
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8558530F954;
	Thu,  6 Nov 2025 11:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lc7SU816"
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98FC30EF6B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429236; cv=none; b=gofHCMuy2o2ACIn46TPq//olVyGZIftzU8/SpQaFDEh5DKW/Ri57YxwHbM+52Fj3ggeaxKeb1atSqzV4PU5nZ047ioBAJU+dCQUf23BBUsj7ALz9a1Xjlc8zo0LFsOehOcUjtUOUA5xIT2Nkle7nCm+tDEcY9BZtO7DHvaeE95g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429236; c=relaxed/simple;
	bh=TzurPXqNIRG9Vp4q5fCO9veienfpprMj+IL3IWQmZSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KEJK9cgwcb4XSedNe+88LLObCOiuWTkuaaUEWvEv9u2LQoQ0fw2Wsd74WMAiXvJFwadthdIzhd4yxKN639A6dMCh0NeTzl400ZTbfBW13xnVBypFzSeQVi96pPP227dSOCrJal3xPj4wN3ucUPUqNEO95YS7D+RnweoNock2t34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lc7SU816; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-594259bc5f1so628653e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 03:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762429233; x=1763034033; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v34V6UOuAW4algEbYefyR7s7Tf+M59sk/X8aCBcGIPc=;
        b=Lc7SU816zRdZ+zxqjLEPPfbSF+UrTfxLKOWwP1MJhSCa52AWbkhb+4buoy2xUTrQ+n
         L6oxTciq2q9F270fwbtPU1SsVmcjPba/lnloss0byHzuP99lf/PqXwM9G6ZaU5qYgf9J
         lGPE+Svydo8aIQzZkmzhqf8spGw2VSjDbdXZE+pb41fGMk9hnG4ZhFs9RRUk94mwJKj7
         nLUu9buLjXBD7FYbq5wlC/6/Jz5ha2pC50PZhcaJPz0FaJS7to0BMfolg2cn5xbgkfgv
         pQmACEy1jMXwRZnZILoWAiNxYtdj5mqJ6wuw6TYD2NB3j7t4sHdKZTKPKiw6WxJAgor6
         reHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762429233; x=1763034033;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v34V6UOuAW4algEbYefyR7s7Tf+M59sk/X8aCBcGIPc=;
        b=jtp8FOrUvepYjcLWw629ZuzWR6TASMMTWzn5ObDRdy26eilaPCiLzPNGrEsakbXTD5
         s9vQIJHlSHZyBoHz4Aiymf4DlKr6Z9KYCZwFbJNYtxn32Q3JBBct8a5KmasLykb8qCRE
         xofbrFCUpt52g2J4WhYBmrhzcB9CWIA07qVA7zJmCFydJFFOUQ89IuBsrKQqw9DbtTpN
         meZDsFPJ9Asm18/VxCWH97zOPcjuZiwME+FR+CuYxoF9XbrhLSXtD1hSjSdj5fk2+PDw
         fCRKaez8pSnh+hGpfKwlsnLXBito+H4u02VNC+geEC30j0lREhA/ACdBda+8BP0gyOEh
         iEpA==
X-Forwarded-Encrypted: i=1; AJvYcCV3Ill7TWXkVqwtAkkb2YhyIKUAN8nLQQSIwqesvwAuLBrhuXVGE/j36ys2m7nLX0cytmhw+g1EW07UrvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3mGcWSNyM5eW22zPuHcwYE+MupAcNhOQ2Uvzj0cEJF+9mJRLP
	ayY1L3S1EeCg1EnV9jD7dkD1E6SFlMEUck29N7urlMNZfsvL3dxaA/ukXPG/Oxse
X-Gm-Gg: ASbGncvEBiikQ3SoA3ut1WquR86EHpvZk5GTXJTYF40kjEWMtoi2o7W0uYzM8WEQu9h
	upwKWnV+hyQfA3v7r2yf6tsL9qkAVmrpk+FDsDqiVwqWMeAbzEWfizIkXILBQfgKh6QOYwBF7ox
	X2vZMF/QQHqKcNKlslGU9+dHK1YV+7nbDLUO1CcmmTs/5+Uv4uqBbmG2XQ6N88vJytRtsV7loWw
	8CJ6do0uOYEDbQSxf1rt8C4G+uBZyox8LB8dhwDky4rAuQLwBwG40iX+3GisLbtDe5i0dUf4Cke
	JNjhyCv57g4wnVFVxGgdkd8Mif2CPf0Vz7tOsgv+qOBTK6nJG13bxL8f6mygXDBAvSDUUKLELl+
	WajOSSc6YNXh2cOp9fQGOHxLuXpf19kRa9hfFVCc/yoxFQSN9fWy91TUYPlMcZIhH32SHH3Ofa2
	TEAc3c2riRjAzkonkERJshzL6DfjCzTDHlqVKydJ3Ikmow7URFvu6E6Jgc1CtEN15fwxfRWjhWU
	/SbvZfBHYXxJgqk2ahYo7GOHekmhK4=
X-Google-Smtp-Source: AGHT+IGIIzFUbwr8Yw2DpY4lrZQbFJ3COc7ijCkphFraNz8s3Ec0LQ/U2ePs+7AxsxoZH31PQrgUNQ==
X-Received: by 2002:a05:600c:46ce:b0:477:1af2:f40a with SMTP id 5b1f17b1804b1-4775cdc9053mr58862025e9.17.1762422432751;
        Thu, 06 Nov 2025 01:47:12 -0800 (PST)
Received: from ?IPV6:2003:d8:2f30:b00:cea9:dee:d607:41d? (p200300d82f300b00cea90deed607041d.dip0.t-ipconnect.de. [2003:d8:2f30:b00:cea9:dee:d607:41d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce32653sm97818805e9.13.2025.11.06.01.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 01:47:12 -0800 (PST)
Message-ID: <2b9fa85b-54ff-415c-9163-461e28b6d660@gmail.com>
Date: Thu, 6 Nov 2025 10:47:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -v4 2/2] arm64, tlbflush: don't TLBI broadcast if page
 reused in write fault
To: Huang Ying <ying.huang@linux.alibaba.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Barry Song <baohua@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Yang Shi <yang@os.amperecomputing.com>,
 "Christoph Lameter (Ampere)" <cl@gentwo.org>, Dev Jain <dev.jain@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>,
 Yin Fengwei <fengwei_yin@linux.alibaba.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20251104095516.7912-1-ying.huang@linux.alibaba.com>
 <20251104095516.7912-3-ying.huang@linux.alibaba.com>
From: "David Hildenbrand (Red Hat)" <davidhildenbrandkernel@gmail.com>
Content-Language: en-US
In-Reply-To: <20251104095516.7912-3-ying.huang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.11.25 10:55, Huang Ying wrote:
> A multi-thread customer workload with large memory footprint uses
> fork()/exec() to run some external programs every tens seconds.  When
> running the workload on an arm64 server machine, it's observed that
> quite some CPU cycles are spent in the TLB flushing functions.  While
> running the workload on the x86_64 server machine, it's not.  This
> causes the performance on arm64 to be much worse than that on x86_64.
> 
> During the workload running, after fork()/exec() write-protects all
> pages in the parent process, memory writing in the parent process
> will cause a write protection fault.  Then the page fault handler
> will make the PTE/PDE writable if the page can be reused, which is
> almost always true in the workload.  On arm64, to avoid the write
> protection fault on other CPUs, the page fault handler flushes the TLB
> globally with TLBI broadcast after changing the PTE/PDE.  However, this
> isn't always necessary.  Firstly, it's safe to leave some stale
> read-only TLB entries as long as they will be flushed finally.
> Secondly, it's quite possible that the original read-only PTE/PDEs
> aren't cached in remote TLB at all if the memory footprint is large.
> In fact, on x86_64, the page fault handler doesn't flush the remote
> TLB in this situation, which benefits the performance a lot.
> 
> To improve the performance on arm64, make the write protection fault
> handler flush the TLB locally instead of globally via TLBI broadcast
> after making the PTE/PDE writable.  If there are stale read-only TLB
> entries in the remote CPUs, the page fault handler on these CPUs will
> regard the page fault as spurious and flush the stale TLB entries.
> 
> To test the patchset, make the usemem.c from
> vm-scalability (https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git).
> support calling fork()/exec() periodically.  To mimic the behavior of
> the customer workload, run usemem with 4 threads, access 100GB memory,
> and call fork()/exec() every 40 seconds.  Test results show that with
> the patchset the score of usemem improves ~40.6%.  The cycles% of TLB
> flush functions reduces from ~50.5% to ~0.3% in perf profile.
> 

All makes sense to me.

Some smaller comments below.

[...]

> +
> +static inline void local_flush_tlb_page_nonotify(
> +	struct vm_area_struct *vma, unsigned long uaddr)

NIT: "struct vm_area_struct *vma" fits onto the previous line.

> +{
> +	__local_flush_tlb_page_nonotify_nosync(vma->vm_mm, uaddr);
> +	dsb(nsh);
> +}
> +
> +static inline void local_flush_tlb_page(struct vm_area_struct *vma,
> +					unsigned long uaddr)
> +{
> +	__local_flush_tlb_page_nonotify_nosync(vma->vm_mm, uaddr);
> +	mmu_notifier_arch_invalidate_secondary_tlbs(vma->vm_mm, uaddr & PAGE_MASK,
> +						(uaddr & PAGE_MASK) + PAGE_SIZE);
> +	dsb(nsh);
> +}
> +
>   static inline void __flush_tlb_page_nosync(struct mm_struct *mm,
>   					   unsigned long uaddr)
>   {
> @@ -472,6 +512,22 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
>   	dsb(ish);
>   }
>   
> +static inline void local_flush_tlb_contpte(struct vm_area_struct *vma,
> +					   unsigned long addr)
> +{
> +	unsigned long asid;
> +
> +	addr = round_down(addr, CONT_PTE_SIZE);
> +
> +	dsb(nshst);
> +	asid = ASID(vma->vm_mm);
> +	__flush_tlb_range_op(vale1, addr, CONT_PTES, PAGE_SIZE, asid,
> +			     3, true, lpa2_is_enabled());
> +	mmu_notifier_arch_invalidate_secondary_tlbs(vma->vm_mm, addr,
> +						    addr + CONT_PTE_SIZE);
> +	dsb(nsh);
> +}
> +
>   static inline void flush_tlb_range(struct vm_area_struct *vma,
>   				   unsigned long start, unsigned long end)
>   {
> diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
> index c0557945939c..589bcf878938 100644
> --- a/arch/arm64/mm/contpte.c
> +++ b/arch/arm64/mm/contpte.c
> @@ -622,8 +622,7 @@ int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
>   			__ptep_set_access_flags(vma, addr, ptep, entry, 0);
>   
>   		if (dirty)
> -			__flush_tlb_range(vma, start_addr, addr,
> -							PAGE_SIZE, true, 3);
> +			local_flush_tlb_contpte(vma, start_addr);

In this case, we now flush a bigger range than we used to, no?

Probably I am missing something (should this change be explained in more 
detail in the cover letter), but I'm wondering why this contpte handling 
wasn't required before on this level.

>   	} else {
>   		__contpte_try_unfold(vma->vm_mm, addr, ptep, orig_pte);
>   		__ptep_set_access_flags(vma, addr, ptep, entry, dirty);
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index d816ff44faff..22f54f5afe3f 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -235,7 +235,7 @@ int __ptep_set_access_flags(struct vm_area_struct *vma,
>   
>   	/* Invalidate a stale read-only entry */

I would expand this comment to also explain how remote TLBs are handled 
very briefly -> flush_tlb_fix_spurious_fault().

>   	if (dirty)
> -		flush_tlb_page(vma, address);
> +		local_flush_tlb_page(vma, address);
>   	return 1;
>   }
>   


