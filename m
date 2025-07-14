Return-Path: <linux-kernel+bounces-730230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0991B04193
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AEDA18848B1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE71E246778;
	Mon, 14 Jul 2025 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OL0ldEQx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3155924DCE5
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503210; cv=none; b=ChbKDdb6VJ2jvfE5+jnUqzU6MIozb3nxjl7UDe8o24hTu4L9eiKl3EtdMKDXQXrx9e15AecM3S7+E3FdYjb6EEL2+JCO4jISjouDnrOeYi/eExUFoUZQ/OTuyTsNlWMoSseM9W1hdmKo+3FzLjyh94l8mTflNUj/1s0B7aA/pOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503210; c=relaxed/simple;
	bh=9sRDt8XbALOiiBQIoQxzEEy7jWrUTiS99+dw/pXB0QE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ES/eMHRxMwDYFwx8Dyq+hc8PQmorItj+xi5sw22iBxONm5jX74XRL1V6tPw5OztPwqMm5JuygqQsflZ8npxDjAeN4g8LmIa7OiGRfxfXLvF3atDuHj4rMksLJQ9+aHz6SwmVvfBSlzafA2joIe7h59eGTVCZBOrPoOz+qqAm6Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OL0ldEQx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752503207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=c3ACkYvoScYSjF9O009sm6wRnr0DwbzxGPZnTDe4KSw=;
	b=OL0ldEQxjEI/2mMwvygg0FKSwdA86RhX357XaHRRVNvJ+OnsezmuiJbrXq1OHuWZveZ/ep
	DidIUC+q5s9/RdEx41cAsR38JIY+en/ROpU7p9M/v4piBGFznqgiaJjbj+Lri5hgffnDJl
	MW4M4+TlgXvVepHnpxQGRIfuohfIXeo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-GYpDeD_nPimqZOecDh27-A-1; Mon, 14 Jul 2025 10:26:45 -0400
X-MC-Unique: GYpDeD_nPimqZOecDh27-A-1
X-Mimecast-MFC-AGG-ID: GYpDeD_nPimqZOecDh27-A_1752503204
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4561611dc2aso10481315e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752503204; x=1753108004;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c3ACkYvoScYSjF9O009sm6wRnr0DwbzxGPZnTDe4KSw=;
        b=RSMtM+7v3dozs7vcCoJSXW6WZ4mymGnOzGhy7udddxZ2ml5ifN5yPfQCOkQLrmeGKn
         4vJI3cAyOOjc2ZMnagh492it27hZ/k+1HvJxATIpNB/rzj5Soy7DElr7YQFXEDDyPkcW
         TuKVXKQJZiUXeL9lZsdIbBJfFjhaL6RioLXsljJzPoTXWbtVY+aXzugFN0VY0NoU7UtM
         VbxkRgSHtmFW6HoQBUo7IU4WhUNFep5ObJPeuoIyphdw1i12reOLVQbx1uoBM8qH+jqo
         1wUnCHF2CxIVS1QFIFwY99ITSHi62sg4lzUN5Rn0SUxreXkTT88S3W88u7jIbrJOL8r0
         xf9Q==
X-Gm-Message-State: AOJu0YwfwiSmcubzh/0Uwh/PW5oGRr5AJhShCBFcJ00cbsbpP1+hUytF
	F8nXVtyiYQumNwMshrm9aeTVJVAhKr1L2CSaABqJUOk60fQhuIZEg/pS1bG1raZMmf7DqIwwND1
	9pkK3S9l5TCZJDDUI3DhSmpkh7Ms6/85xsrExHrTv4vBSqcOnGDyEfHpoPWw33sgqsA==
X-Gm-Gg: ASbGncs/7O6Vd7/kPb4+pqPdebYcCBA7sDtN9hMdwTDQKNc26gS8ffpV+TrCQmHif6W
	9U+/rADxUhsSaht8TTCUdKWIe0+n5d57ao1AbjLGLG/WttkD8dM8tYx/LbgnuDsNV6TShJeHFHK
	BoPIE/3vGsreLDH4XAKJFMRmUhqqoBv7TKZKe/e/CJBfNy8cxlPRQz62OsgDAC6X3Er1SbmRa9F
	weu4heIY72VGkdsIcZltdn7666u82HoOvzbp1g9RnwIE/pDLKzCOFAoa85dVux9lJnkOr4zP/73
	k60e97ZH8v+5BDTUvIAa/Y1bcyR+M2QlB2XElSNjzIQsZ7eGo38Q2RPP+L3pRVMII7h9HJPE2ap
	6S6KUfUoYBFxcFuy3tAo1HxEyxAOUre3otvw1AWwRx33EwAVEUhqBjSLX5/AGpNOK
X-Received: by 2002:a05:600c:4f4d:b0:456:58e:318e with SMTP id 5b1f17b1804b1-456058e338amr99442285e9.30.1752503203985;
        Mon, 14 Jul 2025 07:26:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCZ+IKrhhtP4tYiZrI0atHQAvJRRkNYr8TFlqhLmGj+4u0otwxYQZV2D0/VXONJK/syACHGw==
X-Received: by 2002:a05:600c:4f4d:b0:456:58e:318e with SMTP id 5b1f17b1804b1-456058e338amr99441915e9.30.1752503203512;
        Mon, 14 Jul 2025 07:26:43 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f38:ca00:ca3a:83da:653e:234? (p200300d82f38ca00ca3a83da653e0234.dip0.t-ipconnect.de. [2003:d8:2f38:ca00:ca3a:83da:653e:234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd439051sm135912815e9.8.2025.07.14.07.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 07:26:42 -0700 (PDT)
Message-ID: <5e65d43c-787c-4e42-9aa6-6f84018c6f33@redhat.com>
Date: Mon, 14 Jul 2025 16:26:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] mm/memory: introduce is_huge_zero_pfn() and use it
 in vm_normal_page_pmd()
To: Luiz Capitulino <luizcap@redhat.com>, willy@infradead.org,
 akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, shivankg@amd.com,
 sj@kernel.org, harry.yoo@oracle.com
References: <cover.1752499009.git.luizcap@redhat.com>
 <4940826e99f0c709a7cf7beb94f53288320aea5a.1752499009.git.luizcap@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <4940826e99f0c709a7cf7beb94f53288320aea5a.1752499009.git.luizcap@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.07.25 15:16, Luiz Capitulino wrote:
> From: David Hildenbrand <david@redhat.com>
> 
> Let's avoid working with the PMD when not required. If
> vm_normal_page_pmd() would be called on something that is not a present
> pmd, it would already be a bug (pfn possibly garbage).
> 
> While at it, let's support passing in any pfn covered by the huge zero
> folio by masking off PFN bits -- which should be rather cheap.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
> ---
>   include/linux/huge_mm.h | 12 +++++++++++-
>   mm/memory.c             |  2 +-
>   2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 2f190c90192d..59e93fba15f4 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -486,9 +486,14 @@ static inline bool is_huge_zero_folio(const struct folio *folio)
>   	return READ_ONCE(huge_zero_folio) == folio;
>   }
>   
> +static inline bool is_huge_zero_pfn(unsigned long pfn)
> +{
> +	return READ_ONCE(huge_zero_pfn) == (pfn & ~(HPAGE_PMD_NR - 1));
> +}
> +
>   static inline bool is_huge_zero_pmd(pmd_t pmd)
>   {
> -	return pmd_present(pmd) && READ_ONCE(huge_zero_pfn) == pmd_pfn(pmd);
> +	return pmd_present(pmd) && is_huge_zero_pfn(pmd_pfn(pmd));
>   }
>   
>   struct folio *mm_get_huge_zero_folio(struct mm_struct *mm);
> @@ -636,6 +641,11 @@ static inline bool is_huge_zero_folio(const struct folio *folio)
>   	return false;
>   }
>   
> +static inline bool is_huge_zero_pfn(unsigned long pfn)
> +{
> +	return false;
> +}
> +
>   static inline bool is_huge_zero_pmd(pmd_t pmd)
>   {
>   	return false;
> diff --git a/mm/memory.c b/mm/memory.c
> index b0cda5aab398..3a765553bacb 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -687,7 +687,7 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
>   
>   	if (pmd_devmap(pmd))
>   		return NULL;

This likely doesn't apply as-is on top of mm-unstable / mm-new (and 
likely also not mm-stable).

Should be trivial to fixup, though.

-- 
Cheers,

David / dhildenb


