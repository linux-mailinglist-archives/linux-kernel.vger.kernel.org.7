Return-Path: <linux-kernel+bounces-799487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DDBB42C7C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A4BB3AE90B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505832EB5BD;
	Wed,  3 Sep 2025 22:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDKlXnA7"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5AD2C11F2;
	Wed,  3 Sep 2025 22:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756937037; cv=none; b=N/1UIx0Qh1cGZbGvLxf1wWAO9aXFljCdWlDJwplEvgz6q0q0NR3z9StV1LY3D/NFFtbGRw6xMQRWr5vOhGTqw+wqLA/QqNGKIq9tYfQFatciO9CamFgKK+xM5j25/bhNXAhvOv7QoxJFAVLhBDIFPgZWMfuGD+Ee01J0n+GR4PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756937037; c=relaxed/simple;
	bh=TwDdvBFvSvsOarwoKovd0tvWzgb6n8Y5qHyXtmkaZDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4D36AkQ/HGLASIaz5rtL4OWFBJUAtrIzxJfTbHzTyPCfdyjwRD6FpH+tcFOn/AEfrofnajrOlR864xvj8HiV+BbwyeT7U0/FUHQC3H//EkCpA7hE/EBg7j9P24cUWfs/efnTI2bsMtmeA4254HfnZ3BO4VFjf16X/R8DCvmtcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDKlXnA7; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-772301f8ae2so369441b3a.0;
        Wed, 03 Sep 2025 15:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756937034; x=1757541834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jG0m6HNJ/BCPE0TOqPLp7Ou6yvk+l9Cs7COyFN/45qQ=;
        b=gDKlXnA7bC/er2j4z7OcqdNRs8CbRhFqirOuZMIraNgwh9/PVYUlW8sdVoIzzK4x0x
         eoMPjgUHdzjbsmEq2aWJiX/vC7EoGEHzb4t4bjIEcyAI4HrRQ3tx0wOEelLaPck1rlEm
         9TQPuLpUlN0Hp+0Gp9JJj8AHXLptlvc2D/3kMMKYTMsg2pVstvqssq6QsTrUQ861gp69
         Mad9dWCKE0wa3XWr5N8fMGl6CkBXlhBNWHWiS852FPgGRPDCLB3yo9jSLPruklIshxPw
         FZTmNB0nPl4iuUA/MvKuUCOlWxExKgBnDU9m7IwrV+wPZn7uAAl5UGPgqqEzAgiKWyFP
         +lCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756937034; x=1757541834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jG0m6HNJ/BCPE0TOqPLp7Ou6yvk+l9Cs7COyFN/45qQ=;
        b=gbZR6l6Db75f8AMCWHaOtFEcnUnGN8Jd+KaVU8vyUluwMzZvLwMP7H0tRQc32GpqC6
         9bTQNF7MYu9jNW37uRO7T8ZdLUCth4OVLDPezB1tuOFWZ0rDuQYtIYXHX0U7I85pDTcT
         ii+3v6ErMZtjNJLRfgvyGw+j8UVbeitaYeUyNJSREKHSMyIoTubh36YndPU39YdwMdJc
         uqC8k9KULTDqZb9NQrSgUT1m/R69lsTZFntBihtC7sXlbrA1Uyac4YMTd5mKwUJsw2NC
         ewNlgxEZCfI6DjpUKz0s7/030PTeicWSAcF6osfJHbwul8EyYZO5b/LnpQ50dqXKIxDQ
         /7QA==
X-Forwarded-Encrypted: i=1; AJvYcCVoiTpL70inM12dTZKd88mG/uJzIRvpa5L64492nf5AJtJUABy6bcRJ6UMb3ORphOLirB/O+mOBFJoX0TMnfpE=@vger.kernel.org, AJvYcCW3lXQm1M4jF5nOLarbwKP4piPqNSs3PzoSMX3NJ3qth25Tw/tyzrWafXM2hRLqIbYpDVGcwxUIvZ05Ghw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX0mfB00Hjzp0y1GkYyXkyVlitu31bcNzGiTUTQG2NjsKV5UpV
	bgeQzQaJk6w1GWPoqFqCBKH8pJadb38ydiv4CjDbndF/garnSlljL8Gd
X-Gm-Gg: ASbGnctEc2aOyuTBMSvHmY88X4eAJ4gnbbZOjQy55HdPNwKNE4zh9MSS5/s9VFGKRXQ
	RHzFTMfGbmC/O6M/pBUXzpo8Hlj6a0YjCfiRUmUL7/+yyM0tzcEDpv9ZrIE7UBiIzCGkZu/JF8i
	8/7qeHGQbHdxld/FgHxLhcFpI2Gpej5+vJ/UJ/8AzzyiaqlNVHQdUCZL1IEOolG6r0Nge7B44Da
	rSx/6QtH6bayHJbJN9p8bG/gif043shPzmWqQp2GEORd2N9Sq7Bh51Y87jyuNYRf9SEbVUAeHAf
	gXTWgDiykaThoHdgma1JSwHLgi3V04WDU66xGAcMdE296JdAlo1lFLxWoIC8/LHXgYif30E0Lya
	MCspRr49lHOCOsXhlri8lfHhbY4mUSqu8
X-Google-Smtp-Source: AGHT+IGFzD46F74vfRZav7p17SnqQadIrOzjssirKipnGqHhiSHqc/rNHmh16H0lV55oT0r9qjPfFw==
X-Received: by 2002:a17:903:2301:b0:237:d734:5642 with SMTP id d9443c01a7336-24944ac6b51mr224607925ad.41.1756937034059;
        Wed, 03 Sep 2025 15:03:54 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b1b5e5902sm54229625ad.49.2025.09.03.15.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 15:03:53 -0700 (PDT)
Date: Wed, 3 Sep 2025 18:03:51 -0400
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
	Tyler Hicks <code@tyhicks.com>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 4/7] rust: cpumask: Add getters for globally defined
 cpumasks
Message-ID: <aLi7Ptya5xp22P-B@yury>
References: <20250828-rust-percpu-v3-0-4dd92e1e7904@gmail.com>
 <20250828-rust-percpu-v3-4-4dd92e1e7904@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828-rust-percpu-v3-4-4dd92e1e7904@gmail.com>

On Thu, Aug 28, 2025 at 12:00:11PM -0700, Mitchell Levy wrote:
> Add getters for the global cpumasks documented in
> `include/linux/cpumask.h`, specifically:
> - cpu_possible_mask
> - cpu_online_mask
> - cpu_enabled_mask
> - cpu_present_mask
> - cpu_active_mask
> 
> Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
> ---
>  rust/kernel/cpumask.rs | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/rust/kernel/cpumask.rs b/rust/kernel/cpumask.rs
> index b7401848f59e..ca9aa6875b4a 100644
> --- a/rust/kernel/cpumask.rs
> +++ b/rust/kernel/cpumask.rs
> @@ -77,6 +77,52 @@ pub unsafe fn as_ref<'a>(ptr: *const bindings::cpumask) -> &'a Self {
>          unsafe { &*ptr.cast() }
>      }
>  
> +    /// Get a CPU mask representing possible CPUs; has bit `cpu` set iff cpu is populatable
> +    #[inline]
> +    pub fn possible() -> &'static Self {
> +        // SAFETY: `__cpu_possible_mask` is a valid global provided by the kernel that lives
> +        // forever.
> +        unsafe { Cpumask::as_ref(&raw const bindings::__cpu_possible_mask) }
> +    }

This function and the following look like returning a boolean.
Maybe possible_cpus()? 

The general rule is to keep the rust naming as close to C as
possible, but in this case Cpumask::cpu_possible_mask is, OK,
somewhat excessive.

Thanks,
Yury

> +
> +    /// Get a CPU mask representing online CPUs; has bit `cpu` set iff cpu available to the
> +    /// scheduler
> +    #[inline]
> +    pub fn online() -> &'static Self {
> +        // SAFETY: `__cpu_online_mask` is a valid global provided by the kernel that lives forever.
> +        // Since we wrap the returned pointer in an `Opaque`, it's ok that `__cpu_online_mask`
> +        // may change its value.
> +        unsafe { Cpumask::as_ref(&raw const bindings::__cpu_online_mask) }
> +    }
> +
> +    /// Get a CPU mask representing enabled CPUs; has bit `cpu` set iff cpu can be brought online
> +    #[inline]
> +    pub fn enabled() -> &'static Self {
> +        // SAFETY: `__cpu_enabled_mask` is a valid global provided by the kernel that lives forever.
> +        // Since we wrap the returned pointer in an `Opaque`, it's ok that `__cpu_enabled_mask`
> +        // may change its value.
> +        unsafe { Cpumask::as_ref(&raw const bindings::__cpu_enabled_mask) }
> +    }
> +
> +    /// Get a CPU mask representing present CPUs; has bit `cpu` set iff cpu is populated
> +    #[inline]
> +    pub fn present() -> &'static Self {
> +        // SAFETY: `__cpu_present_mask` is a valid global provided by the kernel that lives
> +        // forever. Since we wrap the returned pointer in an `Opaque`, it's ok that
> +        // `__cpu_present_mask` may change its value.
> +        unsafe { Cpumask::as_ref(&raw const bindings::__cpu_present_mask) }
> +    }
> +
> +    /// Get a CPU mask representing active CPUs; has bit `cpu` set iff cpu is available to
> +    /// migration.
> +    #[inline]
> +    pub fn active() -> &'static Self {
> +        // SAFETY: `__cpu_active_mask` is a valid global provided by the kernel that lives forever.
> +        // Since we wrap the returned pointer in an `Opaque`, it's ok that `__cpu_active_mask`
> +        // may change its value.
> +        unsafe { Cpumask::as_ref(&raw const bindings::__cpu_active_mask) }
> +    }
> +
>      /// Obtain the raw `struct cpumask` pointer.
>      pub fn as_raw(&self) -> *mut bindings::cpumask {
>          let this: *const Self = self;
> 
> -- 
> 2.34.1

