Return-Path: <linux-kernel+bounces-772379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C95B291F8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 09:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA8B6487E9C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 07:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DAB21147B;
	Sun, 17 Aug 2025 07:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWu2cCZ+"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0893718C011;
	Sun, 17 Aug 2025 07:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755415102; cv=none; b=I2WsJCmf3tr4zZ4qoJ489n65PydPbRU7dtBCKJde0hb65x6PbkUORkUsQ4NjM6qOcppMzXkgS6Kr11ppBXbfYA+7zP27hmMJ+9g1Cig/BjF94W9RyzQ0jbXPvPCy9Mcz70abIkW85nAh+Z/HBtN2b9hn/I071eU+O90l5lK0AMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755415102; c=relaxed/simple;
	bh=YYB5cQdBwmhnkPbs3DQCuTcXEQFORaxBGjppJecTYmY=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fQP+YMvc7sAjREW4w4iGvpQ1Ziu4I5efTbvH4VJXayNotTZQFVnmU8zLS69htSHD9oUgp3pYv/fi1QDATQe5532ZFCmsgebASWcUYyrqY45FiIwVFyNPgUoJpYDqNuYKTBZZ8dPuDlIRwJ1wd+jvS2xIm6WK8urmiXeHD2LJb3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWu2cCZ+; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e434a0118so1780272b3a.0;
        Sun, 17 Aug 2025 00:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755415100; x=1756019900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MfMC4arSp0JLKDKHa53x0AnEcCZLSQaZ5L9mSSYKNlo=;
        b=QWu2cCZ+MbttSfY3UbJy9EqBqAz6NaWnbYoHtjVfAWv+OUaw3vpNr1K2ixQhGMz2HY
         d67m1DaD4SKuyT1UXbI2uyXtNSqfDclAY6RXNFcHDtXhpSdEduXsNjnZLNRJnFHOE6V3
         Z6LIqVgxL8mkujsIaNTvCu7c2byjzh0hKCZrEz0bGJ7vShKgU9e0btoH3Ewaf05UwI3N
         AVmNmyJy0UWHvomQi7Lem2ntsq2ulcF/5QVg9x1s8beRBBcO9UdGLitNbWnBir6iLfdX
         yiv3QI2jj/ybhfiQRO9jpHraPSLh9cN4NLo/Ze1gH8a+Tzjevo2wP8t/2L0ksGy+Nivd
         PVRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755415100; x=1756019900;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MfMC4arSp0JLKDKHa53x0AnEcCZLSQaZ5L9mSSYKNlo=;
        b=ThpNvCd/JY9tGqdasvpRCa1WwGAkAKzWDlyurlnv5FzB0G1weZZ8SuSuZgO4EhLsgP
         wy/cUqlT9hVHR+2TxykQxSMQ7+k22rdCdvo5/N9S+DfIh7mVTTZP47INwJ79z46w5ouJ
         F/PcXEYj8X1K7L+NqDt6lqPszy6mFACkt94tlmJLLRKfI8aXA0H5GbMOvPN/VSD+vPbf
         3LjnBcDsw1llH2YrREYDD8dQZL4atLIl7uZco/sSQqmO+wdVkEv7tyYQvL1ERkhSu843
         8nFNK6VAft4TBgHv+G2JZbxm7y8NRoZSrJS9ePfWOhv4WrbZppFUNSWs0Uba8Xn7yALH
         zUlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpD4PRqzIXAGTpyEF5DHxBuestlYCsC7iO9sxmjCoNTKE2+CKqYUEv6FEeOxdIWO1o9EtcdmQrQk7eGS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+N4z7mXom9RsjyoW0scyddc8NGYZX9TYt+m+eDJqrhcqVuFbV
	A83foSNDn3K1wdcaamGunRgZOxaCx3P22DA02nvrbCePB+nwyKNFQrcP
X-Gm-Gg: ASbGncvp7pe2ExKcojb0pz/n6hyG67LrKm97SEU+PFeTf0tSRhV6iKbuNaWYoSGJruU
	LjYRUZHvkDCU+2mdiXywu27s/m9UkrX/enIAY3D5FB8aK8823Y/Rf7C9NunOqEoLyT1E5lQAA6u
	fxa1V+Vp+G970nvKU0jDmJasidNdw6HbmbD7NslnhwdNlyytn0b60vASbryXVSGXBbcvwPMIdQl
	OYbnKsjurhccQiyOA2e4goTTahnESaHhoLI6QaNhT1jymTuvAiEEGKkC6rs1L7PuDwzBdHoWJ4F
	4czV9V/FAzis9vNVYGu1SmUw6AYDIrH80G6rFUadpmiWcRAJzIWzOFUkwU1D9AvilLFrH0u+Jz+
	JDuHdW33MH5UAoySAEUpAxKNzZ00rxhgolYMWdJFyPQbCqkcHiFz2paU4vJBphzVv8i3rrCMM2i
	BFR4DGidehlOE=
X-Google-Smtp-Source: AGHT+IGoK2G125/Gd07SfKiVd0IYtohQM2A/WcFW0fC/hyWR9+qft+w0WXzp4P+R55yWZYHcilLI6Q==
X-Received: by 2002:a17:902:e751:b0:23f:e2e0:f89b with SMTP id d9443c01a7336-2446d5ba169mr100734275ad.3.1755415100120;
        Sun, 17 Aug 2025 00:18:20 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f8ddsm49343985ad.89.2025.08.17.00.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 00:18:19 -0700 (PDT)
Date: Sun, 17 Aug 2025 16:18:04 +0900 (JST)
Message-Id: <20250817.161804.1331850210190243752.fujita.tomonori@gmail.com>
To: lyude@redhat.com
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 tglx@linutronix.de, a.hindborg@kernel.org, fujita.tomonori@gmail.com,
 daniel.almeida@collabora.com, boqun.feng@gmail.com, frederic@kernel.org,
 anna-maria@linutronix.de, jstultz@google.com, sboyd@kernel.org,
 ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, dakr@kernel.org
Subject: Re: [PATCH v7 6/7] rust: time: Add Instant::from_nanos()
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20250813224240.3799325-7-lyude@redhat.com>
References: <20250813224240.3799325-1-lyude@redhat.com>
	<20250813224240.3799325-7-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 13 Aug 2025 18:42:21 -0400
Lyude Paul <lyude@redhat.com> wrote:

> For implementing Rust bindings which can return a point in time.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> 
> ---
> V4:
> * Turn from_nanos() into an unsafe function in order to ensure that we
>   uphold the invariants of Instant
> V5:
> * Add debug_assert!() to from_nanos
> 
>  rust/kernel/time.rs | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index 64c8dcf548d63..75088d080b834 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -200,6 +200,29 @@ pub fn elapsed(&self) -> Delta {
>      pub(crate) fn as_nanos(&self) -> i64 {
>          self.inner
>      }
> +
> +    /// Create an [`Instant`] from a time duration specified in nanoseconds without checking if it
> +    /// is positive.

Can we create Instant (a specific poin in time) from a time duraiton?

The caller (the 7th patch) creates Instant from C side's Instant? 

> +    /// # Panics
> +    ///
> +    /// On debug builds, this function will panic if `nanos` violates our safety contract.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller promises that `nanos` is in the range from 0 to `KTIME_MAX`.

No conclusion has been made yet, but using a mathematical integer
interval or a Rust range expression might be a better fit here:

https://lore.kernel.org/lkml/87ms9ktoly.fsf@kernel.org/

> +    #[expect(unused)]
> +    #[inline]
> +    pub(crate) unsafe fn from_nanos(nanos: i64) -> Self {

If this function creates Instant from C side's Instant, from_ktime()
might be better?


> +        debug_assert!(nanos >= 0);
> +
> +        // INVARIANT: Our safety contract ensures that `nanos` is in the range from 0 to
> +        // `KTIME_MAX`.
> +        Self {
> +            inner: nanos as bindings::ktime_t,
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

