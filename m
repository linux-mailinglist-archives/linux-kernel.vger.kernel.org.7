Return-Path: <linux-kernel+bounces-747800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70244B13879
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F30DD3AB02B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A638234984;
	Mon, 28 Jul 2025 10:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/1wItD5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E965B7483;
	Mon, 28 Jul 2025 10:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753696895; cv=none; b=PXlXGaz1fQGLQjmi+ZMzkk7/rWbi9tcbTg1xpR9g83WeWfqXtbJowQEd2OUjwh4X3upQOS3MEpvEz+H+iueNGPc3q2wTWMh8GV76jE2T65RVRLuss3pFYGZDPpKDEWKcDXC59+s0VYw25+QxGAhhSbacpGQKRS39HCxsbCc0bOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753696895; c=relaxed/simple;
	bh=kTuUkUsd13QnoVQ3yYmQ6WdExLMJS9IjNiFB3TnS/ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rnXul+8lR7hCgKDRDbH2EUwG6/LJnAaAyfJHS+PdNvgSIueEWcOvQCyV0w0kP1Efrs0klMloKLaR9javZ24MDrU69ynmwlBM2fhU5jXPlgyFHaCAzg/5FhIP2ZBYE7UWwoBhS6qMLdYYTJzmVqtYYP58/mvSenetnoKmN28jxQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/1wItD5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C69CC4CEE7;
	Mon, 28 Jul 2025 10:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753696894;
	bh=kTuUkUsd13QnoVQ3yYmQ6WdExLMJS9IjNiFB3TnS/ps=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E/1wItD5UfYnN1EeJpWHnZ9oR8Kj71XeQWzlztjb5ngxcGj/qcnwJWZRZ/CFgLlnl
	 nOP8q8gf1o9IcZVD+t93VWuA4+i7/t9cfDaaE897Ld029eGYnar3/nFH4dS5/GfrPH
	 elGeECdUymPmEzB18YPEYPQefsGPVW1ReKH9C65FMLqxiW8c8Hs+t3fGKg6HSK6SjB
	 VPXoVNrCm8MK3jl6ZMU3PCvSPgrdK2QAmNHjiWMC9u9h7JtZnL29i54c2amumauiJ5
	 a/QzZG5h00z815K1A+mrxf/B/FFt9qea9gLrlGQU/StGxiiMhQZCMY4QKzJUUu8U+F
	 JF0p3FB1aNx+Q==
Message-ID: <10506c57-1629-4ca2-9c3f-3e97e68caa7a@kernel.org>
Date: Mon, 28 Jul 2025 12:01:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rust: transmute: add `as_bytes` method for `AsBytes`
 trait
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, Andreas Hindborg
 <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Trevor Gross <tmgross@umich.edu>,
 "Christian S. Lima" <christiansantoslima21@gmail.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250726-as_bytes-v3-1-eb7514faab28@nvidia.com>
 <CAH5fLghNDDo0HKupPXe8G6z2TP4TJE881Bd76k0LDjSm75KcEQ@mail.gmail.com>
 <aIX-JDehurnGYppE@google.com> <DBMUEH5MYR2L.CXM12OIUH7TZ@kernel.org>
 <DBNDJGIUQC1L.3EYGJ1ROIGMBY@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <DBNDJGIUQC1L.3EYGJ1ROIGMBY@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/28/25 5:39 AM, Alexandre Courbot wrote:
> On Sun Jul 27, 2025 at 9:39 PM JST, Benno Lossin wrote:
>> On Sun Jul 27, 2025 at 12:23 PM CEST, Alice Ryhl wrote:
>>> On Sun, Jul 27, 2025 at 08:52:00AM +0200, Alice Ryhl wrote:
>>>> On Sat, Jul 26, 2025 at 4:47 AM Alexandre Courbot <acourbot@nvidia.com> wrote:
>>>>> diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
>>>>> index 1c7d43771a37b90150de86699f114a2ffb84db91..69c46c19a89191d8a2abc5801564cacda232218c 100644
>>>>> --- a/rust/kernel/transmute.rs
>>>>> +++ b/rust/kernel/transmute.rs
>>>>> @@ -47,7 +47,16 @@ macro_rules! impl_frombytes {
>>>>>   ///
>>>>>   /// Values of this type may not contain any uninitialized bytes. This type must not have interior
>>>>>   /// mutability.
>>>>> -pub unsafe trait AsBytes {}
>>>>> +pub unsafe trait AsBytes {
>>>>> +    /// Returns `self` as a slice of bytes.
>>>>> +    fn as_bytes(&self) -> &[u8] {
>>>>> +        let data = core::ptr::from_ref(self).cast::<u8>();
>>>>> +        let len = size_of_val(self);
>>>>> +
>>>>> +        // SAFETY: `data` is non-null and valid for `len * sizeof::<u8>()` bytes.
>>>>> +        unsafe { core::slice::from_raw_parts(data, len) }
>>>>> +    }
>>>>> +}
>>>>
>>>> Let's also have an as_bytes_mut() method. I would require the type to
>>>> also implement FromBytes as it lets you replace the value with another
>>>> set of bytes.
>>>
>>> s/I would/It would/
>>>
>>> FromBytes is needed only for as_bytes_mut(), not for the existing
>>> method.
>>
>> I agree with your suggestion, but it can be an independent patch and
>> doesn't need to go in via this one, right?
> 
> Given where we are in the merge cycle, it seems like we have a couple of
> months until that code gets merged anyway, so I don't see any reason to
> not send a v4 with Alice's suggestion? The only drawback I see is that I
> would have to reset the Reviewed-by tags.

I'd make it a series and add as_bytes_mut() as a separate patch.

