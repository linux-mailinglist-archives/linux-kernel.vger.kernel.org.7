Return-Path: <linux-kernel+bounces-840167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 723F0BB3BA7
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 13:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 296E43C4D7D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 11:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F271630F95A;
	Thu,  2 Oct 2025 11:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HnFG3Oib"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B391514DC
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 11:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759404089; cv=none; b=aHUDFmYqSbPlqhfX4RI/oIa0zFMwP/S2F85gHB1584Pwo9VEsOkMdzPOmth3DT3yreSaLTWR+IZRVdSCjiSiPo9UP07EIfOzMCoNaM/Wb0kACgFTcWKL7IWONHJYLVw4DjGOuW7BheeKV3SHCmbd1GmCw/0VxXafkK3G0HBv8aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759404089; c=relaxed/simple;
	bh=60HK6HZMDIMqtnELozR/+KeALr5SsZvz/SqxgBn91uA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jd36CfzeuaMKdffBdWvZ15Urypfqs832HK3Swig8TjwViwW5VV1YfElcK2yKDW//iLs+S3t1+/6S6fM5Up7WPK08ofGL8tRlIu5We03rRO2JnXlNH40ATUm4nw6hdjuHwCBoQDDPoIAdbmh+wu8SCkorYNypBIs502JHM4mk2ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HnFG3Oib; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759404086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=j0tbG0uETEop9BgEp09M58D45q7C5ew7mWN0UcZdxs0=;
	b=HnFG3Oib5AE8VrC2yaf8vfExGJ2u6+whSDe8do+bTp/AmaEjN+6OoTM55gR1kbfImWO1Jy
	y8tYUaF9rkfurttyKQKkLUJpyHjWEcL8pbW4os6g6+M5FH3ReThM/0U0RPwgff+dYVLodo
	GIhVQeaYXQOubnSEFtJLXClsMbazlwE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-3F_U0oFmMBe2mnkcwadxQQ-1; Thu, 02 Oct 2025 07:21:22 -0400
X-MC-Unique: 3F_U0oFmMBe2mnkcwadxQQ-1
X-Mimecast-MFC-AGG-ID: 3F_U0oFmMBe2mnkcwadxQQ_1759404081
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e4fa584e7so3835255e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 04:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759404081; x=1760008881;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j0tbG0uETEop9BgEp09M58D45q7C5ew7mWN0UcZdxs0=;
        b=ZL5GA3AqKiMl5c1Xo2K22Q577q2TFZ5I3xh3Zx+nB9yWsJBIWNAj2WF9j0/G6DjkL+
         SuIxjTIBjOORDv4juPhI90mV9SeKsqIW1/CEMs0gnwcHiJcJxqI9RKh5zAl+PqCyLAPy
         SDsZY2Gb6TIzp6jhgO9w/sKMqpjEK6/GXTfKCPkhLXXxy+NtYBOTVyh8mKzwiSXF5+NN
         xKWQrx+czgTidqEXO5A290W9pv0CFeIK8lpj/ZSS5e9VeBIUiiGEmObfI5uHdlsFof/M
         n9ZdZ7JlTgBp1dp1gN0qO+xvCogWTFgxLA0CN/546C+UaMVS5m14DUe/EHTQELfhSyyd
         jLhg==
X-Forwarded-Encrypted: i=1; AJvYcCVpl/19YQm0jFA+f/zWEUswyDGri1yed+uz1+jDNtCAWD7jGSbvLYGOchmXCJXvMcHU7S+deI38FwxQQMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTb7m9nzkn7185jQVPbbrOpL0t20li09FawxJz8VZ/9o2bmcBC
	RBSfaH2ozmaJR3yXQfzCmhiHIm6edsdV1dz4thXiwkmXsL/uKE5UZAHfAofPw++zlSbbsEBP7u8
	vr+rqxhL+T4cCriiYANZ71d3Ene0iDr0YKVCt63EFlVF4sjLZ08tgyK5XRI9GMwOibA==
X-Gm-Gg: ASbGncvEL4q7VMoq4OFOx4rJzYTawTP4EFD+oW37RMRtXxU9rqz4odKW+YWEu/8str+
	jprW3UhZ9LKwzFey1C0OkEAIGtnMeCe+SwskQOXwMIuchcLvOETckZObEVJCvFRziqMUw5ZLwEH
	lY5hzu5Ol6OiO1mHStO/FG7uHWo2NP0KJOYyqxoRbTF5FopfcK5TQ67d6o8AQsLkLAEdFGHVdtQ
	a4stZdY+W2Y0qfdimt9SFc0RzcfDS4ifjvXU6WUbRKs/0TjRdBzoQ5htrD3hwFLuV4PXqOBHNIw
	Q6QrNVjwKlKVnEYEDjFSGdQEav5euClVMhfqurI6M+6ilXFIpcCflU+sHXp4hQpStmXoSMEVD6R
	z3UOQpQ7I
X-Received: by 2002:a05:600c:6094:b0:45d:d88b:cca with SMTP id 5b1f17b1804b1-46e6125cf67mr49453215e9.1.1759404081325;
        Thu, 02 Oct 2025 04:21:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9kXStO64iOsQpfMLe9GoNnIJ31KbxzcIXm6pY0D7xqW25PKHRZJ8o1vkIeJ8Y3HEFf99Rvw==
X-Received: by 2002:a05:600c:6094:b0:45d:d88b:cca with SMTP id 5b1f17b1804b1-46e6125cf67mr49452915e9.1.1759404080827;
        Thu, 02 Oct 2025 04:21:20 -0700 (PDT)
Received: from [192.168.3.141] (tmo-080-144.customers.d1-online.com. [80.187.80.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a2a808sm79601765e9.21.2025.10.02.04.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 04:21:20 -0700 (PDT)
Message-ID: <600f9ca1-580e-46c9-94ad-f9b4b8c3cf97@redhat.com>
Date: Thu, 2 Oct 2025 13:21:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Discuss] First steps for ASI (ASI is fast again)
To: Brendan Jackman <jackmanb@google.com>, peterz@infradead.org,
 bp@alien8.de, dave.hansen@linux.intel.com, mingo@redhat.com,
 tglx@linutronix.de
Cc: akpm@linux-foundation.org, derkling@google.com, junaids@google.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, reijiw@google.com,
 rientjes@google.com, rppt@kernel.org, vbabka@suse.cz, x86@kernel.org,
 yosry.ahmed@linux.dev, Patrick Roy <roypat@amazon.co.uk>,
 Zi Yan <ziy@nvidia.com>
References: <20250812173109.295750-1-jackmanb@google.com>
 <44082771-a35b-4e8d-b08a-bd8cd340c9f2@redhat.com>
 <DD7S12CF1V9G.3KGT3KYBLZ7F2@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <DD7S12CF1V9G.3KGT3KYBLZ7F2@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.10.25 12:50, Brendan Jackman wrote:
> On Thu Oct 2, 2025 at 7:45 AM UTC, David Hildenbrand wrote:
>>> I won't re-hash the details of the problem here (see [1]) but in short: file
>>> pages aren't mapped into the physmap as seen from ASI's restricted address space.
>>> This causes a major overhead when e.g. read()ing files. The solution we've
>>> always envisaged (and which I very hastily tried to describe at LSF/MM/BPF this
>>> year) was to simply stop read() etc from touching the physmap.
>>>
>>> This is achieved in this prototype by a mechanism that I've called the "ephmap".
>>> The ephmap is a special region of the kernel address space that is local to the
>>> mm (much like the "proclocal" idea from 2019 [2]). Users of the ephmap API can
>>> allocate a subregion of this, and provide pages that get mapped into their
>>> subregion. These subregions are CPU-local. This means that it's cheap to tear
>>> these mappings down, so they can be removed immediately after use (eph =
>>> "ephemeral"), eliminating the need for complex/costly tracking data structures.
>>>
>>> (You might notice the ephmap is extremely similar to kmap_local_page() - see the
>>> commit that introduces it ("x86: mm: Introduce the ephmap") for discussion).
>>>
>>> The ephmap can then be used for accessing file pages. It's also a generic
>>> mechanism for accessing sensitive data, for example it could be used for
>>> zeroing sensitive pages, or if necessary for copy-on-write of user pages.
>>>
>>
>> At some point we discussed on how to make secretmem pages movable so we
>> end up having less unmovable pages in the system.
>>
>> Secretmem pages have their directmap removed once allocated, and
>> restored once free (truncated from the page cache).
>>
>> In order to migrate them we would have to temporarily map them, and we
>> obviously don't want to temporarily map them into the directmap.
>>
>> Maybe the ephmap could be user for that use case, too.
> 
> The way I've implemented it here, you can only use the ephmap while
> preemption is disabled. (A lot about the implementation I posted here is
> just stupid prototype stuff, but the preemption-off thing is
> deliberate). Does that still work here? I guess it's only needed for the
> brief moment while we are actually copying the data, right? In that case
> then yeah this seems like a good use case.

Yes, that's my expectation: we only need access for a brief moment in 
time, when actually copying page content.

> 
>> Another, similar use case, would be guest_memfd with a similar approach
>> that secretmem took: removing the direct map. While guest_memfd does not
>> support page migration yet, there are some prototypes that allow
>> migrating pages for non-CoCo (IOW: ordinary) VMs.
>>
>> Maybe using the ephmap could be used here too.
> 
> Yeah, I think overall, the pattern of "I have tried to remove stuff from
> my address space, but actuonally I need to exceptionally access it anyway,
> we are not actually a microkernel" is gonna be a pretty common one. So
> if we can find a way to solve it generically that seems worthwhile. I'm
> not confident that this design is a generic solution but it seems like
> it might be a reasonable starting point.
> 
>> I guess an interesting question would be: which MM to use when we are
>> migrating a page out of random context: memory offlining, page
>> compaction, memory-failure, alloc_contig_pages, ...

In both context ^ would be an interesting point. Maybe we'd just need 
some dummy MM to achieve that, not sure.

>>
>> [...]
>>
>>>
>>> Despite my title these numbers are kinda disappointing to be honest, it's not
>>> where I wanted to be by now,
>>
>> "ASI is faster again" :)
>>
>>> but it's still an order-of-magnitude better than
>>> where we were for native FIO a few months ago. I believe almost all of this
>>> remaining slowdown is due to unnecessary ASI exits, the key areas being:
>>>
>>> - On every context_switch(). Google's internal implementation has fixed this (we
>>>     only really need it when switching mms).
>>>
>>> - Whenever zeroing sensitive pages from the allocator. This could potentially be
>>>     solved with the ephmap but requires a bit of care to avoid opening CPU attack
>>>     windows.
>>>
>>> - In copy-on-write for user pages. The ephmap could also help here but the
>>>     current implementation doesn't support it (it only allows one allocation at a
>>>     time per context).
>>>
>>
>> But only the first point would actually be relevant for the FIO
>> benchmark I assume, right?
> 
> Yeah that's a good point, I was thinking more of kernel compile when I
> wrote this, I don't remember having a specific theory about the FIO
> degradation. The other thing I didn't mention here that might be hitting
> FIO is filesystem metadata. For example if you run this on ext4 you
> would need to get the superblock into the restricted addres space to
> make it fast.  I'm not sure if there would be anything like that in
> shmem though...
> 
>> So how confident are you that this is really going to be solvable.
> 
> I feel pretty good about solvability right now - the numbers we see now
> are kinda where we were at internally 2 or 3 years ago, and then it was
> a few optimisation steps from there to GCE prod (IIRC the
> context_swith() one was a pretty big one for that usecase, I can't
> remember if any of the TLB flushing optimisations made a big
> difference).
> 
> I can't deny the risk that these few steps might be much harder for
> native workloads than VM ones but it  just seems like a game of
> whack-a-mole now, not a "I'm not sure this thing is ever gonna work".
> The only question is how many moles there are to whack...
> 
>> Or to
>> ask from another angle: long-term how much slowdown do you expect and
>> target?
> 
> In the vast majority of cases, we've been able to keep degradations from
> ASI below 1% of whatever anyone's measuring. When things go above that
> we need to grovel a bit, if anything gets to 5% we don't even bother
> asking.
> 
> But also, note in lots of these cases we're switching ASI on while
> leaving other mitigations in place too. If we had a complete "denylist"
> (i.e. the holes in the restricted address space) that we were confident
> covered everything, we'd be able to make a lot of these degradataions
> negative. So we might just be making life unnecessarily hard for
> ourselves by not doing that in the first place. The idea is to retrace
> our steps later and start switching off old mitigations and bragging
> triumphantly about our perf wins once we are totally certain there's no
> security regression.
> 
> So yeah I can't be 100% confident for the reasons I mentioned above but
> the target, which I think is realistic, is for ASI to be faster than the
> existing mitigations in all the interesting cases ("interesting" meaning
> we have to do kernel work instead of just flipping a bit in the CPU ).

Got it, thanks for all that information. I suggest you use some of that 
when moving forward with this projects, because it's much more important 
what the roadmap is than what is the current limitations.

-- 
Cheers

David / dhildenb


