Return-Path: <linux-kernel+bounces-803162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F85B45B70
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85E193A0481
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C312F7AD9;
	Fri,  5 Sep 2025 14:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gZqZMQ/o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F6A374277
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084344; cv=none; b=nDvqDpduXXR1XgodhBzy4ZnBWRPkNgDWpRLCmU49VXzbIs5k8gBI/PYz+ZqEA4a1fo+0/G4CpLDZbQ4ctnlofC4/y8VS1vel8CPDFeVjM93aHbbrxtox5IZT8z8W59D28WL9cRjfa+MT6camxE40AoWt+w7jSLyuy1fFtH40Hro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084344; c=relaxed/simple;
	bh=sdnWLDz+yNfjFyPmsFQFwzf26I0AFF9H53O02l3EhH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XgstKcRnuR/4bD5X1nP/d1iF5JZypKfiNlcm60zJtckEBK3YuRoB6SHSHs8xwr/J+gyp7soN7pHbHqHXpa7rsj0ZS58UonW8L7iPFOwF7txwd5JLUaSrTERIrgnUHb+bRE2DiVX9aHjClxRHiMLFSE5LNO1uPs2FSzd3nvnXxIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gZqZMQ/o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757084341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JWlwVak9NJRiIy1csw++0FPFC/8rFkUoHHpoFQJDPr0=;
	b=gZqZMQ/otCFzs625FQfISsiWpeTUfVS/Oz7E03A7oQwnYpLkozKVCgsorRmrCi8c6GU14H
	hqZ/Ycfo71F+CelZ2Ke1yN1H9pniHfXJp7vEbakrcd5znNRjohVu/93I7eSimZqiUl+BfF
	8kW4Et8EO5KRFtiakMWX7JIhwprRD7k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-Ca4q-W55OqysO8YKpv_CiA-1; Fri, 05 Sep 2025 10:58:59 -0400
X-MC-Unique: Ca4q-W55OqysO8YKpv_CiA-1
X-Mimecast-MFC-AGG-ID: Ca4q-W55OqysO8YKpv_CiA_1757084339
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3e2055ce94bso1228101f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 07:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757084339; x=1757689139;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JWlwVak9NJRiIy1csw++0FPFC/8rFkUoHHpoFQJDPr0=;
        b=URlLYrg8xIYAvoqOJRO6q6QWE4yM5gQLtpIQIy6mxUhySfC2GjXjtB/2qUMpcF475L
         rTbesv4es+H1ZSdKsWOk38TvYtueZxQDLn4fTP8nkyvWPSAStr98j9DciAazOeBJR0sQ
         8w6F2R4BAz34HZB5goRew4KeE9+g9mzGmGSjs6I3WLOICIfja9yXLF3/Uj81JVf+nbeN
         +1YdHu0b27MujQZ6BdS3ixnQsKvxAgZNI4wRaxqKKCGNP+bFJFFbxt1I2x6s9cFjyxhH
         1w0SbG+selW2SXZ+r8vW4H4e9JKBH/yh87+0/XDQNF8QiCnK/fic0ukv2C1qXD93+C5F
         vv3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXT2FPZ8oBSkkDo7lp0Fqg1PoNqxRQOPm7HnoqbwfCPo/T9SrQdEXhXnmvs6otcna+UtYx2QiYxBR9z8G8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQrrrpUb9Z8wedfwXFD/2dEIPkwu0ivGqe3VKm7YmemSU7LsjP
	11fRguO32ltc4jA2uRKV282Rff2Hjzv+rcOdklTQlDf5u9ohyRNP9RO+OLWOs2VIcy/GvCdIGCb
	kIdZw8Y+TdZ3C5trqqIRaTQ/5upBuvsDeRqIl9xNdVkxgfRPDnXpsA44CTb1cSOJDpiegDuFHkw
	==
X-Gm-Gg: ASbGncuEPtNAOI0UeIhu3T8tcdeYuS4TlqEDX4Tn1JKyn6zBBj/XWpLIiFqPY+xbyGb
	3HURV9Jb5A3pQF7PCtfkRNtU42rqsY6722B4HzkWuTn+3KV4d/Lr1u5nJ7vbJ6ity7Z0ZsPpTGc
	OJSQ8Km8uWIZXAMhyGD9YLxcOJR9wlDWge4eXWA6hMWKir7G/2eRwd9unL+5fl/mEh5Wzspe0y2
	bcHGS8ifi0S0JzGqpDrWlclXMmfMt4LxbVQ4ZQzjpnR3dvCLQSuPKLchbxet2gKqY8cewE4qCKz
	bw/bf4A7w1cGEwNf3ThElK7y64X8C4peM+QdRQDtPcFMD+XOvpTRVSkNsaCjT03QSAqN/lwd2q6
	SCcqEhmYZONHtaMlV0+dAU/V6POtt7cqRjetPbM+p2eYc0glx21Gae7PR
X-Received: by 2002:a05:6000:288a:b0:3e3:5166:e098 with SMTP id ffacd0b85a97d-3e35166e4e7mr1736577f8f.17.1757084338579;
        Fri, 05 Sep 2025 07:58:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpDJSYy0+rpRw9Ug9NbfQ9Gf6eDCnizADKdtaBNS+w9mMzRGcRaiPlSSQxhLUcAn7NK9Afcg==
X-Received: by 2002:a05:6000:288a:b0:3e3:5166:e098 with SMTP id ffacd0b85a97d-3e35166e4e7mr1736559f8f.17.1757084338139;
        Fri, 05 Sep 2025 07:58:58 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4d:e00:298:59cc:2514:52? (p200300d82f4d0e00029859cc25140052.dip0.t-ipconnect.de. [2003:d8:2f4d:e00:298:59cc:2514:52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd2304e16sm75072365e9.7.2025.09.05.07.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 07:58:57 -0700 (PDT)
Message-ID: <b56b43c1-d49d-4302-a171-9b00bf9cfa54@redhat.com>
Date: Fri, 5 Sep 2025 16:58:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/huge_memory: fix shrinking of all-zero THPs with
 max_ptes_none default
To: Usama Arif <usamaarif642@gmail.com>, linux-kernel@vger.kernel.org
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <8b9ee2fe-91ef-4475-905c-cf0943ada720@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.09.25 16:53, Usama Arif wrote:
> 
> 
> On 05/09/2025 15:46, David Hildenbrand wrote:
>> [...]
>>
>>>
>>> The reason I did this is for the case if you change max_ptes_none after the THP is added
>>> to deferred split list but *before* memory pressure, i.e. before the shrinker runs,
>>> so that its considered for splitting.
>>
>> Yeah, I was assuming that was the reason why the shrinker is enabled as default.
>>
>> But in any sane system, the admin would enable the shrinker early. If not, we can look into handling it differently.
> 
> Yes, I do this as well, i.e. have a low value from the start.
> 
> Does it make sense to disable shrinker if max_ptes_none is 511? It wont shrink
> the usecase you are describing below, but we wont encounter the increased CPU usage.>

I don't really see why we should do that.

If the shrinker is a problem than the shrinker should be disabled. But 
if it is enabled, we should be shrinking as documented.

Without more magic around our THP toggles (we want less) :)

Shrinking happens when we are under memory pressure, so I am not really 
sure how relevant the scanning bit is, and if it is relevant enought to 
change the shrinker default.

-- 
Cheers

David / dhildenb


