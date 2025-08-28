Return-Path: <linux-kernel+bounces-789679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2893B398F9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8739F7AB4F5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19D93043D8;
	Thu, 28 Aug 2025 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="rsbvXDcc";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="7ZdJTIn4"
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEA2302CAB
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 10:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756375271; cv=none; b=JmfRRL+r9bjVHFOX4Vn4uTmkjAQV8ulIuEIgFH0ET/XcEPw77aD4J9OQ+A4LZIQfR3rHND2X+CVzaI7MoT4YDOnKDw1lQOPSB0qCnBFH6hYZQOiZ209DOvbzUP4sH66hfU3T+lgkbQfhp+0K0OiMOs8/ggYIbtCRqX0YpqwZl1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756375271; c=relaxed/simple;
	bh=Vv+ImGC1QDb0afEqRqGqb+xQ34cL6lHTLcY7kDcR++g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tpF2bkjgzXWexVWXUY8DemuRTbKYOflFHvTGNhWOg4fjB/RU37g6BTJyjeHW8XQd/n2k+USr2hMVB4plbBj1JBtg2QSJL90bxZ5EhMKyCJrKFWKkNv0LQm8KoApYGXATguQVvtDUHBRrZQCCNocCIgNmPhOqZs7BexzV9qlBKNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=rsbvXDcc; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=7ZdJTIn4; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1756375267; x=1756980067;
	d=konsulko.se; s=rsa2;
	h=content-transfer-encoding:content-type:in-reply-to:references:cc:to:from:
	 subject:mime-version:date:message-id:from;
	bh=zAFcuTOsjFedDbDPzSuDb7+jYLKRszwwA6XBeXDqbsE=;
	b=rsbvXDccnCmYC1ppx6HmqRRi10XQ8PdWuZPcWhPGeAHTpAyPV/GRb0pCgAOmM5Au2h2Cd6rdIcSMs
	 cgYZbUIZs3tkWMpMSjSeQRU7OFfYFZQ3YcUNN73zHgd5/v20LDVU4lvq/RiR/x0kKUDwISTf7XwgjI
	 hKiKemzPR5dRRRhKVeSYOpI+g0qad7eRIxLevkIXOioZzn7g6Z9c0G9eZhu0iALVtGVdPZcguP5wS5
	 uT2Iq3iuNg8pXZldwgtR1MRxwmYfV7glFe7fQIOJ2nkTk+tosRs+A+klzk/328seCwbb3pXldbpk3V
	 iAAwqxQ2qN6YWapnr+bdq5n33GkiUaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1756375267; x=1756980067;
	d=konsulko.se; s=ed2;
	h=content-transfer-encoding:content-type:in-reply-to:references:cc:to:from:
	 subject:mime-version:date:message-id:from;
	bh=zAFcuTOsjFedDbDPzSuDb7+jYLKRszwwA6XBeXDqbsE=;
	b=7ZdJTIn4UbYjsUHr/FZLziU9VwkxS5MDmxWqoghzK8XHEFdoZScrBXEB4bsP08cuYJ3WxdRfbYuPn
	 TqLnRqhBg==
X-HalOne-ID: e94213e7-83f5-11f0-ad4c-f7376af24660
Received: from [192.168.10.245] (host-95-203-16-218.mobileonline.telia.com [95.203.16.218])
	by mailrelay6.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id e94213e7-83f5-11f0-ad4c-f7376af24660;
	Thu, 28 Aug 2025 10:01:06 +0000 (UTC)
Message-ID: <d91e6483-c5a6-468f-b40e-1acdd28a80cd@konsulko.se>
Date: Thu, 28 Aug 2025 12:01:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] rust: zpool: add abstraction for zpool drivers
From: Vitaly Wool <vitaly.wool@konsulko.se>
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
References: <20250823130420.867133-1-vitaly.wool@konsulko.se>
 <20250823130522.867263-1-vitaly.wool@konsulko.se>
 <DCCCRYEUVJWZ.2AUDA0DXK0XSF@kernel.org>
 <b1509e7f-4817-4466-bd2b-c083f024c0d4@konsulko.se>
Content-Language: en-US
In-Reply-To: <b1509e7f-4817-4466-bd2b-c083f024c0d4@konsulko.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

<snip>
>>> +    extern "C" fn destroy_(pool: *mut c_void) {
>>> +        // SAFETY: The pointer originates from an `into_foreign` call.
>>> +        T::destroy(unsafe { T::Pool::from_foreign(pool) })
>>> +    }
>>> +    extern "C" fn malloc_(
>>> +        pool: *mut c_void,
>>> +        size: usize,
>>> +        gfp: u32,
>>> +        handle: *mut usize,
>>> +        nid: c_int,
>>> +    ) -> c_int {
>>> +        // SAFETY: The pointer originates from an `into_foreign` 
>>> call. If `pool` is passed to
>>> +        // `from_foreign`, then that happens in `_destroy` which 
>>> will not be called during this
>>> +        // method.
>>> +        let pool = unsafe { T::Pool::borrow_mut(pool) };
>>
>> Wait, can't this happen concurrently to all the other functions that 
>> borrow the
>> pool? This would be undefined behavior, no?
> 
> Theoretically, yes, but since pool is actually Box<T>, it's only the 
> inner T that is mutable.
> 
> Anyway, the only reason for malloc() to require a mutable reference is 
> that the backend implementation *may* use RBTree::cursor_lower_bound() 
> which requires a mutable reference of the tree.
> 
> Would it be okay if I
> * change the Zpool API so that malloc takes an immutable reference
> * extend the RBTree API with a cursor_lower_bound analog which doesn't 
> require a mutable tree?

As a matter of fact, the RBTree change may be postponed and submitted 
together with zblock, it is not relevant until then.

~Vitaly

