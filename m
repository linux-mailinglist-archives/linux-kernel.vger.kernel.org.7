Return-Path: <linux-kernel+bounces-780004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2F4B2FC41
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66D801747B4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68883239E88;
	Thu, 21 Aug 2025 14:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="OF5LdvWf";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="Jf2Wgg3J"
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5394F2949E0
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755785731; cv=none; b=Y7qRGKFjrcVi0wS124RwuvydYsfLkcnLKrH9a/SGwTpolKfet0mQWptyKdt11XoHmu8ph+KI3gNUdN+kdbZrJB9hR3rwkx1uKKeyJpnXP79c18/ptNdJ7lmYyliYst0CwZ/7zgg43k4Ys55enaueMq1+fvyS0HBe5yEmjvOpKhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755785731; c=relaxed/simple;
	bh=efamSLhfQLINOtv7uJR+tW76sMP7oqxge0e3J1PCnDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uO7ov3qLb7qWLNRw8FVqE8n9R3Akg61Qf5N4I1l9NdHQJ0KakuF2LtqPSt/z7oV4Mq/B7a/ad/3B43JrC3uovJENods6Gida7VuOo67a6qNkGN89MESYL+J9KFfY0Ye3WaSDtfgskZPRb9uDKB9gpbcP3mUtqIsF/m5VbjhUs/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=OF5LdvWf; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=Jf2Wgg3J; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1755785727; x=1756390527;
	d=konsulko.se; s=rsa1;
	h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
	 subject:mime-version:date:message-id:from;
	bh=GsvDeHWgZc93f0po8wwYyN06rP47fEkn9doFP/7K+wk=;
	b=OF5LdvWfkSvMzcTHcMlUF39vdcWjEzEDTmzloomgJ6NfyC6x8w6taLxUYXvAByTttkJKQD5QjRlSm
	 EaoZkzevvggjEJPic7NGw2lN3GI5UT+AI2wJ2bxqjSN+PgIWhoGrjGUe/Mrk55Ut+grkQWZosTLXHH
	 lJdN8MmfSVJPGAblL52nE7sIY2HmD1ZNhGh1Me7Xvjrls7zVtKHxLgJpYCmZ50cx0wqMKEF4//8cVU
	 HvHqFM3BHr7pI4tpdAe3WORP9WmVeX+q21pgKE6Pq4RqGTg/zke3m824Kkab0LRw2atV2AJ5tTcgMf
	 u0ARy3Eu0cAEbR27bCBQczKJZnQEjPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1755785727; x=1756390527;
	d=konsulko.se; s=ed1;
	h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
	 subject:mime-version:date:message-id:from;
	bh=GsvDeHWgZc93f0po8wwYyN06rP47fEkn9doFP/7K+wk=;
	b=Jf2Wgg3JfJiS9bqME6Trr5NLTaI9eMvGOUZD4OsL7dogfQDVtmITkVTHCwPUwC7kaPB/xm9tFfMlt
	 8dMiRIXBw==
X-HalOne-ID: 4883bd8a-7e99-11f0-ba34-4f541c8bf1cc
Received: from [192.168.10.245] (host-95-203-16-218.mobileonline.telia.com [95.203.16.218])
	by mailrelay3.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 4883bd8a-7e99-11f0-ba34-4f541c8bf1cc;
	Thu, 21 Aug 2025 14:15:26 +0000 (UTC)
Message-ID: <27139676-8470-4067-b259-f01022751bbc@konsulko.se>
Date: Thu, 21 Aug 2025 16:15:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rust: zpool: add abstraction for zpool drivers
To: Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 Uladzislau Rezki <urezki@gmail.com>, Alice Ryhl <aliceryhl@google.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Miguel Ojeda
 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Johannes Weiner <hannes@cmpxchg.org>,
 Yosry Ahmed <yosry.ahmed@linux.dev>, Nhat Pham <nphamcs@gmail.com>,
 linux-mm@kvack.org
References: <20250821111718.512936-1-vitaly.wool@konsulko.se>
 <DC83A2M3G8EH.12FRM3C05ABCR@kernel.org>
 <DC83WSYHY3K1.1D3XEES0BIKGS@kernel.org>
Content-Language: en-US
From: Vitaly Wool <vitaly.wool@konsulko.se>
In-Reply-To: <DC83WSYHY3K1.1D3XEES0BIKGS@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/21/25 14:32, Danilo Krummrich wrote:
> On Thu Aug 21, 2025 at 2:03 PM CEST, Danilo Krummrich wrote:
>> On Thu Aug 21, 2025 at 1:17 PM CEST, Vitaly Wool wrote:
>>> +    /// preferred NUMA node `nid`. If the allocation is successful, an opaque handle is returned.
>>> +    fn malloc(
>>> +        pool: <Self::Pool as ForeignOwnable>::BorrowedMut<'_>,
>>> +        size: usize,
>>> +        gfp: Flags,
>>> +        nid: NumaNode,
>>> +    ) -> Result<usize>;
>>
>> I still think we need a proper type representation of a zpool handle that
>> guarantees validity and manages its lifetime.
>>
>> For instance, what prevents a caller from calling write() with a random handle?
>>
>> Looking at zsmalloc(), if I call write() with a random number, I will most
>> likely oops the kernel. This is not acceptable for safe APIs.
>>
>> Alternatively, all those trait functions have to be unsafe, which would be very
>> unfortunate.
> 
> I just noticed that I confused something here. :)
> 
> So, for the backend driver this trait is obviously fine, since you have to implement
> the C ops -- sorry for the confusion.
> 
> However, you still have to mark all functions except alloc() and total_pages()
> as unsafe and document and justify the corresponding safety requirements.

How is destroy() different from alloc() in terms of safety? I believe 
it's only free, read_{begin|end}, write that should be marked as unsafe.

>>> +    /// Free a previously allocated from the `pool` object, represented by `handle`.
>>> +    fn free(pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>, handle: usize);
>>
>> What happens if I forget to call free()?
>>
>>> +    /// Make all the necessary preparations for the caller to be able to read from the object
>>> +    /// represented by `handle` and return a valid pointer to the `handle` memory to be read.
>>> +    fn read_begin(pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>, handle: usize)
>>> +        -> NonNull<u8>;
>>
>> Same for this, making it a NonNull<u8> is better than a *mut c_void, but it's
>> still a raw pointer. Nothing prevents users from using this raw pointer after
>> read_end() has been called.
>>
>> This needs a type representation that only lives until read_end().
>>
>> In general, I think this design doesn't really work out well. I think the design
>> should be something along the lines of:
>>
>>    (1) We should only provide alloc() on the Zpool itself and which returns a
>>        Zmem instance. A Zmem instance must not outlive the Zpool it was allocated
>>        with.
>>
>>    (2) Zmem should call free() when it is dropped. It should provide read_begin()
>>        and write() methods.
>>
>>    (3) Zmem::read_begin() should return a Zslice which must not outlive Zmem and
>>        calls read_end() when dropped.
> 
> This design is obiously for when you want to use a Zpool, but not implement its
> backend. :)



