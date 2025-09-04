Return-Path: <linux-kernel+bounces-801587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0F3B44747
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12E45AA2718
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6772B27FD4B;
	Thu,  4 Sep 2025 20:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUeB3I3o"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6F0253F05;
	Thu,  4 Sep 2025 20:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757017573; cv=none; b=gnpCblslYg8FuWSloCNq7di6SJ4Stb/w6BPkUglofE2KEfe8A/QSNP+PKmbQR9c+WZehTJFi84af8OouFh6UNB5d4vYdz7hCGvSj16jYUa4kbuTzNEx13uYJ2GrnNQctyymSSUBQoCg4IJMnu51PpJyU6kt0Kt2qShe/B6yoLjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757017573; c=relaxed/simple;
	bh=Zs9NIpr0zc/+/XHmP3YPSxJ6v4fK+AA3eBaYPZoE9ss=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPwSCnT9R+S+nv2EN6MBcVb7gOTZECv2RIN/MQZYH2MBhOkjDJLYJN/kowe86oKlfKqFbG7oopjZGdhmQiom/zHPK8q7jbF6lI+8snww8jIQSuLPDatI/fGzffNsMI209b+yi8WwXJTLnRYSngwKx+hEEOFdpwbftRdbN43JOUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUeB3I3o; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77251d7cca6so1243002b3a.3;
        Thu, 04 Sep 2025 13:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757017571; x=1757622371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=M3DawnKdh1VJq+m8353LvBxh7HWUqrctE+0WTNHYxA4=;
        b=TUeB3I3ogDRFv1eh7Du7SmMGkY1dgrEYm7f182GJnjVz2EncVozuJJ1VXm/LCW84jW
         yHVAT+Xg0QjUcvxS6PSnFmYXo4Qq8CiET/rRcLLUVq6IVABi3IVOBhkxQB1sD/v2CJ2O
         rL3svKCeNH/yT+Ui5IQ8d1PipyAmZhitKECzmr/VFHd2iDDUImOGe7Fa3zO5pL8bNmNl
         ycb65zewgoH7DnhKbLUmNhPwAbMaegABaJWEy94HAHrdqSHvn5ISxRPxoNMvW6sO5wcV
         qqOB4Rhsw00nJ5Uicfgxu2zwcK9Sp6Dtmx3kzRd5L1ooxHsev9T9d1ADDezyhtDsIlkJ
         N3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757017571; x=1757622371;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3DawnKdh1VJq+m8353LvBxh7HWUqrctE+0WTNHYxA4=;
        b=vzWPPLG+veDs34Ff40TV8pIV1PKXEwcrWfTCDdUbqnYUjS5Aqr5dtZs2Szc7hcXvPw
         kfG68O6+eV8KJE4e90KVlh21c355pDskZ1LlY17ZBwsu9ZxZ7fC/REQTK6iuYa9GRO8A
         cDrssynoXz4r29WnrUEkkGAXfJohTDwA8SpDtYSYFm/rOXhaTw/WKykRp5QxlEEUAHU8
         UyNzNVDaRnnWo/U3VfbwChR4xhDKEpWgkKC6UP/Yd9hRe5PhmIOljxiZY8vDlsvnYRYK
         eSmfBbySRBx6gDZ9ubvoMKDtIXmVzGZY49R+AiKoRn7kGS3uwgG/ybIzBj1Mx4SEzCpx
         RZpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOBEeuRyNeIBNLypVZtZtBGIwVJCNehgnqn8kGpCaS/prgEW8OoAtQTLYaGcRmO6LXJ6PeiGpNq5mkWRYjmvA=@vger.kernel.org, AJvYcCV9P4IENyv7jkHfMiV4ANnHl3+TZSd+iFNdW7gy8l7O6Xcu+L17mDsM/8tbixXj4EM3R60Gx5vWkP7gz4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTKrMkwksldum3e8lc3tkGZYr+ck1alQijSJjWU8i8S4uSc3wA
	SMc0B0mjouz5jtjfoxvGCTh+C/H67Y1iApxBhPYTEVRtXcyes2pmo4iJ
X-Gm-Gg: ASbGncsSBWyb6d81CiSTELPR/XKxkIBFW3bsBIIaKymKGAdI7dh0Sh80Py1TgzvLeJD
	YhHxLOslMlz0gMu+Mvu6lgzOI7Ss/V5CPiHyZ0rpD23p638o71eXe2qFA7e0/NahYuYFGqTbqyE
	DWuYlw0+13FSrhdxXb8nYm7qLQQB4OqFhUTs/J4Zm+bwFOAvjzyKJaBQlDnugAv9INGPVQbkA2j
	RW8xjRVNnHIyueR+IN3KokI3GAjcZYeGetAqyB64zs98I7HuVHqP5mbmuY+SAjGVRX0ljOAGclR
	NMYvJNUfscFUBxDt4W1CPzL4h7QidBFbBt2ccsjn89lJkAOrYW8B4i9Bkcy95EASEx+q+ZwcVDb
	WukSWkkj74suKEg5bE74SWSnvaHZFkKdLRLZCGg==
X-Google-Smtp-Source: AGHT+IE4ZYCCGuchESUfP/TSkRBdMrDu9ZhZyv2wkzlRJ9OVelRFoCLCt0dmnWPHWazi7+BB2MjuPg==
X-Received: by 2002:a05:6a20:7fa8:b0:243:a251:cf46 with SMTP id adf61e73a8af0-243d6f0bc16mr30937981637.32.1757017570537;
        Thu, 04 Sep 2025 13:26:10 -0700 (PDT)
Received: from Cyndaquil. ([174.127.224.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32b9120cef8sm1354636a91.0.2025.09.04.13.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 13:26:10 -0700 (PDT)
Message-ID: <68b9f5e2.170a0220.1224d9.5d3d@mx.google.com>
X-Google-Original-Message-ID: <aLn138+i5jtEioqU@Cyndaquil.>
Date: Thu, 4 Sep 2025 13:26:07 -0700
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
Subject: Re: [PATCH v3 5/7] rust: percpu: Support non-zeroable types for
 DynamicPerCpu
References: <20250828-rust-percpu-v3-0-4dd92e1e7904@gmail.com>
 <20250828-rust-percpu-v3-5-4dd92e1e7904@gmail.com>
 <aLi-7W21N45fBGJk@yury>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLi-7W21N45fBGJk@yury>

On Wed, Sep 03, 2025 at 06:19:25PM -0400, Yury Norov wrote:
> On Thu, Aug 28, 2025 at 12:00:12PM -0700, Mitchell Levy wrote:
> > Add functionality to `PerCpuPtr` to compute pointers to per-CPU variable
> > slots on other CPUs. Use this facility to initialize per-CPU variables
> > on all possible CPUs when a dynamic per-CPU variable is created with a
> > non-zeroable type. Since `RefCell` and other `Cell`-like types fall into
> > this category, `impl CheckedPerCpu` on `DynamicPerCpu` for these
> > `InteriorMutable` types since they can now be used. Add examples of
> > these usages to `samples/rust/rust_percpu.rs`.
> > 
> > Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
> > ---
> >  rust/helpers/percpu.c         |  5 +++
> >  rust/kernel/percpu.rs         | 15 +++++++
> >  rust/kernel/percpu/dynamic.rs | 40 +++++++++++++++++
> >  samples/rust/rust_percpu.rs   | 99 ++++++++++++++++++++++++++++++++++++++++---
> >  4 files changed, 152 insertions(+), 7 deletions(-)
> > 
> > diff --git a/rust/helpers/percpu.c b/rust/helpers/percpu.c
> > index 8cc01d094752..8d83b6b86106 100644
> > --- a/rust/helpers/percpu.c
> > +++ b/rust/helpers/percpu.c
> > @@ -8,6 +8,11 @@ void __percpu *rust_helper_alloc_percpu(size_t sz, size_t align)
> >  	return __alloc_percpu(sz, align);
> >  }
> >  
> > +void *rust_helper_per_cpu_ptr(void __percpu *ptr, unsigned int cpu)
> > +{
> > +	return per_cpu_ptr(ptr, cpu);
> > +}
> > +
> >  void rust_helper_on_each_cpu(smp_call_func_t func, void *info, int wait)
> >  {
> >  	on_each_cpu(func, info, wait);
> > diff --git a/rust/kernel/percpu.rs b/rust/kernel/percpu.rs
> > index 35afcdba3ccd..c68c7520b67f 100644
> > --- a/rust/kernel/percpu.rs
> > +++ b/rust/kernel/percpu.rs
> > @@ -14,6 +14,7 @@
> >  use bindings::{alloc_percpu, free_percpu};
> >  
> >  use crate::alloc::Flags;
> > +use crate::cpu::CpuId;
> >  use crate::percpu::cpu_guard::CpuGuard;
> >  use crate::prelude::*;
> >  use crate::sync::Arc;
> > @@ -115,6 +116,20 @@ pub fn get_ptr(&self) -> *mut MaybeUninit<T> {
> >          // the invariant that self.0 is a valid offset into the per-CPU area.
> >          (this_cpu_area).wrapping_add(self.0 as usize).cast()
> >      }
> > +
> > +    /// Get a `*mut MaybeUninit<T>` to the per-CPU variable on the CPU represented by `cpu`. Note
> > +    /// that without some kind of synchronization, use of the returned pointer may cause a data
> > +    /// race. It is the caller's responsibility to use the returned pointer in a reasonable way.
> > +    ///
> > +    /// # Safety
> > +    /// - The returned pointer is valid only if `self` is (that is, it points to a live allocation
> > +    ///   correctly sized and aligned to hold a `T`)
> > +    /// - The returned pointer is valid only if the bit corresponding to `cpu` is set in
> > +    ///   `Cpumask::possible()`.
> 
> Instead of explaining those rules in comments, can you just enforce
> them in code? Not sure about the 1st rule, but the 2nd one looks like
> a trivial check.

I don't think the first one is possible to check (at least, certainly
not without peeking deeply into the per-CPU allocation management
system).

For the second, I will probably be converting this function to a safe
function (see my reply to Miguel), with these being requirements for the
returned pointer to be valid, so panicking when the requirements aren't
met would probably not be expected behavior.

> > +    pub unsafe fn get_remote_ptr(&self, cpu: CpuId) -> *mut MaybeUninit<T> {
> > +        // SAFETY: The requirements of this function ensure this call is safe.
> > +        unsafe { bindings::per_cpu_ptr(self.0.cast(), cpu.as_u32()) }.cast()
> > +    }
> >  }
> >  
> >  // SAFETY: Sending a `PerCpuPtr<T>` to another thread is safe because as soon as it's sent, the
> > diff --git a/rust/kernel/percpu/dynamic.rs b/rust/kernel/percpu/dynamic.rs
> > index ce95e420f943..64f04cef3705 100644
> > --- a/rust/kernel/percpu/dynamic.rs
> > +++ b/rust/kernel/percpu/dynamic.rs
> > @@ -3,6 +3,8 @@
> >  
> >  use super::*;
> >  
> > +use crate::cpumask::Cpumask;
> > +
> >  /// Represents a dynamic allocation of a per-CPU variable via alloc_percpu. Calls free_percpu when
> >  /// dropped.
> >  pub struct PerCpuAllocation<T>(PerCpuPtr<T>);
> > @@ -74,6 +76,36 @@ pub fn new_zero(flags: Flags) -> Option<Self> {
> >      }
> >  }
> >  
> > +impl<T: Clone> DynamicPerCpu<T> {
> > +    /// Allocates a new per-CPU variable
> > +    ///
> > +    /// # Arguments
> > +    /// * `val` - The initial value of the per-CPU variable on all CPUs.
> > +    /// * `flags` - Flags used to allocate an `Arc` that keeps track of the underlying
> > +    ///   `PerCpuAllocation`.
> > +    pub fn new_with(val: T, flags: Flags) -> Option<Self> {
> > +        let alloc: PerCpuAllocation<T> = PerCpuAllocation::new_uninit()?;
> > +        let ptr = alloc.0;
> > +
> > +        for cpu in Cpumask::possible().iter() {
> 
> In C we've got the 'for_each_possible_cpu()'. Is there any way to
> preserve that semantics in rust? I really believe that similar
> semantics on higher level on both sides will help _a_lot_ for those
> transitioning into the rust world (like me).

I'm not sure I understand what you mean --- I believe the semantics
should be the same here (`cpu` takes on each value in
`cpu_possible_mask`). Could you please clarify?

Thanks,
Mitchell

> Thanks,
> Yury
>  
> > +            // SAFETY: `ptr` is a valid allocation, and `cpu` appears in `Cpumask::possible()`
> > +            let remote_ptr = unsafe { ptr.get_remote_ptr(cpu) };
> > +            // SAFETY: Each CPU's slot corresponding to `ptr` is currently uninitialized, and no
> > +            // one else has a reference to it. Therefore, we can freely write to it without
> > +            // worrying about the need to drop what was there or whether we're racing with someone
> > +            // else. `PerCpuPtr::get_remote_ptr` guarantees that the pointer is valid since we
> > +            // derived it from a valid allocation and `cpu`.
> > +            unsafe {
> > +                (*remote_ptr).write(val.clone());
> > +            }
> > +        }
> > +
> > +        let arc = Arc::new(alloc, flags).ok()?;
> > +
> > +        Some(Self { alloc: arc })
> > +    }
> > +}
> > +
> >  impl<T> PerCpu<T> for DynamicPerCpu<T> {
> >      unsafe fn get_mut(&mut self, guard: CpuGuard) -> PerCpuToken<'_, T> {
> >          // SAFETY: The requirements of `PerCpu::get_mut` and this type's invariant ensure that the
> > @@ -81,3 +113,11 @@ unsafe fn get_mut(&mut self, guard: CpuGuard) -> PerCpuToken<'_, T> {
> >          unsafe { PerCpuToken::new(guard, &self.alloc.0) }
> >      }
> >  }
> > +
> > +impl<T: InteriorMutable> CheckedPerCpu<T> for DynamicPerCpu<T> {
> > +    fn get(&mut self, guard: CpuGuard) -> CheckedPerCpuToken<'_, T> {
> > +        // SAFETY: By the invariant of `DynamicPerCpu`, the memory location in each CPU's
> > +        // per-CPU area corresponding to this variable has been initialized.
> > +        unsafe { CheckedPerCpuToken::new(guard, &self.alloc.0) }
> > +    }
> > +}
> > diff --git a/samples/rust/rust_percpu.rs b/samples/rust/rust_percpu.rs
> > index 98ca1c781b6b..06b322019134 100644
> > --- a/samples/rust/rust_percpu.rs
> > +++ b/samples/rust/rust_percpu.rs
> > @@ -130,13 +130,72 @@ fn init(_module: &'static ThisModule) -> Result<Self, Error> {
> >  
> >          // SAFETY: No prerequisites for on_each_cpu.
> >          unsafe {
> > -            on_each_cpu(Some(inc_percpu), (&raw mut test).cast(), 0);
> > -            on_each_cpu(Some(inc_percpu), (&raw mut test).cast(), 0);
> > -            on_each_cpu(Some(inc_percpu), (&raw mut test).cast(), 0);
> > -            on_each_cpu(Some(inc_percpu), (&raw mut test).cast(), 1);
> > -            on_each_cpu(Some(check_percpu), (&raw mut test).cast(), 1);
> > +            on_each_cpu(Some(inc_percpu_u64), (&raw mut test).cast(), 0);
> > +            on_each_cpu(Some(inc_percpu_u64), (&raw mut test).cast(), 0);
> > +            on_each_cpu(Some(inc_percpu_u64), (&raw mut test).cast(), 0);
> > +            on_each_cpu(Some(inc_percpu_u64), (&raw mut test).cast(), 1);
> > +            on_each_cpu(Some(check_percpu_u64), (&raw mut test).cast(), 1);
> >          }
> >  
> > +        let mut checked: DynamicPerCpu<RefCell<u64>> =
> > +            DynamicPerCpu::new_with(RefCell::new(100), GFP_KERNEL).unwrap();
> > +
> > +        // SAFETY: No prerequisites for on_each_cpu.
> > +        unsafe {
> > +            on_each_cpu(Some(inc_percpu_refcell_u64), (&raw mut checked).cast(), 0);
> > +            on_each_cpu(Some(inc_percpu_refcell_u64), (&raw mut checked).cast(), 0);
> > +            on_each_cpu(Some(inc_percpu_refcell_u64), (&raw mut checked).cast(), 0);
> > +            on_each_cpu(Some(inc_percpu_refcell_u64), (&raw mut checked).cast(), 1);
> > +            on_each_cpu(Some(check_percpu_refcell_u64), (&raw mut checked).cast(), 1);
> > +        }
> > +
> > +        checked.get(CpuGuard::new()).with(|val: &RefCell<u64>| {
> > +            assert!(*val.borrow() == 104);
> > +
> > +            let mut checked_native = 0;
> > +            *val.borrow_mut() = 0;
> > +
> > +            checked_native += 1;
> > +            *val.borrow_mut() += 1;
> > +            pr_info!(
> > +                "Checked native: {}, *checked: {}\n",
> > +                checked_native,
> > +                val.borrow()
> > +            );
> > +            assert!(checked_native == *val.borrow() && checked_native == 1);
> > +
> > +            checked_native = checked_native.wrapping_add((-1i64) as u64);
> > +            val.replace_with(|old: &mut u64| old.wrapping_add((-1i64) as u64));
> > +            pr_info!(
> > +                "Checked native: {}, *checked: {}\n",
> > +                checked_native,
> > +                val.borrow()
> > +            );
> > +            assert!(checked_native == *val.borrow() && checked_native == 0);
> > +
> > +            checked_native = checked_native.wrapping_add((-1i64) as u64);
> > +            val.replace_with(|old: &mut u64| old.wrapping_add((-1i64) as u64));
> > +            pr_info!(
> > +                "Checked native: {}, *checked: {}\n",
> > +                checked_native,
> > +                val.borrow()
> > +            );
> > +            assert!(checked_native == *val.borrow() && checked_native == (-1i64) as u64);
> > +
> > +            checked_native = 0;
> > +            *val.borrow_mut() = 0;
> > +
> > +            checked_native = checked_native.wrapping_sub(1);
> > +            val.replace_with(|old: &mut u64| old.wrapping_sub(1));
> > +            pr_info!(
> > +                "Checked native: {}, *checked: {}\n",
> > +                checked_native,
> > +                val.borrow()
> > +            );
> > +            assert!(checked_native == *val.borrow() && checked_native == (-1i64) as u64);
> > +            assert!(checked_native == *val.borrow() && checked_native == u64::MAX);
> > +        });
> > +
> >          pr_info!("rust dynamic percpu test done\n");
> >  
> >          // Return Err to unload the module
> > @@ -144,7 +203,7 @@ fn init(_module: &'static ThisModule) -> Result<Self, Error> {
> >      }
> >  }
> >  
> > -extern "C" fn inc_percpu(info: *mut c_void) {
> > +extern "C" fn inc_percpu_u64(info: *mut c_void) {
> >      // SAFETY: We know that info is a void *const DynamicPerCpu<u64> and DynamicPerCpu<u64> is Send.
> >      let mut pcpu = unsafe { (*(info as *const DynamicPerCpu<u64>)).clone() };
> >      pr_info!("Incrementing on {}\n", CpuId::current().as_u32());
> > @@ -153,7 +212,7 @@ extern "C" fn inc_percpu(info: *mut c_void) {
> >      unsafe { pcpu.get_mut(CpuGuard::new()) }.with(|val: &mut u64| *val += 1);
> >  }
> >  
> > -extern "C" fn check_percpu(info: *mut c_void) {
> > +extern "C" fn check_percpu_u64(info: *mut c_void) {
> >      // SAFETY: We know that info is a void *const DynamicPerCpu<u64> and DynamicPerCpu<u64> is Send.
> >      let mut pcpu = unsafe { (*(info as *const DynamicPerCpu<u64>)).clone() };
> >      pr_info!("Asserting on {}\n", CpuId::current().as_u32());
> > @@ -161,3 +220,29 @@ extern "C" fn check_percpu(info: *mut c_void) {
> >      // SAFETY: We don't have multiple clones of pcpu in scope
> >      unsafe { pcpu.get_mut(CpuGuard::new()) }.with(|val: &mut u64| assert!(*val == 4));
> >  }
> > +
> > +extern "C" fn inc_percpu_refcell_u64(info: *mut c_void) {
> > +    // SAFETY: We know that info is a void *const DynamicPerCpu<RefCell<u64>> and
> > +    // DynamicPerCpu<RefCell<u64>> is Send.
> > +    let mut pcpu = unsafe { (*(info as *const DynamicPerCpu<RefCell<u64>>)).clone() };
> > +    // SAFETY: smp_processor_id has no preconditions
> > +    pr_info!("Incrementing on {}\n", CpuId::current().as_u32());
> > +
> > +    pcpu.get(CpuGuard::new()).with(|val: &RefCell<u64>| {
> > +        let mut val = val.borrow_mut();
> > +        *val += 1;
> > +    });
> > +}
> > +
> > +extern "C" fn check_percpu_refcell_u64(info: *mut c_void) {
> > +    // SAFETY: We know that info is a void *const DynamicPerCpu<RefCell<u64>> and
> > +    // DynamicPerCpu<RefCell<u64>> is Send.
> > +    let mut pcpu = unsafe { (*(info as *const DynamicPerCpu<RefCell<u64>>)).clone() };
> > +    // SAFETY: smp_processor_id has no preconditions
> > +    pr_info!("Asserting on {}\n", CpuId::current().as_u32());
> > +
> > +    pcpu.get(CpuGuard::new()).with(|val: &RefCell<u64>| {
> > +        let val = val.borrow();
> > +        assert!(*val == 104);
> > +    });
> > +}
> > 
> > -- 
> > 2.34.1

