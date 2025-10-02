Return-Path: <linux-kernel+bounces-839801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BEBBB271F
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 05:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FCEB19C63EE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 03:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC52289374;
	Thu,  2 Oct 2025 03:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b="rHFw3M5x"
Received: from mx-out1.startmail.com (mx-out1.startmail.com [145.131.90.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A98F26B0AE;
	Thu,  2 Oct 2025 03:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.131.90.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759376116; cv=none; b=Mnh7wlJsWo27LiKX+/2MdpVqrXKg2v40JVzTv45fmFgvSl2BUCYi7dRXWqV55vmmDqMxXfg4h/BnKDr0/+CsTM7ouhK3dGCmEvETxnuzm9SCbtmZcWCMukq0rC0TI4uIHHT+iOPjPSwzfw5u4FvqTMhs9sRO/P2cjXVKwCqtRjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759376116; c=relaxed/simple;
	bh=u2gyaGjZb5HWph9zQQEuRhlckrl7pa66Cvobj96k9mM=;
	h=Message-ID:Date:Mime-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZpYN3yFIYfmibpe/2XDvCxL8Cr7EC+viMotKgjIhlTlZ14xOfojqoXoGZnxMVzyhbrE8uEvlEEwmYkNbJCsuMDK5hGfk89bocng8AQI1sB+RIeCJtr0icBIIsYS3mdeTJTmzvq2+kHeyBBf/bZeDNVCBlA53fUzhcz2e844hnPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev; spf=pass smtp.mailfrom=weathered-steel.dev; dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b=rHFw3M5x; arc=none smtp.client-ip=145.131.90.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weathered-steel.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weathered-steel.dev;
	s=startmail1; t=1759376112;
	bh=1xyKrTZsjcargDYNHt+NS6g+2E+KNZ01uBZXtO8X4ew=;
	h=Message-ID:Date:Mime-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:From:Subject:To:
	 Date:Sender:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition:Mime-Version:Reply-To:In-Reply-To:References:
	 Message-Id:List-Unsubscribe:List-Unsubscribe-Post:Autocrypt;
	b=rHFw3M5xlAts0ia2uw2jww5WKJG1Vsf18gQg1t/rinjELHZafqNg4b0yozZAduXtG
	 zX2wHm93B/8h+a2YojU/jKsE0LnxZfgxIhQum1OLG0kk5a3lr94JScbfpXCvAI9SvQ
	 pSQzGjQiV7CTIfo6UkUaILniVPkeqoJHVtNcNHs07LEW06Ey3qUfMzChuihQL03Nsr
	 hO3WHPFRNuBvrBRgGg5T31pN6QF3Nrp6zepk4an7PoL6DLRS5lW+i7k888u3zjPj0d
	 VO5s/XzN0nJ0Vt9sWfUt9klkneN9gB8Nfe6yLm8zlvZ1G9+PufITnP6o+NX2OaIVcu
	 T54PI6pGVoO5A==
Message-ID: <a7acc840-8d95-451a-b431-f3755ad6f37c@weathered-steel.dev>
Date: Thu, 2 Oct 2025 03:35:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v5 6/9] rust: bitfield: Add KUNIT tests for bitfield
To: Alexandre Courbot <acourbot@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
 dakr@kernel.org
Cc: Alistair Popple <apopple@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 joel@joelfernandes.org, Yury Norov <yury.norov@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Andrea Righi <arighi@nvidia.com>, nouveau@lists.freedesktop.org
References: <20250930144537.3559207-1-joelagnelf@nvidia.com>
 <20250930144537.3559207-7-joelagnelf@nvidia.com>
 <DD7GCYCZU3P3.1KK174S7MQ5BW@nvidia.com>
 <d238d9b7-8ec5-4063-8217-885d951d2f0c@weathered-steel.dev>
 <DD7HUD8WZAHD.12RKL7EGBWBFY@nvidia.com>
Content-Language: en-US
From: Elle Rhumsaa <elle@weathered-steel.dev>
In-Reply-To: <DD7HUD8WZAHD.12RKL7EGBWBFY@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/2/25 2:51 AM, Alexandre Courbot wrote:
> On Thu Oct 2, 2025 at 11:16 AM JST, Elle Rhumsaa wrote:
>> On 10/2/25 1:41 AM, Alexandre Courbot wrote:
>>
>>> On Tue Sep 30, 2025 at 11:45 PM JST, Joel Fernandes wrote:
>>>> Add KUNIT tests to make sure the macro is working correctly.
>>>>
>>>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>>>> ---
>>>>    rust/kernel/bitfield.rs | 321 ++++++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 321 insertions(+)
>>>>
>>>> diff --git a/rust/kernel/bitfield.rs b/rust/kernel/bitfield.rs
>>>> index fed19918c3b9..9a20bcd2eb60 100644
>>>> --- a/rust/kernel/bitfield.rs
>>>> +++ b/rust/kernel/bitfield.rs
>>>> @@ -402,3 +402,324 @@ fn default() -> Self {
>>>>            }
>>>>        };
>>>>    }
>>>> +
>>>> +#[::kernel::macros::kunit_tests(kernel_bitfield)]
>>>> +mod tests {
>>>> +    use core::convert::TryFrom;
>>>> +
>>>> +    // Enum types for testing => and ?=> conversions
>>>> +    #[derive(Debug, Clone, Copy, PartialEq)]
>>>> +    enum MemoryType {
>>>> +        Unmapped = 0,
>>>> +        Normal = 1,
>>>> +        Device = 2,
>>>> +        Reserved = 3,
>>>> +    }
>>>> +
>>>> +    impl Default for MemoryType {
>>>> +        fn default() -> Self {
>>>> +            MemoryType::Unmapped
>>>> +        }
>>>> +    }
>>> Tip: you can add `Default` to the `#[derive]` marker of `MemoryType` and
>>> mark the variant you want as default with `#[default]` instead of
>>> providing a full impl block:
>>>
>>>       #[derive(Debug, Default, Clone, Copy, PartialEq)]
>>>       enum MemoryType {
>>>           #[default]
>>>           Unmapped = 0,
>>>           Normal = 1,
>>>           Device = 2,
>>>           Reserved = 3,
>>>       }
>> I would alternatively recommend to provide a `MemoryType::new` impl with
>> a `const` definition:
>>
>> ```rust
>> impl MemoryType {
>>       pub const fn new() -> Self {
>>
>>           Self::Unmapped
>>
>>       }
>> }
>>
>> impl Default for MemoryType {
>>       fn default() -> Self {
>>           Self::new()
>>       }
>> }
>> ```
>>
>> This pattern allows using `MemoryType::new()` in `const` contexts, while
>> also providing the `Default` impl using the same default. It's somewhat
>> of a workaround until we get `const` traits.
> That's an elegant pattern generally speaking, but I don't think we would
> benefit from using it in these unit tests.

*facepalm* right, I lost the context that these data structures were 
KUNIT-specific. Please disregard.


