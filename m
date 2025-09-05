Return-Path: <linux-kernel+bounces-802806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E94DCB4572E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 906753A9B3E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECF434A32A;
	Fri,  5 Sep 2025 12:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="NZ4B7WJy";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="ZErcmkJW"
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF2527AC3D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757073834; cv=none; b=Hu9cJFLXWWTQNJfjwNu833qIZTThhBbNDhmFcjceLu6cYF5paOIShuwUjPXHIWidDpOnRiC6zTDN+1Y4v4t2XaYnAxBp+hcU7D/vz+7eqM7FYdjsqXJYx+yt7aMEpDkB2lTv1giChZ4Sn5SgkV+MoaLoM9gQV8Q2p3THl+gyRs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757073834; c=relaxed/simple;
	bh=rCL2ASRdfQiNdcIJUceXJl8EfVMcj5aVO26he0VLMmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NzXT49bTqyYp70BpOIA5e37EZ3xhvUqHLtPSekHVDXZMVpcKX5T0yaen21JoF5SGfWaGJeDJK2IPNG7NIINBZtQKnOk0fe18XVPK/djHLi6t9de292AqttTWqoxTwhpuZxx37f2TxX03B2PXUxdoalHaXasb6WdEdswvGUl1bCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=NZ4B7WJy; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=ZErcmkJW; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757073825; x=1757678625;
	d=konsulko.se; s=rsa2;
	h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
	 subject:mime-version:date:message-id:from;
	bh=4lT96qRu0B7WnFHrHqRSMSqB3AcU/t9e++Ul2OxkBts=;
	b=NZ4B7WJyCkuvvWe+8/kOVc88qCQz1R09Sm/iphxSmGP/cLkImXIEZJteH9drIeedFoVO721rcI1ZB
	 7YORVBtpEAQlSwSiguNyZZpy6fuO1wHBAMWSN3VakwZWxVGoelpCd2xUbS5/LO1EcjORfrktjwl+vk
	 vwVN5O6R8AW4rt6zjiBbFUAdm0Ir/gu5F1qVFt9xi7Rr35STwviiq+q1J+3JD1oFXoZf8UZeu15QOG
	 SPh7LX8XFG10s0TlsW6Cr/VrUiTpDiyS544OaLqDWUvTx8NrVV5MzAeNDEuJytjHC/IUl2ajexRh39
	 0It9pSzN2mksSd3a2XXFhh8PtpOccwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757073825; x=1757678625;
	d=konsulko.se; s=ed2;
	h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
	 subject:mime-version:date:message-id:from;
	bh=4lT96qRu0B7WnFHrHqRSMSqB3AcU/t9e++Ul2OxkBts=;
	b=ZErcmkJWrxAGuYVv6lFP9TeOcvcbIhp0ZtAnQMhQL89kJyKB8BCTmxnHMoBJLgdZ06kpqV1HOyeNh
	 NaKweGRAQ==
X-HalOne-ID: 5e268e94-8a50-11f0-a450-d510462faafc
Received: from [192.168.10.245] (host-95-203-16-218.mobileonline.telia.com [95.203.16.218])
	by mailrelay4.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 5e268e94-8a50-11f0-a450-d510462faafc;
	Fri, 05 Sep 2025 12:03:44 +0000 (UTC)
Message-ID: <8feaad36-7d58-48a0-b83d-d503e3343ed6@konsulko.se>
Date: Fri, 5 Sep 2025 14:03:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] rust: zpool: add abstraction for zpool drivers
To: Vlastimil Babka <vbabka@suse.cz>, Johannes Weiner <hannes@cmpxchg.org>
Cc: rust-for-linux <rust-for-linux@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Miguel Ojeda
 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Yosry Ahmed <yosry.ahmed@linux.dev>,
 Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org
References: <20250823130420.867133-1-vitaly.wool@konsulko.se>
 <20250826124454.GA1502@cmpxchg.org>
 <CB3E7E9C-2192-4C60-B79A-932AD6CB005A@konsulko.se>
 <c0b9d34e-1a21-4a97-b898-c33f7c8b49dd@suse.cz>
Content-Language: en-US
From: Vitaly Wool <vitaly.wool@konsulko.se>
In-Reply-To: <c0b9d34e-1a21-4a97-b898-c33f7c8b49dd@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/5/25 08:58, Vlastimil Babka wrote:
> On 8/26/25 16:56, Vitaly Wool wrote:
>>
>>
>>> On Aug 26, 2025, at 2:44 PM, Johannes Weiner <hannes@cmpxchg.org> wrote:
>>>
>>> On Sat, Aug 23, 2025 at 03:04:19PM +0200, Vitaly Wool wrote:
>>>> Zpool is a common frontend for memory storage pool implementations.
>>>> These pools are typically used to store compressed memory objects,
>>>> e. g. for Zswap, the lightweight compressed cache for swap pages.
>>>>
>>>> This patch provides the interface to use Zpool in Rust kernel code,
>>>> thus enabling Rust implementations of Zpool allocators for Zswap.
>>>
>>> The zpool indirection is on its way out.
>>>
>>> When you submitted an alternate allocator backend recently, the
>>> resounding feedback from the zswap maintainers was that improvements
>>> should happen to zsmalloc incrementally. It is a lot of code and has a
>>> lot of features that go beyond allocation strategy. We do not want to
>>> fork it and fragment this space again with niche, incomplete backends.
>>>
>>> It's frustrating that you not only ignored this, but then went ahead
>>> and made other people invest their time and effort into this as well.
>>>
>>
>> I don’t think we have a consensus on that.
>>
>> And zblock is, after some additional improvements, just better than
>> zsmalloc in all meaningful aspects, let alone the simplicity. It is fas
>> easier to implement in Rust than zsmalloc, too. Besides, zram is a good
>> candidate to be rewritten in Rust as well and after that is done, zblock
> 
> If your target is zram (not zswap) then I don't understand why insist on the
> zpool layer, as zram refused to adopt it in the first place?

The target is zswap in the first place.

Then, I apologize for quoting myself, but what I wrote was "zram is a 
good candidate to be rewritten in Rust", and I still hold on to this 
idea. zram can be greatly simplified by that rewrite and the code line 
savings will be far more than 700.

So, back to my point in the initial post. When/if zram is rewritten in 
Rust it will make more sense for it to use an allocator which is also 
written in Rust rather then zsmalloc, provided that the allocator 
written in Rust is good enough. And *that* will leave zsmalloc a niche 
backend.

You see,

>> will be even safer and faster. So while not being “incomplete", it’s
>> zsmalloc that is becoming a niche backend moving forward, and I would
>> argue that it could make more sense to eventually obsolete *it* rather
>> than the zpool API.
>>
>> ~Vitaly
> 
> 


