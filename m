Return-Path: <linux-kernel+bounces-787428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9780EB37623
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 02:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7674A7B2177
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 00:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AEC187346;
	Wed, 27 Aug 2025 00:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDs8VEfY"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A19A35958;
	Wed, 27 Aug 2025 00:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756254974; cv=none; b=pRH9vTWhVckR2i1KTa13dL4Rea2tDOgdkMed3kWVSe9SgxuW1otlgIVi2WjCWtRtHsSG6yWL70C34lQK7l55wK9R3bO/bC4R7Dd6wz8TYCU6I9DXtIDFdAda+nKFc49Is7lIyTgJUvCrug3sFsMpioXInHS5D1F4CVD9UnVIZmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756254974; c=relaxed/simple;
	bh=346kr6oQ5/ukFFTFhxjesf3Yoxlksnu09ZrfShWlz3Y=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TjNry5+O2U2DSNKfDiXR8gGtiyHf/jmcBbUXe2qJ/1IGHxl/D+9PlEe2p+T0tnq/XsXxKeWso9B0NM5xKWS3AXQlIvDPtuxbfQep0XuQ77fGCbHY/4TeNQmf3ZbCoJB9nqx8aJeqO/vVDcaXW8WDGg5FdETORfqwEtRj1JEFIVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDs8VEfY; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-77057266cb8so2473078b3a.0;
        Tue, 26 Aug 2025 17:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756254972; x=1756859772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tFGFB+JqMp3p+PLP24FQaKVTUTl9iRruOSim/tb85WA=;
        b=BDs8VEfYsBrioFQ97p5VKWpWnftwWwXYocMZ0Wgovj6EOujNV+TCo5BnT0nr5xM5Cw
         ZsePZmF/9ST9gnSR0GZjre2ZwyCdNbN7HVTTbeNWNVd61ny7gWOCFpkD6yTaq7EGhpbN
         E0F0JY5SR9et7YggMtFYvTzloJKgwIDR7/xul19b+MLTj35MW2gqSFwddbngrDWuuz+L
         7kUHiniWxnb4ztWwdiFWCa/Eox/nietWoUQg2heT6Ty4mER/95Eeupoe0HWsYhsfPjPh
         ud/Neh5/q4H9j5wjH7kFMphxsg7tMcbrWCYS7qsE1/CUspPHaVrj2LVDVlnnFnr1R8il
         RFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756254972; x=1756859772;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tFGFB+JqMp3p+PLP24FQaKVTUTl9iRruOSim/tb85WA=;
        b=DhoMocrBvRIL7oW5QGEwKUtddRwM5elZGawdscFsuM/La+vKiCD4kLP1noBC6fvfkR
         Bk+riWdR/izc4rZdTEGwv0Humc8IoI2Fy0o37+RX02PL4B9+iXPyOFmQGubZG+zhI98S
         kcgKJHARFS/1TA9uiKSbp2hz9zYW0zN6R23ssl0UCeQe1LjxyCL1G90CB79G7Kp6+VhX
         AMvglJ7sAkK1n1pvVPZaJ/nkcH5MUnQELCryyM55cXs/xFBPpaXL/2Q1vU+4Oj7UjG/J
         mW1QzTsfEVt0WbQMDLABqt2Zj4vyCW2UIYfM6gg3GxElKxor6/I4DmXFybwjQT3Shhk4
         M3GQ==
X-Forwarded-Encrypted: i=1; AJvYcCUc1t5gTFXCO7HgLyo56Kb3gGCGfbxzYQlkPpT9/YVgV9t1fRxi2NYrixLhJKa/Kzhg/ysHxZAw4ob+ODxIgww=@vger.kernel.org, AJvYcCUcixIOCvy/lnPF12ROilv2vWi4hMr4UMVdAYLzMxwIttLHMXo8Whw0YMdh+W11xaLLAJ70G61T0vtLXlc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3h2p68TrfyzL5WFC4DjKgsoK8wPU6eCQqNEXnII1bv0PIk05y
	BTLail/qaTDhPr0Zme/gsITjIi5K33hqIjbuAqyCtf5AC9IK6U4ZeUTo
X-Gm-Gg: ASbGnctMYP/PAckdgNyJWEnTE4SUtSjGVoiapj5TaQokNiDygsfc8L0LM7zVOsnKZn5
	siDOyBavVTIKf60naNMEWtVk1xvvzudcVfhDQKr9N/zqDUgjp3RVarhxxER0O6kB+qvLPJERxeb
	J98tUQqpE4BxWw1bEcFPFZxT/B5jdzDU2J/Qp/es1eJ68cJQqVgSrLulgUlf4yY6HJboUpzpPOO
	ranrZlexy4vyOAoICJ69CO1h0VVYIEraRzTolRs+5lFK7uAax0lt4p4xMVJTNPpqFfhcMipLaxT
	nz2C7du7zpkYaeaPcUZPqJAr3uFf4K5FmT0qk1UH+vf/IpKLEnEXxAi8onFy7qL0pAYtsw/0TeC
	IyAyO5t3j0uz37YXo/5BtPyH8WyNR8AX4+PFUIxTArKDYpgWBDWBfS/8WM3gs7MCFa26xuz7GzC
	ZX4cBdugLZ3eA=
X-Google-Smtp-Source: AGHT+IEW/2Tf7LMyVjIbhtmCvItIXViu1RKrqr3kl7oNRuptQstf79lQksx/t63qIT7Uai62LmdBQg==
X-Received: by 2002:a05:6a00:2d0c:b0:771:f393:ceb3 with SMTP id d2e1a72fcca58-771f3a31abcmr7126754b3a.16.1756254972343;
        Tue, 26 Aug 2025 17:36:12 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771fd80300csm2334489b3a.106.2025.08.26.17.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 17:36:11 -0700 (PDT)
Date: Wed, 27 Aug 2025 09:35:59 +0900 (JST)
Message-Id: <20250827.093559.1495790445785541454.fujita.tomonori@gmail.com>
To: daniel.almeida@collabora.com
Cc: fujita.tomonori@gmail.com, a.hindborg@kernel.org,
 alex.gaynor@gmail.com, ojeda@kernel.org, aliceryhl@google.com,
 anna-maria@linutronix.de, bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
 dakr@kernel.org, frederic@kernel.org, gary@garyguo.net,
 jstultz@google.com, linux-kernel@vger.kernel.org, lossin@kernel.org,
 lyude@redhat.com, rust-for-linux@vger.kernel.org, sboyd@kernel.org,
 tglx@linutronix.de, tmgross@umich.edu, acourbot@nvidia.com
Subject: Re: [PATCH v1 2/2] rust: Add read_poll_timeout_atomic function
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <5C851069-5E1E-4DE9-9E1F-0DF2C86C266C@collabora.com>
References: <20250821035710.3692455-1-fujita.tomonori@gmail.com>
	<20250821035710.3692455-3-fujita.tomonori@gmail.com>
	<5C851069-5E1E-4DE9-9E1F-0DF2C86C266C@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit

On Tue, 26 Aug 2025 11:02:18 -0300
Daniel Almeida <daniel.almeida@collabora.com> wrote:

>> +/// Polls periodically until a condition is met, an error occurs,
>> +/// or the timeout is reached.
>> +///
>> +/// The function repeatedly executes the given operation `op` closure and
>> +/// checks its result using the condition closure `cond`.
>> +///
>> +/// If `cond` returns `true`, the function returns successfully with the result of `op`.
>> +/// Otherwise, it performs a busy wait for a duration specified by `delay_delta`
>> +/// before executing `op` again.
>> +///
>> +/// This process continues until either `op` returns an error, `cond`
>> +/// returns `true`, or the timeout specified by `timeout_delta` is
>> +/// reached.
>> +///
>> +/// # Errors
>> +///
>> +/// If `op` returns an error, then that error is returned directly.
>> +///
>> +/// If the timeout specified by `timeout_delta` is reached, then
>> +/// `Err(ETIMEDOUT)` is returned.
>> +///
>> +/// # Examples
>> +///
>> +/// ```no_run
>> +/// use kernel::io::{Io, poll::read_poll_timeout_atomic};
>> +/// use kernel::time::Delta;
>> +///
>> +/// const HW_READY: u16 = 0x01;
>> +///
>> +/// fn wait_for_hardware<const SIZE: usize>(io: &Io<SIZE>) -> Result<()> {
> 
> Just “Result”.

Oops, thanks.

I'll update the example for read_poll_timeout() too.


>> +///     match read_poll_timeout_atomic(
>> +///         // The `op` closure reads the value of a specific status register.
>> +///         || io.try_read16(0x1000),
>> +///         // The `cond` closure takes a reference to the value returned by `op`
>> +///         // and checks whether the hardware is ready.
>> +///         |val: &u16| *val == HW_READY,
>> +///         Delta::from_micros(50),
>> +///         Delta::from_micros(300),
>> +///     ) {
>> +///         Ok(_) => {
>> +///             // The hardware is ready. The returned value of the `op` closure
>> +///             // isn't used.
>> +///             Ok(())
>> +///         }
>> +///         Err(e) => Err(e),
>> +///     }
>> +/// }
>> +/// ```
>> +pub fn read_poll_timeout_atomic<Op, Cond, T>(
>> +    mut op: Op,
>> +    mut cond: Cond,
>> +    delay_delta: Delta,
>> +    timeout_delta: Delta,
>> +) -> Result<T>
>> +where
>> +    Op: FnMut() -> Result<T>,
>> +    Cond: FnMut(&T) -> bool,
>> +{
>> +    let mut left_ns = timeout_delta.as_nanos();
>> +    let delay_ns = delay_delta.as_nanos();
>> +
>> +    loop {
>> +        let val = op()?;
>> +        if cond(&val) {
>> +            // Unlike the C version, we immediately return.
>> +            // We know the condition is met so we don't need to check again.
>> +            return Ok(val);
>> +        }
>> +
>> +        if left_ns < 0 {
>> +            // Unlike the C version, we immediately return.
>> +            // We have just called `op()` so we don't need to call it again.
>> +            return Err(ETIMEDOUT);
>> +        }
>> +
>> +        if !delay_delta.is_zero() {
>> +            udelay(delay_delta);
>> +            left_ns -= delay_ns;
>> +        }
>> +
>> +        cpu_relax();
>> +        left_ns -= 1;
> 
> A comment on the line above would be nice.

As I wrote in another email, the C version was changed to avoid using
ktime, and that’s when the code above was added. I assume the delay is
considered as 1ns as a compromise because ktime can’t be used.

Maybe this comment should be added to the C version instead?


> Also, is timeout_delta == 0 an intended use-case?

I’m not sure if it’s actually used, but I don’t see any reason to
forbid it.


