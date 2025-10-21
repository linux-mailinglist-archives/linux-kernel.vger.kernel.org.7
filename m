Return-Path: <linux-kernel+bounces-862379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B8BBF51F1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C20CD18A5C81
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D71287504;
	Tue, 21 Oct 2025 07:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JlE9O/NO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06182765DF
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761033483; cv=none; b=Ed8zp2NvyCNkEojkD8ndPLE9DVINtNCe0iDf4C4peCZzd2/CVhjq9X/E7mU+JnuHMtlWDXopaNA2KQv2lWtfvu44f9EWrXX+JLw4hktOFePdQnphh2hfVH4L58roSthyD8oiDsATYkA/04KhLYvoAcHF3YuZW5TO5DO5EySSsGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761033483; c=relaxed/simple;
	bh=MMsFBoqqIjrmnFxjhaOWjTtBoLL4ZsqLU8jYvAwysns=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ka+xbhi3oHX0rasMW6hujoghiBaJNSxsKBeuO8rlb6/Y6PQDc6fHxf6vzmlsjhxBvw7saAiRqY59R8HvEqYPQUKthOx8lvBI2F2YoNaBUsa6H768YHw9hVnPXOAk2Zy/kNA6T8UVgQV95Y+fzQSIhqKPESK4nNU9eKbDENGRjjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JlE9O/NO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761033479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=B6eMKFbej+QUBomIM39UwXetYGWu9Y7arv53CZP2AtM=;
	b=JlE9O/NOx5QReqs+mSU0sIGmWphyGP6BJKIlMzHFbpzqiDSyzV4YfxgGeN8xT3NsaxSdi9
	ypEH6h45HZuVy3/s35nMYl4lVGXbIikC+HPsGzXGDB6Ml2RPrDJwTQjOmdgciu0DaEyk2M
	3mMCxSHlMnpF7FD9162aHD4+zct6wzA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-7q6Ie1isM2mi0Xaf-u_9ww-1; Tue, 21 Oct 2025 03:57:58 -0400
X-MC-Unique: 7q6Ie1isM2mi0Xaf-u_9ww-1
X-Mimecast-MFC-AGG-ID: 7q6Ie1isM2mi0Xaf-u_9ww_1761033477
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42851b6a659so82156f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 00:57:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761033477; x=1761638277;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B6eMKFbej+QUBomIM39UwXetYGWu9Y7arv53CZP2AtM=;
        b=oLzvJuCj4xXLLJxPuC2BXwFVOhLH/BBYRbLyZMULJFPF6IWbz4L1LuUwlrcahl14pl
         h5ItDbx5+vWkLHoqWAndo2yQ16wR8vtjCI6NLH5IovycynIYAbj2/93WeQuwqi0HDhat
         W8dqmpGyTzpSDPOup13A27BqSq4+wek12H51r7t3M5TPfnLcl0ZEzEVC9Flm1xNOqvuT
         l9W6okDo14/vg6/BPQondmxTnV4xF7UTZliedDfD6QO1o6kYXG7LP4IjIH2RUJcqdgRF
         mgA+1GWlSqSsljqdZsUL/es5uzIB+PrjzCGMISSNu47Hi38N7Z2+n8lFrPdilhsg+5DT
         8p7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWI88C7nEXUiK1a02zyQzb2gJrYgYXc26QTaimkI8GZBVsdLcb91V9IbkSwcy+6pZd4zLMoyrF1NR6t8Bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxomkLkz4poJQolm3aGLGm1oa399lf2jxJHO3hmAVw3RODq//8E
	sU5L5xi1lkc4p9T0fQWZ7fU9NAdkfN/wXz/MUkFO4H+TTKCer3wMtLnXieSBxPOigGhgg573uaY
	f+8O9F+OUKc5D9HcKjtYCLsTcUhRQpEGgp1q2sWDn/6+9aTnlglWeloPKQIG0PGFDlQ==
X-Gm-Gg: ASbGncsKDK+ehR7w2vBmKvzbQezVeoLnIjnvH3E6UkFHG4VtBUFS6K8aoOJCQopcZ60
	1UKvw8ZGIKebSgXGF6+UFFrkMWCAuQLycjnZqGDWCaHsRNjb0KPtqezGiKJMsSWk346s8cfh0d4
	OVZmSfN5jIemMmjwjxhgoM1wI+4295fJOT9+TcQ04xADxULeWxtkh/YERx2S+HblId2U1YivIYj
	7pOlr9E95dZXPktxjossCqNesKmdMBR+bBlqSrZUaVZ6fw+i6cFb2STbN6X6NHy9oTZ6UJ+McH6
	VOGDKfgH9ORVYXR2o8cWXhsSlsgC6A0aOivCRPYdO3rg87ujuQoZr06T5LeI2VfyZwdoEIHvlx1
	wNXLEvQ0SdzVAHb/OmLswMRKblMUyd9FHtWbtbYx78jiDKeHbCR4nv8ohEMnbULl1lFlkTg2N+i
	thpydtcaGROu9YNZ6eYQdZ2dQIqic=
X-Received: by 2002:a05:600c:548a:b0:46e:6d5f:f68 with SMTP id 5b1f17b1804b1-4711787a2cdmr108346655e9.12.1761033476776;
        Tue, 21 Oct 2025 00:57:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDJFbjuB3mwrwyYzqrJL+fmfXcjBy5U7Nf/cnLxTGYNtC8FgM9hOpaN1CYcynMUVdb2OhGfg==
X-Received: by 2002:a05:600c:548a:b0:46e:6d5f:f68 with SMTP id 5b1f17b1804b1-4711787a2cdmr108346535e9.12.1761033476398;
        Tue, 21 Oct 2025 00:57:56 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144c831asm259795265e9.13.2025.10.21.00.57.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 00:57:55 -0700 (PDT)
Message-ID: <99148386-52d5-4d22-a9f3-48dbc9d77273@redhat.com>
Date: Tue, 21 Oct 2025 09:57:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/vmstat: Fix indentation in fold_diff function.
To: akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 jinnasujing@gmail.com
References: <aPc4I/8zXCGyiapN@pilot-ThinkCentre-M930t-N000>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aPc4I/8zXCGyiapN@pilot-ThinkCentre-M930t-N000>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.10.25 09:37, Jing Su wrote:
> Adjust misaligned braces in the fold_diff function to improve
> code readability and maintain consistent coding style.
> 
> Signed-off-by: Jing Su <jingsusu@didiglobal.com>
> ---
>   mm/vmstat.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index bb09c032eecf..63860c3d22e6 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -782,13 +782,13 @@ static int fold_diff(int *zone_diff, int *node_diff)
>   		if (zone_diff[i]) {
>   			atomic_long_add(zone_diff[i], &vm_zone_stat[i]);
>   			changes++;
> -	}
> +		}
>   
>   	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
>   		if (node_diff[i]) {
>   			atomic_long_add(node_diff[i], &vm_node_stat[i]);
>   			changes++;
> -	}
> +		}
>   	return changes;
>   }
>   

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


