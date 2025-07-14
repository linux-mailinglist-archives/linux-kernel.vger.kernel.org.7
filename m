Return-Path: <linux-kernel+bounces-730410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC31AB0443C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFB1E3A9139
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D04325CC7A;
	Mon, 14 Jul 2025 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DbXgUqPq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B1B1ADC69
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507027; cv=none; b=OqlqyKTS2tbMcTaWHzbUa5aIrN91xnWEt25RdCLRX4b1RSDq8utZbK6iuIcPRw0jdeVIo61mSsOtakdDL7GgLFJ19E/AQ1NzgUOK9LQugD08VR6PfdVE80WqCkTXwQAjt3HJ15nXK8706AfyaEPJImQRlWH8KeVPF8XdIQCvLCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507027; c=relaxed/simple;
	bh=B+afjlfux0KnkcQeBAmqq8PQF+o5lRRZ0attHYFRkd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xo7RrlJyfjuvgHTPK7iyHl2OFOtc7KlwuiefLbGmb2XYbKtnvVcteI2l7PlYfD4K6eSfeJ2Wh85Sz6k6jlnj2cvNY6p67ZO3ktv3ZrUFXYy5uRH1jprvg402SOqsTJPYZu/b87bIs534t0XFvVC9Eagv7aSROUCqIMxzKkhyCpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DbXgUqPq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752507024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gohbFxz9eRg8F1mUSZnC3p7R6dVwGgRWZw+cknpicic=;
	b=DbXgUqPqIP0JtBHOVrNtEsRIWlGk4zVEpdhQ5biSviaf/fmZpJWjZFzxAef2LR5ZHNt/W6
	UlpvSpDy82n4UONgoMTZMrXKDzbIsBHLHTAmZ9s6vVup5Ngy/ThPNgSPpWEbHM7QC9/9dF
	KV2lLOiX2jp3BoZXy+18qMubfTDHX98=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-LSvJVqxlOpqAx9z3All6oQ-1; Mon, 14 Jul 2025 11:30:21 -0400
X-MC-Unique: LSvJVqxlOpqAx9z3All6oQ-1
X-Mimecast-MFC-AGG-ID: LSvJVqxlOpqAx9z3All6oQ_1752507020
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-453a5d50b81so32708415e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752507020; x=1753111820;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gohbFxz9eRg8F1mUSZnC3p7R6dVwGgRWZw+cknpicic=;
        b=R9nNs43dbEev0DfDFZI7VSRTlNNx9ZR5waBe7eJzEP9K5ge527JOnakhTTP8hblTgV
         iXPk5sV+kUaIIY0XmFGj6VsSEsrT/YyfFng5fjRdm8JeaZ2/k8I7DqVxDuB2jKdwogXw
         zSVQg9v1p4m6+0m6retWuIozKXrvK0/lHpToDJy0iR88XHptY5VZnmHtoR8DjK77ci7S
         PpIlKrb+C4gpfOs2RJ/PlLMZdZpPavm4/5LqKSWQP5hVwsUGaDpRK6pLQCE92Si3RJpK
         1425JehfSJpsepUqSz4NokoVpwsdplUXBLwmGQxYkDxStsMlBqy1QxeUZ5orsfsrhM+X
         q1lw==
X-Forwarded-Encrypted: i=1; AJvYcCV6l02LKMZgiljIAPj99+QOr94SiAF+vT8/1lceV6kko+XmAyQ67avvidipqn4Shy1g92rmO+w8G0KdA10=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy17D17Abw+j6loQ/WvicB8C/H56nKNAJMQqiY2T3H+3lXsAd4U
	JvALIUNsaVGeaDqIotID3CQc03UU6BC/8r68DxlMdJ+kiGqrEJ22HQbTPCbG6/FStZZ23FMI+L6
	J6QYjcdCaT/re5Jl9sWmyEthJCjRJch4wkUUc/mx3qOX/Z0tsO3ThQ75uFZqq//OwSw==
X-Gm-Gg: ASbGncsD0dIGL1s6qhZM8Ny74Of80+uqzuNeVBKuhTqX5iw+GxmyTM8GQfw/ZFIqfx9
	drAUJZawHfcJojZ4v2sYPR9tVvRGBvUd2/NdMOdXrypnJ1afI+fgCD22H3WdL6jNNxAm8cjAujV
	1Ok9AJSv+TVQFGMeJjSAyTojuNYoXQi7p0p0Iom9styGCltpT+eNj1cRWvyYVA54CCKOrz19Q68
	OPSdgt8eGoUaMaLNLOv9NB8eYJH0qVxPkKTNVJik+y5jygz+M5jTCSzRSoZ9xwEpWr6d9g9230E
	JwV1O4G70wjK6nRRHpvyUv6EGAHVJThlXQqkM/lAZPH9um/ix8oEiPwHnRlW1MuBU/+IFKtCPS+
	1WKmgivS4hMTd0zqwmyHiSRXxzv7VhRJIknn7YKRpG829Q1OjdKVkCE++dmK0WJ+w
X-Received: by 2002:a05:600c:c4ab:b0:450:cf42:7565 with SMTP id 5b1f17b1804b1-454f4261520mr103684805e9.23.1752507019932;
        Mon, 14 Jul 2025 08:30:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrlAgMB5C+1RW3hZQtc2HLO/XVU7Qsg5A9KDPFitWXd2QxzvhtVbrB/gIf4+x1ax/4pkIAJg==
X-Received: by 2002:a05:600c:c4ab:b0:450:cf42:7565 with SMTP id 5b1f17b1804b1-454f4261520mr103684475e9.23.1752507019507;
        Mon, 14 Jul 2025 08:30:19 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f38:ca00:ca3a:83da:653e:234? (p200300d82f38ca00ca3a83da653e0234.dip0.t-ipconnect.de. [2003:d8:2f38:ca00:ca3a:83da:653e:234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4561d19a21dsm26884725e9.24.2025.07.14.08.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 08:30:18 -0700 (PDT)
Message-ID: <d0c7b14a-6ce9-4e3a-8cd8-7cce4ee7d7cc@redhat.com>
Date: Mon, 14 Jul 2025 17:30:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm/huge_memory: move unrelated code out of
 __split_unmapped_folio()
To: Zi Yan <ziy@nvidia.com>, Balbir Singh <balbirs@nvidia.com>,
 linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
 <hughd@google.com>, Kirill Shutemov <k.shutemov@gmail.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org
References: <20250711182355.3592618-1-ziy@nvidia.com>
 <20250711182355.3592618-2-ziy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <20250711182355.3592618-2-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.07.25 20:23, Zi Yan wrote:
> remap(), folio_ref_unfreeze(), lru_add_split_folio() are not relevant to
> splitting unmapped folio operations. Move them out to the caller so that
> __split_unmapped_folio() only handles unmapped folio splits. This makes
> __split_unmapped_folio() reusable.
> 
> Convert VM_BUG_ON(mapping) to use VM_WARN_ON_ONCE_FOLIO().
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---

[...]

> -	if (folio_test_swapcache(folio)) {
> -		VM_BUG_ON(mapping);
> -
> -		/* a swapcache folio can only be uniformly split to order-0 */
> -		if (!uniform_split || new_order != 0)
> -			return -EINVAL;
> -
> -		swap_cache = swap_address_space(folio->swap);
> -		xa_lock(&swap_cache->i_pages);
> -	}
> -
>   	if (folio_test_anon(folio))
>   		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
>   
> -	/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
> -	lruvec = folio_lruvec_lock(folio);
>   

Nit: now double empty line.

>   	folio_clear_has_hwpoisoned(folio);
>   
> @@ -3480,9 +3451,9 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
>   	for (split_order = start_order;
>   	     split_order >= new_order && !stop_split;
>   	     split_order--) {
> -		int old_order = folio_order(folio);
> -		struct folio *release;
>   		struct folio *end_folio = folio_next(folio);
> +		int old_order = folio_order(folio);
> +		struct folio *new_folio;
>   
>   		/* order-1 anonymous folio is not supported */
>   		if (folio_test_anon(folio) && split_order == 1)
> @@ -3517,113 +3488,34 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
>   
>   after_split:
>   		/*
> -		 * Iterate through after-split folios and perform related
> -		 * operations. But in buddy allocator like split, the folio
> +		 * Iterate through after-split folios and update folio stats.
> +		 * But in buddy allocator like split, the folio
>   		 * containing the specified page is skipped until its order
>   		 * is new_order, since the folio will be worked on in next
>   		 * iteration.
>   		 */
> -		for (release = folio; release != end_folio; release = next) {
> -			next = folio_next(release);
> +		for (new_folio = folio; new_folio != end_folio; new_folio = next) {
> +			next = folio_next(new_folio);
>   			/*
> -			 * for buddy allocator like split, the folio containing
> -			 * page will be split next and should not be released,
> -			 * until the folio's order is new_order or stop_split
> -			 * is set to true by the above xas_split() failure.
> +			 * for buddy allocator like split, new_folio containing
> +			 * page could be split again, thus do not change stats
> +			 * yet. Wait until new_folio's order is new_order or
> +			 * stop_split is set to true by the above xas_split()
> +			 * failure.
>   			 */
> -			if (release == page_folio(split_at)) {
> -				folio = release;
> +			if (new_folio == page_folio(split_at)) {
> +				folio = new_folio;
>   				if (split_order != new_order && !stop_split)
>   					continue;
>   			}
> -			if (folio_test_anon(release)) {
> -				mod_mthp_stat(folio_order(release),
> +			if (folio_test_anon(new_folio)) {
> +				mod_mthp_stat(folio_order(new_folio),
>   						MTHP_STAT_NR_ANON, 1);
>   			}

Nit: {} can be dropped

Code is still confusing, so could be that I miss something, but in general
looks like an improvement to me.

I think we can easily get rid of the goto label in __split_unmapped_folio() doing something like

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 14bc0b54cf9f0..db0ae957a0ba8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3435,18 +3435,18 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
                                 if (xas_error(xas)) {
                                         ret = xas_error(xas);
                                         stop_split = true;
-                                       goto after_split;
                                 }
                         }
                 }
  
-               folio_split_memcg_refs(folio, old_order, split_order);
-               split_page_owner(&folio->page, old_order, split_order);
-               pgalloc_tag_split(folio, old_order, split_order);
+               if (!stop_split) {
+                       folio_split_memcg_refs(folio, old_order, split_order);
+                       split_page_owner(&folio->page, old_order, split_order);
+                       pgalloc_tag_split(folio, old_order, split_order);
  
-               __split_folio_to_order(folio, old_order, split_order);
+                       __split_folio_to_order(folio, old_order, split_order);
+               }
  
-after_split:
                 /*
                  * Iterate through after-split folios and update folio stats.
                  * But in buddy allocator like split, the folio



-- 
Cheers,

David / dhildenb


