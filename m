Return-Path: <linux-kernel+bounces-813594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD04DB54816
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CD4F3A6039
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADFE288CA6;
	Fri, 12 Sep 2025 09:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DVY9SEPw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E700284681
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757669785; cv=none; b=qOhKwodigvw/etqb3XRy1BpDdXJgNK52m7GgtMZGPDOF79nzDOGA+6XRdHSz/hHWNjsuwjYE9dWlRlkAiv24xVOzOXTz+YHNRqZ7CKoyQseNmuXZeihCkuAqItRBlkQWYsdQvMK0vRzHeLVJt5TsvaCWrOxgjMFZfFYsdZudmTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757669785; c=relaxed/simple;
	bh=YVpEMtUPBfI0kSglK1+tG/cRaueTcLeBcBexxPbUDjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XsjthcbR/5OVIqGVbjIru5ooQY3+qShxwfN8fvQDFXhk8RHWyzUePMqcIp3Fwj8o4c8IwiVapX0eh95+IvC1k1J0cfFd1mFuLkwrRMZOuiSrbxkk3aYYDj40eFmyzeFGDnR9GE7/kPLAqr8aYWO/BQVxjvCnUR/3YyNinmFPkdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DVY9SEPw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757669782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=B4KJZdY1MD+iAN7yxyMGS4DtOSEdOr2LuczyAdAae4g=;
	b=DVY9SEPwFGTmzT6ffJylpI0tLbpzffjtOX8j/p4kgQjztrVNrg96cutieXGnISmxALvMny
	vYzXURzuPrv5L4e2GYgwqE6St2zDLNJ7eFD5q81W4Df0TKdR0yyaH2tkTo5Mkl2ii6Ry2b
	YIfbYXfl94mFp20pt+h2RLHt53B1JWk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-o3RZdu8tMvS1snVqU3nzDA-1; Fri, 12 Sep 2025 05:36:21 -0400
X-MC-Unique: o3RZdu8tMvS1snVqU3nzDA-1
X-Mimecast-MFC-AGG-ID: o3RZdu8tMvS1snVqU3nzDA_1757669780
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3e4a8e6df10so1035131f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757669780; x=1758274580;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B4KJZdY1MD+iAN7yxyMGS4DtOSEdOr2LuczyAdAae4g=;
        b=jWt9jJTXqzhdXwDfzjNAT2aLUHtg0EJWsr8tLD48ZBw4TzqJtB2sjrR4pEvYWH5zK4
         3xRyYIkcHVgT4JtVdq0SDd1gfcCOZzleBwA7oYh/bxrnQQnyrd6e4db33VJ145NaiaJm
         o2z7nMZah2xOBp8rA/citTRsFv31zLxh7ix3HY2OFivh5P57dIrLm0K4Q8NBDt/Mv2/t
         MsQdHKCoCabKRnuymwrruOVZih0RjxUqiNMwxOVGAEOa8cOd9ZuajNtTyaRKfH+ldsI5
         f+UdEnElKXFh5+CIxnUfVBmrNz+l/nrCotcrQDhphKwPmRaa+VnJ1sb3hL8hw6yDYf86
         PMfg==
X-Forwarded-Encrypted: i=1; AJvYcCXJORWmmzgOCgHCwxtOEKNhX66j4TqPgwdPNhtDCYpIhXhaFwNWVMdDtZzAnYVZxlYMGuHomosA09FvPdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzoSLxyw6I8E4o/dyP1aw9e6O9CV04YXweZOmBBoBqazDDghZr
	Va3qXBmvqWy7PXPvY9LNoca30uLDwdNmqIs14xlWl7Ev6lI34pq08VX3RDXAExHN+ayJWZjqRkY
	BKF2VmFYC+KtqPf6XyfPYNjV+UNxN4nBonLlvwNTMShGdlfS0VZU4LndH96ruWMXBHw==
X-Gm-Gg: ASbGncv/stIGhg86Iiz9SxXXyp1Go2eY2ktk+dbXQds2ZXaCsSqdJGiRC/kCtE/+ha2
	gJbWpWF66bLEoZ6qr1HX4255DXSMVksW4kq0kiKZLa+0oQYY20DM1VA25HhxhIQrhG8MtvRXNjZ
	C0Ukn+V2vwZ+7gKT3GpuaGHr/ueyFsj8FgG7Lq7YIxcDDjMkg18BUS7so34M3COE2ke6WH8YVKr
	4xPPLxCiRLtELhdvH5YwbkR2J/hhhVmTKq15tmtOHE82TZIXZvgCCHU/fUvZU42curQVedzkqLK
	F0P1OkOEqjsNyF3wgrR4NLUqR2o9ohpGxnWE690jH+du/1bfnIsXRGnMCp0ouZftSWb0e00hAMW
	ZY/b+P4XCpDqqGK1/T9UMQrRvBhpovVxHG8m/emLhDp1ZAkvm8paUrlqYgZUQYfVvj4A=
X-Received: by 2002:a05:6000:2410:b0:3e4:64b0:a75d with SMTP id ffacd0b85a97d-3e7659db640mr1861330f8f.30.1757669779715;
        Fri, 12 Sep 2025 02:36:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEffTnkjpwSgdIokrJRdi0r1dJ0It77LZ+hWwe5tws1dme1LH9tLiMm17T34HzdwjxEeiy8uw==
X-Received: by 2002:a05:6000:2410:b0:3e4:64b0:a75d with SMTP id ffacd0b85a97d-3e7659db640mr1861304f8f.30.1757669779279;
        Fri, 12 Sep 2025 02:36:19 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:da00:b70a:d502:3b51:1f2d? (p200300d82f20da00b70ad5023b511f2d.dip0.t-ipconnect.de. [2003:d8:2f20:da00:b70a:d502:3b51:1f2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607e2fd7sm5942242f8f.63.2025.09.12.02.36.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 02:36:18 -0700 (PDT)
Message-ID: <37816bb5-97f8-4c05-84ed-9a81cfc5c755@redhat.com>
Date: Fri, 12 Sep 2025 11:36:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] resource: Improve child resource handling in
 release_mem_region_adjustable()
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>,
 linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>
References: <20250911140004.2241566-1-sumanthk@linux.ibm.com>
 <0ab2cb14-ba8e-4436-b03d-9457137f492a@redhat.com>
 <aMPluIk8EnOuIWbi@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aMPluIk8EnOuIWbi@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> 
> Hi David,

Hi!

> 
> I am working on the item related to the last discussion -  dynamic
> runtime (de)configuration of memory on s390:
> https://lore.kernel.org/all/aCx-SJdHd-3Z12af@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com/
> 
> I came across the problem when I tried to offline and remove the memory
> via /sys/firmware/memory interface.

Ah, that makes sense. Sorry that I didn't immediately connect the dots 
when seeing your name.

> 
> I have also modified lsmem (not yet upstream) to list deconfigured
> memory, which currently appears as offline. An additional "configured"
> column is also introduced to show the configuration state, but it is not
> displayed here yet (without --output-all).

Worth mentioning in the patch description, otherwise it's confusing.

> 
>>> 0x0000000150000000-0x0000000157ffffff  128M offline               42
> 
> True, this will not be shown with the master lsmem, since the sysfs
> entry is removed after deconfiguration.
> 
>> Do we need a Fixes: and CC stable?
> 
> It will reference commit 825f787bb496 ("resource: add
> release_mem_region_adjustable()"). Since the commit already states
> "enhance this logic when necessary," I did not add a Fixes tag.

So if this cannot be triggered yet, all good and no need for Fixes:.

I was assuming that maybe this can be triggered with ppc dlpar, so I was 
concerned.

> 
>>> Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
>>> ---
>>>    kernel/resource.c | 44 +++++++++++++++++++++++++++++++++++++++-----
>>>    1 file changed, 39 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/kernel/resource.c b/kernel/resource.c
>>> index f9bb5481501a..c329b8a4aa2f 100644
>>> --- a/kernel/resource.c
>>> +++ b/kernel/resource.c
>>> @@ -1388,6 +1388,41 @@ void __release_region(struct resource *parent, resource_size_t start,
>>>    EXPORT_SYMBOL(__release_region);
>>>    #ifdef CONFIG_MEMORY_HOTREMOVE
>>> +static void append_child_to_parent(struct resource *new_parent, struct resource *new_child)
>>> +{
>>> +	struct resource *child;
>>> +
>>> +	child = new_parent->child;
>>> +	if (child) {
>>> +		while (child->sibling)
>>> +			child = child->sibling;
>>> +		child->sibling = new_child;
>>
>> Shouldn't we take care of the address ordering here? I guess this works
>> because we process them in left-to-right (lowest-to-highest) address.
> 
> __request_resource() adds the child resources in the increasing order.
> With that, we dont need to check the ordering again here.  True, here we
> process the child resources from lowest to highest address.
> 
>>> +	} else {
>>> +		new_parent->child = new_child;
>>> +	}
>>> +	new_child->parent = new_parent;
>>> +	new_child->sibling = NULL;
>>> +}
>>> +
>>> +static void move_children_to_parent(struct resource *old_parent,
>>> +				    struct resource *new_parent,
>>> +				    resource_size_t split_addr)
>>
>> I'd call this "reparent_child_resources". But actually the function is
>> weird. Because you only reparents some resources from old to now.
>>
>> Two questions:
>>
>> a) Is split_addr really required. Couldn't we derive that from "old_parent"
> 
> old_parent->end points to old end range before the split, so I think it
> doesnt tell where the split boundary is, until __adjust_resource() is
> called. Hence, split_addr was added.

Makes sense, that's also where the sanity checks happen.

Worth throwing in a comment for the function telling that lower was not 
adjusted yet.

-- 
Cheers

David / dhildenb


