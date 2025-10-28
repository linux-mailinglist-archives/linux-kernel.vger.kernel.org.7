Return-Path: <linux-kernel+bounces-873452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B318C13F99
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29F433A9FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2423002AA;
	Tue, 28 Oct 2025 09:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qAh9HlC/"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2792E7F2C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761645340; cv=none; b=ayaKGvqA0ivvMJ1SUsHepkH/ypjUazUEpXClOs+WdtBiVWFiwfv7yQ9Vsv8Vi2iDbPNf8Dvha9axoGYaMc6ZELZRLh6hmdqAoIDvIXsILQBGUHEDJI3AQiEe2w3vfST1L9LNzNYaGP7wdeFb2eSq9Jn+93Xs/6+gcVLpS1GpdYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761645340; c=relaxed/simple;
	bh=P7cRdbop4WY/CusSuT6htdgxrUs8JkRCVPy7HTpZHc8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AOdx/IOrBTJOIJZZKW2Qu0p+F7dTNz7A5/U2vsl6wpgr/vxpu4V54Xo//vqL9BhrOHKuT2HJ28uhpuupch/LgygJ8mOXEuwXz1gbax5elV8SeTAS9jd2NLahSwqNcHmVoqZK140QnSNfUzOMLy2FDLRW/NcBA4gv2C2mXFkakNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qAh9HlC/; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-471001b980eso35982105e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761645337; x=1762250137; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2vghd+XDwM2SBUakwVmwypFo93qRi1B2f3MugM+wYJY=;
        b=qAh9HlC/LyVBuIrY9ZmlXpQPuJZvaai0hl5oNHcZvDYHsB2G52uhrFf/n2prdVa9Eg
         +8ad5dH+egp1TFvIk7s0taqyg9TGl/D19XBKZU7/E+a8OMJMTxLUJrokQvPJfdyfsTzp
         NAe285PyxdZhJ/9v/sUZXI653lJSMLVkSfAHUFd4ENk3SYb3Ac2nEi+JpmFDIK8EMqfD
         ykiZQTzDx1og2PmIelHJeukrfpqLJRuPagNREavtExPld+31bWlC5BYGRZbwLUQuNc70
         g6gahk3C6dgpDLdXB/0sdOSmRyc3LdAT93uYEqlZ4rCTurcCZBYpGISuzvGrIxbBOTPI
         05fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761645337; x=1762250137;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2vghd+XDwM2SBUakwVmwypFo93qRi1B2f3MugM+wYJY=;
        b=I4X08fb5Kru8WdALM418YIf8+ulZIMs4774Vh/7qRlwSIn/m4EOcUpGK+tAJXrJeSd
         jQ5DFP3g6FMKLU7l/hilYeWjjlWa5ToFtdauWq1F+tA/zmMVBSjEO3O+H6acNuK8JRiM
         I+hWJavKxsXvEPvMZddl0K+4IfR1x/JdYnFeIpaD+42DMcmRbJ9xxgb4sV8zRahKuSSp
         firo77f0zDrO4qV0/dVVE7Y2elBXOY6arrSS8MnsixSv8ZFVQhGVSM0UmEwO2d/Zio8r
         +FF5q9c8J30as0859l0FKNw3r1uny7aVCyc6sl6XVx8HyZw2Wa9zMe1l0NYN5VxnkxOl
         fPsA==
X-Forwarded-Encrypted: i=1; AJvYcCVdrSh1ceHnuZ+uV8A2RFEE1UmXAhDzQ1Cni+M1nRC9FhpPgGRcies+Oyo2tTM6i8/prb+MsxMFiHqaams=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQlaNT1BeMQEbEBWWdHQZd+WF7B8nLHe6Nat+cQdFZg35d32ox
	BYwgRI3LgQNC4s0kgZlWSa1ygc0gSNuAQ9KLw6m/LVrO/fD78Q06LFy73rM/H3apIYRhuZQheBk
	OLPvQp+Ld4SNSBtFosQ==
X-Google-Smtp-Source: AGHT+IEjavKLFfsOXlZGKRuSqHmF51sDvv7FfIUWb/fKG73kO+99xANbMm6177CWOhKmxUs/Cp7WfS/nyAQ+vyM=
X-Received: from wmov15.prod.google.com ([2002:a05:600c:470f:b0:46f:d897:4e46])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3d98:b0:46e:4a60:ea2c with SMTP id 5b1f17b1804b1-47717e633cbmr18922545e9.37.1761645336604;
 Tue, 28 Oct 2025 02:55:36 -0700 (PDT)
Date: Tue, 28 Oct 2025 09:55:35 +0000
In-Reply-To: <20251026125458.2772103-2-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251026125458.2772103-1-fujita.tomonori@gmail.com> <20251026125458.2772103-2-fujita.tomonori@gmail.com>
Message-ID: <aQCTFwswY7dDmfbC@google.com>
Subject: Re: [PATCH v3 1/2] rust: add udelay() function
From: Alice Ryhl <aliceryhl@google.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, dakr@kernel.org, 
	daniel.almeida@collabora.com, ojeda@kernel.org, anna-maria@linutronix.de, 
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, frederic@kernel.org, 
	gary@garyguo.net, jstultz@google.com, linux-kernel@vger.kernel.org, 
	lossin@kernel.org, lyude@redhat.com, rust-for-linux@vger.kernel.org, 
	sboyd@kernel.org, tglx@linutronix.de, tmgross@umich.edu
Content-Type: text/plain; charset="utf-8"

On Sun, Oct 26, 2025 at 09:54:57PM +0900, FUJITA Tomonori wrote:
> Add udelay() function, inserts a delay based on microseconds with busy
> waiting, in preparation for supporting read_poll_timeout_atomic().
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

With below nits addressed:
Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> ---
>  rust/helpers/time.c       |  5 +++++
>  rust/kernel/time/delay.rs | 39 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/rust/helpers/time.c b/rust/helpers/time.c
> index a318e9fa4408..67a36ccc3ec4 100644
> --- a/rust/helpers/time.c
> +++ b/rust/helpers/time.c
> @@ -33,3 +33,8 @@ s64 rust_helper_ktime_to_ms(const ktime_t kt)
>  {
>  	return ktime_to_ms(kt);
>  }
> +
> +void rust_helper_udelay(unsigned long usec)
> +{
> +	udelay(usec);
> +}
> diff --git a/rust/kernel/time/delay.rs b/rust/kernel/time/delay.rs
> index eb8838da62bc..0739b75fb9c3 100644
> --- a/rust/kernel/time/delay.rs
> +++ b/rust/kernel/time/delay.rs
> @@ -47,3 +47,42 @@ pub fn fsleep(delta: Delta) {
>          bindings::fsleep(delta.as_micros_ceil() as c_ulong)
>      }
>  }
> +
> +/// Inserts a delay based on microseconds with busy waiting.
> +///
> +/// Equivalent to the C side [`udelay()`], which delays in microseconds.
> +///
> +/// `delta` must be within `[0, `MAX_UDELAY_MS`]` in milliseconds;

We can nest backticks. This should be:

	`[0, MAX_UDELAY_MS]`

> +/// otherwise, it is erroneous behavior. That is, it is considered a bug to
> +/// call this function with an out-of-range value, in which case the function
> +/// will insert a delay for at least the maximum value in the range and
> +/// may warn in the future.

There's a debug assertion now so I would remove the "maxmimu value"
part.

> +/// The behavior above differs from the C side [`udelay()`] for which out-of-range
> +/// values could lead to an overflow and unexpected behavior.
> +///
> +/// [`udelay()`]: https://docs.kernel.org/timers/delay_sleep_functions.html#c.udelay
> +pub fn udelay(delta: Delta) {
> +    const MAX_UDELAY_DELTA: Delta = Delta::from_millis(bindings::MAX_UDELAY_MS as i64);
> +
> +    debug_assert!(delta.as_nanos() >= 0);
> +    debug_assert!(delta <= MAX_UDELAY_DELTA);
> +
> +    let delta = if (Delta::ZERO..=MAX_UDELAY_DELTA).contains(&delta) {
> +        delta
> +    } else {
> +        MAX_UDELAY_DELTA
> +    };
> +
> +    // SAFETY: It is always safe to call `udelay()` with any duration.
> +    // Note that the kernel is compiled with `-fno-strict-overflow`
> +    // so any out-of-range value could lead to unexpected behavior
> +    // but won't lead to undefined behavior.
> +    unsafe {
> +        // Convert the duration to microseconds and round up to preserve
> +        // the guarantee; `udelay()` inserts a delay for at least
> +        // the provided duration, but that it may delay for longer
> +        // under some circumstances.
> +        bindings::udelay(delta.as_micros_ceil() as c_ulong)
> +    }
> +}
> -- 
> 2.43.0
> 

