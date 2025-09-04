Return-Path: <linux-kernel+bounces-801569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70397B446C4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A4BC5A79BB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092B027703A;
	Thu,  4 Sep 2025 19:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeCwhj02"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76109277029;
	Thu,  4 Sep 2025 19:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757015645; cv=none; b=nAjPn+PBZvaQ2FGNIm+F09K7dgHR+rdiGrbeM4QWzJLKfYNtkl4Rb+lYUI7ryoF5MPULdgkgYVFKdnmrVUA78T+z/xSBsV/78dpvJrjZx7KmbOIBP+K9R+mANt3LeamIY9R8elJm6vaDr5Nd8nahNsQqX9a187G4wSPBPycqskk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757015645; c=relaxed/simple;
	bh=mXuvr9W3ZpZinDdt8ZVuqSvSo6fHF+jQKdRZQcpZLYc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8Yh+X3t1Tw8ixeNnIolo+NPi5N1HQ5H2DUMEFGrc/XbaARuF83Xb6kOKMec1ppjFQzMb3NYBpzOyeQ8YyZOyGfzn4mkuYDhbswzQlwp0Xai0/iYNqC9Oa+sETJTgXoJkzCTwLYmeIjARQ015GAJXH/JeReVAgi2IIianQCZPIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EeCwhj02; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3280264a6e8so1053376a91.3;
        Thu, 04 Sep 2025 12:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757015642; x=1757620442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CW6N/04aVXSqAqCWFvMO/Nhy5na9bRfLZIbzmF48rh0=;
        b=EeCwhj02KPBS3wbSkdDG7Vhqet7NYcbscA6duytPA+/BONmMagMsgswVB6xkdQMyc1
         MAtFq+Yb8/tVF12H3N1CnkBXyyX/FPcUSr3mV1IvFfztPuLwhLHvUnfjSiBp3wfRscw1
         obSNhevJuqp0NJX0bEuJPeivZVZktZIqwrTrd4JH7TM2mhq9cuOA7h+03r9GHaKtbCIa
         rs9RPa9WqlvsqLnKojBH4pWAdb6HqJqESD3PuRyGGAcQbiHT+VrCYYaWghMNXhxKWR1Y
         soT+MAx3OZBYmO1frYdLZFqNufT25HoWAtw9mVWduIiLuQpqrZr19mKNR4XzmHzfOig0
         VSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757015642; x=1757620442;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CW6N/04aVXSqAqCWFvMO/Nhy5na9bRfLZIbzmF48rh0=;
        b=na4OCdOfUPSnseD27ypprDyIP4N3BaP6dr5JE9zfa+p8tKHDQIi9TJQ1z9kBgO9op7
         HoA8d75wc+VEioFBzl3d+I4cDqNo7p084Ku31X4zehBPHtuEZgzCOcmXTshhfnjGrfvd
         cqu/W87AUG4Gw5PTBpW0V8eOQL+jpU/eGxJexPOx21m34TZ9LOuwPweQWe8TTzA74kQF
         /DXwXqJKJ1LuBAqXDAGvjOJZ7Dp/jsidkn4LbGgxDbJjcTwq7PQHT56CNSgXGJVBFbMs
         d+Xk3YOxFno0Xvpa2cFvy37o5O+xriCw6cZQKmQ+mCJclL+vPweXbJf2zeg6mTyTos84
         Friw==
X-Forwarded-Encrypted: i=1; AJvYcCUX75ZQLs9ITt4M84Wi+PknpucRJaLx3ix+A+BR23FHnPZOr/nzGj8ZDhZZqRZTbNAxHbzcOREdEwF4qck=@vger.kernel.org, AJvYcCUhEu/l4hUtbk9laJ+STEXFKT4lHRortr4GbKa2b6MbN+3vPzRQ07t3DmYkNKByESD432dcbWRuJb+j28as468=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcQkRl4jE5yQ8D0l+CGZC2pw/8UaD8dK0/k6RIDgvtktg7nhxH
	9A1ofUDQhFJwBC05aJ3ZO6jJ/MbyoT/9qEC1H6piqzOCLXIHddYzyBqj
X-Gm-Gg: ASbGncsa7q8FvO/nHxgLs66gfymIA6Qx2aFcHtG+Ascgwvmu3B9L0VCZX/OPVPd9BED
	ctymhMf6nxVKc/oTce6l4qWGrio4imfDxy5rG2kM/iBls79taX8tkXEMGKoyQZUXsd+jCqxseVq
	HxnBvXrXhJKs8bhuE2j0tU/XW3FfSh3MA1ekCXmcLWj2g+ECFiQZ6CsM79IcsmunYfYx3ClUxpk
	/Cqp+++PuToHH8hFpSClU8LFevAjsRdVca2MEFepsM8Joo6XmF4bntGiecVZdd2DRG84WNnnAA5
	V+qS6R7L9Fn4eyGAbEHMa6IL2o26Z0sf8PPXrElw7hAStoMhEAmHpobgYtonUh1sOs8BDm2ZbNx
	4HVIzMwPyT0zaIny+A7uDhfKo+ZIUD41GW0ha2g==
X-Google-Smtp-Source: AGHT+IG7yjTqmFrmq0f5et6mH4alxx7MGzM2q6Z+jEo61g9eRQwwTVozQdAP4sVYRYxT/Uynbist0w==
X-Received: by 2002:a17:90b:2809:b0:32b:6223:25a with SMTP id 98e67ed59e1d1-32b62230482mr8507388a91.28.1757015642287;
        Thu, 04 Sep 2025 12:54:02 -0700 (PDT)
Received: from Cyndaquil. ([174.127.224.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32b90b574cesm1442080a91.0.2025.09.04.12.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 12:54:01 -0700 (PDT)
Message-ID: <68b9ee59.170a0220.a7a31.675c@mx.google.com>
X-Google-Original-Message-ID: <aLnuV7zP28+sbl2t@Cyndaquil.>
Date: Thu, 4 Sep 2025 12:53:59 -0700
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
Subject: Re: [PATCH v3 1/7] rust: percpu: introduce a rust API for per-CPU
 variables
References: <20250828-rust-percpu-v3-0-4dd92e1e7904@gmail.com>
 <20250828-rust-percpu-v3-1-4dd92e1e7904@gmail.com>
 <aLi2MBAwoD65tokv@yury>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLi2MBAwoD65tokv@yury>

On Wed, Sep 03, 2025 at 05:42:08PM -0400, Yury Norov wrote:
> On Thu, Aug 28, 2025 at 12:00:08PM -0700, Mitchell Levy wrote:
> > Per-CPU variables are an important tool for reducing lock contention,
> > especially in systems with many processors. They also provide a
> > convenient way to handle data that are logically associated with a
> > particular CPU (e.g., the currently running task). Therefore, add a Rust
> > API to make use of per-CPU variables.
> > 
> > Add a `CpuGuard` type that disables preemption for its lifetime. Add a
> > `PerCpuAllocation` type used to track dynamic allocations. Add a
> > `define_per_cpu!` macro to create static per-CPU allocations. Add
> > `DynamicPerCpu` and `StaticPerCpu` to provide a high-level API. Add a
> > `PerCpu` trait to unify the dynamic and static cases.
> > 
> > Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
> > ---
> >  rust/helpers/helpers.c          |   2 +
> >  rust/helpers/percpu.c           |   9 ++
> >  rust/helpers/preempt.c          |  14 +++
> >  rust/kernel/lib.rs              |   3 +
> >  rust/kernel/percpu.rs           | 223 ++++++++++++++++++++++++++++++++++++++++
> >  rust/kernel/percpu/cpu_guard.rs |  35 +++++++
> >  rust/kernel/percpu/dynamic.rs   |  83 +++++++++++++++
> >  rust/kernel/percpu/static_.rs   | 132 ++++++++++++++++++++++++
> >  8 files changed, 501 insertions(+)
> 
> That's quite a massive patch. Can you please split-out C-binders, and
> maybe make separate patches for each .rs component?

Sure, will do so for v4.

> > diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> > index 7cf7fe95e41d..2fc8d26cfe66 100644

[...]

> > --- /dev/null
> > +++ b/rust/kernel/percpu.rs
> > @@ -0,0 +1,223 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +//! This module contains abstractions for creating and using per-CPU variables from Rust.
> > +//! See the define_per_cpu! macro and the DynamicPerCpu<T> type, as well as the PerCpu<T> trait.
> > +
> > +pub mod cpu_guard;
> > +mod dynamic;
> > +mod static_;
> > +
> > +#[doc(inline)]
> > +pub use dynamic::*;
> > +#[doc(inline)]
> > +pub use static_::*;
> > +
> > +use bindings::{alloc_percpu, free_percpu};
> > +
> > +use crate::alloc::Flags;
> > +use crate::percpu::cpu_guard::CpuGuard;
> > +use crate::prelude::*;
> > +use crate::sync::Arc;
> > +use crate::types::Opaque;
> > +use crate::{declare_extern_per_cpu, get_static_per_cpu};
> > +
> > +use core::arch::asm;
> > +use core::cell::{Cell, RefCell, UnsafeCell};
> > +use core::mem::{align_of, size_of, MaybeUninit};
> > +
> > +use ffi::c_void;
> > +
> > +/// A per-CPU pointer; that is, an offset into the per-CPU area. Note that this type is NOT a smart
> > +/// pointer, it does not manage the allocation.
> > +pub struct PerCpuPtr<T>(*mut MaybeUninit<T>);
> > +
> > +/// Represents exclusive access to the memory location pointed at by a particular PerCpu<T>.
> > +pub struct PerCpuToken<'a, T> {
> > +    // INVARIANT: the current CPU's memory location associated with the per-CPU variable pointed at
> > +    // by `ptr` (i.e., the entry in the per-CPU area on the current CPU) has been initialized.
> > +    _guard: CpuGuard,
> > +    ptr: &'a PerCpuPtr<T>,
> > +}
> > +
> > +/// Represents access to the memory location pointed at by a particular PerCpu<T> where the type
> > +/// `T` manages access to the underlying memory to avoid aliaising troubles. (For example, `T`
> > +/// might be a `Cell` or `RefCell`.)
> > +pub struct CheckedPerCpuToken<'a, T> {
> > +    // INVARIANT: the current CPU's memory location associated with the per-CPU variable pointed at
> > +    // by `ptr` (i.e., the entry in the per-CPU area on the current CPU) has been initialized.
> > +    _guard: CpuGuard,
> > +    ptr: &'a PerCpuPtr<T>,
> > +}
> > +
> > +impl<T> PerCpuPtr<T> {
> > +    /// Makes a new PerCpuPtr from a raw per-CPU pointer.
> > +    ///
> > +    /// # Safety
> > +    /// `ptr` must be a valid per-CPU pointer.
> > +    pub unsafe fn new(ptr: *mut MaybeUninit<T>) -> Self {
> > +        Self(ptr)
> > +    }
> > +
> > +    /// Get a `&mut MaybeUninit<T>` to the per-CPU variable on the current CPU represented by `&self`
> > +    ///
> > +    /// # Safety
> > +    /// The returned `&mut T` must follow Rust's aliasing rules. That is, no other `&(mut) T` may
> > +    /// exist that points to the same location in memory. In practice, this means that `get_(mut_)ref`
> 
> How long is this line?

102 chars, or 103 if you include the newline. `rustfmt` doesn't break
the line, so I left it as-is for this patch. Happy to change it if it
poses a problem, though.

> > +    /// must not be called on another `PerCpuPtr<T>` that is a copy/clone of `&self` for as long as
> > +    /// the returned reference lives.
> > +    ///
> > +    /// CPU preemption must be disabled before calling this function and for the lifetime of the
> > +    /// returned reference. Otherwise, the returned reference might end up being a reference to a
> > +    /// different CPU's per-CPU area, causing the potential for a data race.
> > +    #[allow(clippy::mut_from_ref)] // Safety requirements prevent aliasing issues
> > +    pub unsafe fn get_mut_ref(&self) -> &mut MaybeUninit<T> {
> > +        // SAFETY: `self.get_ptr()` returns a valid pointer to a `MaybeUninit<T>` by its contract,
> > +        // and the safety requirements of this function ensure that the returned reference is
> > +        // exclusive.
> > +        unsafe { &mut *(self.get_ptr()) }
> > +    }
> 
> Here and everywhere: would it make sense to enforce it by testing
> the CPU with preemptible() before returning a reference? 

The only thing we could do would be to panic, which I don't 100% love.
Another alternative would be to take a &'a CpuGuard and bound the
lifetime of the returned reference to 'a, and then we don't need to do
any run-time checking at all.

Originally, I had left this to the caller because it might make sense
down the line for some complex behavior based on per-CPU (e.g., per-CPU
refcount) to do all its own management of per-CPU variables using
`PerCpuPtr` as a core primitive. In these cases, I believe there are
some times where being non-preemptible wouldn't actually be required
(that said, my thoughts on this aren't well reflected in the safety
comment, since I said it must be disabled... gah). But, the more I think
about it, the more I think these use cases would be better served by
just using `get_ptr` --- conjuring `&mut` references seems like it would
be a big footgun. And the safety comment already actually reflects these
thoughts somewhat :)

For v4 I will probably have this function take a &'a CpuGuard and use
that to bound the liftetime of the returned reference, unless there are
other thoughts on this point.

Thanks,
Mitchell

> Thanks,
> Yury

