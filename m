Return-Path: <linux-kernel+bounces-750880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C28B16235
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2344188E33F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C702D97A5;
	Wed, 30 Jul 2025 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GP0fX2fT"
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE602D9491
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 14:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753884267; cv=none; b=fl4helEHtfQR8NTJ40wRjkqEE8IvMRzKfxd1UfDTMuXR0mBrheMs4OijQNwx4nYvDiiEMgmwoUz4s8RmhyiwcSze2WCEvC4DzErMh0BjMq1KmWlnD454onM07Pqovv1jiu6Fn1jYHVHqL/NVfRvPZj9bBTowqrdq6Lah8yjjMRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753884267; c=relaxed/simple;
	bh=nZU05SYgwuxz9tXqf+2n4kG2ZxRFgsh3LY/Vsv1Amyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C/SzsjA3wlMDe51PfdAN1Fnjd1TbtxsfDxmUsEcgY2pcpQ3hEhFilPmEUm1xzAf2nCbYzploqaiKmcM2G4rem2sMbL8ilmUpxfRntWmcNNoOHQjbHk+fxImOpzFM+jy7Zipqnr/crDuwBkyW/PUCqS6aDFQtSpfaPP4kQ8QGDO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GP0fX2fT; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-45896cf24ebso5772565e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 07:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753884264; x=1754489064; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jk6Gtn926lXsIj4x4Dh1A7mGQexyVuqQFAqQu1Vz/9Y=;
        b=GP0fX2fThCo+QUvvVO00lJN+qe8vl5TFgrK3Xpk8vqL+HVZmw9sa0mofHBToGJwgjG
         bdkseuVtRNtOOIt/sEG2U+sFFFz2v4K8RIevJvOBZ2Eq8ivawkjruCwlAMJQ/EeRvmG+
         9IpmRlM0qsUlheO7CsEy47dri87oHrHZtiEwnl+uYMAFT44GzICOWXwC799VBYgYf3NU
         roL9RYmN3xcScWFf2t5TEaZl8nwI3jIOKmC2cDBHii7u+1j8ZXa+31X6LmAZGkRIP083
         VKJBp3dbhvXX8Dcnh5xYCCqeLE4rIMpBaUSOhM88NwIIEGIFc8Q729FI9CiCzbR5wfEn
         eN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753884264; x=1754489064;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jk6Gtn926lXsIj4x4Dh1A7mGQexyVuqQFAqQu1Vz/9Y=;
        b=XedJ171IB4WENP/a962290hnxc38J7dax9xqlugjXRUszaAtN0weaupzx9ucDgdSsH
         +FHySSHzMDe91CPN7Q3J5HrRz2y5aaJRVRDu0SEa7HkyvAH7KD2NIgMx2nGNebGKDy+b
         TqB166vfNiPzB8z7ynxMMlSL5OO42Sts0uxK2peYICZ8LKg8TRIMpBjBO3POaVRbUhF/
         LDXzgUpq766evB7scOjQVC7DQIbn7iDb8KwvisI0G63MiAzeBAa8Cy+YSx5vcWjkkyfR
         0RDSsSFnjWMdvwdvFVeYadv18aXpYASEi2QmVKh9XduSB5mCcAxq9Q1CgSZyHd+d8No+
         2GNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEfS1lV0TDTSwfZAEdkAgI9NclqZhvwnT7v6j+qwMIwWbaEBHnDoTsuXBZ97yMKYGAztN8ZJRiBqhWF+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfhbYm+GVavMF/w2pcGBgLJEp5axc6hSS210eNs2Sfc1aj7E8j
	GCzYkLJIx1DyzHQKN4+W7j8Uy1AzjYWfCBiMjdmTTzPuijfXx/MiF9EMsR6RD9WUwP4=
X-Gm-Gg: ASbGncv47vtgMKK3GTMtsI2vaA8LvP0mbQhs7gKGniH2MoTepahVdkuK7kyt3wD86dT
	RSFMBPI2+iL0BgLgJ7OyglyBk6iVWndq0AhNCR/CoMIPrGCA9eBYyKHKagneulGpApQ8PUT/kj/
	0tPMsTaz7Ztob9/l63CujBQjXX82cSL1No1zo0CrtCbZIW1yvUfbUutrU5ff/cpBlAFkiXjIfnE
	/P7jqRGZoElaJfZ2hggZJWOieSguZLYn/hIsvj5yjFZYNe1ZxYZp2Fnb/E4wJflmrjTu5wCOeor
	1PR+Di+I8tWcq9WnS1KjeK81EK/ARXSvskmDVFzcSTb8Drh9/AM4wVxfU+wkIuckn6i1Zd8Hyrv
	Xgigk/uHKS2+excDbvjGa4CpQYoo+N6ji3E/gknsV
X-Google-Smtp-Source: AGHT+IHNA6XybUky+XOgMeIdLaBli11kALj6z7ErPNCO0GKInoPJQDHw2ePlzrIieSLuzlwB0GbSLA==
X-Received: by 2002:a05:600c:630f:b0:456:18ca:68fd with SMTP id 5b1f17b1804b1-45898a828a3mr27912095e9.10.1753884263659;
        Wed, 30 Jul 2025 07:04:23 -0700 (PDT)
Received: from [192.168.0.33] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b788f5f255sm10023729f8f.13.2025.07.30.07.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 07:04:23 -0700 (PDT)
Message-ID: <9843578b-2adb-4f6f-b3c1-99dac003e2bf@linaro.org>
Date: Wed, 30 Jul 2025 17:04:22 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v2 16/29] mm/show_mem: Annotate static information
 into Kmemdump
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, tglx@linutronix.de, andersson@kernel.org,
 pmladek@suse.com
Cc: linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 corbet@lwn.net, mojha@qti.qualcomm.com, rostedt@goodmis.org,
 jonechou@google.com, tudor.ambarus@linaro.org
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
 <20250724135512.518487-17-eugen.hristev@linaro.org>
 <7ecaae9e-a088-4c1b-9caf-6a006a756544@redhat.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <7ecaae9e-a088-4c1b-9caf-6a006a756544@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/30/25 16:55, David Hildenbrand wrote:
> On 24.07.25 15:54, Eugen Hristev wrote:
>> Annotate vital static information into kmemdump:
>>   - _totalram_pages
>>
>> Information on these variables is stored into dedicated kmemdump section.
>>
>> Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
>> ---
>>   mm/show_mem.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/mm/show_mem.c b/mm/show_mem.c
>> index 41999e94a56d..93a5dc041ae1 100644
>> --- a/mm/show_mem.c
>> +++ b/mm/show_mem.c
>> @@ -14,12 +14,14 @@
>>   #include <linux/mmzone.h>
>>   #include <linux/swap.h>
>>   #include <linux/vmstat.h>
>> +#include <linux/kmemdump.h>
>>   
>>   #include "internal.h"
>>   #include "swap.h"
>>   
>>   atomic_long_t _totalram_pages __read_mostly;
>>   EXPORT_SYMBOL(_totalram_pages);
>> +KMEMDUMP_VAR_CORE(_totalram_pages, sizeof(_totalram_pages));
> 
> Tagging these variables that way is really rather ... controversial.
> 
> As these are exported globals, isn't there a way to have a list of what 
> to include and what not somewhere else?
> 
> Not sure if any of that would win a beauty price, though.
> 

Annotating the variable was suggested here :

https://lore.kernel.org/lkml/87h61wn2qq.ffs@tglx/

It does not win a beauty prize but it's simple and efficient at least.
Do you think it would be better to gather all the annotations for the
globals in a single place ?

Eugen

