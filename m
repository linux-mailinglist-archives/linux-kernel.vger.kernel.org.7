Return-Path: <linux-kernel+bounces-747722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5E3B1374A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5B21178EC7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABA821CC49;
	Mon, 28 Jul 2025 09:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RvaByBga"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB0A1581EE
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753693857; cv=none; b=hCwJv8bnue8U52LoO4XDZ21KDXsPJ0leVvE7yrsJxeaYPDK75tkRUIFUWXgD7/sRjvsd+YFZ8l69dPTAQqnNHohr7SRcCJRjHqqlAy6zPy67CrhBleawIj4MHNwYBF2bFxJZN/qlZDfM9GewIkivExTgOkS67zXiuxApRcl51tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753693857; c=relaxed/simple;
	bh=2JbtmhQK1sEUlITV+i9TxB7G8WlDd1BwPXQzgYTrwB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ij15VxNJgpy6fVcX4a3TA0Hjb+63PNaY8CCrIIRgUrj5h3GTE2aklW8GVgSBS883HsH6maX6kj1Xbagm+2U/+OGsOBYJkGJm+d5PX7kvw8W4FB9/5BqZrqZ1tnETxLUGsH+FRHRI+VBRGsdENQ3/Gr0UOlGeRlM2XY1x//1K8SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RvaByBga; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753693855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VnIU+p1vADjcsZojWJn5Yv3hV3lAOB3Vh76xjsPZ41I=;
	b=RvaByBgasfJNRo5CY4Og0GHbNIjbPAYrBgzI9Xa8boX7oA7e3Z0wSWq18azb+lIEW6jZU1
	rQ2VK8dqWEddxkCjGF2cRWCd71o9kQCMzsobjVp8B6cD/5MR+tb1Ov6nggpIA81idZtmBm
	77WXqaP0NdyDyWOFKC6wXeEitm++chw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-jOz7eqfQNr2V7p68p6sDYw-1; Mon, 28 Jul 2025 05:10:48 -0400
X-MC-Unique: jOz7eqfQNr2V7p68p6sDYw-1
X-Mimecast-MFC-AGG-ID: jOz7eqfQNr2V7p68p6sDYw_1753693847
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b78c983014so7162f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 02:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753693847; x=1754298647;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VnIU+p1vADjcsZojWJn5Yv3hV3lAOB3Vh76xjsPZ41I=;
        b=rpdPLiRiu6FVbULE9a+AYVoRHekks9F2/J3VfEEArSTCvLPDjB/uFEgyT62Z9vfnI1
         eBlbp38q4jzi6vhrH2P2GYzhiFMb7aV0UeWbUCJTVbkNq8Q0Kg7mVVlzGGA3aHgz/a9S
         Qg2wyWXKd3JxyIvS812v3gZnlaf66cAb8vDBN00BYQEz7nvDP3UvtQpuIoXplG2FXcXZ
         +7KwAmSa4lBXJiJYxijboGWRb1TTsAfDtkVhta7UoDGUhMXfYUHZG/0QVfjrlT9ayf7A
         tjOT/QqgE5vU8HeTUS7sU1oSkHAt7eqtmhE2yyxbvRixQRKkgVfY7jWUp7wRzKvU0+R6
         +CmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYf3waYffeIdUqwey0j+vPdqbTLTQGz2dVE2q3xvIu2jUQMVUx1YezcQByX5LJl0C5nfUQWrflp77U5Ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDTa518OQbHgyA+NPh+ssXbM1YutwNj4ATUzdS7le1NkBWhdap
	LigRVRUq9pr+jqzlN8PaLuxOaJJFasm2jzxhGFMdODk0nGCEf4EC2dV3PTRfXWAhlmwsbDZJ6vE
	AnEG9Ouh6pd0SJA2TemvJ+x3t+XIDIGqIdVM8MwZ+l4rVZSS5NUqK4Iy+JGXurVsW3g==
X-Gm-Gg: ASbGncsXJ3x/PGnoTSJroTpJ3Qt4b5N1onzNNBDUHTm83iboP2s2x0uOzLr3jxCfkqM
	SnCNFrvNkDw6RtTbRw/TUiaJeW0ieJyk/fkwFf+oDkatE+DnfKp7SPT5lj5GaS2CFKD3lY03zyL
	2ZFYQhYaonnvBZ6t2y46FAtZH7NmqZZZlTbiWE5ncsv1or8YN0qwCIaDq45X4gjB327nBrHv8s2
	8sKXqzCyjM7Tf2AXJLX46y+sqE/u5wkCTHvaL4nD35TNgY8uf+89eShafovzUqN2Lb2YXdteF5B
	Su1OZeTwFlflXqGJceKXPSyOdgDO5341PAgsZ6FmBC1Ue3q4zSJ77YLFnp0jf4RMcyePKpGWDZV
	eIVrnTpGzIU1Y0Qb/cxvmo+SD/hZtvk+xEs31Ku+MQJFJM+xuu/IyHnHdx35++ribeYQ=
X-Received: by 2002:a05:6000:3107:b0:3b6:13a0:bb20 with SMTP id ffacd0b85a97d-3b77675daf5mr8553824f8f.35.1753693846875;
        Mon, 28 Jul 2025 02:10:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEazl7CS1NCDJ3qvW/s97bvrfSXmYjKBUMzcWrCBBaAi+pylS/P8t5QGt4045/NplxWthVSUQ==
X-Received: by 2002:a05:6000:3107:b0:3b6:13a0:bb20 with SMTP id ffacd0b85a97d-3b77675daf5mr8553791f8f.35.1753693846252;
        Mon, 28 Jul 2025 02:10:46 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f47:2b00:c5f3:4053:2918:d17c? (p200300d82f472b00c5f340532918d17c.dip0.t-ipconnect.de. [2003:d8:2f47:2b00:c5f3:4053:2918:d17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b783ca028dsm4899301f8f.51.2025.07.28.02.10.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 02:10:45 -0700 (PDT)
Message-ID: <79919ace-9cd2-4600-9615-6dc26ba19e19@redhat.com>
Date: Mon, 28 Jul 2025 11:10:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Disable auto_movable_ratio for selfhosted memmap
To: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Hannes Reinecke <hare@kernel.org>
References: <aIcxs2nk3RNWWbD6@localhost.localdomain>
 <aIc5XxgkbAwF6wqE@tiehlicka>
 <2f24e725-cddb-41c5-ba87-783930efb2aa@redhat.com>
 <aIc9DQ1PwsbiOQwc@tiehlicka>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <aIc9DQ1PwsbiOQwc@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.07.25 11:04, Michal Hocko wrote:
> On Mon 28-07-25 10:53:08, David Hildenbrand wrote:
>> On 28.07.25 10:48, Michal Hocko wrote:
>>> On Mon 28-07-25 10:15:47, Oscar Salvador wrote:
>>>> Hi,
>>>>
>>>> Currently, we have several mechanisms to pick a zone for the new memory we are
>>>> onlining.
>>>> Eventually, we will land on zone_for_pfn_range() which will pick the zone.
>>>>
>>>> Two of these mechanisms are 'movable_node' and 'auto-movable' policy.
>>>> The former will put every single hotpluggled memory in ZONE_MOVABLE
>>>> (unless we can keep zones contiguous by not doing so), while the latter
>>>> will put it in ZONA_MOVABLE IFF we are within the established ratio
>>>> MOVABLE:KERNEL.
>>>>
>>>> It seems, the later doesn't play well with CXL memory where CXL cards hold really
>>>> large amounts of memory, making the ratio fail, and since CXL cards must be removed
>>>> as a unit, it can't be done if any memory block fell within
>>>> !ZONE_MOVABLE zone.
>>>
>>> I suspect this is just an example of how our existing memory hotplug
>>> interface based on memory blocks is just suoptimal and it doesn't fit
>>> new usecases. We should start thinking about how a new v2 api should
>>> look like. I am not sure how that should look like but I believe we
>>> should be able to express a "device" as whole rather than having a very
>>> loosely bound generic memblocks. Anyway this is likely for a longer
>>> discussion and a long term plan rather than addressing this particular
>>> issue.
>>
>> We have that concept with memory groups in the kernel already.
> 
> I must have missed that. I will have a look, thanks! Do we have any
> documentation for that? Memory group is an overloaded term in the
> kernel.

It's an internal concept so far, the grouping is not exposed to user space.

We have kerneldoc for e.g., "struct memory_group". E.g., from there

"A memory group logically groups memory blocks; each memory block 
belongs to at most one memory group. A memory group corresponds to a 
memory device, such as a DIMM or a NUMA node, which spans multiple 
memory blocks and might even span multiple non-contiguous physical 
memory ranges."

> 
>> In dax/kmem we register a static memory group. It will be considered one
>> union.
> 
> But we still do export those memory blocks and let udev or whoever act
> on those right? If that is the case then ....

Yes.

> 
> [...]
> 
>> daxctl wants to online memory itself. We want to keep that memory offline
>> from a kernel perspective and let daxctl handle it in this case.
>>
>> We have that problem in RHEL where we currently require user space to
>> disable udev rules so daxctl "can win".
> 
> ... this is the result. Those shouldn't really race. If udev is suppose
> to see the device then only in its entirity so regular memory block
> based onlining rules shouldn't even see that memory. Or am I completely
> missing the picture?

We can't break user space, which relies on individual memory blocks.

So udev or $whatever will right now see individual memory blocks. We 
could export the group id to user space if that is of any help, but at 
least for daxctl purposes, it will be sufficient to identify "oh, this 
was added by dax/kmem" (which we can obtain from /proc/iomem) and say 
"okay, I'll let user-space deal with it."

Having the whole thing exposed as a unit is not really solving any 
problems unless I am missing something important.

-- 
Cheers,

David / dhildenb


