Return-Path: <linux-kernel+bounces-799458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A99F5B42C0C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09B3C1B27BD4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8902EBBB0;
	Wed,  3 Sep 2025 21:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxNAccck"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A732A15ECCC;
	Wed,  3 Sep 2025 21:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756935734; cv=none; b=ImOdnAQDQSgy5NloVcRJPC5LzxKLgafLwjB6Ons5nIRJcFAKgfFbfg10bqrvybpH8bb6zZivE01WlNNmX3kBYWlP7Ci0YfGwsqIKRxztrkiT9dj4up/E0vDiMd+m0Z60hVoV2qU1XBR+/qGNfLMzaZxnknVhwTduQZoDXAY0Yxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756935734; c=relaxed/simple;
	bh=rJ/96WqQKYV+fqE6uNQyL8aeB8svx4aoC/Intl9G/Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLryg0nSocxxZw+wNiZ3DNk/jlJBz4xpSjJCC9uDRU0DWyS4rvuzfqtfKTY5HI60ivZfLEdZbNGbNb/068cHvT6hT4mJjZ3Ot9wXfglKBUsY/ZfGwEYL4tUMUswK5/cOA8Aq7t/tnSPsHVTPxqX+0UyKYtcy12E0YQNybZ8OJ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxNAccck; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24458272c00so4797355ad.3;
        Wed, 03 Sep 2025 14:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756935732; x=1757540532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=913G5mrad7tqw4Q34JzVSSV+9stS80/tzD0diJIXDJg=;
        b=bxNAccckc8cQxjml/f7oUX2bsBmGB6kXpE4LRDqBsnzRez5ez18EqunYp+4T48b927
         3f6lUyhcy0nR9yu2ocAZLjUJECtwTTL6ytJN+x8QlEvp65FCRNvCtmzrhyYVaj/b5qfz
         PTX5j3BarG0B0fAJJ07cDYcNy1yWrgmcaMlCHVrkaC+85wZa4wim4L8jr4bgT5Vx2vnH
         zG1vfMtnjC3z5BZdlGr0FBK1f3AN6vQ7nnuLeyljHqPI9WlwXTJOa8VNznYwCWBYX2SZ
         pSeYjea/jzWz7jl662qhHQcHkIj3oaZNJ1Q31GNY4dkJTj5N+QuD3I7xEs6r6qUnTBhT
         BjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756935732; x=1757540532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=913G5mrad7tqw4Q34JzVSSV+9stS80/tzD0diJIXDJg=;
        b=S2DvpB2QzbwSV28uZp2Y4umKmqeQVhHWxZZU+z2VH53FxOdl/KezLiQVG5zWAzCoZU
         sibufEXEBteEhxxAoATgwNDsdoHOHiHJyxeLRV8ISmfoPWdKJVdHayF/Hps6VxwxLwd5
         UxflzmgVQt0JiSb59WOagETEWz2b3Eul9SMbZhgPufIrzLe8V0UQOz91C1TR5oMsHnG8
         yAR6VRQilbWQ9xl1g4gl2EZebw0NiXbdlANvAVVtIod2k7MF8JJYWW9gr1xmvBQD+2XO
         oA54HPlfqhnTFtkhr44hBP3HdOyaDKV1tQlmjZbRooHWZEV05lzT87Fd3CfJg0zVnf21
         /zVA==
X-Forwarded-Encrypted: i=1; AJvYcCU01V8PFRy4Mk0n7mxKyyyqC8cACpMcouJBITQqhRcFHaG99PtjyJZ3vWk6oEakkNREBICzdIQMp5kbR0WoHm8=@vger.kernel.org, AJvYcCW8sGFbR9IZoR1qTEmx8ynnM6yiFj/VKelPHEioqbKrSXyw4GUrn3dqq3x4Dye+o409/NcDgCSQ4hDxVDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWxbXCDeEOxLFeAGPCeZt9bIBswr1048t6YZuWek6uppsEEy3m
	FdnXyVGXgbK0erKPIm3RWTDddhNou6WbDZgO6B0LT/DW5wuqF4PTfncP
X-Gm-Gg: ASbGnct1uLJ0ZwlJ+fO2cbF7jLNO3sFlDr0/j1i0eKq52RY364XohV6jd0UJKCUd3sX
	L4g48yCa02Napj62sbmG9e1ZxAat3v4Ujx0ziBNG4N7RKrZoHnspyedBDLOAHojx1bjZZSJcJ2O
	9KV3aZEX0z0qBppvmbZUiOYuvlosGyPoh2TrKMXEoV+giy7CzVuYuK5GnTApYAcVyTcKNNNhYoU
	zyfNI9kg8hIRb728eXf8rQ2iJtLi1foq+kegqhbQUCUyZWz2g7rmOn5UVSpM0nXQOTIwP9dQpEX
	qC7VG6iqq/tmApa4zawrcOvpNN+mM5e/qA55CB6F3RVe+8tWi8vZbxk8C2skmrK5GpDphOrMe+V
	Ux5Xbhuq7tSlNpb/fbDAL/xBZCcwIlCTepBkfsGKdQOw=
X-Google-Smtp-Source: AGHT+IGEYHhpxlwqty29iAepYIz+AXBP+Q3J6jABrmveCaY2FnQU2gGFW3oELEV3nWCQvKX8RF2QGw==
X-Received: by 2002:a17:902:da84:b0:24a:ad8a:81f0 with SMTP id d9443c01a7336-24aad8a8560mr158617335ad.51.1756935731425;
        Wed, 03 Sep 2025 14:42:11 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b15780a11sm57490635ad.93.2025.09.03.14.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 14:42:10 -0700 (PDT)
Date: Wed, 3 Sep 2025 17:42:08 -0400
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
Subject: Re: [PATCH v3 1/7] rust: percpu: introduce a rust API for per-CPU
 variables
Message-ID: <aLi2MBAwoD65tokv@yury>
References: <20250828-rust-percpu-v3-0-4dd92e1e7904@gmail.com>
 <20250828-rust-percpu-v3-1-4dd92e1e7904@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828-rust-percpu-v3-1-4dd92e1e7904@gmail.com>

On Thu, Aug 28, 2025 at 12:00:08PM -0700, Mitchell Levy wrote:
> Per-CPU variables are an important tool for reducing lock contention,
> especially in systems with many processors. They also provide a
> convenient way to handle data that are logically associated with a
> particular CPU (e.g., the currently running task). Therefore, add a Rust
> API to make use of per-CPU variables.
> 
> Add a `CpuGuard` type that disables preemption for its lifetime. Add a
> `PerCpuAllocation` type used to track dynamic allocations. Add a
> `define_per_cpu!` macro to create static per-CPU allocations. Add
> `DynamicPerCpu` and `StaticPerCpu` to provide a high-level API. Add a
> `PerCpu` trait to unify the dynamic and static cases.
> 
> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
> ---
>  rust/helpers/helpers.c          |   2 +
>  rust/helpers/percpu.c           |   9 ++
>  rust/helpers/preempt.c          |  14 +++
>  rust/kernel/lib.rs              |   3 +
>  rust/kernel/percpu.rs           | 223 ++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/percpu/cpu_guard.rs |  35 +++++++
>  rust/kernel/percpu/dynamic.rs   |  83 +++++++++++++++
>  rust/kernel/percpu/static_.rs   | 132 ++++++++++++++++++++++++
>  8 files changed, 501 insertions(+)

That's quite a massive patch. Can you please split-out C-binders, and
maybe make separate patches for each .rs component?

> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 7cf7fe95e41d..2fc8d26cfe66 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -31,9 +31,11 @@
>  #include "of.c"
>  #include "page.c"
>  #include "pci.c"
> +#include "percpu.c"
>  #include "pid_namespace.c"
>  #include "platform.c"
>  #include "poll.c"
> +#include "preempt.c"
>  #include "property.c"
>  #include "rbtree.c"
>  #include "rcu.c"
> diff --git a/rust/helpers/percpu.c b/rust/helpers/percpu.c
> new file mode 100644
> index 000000000000..a091389f730f
> --- /dev/null
> +++ b/rust/helpers/percpu.c
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/percpu.h>
> +
> +void __percpu *rust_helper_alloc_percpu(size_t sz, size_t align)
> +{
> +	return __alloc_percpu(sz, align);
> +}
> +
> diff --git a/rust/helpers/preempt.c b/rust/helpers/preempt.c
> new file mode 100644
> index 000000000000..2c7529528ddd
> --- /dev/null
> +++ b/rust/helpers/preempt.c
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/preempt.h>
> +
> +void rust_helper_preempt_disable(void)
> +{
> +	preempt_disable();
> +}
> +
> +void rust_helper_preempt_enable(void)
> +{
> +	preempt_enable();
> +}
> +
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index ed53169e795c..ed0d5756dc55 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -106,6 +106,9 @@
>  pub mod page;
>  #[cfg(CONFIG_PCI)]
>  pub mod pci;
> +// Only x86_64 is supported by percpu for now
> +#[cfg(CONFIG_X86_64)]
> +pub mod percpu;
>  pub mod pid_namespace;
>  pub mod platform;
>  pub mod prelude;
> diff --git a/rust/kernel/percpu.rs b/rust/kernel/percpu.rs
> new file mode 100644
> index 000000000000..35afcdba3ccd
> --- /dev/null
> +++ b/rust/kernel/percpu.rs
> @@ -0,0 +1,223 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//! This module contains abstractions for creating and using per-CPU variables from Rust.
> +//! See the define_per_cpu! macro and the DynamicPerCpu<T> type, as well as the PerCpu<T> trait.
> +
> +pub mod cpu_guard;
> +mod dynamic;
> +mod static_;
> +
> +#[doc(inline)]
> +pub use dynamic::*;
> +#[doc(inline)]
> +pub use static_::*;
> +
> +use bindings::{alloc_percpu, free_percpu};
> +
> +use crate::alloc::Flags;
> +use crate::percpu::cpu_guard::CpuGuard;
> +use crate::prelude::*;
> +use crate::sync::Arc;
> +use crate::types::Opaque;
> +use crate::{declare_extern_per_cpu, get_static_per_cpu};
> +
> +use core::arch::asm;
> +use core::cell::{Cell, RefCell, UnsafeCell};
> +use core::mem::{align_of, size_of, MaybeUninit};
> +
> +use ffi::c_void;
> +
> +/// A per-CPU pointer; that is, an offset into the per-CPU area. Note that this type is NOT a smart
> +/// pointer, it does not manage the allocation.
> +pub struct PerCpuPtr<T>(*mut MaybeUninit<T>);
> +
> +/// Represents exclusive access to the memory location pointed at by a particular PerCpu<T>.
> +pub struct PerCpuToken<'a, T> {
> +    // INVARIANT: the current CPU's memory location associated with the per-CPU variable pointed at
> +    // by `ptr` (i.e., the entry in the per-CPU area on the current CPU) has been initialized.
> +    _guard: CpuGuard,
> +    ptr: &'a PerCpuPtr<T>,
> +}
> +
> +/// Represents access to the memory location pointed at by a particular PerCpu<T> where the type
> +/// `T` manages access to the underlying memory to avoid aliaising troubles. (For example, `T`
> +/// might be a `Cell` or `RefCell`.)
> +pub struct CheckedPerCpuToken<'a, T> {
> +    // INVARIANT: the current CPU's memory location associated with the per-CPU variable pointed at
> +    // by `ptr` (i.e., the entry in the per-CPU area on the current CPU) has been initialized.
> +    _guard: CpuGuard,
> +    ptr: &'a PerCpuPtr<T>,
> +}
> +
> +impl<T> PerCpuPtr<T> {
> +    /// Makes a new PerCpuPtr from a raw per-CPU pointer.
> +    ///
> +    /// # Safety
> +    /// `ptr` must be a valid per-CPU pointer.
> +    pub unsafe fn new(ptr: *mut MaybeUninit<T>) -> Self {
> +        Self(ptr)
> +    }
> +
> +    /// Get a `&mut MaybeUninit<T>` to the per-CPU variable on the current CPU represented by `&self`
> +    ///
> +    /// # Safety
> +    /// The returned `&mut T` must follow Rust's aliasing rules. That is, no other `&(mut) T` may
> +    /// exist that points to the same location in memory. In practice, this means that `get_(mut_)ref`

How long is this line?

> +    /// must not be called on another `PerCpuPtr<T>` that is a copy/clone of `&self` for as long as
> +    /// the returned reference lives.
> +    ///
> +    /// CPU preemption must be disabled before calling this function and for the lifetime of the
> +    /// returned reference. Otherwise, the returned reference might end up being a reference to a
> +    /// different CPU's per-CPU area, causing the potential for a data race.
> +    #[allow(clippy::mut_from_ref)] // Safety requirements prevent aliasing issues
> +    pub unsafe fn get_mut_ref(&self) -> &mut MaybeUninit<T> {
> +        // SAFETY: `self.get_ptr()` returns a valid pointer to a `MaybeUninit<T>` by its contract,
> +        // and the safety requirements of this function ensure that the returned reference is
> +        // exclusive.
> +        unsafe { &mut *(self.get_ptr()) }
> +    }

Here and everywhere: would it make sense to enforce it by testing
the CPU with preemptible() before returning a reference? 

Thanks,
Yury

> +
> +    /// Get a `&MaybeUninit<T>` to the per-CPU variable on the current CPU represented by `&self`
> +    ///
> +    /// # Safety
> +    /// The returned `&T` must follow Rust's aliasing rules. That is, no `&mut T` may exist that
> +    /// points to the same location in memory. In practice, this means that `get_mut_ref` must not
> +    /// be called on another `PerCpuPtr<T>` that is a copy/clone of `&self` for as long as the
> +    /// returned reference lives.
> +    ///
> +    /// CPU preemption must be disabled before calling this function and for the lifetime of the
> +    /// returned reference. Otherwise, the returned reference might end up being a reference to a
> +    /// different CPU's per-CPU area, causing the potential for a data race.
> +    pub unsafe fn get_ref(&self) -> &MaybeUninit<T> {
> +        // SAFETY: `self.get_ptr()` returns a valid pointer to a `MaybeUninit<T>` by its contract.
> +        // The safety requirements of this function ensure that the returned reference isn't
> +        // aliased by a `&mut MaybeUninit<T>`.
> +        unsafe { &*self.get_ptr() }
> +    }
> +
> +    /// Get a `*mut MaybeUninit<T>` to the per-CPU variable on the current CPU represented by
> +    /// `&self`. Note that if CPU preemption is not disabled before calling this function, use of
> +    /// the returned pointer may cause a data race without some other synchronization mechanism.
> +    /// Buyer beware!
> +    pub fn get_ptr(&self) -> *mut MaybeUninit<T> {
> +        let this_cpu_off_pcpu: PerCpuPtr<*mut c_void> = get_static_per_cpu!(this_cpu_off).0;
> +        let mut this_cpu_area: *mut c_void;
> +        // SAFETY: gs + this_cpu_off_pcpu is guaranteed to be a valid pointer because `gs` points
> +        // to the per-CPU area and this_cpu_off_pcpu is a valid per-CPU allocation.
> +        unsafe {
> +            asm!(
> +                "mov {out}, gs:[{off_val}]",
> +                off_val = in(reg) this_cpu_off_pcpu.0,
> +                out = out(reg) this_cpu_area,
> +            )
> +        };
> +
> +        // This_cpu_area + self.0 is guaranteed to be a valid pointer by the per-CPU subsystem and
> +        // the invariant that self.0 is a valid offset into the per-CPU area.
> +        (this_cpu_area).wrapping_add(self.0 as usize).cast()
> +    }
> +}
> +
> +// SAFETY: Sending a `PerCpuPtr<T>` to another thread is safe because as soon as it's sent, the
> +// pointer is logically referring to a different place in memory in the other CPU's per-CPU area.
> +// In particular, this means that there are no restrictions on the type `T`.
> +unsafe impl<T> Send for PerCpuPtr<T> {}
> +
> +// SAFETY: Two threads concurrently making use of a `PerCpuPtr<T>` will each see the `T` in their
> +// own per-CPU area, so there's no potential for a data race (regardless of whether `T` is itself
> +// `Sync`).
> +unsafe impl<T> Sync for PerCpuPtr<T> {}
> +
> +impl<T> Clone for PerCpuPtr<T> {
> +    fn clone(&self) -> Self {
> +        *self
> +    }
> +}
> +
> +/// `PerCpuPtr` is just a wrapper around a pointer.
> +impl<T> Copy for PerCpuPtr<T> {}
> +
> +/// A trait representing a per-CPU variable. This is implemented for both `StaticPerCpu<T>` and
> +/// `DynamicPerCpu<T>`. The main usage of this trait is to call `get_mut` to get a `PerCpuToken`
> +/// that can be used to access the underlying per-CPU variable. See `PerCpuToken::with`.
> +pub trait PerCpu<T> {
> +    /// Produces a token, asserting that the holder has exclusive access to the underlying memory
> +    /// pointed to by `self`
> +    ///
> +    /// # Safety
> +    /// No other `PerCpuToken` or `CheckedPerCpuToken` may exist on the current CPU (which is a
> +    /// sensible notion, since we keep a `CpuGuard` around) that is derived from the same
> +    /// `PerCpu<T>` or a clone thereof.
> +    unsafe fn get_mut(&mut self, guard: CpuGuard) -> PerCpuToken<'_, T>;
> +}
> +
> +/// A marker trait for types that are interior mutable. Types that implement this trait can be used
> +/// to create "checked" per-CPU variables. See `CheckedPerCpu<T>`.
> +pub trait InteriorMutable {}
> +
> +impl<T> InteriorMutable for Cell<T> {}
> +impl<T> InteriorMutable for RefCell<T> {}
> +impl<T> InteriorMutable for UnsafeCell<T> {}
> +impl<T> InteriorMutable for Opaque<T> {}
> +
> +/// A trait representing a per-CPU variable that is usable via a `&T`. The unsafety of `PerCpu<T>`
> +/// stems from the fact that the holder of a `PerCpuToken` can use it to get a `&mut T` to the
> +/// underlying per-CPU variable. This is problematic because the existence of aliaising `&mut T` is
> +/// undefined behavior in Rust. This type avoids that issue by only allowing access via a `&T`,
> +/// with the tradeoff that then `T` must be interior mutable or the underlying per-CPU variable
> +/// must be a constant for the lifetime of the corresponding `CheckedPerCpu<T>`.
> +///
> +/// Currently, only the case where `T` is interior mutable has first-class support, though a custom
> +/// implementation of `PerCpu<T>`/`CheckedPerCpu<T>` could be created for the const case.
> +pub trait CheckedPerCpu<T>: PerCpu<T> {
> +    /// Produces a token via which the holder can access the underlying per-CPU variable.
> +    fn get(&mut self, guard: CpuGuard) -> CheckedPerCpuToken<'_, T>;
> +}
> +
> +impl<'a, T> PerCpuToken<'a, T> {
> +    /// # Safety
> +    /// No other `PerCpuToken` or `CheckedPerCpuToken` may exist on the current CPU (which is a
> +    /// sensible notion, since we keep a `CpuGuard` around) that uses the same `PerCpuPtr<T>`.
> +    ///
> +    /// The current CPU's memory location associated with the per-CPU variable pointed at by `ptr`
> +    /// (i.e., the entry in the per-CPU area on this CPU) must be initialized.
> +    pub unsafe fn new(guard: CpuGuard, ptr: &'a PerCpuPtr<T>) -> PerCpuToken<'a, T> {
> +        Self { _guard: guard, ptr }
> +    }
> +
> +    /// Immediately invokes `func` with a `&mut T` that points at the underlying per-CPU variable
> +    /// that `&mut self` represents.
> +    pub fn with<U>(&mut self, func: U)
> +    where
> +        U: FnOnce(&mut T),
> +    {
> +        // SAFETY: The existence of a PerCpuToken means that the requirements for get_mut_ref are
> +        // satisfied. Likewise, the requirements for assume_init_mut are satisfied because the
> +        // invariants of this type ensure that on the current CPU (which is a sensible notion
> +        // because we have a CpuGuard), the memory location pointed to by `ptr` is initialized.
> +        func(unsafe { self.ptr.get_mut_ref().assume_init_mut() });
> +    }
> +}
> +
> +impl<'a, T> CheckedPerCpuToken<'a, T> {
> +    /// # Safety
> +    /// The current CPU's memory location associated with the per-CPU variable pointed at by `ptr`
> +    /// (i.e., the entry in the per-CPU area on this CPU) must be initialized.
> +    pub unsafe fn new(guard: CpuGuard, ptr: &'a PerCpuPtr<T>) -> CheckedPerCpuToken<'a, T> {
> +        Self { _guard: guard, ptr }
> +    }
> +
> +    /// Immediately invokes `func` with a `&T` that points at the underlying per-CPU variable that
> +    /// `&mut self` represents.
> +    pub fn with<U>(&mut self, func: U)
> +    where
> +        U: FnOnce(&T),
> +    {
> +        // SAFETY: The existence of a CheckedPerCpuToken means that the requirements for get_ref
> +        // are satisfied. Likewise, the requirements for assume_init_ref are satisfied because the
> +        // invariants of this type ensure that on the current CPU (which is a sensible notion
> +        // because we have a CpuGuard), the memory location pointed to by `ptr` is initialized.
> +        func(unsafe { self.ptr.get_ref().assume_init_ref() });
> +    }
> +}
> +
> +declare_extern_per_cpu!(this_cpu_off: *mut c_void);
> diff --git a/rust/kernel/percpu/cpu_guard.rs b/rust/kernel/percpu/cpu_guard.rs
> new file mode 100644
> index 000000000000..14c04b12e7f0
> --- /dev/null
> +++ b/rust/kernel/percpu/cpu_guard.rs
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//! Contains abstractions for disabling CPU preemption. See `CpuGuard`.
> +
> +/// A RAII guard for bindings::preempt_disable and bindings::preempt_enable. Guarantees preemption
> +/// is disabled for as long as this object exists.
> +pub struct CpuGuard {
> +    // Don't make one without using new()
> +    _phantom: (),
> +}
> +
> +impl CpuGuard {
> +    /// Create a new CpuGuard. Disables preemption for its lifetime.
> +    pub fn new() -> Self {
> +        // SAFETY: There are no preconditions required to call preempt_disable
> +        unsafe {
> +            bindings::preempt_disable();
> +        }
> +        CpuGuard { _phantom: () }
> +    }
> +}
> +
> +impl Default for CpuGuard {
> +    fn default() -> Self {
> +        Self::new()
> +    }
> +}
> +
> +impl Drop for CpuGuard {
> +    fn drop(&mut self) {
> +        // SAFETY: There are no preconditions required to call preempt_enable
> +        unsafe {
> +            bindings::preempt_enable();
> +        }
> +    }
> +}
> diff --git a/rust/kernel/percpu/dynamic.rs b/rust/kernel/percpu/dynamic.rs
> new file mode 100644
> index 000000000000..ce95e420f943
> --- /dev/null
> +++ b/rust/kernel/percpu/dynamic.rs
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//! Dynamically allocated per-CPU variables.
> +
> +use super::*;
> +
> +/// Represents a dynamic allocation of a per-CPU variable via alloc_percpu. Calls free_percpu when
> +/// dropped.
> +pub struct PerCpuAllocation<T>(PerCpuPtr<T>);
> +
> +impl<T: Zeroable> PerCpuAllocation<T> {
> +    /// Dynamically allocates a space in the per-CPU area suitably sized and aligned to hold a `T`,
> +    /// initially filled with the zero value for `T`.
> +    ///
> +    /// Returns `None` under the same circumstances the C function `alloc_percpu` returns `NULL`.
> +    pub fn new_zero() -> Option<PerCpuAllocation<T>> {
> +        let ptr: *mut MaybeUninit<T> =
> +            // SAFETY: No preconditions to call alloc_percpu; MaybeUninit<T> is
> +            // `#[repr(transparent)]`, so we can cast a `*mut T` to it.
> +            unsafe { alloc_percpu(size_of::<T>(), align_of::<T>()) }.cast();
> +        if ptr.is_null() {
> +            return None;
> +        }
> +
> +        // alloc_percpu returns zero'ed memory
> +        Some(Self(PerCpuPtr(ptr)))
> +    }
> +}
> +
> +impl<T> PerCpuAllocation<T> {
> +    /// Makes a per-CPU allocation sized and aligned to hold a `T`.
> +    ///
> +    /// Returns `None` under the same circumstances the C function `alloc_percpu` returns `NULL`.
> +    pub fn new_uninit() -> Option<PerCpuAllocation<T>> {
> +        let ptr: *mut MaybeUninit<T> =
> +            // SAFETY: No preconditions to call alloc_percpu; MaybeUninit<T> is
> +            // `#[repr(transparent)]`, so we can cast a `*mut T` to it.
> +            unsafe { alloc_percpu(size_of::<T>(), align_of::<T>()) }.cast();
> +        if ptr.is_null() {
> +            return None;
> +        }
> +
> +        Some(Self(PerCpuPtr(ptr)))
> +    }
> +}
> +
> +impl<T> Drop for PerCpuAllocation<T> {
> +    fn drop(&mut self) {
> +        // SAFETY: self.0.0 was returned by alloc_percpu, and so was a valid pointer into
> +        // the percpu area, and has remained valid by the invariants of PerCpuAllocation<T>.
> +        unsafe { free_percpu(self.0 .0.cast()) }
> +    }
> +}
> +
> +/// Holds a dynamically-allocated per-CPU variable.
> +#[derive(Clone)]
> +pub struct DynamicPerCpu<T> {
> +    // INVARIANT: The memory location in each CPU's per-CPU area pointed at by `alloc.0` has been
> +    // initialized.
> +    pub(super) alloc: Arc<PerCpuAllocation<T>>,
> +}
> +
> +impl<T: Zeroable> DynamicPerCpu<T> {
> +    /// Allocates a new per-CPU variable
> +    ///
> +    /// # Arguments
> +    /// * `flags` - Flags used to allocate an `Arc` that keeps track of the underlying
> +    ///   `PerCpuAllocation`.
> +    pub fn new_zero(flags: Flags) -> Option<Self> {
> +        let alloc: PerCpuAllocation<T> = PerCpuAllocation::new_zero()?;
> +
> +        let arc = Arc::new(alloc, flags).ok()?;
> +
> +        Some(Self { alloc: arc })
> +    }
> +}
> +
> +impl<T> PerCpu<T> for DynamicPerCpu<T> {
> +    unsafe fn get_mut(&mut self, guard: CpuGuard) -> PerCpuToken<'_, T> {
> +        // SAFETY: The requirements of `PerCpu::get_mut` and this type's invariant ensure that the
> +        // requirements of `PerCpuToken::new` are met.
> +        unsafe { PerCpuToken::new(guard, &self.alloc.0) }
> +    }
> +}
> diff --git a/rust/kernel/percpu/static_.rs b/rust/kernel/percpu/static_.rs
> new file mode 100644
> index 000000000000..be226dd2c3aa
> --- /dev/null
> +++ b/rust/kernel/percpu/static_.rs
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//! Statically allocated per-CPU variables.
> +
> +use super::*;
> +
> +/// A wrapper used for declaring static per-CPU variables. These symbols are "virtual" in that the
> +/// linker uses them to generate offsets into each CPU's per-CPU area, but shouldn't be read
> +/// from/written to directly. The fact that the statics are immutable prevents them being written
> +/// to (generally), this struct having _val be non-public prevents reading from them.
> +///
> +/// The end-user of the per-CPU API should make use of the define_per_cpu! macro instead of
> +/// declaring variables of this type directly. All instances of this type must be `static` and
> +/// `#[link_section = ".data..percpu"]` (which the macro handles).
> +#[repr(transparent)]
> +pub struct StaticPerCpuSymbol<T> {
> +    _val: T, // generate a correctly sized type
> +}
> +
> +/// Holds a statically-allocated per-CPU variable.
> +#[derive(Clone)]
> +pub struct StaticPerCpu<T>(pub(super) PerCpuPtr<T>);
> +
> +impl<T> StaticPerCpu<T> {
> +    /// Creates a `StaticPerCpu<T>` from a `StaticPerCpuSymbol<T>`. You should probably be using
> +    /// `get_static_per_cpu!` instead.
> +    pub fn new(ptr: *const StaticPerCpuSymbol<T>) -> StaticPerCpu<T> {
> +        // SAFETY: `StaticPerCpuSymbol<T>` is `#[repr(transparent)]`, so we can safely cast a
> +        // pointer to it into a pointer to `MaybeUninit<T>`. The validity of it as a per-CPU
> +        // pointer is guaranteed by the per-CPU subsystem and invariants of the StaticPerCpuSymbol
> +        // type.
> +        let pcpu_ptr = unsafe { PerCpuPtr::new(ptr.cast_mut().cast()) };
> +        Self(pcpu_ptr)
> +    }
> +}
> +
> +impl<T> PerCpu<T> for StaticPerCpu<T> {
> +    unsafe fn get_mut(&mut self, guard: CpuGuard) -> PerCpuToken<'_, T> {
> +        // SAFETY: The requirements of `PerCpu::get_mut` and the fact that statically-allocated
> +        // per-CPU variables are initialized by the per-CPU subsystem ensure that the requirements
> +        // of `PerCpuToken::new` are met.
> +        unsafe { PerCpuToken::new(guard, &self.0) }
> +    }
> +}
> +
> +impl<T: InteriorMutable> CheckedPerCpu<T> for StaticPerCpu<T> {
> +    fn get(&mut self, guard: CpuGuard) -> CheckedPerCpuToken<'_, T> {
> +        // SAFETY: The per-CPU subsystem guarantees that each CPU's instance of a
> +        // statically allocated variable begins with a copy of the contents of the
> +        // corresponding symbol in `.data..percpu`. Thus, the requirements of
> +        // `CheckedPerCpuToken::new` are met.
> +        unsafe { CheckedPerCpuToken::new(guard, &self.0) }
> +    }
> +}
> +
> +/// Gets a `StaticPerCpu<T>` from a symbol declared with `define_per_cpu!` or
> +/// `declare_extern_per_cpu!`.
> +///
> +/// # Arguments
> +/// * `ident` - The identifier declared
> +#[macro_export]
> +macro_rules! get_static_per_cpu {
> +    ($id:ident) => {
> +        $crate::percpu::StaticPerCpu::new((&raw const $id).cast())
> +    };
> +}
> +
> +/// Declares a StaticPerCpuSymbol corresponding to a per-CPU variable defined in C. Be sure to read
> +/// the safety requirements of `PerCpu::get`.
> +#[macro_export]
> +macro_rules! declare_extern_per_cpu {
> +    ($id:ident: $ty:ty) => {
> +        extern "C" {
> +            static $id: StaticPerCpuSymbol<$ty>;
> +        }
> +    };
> +}
> +
> +/// define_per_cpu! is analogous to the C DEFINE_PER_CPU macro in that it lets you create a
> +/// statically allocated per-CPU variable.
> +///
> +/// # Example
> +/// ```
> +/// use kernel::define_per_cpu;
> +/// use kernel::percpu::StaticPerCpuSymbol;
> +///
> +/// define_per_cpu!(pub MY_PERCPU: u64 = 0);
> +/// ```
> +#[macro_export]
> +macro_rules! define_per_cpu {
> +    ($vis:vis $id:ident: $ty:ty = $expr:expr) => {
> +        $crate::macros::paste! {
> +            // We might want to have a per-CPU variable that doesn't implement `Sync` (not paying
> +            // sync overhead costs is part of the point), but Rust won't let us declare a static of
> +            // a `!Sync` type. Of course, we don't actually have any synchronization issues, since
> +            // each CPU will see its own copy of the variable, so we cheat a little bit and tell
> +            // Rust it's fine.
> +            #[doc(hidden)]
> +            #[allow(non_camel_case_types)]
> +            #[repr(transparent)] // It needs to be the same size as $ty
> +            struct [<__PRIVATE_TYPE_ $id>]($ty);
> +
> +            impl [<__PRIVATE_TYPE_ $id>] {
> +                #[doc(hidden)]
> +                const fn new(val: $ty) -> Self {
> +                    Self(val)
> +                }
> +            }
> +
> +            // Expand $expr outside of the unsafe block to avoid silently allowing unsafe code to be
> +            // used without a user-facing unsafe block
> +            #[doc(hidden)]
> +            static [<__INIT_ $id>]: [<__PRIVATE_TYPE_ $id>] = [<__PRIVATE_TYPE_ $id>]::new($expr);
> +
> +            // SAFETY: This type will ONLY ever be used to declare a `StaticPerCpuSymbol`
> +            // (which we then only ever use as input to `&raw`). Reading from the symbol is
> +            // already UB, so we won't ever actually have any variables of this type where
> +            // synchronization is a concern.
> +            #[doc(hidden)]
> +            unsafe impl Sync for [<__PRIVATE_TYPE_ $id>] {}
> +
> +            // SAFETY: StaticPerCpuSymbol<T> is #[repr(transparent)], so we can freely convert from
> +            // [<__PRIVATE_TYPE_ $id>], which is also `#[repr(transparent)]` (i.e., everything is
> +            // just a `$ty` from a memory layout perspective).
> +            #[link_section = ".data..percpu"]
> +            $vis static $id: StaticPerCpuSymbol<[<__PRIVATE_TYPE_ $id>]> = unsafe {
> +                core::mem::transmute_copy::<
> +                    [<__PRIVATE_TYPE_ $id>], StaticPerCpuSymbol<[<__PRIVATE_TYPE_ $id>]>
> +                >(&[<__INIT_ $id>])
> +            };
> +        }
> +    };
> +}
> 
> -- 
> 2.34.1

