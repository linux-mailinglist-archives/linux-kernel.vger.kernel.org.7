Return-Path: <linux-kernel+bounces-891195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0625C4220E
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 01:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D560F3A9FF2
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 00:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E4C212557;
	Sat,  8 Nov 2025 00:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2DXupsK"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E84020A5E5
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 00:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762561648; cv=none; b=q4rQcrTSCIPQGGY6yJpdVSH9xXKgGWqBiZFmtyZ60BMa3x0kS0VOvASNQXVIydfEVuWa04+79IHoCgCPUCJcfq4R22FfcTul5QhPmeVPawJVaK/rr2IszmDgHVoYtRhuVGBYBKoXTfacIgIvdgJstRBs+G8ZcGN/0wIIlDRrJKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762561648; c=relaxed/simple;
	bh=7kj/nTh8c5FimDk+/Kx8m+ZVMa2y1+ZHOJWDbwOrbyQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+Botz+nxTCtbu8tFN4uzfMTEBBjFWycxvwEA4qUnkSpMfMR/dMAHJ5IKkEeaT4K0iTHo0sOkJMp/ghJiYDfRiX/LHBi1OHgKCflr1JkGpPcDrGuKgn2Qqz4vULj4Oqxejfm5pzIjwnZ3p8ft6qg41UfLBSQ5BNaHoCUgF3+hyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2DXupsK; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b9f1d0126e6so832015a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 16:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762561646; x=1763166446; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oITIVQgMr73mFnSfBGd/HefCrTD9E8UlLjNjhfP/oZE=;
        b=I2DXupsKEkWM/EAfCuP2z/x8aDcWMonPKyBaNz1U6jzPtF1d8Vuk57xiLclLT2/hxd
         QRXQ+vRbbwNHa0z48DtueZBEwpg9qSaHZ+pHT5u2oSjNJ9C6BHcjyhdDB1BKKP3k3Sgt
         Rdcv7+5oteN3eQ3COuYV3Reu54Hm0qRycrYHC1OmAVfTYTT5ZWFKPvr4EY0bNatXUVW+
         qNrmUeY75V+oAmqpoC/mEz9dsOO2sqsdLKmcgHv08FlHUSZOJ66n9PBff3bjD6EjTDwY
         2Ye9QQl0U1UmGYNOmgPGpHUgrdoUgG60xCNVTT+5kJWBZ4t8VaLybYSMGhKBlfV3M69J
         evPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762561646; x=1763166446;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oITIVQgMr73mFnSfBGd/HefCrTD9E8UlLjNjhfP/oZE=;
        b=qfMEjandgavAo6L/sCYcayFUWa6Mx2HDR24/UvlpSQ/L2XbiTynVlnaYzSuHDsQSQ6
         8g2aNIYOMLbxBImf7/KDYo7YEVl2k0EL66wlvSMM/tNSfK6yr80A8PJ1d4gx5UtRtQGB
         eDXJFckVKnJ8O7dyVw43WwnQMG/w0DBkR5QKPOqeI461wSqeiN0agzQWfJ5thGOV7Pet
         h07zBgJ72g6vpmIjqA3mplpcV9u6Gq+HJNDI0xJJVK6wW9rTRfypBPykY9+GGdH+KAMY
         s76wKZc8Gnk2Mfxi6AC4d+CP9T5JUZkTGS7XvYPUjZtOOR/IQKmCEGzGZ/GrYQrGV61X
         BZlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF9gVPYvQp+cVn+gFDyyLUV2b8Lf7V+9wWriTNeXwaPDjuzCHehUcGY3hjgINB+i8ydnQ9xGpTmr7FJv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRSR3HMua08PvolU667U/LaC5x2/UpsjCRZNHP/sSPD8zJRpsa
	ETuXzTYrGZL0u1nl5ewC6XDcVfQaCvOOiGGIT3qCYPYB1o59GFgmcBEO
X-Gm-Gg: ASbGncteIVTuYpGjHo5S2kUsE+4X82H4MVoQsi8Tkmfbcen16hM+Ee6SvjxKe23C9/0
	7/IhnZeQQLPT/l9bKo0NsjXhoRG93pLvxygnWKAX9RnSJ6r2zC0JBzWqRWNfI21QX5vW57LVVc1
	WLvRpdmBizHDuhkWAD5E/jAbrbsCpkbJj3PZYqszlepQYODpYyqArlFWybR3An4cbpS9aEnqfjH
	1LUuFN7I/UoQm6y4oOEgQAfL4uPhcyb4YzpIZIkPrqOPyZ46TRnlNhaZZyBZwYDqG/iyo+tu+zB
	QEJSu+0DHbujx+X4upCQdiQRHUBedQGJjVRDhJX3G3abXErp7M7vtiSVusywUuShEq83x8VRj5x
	9J897tZXyT220QZRI0AyG1lZXo/FYnpfucch1fMxu7VwdqUuM1GughdI6DNTro7Rr4tt8V1SAps
	OhiyxULVDgkFvzY5w=
X-Google-Smtp-Source: AGHT+IGBkvZLAhvDKdrvXHQG3c3w7IqpLjYOFlvAQCWtRpkM1DWxhdW7r8G7DO/y1DZ2Fmaan/pCUg==
X-Received: by 2002:a17:902:cf0b:b0:290:ad7a:bb50 with SMTP id d9443c01a7336-297c96a5cd5mr39554295ad.27.1762561645531;
        Fri, 07 Nov 2025 16:27:25 -0800 (PST)
Received: from Cyndaquil. ([174.127.224.194])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bad33c80393sm2734157a12.4.2025.11.07.16.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 16:27:25 -0800 (PST)
Message-ID: <690e8e6d.050a0220.b06fd.d2ec@mx.google.com>
X-Google-Original-Message-ID: <aQ6Oay2rcmaQLDup@Cyndaquil.>
Date: Fri, 7 Nov 2025 16:27:23 -0800
From: Mitchell Levy <levymitchell0@gmail.com>
To: Yury Norov <yury.norov@gmail.com>
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
Subject: Re: [PATCH v4 2/9] rust: cpumask: Add getters for globally defined
 cpumasks
References: <20251105-rust-percpu-v4-0-984b1470adcb@gmail.com>
 <20251105-rust-percpu-v4-2-984b1470adcb@gmail.com>
 <aQ1DAn7Djc19CgGF@yury>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ1DAn7Djc19CgGF@yury>

On Thu, Nov 06, 2025 at 07:53:22PM -0500, Yury Norov wrote:
> On Wed, Nov 05, 2025 at 03:01:14PM -0800, Mitchell Levy wrote:
> > Add getters for the global cpumasks documented in
> > `include/linux/cpumask.h`, specifically:
> > - cpu_possible_mask
> > - cpu_online_mask
> > - cpu_enabled_mask
> > - cpu_present_mask
> > - cpu_active_mask
> > 
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Suggested-by: Yury Norov <yury.norov@gmail.com>
> > Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
> > ---
> >  rust/kernel/cpumask.rs | 46 ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> > 
> > diff --git a/rust/kernel/cpumask.rs b/rust/kernel/cpumask.rs
> > index b7401848f59e..a6a130092fcb 100644
> > --- a/rust/kernel/cpumask.rs
> > +++ b/rust/kernel/cpumask.rs
> > @@ -77,6 +77,52 @@ pub unsafe fn as_ref<'a>(ptr: *const bindings::cpumask) -> &'a Self {
> >          unsafe { &*ptr.cast() }
> >      }
> >  
> > +    /// Get a CPU mask representing possible CPUs; has bit `cpu` set iff cpu is populatable
> > +    #[inline]
> > +    pub fn possible_cpus() -> &'static Self {
> > +        // SAFETY: `__cpu_possible_mask` is a valid global provided by the kernel that lives
> > +        // forever.
> > +        unsafe { Cpumask::as_ref(&raw const bindings::__cpu_possible_mask) }
> > +    }
> 
> Not sure about this '&raw const' syntax, but I want to make sure that
> all this getters provide non-modifiable references. To modify any of
> those masks, one has to call a dedicated helper like set_cpu_possible().

For `id: T`, the syntax `&raw const id` produces a `*const T` pointing
at `id` (the analogous syntax `&raw mut id` produces a `*mut T`).

All getters here provide const references (`&'static Self` as opposed to
`&'static mut Self`) which will cause the compiler to prevent usage of
any `Cpumask` methods with a `&mut self` reciever (i.e., methods that
change the `Cpumask`).

> Can you maybe explicitly mention it in the comments?

The compiler will prevent using these values to change the underlying
`__cpu_possible_mask` etc, so mentioning that these return values can't
be used for that purpose seems redundant to me.

It is possible someone could get the pointer out via `Cpumask::as_raw`,
and then do something bad with that pointer, but this isn't any
different than someone doing something bad with
`bindings::__cpu_possible_mask`.

Thanks,
Mitchell

> With that,
> 
> Acked-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> 
> > +    /// Get a CPU mask representing online CPUs; has bit `cpu` set iff cpu available to the
> > +    /// scheduler
> > +    #[inline]
> > +    pub fn online_cpus() -> &'static Self {
> > +        // SAFETY: `__cpu_online_mask` is a valid global provided by the kernel that lives forever.
> > +        // Since we wrap the returned pointer in an `Opaque`, it's ok that `__cpu_online_mask`
> > +        // may change its value.
> > +        unsafe { Cpumask::as_ref(&raw const bindings::__cpu_online_mask) }
> > +    }
> > +
> > +    /// Get a CPU mask representing enabled CPUs; has bit `cpu` set iff cpu can be brought online
> > +    #[inline]
> > +    pub fn enabled_cpus() -> &'static Self {
> > +        // SAFETY: `__cpu_enabled_mask` is a valid global provided by the kernel that lives forever.
> > +        // Since we wrap the returned pointer in an `Opaque`, it's ok that `__cpu_enabled_mask`
> > +        // may change its value.
> > +        unsafe { Cpumask::as_ref(&raw const bindings::__cpu_enabled_mask) }
> > +    }
> > +
> > +    /// Get a CPU mask representing present CPUs; has bit `cpu` set iff cpu is populated
> > +    #[inline]
> > +    pub fn present_cpus() -> &'static Self {
> > +        // SAFETY: `__cpu_present_mask` is a valid global provided by the kernel that lives
> > +        // forever. Since we wrap the returned pointer in an `Opaque`, it's ok that
> > +        // `__cpu_present_mask` may change its value.
> > +        unsafe { Cpumask::as_ref(&raw const bindings::__cpu_present_mask) }
> > +    }
> > +
> > +    /// Get a CPU mask representing active CPUs; has bit `cpu` set iff cpu is available to
> > +    /// migration.
> > +    #[inline]
> > +    pub fn active_cpus() -> &'static Self {
> > +        // SAFETY: `__cpu_active_mask` is a valid global provided by the kernel that lives forever.
> > +        // Since we wrap the returned pointer in an `Opaque`, it's ok that `__cpu_active_mask`
> > +        // may change its value.
> > +        unsafe { Cpumask::as_ref(&raw const bindings::__cpu_active_mask) }
> > +    }
> > +
> >      /// Obtain the raw `struct cpumask` pointer.
> >      pub fn as_raw(&self) -> *mut bindings::cpumask {
> >          let this: *const Self = self;
> > 
> > -- 
> > 2.34.1

