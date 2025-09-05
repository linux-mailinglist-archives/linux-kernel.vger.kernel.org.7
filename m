Return-Path: <linux-kernel+bounces-803884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36319B466C2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 00:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5043BD446
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 22:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D331A29A31D;
	Fri,  5 Sep 2025 22:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="AcOYyFpS";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="fBG6Tw91"
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7B02882A9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 22:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757112165; cv=none; b=buGapiAfr6pEtKByqaUpCd7oWLmkqPNR9JLH2OmHtoV/yCPcsaBmFQ3Jhls1xyF28Bzrtlpo+SF8NrXlDdgxvVg69ApsT3v7FP576IepUYODMw+V0W6JlJdkVzMGZQGRikMe8mngJC6z2GYn1iJidHf6+IymxnUQIU767YEZPAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757112165; c=relaxed/simple;
	bh=id810Br+GNdNjSw0noZKu+KhFp2Wbo7veCAJaCxcVc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Et70CxIEpeDa5qj+slPYs/G7vvGl5Aj2+8RrM/M+Jv5VSlvIgVOPbUrwdecEQflwFzZ/tuYdxCxeHW21CCMsRl/u8US1kvSJ8detLNmIlEX2RpOyLg0iNoZrHUZzA4X26Laz7NP1+qzenYzG+pPRJOiaTSYvd/jXbwKlEd0QtA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=AcOYyFpS; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=fBG6Tw91; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757112158; x=1757716958;
	d=konsulko.se; s=rsa2;
	h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
	 subject:mime-version:date:message-id:from;
	bh=f9xMrpEXG0h9LXCdOySlqpPGWgrvgr6XLD10hQV2w4U=;
	b=AcOYyFpSqfd3i8NYCVDRlxQwgRXmJmcsMZylw44CDfROKVAycnd7vV2xLCeheeHf6D+dLbbu0VuKj
	 K5qN48/5eQGhsR+vUy2yjt5d3CtTufZgjwBnaKvGpE7eQqLiBfzZccjN3dZXoy/j1GFiT6mjlVU2HF
	 K4cU8Y1FcxS3jCAzYwOsDXSBRONF5vorWZIV/u0+nxrYAx1miVJer+V6d9WHEg4F1kHUl66ph6O3mR
	 xNCGe5BVPMcYu6fA0k/EJOWLyuNQ/6isbWPmR7f0DVjdnly9qJyTuzOy87KBlx2Z+4TvdcGEbtF02k
	 WV5j6/6KsK7U/0412oFVUpvqdxC0n9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757112158; x=1757716958;
	d=konsulko.se; s=ed2;
	h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
	 subject:mime-version:date:message-id:from;
	bh=f9xMrpEXG0h9LXCdOySlqpPGWgrvgr6XLD10hQV2w4U=;
	b=fBG6Tw91cRm24RdKubzQerR3NsieKINFD80GO4gPES8NMAHFwCpexPqdgABDfvKYMxalUCEMgFJv/
	 6mQJrgNDg==
X-HalOne-ID: 9e70b073-8aa9-11f0-90da-4f541c8bf1cc
Received: from [192.168.10.245] (host-95-203-16-218.mobileonline.telia.com [95.203.16.218])
	by mailrelay3.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 9e70b073-8aa9-11f0-90da-4f541c8bf1cc;
	Fri, 05 Sep 2025 22:42:37 +0000 (UTC)
Message-ID: <5f6a8336-3d0e-4fa4-8fc9-08f59f462eac@konsulko.se>
Date: Sat, 6 Sep 2025 00:42:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] mm: remove zpool
To: Nhat Pham <nphamcs@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, hannes@cmpxchg.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>
References: <20250829162212.208258-1-hannes@cmpxchg.org>
 <20250904093325.2768507-1-vitaly.wool@konsulko.se>
 <7b1ca42d-1b89-44f4-bffb-e6b09f86fdc5@suse.cz>
 <1d42c513-cc83-4f08-a10c-cbd6206070f4@konsulko.se>
 <CAKEwX=MMNSg-QdA2XdBpzhi_d-o9Pv4OOPR5nqrvUVWRdnnpLA@mail.gmail.com>
Content-Language: en-US
From: Vitaly Wool <vitaly.wool@konsulko.se>
In-Reply-To: <CAKEwX=MMNSg-QdA2XdBpzhi_d-o9Pv4OOPR5nqrvUVWRdnnpLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/5/25 20:02, Nhat Pham wrote:
> On Thu, Sep 4, 2025 at 4:49 PM Vitaly Wool <vitaly.wool@konsulko.se> wrote:
>>
>>
>>
>> On 9/4/25 12:13, Vlastimil Babka wrote:
>>> On 9/4/25 11:33, Vitaly Wool wrote:
>>>>> With zswap using zsmalloc directly, there are no more in-tree users of
>>>>> this code. Remove it.
>>>>>
>>>>> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
>>>>
>>>> Per the previous discussions, this gets a *NACK* from my side. There is
>>>> hardly anything _technical_ preventing new in-tree users of zpool API.
>>>> zpool API is neutral and well-defined, I don’t see *any* good reason for
>>>> it to be phased out.
>>>
>>> AFAIK it's a policy that unused code should be removed ASAP. And that's the
>>> case for zpool after Patch 1, no? It could be different if another user was
>>> about to be merged (to avoid unnecessary churn), but that doesn't seem the
>>> case for zblock?
>>
>> For the C implementation of zblock, no. But there's another
>> implementation which is in Rust and it's nearing the submission.
>>
>>> My concern would be if the removal breaks any existing installations relying
>>> on zswap. Presumably not as a make oldconfig will produce a config where
>>> nothing important is missing, and existing boot options such as
>>> "zswap.zpool=" or attempts to write to in the init scripts to
>>> "/sys/module/zswap/parameters/zpool" will cause some errors/noise but not
>>> prevent booting correctly?
>>
>> I don't expect heavy breakage but misconfigurations will definitely occur.
>>> I mean if we were paranoid and anticipated somebody would break their
>>> booting if writing to /sys/module/zswap/parameters/zpool failed, we could
>>> keep the file (for a while) and just produce a warning in dmesg that it's
>>> deprecated and does nothing?
>>>
>>>   From Patch 1:
>>>
>>>> Note that this does not preclude future improvements and experiments
>>>> with different allocation strategies. Should it become necessary, it's
>>>> possible to provide an alternate implementation for the zsmalloc API,
>>>> selectable at compile time. However, zsmalloc is also rather mature
>>>> and feature rich, with years of widespread production exposure; it's
>>>> encouraged to make incremental improvements rather than fork it.
>>>
>>> With my history of maintaining the slab allocators I can only support this
>>> approach.
>>
>> There was the time when slab was the best option and it was more mature
>> than slub, which is now the best and only option. Thus, the "maturity"
>> point is indeed valid but not being backed by anything else it doesn't
>> weigh too much. Besides, zsmalloc's production exposure from all I know
>> is limited to the 4K page case, and zsmalloc is truly struggling when
>> the system is configured for 16K pages.
> 
> That doesn't sound unfixable, if I recall our conversation correctly.
> Perhaps all of this effort is better off being spent fixing zsmalloc's
> inefficiencies :)

Well, there are 2 main issues with zsmalloc on bigger pages as I see it:
1) the granularity in allocations goes down due to the limited number of 
zsmalloc classes
2) the idea that an object can span 2 pages on a large page system turns 
out to be costly and inefficient.

And if you think about solving these problems you end up with something 
zblock like.

>>
>> Things keep changing, and some of the proven solutions may not be a good
>> fit moving forward. While not suggesting that we should have a handful
>> of zpool backends just for the sake of variety, I'd like to emphasize
>> that there are good reasons to have zblock (especially the Rust one),
>> and there are good reasons to keep zsmalloc. That leads to the
>> conclusion that zpool should stay.
> 
> IMHO, the needs for multiple allocators do not necessitate the zpool API.
> 
> The zpool API is only needed if you want to switch the allocators
> arbitrarily at runtime. This one is a much harder sell.
> 
> We can always add zblock, and select the backend via build options.
> Overtime, as zsmalloc improves to acquire zblock's advances, or zblock
> implements the missing features (migratability, compaction, etc.), we
> can unify/remove one of them.

I think migratability is no longer an issue. Compaction will be added 
along the way but it isn't a crucial feature for zblock because its 
fragmentation is harmless in the sense that temporarily empty slots act 
like a cache as opposed to being an unusable free space.

Best regards,
Vitaly


