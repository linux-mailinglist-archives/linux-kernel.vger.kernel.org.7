Return-Path: <linux-kernel+bounces-816642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BB9B576AB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93DC7200D05
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2992FE042;
	Mon, 15 Sep 2025 10:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JoZZH1Lt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B1B2FD1BE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757932661; cv=none; b=nAeEbg5hEGwgZTP1+aSAq/ww8QRqtXfaKHFZLNHkp4XwVv2znOStdR3wccrYqgyChhIaD+d9EDh5QIJtu4617D3Lqme+SlgeQGtyguEpc43OZEwSTV2aGIU+NImM1epxthCpG5Uch/ahDuQeLB/DFJZbmftAVAtliZ4aqD4PlSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757932661; c=relaxed/simple;
	bh=tdj6MeX8UWprv0GiMeEJ4QSHunldRrELX1VJ2VKtwuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OPU4PF/5BeZlGZJSAGY6cj0gqY3cNRPBBWFRbSVlZVd9T02mbf3FIXLH1Zt8tO3vHW+iD3D+gaOJyOfDmL7k4xB6qqmSRKFT5Knd5bmM6fOWDy5EdNvq29NvJxofAlgfu9ETKYxSRfZ3JtLk+VK70L4D+Imuu35JMNUipARVZ38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JoZZH1Lt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757932657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AE1mZo5dM28REMNEPIlpmNiMCj/YW4kRPZdnAEmZK3w=;
	b=JoZZH1LthigquZ4dEXuNMQRslo2vk1ZbZjMSycb4IFeJHoyV2v/E1wlGIpN/8DaflDEFR4
	gUIcEpP61npKmxFZ4kQga6EnvRfuEwA20fh+MiacayPscnHez/FO6Ybz699tMBmAav6kh0
	WFFMijg5FV2ttd1y8wogz08wgu9da4k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-ohbPj8mwMF65oT632AQSCw-1; Mon, 15 Sep 2025 06:37:35 -0400
X-MC-Unique: ohbPj8mwMF65oT632AQSCw-1
X-Mimecast-MFC-AGG-ID: ohbPj8mwMF65oT632AQSCw_1757932653
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45f2b9b99f0so7691895e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 03:37:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757932653; x=1758537453;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AE1mZo5dM28REMNEPIlpmNiMCj/YW4kRPZdnAEmZK3w=;
        b=Yy6lvPxf2a/aPN2vc5wm/CUQ2lhxJVxPbvoQDfHJxWIUnHFIpn4N4bERWKUz9winfS
         el8s/l9kEVsXtW2q/1mb368ekhd0fUMSkudXG+8Zr8q429UYdSnJW43LOJyXMeVcu5ss
         nDQt1lHWDFXD3M6NP/QvZl4OvkS3sfEJdkF2UB7eaDMwI3Xazg1f5nke2RU8s8NuiaZU
         Sdl1wGBPe/PdBX7kqnDqzuqaRXHeFQvui9mR0OX3Lg7gvKT1GcQkG4jPUI9qOUBMJATa
         FG/YwpgG4IHJYsLcQ/O1lep+cnH/Nqeqfz0kOwWc7fbhoYQeDfr7T1MXoJIkG5fXZHJH
         MKvg==
X-Forwarded-Encrypted: i=1; AJvYcCUK/B40eOhRLu9ZI8t/4L6GSVlixr7uFoMb7g+frI9C+pa+lKvmlng438ooyg3EU2JWcgmCUrCt2/SlE3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDY1qjiClsYMptvLUUAf2KmgpIfCuUUcK4HYjN+deXFl/ji5+W
	McasAJFWKVBx3N9R04KqnMD6S22sluqbgKYe9UEK1+r+9dvpsuYUh8zCgaiPMCC5DEimnlRCAuz
	4o4AenU+6athBacgOSEWzPfDl/5hTB3jFJezRaxzzA5ZRhMqCaAS2uu2BJ75T9Q8D5g==
X-Gm-Gg: ASbGncs88CBD40tBy6BaWJTmMYlMYWH9diox1Mz7b1Kd7qKHo1W2G53taXTTZc9Sl8Z
	6hVGJ2RRPI0DqUUv/nx+bGhLDLBZW3MP2O29SumgULuAwGMRYvLNyOLBmbNGqsAptx+tm26R4hV
	TCXL4KRK1r/uF0BTpWhIrSYkcEvbY8RcxKqreD7jmASv+Sfp/Yxdj1Re78fL/VpCRHHqNtJ/Ln2
	kYtc2LsrO9vbs8N3YTmHQJNEOZk/7EcndU1Yds9nW2dhXqplUWWu3aMVFzY1mgtsusaE0hXn0zK
	67o/dd4YW5coANznY/o/RDoGVhMJVXKWjc8AlInIQH7g9o8syo91y0mn5XCqPTwM59BMQXhRPWL
	RmXOT6RVzcrr11o9w0trKwnwwtGAX/3v5AXarQIqcbci2wze24A6+ProMlYwklCFIUUg=
X-Received: by 2002:a05:600c:3414:b0:45d:f680:3140 with SMTP id 5b1f17b1804b1-45dfd5ab209mr99450675e9.2.1757932653214;
        Mon, 15 Sep 2025 03:37:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKqPx+HEJeLSB1hCo0z7zZzUc9au6zeGG4k2n2MG+k85CvLdXKo6KoDdaStSnTH9xLtijK0g==
X-Received: by 2002:a05:600c:3414:b0:45d:f680:3140 with SMTP id 5b1f17b1804b1-45dfd5ab209mr99450255e9.2.1757932652781;
        Mon, 15 Sep 2025 03:37:32 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:f900:e0ae:65d5:8bf8:8cfd? (p200300d82f18f900e0ae65d58bf88cfd.dip0.t-ipconnect.de. [2003:d8:2f18:f900:e0ae:65d5:8bf8:8cfd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e41b6dbdbsm158366625e9.22.2025.09.15.03.37.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 03:37:32 -0700 (PDT)
Message-ID: <f1d36416-bb96-4ed1-bf0a-5e1445fbbdd6@redhat.com>
Date: Mon, 15 Sep 2025 12:37:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/15] khugepaged: mTHP support
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Kiryl Shutsemau <kas@kernel.org>, Nico Pache <npache@redhat.com>,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org,
 peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
 sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com,
 catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
 dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com,
 lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org, jannh@google.com,
 pfalcato@suse.de
References: <43f42d9d-f814-4b54-91a6-3073f7c7cedf@redhat.com>
 <ab8c2e03-53fb-402c-a674-c2c6ab11f54e@redhat.com>
 <rapl4xr55zv2nq3jh5ulk4wvfyxa2kmbnnb4uram6q43y4cbwn@dv5m52ocyqne>
 <80c50bf4-27b1-483c-9977-2519369c2630@redhat.com>
 <7ri4u7uxsv6elyohqiq2w5oxv4yhk2tyniwglfxtiueiyofb3n@l4exlmlf5ty4>
 <59641180-a0d9-400c-aaeb-0c9e93954bf5@redhat.com>
 <c5bcecb8-13e7-4db5-849e-2120c69b2af5@lucifer.local>
 <ed784d6c-6c2a-4e0b-ad2f-e953bf310ce8@redhat.com>
 <dcfc7e27-d3c8-4fd0-8b7b-ce8f5051d597@lucifer.local>
 <78d75263-e0ab-4dcd-ae97-5c5c9bb10193@redhat.com>
 <85aa2020-5b5e-4bfc-aade-581d20aeff87@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <85aa2020-5b5e-4bfc-aade-581d20aeff87@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.09.25 12:32, Lorenzo Stoakes wrote:
> On Mon, Sep 15, 2025 at 12:25:54PM +0200, David Hildenbrand wrote:
>>>>
>>>> I would just say "The kernel might decide to use a more conservative approach
>>>> when collapsing smaller THPs" etc.
>>>>
>>>>
>>>> Thoughts?
>>>
>>> Well I've sort of reviewed oppositely there :) well at least that it needs to be
>>> a hell of a lot clearer (I find that comment really compressed and I just don't
>>> really understand it).
>>
>> Right. I think these are just details we should hide from the user. And in
>> particular, not over-document it so we can more easily change semantics
>> later.
> 
> And when we change semantics we can't change comments?
> 
> I mean maybe we're talking across purposes here, I'm talking about code
> comments, not the documentation.
> 
> I agree the documentation should not mention any of this.

Yes, I was talking about patch #15 ("It's just when it comes to 
documenting all that stuff in patch #15").

Comments we can adjust as we please of course :)

-- 
Cheers

David / dhildenb


