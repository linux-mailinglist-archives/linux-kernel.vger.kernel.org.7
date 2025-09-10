Return-Path: <linux-kernel+bounces-810242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB27EB517A0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5460B18963AA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2EE319852;
	Wed, 10 Sep 2025 13:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKvmEZDs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805BF27F747;
	Wed, 10 Sep 2025 13:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757509798; cv=none; b=dmomTd02XsH3mRGfrUIE0N1QFGdQo559ilRqeLwJyussS0RSjqZVJgpEoCKIa6tTLu1P1mkpUm6yBW6OTZnEuh9+fiwScFPTrl5IemruZ/InyJwuHrKMEiGZdHN8wuvigx8oqU2OOcvTW+BErJdU0JkLXzXIwmbtSSWmpGPk8SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757509798; c=relaxed/simple;
	bh=iLmuguLVeJCxIUtqOKnKeofmTqL0aKKhxJv9kZsu7nU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bR9iwpKvXhV8YZpJ/0xHY1Jrrt3HIH0FxD8g2izhFU8k8VBBRazYnuSYIy2XOBLI6Nq+6arkM3jxYLEevyPBldOWLT1WH79cMzZs7kVlRzUlP3BhsgtRkIDMsBH4BkWcT4UT9+geAZnN62gmGb1zxfhVR/1l5OIf+hkZ1S11hLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKvmEZDs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBEEC4CEF0;
	Wed, 10 Sep 2025 13:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757509798;
	bh=iLmuguLVeJCxIUtqOKnKeofmTqL0aKKhxJv9kZsu7nU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JKvmEZDsVQVaJoklNPIucyvbrJh/O0/aP7kJcJvLWK1dS/yq12Yh4KMyBPUiqd6ty
	 gvT6bISQ6GZAOkx/qpGP3dF7R8PB5Zb3LP2B5uqMS+5qoaH036RcSKcCRT1rTUivI1
	 JJas35q+LAAV0U1xQM7zqNE/jcFTqGeCwfyTZPCSGb6wS5gDnpKNSlRI1WG5LIPthx
	 X4Z/1biq3ICdzFog/i/qbp6RVWG2Dj70jV46UoXxEs/i0E9UmMSH6kVsqkSe/qaRJt
	 7v/v0PEVfgK2r9d0bJZ4rrzyQdARhlHVJCSNpKiEefOyLd8AhGtdwkXB/8iGFHQwvK
	 ikavh2HodZ9Uw==
Message-ID: <b31ed7c6-03ca-4d11-80fe-01a73bdab473@kernel.org>
Date: Wed, 10 Sep 2025 15:09:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rust: pin-init: add `#[bind]` attribute to access
 previously initialized fields
To: Alice Ryhl <aliceryhl@google.com>
Cc: Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Fiona Behrens <me@kloenk.dev>,
 Alban Kurti <kurti@invicto.ai>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250910100755.2361281-1-lossin@kernel.org>
 <aMFQL-Hq1KvBG5lh@google.com> <DCP1Y8N4SRRF.25V7F6PV5ODCQ@kernel.org>
 <CAH5fLgg+-oz_cP9=ke+ukp9qYZAsD=hKqvvGfkJWRcCKdrTQ-g@mail.gmail.com>
 <DCP2STI9M1XX.3RHBQDPQOC3JO@kernel.org>
 <CAH5fLgjS+T1acN9jsEv85bhhXwevSA2trqu-9aFFsKpH82b8iA@mail.gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <CAH5fLgjS+T1acN9jsEv85bhhXwevSA2trqu-9aFFsKpH82b8iA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/10/25 1:52 PM, Alice Ryhl wrote:
> On Wed, Sep 10, 2025 at 1:15 PM Danilo Krummrich <dakr@kernel.org> wrote:
>>
>> On Wed Sep 10, 2025 at 12:40 PM CEST, Alice Ryhl wrote:
>>> On Wed, Sep 10, 2025 at 12:36 PM Benno Lossin <lossin@kernel.org> wrote:
>>>>
>>>> On Wed Sep 10, 2025 at 12:17 PM CEST, Alice Ryhl wrote:
>>>>> On Wed, Sep 10, 2025 at 12:07:53PM +0200, Benno Lossin wrote:
>>>>>> Assigning a field a value in an initializer macro can be marked with the
>>>>>> `#[bind]` attribute. Doing so creates a `let` binding with the same
>>>>>> name. This `let` binding has the type `Pin<&mut T>` if the field is
>>>>>> structurally pinned or `&mut T` otherwise (where `T` is the type of the
>>>>>> field).
>>>>>>
>>>>>> Signed-off-by: Benno Lossin <lossin@kernel.org>
>>>>>
>>>>> Is there a reason we can't apply this to all fields and avoid the
>>>>> attribute?
>>>>
>>>> Adding the attribute was due to Boqun's concern on v1 [1]. I think it
>>>> might be surprising too, but I'm also happy with no attribute.
>>>>
>>>> [1]: https://lore.kernel.org/all/aLshd0_C-1rh3FAg@tardis-2.local
>>>
>>> IMO the ideal is if it works without an attribute. Perhaps trying that
>>> in the kernel is a reasonable experiment to find out whether that's
>>> reasonable to do for the general language feature?
>>>
>>>>> Do we have a place that might be able to use this?
>>>>
>>>> I didn't find one, but Danilo plans to base some changes on top this
>>>> cycle that need this.
>>
>> We can use it in devres right away:
>>
>> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
>> index d04e3fcebafb..97c616a1733d 100644
>> --- a/rust/kernel/devres.rs
>> +++ b/rust/kernel/devres.rs
>> @@ -137,10 +137,11 @@ pub fn new<'a, E>(
>>      {
>>          let callback = Self::devres_callback;
>>
>> -        try_pin_init!(&this in Self {
>> +        try_pin_init!(Self {
>>              dev: dev.into(),
>>              callback,
>>              // INVARIANT: `inner` is properly initialized.
>> +            #[bind]
>>              inner <- Opaque::pin_init(try_pin_init!(Inner {
>>                      devm <- Completion::new(),
>>                      revoke <- Completion::new(),
>> @@ -150,8 +151,7 @@ pub fn new<'a, E>(
>>              //
>>              // [1] https://github.com/Rust-for-Linux/pin-init/pull/69
>>              _add_action: {
>> -                // SAFETY: `this` is a valid pointer to uninitialized memory.
>> -                let inner = unsafe { &raw mut (*this.as_ptr()).inner };
>> +                let inner = core::ptr::from_ref(inner.into_ref().get_ref());
> 
> Overall looks good. Looks like you want Opaque::get here rather than
> the cast cast cast operation.

Oh, indeed. I overlooked that. :)


