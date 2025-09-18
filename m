Return-Path: <linux-kernel+bounces-822117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC79B830E2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D351467761
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BD82D77E7;
	Thu, 18 Sep 2025 05:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ba7Mnjes"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4B12D73A8
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758174974; cv=none; b=Um0qGJPrdpiZt+C5c+z80hOic4MSduC6usYBiPBzzprE7kBoubDlMoEQwl6x5d662sy10Xc8IXpSeN1Ds0mXuq5n6iEz7ryZ5jVouvC3Knk6fVJKH3o0YHVoGTvMIHAGAkF0PqkZgs0oQzFgRyAR184Txox/p3OX5vW1SxfP0PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758174974; c=relaxed/simple;
	bh=y6KtngPftYNXnOVKx2ok1wN+wkrAf54TfFwVsOJ+GWo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=E5UsS+zggGlgfiViSZzGugmrIU5OQoenPyU4fGPb9BW1df6V0hRSJVbu78qb8VFj+5LiYOGLQCWA/9uk8ay1Yg7dNBLopRtvsFvBqGnllGMNDzt+71jggvuakpGLpaA91+OilJC3muYBpyRsuNDQ1PkAt5REHpMeMHG524PJKvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ba7Mnjes; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758174971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iFodLU7WRNoR8rMYR2p+tFACfC6CQ0VFz+XaBvWZe3Q=;
	b=ba7MnjesUawcsLdPTtGIV17YlD4NDn9Yy9BPgpJJQgZqae450b8dUQFCFsfA0TVUkMM/BO
	1J/Q+2nLb/zr4mqNNskVmOF7rHoWvrgliBxy9wXfj1qxoLoz3uKPgHR39NzYnQ/MxAgjFK
	AxZQ0HyA2IaZuYe2IjMgk8e5E1cFAQ0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-azxZQ1zeNuaMjXl4BbQpaQ-1; Thu, 18 Sep 2025 01:56:10 -0400
X-MC-Unique: azxZQ1zeNuaMjXl4BbQpaQ-1
X-Mimecast-MFC-AGG-ID: azxZQ1zeNuaMjXl4BbQpaQ_1758174969
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45dcf5f1239so2113335e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 22:56:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758174969; x=1758779769;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iFodLU7WRNoR8rMYR2p+tFACfC6CQ0VFz+XaBvWZe3Q=;
        b=G20PZiLnzyfYGB6X7Aehv9oxXUE92OjeWNT+5fm28jI/utqqHqwcgWpfkjUNxSTKK2
         M3LLgAIQEUW2BeN4EQzMhHWfF0+MNaVgQmpzugwQPJcZJymEhkGfKrqWXSJneSd5z7Tk
         CkN4UfVhltZ4RAZJ3Qu52Bd9tJ9fq6xwxAuzGwxvH0OCyecj3lBDzppAXNAAyGsJEUSU
         xnUstlsEPoBABBgY8x4LfmuXHKSNJKbbW/FbRAyGa6CMKneDr3UwTW22hcXScTgOqx7K
         x3J9VOqPsyZ4ir7GKlsF5QQCj6MGb2jwlkJl2MUpOmpzeacdgPp4Gzvn4m4BRDedQAlA
         CF2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXWpJEI7Sd+o5b+YfFQ9oQ1qMtYJkqPvJzlRmCn6TpPDboBLeVJFdaBfE+r05JeP1VjINP9ZiVUb3tTNrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOtEx0ZtJKnJ02YdWegNY5qSkPtAtKzlL+yELQM2Hc9baZoify
	JKmHKe5q4mjFop4v2CkTqx+KDw4BLCyln8d3MKn4bJJeyAgniRVFaZpjjACXpZ6Ar7WlJJoHGij
	SEtCmPORriXqCjyFQ99xrPGG3ZGqR9HPAeWTHhklrP8P4alCi76SkRY+9T4ZveeyITw==
X-Gm-Gg: ASbGncusKY9bRmbcSKySAB13adR9dkb/xnje/C4e39G1aO3vOsrd/fdQgpL4FYNGHlG
	67KosL19NfvaCWbZ2748r3Dkulc0EvrP2l5fZjOsVMjlAHn6E3KG6XI8RKa6sP6Vqyw1eOz+hqe
	v5e6xmyrVMF67qjcDQu6qDD0vSXN+rSMkdVZhy5AU2quSFODCy7fvKBxfxK6yfzEwGmXe8mK0XA
	Q0j46uE4g6KiIzZEMtjLMJPeOluq6AzAjWKDY9qq7oSMJOxGjn733FvI7cmvR2MUWfl6EgIkoQt
	uSfVb/E6upEJHlmejc2APrmY3VnGpTfuVqoTW94Axk4PqmRLHz1IbNDARbhq/fG4aVtRUYjoT6L
	A46fzx20V2A9GFB8pQwtihcU7Dd7hkKGEYQT3blD3hFrjxjOIZY+omkkBNqv7dILfr2BJ
X-Received: by 2002:a05:600c:5486:b0:459:d451:3364 with SMTP id 5b1f17b1804b1-46205cc8444mr47905665e9.24.1758174968854;
        Wed, 17 Sep 2025 22:56:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHa5cFLROHCThsOI4QlMKhK4/G9ymQhSNCWrlhpgmZpLNsf0XK4hUNh/ELW+ARX9uKv36toQ==
X-Received: by 2002:a05:600c:5486:b0:459:d451:3364 with SMTP id 5b1f17b1804b1-46205cc8444mr47905405e9.24.1758174968484;
        Wed, 17 Sep 2025 22:56:08 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f07:dd00:ca9c:199e:d2b6:9099? (p200300d82f07dd00ca9c199ed2b69099.dip0.t-ipconnect.de. [2003:d8:2f07:dd00:ca9c:199e:d2b6:9099])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46566f72354sm16617495e9.3.2025.09.17.22.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 22:56:07 -0700 (PDT)
Message-ID: <7c38e725-f6d5-4691-b211-a22fc67db85c@redhat.com>
Date: Thu, 18 Sep 2025 07:56:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/base/node: Fix double free in register_one_node()
From: David Hildenbrand <david@redhat.com>
To: Donet Tom <donettom@linux.ibm.com>, akpm@linux-foundation.org,
 clm@meta.com
Cc: Jonathan.Cameron@huawei.com, alison.schofield@intel.com, dakr@kernel.org,
 dave.jiang@intel.com, gregkh@linuxfoundation.org,
 kamezawa.hiroyu@jp.fujitsu.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, osalvador@suse.de, rafael@kernel.org,
 ritesh.list@gmail.com, yury.norov@gmail.com, ziy@nvidia.com
References: <20250918054144.58980-1-donettom@linux.ibm.com>
 <5512b1b6-31f8-4322-8a5f-add8d1e9b22f@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <5512b1b6-31f8-4322-8a5f-add8d1e9b22f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.09.25 07:55, David Hildenbrand wrote:
> On 18.09.25 07:41, Donet Tom wrote:
>> When device_register() fails in register_node(), it calls
>> put_device(&node->dev). This triggers node_device_release(),
>> which calls kfree(to_node(dev)), thereby freeing the entire
>> node structure.
>>
>> As a result, when register_node() returns an error, the node
>> memory has already been freed. Calling kfree(node) again in
>> register_one_node() leads to a double free.
>>
>> This patch removes the redundant kfree(node) from
>> register_one_node() to prevent the double free.
>>
>> Fixes: 786eb990cfb7 ("drivers/base/node: handle error properly in register_one_node()")
>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>> ---
>>    drivers/base/node.c | 1 -
>>    1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/base/node.c b/drivers/base/node.c
>> index 1608816de67f..6b6e55a98b79 100644
>> --- a/drivers/base/node.c
>> +++ b/drivers/base/node.c
>> @@ -885,7 +885,6 @@ int register_one_node(int nid)
>>    	error = register_node(node_devices[nid], nid);
>>    	if (error) {
>>    		node_devices[nid] = NULL;
>> -		kfree(node);
>>    		return error;
>>    	}
>>    
> 
> Yes, that matches what other users (staring at mm/memory-tiers.c) do.

I forgot

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


