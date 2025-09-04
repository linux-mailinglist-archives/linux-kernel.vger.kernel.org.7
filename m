Return-Path: <linux-kernel+bounces-801570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20892B446C5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DED32A06555
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C36277C90;
	Thu,  4 Sep 2025 19:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRNirJvy"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E811BD035;
	Thu,  4 Sep 2025 19:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757015750; cv=none; b=tC+nPxSQX4y6STBAs7Di0Sw47gF8CXgq5J7M8bANlv56OtPtLPX+/jTg7OIw06btGUg0XsHXMNDK/q/yEVqVId6mJXBX8Eotb7z33AVtDZ5LwzQlp2XXkrsYolnHEcLltLVo5b5IqAJMiuQOSH+gRmiP/365z9y/dg+ON8gAqRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757015750; c=relaxed/simple;
	bh=jOzW1iSEHDaKI2+fj5ZzkmWK4dpWol1b9yL8qaZ88nw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCyBP4LpPMmlnfHlZky+qLcO9XcVWPvY10crJi0NXBQ1LUhPIitIt5EdMG5Z/e5h1Ke8GuVxW4k1xRJYGOU0S+HeLHWhi+/iBgXAt0bTo+p2HdC2hP1OWQxUjEDatSNXOoVGOwmlSY4IXTsoeI3sy6RCDuH8G5yAKw7YIkaNwnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRNirJvy; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4c6fee41c9so1105730a12.1;
        Thu, 04 Sep 2025 12:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757015748; x=1757620548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bMvvP6Q6P7dnqKHCgcbrirHcRzQIivzHuvswVHDmhxk=;
        b=YRNirJvybMTgW1nVMB6oDm/vazNLnRwmjxhB9ZA29yxiTm9g9gHxchOsNTBLDHpjex
         5TN+dgLivPobR/pZDL+vblLu20cmO239iGeMNGE4qD+gEHefd0g5w8/bMt/grq0erwNY
         /E4m5xNjK2ONU8XVS9Y+b07mlISwXxGBfsLL1oO18psFsk9htD9SspW4YyERE7C3MqH3
         w85CPv1OzJ4NxK42un+U63eRL8wO0LSNZtWn6/dk8ZlxosaF8oV2m+WAeMlI6JdFL2rF
         MZfJnicAb3cbnkL7MkMyGIjqraVselvL/3NNiXK5jvR08IXgzFDs3ZBS8HtDKzk+wEyc
         jB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757015748; x=1757620548;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMvvP6Q6P7dnqKHCgcbrirHcRzQIivzHuvswVHDmhxk=;
        b=BvS8InoUPH7CZD/lICVIRePILJzBGvUADJhoya+9EaHyEGR1myegRELW2bvmBcIqKa
         W0zf32mTZf2iE0U0M9o+krTliwkFyUCG4Ibrkr6wQuoHzEet9NgYitiDT/bWVYEQTIeh
         tTAyC+2JDbBSHr40dbYx/x1mNO7Ryj5u3kwac7UQrszJDgBXgvAbAccdCSfaqaa8Ivym
         yMgYBUY9fXCY/QwttHikImrHOkILM7MqkvL70rmKxYN8UaJBPXFEm/A+hMCE6wWA6FjO
         BGassWs4hCwPvUst5SMTyMmh1o+VgSExmeK+MvucPPD3kwzFwN+d8SljvN+Ie98sHvkR
         pwBg==
X-Forwarded-Encrypted: i=1; AJvYcCWNwB/t76Wxdoe3xa9e0dPO/GmfKNe4+huDVZHwHf8+iQRuL/SlTzm7t5NQQ/KtKPZi77sCoVHch7QwmyRsoE4=@vger.kernel.org, AJvYcCXz3uyY0jAdHDAk+w8yqSptO6EDvWWpCPKSmvqosA+lMFrEpxL1AAqCuPKGpEnAbhbJ/uPfuj1T4xaMeQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj4Ne2FBGzPh6bQnaUQcYRY+6/LlLRdoqpy9ZHeqGPA5bb86f6
	SquLEbVc6R3pG1jO/MN5WJ6NlfzI3hMLYv5f+2BJcj16S3ifKzrp2M2u
X-Gm-Gg: ASbGncvRYz3BATcvqQnGjeK6P0a7HtukhhFjcvJnsXtkHzxmn0M8M9XPfPnyzPZU1xY
	psgxi/OtcSJ1os0vaQMgNvVMqFIRxAYRjmnAVJEId0O2fia2He7s6sOWF+TnnO5g8Jray+Ciab5
	geJ78lLykjhjvyD0X9Jn6YN3J++yDbbe0EMp4wxP2dPcdE8z6ivNrPxQPfi6VUA1MH6JwiyvajY
	WLOo0SNLUL9iV3T4LnsVZ10vAUNBi5ncIJFKWXdzio0doT3SPZxQdeYXGK0wSZPaN/ReqVJgC51
	qN4NVMrPY48HZ4NQHIrul9BWsiIL9fnhD/V0A9+VH7ycHVqYNjrqpXn7Cykb5nkN+IWXfqqy8BI
	g2KSzgceD/wD1UMRBdh5jqKM6vFQKtIc0fzLyn6m7tZlGeoVO
X-Google-Smtp-Source: AGHT+IHW6f+P8YnMRKWbSCVkVppITDLw8F9XmDLoYK0RMqz7/Up3hPmTP38YZ62HC4D/4i4MyuBATg==
X-Received: by 2002:a17:903:1a67:b0:24c:b83f:c6bc with SMTP id d9443c01a7336-24cb83fcae1mr71797005ad.56.1757015747493;
        Thu, 04 Sep 2025 12:55:47 -0700 (PDT)
Received: from Cyndaquil. ([174.127.224.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cac2f24fdsm39950505ad.46.2025.09.04.12.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 12:55:47 -0700 (PDT)
Message-ID: <68b9eec3.170a0220.67a17.2278@mx.google.com>
X-Google-Original-Message-ID: <aLnuwADb4/E8BhN9@Cyndaquil.>
Date: Thu, 4 Sep 2025 12:55:44 -0700
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
	Tyler Hicks <code@tyhicks.com>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 4/7] rust: cpumask: Add getters for globally defined
 cpumasks
References: <20250828-rust-percpu-v3-0-4dd92e1e7904@gmail.com>
 <20250828-rust-percpu-v3-4-4dd92e1e7904@gmail.com>
 <aLi7Ptya5xp22P-B@yury>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLi7Ptya5xp22P-B@yury>

On Wed, Sep 03, 2025 at 06:03:51PM -0400, Yury Norov wrote:
> On Thu, Aug 28, 2025 at 12:00:11PM -0700, Mitchell Levy wrote:
> > Add getters for the global cpumasks documented in
> > `include/linux/cpumask.h`, specifically:
> > - cpu_possible_mask
> > - cpu_online_mask
> > - cpu_enabled_mask
> > - cpu_present_mask
> > - cpu_active_mask
> > 
> > Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
> > ---
> >  rust/kernel/cpumask.rs | 46 ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> > 
> > diff --git a/rust/kernel/cpumask.rs b/rust/kernel/cpumask.rs
> > index b7401848f59e..ca9aa6875b4a 100644
> > --- a/rust/kernel/cpumask.rs
> > +++ b/rust/kernel/cpumask.rs
> > @@ -77,6 +77,52 @@ pub unsafe fn as_ref<'a>(ptr: *const bindings::cpumask) -> &'a Self {
> >          unsafe { &*ptr.cast() }
> >      }
> >  
> > +    /// Get a CPU mask representing possible CPUs; has bit `cpu` set iff cpu is populatable
> > +    #[inline]
> > +    pub fn possible() -> &'static Self {
> > +        // SAFETY: `__cpu_possible_mask` is a valid global provided by the kernel that lives
> > +        // forever.
> > +        unsafe { Cpumask::as_ref(&raw const bindings::__cpu_possible_mask) }
> > +    }
> 
> This function and the following look like returning a boolean.
> Maybe possible_cpus()? 

Agreed, I think that's definitely better. Will do for v4.

> The general rule is to keep the rust naming as close to C as
> possible, but in this case Cpumask::cpu_possible_mask is, OK,
> somewhat excessive.

Agreed :)

Thanks,
Mitchell

> Thanks,
> Yury
> 
> > +
> > +    /// Get a CPU mask representing online CPUs; has bit `cpu` set iff cpu available to the
> > +    /// scheduler
> > +    #[inline]
> > +    pub fn online() -> &'static Self {
> > +        // SAFETY: `__cpu_online_mask` is a valid global provided by the kernel that lives forever.
> > +        // Since we wrap the returned pointer in an `Opaque`, it's ok that `__cpu_online_mask`
> > +        // may change its value.
> > +        unsafe { Cpumask::as_ref(&raw const bindings::__cpu_online_mask) }
> > +    }
> > +
> > +    /// Get a CPU mask representing enabled CPUs; has bit `cpu` set iff cpu can be brought online
> > +    #[inline]
> > +    pub fn enabled() -> &'static Self {
> > +        // SAFETY: `__cpu_enabled_mask` is a valid global provided by the kernel that lives forever.
> > +        // Since we wrap the returned pointer in an `Opaque`, it's ok that `__cpu_enabled_mask`
> > +        // may change its value.
> > +        unsafe { Cpumask::as_ref(&raw const bindings::__cpu_enabled_mask) }
> > +    }
> > +
> > +    /// Get a CPU mask representing present CPUs; has bit `cpu` set iff cpu is populated
> > +    #[inline]
> > +    pub fn present() -> &'static Self {
> > +        // SAFETY: `__cpu_present_mask` is a valid global provided by the kernel that lives
> > +        // forever. Since we wrap the returned pointer in an `Opaque`, it's ok that
> > +        // `__cpu_present_mask` may change its value.
> > +        unsafe { Cpumask::as_ref(&raw const bindings::__cpu_present_mask) }
> > +    }
> > +
> > +    /// Get a CPU mask representing active CPUs; has bit `cpu` set iff cpu is available to
> > +    /// migration.
> > +    #[inline]
> > +    pub fn active() -> &'static Self {
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

