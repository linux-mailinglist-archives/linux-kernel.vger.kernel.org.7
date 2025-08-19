Return-Path: <linux-kernel+bounces-776385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4B7B2CCC4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDF9B17F17F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707C626E708;
	Tue, 19 Aug 2025 19:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TcF0oO42"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C814E2F852
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 19:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755630527; cv=none; b=tubnsPhxQAgxh90nBXOfBxyz7GtYp0IuZudfbaIkL4vcKWbXiZQXvFIB69Y5yGJK6cfHPtdgKr82Rciu5+YeVVHqnPd8KTsHrbq9nbE1Ov0ZhBhxaTtnJigpwbvIKGXJsvVERIunVpssET48/LywOfpfiZ4uXzxZ1l5uR6REg9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755630527; c=relaxed/simple;
	bh=0mDx7AEoJYqa+BhkILOyTABBC//CuPUeHs4Xv+po9/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I+xMP2eOrXUO6q8lnQ1w8FmYfW0sU8RvmfD5xAHjS6l79mQybCjY10PhWVXDjPpYbwlKTW1FWtBw6eDKwRE8gd/RnpdMajK6vsIVEIpjxeblWd3u5s3UaPiJ498UXGhfF406v642O6rdc3c09c9O+CqL+7VY/saAAKTV1shzEs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TcF0oO42; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755630524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NVBphbulaafdV9POZPA6QMtZt5qejno98z8OzC7Nom8=;
	b=TcF0oO42LTzWfxAokBkviLPKxmjkQG0nEQjRouchnZTnhZ6H16+A2V/K6wiU8ka+jzFkRd
	Xh74YnHBvobUYRtE0ttFKJAs8sju6CWsZgxkr3AtblL228dHHlWVcBspEUOOqpeO4o1N1z
	piCaseo/87BIRnpAK1jm+VrUSNoodkQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-e6i6TQisM0qWyoqtiZjNUA-1; Tue, 19 Aug 2025 15:08:43 -0400
X-MC-Unique: e6i6TQisM0qWyoqtiZjNUA-1
X-Mimecast-MFC-AGG-ID: e6i6TQisM0qWyoqtiZjNUA_1755630522
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1ac1bf0dso1068455e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 12:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755630522; x=1756235322;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NVBphbulaafdV9POZPA6QMtZt5qejno98z8OzC7Nom8=;
        b=M4qiLRYhDFvoLl3qRHY2jRCGuv0esPV/b3eEU60W6oqejI2cu0PZQNtg+H3aVqM2D0
         GIa1dbqVhY4Vy7XpG0j5z8dnfwFFVc7JNuc9nF6fwVH1M4Xiz/UyNJ0fT1Ryox8lqKWk
         Q4iQELXlYRuEuUOWRoVKraP5bGDDYfSWqfuKX/Q5QTlG+Eq9U2eiVIiOIll27o7Xzogo
         8/3xF1IvpSiMPndwcMSJnpL/B85l1VGu0wD4jF3dTcCf/Dm/mQe3rujA+l44nVLHJHzt
         nRHNctZI2Uy+v+ZIP7FGXc3OqP9dSdEnnrIxqdl8rYUrMC5VND2Etcn2no/q0AkcNRS8
         hFYg==
X-Forwarded-Encrypted: i=1; AJvYcCUPW1eHyDnaKYXzdWp9QueU5V8dg5xZRQ+IkPhiLggsJZKkFNPHsTG9kLcF2nvJXTACJx/Ip41ypgn7ydc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGzjDHCZ1ikattf8idi6E5ZDe+udK5sSLthW9ztlEuuq5ngeaq
	dpsjHpcRMCqLH1qhGQxSzz0Xx2kUnuUvq9Naba0G6Kb8DIF5g6IK07D07EE9b+IULIg4zpRE6pz
	PokfmmFE7lAwctbNGnmr9Yf6HCPE6vxLIhsMVzL/D2pek9FFark17ev8fz/Rm5js5lA==
X-Gm-Gg: ASbGncvbAp6eS53Dxnd2m/3z9zCcWjzSzT1Wb1+Mx3fi3IKjQUKxS8dOHxl706/qvwz
	8gkhk15YVcvFq3PBWp3TUCscOz/Zk3kTqPT9dxAtL5W8JKoJIgOtxY6kDxihRzmLHyHP6n7iG52
	vL4HeoodS5GBKVQ+2M7nr53LjlhYKJL8b6YxjJsplsbr0fbDjGtBjsIJeqzNX3cL9XrcdWuyfjy
	TIZ74mUBSW7kHOiowLQ6kdm2/lSlZaH5l2MTrh73qfEwAbBSXuCYtTTaSLdNT/Hu4f4cXGR8I5/
	NWcmoR6ivAGcMWM47JJfJn5ob8Ch3X1dVjWT3H34rotQTt0nw1UkIp6yEJbCz8JtU9dV
X-Received: by 2002:a05:600c:630c:b0:458:d289:3e26 with SMTP id 5b1f17b1804b1-45b4741f876mr3645685e9.2.1755630522019;
        Tue, 19 Aug 2025 12:08:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVsEVqK9Xi5sH5XY/LzfsWeJWrVW+95aQl6Wwc5VOQomSdSsdeuP6QBZzhHOLkKVbK7Z2qdQ==
X-Received: by 2002:a05:600c:630c:b0:458:d289:3e26 with SMTP id 5b1f17b1804b1-45b4741f876mr3645435e9.2.1755630521491;
        Tue, 19 Aug 2025 12:08:41 -0700 (PDT)
Received: from [192.168.3.141] (p57a1a207.dip0.t-ipconnect.de. [87.161.162.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c07778939bsm4501685f8f.46.2025.08.19.12.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 12:08:40 -0700 (PDT)
Message-ID: <429302cf-1574-4263-b1cb-cb4062509a14@redhat.com>
Date: Tue, 19 Aug 2025 21:08:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mm/memory_hotplug: Update comment for hotplug memory
 callback priorities
To: Dave Jiang <dave.jiang@intel.com>,
 Marc Herbert <marc.herbert@linux.intel.com>, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 akpm@linux-foundation.org
References: <20250814171650.3002930-1-dave.jiang@intel.com>
 <20250814171650.3002930-2-dave.jiang@intel.com>
 <c3e30bf7-403a-4105-8e04-a73b80039ea5@redhat.com>
 <cd3d3e33-7b2e-45f1-977f-2d634ff1ef81@intel.com>
 <3e48429a-b52d-43a1-b48a-06fb46f0a37c@linux.intel.com>
 <83a930e5-660e-49ed-8c34-66c4edf93665@redhat.com>
 <41ec1e23-e0f6-4275-ba9b-a34c2cbddbd9@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <41ec1e23-e0f6-4275-ba9b-a34c2cbddbd9@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19.08.25 17:39, Dave Jiang wrote:
> 
> 
> On 8/19/25 2:18 AM, David Hildenbrand wrote:
>> On 19.08.25 05:14, Marc Herbert wrote:
>>>
>>>
>>> On 2025-08-18 07:08, Dave Jiang wrote:
>>>>
>>>>
>>>> On 8/16/25 12:29 AM, David Hildenbrand wrote:
>>>>> On 14.08.25 19:16, Dave Jiang wrote:
>>>>>> Add clarification to comment for memory hotplug callback ordering as the
>>>>>> current comment does not provide clear language on which callback happens
>>>>>> first.
>>>>>>
>>>>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>>>> ---
>>>>>>     include/linux/memory.h | 2 +-
>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/include/linux/memory.h b/include/linux/memory.h
>>>>>> index 40eb70ccb09d..02314723e5bd 100644
>>>>>> --- a/include/linux/memory.h
>>>>>> +++ b/include/linux/memory.h
>>>>>> @@ -116,7 +116,7 @@ struct mem_section;
>>>>>>       /*
>>>>>>      * Priorities for the hotplug memory callback routines (stored in decreasing
>>>>>> - * order in the callback chain)
>>>>>> + * order in the callback chain). The callback ordering happens from high to low.
>>>>>>      */
>>>>>>     #define DEFAULT_CALLBACK_PRI    0
>>>>>>     #define SLAB_CALLBACK_PRI    1
>>>>>
>>>>> "stored in decreasing order in the callback chain"
>>>>>
>>>>> is pretty clear? It's a chain after all that gets called.
>>>>
>>>> I can drop the patch. For some reason when I read it I'm thinking the opposite, and when Marc was also confused I started questioning things.
>>>>
>>>
>>> I think we both found the current comment confusing (even together!)
>>> because:
>>>
>>> - It very briefly alludes to an implementation detail (the chain)
>>>     without really getting into detail. A "chain" could be bi-directional;
>>>     why not? This one is... "most likely" not. Doubt.
>>>
>>
>> Please note that the memory notifier is really just using the generic *notifier chain* mechanism as documented in include/linux/notifier.h.
>>
>> Here is a good summary of that mechanism. I don't quite agree with the "implementation detail" part, but that information might indeed not be required here.
>>
>> https://0xax.gitbooks.io/linux-insides/content/Concepts/linux-cpu-4.html
>>
>>> - Higher priorities can have lower numbers, example: "P1 bugs". Not the
>>>     case here, but this "double standards" situation makes _all_
>>>     priorities suspicious and confusing.
>>>
>>
>> Yes, "priorities" are handled differently in different context.
>>
>>> - Constants that come first in the file are called last.
>>
>> Yes, but that part makes perfect sense to me.
>>   > I would go further than Dave and also drop the "chain" implementation
>>> detail because it makes the reader to think too much.  Not needed and
>>> distracting at this particular point in the file.
>>
>>   > /*
>>>    * Priorities for the hotplug memory callback routines.
>>>    * Invoked from high to low.
>>>    */
>>>
>>>     => Hopefully zero cognitive load.
>>
>> Still confusion about how a high priority translates to a number, maybe?
>>
>> /*
>>   * Priorities for the hotplug memory callback routines. Invoked from
>>   * high to low. Higher priorities corresponds to higher numbers.
>>   */
>>
> 
> This reads clear to me. I will adopt this comment if there are no additional objections.


Feel free to add

Acked-by: David Hildenbrand <david@redhat.com>


-- 
Cheers

David / dhildenb


