Return-Path: <linux-kernel+bounces-672843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85793ACD85A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 09:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AE303A3F2B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 07:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CF01EB19B;
	Wed,  4 Jun 2025 07:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iih1QpkM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773FA79EA;
	Wed,  4 Jun 2025 07:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749021518; cv=none; b=oYp+msYRKu4H6seNF2xFju3qIwiU7x2UOvoy7H0OIewbPie8aRkxyejo6Arj5kah3063ZLRqfcNfgTN428nC/zhahQKZzvmMlq40nOc7pQ6X3PFuMlb19XKogZ5SIXNluF168iTu32N1P1/oNBpxSaH6f72rJs3Du7RsUvBKNCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749021518; c=relaxed/simple;
	bh=hLV6bUQrXlzvrssls30vFCh548KG3Got5mJHkOfBrZE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=TUKBVt+8SueWwhgGgZ9SglQJZsojelT0s04NPXseXMldmF3OJth2xo0RMjmpRdIv9DtjeMRJU/ZbJj1M1YaFwSqoa3njgTjQheClq3iWA9v4WAmelquNovYc8g/0WKdfkUSmUheqgvwxW7r5MujXEf6A/ttvF3HlBJ+4gWA19CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iih1QpkM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45CBEC4CEE7;
	Wed,  4 Jun 2025 07:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749021517;
	bh=hLV6bUQrXlzvrssls30vFCh548KG3Got5mJHkOfBrZE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=iih1QpkMfxbsDlUAHq58TXJMsIkC8tbUwjHy5IpvIlgaDruw6V4+kZYqxpdwqRNmL
	 wnioY11fpwZFS0uK2W3iDN5MPTCtXv5J3lhhQhiOHtBa/4sEIvhx/1Wq2839gC15mY
	 lNkmheiTD+OKRABEajAtfk6eOI8Laah/kcz+TyfdRcEzJLAAxHUmst5/GByU+fyaCz
	 OBUJ4SbJzt4jsODMvDWQ1suuwzf/wwe4Y9ETvYr9MKALlOzC8SVnAoU/JqHxCI+GnN
	 i7A7+Df57sFynFYl8jaLjTCys7U8x0ePCnWqd9YpofNnY1giZSljV/FR1X99UggmSN
	 GrxxPW8M5B6tQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Jun 2025 09:18:31 +0200
Message-Id: <DADKDQ1KGJJP.3T20P9V1D2PO1@kernel.org>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Ben Skeggs" <bskeggs@nvidia.com>,
 "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Alistair Popple" <apopple@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 04/20] rust: add new `num` module with useful integer
 operations
From: "Benno Lossin" <lossin@kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <benno.lossin@proton.me>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>
X-Mailer: aerc 0.20.1
References: <20250521-nova-frts-v4-0-05dfd4f39479@nvidia.com>
 <20250521-nova-frts-v4-4-05dfd4f39479@nvidia.com>
 <DA82KFLNAOG7.R7YT4BHCLNZQ@kernel.org>
 <DA88YHU4AZT7.B8JGZHW9P9L9@nvidia.com>
 <DA8GTD7LT7KO.1A3LBQGEQTCEW@kernel.org>
 <DAC2L6ZKR6U2.WOMERUJIOENK@nvidia.com>
 <DAD9TNUBUGPN.1ED519FYR29U4@kernel.org>
 <DADB6892Z31G.12LB1BVSGTEAQ@nvidia.com>
In-Reply-To: <DADB6892Z31G.12LB1BVSGTEAQ@nvidia.com>

On Wed Jun 4, 2025 at 2:05 AM CEST, Alexandre Courbot wrote:
> On Wed Jun 4, 2025 at 8:02 AM JST, Benno Lossin wrote:
>> On Mon Jun 2, 2025 at 3:09 PM CEST, Alexandre Courbot wrote:
>>> On Thu May 29, 2025 at 4:27 PM JST, Benno Lossin wrote:
>>>> On Thu May 29, 2025 at 3:18 AM CEST, Alexandre Courbot wrote:
>>>>> On Thu May 29, 2025 at 5:17 AM JST, Benno Lossin wrote:
>>>>>> On Wed May 21, 2025 at 8:44 AM CEST, Alexandre Courbot wrote:
>>>>>>> +    /// Align `self` up to `alignment`.
>>>>>>> +    ///
>>>>>>> +    /// `alignment` must be a power of 2 for accurate results.
>>>>>>> +    ///
>>>>>>> +    /// Wraps around to `0` if the requested alignment pushes the =
result above the type's limits.
>>>>>>> +    ///
>>>>>>> +    /// # Examples
>>>>>>> +    ///
>>>>>>> +    /// ```
>>>>>>> +    /// use kernel::num::NumExt;
>>>>>>> +    ///
>>>>>>> +    /// assert_eq!(0x4fffu32.align_up(0x1000), 0x5000);
>>>>>>> +    /// assert_eq!(0x4000u32.align_up(0x1000), 0x4000);
>>>>>>> +    /// assert_eq!(0x0u32.align_up(0x1000), 0x0);
>>>>>>> +    /// assert_eq!(0xffffu16.align_up(0x100), 0x0);
>>>>>>> +    /// assert_eq!(0x4fffu32.align_up(0x0), 0x0);
>>>>>>> +    /// ```
>>>>>>> +    fn align_up(self, alignment: Self) -> Self;
>>>>>>
>>>>>> Isn't this `next_multiple_of` [1] (it also allows non power of 2
>>>>>> inputs).
>>>>>>
>>>>>> [1]: https://doc.rust-lang.org/std/primitive.u32.html#method.next_mu=
ltiple_of
>>>>>
>>>>> It is, however the fact that `next_multiple_of` works with non powers=
 of
>>>>> two also means it needs to perform a modulo operation. That operation
>>>>> might well be optimized away by the compiler, but ACAICT we have no w=
ay
>>>>> of proving it will always be the case, hence the always-optimal
>>>>> implementation here.
>>>>
>>>> When you use a power of 2 constant, then I'm very sure that it will ge=
t
>>>> optimized [1]. Even with non-powers of 2, you don't get a division [2]=
.
>>>> If you find some code that is not optimized, then sure add a custom
>>>> function.
>>>>
>>>> [1]: https://godbolt.org/z/57M9e36T3
>>>> [2]: https://godbolt.org/z/9P4P8zExh
>>>
>>> That's impressive and would definitely work well with a constant. But
>>> when the value is not known at compile-time, the division does occur
>>> unfortunately: https://godbolt.org/z/WK1bPMeEx
>>>
>>> So I think we will still need a kernel-optimized version of these
>>> alignment functions.
>>
>> Hmm what exactly is the use-case for a variable align amount? Could you
>> store it in const generics?
>
> Say you have an IOMMU with support for different pages sizes, the size
> of a particular page can be decided at runtime.
>
>>
>> If not, there are also these two variants that are more efficient:
>>
>> * option: https://godbolt.org/z/ecnb19zaM
>> * unsafe: https://godbolt.org/z/EqTaGov71
>>
>> So if the compiler can infer it from context it still optimizes it :)
>
> I think the `Option` (and subsequent `unwrap`) is something we want to
> avoid on such a common operation.

Makes sense.

>> But yeah to be extra sure, you need your version. By the way, what
>> happens if `align` is not a power of 2 in your version?
>
> It will just return `(self + (self - 1)) & (alignment - 1)`, which will
> likely be a value you don't want.

So wouldn't it be better to make users validate that they gave a
power-of-2 alignment?

> So yes, for this particular operation we would prefer to only use powers
> of 2 as inputs - if we can ensure that then it solves most of our
> problems (can use `next_multiple_of`, no `Option`, etc).
>
> Maybe we can introduce a new integer type that, similarly to `NonZero`,
> guarantees that the value it stores is a power of 2? Users with const
> values (90+% of uses) won't see any difference, and if working with a
> runtime-generated value we will want to validate it anyway...

I like this idea. But it will mean that we have to have a custom
function that is either standalone and const or in an extension trait :(
But for this one we can use the name `align_up` :)

Here is a cool idea for the implementation: https://godbolt.org/z/x6navM5WK

> (I can already hear you saying "send that to upstream Rust!" ^_^;)

This one isn't as clear I'd say. The stdlib of Rust is strict on what
gets added. Since they already have `next_multiple_of`, adding a
`prev_multiple_of` sounds very reasonable, but a new type for powers of
2? That could be something they don't want to add. Ultimately I don't
know, but if we need it, we should build it ourselves first :)

---
Cheers,
Benno

