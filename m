Return-Path: <linux-kernel+bounces-744023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4708B1070C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CBCA7B85D4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCC02566D9;
	Thu, 24 Jul 2025 09:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UnQyh3Xe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A61D3BBF0
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753350760; cv=none; b=UkPkkVSE/L93Jac9bK48899QU4IgGyWoTr4Y4MCS7krm/OwkzWQYJ0b10F10HXtjIYucYUUVdp2dCh/xsA9g0nK26OilAmyPPARYRSwPp2q3xx0IzEJwcoy89gCwNrg9s6EaA1cGIC+ncYAZSyCLpHeXasPC/8o5rORjMa1puf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753350760; c=relaxed/simple;
	bh=uBFoTe5ls+xFrn2HTu4BQcFHo7YOeSE/BfhUnjzp5s8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HQxHBbrUgDZCqiZj/LFKnMbUmIcc2/W3AkD/EbUWPHWKY7yqum04N95LW1kdO00inXklNzBUAYVXymHTucv0NT8GXefKz3E/EwAtfLoLe++KBL0hIoOcN8fIoe54R4lnNb3mVWaUrdJfv19F2gQadIC4Sb/MyRdDqZKMo2qtMBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UnQyh3Xe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753350756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3d1VaRL28+ml7CYd59gxcB8VWqpmtd7xKREjccFb968=;
	b=UnQyh3XepzbV7JesZpDVXPkS3QiqoBNYLOAmxw1CE3CZgzZnfhwxJHFganCSMvnx5jMQxE
	B1JkmyeBtk5z12gWa6gJ4sYQgQKvkeF5xTbHsaEYP3w95oyN49G8RqkULkXj0WWok2XdPL
	CnCxL3Ijs3gTbc8MqqTI16k7P3pMVxg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-AJgMLFrAO06f9NvUJW4Z7A-1; Thu, 24 Jul 2025 05:52:34 -0400
X-MC-Unique: AJgMLFrAO06f9NvUJW4Z7A-1
X-Mimecast-MFC-AGG-ID: AJgMLFrAO06f9NvUJW4Z7A_1753350753
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-454dee17a91so6040905e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 02:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753350753; x=1753955553;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3d1VaRL28+ml7CYd59gxcB8VWqpmtd7xKREjccFb968=;
        b=O5iJIgQzK7DW1sCiLWhRaS8B9s7LNW7QsV5I+Y2JC7ydM+gZA/yJaEJwYh976qRZw1
         SbVIVUM2veS365KOCoz1HMwre4OJMI1pCtkBd+pAsdM29PhWSJOFx0g7q93YM1Jfn3zW
         Jnb+Y9ws5hlVeqCFb1Ce4D5z7UiOiQPXYVSYjl7k1SkR/oTzOPXva8OFfjHqPKwEZaj9
         lEioOuOXYVAJkFPm8EVZ4qMPbCoBD5k07I5zJR76aWpHEtpd8CeCZU1COLTjmra/4i9B
         4cZ1UsnA30BiWwXp4kVa8R6OyWcunDwqb+2Hoeo0kJmZBVIYPNZCPTNdqGGQSt9AfBYR
         2gJA==
X-Forwarded-Encrypted: i=1; AJvYcCXDFYEd3QKGr/1ol+gHVBNTd/n4kLg9l1u5UPw4WhbZza+Tz1I7ESHF6/vSem7VZ/jqpZFZ4q1Ogt/dBFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyywiWSWNjqMz065PUj3WmYYFzIQMxPql/IFIzUZF5hoqpDINZ3
	J6wyqfTGdmWUgVm2kqWDN6kHRti1a5ZALNwjg9lkjPGOXgDT0B/inuZTCW3BYZL42Ay1Ob4LMnF
	wAEPrkFaiRO/f/vyuaoy3sk3y1EzRkx6Dgzkgt0zaMrqXS+xFUVc4ggOLeKYrORKOpw==
X-Gm-Gg: ASbGncsv1/29tTCuAS7Y2QW9HSzTAOansfYDdNpVI+HbTsvJA9rig6pGmNWfNBxOOcP
	9RRn1nBrZ3tNydmeKNAqAJoeRVh+pxnPRpuwH0yrUlI3NfgxNEGMi+j0YQuIGvBfPO8AqdE6+VD
	nYxSHbazsaYs1K0js6O6GiHmYIZ+m4G+pbEbQnH/EGrF6Go+Qk7Bql0SVOwEKTJuBX31SaFGH2Q
	/kX1qE7AVR6PayJBlGRDPZ+kbTTVKhGpkYVjF1jDFY7HSh4I1N0zVA6OJ4Kn+l7giyhBukUKviT
	Tt5L+mVt1sNYU8vU1LcvLGFaukmh6vnu3BnUulR0jn2D8R5KsYk96VUMRv0E6NIqCi+ZDQiCIKD
	ydthnurFIxJu+p/d28YtBgvkUElcail2IfK9CU491tPQUyhwN+pFMYb4HpSoT9ub9
X-Received: by 2002:a05:600c:1e29:b0:456:1752:2b43 with SMTP id 5b1f17b1804b1-45868cfb59bmr48340415e9.21.1753350753337;
        Thu, 24 Jul 2025 02:52:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZAUXrziIB8EzlJBAqClUneVHNyWDyc5yyca5B2bw+Sp4TnAaoK9coMye25IUT6mVqTfLJrw==
X-Received: by 2002:a05:600c:1e29:b0:456:1752:2b43 with SMTP id 5b1f17b1804b1-45868cfb59bmr48340085e9.21.1753350752846;
        Thu, 24 Jul 2025 02:52:32 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:5e00:c941:d6fb:3e30:b42? (p200300d82f1f5e00c941d6fb3e300b42.dip0.t-ipconnect.de. [2003:d8:2f1f:5e00:c941:d6fb:3e30:b42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45870554457sm15018435e9.18.2025.07.24.02.52.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 02:52:32 -0700 (PDT)
Message-ID: <67a54f31-e568-427a-8fc8-9791fd34e11b@redhat.com>
Date: Thu, 24 Jul 2025 11:52:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm/page_alloc: Add PCP list for THP CMA
To: "akash.tyagi" <akash.tyagi@mediatek.com>, akpm@linux-foundation.org,
 vbabka@suse.cz, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com
Cc: surenb@google.com, mhocko@suse.com, jackmanb@google.com,
 hannes@cmpxchg.org, ziy@nvidia.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
References: <20250724075301.1151817-1-akash.tyagi@mediatek.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250724075301.1151817-1-akash.tyagi@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.07.25 09:53, akash.tyagi wrote:
> Currently, THP CMA pages share PCP lists with UNMOVABLE and RECLAIMABLE
> pages. This may result in CMA THP pages being allocated from the PCP
> list for other migratetypes. When this occurs, these pages may fail to
> be isolated, leading to CMA allocation failures when drivers request
> them.

Curious, did you run into that in practice?

Having MIGRATE_CMA pages allocated for unmovable allocations would 
indeed be broken.

But, MIGRATE_PCPTYPES does not include MIGRATE_CMA. So there is also no 
dedicated PCP list for VMA?


In free_unref_folios(), we have

"Non-isolated types over MIGRATE_PCPTYPES get added to the 
MIGRATE_MOVABLE pcp list."

	if (unlikely(migratetype >= MIGRATE_PCPTYPES))
		migratetype = MIGRATE_MOVABLE;

So ... shouldn't that safe us here as well for THPs?

> 
> This patch introduces a dedicated PCP list for the THP CMA migratetype,
> ensuring that CMA THP pages are not mixed with other migratetypes and
> remain available for CMA allocations as intended.
> 
> Signed-off-by: akash.tyagi <akash.tyagi@mediatek.com>
> ---
>   include/linux/mmzone.h | 10 ++++++++--
>   mm/page_alloc.c        |  5 +++++
>   2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 283913d42d7b..dd93088ce851 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -696,11 +696,17 @@ enum zone_watermarks {
>   
>   /*
>    * One per migratetype for each PAGE_ALLOC_COSTLY_ORDER. Two additional lists
> - * are added for THP. One PCP list is used by GPF_MOVABLE, and the other PCP list
> - * is used by GFP_UNMOVABLE and GFP_RECLAIMABLE.
> + * are added for THP: one for GFP_MOVABLE, and one for GFP_UNMOVABLE and
> + * GFP_RECLAIMABLE. With CMA enabled, an extra THP PCP list is added for
> + * MIGRATE_CMA, allowing further distinction between MIGRATE_MOVABLE and
> + * MIGRATE_CMA for THP allocations.
>    */
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +#ifdef CONFIG_CMA
> +#define NR_PCP_THP 3
> +#else
>   #define NR_PCP_THP 2
> +#endif
>   #else
>   #define NR_PCP_THP 0
>   #endif
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 2ef3c07266b3..35f8041afbcc 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -519,6 +519,11 @@ static inline unsigned int order_to_pindex(int migratetype, int order)
>   	if (order > PAGE_ALLOC_COSTLY_ORDER) {
>   		VM_BUG_ON(order != HPAGE_PMD_ORDER);
>   
> +#ifdef CONFIG_CMA
> +		if (migratetype == MIGRATE_CMA)
> +			return NR_LOWORDER_PCP_LISTS + 2;
> +#endif
> +
>   		movable = migratetype == MIGRATE_MOVABLE;
>   
>   		return NR_LOWORDER_PCP_LISTS + movable;


-- 
Cheers,

David / dhildenb


