Return-Path: <linux-kernel+bounces-889618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF828C3E0EE
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 01:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A2213B2581
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 00:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945BE2EACF2;
	Fri,  7 Nov 2025 00:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEcTnDHF"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A8A2C159C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 00:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476807; cv=none; b=XIkNUfFPe+1C2E3R0mJ/HMMupNyQvJVV0ktjZdChpYLS9535nGJdURZxWBIJn/crZ128DOngV3Izsc1JKwho3578R2LTd/J8vNDh4q/UcYWFXFWwTEjkOTRJPmNFPfWaQyxDj/15eqhKLb2yIIvo8z1WihPZc9BoGWdqm47vLhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476807; c=relaxed/simple;
	bh=n4qYVI+5vw6nP6vialaamI7erXW0CC/vKRNitzPsQ0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptJQtMivMy4UrcVGQsinv5mi3EVYsDoBDOdSmrIgtsmKV0BDrwfxc4oRfDyy2KeTyd7s0jGrX3t70fErmwyz70pFc6nTWrkXx5kPOC5pPBtgSHxOQ388mLDffKFj9IOND2+8Ahh7dlONfgwg+8cD6x98gvH2FZLovBXo8u4ncpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEcTnDHF; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ed59386345so1020141cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 16:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762476805; x=1763081605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EMYmGSsqeU1KDtEF4CxFnVpHkfjLKjnXEKwE6nhE6B0=;
        b=IEcTnDHFRbhQELUGRkstjF1kIy/uzjb6H4ApFLfp3eBhjftY00lW2m/dfT1tm1crPE
         VngnAITUHZ6OWnMkWyVAj1INd1omc4G64zCo7/RjSEal8+1yKODGnQrAOGX4HD7Um4FA
         dCRm5+w/dFBcCwJHbtaQop+7zeguM3CX3LE5+dNroyYV8hLTM/oH3f4+AQCYqTNynnWs
         G+j1FPLjhVUS1tQUBzQlORq3bDHzTwU1oCKEvBDNOJUJ0wb14RTQvvDT5bav5SUA20Bi
         pj7OlTV9fCQ42WA0d9brGB9L4PYeazXarm2d1mQKvKv3WWCRRIp5lsiMa41H63tnB4xu
         C13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762476805; x=1763081605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMYmGSsqeU1KDtEF4CxFnVpHkfjLKjnXEKwE6nhE6B0=;
        b=aFQBar/Ni4XtT2aO/Ac4enRhbgEYTi4ib1MnURr+3pGbRDyTH0jp2YmuHh5TiShv/A
         O6R61jh4pfwT9e989E4/9L2mpTVJteeI/1+udw+6DC7QG0Wvqiv9/GYcFxzjCEQH6o4s
         zfPTIQ+x0eNB8pKIqYGuEGpsNwExKFPSyPTNJ20LWGAgEhNjPzFuDTbRdcWVSCD9IK2O
         5mcwdUtfb0ZXEx7lx3TJsZJMHh2XzUdDKb9EUjPIOHVoWWXAUWBc1LWOMeynkaUaHEwm
         OwVdAANIpRyDOyTq//ZQjL1kxkldZweSCutWTLb1Kn29uDfZMxOia70r4tps9ZGQbYIQ
         IW4g==
X-Forwarded-Encrypted: i=1; AJvYcCWyjspd0RrvhtsmOpP+FWNlDWfCUBt4UVFw9UUFy07Ovs++YaBuIkaPzGHHhV1ij+T2m+p/JifJr7UXcLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJoYvtX0OzO3n0NHufsMBO3TAkfyMdOZ//z4RqGJroDqqZXW/C
	Jhk0SdjedeWTtKSU03JRLyjOj89PzTQKg3SpsnwrHvYqpY5f58ALKQvl
X-Gm-Gg: ASbGnculO9OZOTld2WSfaBazrsrBM1UzIndhX2b80EaDwQWn+41mAxdTh/U2OuIxUdo
	HtD5G4DQnZLdLiw3IrIRbXG/dntGdTvVzEvrK7mQL51xmVSPTe6++GpvsxVgaEnVw+apIgReXv+
	f/zvv1R2l9Hr40ITOzA1bXCbgqN0jXYTYQoSJ3RsuDQi/jpaN6saf3ElfOJSlIh8Wsq6gorielY
	e5/ROOGelNCPLmeYk5vfIDxRE+U+vOHr4DJS22VbzXqUx9IPoE+zEzPoOjaAucCGstrpJ566oR/
	I8DC9usfDR0Huh3mY1OIb/gZHlFrQFf6QrtAT2B0O1ZnH5qIDCmfSeCjL2ckCOrw/yMvQU5vcCj
	X2ZL7HUVjnHqEapBFG+XMlkL2EPZMTcbtFOsMZiWq+ZEAwAv3JqVFYEMEqMUfFrx3LaacZupnTM
	gW/y2XF5I=
X-Google-Smtp-Source: AGHT+IFiMc8RzsIBsIzMJ+XwkCfeVR2K1y5iqPGYwD/UYhIHGqwy9VQsEjUeh10FWOEZ8H4o0TionA==
X-Received: by 2002:ac8:5783:0:b0:4ec:efbf:4ef2 with SMTP id d75a77b69052e-4ed94a6a15fmr19280081cf.47.1762476805099;
        Thu, 06 Nov 2025 16:53:25 -0800 (PST)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-880828c5816sm30074976d6.4.2025.11.06.16.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:53:24 -0800 (PST)
Date: Thu, 6 Nov 2025 19:53:22 -0500
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
Subject: Re: [PATCH v4 2/9] rust: cpumask: Add getters for globally defined
 cpumasks
Message-ID: <aQ1DAn7Djc19CgGF@yury>
References: <20251105-rust-percpu-v4-0-984b1470adcb@gmail.com>
 <20251105-rust-percpu-v4-2-984b1470adcb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105-rust-percpu-v4-2-984b1470adcb@gmail.com>

On Wed, Nov 05, 2025 at 03:01:14PM -0800, Mitchell Levy wrote:
> Add getters for the global cpumasks documented in
> `include/linux/cpumask.h`, specifically:
> - cpu_possible_mask
> - cpu_online_mask
> - cpu_enabled_mask
> - cpu_present_mask
> - cpu_active_mask
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
> ---
>  rust/kernel/cpumask.rs | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/rust/kernel/cpumask.rs b/rust/kernel/cpumask.rs
> index b7401848f59e..a6a130092fcb 100644
> --- a/rust/kernel/cpumask.rs
> +++ b/rust/kernel/cpumask.rs
> @@ -77,6 +77,52 @@ pub unsafe fn as_ref<'a>(ptr: *const bindings::cpumask) -> &'a Self {
>          unsafe { &*ptr.cast() }
>      }
>  
> +    /// Get a CPU mask representing possible CPUs; has bit `cpu` set iff cpu is populatable
> +    #[inline]
> +    pub fn possible_cpus() -> &'static Self {
> +        // SAFETY: `__cpu_possible_mask` is a valid global provided by the kernel that lives
> +        // forever.
> +        unsafe { Cpumask::as_ref(&raw const bindings::__cpu_possible_mask) }
> +    }

Not sure about this '&raw const' syntax, but I want to make sure that
all this getters provide non-modifiable references. To modify any of
those masks, one has to call a dedicated helper like set_cpu_possible().

Can you maybe explicitly mention it in the comments?

With that,

Acked-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>

> +    /// Get a CPU mask representing online CPUs; has bit `cpu` set iff cpu available to the
> +    /// scheduler
> +    #[inline]
> +    pub fn online_cpus() -> &'static Self {
> +        // SAFETY: `__cpu_online_mask` is a valid global provided by the kernel that lives forever.
> +        // Since we wrap the returned pointer in an `Opaque`, it's ok that `__cpu_online_mask`
> +        // may change its value.
> +        unsafe { Cpumask::as_ref(&raw const bindings::__cpu_online_mask) }
> +    }
> +
> +    /// Get a CPU mask representing enabled CPUs; has bit `cpu` set iff cpu can be brought online
> +    #[inline]
> +    pub fn enabled_cpus() -> &'static Self {
> +        // SAFETY: `__cpu_enabled_mask` is a valid global provided by the kernel that lives forever.
> +        // Since we wrap the returned pointer in an `Opaque`, it's ok that `__cpu_enabled_mask`
> +        // may change its value.
> +        unsafe { Cpumask::as_ref(&raw const bindings::__cpu_enabled_mask) }
> +    }
> +
> +    /// Get a CPU mask representing present CPUs; has bit `cpu` set iff cpu is populated
> +    #[inline]
> +    pub fn present_cpus() -> &'static Self {
> +        // SAFETY: `__cpu_present_mask` is a valid global provided by the kernel that lives
> +        // forever. Since we wrap the returned pointer in an `Opaque`, it's ok that
> +        // `__cpu_present_mask` may change its value.
> +        unsafe { Cpumask::as_ref(&raw const bindings::__cpu_present_mask) }
> +    }
> +
> +    /// Get a CPU mask representing active CPUs; has bit `cpu` set iff cpu is available to
> +    /// migration.
> +    #[inline]
> +    pub fn active_cpus() -> &'static Self {
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

