Return-Path: <linux-kernel+bounces-889588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E45C3DF99
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 01:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D48874EAC01
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 00:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528602D0C68;
	Fri,  7 Nov 2025 00:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAExQ052"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2102C08BA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 00:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762475136; cv=none; b=BP3QR/gbBtTM4fWQSE08Vy1uwP2P16b4ltq7E1vX0IJ5uKIbwpd7HCcaddHKn9PP5tugx3DnzlWwzB5FxjBGmqURh6GTsRaNGxuylL7F7oAODWPaD7DFMqNc/GUijLGdx1K1G29O3OYHbeawPQJpBdDI1WpSFItiW6gLMiGz8U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762475136; c=relaxed/simple;
	bh=2OYTQxpg9nb0ECcvWiDf5s06kwrR/GHJEK7e2Ia8Npo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZazY7tYUw5uvGzAlALEHjYH9u7N1dxP/625j73bbnjPRC+eODW3+RfvOvYoKDgZOOJ4oSKDPnIGyoPhQSmb9Qy4hojnCqnZ5d02Mz2fdC1vy7C0+sUv2KzC6LI+vTwj//k5XSUA/sJE2d+eZ7rHjXrVgV9869PTknTdVa57eDtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAExQ052; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-89e8a3fa70fso15365785a.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 16:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762475130; x=1763079930; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eDrGyP4KsggNDtgfNXCVvLL5On0RJHEibXmC0ga7f1Y=;
        b=XAExQ052D5vV0ETkdo9kS4OVmh2x4pDuMJYlUhK/Ol6Wd+wrKhYo0klGF30/ZoOjQI
         4t2dICuowjIw73Yxwbj5AvcsQD2Y0ux8RmjAu+PMTYqXy9gNaZIuZ/JJh78KenaPEwdv
         nM3w+XU2HT9reieD7gWIhMO6sX9/LEr1rkSaeg72pGkH0pEC7UGwtD7J1Ir20GrC3rx8
         V+7hIIykgRumIquNoXOlBHJ6rQW8rlbGck4wL4mN6fPLCErWBgWaq6wR9PurYD/dtfJf
         LLbQHrSYbwiYS/NIPFQgW7LAGkoJSD6z+q73Q/C/Xwb7ovB6ZnAdlqpXZEugTVZOozO8
         5PEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762475130; x=1763079930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eDrGyP4KsggNDtgfNXCVvLL5On0RJHEibXmC0ga7f1Y=;
        b=JYxEySe9pHTFd/7EJW9qlO2Ag2VIkpRyGxg78QVwYG2hWt8KKw5FV43Jkqp4EEoZcH
         pmuU/cS14PgCmPZrK75VsZP1ZSnkeQCIJEzvIuuNubwXwzUC1BAwx5mIQbsOaH6AHiFs
         6y0ccLtyoRtPd64rDjfWgLDVRlsZsnoXPYkVHxBfiY6FxRTfGSOf4FnO9WnleUMp2Nxc
         GOJAvS4z+2w+U9U1nz9M5YHAxNE1aQci6gTjNN8ByDcXImCg7GMYBKHL/5xhuome+rbw
         cwe6pJm0S3/nXmU+uhie4Wyl+v+B13lAmqSv2YQeJhJbICYuVUeEXgW7FVF9E7Bq0JTQ
         FNKg==
X-Forwarded-Encrypted: i=1; AJvYcCXYaPl/WRVCi99S98J4NS7yKdl1TdVb1PuroiwUG5QyyZLfwxmItmEOUy+IWfOA4qRDImHQVegVwdztRCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnHQLu4mgQv9bHuG2ZZNsGZrg5YcjVbFchO3elRiyDD5JAqgo4
	n833myn1WbhM67WFOQ0d409tGWuda0JSIt6dxUUOFvn+dHJNOqGQKHbe
X-Gm-Gg: ASbGncuG0ZkI4bBwIEVB2WbTptSlj0A+mVfi0w7LkOFFWp4d4JezGDGTsbxocCIdHQe
	iLaRHOIccboGMvyXLZfH7+l0YUjl7++ucjStqA5LjuVVytsAKDoOF2oTYQPzsEmAOKkb36Bmi6B
	qZBQ1ymk2tzTEb38xyImP3G4cpfFYaD0R/fGUSESWOieLRA6Ho1S5H1IZiyglJDqdGfNc7HgTKt
	BAp8PR/w1G7u4hnx2S9tdmhFBF8BLX7qpha/VA27RKQkNpbLY+Sg4HCgvcTKWtgHnaAqg/2ns8q
	cBlxzyK51257RozjvxRLDJedyg7cDFwP+mPRF5Nj1lTKtSS5ajdXse2JRj0D7lLJs+D1OjiYdHY
	vJmCirFgJjCQ54uWD/wvQl5shnVxkg9I7+DpxjohaSSYQVzToF3bhG6McexaM4KiUmVvxudOz
X-Google-Smtp-Source: AGHT+IE3wHS1UJmfiT2G9cUOC3xFxU6u/uO+VhHYvECIZct+pRXqPd9d6g9YleM22aR0m7kB5P9qtQ==
X-Received: by 2002:a05:620a:2943:b0:89e:da49:7967 with SMTP id af79cd13be357-8b245286758mr198236785a.18.1762475130279;
        Thu, 06 Nov 2025 16:25:30 -0800 (PST)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2357de61esm299869785a.32.2025.11.06.16.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:25:29 -0800 (PST)
Date: Thu, 6 Nov 2025 19:25:27 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Mitchell Levy <levymitchell0@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Benno Lossin <lossin@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Tyler Hicks <code@tyhicks.com>,
	Allen Pais <apais@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v4 1/9] rust: cpumask: Add a `Cpumask` iterator
Message-ID: <aQ08d2NUVsIf5ukH@yury>
References: <20251105-rust-percpu-v4-0-984b1470adcb@gmail.com>
 <20251105-rust-percpu-v4-1-984b1470adcb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105-rust-percpu-v4-1-984b1470adcb@gmail.com>

On Wed, Nov 05, 2025 at 03:01:13PM -0800, Mitchell Levy wrote:
> Add an iterator for `Cpumask` making use of C's `cpumask_next`.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
> ---
>  rust/helpers/cpumask.c |  5 +++++
>  rust/kernel/cpumask.rs | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/helpers/cpumask.c b/rust/helpers/cpumask.c
> index eb10598a0242..d95bfa111191 100644
> --- a/rust/helpers/cpumask.c
> +++ b/rust/helpers/cpumask.c
> @@ -42,6 +42,11 @@ bool rust_helper_cpumask_full(struct cpumask *srcp)
>  	return cpumask_full(srcp);
>  }
>  
> +unsigned int rust_helper_cpumask_next(int n, struct cpumask *srcp)
> +{
> +	return cpumask_next(n, srcp);
> +}
> +
>  unsigned int rust_helper_cpumask_weight(struct cpumask *srcp)
>  {
>  	return cpumask_weight(srcp);
> diff --git a/rust/kernel/cpumask.rs b/rust/kernel/cpumask.rs
> index 3fcbff438670..b7401848f59e 100644
> --- a/rust/kernel/cpumask.rs
> +++ b/rust/kernel/cpumask.rs
> @@ -6,7 +6,7 @@
>  
>  use crate::{
>      alloc::{AllocError, Flags},
> -    cpu::CpuId,
> +    cpu::{self, CpuId},
>      prelude::*,
>      types::Opaque,
>  };
> @@ -161,6 +161,52 @@ pub fn copy(&self, dstp: &mut Self) {
>      }
>  }
>  
> +/// Iterator for a `Cpumask`.
> +pub struct CpumaskIter<'a> {
> +    mask: &'a Cpumask,
> +    last: Option<u32>,

This is not the last, it's a current CPU.

> +}
> +
> +impl<'a> CpumaskIter<'a> {
> +    /// Creates a new `CpumaskIter` for the given `Cpumask`.
> +    fn new(mask: &'a Cpumask) -> CpumaskIter<'a> {
> +        Self { mask, last: None }
> +    }
> +}
> +
> +impl<'a> Iterator for CpumaskIter<'a> {
> +    type Item = CpuId;
> +
> +    fn next(&mut self) -> Option<Self::Item> {
> +        // SAFETY: By the type invariant, `self.mask.as_raw` is a `struct cpumask *`.
> +        let next = unsafe {
> +            bindings::cpumask_next(
> +                if let Some(last) = self.last {
> +                    last.try_into().unwrap()
> +                } else {
> +                    -1
> +                },
> +                self.mask.as_raw(),
> +            )
> +        };
> +
> +        if next == cpu::nr_cpu_ids() {
> +            None

Please:    if next >= cpu::nr_cpu_ids() {

> +        } else {
> +            self.last = Some(next);
> +            // SAFETY: `cpumask_next` returns either `nr_cpu_ids` or a valid CPU ID.

Now that you've handled the no-found case in the previous block, the
comment doesn't look correct. Can you either move it on top of the
if-else, or just drop entirely?

> +            unsafe { Some(CpuId::from_u32_unchecked(next)) }
> +        }
> +    }
> +}
> +
> +impl Cpumask {
> +    /// Returns an iterator over the set bits in the cpumask.
> +    pub fn iter(&self) -> CpumaskIter<'_> {
> +        CpumaskIter::new(self)
> +    }
> +}
> +
>  /// A CPU Mask pointer.
>  ///
>  /// Rust abstraction for the C `struct cpumask_var_t`.
> 
> -- 
> 2.34.1

