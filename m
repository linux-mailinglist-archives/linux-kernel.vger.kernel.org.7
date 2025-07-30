Return-Path: <linux-kernel+bounces-750871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EEDB16213
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB2115A610F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AAE2D94A9;
	Wed, 30 Jul 2025 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jx5ugZWt"
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3322D9780
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 13:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753883845; cv=none; b=DQKy5FJV3sOTcF9DM1WYJxC2enObLMWPMmVwIVrpGCmNJkmP3gFHFbqxpvurq9GCvKDL2Pr14Hms6mj5iLEPIUpyJ6S008/Pso4pFv9lRI1sEkCg9zKBBs9+Heox3SQoqnmUmkPBaP1t/nwhuSMongHzkq9DQx8zifDn5ZHOzt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753883845; c=relaxed/simple;
	bh=KAuIxAKCqcvJESNNAPuXzlToKx9gAeC5GQhRozqHAyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V51RQ5BF30+1mvsd4ganGwDV9aqO+UovLzsV++1WQzOHFZv+7nEIXHWCzMwDE19nd/9zFWjNN0NL9iLXFQ/YGMYO+3RvifBIkC3NT/FNRfI1Db9Sn7Z9iYXZVoFJRQreUwEeMkgDTY2gZidjm8pJpH6Z13cwgeTbuGdTVSjbbg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jx5ugZWt; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3b785a69454so2433200f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 06:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753883842; x=1754488642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o9x/2NmBAyKmjbcpba0SHjkvYUhTVea6LU5Wnmf6NNM=;
        b=Jx5ugZWtSK8COB35T6ay+0YdwxeOCttweMLRxJBK2JXAXtlpQzAy35n4IE9WKajNUr
         9ThFYASiYaYYwE02g/ue708xDEexVjPx/cKG+H5eVlUWiRCeSbJiJ7Mynyok2+FGcydo
         DLzMGuHYnMPinmuVFAw3BFjz8y/hrUvMZKRw1PhES81AaTNPALDFzSjLgAZ5XBkNFB5B
         4UyxwmRK50urYQTzwJJk6nwenS/o9dL4EBdu8aaxiEBD4B5ovGL9GViRQMK9G/JfUGhE
         Nq02agYiqRCzuXuJw/7ODDisEkq2x6bb+i/S2oc7ZWaaEGjfbaGYEDb5W3zO9iXK4rqW
         xv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753883842; x=1754488642;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o9x/2NmBAyKmjbcpba0SHjkvYUhTVea6LU5Wnmf6NNM=;
        b=L3bTRYO5bTY996rBT7aEv5a97qgdlOZogqLOdlMtWcf9BZ7ue5m/SF3S4cqg5QA1jx
         O+B7GQ+yuSO21GfkqceymqI/Yii8g343L8BJbe4u/PB9bnHNqO3j7mG3C9UTg8Z1oA03
         ws6ISvND+cpsCi1MnmpV017DBdDs7uNjuE0qDkXxmLr/3i2K5YttA6SDZnlagRQ0Xr/t
         +tWfSbcsJDOsXGVsoka3+InFhx890F+Pm8dCGKLUvbWHKJVoel7RJBjZlfvTsUXVOadL
         Dg6GghvzGmmPUJ4dwi9JlSdWvTODRX9XU73UlAspmMsLYxhtDFiqRzOsy9BYS+2yXyXM
         l6dQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8sv7PiRWjJtvHi08OclTxGKf8eiyDlnLVmhwMm4gCW8tjpi67RZ9WlpgaGuGFaB30EcUGc9e+GQpXzoc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/v3O9ViNpvwlg1JhmBZFiGJ0W5Tj+RTHATTdAfkMB20Pj6lZv
	ckagRfqmOW8AXkYOTr9I51hzrXJSDMlv5MMKZ4QurvYEg9K7DcYaeT4WW4DGHqK98F8=
X-Gm-Gg: ASbGncvryA3s7bCyKyIRbwIkUxHnuXmWIH112w2HpJTzpQJ79SdMUjZBXbACqRV2wQk
	wd7uQPr9KBnEFP5X2hKw9mazwxQ1PsKJ+qdUnwrIKBDnmuQkelNGlv3eYhHVT948BjMdQj0hXrS
	y3ESEpjWFqCy4OrMIAkuBFpMUJSu0q8tRAip/v65CmSZE6PSrCSflJvhhLKGNyGmksMBSudfLE4
	m2NsrJMNC249tWsfYyp+mUTxsI8gCQ5L3OpKj0ore0/IXTjeZNI8kxnekXv8QInIjnwYQt8T0Vn
	nSGS+tZ6ckPi0OOBpGaYRrveDFGHyqc1LKT8XiefY8/XT7BivU5WJtGZY4JpFCXB+TM2ibdLE9t
	Ol70FHfcHc8OWRv0EhqflnXdNE8/J5w==
X-Google-Smtp-Source: AGHT+IH3yb9aRgK/Q+bZ6pcZQPnb/X5dHJrsLz/8jaoiHMtgM6iMNWm/RCtsBVpSGygJWiFCkMusNg==
X-Received: by 2002:a05:6000:1886:b0:3b7:9a31:2a10 with SMTP id ffacd0b85a97d-3b79a312c5bmr433785f8f.41.1753883841744;
        Wed, 30 Jul 2025 06:57:21 -0700 (PDT)
Received: from [192.168.0.33] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b795bf9719sm2807959f8f.63.2025.07.30.06.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 06:57:21 -0700 (PDT)
Message-ID: <e66f29c2-9f9f-4b04-b029-23383ed4aed4@linaro.org>
Date: Wed, 30 Jul 2025 16:57:20 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v2 22/29] mm/numa: Register information into Kmemdump
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, tglx@linutronix.de, andersson@kernel.org,
 pmladek@suse.com
Cc: linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 corbet@lwn.net, mojha@qti.qualcomm.com, rostedt@goodmis.org,
 jonechou@google.com, tudor.ambarus@linaro.org
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
 <20250724135512.518487-23-eugen.hristev@linaro.org>
 <ffc43855-2263-408d-831c-33f518249f96@redhat.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <ffc43855-2263-408d-831c-33f518249f96@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 7/30/25 16:52, David Hildenbrand wrote:
> On 24.07.25 15:55, Eugen Hristev wrote:
>> Annotate vital static information into kmemdump:
>>   - node_data
>>
>> Information on these variables is stored into dedicated kmemdump section.
>>
>> Register dynamic information into kmemdump:
>>   - dynamic node data for each node
>>
>> This information is being allocated for each node, as physical address,
>> so call kmemdump_phys_alloc_size that will allocate an unique kmemdump
>> uid, and register the virtual address.
>>
>> Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
>> ---
>>   mm/numa.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/numa.c b/mm/numa.c
>> index 7d5e06fe5bd4..88cada571171 100644
>> --- a/mm/numa.c
>> +++ b/mm/numa.c
>> @@ -4,9 +4,11 @@
>>   #include <linux/printk.h>
>>   #include <linux/numa.h>
>>   #include <linux/numa_memblks.h>
>> +#include <linux/kmemdump.h>
>>   
>>   struct pglist_data *node_data[MAX_NUMNODES];
>>   EXPORT_SYMBOL(node_data);
>> +KMEMDUMP_VAR_CORE(node_data, MAX_NUMNODES * sizeof(struct pglist_data));
>>   
>>   /* Allocate NODE_DATA for a node on the local memory */
>>   void __init alloc_node_data(int nid)
>> @@ -16,7 +18,8 @@ void __init alloc_node_data(int nid)
>>   	int tnid;
>>   
>>   	/* Allocate node data.  Try node-local memory and then any node. */
>> -	nd_pa = memblock_phys_alloc_try_nid(nd_size, SMP_CACHE_BYTES, nid);
>> +	nd_pa = kmemdump_phys_alloc_size(nd_size, memblock_phys_alloc_try_nid,
>> +					 nd_size, SMP_CACHE_BYTES, nid);
> 
> Do we really want to wrap memblock allocations in such a way? :/
> 
> Gah, no, no no.
> 
> Can't we pass that as some magical flag, or just ... register *after* 
> allocating?
> 

Thanks for looking into my patch.

Yes, registering after is also an option. Initially this is how I
designed the kmemdump API, I also had in mind to add a flag, but, after
discussing with Thomas Gleixner, he came up with the macro wrapper idea
here:
https://lore.kernel.org/lkml/87ikkzpcup.ffs@tglx/
Do you think we can continue that discussion , or maybe start it here ?

Eugen

