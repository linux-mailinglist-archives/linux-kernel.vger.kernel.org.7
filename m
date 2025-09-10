Return-Path: <linux-kernel+bounces-810470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2A2B51B17
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB9BF1894D29
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05E3298994;
	Wed, 10 Sep 2025 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8No1AQZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5DC259CBC;
	Wed, 10 Sep 2025 15:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757516890; cv=none; b=hYHGjgoGvqCVBc3KwJtfrfgtmB5ClRxhyPT4yfvdVbplnmEfck6BVw9px7QaxhEJOKnaZUGiDjfib1jhSYmj9K81TdMd3YeP6T1MSb/gAmgBrlXxuEi9EDG3dYfAq2+ICDC/9VhD7e30e7FJtId/XrVAOFbkZbTTBi6mvs04vWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757516890; c=relaxed/simple;
	bh=bvZHnhmU6YFdTTKMEoziZPmXCSvh59ghlawVkMA6E7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k7mv7cyZuQsd3fpx5BL/iwPOQ2Rot0bWOclDIg0uDG3xSzW1mdcfEc6UaA29hnWLmifrUBatedLGC+WiPF0X9AEFHk3X0ptRfEthz3iNH2eA8xtRr3Y4CFYPEOS4FGVKoT33KZ62hYhrThDLamPHrq72nLYMwPFCInLvriN3K6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8No1AQZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE6CC4CEEB;
	Wed, 10 Sep 2025 15:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757516889;
	bh=bvZHnhmU6YFdTTKMEoziZPmXCSvh59ghlawVkMA6E7Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K8No1AQZcL4CTYlNtl4e0zQCljA7seKG6NzXcny2nBooRDPb+w00kcodm4m0Xloko
	 dsiTSyeLY3kVPv7F7/AHxaHEibx4CFstN7fYj9/8r3KWNKkxOGwB8fWgCPs9hRfGqw
	 VfqRxgHHo7bsCx5w8hXbd9MQyChumDIwSDMauNsdsFMmvn1DbpV4Plzsd6k2isn+yB
	 9JahEqE/Bo3qoyh5XaQjVQPLVkk9riEmbz24p6Ea7jPTCbvYoRIp4E1g9jHLP3r7E5
	 JVgmKQ0XDKbKz/pnzM+9BcFzqThXD3o/Uwc5S5tSASeL/i2igsWe56uzX+nQLjZIfY
	 tFSAjcZH7SIWA==
Message-ID: <953481fa-785b-4329-9306-51db6620f611@kernel.org>
Date: Wed, 10 Sep 2025 17:08:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rust: pin-init: add `#[bind]` attribute to access
 previously initialized fields
To: Benno Lossin <lossin@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Fiona Behrens <me@kloenk.dev>,
 Alban Kurti <kurti@invicto.ai>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250910100755.2361281-1-lossin@kernel.org>
 <aMFQL-Hq1KvBG5lh@google.com> <DCP1Y8N4SRRF.25V7F6PV5ODCQ@kernel.org>
 <CAH5fLgg+-oz_cP9=ke+ukp9qYZAsD=hKqvvGfkJWRcCKdrTQ-g@mail.gmail.com>
 <DCP456FHT625.1L5BVZ4LPD8VQ@kernel.org> <aMGE64_J5R8U_rk5@tardis-2.local>
 <DCP7JTWPA4QS.9PTE12UVZFDC@kernel.org>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <DCP7JTWPA4QS.9PTE12UVZFDC@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/10/25 4:59 PM, Benno Lossin wrote:
> On Wed Sep 10, 2025 at 4:02 PM CEST, Boqun Feng wrote:
>> On Wed, Sep 10, 2025 at 02:19:00PM +0200, Benno Lossin wrote:
>>> On Wed Sep 10, 2025 at 12:40 PM CEST, Alice Ryhl wrote:
>>>> On Wed, Sep 10, 2025 at 12:36 PM Benno Lossin <lossin@kernel.org> wrote:
>>>>>
>>>>> On Wed Sep 10, 2025 at 12:17 PM CEST, Alice Ryhl wrote:
>>>>>> On Wed, Sep 10, 2025 at 12:07:53PM +0200, Benno Lossin wrote:
>>>>>>> Assigning a field a value in an initializer macro can be marked with the
>>>>>>> `#[bind]` attribute. Doing so creates a `let` binding with the same
>>>>>>> name. This `let` binding has the type `Pin<&mut T>` if the field is
>>>>>>> structurally pinned or `&mut T` otherwise (where `T` is the type of the
>>>>>>> field).
>>>>>>>
>>>>>>> Signed-off-by: Benno Lossin <lossin@kernel.org>
>>>>>>
>>>>>> Is there a reason we can't apply this to all fields and avoid the
>>>>>> attribute?
>>>>>
>>>>> Adding the attribute was due to Boqun's concern on v1 [1]. I think it
>>>>> might be surprising too, but I'm also happy with no attribute.
>>>>>
>>>>> [1]: https://lore.kernel.org/all/aLshd0_C-1rh3FAg@tardis-2.local
>>>>
>>>> IMO the ideal is if it works without an attribute. Perhaps trying that
>>>> in the kernel is a reasonable experiment to find out whether that's
>>>> reasonable to do for the general language feature?
>>>
>>> @Boqun what is your opinion on this?
>>>
>>
>> If we plan to make the in-place initializer language feature behave
>> similar, as I asked here [1], then dropping `#[bind]` seems good to me.
> 
> I don't think we can promise how that language feature is going to look
> like. It will definitely support accessing already initialized fields,
> but in what form remains to be seen.

And as Alice said, getting some experience from real applications is not the
worst thing. We can always change it if we see it causing too much pain.

