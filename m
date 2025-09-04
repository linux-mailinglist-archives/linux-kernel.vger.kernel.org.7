Return-Path: <linux-kernel+bounces-800963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CD2B43E41
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CCC017ECAB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6445306D50;
	Thu,  4 Sep 2025 14:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="cOebGlCu";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="XDWBDbeY"
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AA33064AF
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 14:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995075; cv=none; b=ALhX1u9X3ySfQpZu9w7lsjmzCxqOQbKkwZtVKFXpsR+Q3QfDLdENiQpM0VqiAyU5CF27g4pKjYkbrK8vRus2LzKx4Tyn1x9xYDSO3PxoXIupg5G+9ywgHpRI4W9kCXcAt2P63+z/cxwHH/VzU8WXgHErxsP9zo3WEZ3BwV8cLE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995075; c=relaxed/simple;
	bh=QHbL/EbU4wmm902gFUKVyUaplUVoIhFDBCYVyUxrLHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gbEKBhm+t2Ck5WY/KFQDTrEV7HlWyOR69tEOZjw44PNsbMk3I+lW8g8uuvm6h6p+jsMhvLcX+8tFg7mmZUOZ4BPyWc1JIU5vBYP4S4OWDXaiMVD+XKNcx4lXGK3vDfiSDTRGjrXJmvuQt9exshpGbx8cXesYsxiZnumWjj4bkVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=cOebGlCu; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=XDWBDbeY; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1756995065; x=1757599865;
	d=konsulko.se; s=rsa2;
	h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
	 subject:mime-version:date:message-id:from;
	bh=Cuct/RPYsog3+FtV3cKt5Z3ifZSx4ZMCF7gpniW4mCI=;
	b=cOebGlCuczRNUo4g4d4ajARv60jt0S+Wqh8jmDRu9Mf8FSF2YmYLUMztYuqnrS4XJpBsG/xg1SVS+
	 RnSqIoV1kkhmJ4y3BDMWwp5XlyiWt/dFGIGcOHfmUIv+yMDcvE7rBC6BuBYcbNTCMLLdohKwwSWIsl
	 nC4aiyT77ewScMsTXAI7wi46r4YPrGNI7i0JyYiDSX0gPwx1U8UKy0JTnqVk+rwcy96mexlsJ+pUsV
	 dA/VEP8cYUpBEbkmua1h4auMdHVoG9vmCwmZNmGUM5Ek3Tug3qqjnV7ewydRTgOPCEnLgz8xfRCcql
	 OOOQ0wMx2o5PiJZkInAIMx7sRP3Mf5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1756995065; x=1757599865;
	d=konsulko.se; s=ed2;
	h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
	 subject:mime-version:date:message-id:from;
	bh=Cuct/RPYsog3+FtV3cKt5Z3ifZSx4ZMCF7gpniW4mCI=;
	b=XDWBDbeYOioZ7VHX+LhpdlOj714dmqlpXCpsNZKSu/SjlWyYcRG8rDDbnJO5SdO9yda8iNTFDQHot
	 PnZ+fFgCg==
X-HalOne-ID: fd8e0ca1-8998-11f0-9595-c9fa7b04d629
Received: from [192.168.10.245] (host-95-203-16-218.mobileonline.telia.com [95.203.16.218])
	by mailrelay1.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id fd8e0ca1-8998-11f0-9595-c9fa7b04d629;
	Thu, 04 Sep 2025 14:11:04 +0000 (UTC)
Message-ID: <1d42c513-cc83-4f08-a10c-cbd6206070f4@konsulko.se>
Date: Thu, 4 Sep 2025 16:11:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] mm: remove zpool
To: Vlastimil Babka <vbabka@suse.cz>, hannes@cmpxchg.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>
References: <20250829162212.208258-1-hannes@cmpxchg.org>
 <20250904093325.2768507-1-vitaly.wool@konsulko.se>
 <7b1ca42d-1b89-44f4-bffb-e6b09f86fdc5@suse.cz>
Content-Language: en-US
From: Vitaly Wool <vitaly.wool@konsulko.se>
In-Reply-To: <7b1ca42d-1b89-44f4-bffb-e6b09f86fdc5@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/4/25 12:13, Vlastimil Babka wrote:
> On 9/4/25 11:33, Vitaly Wool wrote:
>>> With zswap using zsmalloc directly, there are no more in-tree users of
>>> this code. Remove it.
>>>
>>> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
>>
>> Per the previous discussions, this gets a *NACK* from my side. There is
>> hardly anything _technical_ preventing new in-tree users of zpool API.
>> zpool API is neutral and well-defined, I don’t see *any* good reason for
>> it to be phased out.
> 
> AFAIK it's a policy that unused code should be removed ASAP. And that's the
> case for zpool after Patch 1, no? It could be different if another user was
> about to be merged (to avoid unnecessary churn), but that doesn't seem the
> case for zblock?

For the C implementation of zblock, no. But there's another 
implementation which is in Rust and it's nearing the submission.

> My concern would be if the removal breaks any existing installations relying
> on zswap. Presumably not as a make oldconfig will produce a config where
> nothing important is missing, and existing boot options such as
> "zswap.zpool=" or attempts to write to in the init scripts to
> "/sys/module/zswap/parameters/zpool" will cause some errors/noise but not
> prevent booting correctly?

I don't expect heavy breakage but misconfigurations will definitely occur.
> I mean if we were paranoid and anticipated somebody would break their
> booting if writing to /sys/module/zswap/parameters/zpool failed, we could
> keep the file (for a while) and just produce a warning in dmesg that it's
> deprecated and does nothing?
> 
>  From Patch 1:
> 
>> Note that this does not preclude future improvements and experiments
>> with different allocation strategies. Should it become necessary, it's
>> possible to provide an alternate implementation for the zsmalloc API,
>> selectable at compile time. However, zsmalloc is also rather mature
>> and feature rich, with years of widespread production exposure; it's
>> encouraged to make incremental improvements rather than fork it.
> 
> With my history of maintaining the slab allocators I can only support this
> approach.

There was the time when slab was the best option and it was more mature 
than slub, which is now the best and only option. Thus, the "maturity" 
point is indeed valid but not being backed by anything else it doesn't 
weigh too much. Besides, zsmalloc's production exposure from all I know 
is limited to the 4K page case, and zsmalloc is truly struggling when 
the system is configured for 16K pages.

Things keep changing, and some of the proven solutions may not be a good 
fit moving forward. While not suggesting that we should have a handful 
of zpool backends just for the sake of variety, I'd like to emphasize 
that there are good reasons to have zblock (especially the Rust one), 
and there are good reasons to keep zsmalloc. That leads to the 
conclusion that zpool should stay.



