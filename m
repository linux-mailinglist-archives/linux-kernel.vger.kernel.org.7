Return-Path: <linux-kernel+bounces-816728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E23E0B577AD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C0B3A4E1D29
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD592FC013;
	Mon, 15 Sep 2025 11:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JNnk92dY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14064277C88
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757934497; cv=none; b=r5gO8lyJSi7dIbZqSKbTTSVbwx7S97hX/p0mRiNA8oFGPh/Ek5NvO+TEGSzBIi3nNIfNfI5pwqFH0LFdO5LxruuFKmvMAiBKg2zzntyp+o5yz+hddbxIll3g4WRckpLwAhOZmIKfHxo5GjptfZerDhMLGxp/0/XS/hATm0Llk9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757934497; c=relaxed/simple;
	bh=FMf5HG9EN4pGPXR8DNOHVXUxBF3y+SPpRhaGHilqhf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WydqoyYXgNaNNsQuGXRFN9GM6HGmZOm0UU4w5BYn9c+gUYFDHjr17Q5Xo/kY4l/4yXyxTgXKBlnkJcLkNv5N6c2EX60voWrODfyUKy+o50MLkvdogUiB5U3qw6b92qbxpjyyR9/GTG9MUUK4JRxLE4oYBMv3N5nNCrzoSy10LhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JNnk92dY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757934494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vO5Sx3qikY9rqKll7zfCyBLKJ3aOWWhA1Eq3H6Wln0s=;
	b=JNnk92dYFgJElfnBnBeOarj2oQ0UzcK0+/DxveeopGkgov5szKGd88afkl9y72I9QxoDH5
	3jIojxLhjFS7u3DxftlXEP9f3Jz9MBhhBcK1348gU+lNf7hX8mk1gI8NwnmtEDjihIGG/6
	p0ReQ8TQuuj7js+bBueP8KBNgF68pug=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-Y6xTh87MPhKfF0WQnT2JIw-1; Mon, 15 Sep 2025 07:08:13 -0400
X-MC-Unique: Y6xTh87MPhKfF0WQnT2JIw-1
X-Mimecast-MFC-AGG-ID: Y6xTh87MPhKfF0WQnT2JIw_1757934492
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3eb5130a9efso347539f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757934492; x=1758539292;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vO5Sx3qikY9rqKll7zfCyBLKJ3aOWWhA1Eq3H6Wln0s=;
        b=q/bI8QmJaf9OXg7f/qV5wGQGnXfZ4pBYIQEuF6ENjpN7C3D8/21RvaXlDLkQ+QNdWC
         4talSjCvBXtAFUq4qVuyvMVctzuCr9c6DkiLmrvEoS9WzxP6h5rxJAqxFF1uwXwE6lzp
         tVdcEDuzRiwww5203ImS3blSHFssoa1ME7HISPIgKAl1pO/VhP9Q4gLJLxDMdzSWEIDL
         hU1Cfi54Thm1sxoQmPCfjgU6qCGMImWpXIMdboNOyu0cT3i5Rd2SM/dUyYBWgcz58BT4
         aOe/9H+S93rHKuPiFOCgxUeEw3hwVnFm60KKcSCwecI7/OsFbqBOFatD5F+b9u51BAHK
         Mv2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDrlnLiiTdfrK96nxMafeg3dbACODnswzJhEtY6O9CftrVkvmDormt3LgCKfm3fl8RtrLkRaz3shJe+yI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL3EG2cbwit44q0eq+17QJR2mtKDzXqlNt0QRSd6cm+QI5qupV
	QegNz6hrD8Jakhg6uVO4RQItPZe0OdEYTyfWqz0k3+4LMpJLPhzAzvfcLFGQKv2/xETENxEHPql
	DUOJtGkFPYW+06e4gZNYN+wIzrktQxYS+kkmqAEcraTXKzieQk6mNzYlncq+w+z5K0g==
X-Gm-Gg: ASbGncsXcujEjqYEvWi0oxunTxy1NXU7ScUN5kSelJJRtfVMIMlLKTzesJtZRGPXsty
	y3wx3ej1e02+3P03QxNb7VYc7N2W3RvhicdvTjrnoyQWo5D18gYPpeGn6HU1JQjPUjAqHgL2PJ+
	B9et0GqTndTogx9DyooTc92EkujQfOjc1mYhLT86j5Ck2bVY6x4dnhX0jLC/shnh7Gyn1Ivfalf
	zmQeUOW+MpGRAaKTXd5itLmSPe8DOXnj/Lkezneh6G6Z/Cp9WNDW4ylkPX4b9wMpBX0X4Z7JHEO
	eHHnVYTPmo2PGrR2wcgBC/g/qDmm0KUlclp46tKciFdz3mv1OC+ah7AnTxgS7i9JDImLTayq9Yj
	97JxaGDQAPNr0zqB57pslfjpwPgfX53kriUWLQ9AqTO9+mGxET9ni4SsPvEl/80Yp0NM=
X-Received: by 2002:a05:6000:2307:b0:3e3:e7a0:1fec with SMTP id ffacd0b85a97d-3e7657924f5mr9180929f8f.16.1757934492273;
        Mon, 15 Sep 2025 04:08:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGctyRyrIadbxrhHerFpu4jtEM0UPvEhLZCrLT5sa+2qupDmvbeVcrVDByB23FbmDYJzWxMRQ==
X-Received: by 2002:a05:6000:2307:b0:3e3:e7a0:1fec with SMTP id ffacd0b85a97d-3e7657924f5mr9180891f8f.16.1757934491798;
        Mon, 15 Sep 2025 04:08:11 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:f900:e0ae:65d5:8bf8:8cfd? (p200300d82f18f900e0ae65d58bf88cfd.dip0.t-ipconnect.de. [2003:d8:2f18:f900:e0ae:65d5:8bf8:8cfd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0153fbd5sm91804875e9.5.2025.09.15.04.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 04:08:11 -0700 (PDT)
Message-ID: <8c51da7a-7370-4678-96a3-7cd6eaf0db62@redhat.com>
Date: Mon, 15 Sep 2025 13:08:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] mm: add spurious fault fixing support for huge
 pmd
To: Huang Ying <ying.huang@linux.alibaba.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Yang Shi <yang@os.amperecomputing.com>,
 "Christoph Lameter (Ampere)" <cl@gentwo.org>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Anshuman Khandual
 <anshuman.khandual@arm.com>, Yicong Yang <yangyicong@hisilicon.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>,
 Yin Fengwei <fengwei_yin@linux.alibaba.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20250915032946.33203-1-ying.huang@linux.alibaba.com>
 <20250915032946.33203-2-ying.huang@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250915032946.33203-2-ying.huang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.09.25 05:29, Huang Ying wrote:
> In the current kernel, there is spurious fault fixing support for pte,
> but not for huge pmd because no architectures need it. But in the
> next patch in the series, we will change the write protection fault
> handling logic on arm64, so that some stale huge pmd entries may
> remain in the TLB. These entries need to be flushed via the huge pmd
> spurious fault fixing mechanism.
> 
> Signed-off-by: Huang Ying <ying.huang@linux.alibaba.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Yang Shi <yang@os.amperecomputing.com>
> Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Yicong Yang <yangyicong@hisilicon.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Kevin Brodsky <kevin.brodsky@arm.com>
> Cc: Yin Fengwei <fengwei_yin@linux.alibaba.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---

[...]

>   
>   int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> @@ -1857,7 +1861,20 @@ void huge_pmd_set_accessed(struct vm_fault *vmf)
>   	if (unlikely(!pmd_same(*vmf->pmd, vmf->orig_pmd)))
>   		goto unlock;
>   
> -	touch_pmd(vmf->vma, vmf->address, vmf->pmd, write);
> +	if (!touch_pmd(vmf->vma, vmf->address, vmf->pmd, write)) {
> +		/* Skip spurious TLB flush for retried page fault */
> +		if (vmf->flags & FAULT_FLAG_TRIED)
> +			goto unlock;
> +		/*
> +		 * This is needed only for protection faults but the arch code
> +		 * is not yet telling us if this is a protection fault or not.
> +		 * This still avoids useless tlb flushes for .text page faults
> +		 * with threads.
> +		 */

Can we instead just remove these comments and simplly say "see 
handle_pte_fault()"

> +		if (vmf->flags & FAULT_FLAG_WRITE)
> +			flush_tlb_fix_spurious_fault_pmd(vmf->vma, vmf->address,
> +							 vmf->pmd);
> +	}

Okay, In the PTE case, we call flush_tlb_fix_spurious_fault() during 
write faults if ptep_set_access_flags() returned "0".

You are calling flush_tlb_fix_spurious_fault_pmd() during a write fault 
when pmdp_set_access_flags() returned "0" as well.

In general, LGTM, but I would just let touch_pmd() return the value of 
pmdp_set_access_flags() instead and add a quick comment for touch_pmd() 
what the return value means.

-- 
Cheers

David / dhildenb


