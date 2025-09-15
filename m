Return-Path: <linux-kernel+bounces-816899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF14B57A34
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 766F01A2795A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E69F304964;
	Mon, 15 Sep 2025 12:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVj+RNSj"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEA323D7E7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938612; cv=none; b=dG9+XsO8pFsVn7Os6osNsJdfYP30xEh++29lQcV8PR0AdAd22BQJntad8Fqnrmmqf0HK9UdcmlRfJfr09NojV3bBZS/b4XXg8qQ6Fm8ISbUSINJQwfOp6KJuGn9Si0qQsWjXkOsqg1QWh8aUtfU7I6X7vQGcXKPhAkK20kAzBIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938612; c=relaxed/simple;
	bh=++dZYV/juMI5pl6UTOl5lGiPaGz60jWMWAPjOPQh934=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ecnokd3asgSC3GXY3pSU/bmBdnURUeNyGIskR/d6StQlCdpbR2SwvUAKelJxWlW6ZxgX4VuSve0ajkzvt+nz86PnLJ+6cDKxKDigJuIEMAwFepnsrthIdwzKlu4r242wE3RfcLeZvs8Qv4LboQHBrOMzkEIbZHLRB6meBQKqbps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVj+RNSj; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45f2c5ef00fso10111635e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 05:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757938609; x=1758543409; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hkh90FvShjKuQpnhzVfehnVtCnrky/4Hn2fBZ8wL670=;
        b=lVj+RNSjqxDyJAhTcfPQzJl+DcmHpkBwiSK4bth/MseJZpIGD3rVM4e0NLt4u354uf
         hve9JkMN1+aatCJgicCLwScHi6K38mzBw+RgW2zdYD1JiXZ5Vv7kOaLBQZWLshiJrkYO
         qOk/PucYsYttxw8kbyU3FVOih9e+RGEGseyidf21Vyai6Z5hr7ETd1QHv+XNfGFTQNLl
         rfiOB0MmGjsunRrlHON1ibuq6tcVHtORzaMM3pnkGg3vUa6E9jZGYGFAfoT17fjoUARI
         ntuTFbJWHQGCVWwB3wQpZxgOFka50qsB59aVwfin25dHteSaj819ElxdFv1+XImbmXgG
         wLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757938609; x=1758543409;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hkh90FvShjKuQpnhzVfehnVtCnrky/4Hn2fBZ8wL670=;
        b=acYjKeFDs5+cISWXhZZ/hraaPu0C5gmadqH5HT/GhQEdntfZR+N7dNI31QH8Yiwxwz
         HPRQgILsawcHzl1E0lXdCDOzHqQKwGfQvKoQPy9sDXbSBjJs9pLlSeFL303tJsgQehft
         5CIyUs4cVxGfEjj0vXI/jzZNOH6+vyuRy8wrPs3ISKruMp4fHwD1nCPJbfhuHNiEvMTV
         9cxoquLsG0KmCIk4HUmlU/68XkYToyS/tTYW4pU2YI4+KNPulOMiXSDJE6dcRwXypUre
         IYxpBHpfdKL+9YYzAlPsD2RRve1WYUn4dJx1T021RrNpr9laXzHPnQzfT14X1b/No75d
         gKhw==
X-Forwarded-Encrypted: i=1; AJvYcCVGmTcmt3DSNlbPsamqdNhZGaSP0xr/4G27Qb6Q7HGlUQtFR1VsQRywlES4+YkgquTh35pY+8YOSJX872g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx9L64gopnZZ0EhjOiaEaNnUN8qk1qtdS6B+xFvPyMQ9DnhpnC
	oaPLXmnhldozmNbka9Bj5AKKq9gmet64z6YkfZtT59ZVkBsjS/NM8GWMRrWuBm5r
X-Gm-Gg: ASbGncs4pOsYlmcFpDuZ5CK5f3JPNitRrLR3KHAg5HOqm9mCRhQ3U6BJ1FjcPC8VaAQ
	G6NmmAHRLDQo/kC65ly9KeB8ZdX5oQFy5q1Q6fe8AjqXL3nqQ2tww4fiFw41S0QDZuGr13/WwcO
	HozytAhvJ92f9jrEzVb7t9TQsCNVtgduR1LxLE31Tt9W56Eyajxeq/qYLaCm1zVLcRe3Y4w/t3T
	g2u19mjBRogsrVUh2tNBcfI1nt3cCpOCHDPDpEG6WGEHIQM1k7I7FQ+KowUZxydnyNKAzD85NVQ
	S297KigRjlnosvembWtIGXBJpULlUSTfJ4ucS8YV7ll7NnA1Zbp/mfJy2T2n9BmlIzt/a0CHaan
	TKw+y2yG1xOqiG5MM5gCnvrejZHmpzi7ibt6pFdH0VS3h1TS9yt9JqU8cBVYRe8CsJwD6rxJC8O
	wYfDnnWg==
X-Google-Smtp-Source: AGHT+IHLdvnlzkDOd7uXK6UlLVGn66En8B0SEaqf+MBMTOLNt+IzT6bYlms/O5Yrrl4aVtgHa35tlA==
X-Received: by 2002:a05:600c:4691:b0:45f:28d5:fae with SMTP id 5b1f17b1804b1-45f28d511f7mr65042655e9.4.1757938608737;
        Mon, 15 Sep 2025 05:16:48 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:1449:d619:96c0:8e08? ([2620:10d:c092:500::5:94b0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037d62besm173987755e9.21.2025.09.15.05.16.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 05:16:48 -0700 (PDT)
Message-ID: <f34dbfd0-2291-4a19-bbd8-b61fe7754e55@gmail.com>
Date: Mon, 15 Sep 2025 13:16:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/15] khugepaged: mTHP support
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Kiryl Shutsemau <kas@kernel.org>, Nico Pache <npache@redhat.com>,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org,
 peterx@redhat.com, wangkefeng.wang@huawei.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, aarcange@redhat.com, raquini@redhat.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com,
 lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org, jannh@google.com,
 pfalcato@suse.de
References: <ppzgohmkll7dbf2aiwhw7f4spf6kxjtwwe3djkx26pwy4ekrnd@mgeantq5sn2z>
 <d0e81c75-ad63-4e37-9948-3ae89bc94334@redhat.com>
 <CAA1CXcA+pb5KvEnJJqdf1eSjaFiBZ82MRB+KDmyhj3DbiQqOxg@mail.gmail.com>
 <enrgrocqajwu5d3x34voghja7pbvau45oobxgabawrly44ld4u@ahch3xn6rtq5>
 <cd8e7f1c-a563-4ae9-a0fb-b0d04a4c35b4@redhat.com>
 <2c5328ee-fb6e-45cf-a151-868cc8e7ff97@lucifer.local>
 <4508810d-7645-4f57-a0c5-2ee9f44206fc@lucifer.local>
 <34754ca4-fced-4a3c-8ff8-c00967d487de@redhat.com>
 <92352257-5be4-4aaa-b97f-c4e879ac6959@lucifer.local>
 <de3f5502-ef81-4f44-96a9-995e512301a3@redhat.com>
 <5099d9fe-4a07-4acd-95c8-782ffc74df37@lucifer.local>
 <1312fa3e-88dd-490a-9e07-9749c625933b@redhat.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <1312fa3e-88dd-490a-9e07-9749c625933b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 15/09/2025 12:10, David Hildenbrand wrote:
> On 15.09.25 12:59, Lorenzo Stoakes wrote:
>> On Mon, Sep 15, 2025 at 12:52:53PM +0200, David Hildenbrand wrote:
>>> On 15.09.25 12:48, Lorenzo Stoakes wrote:
>>>> On Mon, Sep 15, 2025 at 12:44:34PM +0200, David Hildenbrand wrote:
>>>>>>>> Mapping that to actual THP sizes (#pages in a thp) on an arch will be easy.
>>>>>>>
>>>>>>> And at different mTHP levels too right?
>>>>>>>
>>>>>>
>>>>>> Another point here, since we have to keep:
>>>>>>
>>>>>> /sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none
>>>>>>
>>>>>> Around, and users will try to set values there, presumably we will now add:
>>>>>>
>>>>>> /sys/kernel/mm/transparent_hugepage/khugepaged/eagerness
>>>>>>
>>>>>> How will we map <-> the two tunables?
>>>>>
>>>>> Well, the easy case if someone updates eagerness, then we simply et it to
>>>>> whatever magic value we compute and document.
>>>>>
>>>>> The other direction is more problematic, likely we'll simply warn and do
>>>>> something reasonable (map it to whatever eagerness scale is closest or
>>>>> simply indicate it as "-1" -- user intervened or sth like that)
>>>>
>>>> I don't love the idea of a -1 situation, as that's going to create some
>>>> confusion.
>>>
>>> swapiness also has a "max" parameter, so we could just say "override" /"
>>> disabled" / whatever?
>>
>> I don't love the user being able to override this though, let's just nuke their
>> ability to set this pleeeease.

Do you mean stop people from changing max_ptes_none? I am not sure if thats a good idea,
Its existed for a very long time and even a few release warnings might not be enough
of a warning for sysadmins that might not have a kernel team to notice this.

If the eagerness solution is just a logarithmic mapping of max_ptes_none at the start, I do
think we need to keep max_ptes_none completely supported. As eagerness isnt really doing
something new? Once eagnerness diverges from just setting max_ptes_none, only then
we should start thinking about deprecating it?


>>
>> Because if they can override it, then we have to do some deeply nasty scaling
>> for mTHP again.
> 
> There are ways to have it working internally, just using a different "scale" instead of the 100 -> 50 -> 25 etc.
> 
> I am afraid we cannot change the parameter to ignore other values because of the interaction with the shrinker that easily .... we might be able to detracted at wait a bunch of kernel releases probably.
> 


