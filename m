Return-Path: <linux-kernel+bounces-759079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7A9B1D82A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 14:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E609583E85
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 12:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7FB253B42;
	Thu,  7 Aug 2025 12:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+hj8c+T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E2E1E48A;
	Thu,  7 Aug 2025 12:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754570667; cv=none; b=VnRtmSsQSeF+TubhjnvFMV1pilEQ75u4kHBeX1DtfugQ4GunvuA3j/kN4HF847OLWxNlq8V7q5nOiI+dNhG3stXgk+ObGfvAa4qijuL1DghZZMXh6pPvF6ZCUFbnqSLVdncx14dd/BDYihMkS9uFMEox7w8Rodt3QetGbQ+EZ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754570667; c=relaxed/simple;
	bh=WMsVnSXX7wd5ayJeziJSnbluq2OE3O0GYuxrdGD9xPc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F47ubRaNG33eSZvUPT+KDBQul6w3LVNtEWQWzXxzfo5qWGkJvIT3iAbRDSdN+m+/NupeqDr78HQoEU+Ud82cI21/Dwk+Rz1JUSZHKDIE35yo3vVR1Mvsj95CmMj39Qk6pL66YQslO1kcAZhabyDGBNv57638CmVOLWUzRXn20Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+hj8c+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52853C4CEEB;
	Thu,  7 Aug 2025 12:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754570666;
	bh=WMsVnSXX7wd5ayJeziJSnbluq2OE3O0GYuxrdGD9xPc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=C+hj8c+TN+8FP10aYaWDW92qIeSUM4B/T49pou8Q+zdbIDd22Jjtz+LBGwd8bb1u6
	 u2bxV/bB5QgwP0SVzb4qze6vPobbCp1yB7262yOenuZxt1cV+GCyqSArLSwTuJn8t1
	 IhRAWoPyNBB8KHOpX1PQy3olugL5k9VWhSqUY/BCIzv9AGu3NI/1RGBkfq/RFP8G99
	 b25yGoa2qxqEhi8Y+J2Uh0xDNxsZpt40+/iX/rvTGKFqb/TuEI3VAlwEZM4hL1z962
	 bg7vLZTa8VgbyVLkew1JAO7ES6K5jul9X+znnp076ZY5m+7g99/GJ0oWujtoQOo/WC
	 9w0+UVDtJIkgw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Lyude Paul <lyude@redhat.com>, Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org, FUJITA
 Tomonori <fujita.tomonori@gmail.com>, Frederic Weisbecker
 <frederic@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, John
 Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda
 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo
 <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH 2/2] rust: time: Implement basic arithmetic operations
 for Delta
In-Reply-To: <ddea64af3b845d2c32d807c5aab6146a9ce3c2bf.camel@redhat.com>
References: <20250724185700.557505-1-lyude@redhat.com>
 <20250724185700.557505-3-lyude@redhat.com> <aIXVzIwBDvY1ZVjL@google.com>
 <f92b5f82b3ad7bb8d5bf60b272aac8cf1e6ced24.camel@redhat.com>
 <aIi7ZycRtmOZNtcf@google.com>
 <HOO5JYIxZKoD8xW4fQHGxeBnL_P4Np3fmfvoUV7ESg_DEoS-c3QfTMooZrAhXsJ5nTf8DWNKoEnr4pQN9IYpPQ==@protonmail.internalid>
 <ddea64af3b845d2c32d807c5aab6146a9ce3c2bf.camel@redhat.com>
Date: Thu, 07 Aug 2025 14:44:16 +0200
Message-ID: <87ms8b713z.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lyude Paul" <lyude@redhat.com> writes:

> On Tue, 2025-07-29 at 12:15 +0000, Alice Ryhl wrote:
>>
>>
>> The reason I bring up the example is that once you add code using these
>> impls, you're going to get kernel build bot errors from your code not
>> compiling on 32-bit. And as seen in the linked one, code may be compiled
>> for 32-bit when setting CONFIG_COMPILE_TEST even if you don't support it
>> for real.
>>
>> > This being said, the kernel does have a math library that we can call into
>> > that emulates operations like this on 32 bit - which I'd be willing to convert
>> > these implementations over to using. I just put the CONFIG_64BIT there because
>> > if we do use the kernel math library, I just want to make sure I don't end up
>> > being the oen who has to figure out how to hook up the kernel math library for
>> > 64 bit division outside of simple time value manipulation. I've got enough
>> > dependencies on my plate to get upstream as it is :P
>>
>> If you just want to call the relevant bindings:: method directly without
>> any further logic that seems fine to me.
>
> Gotcha, I will do that. Ideally I would at least like to have us only call the
> bindings:: method so long as we're on a config where we really need
> it.

We took a similar approach in `Delta::as_micros_ceil`:

    /// Return the smallest number of microseconds greater than or equal
    /// to the value in the [`Delta`].
    #[inline]
    pub fn as_micros_ceil(self) -> i64 {
        #[cfg(CONFIG_64BIT)]
        {
            self.as_nanos().saturating_add(NSEC_PER_USEC - 1) / NSEC_PER_USEC
        }

        #[cfg(not(CONFIG_64BIT))]
        // SAFETY: It is always safe to call `ktime_to_us()` with any value.
        unsafe {
            bindings::ktime_to_us(self.as_nanos().saturating_add(NSEC_PER_USEC - 1))
        }
    }


Best regards,
Andreas Hindborg



