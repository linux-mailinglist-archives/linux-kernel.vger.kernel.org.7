Return-Path: <linux-kernel+bounces-754224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6506B1900D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 23:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F9097A8A7B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 21:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20F5258CDC;
	Sat,  2 Aug 2025 21:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="O7F+7c/z"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DBB1F91C5
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 21:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754169593; cv=none; b=BWgra5ER/kUEVkMHgSPxwz21c3P4OfW95txI5YoDm02rMBns30ebL3t311nHW4/Skpn0xQ8O9Igdh0vtwEcKVxnD7oUA4Sl4MSf2expGYPWjbwBoI1FiiEK+LSnn0jy/2kOs0tbFs0ocKSeBSaQa2cchy1qmGX39zDe854utP8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754169593; c=relaxed/simple;
	bh=vSlkJ+vsxjOY9oI9RrIgABm9WROts/lXyLnQDsNHTsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=ru9SRllLWFqRbzFm0TMEw9GYxKprLAI/lc0+2nBDjI12idrXWlc1gw/42z2bMKIyjAtEvaE4HHA+T2s92xmxn91dj+GaQDzWRQA0C5SVWfZrwBFPZoqVQ2SS8BlWUL/s+bEudwBZ2kXZ6EA7vwKIVVBc9VLPMttErw/yRfxAawo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=O7F+7c/z; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250802211942euoutp0188a4c327a1711751051861ec96207943~YD-EUrUBn2766927669euoutp01d
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 21:19:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250802211942euoutp0188a4c327a1711751051861ec96207943~YD-EUrUBn2766927669euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754169583;
	bh=I/2dlcrRSy99Csm9t0csY8wO5EgDCaan9WuLdFU4wKo=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=O7F+7c/zO3ynvYKekJOpIjKFPgTXLgxJUkXBvorx3Q5rDQmOv499KLua9QZTOJrcu
	 Hwd6zgFNaVT3Q0LqpXzYTAle2aZWvCvJUN5wZDTE1w+S4qKFqJAKkGRs71OCNAZnmt
	 MkiuMFtdiABxtYQ+uGv3qEvlRvfLDGb6JXmk58oE=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250802211941eucas1p1872fbfcbece711926d059e0e5d14df1d~YD-DYQxnX2180321803eucas1p1j;
	Sat,  2 Aug 2025 21:19:41 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250802211940eusmtip18530543824eaf584b29d76a65b2312ae~YD-CRmpZK2541225412eusmtip1h;
	Sat,  2 Aug 2025 21:19:40 +0000 (GMT)
Message-ID: <8a99664b-8acb-4ace-9c2a-bdada5cac5cb@samsung.com>
Date: Sat, 2 Aug 2025 23:19:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/3] rust: pwm: Add Kconfig and basic data
 structures
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Miguel Ojeda
	<ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas
	Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
	Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Drew Fustini
	<drew@pdp7.com>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Rob
	Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
	Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Benno Lossin <lossin@kernel.org>, Michael
	Turquette <mturquette@baylibre.com>, Drew Fustini <fustini@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <437DA583-95FF-4ADF-9947-1F39D242E157@collabora.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250802211941eucas1p1872fbfcbece711926d059e0e5d14df1d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250717090831eucas1p282ac3df2e2f1fc2a46e12c440abfbba1
X-EPHeader: CA
X-CMS-RootMailID: 20250717090831eucas1p282ac3df2e2f1fc2a46e12c440abfbba1
References: <20250717-rust-next-pwm-working-fan-for-sending-v12-0-40f73defae0c@samsung.com>
	<CGME20250717090831eucas1p282ac3df2e2f1fc2a46e12c440abfbba1@eucas1p2.samsung.com>
	<20250717-rust-next-pwm-working-fan-for-sending-v12-2-40f73defae0c@samsung.com>
	<437DA583-95FF-4ADF-9947-1F39D242E157@collabora.com>



On 7/25/25 17:08, Daniel Almeida wrote:
> Hi Michal,
> 
> 
> Overall looks good, a few minor comments:

Hi,
Congratulations for getting your IoMem series merged. Thank you for your
work, as it will allow me to proceed and re-add the driver part for this
series.

> 
> […]
> 
>> +
>> +/// Wrapper for board-dependent PWM arguments [`struct pwm_args`](srctree/include/linux/pwm.h).
>> +#[repr(transparent)]
>> +pub struct Args(Opaque<bindings::pwm_args>);
>> +
>> +impl Args {
>> +    /// Creates an `Args` wrapper from a C struct pointer.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// The caller must ensure that `c_args_ptr` is a valid, non-null pointer
>> +    /// to `bindings::pwm_args` and that the pointed-to data is valid
>> +    /// for the duration of this function call (as data is copied).
>> +    unsafe fn from_c_ptr(c_args_ptr: *const bindings::pwm_args) -> Self {
>> +        // SAFETY: Caller guarantees `c_args_ptr` is valid. We dereference it to copy.
>> +        Args(Opaque::new(unsafe { *c_args_ptr }))
>> +    }
> 
> from_raw()
> 
> 
>> +
>> +    /// Returns the period of the PWM signal in nanoseconds.
>> +    pub fn period(&self) -> u64 {
>> +        // SAFETY: `self.0.get()` returns a pointer to the `bindings::pwm_args`
>> +        // managed by the `Opaque` wrapper. This pointer is guaranteed to be
>> +        // valid and aligned for the lifetime of `self` because `Opaque` owns a copy.
>> +        unsafe { (*self.0.get()).period }
>> +    }
>> +
>> +    /// Returns the polarity of the PWM signal.
>> +    pub fn polarity(&self) -> Result<Polarity, Error> {
>> +        // SAFETY: `self.0.get()` returns a pointer to the `bindings::pwm_args`
>> +        // managed by the `Opaque` wrapper. This pointer is guaranteed to be
>> +        // valid and aligned for the lifetime of `self`.
>> +        let raw_polarity = unsafe { (*self.0.get()).polarity };
>> +        Polarity::try_from(raw_polarity)
>> +    }
>> +}
>> +
>> +/// Wrapper for PWM state [`struct pwm_state`](srctree/include/linux/pwm.h).
>> +#[repr(transparent)]
>> +pub struct State(bindings::pwm_state);
> 
> No Opaque<T>?

Since this is a copy of the state it's fine. The Args above should
follow similar pattern, the divergence stemmed when iterating with this
series. So I would rather fix the Args to also not be Opaque as it
doesn't need to be, since it's also a copy of the original (since it's
so small and read only).

> 
>> +
>> +impl State {
>> +    /// Creates a `State` wrapper by taking ownership of a C `pwm_state` value.
>> +    pub(crate) fn from_c(c_state: bindings::pwm_state) -> Self {
>> +        State(c_state)
>> +    }
>> +
>> +    /// Returns `true` if the PWM signal is enabled.
>> +    pub fn enabled(&self) -> bool {
>> +        self.0.enabled
>> +    }
>> +}
>>
>> -- 
>> 2.34.1
>>
>>
> 
> If the lack of Opaque<T> is not a problem for whatever reason:
> 
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> 
> — Daniel
> 
> 

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

