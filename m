Return-Path: <linux-kernel+bounces-803184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB98B45BC9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CD8E17D17B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A975C306B3C;
	Fri,  5 Sep 2025 15:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOX008XP"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662F9306B37
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084493; cv=none; b=RH2rfGPDLmhsZ3zU9KV1LvGbyycxcw5tRBGIJ1ERaZd4wapBWx//B39Jqk/GEZ3G+ZgV0yLd757h7gtQfp//Vb873Hmgh+bwOVwzvXLSLEXnH5c6zTISvXvIUxq27NtJum9H6/RiYIJZrlmfJ16HRDQ87hccxoSbNONIKJr8vXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084493; c=relaxed/simple;
	bh=7ENsG1Yb2Kwq37ijF+KbmuknAG28/y9TcWRUDHuGQno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FArR9OC4KjEfqSYaua63srR5qBUa7ATof4GEVnt7j7WIHFDWIPix0tc8sHrXPhceEyfvTIG1kaj+hC150kxbwp6VGoY67JLzg5ORpEt2QDIPeOQ625QuwG6ewFfvbFNrBIJ+u85b/SCt1Y8t7bAuxGssR+qpQUulERU6irOuHzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOX008XP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45b8b8d45b3so21267685e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 08:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757084489; x=1757689289; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cqm8/MpfOR7y7rPAbRaZnCO/4JEe1n2rO7vX6ndNO4I=;
        b=AOX008XPysEffUafzdepdjX0M5Yf6IUFZOWoMC951y/5JejXVsBZHrrhzSU+pjTfcl
         DNsIPjQuQiLJgU3kOhpxu2x6znML947x2d28CLQEPeJXlttI0lc5F4xyoEa0nyzz2KkB
         wRPPHKbcMeEvi/54RLkm0LYLr0Ta6uKfECvr3eL+bOCEx936VUE021Av4AlvQuAvpmZY
         6bV5Z7drdFyxUNKXaNMS8NryGdKXgEb1oBDVS/lW7p1CNgBGNPHU911ji47kOoeEf48m
         MWumUHl4/fbMW4c9LO6DH8gkmV/GAWTpEj2K6GFPeFIl//SCnfQV7JvJtZmamgG304M2
         v7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757084489; x=1757689289;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cqm8/MpfOR7y7rPAbRaZnCO/4JEe1n2rO7vX6ndNO4I=;
        b=pEYmw6eRteWe+nPuwiJQOCioCglcVe0l+SOD1+313SzGi7lIU2cb2sj2BaJEpqABcX
         wPCfPuNYHKdHlLjCeKTHSy5s78WFvpDlMAzoQsC3KgrmPSXaqpsct3tw7sBdXrQ4b2Rt
         0hIH3G+H4oNW4JKLKcpOXrppo0jw87Lg7pk0RNeza52NBa06vUKurSTNKN8jBqeaxeh7
         thgF/YkJ9YkXDJifmVFu33Zs31t4K2NmW7qp19FVKm6fOAPH/HWSyiWtGN/Py5bud5fF
         xv5lLl/PGC6Ej8FAmtWdjq55YiGihBMz5W1bv4PEGC9k5LG16KC0ImFFJBWgB6d90QdR
         IVzw==
X-Forwarded-Encrypted: i=1; AJvYcCXFiukdb4Jz1p8g532TnkZGyO01tmfXm6wuCNBF3O15Tbc07UUDG1QXBC8PtkXNqBKM3fL4KZFDpW8VwK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU0EuBhQSwud0K+UyiOfMOZrlYeV/tR30czN6P573JGmF3OJKX
	jHysl/sV66Wan/Izhhci8pk6wT4YfoFlMSHG/W1wX/oiwGDIhB3PGC1C
X-Gm-Gg: ASbGncsd/9b/FdTbiFGEM6UK/ANS2u6hdqsaQ633kB3kzf9BAm8e3kWEgsHSgCcyouW
	o5h1ihsLcJf6OEhnnsrRNzNuA1HpTj2MrPpR4kB4NatYJtPTLGkiTnmWUUlEmGOzLlPEz4LLcCb
	rTwQY1A7PLaPXemjnRpXXgzb6/SNjiMmJhdoxpBplUL+n3Rz1LZvG4KWX5rs1fgu/LjIkS5lyL+
	04l4eWP4zRQcVJ87gdDl1Vc+xcFfzTioBkFx8VOjMDdRZferX6QYj1c+LHE/MPf5foz23r38Y0d
	yBBRNLIbR1h3RNqkpJCLuAzjM+mN7xbWZhXqGqAsGv5guRVDxHk5Mv2nHpcwzI44JNemWNYGaEN
	5P4P2ovO2GY48qXD2F3j4HVKVS51C3VlCLspNY41Q308H7bcifeOP8fuyC7uTewtib3UMdHcHfN
	YA2ZLhMI/aQA5P/Kxg
X-Google-Smtp-Source: AGHT+IGe+fILrap8cGg9dZVGpK+9sA4k4FV6nVfCljYfVknfZyIkZg/8sGEneiKua6ClriufuvNqiA==
X-Received: by 2002:a05:600c:1914:b0:45b:88d6:8db5 with SMTP id 5b1f17b1804b1-45b88d694d3mr186079445e9.12.1757084488540;
        Fri, 05 Sep 2025 08:01:28 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:1449:d619:96c0:8e08? ([2620:10d:c092:500::4:4f66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd4affb6bsm51876115e9.1.2025.09.05.08.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 08:01:27 -0700 (PDT)
Message-ID: <8461f6df-a958-4c34-9429-d6696848a145@gmail.com>
Date: Fri, 5 Sep 2025 16:01:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/huge_memory: fix shrinking of all-zero THPs with
 max_ptes_none default
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>
References: <20250905141137.3529867-1-david@redhat.com>
 <06874db5-80f2-41a0-98f1-35177f758670@gmail.com>
 <1aa5818f-eb75-4aee-a866-9d2f81111056@redhat.com>
 <8b9ee2fe-91ef-4475-905c-cf0943ada720@gmail.com>
 <b56b43c1-d49d-4302-a171-9b00bf9cfa54@redhat.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <b56b43c1-d49d-4302-a171-9b00bf9cfa54@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 05/09/2025 15:58, David Hildenbrand wrote:
> On 05.09.25 16:53, Usama Arif wrote:
>>
>>
>> On 05/09/2025 15:46, David Hildenbrand wrote:
>>> [...]
>>>
>>>>
>>>> The reason I did this is for the case if you change max_ptes_none after the THP is added
>>>> to deferred split list but *before* memory pressure, i.e. before the shrinker runs,
>>>> so that its considered for splitting.
>>>
>>> Yeah, I was assuming that was the reason why the shrinker is enabled as default.
>>>
>>> But in any sane system, the admin would enable the shrinker early. If not, we can look into handling it differently.
>>
>> Yes, I do this as well, i.e. have a low value from the start.
>>
>> Does it make sense to disable shrinker if max_ptes_none is 511? It wont shrink
>> the usecase you are describing below, but we wont encounter the increased CPU usage.>
> 
> I don't really see why we should do that.
> 
> If the shrinker is a problem than the shrinker should be disabled. But if it is enabled, we should be shrinking as documented.
> 
> Without more magic around our THP toggles (we want less) :)
> 
> Shrinking happens when we are under memory pressure, so I am not really sure how relevant the scanning bit is, and if it is relevant enought to change the shrinker default.
> 

yes agreed, I also dont have numbers to back up my worry, its all theoretical :)


