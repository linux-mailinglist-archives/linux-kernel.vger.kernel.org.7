Return-Path: <linux-kernel+bounces-830269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB41B99404
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C3731B23DE2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64B42DA75A;
	Wed, 24 Sep 2025 09:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c0vPEHwm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283152DA779
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758707472; cv=none; b=gLixvLBz+5gT2kVpj/eoZzEnS/jId0UB9sm2n9ojo7PDElGlFpD4hJ6rDbuaqf2oJqQi6ViyagjuJnreuTMY+CTWp7XyVHSDqKWJS4wiePwxMqQLLxe14EmlvjIBqFYeZADSDUSRLYTIwgBD2xC9/GXIlDsmFjgnMGeYHxwCBn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758707472; c=relaxed/simple;
	bh=DJjFBN0dCoTlCXQPGfO3ldZKyS8M8jtLUNopIH2u4bA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r7DPjBJkWb2IEINzFprmj8mUFdxcRuG/e5EsVWVwnxPBmn8WRPnUsCx/Q+/UR2Cn95pWbzGIa/YTHC3AntcEgq53nkPoDosVwY4uF7tN4FE9sU7O5s5sU9AdeYUnwT2UnpP4Y57R/jSzRbBSVD5AoUN+oPF7ZL1UsMlpGkZEprw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c0vPEHwm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758707464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wQMBR3G5+Db1duFANu1LlfQUqIsF8KEE1eC0NYFF1Ho=;
	b=c0vPEHwm+aP8DRqpI6jwhDdm3adZ1STCpN+nEoACzDfG7Gg+hWE63tEV65SzlHtEy03j+6
	1Jrf+34F78uKTSxchKftAcCmKhU9AZ+6Ybqiu+RwxQLqjMi9pHqsAdjgCaiVRUlNLbXIth
	Ym/pnvrdeis3r0mJBmFtU/P/PYKqNXo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-0maKENUkOfCVdFDL3fk37A-1; Wed, 24 Sep 2025 05:51:03 -0400
X-MC-Unique: 0maKENUkOfCVdFDL3fk37A-1
X-Mimecast-MFC-AGG-ID: 0maKENUkOfCVdFDL3fk37A_1758707462
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ecdd80ea44so521491f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 02:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758707462; x=1759312262;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wQMBR3G5+Db1duFANu1LlfQUqIsF8KEE1eC0NYFF1Ho=;
        b=UJ1/31cDMY9SWRcISNxkhzKomZ3AFs++i7mZmN72kj5+7vkkGokmEq/OmF8+WJx1k7
         6HRBU44NYHdRtq9tP0aQ9LoUP9RakYyEf5XdBsVHzghPoTDstVa2YwEptXuV8JTYVKp2
         F5VlYCgIZgMd99y5IDcuE1tgLJvMBLjKqpHCND26Rx1KYojQ80CWfqrZfylcG0RiEhpb
         zx6yRvwVmdLzRihEEj5IWhw/R8gv+wGJ4i8EMCQ7OUbcWU2WiNS1Crd0fLuLSR9uzCZi
         I2DTuvJmjAgWYUD9myAnse+CV4vPiGkDbDDfRTR6e9x0aGb/5uFFXb6Ta4rp9yhm81BE
         NFFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm9+bzAE528cmnJ7IMaswxgvoO+36TWnZHo/Vy3WvNxVHPA0aKvg+wkmEE7TgLs22G4rJNBDvXleE66sI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDoHyQgBAMK8b/tpcWeijKWP+5jGDEPtNXtEw/bZDch6yebIUQ
	xNipfEPBC4u6BSYoCxoLxaJY4s6gmTZo2gcf+pm38Js/ZF5/DLiVWo6E2Oo4gHskfXzPPHB5OEb
	Q4Y3S20BeuTV02nkpQ2PJb4eD7cgqDz/p7QGcVQJpX1wgNtrO2jwhlmAUGnuENgl4eA==
X-Gm-Gg: ASbGncv8ZWc3Jvi0ijmmk0KZ5KoManI4Mzf1SYiYv0lUIpEqS1OkZK2m1psrnm/noIg
	wS0e4mMp2UHoEOQPbKp2DYNER6NBaifhZkNL6aZfQ45hCEV2rAM+hi/bfWMwQycBEHslFvQyU9q
	vrQzmbEe0xIip7cMjCgLSXxN+wqlw4szgDxxK2n0tPLTZQAcxm4rRbaUiDTQ9DuNlTxSDz1eSon
	BKA+i9ctrZYDpyORJSVmkqnlLZ75oRv6j2n7+eWDMn9dxzww6KyZSJgpog8PE0vBSPEAGd/TL8e
	Qc3JWlJ9xWEBzoFLTZ79X8cUwIFiIwFatmK6nFOfnJSH482vngANT2FY4hpS3yriUOwLt6vG3U1
	dkA0N2qCp6nB4PU+hBNICQ6jMW0SygoqyXmzJqVhAXbrLRWQeittM7ZSdTdcT4Qf4pg==
X-Received: by 2002:a05:6000:250e:b0:407:d776:4434 with SMTP id ffacd0b85a97d-40ad3e31090mr1902988f8f.30.1758707461963;
        Wed, 24 Sep 2025 02:51:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhPPRuD29fp3XB+dlfoXl2496knpnZNpdUhlWL76OfhvP5Pe0dNCs5vxe+nKDXGGk5bWGRAQ==
X-Received: by 2002:a05:6000:250e:b0:407:d776:4434 with SMTP id ffacd0b85a97d-40ad3e31090mr1902931f8f.30.1758707461451;
        Wed, 24 Sep 2025 02:51:01 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f14:2400:afc:9797:137c:a25b? (p200300d82f1424000afc9797137ca25b.dip0.t-ipconnect.de. [2003:d8:2f14:2400:afc:9797:137c:a25b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a998314sm29241655e9.3.2025.09.24.02.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 02:51:00 -0700 (PDT)
Message-ID: <f8571506-30c0-4dc8-9995-41a6469f8fc7@redhat.com>
Date: Wed, 24 Sep 2025 11:50:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] mm: add PMD-level huge page support for
 remap_pfn_range()
To: Yin Tirui <yintirui@huawei.com>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, catalin.marinas@arm.com,
 will@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, anshuman.khandual@arm.com,
 yangyicong@hisilicon.com, ardb@kernel.org, willy@infradead.org,
 apopple@nvidia.com, samuel.holland@sifive.com, luxu.kernel@bytedance.com,
 abrestic@rivosinc.com, yongxuan.wang@sifive.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-riscv@lists.infradead.org
Cc: wangkefeng.wang@huawei.com, chenjun102@huawei.com
References: <20250923133104.926672-1-yintirui@huawei.com>
 <20250923133104.926672-3-yintirui@huawei.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250923133104.926672-3-yintirui@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.09.25 15:31, Yin Tirui wrote:
> Add PMD-level huge page support to remap_pfn_range(), automatically
> creating huge mappings when prerequisites are satisfied (size, alignment,
> architecture support, etc.) and falling back to normal page mappings
> otherwise.
> 
> Implement special huge PMD splitting by utilizing the pgtable deposit/
> withdraw mechanism. When splitting is needed, the deposited pgtable is
> withdrawn and populated with individual PTEs created from the original
> huge mapping, using pte_clrhuge() to clear huge page attributes.
> 
> Update arch_needs_pgtable_deposit() to return true when PMD pfnmap
> support is enabled, ensuring proper pgtable management for huge
> pfnmap operations.
> 
> Introduce pfnmap_max_page_shift parameter to control maximum page
> size and "nohugepfnmap" boot option to disable huge pfnmap entirely.

Why? If an arch supports it we should just do it. Or what's the reason 
behind that?

> 
> Signed-off-by: Yin Tirui <yintirui@huawei.com>
> ---
>   include/linux/pgtable.h |  6 +++-
>   mm/huge_memory.c        | 22 ++++++++----
>   mm/memory.c             | 74 ++++++++++++++++++++++++++++++++++++-----
>   3 files changed, 85 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 4c035637eeb7..4028318552ca 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1025,7 +1025,11 @@ extern pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
>   #endif
>   
>   #ifndef arch_needs_pgtable_deposit
> -#define arch_needs_pgtable_deposit() (false)
> +#define arch_needs_pgtable_deposit arch_needs_pgtable_deposit
> +static inline bool arch_needs_pgtable_deposit(void)
> +{
> +	return IS_ENABLED(CONFIG_ARCH_SUPPORTS_PMD_PFNMAP);
> +}
>   #endif
>   
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 9c38a95e9f09..9f20adcbbb55 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2857,14 +2857,22 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>   
>   	if (!vma_is_anonymous(vma)) {
>   		old_pmd = pmdp_huge_clear_flush(vma, haddr, pmd);
> -		/*
> -		 * We are going to unmap this huge page. So
> -		 * just go ahead and zap it
> -		 */
> -		if (arch_needs_pgtable_deposit())
> -			zap_deposited_table(mm, pmd);

Are you sure we can just entirely remove this block for 
!vma_is_anonymous(vma)?

-- 
Cheers

David / dhildenb


