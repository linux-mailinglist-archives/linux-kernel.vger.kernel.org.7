Return-Path: <linux-kernel+bounces-886940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EE2C37017
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5F11624C19
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3790732E13D;
	Wed,  5 Nov 2025 16:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+rOhbrv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ke1Yvf6t"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99463271E9
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762360748; cv=none; b=mJK+znPqzxkh2Y/QJdOQWFGDqI0M6i0T0x7YrMtkLRDYsnSJTMZAX7OvhyFRWjQRRy/SjwxBnkTXoFquQbDFiWQw03RIOMiuE6HYtix0JRK8UzognAJr/jFjIXy4BHB6mg05l5VH0WINn1TmL6ca6LTfFGqy++xAbWaihWfrRpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762360748; c=relaxed/simple;
	bh=vLBraTI6rz3ehteTYXuZDN6G+xGvXqdX47LCRqe+UJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cP3L3MpyiPMkO8EcuIaYZIknVmhC5FExKf6GomtMiz/Sd464dvrRRWfWeE/zJrOxBJravGjwmPG8hU+EI3+plAfECpCNGtmpT1cHcH3Pt7TVCnAMlj75sGzFsp0mDA0pdpvIAH+hzTLfvnVRf3Ptv9dZ0Z0nMngftJtV9XX8aAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A+rOhbrv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ke1Yvf6t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762360745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5DDwUEanHIf5XFFvGb0OEC6nQuQQ0S85vv2/8gZzaqA=;
	b=A+rOhbrv29XjS/gTBK72bVMCflf09UMf6E6wd/wr/qUmJV8u3b1M0UWQkPdWMqioejl51r
	R9U+ChCDjGp+a/ljVzV3Ysc0B+Nsa0XyubCnqDGGoK7Itcki1FsbJqQiFXfI04OhTU8MLU
	/1Xod/WVSbQlfc9d+aQwQHiZEm1kRuw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-ygTfPKMNMeO6a1WY293P0w-1; Wed, 05 Nov 2025 11:39:04 -0500
X-MC-Unique: ygTfPKMNMeO6a1WY293P0w-1
X-Mimecast-MFC-AGG-ID: ygTfPKMNMeO6a1WY293P0w_1762360743
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-429cd1d0d98so17321f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762360743; x=1762965543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5DDwUEanHIf5XFFvGb0OEC6nQuQQ0S85vv2/8gZzaqA=;
        b=ke1Yvf6tLd4l6FE6x17wMxPi46NlFH5MNvI3lcFcLWJnWVQxOg6Hjd+E4for0hK8gg
         EPZpqZtEbrLFPnCkcaWLdrFUOD2SDe+EP/TbQm8rLLoFGSq0WZ1nK3NQpf3Q7qh3h7PY
         zvvzVuk/n0REqR1NsUJcI0agmRnIAIEWSEeLBxuIGMaNEUsjNNQ1wWa2zVx5IM07/ggH
         OGAndIiHw1+E4JNTddtID/r3xsnH0BeeptcQCPXpiEC23VnQ99H0xp5yOkapRK6QuEbi
         +g4fxLVtsf3y+6+XFNAUar6TDf4dGql1epIditX7EkCUZttdvHVdFxbbFBHazaVeHoko
         cCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762360743; x=1762965543;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5DDwUEanHIf5XFFvGb0OEC6nQuQQ0S85vv2/8gZzaqA=;
        b=mCICK/LRvNUPHldECL/1uXZr/NR3U8OaxaI1EoUbJdM8+BMfdWqHdTOOG83IZdhLIL
         GMG7/2eVGk7DCWDR8uFsB+0JJQzTImizOfi9xxROGsV4bTah4JQ/jyRHt+vHVAwAZzd7
         D0ba3a5jTme+SXUtCQ0uSBN13MTpt8FSunQVGiPNGC+ylt6F0EXTtId2Htak3sO5aSuk
         CzUeXyXpSq9iyysme+FzH5C6OFX4EGBxca4yOe8uIAYKgMMk6ZxM9RyfZPvz9+9o9pEy
         6pEG5aaJwxro2nJWWqQbmgxXLDGMJeFA55omMK13VxNm0s7bur2bt3RM2yoCn6CSrHWy
         kTGw==
X-Forwarded-Encrypted: i=1; AJvYcCVzAS8BRm5D01zRT0zY1Kx28oS1u6Q/nS1HxZTWFqjmzE2x2i3vo8OpnWCnuGEy+n/ynCEP7MBv4PqmnkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJZ70bMrkYiSAfCjvsiDSbbEGpQ87Lom2Q57ZshZgFOCOdIajy
	Qz2WyzTRNLjoXuAYIvSQnQOEjeg23/zQc3OzzhzDWaWz5qJVxftTNjxW2H+OWhCXRU+0MhjDpoV
	F7q6Wm8CbddRuL/dUqbzl38qfxheJOqEHTvvM7bVovIa9D8zMUzdM9w5/TqqpO7IpEg==
X-Gm-Gg: ASbGnctcTe/+SEBe25jYAYo+zkf1xyNReqwToEzTmCus51/ZPGloF7vlaNHRDDYWqzU
	rM01wC4C+ef1O++U/KYVSmrD1W+V0P92nOQ8h5qMTMXwzDJENXE5zdnKCY/L2KttN0MhBF8WDIX
	khLLkGAoK/4R+aVrsk4rjQKWByYBSQkOWYLiffJlIUpemxKVURqFb78t3k97pwcPHnuHvYQ/TWp
	IruozzxnEWA+xi28K2knsCqHojwMgxNxcTQL7Mz8kZVC+aKMNuXuQraa3W69vMl85KX8DSZJxo8
	ZtIdyTdkbIWhYJoyartOvG874+q6iSP0lSwD6telPv9I+w1pDFSgDTuVyWBG9DyvwK/xZeFS3j7
	AcKY/ymeVf+cIiHz2F9wQI1z36KNEiPvHnllGnhd5BciDm2OAWZ7DxOdnMwuu5IH9kt4nI++rRW
	uKMUlMEkdwQnji/1x4/ele2Y0=
X-Received: by 2002:a05:6000:144e:b0:429:cf03:8b1a with SMTP id ffacd0b85a97d-429e3309cbemr3444646f8f.45.1762360742894;
        Wed, 05 Nov 2025 08:39:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuh/61JxchnbvDD3t9otzAnckg9PYa/U28Sk++DnkiTdkTuxAxX+B0W7YZV5+JgZgZiAf29Q==
X-Received: by 2002:a05:6000:144e:b0:429:cf03:8b1a with SMTP id ffacd0b85a97d-429e3309cbemr3444613f8f.45.1762360742399;
        Wed, 05 Nov 2025 08:39:02 -0800 (PST)
Received: from ?IPV6:2003:d8:2f30:b00:cea9:dee:d607:41d? (p200300d82f300b00cea90deed607041d.dip0.t-ipconnect.de. [2003:d8:2f30:b00:cea9:dee:d607:41d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc18f40bsm11263373f8f.1.2025.11.05.08.39.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 08:39:01 -0800 (PST)
Message-ID: <547b6ad3-fb62-4549-b1e9-8bbfb246fbd4@redhat.com>
Date: Wed, 5 Nov 2025 17:39:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] mm/hugetlb: refactor sysfs/sysctl interfaces
To: Oscar Salvador <osalvador@suse.de>, Hui Zhu <hui.zhu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Hui Zhu <zhuhui@kylinos.cn>
References: <cover.1762310125.git.zhuhui@kylinos.cn>
 <aQtcMkivdFHbW2lK@localhost.localdomain>
From: David Hildenbrand <dhildenb@redhat.com>
Content-Language: en-US
In-Reply-To: <aQtcMkivdFHbW2lK@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.11.25 15:16, Oscar Salvador wrote:
> On Wed, Nov 05, 2025 at 10:42:42AM +0800, Hui Zhu wrote:
>> From: Hui Zhu <zhuhui@kylinos.cn>
>>
>> The hugetlb.c file has grown significantly and become difficult to
>> maintain. This patch series extracts the sysfs and sysctl interface
>> code into separate dedicated files to improve code organization.
>>
>> The refactoring includes:
>> - Patch 1: Extract sysfs interface into mm/hugetlb_sysfs.c
>> - Patch 2: Extract sysctl interface into mm/hugetlb_sysctl.c
>>
>> No functional changes are introduced in this series. The code is moved
>> as-is, with only minor formatting adjustments for code style
>> consistency. This should make future maintenance and enhancements to
>> the hugetlb subsystem easier.
>>
>> Testing: The patch series has been compile-tested and maintains the
>> same functionality as the original code.
>>
>> Changelog:
>> v4:
>> According to the comments of David Hildenbrand, add copyright of
>> hugetlb.c to hugetlb_internal.h, hugetlb_sysctl.c and hugetlb_sysfs.c.
>> v3:
>> According to the comments of SeongJae Park, updated MAINTAINERS to
>> add new files.
>> Removed the wrong copyright in hugetlb_internal.h.
>> v2:
>> According to the comments of David Hildenbrand, removed the wrong
>> copyright in the file headers.
>>
>> Hui Zhu (2):
>>    mm/hugetlb: extract sysfs into hugetlb_sysfs.c
>>    mm/hugetlb: extract sysctl into hugetlb_sysctl.c
> 
> I am replying here as a response to https://lore.kernel.org/linux-mm/58d3c50f-2b4a-4053-a846-613434d5bcd9@redhat.com/T/#mf694af3f5a6ca56b76adf66352cbb88d022fe36c
> 
> So, taking a look at patch#1 as an example,which moves sysfs stuff into hugetlb_sysfs.c.
> I have the feeling we are moving too much stuff. It is true that drawing a line
> is not easy, but e.g: you mention
> 
> The following components are moved to mm/hugetlb_sysfs.c:
> - hugetlb page demote functions (demote_free_hugetlb_folios,
>    demote_pool_huge_page)
> 
> I __think__ that moving demote_store() into hugetlb_sysfs.c is fine, but although
> demote_pool_huge_page and demote_free_hugetlb_folios are only called from there,
> they look more than a sysfs interface and more like hugetlb generic code.
> 
> Again, drawing a like might be difficult, but I think that e.g: we should only move
> sysfs entry points functions into hugetlb_sysfs.c

That matches my comments from [1], right?


[1] 
https://lore.kernel.org/linux-mm/58d3c50f-2b4a-4053-a846-613434d5bcd9@redhat.com/T/#mda7f5c2ea07233857af094367b573475011bf0d4

-- 
Cheers

David


