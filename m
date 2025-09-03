Return-Path: <linux-kernel+bounces-799041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AC3B42639
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36F297AFAE8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7B32BCF6A;
	Wed,  3 Sep 2025 16:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePQE5Hro"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D1229C323;
	Wed,  3 Sep 2025 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756915570; cv=none; b=WNUyaJdmWl147qis01a5KgZy6WOKkjfLjLHl2BAoxuDGb/1vEf4Ahdh44IItO2WeyBb5egXssRKb71Hm+G/NvySZs//KTWNBJ2SlxzwRbqO3aaT0eL9GL0Z93yAldoI5+z7wgWArZ/Ye7ucxBTiqu/2bseHlMqVhZEVcYuaz0IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756915570; c=relaxed/simple;
	bh=eMm7CdSxdi2JGX3257lPFRMtpni/lRltMz7IiWUbMbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bx9u6S2SjxxuJPvA9kEaOTxos7niJ24Ho4v1FNFAPvINRJrjBulEk2HU0pZ+wr3qAyZBDTKmIvmvUdnpnP/oZBooCWmdqEgNJ+tS+HlMGrVDNaIA+Zmpv28/T19kZiofZScSVk+NWrymXiRz6PzQXhvoPjycqK5EP/u6mM1choU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePQE5Hro; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b3415bfb26so694941cf.3;
        Wed, 03 Sep 2025 09:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756915567; x=1757520367; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wtG0lSFcCsgRhfzFGAJql7iOsNVinPOKt+3XnDjH6Qo=;
        b=ePQE5HroRSEEnUxKOvHKl1YwIC+ddxIC3WupKmEtE5QVr9njWn/0lCgHlIOWnOdkNy
         6AUaisbW8JdCetWUf4FmagtSa7tT8laCeLBpte1acF5kIDF8JXLdJiTIvVN5zadvxyjg
         S4Ra7wtsQuQJP8ZnukRbRc12oH+pg2nr2zNChpkCiDWJAeq2Wwn+rHUeUGnfKsJM8dQx
         11Xpc+SsW1+tv/aXTfsaOcpZzcv+Jg5Sh2mz1z8ekwHZYFv4fUJQj4vFwgNShNblhqgV
         bowqXcfqdYsDgLuVPCojZukPkr3yR/qmq/c/t9yqjfIE5MC0f1/tm4K5TVq+AZwkNvqN
         noDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756915567; x=1757520367;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wtG0lSFcCsgRhfzFGAJql7iOsNVinPOKt+3XnDjH6Qo=;
        b=o+dP3uBw4UCeuvbvV7p6k3+Ft/5c/Uxfm2OwT7raM55VS3YAlypQIugJN9ZVZ4Fe4R
         vT8UhLXPSedUtx9VbP9w0JZW8HHan0JeeMHYpH8P0Ghgf1Lz/ys4Q6IgytdQG+XBCU6u
         Vxg0mOYG0BQvh68aoQZ/y9Ix6SUP7kcdGaIdzmT2ynmoVCafd4nUsRQXTfh6zEmT1FNB
         9GHU3KJ9QyoniC61TOz8oZI70q6VLdescbgC4jW5eQqAh2XmkT0Bfd9HqK3cQqfjcaZz
         hIBYzv9MHYw2NW84WY92P1l9sF1ezBDY/FIP3J7YiRjLdtCbz+QwXeLWYYsUwsNPvD/f
         k4gg==
X-Forwarded-Encrypted: i=1; AJvYcCXrKnofOlyUqnSDUlws9isaB1OFiGroh6TvlxzRAhyfs8oVYoSHxdN/dng50mL+X3rolmlfBXh1lDyIXC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWJxvYy9vQbEaG3bkXQbaqjcqtN9bdm5oS/E2e8HesVf6oQY6D
	IU+Mjap1tfA8F5qGhdvng8twxaWVHvLeZWwzicfH70Iw+nKE42u4V5F/
X-Gm-Gg: ASbGncvvfNyrIE2H9h34Pb6oop0nGb5z7lBSVGF5gL16dOmvKBfNBUuWYtkB+yhPd8P
	reiK5hJwoO1czR70bVsFYIyWMDLyyYcsLrx2T6+0b44WV8kI5GBAvYNqR5rXc8HfZZABgLJGuLd
	IfUS3Zf+hLzr7z0xGxJeOvLNSlwFNRhJ2jFqo9iSLrWEDrS+dBC5bHpYVRxX9dbnsbdXaiwXFtG
	bLc5KwXseGHzH0+N39WGIFYc9R67x4+I4w/utP08R8JcgeVms+hBCrHoOQ8hERCPXiszHIdJ85g
	WkHF8fAjppiFh0kgu5de9/EYLBnVQWmBwfImxQ6kAd7WFmZpSM1Pk5gR4MXEeCDzsDSm8bWS6w4
	KAG2Pvk0GTDNT0vqRNqfuwQDkKghCFQzAGGjDnqxaBtCuRqh9/zkfAHZVfCJqOGbzFtYYrxawg4
	OcWsKLlqmctLswo5BMoimmMsyqdkhz9n5Org==
X-Google-Smtp-Source: AGHT+IFC+IPPKxcEgGV87IthwLLY97OA6GdYBbHxCcjlnfhaTUDGmRymoMzj3sW/Tj+rFLHEs3Py+A==
X-Received: by 2002:a05:622a:4c0e:b0:4b3:552:27ae with SMTP id d75a77b69052e-4b31da3ac27mr256133601cf.52.1756915566932;
        Wed, 03 Sep 2025 09:06:06 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f62aa1esm13824211cf.6.2025.09.03.09.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 09:06:06 -0700 (PDT)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id BA9D9F4006C;
	Wed,  3 Sep 2025 12:06:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 03 Sep 2025 12:06:05 -0400
X-ME-Sender: <xms:bWe4aNziqnMmZs3H3Iy_bDxag736NikDJ-Zh8MIYfKNFtllbCnE9Qw>
    <xme:bWe4aDthLrzZthCrSkDTSQX1i6pLaxNbvivVl0OkeAN3Sz_JHM3xjU7lnLZYIe_z1
    JMe_1GYN-OuxbS1Kw>
X-ME-Received: <xmr:bWe4aE0cjWFT6-RL_fb8oYwitO91MiXwsj9pM0MjuN86zyYx_mWFbGucMUjvtOBxw7wvxSTZna-RIF9n5irpfkEhmx544wpu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttd
    dtudenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgr
    ihhlrdgtohhmqeenucggtffrrghtthgvrhhnpefgleehteekgfduteejjeekhfejfedvie
    eftdfhhefggfehheeileeihfdtteehfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedvuddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepfihorhhksehonhhurhhoiihkrghnrdguvghvpdhrtghpthhtoheprhhushhtqd
    hfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhi
    nhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hoshhsihhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlhihuuggvsehrvgguhhgr
    thdrtghomhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhih
    sehgrghrhihguhhordhnvghtpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:bWe4aH5IOKye-5zhq9D5RtXNmp9wgFjiRhkYk-48OQVbf0nTbFKzwA>
    <xmx:bWe4aOPCEZs9S4ACaTjojU7X0lSRnE2bH1aUzp91TD0gPBjiuwKq2g>
    <xmx:bWe4aDHxGhqCPrzR8qbzgVMSVr-9PInVoTea0J7WlNnCq24D8uZzoA>
    <xmx:bWe4aK1fEtQk-rkfbMdkXrRxtIxSQ27R2DaIUFQJyL-s4B68cczfow>
    <xmx:bWe4aCHIaU2a5BODEaAb8tOcNSbB-YBBuvgSCW2DyKKgJ4c4ablBfPoE>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 12:06:04 -0400 (EDT)
Date: Wed, 3 Sep 2025 09:06:03 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	lossin@kernel.org, lyude@redhat.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org,
	peterz@infradead.org, mingo@redhat.com, will@kernel.org,
	longman@redhat.com, felipe_life@live.com, daniel@sedlak.dev,
	bjorn3_gh@protonmail.com, daniel.almeida@collabora.com
Subject: Re: [PATCH v6 2/7] rust: implement `WwClass` for ww_mutex support
Message-ID: <aLhna_Xj6W88F6Wp@tardis-2.local>
References: <20250903131313.4365-1-work@onurozkan.dev>
 <20250903131313.4365-3-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250903131313.4365-3-work@onurozkan.dev>

On Wed, Sep 03, 2025 at 04:13:08PM +0300, Onur Özkan wrote:
> Adds the `WwClass` type, the first step in supporting
> `ww_mutex` in Rust. `WwClass` represents a class of ww
> mutexes used for deadlock avoidance for supporting both
> wait-die and wound-wait semantics.
> 
> Also adds the `define_ww_class!` macro for safely declaring
> static instances.
> 
> Signed-off-by: Onur Özkan <work@onurozkan.dev>
> ---
>  rust/kernel/sync/lock.rs          |   1 +
>  rust/kernel/sync/lock/ww_mutex.rs | 136 ++++++++++++++++++++++++++++++
>  2 files changed, 137 insertions(+)
>  create mode 100644 rust/kernel/sync/lock/ww_mutex.rs
> 
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index 27202beef90c..5b320c2b28c1 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -15,6 +15,7 @@
> 
>  pub mod mutex;
>  pub mod spinlock;
> +pub mod ww_mutex;
> 
>  pub(super) mod global;
>  pub use global::{GlobalGuard, GlobalLock, GlobalLockBackend, GlobalLockedBy};
> diff --git a/rust/kernel/sync/lock/ww_mutex.rs b/rust/kernel/sync/lock/ww_mutex.rs
> new file mode 100644
> index 000000000000..ca5b4525ace6
> --- /dev/null
> +++ b/rust/kernel/sync/lock/ww_mutex.rs
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! A kernel Wound/Wait Mutex.
> +//!
> +//! This module provides Rust abstractions for the Linux kernel's `ww_mutex` implementation,
> +//! which provides deadlock avoidance through a wait-wound or wait-die algorithm.
> +//!
> +//! C header: [`include/linux/ww_mutex.h`](srctree/include/linux/ww_mutex.h)
> +//!
> +//! For more information: <https://docs.kernel.org/locking/ww-mutex-design.html>
> +
> +use crate::bindings;
> +use crate::prelude::*;
> +use crate::types::Opaque;
> +
> +/// Create static [`WwClass`] instances.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// use kernel::{c_str, define_ww_class};
> +///
> +/// define_ww_class!(WOUND_WAIT_GLOBAL_CLASS, wound_wait, c_str!("wound_wait_global_class"));
> +/// define_ww_class!(WAIT_DIE_GLOBAL_CLASS, wait_die, c_str!("wait_die_global_class"));
> +/// ```
> +#[macro_export]
> +macro_rules! define_ww_class {
> +    ($name:ident, wound_wait, $class_name:expr) => {
> +        static $name: $crate::sync::lock::ww_mutex::WwClass =
> +            // SAFETY: This is `static`, so address is fixed and won't move.
> +            unsafe { $crate::sync::lock::ww_mutex::WwClass::unpinned_new($class_name, false) };
> +    };
> +    ($name:ident, wait_die, $class_name:expr) => {
> +        static $name: $crate::sync::lock::ww_mutex::WwClass =
> +            // SAFETY: This is `static`, so address is fixed and won't move.
> +            unsafe { $crate::sync::lock::ww_mutex::WwClass::unpinned_new($class_name, true) };
> +    };
> +}
> +
> +/// A class used to group mutexes together for deadlock avoidance.
> +///
> +/// All mutexes that might be acquired together should use the same class.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// use kernel::sync::lock::ww_mutex::WwClass;
> +/// use kernel::c_str;
> +/// use pin_init::stack_pin_init;
> +///
> +/// stack_pin_init!(let _wait_die_class = WwClass::new_wait_die(c_str!("graphics_buffers")));
> +/// stack_pin_init!(let _wound_wait_class = WwClass::new_wound_wait(c_str!("memory_pools")));
> +///
> +/// # Ok::<(), Error>(())
> +/// ```
> +#[pin_data]
> +pub struct WwClass {
> +    #[pin]
> +    inner: Opaque<bindings::ww_class>,
> +}
> +
> +// SAFETY: [`WwClass`] is set up once and never modified. It's fine to share it across threads.
> +unsafe impl Sync for WwClass {}
> +// SAFETY: Doesn't hold anything thread-specific. It's safe to send to other threads.
> +unsafe impl Send for WwClass {}
> +
> +impl WwClass {
> +    /// Creates an unpinned [`WwClass`].
> +    ///
> +    /// # Safety
> +    ///
> +    /// Caller must guarantee that the returned value is not moved after creation.
> +    pub const unsafe fn unpinned_new(name: &'static CStr, is_wait_die: bool) -> Self {
> +        WwClass {
> +            inner: Opaque::new(bindings::ww_class {
> +                stamp: bindings::atomic_long_t { counter: 0 },
> +                acquire_name: name.as_char_ptr(),
> +                mutex_name: name.as_char_ptr(),
> +                is_wait_die: is_wait_die as u32,
> +                // TODO: Replace with `bindings::lock_class_key::default()` once stabilized for `const`.
> +                //
> +                // SAFETY: This is always zero-initialized when defined with `DEFINE_WD_CLASS`
> +                // globally on C side.
> +                //
> +                // Ref: <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/ww_mutex.h?h=v6.16-rc2#n85>

Please don't use internet to reference the code in the same repo ;-) You
can just say "see __WW_CLASS_INITIALIZER() in include/linux/ww_mutex.h".

> +                acquire_key: unsafe { core::mem::zeroed() },
> +                // TODO: Replace with `bindings::lock_class_key::default()` once stabilized for `const`.
> +                //
> +                // SAFETY: This is always zero-initialized when defined with `DEFINE_WD_CLASS`
> +                // globally on C side.
> +                //
> +                // Ref: <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/ww_mutex.h?h=v6.16-rc2#n85>
> +                mutex_key: unsafe { core::mem::zeroed() },
> +            }),
> +        }
> +    }
> +
> +    /// Creates a [`WwClass`].
> +    ///
> +    /// You should not use this function directly. Use the [`define_ww_class!`]
> +    /// macro or call [`WwClass::new_wait_die`] or [`WwClass::new_wound_wait`] instead.
> +    const fn new(name: &'static CStr, is_wait_die: bool) -> Self {
> +        WwClass {
> +            inner: Opaque::new(bindings::ww_class {

You cannot use Opaque::new() here, it'll move the object when new()
returns. You should change the function signature to a `... ->
PinInit<Self>`, and use pin_init!() macro + Opaque::ffi_init(), like:

    const fn new(...) -> PinInit<Self> {
        pin_init!{
	    Self {
	        inner <- Opaque::ffi_init(|class| {
		    ...
		});
	    }
	}
    }

Regards,
Boqun

> +                stamp: bindings::atomic_long_t { counter: 0 },
> +                acquire_name: name.as_char_ptr(),
> +                mutex_name: name.as_char_ptr(),
> +                is_wait_die: is_wait_die as u32,
> +                // TODO: Replace with `bindings::lock_class_key::default()` once stabilized for `const`.
> +                //
> +                // SAFETY: This is always zero-initialized when defined with `DEFINE_WD_CLASS`
> +                // globally on C side.
> +                //
> +                // Ref: <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/ww_mutex.h?h=v6.16-rc2#n85>
> +                acquire_key: unsafe { core::mem::zeroed() },
> +                // TODO: Replace with `bindings::lock_class_key::default()` once stabilized for `const`.
> +                //
> +                // SAFETY: This is always zero-initialized when defined with `DEFINE_WD_CLASS`
> +                // globally on C side.
> +                //
> +                // Ref: <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/ww_mutex.h?h=v6.16-rc2#n85>
> +                mutex_key: unsafe { core::mem::zeroed() },
> +            }),
> +        }
> +    }
> +
> +    /// Creates wait-die [`WwClass`].
> +    pub fn new_wait_die(name: &'static CStr) -> impl PinInit<Self> {
> +        Self::new(name, true)
> +    }
> +
> +    /// Creates wound-wait [`WwClass`].
> +    pub fn new_wound_wait(name: &'static CStr) -> impl PinInit<Self> {
> +        Self::new(name, false)
> +    }
> +}
> --
> 2.50.0
> 

