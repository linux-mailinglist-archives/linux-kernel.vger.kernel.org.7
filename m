Return-Path: <linux-kernel+bounces-675687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2558AD0185
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 13:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D65D1774AB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 11:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906912882AC;
	Fri,  6 Jun 2025 11:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fEYiXl2l"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEC12066CE
	for <linux-kernel@vger.kernel.org>; Fri,  6 Jun 2025 11:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749210981; cv=none; b=EgzkSMgfyW/RZr9BKyzBKHjUyR8ZaF8uaIHWWVPInDm7NERaSyRdp35LQgKEK/Tl2jnZsIMD4o4cIX/lmbz7FAnm1N8q+VaxF3Dpsuo0yZBRLeVketNeEZQXdS4IFynnLZ95R04Sgkg5uzigucJQJknQzPcEgadfwjbGIIYhM60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749210981; c=relaxed/simple;
	bh=0u1y4/eFFJ3O0SjLhhxAK1pWG7i/G53qUJV7Hgw4o2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DXJCjgIuUGnG7FXJCK1/AZ5BBtCsrLKSsBOdxBWIuO2j8T2j1SaLldGhYskLIgA2a/umYwBdFVdz5hk45AxDvhFowS2MCJ0uH1O2F9pfuuj4G6gHBj4xAYXGKwNkGi5m6hOVSkZBzXlGSQJwpTjjWIt5A/AEBEieJerKmKKzJcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fEYiXl2l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749210979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=v/9NNy4TMyU9eeIJpLVXjlAQECKJ+eaM7O94WJTzoyU=;
	b=fEYiXl2lvPgtPc/I+NHMHzEbv+k0Mfak+EUTliOINzbUQNgJlywGf+gPIaxPlmLbAnvEQN
	6ZPOaTvWgWbdk4zdxNfMnJGm1Rux6lGmOgKcJAJHAh5CZ10sY3cGnExW1f6bGI4IMGz2bV
	NzoEd33Mrtz8g66wj9eU0WJ+wlpoNQQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-7Pgxbzq2Ohuir0zE4FyorQ-1; Fri, 06 Jun 2025 07:56:18 -0400
X-MC-Unique: 7Pgxbzq2Ohuir0zE4FyorQ-1
X-Mimecast-MFC-AGG-ID: 7Pgxbzq2Ohuir0zE4FyorQ_1749210977
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f6ba526eso1282024f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jun 2025 04:56:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749210977; x=1749815777;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v/9NNy4TMyU9eeIJpLVXjlAQECKJ+eaM7O94WJTzoyU=;
        b=lct0haUJhhRmoP3LJx119XoN/a074pNbztwH/C/kJ13WFmRhDvUDEf7vzwcDt7y7mv
         GtDNEFdxg/3n1B9yJ2vZZUvxiq/9EIBnr98llwV5fgpXpUgBKHrtNnV90LdgFvDpt97l
         RV6lyA4Rf6Zk25mW9stf/OpLrL1l3CvnKeVp3TDcNOlDFDIPUO4KioDTA02m6xD1VRbi
         dhiy2ZV5CTp1uLMAAjw2PK0+6aysiltGVALtgeTI5OPTpajw8DwD8I0mmym34+ohEPaG
         KbxkQlp3riieOyZvzzJlaP2Gf7IYj1zmY6Nuk/8D82L+5+mesoAqC1Ts0xX7oTl5NS4D
         5MRg==
X-Forwarded-Encrypted: i=1; AJvYcCW94yk9HymPKC9piv+TJf5zbT1GKNu4XWRMDs2EWZTTYfozJyV5/nIBodWsCQd4YzYAVlvnc3RqddS5OdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMWzPIxd8E0J6S6DcyamLsFYnXDTY3IImmPab+m6SBMhg83ryr
	/AFxBDPuBUp3Vo8/+ySLKTbmTUvCUQT+f7FsJZ10Nwb2tO8DKbs/yZd7Diy+QUKyd/D2j4jgrVI
	7ltToflv+puGOMCy+vYNE94CrVSwE82a5MC+DEJ+TdAvxdFlSoNdbp8MPUT1BB9yPkA==
X-Gm-Gg: ASbGncvE9aZSm2vmdU4JjY+HHhowge+qr2wL0Pd8dwLTJWCTUYkMsqqhpATV28312r8
	//2dUbCtxSvm5uqbi+sHdvuHZBVxVDUE1Orov6JgTJ/VjbIxxXExDSkkFXZrCI9U/7VIvH+LLFe
	Ba+HnPpAACucHH402eaC0FZp0rLFzyq9YalZhgA7qHiHWsmrdtf8zUJizyIzUpKTrwZKv3gLvXy
	wEE8xGDNUrYz+UW0UK7QFXRtYpL6uPwkUesq9RjtOKiHXGOeOhKMpXAq/wvuoe3euhXvWykh8pm
	K/Li/QbM+5ByyCoceeJEoJQm8qBPxOu40LhxopbwClFWZe8Hr0mgLfSXyDBFm+w/8X3m3T8YL/f
	CnFDfRjGugdCH5WB0sMtF+ds9dd4e4kU=
X-Received: by 2002:a05:6000:4284:b0:3a4:d8f8:fba7 with SMTP id ffacd0b85a97d-3a5318822a4mr2440246f8f.2.1749210977101;
        Fri, 06 Jun 2025 04:56:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH81pzwafZsjxj1UMHZCDZeA5pir+zKKSl7ua6ZL1jSF8b76n0i40RaUs/z/QtsMw38UkmCOA==
X-Received: by 2002:a05:6000:4284:b0:3a4:d8f8:fba7 with SMTP id ffacd0b85a97d-3a5318822a4mr2440224f8f.2.1749210976743;
        Fri, 06 Jun 2025 04:56:16 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f19:9c00:568:7df7:e1:293d? (p200300d82f199c0005687df700e1293d.dip0.t-ipconnect.de. [2003:d8:2f19:9c00:568:7df7:e1:293d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5323a8acasm1641373f8f.26.2025.06.06.04.56.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jun 2025 04:56:16 -0700 (PDT)
Message-ID: <0ca963af-8dc9-4cb4-9142-04497c359b81@redhat.com>
Date: Fri, 6 Jun 2025 13:56:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/10] mm,slub: Use node-notifier instead of
 memory-notifier
To: Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Harry Yoo <harry.yoo@oracle.com>, Rakie Kim <rakie.kim@sk.com>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250605142305.244465-1-osalvador@suse.de>
 <20250605142305.244465-5-osalvador@suse.de>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250605142305.244465-5-osalvador@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.06.25 16:22, Oscar Salvador wrote:
> slub is only concerned when a numa node changes its memory state,
> so stop using the memory notifier and use the new numa node notifer
> instead.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>   mm/slub.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index f92b43d36adc..b8b5b81bfd1a 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -6164,8 +6164,8 @@ static int slab_mem_going_online_callback(void *arg)
>   {
>   	struct kmem_cache_node *n;
>   	struct kmem_cache *s;
> -	struct memory_notify *marg = arg;
> -	int nid = marg->status_change_nid;
> +	struct node_notify *narg = arg;
> +	int nid = narg->nid;
>   	int ret = 0;
>   
>   	/*
> @@ -6217,15 +6217,12 @@ static int slab_memory_callback(struct notifier_block *self,
>   	int ret = 0;
>   
>   	switch (action) {
> -	case MEM_GOING_ONLINE:
> +	case NODE_ADDING_FIRST_MEMORY:
>   		ret = slab_mem_going_online_callback(arg);

In slab_mem_going_online_callback we will cast arg to "struct 
memory_notify", no?

Probably needs to get fixed.

... and probably best to pass marg directly.

>   		break;
> -	case MEM_GOING_OFFLINE:
> +	case NODE_REMOVING_LAST_MEMORY:
>   		ret = slab_mem_going_offline_callback(arg);

slab_mem_going_offline_callback() doesn't even look at arg, so likely we 
can drop that parameter?


-- 
Cheers,

David / dhildenb


