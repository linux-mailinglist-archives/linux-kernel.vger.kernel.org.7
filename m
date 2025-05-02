Return-Path: <linux-kernel+bounces-629364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E88EAA6B72
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 09:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A72D93AF116
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 07:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967CB21A94F;
	Fri,  2 May 2025 07:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZX+mt2V5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E9217B421
	for <linux-kernel@vger.kernel.org>; Fri,  2 May 2025 07:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746170328; cv=none; b=THSD/EQHYw68YAeikG08YvUxwX3e8y2phTaDzHKimB0jCrtILecimaJxRgk5nxlsanvhvcG7DidAISs4jx3ebs8kXiZxKWUvMVlR2POJc+7GRGuIJNHhazqv35bEAJLp8QpNQw04zy0otsniZ+L7URm9mhG6Bib/m0n7Da7jDsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746170328; c=relaxed/simple;
	bh=NIeowkEGbpanNrkPcWML6l4OVL9Lyc4Zb3yOLxJlazU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nLO0od+kG3PbbDzpOqfBATailIsg87KOnlQKysy0QIcIxFxpm9VJ1RZC/DeheMRSKrirAc27mkNxWutIDRoDhxSZNn6ie7UgU3LalwT07nq+EdO3EpMVXkAvh9sgPFq6J4N/ds6leyT8oQ7Ul+4zX/M36GByTwaVBdm+PlpvN4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZX+mt2V5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746170325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WvVwxa/l0Dpro0/sAgCe/uKQ25ooLoIul7E/bG/CZSA=;
	b=ZX+mt2V55iCOxdF0asN5aPU/VH+R+/j8Xh/5GMzeJZc/Qr10/WFj8+vCfVYwagzDoHxL+D
	suQvQhAS1Huydm/7Q6wotbM4pwjBB1EspU7jQPpXY40UKaK8YRXmIrp55qlMfSg+DyRIK9
	r+44YUYJeQ1xjks1g3WJtro+kHw2m2k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-qP-VVDssM5yc5q-ubtUN9g-1; Fri, 02 May 2025 03:18:44 -0400
X-MC-Unique: qP-VVDssM5yc5q-ubtUN9g-1
X-Mimecast-MFC-AGG-ID: qP-VVDssM5yc5q-ubtUN9g_1746170323
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3912fe32a30so517984f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 May 2025 00:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746170323; x=1746775123;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WvVwxa/l0Dpro0/sAgCe/uKQ25ooLoIul7E/bG/CZSA=;
        b=WMv9L2VNXcy+cdhbcOml0OsjTpaoRE0IFrr9T4Fu+S1LnEg+sDBgEfyIVuJftVlaq+
         C/1TMEsECzxsypAoyTHyIqBfnIb6M/gadhwgXtdj3SKER8Z+5OCewFh3fa5w5SUZRcFO
         Q+MGSjL2rzvqotw2SCd4zPyPJvnTnrAhlIE0qj2lj9bozTm3CYDplbPxj8wK9G/KQnNR
         K8FZ4fS4xsGqeYfONWKQucZ/UJLWWrYa/c2q5PBspq6RmG1ap33SQXhXe5OSVd/wu5wf
         emxRaJNjwPatwl1Hx62PuoQLEp4mFE1r7frd87dYXqPtg2s8+yOu/VZAOWUQwGIlU+BO
         3GoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ4vH+TIWX9+9hkXs9QYO+i2tyz4vAWvzPWeIZJMw7T1jCMbPZBzYQIpD0rQ5+fOthoC5I1MRi+pKq5Zc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5I8odlHggJOkq9TMYxZcPlCUl5Ca3DHG7Nfpr9Dm6HLQCpSVF
	MDOATXI/lVbAmti5tTpHir1ZargeQ/bydAVif3SJvr2err1t8MYh9rYMOIwlgMkIixeYQK95757
	3Q9ipxYG7extpT9N7nV9qRPirXLEdM0RavR4XQYGfv/PBwj8a3cqHdBjlTobVNg==
X-Gm-Gg: ASbGncvFZw9py1TpCzvfv+U0omw2Hzl6aEwTDx7LcCsW40S4V9knFsqoEb8CgnlN3sh
	xGuUNWBSDNiLwnW9ZtIRw5oHP02kfNrbiWCbP/YRc8XY+7+9WNwlwuxuo8dK63OUu93sdAoi4RW
	h6gQzCuPc+kZ4BxDq8/PCxm9MZZc0rH5wa+/4Er0sG2CMcfIcsSkBQgDggwnhEFCByWzwRG74kn
	OmL8pTNeQiBYeXhmZD+qwWXUvY6wkJLPHiLKIteEYspS5Ppg+jlz/IIOEmDJWp4YvvFa4OTi1pa
	d8xZPI4WUgwU0dp4MQUSdkSYNfP/L2WuEWQh/mYwIZnu6CTthuqZXDI0HRVaKNzUT6/pZh6061/
	K9xuRSyJ0QkEdEXakfpmxRe2lQ7TKVA9A+6SuHaM=
X-Received: by 2002:a05:6000:420f:b0:3a0:7139:d178 with SMTP id ffacd0b85a97d-3a099aef9c0mr971156f8f.51.1746170323350;
        Fri, 02 May 2025 00:18:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyRMNgoo6YPSxUQFUuMJW5ewbRCwkZNmCBDuHOusZvSz6tTMPNpdjOI6X6GDT8vuzy7+l7EA==
X-Received: by 2002:a05:6000:420f:b0:3a0:7139:d178 with SMTP id ffacd0b85a97d-3a099aef9c0mr971132f8f.51.1746170322963;
        Fri, 02 May 2025 00:18:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c713:d600:afc5:4312:176f:3fb0? (p200300cbc713d600afc54312176f3fb0.dip0.t-ipconnect.de. [2003:cb:c713:d600:afc5:4312:176f:3fb0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae338bsm1299223f8f.27.2025.05.02.00.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 00:18:42 -0700 (PDT)
Message-ID: <72978e3a-ee67-47d4-b06d-e911bc5d57ff@redhat.com>
Date: Fri, 2 May 2025 09:18:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Re: [PATCH v3 3/6] mm: shmem: add large folio
 support for tmpfs
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Daniel Gomez <da.gomez@kernel.org>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org,
 wangkefeng.wang@huawei.com, 21cnbao@gmail.com, ryan.roberts@arm.com,
 ioworker0@gmail.com, da.gomez@samsung.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
 intel-gfx@lists.freedesktop.org, Eero Tamminen <eero.t.tamminen@intel.com>
References: <cover.1732779148.git.baolin.wang@linux.alibaba.com>
 <035bf55fbdebeff65f5cb2cdb9907b7d632c3228.1732779148.git.baolin.wang@linux.alibaba.com>
 <aBEP-6iFhIC87zmb@intel.com>
 <ac8cbd8d-44e9-4a88-b88b-e29e9f30a2fd@linux.alibaba.com>
 <aBIHYqzar5J8uxGO@intel.com>
 <cxwpgygobg6wleoeezbowjhmid4mdhptzheqask44ew37h2q24@kryzkecuobbp>
 <57dc4929-268b-4f3f-a0f8-43d6ec85974f@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <57dc4929-268b-4f3f-a0f8-43d6ec85974f@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02.05.25 03:02, Baolin Wang wrote:
> 
> 
> On 2025/4/30 21:24, Daniel Gomez wrote:
>> On Wed, Apr 30, 2025 at 02:20:02PM +0100, Ville Syrjälä wrote:
>>> On Wed, Apr 30, 2025 at 02:32:39PM +0800, Baolin Wang wrote:
>>>> On 2025/4/30 01:44, Ville Syrjälä wrote:
>>>>> On Thu, Nov 28, 2024 at 03:40:41PM +0800, Baolin Wang wrote:
>>>>> Hi,
>>>>>
>>>>> This causes a huge regression in Intel iGPU texturing performance.
>>>>
>>>> Unfortunately, I don't have such platform to test it.
>>>>
>>>>>
>>>>> I haven't had time to look at this in detail, but presumably the
>>>>> problem is that we're no longer getting huge pages from our
>>>>> private tmpfs mount (done in i915_gemfs_init()).
>>>>
>>>> IIUC, the i915 driver still limits the maximum write size to PAGE_SIZE
>>>> in the shmem_pwrite(),
>>>
>>> pwrite is just one random way to write to objects, and probably
>>> not something that's even used by current Mesa.
>>>
>>>> which prevents tmpfs from allocating large
>>>> folios. As mentioned in the comments below, tmpfs like other file
>>>> systems that support large folios, will allow getting a highest order
>>>> hint based on the size of the write and fallocate paths, and then will
>>>> attempt each allowable huge order.
>>>>
>>>> Therefore, I think the shmem_pwrite() function should be changed to
>>>> remove the limitation that the write size cannot exceed PAGE_SIZE.
>>
>> To enable mTHP on tmpfs, the necessary knobs must first be enabled in sysfs
>> as they are not enabled by default IIRC (only THP, PMD level). Ville, I
>> see i915_gemfs the huge=within_size mount option is passed. Can you confirm
>> if /sys/kernel/mm/transparent_hugepage/hugepages-*/enabled are also marked as
>> 'always' when the regression is found?
> 
> The tmpfs mount will not be controlled by
> '/sys/kernel/mm/transparent_hugepage/hugepages-*Kb/enabled' (except for
> the debugging options 'deny' and 'force').

Right, IIRC as requested by Willy, it should behave like other FSes 
where there is no control over the folio size to be used.

-- 
Cheers,

David / dhildenb


