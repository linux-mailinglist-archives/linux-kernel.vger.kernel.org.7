Return-Path: <linux-kernel+bounces-806382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 335FDB495CB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD9C24C3AE8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CC33101D3;
	Mon,  8 Sep 2025 16:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="NgTF32Yn";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="mvMbg9/x"
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CF930F7FC
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349694; cv=none; b=iAZLQa4hbdO6yt9YeLipSE0o9bS6dZeEM3icUit1Vv4zULZV52O+2tWCatDVyenri0G5yNhky6PiwLHmiaHEi8kr6JnWQssXHr/DdjSq1CgPiUs3vCPTSUN9t5VGvAhituisI1GA/53yREFNq/c+iwDtdOMldn7lEecRu6ncI+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349694; c=relaxed/simple;
	bh=YwVHjebInMG9oRr4lXfDXYZj58EE7Jryy5HDdz/NCP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i6s/TPP8Xr32uNFg/bkpgJ2JYuSLRpglAX/uwsNSYGxJc16dhHr1NUcdGHw2DskBKDua+gKLwqB2YydEjPPXgRz2ocm51iFVQqE2HvYEdw2Lk+Opinj7zMlMKlKxeIZZEkIbT8VwC6Bs0mWpkfjJfABrCFIKzF2xLdnE85gaacU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=NgTF32Yn; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=mvMbg9/x; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757349689; x=1757954489;
	d=konsulko.se; s=rsa2;
	h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
	 subject:mime-version:date:message-id:from;
	bh=bFsyjTOyd4JD8d4bOCK504vL4o/OhXeaSEq77/oqhG8=;
	b=NgTF32YndEsPp6zMQUA5gmnHyRZcg/hbk5BHMXHZQJF+aH7lbtiknMdR+sJur9Zi6fIilCIqxEkH9
	 EKrqbdXLlWzPHnKzBmPoATAFI1tNk7xWO291axr1xuxQdgPI0kV9Q3UBMbdCk5aeTvMKw5pd4Syew3
	 X0Y3Yl8KwHAOCWndUf5J03baikXS+uPGMKHzP0ty+U5n2ZyrvH20j8CnZPkY+8hVa6MURZvPYl5glL
	 kFEo7mpRJpgqOuwuB5HR1LTqVry/tgH/aTkshItHngJtWadV0CrM+YVaQeyhTzXYDhP3R6qTfVqVlF
	 w++4IlJIZXey7V2VZSt/zpv5Lhe+8pA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757349689; x=1757954489;
	d=konsulko.se; s=ed2;
	h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
	 subject:mime-version:date:message-id:from;
	bh=bFsyjTOyd4JD8d4bOCK504vL4o/OhXeaSEq77/oqhG8=;
	b=mvMbg9/xcAJKj8Hd4iByCa/rX/pDrr2AAUdQ39qzL7CLBlXLHoO6S8MHYI43HNWkNXuCJTBfD0ofc
	 NduVeaAAw==
X-HalOne-ID: a9fc7ba8-8cd2-11f0-8147-f7376af24660
Received: from [192.168.10.245] (host-95-203-16-218.mobileonline.telia.com [95.203.16.218])
	by mailrelay6.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id a9fc7ba8-8cd2-11f0-8147-f7376af24660;
	Mon, 08 Sep 2025 16:41:29 +0000 (UTC)
Message-ID: <99eff662-417c-4adb-b7dc-7f3053a4d616@konsulko.se>
Date: Mon, 8 Sep 2025 18:41:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rust: rbtree: add immutable cursor
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, =?UTF-8?Q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>
References: <20250908125339.3313777-1-vitaly.wool@konsulko.se>
 <CANiq72mekzqaNak+KYxqzxOeKpmNDYPO2bvATw6FkOjHWO1w0w@mail.gmail.com>
Content-Language: en-US
From: Vitaly Wool <vitaly.wool@konsulko.se>
In-Reply-To: <CANiq72mekzqaNak+KYxqzxOeKpmNDYPO2bvATw6FkOjHWO1w0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/8/25 18:36, Miguel Ojeda wrote:
> On Mon, Sep 8, 2025 at 2:54 PM Vitaly Wool <vitaly.wool@konsulko.se> wrote:
>>
>> Sometimes we may need to iterate over, or find an element in a read
>> only (or read mostly) red-black tree, and in that case we don't need a
>> mutable reference to the tree, which we'll however have to take to be
>> able to use the current (mutable) cursor implementation.
>>
>> This patch adds a simple immutable cursor implementation to RBTree,
>> which enables us to use an immutable tree reference. The existing
>> (fully featured) cursor implementation is renamed to CursorMut,
>> while retaining its functionality.
>>
>> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
> 
> Could you apply the `&raw` operator suggestion from v2 so that we
> don't have to migrate those later?

Absolutely, I wonder though if I'm supposed to do that only for the code 
I'm adding, or for the whole file, and if the latter is the preferred 
way, if that should be arranged as a 1st patch in a 2 patch series. What 
would you recommend?

> Thanks!
> 
> (For some reason I am not Cc'd)

Sorry about that, will surely add you for the v4.

Best regards,
Vitaly

