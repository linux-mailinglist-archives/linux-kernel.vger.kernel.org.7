Return-Path: <linux-kernel+bounces-776620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F0DB2CF9D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AA797B530B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EFB253B4C;
	Tue, 19 Aug 2025 23:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fS1mNJkK"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB6C2512DE;
	Tue, 19 Aug 2025 23:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755644861; cv=none; b=PAcEyvSi7uB6XrwmZF2khLOsc0OU9CqlbVst0KE/Nu1HYW59qs7+m+143DOlxubSOhiYAnuE792oUaE3OZgPX4moN8JMEor8oMnR7VxWyGKBw2BulDtOXir3bnC2qXYjmws/1b6P2x7eOHY3SpFucGrQGDxuIfp1wADWNCNDJSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755644861; c=relaxed/simple;
	bh=kP5KICDjVGFTguWffLhUXR9fkMg2CHShAjqdqroa9jQ=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qjelY/ad8zSL1dN3NzOjrr6DeWzX+vQfQmqrA6PyZwHgq1i/ihC379z0nQPNZJrDwiYTEHOWw6vUjzYMzKewelfNXzhrZN1AIp0V0r4NhLeFnCfh7KeXpqbhQKvYO7AhPWBZq/XHZmcGCPZ3XkZ2+zHvdT28q5UlHhZTBbrXd/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fS1mNJkK; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2430c5b1b32so2579685ad.1;
        Tue, 19 Aug 2025 16:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755644858; x=1756249658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GYVG8v8pdpVSBv9zxjqFObiIPrbN0RlS5lG6lYDp9ig=;
        b=fS1mNJkKXbb9w2nS+NgxRVlwae1C5YPenSqzaSw51ESirrRjGQW8Vlra/XcWx7nSDN
         EoY6q7oDNK9W52qrr0x11m4rDFRl8tqVqu7kg08+WHEM7GgYdSYKcxHE3UKCtuk+w3f0
         47vFHcTCJieon3dLe3o3oEPFINj4Q16PEyW5qPPs07mwy/hBqhx3WHaYW+7jwdZlHu+h
         Boc8LC80E6samNBnVVyVKvGr03WV5qDU7XCzthrT3b5jdl/KEQrb6GcCd2ZPwb5Msn39
         b7042xOlK5Wjvuap5nMJUFJJtxoN9HI5Ojhf4U2KNp+ugL9TtlMxZGxIQlyfl3Rwvytd
         eGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755644858; x=1756249658;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GYVG8v8pdpVSBv9zxjqFObiIPrbN0RlS5lG6lYDp9ig=;
        b=MVYJCvhphqQZokirImqX+xcrXwYzzpzFlcgeLNI0LvDVVEdkcLXAN8LK0Al9i77KNg
         1KnUBNYt4uQ3HS1CQo98a01JYPFa4OIN68HWBNb+PX0ZxslTNDoJyXwQzO/iZwmRtvcF
         uFeTiZp91oT7xKy3Uog5rrU6wTnOr5zEWUb7IvnoI+1drGaRM/DoaL5ge0yVhvuS1WLo
         OK8+gIRcPcvKqMRcaWnMyCxKSnMUw5We0b7AGgvkHH+vgq7z7mUexTgh579wBe8LU3Ij
         sJejFQl5Ut5BojI053lZfILj0aOu2BF5lqaGmJISz3Qp+2W9z/Uo/YDjThR6Nzqo7mIq
         RHTw==
X-Forwarded-Encrypted: i=1; AJvYcCVQJKUyem3MlKC6oXsf5JVxrIndUdRwOmvC+q6YvIEKIHFeZkVPX8botw3vFY1cHrEjnovr22Hr8Z2TOik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0yPC+ep3Vvic0hm6Q4rQLZk97RlFIalqL2Z2hEhNRVSQ/+S2+
	Ughco1JYfmhO2tc9tiyI9N/heEXXRljUexjDaBzAtbQkbuh3lNPSZtuV
X-Gm-Gg: ASbGncsapKpUFBzB5wQdgxU5iExhET8Ak0sbAYt6WLGzgzh1YilalgffB6cqaNu0yzJ
	T8wMK4qN+RfdwC7CPKzuCjw1cT7QfYLcUb18ZA6KLSH63NBop0SbR0VGCSGCfPXFct0EOHF/BjB
	RxbyV2zqE8ohvUsqts9dd3gf2HvQn1qDv+2qCyseEPHGvN+4WzVVaCN27jZOU/FB/sGI32T0Wqm
	hKe8x9amQdbl73UGks1nhFB7fueJWgU3mFZG2Us9d/2H0uiHGESHig6MAJ8LfIR30qg0b0TCnM5
	407t6wxOcfqOgzEayIAMgeycvMeHlf9GY54dupNptSBTbwhn/jkmdCcXoE862yy21kMA2fq/Emr
	G/ytR6MHnsrg33hdZ9a8X9FqwuODttkw1xGkHsmBZQX42fgT3grR+C73MN7U2M8Squc3vA1IaYo
	kY
X-Google-Smtp-Source: AGHT+IHKPAN+5QZ7+r8J44EHgjvyKpIvsgvKxfwIW7WnWeJZXqrUiD+Qt2lLAzbIqo7kjb4T6teTcA==
X-Received: by 2002:a17:903:38c5:b0:242:5f6c:6b4e with SMTP id d9443c01a7336-245ee00e635mr12745435ad.7.1755644858260;
        Tue, 19 Aug 2025 16:07:38 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed375db3sm8080465ad.59.2025.08.19.16.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 16:07:37 -0700 (PDT)
Date: Wed, 20 Aug 2025 08:07:21 +0900 (JST)
Message-Id: <20250820.080721.742789396303033039.fujita.tomonori@gmail.com>
To: lyude@redhat.com
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 tglx@linutronix.de, a.hindborg@kernel.org, fujita.tomonori@gmail.com,
 boqun.feng@gmail.com, frederic@kernel.org, anna-maria@linutronix.de,
 jstultz@google.com, sboyd@kernel.org, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org
Subject: Re: [PATCH v8 6/7] rust: time: Add Instant::from_ktime()
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20250819201334.545001-7-lyude@redhat.com>
References: <20250819201334.545001-1-lyude@redhat.com>
	<20250819201334.545001-7-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 19 Aug 2025 16:05:57 -0400
Lyude Paul <lyude@redhat.com> wrote:

> For implementing Rust bindings which can return a point in time.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> 
> ---
> V4:
> * Turn from_nanos() into an unsafe function in order to ensure that we
>   uphold the invariants of Instant
> V5:
> * Add debug_assert!() to from_nanos
> V8:
> * Change name of function from Instant::from_nanos() to
>   Instant::from_ktime()
> 
>  rust/kernel/time.rs | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

Thanks!


> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index 64c8dcf548d63..5c40ebe096357 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -200,6 +200,29 @@ pub fn elapsed(&self) -> Delta {
>      pub(crate) fn as_nanos(&self) -> i64 {
>          self.inner
>      }
> +
> +    /// Create an [`Instant`] from a `ktime_t` without checking if it is non-negative.
> +    ///
> +    /// # Panics
> +    ///
> +    /// On debug builds, this function will panic if `nanos` is not in the range from 0 to
> +    /// `KTIME_MAX`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller promises that `nanos` is in the range from 0 to `KTIME_MAX`.

The comment looks outdated. 'ktime'?


> +    #[expect(unused)]
> +    #[inline]
> +    pub(crate) unsafe fn from_ktime(ktime: bindings::ktime_t) -> Self {
> +        debug_assert!(ktime >= 0);
> +
> +        // INVARIANT: Our safety contract ensures that `nanos` is in the range from 0 to

Ditto.

> +        // `KTIME_MAX`.
> +        Self {
> +            inner: ktime,
> +            _c: PhantomData,
> +        }
> +    }
>  }
>  
>  impl<C: ClockSource> core::ops::Sub for Instant<C> {
> -- 
> 2.50.0
> 
> 

