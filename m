Return-Path: <linux-kernel+bounces-799496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04926B42CB0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A7E1BC66F2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC932E62BF;
	Wed,  3 Sep 2025 22:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1sSEw5T"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E03E155333;
	Wed,  3 Sep 2025 22:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756937972; cv=none; b=EV2AsaSvH8tTteVGXTE0kULuvu6Df+Wxh2wbcmjGx1akhxPerszIR4bRduNab2cXoJGtlgKgsEJAUejasEeH/c6JKFw09gjZgV42j7ji3XrMsVzP0FSc+oQf0Fj/oIAzjTq7uoarMUd0wKtOV5c7HMQcIU02GI8bmP34LyVfSZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756937972; c=relaxed/simple;
	bh=VtdLUD3G7dEt++bkWSJhTL2/B651+Fy6CRiGHy+FLmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9VCiyn9bx7WJHqajVLhoAg2o3f5PP3DM//9Qd8sCSf0Pf02BUnyn4uA6bPqg8EQMa5QnllbFbiaka3SlU9pc0QcUDRLpdeKovprLSP42wjIFlQ9kQWq/ex2m/yXBhA4zcWRjnI+rLRV7aQwB+mydvyyf1Q6R0m2FwO88dX5rf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1sSEw5T; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b4cf40cd0d1so281191a12.0;
        Wed, 03 Sep 2025 15:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756937968; x=1757542768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FGh0aO9P7/8bAqXz1KGMkNxGhUGFVRPwAI7ofK2YqgQ=;
        b=O1sSEw5TPQg+TS6FBK1uDNeWjFY4B55jwhrM1Amqi4mdVdz4CS9r4PBoFSdPfZ8BXx
         ADBVAPLkxkzO+I5Nonmxhz2X1twz1gJ4DlgxEfWjYY7KK8Gq9Pg/mCxgK3rgMUr+QLho
         Pk6T9bo4wSOlm3QgBQ8ybizDHsfQv/5q+b1KDVJONluBrDGwATCopqC7s1L+l6++3AEt
         j5qIKbn9jXUzDQaEvo5c4o1t7+IktZp/H+JW/BdFkx4VndnFi3LharsYKLx8PhMMDTMy
         GrU4wVhhsPnHXycev7NqwayBqUPiymZuIJHjMTjiyxdYPkQRCFZUnTTwy2fcTVapV+RQ
         Hr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756937968; x=1757542768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGh0aO9P7/8bAqXz1KGMkNxGhUGFVRPwAI7ofK2YqgQ=;
        b=J/d0E90rfAJRwG6RvQOVcvlTbnG8vxDZrXuP+rPnziBz1QiyM/gSuDoIhKHu9L2qWx
         NfRwDosM5hKCCiF5lEvbC6qPlojbwK2KLCXOJ5VYFpZ0sr+xRjrMmUqic0f3K4auF/Ci
         DjKBf67yl8m7YmRHRwdzRMuk+UmCeWFW0Zr9W/Lx9rnjH6oy7Qcu8GPe2hAXiifeyC/R
         ET8de9hmtCZZONVYJLZsAxBWfs1g2AWQyPvReDkRsg5pxvKF1wHSsrIwwU1Hq7rS+D1y
         qlDUPVmi4NUXWy1w1kM+3N4QWlzq9epFj4EO1gJ3NXVX6N/G0m00SSOejGvm1/mrjidZ
         6ksw==
X-Forwarded-Encrypted: i=1; AJvYcCVF8GYpVAMKqZ97SFjMKcRmmXHS077gavofndEFb7m72NfJqP83taMWJ1Fk3WMaw0dMmpinh6vx+W8wfZM=@vger.kernel.org, AJvYcCWlaPYQEoL8Kl9vIYblDknMmtH7ro/nKu+cDmuS5w3RX+dBUSjH0Oa+93lBvNAvR7oFFN4iT8EhsJek1mYICxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTUVdlJP5muUbAJPdyotktuEnDiJhG2fVI360wilV7w7peNnvK
	7ZyFNMfZz3TgGnXzVq12465l/EbgINRr6UxXrq/qq/J6X5gaXHGanvSy
X-Gm-Gg: ASbGncsrhzPbokJWbBnHYNzrxaVIdWD4SlXydGzcH2xmWYgGHKWkvqB1PwZUY04Z1CN
	+rsU7x9DLt2F6rgv4eHEadazjyD2TLAqsK7bfARjqRGHEpqHxv4WW7qag1k54AxUFRJOmLxIEbQ
	2ILO2TUG6PJh2naTEnf9vAGDbgNtvTkYpDyBtT7BuDd9RudLfQgeDKVfUMRiHvkfHj/KWdG41en
	lNLP4GV7A1tzyDM1cxSDD/DgcBdNKaqNG6WLydxkZQZe8TwlfrUcjKOHiXmDN2knKbtY61r9SnQ
	Xwfwg2Ceu9eDsQMoN+qXKw3kBt8je8nTq0F9AvuMtqc3kjpdoONRN7xjUnRn2KI3FmKbqwM+ybb
	5tY0zILyUkoqn3s4h45Zaz+Z1YOyapL2a
X-Google-Smtp-Source: AGHT+IHaoA1D5Y10BtKzlkX/Du8lTHmOmK64FNdTYwKg9zp5WV48oAL1copKMRA7EORTsmNKAIAGBg==
X-Received: by 2002:a17:902:e551:b0:246:d3a1:c6c4 with SMTP id d9443c01a7336-249448d8a65mr221190555ad.16.1756937968264;
        Wed, 03 Sep 2025 15:19:28 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ca63c9e71sm21354135ad.95.2025.09.03.15.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 15:19:27 -0700 (PDT)
Date: Wed, 3 Sep 2025 18:19:25 -0400
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
Subject: Re: [PATCH v3 5/7] rust: percpu: Support non-zeroable types for
 DynamicPerCpu
Message-ID: <aLi-7W21N45fBGJk@yury>
References: <20250828-rust-percpu-v3-0-4dd92e1e7904@gmail.com>
 <20250828-rust-percpu-v3-5-4dd92e1e7904@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828-rust-percpu-v3-5-4dd92e1e7904@gmail.com>

On Thu, Aug 28, 2025 at 12:00:12PM -0700, Mitchell Levy wrote:
> Add functionality to `PerCpuPtr` to compute pointers to per-CPU variable
> slots on other CPUs. Use this facility to initialize per-CPU variables
> on all possible CPUs when a dynamic per-CPU variable is created with a
> non-zeroable type. Since `RefCell` and other `Cell`-like types fall into
> this category, `impl CheckedPerCpu` on `DynamicPerCpu` for these
> `InteriorMutable` types since they can now be used. Add examples of
> these usages to `samples/rust/rust_percpu.rs`.
> 
> Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
> ---
>  rust/helpers/percpu.c         |  5 +++
>  rust/kernel/percpu.rs         | 15 +++++++
>  rust/kernel/percpu/dynamic.rs | 40 +++++++++++++++++
>  samples/rust/rust_percpu.rs   | 99 ++++++++++++++++++++++++++++++++++++++++---
>  4 files changed, 152 insertions(+), 7 deletions(-)
> 
> diff --git a/rust/helpers/percpu.c b/rust/helpers/percpu.c
> index 8cc01d094752..8d83b6b86106 100644
> --- a/rust/helpers/percpu.c
> +++ b/rust/helpers/percpu.c
> @@ -8,6 +8,11 @@ void __percpu *rust_helper_alloc_percpu(size_t sz, size_t align)
>  	return __alloc_percpu(sz, align);
>  }
>  
> +void *rust_helper_per_cpu_ptr(void __percpu *ptr, unsigned int cpu)
> +{
> +	return per_cpu_ptr(ptr, cpu);
> +}
> +
>  void rust_helper_on_each_cpu(smp_call_func_t func, void *info, int wait)
>  {
>  	on_each_cpu(func, info, wait);
> diff --git a/rust/kernel/percpu.rs b/rust/kernel/percpu.rs
> index 35afcdba3ccd..c68c7520b67f 100644
> --- a/rust/kernel/percpu.rs
> +++ b/rust/kernel/percpu.rs
> @@ -14,6 +14,7 @@
>  use bindings::{alloc_percpu, free_percpu};
>  
>  use crate::alloc::Flags;
> +use crate::cpu::CpuId;
>  use crate::percpu::cpu_guard::CpuGuard;
>  use crate::prelude::*;
>  use crate::sync::Arc;
> @@ -115,6 +116,20 @@ pub fn get_ptr(&self) -> *mut MaybeUninit<T> {
>          // the invariant that self.0 is a valid offset into the per-CPU area.
>          (this_cpu_area).wrapping_add(self.0 as usize).cast()
>      }
> +
> +    /// Get a `*mut MaybeUninit<T>` to the per-CPU variable on the CPU represented by `cpu`. Note
> +    /// that without some kind of synchronization, use of the returned pointer may cause a data
> +    /// race. It is the caller's responsibility to use the returned pointer in a reasonable way.
> +    ///
> +    /// # Safety
> +    /// - The returned pointer is valid only if `self` is (that is, it points to a live allocation
> +    ///   correctly sized and aligned to hold a `T`)
> +    /// - The returned pointer is valid only if the bit corresponding to `cpu` is set in
> +    ///   `Cpumask::possible()`.

Instead of explaining those rules in comments, can you just enforce
them in code? Not sure about the 1st rule, but the 2nd one looks like
a trivial check.

> +    pub unsafe fn get_remote_ptr(&self, cpu: CpuId) -> *mut MaybeUninit<T> {
> +        // SAFETY: The requirements of this function ensure this call is safe.
> +        unsafe { bindings::per_cpu_ptr(self.0.cast(), cpu.as_u32()) }.cast()
> +    }
>  }
>  
>  // SAFETY: Sending a `PerCpuPtr<T>` to another thread is safe because as soon as it's sent, the
> diff --git a/rust/kernel/percpu/dynamic.rs b/rust/kernel/percpu/dynamic.rs
> index ce95e420f943..64f04cef3705 100644
> --- a/rust/kernel/percpu/dynamic.rs
> +++ b/rust/kernel/percpu/dynamic.rs
> @@ -3,6 +3,8 @@
>  
>  use super::*;
>  
> +use crate::cpumask::Cpumask;
> +
>  /// Represents a dynamic allocation of a per-CPU variable via alloc_percpu. Calls free_percpu when
>  /// dropped.
>  pub struct PerCpuAllocation<T>(PerCpuPtr<T>);
> @@ -74,6 +76,36 @@ pub fn new_zero(flags: Flags) -> Option<Self> {
>      }
>  }
>  
> +impl<T: Clone> DynamicPerCpu<T> {
> +    /// Allocates a new per-CPU variable
> +    ///
> +    /// # Arguments
> +    /// * `val` - The initial value of the per-CPU variable on all CPUs.
> +    /// * `flags` - Flags used to allocate an `Arc` that keeps track of the underlying
> +    ///   `PerCpuAllocation`.
> +    pub fn new_with(val: T, flags: Flags) -> Option<Self> {
> +        let alloc: PerCpuAllocation<T> = PerCpuAllocation::new_uninit()?;
> +        let ptr = alloc.0;
> +
> +        for cpu in Cpumask::possible().iter() {

In C we've got the 'for_each_possible_cpu()'. Is there any way to
preserve that semantics in rust? I really believe that similar
semantics on higher level on both sides will help _a_lot_ for those
transitioning into the rust world (like me).

Thanks,
Yury
 
> +            // SAFETY: `ptr` is a valid allocation, and `cpu` appears in `Cpumask::possible()`
> +            let remote_ptr = unsafe { ptr.get_remote_ptr(cpu) };
> +            // SAFETY: Each CPU's slot corresponding to `ptr` is currently uninitialized, and no
> +            // one else has a reference to it. Therefore, we can freely write to it without
> +            // worrying about the need to drop what was there or whether we're racing with someone
> +            // else. `PerCpuPtr::get_remote_ptr` guarantees that the pointer is valid since we
> +            // derived it from a valid allocation and `cpu`.
> +            unsafe {
> +                (*remote_ptr).write(val.clone());
> +            }
> +        }
> +
> +        let arc = Arc::new(alloc, flags).ok()?;
> +
> +        Some(Self { alloc: arc })
> +    }
> +}
> +
>  impl<T> PerCpu<T> for DynamicPerCpu<T> {
>      unsafe fn get_mut(&mut self, guard: CpuGuard) -> PerCpuToken<'_, T> {
>          // SAFETY: The requirements of `PerCpu::get_mut` and this type's invariant ensure that the
> @@ -81,3 +113,11 @@ unsafe fn get_mut(&mut self, guard: CpuGuard) -> PerCpuToken<'_, T> {
>          unsafe { PerCpuToken::new(guard, &self.alloc.0) }
>      }
>  }
> +
> +impl<T: InteriorMutable> CheckedPerCpu<T> for DynamicPerCpu<T> {
> +    fn get(&mut self, guard: CpuGuard) -> CheckedPerCpuToken<'_, T> {
> +        // SAFETY: By the invariant of `DynamicPerCpu`, the memory location in each CPU's
> +        // per-CPU area corresponding to this variable has been initialized.
> +        unsafe { CheckedPerCpuToken::new(guard, &self.alloc.0) }
> +    }
> +}
> diff --git a/samples/rust/rust_percpu.rs b/samples/rust/rust_percpu.rs
> index 98ca1c781b6b..06b322019134 100644
> --- a/samples/rust/rust_percpu.rs
> +++ b/samples/rust/rust_percpu.rs
> @@ -130,13 +130,72 @@ fn init(_module: &'static ThisModule) -> Result<Self, Error> {
>  
>          // SAFETY: No prerequisites for on_each_cpu.
>          unsafe {
> -            on_each_cpu(Some(inc_percpu), (&raw mut test).cast(), 0);
> -            on_each_cpu(Some(inc_percpu), (&raw mut test).cast(), 0);
> -            on_each_cpu(Some(inc_percpu), (&raw mut test).cast(), 0);
> -            on_each_cpu(Some(inc_percpu), (&raw mut test).cast(), 1);
> -            on_each_cpu(Some(check_percpu), (&raw mut test).cast(), 1);
> +            on_each_cpu(Some(inc_percpu_u64), (&raw mut test).cast(), 0);
> +            on_each_cpu(Some(inc_percpu_u64), (&raw mut test).cast(), 0);
> +            on_each_cpu(Some(inc_percpu_u64), (&raw mut test).cast(), 0);
> +            on_each_cpu(Some(inc_percpu_u64), (&raw mut test).cast(), 1);
> +            on_each_cpu(Some(check_percpu_u64), (&raw mut test).cast(), 1);
>          }
>  
> +        let mut checked: DynamicPerCpu<RefCell<u64>> =
> +            DynamicPerCpu::new_with(RefCell::new(100), GFP_KERNEL).unwrap();
> +
> +        // SAFETY: No prerequisites for on_each_cpu.
> +        unsafe {
> +            on_each_cpu(Some(inc_percpu_refcell_u64), (&raw mut checked).cast(), 0);
> +            on_each_cpu(Some(inc_percpu_refcell_u64), (&raw mut checked).cast(), 0);
> +            on_each_cpu(Some(inc_percpu_refcell_u64), (&raw mut checked).cast(), 0);
> +            on_each_cpu(Some(inc_percpu_refcell_u64), (&raw mut checked).cast(), 1);
> +            on_each_cpu(Some(check_percpu_refcell_u64), (&raw mut checked).cast(), 1);
> +        }
> +
> +        checked.get(CpuGuard::new()).with(|val: &RefCell<u64>| {
> +            assert!(*val.borrow() == 104);
> +
> +            let mut checked_native = 0;
> +            *val.borrow_mut() = 0;
> +
> +            checked_native += 1;
> +            *val.borrow_mut() += 1;
> +            pr_info!(
> +                "Checked native: {}, *checked: {}\n",
> +                checked_native,
> +                val.borrow()
> +            );
> +            assert!(checked_native == *val.borrow() && checked_native == 1);
> +
> +            checked_native = checked_native.wrapping_add((-1i64) as u64);
> +            val.replace_with(|old: &mut u64| old.wrapping_add((-1i64) as u64));
> +            pr_info!(
> +                "Checked native: {}, *checked: {}\n",
> +                checked_native,
> +                val.borrow()
> +            );
> +            assert!(checked_native == *val.borrow() && checked_native == 0);
> +
> +            checked_native = checked_native.wrapping_add((-1i64) as u64);
> +            val.replace_with(|old: &mut u64| old.wrapping_add((-1i64) as u64));
> +            pr_info!(
> +                "Checked native: {}, *checked: {}\n",
> +                checked_native,
> +                val.borrow()
> +            );
> +            assert!(checked_native == *val.borrow() && checked_native == (-1i64) as u64);
> +
> +            checked_native = 0;
> +            *val.borrow_mut() = 0;
> +
> +            checked_native = checked_native.wrapping_sub(1);
> +            val.replace_with(|old: &mut u64| old.wrapping_sub(1));
> +            pr_info!(
> +                "Checked native: {}, *checked: {}\n",
> +                checked_native,
> +                val.borrow()
> +            );
> +            assert!(checked_native == *val.borrow() && checked_native == (-1i64) as u64);
> +            assert!(checked_native == *val.borrow() && checked_native == u64::MAX);
> +        });
> +
>          pr_info!("rust dynamic percpu test done\n");
>  
>          // Return Err to unload the module
> @@ -144,7 +203,7 @@ fn init(_module: &'static ThisModule) -> Result<Self, Error> {
>      }
>  }
>  
> -extern "C" fn inc_percpu(info: *mut c_void) {
> +extern "C" fn inc_percpu_u64(info: *mut c_void) {
>      // SAFETY: We know that info is a void *const DynamicPerCpu<u64> and DynamicPerCpu<u64> is Send.
>      let mut pcpu = unsafe { (*(info as *const DynamicPerCpu<u64>)).clone() };
>      pr_info!("Incrementing on {}\n", CpuId::current().as_u32());
> @@ -153,7 +212,7 @@ extern "C" fn inc_percpu(info: *mut c_void) {
>      unsafe { pcpu.get_mut(CpuGuard::new()) }.with(|val: &mut u64| *val += 1);
>  }
>  
> -extern "C" fn check_percpu(info: *mut c_void) {
> +extern "C" fn check_percpu_u64(info: *mut c_void) {
>      // SAFETY: We know that info is a void *const DynamicPerCpu<u64> and DynamicPerCpu<u64> is Send.
>      let mut pcpu = unsafe { (*(info as *const DynamicPerCpu<u64>)).clone() };
>      pr_info!("Asserting on {}\n", CpuId::current().as_u32());
> @@ -161,3 +220,29 @@ extern "C" fn check_percpu(info: *mut c_void) {
>      // SAFETY: We don't have multiple clones of pcpu in scope
>      unsafe { pcpu.get_mut(CpuGuard::new()) }.with(|val: &mut u64| assert!(*val == 4));
>  }
> +
> +extern "C" fn inc_percpu_refcell_u64(info: *mut c_void) {
> +    // SAFETY: We know that info is a void *const DynamicPerCpu<RefCell<u64>> and
> +    // DynamicPerCpu<RefCell<u64>> is Send.
> +    let mut pcpu = unsafe { (*(info as *const DynamicPerCpu<RefCell<u64>>)).clone() };
> +    // SAFETY: smp_processor_id has no preconditions
> +    pr_info!("Incrementing on {}\n", CpuId::current().as_u32());
> +
> +    pcpu.get(CpuGuard::new()).with(|val: &RefCell<u64>| {
> +        let mut val = val.borrow_mut();
> +        *val += 1;
> +    });
> +}
> +
> +extern "C" fn check_percpu_refcell_u64(info: *mut c_void) {
> +    // SAFETY: We know that info is a void *const DynamicPerCpu<RefCell<u64>> and
> +    // DynamicPerCpu<RefCell<u64>> is Send.
> +    let mut pcpu = unsafe { (*(info as *const DynamicPerCpu<RefCell<u64>>)).clone() };
> +    // SAFETY: smp_processor_id has no preconditions
> +    pr_info!("Asserting on {}\n", CpuId::current().as_u32());
> +
> +    pcpu.get(CpuGuard::new()).with(|val: &RefCell<u64>| {
> +        let val = val.borrow();
> +        assert!(*val == 104);
> +    });
> +}
> 
> -- 
> 2.34.1

