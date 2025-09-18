Return-Path: <linux-kernel+bounces-823266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC5FB85F3D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09B04A67EE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012D430FC22;
	Thu, 18 Sep 2025 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dmlPnd7f"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808473112B3
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212420; cv=none; b=cXJOh/ax4WWZRQNcI8kHXjf8Vl/8HAm/pYrCdQDE7JoWfpez3Y0vbNfLJHLcb3dITTqJsRGvnHqCu2pHgH7fIjBQ9W2kSV49gtAt5e6KCl411/UstB2awbpI1B9rh8ovCEXVipw9ZhVPjjdBIM70A/bz3fEstFh2d3uKdF7yoic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212420; c=relaxed/simple;
	bh=tJrYZUrIWbgF+O4IRS1EoOTKZqoXGlGLpUWB3HPlx4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlFnLwxjDKwiLSVXdyc1tzf1WYfDk1ebVpRdusc9RSd1kXtUzagp9UWSqJDK11ArTTnb/qqD58AjpxGTPB4ScBUu9wV7gZEwx9FWutWJ6NLQdsNl/wrxpdi3buTg3zumzvdNk7fFrt5WFY4itRK7p8oFF2A/tM2cthBU1HDbgLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dmlPnd7f; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-267c90c426dso255295ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758212406; x=1758817206; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9o4isFY4qaUI1qY0G0DPhrdWsHD8gGr+6smM2FoseXE=;
        b=dmlPnd7f0ycuM/Bej1t61ixlwfG0j5/bxfIVAkGTJHc4opo9HK8xQU2bsrugfXG1NJ
         6WNR7YGe1GVmt+joNk6Betd9SeUhvD3RKizH82FCjTbNbSM0k84okm1HLMkBULCBFKnt
         gONaEkX6WJJd06LkVfKq4c5etRI5NvMRgsnBg6gSUS9ewfTCO/FCElbR8ZQYJKBPiO0Q
         07emTeT5z0fzKaPRxzn8qXTeLXedWdwYFtTmp2MqB2+uJXsyRIqQGnFAGkEkFPXwROiM
         76v/sB1IqBQRvjoEx3y6Sk0622Yljx4QX12C9irLU/4xTQRYEpvWE362DvGF2or2WXfk
         +g/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758212406; x=1758817206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9o4isFY4qaUI1qY0G0DPhrdWsHD8gGr+6smM2FoseXE=;
        b=KaGLclzjfsIQPZepcPz2zGSTk7x7Hn3fxcvTkIlIERadKMaroX9UZJUOAv8714smJ9
         rBYLIliVQMNjrjiXSKXFtWgEN+breZBcSB0qZN3V7YE7qCQtns83hYG0Sme+BErW/tWz
         CTl0LnlIP2YlasvEkgiisiMm0nbarCvxKehPUYSpFP2sgkLigvayvpvIf1tvCdCMwtUy
         L46ze9pIiRsnpF2hidoOol1EDjYU86pIqcFzVrLYAwzrfKQgNS7S9C06jH+vpyEAwA9H
         abmz1ecufy8u8e/g1KU7W+s9/bjPxaJ2v4oSSzi+MHCMP0nTi8yXcXIogGW5pw7sjqD5
         uZZA==
X-Forwarded-Encrypted: i=1; AJvYcCXLNzlE1R47CObOlfeNvCCX4k9Xa8/MM4FpFX/WZmAgsTNmKyKDV8g1LHWdNr+xL/QHgZcXWdjRUOPOkLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxewdDhj3lEMzU4C0OcdbaibK8B5Fj3pMtFF4F2Z1BWENg2fuyD
	gyOhrvJp24BePVh6DHAHSzSLraGepuD/xMssf9ryaGn2aBT2tpj6X4CW6vPclUkZYA==
X-Gm-Gg: ASbGncutFZMLSg1hsE/v3P8svUsyTKGH8DmE/9V3SE1Xosx5SHYKfCFpReeDxYo3YCu
	h0Y/IwcG9BUB2oUMz79i3X0EQlQu2Fh6x+GgZLW+sjD/2zcTuxjFoZRNmyoCnf8qr6mKREGpy5Y
	ciT4Aa2j9NPRsbbdDBLRy8HgzreQWlQca+EaNLXeIos3pf5EiyH2c9/XjYddAG32niycpRExAwf
	EbqEiCoUwE22d6YZyG9y/4pvND8jneenUWsMiolE4Lc6Ni8BEj4iCd1hAZyRU9kbjMSBNBNoSiU
	X0b5une98/mk9tn2xWZY6/mcZtw6li1dXEttrUGKJNXwMLUv65nrEJwM/9YDxO0/KQ4WNabcdoc
	6cxsS5uzbd2JMWITGHBgKxZ04GaIDx1rvtHajrZoH5OGnmDexsudZyCsep0ju84fbZDK7l8Br3N
	DZVhsfkgaJPQ==
X-Google-Smtp-Source: AGHT+IHfsqc7N+1Y6KrRI+CCHS1J6OVu9MTJ0YHEBFBcLlYk2XqqR7w9xY/0osLpAhFeYulpG8uEDQ==
X-Received: by 2002:a17:902:e74d:b0:269:7c50:85c8 with SMTP id d9443c01a7336-2697c5088camr6741175ad.2.1758212403891;
        Thu, 18 Sep 2025 09:20:03 -0700 (PDT)
Received: from google.com (163.180.16.34.bc.googleusercontent.com. [34.16.180.163])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698033c922sm29114645ad.131.2025.09.18.09.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 09:20:02 -0700 (PDT)
Date: Thu, 18 Sep 2025 16:19:57 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Matt Gilbride <mattgilbride@google.com>
Subject: Re: [PATCH] rust_binder: add Rust Binder driver
Message-ID: <aMwxLQubVOuGZGLf@google.com>
References: <20250918-rust-binder-v1-1-7a5559e8c6bb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918-rust-binder-v1-1-7a5559e8c6bb@google.com>

On Thu, Sep 18, 2025 at 10:19:38AM +0000, Alice Ryhl wrote:
> Please see the attached link to the original RFC for motivation.
> 
> I did not include all of the tracepoints as I felt that the mechansim
> for making C access fields of Rust structs should be discussed on list
> separately. I also did not include the support for building Rust Binder
> as a module since that requires exporting a bunch of additional symbols
> on the C side.
> 
> Link: https://lore.kernel.org/r/20231101-rust-binder-v1-0-08ba9197f637@google.com
> Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Co-developed-by: Matt Gilbride <mattgilbride@google.com>
> Signed-off-by: Matt Gilbride <mattgilbride@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  drivers/android/Kconfig                       |   15 +-
>  drivers/android/Makefile                      |    1 +
>  drivers/android/binder/Makefile               |    9 +
>  drivers/android/binder/allocation.rs          |  602 +++++++++
>  drivers/android/binder/context.rs             |  180 +++
>  drivers/android/binder/deferred_close.rs      |  204 +++
>  drivers/android/binder/defs.rs                |  182 +++
>  drivers/android/binder/dummy.c                |   15 +
>  drivers/android/binder/error.rs               |   99 ++
>  drivers/android/binder/freeze.rs              |  388 ++++++
>  drivers/android/binder/node.rs                | 1131 +++++++++++++++++
>  drivers/android/binder/node/wrapper.rs        |   78 ++
>  drivers/android/binder/page_range.rs          |  746 +++++++++++
>  drivers/android/binder/page_range_helper.c    |   24 +
>  drivers/android/binder/page_range_helper.h    |   15 +
>  drivers/android/binder/process.rs             | 1696 +++++++++++++++++++++++++
>  drivers/android/binder/range_alloc/array.rs   |  251 ++++
>  drivers/android/binder/range_alloc/mod.rs     |  329 +++++
>  drivers/android/binder/range_alloc/tree.rs    |  488 +++++++
>  drivers/android/binder/rust_binder.h          |   23 +
>  drivers/android/binder/rust_binder_events.c   |   59 +
>  drivers/android/binder/rust_binder_events.h   |   36 +
>  drivers/android/binder/rust_binder_internal.h |   87 ++
>  drivers/android/binder/rust_binder_main.rs    |  627 +++++++++
>  drivers/android/binder/rust_binderfs.c        |  850 +++++++++++++
>  drivers/android/binder/stats.rs               |   89 ++
>  drivers/android/binder/thread.rs              | 1596 +++++++++++++++++++++++
>  drivers/android/binder/trace.rs               |   16 +
>  drivers/android/binder/transaction.rs         |  456 +++++++
>  include/uapi/linux/android/binder.h           |    2 +-
>  rust/bindings/bindings_helper.h               |    8 +
>  rust/helpers/binder.c                         |   26 +
>  rust/helpers/helpers.c                        |    1 +
>  rust/helpers/page.c                           |    8 +
>  rust/helpers/security.c                       |   24 +
>  rust/kernel/cred.rs                           |    6 +
>  rust/kernel/page.rs                           |    6 +
>  rust/kernel/security.rs                       |   37 +
>  rust/uapi/uapi_helper.h                       |    1 +
>  39 files changed, 10409 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/android/Kconfig b/drivers/android/Kconfig
> index 75af3cf472c8f8a3b93698911c6115ff5692943a..e2e402c9d1759c81591473ad02ab7ad011bc61d0 100644
> --- a/drivers/android/Kconfig
> +++ b/drivers/android/Kconfig
> @@ -14,6 +14,19 @@ config ANDROID_BINDER_IPC
>  	  Android process, using Binder to identify, invoke and pass arguments
>  	  between said processes.
>  
> +config ANDROID_BINDER_IPC_RUST
> +	bool "Rust version of Android Binder IPC Driver"
> +	depends on RUST && MMU && !ANDROID_BINDER_IPC
> +	help
> +	  This enables the Rust implementation of the Binder driver.
> +
> +	  Binder is used in Android for both communication between processes,
> +	  and remote method invocation.
> +
> +	  This means one Android process can call a method/routine in another
> +	  Android process, using Binder to identify, invoke and pass arguments
> +	  between said processes.
> +
>  config ANDROID_BINDERFS
>  	bool "Android Binderfs filesystem"
>  	depends on ANDROID_BINDER_IPC
> @@ -28,7 +41,7 @@ config ANDROID_BINDERFS
>  
>  config ANDROID_BINDER_DEVICES
>  	string "Android Binder devices"
> -	depends on ANDROID_BINDER_IPC
> +	depends on ANDROID_BINDER_IPC || ANDROID_BINDER_IPC_RUST
>  	default "binder,hwbinder,vndbinder"
>  	help
>  	  Default value for the binder.devices parameter.
> diff --git a/drivers/android/Makefile b/drivers/android/Makefile
> index f422f91e026b2c421c6036f0d5c4286a9cebe8ee..e0c650d3898edeefd66c7d04c28bd1d0f49a76c9 100644
> --- a/drivers/android/Makefile
> +++ b/drivers/android/Makefile
> @@ -4,3 +4,4 @@ ccflags-y += -I$(src)			# needed for trace events
>  obj-$(CONFIG_ANDROID_BINDERFS)		+= binderfs.o
>  obj-$(CONFIG_ANDROID_BINDER_IPC)	+= binder.o binder_alloc.o binder_netlink.o
>  obj-$(CONFIG_ANDROID_BINDER_ALLOC_KUNIT_TEST)	+= tests/
> +obj-$(CONFIG_ANDROID_BINDER_IPC_RUST)	+= binder/
> diff --git a/drivers/android/binder/Makefile b/drivers/android/binder/Makefile
> new file mode 100644
> index 0000000000000000000000000000000000000000..b70f80894c74cc2212f720f5a8d874b7bf4778d5
> --- /dev/null
> +++ b/drivers/android/binder/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +ccflags-y += -I$(src)	# needed for trace events
> +
> +obj-$(CONFIG_ANDROID_BINDER_IPC_RUST) += rust_binder.o
> +rust_binder-$(CONFIG_ANDROID_BINDER_IPC_RUST) := \

Since there is only one option for rust_binder.o, the target here should
probably be just 'rust_binder-y := ...'.

> +	rust_binder_main.o	\
> +	rust_binderfs.o		\
> +	rust_binder_events.o	\
> +	page_range_helper.o
> diff --git a/drivers/android/binder/allocation.rs b/drivers/android/binder/allocation.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..7f65a9c3a0e58e07a7e6d4e7d7b185f73fb1aab8
> --- /dev/null
> +++ b/drivers/android/binder/allocation.rs
> @@ -0,0 +1,602 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2025 Google LLC.
> +
> +use core::mem::{size_of, size_of_val, MaybeUninit};
> +use core::ops::Range;
> +
> +use kernel::{
> +    bindings,
> +    fs::file::{File, FileDescriptorReservation},
> +    prelude::*,
> +    sync::{aref::ARef, Arc},
> +    transmute::{AsBytes, FromBytes},
> +    uaccess::UserSliceReader,
> +    uapi,
> +};
> +
> +use crate::{
> +    deferred_close::DeferredFdCloser,
> +    defs::*,
> +    node::{Node, NodeRef},
> +    process::Process,
> +    DArc,
> +};
> +
> +#[derive(Default)]
> +pub(crate) struct AllocationInfo {
> +    /// Range within the allocation where we can find the offsets to the object descriptors.
> +    pub(crate) offsets: Option<Range<usize>>,
> +    /// The target node of the transaction this allocation is associated to.
> +    /// Not set for replies.
> +    pub(crate) target_node: Option<NodeRef>,
> +    /// When this allocation is dropped, call `pending_oneway_finished` on the node.
> +    ///
> +    /// This is used to serialize oneway transaction on the same node. Binder guarantees that
> +    /// oneway transactions to the same node are delivered sequentially in the order they are sent.
> +    pub(crate) oneway_node: Option<DArc<Node>>,
> +    /// Zero the data in the buffer on free.
> +    pub(crate) clear_on_free: bool,
> +    /// List of files embedded in this transaction.
> +    file_list: FileList,
> +}
> +
> +/// Represents an allocation that the kernel is currently using.
> +///
> +/// When allocations are idle, the range allocator holds the data related to them.
> +///
> +/// # Invariants
> +///
> +/// This allocation corresponds to an allocation in the range allocator, so the relevant pages are
> +/// marked in use in the page range.
> +pub(crate) struct Allocation {
> +    pub(crate) offset: usize,
> +    size: usize,
> +    pub(crate) ptr: usize,
> +    pub(crate) process: Arc<Process>,
> +    allocation_info: Option<AllocationInfo>,
> +    free_on_drop: bool,
> +    pub(crate) oneway_spam_detected: bool,
> +    #[allow(dead_code)]
> +    pub(crate) debug_id: usize,
> +}
> +
> +impl Allocation {
> +    pub(crate) fn new(
> +        process: Arc<Process>,
> +        debug_id: usize,
> +        offset: usize,
> +        size: usize,
> +        ptr: usize,
> +        oneway_spam_detected: bool,
> +    ) -> Self {
> +        Self {
> +            process,
> +            offset,
> +            size,
> +            ptr,
> +            debug_id,
> +            oneway_spam_detected,
> +            allocation_info: None,
> +            free_on_drop: true,
> +        }
> +    }
> +
> +    fn size_check(&self, offset: usize, size: usize) -> Result {
> +        let overflow_fail = offset.checked_add(size).is_none();
> +        let cmp_size_fail = offset.wrapping_add(size) > self.size;
> +        if overflow_fail || cmp_size_fail {
> +            return Err(EFAULT);
> +        }
> +        Ok(())
> +    }
> +
> +    pub(crate) fn copy_into(
> +        &self,
> +        reader: &mut UserSliceReader,
> +        offset: usize,
> +        size: usize,
> +    ) -> Result {
> +        self.size_check(offset, size)?;
> +
> +        // SAFETY: While this object exists, the range allocator will keep the range allocated, and
> +        // in turn, the pages will be marked as in use.
> +        unsafe {
> +            self.process
> +                .pages
> +                .copy_from_user_slice(reader, self.offset + offset, size)
> +        }
> +    }
> +
> +    pub(crate) fn read<T: FromBytes>(&self, offset: usize) -> Result<T> {
> +        self.size_check(offset, size_of::<T>())?;
> +
> +        // SAFETY: While this object exists, the range allocator will keep the range allocated, and
> +        // in turn, the pages will be marked as in use.
> +        unsafe { self.process.pages.read(self.offset + offset) }
> +    }
> +
> +    pub(crate) fn write<T: ?Sized>(&self, offset: usize, obj: &T) -> Result {
> +        self.size_check(offset, size_of_val::<T>(obj))?;
> +
> +        // SAFETY: While this object exists, the range allocator will keep the range allocated, and
> +        // in turn, the pages will be marked as in use.
> +        unsafe { self.process.pages.write(self.offset + offset, obj) }
> +    }
> +
> +    pub(crate) fn fill_zero(&self) -> Result {
> +        // SAFETY: While this object exists, the range allocator will keep the range allocated, and
> +        // in turn, the pages will be marked as in use.
> +        unsafe { self.process.pages.fill_zero(self.offset, self.size) }
> +    }
> +
> +    pub(crate) fn keep_alive(mut self) {
> +        self.process
> +            .buffer_make_freeable(self.offset, self.allocation_info.take());
> +        self.free_on_drop = false;
> +    }
> +
> +    pub(crate) fn set_info(&mut self, info: AllocationInfo) {
> +        self.allocation_info = Some(info);
> +    }
> +
> +    pub(crate) fn get_or_init_info(&mut self) -> &mut AllocationInfo {
> +        self.allocation_info.get_or_insert_with(Default::default)
> +    }
> +
> +    pub(crate) fn set_info_offsets(&mut self, offsets: Range<usize>) {
> +        self.get_or_init_info().offsets = Some(offsets);
> +    }
> +
> +    pub(crate) fn set_info_oneway_node(&mut self, oneway_node: DArc<Node>) {
> +        self.get_or_init_info().oneway_node = Some(oneway_node);
> +    }
> +
> +    pub(crate) fn set_info_clear_on_drop(&mut self) {
> +        self.get_or_init_info().clear_on_free = true;
> +    }
> +
> +    pub(crate) fn set_info_target_node(&mut self, target_node: NodeRef) {
> +        self.get_or_init_info().target_node = Some(target_node);
> +    }
> +
> +    /// Reserve enough space to push at least `num_fds` fds.
> +    pub(crate) fn info_add_fd_reserve(&mut self, num_fds: usize) -> Result {
> +        self.get_or_init_info()
> +            .file_list
> +            .files_to_translate
> +            .reserve(num_fds, GFP_KERNEL)?;
> +
> +        Ok(())
> +    }
> +
> +    pub(crate) fn info_add_fd(
> +        &mut self,
> +        file: ARef<File>,
> +        buffer_offset: usize,
> +        close_on_free: bool,
> +    ) -> Result {
> +        self.get_or_init_info().file_list.files_to_translate.push(
> +            FileEntry {
> +                file,
> +                buffer_offset,
> +                close_on_free,
> +            },
> +            GFP_KERNEL,
> +        )?;
> +
> +        Ok(())
> +    }
> +
> +    pub(crate) fn set_info_close_on_free(&mut self, cof: FdsCloseOnFree) {
> +        self.get_or_init_info().file_list.close_on_free = cof.0;
> +    }
> +
> +    pub(crate) fn translate_fds(&mut self) -> Result<TranslatedFds> {
> +        let file_list = match self.allocation_info.as_mut() {
> +            Some(info) => &mut info.file_list,
> +            None => return Ok(TranslatedFds::new()),
> +        };
> +
> +        let files = core::mem::take(&mut file_list.files_to_translate);
> +
> +        let num_close_on_free = files.iter().filter(|entry| entry.close_on_free).count();
> +        let mut close_on_free = KVec::with_capacity(num_close_on_free, GFP_KERNEL)?;
> +
> +        let mut reservations = KVec::with_capacity(files.len(), GFP_KERNEL)?;
> +        for file_info in files {
> +            let res = FileDescriptorReservation::get_unused_fd_flags(bindings::O_CLOEXEC)?;
> +            let fd = res.reserved_fd();
> +            self.write::<u32>(file_info.buffer_offset, &fd)?;
> +
> +            reservations.push(
> +                Reservation {
> +                    res,
> +                    file: file_info.file,
> +                },
> +                GFP_KERNEL,
> +            )?;
> +            if file_info.close_on_free {
> +                close_on_free.push(fd, GFP_KERNEL)?;
> +            }
> +        }
> +
> +        Ok(TranslatedFds {
> +            reservations,
> +            close_on_free: FdsCloseOnFree(close_on_free),
> +        })
> +    }
> +
> +    /// Should the looper return to userspace when freeing this allocation?
> +    pub(crate) fn looper_need_return_on_free(&self) -> bool {
> +        // Closing fds involves pushing task_work for execution when we return to userspace. Hence,
> +        // we should return to userspace asap if we are closing fds.
> +        match self.allocation_info {
> +            Some(ref info) => !info.file_list.close_on_free.is_empty(),
> +            None => false,
> +        }
> +    }
> +}
> +
> +impl Drop for Allocation {
> +    fn drop(&mut self) {
> +        if !self.free_on_drop {
> +            return;
> +        }
> +
> +        if let Some(mut info) = self.allocation_info.take() {
> +            if let Some(oneway_node) = info.oneway_node.as_ref() {
> +                oneway_node.pending_oneway_finished();
> +            }
> +
> +            info.target_node = None;
> +
> +            if let Some(offsets) = info.offsets.clone() {
> +                let view = AllocationView::new(self, offsets.start);
> +                for i in offsets.step_by(size_of::<usize>()) {
> +                    if view.cleanup_object(i).is_err() {
> +                        pr_warn!("Error cleaning up object at offset {}\n", i)
> +                    }
> +                }
> +            }
> +
> +            for &fd in &info.file_list.close_on_free {
> +                let closer = match DeferredFdCloser::new(GFP_KERNEL) {
> +                    Ok(closer) => closer,
> +                    Err(kernel::alloc::AllocError) => {
> +                        // Ignore allocation failures.
> +                        break;
> +                    }
> +                };
> +
> +                // Here, we ignore errors. The operation can fail if the fd is not valid, or if the
> +                // method is called from a kthread. However, this is always called from a syscall,
> +                // so the latter case cannot happen, and we don't care about the first case.
> +                let _ = closer.close_fd(fd);
> +            }
> +
> +            if info.clear_on_free {
> +                if let Err(e) = self.fill_zero() {
> +                    pr_warn!("Failed to clear data on free: {:?}", e);
> +                }
> +            }
> +        }
> +
> +        self.process.buffer_raw_free(self.ptr);
> +    }
> +}
> +
> +/// A wrapper around `Allocation` that is being created.
> +///
> +/// If the allocation is destroyed while wrapped in this wrapper, then the allocation will be
> +/// considered to be part of a failed transaction. Successful transactions avoid that by calling
> +/// `success`, which skips the destructor.
> +#[repr(transparent)]
> +pub(crate) struct NewAllocation(pub(crate) Allocation);
> +
> +impl NewAllocation {
> +    pub(crate) fn success(self) -> Allocation {
> +        // This skips the destructor.
> +        //
> +        // SAFETY: This type is `#[repr(transparent)]`, so the layout matches.
> +        unsafe { core::mem::transmute(self) }
> +    }
> +}
> +
> +impl core::ops::Deref for NewAllocation {
> +    type Target = Allocation;
> +    fn deref(&self) -> &Allocation {
> +        &self.0
> +    }
> +}
> +
> +impl core::ops::DerefMut for NewAllocation {
> +    fn deref_mut(&mut self) -> &mut Allocation {
> +        &mut self.0
> +    }
> +}
> +
> +/// A view into the beginning of an allocation.
> +///
> +/// All attempts to read or write outside of the view will fail. To intentionally access outside of
> +/// this view, use the `alloc` field of this struct directly.
> +pub(crate) struct AllocationView<'a> {
> +    pub(crate) alloc: &'a mut Allocation,
> +    limit: usize,
> +}
> +
> +impl<'a> AllocationView<'a> {
> +    pub(crate) fn new(alloc: &'a mut Allocation, limit: usize) -> Self {
> +        AllocationView { alloc, limit }
> +    }
> +
> +    pub(crate) fn read<T: FromBytes>(&self, offset: usize) -> Result<T> {
> +        if offset.checked_add(size_of::<T>()).ok_or(EINVAL)? > self.limit {
> +            return Err(EINVAL);
> +        }
> +        self.alloc.read(offset)
> +    }
> +
> +    pub(crate) fn write<T: AsBytes>(&self, offset: usize, obj: &T) -> Result {
> +        if offset.checked_add(size_of::<T>()).ok_or(EINVAL)? > self.limit {
> +            return Err(EINVAL);
> +        }
> +        self.alloc.write(offset, obj)
> +    }
> +
> +    pub(crate) fn copy_into(
> +        &self,
> +        reader: &mut UserSliceReader,
> +        offset: usize,
> +        size: usize,
> +    ) -> Result {
> +        if offset.checked_add(size).ok_or(EINVAL)? > self.limit {
> +            return Err(EINVAL);
> +        }
> +        self.alloc.copy_into(reader, offset, size)
> +    }
> +
> +    pub(crate) fn transfer_binder_object(
> +        &self,
> +        offset: usize,
> +        obj: &uapi::flat_binder_object,
> +        strong: bool,
> +        node_ref: NodeRef,
> +    ) -> Result {
> +        let mut newobj = FlatBinderObject::default();
> +        let node = node_ref.node.clone();
> +        if Arc::ptr_eq(&node_ref.node.owner, &self.alloc.process) {
> +            // The receiving process is the owner of the node, so send it a binder object (instead
> +            // of a handle).
> +            let (ptr, cookie) = node.get_id();
> +            newobj.hdr.type_ = if strong {
> +                BINDER_TYPE_BINDER
> +            } else {
> +                BINDER_TYPE_WEAK_BINDER
> +            };
> +            newobj.flags = obj.flags;
> +            newobj.__bindgen_anon_1.binder = ptr as _;
> +            newobj.cookie = cookie as _;
> +            self.write(offset, &newobj)?;
> +            // Increment the user ref count on the node. It will be decremented as part of the
> +            // destruction of the buffer, when we see a binder or weak-binder object.
> +            node.update_refcount(true, 1, strong);
> +        } else {
> +            // The receiving process is different from the owner, so we need to insert a handle to
> +            // the binder object.
> +            let handle = self
> +                .alloc
> +                .process
> +                .as_arc_borrow()
> +                .insert_or_update_handle(node_ref, false)?;
> +            newobj.hdr.type_ = if strong {
> +                BINDER_TYPE_HANDLE
> +            } else {
> +                BINDER_TYPE_WEAK_HANDLE
> +            };
> +            newobj.flags = obj.flags;
> +            newobj.__bindgen_anon_1.handle = handle;
> +            if self.write(offset, &newobj).is_err() {
> +                // Decrement ref count on the handle we just created.
> +                let _ = self
> +                    .alloc
> +                    .process
> +                    .as_arc_borrow()
> +                    .update_ref(handle, false, strong);
> +                return Err(EINVAL);
> +            }
> +        }
> +
> +        Ok(())
> +    }
> +
> +    fn cleanup_object(&self, index_offset: usize) -> Result {
> +        let offset = self.alloc.read(index_offset)?;
> +        let header = self.read::<BinderObjectHeader>(offset)?;
> +        match header.type_ {
> +            BINDER_TYPE_WEAK_BINDER | BINDER_TYPE_BINDER => {
> +                let obj = self.read::<FlatBinderObject>(offset)?;
> +                let strong = header.type_ == BINDER_TYPE_BINDER;
> +                // SAFETY: The type is `BINDER_TYPE_{WEAK_}BINDER`, so the `binder` field is
> +                // populated.
> +                let ptr = unsafe { obj.__bindgen_anon_1.binder };
> +                let cookie = obj.cookie;
> +                self.alloc.process.update_node(ptr, cookie, strong);
> +                Ok(())
> +            }
> +            BINDER_TYPE_WEAK_HANDLE | BINDER_TYPE_HANDLE => {
> +                let obj = self.read::<FlatBinderObject>(offset)?;
> +                let strong = header.type_ == BINDER_TYPE_HANDLE;
> +                // SAFETY: The type is `BINDER_TYPE_{WEAK_}HANDLE`, so the `handle` field is
> +                // populated.
> +                let handle = unsafe { obj.__bindgen_anon_1.handle };
> +                self.alloc
> +                    .process
> +                    .as_arc_borrow()
> +                    .update_ref(handle, false, strong)
> +            }
> +            _ => Ok(()),
> +        }
> +    }
> +}
> +
> +/// A binder object as it is serialized.
> +///
> +/// # Invariants
> +///
> +/// All bytes must be initialized, and the value of `self.hdr.type_` must be one of the allowed
> +/// types.
> +#[repr(C)]
> +pub(crate) union BinderObject {
> +    hdr: uapi::binder_object_header,
> +    fbo: uapi::flat_binder_object,
> +    fdo: uapi::binder_fd_object,
> +    bbo: uapi::binder_buffer_object,
> +    fdao: uapi::binder_fd_array_object,
> +}
> +
> +/// A view into a `BinderObject` that can be used in a match statement.
> +pub(crate) enum BinderObjectRef<'a> {
> +    Binder(&'a mut uapi::flat_binder_object),
> +    Handle(&'a mut uapi::flat_binder_object),
> +    Fd(&'a mut uapi::binder_fd_object),
> +    Ptr(&'a mut uapi::binder_buffer_object),
> +    Fda(&'a mut uapi::binder_fd_array_object),
> +}
> +
> +impl BinderObject {
> +    pub(crate) fn read_from(reader: &mut UserSliceReader) -> Result<BinderObject> {
> +        let object = Self::read_from_inner(|slice| {
> +            let read_len = usize::min(slice.len(), reader.len());
> +            reader.clone_reader().read_slice(&mut slice[..read_len])?;
> +            Ok(())
> +        })?;
> +
> +        // If we used a object type smaller than the largest object size, then we've read more
> +        // bytes than we needed to. However, we used `.clone_reader()` to avoid advancing the
> +        // original reader. Now, we call `skip` so that the caller's reader is advanced by the
> +        // right amount.
> +        //
> +        // The `skip` call fails if the reader doesn't have `size` bytes available. This could
> +        // happen if the type header corresponds to an object type that is larger than the rest of
> +        // the reader.
> +        //
> +        // Any extra bytes beyond the size of the object are inaccessible after this call, so
> +        // reading them again from the `reader` later does not result in TOCTOU bugs.
> +        reader.skip(object.size())?;
> +
> +        Ok(object)
> +    }
> +
> +    /// Use the provided reader closure to construct a `BinderObject`.
> +    ///
> +    /// The closure should write the bytes for the object into the provided slice.
> +    pub(crate) fn read_from_inner<R>(reader: R) -> Result<BinderObject>
> +    where
> +        R: FnOnce(&mut [u8; size_of::<BinderObject>()]) -> Result<()>,
> +    {
> +        let mut obj = MaybeUninit::<BinderObject>::zeroed();
> +
> +        // SAFETY: The lengths of `BinderObject` and `[u8; size_of::<BinderObject>()]` are equal,
> +        // and the byte array has an alignment requirement of one, so the pointer cast is okay.
> +        // Additionally, `obj` was initialized to zeros, so the byte array will not be
> +        // uninitialized.
> +        (reader)(unsafe { &mut *obj.as_mut_ptr().cast() })?;
> +
> +        // SAFETY: The entire object is initialized, so accessing this field is safe.
> +        let type_ = unsafe { obj.assume_init_ref().hdr.type_ };
> +        if Self::type_to_size(type_).is_none() {
> +            // The value of `obj.hdr_type_` was invalid.
> +            return Err(EINVAL);
> +        }
> +
> +        // SAFETY: All bytes are initialized (since we zeroed them at the start) and we checked
> +        // that `self.hdr.type_` is one of the allowed types, so the type invariants are satisfied.
> +        unsafe { Ok(obj.assume_init()) }
> +    }
> +
> +    pub(crate) fn as_ref(&mut self) -> BinderObjectRef<'_> {
> +        use BinderObjectRef::*;
> +        // SAFETY: The constructor ensures that all bytes of `self` are initialized, and all
> +        // variants of this union accept all initialized bit patterns.
> +        unsafe {
> +            match self.hdr.type_ {
> +                BINDER_TYPE_WEAK_BINDER | BINDER_TYPE_BINDER => Binder(&mut self.fbo),
> +                BINDER_TYPE_WEAK_HANDLE | BINDER_TYPE_HANDLE => Handle(&mut self.fbo),
> +                BINDER_TYPE_FD => Fd(&mut self.fdo),
> +                BINDER_TYPE_PTR => Ptr(&mut self.bbo),
> +                BINDER_TYPE_FDA => Fda(&mut self.fdao),
> +                // SAFETY: By the type invariant, the value of `self.hdr.type_` cannot have any
> +                // other value than the ones checked above.
> +                _ => core::hint::unreachable_unchecked(),
> +            }
> +        }
> +    }
> +
> +    pub(crate) fn size(&self) -> usize {
> +        // SAFETY: The entire object is initialized, so accessing this field is safe.
> +        let type_ = unsafe { self.hdr.type_ };
> +
> +        // SAFETY: The type invariants guarantee that the type field is correct.
> +        unsafe { Self::type_to_size(type_).unwrap_unchecked() }
> +    }
> +
> +    fn type_to_size(type_: u32) -> Option<usize> {
> +        match type_ {
> +            BINDER_TYPE_WEAK_BINDER => Some(size_of::<uapi::flat_binder_object>()),
> +            BINDER_TYPE_BINDER => Some(size_of::<uapi::flat_binder_object>()),
> +            BINDER_TYPE_WEAK_HANDLE => Some(size_of::<uapi::flat_binder_object>()),
> +            BINDER_TYPE_HANDLE => Some(size_of::<uapi::flat_binder_object>()),
> +            BINDER_TYPE_FD => Some(size_of::<uapi::binder_fd_object>()),
> +            BINDER_TYPE_PTR => Some(size_of::<uapi::binder_buffer_object>()),
> +            BINDER_TYPE_FDA => Some(size_of::<uapi::binder_fd_array_object>()),
> +            _ => None,
> +        }
> +    }
> +}
> +
> +#[derive(Default)]
> +struct FileList {
> +    files_to_translate: KVec<FileEntry>,
> +    close_on_free: KVec<u32>,
> +}
> +
> +struct FileEntry {
> +    /// The file for which a descriptor will be created in the recipient process.
> +    file: ARef<File>,
> +    /// The offset in the buffer where the file descriptor is stored.
> +    buffer_offset: usize,
> +    /// Whether this fd should be closed when the allocation is freed.
> +    close_on_free: bool,
> +}
> +
> +pub(crate) struct TranslatedFds {
> +    reservations: KVec<Reservation>,
> +    /// If commit is called, then these fds should be closed. (If commit is not called, then they
> +    /// shouldn't be closed.)
> +    close_on_free: FdsCloseOnFree,
> +}
> +
> +struct Reservation {
> +    res: FileDescriptorReservation,
> +    file: ARef<File>,
> +}
> +
> +impl TranslatedFds {
> +    pub(crate) fn new() -> Self {
> +        Self {
> +            reservations: KVec::new(),
> +            close_on_free: FdsCloseOnFree(KVec::new()),
> +        }
> +    }
> +
> +    pub(crate) fn commit(self) -> FdsCloseOnFree {
> +        for entry in self.reservations {
> +            entry.res.fd_install(entry.file);
> +        }
> +
> +        self.close_on_free
> +    }
> +}
> +
> +pub(crate) struct FdsCloseOnFree(KVec<u32>);
> diff --git a/drivers/android/binder/context.rs b/drivers/android/binder/context.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..3d135ec03ca74d7dd6f3d67807375eadd4f70fe8
> --- /dev/null
> +++ b/drivers/android/binder/context.rs
> @@ -0,0 +1,180 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2025 Google LLC.
> +
> +use kernel::{
> +    error::Error,
> +    list::{List, ListArc, ListLinks},
> +    prelude::*,
> +    security,
> +    str::{CStr, CString},
> +    sync::{Arc, Mutex},
> +    task::Kuid,
> +};
> +
> +use crate::{error::BinderError, node::NodeRef, process::Process};
> +
> +kernel::sync::global_lock! {
> +    // SAFETY: We call `init` in the module initializer, so it's initialized before first use.
> +    pub(crate) unsafe(uninit) static CONTEXTS: Mutex<ContextList> = ContextList {
> +        list: List::new(),
> +    };
> +}
> +
> +pub(crate) struct ContextList {
> +    list: List<Context>,
> +}
> +
> +pub(crate) fn get_all_contexts() -> Result<KVec<Arc<Context>>> {
> +    let lock = CONTEXTS.lock();
> +
> +    let count = lock.list.iter().count();
> +
> +    let mut ctxs = KVec::with_capacity(count, GFP_KERNEL)?;
> +    for ctx in &lock.list {
> +        ctxs.push(Arc::from(ctx), GFP_KERNEL)?;
> +    }
> +    Ok(ctxs)
> +}
> +
> +/// This struct keeps track of the processes using this context, and which process is the context
> +/// manager.
> +struct Manager {
> +    node: Option<NodeRef>,
> +    uid: Option<Kuid>,
> +    all_procs: List<Process>,
> +}
> +
> +/// There is one context per binder file (/dev/binder, /dev/hwbinder, etc)
> +#[pin_data]
> +pub(crate) struct Context {
> +    #[pin]
> +    manager: Mutex<Manager>,
> +    pub(crate) name: CString,
> +    #[pin]
> +    links: ListLinks,
> +}
> +
> +kernel::list::impl_list_arc_safe! {
> +    impl ListArcSafe<0> for Context { untracked; }
> +}
> +kernel::list::impl_list_item! {
> +    impl ListItem<0> for Context {
> +        using ListLinks { self.links };
> +    }
> +}
> +
> +impl Context {
> +    pub(crate) fn new(name: &CStr) -> Result<Arc<Self>> {
> +        let name = CString::try_from(name)?;
> +        let list_ctx = ListArc::pin_init::<Error>(
> +            try_pin_init!(Context {
> +                name,
> +                links <- ListLinks::new(),
> +                manager <- kernel::new_mutex!(Manager {
> +                    all_procs: List::new(),
> +                    node: None,
> +                    uid: None,
> +                }, "Context::manager"),
> +            }),
> +            GFP_KERNEL,
> +        )?;
> +
> +        let ctx = list_ctx.clone_arc();
> +        CONTEXTS.lock().list.push_back(list_ctx);
> +
> +        Ok(ctx)
> +    }
> +
> +    /// Called when the file for this context is unlinked.
> +    ///
> +    /// No-op if called twice.
> +    pub(crate) fn deregister(&self) {
> +        // SAFETY: We never add the context to any other linked list than this one, so it is either
> +        // in this list, or not in any list.
> +        unsafe { CONTEXTS.lock().list.remove(self) };
> +    }
> +
> +    pub(crate) fn register_process(self: &Arc<Self>, proc: ListArc<Process>) {
> +        if !Arc::ptr_eq(self, &proc.ctx) {
> +            pr_err!("Context::register_process called on the wrong context.");
> +            return;
> +        }
> +        self.manager.lock().all_procs.push_back(proc);
> +    }
> +
> +    pub(crate) fn deregister_process(self: &Arc<Self>, proc: &Process) {
> +        if !Arc::ptr_eq(self, &proc.ctx) {
> +            pr_err!("Context::deregister_process called on the wrong context.");
> +            return;
> +        }
> +        // SAFETY: We just checked that this is the right list.
> +        unsafe { self.manager.lock().all_procs.remove(proc) };
> +    }
> +
> +    pub(crate) fn set_manager_node(&self, node_ref: NodeRef) -> Result {
> +        let mut manager = self.manager.lock();
> +        if manager.node.is_some() {
> +            pr_warn!("BINDER_SET_CONTEXT_MGR already set");
> +            return Err(EBUSY);
> +        }
> +        security::binder_set_context_mgr(&node_ref.node.owner.cred)?;
> +
> +        // If the context manager has been set before, ensure that we use the same euid.
> +        let caller_uid = Kuid::current_euid();
> +        if let Some(ref uid) = manager.uid {
> +            if *uid != caller_uid {
> +                return Err(EPERM);
> +            }
> +        }
> +
> +        manager.node = Some(node_ref);
> +        manager.uid = Some(caller_uid);
> +        Ok(())
> +    }
> +
> +    pub(crate) fn unset_manager_node(&self) {
> +        let node_ref = self.manager.lock().node.take();
> +        drop(node_ref);
> +    }
> +
> +    pub(crate) fn get_manager_node(&self, strong: bool) -> Result<NodeRef, BinderError> {
> +        self.manager
> +            .lock()
> +            .node
> +            .as_ref()
> +            .ok_or_else(BinderError::new_dead)?
> +            .clone(strong)
> +            .map_err(BinderError::from)
> +    }
> +
> +    pub(crate) fn for_each_proc<F>(&self, mut func: F)
> +    where
> +        F: FnMut(&Process),
> +    {
> +        let lock = self.manager.lock();
> +        for proc in &lock.all_procs {
> +            func(&proc);
> +        }
> +    }
> +
> +    pub(crate) fn get_all_procs(&self) -> Result<KVec<Arc<Process>>> {
> +        let lock = self.manager.lock();
> +        let count = lock.all_procs.iter().count();
> +
> +        let mut procs = KVec::with_capacity(count, GFP_KERNEL)?;
> +        for proc in &lock.all_procs {
> +            procs.push(Arc::from(proc), GFP_KERNEL)?;
> +        }
> +        Ok(procs)
> +    }
> +
> +    pub(crate) fn get_procs_with_pid(&self, pid: i32) -> Result<KVec<Arc<Process>>> {
> +        let orig = self.get_all_procs()?;
> +        let mut backing = KVec::with_capacity(orig.len(), GFP_KERNEL)?;
> +        for proc in orig.into_iter().filter(|proc| proc.task.pid() == pid) {
> +            backing.push(proc, GFP_KERNEL)?;
> +        }
> +        Ok(backing)
> +    }
> +}
> diff --git a/drivers/android/binder/deferred_close.rs b/drivers/android/binder/deferred_close.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..ac895c04d0cb7e867a36ba583facdecef10ca224
> --- /dev/null
> +++ b/drivers/android/binder/deferred_close.rs
> @@ -0,0 +1,204 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2025 Google LLC.
> +
> +//! Logic for closing files in a deferred manner.
> +//!
> +//! This file could make sense to have in `kernel::fs`, but it was rejected for being too
> +//! Binder-specific.
> +
> +use core::mem::MaybeUninit;
> +use kernel::{
> +    alloc::{AllocError, Flags},
> +    bindings,
> +    prelude::*,
> +};
> +
> +/// Helper used for closing file descriptors in a way that is safe even if the file is currently
> +/// held using `fdget`.
> +///
> +/// Additional motivation can be found in commit 80cd795630d6 ("binder: fix use-after-free due to
> +/// ksys_close() during fdget()") and in the comments on `binder_do_fd_close`.
> +pub(crate) struct DeferredFdCloser {
> +    inner: KBox<DeferredFdCloserInner>,
> +}
> +
> +/// SAFETY: This just holds an allocation with no real content, so there's no safety issue with
> +/// moving it across threads.
> +unsafe impl Send for DeferredFdCloser {}
> +/// SAFETY: This just holds an allocation with no real content, so there's no safety issue with
> +/// moving it across threads.
> +unsafe impl Sync for DeferredFdCloser {}
> +
> +/// # Invariants
> +///
> +/// If the `file` pointer is non-null, then it points at a `struct file` and owns a refcount to
> +/// that file.
> +#[repr(C)]
> +struct DeferredFdCloserInner {
> +    twork: MaybeUninit<bindings::callback_head>,
> +    file: *mut bindings::file,
> +}
> +
> +impl DeferredFdCloser {
> +    /// Create a new [`DeferredFdCloser`].
> +    pub(crate) fn new(flags: Flags) -> Result<Self, AllocError> {
> +        Ok(Self {
> +            // INVARIANT: The `file` pointer is null, so the type invariant does not apply.
> +            inner: KBox::new(
> +                DeferredFdCloserInner {
> +                    twork: MaybeUninit::uninit(),
> +                    file: core::ptr::null_mut(),
> +                },
> +                flags,
> +            )?,
> +        })
> +    }
> +
> +    /// Schedule a task work that closes the file descriptor when this task returns to userspace.
> +    ///
> +    /// Fails if this is called from a context where we cannot run work when returning to
> +    /// userspace. (E.g., from a kthread.)
> +    pub(crate) fn close_fd(self, fd: u32) -> Result<(), DeferredFdCloseError> {
> +        use bindings::task_work_notify_mode_TWA_RESUME as TWA_RESUME;
> +
> +        // In this method, we schedule the task work before closing the file. This is because
> +        // scheduling a task work is fallible, and we need to know whether it will fail before we
> +        // attempt to close the file.
> +
> +        // Task works are not available on kthreads.
> +        let current = kernel::current!();
> +
> +        // Check if this is a kthread.
> +        // SAFETY: Reading `flags` from a task is always okay.
> +        if unsafe { ((*current.as_ptr()).flags & bindings::PF_KTHREAD) != 0 } {
> +            return Err(DeferredFdCloseError::TaskWorkUnavailable);
> +        }
> +
> +        // Transfer ownership of the box's allocation to a raw pointer. This disables the
> +        // destructor, so we must manually convert it back to a KBox to drop it.
> +        //
> +        // Until we convert it back to a `KBox`, there are no aliasing requirements on this
> +        // pointer.
> +        let inner = KBox::into_raw(self.inner);
> +
> +        // The `callback_head` field is first in the struct, so this cast correctly gives us a
> +        // pointer to the field.
> +        let callback_head = inner.cast::<bindings::callback_head>();
> +        // SAFETY: This pointer offset operation does not go out-of-bounds.
> +        let file_field = unsafe { core::ptr::addr_of_mut!((*inner).file) };
> +
> +        let current = current.as_ptr();
> +
> +        // SAFETY: This function currently has exclusive access to the `DeferredFdCloserInner`, so
> +        // it is okay for us to perform unsynchronized writes to its `callback_head` field.
> +        unsafe { bindings::init_task_work(callback_head, Some(Self::do_close_fd)) };
> +
> +        // SAFETY: This inserts the `DeferredFdCloserInner` into the task workqueue for the current
> +        // task. If this operation is successful, then this transfers exclusive ownership of the
> +        // `callback_head` field to the C side until it calls `do_close_fd`, and we don't touch or
> +        // invalidate the field during that time.
> +        //
> +        // When the C side calls `do_close_fd`, the safety requirements of that method are
> +        // satisfied because when a task work is executed, the callback is given ownership of the
> +        // pointer.
> +        //
> +        // The file pointer is currently null. If it is changed to be non-null before `do_close_fd`
> +        // is called, then that change happens due to the write at the end of this function, and
> +        // that write has a safety comment that explains why the refcount can be dropped when
> +        // `do_close_fd` runs.
> +        let res = unsafe { bindings::task_work_add(current, callback_head, TWA_RESUME) };
> +
> +        if res != 0 {
> +            // SAFETY: Scheduling the task work failed, so we still have ownership of the box, so
> +            // we may destroy it.
> +            unsafe { drop(KBox::from_raw(inner)) };
> +
> +            return Err(DeferredFdCloseError::TaskWorkUnavailable);
> +        }
> +
> +        // This removes the fd from the fd table in `current`. The file is not fully closed until
> +        // `filp_close` is called. We are given ownership of one refcount to the file.
> +        //
> +        // SAFETY: This is safe no matter what `fd` is. If the `fd` is valid (that is, if the
> +        // pointer is non-null), then we call `filp_close` on the returned pointer as required by
> +        // `file_close_fd`.
> +        let file = unsafe { bindings::file_close_fd(fd) };
> +        if file.is_null() {
> +            // We don't clean up the task work since that might be expensive if the task work queue
> +            // is long. Just let it execute and let it clean up for itself.
> +            return Err(DeferredFdCloseError::BadFd);
> +        }
> +
> +        // Acquire a second refcount to the file.
> +        //
> +        // SAFETY: The `file` pointer points at a file with a non-zero refcount.
> +        unsafe { bindings::get_file(file) };
> +
> +        // This method closes the fd, consuming one of our two refcounts. There could be active
> +        // light refcounts created from that fd, so we must ensure that the file has a positive
> +        // refcount for the duration of those active light refcounts. We do that by holding on to
> +        // the second refcount until the current task returns to userspace.
> +        //
> +        // SAFETY: The `file` pointer is valid. Passing `current->files` as the file table to close
> +        // it in is correct, since we just got the `fd` from `file_close_fd` which also uses
> +        // `current->files`.
> +        //
> +        // Note: fl_owner_t is currently a void pointer.
> +        unsafe { bindings::filp_close(file, (*current).files as bindings::fl_owner_t) };
> +
> +        // We update the file pointer that the task work is supposed to fput. This transfers
> +        // ownership of our last refcount.
> +        //
> +        // INVARIANT: This changes the `file` field of a `DeferredFdCloserInner` from null to
> +        // non-null. This doesn't break the type invariant for `DeferredFdCloserInner` because we
> +        // still own a refcount to the file, so we can pass ownership of that refcount to the
> +        // `DeferredFdCloserInner`.
> +        //
> +        // When `do_close_fd` runs, it must be safe for it to `fput` the refcount. However, this is
> +        // the case because all light refcounts that are associated with the fd we closed
> +        // previously must be dropped when `do_close_fd`, since light refcounts must be dropped
> +        // before returning to userspace.
> +        //
> +        // SAFETY: Task works are executed on the current thread right before we return to
> +        // userspace, so this write is guaranteed to happen before `do_close_fd` is called, which
> +        // means that a race is not possible here.
> +        unsafe { *file_field = file };
> +
> +        Ok(())
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// The provided pointer must point at the `twork` field of a `DeferredFdCloserInner` stored in
> +    /// a `KBox`, and the caller must pass exclusive ownership of that `KBox`. Furthermore, if the
> +    /// file pointer is non-null, then it must be okay to release the refcount by calling `fput`.
> +    unsafe extern "C" fn do_close_fd(inner: *mut bindings::callback_head) {
> +        // SAFETY: The caller just passed us ownership of this box.
> +        let inner = unsafe { KBox::from_raw(inner.cast::<DeferredFdCloserInner>()) };
> +        if !inner.file.is_null() {
> +            // SAFETY: By the type invariants, we own a refcount to this file, and the caller
> +            // guarantees that dropping the refcount now is okay.
> +            unsafe { bindings::fput(inner.file) };
> +        }
> +        // The allocation is freed when `inner` goes out of scope.
> +    }
> +}
> +
> +/// Represents a failure to close an fd in a deferred manner.
> +#[derive(Copy, Clone, Debug, Eq, PartialEq)]
> +pub(crate) enum DeferredFdCloseError {
> +    /// Closing the fd failed because we were unable to schedule a task work.
> +    TaskWorkUnavailable,
> +    /// Closing the fd failed because the fd does not exist.
> +    BadFd,
> +}
> +
> +impl From<DeferredFdCloseError> for Error {
> +    fn from(err: DeferredFdCloseError) -> Error {
> +        match err {
> +            DeferredFdCloseError::TaskWorkUnavailable => ESRCH,
> +            DeferredFdCloseError::BadFd => EBADF,
> +        }
> +    }
> +}
> diff --git a/drivers/android/binder/defs.rs b/drivers/android/binder/defs.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..33f51b4139c7e03184369dc7cd3fc8b464dee012
> --- /dev/null
> +++ b/drivers/android/binder/defs.rs
> @@ -0,0 +1,182 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2025 Google LLC.
> +
> +use core::mem::MaybeUninit;
> +use core::ops::{Deref, DerefMut};
> +use kernel::{
> +    transmute::{AsBytes, FromBytes},
> +    uapi::{self, *},
> +};
> +
> +macro_rules! pub_no_prefix {
> +    ($prefix:ident, $($newname:ident),+ $(,)?) => {
> +        $(pub(crate) const $newname: u32 = kernel::macros::concat_idents!($prefix, $newname);)+
> +    };
> +}
> +
> +pub_no_prefix!(
> +    binder_driver_return_protocol_,
> +    BR_TRANSACTION,
> +    BR_TRANSACTION_SEC_CTX,
> +    BR_REPLY,
> +    BR_DEAD_REPLY,
> +    BR_FAILED_REPLY,
> +    BR_FROZEN_REPLY,
> +    BR_NOOP,
> +    BR_SPAWN_LOOPER,
> +    BR_TRANSACTION_COMPLETE,
> +    BR_TRANSACTION_PENDING_FROZEN,
> +    BR_ONEWAY_SPAM_SUSPECT,
> +    BR_OK,
> +    BR_ERROR,
> +    BR_INCREFS,
> +    BR_ACQUIRE,
> +    BR_RELEASE,
> +    BR_DECREFS,
> +    BR_DEAD_BINDER,
> +    BR_CLEAR_DEATH_NOTIFICATION_DONE,
> +    BR_FROZEN_BINDER,
> +    BR_CLEAR_FREEZE_NOTIFICATION_DONE,
> +);
> +
> +pub_no_prefix!(
> +    binder_driver_command_protocol_,
> +    BC_TRANSACTION,
> +    BC_TRANSACTION_SG,
> +    BC_REPLY,
> +    BC_REPLY_SG,
> +    BC_FREE_BUFFER,
> +    BC_ENTER_LOOPER,
> +    BC_EXIT_LOOPER,
> +    BC_REGISTER_LOOPER,
> +    BC_INCREFS,
> +    BC_ACQUIRE,
> +    BC_RELEASE,
> +    BC_DECREFS,
> +    BC_INCREFS_DONE,
> +    BC_ACQUIRE_DONE,
> +    BC_REQUEST_DEATH_NOTIFICATION,
> +    BC_CLEAR_DEATH_NOTIFICATION,
> +    BC_DEAD_BINDER_DONE,
> +    BC_REQUEST_FREEZE_NOTIFICATION,
> +    BC_CLEAR_FREEZE_NOTIFICATION,
> +    BC_FREEZE_NOTIFICATION_DONE,
> +);
> +
> +pub_no_prefix!(
> +    flat_binder_object_flags_,
> +    FLAT_BINDER_FLAG_ACCEPTS_FDS,
> +    FLAT_BINDER_FLAG_TXN_SECURITY_CTX
> +);
> +
> +pub_no_prefix!(
> +    transaction_flags_,
> +    TF_ONE_WAY,
> +    TF_ACCEPT_FDS,
> +    TF_CLEAR_BUF,
> +    TF_UPDATE_TXN
> +);
> +
> +pub(crate) use uapi::{
> +    BINDER_TYPE_BINDER, BINDER_TYPE_FD, BINDER_TYPE_FDA, BINDER_TYPE_HANDLE, BINDER_TYPE_PTR,
> +    BINDER_TYPE_WEAK_BINDER, BINDER_TYPE_WEAK_HANDLE,
> +};
> +
> +macro_rules! decl_wrapper {
> +    ($newname:ident, $wrapped:ty) => {
> +        // Define a wrapper around the C type. Use `MaybeUninit` to enforce that the value of
> +        // padding bytes must be preserved.
> +        #[derive(Copy, Clone)]
> +        #[repr(transparent)]
> +        pub(crate) struct $newname(MaybeUninit<$wrapped>);
> +
> +        // SAFETY: This macro is only used with types where this is ok.
> +        unsafe impl FromBytes for $newname {}
> +        // SAFETY: This macro is only used with types where this is ok.
> +        unsafe impl AsBytes for $newname {}
> +
> +        impl Deref for $newname {
> +            type Target = $wrapped;
> +            fn deref(&self) -> &Self::Target {
> +                // SAFETY: We use `MaybeUninit` only to preserve padding. The value must still
> +                // always be valid.
> +                unsafe { self.0.assume_init_ref() }
> +            }
> +        }
> +
> +        impl DerefMut for $newname {
> +            fn deref_mut(&mut self) -> &mut Self::Target {
> +                // SAFETY: We use `MaybeUninit` only to preserve padding. The value must still
> +                // always be valid.
> +                unsafe { self.0.assume_init_mut() }
> +            }
> +        }
> +
> +        impl Default for $newname {
> +            fn default() -> Self {
> +                // Create a new value of this type where all bytes (including padding) are zeroed.
> +                Self(MaybeUninit::zeroed())
> +            }
> +        }
> +    };
> +}
> +
> +decl_wrapper!(BinderNodeDebugInfo, uapi::binder_node_debug_info);
> +decl_wrapper!(BinderNodeInfoForRef, uapi::binder_node_info_for_ref);
> +decl_wrapper!(FlatBinderObject, uapi::flat_binder_object);
> +decl_wrapper!(BinderFdObject, uapi::binder_fd_object);
> +decl_wrapper!(BinderFdArrayObject, uapi::binder_fd_array_object);
> +decl_wrapper!(BinderObjectHeader, uapi::binder_object_header);
> +decl_wrapper!(BinderBufferObject, uapi::binder_buffer_object);
> +decl_wrapper!(BinderTransactionData, uapi::binder_transaction_data);
> +decl_wrapper!(
> +    BinderTransactionDataSecctx,
> +    uapi::binder_transaction_data_secctx
> +);
> +decl_wrapper!(BinderTransactionDataSg, uapi::binder_transaction_data_sg);
> +decl_wrapper!(BinderWriteRead, uapi::binder_write_read);
> +decl_wrapper!(BinderVersion, uapi::binder_version);
> +decl_wrapper!(BinderFrozenStatusInfo, uapi::binder_frozen_status_info);
> +decl_wrapper!(BinderFreezeInfo, uapi::binder_freeze_info);
> +decl_wrapper!(BinderFrozenStateInfo, uapi::binder_frozen_state_info);
> +decl_wrapper!(BinderHandleCookie, uapi::binder_handle_cookie);
> +decl_wrapper!(ExtendedError, uapi::binder_extended_error);
> +
> +impl BinderVersion {
> +    pub(crate) fn current() -> Self {
> +        Self(MaybeUninit::new(uapi::binder_version {
> +            protocol_version: BINDER_CURRENT_PROTOCOL_VERSION as _,
> +        }))
> +    }
> +}
> +
> +impl BinderTransactionData {
> +    pub(crate) fn with_buffers_size(self, buffers_size: u64) -> BinderTransactionDataSg {
> +        BinderTransactionDataSg(MaybeUninit::new(uapi::binder_transaction_data_sg {
> +            transaction_data: *self,
> +            buffers_size,
> +        }))
> +    }
> +}
> +
> +impl BinderTransactionDataSecctx {
> +    /// View the inner data as wrapped in `BinderTransactionData`.
> +    pub(crate) fn tr_data(&mut self) -> &mut BinderTransactionData {
> +        // SAFETY: Transparent wrapper is safe to transmute.
> +        unsafe {
> +            &mut *(&mut self.transaction_data as *mut uapi::binder_transaction_data
> +                as *mut BinderTransactionData)
> +        }
> +    }
> +}
> +
> +impl ExtendedError {
> +    pub(crate) fn new(id: u32, command: u32, param: i32) -> Self {
> +        Self(MaybeUninit::new(uapi::binder_extended_error {
> +            id,
> +            command,
> +            param,
> +        }))
> +    }
> +}
> diff --git a/drivers/android/binder/dummy.c b/drivers/android/binder/dummy.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..7e9f6ea3a474b59f11e723a709c0c21e8b8beae0
> --- /dev/null
> +++ b/drivers/android/binder/dummy.c

This dummy should be removed, we aren't going to need it here right?

> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +
> +static int __init rbd_init(void)
> +{
> +	pr_warn("Using Rust Binder dummy module");
> +	return 0;
> +}
> +
> +module_init(rbd_init);
> +MODULE_DESCRIPTION("Dummy Rust Binder module");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Alice Ryhl <aliceryhl@google.com>");
> diff --git a/drivers/android/binder/error.rs b/drivers/android/binder/error.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..9921827267d0d679f5aebb586ecf190efe7c6405
> --- /dev/null
> +++ b/drivers/android/binder/error.rs
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2025 Google LLC.
> +
> +use kernel::prelude::*;
> +
> +use crate::defs::*;
> +
> +pub(crate) type BinderResult<T = ()> = core::result::Result<T, BinderError>;
> +
> +/// An error that will be returned to userspace via the `BINDER_WRITE_READ` ioctl rather than via
> +/// errno.
> +pub(crate) struct BinderError {
> +    pub(crate) reply: u32,
> +    source: Option<Error>,
> +}
> +
> +impl BinderError {
> +    pub(crate) fn new_dead() -> Self {
> +        Self {
> +            reply: BR_DEAD_REPLY,
> +            source: None,
> +        }
> +    }
> +
> +    pub(crate) fn new_frozen() -> Self {
> +        Self {
> +            reply: BR_FROZEN_REPLY,
> +            source: None,
> +        }
> +    }
> +
> +    pub(crate) fn new_frozen_oneway() -> Self {
> +        Self {
> +            reply: BR_TRANSACTION_PENDING_FROZEN,
> +            source: None,
> +        }
> +    }
> +
> +    pub(crate) fn is_dead(&self) -> bool {
> +        self.reply == BR_DEAD_REPLY
> +    }
> +
> +    pub(crate) fn as_errno(&self) -> kernel::ffi::c_int {
> +        self.source.unwrap_or(EINVAL).to_errno()
> +    }
> +
> +    pub(crate) fn should_pr_warn(&self) -> bool {
> +        self.source.is_some()
> +    }
> +}
> +
> +/// Convert an errno into a `BinderError` and store the errno used to construct it. The errno
> +/// should be stored as the thread's extended error when given to userspace.
> +impl From<Error> for BinderError {
> +    fn from(source: Error) -> Self {
> +        Self {
> +            reply: BR_FAILED_REPLY,
> +            source: Some(source),
> +        }
> +    }
> +}
> +
> +impl From<kernel::fs::file::BadFdError> for BinderError {
> +    fn from(source: kernel::fs::file::BadFdError) -> Self {
> +        BinderError::from(Error::from(source))
> +    }
> +}
> +
> +impl From<kernel::alloc::AllocError> for BinderError {
> +    fn from(_: kernel::alloc::AllocError) -> Self {
> +        Self {
> +            reply: BR_FAILED_REPLY,
> +            source: Some(ENOMEM),
> +        }
> +    }
> +}
> +
> +impl core::fmt::Debug for BinderError {
> +    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
> +        match self.reply {
> +            BR_FAILED_REPLY => match self.source.as_ref() {
> +                Some(source) => f
> +                    .debug_struct("BR_FAILED_REPLY")
> +                    .field("source", source)
> +                    .finish(),
> +                None => f.pad("BR_FAILED_REPLY"),
> +            },
> +            BR_DEAD_REPLY => f.pad("BR_DEAD_REPLY"),
> +            BR_FROZEN_REPLY => f.pad("BR_FROZEN_REPLY"),
> +            BR_TRANSACTION_PENDING_FROZEN => f.pad("BR_TRANSACTION_PENDING_FROZEN"),
> +            BR_TRANSACTION_COMPLETE => f.pad("BR_TRANSACTION_COMPLETE"),
> +            _ => f
> +                .debug_struct("BinderError")
> +                .field("reply", &self.reply)
> +                .finish(),
> +        }
> +    }
> +}
> diff --git a/drivers/android/binder/freeze.rs b/drivers/android/binder/freeze.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..e68c3c8bc55a203c32261c23915d8c427569e3b0
> --- /dev/null
> +++ b/drivers/android/binder/freeze.rs
> @@ -0,0 +1,388 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2025 Google LLC.
> +
> +use kernel::{
> +    alloc::AllocError,
> +    list::ListArc,
> +    prelude::*,
> +    rbtree::{self, RBTreeNodeReservation},
> +    seq_file::SeqFile,
> +    seq_print,
> +    sync::{Arc, UniqueArc},
> +    uaccess::UserSliceReader,
> +};
> +
> +use crate::{
> +    defs::*, node::Node, process::Process, thread::Thread, BinderReturnWriter, DArc, DLArc,
> +    DTRWrap, DeliverToRead,
> +};
> +
> +#[derive(Clone, Copy, Eq, PartialEq, Ord, PartialOrd)]
> +pub(crate) struct FreezeCookie(u64);
> +
> +/// Represents a listener for changes to the frozen state of a process.
> +pub(crate) struct FreezeListener {
> +    /// The node we are listening for.
> +    pub(crate) node: DArc<Node>,
> +    /// The cookie of this freeze listener.
> +    cookie: FreezeCookie,
> +    /// What value of `is_frozen` did we most recently tell userspace about?
> +    last_is_frozen: Option<bool>,
> +    /// We sent a `BR_FROZEN_BINDER` and we are waiting for `BC_FREEZE_NOTIFICATION_DONE` before
> +    /// sending any other commands.
> +    is_pending: bool,
> +    /// Userspace sent `BC_CLEAR_FREEZE_NOTIFICATION` and we need to reply with
> +    /// `BR_CLEAR_FREEZE_NOTIFICATION_DONE` as soon as possible. If `is_pending` is set, then we
> +    /// must wait for it to be unset before we can reply.
> +    is_clearing: bool,
> +    /// Number of cleared duplicates that can't be deleted until userspace sends
> +    /// `BC_FREEZE_NOTIFICATION_DONE`.
> +    num_pending_duplicates: u64,
> +    /// Number of cleared duplicates that can be deleted.
> +    num_cleared_duplicates: u64,
> +}
> +
> +impl FreezeListener {
> +    /// Is it okay to create a new listener with the same cookie as this one for the provided node?
> +    ///
> +    /// Under some scenarios, userspace may delete a freeze listener and immediately recreate it
> +    /// with the same cookie. This results in duplicate listeners. To avoid issues with ambiguity,
> +    /// we allow this only if the new listener is for the same node, and we also require that the
> +    /// old listener has already been cleared.
> +    fn allow_duplicate(&self, node: &DArc<Node>) -> bool {
> +        Arc::ptr_eq(&self.node, node) && self.is_clearing
> +    }
> +}
> +
> +type UninitFM = UniqueArc<core::mem::MaybeUninit<DTRWrap<FreezeMessage>>>;
> +
> +/// Represents a notification that the freeze state has changed.
> +pub(crate) struct FreezeMessage {
> +    cookie: FreezeCookie,
> +}
> +
> +kernel::list::impl_list_arc_safe! {
> +    impl ListArcSafe<0> for FreezeMessage {
> +        untracked;
> +    }
> +}
> +
> +impl FreezeMessage {
> +    fn new(flags: kernel::alloc::Flags) -> Result<UninitFM, AllocError> {
> +        UniqueArc::new_uninit(flags)
> +    }
> +
> +    fn init(ua: UninitFM, cookie: FreezeCookie) -> DLArc<FreezeMessage> {
> +        match ua.pin_init_with(DTRWrap::new(FreezeMessage { cookie })) {
> +            Ok(msg) => ListArc::from(msg),
> +            Err(err) => match err {},
> +        }
> +    }
> +}
> +
> +impl DeliverToRead for FreezeMessage {
> +    fn do_work(
> +        self: DArc<Self>,
> +        thread: &Thread,
> +        writer: &mut BinderReturnWriter<'_>,
> +    ) -> Result<bool> {
> +        let _removed_listener;
> +        let mut node_refs = thread.process.node_refs.lock();
> +        let Some(mut freeze_entry) = node_refs.freeze_listeners.find_mut(&self.cookie) else {
> +            return Ok(true);
> +        };
> +        let freeze = freeze_entry.get_mut();
> +
> +        if freeze.num_cleared_duplicates > 0 {
> +            freeze.num_cleared_duplicates -= 1;
> +            drop(node_refs);
> +            writer.write_code(BR_CLEAR_FREEZE_NOTIFICATION_DONE)?;
> +            writer.write_payload(&self.cookie.0)?;
> +            return Ok(true);
> +        }
> +
> +        if freeze.is_pending {
> +            return Ok(true);
> +        }
> +        if freeze.is_clearing {
> +            _removed_listener = freeze_entry.remove_node();
> +            drop(node_refs);
> +            writer.write_code(BR_CLEAR_FREEZE_NOTIFICATION_DONE)?;
> +            writer.write_payload(&self.cookie.0)?;
> +            Ok(true)
> +        } else {
> +            let is_frozen = freeze.node.owner.inner.lock().is_frozen;
> +            if freeze.last_is_frozen == Some(is_frozen) {
> +                return Ok(true);
> +            }
> +
> +            let mut state_info = BinderFrozenStateInfo::default();
> +            state_info.is_frozen = is_frozen as u32;
> +            state_info.cookie = freeze.cookie.0;
> +            freeze.is_pending = true;
> +            freeze.last_is_frozen = Some(is_frozen);
> +            drop(node_refs);
> +
> +            writer.write_code(BR_FROZEN_BINDER)?;
> +            writer.write_payload(&state_info)?;
> +            // BR_FROZEN_BINDER notifications can cause transactions
> +            Ok(false)
> +        }
> +    }
> +
> +    fn cancel(self: DArc<Self>) {}
> +
> +    fn should_sync_wakeup(&self) -> bool {
> +        false
> +    }
> +
> +    #[inline(never)]
> +    fn debug_print(&self, m: &SeqFile, prefix: &str, _tprefix: &str) -> Result<()> {
> +        seq_print!(m, "{}has frozen binder\n", prefix);
> +        Ok(())
> +    }
> +}
> +
> +impl FreezeListener {
> +    pub(crate) fn on_process_exit(&self, proc: &Arc<Process>) {
> +        if !self.is_clearing {
> +            self.node.remove_freeze_listener(proc);
> +        }
> +    }
> +}
> +
> +impl Process {
> +    pub(crate) fn request_freeze_notif(
> +        self: &Arc<Self>,
> +        reader: &mut UserSliceReader,
> +    ) -> Result<()> {
> +        let hc = reader.read::<BinderHandleCookie>()?;
> +        let handle = hc.handle;
> +        let cookie = FreezeCookie(hc.cookie);
> +
> +        let msg = FreezeMessage::new(GFP_KERNEL)?;
> +        let alloc = RBTreeNodeReservation::new(GFP_KERNEL)?;
> +
> +        let mut node_refs_guard = self.node_refs.lock();
> +        let node_refs = &mut *node_refs_guard;
> +        let Some(info) = node_refs.by_handle.get_mut(&handle) else {
> +            pr_warn!("BC_REQUEST_FREEZE_NOTIFICATION invalid ref {}\n", handle);
> +            return Err(EINVAL);
> +        };
> +        if info.freeze().is_some() {
> +            pr_warn!("BC_REQUEST_FREEZE_NOTIFICATION already set\n");
> +            return Err(EINVAL);
> +        }
> +        let node_ref = info.node_ref();
> +        let freeze_entry = node_refs.freeze_listeners.entry(cookie);
> +
> +        if let rbtree::Entry::Occupied(ref dupe) = freeze_entry {
> +            if !dupe.get().allow_duplicate(&node_ref.node) {
> +                pr_warn!("BC_REQUEST_FREEZE_NOTIFICATION duplicate cookie\n");
> +                return Err(EINVAL);
> +            }
> +        }
> +
> +        // All failure paths must come before this call, and all modifications must come after this
> +        // call.
> +        node_ref.node.add_freeze_listener(self, GFP_KERNEL)?;
> +
> +        match freeze_entry {
> +            rbtree::Entry::Vacant(entry) => {
> +                entry.insert(
> +                    FreezeListener {
> +                        cookie,
> +                        node: node_ref.node.clone(),
> +                        last_is_frozen: None,
> +                        is_pending: false,
> +                        is_clearing: false,
> +                        num_pending_duplicates: 0,
> +                        num_cleared_duplicates: 0,
> +                    },
> +                    alloc,
> +                );
> +            }
> +            rbtree::Entry::Occupied(mut dupe) => {
> +                let dupe = dupe.get_mut();
> +                if dupe.is_pending {
> +                    dupe.num_pending_duplicates += 1;
> +                } else {
> +                    dupe.num_cleared_duplicates += 1;
> +                }
> +                dupe.last_is_frozen = None;
> +                dupe.is_pending = false;
> +                dupe.is_clearing = false;
> +            }
> +        }
> +
> +        *info.freeze() = Some(cookie);
> +        let msg = FreezeMessage::init(msg, cookie);
> +        drop(node_refs_guard);
> +        let _ = self.push_work(msg);
> +        Ok(())
> +    }
> +
> +    pub(crate) fn freeze_notif_done(self: &Arc<Self>, reader: &mut UserSliceReader) -> Result<()> {
> +        let cookie = FreezeCookie(reader.read()?);
> +        let alloc = FreezeMessage::new(GFP_KERNEL)?;
> +        let mut node_refs_guard = self.node_refs.lock();
> +        let node_refs = &mut *node_refs_guard;
> +        let Some(freeze) = node_refs.freeze_listeners.get_mut(&cookie) else {
> +            pr_warn!("BC_FREEZE_NOTIFICATION_DONE {:016x} not found\n", cookie.0);
> +            return Err(EINVAL);
> +        };
> +        let mut clear_msg = None;
> +        if freeze.num_pending_duplicates > 0 {
> +            clear_msg = Some(FreezeMessage::init(alloc, cookie));
> +            freeze.num_pending_duplicates -= 1;
> +            freeze.num_cleared_duplicates += 1;
> +        } else {
> +            if !freeze.is_pending {
> +                pr_warn!(
> +                    "BC_FREEZE_NOTIFICATION_DONE {:016x} not pending\n",
> +                    cookie.0
> +                );
> +                return Err(EINVAL);
> +            }
> +            if freeze.is_clearing {
> +                // Immediately send another FreezeMessage for BR_CLEAR_FREEZE_NOTIFICATION_DONE.
> +                clear_msg = Some(FreezeMessage::init(alloc, cookie));
> +            }
> +            freeze.is_pending = false;
> +        }
> +        drop(node_refs_guard);
> +        if let Some(clear_msg) = clear_msg {
> +            let _ = self.push_work(clear_msg);
> +        }
> +        Ok(())
> +    }
> +
> +    pub(crate) fn clear_freeze_notif(self: &Arc<Self>, reader: &mut UserSliceReader) -> Result<()> {
> +        let hc = reader.read::<BinderHandleCookie>()?;
> +        let handle = hc.handle;
> +        let cookie = FreezeCookie(hc.cookie);
> +
> +        let alloc = FreezeMessage::new(GFP_KERNEL)?;
> +        let mut node_refs_guard = self.node_refs.lock();
> +        let node_refs = &mut *node_refs_guard;
> +        let Some(info) = node_refs.by_handle.get_mut(&handle) else {
> +            pr_warn!("BC_CLEAR_FREEZE_NOTIFICATION invalid ref {}\n", handle);
> +            return Err(EINVAL);
> +        };
> +        let Some(info_cookie) = info.freeze() else {
> +            pr_warn!("BC_CLEAR_FREEZE_NOTIFICATION freeze notification not active\n");
> +            return Err(EINVAL);
> +        };
> +        if *info_cookie != cookie {
> +            pr_warn!("BC_CLEAR_FREEZE_NOTIFICATION freeze notification cookie mismatch\n");
> +            return Err(EINVAL);
> +        }
> +        let Some(listener) = node_refs.freeze_listeners.get_mut(&cookie) else {
> +            pr_warn!("BC_CLEAR_FREEZE_NOTIFICATION invalid cookie {}\n", handle);
> +            return Err(EINVAL);
> +        };
> +        listener.is_clearing = true;
> +        listener.node.remove_freeze_listener(self);
> +        *info.freeze() = None;
> +        let mut msg = None;
> +        if !listener.is_pending {
> +            msg = Some(FreezeMessage::init(alloc, cookie));
> +        }
> +        drop(node_refs_guard);
> +
> +        if let Some(msg) = msg {
> +            let _ = self.push_work(msg);
> +        }
> +        Ok(())
> +    }
> +
> +    fn get_freeze_cookie(&self, node: &DArc<Node>) -> Option<FreezeCookie> {
> +        let node_refs = &mut *self.node_refs.lock();
> +        let handle = node_refs.by_node.get(&node.global_id())?;
> +        let node_ref = node_refs.by_handle.get_mut(handle)?;
> +        *node_ref.freeze()
> +    }
> +
> +    /// Creates a vector of every freeze listener on this process.
> +    ///
> +    /// Returns pairs of the remote process listening for notifications and the local node it is
> +    /// listening on.
> +    #[expect(clippy::type_complexity)]
> +    fn find_freeze_recipients(&self) -> Result<KVVec<(DArc<Node>, Arc<Process>)>, AllocError> {
> +        // Defined before `inner` to drop after releasing spinlock if `push_within_capacity` fails.
> +        let mut node_proc_pair;
> +
> +        // We pre-allocate space for up to 8 recipients before we take the spinlock. However, if
> +        // the allocation fails, use a vector with a capacity of zero instead of failing. After
> +        // all, there might not be any freeze listeners, in which case this operation could still
> +        // succeed.
> +        let mut recipients =
> +            KVVec::with_capacity(8, GFP_KERNEL).unwrap_or_else(|_err| KVVec::new());
> +
> +        let mut inner = self.lock_with_nodes();
> +        let mut curr = inner.nodes.cursor_front();
> +        while let Some(cursor) = curr {
> +            let (key, node) = cursor.current();
> +            let key = *key;
> +            let list = node.freeze_list(&inner.inner);
> +            let len = list.len();
> +
> +            if recipients.spare_capacity_mut().len() < len {
> +                drop(inner);
> +                recipients.reserve(len, GFP_KERNEL)?;
> +                inner = self.lock_with_nodes();
> +                // Find the node we were looking at and try again. If the set of nodes was changed,
> +                // then just proceed to the next node. This is ok because we don't guarantee the
> +                // inclusion of nodes that are added or removed in parallel with this operation.
> +                curr = inner.nodes.cursor_lower_bound(&key);
> +                continue;
> +            }
> +
> +            for proc in list {
> +                node_proc_pair = (node.clone(), proc.clone());
> +                recipients
> +                    .push_within_capacity(node_proc_pair)
> +                    .map_err(|_| {
> +                        pr_err!(
> +                            "push_within_capacity failed even though we checked the capacity\n"
> +                        );
> +                        AllocError
> +                    })?;
> +            }
> +
> +            curr = cursor.move_next();
> +        }
> +        Ok(recipients)
> +    }
> +
> +    /// Prepare allocations for sending freeze messages.
> +    pub(crate) fn prepare_freeze_messages(&self) -> Result<FreezeMessages, AllocError> {
> +        let recipients = self.find_freeze_recipients()?;
> +        let mut batch = KVVec::with_capacity(recipients.len(), GFP_KERNEL)?;
> +        for (node, proc) in recipients {
> +            let Some(cookie) = proc.get_freeze_cookie(&node) else {
> +                // If the freeze listener was removed in the meantime, just discard the
> +                // notification.
> +                continue;
> +            };
> +            let msg_alloc = FreezeMessage::new(GFP_KERNEL)?;
> +            let msg = FreezeMessage::init(msg_alloc, cookie);
> +            batch.push((proc, msg), GFP_KERNEL)?;
> +        }
> +
> +        Ok(FreezeMessages { batch })
> +    }
> +}
> +
> +pub(crate) struct FreezeMessages {
> +    batch: KVVec<(Arc<Process>, DLArc<FreezeMessage>)>,
> +}
> +
> +impl FreezeMessages {
> +    pub(crate) fn send_messages(self) {
> +        for (proc, msg) in self.batch {
> +            let _ = proc.push_work(msg);
> +        }
> +    }
> +}
> diff --git a/drivers/android/binder/node.rs b/drivers/android/binder/node.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..ade895ef791ec5746f9f5c1bfc15f47d59829455
> --- /dev/null
> +++ b/drivers/android/binder/node.rs
> @@ -0,0 +1,1131 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2025 Google LLC.
> +
> +use kernel::{
> +    list::{AtomicTracker, List, ListArc, ListLinks, TryNewListArc},
> +    prelude::*,
> +    seq_file::SeqFile,
> +    seq_print,
> +    sync::lock::{spinlock::SpinLockBackend, Guard},
> +    sync::{Arc, LockedBy, SpinLock},
> +};
> +
> +use crate::{
> +    defs::*,
> +    error::BinderError,
> +    process::{NodeRefInfo, Process, ProcessInner},
> +    thread::Thread,
> +    transaction::Transaction,
> +    BinderReturnWriter, DArc, DLArc, DTRWrap, DeliverToRead,
> +};
> +
> +use core::mem;
> +
> +mod wrapper;
> +pub(crate) use self::wrapper::CritIncrWrapper;
> +
> +#[derive(Debug)]
> +pub(crate) struct CouldNotDeliverCriticalIncrement;
> +
> +/// Keeps track of how this node is scheduled.
> +///
> +/// There are two ways to schedule a node to a work list. Just schedule the node itself, or
> +/// allocate a wrapper that references the node and schedule the wrapper. These wrappers exists to
> +/// make it possible to "move" a node from one list to another - when `do_work` is called directly
> +/// on the `Node`, then it's a no-op if there's also a pending wrapper.
> +///
> +/// Wrappers are generally only needed for zero-to-one refcount increments, and there are two cases
> +/// of this: weak increments and strong increments. We call such increments "critical" because it
> +/// is critical that they are delivered to the thread doing the increment. Some examples:
> +///
> +/// * One thread makes a zero-to-one strong increment, and another thread makes a zero-to-one weak
> +///   increment. Delivering the node to the thread doing the weak increment is wrong, since the
> +///   thread doing the strong increment may have ended a long time ago when the command is actually
> +///   processed by userspace.
> +///
> +/// * We have a weak reference and are about to drop it on one thread. But then another thread does
> +///   a zero-to-one strong increment. If the strong increment gets sent to the thread that was
> +///   about to drop the weak reference, then the strong increment could be processed after the
> +///   other thread has already exited, which would be too late.
> +///
> +/// Note that trying to create a `ListArc` to the node can succeed even if `has_normal_push` is
> +/// set. This is because another thread might just have popped the node from a todo list, but not
> +/// yet called `do_work`. However, if `has_normal_push` is false, then creating a `ListArc` should
> +/// always succeed.
> +///
> +/// Like the other fields in `NodeInner`, the delivery state is protected by the process lock.
> +struct DeliveryState {
> +    /// Is the `Node` currently scheduled?
> +    has_pushed_node: bool,
> +
> +    /// Is a wrapper currently scheduled?
> +    ///
> +    /// The wrapper is used only for strong zero2one increments.
> +    has_pushed_wrapper: bool,
> +
> +    /// Is the currently scheduled `Node` scheduled due to a weak zero2one increment?
> +    ///
> +    /// Weak zero2one operations are always scheduled using the `Node`.
> +    has_weak_zero2one: bool,
> +
> +    /// Is the currently scheduled wrapper/`Node` scheduled due to a strong zero2one increment?
> +    ///
> +    /// If `has_pushed_wrapper` is set, then the strong zero2one increment was scheduled using the
> +    /// wrapper. Otherwise, `has_pushed_node` must be set and it was scheduled using the `Node`.
> +    has_strong_zero2one: bool,
> +}
> +
> +impl DeliveryState {
> +    fn should_normal_push(&self) -> bool {
> +        !self.has_pushed_node && !self.has_pushed_wrapper
> +    }
> +
> +    fn did_normal_push(&mut self) {
> +        assert!(self.should_normal_push());
> +        self.has_pushed_node = true;
> +    }
> +
> +    fn should_push_weak_zero2one(&self) -> bool {
> +        !self.has_weak_zero2one && !self.has_strong_zero2one
> +    }
> +
> +    fn can_push_weak_zero2one_normally(&self) -> bool {
> +        !self.has_pushed_node
> +    }
> +
> +    fn did_push_weak_zero2one(&mut self) {
> +        assert!(self.should_push_weak_zero2one());
> +        assert!(self.can_push_weak_zero2one_normally());
> +        self.has_pushed_node = true;
> +        self.has_weak_zero2one = true;
> +    }
> +
> +    fn should_push_strong_zero2one(&self) -> bool {
> +        !self.has_strong_zero2one
> +    }
> +
> +    fn can_push_strong_zero2one_normally(&self) -> bool {
> +        !self.has_pushed_node
> +    }
> +
> +    fn did_push_strong_zero2one(&mut self) {
> +        assert!(self.should_push_strong_zero2one());
> +        assert!(self.can_push_strong_zero2one_normally());
> +        self.has_pushed_node = true;
> +        self.has_strong_zero2one = true;
> +    }
> +
> +    fn did_push_strong_zero2one_wrapper(&mut self) {
> +        assert!(self.should_push_strong_zero2one());
> +        assert!(!self.can_push_strong_zero2one_normally());
> +        self.has_pushed_wrapper = true;
> +        self.has_strong_zero2one = true;
> +    }
> +}
> +
> +struct CountState {
> +    /// The reference count.
> +    count: usize,
> +    /// Whether the process that owns this node thinks that we hold a refcount on it. (Note that
> +    /// even if count is greater than one, we only increment it once in the owning process.)
> +    has_count: bool,
> +}
> +
> +impl CountState {
> +    fn new() -> Self {
> +        Self {
> +            count: 0,
> +            has_count: false,
> +        }
> +    }
> +}
> +
> +struct NodeInner {
> +    /// Strong refcounts held on this node by `NodeRef` objects.
> +    strong: CountState,
> +    /// Weak refcounts held on this node by `NodeRef` objects.
> +    weak: CountState,
> +    delivery_state: DeliveryState,
> +    /// The binder driver guarantees that oneway transactions sent to the same node are serialized,
> +    /// that is, userspace will not be given the next one until it has finished processing the
> +    /// previous oneway transaction. This is done to avoid the case where two oneway transactions
> +    /// arrive in opposite order from the order in which they were sent. (E.g., they could be
> +    /// delivered to two different threads, which could appear as-if they were sent in opposite
> +    /// order.)
> +    ///
> +    /// To fix that, we store pending oneway transactions in a separate list in the node, and don't
> +    /// deliver the next oneway transaction until userspace signals that it has finished processing
> +    /// the previous oneway transaction by calling the `BC_FREE_BUFFER` ioctl.
> +    oneway_todo: List<DTRWrap<Transaction>>,
> +    /// Keeps track of whether this node has a pending oneway transaction.
> +    ///
> +    /// When this is true, incoming oneway transactions are stored in `oneway_todo`, instead of
> +    /// being delivered directly to the process.
> +    has_oneway_transaction: bool,
> +    /// List of processes to deliver a notification to when this node is destroyed (usually due to
> +    /// the process dying).
> +    death_list: List<DTRWrap<NodeDeath>, 1>,
> +    /// List of processes to deliver freeze notifications to.
> +    freeze_list: KVVec<Arc<Process>>,
> +    /// The number of active BR_INCREFS or BR_ACQUIRE operations. (should be maximum two)
> +    ///
> +    /// If this is non-zero, then we postpone any BR_RELEASE or BR_DECREFS notifications until the
> +    /// active operations have ended. This avoids the situation an increment and decrement get
> +    /// reordered from userspace's perspective.
> +    active_inc_refs: u8,
> +    /// List of `NodeRefInfo` objects that reference this node.
> +    refs: List<NodeRefInfo, { NodeRefInfo::LIST_NODE }>,
> +}
> +
> +#[pin_data]
> +pub(crate) struct Node {
> +    pub(crate) debug_id: usize,
> +    ptr: u64,
> +    pub(crate) cookie: u64,
> +    pub(crate) flags: u32,
> +    pub(crate) owner: Arc<Process>,
> +    inner: LockedBy<NodeInner, ProcessInner>,
> +    #[pin]
> +    links_track: AtomicTracker,
> +}
> +
> +kernel::list::impl_list_arc_safe! {
> +    impl ListArcSafe<0> for Node {
> +        tracked_by links_track: AtomicTracker;
> +    }
> +}
> +
> +// Make `oneway_todo` work.
> +kernel::list::impl_list_item! {
> +    impl ListItem<0> for DTRWrap<Transaction> {
> +        using ListLinks { self.links.inner };
> +    }
> +}
> +
> +impl Node {
> +    pub(crate) fn new(
> +        ptr: u64,
> +        cookie: u64,
> +        flags: u32,
> +        owner: Arc<Process>,
> +    ) -> impl PinInit<Self> {
> +        pin_init!(Self {
> +            inner: LockedBy::new(
> +                &owner.inner,
> +                NodeInner {
> +                    strong: CountState::new(),
> +                    weak: CountState::new(),
> +                    delivery_state: DeliveryState {
> +                        has_pushed_node: false,
> +                        has_pushed_wrapper: false,
> +                        has_weak_zero2one: false,
> +                        has_strong_zero2one: false,
> +                    },
> +                    death_list: List::new(),
> +                    oneway_todo: List::new(),
> +                    freeze_list: KVVec::new(),
> +                    has_oneway_transaction: false,
> +                    active_inc_refs: 0,
> +                    refs: List::new(),
> +                },
> +            ),
> +            debug_id: super::next_debug_id(),
> +            ptr,
> +            cookie,
> +            flags,
> +            owner,
> +            links_track <- AtomicTracker::new(),
> +        })
> +    }
> +
> +    pub(crate) fn has_oneway_transaction(&self, owner_inner: &mut ProcessInner) -> bool {
> +        let inner = self.inner.access_mut(owner_inner);
> +        inner.has_oneway_transaction
> +    }
> +
> +    #[inline(never)]
> +    pub(crate) fn full_debug_print(
> +        &self,
> +        m: &SeqFile,
> +        owner_inner: &mut ProcessInner,
> +    ) -> Result<()> {
> +        let inner = self.inner.access_mut(owner_inner);
> +        seq_print!(
> +            m,
> +            "  node {}: u{:016x} c{:016x} hs {} hw {} cs {} cw {}",
> +            self.debug_id,
> +            self.ptr,
> +            self.cookie,
> +            inner.strong.has_count,
> +            inner.weak.has_count,
> +            inner.strong.count,
> +            inner.weak.count,
> +        );
> +        if !inner.refs.is_empty() {
> +            seq_print!(m, " proc");
> +            for node_ref in &inner.refs {
> +                seq_print!(m, " {}", node_ref.process.task.pid());
> +            }
> +        }
> +        seq_print!(m, "\n");
> +        for t in &inner.oneway_todo {
> +            t.debug_print_inner(m, "    pending async transaction ");
> +        }
> +        Ok(())
> +    }
> +
> +    /// Insert the `NodeRef` into this `refs` list.
> +    ///
> +    /// # Safety
> +    ///
> +    /// It must be the case that `info.node_ref.node` is this node.
> +    pub(crate) unsafe fn insert_node_info(
> +        &self,
> +        info: ListArc<NodeRefInfo, { NodeRefInfo::LIST_NODE }>,
> +    ) {
> +        self.inner
> +            .access_mut(&mut self.owner.inner.lock())
> +            .refs
> +            .push_front(info);
> +    }
> +
> +    /// Insert the `NodeRef` into this `refs` list.
> +    ///
> +    /// # Safety
> +    ///
> +    /// It must be the case that `info.node_ref.node` is this node.
> +    pub(crate) unsafe fn remove_node_info(
> +        &self,
> +        info: &NodeRefInfo,
> +    ) -> Option<ListArc<NodeRefInfo, { NodeRefInfo::LIST_NODE }>> {
> +        // SAFETY: We always insert `NodeRefInfo` objects into the `refs` list of the node that it
> +        // references in `info.node_ref.node`. That is this node, so `info` cannot possibly be in
> +        // the `refs` list of another node.
> +        unsafe {
> +            self.inner
> +                .access_mut(&mut self.owner.inner.lock())
> +                .refs
> +                .remove(info)
> +        }
> +    }
> +
> +    /// An id that is unique across all binder nodes on the system. Used as the key in the
> +    /// `by_node` map.
> +    pub(crate) fn global_id(&self) -> usize {
> +        self as *const Node as usize
> +    }
> +
> +    pub(crate) fn get_id(&self) -> (u64, u64) {
> +        (self.ptr, self.cookie)
> +    }
> +
> +    pub(crate) fn add_death(
> +        &self,
> +        death: ListArc<DTRWrap<NodeDeath>, 1>,
> +        guard: &mut Guard<'_, ProcessInner, SpinLockBackend>,
> +    ) {
> +        self.inner.access_mut(guard).death_list.push_back(death);
> +    }
> +
> +    pub(crate) fn inc_ref_done_locked(
> +        self: &DArc<Node>,
> +        _strong: bool,
> +        owner_inner: &mut ProcessInner,
> +    ) -> Option<DLArc<Node>> {
> +        let inner = self.inner.access_mut(owner_inner);
> +        if inner.active_inc_refs == 0 {
> +            pr_err!("inc_ref_done called when no active inc_refs");
> +            return None;
> +        }
> +
> +        inner.active_inc_refs -= 1;
> +        if inner.active_inc_refs == 0 {
> +            // Having active inc_refs can inhibit dropping of ref-counts. Calculate whether we
> +            // would send a refcount decrement, and if so, tell the caller to schedule us.
> +            let strong = inner.strong.count > 0;
> +            let has_strong = inner.strong.has_count;
> +            let weak = strong || inner.weak.count > 0;
> +            let has_weak = inner.weak.has_count;
> +
> +            let should_drop_weak = !weak && has_weak;
> +            let should_drop_strong = !strong && has_strong;
> +
> +            // If we want to drop the ref-count again, tell the caller to schedule a work node for
> +            // that.
> +            let need_push = should_drop_weak || should_drop_strong;
> +
> +            if need_push && inner.delivery_state.should_normal_push() {
> +                let list_arc = ListArc::try_from_arc(self.clone()).ok().unwrap();
> +                inner.delivery_state.did_normal_push();
> +                Some(list_arc)
> +            } else {
> +                None
> +            }
> +        } else {
> +            None
> +        }
> +    }
> +
> +    pub(crate) fn update_refcount_locked(
> +        self: &DArc<Node>,
> +        inc: bool,
> +        strong: bool,
> +        count: usize,
> +        owner_inner: &mut ProcessInner,
> +    ) -> Option<DLArc<Node>> {
> +        let is_dead = owner_inner.is_dead;
> +        let inner = self.inner.access_mut(owner_inner);
> +
> +        // Get a reference to the state we'll update.
> +        let state = if strong {
> +            &mut inner.strong
> +        } else {
> +            &mut inner.weak
> +        };
> +
> +        // Update the count and determine whether we need to push work.
> +        let need_push = if inc {
> +            state.count += count;
> +            // TODO: This method shouldn't be used for zero-to-one increments.
> +            !is_dead && !state.has_count
> +        } else {
> +            if state.count < count {
> +                pr_err!("Failure: refcount underflow!");
> +                return None;
> +            }
> +            state.count -= count;
> +            !is_dead && state.count == 0 && state.has_count
> +        };
> +
> +        if need_push && inner.delivery_state.should_normal_push() {
> +            let list_arc = ListArc::try_from_arc(self.clone()).ok().unwrap();
> +            inner.delivery_state.did_normal_push();
> +            Some(list_arc)
> +        } else {
> +            None
> +        }
> +    }
> +
> +    pub(crate) fn incr_refcount_allow_zero2one(
> +        self: &DArc<Self>,
> +        strong: bool,
> +        owner_inner: &mut ProcessInner,
> +    ) -> Result<Option<DLArc<Node>>, CouldNotDeliverCriticalIncrement> {
> +        let is_dead = owner_inner.is_dead;
> +        let inner = self.inner.access_mut(owner_inner);
> +
> +        // Get a reference to the state we'll update.
> +        let state = if strong {
> +            &mut inner.strong
> +        } else {
> +            &mut inner.weak
> +        };
> +
> +        // Update the count and determine whether we need to push work.
> +        state.count += 1;
> +        if is_dead || state.has_count {
> +            return Ok(None);
> +        }
> +
> +        // Userspace needs to be notified of this.
> +        if !strong && inner.delivery_state.should_push_weak_zero2one() {
> +            assert!(inner.delivery_state.can_push_weak_zero2one_normally());
> +            let list_arc = ListArc::try_from_arc(self.clone()).ok().unwrap();
> +            inner.delivery_state.did_push_weak_zero2one();
> +            Ok(Some(list_arc))
> +        } else if strong && inner.delivery_state.should_push_strong_zero2one() {
> +            if inner.delivery_state.can_push_strong_zero2one_normally() {
> +                let list_arc = ListArc::try_from_arc(self.clone()).ok().unwrap();
> +                inner.delivery_state.did_push_strong_zero2one();
> +                Ok(Some(list_arc))
> +            } else {
> +                state.count -= 1;
> +                Err(CouldNotDeliverCriticalIncrement)
> +            }
> +        } else {
> +            // Work is already pushed, and we don't need to push again.
> +            Ok(None)
> +        }
> +    }
> +
> +    pub(crate) fn incr_refcount_allow_zero2one_with_wrapper(
> +        self: &DArc<Self>,
> +        strong: bool,
> +        wrapper: CritIncrWrapper,
> +        owner_inner: &mut ProcessInner,
> +    ) -> Option<DLArc<dyn DeliverToRead>> {
> +        match self.incr_refcount_allow_zero2one(strong, owner_inner) {
> +            Ok(Some(node)) => Some(node as _),
> +            Ok(None) => None,
> +            Err(CouldNotDeliverCriticalIncrement) => {
> +                assert!(strong);
> +                let inner = self.inner.access_mut(owner_inner);
> +                inner.strong.count += 1;
> +                inner.delivery_state.did_push_strong_zero2one_wrapper();
> +                Some(wrapper.init(self.clone()))
> +            }
> +        }
> +    }
> +
> +    pub(crate) fn update_refcount(self: &DArc<Self>, inc: bool, count: usize, strong: bool) {
> +        self.owner
> +            .inner
> +            .lock()
> +            .update_node_refcount(self, inc, strong, count, None);
> +    }
> +
> +    pub(crate) fn populate_counts(
> +        &self,
> +        out: &mut BinderNodeInfoForRef,
> +        guard: &Guard<'_, ProcessInner, SpinLockBackend>,
> +    ) {
> +        let inner = self.inner.access(guard);
> +        out.strong_count = inner.strong.count as _;
> +        out.weak_count = inner.weak.count as _;
> +    }
> +
> +    pub(crate) fn populate_debug_info(
> +        &self,
> +        out: &mut BinderNodeDebugInfo,
> +        guard: &Guard<'_, ProcessInner, SpinLockBackend>,
> +    ) {
> +        out.ptr = self.ptr as _;
> +        out.cookie = self.cookie as _;
> +        let inner = self.inner.access(guard);
> +        if inner.strong.has_count {
> +            out.has_strong_ref = 1;
> +        }
> +        if inner.weak.has_count {
> +            out.has_weak_ref = 1;
> +        }
> +    }
> +
> +    pub(crate) fn force_has_count(&self, guard: &mut Guard<'_, ProcessInner, SpinLockBackend>) {
> +        let inner = self.inner.access_mut(guard);
> +        inner.strong.has_count = true;
> +        inner.weak.has_count = true;
> +    }
> +
> +    fn write(&self, writer: &mut BinderReturnWriter<'_>, code: u32) -> Result {
> +        writer.write_code(code)?;
> +        writer.write_payload(&self.ptr)?;
> +        writer.write_payload(&self.cookie)?;
> +        Ok(())
> +    }
> +
> +    pub(crate) fn submit_oneway(
> +        &self,
> +        transaction: DLArc<Transaction>,
> +        guard: &mut Guard<'_, ProcessInner, SpinLockBackend>,
> +    ) -> Result<(), (BinderError, DLArc<dyn DeliverToRead>)> {
> +        if guard.is_dead {
> +            return Err((BinderError::new_dead(), transaction));
> +        }
> +
> +        let inner = self.inner.access_mut(guard);
> +        if inner.has_oneway_transaction {
> +            inner.oneway_todo.push_back(transaction);
> +        } else {
> +            inner.has_oneway_transaction = true;
> +            guard.push_work(transaction)?;
> +        }
> +        Ok(())
> +    }
> +
> +    pub(crate) fn release(&self) {
> +        let mut guard = self.owner.inner.lock();
> +        while let Some(work) = self.inner.access_mut(&mut guard).oneway_todo.pop_front() {
> +            drop(guard);
> +            work.into_arc().cancel();
> +            guard = self.owner.inner.lock();
> +        }
> +
> +        let death_list = core::mem::take(&mut self.inner.access_mut(&mut guard).death_list);
> +        drop(guard);
> +        for death in death_list {
> +            death.into_arc().set_dead();
> +        }
> +    }
> +
> +    pub(crate) fn pending_oneway_finished(&self) {
> +        let mut guard = self.owner.inner.lock();
> +        if guard.is_dead {
> +            // Cleanup will happen in `Process::deferred_release`.
> +            return;
> +        }
> +
> +        let inner = self.inner.access_mut(&mut guard);
> +
> +        let transaction = inner.oneway_todo.pop_front();
> +        inner.has_oneway_transaction = transaction.is_some();
> +        if let Some(transaction) = transaction {
> +            match guard.push_work(transaction) {
> +                Ok(()) => {}
> +                Err((_err, work)) => {
> +                    // Process is dead.
> +                    // This shouldn't happen due to the `is_dead` check, but if it does, just drop
> +                    // the transaction and return.
> +                    drop(guard);
> +                    drop(work);
> +                }
> +            }
> +        }
> +    }
> +
> +    /// Finds an outdated transaction that the given transaction can replace.
> +    ///
> +    /// If one is found, it is removed from the list and returned.
> +    pub(crate) fn take_outdated_transaction(
> +        &self,
> +        new: &Transaction,
> +        guard: &mut Guard<'_, ProcessInner, SpinLockBackend>,
> +    ) -> Option<DLArc<Transaction>> {
> +        let inner = self.inner.access_mut(guard);
> +        let mut cursor = inner.oneway_todo.cursor_front();
> +        while let Some(next) = cursor.peek_next() {
> +            if new.can_replace(&next) {
> +                return Some(next.remove());
> +            }
> +            cursor.move_next();
> +        }
> +        None
> +    }
> +
> +    /// This is split into a separate function since it's called by both `Node::do_work` and
> +    /// `NodeWrapper::do_work`.
> +    fn do_work_locked(
> +        &self,
> +        writer: &mut BinderReturnWriter<'_>,
> +        mut guard: Guard<'_, ProcessInner, SpinLockBackend>,
> +    ) -> Result<bool> {
> +        let inner = self.inner.access_mut(&mut guard);
> +        let strong = inner.strong.count > 0;
> +        let has_strong = inner.strong.has_count;
> +        let weak = strong || inner.weak.count > 0;
> +        let has_weak = inner.weak.has_count;
> +
> +        if weak && !has_weak {
> +            inner.weak.has_count = true;
> +            inner.active_inc_refs += 1;
> +        }
> +
> +        if strong && !has_strong {
> +            inner.strong.has_count = true;
> +            inner.active_inc_refs += 1;
> +        }
> +
> +        let no_active_inc_refs = inner.active_inc_refs == 0;
> +        let should_drop_weak = no_active_inc_refs && (!weak && has_weak);
> +        let should_drop_strong = no_active_inc_refs && (!strong && has_strong);
> +        if should_drop_weak {
> +            inner.weak.has_count = false;
> +        }
> +        if should_drop_strong {
> +            inner.strong.has_count = false;
> +        }
> +        if no_active_inc_refs && !weak {
> +            // Remove the node if there are no references to it.
> +            guard.remove_node(self.ptr);
> +        }
> +        drop(guard);
> +
> +        if weak && !has_weak {
> +            self.write(writer, BR_INCREFS)?;
> +        }
> +        if strong && !has_strong {
> +            self.write(writer, BR_ACQUIRE)?;
> +        }
> +        if should_drop_strong {
> +            self.write(writer, BR_RELEASE)?;
> +        }
> +        if should_drop_weak {
> +            self.write(writer, BR_DECREFS)?;
> +        }
> +
> +        Ok(true)
> +    }
> +
> +    pub(crate) fn add_freeze_listener(
> +        &self,
> +        process: &Arc<Process>,
> +        flags: kernel::alloc::Flags,
> +    ) -> Result {
> +        let mut vec_alloc = KVVec::<Arc<Process>>::new();
> +        loop {
> +            let mut guard = self.owner.inner.lock();
> +            // Do not check for `guard.dead`. The `dead` flag that matters here is the owner of the
> +            // listener, no the target.
> +            let inner = self.inner.access_mut(&mut guard);
> +            let len = inner.freeze_list.len();
> +            if len >= inner.freeze_list.capacity() {
> +                if len >= vec_alloc.capacity() {
> +                    drop(guard);
> +                    vec_alloc = KVVec::with_capacity((1 + len).next_power_of_two(), flags)?;
> +                    continue;
> +                }
> +                mem::swap(&mut inner.freeze_list, &mut vec_alloc);
> +                for elem in vec_alloc.drain_all() {
> +                    inner.freeze_list.push_within_capacity(elem)?;
> +                }
> +            }
> +            inner.freeze_list.push_within_capacity(process.clone())?;
> +            return Ok(());
> +        }
> +    }
> +
> +    pub(crate) fn remove_freeze_listener(&self, p: &Arc<Process>) {
> +        let _unused_capacity;
> +        let mut guard = self.owner.inner.lock();
> +        let inner = self.inner.access_mut(&mut guard);
> +        let len = inner.freeze_list.len();
> +        inner.freeze_list.retain(|proc| !Arc::ptr_eq(proc, p));
> +        if len == inner.freeze_list.len() {
> +            pr_warn!(
> +                "Could not remove freeze listener for {}\n",
> +                p.pid_in_current_ns()
> +            );
> +        }
> +        if inner.freeze_list.is_empty() {
> +            _unused_capacity = mem::replace(&mut inner.freeze_list, KVVec::new());
> +        }
> +    }
> +
> +    pub(crate) fn freeze_list<'a>(&'a self, guard: &'a ProcessInner) -> &'a [Arc<Process>] {
> +        &self.inner.access(guard).freeze_list
> +    }
> +}
> +
> +impl DeliverToRead for Node {
> +    fn do_work(
> +        self: DArc<Self>,
> +        _thread: &Thread,
> +        writer: &mut BinderReturnWriter<'_>,
> +    ) -> Result<bool> {
> +        let mut owner_inner = self.owner.inner.lock();
> +        let inner = self.inner.access_mut(&mut owner_inner);
> +
> +        assert!(inner.delivery_state.has_pushed_node);
> +        if inner.delivery_state.has_pushed_wrapper {
> +            // If the wrapper is scheduled, then we are either a normal push or weak zero2one
> +            // increment, and the wrapper is a strong zero2one increment, so the wrapper always
> +            // takes precedence over us.
> +            assert!(inner.delivery_state.has_strong_zero2one);
> +            inner.delivery_state.has_pushed_node = false;
> +            inner.delivery_state.has_weak_zero2one = false;
> +            return Ok(true);
> +        }
> +
> +        inner.delivery_state.has_pushed_node = false;
> +        inner.delivery_state.has_weak_zero2one = false;
> +        inner.delivery_state.has_strong_zero2one = false;
> +
> +        self.do_work_locked(writer, owner_inner)
> +    }
> +
> +    fn cancel(self: DArc<Self>) {}
> +
> +    fn should_sync_wakeup(&self) -> bool {
> +        false
> +    }
> +
> +    #[inline(never)]
> +    fn debug_print(&self, m: &SeqFile, prefix: &str, _tprefix: &str) -> Result<()> {
> +        seq_print!(
> +            m,
> +            "{}node work {}: u{:016x} c{:016x}\n",
> +            prefix,
> +            self.debug_id,
> +            self.ptr,
> +            self.cookie,
> +        );
> +        Ok(())
> +    }
> +}
> +
> +/// Represents something that holds one or more ref-counts to a `Node`.
> +///
> +/// Whenever process A holds a refcount to a node owned by a different process B, then process A
> +/// will store a `NodeRef` that refers to the `Node` in process B. When process A releases the
> +/// refcount, we destroy the NodeRef, which decrements the ref-count in process A.
> +///
> +/// This type is also used for some other cases. For example, a transaction allocation holds a
> +/// refcount on the target node, and this is implemented by storing a `NodeRef` in the allocation
> +/// so that the destructor of the allocation will drop a refcount of the `Node`.
> +pub(crate) struct NodeRef {
> +    pub(crate) node: DArc<Node>,
> +    /// How many times does this NodeRef hold a refcount on the Node?
> +    strong_node_count: usize,
> +    weak_node_count: usize,
> +    /// How many times does userspace hold a refcount on this NodeRef?
> +    strong_count: usize,
> +    weak_count: usize,
> +}
> +
> +impl NodeRef {
> +    pub(crate) fn new(node: DArc<Node>, strong_count: usize, weak_count: usize) -> Self {
> +        Self {
> +            node,
> +            strong_node_count: strong_count,
> +            weak_node_count: weak_count,
> +            strong_count,
> +            weak_count,
> +        }
> +    }
> +
> +    pub(crate) fn absorb(&mut self, mut other: Self) {
> +        assert!(
> +            Arc::ptr_eq(&self.node, &other.node),
> +            "absorb called with differing nodes"
> +        );
> +        self.strong_node_count += other.strong_node_count;
> +        self.weak_node_count += other.weak_node_count;
> +        self.strong_count += other.strong_count;
> +        self.weak_count += other.weak_count;
> +        other.strong_count = 0;
> +        other.weak_count = 0;
> +        other.strong_node_count = 0;
> +        other.weak_node_count = 0;
> +
> +        if self.strong_node_count >= 2 || self.weak_node_count >= 2 {
> +            let mut guard = self.node.owner.inner.lock();
> +            let inner = self.node.inner.access_mut(&mut guard);
> +
> +            if self.strong_node_count >= 2 {
> +                inner.strong.count -= self.strong_node_count - 1;
> +                self.strong_node_count = 1;
> +                assert_ne!(inner.strong.count, 0);
> +            }
> +            if self.weak_node_count >= 2 {
> +                inner.weak.count -= self.weak_node_count - 1;
> +                self.weak_node_count = 1;
> +                assert_ne!(inner.weak.count, 0);
> +            }
> +        }
> +    }
> +
> +    pub(crate) fn get_count(&self) -> (usize, usize) {
> +        (self.strong_count, self.weak_count)
> +    }
> +
> +    pub(crate) fn clone(&self, strong: bool) -> Result<NodeRef> {
> +        if strong && self.strong_count == 0 {
> +            return Err(EINVAL);
> +        }
> +        Ok(self
> +            .node
> +            .owner
> +            .inner
> +            .lock()
> +            .new_node_ref(self.node.clone(), strong, None))
> +    }
> +
> +    /// Updates (increments or decrements) the number of references held against the node. If the
> +    /// count being updated transitions from 0 to 1 or from 1 to 0, the node is notified by having
> +    /// its `update_refcount` function called.
> +    ///
> +    /// Returns whether `self` should be removed (when both counts are zero).
> +    pub(crate) fn update(&mut self, inc: bool, strong: bool) -> bool {
> +        if strong && self.strong_count == 0 {
> +            return false;
> +        }
> +        let (count, node_count, other_count) = if strong {
> +            (
> +                &mut self.strong_count,
> +                &mut self.strong_node_count,
> +                self.weak_count,
> +            )
> +        } else {
> +            (
> +                &mut self.weak_count,
> +                &mut self.weak_node_count,
> +                self.strong_count,
> +            )
> +        };
> +        if inc {
> +            if *count == 0 {
> +                *node_count = 1;
> +                self.node.update_refcount(true, 1, strong);
> +            }
> +            *count += 1;
> +        } else {
> +            if *count == 0 {
> +                pr_warn!(
> +                    "pid {} performed invalid decrement on ref\n",
> +                    kernel::current!().pid()
> +                );
> +                return false;
> +            }
> +            *count -= 1;
> +            if *count == 0 {
> +                self.node.update_refcount(false, *node_count, strong);
> +                *node_count = 0;
> +                return other_count == 0;
> +            }
> +        }
> +        false
> +    }
> +}
> +
> +impl Drop for NodeRef {
> +    // This destructor is called conditionally from `Allocation::drop`. That branch is often
> +    // mispredicted. Inlining this method call reduces the cost of those branch mispredictions.
> +    #[inline(always)]
> +    fn drop(&mut self) {
> +        if self.strong_node_count > 0 {
> +            self.node
> +                .update_refcount(false, self.strong_node_count, true);
> +        }
> +        if self.weak_node_count > 0 {
> +            self.node
> +                .update_refcount(false, self.weak_node_count, false);
> +        }
> +    }
> +}
> +
> +struct NodeDeathInner {
> +    dead: bool,
> +    cleared: bool,
> +    notification_done: bool,
> +    /// Indicates whether the normal flow was interrupted by removing the handle. In this case, we
> +    /// need behave as if the death notification didn't exist (i.e., we don't deliver anything to
> +    /// the user.
> +    aborted: bool,
> +}
> +
> +/// Used to deliver notifications when a process dies.
> +///
> +/// A process can request to be notified when a process dies using `BC_REQUEST_DEATH_NOTIFICATION`.
> +/// This will make the driver send a `BR_DEAD_BINDER` to userspace when the process dies (or
> +/// immediately if it is already dead). Userspace is supposed to respond with `BC_DEAD_BINDER_DONE`
> +/// once it has processed the notification.
> +///
> +/// Userspace can unregister from death notifications using the `BC_CLEAR_DEATH_NOTIFICATION`
> +/// command. In this case, the kernel will respond with `BR_CLEAR_DEATH_NOTIFICATION_DONE` once the
> +/// notification has been removed. Note that if the remote process dies before the kernel has
> +/// responded with `BR_CLEAR_DEATH_NOTIFICATION_DONE`, then the kernel will still send a
> +/// `BR_DEAD_BINDER`, which userspace must be able to process. In this case, the kernel will wait
> +/// for the `BC_DEAD_BINDER_DONE` command before it sends `BR_CLEAR_DEATH_NOTIFICATION_DONE`.
> +///
> +/// Note that even if the kernel sends a `BR_DEAD_BINDER`, this does not remove the death
> +/// notification. Userspace must still remove it manually using `BC_CLEAR_DEATH_NOTIFICATION`.
> +///
> +/// If a process uses `BC_RELEASE` to destroy its last refcount on a node that has an active death
> +/// registration, then the death registration is immediately deleted (we implement this using the
> +/// `aborted` field). However, userspace is not supposed to delete a `NodeRef` without first
> +/// deregistering death notifications, so this codepath is not executed under normal circumstances.
> +#[pin_data]
> +pub(crate) struct NodeDeath {
> +    node: DArc<Node>,
> +    process: Arc<Process>,
> +    pub(crate) cookie: u64,
> +    #[pin]
> +    links_track: AtomicTracker<0>,
> +    /// Used by the owner `Node` to store a list of registered death notifications.
> +    ///
> +    /// # Invariants
> +    ///
> +    /// Only ever used with the `death_list` list of `self.node`.
> +    #[pin]
> +    death_links: ListLinks<1>,
> +    /// Used by the process to keep track of the death notifications for which we have sent a
> +    /// `BR_DEAD_BINDER` but not yet received a `BC_DEAD_BINDER_DONE`.
> +    ///
> +    /// # Invariants
> +    ///
> +    /// Only ever used with the `delivered_deaths` list of `self.process`.
> +    #[pin]
> +    delivered_links: ListLinks<2>,
> +    #[pin]
> +    delivered_links_track: AtomicTracker<2>,
> +    #[pin]
> +    inner: SpinLock<NodeDeathInner>,
> +}
> +
> +impl NodeDeath {
> +    /// Constructs a new node death notification object.
> +    pub(crate) fn new(
> +        node: DArc<Node>,
> +        process: Arc<Process>,
> +        cookie: u64,
> +    ) -> impl PinInit<DTRWrap<Self>> {
> +        DTRWrap::new(pin_init!(
> +            Self {
> +                node,
> +                process,
> +                cookie,
> +                links_track <- AtomicTracker::new(),
> +                death_links <- ListLinks::new(),
> +                delivered_links <- ListLinks::new(),
> +                delivered_links_track <- AtomicTracker::new(),
> +                inner <- kernel::new_spinlock!(NodeDeathInner {
> +                    dead: false,
> +                    cleared: false,
> +                    notification_done: false,
> +                    aborted: false,
> +                }, "NodeDeath::inner"),
> +            }
> +        ))
> +    }
> +
> +    /// Sets the cleared flag to `true`.
> +    ///
> +    /// It removes `self` from the node's death notification list if needed.
> +    ///
> +    /// Returns whether it needs to be queued.
> +    pub(crate) fn set_cleared(self: &DArc<Self>, abort: bool) -> bool {
> +        let (needs_removal, needs_queueing) = {
> +            // Update state and determine if we need to queue a work item. We only need to do it
> +            // when the node is not dead or if the user already completed the death notification.
> +            let mut inner = self.inner.lock();
> +            if abort {
> +                inner.aborted = true;
> +            }
> +            if inner.cleared {
> +                // Already cleared.
> +                return false;
> +            }
> +            inner.cleared = true;
> +            (!inner.dead, !inner.dead || inner.notification_done)
> +        };
> +
> +        // Remove death notification from node.
> +        if needs_removal {
> +            let mut owner_inner = self.node.owner.inner.lock();
> +            let node_inner = self.node.inner.access_mut(&mut owner_inner);
> +            // SAFETY: A `NodeDeath` is never inserted into the death list of any node other than
> +            // its owner, so it is either in this death list or in no death list.
> +            unsafe { node_inner.death_list.remove(self) };
> +        }
> +        needs_queueing
> +    }
> +
> +    /// Sets the 'notification done' flag to `true`.
> +    pub(crate) fn set_notification_done(self: DArc<Self>, thread: &Thread) {
> +        let needs_queueing = {
> +            let mut inner = self.inner.lock();
> +            inner.notification_done = true;
> +            inner.cleared
> +        };
> +        if needs_queueing {
> +            if let Some(death) = ListArc::try_from_arc_or_drop(self) {
> +                let _ = thread.push_work_if_looper(death);
> +            }
> +        }
> +    }
> +
> +    /// Sets the 'dead' flag to `true` and queues work item if needed.
> +    pub(crate) fn set_dead(self: DArc<Self>) {
> +        let needs_queueing = {
> +            let mut inner = self.inner.lock();
> +            if inner.cleared {
> +                false
> +            } else {
> +                inner.dead = true;
> +                true
> +            }
> +        };
> +        if needs_queueing {
> +            // Push the death notification to the target process. There is nothing else to do if
> +            // it's already dead.
> +            if let Some(death) = ListArc::try_from_arc_or_drop(self) {
> +                let process = death.process.clone();
> +                let _ = process.push_work(death);
> +            }
> +        }
> +    }
> +}
> +
> +kernel::list::impl_list_arc_safe! {
> +    impl ListArcSafe<0> for NodeDeath {
> +        tracked_by links_track: AtomicTracker;
> +    }
> +}
> +
> +kernel::list::impl_list_arc_safe! {
> +    impl ListArcSafe<1> for DTRWrap<NodeDeath> { untracked; }
> +}
> +kernel::list::impl_list_item! {
> +    impl ListItem<1> for DTRWrap<NodeDeath> {
> +        using ListLinks { self.wrapped.death_links };
> +    }
> +}
> +
> +kernel::list::impl_list_arc_safe! {
> +    impl ListArcSafe<2> for DTRWrap<NodeDeath> {
> +        tracked_by wrapped: NodeDeath;
> +    }
> +}
> +kernel::list::impl_list_arc_safe! {
> +    impl ListArcSafe<2> for NodeDeath {
> +        tracked_by delivered_links_track: AtomicTracker<2>;
> +    }
> +}
> +kernel::list::impl_list_item! {
> +    impl ListItem<2> for DTRWrap<NodeDeath> {
> +        using ListLinks { self.wrapped.delivered_links };
> +    }
> +}
> +
> +impl DeliverToRead for NodeDeath {
> +    fn do_work(
> +        self: DArc<Self>,
> +        _thread: &Thread,
> +        writer: &mut BinderReturnWriter<'_>,
> +    ) -> Result<bool> {
> +        let done = {
> +            let inner = self.inner.lock();
> +            if inner.aborted {
> +                return Ok(true);
> +            }
> +            inner.cleared && (!inner.dead || inner.notification_done)
> +        };
> +
> +        let cookie = self.cookie;
> +        let cmd = if done {
> +            BR_CLEAR_DEATH_NOTIFICATION_DONE
> +        } else {
> +            let process = self.process.clone();
> +            let mut process_inner = process.inner.lock();
> +            let inner = self.inner.lock();
> +            if inner.aborted {
> +                return Ok(true);
> +            }
> +            // We're still holding the inner lock, so it cannot be aborted while we insert it into
> +            // the delivered list.
> +            process_inner.death_delivered(self.clone());
> +            BR_DEAD_BINDER
> +        };
> +
> +        writer.write_code(cmd)?;
> +        writer.write_payload(&cookie)?;
> +        // DEAD_BINDER notifications can cause transactions, so stop processing work items when we
> +        // get to a death notification.
> +        Ok(cmd != BR_DEAD_BINDER)
> +    }
> +
> +    fn cancel(self: DArc<Self>) {}
> +
> +    fn should_sync_wakeup(&self) -> bool {
> +        false
> +    }
> +
> +    #[inline(never)]
> +    fn debug_print(&self, m: &SeqFile, prefix: &str, _tprefix: &str) -> Result<()> {
> +        let inner = self.inner.lock();
> +
> +        let dead_binder = inner.dead && !inner.notification_done;
> +
> +        if dead_binder {
> +            if inner.cleared {
> +                seq_print!(m, "{}has cleared dead binder\n", prefix);
> +            } else {
> +                seq_print!(m, "{}has dead binder\n", prefix);
> +            }
> +        } else {
> +            seq_print!(m, "{}has cleared death notification\n", prefix);
> +        }
> +
> +        Ok(())
> +    }
> +}
> diff --git a/drivers/android/binder/node/wrapper.rs b/drivers/android/binder/node/wrapper.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..43294c050502926633b9fec92e82e34f39f74fdb
> --- /dev/null
> +++ b/drivers/android/binder/node/wrapper.rs
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2025 Google LLC.
> +
> +use kernel::{list::ListArc, prelude::*, seq_file::SeqFile, seq_print, sync::UniqueArc};
> +
> +use crate::{node::Node, thread::Thread, BinderReturnWriter, DArc, DLArc, DTRWrap, DeliverToRead};
> +
> +use core::mem::MaybeUninit;
> +
> +pub(crate) struct CritIncrWrapper {
> +    inner: UniqueArc<MaybeUninit<DTRWrap<NodeWrapper>>>,
> +}
> +
> +impl CritIncrWrapper {
> +    pub(crate) fn new() -> Result<Self> {
> +        Ok(CritIncrWrapper {
> +            inner: UniqueArc::new_uninit(GFP_KERNEL)?,
> +        })
> +    }
> +
> +    pub(super) fn init(self, node: DArc<Node>) -> DLArc<dyn DeliverToRead> {
> +        match self.inner.pin_init_with(DTRWrap::new(NodeWrapper { node })) {
> +            Ok(initialized) => ListArc::from(initialized) as _,
> +            Err(err) => match err {},
> +        }
> +    }
> +}
> +
> +struct NodeWrapper {
> +    node: DArc<Node>,
> +}
> +
> +kernel::list::impl_list_arc_safe! {
> +    impl ListArcSafe<0> for NodeWrapper {
> +        untracked;
> +    }
> +}
> +
> +impl DeliverToRead for NodeWrapper {
> +    fn do_work(
> +        self: DArc<Self>,
> +        _thread: &Thread,
> +        writer: &mut BinderReturnWriter<'_>,
> +    ) -> Result<bool> {
> +        let node = &self.node;
> +        let mut owner_inner = node.owner.inner.lock();
> +        let inner = node.inner.access_mut(&mut owner_inner);
> +
> +        let ds = &mut inner.delivery_state;
> +
> +        assert!(ds.has_pushed_wrapper);
> +        assert!(ds.has_strong_zero2one);
> +        ds.has_pushed_wrapper = false;
> +        ds.has_strong_zero2one = false;
> +
> +        node.do_work_locked(writer, owner_inner)
> +    }
> +
> +    fn cancel(self: DArc<Self>) {}
> +
> +    fn should_sync_wakeup(&self) -> bool {
> +        false
> +    }
> +
> +    #[inline(never)]
> +    fn debug_print(&self, m: &SeqFile, prefix: &str, _tprefix: &str) -> Result<()> {
> +        seq_print!(
> +            m,
> +            "{}node work {}: u{:016x} c{:016x}\n",
> +            prefix,
> +            self.node.debug_id,
> +            self.node.ptr,
> +            self.node.cookie,
> +        );
> +        Ok(())
> +    }
> +}
> diff --git a/drivers/android/binder/page_range.rs b/drivers/android/binder/page_range.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..2ae17e6776c25f23e66a8334ca73925641a4deeb
> --- /dev/null
> +++ b/drivers/android/binder/page_range.rs
> @@ -0,0 +1,746 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2025 Google LLC.
> +
> +//! This module has utilities for managing a page range where unused pages may be reclaimed by a
> +//! vma shrinker.
> +
> +// To avoid deadlocks, locks are taken in the order:
> +//
> +//  1. mmap lock
> +//  2. spinlock
> +//  3. lru spinlock
> +//
> +// The shrinker will use trylock methods because it locks them in a different order.
> +
> +use core::{
> +    alloc::Layout,
> +    marker::PhantomPinned,
> +    mem::{size_of, size_of_val, MaybeUninit},
> +    ptr::{self, NonNull},
> +};
> +
> +use kernel::{
> +    alloc::allocator::KVmalloc,
> +    alloc::Allocator,
> +    bindings,
> +    error::Result,
> +    ffi::{c_ulong, c_void},
> +    mm::{virt, Mm, MmWithUser},
> +    new_mutex, new_spinlock,
> +    page::{Page, PAGE_SHIFT, PAGE_SIZE},
> +    prelude::*,
> +    str::CStr,
> +    sync::{aref::ARef, Mutex, SpinLock},
> +    task::Pid,
> +    transmute::FromBytes,
> +    types::Opaque,
> +    uaccess::UserSliceReader,
> +};
> +
> +/// Represents a shrinker that can be registered with the kernel.
> +///
> +/// Each shrinker can be used by many `ShrinkablePageRange` objects.
> +#[repr(C)]
> +pub(crate) struct Shrinker {
> +    inner: Opaque<*mut bindings::shrinker>,
> +    list_lru: Opaque<bindings::list_lru>,
> +}
> +
> +// SAFETY: The shrinker and list_lru are thread safe.
> +unsafe impl Send for Shrinker {}
> +// SAFETY: The shrinker and list_lru are thread safe.
> +unsafe impl Sync for Shrinker {}
> +
> +impl Shrinker {
> +    /// Create a new shrinker.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Before using this shrinker with a `ShrinkablePageRange`, the `register` method must have
> +    /// been called exactly once, and it must not have returned an error.
> +    pub(crate) const unsafe fn new() -> Self {
> +        Self {
> +            inner: Opaque::uninit(),
> +            list_lru: Opaque::uninit(),
> +        }
> +    }
> +
> +    /// Register this shrinker with the kernel.
> +    pub(crate) fn register(&'static self, name: &CStr) -> Result<()> {
> +        // SAFETY: These fields are not yet used, so it's okay to zero them.
> +        unsafe {
> +            self.inner.get().write(ptr::null_mut());
> +            self.list_lru.get().write_bytes(0, 1);
> +        }
> +
> +        // SAFETY: The field is not yet used, so we can initialize it.
> +        let ret = unsafe { bindings::__list_lru_init(self.list_lru.get(), false, ptr::null_mut()) };
> +        if ret != 0 {
> +            return Err(Error::from_errno(ret));
> +        }
> +
> +        // SAFETY: The `name` points at a valid c string.
> +        let shrinker = unsafe { bindings::shrinker_alloc(0, name.as_char_ptr()) };
> +        if shrinker.is_null() {
> +            // SAFETY: We initialized it, so its okay to destroy it.
> +            unsafe { bindings::list_lru_destroy(self.list_lru.get()) };
> +            return Err(Error::from_errno(ret));
> +        }
> +
> +        // SAFETY: We're about to register the shrinker, and these are the fields we need to
> +        // initialize. (All other fields are already zeroed.)
> +        unsafe {
> +            ptr::addr_of_mut!((*shrinker).count_objects).write(Some(rust_shrink_count));
> +            ptr::addr_of_mut!((*shrinker).scan_objects).write(Some(rust_shrink_scan));
> +            ptr::addr_of_mut!((*shrinker).private_data).write(self.list_lru.get().cast());
> +        }
> +
> +        // SAFETY: The new shrinker has been fully initialized, so we can register it.
> +        unsafe { bindings::shrinker_register(shrinker) };
> +
> +        // SAFETY: This initializes the pointer to the shrinker so that we can use it.
> +        unsafe { self.inner.get().write(shrinker) };
> +
> +        Ok(())
> +    }
> +}
> +
> +/// A container that manages a page range in a vma.
> +///
> +/// The pages can be thought of as an array of booleans of whether the pages are usable. The
> +/// methods `use_range` and `stop_using_range` set all booleans in a range to true or false
> +/// respectively. Initially, no pages are allocated. When a page is not used, it is not freed
> +/// immediately. Instead, it is made available to the memory shrinker to free it if the device is
> +/// under memory pressure.
> +///
> +/// It's okay for `use_range` and `stop_using_range` to race with each other, although there's no
> +/// way to know whether an index ends up with true or false if a call to `use_range` races with
> +/// another call to `stop_using_range` on a given index.
> +///
> +/// It's also okay for the two methods to race with themselves, e.g. if two threads call
> +/// `use_range` on the same index, then that's fine and neither call will return until the page is
> +/// allocated and mapped.
> +///
> +/// The methods that read or write to a range require that the page is marked as in use. So it is
> +/// _not_ okay to call `stop_using_range` on a page that is in use by the methods that read or
> +/// write to the page.
> +#[pin_data(PinnedDrop)]
> +pub(crate) struct ShrinkablePageRange {
> +    /// Shrinker object registered with the kernel.
> +    shrinker: &'static Shrinker,
> +    /// Pid using this page range. Only used as debugging information.
> +    pid: Pid,
> +    /// The mm for the relevant process.
> +    mm: ARef<Mm>,
> +    /// Used to synchronize calls to `vm_insert_page` and `zap_page_range_single`.
> +    #[pin]
> +    mm_lock: Mutex<()>,
> +    /// Spinlock protecting changes to pages.
> +    #[pin]
> +    lock: SpinLock<Inner>,
> +
> +    /// Must not move, since page info has pointers back.
> +    #[pin]
> +    _pin: PhantomPinned,
> +}
> +
> +struct Inner {
> +    /// Array of pages.
> +    ///
> +    /// Since this is also accessed by the shrinker, we can't use a `Box`, which asserts exclusive
> +    /// ownership. To deal with that, we manage it using raw pointers.
> +    pages: *mut PageInfo,
> +    /// Length of the `pages` array.
> +    size: usize,
> +    /// The address of the vma to insert the pages into.
> +    vma_addr: usize,
> +}
> +
> +// SAFETY: proper locking is in place for `Inner`
> +unsafe impl Send for Inner {}
> +
> +type StableMmGuard =
> +    kernel::sync::lock::Guard<'static, (), kernel::sync::lock::mutex::MutexBackend>;
> +
> +/// An array element that describes the current state of a page.
> +///
> +/// There are three states:
> +///
> +///  * Free. The page is None. The `lru` element is not queued.
> +///  * Available. The page is Some. The `lru` element is queued to the shrinker's lru.
> +///  * Used. The page is Some. The `lru` element is not queued.
> +///
> +/// When an element is available, the shrinker is able to free the page.
> +#[repr(C)]
> +struct PageInfo {
> +    lru: bindings::list_head,
> +    page: Option<Page>,
> +    range: *const ShrinkablePageRange,
> +}
> +
> +impl PageInfo {
> +    /// # Safety
> +    ///
> +    /// The caller ensures that writing to `me.page` is ok, and that the page is not currently set.
> +    unsafe fn set_page(me: *mut PageInfo, page: Page) {
> +        // SAFETY: This pointer offset is in bounds.
> +        let ptr = unsafe { ptr::addr_of_mut!((*me).page) };
> +
> +        // SAFETY: The pointer is valid for writing, so also valid for reading.
> +        if unsafe { (*ptr).is_some() } {
> +            pr_err!("set_page called when there is already a page");
> +            // SAFETY: We will initialize the page again below.
> +            unsafe { ptr::drop_in_place(ptr) };
> +        }
> +
> +        // SAFETY: The pointer is valid for writing.
> +        unsafe { ptr::write(ptr, Some(page)) };
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// The caller ensures that reading from `me.page` is ok for the duration of 'a.
> +    unsafe fn get_page<'a>(me: *const PageInfo) -> Option<&'a Page> {
> +        // SAFETY: This pointer offset is in bounds.
> +        let ptr = unsafe { ptr::addr_of!((*me).page) };
> +
> +        // SAFETY: The pointer is valid for reading.
> +        unsafe { (*ptr).as_ref() }
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// The caller ensures that writing to `me.page` is ok for the duration of 'a.
> +    unsafe fn take_page(me: *mut PageInfo) -> Option<Page> {
> +        // SAFETY: This pointer offset is in bounds.
> +        let ptr = unsafe { ptr::addr_of_mut!((*me).page) };
> +
> +        // SAFETY: The pointer is valid for reading.
> +        unsafe { (*ptr).take() }
> +    }
> +
> +    /// Add this page to the lru list, if not already in the list.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The pointer must be valid, and it must be the right shrinker and nid.
> +    unsafe fn list_lru_add(me: *mut PageInfo, nid: i32, shrinker: &'static Shrinker) {
> +        // SAFETY: This pointer offset is in bounds.
> +        let lru_ptr = unsafe { ptr::addr_of_mut!((*me).lru) };
> +        // SAFETY: The lru pointer is valid, and we're not using it with any other lru list.
> +        unsafe { bindings::list_lru_add(shrinker.list_lru.get(), lru_ptr, nid, ptr::null_mut()) };
> +    }
> +
> +    /// Remove this page from the lru list, if it is in the list.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The pointer must be valid, and it must be the right shrinker and nid.
> +    unsafe fn list_lru_del(me: *mut PageInfo, nid: i32, shrinker: &'static Shrinker) {
> +        // SAFETY: This pointer offset is in bounds.
> +        let lru_ptr = unsafe { ptr::addr_of_mut!((*me).lru) };
> +        // SAFETY: The lru pointer is valid, and we're not using it with any other lru list.
> +        unsafe { bindings::list_lru_del(shrinker.list_lru.get(), lru_ptr, nid, ptr::null_mut()) };
> +    }
> +}
> +
> +impl ShrinkablePageRange {
> +    /// Create a new `ShrinkablePageRange` using the given shrinker.
> +    pub(crate) fn new(shrinker: &'static Shrinker) -> impl PinInit<Self, Error> {
> +        try_pin_init!(Self {
> +            shrinker,
> +            pid: kernel::current!().pid(),
> +            mm: ARef::from(&**kernel::current!().mm().ok_or(ESRCH)?),
> +            mm_lock <- new_mutex!((), "ShrinkablePageRange::mm"),
> +            lock <- new_spinlock!(Inner {
> +                pages: ptr::null_mut(),
> +                size: 0,
> +                vma_addr: 0,
> +            }, "ShrinkablePageRange"),
> +            _pin: PhantomPinned,
> +        })
> +    }
> +
> +    pub(crate) fn stable_trylock_mm(&self) -> Option<StableMmGuard> {
> +        // SAFETY: This extends the duration of the reference. Since this call happens before
> +        // `mm_lock` is taken in the destructor of `ShrinkablePageRange`, the destructor will block
> +        // until the returned guard is dropped. This ensures that the guard is valid until dropped.
> +        let mm_lock = unsafe { &*ptr::from_ref(&self.mm_lock) };
> +
> +        mm_lock.try_lock()
> +    }
> +
> +    /// Register a vma with this page range. Returns the size of the region.
> +    pub(crate) fn register_with_vma(&self, vma: &virt::VmaNew) -> Result<usize> {
> +        let num_bytes = usize::min(vma.end() - vma.start(), bindings::SZ_4M as usize);
> +        let num_pages = num_bytes >> PAGE_SHIFT;
> +
> +        if !ptr::eq::<Mm>(&*self.mm, &**vma.mm()) {
> +            pr_debug!("Failed to register with vma: invalid vma->vm_mm");
> +            return Err(EINVAL);
> +        }
> +        if num_pages == 0 {
> +            pr_debug!("Failed to register with vma: size zero");
> +            return Err(EINVAL);
> +        }
> +
> +        let layout = Layout::array::<PageInfo>(num_pages).map_err(|_| ENOMEM)?;
> +        let pages = KVmalloc::alloc(layout, GFP_KERNEL)?.cast::<PageInfo>();
> +
> +        // SAFETY: This just initializes the pages array.
> +        unsafe {
> +            let self_ptr = self as *const ShrinkablePageRange;
> +            for i in 0..num_pages {
> +                let info = pages.as_ptr().add(i);
> +                ptr::addr_of_mut!((*info).range).write(self_ptr);
> +                ptr::addr_of_mut!((*info).page).write(None);
> +                let lru = ptr::addr_of_mut!((*info).lru);
> +                ptr::addr_of_mut!((*lru).next).write(lru);
> +                ptr::addr_of_mut!((*lru).prev).write(lru);
> +            }
> +        }
> +
> +        let mut inner = self.lock.lock();
> +        if inner.size > 0 {
> +            pr_debug!("Failed to register with vma: already registered");
> +            drop(inner);
> +            // SAFETY: The `pages` array was allocated with the same layout.
> +            unsafe { KVmalloc::free(pages.cast(), layout) };
> +            return Err(EBUSY);
> +        }
> +
> +        inner.pages = pages.as_ptr();
> +        inner.size = num_pages;
> +        inner.vma_addr = vma.start();
> +
> +        Ok(num_pages)
> +    }
> +
> +    /// Make sure that the given pages are allocated and mapped.
> +    ///
> +    /// Must not be called from an atomic context.
> +    pub(crate) fn use_range(&self, start: usize, end: usize) -> Result<()> {
> +        if start >= end {
> +            return Ok(());
> +        }
> +        let mut inner = self.lock.lock();
> +        assert!(end <= inner.size);
> +
> +        for i in start..end {
> +            // SAFETY: This pointer offset is in bounds.
> +            let page_info = unsafe { inner.pages.add(i) };
> +
> +            // SAFETY: The pointer is valid, and we hold the lock so reading from the page is okay.
> +            if let Some(page) = unsafe { PageInfo::get_page(page_info) } {
> +                // Since we're going to use the page, we should remove it from the lru list so that
> +                // the shrinker will not free it.
> +                //
> +                // SAFETY: The pointer is valid, and this is the right shrinker.
> +                //
> +                // The shrinker can't free the page between the check and this call to
> +                // `list_lru_del` because we hold the lock.
> +                unsafe { PageInfo::list_lru_del(page_info, page.nid(), self.shrinker) };
> +            } else {
> +                // We have to allocate a new page. Use the slow path.
> +                drop(inner);
> +                // SAFETY: `i < end <= inner.size` so `i` is in bounds.
> +                match unsafe { self.use_page_slow(i) } {
> +                    Ok(()) => {}
> +                    Err(err) => {
> +                        pr_warn!("Error in use_page_slow: {:?}", err);
> +                        return Err(err);
> +                    }
> +                }
> +                inner = self.lock.lock();
> +            }
> +        }
> +        Ok(())
> +    }
> +
> +    /// Mark the given page as in use, slow path.
> +    ///
> +    /// Must not be called from an atomic context.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Assumes that `i` is in bounds.
> +    #[cold]
> +    unsafe fn use_page_slow(&self, i: usize) -> Result<()> {
> +        let new_page = Page::alloc_page(GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO)?;
> +
> +        let mm_mutex = self.mm_lock.lock();
> +        let inner = self.lock.lock();
> +
> +        // SAFETY: This pointer offset is in bounds.
> +        let page_info = unsafe { inner.pages.add(i) };
> +
> +        // SAFETY: The pointer is valid, and we hold the lock so reading from the page is okay.
> +        if let Some(page) = unsafe { PageInfo::get_page(page_info) } {
> +            // The page was already there, or someone else added the page while we didn't hold the
> +            // spinlock.
> +            //
> +            // SAFETY: The pointer is valid, and this is the right shrinker.
> +            //
> +            // The shrinker can't free the page between the check and this call to
> +            // `list_lru_del` because we hold the lock.
> +            unsafe { PageInfo::list_lru_del(page_info, page.nid(), self.shrinker) };
> +            return Ok(());
> +        }
> +
> +        let vma_addr = inner.vma_addr;
> +        // Release the spinlock while we insert the page into the vma.
> +        drop(inner);
> +
> +        // No overflow since we stay in bounds of the vma.
> +        let user_page_addr = vma_addr + (i << PAGE_SHIFT);
> +
> +        // We use `mmput_async` when dropping the `mm` because `use_page_slow` is usually used from
> +        // a remote process. If the call to `mmput` races with the process shutting down, then the
> +        // caller of `use_page_slow` becomes responsible for cleaning up the `mm`, which doesn't
> +        // happen until it returns to userspace. However, the caller might instead go to sleep and
> +        // wait for the owner of the `mm` to wake it up, which doesn't happen because it's in the
> +        // middle of a shutdown process that won't complete until the `mm` is dropped. This can
> +        // amount to a deadlock.
> +        //
> +        // Using `mmput_async` avoids this, because then the `mm` cleanup is instead queued to a
> +        // workqueue.
> +        MmWithUser::into_mmput_async(self.mm.mmget_not_zero().ok_or(ESRCH)?)
> +            .mmap_read_lock()
> +            .vma_lookup(vma_addr)
> +            .ok_or(ESRCH)?
> +            .as_mixedmap_vma()
> +            .ok_or(ESRCH)?
> +            .vm_insert_page(user_page_addr, &new_page)
> +            .inspect_err(|err| {
> +                pr_warn!(
> +                    "Failed to vm_insert_page({}): vma_addr:{} i:{} err:{:?}",
> +                    user_page_addr,
> +                    vma_addr,
> +                    i,
> +                    err
> +                )
> +            })?;
> +
> +        let inner = self.lock.lock();
> +
> +        // SAFETY: The `page_info` pointer is valid and currently does not have a page. The page
> +        // can be written to since we hold the lock.
> +        //
> +        // We released and reacquired the spinlock since we checked that the page is null, but we
> +        // always hold the mm_lock mutex when setting the page to a non-null value, so it's not
> +        // possible for someone else to have changed it since our check.
> +        unsafe { PageInfo::set_page(page_info, new_page) };
> +
> +        drop(inner);
> +        drop(mm_mutex);
> +
> +        Ok(())
> +    }
> +
> +    /// If the given page is in use, then mark it as available so that the shrinker can free it.
> +    ///
> +    /// May be called from an atomic context.
> +    pub(crate) fn stop_using_range(&self, start: usize, end: usize) {
> +        if start >= end {
> +            return;
> +        }
> +        let inner = self.lock.lock();
> +        assert!(end <= inner.size);
> +
> +        for i in (start..end).rev() {
> +            // SAFETY: The pointer is in bounds.
> +            let page_info = unsafe { inner.pages.add(i) };
> +
> +            // SAFETY: Okay for reading since we have the lock.
> +            if let Some(page) = unsafe { PageInfo::get_page(page_info) } {
> +                // SAFETY: The pointer is valid, and it's the right shrinker.
> +                unsafe { PageInfo::list_lru_add(page_info, page.nid(), self.shrinker) };
> +            }
> +        }
> +    }
> +
> +    /// Helper for reading or writing to a range of bytes that may overlap with several pages.
> +    ///
> +    /// # Safety
> +    ///
> +    /// All pages touched by this operation must be in use for the duration of this call.
> +    unsafe fn iterate<T>(&self, mut offset: usize, mut size: usize, mut cb: T) -> Result
> +    where
> +        T: FnMut(&Page, usize, usize) -> Result,
> +    {
> +        if size == 0 {
> +            return Ok(());
> +        }
> +
> +        let (pages, num_pages) = {
> +            let inner = self.lock.lock();
> +            (inner.pages, inner.size)
> +        };
> +        let num_bytes = num_pages << PAGE_SHIFT;
> +
> +        // Check that the request is within the buffer.
> +        if offset.checked_add(size).ok_or(EFAULT)? > num_bytes {
> +            return Err(EFAULT);
> +        }
> +
> +        let mut page_index = offset >> PAGE_SHIFT;
> +        offset &= PAGE_SIZE - 1;
> +        while size > 0 {
> +            let available = usize::min(size, PAGE_SIZE - offset);
> +            // SAFETY: The pointer is in bounds.
> +            let page_info = unsafe { pages.add(page_index) };
> +            // SAFETY: The caller guarantees that this page is in the "in use" state for the
> +            // duration of this call to `iterate`, so nobody will change the page.
> +            let page = unsafe { PageInfo::get_page(page_info) };
> +            if page.is_none() {
> +                pr_warn!("Page is null!");
> +            }
> +            let page = page.ok_or(EFAULT)?;
> +            cb(page, offset, available)?;
> +            size -= available;
> +            page_index += 1;
> +            offset = 0;
> +        }
> +        Ok(())
> +    }
> +
> +    /// Copy from userspace into this page range.
> +    ///
> +    /// # Safety
> +    ///
> +    /// All pages touched by this operation must be in use for the duration of this call.
> +    pub(crate) unsafe fn copy_from_user_slice(
> +        &self,
> +        reader: &mut UserSliceReader,
> +        offset: usize,
> +        size: usize,
> +    ) -> Result {
> +        // SAFETY: `self.iterate` has the same safety requirements as `copy_from_user_slice`.
> +        unsafe {
> +            self.iterate(offset, size, |page, offset, to_copy| {
> +                page.copy_from_user_slice_raw(reader, offset, to_copy)
> +            })
> +        }
> +    }
> +
> +    /// Copy from this page range into kernel space.
> +    ///
> +    /// # Safety
> +    ///
> +    /// All pages touched by this operation must be in use for the duration of this call.
> +    pub(crate) unsafe fn read<T: FromBytes>(&self, offset: usize) -> Result<T> {
> +        let mut out = MaybeUninit::<T>::uninit();
> +        let mut out_offset = 0;
> +        // SAFETY: `self.iterate` has the same safety requirements as `read`.
> +        unsafe {
> +            self.iterate(offset, size_of::<T>(), |page, offset, to_copy| {
> +                // SAFETY: The sum of `offset` and `to_copy` is bounded by the size of T.
> +                let obj_ptr = (out.as_mut_ptr() as *mut u8).add(out_offset);
> +                // SAFETY: The pointer points is in-bounds of the `out` variable, so it is valid.
> +                page.read_raw(obj_ptr, offset, to_copy)?;
> +                out_offset += to_copy;
> +                Ok(())
> +            })?;
> +        }
> +        // SAFETY: We just initialised the data.
> +        Ok(unsafe { out.assume_init() })
> +    }
> +
> +    /// Copy from kernel space into this page range.
> +    ///
> +    /// # Safety
> +    ///
> +    /// All pages touched by this operation must be in use for the duration of this call.
> +    pub(crate) unsafe fn write<T: ?Sized>(&self, offset: usize, obj: &T) -> Result {
> +        let mut obj_offset = 0;
> +        // SAFETY: `self.iterate` has the same safety requirements as `write`.
> +        unsafe {
> +            self.iterate(offset, size_of_val(obj), |page, offset, to_copy| {
> +                // SAFETY: The sum of `offset` and `to_copy` is bounded by the size of T.
> +                let obj_ptr = (obj as *const T as *const u8).add(obj_offset);
> +                // SAFETY: We have a reference to the object, so the pointer is valid.
> +                page.write_raw(obj_ptr, offset, to_copy)?;
> +                obj_offset += to_copy;
> +                Ok(())
> +            })
> +        }
> +    }
> +
> +    /// Write zeroes to the given range.
> +    ///
> +    /// # Safety
> +    ///
> +    /// All pages touched by this operation must be in use for the duration of this call.
> +    pub(crate) unsafe fn fill_zero(&self, offset: usize, size: usize) -> Result {
> +        // SAFETY: `self.iterate` has the same safety requirements as `copy_into`.
> +        unsafe {
> +            self.iterate(offset, size, |page, offset, len| {
> +                page.fill_zero_raw(offset, len)
> +            })
> +        }
> +    }
> +}
> +
> +#[pinned_drop]
> +impl PinnedDrop for ShrinkablePageRange {
> +    fn drop(self: Pin<&mut Self>) {
> +        let (pages, size) = {
> +            let lock = self.lock.lock();
> +            (lock.pages, lock.size)
> +        };
> +
> +        if size == 0 {
> +            return;
> +        }
> +
> +        // Note: This call is also necessary for the safety of `stable_trylock_mm`.
> +        let mm_lock = self.mm_lock.lock();
> +
> +        // This is the destructor, so unlike the other methods, we only need to worry about races
> +        // with the shrinker here. Since we hold the mm_lock, we also can't race with the shrinker.
> +        for i in 0..size {
> +            // SAFETY: Loop is in-bounds of the size.
> +            let p_ptr = unsafe { pages.add(i) };
> +            // SAFETY: No other readers, so we can read.
> +            if let Some(p) = unsafe { PageInfo::get_page(p_ptr) } {
> +                // SAFETY: The pointer is valid and it's the right shrinker.
> +                unsafe { PageInfo::list_lru_del(p_ptr, p.nid(), self.shrinker) };
> +                // SAFETY: No other readers, so we can write.
> +                unsafe { drop(PageInfo::take_page(p_ptr)) };
> +            }
> +        }
> +
> +        drop(mm_lock);
> +
> +        let Some(pages) = NonNull::new(pages) else {
> +            return;
> +        };
> +
> +        // SAFETY: This computation did not overflow when allocating the pages array, so it will
> +        // not overflow this time.
> +        let layout = unsafe { Layout::array::<PageInfo>(size).unwrap_unchecked() };
> +
> +        // SAFETY: The `pages` array was allocated with the same layout.
> +        unsafe { KVmalloc::free(pages.cast(), layout) };
> +    }
> +}
> +
> +/// # Safety
> +/// Called by the shrinker.
> +#[no_mangle]
> +unsafe extern "C" fn rust_shrink_count(
> +    shrink: *mut bindings::shrinker,
> +    _sc: *mut bindings::shrink_control,
> +) -> c_ulong {
> +    // SAFETY: We can access our own private data.
> +    let list_lru = unsafe { (*shrink).private_data.cast::<bindings::list_lru>() };
> +    // SAFETY: Accessing the lru list is okay. Just an FFI call.
> +    unsafe { bindings::list_lru_count(list_lru) }
> +}
> +
> +/// # Safety
> +/// Called by the shrinker.
> +#[no_mangle]
> +unsafe extern "C" fn rust_shrink_scan(
> +    shrink: *mut bindings::shrinker,
> +    sc: *mut bindings::shrink_control,
> +) -> c_ulong {
> +    // SAFETY: We can access our own private data.
> +    let list_lru = unsafe { (*shrink).private_data.cast::<bindings::list_lru>() };
> +    // SAFETY: Caller guarantees that it is safe to read this field.
> +    let nr_to_scan = unsafe { (*sc).nr_to_scan };
> +    // SAFETY: Accessing the lru list is okay. Just an FFI call.
> +    unsafe {
> +        bindings::list_lru_walk(
> +            list_lru,
> +            Some(bindings::rust_shrink_free_page_wrap),
> +            ptr::null_mut(),
> +            nr_to_scan,
> +        )
> +    }
> +}
> +
> +const LRU_SKIP: bindings::lru_status = bindings::lru_status_LRU_SKIP;
> +const LRU_REMOVED_ENTRY: bindings::lru_status = bindings::lru_status_LRU_REMOVED_RETRY;
> +
> +/// # Safety
> +/// Called by the shrinker.
> +#[no_mangle]
> +unsafe extern "C" fn rust_shrink_free_page(
> +    item: *mut bindings::list_head,
> +    lru: *mut bindings::list_lru_one,
> +    _cb_arg: *mut c_void,
> +) -> bindings::lru_status {
> +    // Fields that should survive after unlocking the lru lock.
> +    let page;
> +    let page_index;
> +    let mm;
> +    let mmap_read;
> +    let mm_mutex;
> +    let vma_addr;
> +
> +    {
> +        // CAST: The `list_head` field is first in `PageInfo`.
> +        let info = item as *mut PageInfo;
> +        // SAFETY: The `range` field of `PageInfo` is immutable.
> +        let range = unsafe { &*((*info).range) };
> +
> +        mm = match range.mm.mmget_not_zero() {
> +            Some(mm) => MmWithUser::into_mmput_async(mm),
> +            None => return LRU_SKIP,
> +        };
> +
> +        mm_mutex = match range.stable_trylock_mm() {
> +            Some(guard) => guard,
> +            None => return LRU_SKIP,
> +        };
> +
> +        mmap_read = match mm.mmap_read_trylock() {
> +            Some(guard) => guard,
> +            None => return LRU_SKIP,
> +        };
> +
> +        // We can't lock it normally here, since we hold the lru lock.
> +        let inner = match range.lock.try_lock() {
> +            Some(inner) => inner,
> +            None => return LRU_SKIP,
> +        };
> +
> +        // SAFETY: The item is in this lru list, so it's okay to remove it.
> +        unsafe { bindings::list_lru_isolate(lru, item) };
> +
> +        // SAFETY: Both pointers are in bounds of the same allocation.
> +        page_index = unsafe { info.offset_from(inner.pages) } as usize;
> +
> +        // SAFETY: We hold the spinlock, so we can take the page.
> +        //
> +        // This sets the page pointer to zero before we unmap it from the vma. However, we call
> +        // `zap_page_range` before we release the mmap lock, so `use_page_slow` will not be able to
> +        // insert a new page until after our call to `zap_page_range`.
> +        page = unsafe { PageInfo::take_page(info) };
> +        vma_addr = inner.vma_addr;
> +
> +        // From this point on, we don't access this PageInfo or ShrinkablePageRange again, because
> +        // they can be freed at any point after we unlock `lru_lock`. This is with the exception of
> +        // `mm_mutex` which is kept alive by holding the lock.
> +    }
> +
> +    // SAFETY: The lru lock is locked when this method is called.
> +    unsafe { bindings::spin_unlock(&raw mut (*lru).lock) };
> +
> +    if let Some(vma) = mmap_read.vma_lookup(vma_addr) {
> +        let user_page_addr = vma_addr + (page_index << PAGE_SHIFT);
> +        vma.zap_page_range_single(user_page_addr, PAGE_SIZE);
> +    }
> +
> +    drop(mmap_read);
> +    drop(mm_mutex);
> +    drop(mm);
> +    drop(page);
> +
> +    // SAFETY: We just unlocked the lru lock, but it should be locked when we return.
> +    unsafe { bindings::spin_lock(&raw mut (*lru).lock) };
> +
> +    LRU_REMOVED_ENTRY
> +}
> diff --git a/drivers/android/binder/page_range_helper.c b/drivers/android/binder/page_range_helper.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..496887723ee003e910d6ce67dbadd8c5286e39d1
> --- /dev/null
> +++ b/drivers/android/binder/page_range_helper.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/* C helper for page_range.rs to work around a CFI violation.
> + *
> + * Bindgen currently pretends that `enum lru_status` is the same as an integer.
> + * This assumption is fine ABI-wise, but once you add CFI to the mix, it
> + * triggers a CFI violation because `enum lru_status` gets a different CFI tag.
> + *
> + * This file contains a workaround until bindgen can be fixed.
> + *
> + * Copyright (C) 2025 Google LLC.
> + */
> +#include "page_range_helper.h"
> +
> +unsigned int rust_shrink_free_page(struct list_head *item,
> +				   struct list_lru_one *list,
> +				   void *cb_arg);
> +
> +enum lru_status
> +rust_shrink_free_page_wrap(struct list_head *item, struct list_lru_one *list,
> +			   void *cb_arg)
> +{
> +	return rust_shrink_free_page(item, list, cb_arg);
> +}
> diff --git a/drivers/android/binder/page_range_helper.h b/drivers/android/binder/page_range_helper.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..18dd2dd117b253fcbac735b48032b8f2d53d11fe
> --- /dev/null
> +++ b/drivers/android/binder/page_range_helper.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2025 Google, Inc.
> + */
> +
> +#ifndef _LINUX_PAGE_RANGE_HELPER_H
> +#define _LINUX_PAGE_RANGE_HELPER_H
> +
> +#include <linux/list_lru.h>
> +
> +enum lru_status
> +rust_shrink_free_page_wrap(struct list_head *item, struct list_lru_one *list,
> +			   void *cb_arg);
> +
> +#endif /* _LINUX_PAGE_RANGE_HELPER_H */
> diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/process.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..f13a747e784c84a0fb09cbf47442712106eba07c
> --- /dev/null
> +++ b/drivers/android/binder/process.rs
> @@ -0,0 +1,1696 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2025 Google LLC.
> +
> +//! This module defines the `Process` type, which represents a process using a particular binder
> +//! context.
> +//!
> +//! The `Process` object keeps track of all of the resources that this process owns in the binder
> +//! context.
> +//!
> +//! There is one `Process` object for each binder fd that a process has opened, so processes using
> +//! several binder contexts have several `Process` objects. This ensures that the contexts are
> +//! fully separated.
> +
> +use core::mem::take;
> +
> +use kernel::{
> +    bindings,
> +    cred::Credential,
> +    error::Error,
> +    fs::file::{self, File},
> +    list::{List, ListArc, ListArcField, ListLinks},
> +    mm,
> +    prelude::*,
> +    rbtree::{self, RBTree, RBTreeNode, RBTreeNodeReservation},
> +    seq_file::SeqFile,
> +    seq_print,
> +    sync::poll::PollTable,
> +    sync::{
> +        lock::{spinlock::SpinLockBackend, Guard},
> +        Arc, ArcBorrow, CondVar, CondVarTimeoutResult, Mutex, SpinLock, UniqueArc,
> +    },
> +    task::Task,
> +    types::ARef,
> +    uaccess::{UserSlice, UserSliceReader},
> +    uapi,
> +    workqueue::{self, Work},
> +};
> +
> +use crate::{
> +    allocation::{Allocation, AllocationInfo, NewAllocation},
> +    context::Context,
> +    defs::*,
> +    error::{BinderError, BinderResult},
> +    node::{CouldNotDeliverCriticalIncrement, CritIncrWrapper, Node, NodeDeath, NodeRef},
> +    page_range::ShrinkablePageRange,
> +    range_alloc::{RangeAllocator, ReserveNew, ReserveNewArgs},
> +    stats::BinderStats,
> +    thread::{PushWorkRes, Thread},
> +    BinderfsProcFile, DArc, DLArc, DTRWrap, DeliverToRead,
> +};
> +
> +#[path = "freeze.rs"]
> +mod freeze;
> +use self::freeze::{FreezeCookie, FreezeListener};
> +
> +struct Mapping {
> +    address: usize,
> +    alloc: RangeAllocator<AllocationInfo>,
> +}
> +
> +impl Mapping {
> +    fn new(address: usize, size: usize) -> Self {
> +        Self {
> +            address,
> +            alloc: RangeAllocator::new(size),
> +        }
> +    }
> +}
> +
> +// bitflags for defer_work.
> +const PROC_DEFER_FLUSH: u8 = 1;
> +const PROC_DEFER_RELEASE: u8 = 2;
> +
> +/// The fields of `Process` protected by the spinlock.
> +pub(crate) struct ProcessInner {
> +    is_manager: bool,
> +    pub(crate) is_dead: bool,
> +    threads: RBTree<i32, Arc<Thread>>,
> +    /// INVARIANT: Threads pushed to this list must be owned by this process.
> +    ready_threads: List<Thread>,
> +    nodes: RBTree<u64, DArc<Node>>,
> +    mapping: Option<Mapping>,
> +    work: List<DTRWrap<dyn DeliverToRead>>,
> +    delivered_deaths: List<DTRWrap<NodeDeath>, 2>,
> +
> +    /// The number of requested threads that haven't registered yet.
> +    requested_thread_count: u32,
> +    /// The maximum number of threads used by the process thread pool.
> +    max_threads: u32,
> +    /// The number of threads the started and registered with the thread pool.
> +    started_thread_count: u32,
> +
> +    /// Bitmap of deferred work to do.
> +    defer_work: u8,
> +
> +    /// Number of transactions to be transmitted before processes in freeze_wait
> +    /// are woken up.
> +    outstanding_txns: u32,
> +    /// Process is frozen and unable to service binder transactions.
> +    pub(crate) is_frozen: bool,
> +    /// Process received sync transactions since last frozen.
> +    pub(crate) sync_recv: bool,
> +    /// Process received async transactions since last frozen.
> +    pub(crate) async_recv: bool,
> +    pub(crate) binderfs_file: Option<BinderfsProcFile>,
> +    /// Check for oneway spam
> +    oneway_spam_detection_enabled: bool,
> +}
> +
> +impl ProcessInner {
> +    fn new() -> Self {
> +        Self {
> +            is_manager: false,
> +            is_dead: false,
> +            threads: RBTree::new(),
> +            ready_threads: List::new(),
> +            mapping: None,
> +            nodes: RBTree::new(),
> +            work: List::new(),
> +            delivered_deaths: List::new(),
> +            requested_thread_count: 0,
> +            max_threads: 0,
> +            started_thread_count: 0,
> +            defer_work: 0,
> +            outstanding_txns: 0,
> +            is_frozen: false,
> +            sync_recv: false,
> +            async_recv: false,
> +            binderfs_file: None,
> +            oneway_spam_detection_enabled: false,
> +        }
> +    }
> +
> +    /// Schedule the work item for execution on this process.
> +    ///
> +    /// If any threads are ready for work, then the work item is given directly to that thread and
> +    /// it is woken up. Otherwise, it is pushed to the process work list.
> +    ///
> +    /// This call can fail only if the process is dead. In this case, the work item is returned to
> +    /// the caller so that the caller can drop it after releasing the inner process lock. This is
> +    /// necessary since the destructor of `Transaction` will take locks that can't necessarily be
> +    /// taken while holding the inner process lock.
> +    pub(crate) fn push_work(
> +        &mut self,
> +        work: DLArc<dyn DeliverToRead>,
> +    ) -> Result<(), (BinderError, DLArc<dyn DeliverToRead>)> {
> +        // Try to find a ready thread to which to push the work.
> +        if let Some(thread) = self.ready_threads.pop_front() {
> +            // Push to thread while holding state lock. This prevents the thread from giving up
> +            // (for example, because of a signal) when we're about to deliver work.
> +            match thread.push_work(work) {
> +                PushWorkRes::Ok => Ok(()),
> +                PushWorkRes::FailedDead(work) => Err((BinderError::new_dead(), work)),
> +            }
> +        } else if self.is_dead {
> +            Err((BinderError::new_dead(), work))
> +        } else {
> +            let sync = work.should_sync_wakeup();
> +
> +            // Didn't find a thread waiting for proc work; this can happen
> +            // in two scenarios:
> +            // 1. All threads are busy handling transactions
> +            //    In that case, one of those threads should call back into
> +            //    the kernel driver soon and pick up this work.
> +            // 2. Threads are using the (e)poll interface, in which case
> +            //    they may be blocked on the waitqueue without having been
> +            //    added to waiting_threads. For this case, we just iterate
> +            //    over all threads not handling transaction work, and
> +            //    wake them all up. We wake all because we don't know whether
> +            //    a thread that called into (e)poll is handling non-binder
> +            //    work currently.
> +            self.work.push_back(work);
> +
> +            // Wake up polling threads, if any.
> +            for thread in self.threads.values() {
> +                thread.notify_if_poll_ready(sync);
> +            }
> +
> +            Ok(())
> +        }
> +    }
> +
> +    pub(crate) fn remove_node(&mut self, ptr: u64) {
> +        self.nodes.remove(&ptr);
> +    }
> +
> +    /// Updates the reference count on the given node.
> +    pub(crate) fn update_node_refcount(
> +        &mut self,
> +        node: &DArc<Node>,
> +        inc: bool,
> +        strong: bool,
> +        count: usize,
> +        othread: Option<&Thread>,
> +    ) {
> +        let push = node.update_refcount_locked(inc, strong, count, self);
> +
> +        // If we decided that we need to push work, push either to the process or to a thread if
> +        // one is specified.
> +        if let Some(node) = push {
> +            if let Some(thread) = othread {
> +                thread.push_work_deferred(node);
> +            } else {
> +                let _ = self.push_work(node);
> +                // Nothing to do: `push_work` may fail if the process is dead, but that's ok as in
> +                // that case, it doesn't care about the notification.
> +            }
> +        }
> +    }
> +
> +    pub(crate) fn new_node_ref(
> +        &mut self,
> +        node: DArc<Node>,
> +        strong: bool,
> +        thread: Option<&Thread>,
> +    ) -> NodeRef {
> +        self.update_node_refcount(&node, true, strong, 1, thread);
> +        let strong_count = if strong { 1 } else { 0 };
> +        NodeRef::new(node, strong_count, 1 - strong_count)
> +    }
> +
> +    pub(crate) fn new_node_ref_with_thread(
> +        &mut self,
> +        node: DArc<Node>,
> +        strong: bool,
> +        thread: &Thread,
> +        wrapper: Option<CritIncrWrapper>,
> +    ) -> Result<NodeRef, CouldNotDeliverCriticalIncrement> {
> +        let push = match wrapper {
> +            None => node
> +                .incr_refcount_allow_zero2one(strong, self)?
> +                .map(|node| node as _),
> +            Some(wrapper) => node.incr_refcount_allow_zero2one_with_wrapper(strong, wrapper, self),
> +        };
> +        if let Some(node) = push {
> +            thread.push_work_deferred(node);
> +        }
> +        let strong_count = if strong { 1 } else { 0 };
> +        Ok(NodeRef::new(node, strong_count, 1 - strong_count))
> +    }
> +
> +    /// Returns an existing node with the given pointer and cookie, if one exists.
> +    ///
> +    /// Returns an error if a node with the given pointer but a different cookie exists.
> +    fn get_existing_node(&self, ptr: u64, cookie: u64) -> Result<Option<DArc<Node>>> {
> +        match self.nodes.get(&ptr) {
> +            None => Ok(None),
> +            Some(node) => {
> +                let (_, node_cookie) = node.get_id();
> +                if node_cookie == cookie {
> +                    Ok(Some(node.clone()))
> +                } else {
> +                    Err(EINVAL)
> +                }
> +            }
> +        }
> +    }
> +
> +    fn register_thread(&mut self) -> bool {
> +        if self.requested_thread_count == 0 {
> +            return false;
> +        }
> +
> +        self.requested_thread_count -= 1;
> +        self.started_thread_count += 1;
> +        true
> +    }
> +
> +    /// Finds a delivered death notification with the given cookie, removes it from the thread's
> +    /// delivered list, and returns it.
> +    fn pull_delivered_death(&mut self, cookie: u64) -> Option<DArc<NodeDeath>> {
> +        let mut cursor = self.delivered_deaths.cursor_front();
> +        while let Some(next) = cursor.peek_next() {
> +            if next.cookie == cookie {
> +                return Some(next.remove().into_arc());
> +            }
> +            cursor.move_next();
> +        }
> +        None
> +    }
> +
> +    pub(crate) fn death_delivered(&mut self, death: DArc<NodeDeath>) {
> +        if let Some(death) = ListArc::try_from_arc_or_drop(death) {
> +            self.delivered_deaths.push_back(death);
> +        } else {
> +            pr_warn!("Notification added to `delivered_deaths` twice.");
> +        }
> +    }
> +
> +    pub(crate) fn add_outstanding_txn(&mut self) {
> +        self.outstanding_txns += 1;
> +    }
> +
> +    fn txns_pending_locked(&self) -> bool {
> +        if self.outstanding_txns > 0 {
> +            return true;
> +        }
> +        for thread in self.threads.values() {
> +            if thread.has_current_transaction() {
> +                return true;
> +            }
> +        }
> +        false
> +    }
> +}
> +
> +/// Used to keep track of a node that this process has a handle to.
> +#[pin_data]
> +pub(crate) struct NodeRefInfo {
> +    debug_id: usize,
> +    /// The refcount that this process owns to the node.
> +    node_ref: ListArcField<NodeRef, { Self::LIST_PROC }>,
> +    death: ListArcField<Option<DArc<NodeDeath>>, { Self::LIST_PROC }>,
> +    /// Cookie of the active freeze listener for this node.
> +    freeze: ListArcField<Option<FreezeCookie>, { Self::LIST_PROC }>,
> +    /// Used to store this `NodeRefInfo` in the node's `refs` list.
> +    #[pin]
> +    links: ListLinks<{ Self::LIST_NODE }>,
> +    /// The handle for this `NodeRefInfo`.
> +    handle: u32,
> +    /// The process that has a handle to the node.
> +    pub(crate) process: Arc<Process>,
> +}
> +
> +impl NodeRefInfo {
> +    /// The id used for the `Node::refs` list.
> +    pub(crate) const LIST_NODE: u64 = 0x2da16350fb724a10;
> +    /// The id used for the `ListArc` in `ProcessNodeRefs`.
> +    const LIST_PROC: u64 = 0xd703a5263dcc8650;
> +
> +    fn new(node_ref: NodeRef, handle: u32, process: Arc<Process>) -> impl PinInit<Self> {
> +        pin_init!(Self {
> +            debug_id: super::next_debug_id(),
> +            node_ref: ListArcField::new(node_ref),
> +            death: ListArcField::new(None),
> +            freeze: ListArcField::new(None),
> +            links <- ListLinks::new(),
> +            handle,
> +            process,
> +        })
> +    }
> +
> +    kernel::list::define_list_arc_field_getter! {
> +        pub(crate) fn death(&mut self<{Self::LIST_PROC}>) -> &mut Option<DArc<NodeDeath>> { death }
> +        pub(crate) fn freeze(&mut self<{Self::LIST_PROC}>) -> &mut Option<FreezeCookie> { freeze }
> +        pub(crate) fn node_ref(&mut self<{Self::LIST_PROC}>) -> &mut NodeRef { node_ref }
> +        pub(crate) fn node_ref2(&self<{Self::LIST_PROC}>) -> &NodeRef { node_ref }
> +    }
> +}
> +
> +kernel::list::impl_list_arc_safe! {
> +    impl ListArcSafe<{Self::LIST_NODE}> for NodeRefInfo { untracked; }
> +    impl ListArcSafe<{Self::LIST_PROC}> for NodeRefInfo { untracked; }
> +}
> +kernel::list::impl_list_item! {
> +    impl ListItem<{Self::LIST_NODE}> for NodeRefInfo {
> +        using ListLinks { self.links };
> +    }
> +}
> +
> +/// Keeps track of references this process has to nodes owned by other processes.
> +///
> +/// TODO: Currently, the rbtree requires two allocations per node reference, and two tree
> +/// traversals to look up a node by `Node::global_id`. Once the rbtree is more powerful, these
> +/// extra costs should be eliminated.
> +struct ProcessNodeRefs {
> +    /// Used to look up nodes using the 32-bit id that this process knows it by.
> +    by_handle: RBTree<u32, ListArc<NodeRefInfo, { NodeRefInfo::LIST_PROC }>>,
> +    /// Used to look up nodes without knowing their local 32-bit id. The usize is the address of
> +    /// the underlying `Node` struct as returned by `Node::global_id`.
> +    by_node: RBTree<usize, u32>,
> +    /// Used to look up a `FreezeListener` by cookie.
> +    ///
> +    /// There might be multiple freeze listeners for the same node, but at most one of them is
> +    /// active.
> +    freeze_listeners: RBTree<FreezeCookie, FreezeListener>,
> +}
> +
> +impl ProcessNodeRefs {
> +    fn new() -> Self {
> +        Self {
> +            by_handle: RBTree::new(),
> +            by_node: RBTree::new(),
> +            freeze_listeners: RBTree::new(),
> +        }
> +    }
> +}
> +
> +/// A process using binder.
> +///
> +/// Strictly speaking, there can be multiple of these per process. There is one for each binder fd
> +/// that a process has opened, so processes using several binder contexts have several `Process`
> +/// objects. This ensures that the contexts are fully separated.
> +#[pin_data]
> +pub(crate) struct Process {
> +    pub(crate) ctx: Arc<Context>,
> +
> +    // The task leader (process).
> +    pub(crate) task: ARef<Task>,
> +
> +    // Credential associated with file when `Process` is created.
> +    pub(crate) cred: ARef<Credential>,
> +
> +    #[pin]
> +    pub(crate) inner: SpinLock<ProcessInner>,
> +
> +    #[pin]
> +    pub(crate) pages: ShrinkablePageRange,
> +
> +    // Waitqueue of processes waiting for all outstanding transactions to be
> +    // processed.
> +    #[pin]
> +    freeze_wait: CondVar,
> +
> +    // Node references are in a different lock to avoid recursive acquisition when
> +    // incrementing/decrementing a node in another process.
> +    #[pin]
> +    node_refs: Mutex<ProcessNodeRefs>,
> +
> +    // Work node for deferred work item.
> +    #[pin]
> +    defer_work: Work<Process>,
> +
> +    // Links for process list in Context.
> +    #[pin]
> +    links: ListLinks,
> +
> +    pub(crate) stats: BinderStats,
> +}
> +
> +kernel::impl_has_work! {
> +    impl HasWork<Process> for Process { self.defer_work }
> +}
> +
> +kernel::list::impl_list_arc_safe! {
> +    impl ListArcSafe<0> for Process { untracked; }
> +}
> +kernel::list::impl_list_item! {
> +    impl ListItem<0> for Process {
> +        using ListLinks { self.links };
> +    }
> +}
> +
> +impl workqueue::WorkItem for Process {
> +    type Pointer = Arc<Process>;
> +
> +    fn run(me: Arc<Self>) {
> +        let defer;
> +        {
> +            let mut inner = me.inner.lock();
> +            defer = inner.defer_work;
> +            inner.defer_work = 0;
> +        }
> +
> +        if defer & PROC_DEFER_FLUSH != 0 {
> +            me.deferred_flush();
> +        }
> +        if defer & PROC_DEFER_RELEASE != 0 {
> +            me.deferred_release();
> +        }
> +    }
> +}
> +
> +impl Process {
> +    fn new(ctx: Arc<Context>, cred: ARef<Credential>) -> Result<Arc<Self>> {
> +        let current = kernel::current!();
> +        let list_process = ListArc::pin_init::<Error>(
> +            try_pin_init!(Process {
> +                ctx,
> +                cred,
> +                inner <- kernel::new_spinlock!(ProcessInner::new(), "Process::inner"),
> +                pages <- ShrinkablePageRange::new(&super::BINDER_SHRINKER),
> +                node_refs <- kernel::new_mutex!(ProcessNodeRefs::new(), "Process::node_refs"),
> +                freeze_wait <- kernel::new_condvar!("Process::freeze_wait"),
> +                task: current.group_leader().into(),
> +                defer_work <- kernel::new_work!("Process::defer_work"),
> +                links <- ListLinks::new(),
> +                stats: BinderStats::new(),
> +            }),
> +            GFP_KERNEL,
> +        )?;
> +
> +        let process = list_process.clone_arc();
> +        process.ctx.register_process(list_process);
> +
> +        Ok(process)
> +    }
> +
> +    pub(crate) fn pid_in_current_ns(&self) -> kernel::task::Pid {
> +        self.task.tgid_nr_ns(None)
> +    }
> +
> +    #[inline(never)]
> +    pub(crate) fn debug_print_stats(&self, m: &SeqFile, ctx: &Context) -> Result<()> {
> +        seq_print!(m, "proc {}\n", self.pid_in_current_ns());
> +        seq_print!(m, "context {}\n", &*ctx.name);
> +
> +        let inner = self.inner.lock();
> +        seq_print!(m, "  threads: {}\n", inner.threads.iter().count());
> +        seq_print!(
> +            m,
> +            "  requested threads: {}+{}/{}\n",
> +            inner.requested_thread_count,
> +            inner.started_thread_count,
> +            inner.max_threads,
> +        );
> +        if let Some(mapping) = &inner.mapping {
> +            seq_print!(
> +                m,
> +                "  free oneway space: {}\n",
> +                mapping.alloc.free_oneway_space()
> +            );
> +            seq_print!(m, "  buffers: {}\n", mapping.alloc.count_buffers());
> +        }
> +        seq_print!(
> +            m,
> +            "  outstanding transactions: {}\n",
> +            inner.outstanding_txns
> +        );
> +        seq_print!(m, "  nodes: {}\n", inner.nodes.iter().count());
> +        drop(inner);
> +
> +        {
> +            let mut refs = self.node_refs.lock();
> +            let (mut count, mut weak, mut strong) = (0, 0, 0);
> +            for r in refs.by_handle.values_mut() {
> +                let node_ref = r.node_ref();
> +                let (nstrong, nweak) = node_ref.get_count();
> +                count += 1;
> +                weak += nweak;
> +                strong += nstrong;
> +            }
> +            seq_print!(m, "  refs: {count} s {strong} w {weak}\n");
> +        }
> +
> +        self.stats.debug_print("  ", m);
> +
> +        Ok(())
> +    }
> +
> +    #[inline(never)]
> +    pub(crate) fn debug_print(&self, m: &SeqFile, ctx: &Context, print_all: bool) -> Result<()> {
> +        seq_print!(m, "proc {}\n", self.pid_in_current_ns());
> +        seq_print!(m, "context {}\n", &*ctx.name);
> +
> +        let mut all_threads = KVec::new();
> +        let mut all_nodes = KVec::new();
> +        loop {
> +            let inner = self.inner.lock();
> +            let num_threads = inner.threads.iter().count();
> +            let num_nodes = inner.nodes.iter().count();
> +
> +            if all_threads.capacity() < num_threads || all_nodes.capacity() < num_nodes {
> +                drop(inner);
> +                all_threads.reserve(num_threads, GFP_KERNEL)?;
> +                all_nodes.reserve(num_nodes, GFP_KERNEL)?;
> +                continue;
> +            }
> +
> +            for thread in inner.threads.values() {
> +                assert!(all_threads.len() < all_threads.capacity());
> +                let _ = all_threads.push(thread.clone(), GFP_ATOMIC);
> +            }
> +
> +            for node in inner.nodes.values() {
> +                assert!(all_nodes.len() < all_nodes.capacity());
> +                let _ = all_nodes.push(node.clone(), GFP_ATOMIC);
> +            }
> +
> +            break;
> +        }
> +
> +        for thread in all_threads {
> +            thread.debug_print(m, print_all)?;
> +        }
> +
> +        let mut inner = self.inner.lock();
> +        for node in all_nodes {
> +            if print_all || node.has_oneway_transaction(&mut inner) {
> +                node.full_debug_print(m, &mut inner)?;
> +            }
> +        }
> +        drop(inner);
> +
> +        if print_all {
> +            let mut refs = self.node_refs.lock();
> +            for r in refs.by_handle.values_mut() {
> +                let node_ref = r.node_ref();
> +                let dead = node_ref.node.owner.inner.lock().is_dead;
> +                let (strong, weak) = node_ref.get_count();
> +                let debug_id = node_ref.node.debug_id;
> +
> +                seq_print!(
> +                    m,
> +                    "  ref {}: desc {} {}node {debug_id} s {strong} w {weak}",
> +                    r.debug_id,
> +                    r.handle,
> +                    if dead { "dead " } else { "" },
> +                );
> +            }
> +        }
> +
> +        let inner = self.inner.lock();
> +        for work in &inner.work {
> +            work.debug_print(m, "  ", "  pending transaction ")?;
> +        }
> +        for _death in &inner.delivered_deaths {
> +            seq_print!(m, "  has delivered dead binder\n");
> +        }
> +        if let Some(mapping) = &inner.mapping {
> +            mapping.alloc.debug_print(m)?;
> +        }
> +        drop(inner);
> +
> +        Ok(())
> +    }
> +
> +    /// Attempts to fetch a work item from the process queue.
> +    pub(crate) fn get_work(&self) -> Option<DLArc<dyn DeliverToRead>> {
> +        self.inner.lock().work.pop_front()
> +    }
> +
> +    /// Attempts to fetch a work item from the process queue. If none is available, it registers the
> +    /// given thread as ready to receive work directly.
> +    ///
> +    /// This must only be called when the thread is not participating in a transaction chain; when
> +    /// it is, work will always be delivered directly to the thread (and not through the process
> +    /// queue).
> +    pub(crate) fn get_work_or_register<'a>(
> +        &'a self,
> +        thread: &'a Arc<Thread>,
> +    ) -> GetWorkOrRegister<'a> {
> +        let mut inner = self.inner.lock();
> +        // Try to get work from the process queue.
> +        if let Some(work) = inner.work.pop_front() {
> +            return GetWorkOrRegister::Work(work);
> +        }
> +
> +        // Register the thread as ready.
> +        GetWorkOrRegister::Register(Registration::new(thread, &mut inner))
> +    }
> +
> +    fn get_current_thread(self: ArcBorrow<'_, Self>) -> Result<Arc<Thread>> {
> +        let id = {
> +            let current = kernel::current!();
> +            if !core::ptr::eq(current.group_leader(), &*self.task) {
> +                pr_err!("get_current_thread was called from the wrong process.");
> +                return Err(EINVAL);
> +            }
> +            current.pid()
> +        };
> +
> +        {
> +            let inner = self.inner.lock();
> +            if let Some(thread) = inner.threads.get(&id) {
> +                return Ok(thread.clone());
> +            }
> +        }
> +
> +        // Allocate a new `Thread` without holding any locks.
> +        let reservation = RBTreeNodeReservation::new(GFP_KERNEL)?;
> +        let ta: Arc<Thread> = Thread::new(id, self.into())?;
> +
> +        let mut inner = self.inner.lock();
> +        match inner.threads.entry(id) {
> +            rbtree::Entry::Vacant(entry) => {
> +                entry.insert(ta.clone(), reservation);
> +                Ok(ta)
> +            }
> +            rbtree::Entry::Occupied(_entry) => {
> +                pr_err!("Cannot create two threads with the same id.");
> +                Err(EINVAL)
> +            }
> +        }
> +    }
> +
> +    pub(crate) fn push_work(&self, work: DLArc<dyn DeliverToRead>) -> BinderResult {
> +        // If push_work fails, drop the work item outside the lock.
> +        let res = self.inner.lock().push_work(work);
> +        match res {
> +            Ok(()) => Ok(()),
> +            Err((err, work)) => {
> +                drop(work);
> +                Err(err)
> +            }
> +        }
> +    }
> +
> +    fn set_as_manager(
> +        self: ArcBorrow<'_, Self>,
> +        info: Option<FlatBinderObject>,
> +        thread: &Thread,
> +    ) -> Result {
> +        let (ptr, cookie, flags) = if let Some(obj) = info {
> +            (
> +                // SAFETY: The object type for this ioctl is implicitly `BINDER_TYPE_BINDER`, so it
> +                // is safe to access the `binder` field.
> +                unsafe { obj.__bindgen_anon_1.binder },
> +                obj.cookie,
> +                obj.flags,
> +            )
> +        } else {
> +            (0, 0, 0)
> +        };
> +        let node_ref = self.get_node(ptr, cookie, flags as _, true, thread)?;
> +        let node = node_ref.node.clone();
> +        self.ctx.set_manager_node(node_ref)?;
> +        self.inner.lock().is_manager = true;
> +
> +        // Force the state of the node to prevent the delivery of acquire/increfs.
> +        let mut owner_inner = node.owner.inner.lock();
> +        node.force_has_count(&mut owner_inner);
> +        Ok(())
> +    }
> +
> +    fn get_node_inner(
> +        self: ArcBorrow<'_, Self>,
> +        ptr: u64,
> +        cookie: u64,
> +        flags: u32,
> +        strong: bool,
> +        thread: &Thread,
> +        wrapper: Option<CritIncrWrapper>,
> +    ) -> Result<Result<NodeRef, CouldNotDeliverCriticalIncrement>> {
> +        // Try to find an existing node.
> +        {
> +            let mut inner = self.inner.lock();
> +            if let Some(node) = inner.get_existing_node(ptr, cookie)? {
> +                return Ok(inner.new_node_ref_with_thread(node, strong, thread, wrapper));
> +            }
> +        }
> +
> +        // Allocate the node before reacquiring the lock.
> +        let node = DTRWrap::arc_pin_init(Node::new(ptr, cookie, flags, self.into()))?.into_arc();
> +        let rbnode = RBTreeNode::new(ptr, node.clone(), GFP_KERNEL)?;
> +        let mut inner = self.inner.lock();
> +        if let Some(node) = inner.get_existing_node(ptr, cookie)? {
> +            return Ok(inner.new_node_ref_with_thread(node, strong, thread, wrapper));
> +        }
> +
> +        inner.nodes.insert(rbnode);
> +        // This can only fail if someone has already pushed the node to a list, but we just created
> +        // it and still hold the lock, so it can't fail right now.
> +        let node_ref = inner
> +            .new_node_ref_with_thread(node, strong, thread, wrapper)
> +            .unwrap();
> +
> +        Ok(Ok(node_ref))
> +    }
> +
> +    pub(crate) fn get_node(
> +        self: ArcBorrow<'_, Self>,
> +        ptr: u64,
> +        cookie: u64,
> +        flags: u32,
> +        strong: bool,
> +        thread: &Thread,
> +    ) -> Result<NodeRef> {
> +        let mut wrapper = None;
> +        for _ in 0..2 {
> +            match self.get_node_inner(ptr, cookie, flags, strong, thread, wrapper) {
> +                Err(err) => return Err(err),
> +                Ok(Ok(node_ref)) => return Ok(node_ref),
> +                Ok(Err(CouldNotDeliverCriticalIncrement)) => {
> +                    wrapper = Some(CritIncrWrapper::new()?);
> +                }
> +            }
> +        }
> +        // We only get a `CouldNotDeliverCriticalIncrement` error if `wrapper` is `None`, so the
> +        // loop should run at most twice.
> +        unreachable!()
> +    }
> +
> +    pub(crate) fn insert_or_update_handle(
> +        self: ArcBorrow<'_, Process>,
> +        node_ref: NodeRef,
> +        is_mananger: bool,
> +    ) -> Result<u32> {
> +        {
> +            let mut refs = self.node_refs.lock();
> +
> +            // Do a lookup before inserting.
> +            if let Some(handle_ref) = refs.by_node.get(&node_ref.node.global_id()) {
> +                let handle = *handle_ref;
> +                let info = refs.by_handle.get_mut(&handle).unwrap();
> +                info.node_ref().absorb(node_ref);
> +                return Ok(handle);
> +            }
> +        }
> +
> +        // Reserve memory for tree nodes.
> +        let reserve1 = RBTreeNodeReservation::new(GFP_KERNEL)?;
> +        let reserve2 = RBTreeNodeReservation::new(GFP_KERNEL)?;
> +        let info = UniqueArc::new_uninit(GFP_KERNEL)?;
> +
> +        let mut refs = self.node_refs.lock();
> +
> +        // Do a lookup again as node may have been inserted before the lock was reacquired.
> +        if let Some(handle_ref) = refs.by_node.get(&node_ref.node.global_id()) {
> +            let handle = *handle_ref;
> +            let info = refs.by_handle.get_mut(&handle).unwrap();
> +            info.node_ref().absorb(node_ref);
> +            return Ok(handle);
> +        }
> +
> +        // Find id.
> +        let mut target: u32 = if is_mananger { 0 } else { 1 };
> +        for handle in refs.by_handle.keys() {
> +            if *handle > target {
> +                break;
> +            }
> +            if *handle == target {
> +                target = target.checked_add(1).ok_or(ENOMEM)?;
> +            }
> +        }
> +
> +        let gid = node_ref.node.global_id();
> +        let (info_proc, info_node) = {
> +            let info_init = NodeRefInfo::new(node_ref, target, self.into());
> +            match info.pin_init_with(info_init) {
> +                Ok(info) => ListArc::pair_from_pin_unique(info),
> +                // error is infallible
> +                Err(err) => match err {},
> +            }
> +        };
> +
> +        // Ensure the process is still alive while we insert a new reference.
> +        //
> +        // This releases the lock before inserting the nodes, but since `is_dead` is set as the
> +        // first thing in `deferred_release`, process cleanup will not miss the items inserted into
> +        // `refs` below.
> +        if self.inner.lock().is_dead {
> +            return Err(ESRCH);
> +        }
> +
> +        // SAFETY: `info_proc` and `info_node` reference the same node, so we are inserting
> +        // `info_node` into the right node's `refs` list.
> +        unsafe { info_proc.node_ref2().node.insert_node_info(info_node) };
> +
> +        refs.by_node.insert(reserve1.into_node(gid, target));
> +        refs.by_handle.insert(reserve2.into_node(target, info_proc));
> +        Ok(target)
> +    }
> +
> +    pub(crate) fn get_transaction_node(&self, handle: u32) -> BinderResult<NodeRef> {
> +        // When handle is zero, try to get the context manager.
> +        if handle == 0 {
> +            Ok(self.ctx.get_manager_node(true)?)
> +        } else {
> +            Ok(self.get_node_from_handle(handle, true)?)
> +        }
> +    }
> +
> +    pub(crate) fn get_node_from_handle(&self, handle: u32, strong: bool) -> Result<NodeRef> {
> +        self.node_refs
> +            .lock()
> +            .by_handle
> +            .get_mut(&handle)
> +            .ok_or(ENOENT)?
> +            .node_ref()
> +            .clone(strong)
> +    }
> +
> +    pub(crate) fn remove_from_delivered_deaths(&self, death: &DArc<NodeDeath>) {
> +        let mut inner = self.inner.lock();
> +        // SAFETY: By the invariant on the `delivered_links` field, this is the right linked list.
> +        let removed = unsafe { inner.delivered_deaths.remove(death) };
> +        drop(inner);
> +        drop(removed);
> +    }
> +
> +    pub(crate) fn update_ref(
> +        self: ArcBorrow<'_, Process>,
> +        handle: u32,
> +        inc: bool,
> +        strong: bool,
> +    ) -> Result {
> +        if inc && handle == 0 {
> +            if let Ok(node_ref) = self.ctx.get_manager_node(strong) {
> +                if core::ptr::eq(&*self, &*node_ref.node.owner) {
> +                    return Err(EINVAL);
> +                }
> +                let _ = self.insert_or_update_handle(node_ref, true);
> +                return Ok(());
> +            }
> +        }
> +
> +        // To preserve original binder behaviour, we only fail requests where the manager tries to
> +        // increment references on itself.
> +        let mut refs = self.node_refs.lock();
> +        if let Some(info) = refs.by_handle.get_mut(&handle) {
> +            if info.node_ref().update(inc, strong) {
> +                // Clean up death if there is one attached to this node reference.
> +                if let Some(death) = info.death().take() {
> +                    death.set_cleared(true);
> +                    self.remove_from_delivered_deaths(&death);
> +                }
> +
> +                // Remove reference from process tables, and from the node's `refs` list.
> +
> +                // SAFETY: We are removing the `NodeRefInfo` from the right node.
> +                unsafe { info.node_ref2().node.remove_node_info(info) };
> +
> +                let id = info.node_ref().node.global_id();
> +                refs.by_handle.remove(&handle);
> +                refs.by_node.remove(&id);
> +            }
> +        } else {
> +            // All refs are cleared in process exit, so this warning is expected in that case.
> +            if !self.inner.lock().is_dead {
> +                pr_warn!("{}: no such ref {handle}\n", self.pid_in_current_ns());
> +            }
> +        }
> +        Ok(())
> +    }
> +
> +    /// Decrements the refcount of the given node, if one exists.
> +    pub(crate) fn update_node(&self, ptr: u64, cookie: u64, strong: bool) {
> +        let mut inner = self.inner.lock();
> +        if let Ok(Some(node)) = inner.get_existing_node(ptr, cookie) {
> +            inner.update_node_refcount(&node, false, strong, 1, None);
> +        }
> +    }
> +
> +    pub(crate) fn inc_ref_done(&self, reader: &mut UserSliceReader, strong: bool) -> Result {
> +        let ptr = reader.read::<u64>()?;
> +        let cookie = reader.read::<u64>()?;
> +        let mut inner = self.inner.lock();
> +        if let Ok(Some(node)) = inner.get_existing_node(ptr, cookie) {
> +            if let Some(node) = node.inc_ref_done_locked(strong, &mut inner) {
> +                // This only fails if the process is dead.
> +                let _ = inner.push_work(node);
> +            }
> +        }
> +        Ok(())
> +    }
> +
> +    pub(crate) fn buffer_alloc(
> +        self: &Arc<Self>,
> +        debug_id: usize,
> +        size: usize,
> +        is_oneway: bool,
> +        from_pid: i32,
> +    ) -> BinderResult<NewAllocation> {
> +        use kernel::page::PAGE_SIZE;
> +
> +        let mut reserve_new_args = ReserveNewArgs {
> +            debug_id,
> +            size,
> +            is_oneway,
> +            pid: from_pid,
> +            ..ReserveNewArgs::default()
> +        };
> +
> +        let (new_alloc, addr) = loop {
> +            let mut inner = self.inner.lock();
> +            let mapping = inner.mapping.as_mut().ok_or_else(BinderError::new_dead)?;
> +            let alloc_request = match mapping.alloc.reserve_new(reserve_new_args)? {
> +                ReserveNew::Success(new_alloc) => break (new_alloc, mapping.address),
> +                ReserveNew::NeedAlloc(request) => request,
> +            };
> +            drop(inner);
> +            // We need to allocate memory and then call `reserve_new` again.
> +            reserve_new_args = alloc_request.make_alloc()?;
> +        };
> +
> +        let res = Allocation::new(
> +            self.clone(),
> +            debug_id,
> +            new_alloc.offset,
> +            size,
> +            addr + new_alloc.offset,
> +            new_alloc.oneway_spam_detected,
> +        );
> +
> +        // This allocation will be marked as in use until the `Allocation` is used to free it.
> +        //
> +        // This method can't be called while holding a lock, so we release the lock first. It's
> +        // okay for several threads to use the method on the same index at the same time. In that
> +        // case, one of the calls will allocate the given page (if missing), and the other call
> +        // will wait for the other call to finish allocating the page.
> +        //
> +        // We will not call `stop_using_range` in parallel with this on the same page, because the
> +        // allocation can only be removed via the destructor of the `Allocation` object that we
> +        // currently own.
> +        match self.pages.use_range(
> +            new_alloc.offset / PAGE_SIZE,
> +            (new_alloc.offset + size).div_ceil(PAGE_SIZE),
> +        ) {
> +            Ok(()) => {}
> +            Err(err) => {
> +                pr_warn!("use_range failure {:?}", err);
> +                return Err(err.into());
> +            }
> +        }
> +
> +        Ok(NewAllocation(res))
> +    }
> +
> +    pub(crate) fn buffer_get(self: &Arc<Self>, ptr: usize) -> Option<Allocation> {
> +        let mut inner = self.inner.lock();
> +        let mapping = inner.mapping.as_mut()?;
> +        let offset = ptr.checked_sub(mapping.address)?;
> +        let (size, debug_id, odata) = mapping.alloc.reserve_existing(offset).ok()?;
> +        let mut alloc = Allocation::new(self.clone(), debug_id, offset, size, ptr, false);
> +        if let Some(data) = odata {
> +            alloc.set_info(data);
> +        }
> +        Some(alloc)
> +    }
> +
> +    pub(crate) fn buffer_raw_free(&self, ptr: usize) {
> +        let mut inner = self.inner.lock();
> +        if let Some(ref mut mapping) = &mut inner.mapping {
> +            let offset = match ptr.checked_sub(mapping.address) {
> +                Some(offset) => offset,
> +                None => return,
> +            };
> +
> +            let freed_range = match mapping.alloc.reservation_abort(offset) {
> +                Ok(freed_range) => freed_range,
> +                Err(_) => {
> +                    pr_warn!(
> +                        "Pointer {:x} failed to free, base = {:x}\n",
> +                        ptr,
> +                        mapping.address
> +                    );
> +                    return;
> +                }
> +            };
> +
> +            // No more allocations in this range. Mark them as not in use.
> +            //
> +            // Must be done before we release the lock so that `use_range` is not used on these
> +            // indices until `stop_using_range` returns.
> +            self.pages
> +                .stop_using_range(freed_range.start_page_idx, freed_range.end_page_idx);
> +        }
> +    }
> +
> +    pub(crate) fn buffer_make_freeable(&self, offset: usize, mut data: Option<AllocationInfo>) {
> +        let mut inner = self.inner.lock();
> +        if let Some(ref mut mapping) = &mut inner.mapping {
> +            if mapping.alloc.reservation_commit(offset, &mut data).is_err() {
> +                pr_warn!("Offset {} failed to be marked freeable\n", offset);
> +            }
> +        }
> +    }
> +
> +    fn create_mapping(&self, vma: &mm::virt::VmaNew) -> Result {
> +        use kernel::page::PAGE_SIZE;
> +        let size = usize::min(vma.end() - vma.start(), bindings::SZ_4M as usize);
> +        let mapping = Mapping::new(vma.start(), size);
> +        let page_count = self.pages.register_with_vma(vma)?;
> +        if page_count * PAGE_SIZE != size {
> +            return Err(EINVAL);
> +        }
> +
> +        // Save range allocator for later.
> +        self.inner.lock().mapping = Some(mapping);
> +
> +        Ok(())
> +    }
> +
> +    fn version(&self, data: UserSlice) -> Result {
> +        data.writer().write(&BinderVersion::current())
> +    }
> +
> +    pub(crate) fn register_thread(&self) -> bool {
> +        self.inner.lock().register_thread()
> +    }
> +
> +    fn remove_thread(&self, thread: Arc<Thread>) {
> +        self.inner.lock().threads.remove(&thread.id);
> +        thread.release();
> +    }
> +
> +    fn set_max_threads(&self, max: u32) {
> +        self.inner.lock().max_threads = max;
> +    }
> +
> +    fn set_oneway_spam_detection_enabled(&self, enabled: u32) {
> +        self.inner.lock().oneway_spam_detection_enabled = enabled != 0;
> +    }
> +
> +    pub(crate) fn is_oneway_spam_detection_enabled(&self) -> bool {
> +        self.inner.lock().oneway_spam_detection_enabled
> +    }
> +
> +    fn get_node_debug_info(&self, data: UserSlice) -> Result {
> +        let (mut reader, mut writer) = data.reader_writer();
> +
> +        // Read the starting point.
> +        let ptr = reader.read::<BinderNodeDebugInfo>()?.ptr;
> +        let mut out = BinderNodeDebugInfo::default();
> +
> +        {
> +            let inner = self.inner.lock();
> +            for (node_ptr, node) in &inner.nodes {
> +                if *node_ptr > ptr {
> +                    node.populate_debug_info(&mut out, &inner);
> +                    break;
> +                }
> +            }
> +        }
> +
> +        writer.write(&out)
> +    }
> +
> +    fn get_node_info_from_ref(&self, data: UserSlice) -> Result {
> +        let (mut reader, mut writer) = data.reader_writer();
> +        let mut out = reader.read::<BinderNodeInfoForRef>()?;
> +
> +        if out.strong_count != 0
> +            || out.weak_count != 0
> +            || out.reserved1 != 0
> +            || out.reserved2 != 0
> +            || out.reserved3 != 0
> +        {
> +            return Err(EINVAL);
> +        }
> +
> +        // Only the context manager is allowed to use this ioctl.
> +        if !self.inner.lock().is_manager {
> +            return Err(EPERM);
> +        }
> +
> +        {
> +            let mut node_refs = self.node_refs.lock();
> +            let node_info = node_refs.by_handle.get_mut(&out.handle).ok_or(ENOENT)?;
> +            let node_ref = node_info.node_ref();
> +            let owner_inner = node_ref.node.owner.inner.lock();
> +            node_ref.node.populate_counts(&mut out, &owner_inner);
> +        }
> +
> +        // Write the result back.
> +        writer.write(&out)
> +    }
> +
> +    pub(crate) fn needs_thread(&self) -> bool {
> +        let mut inner = self.inner.lock();
> +        let ret = inner.requested_thread_count == 0
> +            && inner.ready_threads.is_empty()
> +            && inner.started_thread_count < inner.max_threads;
> +        if ret {
> +            inner.requested_thread_count += 1
> +        }
> +        ret
> +    }
> +
> +    pub(crate) fn request_death(
> +        self: &Arc<Self>,
> +        reader: &mut UserSliceReader,
> +        thread: &Thread,
> +    ) -> Result {
> +        let handle: u32 = reader.read()?;
> +        let cookie: u64 = reader.read()?;
> +
> +        // Queue BR_ERROR if we can't allocate memory for the death notification.
> +        let death = UniqueArc::new_uninit(GFP_KERNEL).inspect_err(|_| {
> +            thread.push_return_work(BR_ERROR);
> +        })?;
> +        let mut refs = self.node_refs.lock();
> +        let Some(info) = refs.by_handle.get_mut(&handle) else {
> +            pr_warn!("BC_REQUEST_DEATH_NOTIFICATION invalid ref {handle}\n");
> +            return Ok(());
> +        };
> +
> +        // Nothing to do if there is already a death notification request for this handle.
> +        if info.death().is_some() {
> +            pr_warn!("BC_REQUEST_DEATH_NOTIFICATION death notification already set\n");
> +            return Ok(());
> +        }
> +
> +        let death = {
> +            let death_init = NodeDeath::new(info.node_ref().node.clone(), self.clone(), cookie);
> +            match death.pin_init_with(death_init) {
> +                Ok(death) => death,
> +                // error is infallible
> +                Err(err) => match err {},
> +            }
> +        };
> +
> +        // Register the death notification.
> +        {
> +            let owner = info.node_ref2().node.owner.clone();
> +            let mut owner_inner = owner.inner.lock();
> +            if owner_inner.is_dead {
> +                let death = Arc::from(death);
> +                *info.death() = Some(death.clone());
> +                drop(owner_inner);
> +                death.set_dead();
> +            } else {
> +                let death = ListArc::from(death);
> +                *info.death() = Some(death.clone_arc());
> +                info.node_ref().node.add_death(death, &mut owner_inner);
> +            }
> +        }
> +        Ok(())
> +    }
> +
> +    pub(crate) fn clear_death(&self, reader: &mut UserSliceReader, thread: &Thread) -> Result {
> +        let handle: u32 = reader.read()?;
> +        let cookie: u64 = reader.read()?;
> +
> +        let mut refs = self.node_refs.lock();
> +        let Some(info) = refs.by_handle.get_mut(&handle) else {
> +            pr_warn!("BC_CLEAR_DEATH_NOTIFICATION invalid ref {handle}\n");
> +            return Ok(());
> +        };
> +
> +        let Some(death) = info.death().take() else {
> +            pr_warn!("BC_CLEAR_DEATH_NOTIFICATION death notification not active\n");
> +            return Ok(());
> +        };
> +        if death.cookie != cookie {
> +            *info.death() = Some(death);
> +            pr_warn!("BC_CLEAR_DEATH_NOTIFICATION death notification cookie mismatch\n");
> +            return Ok(());
> +        }
> +
> +        // Update state and determine if we need to queue a work item. We only need to do it when
> +        // the node is not dead or if the user already completed the death notification.
> +        if death.set_cleared(false) {
> +            if let Some(death) = ListArc::try_from_arc_or_drop(death) {
> +                let _ = thread.push_work_if_looper(death);
> +            }
> +        }
> +
> +        Ok(())
> +    }
> +
> +    pub(crate) fn dead_binder_done(&self, cookie: u64, thread: &Thread) {
> +        if let Some(death) = self.inner.lock().pull_delivered_death(cookie) {
> +            death.set_notification_done(thread);
> +        }
> +    }
> +
> +    /// Locks the spinlock and move the `nodes` rbtree out.
> +    ///
> +    /// This allows you to iterate through `nodes` while also allowing you to give other parts of
> +    /// the codebase exclusive access to `ProcessInner`.
> +    pub(crate) fn lock_with_nodes(&self) -> WithNodes<'_> {
> +        let mut inner = self.inner.lock();
> +        WithNodes {
> +            nodes: take(&mut inner.nodes),
> +            inner,
> +        }
> +    }
> +
> +    fn deferred_flush(&self) {
> +        let inner = self.inner.lock();
> +        for thread in inner.threads.values() {
> +            thread.exit_looper();
> +        }
> +    }
> +
> +    fn deferred_release(self: Arc<Self>) {
> +        let is_manager = {
> +            let mut inner = self.inner.lock();
> +            inner.is_dead = true;
> +            inner.is_frozen = false;
> +            inner.sync_recv = false;
> +            inner.async_recv = false;
> +            inner.is_manager
> +        };
> +
> +        if is_manager {
> +            self.ctx.unset_manager_node();
> +        }
> +
> +        self.ctx.deregister_process(&self);
> +
> +        let binderfs_file = self.inner.lock().binderfs_file.take();
> +        drop(binderfs_file);
> +
> +        // Release threads.
> +        let threads = {
> +            let mut inner = self.inner.lock();
> +            let threads = take(&mut inner.threads);
> +            let ready = take(&mut inner.ready_threads);
> +            drop(inner);
> +            drop(ready);
> +
> +            for thread in threads.values() {
> +                thread.release();
> +            }
> +            threads
> +        };
> +
> +        // Release nodes.
> +        {
> +            while let Some(node) = {
> +                let mut lock = self.inner.lock();
> +                lock.nodes.cursor_front().map(|c| c.remove_current().1)
> +            } {
> +                node.to_key_value().1.release();
> +            }
> +        }
> +
> +        // Clean up death listeners and remove nodes from external node info lists.
> +        for info in self.node_refs.lock().by_handle.values_mut() {
> +            // SAFETY: We are removing the `NodeRefInfo` from the right node.
> +            unsafe { info.node_ref2().node.remove_node_info(info) };
> +
> +            // Remove all death notifications from the nodes (that belong to a different process).
> +            let death = if let Some(existing) = info.death().take() {
> +                existing
> +            } else {
> +                continue;
> +            };
> +            death.set_cleared(false);
> +        }
> +
> +        // Clean up freeze listeners.
> +        let freeze_listeners = take(&mut self.node_refs.lock().freeze_listeners);
> +        for listener in freeze_listeners.values() {
> +            listener.on_process_exit(&self);
> +        }
> +        drop(freeze_listeners);
> +
> +        // Release refs on foreign nodes.
> +        {
> +            let mut refs = self.node_refs.lock();
> +            let by_handle = take(&mut refs.by_handle);
> +            let by_node = take(&mut refs.by_node);
> +            drop(refs);
> +            drop(by_node);
> +            drop(by_handle);
> +        }
> +
> +        // Cancel all pending work items.
> +        while let Some(work) = self.get_work() {
> +            work.into_arc().cancel();
> +        }
> +
> +        let delivered_deaths = take(&mut self.inner.lock().delivered_deaths);
> +        drop(delivered_deaths);
> +
> +        // Free any resources kept alive by allocated buffers.
> +        let omapping = self.inner.lock().mapping.take();
> +        if let Some(mut mapping) = omapping {
> +            let address = mapping.address;
> +            mapping
> +                .alloc
> +                .take_for_each(|offset, size, debug_id, odata| {
> +                    let ptr = offset + address;
> +                    pr_warn!(
> +                        "{}: removing orphan mapping {offset}:{size}\n",
> +                        self.pid_in_current_ns()
> +                    );
> +                    let mut alloc =
> +                        Allocation::new(self.clone(), debug_id, offset, size, ptr, false);
> +                    if let Some(data) = odata {
> +                        alloc.set_info(data);
> +                    }
> +                    drop(alloc)
> +                });
> +        }
> +
> +        // calls to synchronize_rcu() in thread drop will happen here
> +        drop(threads);
> +    }
> +
> +    pub(crate) fn drop_outstanding_txn(&self) {
> +        let wake = {
> +            let mut inner = self.inner.lock();
> +            if inner.outstanding_txns == 0 {
> +                pr_err!("outstanding_txns underflow");
> +                return;
> +            }
> +            inner.outstanding_txns -= 1;
> +            inner.is_frozen && inner.outstanding_txns == 0
> +        };
> +
> +        if wake {
> +            self.freeze_wait.notify_all();
> +        }
> +    }
> +
> +    pub(crate) fn ioctl_freeze(&self, info: &BinderFreezeInfo) -> Result {
> +        if info.enable == 0 {
> +            let msgs = self.prepare_freeze_messages()?;
> +            let mut inner = self.inner.lock();
> +            inner.sync_recv = false;
> +            inner.async_recv = false;
> +            inner.is_frozen = false;
> +            drop(inner);
> +            msgs.send_messages();
> +            return Ok(());
> +        }
> +
> +        let mut inner = self.inner.lock();
> +        inner.sync_recv = false;
> +        inner.async_recv = false;
> +        inner.is_frozen = true;
> +
> +        if info.timeout_ms > 0 {
> +            let mut jiffies = kernel::time::msecs_to_jiffies(info.timeout_ms);
> +            while jiffies > 0 {
> +                if inner.outstanding_txns == 0 {
> +                    break;
> +                }
> +
> +                match self
> +                    .freeze_wait
> +                    .wait_interruptible_timeout(&mut inner, jiffies)
> +                {
> +                    CondVarTimeoutResult::Signal { .. } => {
> +                        inner.is_frozen = false;
> +                        return Err(ERESTARTSYS);
> +                    }
> +                    CondVarTimeoutResult::Woken { jiffies: remaining } => {
> +                        jiffies = remaining;
> +                    }
> +                    CondVarTimeoutResult::Timeout => {
> +                        jiffies = 0;
> +                    }
> +                }
> +            }
> +        }
> +
> +        if inner.txns_pending_locked() {
> +            inner.is_frozen = false;
> +            Err(EAGAIN)
> +        } else {
> +            drop(inner);
> +            match self.prepare_freeze_messages() {
> +                Ok(batch) => {
> +                    batch.send_messages();
> +                    Ok(())
> +                }
> +                Err(kernel::alloc::AllocError) => {
> +                    self.inner.lock().is_frozen = false;
> +                    Err(ENOMEM)
> +                }
> +            }
> +        }
> +    }
> +}
> +
> +fn get_frozen_status(data: UserSlice) -> Result {
> +    let (mut reader, mut writer) = data.reader_writer();
> +
> +    let mut info = reader.read::<BinderFrozenStatusInfo>()?;
> +    info.sync_recv = 0;
> +    info.async_recv = 0;
> +    let mut found = false;
> +
> +    for ctx in crate::context::get_all_contexts()? {
> +        ctx.for_each_proc(|proc| {
> +            if proc.task.pid() == info.pid as _ {
> +                found = true;
> +                let inner = proc.inner.lock();
> +                let txns_pending = inner.txns_pending_locked();
> +                info.async_recv |= inner.async_recv as u32;
> +                info.sync_recv |= inner.sync_recv as u32;
> +                info.sync_recv |= (txns_pending as u32) << 1;
> +            }
> +        });
> +    }
> +
> +    if found {
> +        writer.write(&info)?;
> +        Ok(())
> +    } else {
> +        Err(EINVAL)
> +    }
> +}
> +
> +fn ioctl_freeze(reader: &mut UserSliceReader) -> Result {
> +    let info = reader.read::<BinderFreezeInfo>()?;
> +
> +    // Very unlikely for there to be more than 3, since a process normally uses at most binder and
> +    // hwbinder.
> +    let mut procs = KVec::with_capacity(3, GFP_KERNEL)?;
> +
> +    let ctxs = crate::context::get_all_contexts()?;
> +    for ctx in ctxs {
> +        for proc in ctx.get_procs_with_pid(info.pid as i32)? {
> +            procs.push(proc, GFP_KERNEL)?;
> +        }
> +    }
> +
> +    for proc in procs {
> +        proc.ioctl_freeze(&info)?;
> +    }
> +    Ok(())
> +}
> +
> +/// The ioctl handler.
> +impl Process {
> +    /// Ioctls that are write-only from the perspective of userspace.
> +    ///
> +    /// The kernel will only read from the pointer that userspace provided to us.
> +    fn ioctl_write_only(
> +        this: ArcBorrow<'_, Process>,
> +        _file: &File,
> +        cmd: u32,
> +        reader: &mut UserSliceReader,
> +    ) -> Result {
> +        let thread = this.get_current_thread()?;
> +        match cmd {
> +            uapi::BINDER_SET_MAX_THREADS => this.set_max_threads(reader.read()?),
> +            uapi::BINDER_THREAD_EXIT => this.remove_thread(thread),
> +            uapi::BINDER_SET_CONTEXT_MGR => this.set_as_manager(None, &thread)?,
> +            uapi::BINDER_SET_CONTEXT_MGR_EXT => {
> +                this.set_as_manager(Some(reader.read()?), &thread)?
> +            }
> +            uapi::BINDER_ENABLE_ONEWAY_SPAM_DETECTION => {
> +                this.set_oneway_spam_detection_enabled(reader.read()?)
> +            }
> +            uapi::BINDER_FREEZE => ioctl_freeze(reader)?,
> +            _ => return Err(EINVAL),
> +        }
> +        Ok(())
> +    }
> +
> +    /// Ioctls that are read/write from the perspective of userspace.
> +    ///
> +    /// The kernel will both read from and write to the pointer that userspace provided to us.
> +    fn ioctl_write_read(
> +        this: ArcBorrow<'_, Process>,
> +        file: &File,
> +        cmd: u32,
> +        data: UserSlice,
> +    ) -> Result {
> +        let thread = this.get_current_thread()?;
> +        let blocking = (file.flags() & file::flags::O_NONBLOCK) == 0;
> +        match cmd {
> +            uapi::BINDER_WRITE_READ => thread.write_read(data, blocking)?,
> +            uapi::BINDER_GET_NODE_DEBUG_INFO => this.get_node_debug_info(data)?,
> +            uapi::BINDER_GET_NODE_INFO_FOR_REF => this.get_node_info_from_ref(data)?,
> +            uapi::BINDER_VERSION => this.version(data)?,
> +            uapi::BINDER_GET_FROZEN_INFO => get_frozen_status(data)?,
> +            uapi::BINDER_GET_EXTENDED_ERROR => thread.get_extended_error(data)?,
> +            _ => return Err(EINVAL),
> +        }
> +        Ok(())
> +    }
> +}
> +
> +/// The file operations supported by `Process`.
> +impl Process {
> +    pub(crate) fn open(ctx: ArcBorrow<'_, Context>, file: &File) -> Result<Arc<Process>> {
> +        Self::new(ctx.into(), ARef::from(file.cred()))
> +    }
> +
> +    pub(crate) fn release(this: Arc<Process>, _file: &File) {
> +        let binderfs_file;
> +        let should_schedule;
> +        {
> +            let mut inner = this.inner.lock();
> +            should_schedule = inner.defer_work == 0;
> +            inner.defer_work |= PROC_DEFER_RELEASE;
> +            binderfs_file = inner.binderfs_file.take();
> +        }
> +
> +        if should_schedule {
> +            // Ignore failures to schedule to the workqueue. Those just mean that we're already
> +            // scheduled for execution.
> +            let _ = workqueue::system().enqueue(this);
> +        }
> +
> +        drop(binderfs_file);
> +    }
> +
> +    pub(crate) fn flush(this: ArcBorrow<'_, Process>) -> Result {
> +        let should_schedule;
> +        {
> +            let mut inner = this.inner.lock();
> +            should_schedule = inner.defer_work == 0;
> +            inner.defer_work |= PROC_DEFER_FLUSH;
> +        }
> +
> +        if should_schedule {
> +            // Ignore failures to schedule to the workqueue. Those just mean that we're already
> +            // scheduled for execution.
> +            let _ = workqueue::system().enqueue(Arc::from(this));
> +        }
> +        Ok(())
> +    }
> +
> +    pub(crate) fn ioctl(this: ArcBorrow<'_, Process>, file: &File, cmd: u32, arg: usize) -> Result {
> +        use kernel::ioctl::{_IOC_DIR, _IOC_SIZE};
> +        use kernel::uapi::{_IOC_READ, _IOC_WRITE};
> +
> +        crate::trace::trace_ioctl(cmd, arg);
> +
> +        let user_slice = UserSlice::new(UserPtr::from_addr(arg), _IOC_SIZE(cmd));
> +
> +        const _IOC_READ_WRITE: u32 = _IOC_READ | _IOC_WRITE;
> +
> +        match _IOC_DIR(cmd) {
> +            _IOC_WRITE => Self::ioctl_write_only(this, file, cmd, &mut user_slice.reader()),
> +            _IOC_READ_WRITE => Self::ioctl_write_read(this, file, cmd, user_slice),
> +            _ => Err(EINVAL),
> +        }
> +    }
> +
> +    pub(crate) fn compat_ioctl(
> +        this: ArcBorrow<'_, Process>,
> +        file: &File,
> +        cmd: u32,
> +        arg: usize,
> +    ) -> Result {
> +        Self::ioctl(this, file, cmd, arg)
> +    }
> +
> +    pub(crate) fn mmap(
> +        this: ArcBorrow<'_, Process>,
> +        _file: &File,
> +        vma: &mm::virt::VmaNew,
> +    ) -> Result {
> +        // We don't allow mmap to be used in a different process.
> +        if !core::ptr::eq(kernel::current!().group_leader(), &*this.task) {
> +            return Err(EINVAL);
> +        }
> +        if vma.start() == 0 {
> +            return Err(EINVAL);
> +        }
> +
> +        vma.try_clear_maywrite().map_err(|_| EPERM)?;
> +        vma.set_dontcopy();
> +        vma.set_mixedmap();
> +
> +        // TODO: Set ops. We need to learn when the user unmaps so that we can stop using it.
> +        this.create_mapping(vma)
> +    }
> +
> +    pub(crate) fn poll(
> +        this: ArcBorrow<'_, Process>,
> +        file: &File,
> +        table: PollTable<'_>,
> +    ) -> Result<u32> {
> +        let thread = this.get_current_thread()?;
> +        let (from_proc, mut mask) = thread.poll(file, table);
> +        if mask == 0 && from_proc && !this.inner.lock().work.is_empty() {
> +            mask |= bindings::POLLIN;
> +        }
> +        Ok(mask)
> +    }
> +}
> +
> +/// Represents that a thread has registered with the `ready_threads` list of its process.
> +///
> +/// The destructor of this type will unregister the thread from the list of ready threads.
> +pub(crate) struct Registration<'a> {
> +    thread: &'a Arc<Thread>,
> +}
> +
> +impl<'a> Registration<'a> {
> +    fn new(thread: &'a Arc<Thread>, guard: &mut Guard<'_, ProcessInner, SpinLockBackend>) -> Self {
> +        assert!(core::ptr::eq(&thread.process.inner, guard.lock_ref()));
> +        // INVARIANT: We are pushing this thread to the right `ready_threads` list.
> +        if let Ok(list_arc) = ListArc::try_from_arc(thread.clone()) {
> +            guard.ready_threads.push_front(list_arc);
> +        } else {
> +            // It is an error to hit this branch, and it should not be reachable. We try to do
> +            // something reasonable when the failure path happens. Most likely, the thread in
> +            // question will sleep forever.
> +            pr_err!("Same thread registered with `ready_threads` twice.");
> +        }
> +        Self { thread }
> +    }
> +}
> +
> +impl Drop for Registration<'_> {
> +    fn drop(&mut self) {
> +        let mut inner = self.thread.process.inner.lock();
> +        // SAFETY: The thread has the invariant that we never push it to any other linked list than
> +        // the `ready_threads` list of its parent process. Therefore, the thread is either in that
> +        // list, or in no list.
> +        unsafe { inner.ready_threads.remove(self.thread) };
> +    }
> +}
> +
> +pub(crate) struct WithNodes<'a> {
> +    pub(crate) inner: Guard<'a, ProcessInner, SpinLockBackend>,
> +    pub(crate) nodes: RBTree<u64, DArc<Node>>,
> +}
> +
> +impl Drop for WithNodes<'_> {
> +    fn drop(&mut self) {
> +        core::mem::swap(&mut self.nodes, &mut self.inner.nodes);
> +        if self.nodes.iter().next().is_some() {
> +            pr_err!("nodes array was modified while using lock_with_nodes\n");
> +        }
> +    }
> +}
> +
> +pub(crate) enum GetWorkOrRegister<'a> {
> +    Work(DLArc<dyn DeliverToRead>),
> +    Register(Registration<'a>),
> +}
> diff --git a/drivers/android/binder/range_alloc/array.rs b/drivers/android/binder/range_alloc/array.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..07e1dec2ce630f57333f7bdb0670645dfc4ca0f3
> --- /dev/null
> +++ b/drivers/android/binder/range_alloc/array.rs
> @@ -0,0 +1,251 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2025 Google LLC.
> +
> +use kernel::{
> +    page::{PAGE_MASK, PAGE_SIZE},
> +    prelude::*,
> +    seq_file::SeqFile,
> +    seq_print,
> +    task::Pid,
> +};
> +
> +use crate::range_alloc::{DescriptorState, FreedRange, Range};
> +
> +/// Keeps track of allocations in a process' mmap.
> +///
> +/// Each process has an mmap where the data for incoming transactions will be placed. This struct
> +/// keeps track of allocations made in the mmap. For each allocation, we store a descriptor that
> +/// has metadata related to the allocation. We also keep track of available free space.
> +pub(super) struct ArrayRangeAllocator<T> {
> +    /// This stores all ranges that are allocated. Unlike the tree based allocator, we do *not*
> +    /// store the free ranges.
> +    ///
> +    /// Sorted by offset.
> +    pub(super) ranges: KVec<Range<T>>,
> +    size: usize,
> +    free_oneway_space: usize,
> +}
> +
> +struct FindEmptyRes {
> +    /// Which index in `ranges` should we insert the new range at?
> +    ///
> +    /// Inserting the new range at this index keeps `ranges` sorted.
> +    insert_at_idx: usize,
> +    /// Which offset should we insert the new range at?
> +    insert_at_offset: usize,
> +}
> +
> +impl<T> ArrayRangeAllocator<T> {
> +    pub(crate) fn new(size: usize, alloc: EmptyArrayAlloc<T>) -> Self {
> +        Self {
> +            ranges: alloc.ranges,
> +            size,
> +            free_oneway_space: size / 2,
> +        }
> +    }
> +
> +    pub(crate) fn free_oneway_space(&self) -> usize {
> +        self.free_oneway_space
> +    }
> +
> +    pub(crate) fn count_buffers(&self) -> usize {
> +        self.ranges.len()
> +    }
> +
> +    pub(crate) fn total_size(&self) -> usize {
> +        self.size
> +    }
> +
> +    pub(crate) fn is_full(&self) -> bool {
> +        self.ranges.len() == self.ranges.capacity()
> +    }
> +
> +    pub(crate) fn debug_print(&self, m: &SeqFile) -> Result<()> {
> +        for range in &self.ranges {
> +            seq_print!(
> +                m,
> +                "  buffer {}: {} size {} pid {} oneway {}",
> +                0,
> +                range.offset,
> +                range.size,
> +                range.state.pid(),
> +                range.state.is_oneway(),
> +            );
> +            if let DescriptorState::Reserved(_) = range.state {
> +                seq_print!(m, " reserved\n");
> +            } else {
> +                seq_print!(m, " allocated\n");
> +            }
> +        }
> +        Ok(())
> +    }
> +
> +    /// Find somewhere to put a new range.
> +    ///
> +    /// Unlike the tree implementation, we do not bother to find the smallest gap. The idea is that
> +    /// fragmentation isn't a big issue when we don't have many ranges.
> +    ///
> +    /// Returns the index that the new range should have in `self.ranges` after insertion.
> +    fn find_empty_range(&self, size: usize) -> Option<FindEmptyRes> {
> +        let after_last_range = self.ranges.last().map(Range::endpoint).unwrap_or(0);
> +
> +        if size <= self.total_size() - after_last_range {
> +            // We can put the range at the end, so just do that.
> +            Some(FindEmptyRes {
> +                insert_at_idx: self.ranges.len(),
> +                insert_at_offset: after_last_range,
> +            })
> +        } else {
> +            let mut end_of_prev = 0;
> +            for (i, range) in self.ranges.iter().enumerate() {
> +                // Does it fit before the i'th range?
> +                if size <= range.offset - end_of_prev {
> +                    return Some(FindEmptyRes {
> +                        insert_at_idx: i,
> +                        insert_at_offset: end_of_prev,
> +                    });
> +                }
> +                end_of_prev = range.endpoint();
> +            }
> +            None
> +        }
> +    }
> +
> +    pub(crate) fn reserve_new(
> +        &mut self,
> +        debug_id: usize,
> +        size: usize,
> +        is_oneway: bool,
> +        pid: Pid,
> +    ) -> Result<usize> {
> +        // Compute new value of free_oneway_space, which is set only on success.
> +        let new_oneway_space = if is_oneway {
> +            match self.free_oneway_space.checked_sub(size) {
> +                Some(new_oneway_space) => new_oneway_space,
> +                None => return Err(ENOSPC),
> +            }
> +        } else {
> +            self.free_oneway_space
> +        };
> +
> +        let FindEmptyRes {
> +            insert_at_idx,
> +            insert_at_offset,
> +        } = self.find_empty_range(size).ok_or(ENOSPC)?;
> +        self.free_oneway_space = new_oneway_space;
> +
> +        let new_range = Range {
> +            offset: insert_at_offset,
> +            size,
> +            state: DescriptorState::new(is_oneway, debug_id, pid),
> +        };
> +        // Insert the value at the given index to keep the array sorted.
> +        self.ranges
> +            .insert_within_capacity(insert_at_idx, new_range)
> +            .ok()
> +            .unwrap();
> +
> +        Ok(insert_at_offset)
> +    }
> +
> +    pub(crate) fn reservation_abort(&mut self, offset: usize) -> Result<FreedRange> {
> +        // This could use a binary search, but linear scans are usually faster for small arrays.
> +        let i = self
> +            .ranges
> +            .iter()
> +            .position(|range| range.offset == offset)
> +            .ok_or(EINVAL)?;
> +        let range = &self.ranges[i];
> +
> +        if let DescriptorState::Allocated(_) = range.state {
> +            return Err(EPERM);
> +        }
> +
> +        let size = range.size;
> +        let offset = range.offset;
> +
> +        if range.state.is_oneway() {
> +            self.free_oneway_space += size;
> +        }
> +
> +        // This computes the range of pages that are no longer used by *any* allocated range. The
> +        // caller will mark them as unused, which means that they can be freed if the system comes
> +        // under memory pressure.
> +        let mut freed_range = FreedRange::interior_pages(offset, size);
> +        #[expect(clippy::collapsible_if)] // reads better like this
> +        if offset % PAGE_SIZE != 0 {
> +            if i == 0 || self.ranges[i - 1].endpoint() <= (offset & PAGE_MASK) {
> +                freed_range.start_page_idx -= 1;
> +            }
> +        }
> +        if range.endpoint() % PAGE_SIZE != 0 {
> +            let page_after = (range.endpoint() & PAGE_MASK) + PAGE_SIZE;
> +            if i + 1 == self.ranges.len() || page_after <= self.ranges[i + 1].offset {
> +                freed_range.end_page_idx += 1;
> +            }
> +        }
> +
> +        self.ranges.remove(i)?;
> +        Ok(freed_range)
> +    }
> +
> +    pub(crate) fn reservation_commit(&mut self, offset: usize, data: &mut Option<T>) -> Result {
> +        // This could use a binary search, but linear scans are usually faster for small arrays.
> +        let range = self
> +            .ranges
> +            .iter_mut()
> +            .find(|range| range.offset == offset)
> +            .ok_or(ENOENT)?;
> +
> +        let DescriptorState::Reserved(reservation) = &range.state else {
> +            return Err(ENOENT);
> +        };
> +
> +        range.state = DescriptorState::Allocated(reservation.clone().allocate(data.take()));
> +        Ok(())
> +    }
> +
> +    pub(crate) fn reserve_existing(&mut self, offset: usize) -> Result<(usize, usize, Option<T>)> {
> +        // This could use a binary search, but linear scans are usually faster for small arrays.
> +        let range = self
> +            .ranges
> +            .iter_mut()
> +            .find(|range| range.offset == offset)
> +            .ok_or(ENOENT)?;
> +
> +        let DescriptorState::Allocated(allocation) = &mut range.state else {
> +            return Err(ENOENT);
> +        };
> +
> +        let data = allocation.take();
> +        let debug_id = allocation.reservation.debug_id;
> +        range.state = DescriptorState::Reserved(allocation.reservation.clone());
> +        Ok((range.size, debug_id, data))
> +    }
> +
> +    pub(crate) fn take_for_each<F: Fn(usize, usize, usize, Option<T>)>(&mut self, callback: F) {
> +        for range in self.ranges.iter_mut() {
> +            if let DescriptorState::Allocated(allocation) = &mut range.state {
> +                callback(
> +                    range.offset,
> +                    range.size,
> +                    allocation.reservation.debug_id,
> +                    allocation.data.take(),
> +                );
> +            }
> +        }
> +    }
> +}
> +
> +pub(crate) struct EmptyArrayAlloc<T> {
> +    ranges: KVec<Range<T>>,
> +}
> +
> +impl<T> EmptyArrayAlloc<T> {
> +    pub(crate) fn try_new(capacity: usize) -> Result<Self> {
> +        Ok(Self {
> +            ranges: KVec::with_capacity(capacity, GFP_KERNEL)?,
> +        })
> +    }
> +}
> diff --git a/drivers/android/binder/range_alloc/mod.rs b/drivers/android/binder/range_alloc/mod.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..2301e2bc1a1fcdd163a96ac5113d0fb48a72bb90
> --- /dev/null
> +++ b/drivers/android/binder/range_alloc/mod.rs
> @@ -0,0 +1,329 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2025 Google LLC.
> +
> +use kernel::{page::PAGE_SIZE, prelude::*, seq_file::SeqFile, task::Pid};
> +
> +mod tree;
> +use self::tree::{FromArrayAllocs, ReserveNewTreeAlloc, TreeRangeAllocator};
> +
> +mod array;
> +use self::array::{ArrayRangeAllocator, EmptyArrayAlloc};
> +
> +enum DescriptorState<T> {
> +    Reserved(Reservation),
> +    Allocated(Allocation<T>),
> +}
> +
> +impl<T> DescriptorState<T> {
> +    fn new(is_oneway: bool, debug_id: usize, pid: Pid) -> Self {
> +        DescriptorState::Reserved(Reservation {
> +            debug_id,
> +            is_oneway,
> +            pid,
> +        })
> +    }
> +
> +    fn pid(&self) -> Pid {
> +        match self {
> +            DescriptorState::Reserved(inner) => inner.pid,
> +            DescriptorState::Allocated(inner) => inner.reservation.pid,
> +        }
> +    }
> +
> +    fn is_oneway(&self) -> bool {
> +        match self {
> +            DescriptorState::Reserved(inner) => inner.is_oneway,
> +            DescriptorState::Allocated(inner) => inner.reservation.is_oneway,
> +        }
> +    }
> +}
> +
> +#[derive(Clone)]
> +struct Reservation {
> +    debug_id: usize,
> +    is_oneway: bool,
> +    pid: Pid,
> +}
> +
> +impl Reservation {
> +    fn allocate<T>(self, data: Option<T>) -> Allocation<T> {
> +        Allocation {
> +            data,
> +            reservation: self,
> +        }
> +    }
> +}
> +
> +struct Allocation<T> {
> +    reservation: Reservation,
> +    data: Option<T>,
> +}
> +
> +impl<T> Allocation<T> {
> +    fn deallocate(self) -> (Reservation, Option<T>) {
> +        (self.reservation, self.data)
> +    }
> +
> +    fn debug_id(&self) -> usize {
> +        self.reservation.debug_id
> +    }
> +
> +    fn take(&mut self) -> Option<T> {
> +        self.data.take()
> +    }
> +}
> +
> +/// The array implementation must switch to the tree if it wants to go beyond this number of
> +/// ranges.
> +const TREE_THRESHOLD: usize = 8;
> +
> +/// Represents a range of pages that have just become completely free.
> +#[derive(Copy, Clone)]
> +pub(crate) struct FreedRange {
> +    pub(crate) start_page_idx: usize,
> +    pub(crate) end_page_idx: usize,
> +}
> +
> +impl FreedRange {
> +    fn interior_pages(offset: usize, size: usize) -> FreedRange {
> +        FreedRange {
> +            // Divide round up
> +            start_page_idx: offset.div_ceil(PAGE_SIZE),
> +            // Divide round down
> +            end_page_idx: (offset + size) / PAGE_SIZE,
> +        }
> +    }
> +}
> +
> +struct Range<T> {
> +    offset: usize,
> +    size: usize,
> +    state: DescriptorState<T>,
> +}
> +
> +impl<T> Range<T> {
> +    fn endpoint(&self) -> usize {
> +        self.offset + self.size
> +    }
> +}
> +
> +pub(crate) struct RangeAllocator<T> {
> +    inner: Impl<T>,
> +}
> +
> +enum Impl<T> {
> +    Empty(usize),
> +    Array(ArrayRangeAllocator<T>),
> +    Tree(TreeRangeAllocator<T>),
> +}
> +
> +impl<T> RangeAllocator<T> {
> +    pub(crate) fn new(size: usize) -> Self {
> +        Self {
> +            inner: Impl::Empty(size),
> +        }
> +    }
> +
> +    pub(crate) fn free_oneway_space(&self) -> usize {
> +        match &self.inner {
> +            Impl::Empty(size) => size / 2,
> +            Impl::Array(array) => array.free_oneway_space(),
> +            Impl::Tree(tree) => tree.free_oneway_space(),
> +        }
> +    }
> +
> +    pub(crate) fn count_buffers(&self) -> usize {
> +        match &self.inner {
> +            Impl::Empty(_size) => 0,
> +            Impl::Array(array) => array.count_buffers(),
> +            Impl::Tree(tree) => tree.count_buffers(),
> +        }
> +    }
> +
> +    pub(crate) fn debug_print(&self, m: &SeqFile) -> Result<()> {
> +        match &self.inner {
> +            Impl::Empty(_size) => Ok(()),
> +            Impl::Array(array) => array.debug_print(m),
> +            Impl::Tree(tree) => tree.debug_print(m),
> +        }
> +    }
> +
> +    /// Try to reserve a new buffer, using the provided allocation if necessary.
> +    pub(crate) fn reserve_new(&mut self, mut args: ReserveNewArgs<T>) -> Result<ReserveNew<T>> {
> +        match &mut self.inner {
> +            Impl::Empty(size) => {
> +                let empty_array = match args.empty_array_alloc.take() {
> +                    Some(empty_array) => ArrayRangeAllocator::new(*size, empty_array),
> +                    None => {
> +                        return Ok(ReserveNew::NeedAlloc(ReserveNewNeedAlloc {
> +                            args,
> +                            need_empty_array_alloc: true,
> +                            need_new_tree_alloc: false,
> +                            need_tree_alloc: false,
> +                        }))
> +                    }
> +                };
> +
> +                self.inner = Impl::Array(empty_array);
> +                self.reserve_new(args)
> +            }
> +            Impl::Array(array) if array.is_full() => {
> +                let allocs = match args.new_tree_alloc {
> +                    Some(ref mut allocs) => allocs,
> +                    None => {
> +                        return Ok(ReserveNew::NeedAlloc(ReserveNewNeedAlloc {
> +                            args,
> +                            need_empty_array_alloc: false,
> +                            need_new_tree_alloc: true,
> +                            need_tree_alloc: true,
> +                        }))
> +                    }
> +                };
> +
> +                let new_tree =
> +                    TreeRangeAllocator::from_array(array.total_size(), &mut array.ranges, allocs);
> +
> +                self.inner = Impl::Tree(new_tree);
> +                self.reserve_new(args)
> +            }
> +            Impl::Array(array) => {
> +                let offset =
> +                    array.reserve_new(args.debug_id, args.size, args.is_oneway, args.pid)?;
> +                Ok(ReserveNew::Success(ReserveNewSuccess {
> +                    offset,
> +                    oneway_spam_detected: false,
> +                    _empty_array_alloc: args.empty_array_alloc,
> +                    _new_tree_alloc: args.new_tree_alloc,
> +                    _tree_alloc: args.tree_alloc,
> +                }))
> +            }
> +            Impl::Tree(tree) => {
> +                let alloc = match args.tree_alloc {
> +                    Some(alloc) => alloc,
> +                    None => {
> +                        return Ok(ReserveNew::NeedAlloc(ReserveNewNeedAlloc {
> +                            args,
> +                            need_empty_array_alloc: false,
> +                            need_new_tree_alloc: false,
> +                            need_tree_alloc: true,
> +                        }));
> +                    }
> +                };
> +                let (offset, oneway_spam_detected) =
> +                    tree.reserve_new(args.debug_id, args.size, args.is_oneway, args.pid, alloc)?;
> +                Ok(ReserveNew::Success(ReserveNewSuccess {
> +                    offset,
> +                    oneway_spam_detected,
> +                    _empty_array_alloc: args.empty_array_alloc,
> +                    _new_tree_alloc: args.new_tree_alloc,
> +                    _tree_alloc: None,
> +                }))
> +            }
> +        }
> +    }
> +
> +    /// Deletes the allocations at `offset`.
> +    pub(crate) fn reservation_abort(&mut self, offset: usize) -> Result<FreedRange> {
> +        match &mut self.inner {
> +            Impl::Empty(_size) => Err(EINVAL),
> +            Impl::Array(array) => array.reservation_abort(offset),
> +            Impl::Tree(tree) => {
> +                let freed_range = tree.reservation_abort(offset)?;
> +                if tree.is_empty() {
> +                    self.inner = Impl::Empty(tree.total_size());
> +                }
> +                Ok(freed_range)
> +            }
> +        }
> +    }
> +
> +    /// Called when an allocation is no longer in use by the kernel.
> +    ///
> +    /// The value in `data` will be stored, if any. A mutable reference is used to avoid dropping
> +    /// the `T` when an error is returned.
> +    pub(crate) fn reservation_commit(&mut self, offset: usize, data: &mut Option<T>) -> Result {
> +        match &mut self.inner {
> +            Impl::Empty(_size) => Err(EINVAL),
> +            Impl::Array(array) => array.reservation_commit(offset, data),
> +            Impl::Tree(tree) => tree.reservation_commit(offset, data),
> +        }
> +    }
> +
> +    /// Called when the kernel starts using an allocation.
> +    ///
> +    /// Returns the size of the existing entry and the data associated with it.
> +    pub(crate) fn reserve_existing(&mut self, offset: usize) -> Result<(usize, usize, Option<T>)> {
> +        match &mut self.inner {
> +            Impl::Empty(_size) => Err(EINVAL),
> +            Impl::Array(array) => array.reserve_existing(offset),
> +            Impl::Tree(tree) => tree.reserve_existing(offset),
> +        }
> +    }
> +
> +    /// Call the provided callback at every allocated region.
> +    ///
> +    /// This destroys the range allocator. Used only during shutdown.
> +    pub(crate) fn take_for_each<F: Fn(usize, usize, usize, Option<T>)>(&mut self, callback: F) {
> +        match &mut self.inner {
> +            Impl::Empty(_size) => {}
> +            Impl::Array(array) => array.take_for_each(callback),
> +            Impl::Tree(tree) => tree.take_for_each(callback),
> +        }
> +    }
> +}
> +
> +/// The arguments for `reserve_new`.
> +#[derive(Default)]
> +pub(crate) struct ReserveNewArgs<T> {
> +    pub(crate) size: usize,
> +    pub(crate) is_oneway: bool,
> +    pub(crate) debug_id: usize,
> +    pub(crate) pid: Pid,
> +    pub(crate) empty_array_alloc: Option<EmptyArrayAlloc<T>>,
> +    pub(crate) new_tree_alloc: Option<FromArrayAllocs<T>>,
> +    pub(crate) tree_alloc: Option<ReserveNewTreeAlloc<T>>,
> +}
> +
> +/// The return type of `ReserveNew`.
> +pub(crate) enum ReserveNew<T> {
> +    Success(ReserveNewSuccess<T>),
> +    NeedAlloc(ReserveNewNeedAlloc<T>),
> +}
> +
> +/// Returned by `reserve_new` when the reservation was successul.
> +pub(crate) struct ReserveNewSuccess<T> {
> +    pub(crate) offset: usize,
> +    pub(crate) oneway_spam_detected: bool,
> +
> +    // If the user supplied an allocation that we did not end up using, then we return it here.
> +    // The caller will kfree it outside of the lock.
> +    _empty_array_alloc: Option<EmptyArrayAlloc<T>>,
> +    _new_tree_alloc: Option<FromArrayAllocs<T>>,
> +    _tree_alloc: Option<ReserveNewTreeAlloc<T>>,
> +}
> +
> +/// Returned by `reserve_new` to request the caller to make an allocation before calling the method
> +/// again.
> +pub(crate) struct ReserveNewNeedAlloc<T> {
> +    args: ReserveNewArgs<T>,
> +    need_empty_array_alloc: bool,
> +    need_new_tree_alloc: bool,
> +    need_tree_alloc: bool,
> +}
> +
> +impl<T> ReserveNewNeedAlloc<T> {
> +    /// Make the necessary allocations for another call to `reserve_new`.
> +    pub(crate) fn make_alloc(mut self) -> Result<ReserveNewArgs<T>> {
> +        if self.need_empty_array_alloc && self.args.empty_array_alloc.is_none() {
> +            self.args.empty_array_alloc = Some(EmptyArrayAlloc::try_new(TREE_THRESHOLD)?);
> +        }
> +        if self.need_new_tree_alloc && self.args.new_tree_alloc.is_none() {
> +            self.args.new_tree_alloc = Some(FromArrayAllocs::try_new(TREE_THRESHOLD)?);
> +        }
> +        if self.need_tree_alloc && self.args.tree_alloc.is_none() {
> +            self.args.tree_alloc = Some(ReserveNewTreeAlloc::try_new()?);
> +        }
> +        Ok(self.args)
> +    }
> +}
> diff --git a/drivers/android/binder/range_alloc/tree.rs b/drivers/android/binder/range_alloc/tree.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..7b1a248fcb0269ca92792c3861973d4ea69ada1f
> --- /dev/null
> +++ b/drivers/android/binder/range_alloc/tree.rs
> @@ -0,0 +1,488 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2025 Google LLC.
> +
> +use kernel::{
> +    page::PAGE_SIZE,
> +    prelude::*,
> +    rbtree::{RBTree, RBTreeNode, RBTreeNodeReservation},
> +    seq_file::SeqFile,
> +    seq_print,
> +    task::Pid,
> +};
> +
> +use crate::range_alloc::{DescriptorState, FreedRange, Range};
> +
> +/// Keeps track of allocations in a process' mmap.
> +///
> +/// Each process has an mmap where the data for incoming transactions will be placed. This struct
> +/// keeps track of allocations made in the mmap. For each allocation, we store a descriptor that
> +/// has metadata related to the allocation. We also keep track of available free space.
> +pub(super) struct TreeRangeAllocator<T> {
> +    /// This collection contains descriptors for *both* ranges containing an allocation, *and* free
> +    /// ranges between allocations. The free ranges get merged, so there are never two free ranges
> +    /// next to each other.
> +    tree: RBTree<usize, Descriptor<T>>,
> +    /// Contains an entry for every free range in `self.tree`. This tree sorts the ranges by size,
> +    /// letting us look up the smallest range whose size is at least some lower bound.
> +    free_tree: RBTree<FreeKey, ()>,
> +    size: usize,
> +    free_oneway_space: usize,
> +}
> +
> +impl<T> TreeRangeAllocator<T> {
> +    pub(crate) fn from_array(
> +        size: usize,
> +        ranges: &mut KVec<Range<T>>,
> +        alloc: &mut FromArrayAllocs<T>,
> +    ) -> Self {
> +        let mut tree = TreeRangeAllocator {
> +            tree: RBTree::new(),
> +            free_tree: RBTree::new(),
> +            size,
> +            free_oneway_space: size / 2,
> +        };
> +
> +        let mut free_offset = 0;
> +        for range in ranges.drain_all() {
> +            let free_size = range.offset - free_offset;
> +            if free_size > 0 {
> +                let free_node = alloc.free_tree.pop().unwrap();
> +                tree.free_tree
> +                    .insert(free_node.into_node((free_size, free_offset), ()));
> +                let tree_node = alloc.tree.pop().unwrap();
> +                tree.tree.insert(
> +                    tree_node.into_node(free_offset, Descriptor::new(free_offset, free_size)),
> +                );
> +            }
> +            free_offset = range.endpoint();
> +
> +            if range.state.is_oneway() {
> +                tree.free_oneway_space = tree.free_oneway_space.saturating_sub(range.size);
> +            }
> +
> +            let free_res = alloc.free_tree.pop().unwrap();
> +            let tree_node = alloc.tree.pop().unwrap();
> +            let mut desc = Descriptor::new(range.offset, range.size);
> +            desc.state = Some((range.state, free_res));
> +            tree.tree.insert(tree_node.into_node(range.offset, desc));
> +        }
> +
> +        // After the last range, we may need a free range.
> +        if free_offset < size {
> +            let free_size = size - free_offset;
> +            let free_node = alloc.free_tree.pop().unwrap();
> +            tree.free_tree
> +                .insert(free_node.into_node((free_size, free_offset), ()));
> +            let tree_node = alloc.tree.pop().unwrap();
> +            tree.tree
> +                .insert(tree_node.into_node(free_offset, Descriptor::new(free_offset, free_size)));
> +        }
> +
> +        tree
> +    }
> +
> +    pub(crate) fn is_empty(&self) -> bool {
> +        let mut tree_iter = self.tree.values();
> +        // There's always at least one range, because index zero is either the start of a free or
> +        // allocated range.
> +        let first_value = tree_iter.next().unwrap();
> +        if tree_iter.next().is_some() {
> +            // There are never two free ranges next to each other, so if there is more than one
> +            // descriptor, then at least one of them must hold an allocated range.
> +            return false;
> +        }
> +        // There is only one descriptor. Return true if it is for a free range.
> +        first_value.state.is_none()
> +    }
> +
> +    pub(crate) fn total_size(&self) -> usize {
> +        self.size
> +    }
> +
> +    pub(crate) fn free_oneway_space(&self) -> usize {
> +        self.free_oneway_space
> +    }
> +
> +    pub(crate) fn count_buffers(&self) -> usize {
> +        self.tree
> +            .values()
> +            .filter(|desc| desc.state.is_some())
> +            .count()
> +    }
> +
> +    pub(crate) fn debug_print(&self, m: &SeqFile) -> Result<()> {
> +        for desc in self.tree.values() {
> +            let state = match &desc.state {
> +                Some(state) => &state.0,
> +                None => continue,
> +            };
> +            seq_print!(
> +                m,
> +                "  buffer: {} size {} pid {}",
> +                desc.offset,
> +                desc.size,
> +                state.pid(),
> +            );
> +            if state.is_oneway() {
> +                seq_print!(m, " oneway");
> +            }
> +            match state {
> +                DescriptorState::Reserved(_res) => {
> +                    seq_print!(m, " reserved\n");
> +                }
> +                DescriptorState::Allocated(_alloc) => {
> +                    seq_print!(m, " allocated\n");
> +                }
> +            }
> +        }
> +        Ok(())
> +    }
> +
> +    fn find_best_match(&mut self, size: usize) -> Option<&mut Descriptor<T>> {
> +        let free_cursor = self.free_tree.cursor_lower_bound(&(size, 0))?;
> +        let ((_, offset), ()) = free_cursor.current();
> +        self.tree.get_mut(offset)
> +    }
> +
> +    /// Try to reserve a new buffer, using the provided allocation if necessary.
> +    pub(crate) fn reserve_new(
> +        &mut self,
> +        debug_id: usize,
> +        size: usize,
> +        is_oneway: bool,
> +        pid: Pid,
> +        alloc: ReserveNewTreeAlloc<T>,
> +    ) -> Result<(usize, bool)> {
> +        // Compute new value of free_oneway_space, which is set only on success.
> +        let new_oneway_space = if is_oneway {
> +            match self.free_oneway_space.checked_sub(size) {
> +                Some(new_oneway_space) => new_oneway_space,
> +                None => return Err(ENOSPC),
> +            }
> +        } else {
> +            self.free_oneway_space
> +        };
> +
> +        // Start detecting spammers once we have less than 20%
> +        // of async space left (which is less than 10% of total
> +        // buffer size).
> +        //
> +        // (This will short-circut, so `low_oneway_space` is
> +        // only called when necessary.)
> +        let oneway_spam_detected =
> +            is_oneway && new_oneway_space < self.size / 10 && self.low_oneway_space(pid);
> +
> +        let (found_size, found_off, tree_node, free_tree_node) = match self.find_best_match(size) {
> +            None => {
> +                pr_warn!("ENOSPC from range_alloc.reserve_new - size: {}", size);
> +                return Err(ENOSPC);
> +            }
> +            Some(desc) => {
> +                let found_size = desc.size;
> +                let found_offset = desc.offset;
> +
> +                // In case we need to break up the descriptor
> +                let new_desc = Descriptor::new(found_offset + size, found_size - size);
> +                let (tree_node, free_tree_node, desc_node_res) = alloc.initialize(new_desc);
> +
> +                desc.state = Some((
> +                    DescriptorState::new(is_oneway, debug_id, pid),
> +                    desc_node_res,
> +                ));
> +                desc.size = size;
> +
> +                (found_size, found_offset, tree_node, free_tree_node)
> +            }
> +        };
> +        self.free_oneway_space = new_oneway_space;
> +        self.free_tree.remove(&(found_size, found_off));
> +
> +        if found_size != size {
> +            self.tree.insert(tree_node);
> +            self.free_tree.insert(free_tree_node);
> +        }
> +
> +        Ok((found_off, oneway_spam_detected))
> +    }
> +
> +    pub(crate) fn reservation_abort(&mut self, offset: usize) -> Result<FreedRange> {
> +        let mut cursor = self.tree.cursor_lower_bound(&offset).ok_or_else(|| {
> +            pr_warn!(
> +                "EINVAL from range_alloc.reservation_abort - offset: {}",
> +                offset
> +            );
> +            EINVAL
> +        })?;
> +
> +        let (_, desc) = cursor.current_mut();
> +
> +        if desc.offset != offset {
> +            pr_warn!(
> +                "EINVAL from range_alloc.reservation_abort - offset: {}",
> +                offset
> +            );
> +            return Err(EINVAL);
> +        }
> +
> +        let (reservation, free_node_res) = desc.try_change_state(|state| match state {
> +            Some((DescriptorState::Reserved(reservation), free_node_res)) => {
> +                (None, Ok((reservation, free_node_res)))
> +            }
> +            None => {
> +                pr_warn!(
> +                    "EINVAL from range_alloc.reservation_abort - offset: {}",
> +                    offset
> +                );
> +                (None, Err(EINVAL))
> +            }
> +            allocated => {
> +                pr_warn!(
> +                    "EPERM from range_alloc.reservation_abort - offset: {}",
> +                    offset
> +                );
> +                (allocated, Err(EPERM))
> +            }
> +        })?;
> +
> +        let mut size = desc.size;
> +        let mut offset = desc.offset;
> +        let free_oneway_space_add = if reservation.is_oneway { size } else { 0 };
> +
> +        self.free_oneway_space += free_oneway_space_add;
> +
> +        let mut freed_range = FreedRange::interior_pages(offset, size);
> +        // Compute how large the next free region needs to be to include one more page in
> +        // the newly freed range.
> +        let add_next_page_needed = match (offset + size) % PAGE_SIZE {
> +            0 => usize::MAX,
> +            unalign => PAGE_SIZE - unalign,
> +        };
> +        // Compute how large the previous free region needs to be to include one more page
> +        // in the newly freed range.
> +        let add_prev_page_needed = match offset % PAGE_SIZE {
> +            0 => usize::MAX,
> +            unalign => unalign,
> +        };
> +
> +        // Merge next into current if next is free
> +        let remove_next = match cursor.peek_next() {
> +            Some((_, next)) if next.state.is_none() => {
> +                if next.size >= add_next_page_needed {
> +                    freed_range.end_page_idx += 1;
> +                }
> +                self.free_tree.remove(&(next.size, next.offset));
> +                size += next.size;
> +                true
> +            }
> +            _ => false,
> +        };
> +
> +        if remove_next {
> +            let (_, desc) = cursor.current_mut();
> +            desc.size = size;
> +            cursor.remove_next();
> +        }
> +
> +        // Merge current into prev if prev is free
> +        match cursor.peek_prev_mut() {
> +            Some((_, prev)) if prev.state.is_none() => {
> +                if prev.size >= add_prev_page_needed {
> +                    freed_range.start_page_idx -= 1;
> +                }
> +                // merge previous with current, remove current
> +                self.free_tree.remove(&(prev.size, prev.offset));
> +                offset = prev.offset;
> +                size += prev.size;
> +                prev.size = size;
> +                cursor.remove_current();
> +            }
> +            _ => {}
> +        };
> +
> +        self.free_tree
> +            .insert(free_node_res.into_node((size, offset), ()));
> +
> +        Ok(freed_range)
> +    }
> +
> +    pub(crate) fn reservation_commit(&mut self, offset: usize, data: &mut Option<T>) -> Result {
> +        let desc = self.tree.get_mut(&offset).ok_or(ENOENT)?;
> +
> +        desc.try_change_state(|state| match state {
> +            Some((DescriptorState::Reserved(reservation), free_node_res)) => (
> +                Some((
> +                    DescriptorState::Allocated(reservation.allocate(data.take())),
> +                    free_node_res,
> +                )),
> +                Ok(()),
> +            ),
> +            other => (other, Err(ENOENT)),
> +        })
> +    }
> +
> +    /// Takes an entry at the given offset from [`DescriptorState::Allocated`] to
> +    /// [`DescriptorState::Reserved`].
> +    ///
> +    /// Returns the size of the existing entry and the data associated with it.
> +    pub(crate) fn reserve_existing(&mut self, offset: usize) -> Result<(usize, usize, Option<T>)> {
> +        let desc = self.tree.get_mut(&offset).ok_or_else(|| {
> +            pr_warn!(
> +                "ENOENT from range_alloc.reserve_existing - offset: {}",
> +                offset
> +            );
> +            ENOENT
> +        })?;
> +
> +        let (debug_id, data) = desc.try_change_state(|state| match state {
> +            Some((DescriptorState::Allocated(allocation), free_node_res)) => {
> +                let (reservation, data) = allocation.deallocate();
> +                let debug_id = reservation.debug_id;
> +                (
> +                    Some((DescriptorState::Reserved(reservation), free_node_res)),
> +                    Ok((debug_id, data)),
> +                )
> +            }
> +            other => {
> +                pr_warn!(
> +                    "ENOENT from range_alloc.reserve_existing - offset: {}",
> +                    offset
> +                );
> +                (other, Err(ENOENT))
> +            }
> +        })?;
> +
> +        Ok((desc.size, debug_id, data))
> +    }
> +
> +    /// Call the provided callback at every allocated region.
> +    ///
> +    /// This destroys the range allocator. Used only during shutdown.
> +    pub(crate) fn take_for_each<F: Fn(usize, usize, usize, Option<T>)>(&mut self, callback: F) {
> +        for (_, desc) in self.tree.iter_mut() {
> +            if let Some((DescriptorState::Allocated(allocation), _)) = &mut desc.state {
> +                callback(
> +                    desc.offset,
> +                    desc.size,
> +                    allocation.debug_id(),
> +                    allocation.take(),
> +                );
> +            }
> +        }
> +    }
> +
> +    /// Find the amount and size of buffers allocated by the current caller.
> +    ///
> +    /// The idea is that once we cross the threshold, whoever is responsible
> +    /// for the low async space is likely to try to send another async transaction,
> +    /// and at some point we'll catch them in the act.  This is more efficient
> +    /// than keeping a map per pid.
> +    fn low_oneway_space(&self, calling_pid: Pid) -> bool {
> +        let mut total_alloc_size = 0;
> +        let mut num_buffers = 0;
> +        for (_, desc) in self.tree.iter() {
> +            if let Some((state, _)) = &desc.state {
> +                if state.is_oneway() && state.pid() == calling_pid {
> +                    total_alloc_size += desc.size;
> +                    num_buffers += 1;
> +                }
> +            }
> +        }
> +
> +        // Warn if this pid has more than 50 transactions, or more than 50% of
> +        // async space (which is 25% of total buffer size). Oneway spam is only
> +        // detected when the threshold is exceeded.
> +        num_buffers > 50 || total_alloc_size > self.size / 4
> +    }
> +}
> +
> +type TreeDescriptorState<T> = (DescriptorState<T>, FreeNodeRes);
> +struct Descriptor<T> {
> +    size: usize,
> +    offset: usize,
> +    state: Option<TreeDescriptorState<T>>,
> +}
> +
> +impl<T> Descriptor<T> {
> +    fn new(offset: usize, size: usize) -> Self {
> +        Self {
> +            size,
> +            offset,
> +            state: None,
> +        }
> +    }
> +
> +    fn try_change_state<F, Data>(&mut self, f: F) -> Result<Data>
> +    where
> +        F: FnOnce(Option<TreeDescriptorState<T>>) -> (Option<TreeDescriptorState<T>>, Result<Data>),
> +    {
> +        let (new_state, result) = f(self.state.take());
> +        self.state = new_state;
> +        result
> +    }
> +}
> +
> +// (Descriptor.size, Descriptor.offset)
> +type FreeKey = (usize, usize);
> +type FreeNodeRes = RBTreeNodeReservation<FreeKey, ()>;
> +
> +/// An allocation for use by `reserve_new`.
> +pub(crate) struct ReserveNewTreeAlloc<T> {
> +    tree_node_res: RBTreeNodeReservation<usize, Descriptor<T>>,
> +    free_tree_node_res: FreeNodeRes,
> +    desc_node_res: FreeNodeRes,
> +}
> +
> +impl<T> ReserveNewTreeAlloc<T> {
> +    pub(crate) fn try_new() -> Result<Self> {
> +        let tree_node_res = RBTreeNodeReservation::new(GFP_KERNEL)?;
> +        let free_tree_node_res = RBTreeNodeReservation::new(GFP_KERNEL)?;
> +        let desc_node_res = RBTreeNodeReservation::new(GFP_KERNEL)?;
> +        Ok(Self {
> +            tree_node_res,
> +            free_tree_node_res,
> +            desc_node_res,
> +        })
> +    }
> +
> +    fn initialize(
> +        self,
> +        desc: Descriptor<T>,
> +    ) -> (
> +        RBTreeNode<usize, Descriptor<T>>,
> +        RBTreeNode<FreeKey, ()>,
> +        FreeNodeRes,
> +    ) {
> +        let size = desc.size;
> +        let offset = desc.offset;
> +        (
> +            self.tree_node_res.into_node(offset, desc),
> +            self.free_tree_node_res.into_node((size, offset), ()),
> +            self.desc_node_res,
> +        )
> +    }
> +}
> +
> +/// An allocation for creating a tree from an `ArrayRangeAllocator`.
> +pub(crate) struct FromArrayAllocs<T> {
> +    tree: KVec<RBTreeNodeReservation<usize, Descriptor<T>>>,
> +    free_tree: KVec<RBTreeNodeReservation<FreeKey, ()>>,
> +}
> +
> +impl<T> FromArrayAllocs<T> {
> +    pub(crate) fn try_new(len: usize) -> Result<Self> {
> +        let num_descriptors = 2 * len + 1;
> +
> +        let mut tree = KVec::with_capacity(num_descriptors, GFP_KERNEL)?;
> +        for _ in 0..num_descriptors {
> +            tree.push(RBTreeNodeReservation::new(GFP_KERNEL)?, GFP_KERNEL)?;
> +        }
> +
> +        let mut free_tree = KVec::with_capacity(num_descriptors, GFP_KERNEL)?;
> +        for _ in 0..num_descriptors {
> +            free_tree.push(RBTreeNodeReservation::new(GFP_KERNEL)?, GFP_KERNEL)?;
> +        }
> +
> +        Ok(Self { tree, free_tree })
> +    }
> +}
> diff --git a/drivers/android/binder/rust_binder.h b/drivers/android/binder/rust_binder.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..31806890ed1a278793ae7178f9d76ca4d591a954
> --- /dev/null
> +++ b/drivers/android/binder/rust_binder.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2025 Google, Inc.
> + */
> +
> +#ifndef _LINUX_RUST_BINDER_H
> +#define _LINUX_RUST_BINDER_H
> +
> +#include <uapi/linux/android/binder.h>
> +#include <uapi/linux/android/binderfs.h>
> +
> +/*
> + * These symbols are exposed by `rust_binderfs.c` and exist here so that Rust
> + * Binder can call them.
> + */
> +int init_rust_binderfs(void);
> +
> +struct dentry;
> +struct inode;
> +struct dentry *rust_binderfs_create_proc_file(struct inode *nodp, int pid);
> +void rust_binderfs_remove_file(struct dentry *dentry);
> +
> +#endif
> diff --git a/drivers/android/binder/rust_binder_events.c b/drivers/android/binder/rust_binder_events.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..488b1470060cc43f24345e9c32336134f96b0da0
> --- /dev/null
> +++ b/drivers/android/binder/rust_binder_events.c
> @@ -0,0 +1,59 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* rust_binder_events.c
> + *
> + * Rust Binder tracepoints.
> + *
> + * Copyright 2025 Google LLC
> + */
> +
> +#include "rust_binder.h"
> +
> +const char * const binder_command_strings[] = {
> +	"BC_TRANSACTION",
> +	"BC_REPLY",
> +	"BC_ACQUIRE_RESULT",
> +	"BC_FREE_BUFFER",
> +	"BC_INCREFS",
> +	"BC_ACQUIRE",
> +	"BC_RELEASE",
> +	"BC_DECREFS",
> +	"BC_INCREFS_DONE",
> +	"BC_ACQUIRE_DONE",
> +	"BC_ATTEMPT_ACQUIRE",
> +	"BC_REGISTER_LOOPER",
> +	"BC_ENTER_LOOPER",
> +	"BC_EXIT_LOOPER",
> +	"BC_REQUEST_DEATH_NOTIFICATION",
> +	"BC_CLEAR_DEATH_NOTIFICATION",
> +	"BC_DEAD_BINDER_DONE",
> +	"BC_TRANSACTION_SG",
> +	"BC_REPLY_SG",
> +};
> +
> +const char * const binder_return_strings[] = {
> +	"BR_ERROR",
> +	"BR_OK",
> +	"BR_TRANSACTION",
> +	"BR_REPLY",
> +	"BR_ACQUIRE_RESULT",
> +	"BR_DEAD_REPLY",
> +	"BR_TRANSACTION_COMPLETE",
> +	"BR_INCREFS",
> +	"BR_ACQUIRE",
> +	"BR_RELEASE",
> +	"BR_DECREFS",
> +	"BR_ATTEMPT_ACQUIRE",
> +	"BR_NOOP",
> +	"BR_SPAWN_LOOPER",
> +	"BR_FINISHED",
> +	"BR_DEAD_BINDER",
> +	"BR_CLEAR_DEATH_NOTIFICATION_DONE",
> +	"BR_FAILED_REPLY",
> +	"BR_FROZEN_REPLY",
> +	"BR_ONEWAY_SPAM_SUSPECT",
> +	"BR_TRANSACTION_PENDING_FROZEN"
> +};
> +
> +#define CREATE_TRACE_POINTS
> +#define CREATE_RUST_TRACE_POINTS
> +#include "rust_binder_events.h"
> diff --git a/drivers/android/binder/rust_binder_events.h b/drivers/android/binder/rust_binder_events.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..2f3efbf9dba68e6415f0f09ff5c8255dc5c5bc00
> --- /dev/null
> +++ b/drivers/android/binder/rust_binder_events.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2025 Google, Inc.
> + */
> +
> +#undef TRACE_SYSTEM
> +#undef TRACE_INCLUDE_FILE
> +#undef TRACE_INCLUDE_PATH
> +#define TRACE_SYSTEM rust_binder
> +#define TRACE_INCLUDE_FILE rust_binder_events
> +#define TRACE_INCLUDE_PATH ../drivers/android/binder
> +
> +#if !defined(_RUST_BINDER_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _RUST_BINDER_TRACE_H
> +
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(rust_binder_ioctl,
> +	TP_PROTO(unsigned int cmd, unsigned long arg),
> +	TP_ARGS(cmd, arg),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned int, cmd)
> +		__field(unsigned long, arg)
> +	),
> +	TP_fast_assign(
> +		__entry->cmd = cmd;
> +		__entry->arg = arg;
> +	),
> +	TP_printk("cmd=0x%x arg=0x%lx", __entry->cmd, __entry->arg)
> +);
> +
> +#endif /* _RUST_BINDER_TRACE_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/drivers/android/binder/rust_binder_internal.h b/drivers/android/binder/rust_binder_internal.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..78288fe7964d804205105889db3918bd7fa51623
> --- /dev/null
> +++ b/drivers/android/binder/rust_binder_internal.h
> @@ -0,0 +1,87 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* rust_binder_internal.h
> + *
> + * This file contains internal data structures used by Rust Binder. Mostly,
> + * these are type definitions used only by binderfs or things that Rust Binder
> + * define and export to binderfs.
> + *
> + * It does not include things exported by binderfs to Rust Binder since this
> + * file is not included as input to bindgen.
> + *
> + * Copyright (C) 2025 Google LLC.
> + */
> +
> +#ifndef _LINUX_RUST_BINDER_INTERNAL_H
> +#define _LINUX_RUST_BINDER_INTERNAL_H
> +
> +#define RUST_BINDERFS_SUPER_MAGIC	0x6c6f6f71
> +
> +#include <linux/seq_file.h>
> +#include <uapi/linux/android/binder.h>
> +#include <uapi/linux/android/binderfs.h>
> +
> +/*
> + * The internal data types in the Rust Binder driver are opaque to C, so we use
> + * void pointer typedefs for these types.
> + */
> +typedef void *rust_binder_context;
> +
> +/**
> + * struct binder_device - information about a binder device node
> + * @minor:     the minor number used by this device
> + * @ctx:       the Rust Context used by this device, or null for binder-control
> + *
> + * This is used as the private data for files directly in binderfs, but not
> + * files in the binder_logs subdirectory. This struct owns a refcount on `ctx`
> + * and the entry for `minor` in `binderfs_minors`. For binder-control `ctx` is
> + * null.
> + */
> +struct binder_device {
> +	int minor;
> +	rust_binder_context ctx;
> +};
> +
> +int rust_binder_stats_show(struct seq_file *m, void *unused);
> +int rust_binder_state_show(struct seq_file *m, void *unused);
> +int rust_binder_transactions_show(struct seq_file *m, void *unused);
> +int rust_binder_proc_show(struct seq_file *m, void *pid);
> +
> +extern const struct file_operations rust_binder_fops;
> +rust_binder_context rust_binder_new_context(char *name);
> +void rust_binder_remove_context(rust_binder_context device);
> +
> +/**
> + * binderfs_mount_opts - mount options for binderfs
> + * @max: maximum number of allocatable binderfs binder devices
> + * @stats_mode: enable binder stats in binderfs.
> + */
> +struct binderfs_mount_opts {
> +	int max;
> +	int stats_mode;
> +};
> +
> +/**
> + * binderfs_info - information about a binderfs mount
> + * @ipc_ns:         The ipc namespace the binderfs mount belongs to.
> + * @control_dentry: This records the dentry of this binderfs mount
> + *                  binder-control device.
> + * @root_uid:       uid that needs to be used when a new binder device is
> + *                  created.
> + * @root_gid:       gid that needs to be used when a new binder device is
> + *                  created.
> + * @mount_opts:     The mount options in use.
> + * @device_count:   The current number of allocated binder devices.
> + * @proc_log_dir:   Pointer to the directory dentry containing process-specific
> + *                  logs.
> + */
> +struct binderfs_info {
> +	struct ipc_namespace *ipc_ns;
> +	struct dentry *control_dentry;
> +	kuid_t root_uid;
> +	kgid_t root_gid;
> +	struct binderfs_mount_opts mount_opts;
> +	int device_count;
> +	struct dentry *proc_log_dir;
> +};
> +
> +#endif /* _LINUX_RUST_BINDER_INTERNAL_H */
> diff --git a/drivers/android/binder/rust_binder_main.rs b/drivers/android/binder/rust_binder_main.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..6773b7c273ec9634057300954d67b51ca9b54f6f
> --- /dev/null
> +++ b/drivers/android/binder/rust_binder_main.rs
> @@ -0,0 +1,627 @@
> +// SPDX-License-Identifier: GPL-2.0

I'm not sure if all these need to be "GPL-2.0-only" explicitly?

> +
> +// Copyright (C) 2025 Google LLC.
> +
> +//! Binder -- the Android IPC mechanism.
> +#![recursion_limit = "256"]
> +#![allow(
> +    clippy::as_underscore,
> +    clippy::ref_as_ptr,
> +    clippy::ptr_as_ptr,
> +    clippy::cast_lossless
> +)]
> +
> +use kernel::{
> +    bindings::{self, seq_file},
> +    fs::File,
> +    list::{ListArc, ListArcSafe, ListLinksSelfPtr, TryNewListArc},
> +    prelude::*,
> +    seq_file::SeqFile,
> +    seq_print,
> +    sync::poll::PollTable,
> +    sync::Arc,
> +    task::Pid,
> +    transmute::AsBytes,
> +    types::ForeignOwnable,
> +    uaccess::UserSliceWriter,
> +};
> +
> +use crate::{context::Context, page_range::Shrinker, process::Process, thread::Thread};
> +
> +use core::{
> +    ptr::NonNull,
> +    sync::atomic::{AtomicBool, AtomicUsize, Ordering},
> +};
> +
> +mod allocation;
> +mod context;
> +mod deferred_close;
> +mod defs;
> +mod error;
> +mod node;
> +mod page_range;
> +mod process;
> +mod range_alloc;
> +mod stats;
> +mod thread;
> +mod trace;
> +mod transaction;
> +
> +#[allow(warnings)] // generated bindgen code
> +mod binderfs {
> +    use kernel::bindings::{dentry, inode};
> +
> +    extern "C" {
> +        pub fn init_rust_binderfs() -> kernel::ffi::c_int;
> +    }
> +    extern "C" {
> +        pub fn rust_binderfs_create_proc_file(
> +            nodp: *mut inode,
> +            pid: kernel::ffi::c_int,
> +        ) -> *mut dentry;
> +    }
> +    extern "C" {
> +        pub fn rust_binderfs_remove_file(dentry: *mut dentry);
> +    }
> +    pub type rust_binder_context = *mut kernel::ffi::c_void;
> +    #[repr(C)]
> +    #[derive(Copy, Clone)]
> +    pub struct binder_device {
> +        pub minor: kernel::ffi::c_int,
> +        pub ctx: rust_binder_context,
> +    }
> +    impl Default for binder_device {
> +        fn default() -> Self {
> +            let mut s = ::core::mem::MaybeUninit::<Self>::uninit();
> +            unsafe {
> +                ::core::ptr::write_bytes(s.as_mut_ptr(), 0, 1);
> +                s.assume_init()
> +            }
> +        }
> +    }
> +}
> +
> +module! {
> +    type: BinderModule,
> +    name: "rust_binder",
> +    authors: ["Wedson Almeida Filho", "Alice Ryhl"],
> +    description: "Android Binder",
> +    license: "GPL",
> +}
> +
> +fn next_debug_id() -> usize {
> +    static NEXT_DEBUG_ID: AtomicUsize = AtomicUsize::new(0);
> +
> +    NEXT_DEBUG_ID.fetch_add(1, Ordering::Relaxed)
> +}
> +
> +/// Provides a single place to write Binder return values via the
> +/// supplied `UserSliceWriter`.
> +pub(crate) struct BinderReturnWriter<'a> {
> +    writer: UserSliceWriter,
> +    thread: &'a Thread,
> +}
> +
> +impl<'a> BinderReturnWriter<'a> {
> +    fn new(writer: UserSliceWriter, thread: &'a Thread) -> Self {
> +        BinderReturnWriter { writer, thread }
> +    }
> +
> +    /// Write a return code back to user space.
> +    /// Should be a `BR_` constant from [`defs`] e.g. [`defs::BR_TRANSACTION_COMPLETE`].
> +    fn write_code(&mut self, code: u32) -> Result {
> +        stats::GLOBAL_STATS.inc_br(code);
> +        self.thread.process.stats.inc_br(code);
> +        self.writer.write(&code)
> +    }
> +
> +    /// Write something *other than* a return code to user space.
> +    fn write_payload<T: AsBytes>(&mut self, payload: &T) -> Result {
> +        self.writer.write(payload)
> +    }
> +
> +    fn len(&self) -> usize {
> +        self.writer.len()
> +    }
> +}
> +
> +/// Specifies how a type should be delivered to the read part of a BINDER_WRITE_READ ioctl.
> +///
> +/// When a value is pushed to the todo list for a process or thread, it is stored as a trait object
> +/// with the type `Arc<dyn DeliverToRead>`. Trait objects are a Rust feature that lets you
> +/// implement dynamic dispatch over many different types. This lets us store many different types
> +/// in the todo list.
> +trait DeliverToRead: ListArcSafe + Send + Sync {
> +    /// Performs work. Returns true if remaining work items in the queue should be processed
> +    /// immediately, or false if it should return to caller before processing additional work
> +    /// items.
> +    fn do_work(
> +        self: DArc<Self>,
> +        thread: &Thread,
> +        writer: &mut BinderReturnWriter<'_>,
> +    ) -> Result<bool>;
> +
> +    /// Cancels the given work item. This is called instead of [`DeliverToRead::do_work`] when work
> +    /// won't be delivered.
> +    fn cancel(self: DArc<Self>);
> +
> +    /// Should we use `wake_up_interruptible_sync` or `wake_up_interruptible` when scheduling this
> +    /// work item?
> +    ///
> +    /// Generally only set to true for non-oneway transactions.
> +    fn should_sync_wakeup(&self) -> bool;
> +
> +    fn debug_print(&self, m: &SeqFile, prefix: &str, transaction_prefix: &str) -> Result<()>;
> +}
> +
> +// Wrapper around a `DeliverToRead` with linked list links.
> +#[pin_data]
> +struct DTRWrap<T: ?Sized> {
> +    #[pin]
> +    links: ListLinksSelfPtr<DTRWrap<dyn DeliverToRead>>,
> +    #[pin]
> +    wrapped: T,
> +}
> +kernel::list::impl_list_arc_safe! {
> +    impl{T: ListArcSafe + ?Sized} ListArcSafe<0> for DTRWrap<T> {
> +        tracked_by wrapped: T;
> +    }
> +}
> +kernel::list::impl_list_item! {
> +    impl ListItem<0> for DTRWrap<dyn DeliverToRead> {
> +        using ListLinksSelfPtr { self.links };
> +    }
> +}
> +
> +impl<T: ?Sized> core::ops::Deref for DTRWrap<T> {
> +    type Target = T;
> +    fn deref(&self) -> &T {
> +        &self.wrapped
> +    }
> +}
> +
> +type DArc<T> = kernel::sync::Arc<DTRWrap<T>>;
> +type DLArc<T> = kernel::list::ListArc<DTRWrap<T>>;
> +
> +impl<T: ListArcSafe> DTRWrap<T> {
> +    fn new(val: impl PinInit<T>) -> impl PinInit<Self> {
> +        pin_init!(Self {
> +            links <- ListLinksSelfPtr::new(),
> +            wrapped <- val,
> +        })
> +    }
> +
> +    fn arc_try_new(val: T) -> Result<DLArc<T>, kernel::alloc::AllocError> {
> +        ListArc::pin_init(
> +            try_pin_init!(Self {
> +                links <- ListLinksSelfPtr::new(),
> +                wrapped: val,
> +            }),
> +            GFP_KERNEL,
> +        )
> +        .map_err(|_| kernel::alloc::AllocError)
> +    }
> +
> +    fn arc_pin_init(init: impl PinInit<T>) -> Result<DLArc<T>, kernel::error::Error> {
> +        ListArc::pin_init(
> +            try_pin_init!(Self {
> +                links <- ListLinksSelfPtr::new(),
> +                wrapped <- init,
> +            }),
> +            GFP_KERNEL,
> +        )
> +    }
> +}
> +
> +struct DeliverCode {
> +    code: u32,
> +    skip: AtomicBool,
> +}
> +
> +kernel::list::impl_list_arc_safe! {
> +    impl ListArcSafe<0> for DeliverCode { untracked; }
> +}
> +
> +impl DeliverCode {
> +    fn new(code: u32) -> Self {
> +        Self {
> +            code,
> +            skip: AtomicBool::new(false),
> +        }
> +    }
> +
> +    /// Disable this DeliverCode and make it do nothing.
> +    ///
> +    /// This is used instead of removing it from the work list, since `LinkedList::remove` is
> +    /// unsafe, whereas this method is not.
> +    fn skip(&self) {
> +        self.skip.store(true, Ordering::Relaxed);
> +    }
> +}
> +
> +impl DeliverToRead for DeliverCode {
> +    fn do_work(
> +        self: DArc<Self>,
> +        _thread: &Thread,
> +        writer: &mut BinderReturnWriter<'_>,
> +    ) -> Result<bool> {
> +        if !self.skip.load(Ordering::Relaxed) {
> +            writer.write_code(self.code)?;
> +        }
> +        Ok(true)
> +    }
> +
> +    fn cancel(self: DArc<Self>) {}
> +
> +    fn should_sync_wakeup(&self) -> bool {
> +        false
> +    }
> +
> +    fn debug_print(&self, m: &SeqFile, prefix: &str, _tprefix: &str) -> Result<()> {
> +        seq_print!(m, "{}", prefix);
> +        if self.skip.load(Ordering::Relaxed) {
> +            seq_print!(m, "(skipped) ");
> +        }
> +        if self.code == defs::BR_TRANSACTION_COMPLETE {
> +            seq_print!(m, "transaction complete\n");
> +        } else {
> +            seq_print!(m, "transaction error: {}\n", self.code);
> +        }
> +        Ok(())
> +    }
> +}
> +
> +fn ptr_align(value: usize) -> Option<usize> {
> +    let size = core::mem::size_of::<usize>() - 1;
> +    Some(value.checked_add(size)? & !size)
> +}
> +
> +// SAFETY: We call register in `init`.
> +static BINDER_SHRINKER: Shrinker = unsafe { Shrinker::new() };
> +
> +struct BinderModule {}
> +
> +impl kernel::Module for BinderModule {
> +    fn init(_module: &'static kernel::ThisModule) -> Result<Self> {
> +        // SAFETY: The module initializer never runs twice, so we only call this once.
> +        unsafe { crate::context::CONTEXTS.init() };
> +
> +        pr_warn!("Loaded Rust Binder.");
> +
> +        BINDER_SHRINKER.register(kernel::c_str!("android-binder"))?;
> +
> +        // SAFETY: The module is being loaded, so we can initialize binderfs.
> +        unsafe { kernel::error::to_result(binderfs::init_rust_binderfs())? };
> +
> +        Ok(Self {})
> +    }
> +}
> +
> +/// Makes the inner type Sync.
> +#[repr(transparent)]
> +pub struct AssertSync<T>(T);
> +// SAFETY: Used only to insert `file_operations` into a global, which is safe.
> +unsafe impl<T> Sync for AssertSync<T> {}
> +
> +/// File operations that rust_binderfs.c can use.
> +#[no_mangle]
> +#[used]
> +pub static rust_binder_fops: AssertSync<kernel::bindings::file_operations> = {
> +    // SAFETY: All zeroes is safe for the `file_operations` type.
> +    let zeroed_ops = unsafe { core::mem::MaybeUninit::zeroed().assume_init() };
> +
> +    let ops = kernel::bindings::file_operations {
> +        owner: THIS_MODULE.as_ptr(),
> +        poll: Some(rust_binder_poll),
> +        unlocked_ioctl: Some(rust_binder_unlocked_ioctl),
> +        compat_ioctl: Some(rust_binder_compat_ioctl),
> +        mmap: Some(rust_binder_mmap),
> +        open: Some(rust_binder_open),
> +        release: Some(rust_binder_release),
> +        flush: Some(rust_binder_flush),
> +        ..zeroed_ops
> +    };
> +    AssertSync(ops)
> +};
> +
> +/// # Safety
> +/// Only called by binderfs.
> +#[no_mangle]
> +unsafe extern "C" fn rust_binder_new_context(
> +    name: *const kernel::ffi::c_char,
> +) -> *mut kernel::ffi::c_void {
> +    // SAFETY: The caller will always provide a valid c string here.
> +    let name = unsafe { kernel::str::CStr::from_char_ptr(name) };
> +    match Context::new(name) {
> +        Ok(ctx) => Arc::into_foreign(ctx),
> +        Err(_err) => core::ptr::null_mut(),
> +    }
> +}
> +
> +/// # Safety
> +/// Only called by binderfs.
> +#[no_mangle]
> +unsafe extern "C" fn rust_binder_remove_context(device: *mut kernel::ffi::c_void) {
> +    if !device.is_null() {
> +        // SAFETY: The caller ensures that the `device` pointer came from a previous call to
> +        // `rust_binder_new_device`.
> +        let ctx = unsafe { Arc::<Context>::from_foreign(device) };
> +        ctx.deregister();
> +        drop(ctx);
> +    }
> +}
> +
> +/// # Safety
> +/// Only called by binderfs.
> +unsafe extern "C" fn rust_binder_open(
> +    inode: *mut bindings::inode,
> +    file_ptr: *mut bindings::file,
> +) -> kernel::ffi::c_int {
> +    // SAFETY: The `rust_binderfs.c` file ensures that `i_private` is set to a
> +    // `struct binder_device`.
> +    let device = unsafe { (*inode).i_private } as *const binderfs::binder_device;
> +
> +    assert!(!device.is_null());
> +
> +    // SAFETY: The `rust_binderfs.c` file ensures that `device->ctx` holds a binder context when
> +    // using the rust binder fops.
> +    let ctx = unsafe { Arc::<Context>::borrow((*device).ctx) };
> +
> +    // SAFETY: The caller provides a valid file pointer to a new `struct file`.
> +    let file = unsafe { File::from_raw_file(file_ptr) };
> +    let process = match Process::open(ctx, file) {
> +        Ok(process) => process,
> +        Err(err) => return err.to_errno(),
> +    };
> +
> +    // SAFETY: This is an `inode` for a newly created binder file.
> +    match unsafe { BinderfsProcFile::new(inode, process.task.pid()) } {
> +        Ok(Some(file)) => process.inner.lock().binderfs_file = Some(file),
> +        Ok(None) => { /* pid already exists */ }
> +        Err(err) => return err.to_errno(),
> +    }
> +
> +    // SAFETY: This file is associated with Rust binder, so we own the `private_data` field.
> +    unsafe { (*file_ptr).private_data = process.into_foreign() };
> +    0
> +}
> +
> +/// # Safety
> +/// Only called by binderfs.
> +unsafe extern "C" fn rust_binder_release(
> +    _inode: *mut bindings::inode,
> +    file: *mut bindings::file,
> +) -> kernel::ffi::c_int {
> +    // SAFETY: We previously set `private_data` in `rust_binder_open`.
> +    let process = unsafe { Arc::<Process>::from_foreign((*file).private_data) };
> +    // SAFETY: The caller ensures that the file is valid.
> +    let file = unsafe { File::from_raw_file(file) };
> +    Process::release(process, file);
> +    0
> +}
> +
> +/// # Safety
> +/// Only called by binderfs.
> +unsafe extern "C" fn rust_binder_compat_ioctl(
> +    file: *mut bindings::file,
> +    cmd: kernel::ffi::c_uint,
> +    arg: kernel::ffi::c_ulong,
> +) -> kernel::ffi::c_long {
> +    // SAFETY: We previously set `private_data` in `rust_binder_open`.
> +    let f = unsafe { Arc::<Process>::borrow((*file).private_data) };
> +    // SAFETY: The caller ensures that the file is valid.
> +    match Process::compat_ioctl(f, unsafe { File::from_raw_file(file) }, cmd as _, arg as _) {
> +        Ok(()) => 0,
> +        Err(err) => err.to_errno() as isize,
> +    }
> +}
> +
> +/// # Safety
> +/// Only called by binderfs.
> +unsafe extern "C" fn rust_binder_unlocked_ioctl(
> +    file: *mut bindings::file,
> +    cmd: kernel::ffi::c_uint,
> +    arg: kernel::ffi::c_ulong,
> +) -> kernel::ffi::c_long {
> +    // SAFETY: We previously set `private_data` in `rust_binder_open`.
> +    let f = unsafe { Arc::<Process>::borrow((*file).private_data) };
> +    // SAFETY: The caller ensures that the file is valid.
> +    match Process::ioctl(f, unsafe { File::from_raw_file(file) }, cmd as _, arg as _) {
> +        Ok(()) => 0,
> +        Err(err) => err.to_errno() as isize,
> +    }
> +}
> +
> +/// # Safety
> +/// Only called by binderfs.
> +unsafe extern "C" fn rust_binder_mmap(
> +    file: *mut bindings::file,
> +    vma: *mut bindings::vm_area_struct,
> +) -> kernel::ffi::c_int {
> +    // SAFETY: We previously set `private_data` in `rust_binder_open`.
> +    let f = unsafe { Arc::<Process>::borrow((*file).private_data) };
> +    // SAFETY: The caller ensures that the vma is valid.
> +    let area = unsafe { kernel::mm::virt::VmaNew::from_raw(vma) };
> +    // SAFETY: The caller ensures that the file is valid.
> +    match Process::mmap(f, unsafe { File::from_raw_file(file) }, area) {
> +        Ok(()) => 0,
> +        Err(err) => err.to_errno(),
> +    }
> +}
> +
> +/// # Safety
> +/// Only called by binderfs.
> +unsafe extern "C" fn rust_binder_poll(
> +    file: *mut bindings::file,
> +    wait: *mut bindings::poll_table_struct,
> +) -> bindings::__poll_t {
> +    // SAFETY: We previously set `private_data` in `rust_binder_open`.
> +    let f = unsafe { Arc::<Process>::borrow((*file).private_data) };
> +    // SAFETY: The caller ensures that the file is valid.
> +    let fileref = unsafe { File::from_raw_file(file) };
> +    // SAFETY: The caller ensures that the `PollTable` is valid.
> +    match Process::poll(f, fileref, unsafe { PollTable::from_raw(wait) }) {
> +        Ok(v) => v,
> +        Err(_) => bindings::POLLERR,
> +    }
> +}
> +
> +/// # Safety
> +/// Only called by binderfs.
> +unsafe extern "C" fn rust_binder_flush(
> +    file: *mut bindings::file,
> +    _id: bindings::fl_owner_t,
> +) -> kernel::ffi::c_int {
> +    // SAFETY: We previously set `private_data` in `rust_binder_open`.
> +    let f = unsafe { Arc::<Process>::borrow((*file).private_data) };
> +    match Process::flush(f) {
> +        Ok(()) => 0,
> +        Err(err) => err.to_errno(),
> +    }
> +}
> +
> +/// # Safety
> +/// Only called by binderfs.
> +#[no_mangle]
> +unsafe extern "C" fn rust_binder_stats_show(
> +    ptr: *mut seq_file,
> +    _: *mut kernel::ffi::c_void,
> +) -> kernel::ffi::c_int {
> +    // SAFETY: The caller ensures that the pointer is valid and exclusive for the duration in which
> +    // this method is called.
> +    let m = unsafe { SeqFile::from_raw(ptr) };
> +    if let Err(err) = rust_binder_stats_show_impl(m) {
> +        seq_print!(m, "failed to generate state: {:?}\n", err);
> +    }
> +    0
> +}
> +
> +/// # Safety
> +/// Only called by binderfs.
> +#[no_mangle]
> +unsafe extern "C" fn rust_binder_state_show(
> +    ptr: *mut seq_file,
> +    _: *mut kernel::ffi::c_void,
> +) -> kernel::ffi::c_int {
> +    // SAFETY: The caller ensures that the pointer is valid and exclusive for the duration in which
> +    // this method is called.
> +    let m = unsafe { SeqFile::from_raw(ptr) };
> +    if let Err(err) = rust_binder_state_show_impl(m) {
> +        seq_print!(m, "failed to generate state: {:?}\n", err);
> +    }
> +    0
> +}
> +
> +/// # Safety
> +/// Only called by binderfs.
> +#[no_mangle]
> +unsafe extern "C" fn rust_binder_proc_show(
> +    ptr: *mut seq_file,
> +    _: *mut kernel::ffi::c_void,
> +) -> kernel::ffi::c_int {
> +    // SAFETY: Accessing the private field of `seq_file` is okay.
> +    let pid = (unsafe { (*ptr).private }) as usize as Pid;
> +    // SAFETY: The caller ensures that the pointer is valid and exclusive for the duration in which
> +    // this method is called.
> +    let m = unsafe { SeqFile::from_raw(ptr) };
> +    if let Err(err) = rust_binder_proc_show_impl(m, pid) {
> +        seq_print!(m, "failed to generate state: {:?}\n", err);
> +    }
> +    0
> +}
> +
> +/// # Safety
> +/// Only called by binderfs.
> +#[no_mangle]
> +unsafe extern "C" fn rust_binder_transactions_show(
> +    ptr: *mut seq_file,
> +    _: *mut kernel::ffi::c_void,
> +) -> kernel::ffi::c_int {
> +    // SAFETY: The caller ensures that the pointer is valid and exclusive for the duration in which
> +    // this method is called.
> +    let m = unsafe { SeqFile::from_raw(ptr) };
> +    if let Err(err) = rust_binder_transactions_show_impl(m) {
> +        seq_print!(m, "failed to generate state: {:?}\n", err);
> +    }
> +    0
> +}
> +
> +fn rust_binder_transactions_show_impl(m: &SeqFile) -> Result<()> {
> +    seq_print!(m, "binder transactions:\n");
> +    let contexts = context::get_all_contexts()?;
> +    for ctx in contexts {
> +        let procs = ctx.get_all_procs()?;
> +        for proc in procs {
> +            proc.debug_print(m, &ctx, false)?;
> +            seq_print!(m, "\n");
> +        }
> +    }
> +    Ok(())
> +}
> +
> +fn rust_binder_stats_show_impl(m: &SeqFile) -> Result<()> {
> +    seq_print!(m, "binder stats:\n");
> +    stats::GLOBAL_STATS.debug_print("", m);
> +    let contexts = context::get_all_contexts()?;
> +    for ctx in contexts {
> +        let procs = ctx.get_all_procs()?;
> +        for proc in procs {
> +            proc.debug_print_stats(m, &ctx)?;
> +            seq_print!(m, "\n");
> +        }
> +    }
> +    Ok(())
> +}
> +
> +fn rust_binder_state_show_impl(m: &SeqFile) -> Result<()> {
> +    seq_print!(m, "binder state:\n");
> +    let contexts = context::get_all_contexts()?;
> +    for ctx in contexts {
> +        let procs = ctx.get_all_procs()?;
> +        for proc in procs {
> +            proc.debug_print(m, &ctx, true)?;
> +            seq_print!(m, "\n");
> +        }
> +    }
> +    Ok(())
> +}
> +
> +fn rust_binder_proc_show_impl(m: &SeqFile, pid: Pid) -> Result<()> {
> +    seq_print!(m, "binder proc state:\n");
> +    let contexts = context::get_all_contexts()?;
> +    for ctx in contexts {
> +        let procs = ctx.get_procs_with_pid(pid)?;
> +        for proc in procs {
> +            proc.debug_print(m, &ctx, true)?;
> +            seq_print!(m, "\n");
> +        }
> +    }
> +    Ok(())
> +}
> +
> +struct BinderfsProcFile(NonNull<bindings::dentry>);
> +
> +// SAFETY: Safe to drop any thread.
> +unsafe impl Send for BinderfsProcFile {}
> +
> +impl BinderfsProcFile {
> +    /// # Safety
> +    ///
> +    /// Takes an inode from a newly created binder file.
> +    unsafe fn new(nodp: *mut bindings::inode, pid: i32) -> Result<Option<Self>> {
> +        // SAFETY: The caller passes an `inode` for a newly created binder file.
> +        let dentry = unsafe { binderfs::rust_binderfs_create_proc_file(nodp, pid) };
> +        match kernel::error::from_err_ptr(dentry) {
> +            Ok(dentry) => Ok(NonNull::new(dentry).map(Self)),
> +            Err(err) if err == EEXIST => Ok(None),
> +            Err(err) => Err(err),
> +        }
> +    }
> +}
> +
> +impl Drop for BinderfsProcFile {
> +    fn drop(&mut self) {
> +        // SAFETY: This is a dentry from `rust_binderfs_remove_file` that has not been deleted yet.
> +        unsafe { binderfs::rust_binderfs_remove_file(self.0.as_ptr()) };
> +    }
> +}
> diff --git a/drivers/android/binder/rust_binderfs.c b/drivers/android/binder/rust_binderfs.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..6b497146b698b3d031f8fe7d3264f3fadbed8722
> --- /dev/null
> +++ b/drivers/android/binder/rust_binderfs.c
> @@ -0,0 +1,850 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/compiler_types.h>
> +#include <linux/errno.h>
> +#include <linux/fs.h>
> +#include <linux/fsnotify.h>
> +#include <linux/gfp.h>
> +#include <linux/idr.h>
> +#include <linux/init.h>
> +#include <linux/ipc_namespace.h>
> +#include <linux/kdev_t.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/namei.h>
> +#include <linux/magic.h>
> +#include <linux/major.h>
> +#include <linux/miscdevice.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/mount.h>
> +#include <linux/fs_parser.h>
> +#include <linux/sched.h>
> +#include <linux/seq_file.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock_types.h>
> +#include <linux/stddef.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +#include <linux/uaccess.h>
> +#include <linux/user_namespace.h>
> +#include <linux/xarray.h>
> +#include <uapi/asm-generic/errno-base.h>
> +#include <uapi/linux/android/binder.h>
> +#include <uapi/linux/android/binderfs.h>
> +
> +#include "rust_binder.h"
> +#include "rust_binder_internal.h"
> +
> +#define FIRST_INODE 1
> +#define SECOND_INODE 2
> +#define INODE_OFFSET 3
> +#define BINDERFS_MAX_MINOR (1U << MINORBITS)
> +/* Ensure that the initial ipc namespace always has devices available. */
> +#define BINDERFS_MAX_MINOR_CAPPED (BINDERFS_MAX_MINOR - 4)
> +
> +DEFINE_SHOW_ATTRIBUTE(rust_binder_stats);
> +DEFINE_SHOW_ATTRIBUTE(rust_binder_state);
> +DEFINE_SHOW_ATTRIBUTE(rust_binder_transactions);
> +DEFINE_SHOW_ATTRIBUTE(rust_binder_proc);
> +
> +char *rust_binder_devices_param = CONFIG_ANDROID_BINDER_DEVICES;
> +module_param_named(rust_devices, rust_binder_devices_param, charp, 0444);
> +
> +static dev_t binderfs_dev;
> +static DEFINE_MUTEX(binderfs_minors_mutex);
> +static DEFINE_IDA(binderfs_minors);
> +
> +enum binderfs_param {
> +	Opt_max,
> +	Opt_stats_mode,
> +};
> +
> +enum binderfs_stats_mode {
> +	binderfs_stats_mode_unset,
> +	binderfs_stats_mode_global,
> +};
> +
> +struct binder_features {
> +	bool oneway_spam_detection;
> +	bool extended_error;
> +	bool freeze_notification;
> +};
> +
> +static const struct constant_table binderfs_param_stats[] = {
> +	{ "global", binderfs_stats_mode_global },
> +	{}
> +};
> +
> +static const struct fs_parameter_spec binderfs_fs_parameters[] = {
> +	fsparam_u32("max",	Opt_max),
> +	fsparam_enum("stats",	Opt_stats_mode, binderfs_param_stats),
> +	{}
> +};
> +
> +static struct binder_features binder_features = {
> +	.oneway_spam_detection = true,
> +	.extended_error = true,
> +	.freeze_notification = true,
> +};
> +
> +static inline struct binderfs_info *BINDERFS_SB(const struct super_block *sb)
> +{
> +	return sb->s_fs_info;
> +}
> +
> +/**
> + * binderfs_binder_device_create - allocate inode from super block of a
> + *                                 binderfs mount
> + * @ref_inode: inode from wich the super block will be taken
> + * @userp:     buffer to copy information about new device for userspace to
> + * @req:       struct binderfs_device as copied from userspace
> + *
> + * This function allocates a new binder_device and reserves a new minor
> + * number for it.
> + * Minor numbers are limited and tracked globally in binderfs_minors. The
> + * function will stash a struct binder_device for the specific binder
> + * device in i_private of the inode.
> + * It will go on to allocate a new inode from the super block of the
> + * filesystem mount, stash a struct binder_device in its i_private field
> + * and attach a dentry to that inode.
> + *
> + * Return: 0 on success, negative errno on failure
> + */
> +static int binderfs_binder_device_create(struct inode *ref_inode,
> +					 struct binderfs_device __user *userp,
> +					 struct binderfs_device *req)
> +{
> +	int minor, ret;
> +	struct dentry *dentry, *root;
> +	struct binder_device *device = NULL;
> +	rust_binder_context ctx = NULL;
> +	struct inode *inode = NULL;
> +	struct super_block *sb = ref_inode->i_sb;
> +	struct binderfs_info *info = sb->s_fs_info;
> +#if defined(CONFIG_IPC_NS)
> +	bool use_reserve = (info->ipc_ns == &init_ipc_ns);
> +#else
> +	bool use_reserve = true;
> +#endif
> +
> +	/* Reserve new minor number for the new device. */
> +	mutex_lock(&binderfs_minors_mutex);
> +	if (++info->device_count <= info->mount_opts.max)
> +		minor = ida_alloc_max(&binderfs_minors,
> +				      use_reserve ? BINDERFS_MAX_MINOR :
> +						    BINDERFS_MAX_MINOR_CAPPED,
> +				      GFP_KERNEL);
> +	else
> +		minor = -ENOSPC;
> +	if (minor < 0) {
> +		--info->device_count;
> +		mutex_unlock(&binderfs_minors_mutex);
> +		return minor;
> +	}
> +	mutex_unlock(&binderfs_minors_mutex);
> +
> +	ret = -ENOMEM;
> +	device = kzalloc(sizeof(*device), GFP_KERNEL);
> +	if (!device)
> +		goto err;
> +
> +	req->name[BINDERFS_MAX_NAME] = '\0'; /* NUL-terminate */
> +
> +	ctx = rust_binder_new_context(req->name);
> +	if (!ctx)
> +		goto err;
> +
> +	inode = new_inode(sb);
> +	if (!inode)
> +		goto err;
> +
> +	inode->i_ino = minor + INODE_OFFSET;
> +	simple_inode_init_ts(inode);
> +	init_special_inode(inode, S_IFCHR | 0600,
> +			   MKDEV(MAJOR(binderfs_dev), minor));
> +	inode->i_fop = &rust_binder_fops;
> +	inode->i_uid = info->root_uid;
> +	inode->i_gid = info->root_gid;
> +
> +	req->major = MAJOR(binderfs_dev);
> +	req->minor = minor;
> +	device->ctx = ctx;
> +	device->minor = minor;
> +
> +	if (userp && copy_to_user(userp, req, sizeof(*req))) {
> +		ret = -EFAULT;
> +		goto err;
> +	}
> +
> +	root = sb->s_root;
> +	inode_lock(d_inode(root));
> +
> +	/* look it up */
> +	dentry = lookup_noperm(&QSTR(req->name), root);
> +	if (IS_ERR(dentry)) {
> +		inode_unlock(d_inode(root));
> +		ret = PTR_ERR(dentry);
> +		goto err;
> +	}
> +
> +	if (d_really_is_positive(dentry)) {
> +		/* already exists */
> +		dput(dentry);
> +		inode_unlock(d_inode(root));
> +		ret = -EEXIST;
> +		goto err;
> +	}
> +
> +	inode->i_private = device;
> +	d_instantiate(dentry, inode);
> +	fsnotify_create(root->d_inode, dentry);
> +	inode_unlock(d_inode(root));
> +
> +	return 0;
> +
> +err:
> +	kfree(device);
> +	rust_binder_remove_context(ctx);
> +	mutex_lock(&binderfs_minors_mutex);
> +	--info->device_count;
> +	ida_free(&binderfs_minors, minor);
> +	mutex_unlock(&binderfs_minors_mutex);
> +	iput(inode);
> +
> +	return ret;
> +}
> +
> +/**
> + * binder_ctl_ioctl - handle binder device node allocation requests
> + *
> + * The request handler for the binder-control device. All requests operate on
> + * the binderfs mount the binder-control device resides in:
> + * - BINDER_CTL_ADD
> + *   Allocate a new binder device.
> + *
> + * Return: %0 on success, negative errno on failure.
> + */
> +static long binder_ctl_ioctl(struct file *file, unsigned int cmd,
> +			     unsigned long arg)
> +{
> +	int ret = -EINVAL;
> +	struct inode *inode = file_inode(file);
> +	struct binderfs_device __user *device = (struct binderfs_device __user *)arg;
> +	struct binderfs_device device_req;
> +
> +	switch (cmd) {
> +	case BINDER_CTL_ADD:
> +		ret = copy_from_user(&device_req, device, sizeof(device_req));
> +		if (ret) {
> +			ret = -EFAULT;
> +			break;
> +		}
> +
> +		ret = binderfs_binder_device_create(inode, device, &device_req);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static void binderfs_evict_inode(struct inode *inode)
> +{
> +	struct binder_device *device = inode->i_private;
> +	struct binderfs_info *info = BINDERFS_SB(inode->i_sb);
> +
> +	clear_inode(inode);
> +
> +	if (!S_ISCHR(inode->i_mode) || !device)
> +		return;
> +
> +	mutex_lock(&binderfs_minors_mutex);
> +	--info->device_count;
> +	ida_free(&binderfs_minors, device->minor);
> +	mutex_unlock(&binderfs_minors_mutex);
> +
> +	/* ctx is null for binder-control, but this function ignores null pointers */
> +	rust_binder_remove_context(device->ctx);
> +
> +	kfree(device);
> +}
> +
> +static int binderfs_fs_context_parse_param(struct fs_context *fc,
> +					   struct fs_parameter *param)
> +{
> +	int opt;
> +	struct binderfs_mount_opts *ctx = fc->fs_private;
> +	struct fs_parse_result result;
> +
> +	opt = fs_parse(fc, binderfs_fs_parameters, param, &result);
> +	if (opt < 0)
> +		return opt;
> +
> +	switch (opt) {
> +	case Opt_max:
> +		if (result.uint_32 > BINDERFS_MAX_MINOR)
> +			return invalfc(fc, "Bad value for '%s'", param->key);
> +
> +		ctx->max = result.uint_32;
> +		break;
> +	case Opt_stats_mode:
> +		if (!capable(CAP_SYS_ADMIN))
> +			return -EPERM;
> +
> +		ctx->stats_mode = result.uint_32;
> +		break;
> +	default:
> +		return invalfc(fc, "Unsupported parameter '%s'", param->key);
> +	}
> +
> +	return 0;
> +}
> +
> +static int binderfs_fs_context_reconfigure(struct fs_context *fc)
> +{
> +	struct binderfs_mount_opts *ctx = fc->fs_private;
> +	struct binderfs_info *info = BINDERFS_SB(fc->root->d_sb);
> +
> +	if (info->mount_opts.stats_mode != ctx->stats_mode)
> +		return invalfc(fc, "Binderfs stats mode cannot be changed during a remount");
> +
> +	info->mount_opts.stats_mode = ctx->stats_mode;
> +	info->mount_opts.max = ctx->max;
> +	return 0;
> +}
> +
> +static int binderfs_show_options(struct seq_file *seq, struct dentry *root)
> +{
> +	struct binderfs_info *info = BINDERFS_SB(root->d_sb);
> +
> +	if (info->mount_opts.max <= BINDERFS_MAX_MINOR)
> +		seq_printf(seq, ",max=%d", info->mount_opts.max);
> +
> +	switch (info->mount_opts.stats_mode) {
> +	case binderfs_stats_mode_unset:
> +		break;
> +	case binderfs_stats_mode_global:
> +		seq_puts(seq, ",stats=global");
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct super_operations binderfs_super_ops = {
> +	.evict_inode    = binderfs_evict_inode,
> +	.show_options	= binderfs_show_options,
> +	.statfs         = simple_statfs,
> +};
> +
> +static inline bool is_binderfs_control_device(const struct dentry *dentry)
> +{
> +	struct binderfs_info *info = dentry->d_sb->s_fs_info;
> +
> +	return info->control_dentry == dentry;
> +}
> +
> +static int binderfs_rename(struct mnt_idmap *idmap,
> +			   struct inode *old_dir, struct dentry *old_dentry,
> +			   struct inode *new_dir, struct dentry *new_dentry,
> +			   unsigned int flags)
> +{
> +	if (is_binderfs_control_device(old_dentry) ||
> +	    is_binderfs_control_device(new_dentry))
> +		return -EPERM;
> +
> +	return simple_rename(idmap, old_dir, old_dentry, new_dir,
> +			     new_dentry, flags);
> +}
> +
> +static int binderfs_unlink(struct inode *dir, struct dentry *dentry)
> +{
> +	if (is_binderfs_control_device(dentry))
> +		return -EPERM;
> +
> +	return simple_unlink(dir, dentry);
> +}
> +
> +static const struct file_operations binder_ctl_fops = {
> +	.owner		= THIS_MODULE,
> +	.open		= nonseekable_open,
> +	.unlocked_ioctl	= binder_ctl_ioctl,
> +	.compat_ioctl	= binder_ctl_ioctl,
> +	.llseek		= noop_llseek,
> +};
> +
> +/**
> + * binderfs_binder_ctl_create - create a new binder-control device
> + * @sb: super block of the binderfs mount
> + *
> + * This function creates a new binder-control device node in the binderfs mount
> + * referred to by @sb.
> + *
> + * Return: 0 on success, negative errno on failure
> + */
> +static int binderfs_binder_ctl_create(struct super_block *sb)
> +{
> +	int minor, ret;
> +	struct dentry *dentry;
> +	struct binder_device *device;
> +	struct inode *inode = NULL;
> +	struct dentry *root = sb->s_root;
> +	struct binderfs_info *info = sb->s_fs_info;
> +#if defined(CONFIG_IPC_NS)
> +	bool use_reserve = (info->ipc_ns == &init_ipc_ns);
> +#else
> +	bool use_reserve = true;
> +#endif
> +
> +	device = kzalloc(sizeof(*device), GFP_KERNEL);
> +	if (!device)
> +		return -ENOMEM;
> +
> +	/* If we have already created a binder-control node, return. */
> +	if (info->control_dentry) {
> +		ret = 0;
> +		goto out;
> +	}
> +
> +	ret = -ENOMEM;
> +	inode = new_inode(sb);
> +	if (!inode)
> +		goto out;
> +
> +	/* Reserve a new minor number for the new device. */
> +	mutex_lock(&binderfs_minors_mutex);
> +	minor = ida_alloc_max(&binderfs_minors,
> +			      use_reserve ? BINDERFS_MAX_MINOR :
> +					    BINDERFS_MAX_MINOR_CAPPED,
> +			      GFP_KERNEL);
> +	mutex_unlock(&binderfs_minors_mutex);
> +	if (minor < 0) {
> +		ret = minor;
> +		goto out;
> +	}
> +
> +	inode->i_ino = SECOND_INODE;
> +	simple_inode_init_ts(inode);
> +	init_special_inode(inode, S_IFCHR | 0600,
> +			   MKDEV(MAJOR(binderfs_dev), minor));
> +	inode->i_fop = &binder_ctl_fops;
> +	inode->i_uid = info->root_uid;
> +	inode->i_gid = info->root_gid;
> +
> +	device->minor = minor;
> +	device->ctx = NULL;
> +
> +	dentry = d_alloc_name(root, "binder-control");
> +	if (!dentry)
> +		goto out;
> +
> +	inode->i_private = device;
> +	info->control_dentry = dentry;
> +	d_add(dentry, inode);
> +
> +	return 0;
> +
> +out:
> +	kfree(device);
> +	iput(inode);
> +
> +	return ret;
> +}
> +
> +static const struct inode_operations binderfs_dir_inode_operations = {
> +	.lookup = simple_lookup,
> +	.rename = binderfs_rename,
> +	.unlink = binderfs_unlink,
> +};
> +
> +static struct inode *binderfs_make_inode(struct super_block *sb, int mode)
> +{
> +	struct inode *ret;
> +
> +	ret = new_inode(sb);
> +	if (ret) {
> +		ret->i_ino = iunique(sb, BINDERFS_MAX_MINOR + INODE_OFFSET);
> +		ret->i_mode = mode;
> +		simple_inode_init_ts(ret);
> +	}
> +	return ret;
> +}
> +
> +static struct dentry *binderfs_create_dentry(struct dentry *parent,
> +					     const char *name)
> +{
> +	struct dentry *dentry;
> +
> +	dentry = lookup_noperm(&QSTR(name), parent);
> +	if (IS_ERR(dentry))
> +		return dentry;
> +
> +	/* Return error if the file/dir already exists. */
> +	if (d_really_is_positive(dentry)) {
> +		dput(dentry);
> +		return ERR_PTR(-EEXIST);
> +	}
> +
> +	return dentry;
> +}
> +
> +void rust_binderfs_remove_file(struct dentry *dentry)
> +{
> +	struct inode *parent_inode;
> +
> +	parent_inode = d_inode(dentry->d_parent);
> +	inode_lock(parent_inode);
> +	if (simple_positive(dentry)) {
> +		dget(dentry);
> +		simple_unlink(parent_inode, dentry);
> +		d_delete(dentry);
> +		dput(dentry);
> +	}
> +	inode_unlock(parent_inode);
> +}
> +
> +static struct dentry *rust_binderfs_create_file(struct dentry *parent, const char *name,
> +						const struct file_operations *fops,
> +						void *data)
> +{
> +	struct dentry *dentry;
> +	struct inode *new_inode, *parent_inode;
> +	struct super_block *sb;
> +
> +	parent_inode = d_inode(parent);
> +	inode_lock(parent_inode);
> +
> +	dentry = binderfs_create_dentry(parent, name);
> +	if (IS_ERR(dentry))
> +		goto out;
> +
> +	sb = parent_inode->i_sb;
> +	new_inode = binderfs_make_inode(sb, S_IFREG | 0444);
> +	if (!new_inode) {
> +		dput(dentry);
> +		dentry = ERR_PTR(-ENOMEM);
> +		goto out;
> +	}
> +
> +	new_inode->i_fop = fops;
> +	new_inode->i_private = data;
> +	d_instantiate(dentry, new_inode);
> +	fsnotify_create(parent_inode, dentry);
> +
> +out:
> +	inode_unlock(parent_inode);
> +	return dentry;
> +}
> +
> +struct dentry *rust_binderfs_create_proc_file(struct inode *nodp, int pid)
> +{
> +	struct binderfs_info *info = nodp->i_sb->s_fs_info;
> +	struct dentry *dir = info->proc_log_dir;
> +	char strbuf[20 + 1];
> +	void *data = (void *)(unsigned long) pid;
> +
> +	if (!dir)
> +		return NULL;
> +
> +	snprintf(strbuf, sizeof(strbuf), "%u", pid);
> +	return rust_binderfs_create_file(dir, strbuf, &rust_binder_proc_fops, data);
> +}
> +
> +static struct dentry *binderfs_create_dir(struct dentry *parent,
> +					  const char *name)
> +{
> +	struct dentry *dentry;
> +	struct inode *new_inode, *parent_inode;
> +	struct super_block *sb;
> +
> +	parent_inode = d_inode(parent);
> +	inode_lock(parent_inode);
> +
> +	dentry = binderfs_create_dentry(parent, name);
> +	if (IS_ERR(dentry))
> +		goto out;
> +
> +	sb = parent_inode->i_sb;
> +	new_inode = binderfs_make_inode(sb, S_IFDIR | 0755);
> +	if (!new_inode) {
> +		dput(dentry);
> +		dentry = ERR_PTR(-ENOMEM);
> +		goto out;
> +	}
> +
> +	new_inode->i_fop = &simple_dir_operations;
> +	new_inode->i_op = &simple_dir_inode_operations;
> +
> +	set_nlink(new_inode, 2);
> +	d_instantiate(dentry, new_inode);
> +	inc_nlink(parent_inode);
> +	fsnotify_mkdir(parent_inode, dentry);
> +
> +out:
> +	inode_unlock(parent_inode);
> +	return dentry;
> +}
> +
> +static int binder_features_show(struct seq_file *m, void *unused)
> +{
> +	bool *feature = m->private;
> +
> +	seq_printf(m, "%d\n", *feature);
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(binder_features);
> +
> +static int init_binder_features(struct super_block *sb)
> +{
> +	struct dentry *dentry, *dir;
> +
> +	dir = binderfs_create_dir(sb->s_root, "features");
> +	if (IS_ERR(dir))
> +		return PTR_ERR(dir);
> +
> +	dentry = rust_binderfs_create_file(dir, "oneway_spam_detection",
> +				      &binder_features_fops,
> +				      &binder_features.oneway_spam_detection);
> +	if (IS_ERR(dentry))
> +		return PTR_ERR(dentry);
> +
> +	dentry = rust_binderfs_create_file(dir, "extended_error",
> +				      &binder_features_fops,
> +				      &binder_features.extended_error);
> +	if (IS_ERR(dentry))
> +		return PTR_ERR(dentry);
> +
> +	dentry = rust_binderfs_create_file(dir, "freeze_notification",
> +				      &binder_features_fops,
> +				      &binder_features.freeze_notification);
> +	if (IS_ERR(dentry))
> +		return PTR_ERR(dentry);
> +
> +	return 0;
> +}
> +
> +static int init_binder_logs(struct super_block *sb)
> +{
> +	struct dentry *binder_logs_root_dir, *dentry, *proc_log_dir;
> +	struct binderfs_info *info;
> +	int ret = 0;
> +
> +	binder_logs_root_dir = binderfs_create_dir(sb->s_root,
> +						   "binder_logs");
> +	if (IS_ERR(binder_logs_root_dir)) {
> +		ret = PTR_ERR(binder_logs_root_dir);
> +		goto out;
> +	}
> +
> +	dentry = rust_binderfs_create_file(binder_logs_root_dir, "stats",
> +				      &rust_binder_stats_fops, NULL);
> +	if (IS_ERR(dentry)) {
> +		ret = PTR_ERR(dentry);
> +		goto out;
> +	}
> +
> +	dentry = rust_binderfs_create_file(binder_logs_root_dir, "state",
> +				      &rust_binder_state_fops, NULL);
> +	if (IS_ERR(dentry)) {
> +		ret = PTR_ERR(dentry);
> +		goto out;
> +	}
> +
> +	dentry = rust_binderfs_create_file(binder_logs_root_dir, "transactions",
> +				      &rust_binder_transactions_fops, NULL);
> +	if (IS_ERR(dentry)) {
> +		ret = PTR_ERR(dentry);
> +		goto out;
> +	}
> +
> +	proc_log_dir = binderfs_create_dir(binder_logs_root_dir, "proc");
> +	if (IS_ERR(proc_log_dir)) {
> +		ret = PTR_ERR(proc_log_dir);
> +		goto out;
> +	}
> +	info = sb->s_fs_info;
> +	info->proc_log_dir = proc_log_dir;
> +
> +out:
> +	return ret;
> +}
> +
> +static int binderfs_fill_super(struct super_block *sb, struct fs_context *fc)
> +{
> +	int ret;
> +	struct binderfs_info *info;
> +	struct binderfs_mount_opts *ctx = fc->fs_private;
> +	struct inode *inode = NULL;
> +	struct binderfs_device device_info = {};
> +	const char *name;
> +	size_t len;
> +
> +	sb->s_blocksize = PAGE_SIZE;
> +	sb->s_blocksize_bits = PAGE_SHIFT;
> +
> +	/*
> +	 * The binderfs filesystem can be mounted by userns root in a
> +	 * non-initial userns. By default such mounts have the SB_I_NODEV flag
> +	 * set in s_iflags to prevent security issues where userns root can
> +	 * just create random device nodes via mknod() since it owns the
> +	 * filesystem mount. But binderfs does not allow to create any files
> +	 * including devices nodes. The only way to create binder devices nodes
> +	 * is through the binder-control device which userns root is explicitly
> +	 * allowed to do. So removing the SB_I_NODEV flag from s_iflags is both
> +	 * necessary and safe.
> +	 */
> +	sb->s_iflags &= ~SB_I_NODEV;
> +	sb->s_iflags |= SB_I_NOEXEC;
> +	sb->s_magic = RUST_BINDERFS_SUPER_MAGIC;
> +	sb->s_op = &binderfs_super_ops;
> +	sb->s_time_gran = 1;
> +
> +	sb->s_fs_info = kzalloc(sizeof(struct binderfs_info), GFP_KERNEL);
> +	if (!sb->s_fs_info)
> +		return -ENOMEM;
> +	info = sb->s_fs_info;
> +
> +	info->ipc_ns = get_ipc_ns(current->nsproxy->ipc_ns);
> +
> +	info->root_gid = make_kgid(sb->s_user_ns, 0);
> +	if (!gid_valid(info->root_gid))
> +		info->root_gid = GLOBAL_ROOT_GID;
> +	info->root_uid = make_kuid(sb->s_user_ns, 0);
> +	if (!uid_valid(info->root_uid))
> +		info->root_uid = GLOBAL_ROOT_UID;
> +	info->mount_opts.max = ctx->max;
> +	info->mount_opts.stats_mode = ctx->stats_mode;
> +
> +	inode = new_inode(sb);
> +	if (!inode)
> +		return -ENOMEM;
> +
> +	inode->i_ino = FIRST_INODE;
> +	inode->i_fop = &simple_dir_operations;
> +	inode->i_mode = S_IFDIR | 0755;
> +	simple_inode_init_ts(inode);
> +	inode->i_op = &binderfs_dir_inode_operations;
> +	set_nlink(inode, 2);
> +
> +	sb->s_root = d_make_root(inode);
> +	if (!sb->s_root)
> +		return -ENOMEM;
> +
> +	ret = binderfs_binder_ctl_create(sb);
> +	if (ret)
> +		return ret;
> +
> +	name = rust_binder_devices_param;
> +	for (len = strcspn(name, ","); len > 0; len = strcspn(name, ",")) {
> +		strscpy(device_info.name, name, len + 1);
> +		ret = binderfs_binder_device_create(inode, NULL, &device_info);
> +		if (ret)
> +			return ret;
> +		name += len;
> +		if (*name == ',')
> +			name++;
> +	}
> +
> +	ret = init_binder_features(sb);
> +	if (ret)
> +		return ret;
> +
> +	if (info->mount_opts.stats_mode == binderfs_stats_mode_global)
> +		return init_binder_logs(sb);
> +
> +	return 0;
> +}
> +
> +static int binderfs_fs_context_get_tree(struct fs_context *fc)
> +{
> +	return get_tree_nodev(fc, binderfs_fill_super);
> +}
> +
> +static void binderfs_fs_context_free(struct fs_context *fc)
> +{
> +	struct binderfs_mount_opts *ctx = fc->fs_private;
> +
> +	kfree(ctx);
> +}
> +
> +static const struct fs_context_operations binderfs_fs_context_ops = {
> +	.free		= binderfs_fs_context_free,
> +	.get_tree	= binderfs_fs_context_get_tree,
> +	.parse_param	= binderfs_fs_context_parse_param,
> +	.reconfigure	= binderfs_fs_context_reconfigure,
> +};
> +
> +static int binderfs_init_fs_context(struct fs_context *fc)
> +{
> +	struct binderfs_mount_opts *ctx;
> +
> +	ctx = kzalloc(sizeof(struct binderfs_mount_opts), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	ctx->max = BINDERFS_MAX_MINOR;
> +	ctx->stats_mode = binderfs_stats_mode_unset;
> +
> +	fc->fs_private = ctx;
> +	fc->ops = &binderfs_fs_context_ops;
> +
> +	return 0;
> +}
> +
> +static void binderfs_kill_super(struct super_block *sb)
> +{
> +	struct binderfs_info *info = sb->s_fs_info;
> +
> +	/*
> +	 * During inode eviction struct binderfs_info is needed.
> +	 * So first wipe the super_block then free struct binderfs_info.
> +	 */
> +	kill_litter_super(sb);
> +
> +	if (info && info->ipc_ns)
> +		put_ipc_ns(info->ipc_ns);
> +
> +	kfree(info);
> +}
> +
> +static struct file_system_type binder_fs_type = {
> +	.name			= "binder",
> +	.init_fs_context	= binderfs_init_fs_context,
> +	.parameters		= binderfs_fs_parameters,
> +	.kill_sb		= binderfs_kill_super,
> +	.fs_flags		= FS_USERNS_MOUNT,
> +};
> +
> +int init_rust_binderfs(void)
> +{
> +	int ret;
> +	const char *name;
> +	size_t len;
> +
> +	/* Verify that the default binderfs device names are valid. */
> +	name = rust_binder_devices_param;
> +	for (len = strcspn(name, ","); len > 0; len = strcspn(name, ",")) {
> +		if (len > BINDERFS_MAX_NAME)
> +			return -E2BIG;
> +		name += len;
> +		if (*name == ',')
> +			name++;
> +	}
> +
> +	/* Allocate new major number for binderfs. */
> +	ret = alloc_chrdev_region(&binderfs_dev, 0, BINDERFS_MAX_MINOR,
> +				  "rust_binder");
> +	if (ret)
> +		return ret;
> +
> +	ret = register_filesystem(&binder_fs_type);
> +	if (ret) {
> +		unregister_chrdev_region(binderfs_dev, BINDERFS_MAX_MINOR);
> +		return ret;
> +	}
> +
> +	return ret;
> +}

Hmm, is there anyway to keep a single binderfs.c implementation? In this
case we now have separate CONFIGs we could use for the file creation
callback? It would be nice to keep a single binderfs source file.


> diff --git a/drivers/android/binder/stats.rs b/drivers/android/binder/stats.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..a83ec111d2cb50e8cf3282fd14e3ac004648658b
> --- /dev/null
> +++ b/drivers/android/binder/stats.rs
> @@ -0,0 +1,89 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2025 Google LLC.
> +
> +//! Keep track of statistics for binder_logs.
> +
> +use crate::defs::*;
> +use core::sync::atomic::{AtomicU32, Ordering::Relaxed};
> +use kernel::{ioctl::_IOC_NR, seq_file::SeqFile, seq_print};
> +
> +const BC_COUNT: usize = _IOC_NR(BC_REPLY_SG) as usize + 1;
> +const BR_COUNT: usize = _IOC_NR(BR_TRANSACTION_PENDING_FROZEN) as usize + 1;
> +
> +pub(crate) static GLOBAL_STATS: BinderStats = BinderStats::new();
> +
> +pub(crate) struct BinderStats {
> +    bc: [AtomicU32; BC_COUNT],
> +    br: [AtomicU32; BR_COUNT],
> +}
> +
> +impl BinderStats {
> +    pub(crate) const fn new() -> Self {
> +        #[expect(clippy::declare_interior_mutable_const)]
> +        const ZERO: AtomicU32 = AtomicU32::new(0);
> +
> +        Self {
> +            bc: [ZERO; BC_COUNT],
> +            br: [ZERO; BR_COUNT],
> +        }
> +    }
> +
> +    pub(crate) fn inc_bc(&self, bc: u32) {
> +        let idx = _IOC_NR(bc) as usize;
> +        if let Some(bc_ref) = self.bc.get(idx) {
> +            bc_ref.fetch_add(1, Relaxed);
> +        }
> +    }
> +
> +    pub(crate) fn inc_br(&self, br: u32) {
> +        let idx = _IOC_NR(br) as usize;
> +        if let Some(br_ref) = self.br.get(idx) {
> +            br_ref.fetch_add(1, Relaxed);
> +        }
> +    }
> +
> +    pub(crate) fn debug_print(&self, prefix: &str, m: &SeqFile) {
> +        for (i, cnt) in self.bc.iter().enumerate() {
> +            let cnt = cnt.load(Relaxed);
> +            if cnt > 0 {
> +                seq_print!(m, "{}{}: {}\n", prefix, command_string(i), cnt);
> +            }
> +        }
> +        for (i, cnt) in self.br.iter().enumerate() {
> +            let cnt = cnt.load(Relaxed);
> +            if cnt > 0 {
> +                seq_print!(m, "{}{}: {}\n", prefix, return_string(i), cnt);
> +            }
> +        }
> +    }
> +}
> +
> +mod strings {
> +    use core::str::from_utf8_unchecked;
> +    use kernel::str::CStr;
> +
> +    extern "C" {
> +        static binder_command_strings: [*const u8; super::BC_COUNT];
> +        static binder_return_strings: [*const u8; super::BR_COUNT];
> +    }
> +
> +    pub(super) fn command_string(i: usize) -> &'static str {
> +        // SAFETY: Accessing `binder_command_strings` is always safe.
> +        let c_str_ptr = unsafe { binder_command_strings[i] };
> +        // SAFETY: The `binder_command_strings` array only contains nul-terminated strings.
> +        let bytes = unsafe { CStr::from_char_ptr(c_str_ptr) }.as_bytes();
> +        // SAFETY: The `binder_command_strings` array only contains strings with ascii-chars.
> +        unsafe { from_utf8_unchecked(bytes) }
> +    }
> +
> +    pub(super) fn return_string(i: usize) -> &'static str {
> +        // SAFETY: Accessing `binder_return_strings` is always safe.
> +        let c_str_ptr = unsafe { binder_return_strings[i] };
> +        // SAFETY: The `binder_command_strings` array only contains nul-terminated strings.
> +        let bytes = unsafe { CStr::from_char_ptr(c_str_ptr) }.as_bytes();
> +        // SAFETY: The `binder_command_strings` array only contains strings with ascii-chars.
> +        unsafe { from_utf8_unchecked(bytes) }
> +    }
> +}
> +use strings::{command_string, return_string};
> diff --git a/drivers/android/binder/thread.rs b/drivers/android/binder/thread.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..7e34ccd394f8049bab88562ffb4601739aea670a
> --- /dev/null
> +++ b/drivers/android/binder/thread.rs
> @@ -0,0 +1,1596 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2025 Google LLC.
> +
> +//! This module defines the `Thread` type, which represents a userspace thread that is using
> +//! binder.
> +//!
> +//! The `Process` object stores all of the threads in an rb tree.
> +
> +use kernel::{
> +    bindings,
> +    fs::{File, LocalFile},
> +    list::{AtomicTracker, List, ListArc, ListLinks, TryNewListArc},
> +    prelude::*,
> +    security,
> +    seq_file::SeqFile,
> +    seq_print,
> +    sync::poll::{PollCondVar, PollTable},
> +    sync::{Arc, SpinLock},
> +    task::Task,
> +    types::ARef,
> +    uaccess::UserSlice,
> +    uapi,
> +};
> +
> +use crate::{
> +    allocation::{Allocation, AllocationView, BinderObject, BinderObjectRef, NewAllocation},
> +    defs::*,
> +    error::BinderResult,
> +    process::{GetWorkOrRegister, Process},
> +    ptr_align,
> +    stats::GLOBAL_STATS,
> +    transaction::Transaction,
> +    BinderReturnWriter, DArc, DLArc, DTRWrap, DeliverCode, DeliverToRead,
> +};
> +
> +use core::{
> +    mem::size_of,
> +    sync::atomic::{AtomicU32, Ordering},
> +};
> +
> +/// Stores the layout of the scatter-gather entries. This is used during the `translate_objects`
> +/// call and is discarded when it returns.
> +struct ScatterGatherState {
> +    /// A struct that tracks the amount of unused buffer space.
> +    unused_buffer_space: UnusedBufferSpace,
> +    /// Scatter-gather entries to copy.
> +    sg_entries: KVec<ScatterGatherEntry>,
> +    /// Indexes into `sg_entries` corresponding to the last binder_buffer_object that
> +    /// was processed and all of its ancestors. The array is in sorted order.
> +    ancestors: KVec<usize>,
> +}
> +
> +/// This entry specifies an additional buffer that should be copied using the scatter-gather
> +/// mechanism.
> +struct ScatterGatherEntry {
> +    /// The index in the offset array of the BINDER_TYPE_PTR that this entry originates from.
> +    obj_index: usize,
> +    /// Offset in target buffer.
> +    offset: usize,
> +    /// User address in source buffer.
> +    sender_uaddr: usize,
> +    /// Number of bytes to copy.
> +    length: usize,
> +    /// The minimum offset of the next fixup in this buffer.
> +    fixup_min_offset: usize,
> +    /// The offsets within this buffer that contain pointers which should be translated.
> +    pointer_fixups: KVec<PointerFixupEntry>,
> +}
> +
> +/// This entry specifies that a fixup should happen at `target_offset` of the
> +/// buffer. If `skip` is nonzero, then the fixup is a `binder_fd_array_object`
> +/// and is applied later. Otherwise if `skip` is zero, then the size of the
> +/// fixup is `sizeof::<u64>()` and `pointer_value` is written to the buffer.
> +struct PointerFixupEntry {
> +    /// The number of bytes to skip, or zero for a `binder_buffer_object` fixup.
> +    skip: usize,
> +    /// The translated pointer to write when `skip` is zero.
> +    pointer_value: u64,
> +    /// The offset at which the value should be written. The offset is relative
> +    /// to the original buffer.
> +    target_offset: usize,
> +}
> +
> +/// Return type of `apply_and_validate_fixup_in_parent`.
> +struct ParentFixupInfo {
> +    /// The index of the parent buffer in `sg_entries`.
> +    parent_sg_index: usize,
> +    /// The number of ancestors of the buffer.
> +    ///
> +    /// The buffer is considered an ancestor of itself, so this is always at
> +    /// least one.
> +    num_ancestors: usize,
> +    /// New value of `fixup_min_offset` if this fixup is applied.
> +    new_min_offset: usize,
> +    /// The offset of the fixup in the target buffer.
> +    target_offset: usize,
> +}
> +
> +impl ScatterGatherState {
> +    /// Called when a `binder_buffer_object` or `binder_fd_array_object` tries
> +    /// to access a region in its parent buffer. These accesses have various
> +    /// restrictions, which this method verifies.
> +    ///
> +    /// The `parent_offset` and `length` arguments describe the offset and
> +    /// length of the access in the parent buffer.
> +    ///
> +    /// # Detailed restrictions
> +    ///
> +    /// Obviously the fixup must be in-bounds for the parent buffer.
> +    ///
> +    /// For safety reasons, we only allow fixups inside a buffer to happen
> +    /// at increasing offsets; additionally, we only allow fixup on the last
> +    /// buffer object that was verified, or one of its parents.
> +    ///
> +    /// Example of what is allowed:
> +    ///
> +    /// A
> +    ///   B (parent = A, offset = 0)
> +    ///   C (parent = A, offset = 16)
> +    ///     D (parent = C, offset = 0)
> +    ///   E (parent = A, offset = 32) // min_offset is 16 (C.parent_offset)
> +    ///
> +    /// Examples of what is not allowed:
> +    ///
> +    /// Decreasing offsets within the same parent:
> +    /// A
> +    ///   C (parent = A, offset = 16)
> +    ///   B (parent = A, offset = 0) // decreasing offset within A
> +    ///
> +    /// Arcerring to a parent that wasn't the last object or any of its parents:
> +    /// A
> +    ///   B (parent = A, offset = 0)
> +    ///   C (parent = A, offset = 0)
> +    ///   C (parent = A, offset = 16)
> +    ///     D (parent = B, offset = 0) // B is not A or any of A's parents
> +    fn validate_parent_fixup(
> +        &self,
> +        parent: usize,
> +        parent_offset: usize,
> +        length: usize,
> +    ) -> Result<ParentFixupInfo> {
> +        // Using `position` would also be correct, but `rposition` avoids
> +        // quadratic running times.
> +        let ancestors_i = self
> +            .ancestors
> +            .iter()
> +            .copied()
> +            .rposition(|sg_idx| self.sg_entries[sg_idx].obj_index == parent)
> +            .ok_or(EINVAL)?;
> +        let sg_idx = self.ancestors[ancestors_i];
> +        let sg_entry = match self.sg_entries.get(sg_idx) {
> +            Some(sg_entry) => sg_entry,
> +            None => {
> +                pr_err!(
> +                    "self.ancestors[{}] is {}, but self.sg_entries.len() is {}",
> +                    ancestors_i,
> +                    sg_idx,
> +                    self.sg_entries.len()
> +                );
> +                return Err(EINVAL);
> +            }
> +        };
> +        if sg_entry.fixup_min_offset > parent_offset {
> +            pr_warn!(
> +                "validate_parent_fixup: fixup_min_offset={}, parent_offset={}",
> +                sg_entry.fixup_min_offset,
> +                parent_offset
> +            );
> +            return Err(EINVAL);
> +        }
> +        let new_min_offset = parent_offset.checked_add(length).ok_or(EINVAL)?;
> +        if new_min_offset > sg_entry.length {
> +            pr_warn!(
> +                "validate_parent_fixup: new_min_offset={}, sg_entry.length={}",
> +                new_min_offset,
> +                sg_entry.length
> +            );
> +            return Err(EINVAL);
> +        }
> +        let target_offset = sg_entry.offset.checked_add(parent_offset).ok_or(EINVAL)?;
> +        // The `ancestors_i + 1` operation can't overflow since the output of the addition is at
> +        // most `self.ancestors.len()`, which also fits in a usize.
> +        Ok(ParentFixupInfo {
> +            parent_sg_index: sg_idx,
> +            num_ancestors: ancestors_i + 1,
> +            new_min_offset,
> +            target_offset,
> +        })
> +    }
> +}
> +
> +/// Keeps track of how much unused buffer space is left. The initial amount is the number of bytes
> +/// requested by the user using the `buffers_size` field of `binder_transaction_data_sg`. Each time
> +/// we translate an object of type `BINDER_TYPE_PTR`, some of the unused buffer space is consumed.
> +struct UnusedBufferSpace {
> +    /// The start of the remaining space.
> +    offset: usize,
> +    /// The end of the remaining space.
> +    limit: usize,
> +}
> +impl UnusedBufferSpace {
> +    /// Claim the next `size` bytes from the unused buffer space. The offset for the claimed chunk
> +    /// into the buffer is returned.
> +    fn claim_next(&mut self, size: usize) -> Result<usize> {
> +        // We require every chunk to be aligned.
> +        let size = ptr_align(size).ok_or(EINVAL)?;
> +        let new_offset = self.offset.checked_add(size).ok_or(EINVAL)?;
> +
> +        if new_offset <= self.limit {
> +            let offset = self.offset;
> +            self.offset = new_offset;
> +            Ok(offset)
> +        } else {
> +            Err(EINVAL)
> +        }
> +    }
> +}
> +
> +pub(crate) enum PushWorkRes {
> +    Ok,
> +    FailedDead(DLArc<dyn DeliverToRead>),
> +}
> +
> +impl PushWorkRes {
> +    fn is_ok(&self) -> bool {
> +        match self {
> +            PushWorkRes::Ok => true,
> +            PushWorkRes::FailedDead(_) => false,
> +        }
> +    }
> +}
> +
> +/// The fields of `Thread` protected by the spinlock.
> +struct InnerThread {
> +    /// Determines the looper state of the thread. It is a bit-wise combination of the constants
> +    /// prefixed with `LOOPER_`.
> +    looper_flags: u32,
> +
> +    /// Determines whether the looper should return.
> +    looper_need_return: bool,
> +
> +    /// Determines if thread is dead.
> +    is_dead: bool,
> +
> +    /// Work item used to deliver error codes to the thread that started a transaction. Stored here
> +    /// so that it can be reused.
> +    reply_work: DArc<ThreadError>,
> +
> +    /// Work item used to deliver error codes to the current thread. Stored here so that it can be
> +    /// reused.
> +    return_work: DArc<ThreadError>,
> +
> +    /// Determines whether the work list below should be processed. When set to false, `work_list`
> +    /// is treated as if it were empty.
> +    process_work_list: bool,
> +    /// List of work items to deliver to userspace.
> +    work_list: List<DTRWrap<dyn DeliverToRead>>,
> +    current_transaction: Option<DArc<Transaction>>,
> +
> +    /// Extended error information for this thread.
> +    extended_error: ExtendedError,
> +}
> +
> +const LOOPER_REGISTERED: u32 = 0x01;
> +const LOOPER_ENTERED: u32 = 0x02;
> +const LOOPER_EXITED: u32 = 0x04;
> +const LOOPER_INVALID: u32 = 0x08;
> +const LOOPER_WAITING: u32 = 0x10;
> +const LOOPER_WAITING_PROC: u32 = 0x20;
> +const LOOPER_POLL: u32 = 0x40;
> +
> +impl InnerThread {
> +    fn new() -> Result<Self> {
> +        fn next_err_id() -> u32 {
> +            static EE_ID: AtomicU32 = AtomicU32::new(0);
> +            EE_ID.fetch_add(1, Ordering::Relaxed)
> +        }
> +
> +        Ok(Self {
> +            looper_flags: 0,
> +            looper_need_return: false,
> +            is_dead: false,
> +            process_work_list: false,
> +            reply_work: ThreadError::try_new()?,
> +            return_work: ThreadError::try_new()?,
> +            work_list: List::new(),
> +            current_transaction: None,
> +            extended_error: ExtendedError::new(next_err_id(), BR_OK, 0),
> +        })
> +    }
> +
> +    fn pop_work(&mut self) -> Option<DLArc<dyn DeliverToRead>> {
> +        if !self.process_work_list {
> +            return None;
> +        }
> +
> +        let ret = self.work_list.pop_front();
> +        self.process_work_list = !self.work_list.is_empty();
> +        ret
> +    }
> +
> +    fn push_work(&mut self, work: DLArc<dyn DeliverToRead>) -> PushWorkRes {
> +        if self.is_dead {
> +            PushWorkRes::FailedDead(work)
> +        } else {
> +            self.work_list.push_back(work);
> +            self.process_work_list = true;
> +            PushWorkRes::Ok
> +        }
> +    }
> +
> +    fn push_reply_work(&mut self, code: u32) {
> +        if let Ok(work) = ListArc::try_from_arc(self.reply_work.clone()) {
> +            work.set_error_code(code);
> +            self.push_work(work);
> +        } else {
> +            pr_warn!("Thread reply work is already in use.");
> +        }
> +    }
> +
> +    fn push_return_work(&mut self, reply: u32) {
> +        if let Ok(work) = ListArc::try_from_arc(self.return_work.clone()) {
> +            work.set_error_code(reply);
> +            self.push_work(work);
> +        } else {
> +            pr_warn!("Thread return work is already in use.");
> +        }
> +    }
> +
> +    /// Used to push work items that do not need to be processed immediately and can wait until the
> +    /// thread gets another work item.
> +    fn push_work_deferred(&mut self, work: DLArc<dyn DeliverToRead>) {
> +        self.work_list.push_back(work);
> +    }
> +
> +    /// Fetches the transaction this thread can reply to. If the thread has a pending transaction
> +    /// (that it could respond to) but it has also issued a transaction, it must first wait for the
> +    /// previously-issued transaction to complete.
> +    ///
> +    /// The `thread` parameter should be the thread containing this `ThreadInner`.
> +    fn pop_transaction_to_reply(&mut self, thread: &Thread) -> Result<DArc<Transaction>> {
> +        let transaction = self.current_transaction.take().ok_or(EINVAL)?;
> +        if core::ptr::eq(thread, transaction.from.as_ref()) {
> +            self.current_transaction = Some(transaction);
> +            return Err(EINVAL);
> +        }
> +        // Find a new current transaction for this thread.
> +        self.current_transaction = transaction.find_from(thread).cloned();
> +        Ok(transaction)
> +    }
> +
> +    fn pop_transaction_replied(&mut self, transaction: &DArc<Transaction>) -> bool {
> +        match self.current_transaction.take() {
> +            None => false,
> +            Some(old) => {
> +                if !Arc::ptr_eq(transaction, &old) {
> +                    self.current_transaction = Some(old);
> +                    return false;
> +                }
> +                self.current_transaction = old.clone_next();
> +                true
> +            }
> +        }
> +    }
> +
> +    fn looper_enter(&mut self) {
> +        self.looper_flags |= LOOPER_ENTERED;
> +        if self.looper_flags & LOOPER_REGISTERED != 0 {
> +            self.looper_flags |= LOOPER_INVALID;
> +        }
> +    }
> +
> +    fn looper_register(&mut self, valid: bool) {
> +        self.looper_flags |= LOOPER_REGISTERED;
> +        if !valid || self.looper_flags & LOOPER_ENTERED != 0 {
> +            self.looper_flags |= LOOPER_INVALID;
> +        }
> +    }
> +
> +    fn looper_exit(&mut self) {
> +        self.looper_flags |= LOOPER_EXITED;
> +    }
> +
> +    /// Determines whether the thread is part of a pool, i.e., if it is a looper.
> +    fn is_looper(&self) -> bool {
> +        self.looper_flags & (LOOPER_ENTERED | LOOPER_REGISTERED) != 0
> +    }
> +
> +    /// Determines whether the thread should attempt to fetch work items from the process queue.
> +    /// This is generally case when the thread is registered as a looper and not part of a
> +    /// transaction stack. But if there is local work, we want to return to userspace before we
> +    /// deliver any remote work.
> +    fn should_use_process_work_queue(&self) -> bool {
> +        self.current_transaction.is_none() && !self.process_work_list && self.is_looper()
> +    }
> +
> +    fn poll(&mut self) -> u32 {
> +        self.looper_flags |= LOOPER_POLL;
> +        if self.process_work_list || self.looper_need_return {
> +            bindings::POLLIN
> +        } else {
> +            0
> +        }
> +    }
> +}
> +
> +/// This represents a thread that's used with binder.
> +#[pin_data]
> +pub(crate) struct Thread {
> +    pub(crate) id: i32,
> +    pub(crate) process: Arc<Process>,
> +    pub(crate) task: ARef<Task>,
> +    #[pin]
> +    inner: SpinLock<InnerThread>,
> +    #[pin]
> +    work_condvar: PollCondVar,
> +    /// Used to insert this thread into the process' `ready_threads` list.
> +    ///
> +    /// INVARIANT: May never be used for any other list than the `self.process.ready_threads`.
> +    #[pin]
> +    links: ListLinks,
> +    #[pin]
> +    links_track: AtomicTracker,
> +}
> +
> +kernel::list::impl_list_arc_safe! {
> +    impl ListArcSafe<0> for Thread {
> +        tracked_by links_track: AtomicTracker;
> +    }
> +}
> +kernel::list::impl_list_item! {
> +    impl ListItem<0> for Thread {
> +        using ListLinks { self.links };
> +    }
> +}
> +
> +impl Thread {
> +    pub(crate) fn new(id: i32, process: Arc<Process>) -> Result<Arc<Self>> {
> +        let inner = InnerThread::new()?;
> +
> +        Arc::pin_init(
> +            try_pin_init!(Thread {
> +                id,
> +                process,
> +                task: ARef::from(&**kernel::current!()),
> +                inner <- kernel::new_spinlock!(inner, "Thread::inner"),
> +                work_condvar <- kernel::new_poll_condvar!("Thread::work_condvar"),
> +                links <- ListLinks::new(),
> +                links_track <- AtomicTracker::new(),
> +            }),
> +            GFP_KERNEL,
> +        )
> +    }
> +
> +    #[inline(never)]
> +    pub(crate) fn debug_print(self: &Arc<Self>, m: &SeqFile, print_all: bool) -> Result<()> {
> +        let inner = self.inner.lock();
> +
> +        if print_all || inner.current_transaction.is_some() || !inner.work_list.is_empty() {
> +            seq_print!(
> +                m,
> +                "  thread {}: l {:02x} need_return {}\n",
> +                self.id,
> +                inner.looper_flags,
> +                inner.looper_need_return,
> +            );
> +        }
> +
> +        let mut t_opt = inner.current_transaction.as_ref();
> +        while let Some(t) = t_opt {
> +            if Arc::ptr_eq(&t.from, self) {
> +                t.debug_print_inner(m, "    outgoing transaction ");
> +                t_opt = t.from_parent.as_ref();
> +            } else if Arc::ptr_eq(&t.to, &self.process) {
> +                t.debug_print_inner(m, "    incoming transaction ");
> +                t_opt = t.find_from(self);
> +            } else {
> +                t.debug_print_inner(m, "    bad transaction ");
> +                t_opt = None;
> +            }
> +        }
> +
> +        for work in &inner.work_list {
> +            work.debug_print(m, "    ", "    pending transaction ")?;
> +        }
> +        Ok(())
> +    }
> +
> +    pub(crate) fn get_extended_error(&self, data: UserSlice) -> Result {
> +        let mut writer = data.writer();
> +        let ee = self.inner.lock().extended_error;
> +        writer.write(&ee)?;
> +        Ok(())
> +    }
> +
> +    pub(crate) fn set_current_transaction(&self, transaction: DArc<Transaction>) {
> +        self.inner.lock().current_transaction = Some(transaction);
> +    }
> +
> +    pub(crate) fn has_current_transaction(&self) -> bool {
> +        self.inner.lock().current_transaction.is_some()
> +    }
> +
> +    /// Attempts to fetch a work item from the thread-local queue. The behaviour if the queue is
> +    /// empty depends on `wait`: if it is true, the function waits for some work to be queued (or a
> +    /// signal); otherwise it returns indicating that none is available.
> +    fn get_work_local(self: &Arc<Self>, wait: bool) -> Result<Option<DLArc<dyn DeliverToRead>>> {
> +        {
> +            let mut inner = self.inner.lock();
> +            if inner.looper_need_return {
> +                return Ok(inner.pop_work());
> +            }
> +        }
> +
> +        // Try once if the caller does not want to wait.
> +        if !wait {
> +            return self.inner.lock().pop_work().ok_or(EAGAIN).map(Some);
> +        }
> +
> +        // Loop waiting only on the local queue (i.e., not registering with the process queue).
> +        let mut inner = self.inner.lock();
> +        loop {
> +            if let Some(work) = inner.pop_work() {
> +                return Ok(Some(work));
> +            }
> +
> +            inner.looper_flags |= LOOPER_WAITING;
> +            let signal_pending = self.work_condvar.wait_interruptible_freezable(&mut inner);
> +            inner.looper_flags &= !LOOPER_WAITING;
> +
> +            if signal_pending {
> +                return Err(EINTR);
> +            }
> +            if inner.looper_need_return {
> +                return Ok(None);
> +            }
> +        }
> +    }
> +
> +    /// Attempts to fetch a work item from the thread-local queue, falling back to the process-wide
> +    /// queue if none is available locally.
> +    ///
> +    /// This must only be called when the thread is not participating in a transaction chain. If it
> +    /// is, the local version (`get_work_local`) should be used instead.
> +    fn get_work(self: &Arc<Self>, wait: bool) -> Result<Option<DLArc<dyn DeliverToRead>>> {
> +        // Try to get work from the thread's work queue, using only a local lock.
> +        {
> +            let mut inner = self.inner.lock();
> +            if let Some(work) = inner.pop_work() {
> +                return Ok(Some(work));
> +            }
> +            if inner.looper_need_return {
> +                drop(inner);
> +                return Ok(self.process.get_work());
> +            }
> +        }
> +
> +        // If the caller doesn't want to wait, try to grab work from the process queue.
> +        //
> +        // We know nothing will have been queued directly to the thread queue because it is not in
> +        // a transaction and it is not in the process' ready list.
> +        if !wait {
> +            return self.process.get_work().ok_or(EAGAIN).map(Some);
> +        }
> +
> +        // Get work from the process queue. If none is available, atomically register as ready.
> +        let reg = match self.process.get_work_or_register(self) {
> +            GetWorkOrRegister::Work(work) => return Ok(Some(work)),
> +            GetWorkOrRegister::Register(reg) => reg,
> +        };
> +
> +        let mut inner = self.inner.lock();
> +        loop {
> +            if let Some(work) = inner.pop_work() {
> +                return Ok(Some(work));
> +            }
> +
> +            inner.looper_flags |= LOOPER_WAITING | LOOPER_WAITING_PROC;
> +            let signal_pending = self.work_condvar.wait_interruptible_freezable(&mut inner);
> +            inner.looper_flags &= !(LOOPER_WAITING | LOOPER_WAITING_PROC);
> +
> +            if signal_pending || inner.looper_need_return {
> +                // We need to return now. We need to pull the thread off the list of ready threads
> +                // (by dropping `reg`), then check the state again after it's off the list to
> +                // ensure that something was not queued in the meantime. If something has been
> +                // queued, we just return it (instead of the error).
> +                drop(inner);
> +                drop(reg);
> +
> +                let res = match self.inner.lock().pop_work() {
> +                    Some(work) => Ok(Some(work)),
> +                    None if signal_pending => Err(EINTR),
> +                    None => Ok(None),
> +                };
> +                return res;
> +            }
> +        }
> +    }
> +
> +    /// Push the provided work item to be delivered to user space via this thread.
> +    ///
> +    /// Returns whether the item was successfully pushed. This can only fail if the thread is dead.
> +    pub(crate) fn push_work(&self, work: DLArc<dyn DeliverToRead>) -> PushWorkRes {
> +        let sync = work.should_sync_wakeup();
> +
> +        let res = self.inner.lock().push_work(work);
> +
> +        if res.is_ok() {
> +            if sync {
> +                self.work_condvar.notify_sync();
> +            } else {
> +                self.work_condvar.notify_one();
> +            }
> +        }
> +
> +        res
> +    }
> +
> +    /// Attempts to push to given work item to the thread if it's a looper thread (i.e., if it's
> +    /// part of a thread pool) and is alive. Otherwise, push the work item to the process instead.
> +    pub(crate) fn push_work_if_looper(&self, work: DLArc<dyn DeliverToRead>) -> BinderResult {
> +        let mut inner = self.inner.lock();
> +        if inner.is_looper() && !inner.is_dead {
> +            inner.push_work(work);
> +            Ok(())
> +        } else {
> +            drop(inner);
> +            self.process.push_work(work)
> +        }
> +    }
> +
> +    pub(crate) fn push_work_deferred(&self, work: DLArc<dyn DeliverToRead>) {
> +        self.inner.lock().push_work_deferred(work);
> +    }
> +
> +    pub(crate) fn push_return_work(&self, reply: u32) {
> +        self.inner.lock().push_return_work(reply);
> +    }
> +
> +    fn translate_object(
> +        &self,
> +        obj_index: usize,
> +        offset: usize,
> +        object: BinderObjectRef<'_>,
> +        view: &mut AllocationView<'_>,
> +        allow_fds: bool,
> +        sg_state: &mut ScatterGatherState,
> +    ) -> BinderResult {
> +        match object {
> +            BinderObjectRef::Binder(obj) => {
> +                let strong = obj.hdr.type_ == BINDER_TYPE_BINDER;
> +                // SAFETY: `binder` is a `binder_uintptr_t`; any bit pattern is a valid
> +                // representation.
> +                let ptr = unsafe { obj.__bindgen_anon_1.binder } as _;
> +                let cookie = obj.cookie as _;
> +                let flags = obj.flags as _;
> +                let node = self
> +                    .process
> +                    .as_arc_borrow()
> +                    .get_node(ptr, cookie, flags, strong, self)?;
> +                security::binder_transfer_binder(&self.process.cred, &view.alloc.process.cred)?;
> +                view.transfer_binder_object(offset, obj, strong, node)?;
> +            }
> +            BinderObjectRef::Handle(obj) => {
> +                let strong = obj.hdr.type_ == BINDER_TYPE_HANDLE;
> +                // SAFETY: `handle` is a `u32`; any bit pattern is a valid representation.
> +                let handle = unsafe { obj.__bindgen_anon_1.handle } as _;
> +                let node = self.process.get_node_from_handle(handle, strong)?;
> +                security::binder_transfer_binder(&self.process.cred, &view.alloc.process.cred)?;
> +                view.transfer_binder_object(offset, obj, strong, node)?;
> +            }
> +            BinderObjectRef::Fd(obj) => {
> +                if !allow_fds {
> +                    return Err(EPERM.into());
> +                }
> +
> +                // SAFETY: `fd` is a `u32`; any bit pattern is a valid representation.
> +                let fd = unsafe { obj.__bindgen_anon_1.fd };
> +                let file = LocalFile::fget(fd)?;
> +                // SAFETY: The binder driver never calls `fdget_pos` and this code runs from an
> +                // ioctl, so there are no active calls to `fdget_pos` on this thread.
> +                let file = unsafe { LocalFile::assume_no_fdget_pos(file) };
> +                security::binder_transfer_file(
> +                    &self.process.cred,
> +                    &view.alloc.process.cred,
> +                    &file,
> +                )?;
> +
> +                let mut obj_write = BinderFdObject::default();
> +                obj_write.hdr.type_ = BINDER_TYPE_FD;
> +                // This will be overwritten with the actual fd when the transaction is received.
> +                obj_write.__bindgen_anon_1.fd = u32::MAX;
> +                obj_write.cookie = obj.cookie;
> +                view.write::<BinderFdObject>(offset, &obj_write)?;
> +
> +                const FD_FIELD_OFFSET: usize =
> +                    core::mem::offset_of!(uapi::binder_fd_object, __bindgen_anon_1.fd);
> +
> +                let field_offset = offset + FD_FIELD_OFFSET;
> +
> +                view.alloc.info_add_fd(file, field_offset, false)?;
> +            }
> +            BinderObjectRef::Ptr(obj) => {
> +                let obj_length = obj.length.try_into().map_err(|_| EINVAL)?;
> +                let alloc_offset = match sg_state.unused_buffer_space.claim_next(obj_length) {
> +                    Ok(alloc_offset) => alloc_offset,
> +                    Err(err) => {
> +                        pr_warn!(
> +                            "Failed to claim space for a BINDER_TYPE_PTR. (offset: {}, limit: {}, size: {})",
> +                            sg_state.unused_buffer_space.offset,
> +                            sg_state.unused_buffer_space.limit,
> +                            obj_length,
> +                        );
> +                        return Err(err.into());
> +                    }
> +                };
> +
> +                let sg_state_idx = sg_state.sg_entries.len();
> +                sg_state.sg_entries.push(
> +                    ScatterGatherEntry {
> +                        obj_index,
> +                        offset: alloc_offset,
> +                        sender_uaddr: obj.buffer as _,
> +                        length: obj_length,
> +                        pointer_fixups: KVec::new(),
> +                        fixup_min_offset: 0,
> +                    },
> +                    GFP_KERNEL,
> +                )?;
> +
> +                let buffer_ptr_in_user_space = (view.alloc.ptr + alloc_offset) as u64;
> +
> +                if obj.flags & uapi::BINDER_BUFFER_FLAG_HAS_PARENT == 0 {
> +                    sg_state.ancestors.clear();
> +                    sg_state.ancestors.push(sg_state_idx, GFP_KERNEL)?;
> +                } else {
> +                    // Another buffer also has a pointer to this buffer, and we need to fixup that
> +                    // pointer too.
> +
> +                    let parent_index = usize::try_from(obj.parent).map_err(|_| EINVAL)?;
> +                    let parent_offset = usize::try_from(obj.parent_offset).map_err(|_| EINVAL)?;
> +
> +                    let info = sg_state.validate_parent_fixup(
> +                        parent_index,
> +                        parent_offset,
> +                        size_of::<u64>(),
> +                    )?;
> +
> +                    sg_state.ancestors.truncate(info.num_ancestors);
> +                    sg_state.ancestors.push(sg_state_idx, GFP_KERNEL)?;
> +
> +                    let parent_entry = match sg_state.sg_entries.get_mut(info.parent_sg_index) {
> +                        Some(parent_entry) => parent_entry,
> +                        None => {
> +                            pr_err!(
> +                                "validate_parent_fixup returned index out of bounds for sg.entries"
> +                            );
> +                            return Err(EINVAL.into());
> +                        }
> +                    };
> +
> +                    parent_entry.fixup_min_offset = info.new_min_offset;
> +                    parent_entry.pointer_fixups.push(
> +                        PointerFixupEntry {
> +                            skip: 0,
> +                            pointer_value: buffer_ptr_in_user_space,
> +                            target_offset: info.target_offset,
> +                        },
> +                        GFP_KERNEL,
> +                    )?;
> +                }
> +
> +                let mut obj_write = BinderBufferObject::default();
> +                obj_write.hdr.type_ = BINDER_TYPE_PTR;
> +                obj_write.flags = obj.flags;
> +                obj_write.buffer = buffer_ptr_in_user_space;
> +                obj_write.length = obj.length;
> +                obj_write.parent = obj.parent;
> +                obj_write.parent_offset = obj.parent_offset;
> +                view.write::<BinderBufferObject>(offset, &obj_write)?;
> +            }
> +            BinderObjectRef::Fda(obj) => {
> +                if !allow_fds {
> +                    return Err(EPERM.into());
> +                }
> +                let parent_index = usize::try_from(obj.parent).map_err(|_| EINVAL)?;
> +                let parent_offset = usize::try_from(obj.parent_offset).map_err(|_| EINVAL)?;
> +                let num_fds = usize::try_from(obj.num_fds).map_err(|_| EINVAL)?;
> +                let fds_len = num_fds.checked_mul(size_of::<u32>()).ok_or(EINVAL)?;
> +
> +                let info = sg_state.validate_parent_fixup(parent_index, parent_offset, fds_len)?;
> +                view.alloc.info_add_fd_reserve(num_fds)?;
> +
> +                sg_state.ancestors.truncate(info.num_ancestors);
> +                let parent_entry = match sg_state.sg_entries.get_mut(info.parent_sg_index) {
> +                    Some(parent_entry) => parent_entry,
> +                    None => {
> +                        pr_err!(
> +                            "validate_parent_fixup returned index out of bounds for sg.entries"
> +                        );
> +                        return Err(EINVAL.into());
> +                    }
> +                };
> +
> +                parent_entry.fixup_min_offset = info.new_min_offset;
> +                parent_entry
> +                    .pointer_fixups
> +                    .push(
> +                        PointerFixupEntry {
> +                            skip: fds_len,
> +                            pointer_value: 0,
> +                            target_offset: info.target_offset,
> +                        },
> +                        GFP_KERNEL,
> +                    )
> +                    .map_err(|_| ENOMEM)?;
> +
> +                let fda_uaddr = parent_entry
> +                    .sender_uaddr
> +                    .checked_add(parent_offset)
> +                    .ok_or(EINVAL)?;
> +                let mut fda_bytes = KVec::new();
> +                UserSlice::new(UserPtr::from_addr(fda_uaddr as _), fds_len)
> +                    .read_all(&mut fda_bytes, GFP_KERNEL)?;
> +
> +                if fds_len != fda_bytes.len() {
> +                    pr_err!("UserSlice::read_all returned wrong length in BINDER_TYPE_FDA");
> +                    return Err(EINVAL.into());
> +                }
> +
> +                for i in (0..fds_len).step_by(size_of::<u32>()) {
> +                    let fd = {
> +                        let mut fd_bytes = [0u8; size_of::<u32>()];
> +                        fd_bytes.copy_from_slice(&fda_bytes[i..i + size_of::<u32>()]);
> +                        u32::from_ne_bytes(fd_bytes)
> +                    };
> +
> +                    let file = LocalFile::fget(fd)?;
> +                    // SAFETY: The binder driver never calls `fdget_pos` and this code runs from an
> +                    // ioctl, so there are no active calls to `fdget_pos` on this thread.
> +                    let file = unsafe { LocalFile::assume_no_fdget_pos(file) };
> +                    security::binder_transfer_file(
> +                        &self.process.cred,
> +                        &view.alloc.process.cred,
> +                        &file,
> +                    )?;
> +
> +                    // The `validate_parent_fixup` call ensuers that this addition will not
> +                    // overflow.
> +                    view.alloc.info_add_fd(file, info.target_offset + i, true)?;
> +                }
> +                drop(fda_bytes);
> +
> +                let mut obj_write = BinderFdArrayObject::default();
> +                obj_write.hdr.type_ = BINDER_TYPE_FDA;
> +                obj_write.num_fds = obj.num_fds;
> +                obj_write.parent = obj.parent;
> +                obj_write.parent_offset = obj.parent_offset;
> +                view.write::<BinderFdArrayObject>(offset, &obj_write)?;
> +            }
> +        }
> +        Ok(())
> +    }
> +
> +    fn apply_sg(&self, alloc: &mut Allocation, sg_state: &mut ScatterGatherState) -> BinderResult {
> +        for sg_entry in &mut sg_state.sg_entries {
> +            let mut end_of_previous_fixup = sg_entry.offset;
> +            let offset_end = sg_entry.offset.checked_add(sg_entry.length).ok_or(EINVAL)?;
> +
> +            let mut reader =
> +                UserSlice::new(UserPtr::from_addr(sg_entry.sender_uaddr), sg_entry.length).reader();
> +            for fixup in &mut sg_entry.pointer_fixups {
> +                let fixup_len = if fixup.skip == 0 {
> +                    size_of::<u64>()
> +                } else {
> +                    fixup.skip
> +                };
> +
> +                let target_offset_end = fixup.target_offset.checked_add(fixup_len).ok_or(EINVAL)?;
> +                if fixup.target_offset < end_of_previous_fixup || offset_end < target_offset_end {
> +                    pr_warn!(
> +                        "Fixups oob {} {} {} {}",
> +                        fixup.target_offset,
> +                        end_of_previous_fixup,
> +                        offset_end,
> +                        target_offset_end
> +                    );
> +                    return Err(EINVAL.into());
> +                }
> +
> +                let copy_off = end_of_previous_fixup;
> +                let copy_len = fixup.target_offset - end_of_previous_fixup;
> +                if let Err(err) = alloc.copy_into(&mut reader, copy_off, copy_len) {
> +                    pr_warn!("Failed copying into alloc: {:?}", err);
> +                    return Err(err.into());
> +                }
> +                if fixup.skip == 0 {
> +                    let res = alloc.write::<u64>(fixup.target_offset, &fixup.pointer_value);
> +                    if let Err(err) = res {
> +                        pr_warn!("Failed copying ptr into alloc: {:?}", err);
> +                        return Err(err.into());
> +                    }
> +                }
> +                if let Err(err) = reader.skip(fixup_len) {
> +                    pr_warn!("Failed skipping {} from reader: {:?}", fixup_len, err);
> +                    return Err(err.into());
> +                }
> +                end_of_previous_fixup = target_offset_end;
> +            }
> +            let copy_off = end_of_previous_fixup;
> +            let copy_len = offset_end - end_of_previous_fixup;
> +            if let Err(err) = alloc.copy_into(&mut reader, copy_off, copy_len) {
> +                pr_warn!("Failed copying remainder into alloc: {:?}", err);
> +                return Err(err.into());
> +            }
> +        }
> +        Ok(())
> +    }
> +
> +    /// This method copies the payload of a transaction into the target process.
> +    ///
> +    /// The resulting payload will have several different components, which will be stored next to
> +    /// each other in the allocation. Furthermore, various objects can be embedded in the payload,
> +    /// and those objects have to be translated so that they make sense to the target transaction.
> +    pub(crate) fn copy_transaction_data(
> +        &self,
> +        to_process: Arc<Process>,
> +        tr: &BinderTransactionDataSg,
> +        debug_id: usize,
> +        allow_fds: bool,
> +        txn_security_ctx_offset: Option<&mut usize>,
> +    ) -> BinderResult<NewAllocation> {
> +        let trd = &tr.transaction_data;
> +        let is_oneway = trd.flags & TF_ONE_WAY != 0;
> +        let mut secctx = if let Some(offset) = txn_security_ctx_offset {
> +            let secid = self.process.cred.get_secid();
> +            let ctx = match security::SecurityCtx::from_secid(secid) {
> +                Ok(ctx) => ctx,
> +                Err(err) => {
> +                    pr_warn!("Failed to get security ctx for id {}: {:?}", secid, err);
> +                    return Err(err.into());
> +                }
> +            };
> +            Some((offset, ctx))
> +        } else {
> +            None
> +        };
> +
> +        let data_size = trd.data_size.try_into().map_err(|_| EINVAL)?;
> +        let aligned_data_size = ptr_align(data_size).ok_or(EINVAL)?;
> +        let offsets_size = trd.offsets_size.try_into().map_err(|_| EINVAL)?;
> +        let aligned_offsets_size = ptr_align(offsets_size).ok_or(EINVAL)?;
> +        let buffers_size = tr.buffers_size.try_into().map_err(|_| EINVAL)?;
> +        let aligned_buffers_size = ptr_align(buffers_size).ok_or(EINVAL)?;
> +        let aligned_secctx_size = match secctx.as_ref() {
> +            Some((_offset, ctx)) => ptr_align(ctx.len()).ok_or(EINVAL)?,
> +            None => 0,
> +        };
> +
> +        // This guarantees that at least `sizeof(usize)` bytes will be allocated.
> +        let len = usize::max(
> +            aligned_data_size
> +                .checked_add(aligned_offsets_size)
> +                .and_then(|sum| sum.checked_add(aligned_buffers_size))
> +                .and_then(|sum| sum.checked_add(aligned_secctx_size))
> +                .ok_or(ENOMEM)?,
> +            size_of::<usize>(),
> +        );
> +        let secctx_off = aligned_data_size + aligned_offsets_size + aligned_buffers_size;
> +        let mut alloc =
> +            match to_process.buffer_alloc(debug_id, len, is_oneway, self.process.task.pid()) {
> +                Ok(alloc) => alloc,
> +                Err(err) => {
> +                    pr_warn!(
> +                        "Failed to allocate buffer. len:{}, is_oneway:{}",
> +                        len,
> +                        is_oneway
> +                    );
> +                    return Err(err);
> +                }
> +            };
> +
> +        // SAFETY: This accesses a union field, but it's okay because the field's type is valid for
> +        // all bit-patterns.
> +        let trd_data_ptr = unsafe { &trd.data.ptr };
> +        let mut buffer_reader =
> +            UserSlice::new(UserPtr::from_addr(trd_data_ptr.buffer as _), data_size).reader();
> +        let mut end_of_previous_object = 0;
> +        let mut sg_state = None;
> +
> +        // Copy offsets if there are any.
> +        if offsets_size > 0 {
> +            {
> +                let mut reader =
> +                    UserSlice::new(UserPtr::from_addr(trd_data_ptr.offsets as _), offsets_size)
> +                        .reader();
> +                alloc.copy_into(&mut reader, aligned_data_size, offsets_size)?;
> +            }
> +
> +            let offsets_start = aligned_data_size;
> +            let offsets_end = aligned_data_size + aligned_offsets_size;
> +
> +            // This state is used for BINDER_TYPE_PTR objects.
> +            let sg_state = sg_state.insert(ScatterGatherState {
> +                unused_buffer_space: UnusedBufferSpace {
> +                    offset: offsets_end,
> +                    limit: len,
> +                },
> +                sg_entries: KVec::new(),
> +                ancestors: KVec::new(),
> +            });
> +
> +            // Traverse the objects specified.
> +            let mut view = AllocationView::new(&mut alloc, data_size);
> +            for (index, index_offset) in (offsets_start..offsets_end)
> +                .step_by(size_of::<usize>())
> +                .enumerate()
> +            {
> +                let offset = view.alloc.read(index_offset)?;
> +
> +                if offset < end_of_previous_object {
> +                    pr_warn!("Got transaction with invalid offset.");
> +                    return Err(EINVAL.into());
> +                }
> +
> +                // Copy data between two objects.
> +                if end_of_previous_object < offset {
> +                    view.copy_into(
> +                        &mut buffer_reader,
> +                        end_of_previous_object,
> +                        offset - end_of_previous_object,
> +                    )?;
> +                }
> +
> +                let mut object = BinderObject::read_from(&mut buffer_reader)?;
> +
> +                match self.translate_object(
> +                    index,
> +                    offset,
> +                    object.as_ref(),
> +                    &mut view,
> +                    allow_fds,
> +                    sg_state,
> +                ) {
> +                    Ok(()) => end_of_previous_object = offset + object.size(),
> +                    Err(err) => {
> +                        pr_warn!("Error while translating object.");
> +                        return Err(err);
> +                    }
> +                }
> +
> +                // Update the indexes containing objects to clean up.
> +                let offset_after_object = index_offset + size_of::<usize>();
> +                view.alloc
> +                    .set_info_offsets(offsets_start..offset_after_object);
> +            }
> +        }
> +
> +        // Copy remaining raw data.
> +        alloc.copy_into(
> +            &mut buffer_reader,
> +            end_of_previous_object,
> +            data_size - end_of_previous_object,
> +        )?;
> +
> +        if let Some(sg_state) = sg_state.as_mut() {
> +            if let Err(err) = self.apply_sg(&mut alloc, sg_state) {
> +                pr_warn!("Failure in apply_sg: {:?}", err);
> +                return Err(err);
> +            }
> +        }
> +
> +        if let Some((off_out, secctx)) = secctx.as_mut() {
> +            if let Err(err) = alloc.write(secctx_off, secctx.as_bytes()) {
> +                pr_warn!("Failed to write security context: {:?}", err);
> +                return Err(err.into());
> +            }
> +            **off_out = secctx_off;
> +        }
> +        Ok(alloc)
> +    }
> +
> +    fn unwind_transaction_stack(self: &Arc<Self>) {
> +        let mut thread = self.clone();
> +        while let Ok(transaction) = {
> +            let mut inner = thread.inner.lock();
> +            inner.pop_transaction_to_reply(thread.as_ref())
> +        } {
> +            let reply = Err(BR_DEAD_REPLY);
> +            if !transaction.from.deliver_single_reply(reply, &transaction) {
> +                break;
> +            }
> +
> +            thread = transaction.from.clone();
> +        }
> +    }
> +
> +    pub(crate) fn deliver_reply(
> +        &self,
> +        reply: Result<DLArc<Transaction>, u32>,
> +        transaction: &DArc<Transaction>,
> +    ) {
> +        if self.deliver_single_reply(reply, transaction) {
> +            transaction.from.unwind_transaction_stack();
> +        }
> +    }
> +
> +    /// Delivers a reply to the thread that started a transaction. The reply can either be a
> +    /// reply-transaction or an error code to be delivered instead.
> +    ///
> +    /// Returns whether the thread is dead. If it is, the caller is expected to unwind the
> +    /// transaction stack by completing transactions for threads that are dead.
> +    fn deliver_single_reply(
> +        &self,
> +        reply: Result<DLArc<Transaction>, u32>,
> +        transaction: &DArc<Transaction>,
> +    ) -> bool {
> +        if let Ok(transaction) = &reply {
> +            transaction.set_outstanding(&mut self.process.inner.lock());
> +        }
> +
> +        {
> +            let mut inner = self.inner.lock();
> +            if !inner.pop_transaction_replied(transaction) {
> +                return false;
> +            }
> +
> +            if inner.is_dead {
> +                return true;
> +            }
> +
> +            match reply {
> +                Ok(work) => {
> +                    inner.push_work(work);
> +                }
> +                Err(code) => inner.push_reply_work(code),
> +            }
> +        }
> +
> +        // Notify the thread now that we've released the inner lock.
> +        self.work_condvar.notify_sync();
> +        false
> +    }
> +
> +    /// Determines if the given transaction is the current transaction for this thread.
> +    fn is_current_transaction(&self, transaction: &DArc<Transaction>) -> bool {
> +        let inner = self.inner.lock();
> +        match &inner.current_transaction {
> +            None => false,
> +            Some(current) => Arc::ptr_eq(current, transaction),
> +        }
> +    }
> +
> +    /// Determines the current top of the transaction stack. It fails if the top is in another
> +    /// thread (i.e., this thread belongs to a stack but it has called another thread). The top is
> +    /// [`None`] if the thread is not currently participating in a transaction stack.
> +    fn top_of_transaction_stack(&self) -> Result<Option<DArc<Transaction>>> {
> +        let inner = self.inner.lock();
> +        if let Some(cur) = &inner.current_transaction {
> +            if core::ptr::eq(self, cur.from.as_ref()) {
> +                pr_warn!("got new transaction with bad transaction stack");
> +                return Err(EINVAL);
> +            }
> +            Ok(Some(cur.clone()))
> +        } else {
> +            Ok(None)
> +        }
> +    }
> +
> +    fn transaction<T>(self: &Arc<Self>, tr: &BinderTransactionDataSg, inner: T)
> +    where
> +        T: FnOnce(&Arc<Self>, &BinderTransactionDataSg) -> BinderResult,
> +    {
> +        if let Err(err) = inner(self, tr) {
> +            if err.should_pr_warn() {
> +                let mut ee = self.inner.lock().extended_error;
> +                ee.command = err.reply;
> +                ee.param = err.as_errno();
> +                pr_warn!(
> +                    "Transaction failed: {:?} my_pid:{}",
> +                    err,
> +                    self.process.pid_in_current_ns()
> +                );
> +            }
> +
> +            self.push_return_work(err.reply);
> +        }
> +    }
> +
> +    fn transaction_inner(self: &Arc<Self>, tr: &BinderTransactionDataSg) -> BinderResult {
> +        // SAFETY: Handle's type has no invalid bit patterns.
> +        let handle = unsafe { tr.transaction_data.target.handle };
> +        let node_ref = self.process.get_transaction_node(handle)?;
> +        security::binder_transaction(&self.process.cred, &node_ref.node.owner.cred)?;
> +        // TODO: We need to ensure that there isn't a pending transaction in the work queue. How
> +        // could this happen?
> +        let top = self.top_of_transaction_stack()?;
> +        let list_completion = DTRWrap::arc_try_new(DeliverCode::new(BR_TRANSACTION_COMPLETE))?;
> +        let completion = list_completion.clone_arc();
> +        let transaction = Transaction::new(node_ref, top, self, tr)?;
> +
> +        // Check that the transaction stack hasn't changed while the lock was released, then update
> +        // it with the new transaction.
> +        {
> +            let mut inner = self.inner.lock();
> +            if !transaction.is_stacked_on(&inner.current_transaction) {
> +                pr_warn!("Transaction stack changed during transaction!");
> +                return Err(EINVAL.into());
> +            }
> +            inner.current_transaction = Some(transaction.clone_arc());
> +            // We push the completion as a deferred work so that we wait for the reply before
> +            // returning to userland.
> +            inner.push_work_deferred(list_completion);
> +        }
> +
> +        if let Err(e) = transaction.submit() {
> +            completion.skip();
> +            // Define `transaction` first to drop it after `inner`.
> +            let transaction;
> +            let mut inner = self.inner.lock();
> +            transaction = inner.current_transaction.take().unwrap();
> +            inner.current_transaction = transaction.clone_next();
> +            Err(e)
> +        } else {
> +            Ok(())
> +        }
> +    }
> +
> +    fn reply_inner(self: &Arc<Self>, tr: &BinderTransactionDataSg) -> BinderResult {
> +        let orig = self.inner.lock().pop_transaction_to_reply(self)?;
> +        if !orig.from.is_current_transaction(&orig) {
> +            return Err(EINVAL.into());
> +        }
> +
> +        // We need to complete the transaction even if we cannot complete building the reply.
> +        let out = (|| -> BinderResult<_> {
> +            let completion = DTRWrap::arc_try_new(DeliverCode::new(BR_TRANSACTION_COMPLETE))?;
> +            let process = orig.from.process.clone();
> +            let allow_fds = orig.flags & TF_ACCEPT_FDS != 0;
> +            let reply = Transaction::new_reply(self, process, tr, allow_fds)?;
> +            self.inner.lock().push_work(completion);
> +            orig.from.deliver_reply(Ok(reply), &orig);
> +            Ok(())
> +        })()
> +        .map_err(|mut err| {
> +            // At this point we only return `BR_TRANSACTION_COMPLETE` to the caller, and we must let
> +            // the sender know that the transaction has completed (with an error in this case).
> +            pr_warn!(
> +                "Failure {:?} during reply - delivering BR_FAILED_REPLY to sender.",
> +                err
> +            );
> +            let reply = Err(BR_FAILED_REPLY);
> +            orig.from.deliver_reply(reply, &orig);
> +            err.reply = BR_TRANSACTION_COMPLETE;
> +            err
> +        });
> +
> +        out
> +    }
> +
> +    fn oneway_transaction_inner(self: &Arc<Self>, tr: &BinderTransactionDataSg) -> BinderResult {
> +        // SAFETY: The `handle` field is valid for all possible byte values, so reading from the
> +        // union is okay.
> +        let handle = unsafe { tr.transaction_data.target.handle };
> +        let node_ref = self.process.get_transaction_node(handle)?;
> +        security::binder_transaction(&self.process.cred, &node_ref.node.owner.cred)?;
> +        let transaction = Transaction::new(node_ref, None, self, tr)?;
> +        let code = if self.process.is_oneway_spam_detection_enabled()
> +            && transaction.oneway_spam_detected
> +        {
> +            BR_ONEWAY_SPAM_SUSPECT
> +        } else {
> +            BR_TRANSACTION_COMPLETE
> +        };
> +        let list_completion = DTRWrap::arc_try_new(DeliverCode::new(code))?;
> +        let completion = list_completion.clone_arc();
> +        self.inner.lock().push_work(list_completion);
> +        match transaction.submit() {
> +            Ok(()) => Ok(()),
> +            Err(err) => {
> +                completion.skip();
> +                Err(err)
> +            }
> +        }
> +    }
> +
> +    fn write(self: &Arc<Self>, req: &mut BinderWriteRead) -> Result {
> +        let write_start = req.write_buffer.wrapping_add(req.write_consumed);
> +        let write_len = req.write_size.saturating_sub(req.write_consumed);
> +        let mut reader =
> +            UserSlice::new(UserPtr::from_addr(write_start as _), write_len as _).reader();
> +
> +        while reader.len() >= size_of::<u32>() && self.inner.lock().return_work.is_unused() {
> +            let before = reader.len();
> +            let cmd = reader.read::<u32>()?;
> +            GLOBAL_STATS.inc_bc(cmd);
> +            self.process.stats.inc_bc(cmd);
> +            match cmd {
> +                BC_TRANSACTION => {
> +                    let tr = reader.read::<BinderTransactionData>()?.with_buffers_size(0);
> +                    if tr.transaction_data.flags & TF_ONE_WAY != 0 {
> +                        self.transaction(&tr, Self::oneway_transaction_inner);
> +                    } else {
> +                        self.transaction(&tr, Self::transaction_inner);
> +                    }
> +                }
> +                BC_TRANSACTION_SG => {
> +                    let tr = reader.read::<BinderTransactionDataSg>()?;
> +                    if tr.transaction_data.flags & TF_ONE_WAY != 0 {
> +                        self.transaction(&tr, Self::oneway_transaction_inner);
> +                    } else {
> +                        self.transaction(&tr, Self::transaction_inner);
> +                    }
> +                }
> +                BC_REPLY => {
> +                    let tr = reader.read::<BinderTransactionData>()?.with_buffers_size(0);
> +                    self.transaction(&tr, Self::reply_inner)
> +                }
> +                BC_REPLY_SG => {
> +                    let tr = reader.read::<BinderTransactionDataSg>()?;
> +                    self.transaction(&tr, Self::reply_inner)
> +                }
> +                BC_FREE_BUFFER => {
> +                    let buffer = self.process.buffer_get(reader.read()?);
> +                    if let Some(buffer) = &buffer {
> +                        if buffer.looper_need_return_on_free() {
> +                            self.inner.lock().looper_need_return = true;
> +                        }
> +                    }
> +                    drop(buffer);
> +                }
> +                BC_INCREFS => {
> +                    self.process
> +                        .as_arc_borrow()
> +                        .update_ref(reader.read()?, true, false)?
> +                }
> +                BC_ACQUIRE => {
> +                    self.process
> +                        .as_arc_borrow()
> +                        .update_ref(reader.read()?, true, true)?
> +                }
> +                BC_RELEASE => {
> +                    self.process
> +                        .as_arc_borrow()
> +                        .update_ref(reader.read()?, false, true)?
> +                }
> +                BC_DECREFS => {
> +                    self.process
> +                        .as_arc_borrow()
> +                        .update_ref(reader.read()?, false, false)?
> +                }
> +                BC_INCREFS_DONE => self.process.inc_ref_done(&mut reader, false)?,
> +                BC_ACQUIRE_DONE => self.process.inc_ref_done(&mut reader, true)?,
> +                BC_REQUEST_DEATH_NOTIFICATION => self.process.request_death(&mut reader, self)?,
> +                BC_CLEAR_DEATH_NOTIFICATION => self.process.clear_death(&mut reader, self)?,
> +                BC_DEAD_BINDER_DONE => self.process.dead_binder_done(reader.read()?, self),
> +                BC_REGISTER_LOOPER => {
> +                    let valid = self.process.register_thread();
> +                    self.inner.lock().looper_register(valid);
> +                }
> +                BC_ENTER_LOOPER => self.inner.lock().looper_enter(),
> +                BC_EXIT_LOOPER => self.inner.lock().looper_exit(),
> +                BC_REQUEST_FREEZE_NOTIFICATION => self.process.request_freeze_notif(&mut reader)?,
> +                BC_CLEAR_FREEZE_NOTIFICATION => self.process.clear_freeze_notif(&mut reader)?,
> +                BC_FREEZE_NOTIFICATION_DONE => self.process.freeze_notif_done(&mut reader)?,
> +
> +                // Fail if given an unknown error code.
> +                // BC_ATTEMPT_ACQUIRE and BC_ACQUIRE_RESULT are no longer supported.
> +                _ => return Err(EINVAL),
> +            }
> +            // Update the number of write bytes consumed.
> +            req.write_consumed += (before - reader.len()) as u64;
> +        }
> +
> +        Ok(())
> +    }
> +
> +    fn read(self: &Arc<Self>, req: &mut BinderWriteRead, wait: bool) -> Result {
> +        let read_start = req.read_buffer.wrapping_add(req.read_consumed);
> +        let read_len = req.read_size.saturating_sub(req.read_consumed);
> +        let mut writer = BinderReturnWriter::new(
> +            UserSlice::new(UserPtr::from_addr(read_start as _), read_len as _).writer(),
> +            self,
> +        );
> +        let (in_pool, use_proc_queue) = {
> +            let inner = self.inner.lock();
> +            (inner.is_looper(), inner.should_use_process_work_queue())
> +        };
> +
> +        let getter = if use_proc_queue {
> +            Self::get_work
> +        } else {
> +            Self::get_work_local
> +        };
> +
> +        // Reserve some room at the beginning of the read buffer so that we can send a
> +        // BR_SPAWN_LOOPER if we need to.
> +        let mut has_noop_placeholder = false;
> +        if req.read_consumed == 0 {
> +            if let Err(err) = writer.write_code(BR_NOOP) {
> +                pr_warn!("Failure when writing BR_NOOP at beginning of buffer.");
> +                return Err(err);
> +            }
> +            has_noop_placeholder = true;
> +        }
> +
> +        // Loop doing work while there is room in the buffer.
> +        let initial_len = writer.len();
> +        while writer.len() >= size_of::<uapi::binder_transaction_data_secctx>() + 4 {
> +            match getter(self, wait && initial_len == writer.len()) {
> +                Ok(Some(work)) => match work.into_arc().do_work(self, &mut writer) {
> +                    Ok(true) => {}
> +                    Ok(false) => break,
> +                    Err(err) => {
> +                        return Err(err);
> +                    }
> +                },
> +                Ok(None) => {
> +                    break;
> +                }
> +                Err(err) => {
> +                    // Propagate the error if we haven't written anything else.
> +                    if err != EINTR && err != EAGAIN {
> +                        pr_warn!("Failure in work getter: {:?}", err);
> +                    }
> +                    if initial_len == writer.len() {
> +                        return Err(err);
> +                    } else {
> +                        break;
> +                    }
> +                }
> +            }
> +        }
> +
> +        req.read_consumed += read_len - writer.len() as u64;
> +
> +        // Write BR_SPAWN_LOOPER if the process needs more threads for its pool.
> +        if has_noop_placeholder && in_pool && self.process.needs_thread() {
> +            let mut writer =
> +                UserSlice::new(UserPtr::from_addr(req.read_buffer as _), req.read_size as _)
> +                    .writer();
> +            writer.write(&BR_SPAWN_LOOPER)?;
> +        }
> +        Ok(())
> +    }
> +
> +    pub(crate) fn write_read(self: &Arc<Self>, data: UserSlice, wait: bool) -> Result {
> +        let (mut reader, mut writer) = data.reader_writer();
> +        let mut req = reader.read::<BinderWriteRead>()?;
> +
> +        // Go through the write buffer.
> +        let mut ret = Ok(());
> +        if req.write_size > 0 {
> +            ret = self.write(&mut req);
> +            if let Err(err) = ret {
> +                pr_warn!(
> +                    "Write failure {:?} in pid:{}",
> +                    err,
> +                    self.process.pid_in_current_ns()
> +                );
> +                req.read_consumed = 0;
> +                writer.write(&req)?;
> +                self.inner.lock().looper_need_return = false;
> +                return ret;
> +            }
> +        }
> +
> +        // Go through the work queue.
> +        if req.read_size > 0 {
> +            ret = self.read(&mut req, wait);
> +            if ret.is_err() && ret != Err(EINTR) {
> +                pr_warn!(
> +                    "Read failure {:?} in pid:{}",
> +                    ret,
> +                    self.process.pid_in_current_ns()
> +                );
> +            }
> +        }
> +
> +        // Write the request back so that the consumed fields are visible to the caller.
> +        writer.write(&req)?;
> +
> +        self.inner.lock().looper_need_return = false;
> +
> +        ret
> +    }
> +
> +    pub(crate) fn poll(&self, file: &File, table: PollTable<'_>) -> (bool, u32) {
> +        table.register_wait(file, &self.work_condvar);
> +        let mut inner = self.inner.lock();
> +        (inner.should_use_process_work_queue(), inner.poll())
> +    }
> +
> +    /// Make the call to `get_work` or `get_work_local` return immediately, if any.
> +    pub(crate) fn exit_looper(&self) {
> +        let mut inner = self.inner.lock();
> +        let should_notify = inner.looper_flags & LOOPER_WAITING != 0;
> +        if should_notify {
> +            inner.looper_need_return = true;
> +        }
> +        drop(inner);
> +
> +        if should_notify {
> +            self.work_condvar.notify_one();
> +        }
> +    }
> +
> +    pub(crate) fn notify_if_poll_ready(&self, sync: bool) {
> +        // Determine if we need to notify. This requires the lock.
> +        let inner = self.inner.lock();
> +        let notify = inner.looper_flags & LOOPER_POLL != 0 && inner.should_use_process_work_queue();
> +        drop(inner);
> +
> +        // Now that the lock is no longer held, notify the waiters if we have to.
> +        if notify {
> +            if sync {
> +                self.work_condvar.notify_sync();
> +            } else {
> +                self.work_condvar.notify_one();
> +            }
> +        }
> +    }
> +
> +    pub(crate) fn release(self: &Arc<Self>) {
> +        self.inner.lock().is_dead = true;
> +
> +        //self.work_condvar.clear();
> +        self.unwind_transaction_stack();
> +
> +        // Cancel all pending work items.
> +        while let Ok(Some(work)) = self.get_work_local(false) {
> +            work.into_arc().cancel();
> +        }
> +    }
> +}
> +
> +#[pin_data]
> +struct ThreadError {
> +    error_code: AtomicU32,
> +    #[pin]
> +    links_track: AtomicTracker,
> +}
> +
> +impl ThreadError {
> +    fn try_new() -> Result<DArc<Self>> {
> +        DTRWrap::arc_pin_init(pin_init!(Self {
> +            error_code: AtomicU32::new(BR_OK),
> +            links_track <- AtomicTracker::new(),
> +        }))
> +        .map(ListArc::into_arc)
> +    }
> +
> +    fn set_error_code(&self, code: u32) {
> +        self.error_code.store(code, Ordering::Relaxed);
> +    }
> +
> +    fn is_unused(&self) -> bool {
> +        self.error_code.load(Ordering::Relaxed) == BR_OK
> +    }
> +}
> +
> +impl DeliverToRead for ThreadError {
> +    fn do_work(
> +        self: DArc<Self>,
> +        _thread: &Thread,
> +        writer: &mut BinderReturnWriter<'_>,
> +    ) -> Result<bool> {
> +        let code = self.error_code.load(Ordering::Relaxed);
> +        self.error_code.store(BR_OK, Ordering::Relaxed);
> +        writer.write_code(code)?;
> +        Ok(true)
> +    }
> +
> +    fn cancel(self: DArc<Self>) {}
> +
> +    fn should_sync_wakeup(&self) -> bool {
> +        false
> +    }
> +
> +    fn debug_print(&self, m: &SeqFile, prefix: &str, _tprefix: &str) -> Result<()> {
> +        seq_print!(
> +            m,
> +            "{}transaction error: {}\n",
> +            prefix,
> +            self.error_code.load(Ordering::Relaxed)
> +        );
> +        Ok(())
> +    }
> +}
> +
> +kernel::list::impl_list_arc_safe! {
> +    impl ListArcSafe<0> for ThreadError {
> +        tracked_by links_track: AtomicTracker;
> +    }
> +}
> diff --git a/drivers/android/binder/trace.rs b/drivers/android/binder/trace.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..af0e4392805e7ef2a39b7c1e557ea233dcd810ab
> --- /dev/null
> +++ b/drivers/android/binder/trace.rs
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2025 Google LLC.
> +
> +use kernel::ffi::{c_uint, c_ulong};
> +use kernel::tracepoint::declare_trace;
> +
> +declare_trace! {
> +    unsafe fn rust_binder_ioctl(cmd: c_uint, arg: c_ulong);
> +}
> +
> +#[inline]
> +pub(crate) fn trace_ioctl(cmd: u32, arg: usize) {
> +    // SAFETY: Always safe to call.
> +    unsafe { rust_binder_ioctl(cmd, arg as c_ulong) }
> +}
> diff --git a/drivers/android/binder/transaction.rs b/drivers/android/binder/transaction.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..02512175d6229535373f2d3e543ba8c91ecd72f0
> --- /dev/null
> +++ b/drivers/android/binder/transaction.rs
> @@ -0,0 +1,456 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2025 Google LLC.
> +
> +use core::sync::atomic::{AtomicBool, Ordering};
> +use kernel::{
> +    prelude::*,
> +    seq_file::SeqFile,
> +    seq_print,
> +    sync::{Arc, SpinLock},
> +    task::Kuid,
> +    time::{Instant, Monotonic},
> +    types::ScopeGuard,
> +};
> +
> +use crate::{
> +    allocation::{Allocation, TranslatedFds},
> +    defs::*,
> +    error::{BinderError, BinderResult},
> +    node::{Node, NodeRef},
> +    process::{Process, ProcessInner},
> +    ptr_align,
> +    thread::{PushWorkRes, Thread},
> +    BinderReturnWriter, DArc, DLArc, DTRWrap, DeliverToRead,
> +};
> +
> +#[pin_data(PinnedDrop)]
> +pub(crate) struct Transaction {
> +    pub(crate) debug_id: usize,
> +    target_node: Option<DArc<Node>>,
> +    pub(crate) from_parent: Option<DArc<Transaction>>,
> +    pub(crate) from: Arc<Thread>,
> +    pub(crate) to: Arc<Process>,
> +    #[pin]
> +    allocation: SpinLock<Option<Allocation>>,
> +    is_outstanding: AtomicBool,
> +    code: u32,
> +    pub(crate) flags: u32,
> +    data_size: usize,
> +    offsets_size: usize,
> +    data_address: usize,
> +    sender_euid: Kuid,
> +    txn_security_ctx_off: Option<usize>,
> +    pub(crate) oneway_spam_detected: bool,
> +    start_time: Instant<Monotonic>,
> +}
> +
> +kernel::list::impl_list_arc_safe! {
> +    impl ListArcSafe<0> for Transaction { untracked; }
> +}
> +
> +impl Transaction {
> +    pub(crate) fn new(
> +        node_ref: NodeRef,
> +        from_parent: Option<DArc<Transaction>>,
> +        from: &Arc<Thread>,
> +        tr: &BinderTransactionDataSg,
> +    ) -> BinderResult<DLArc<Self>> {
> +        let debug_id = super::next_debug_id();
> +        let trd = &tr.transaction_data;
> +        let allow_fds = node_ref.node.flags & FLAT_BINDER_FLAG_ACCEPTS_FDS != 0;
> +        let txn_security_ctx = node_ref.node.flags & FLAT_BINDER_FLAG_TXN_SECURITY_CTX != 0;
> +        let mut txn_security_ctx_off = if txn_security_ctx { Some(0) } else { None };
> +        let to = node_ref.node.owner.clone();
> +        let mut alloc = match from.copy_transaction_data(
> +            to.clone(),
> +            tr,
> +            debug_id,
> +            allow_fds,
> +            txn_security_ctx_off.as_mut(),
> +        ) {
> +            Ok(alloc) => alloc,
> +            Err(err) => {
> +                if !err.is_dead() {
> +                    pr_warn!("Failure in copy_transaction_data: {:?}", err);
> +                }
> +                return Err(err);
> +            }
> +        };
> +        let oneway_spam_detected = alloc.oneway_spam_detected;
> +        if trd.flags & TF_ONE_WAY != 0 {
> +            if from_parent.is_some() {
> +                pr_warn!("Oneway transaction should not be in a transaction stack.");
> +                return Err(EINVAL.into());
> +            }
> +            alloc.set_info_oneway_node(node_ref.node.clone());
> +        }
> +        if trd.flags & TF_CLEAR_BUF != 0 {
> +            alloc.set_info_clear_on_drop();
> +        }
> +        let target_node = node_ref.node.clone();
> +        alloc.set_info_target_node(node_ref);
> +        let data_address = alloc.ptr;
> +
> +        Ok(DTRWrap::arc_pin_init(pin_init!(Transaction {
> +            debug_id,
> +            target_node: Some(target_node),
> +            from_parent,
> +            sender_euid: from.process.task.euid(),
> +            from: from.clone(),
> +            to,
> +            code: trd.code,
> +            flags: trd.flags,
> +            data_size: trd.data_size as _,
> +            offsets_size: trd.offsets_size as _,
> +            data_address,
> +            allocation <- kernel::new_spinlock!(Some(alloc.success()), "Transaction::new"),
> +            is_outstanding: AtomicBool::new(false),
> +            txn_security_ctx_off,
> +            oneway_spam_detected,
> +            start_time: Instant::now(),
> +        }))?)
> +    }
> +
> +    pub(crate) fn new_reply(
> +        from: &Arc<Thread>,
> +        to: Arc<Process>,
> +        tr: &BinderTransactionDataSg,
> +        allow_fds: bool,
> +    ) -> BinderResult<DLArc<Self>> {
> +        let debug_id = super::next_debug_id();
> +        let trd = &tr.transaction_data;
> +        let mut alloc = match from.copy_transaction_data(to.clone(), tr, debug_id, allow_fds, None)
> +        {
> +            Ok(alloc) => alloc,
> +            Err(err) => {
> +                pr_warn!("Failure in copy_transaction_data: {:?}", err);
> +                return Err(err);
> +            }
> +        };
> +        let oneway_spam_detected = alloc.oneway_spam_detected;
> +        if trd.flags & TF_CLEAR_BUF != 0 {
> +            alloc.set_info_clear_on_drop();
> +        }
> +        Ok(DTRWrap::arc_pin_init(pin_init!(Transaction {
> +            debug_id,
> +            target_node: None,
> +            from_parent: None,
> +            sender_euid: from.process.task.euid(),
> +            from: from.clone(),
> +            to,
> +            code: trd.code,
> +            flags: trd.flags,
> +            data_size: trd.data_size as _,
> +            offsets_size: trd.offsets_size as _,
> +            data_address: alloc.ptr,
> +            allocation <- kernel::new_spinlock!(Some(alloc.success()), "Transaction::new"),
> +            is_outstanding: AtomicBool::new(false),
> +            txn_security_ctx_off: None,
> +            oneway_spam_detected,
> +            start_time: Instant::now(),
> +        }))?)
> +    }
> +
> +    #[inline(never)]
> +    pub(crate) fn debug_print_inner(&self, m: &SeqFile, prefix: &str) {
> +        seq_print!(
> +            m,
> +            "{}{}: from {}:{} to {} code {:x} flags {:x} elapsed {}ms",
> +            prefix,
> +            self.debug_id,
> +            self.from.process.task.pid(),
> +            self.from.id,
> +            self.to.task.pid(),
> +            self.code,
> +            self.flags,
> +            self.start_time.elapsed().as_millis(),
> +        );
> +        if let Some(target_node) = &self.target_node {
> +            seq_print!(m, " node {}", target_node.debug_id);
> +        }
> +        seq_print!(m, " size {}:{}\n", self.data_size, self.offsets_size);
> +    }
> +
> +    /// Determines if the transaction is stacked on top of the given transaction.
> +    pub(crate) fn is_stacked_on(&self, onext: &Option<DArc<Self>>) -> bool {
> +        match (&self.from_parent, onext) {
> +            (None, None) => true,
> +            (Some(from_parent), Some(next)) => Arc::ptr_eq(from_parent, next),
> +            _ => false,
> +        }
> +    }
> +
> +    /// Returns a pointer to the next transaction on the transaction stack, if there is one.
> +    pub(crate) fn clone_next(&self) -> Option<DArc<Self>> {
> +        Some(self.from_parent.as_ref()?.clone())
> +    }
> +
> +    /// Searches in the transaction stack for a thread that belongs to the target process. This is
> +    /// useful when finding a target for a new transaction: if the node belongs to a process that
> +    /// is already part of the transaction stack, we reuse the thread.
> +    fn find_target_thread(&self) -> Option<Arc<Thread>> {
> +        let mut it = &self.from_parent;
> +        while let Some(transaction) = it {
> +            if Arc::ptr_eq(&transaction.from.process, &self.to) {
> +                return Some(transaction.from.clone());
> +            }
> +            it = &transaction.from_parent;
> +        }
> +        None
> +    }
> +
> +    /// Searches in the transaction stack for a transaction originating at the given thread.
> +    pub(crate) fn find_from(&self, thread: &Thread) -> Option<&DArc<Transaction>> {
> +        let mut it = &self.from_parent;
> +        while let Some(transaction) = it {
> +            if core::ptr::eq(thread, transaction.from.as_ref()) {
> +                return Some(transaction);
> +            }
> +
> +            it = &transaction.from_parent;
> +        }
> +        None
> +    }
> +
> +    pub(crate) fn set_outstanding(&self, to_process: &mut ProcessInner) {
> +        // No race because this method is only called once.
> +        if !self.is_outstanding.load(Ordering::Relaxed) {
> +            self.is_outstanding.store(true, Ordering::Relaxed);
> +            to_process.add_outstanding_txn();
> +        }
> +    }
> +
> +    /// Decrement `outstanding_txns` in `to` if it hasn't already been decremented.
> +    fn drop_outstanding_txn(&self) {
> +        // No race because this is called at most twice, and one of the calls are in the
> +        // destructor, which is guaranteed to not race with any other operations on the
> +        // transaction. It also cannot race with `set_outstanding`, since submission happens
> +        // before delivery.
> +        if self.is_outstanding.load(Ordering::Relaxed) {
> +            self.is_outstanding.store(false, Ordering::Relaxed);
> +            self.to.drop_outstanding_txn();
> +        }
> +    }
> +
> +    /// Submits the transaction to a work queue. Uses a thread if there is one in the transaction
> +    /// stack, otherwise uses the destination process.
> +    ///
> +    /// Not used for replies.
> +    pub(crate) fn submit(self: DLArc<Self>) -> BinderResult {
> +        // Defined before `process_inner` so that the destructor runs after releasing the lock.
> +        let mut _t_outdated;
> +
> +        let oneway = self.flags & TF_ONE_WAY != 0;
> +        let process = self.to.clone();
> +        let mut process_inner = process.inner.lock();
> +
> +        self.set_outstanding(&mut process_inner);
> +
> +        if oneway {
> +            if let Some(target_node) = self.target_node.clone() {
> +                if process_inner.is_frozen {
> +                    process_inner.async_recv = true;
> +                    if self.flags & TF_UPDATE_TXN != 0 {
> +                        if let Some(t_outdated) =
> +                            target_node.take_outdated_transaction(&self, &mut process_inner)
> +                        {
> +                            // Save the transaction to be dropped after locks are released.
> +                            _t_outdated = t_outdated;
> +                        }
> +                    }
> +                }
> +                match target_node.submit_oneway(self, &mut process_inner) {
> +                    Ok(()) => {}
> +                    Err((err, work)) => {
> +                        drop(process_inner);
> +                        // Drop work after releasing process lock.
> +                        drop(work);
> +                        return Err(err);
> +                    }
> +                }
> +
> +                if process_inner.is_frozen {
> +                    return Err(BinderError::new_frozen_oneway());
> +                } else {
> +                    return Ok(());
> +                }
> +            } else {
> +                pr_err!("Failed to submit oneway transaction to node.");
> +            }
> +        }
> +
> +        if process_inner.is_frozen {
> +            process_inner.sync_recv = true;
> +            return Err(BinderError::new_frozen());
> +        }
> +
> +        let res = if let Some(thread) = self.find_target_thread() {
> +            match thread.push_work(self) {
> +                PushWorkRes::Ok => Ok(()),
> +                PushWorkRes::FailedDead(me) => Err((BinderError::new_dead(), me)),
> +            }
> +        } else {
> +            process_inner.push_work(self)
> +        };
> +        drop(process_inner);
> +
> +        match res {
> +            Ok(()) => Ok(()),
> +            Err((err, work)) => {
> +                // Drop work after releasing process lock.
> +                drop(work);
> +                Err(err)
> +            }
> +        }
> +    }
> +
> +    /// Check whether one oneway transaction can supersede another.
> +    pub(crate) fn can_replace(&self, old: &Transaction) -> bool {
> +        if self.from.process.task.pid() != old.from.process.task.pid() {
> +            return false;
> +        }
> +
> +        if self.flags & old.flags & (TF_ONE_WAY | TF_UPDATE_TXN) != (TF_ONE_WAY | TF_UPDATE_TXN) {
> +            return false;
> +        }
> +
> +        let target_node_match = match (self.target_node.as_ref(), old.target_node.as_ref()) {
> +            (None, None) => true,
> +            (Some(tn1), Some(tn2)) => Arc::ptr_eq(tn1, tn2),
> +            _ => false,
> +        };
> +
> +        self.code == old.code && self.flags == old.flags && target_node_match
> +    }
> +
> +    fn prepare_file_list(&self) -> Result<TranslatedFds> {
> +        let mut alloc = self.allocation.lock().take().ok_or(ESRCH)?;
> +
> +        match alloc.translate_fds() {
> +            Ok(translated) => {
> +                *self.allocation.lock() = Some(alloc);
> +                Ok(translated)
> +            }
> +            Err(err) => {
> +                // Free the allocation eagerly.
> +                drop(alloc);
> +                Err(err)
> +            }
> +        }
> +    }
> +}
> +
> +impl DeliverToRead for Transaction {
> +    fn do_work(
> +        self: DArc<Self>,
> +        thread: &Thread,
> +        writer: &mut BinderReturnWriter<'_>,
> +    ) -> Result<bool> {
> +        let send_failed_reply = ScopeGuard::new(|| {
> +            if self.target_node.is_some() && self.flags & TF_ONE_WAY == 0 {
> +                let reply = Err(BR_FAILED_REPLY);
> +                self.from.deliver_reply(reply, &self);
> +            }
> +            self.drop_outstanding_txn();
> +        });
> +
> +        let files = if let Ok(list) = self.prepare_file_list() {
> +            list
> +        } else {
> +            // On failure to process the list, we send a reply back to the sender and ignore the
> +            // transaction on the recipient.
> +            return Ok(true);
> +        };
> +
> +        let mut tr_sec = BinderTransactionDataSecctx::default();
> +        let tr = tr_sec.tr_data();
> +        if let Some(target_node) = &self.target_node {
> +            let (ptr, cookie) = target_node.get_id();
> +            tr.target.ptr = ptr as _;
> +            tr.cookie = cookie as _;
> +        };
> +        tr.code = self.code;
> +        tr.flags = self.flags;
> +        tr.data_size = self.data_size as _;
> +        tr.data.ptr.buffer = self.data_address as _;
> +        tr.offsets_size = self.offsets_size as _;
> +        if tr.offsets_size > 0 {
> +            tr.data.ptr.offsets = (self.data_address + ptr_align(self.data_size).unwrap()) as _;
> +        }
> +        tr.sender_euid = self.sender_euid.into_uid_in_current_ns();
> +        tr.sender_pid = 0;
> +        if self.target_node.is_some() && self.flags & TF_ONE_WAY == 0 {
> +            // Not a reply and not one-way.
> +            tr.sender_pid = self.from.process.pid_in_current_ns();
> +        }
> +        let code = if self.target_node.is_none() {
> +            BR_REPLY
> +        } else if self.txn_security_ctx_off.is_some() {
> +            BR_TRANSACTION_SEC_CTX
> +        } else {
> +            BR_TRANSACTION
> +        };
> +
> +        // Write the transaction code and data to the user buffer.
> +        writer.write_code(code)?;
> +        if let Some(off) = self.txn_security_ctx_off {
> +            tr_sec.secctx = (self.data_address + off) as u64;
> +            writer.write_payload(&tr_sec)?;
> +        } else {
> +            writer.write_payload(&*tr)?;
> +        }
> +
> +        let mut alloc = self.allocation.lock().take().ok_or(ESRCH)?;
> +
> +        // Dismiss the completion of transaction with a failure. No failure paths are allowed from
> +        // here on out.
> +        send_failed_reply.dismiss();
> +
> +        // Commit files, and set FDs in FDA to be closed on buffer free.
> +        let close_on_free = files.commit();
> +        alloc.set_info_close_on_free(close_on_free);
> +
> +        // It is now the user's responsibility to clear the allocation.
> +        alloc.keep_alive();
> +
> +        self.drop_outstanding_txn();
> +
> +        // When this is not a reply and not a oneway transaction, update `current_transaction`. If
> +        // it's a reply, `current_transaction` has already been updated appropriately.
> +        if self.target_node.is_some() && tr_sec.transaction_data.flags & TF_ONE_WAY == 0 {
> +            thread.set_current_transaction(self);
> +        }
> +
> +        Ok(false)
> +    }
> +
> +    fn cancel(self: DArc<Self>) {
> +        let allocation = self.allocation.lock().take();
> +        drop(allocation);
> +
> +        // If this is not a reply or oneway transaction, then send a dead reply.
> +        if self.target_node.is_some() && self.flags & TF_ONE_WAY == 0 {
> +            let reply = Err(BR_DEAD_REPLY);
> +            self.from.deliver_reply(reply, &self);
> +        }
> +
> +        self.drop_outstanding_txn();
> +    }
> +
> +    fn should_sync_wakeup(&self) -> bool {
> +        self.flags & TF_ONE_WAY == 0
> +    }
> +
> +    fn debug_print(&self, m: &SeqFile, _prefix: &str, tprefix: &str) -> Result<()> {
> +        self.debug_print_inner(m, tprefix);
> +        Ok(())
> +    }
> +}
> +
> +#[pinned_drop]
> +impl PinnedDrop for Transaction {
> +    fn drop(self: Pin<&mut Self>) {
> +        self.drop_outstanding_txn();
> +    }
> +}
> diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/android/binder.h
> index 1fd92021a573aab833291f92e167152e36f9b69c..03ee4c7010d70bac5ac06b569073c25b9971767e 100644
> --- a/include/uapi/linux/android/binder.h
> +++ b/include/uapi/linux/android/binder.h
> @@ -38,7 +38,7 @@ enum {
>  	BINDER_TYPE_PTR		= B_PACK_CHARS('p', 't', '*', B_TYPE_LARGE),
>  };
>  
> -enum {
> +enum flat_binder_object_flags {
>  	FLAT_BINDER_FLAG_PRIORITY_MASK = 0xff,
>  	FLAT_BINDER_FLAG_ACCEPTS_FDS = 0x100,
>  
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 84d60635e8a9baef1f1a1b2752dc0fa044f8542f..9b3a4ab95818c937d5f520c88e56697d6efdf1d1 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -50,6 +50,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/errname.h>
>  #include <linux/ethtool.h>
> +#include <linux/fdtable.h>
>  #include <linux/file.h>
>  #include <linux/firmware.h>
>  #include <linux/fs.h>
> @@ -71,6 +72,7 @@
>  #include <linux/sched.h>
>  #include <linux/security.h>
>  #include <linux/slab.h>
> +#include <linux/task_work.h>
>  #include <linux/tracepoint.h>
>  #include <linux/wait.h>
>  #include <linux/workqueue.h>
> @@ -99,3 +101,9 @@ const xa_mark_t RUST_CONST_HELPER_XA_PRESENT = XA_PRESENT;
>  
>  const gfp_t RUST_CONST_HELPER_XA_FLAGS_ALLOC = XA_FLAGS_ALLOC;
>  const gfp_t RUST_CONST_HELPER_XA_FLAGS_ALLOC1 = XA_FLAGS_ALLOC1;
> +
> +#if IS_ENABLED(CONFIG_ANDROID_BINDER_IPC_RUST)
> +#include "../../drivers/android/binder/rust_binder.h"
> +#include "../../drivers/android/binder/rust_binder_events.h"
> +#include "../../drivers/android/binder/page_range_helper.h"
> +#endif
> diff --git a/rust/helpers/binder.c b/rust/helpers/binder.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..224d38a92f1d985d78767d5a72f5ff60765b8508
> --- /dev/null
> +++ b/rust/helpers/binder.c
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (C) 2025 Google LLC.
> + */
> +
> +#include <linux/list_lru.h>
> +#include <linux/task_work.h>
> +
> +unsigned long rust_helper_list_lru_count(struct list_lru *lru)
> +{
> +	return list_lru_count(lru);
> +}
> +
> +unsigned long rust_helper_list_lru_walk(struct list_lru *lru,
> +					list_lru_walk_cb isolate, void *cb_arg,
> +					unsigned long nr_to_walk)
> +{
> +	return list_lru_walk(lru, isolate, cb_arg, nr_to_walk);
> +}
> +
> +void rust_helper_init_task_work(struct callback_head *twork,
> +				task_work_func_t func)
> +{
> +	init_task_work(twork, func);
> +}
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 7cf7fe95e41dd51717050648d6160bebebdf4b26..8e8277bdddcaeec1edebe18ffc4fe831c08a8455 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include "auxiliary.c"
> +#include "binder.c"
>  #include "blk.c"
>  #include "bug.c"
>  #include "build_assert.c"
> diff --git a/rust/helpers/page.c b/rust/helpers/page.c
> index b3f2b8fbf87fc9aa89cb1636736c52be16411301..7144de5a61dbdb3006a668961cd1b09440e74908 100644
> --- a/rust/helpers/page.c
> +++ b/rust/helpers/page.c
> @@ -2,6 +2,7 @@
>  
>  #include <linux/gfp.h>
>  #include <linux/highmem.h>
> +#include <linux/mm.h>
>  
>  struct page *rust_helper_alloc_pages(gfp_t gfp_mask, unsigned int order)
>  {
> @@ -17,3 +18,10 @@ void rust_helper_kunmap_local(const void *addr)
>  {
>  	kunmap_local(addr);
>  }
> +
> +#ifndef NODE_NOT_IN_PAGE_FLAGS
> +int rust_helper_page_to_nid(const struct page *page)
> +{
> +	return page_to_nid(page);
> +}
> +#endif
> diff --git a/rust/helpers/security.c b/rust/helpers/security.c
> index 0c4c2065df28e7c6dc8982c6df44d47c57bf29e6..ca22da09548dfed95a83168ed09263e75cf08fd2 100644
> --- a/rust/helpers/security.c
> +++ b/rust/helpers/security.c
> @@ -17,4 +17,28 @@ void rust_helper_security_release_secctx(struct lsm_context *cp)
>  {
>  	security_release_secctx(cp);
>  }
> +
> +int rust_helper_security_binder_set_context_mgr(const struct cred *mgr)
> +{
> +	return security_binder_set_context_mgr(mgr);
> +}
> +
> +int rust_helper_security_binder_transaction(const struct cred *from,
> +					    const struct cred *to)
> +{
> +	return security_binder_transaction(from, to);
> +}
> +
> +int rust_helper_security_binder_transfer_binder(const struct cred *from,
> +						const struct cred *to)
> +{
> +	return security_binder_transfer_binder(from, to);
> +}
> +
> +int rust_helper_security_binder_transfer_file(const struct cred *from,
> +					      const struct cred *to,
> +					      const struct file *file)
> +{
> +	return security_binder_transfer_file(from, to, file);
> +}
>  #endif
> diff --git a/rust/kernel/cred.rs b/rust/kernel/cred.rs
> index 2599f01e8b285f2106aefd27c315ae2aff25293c..3aa2e4c4a50c99864106d93d573498b0202f024e 100644
> --- a/rust/kernel/cred.rs
> +++ b/rust/kernel/cred.rs
> @@ -54,6 +54,12 @@ pub unsafe fn from_ptr<'a>(ptr: *const bindings::cred) -> &'a Credential {
>          unsafe { &*ptr.cast() }
>      }
>  
> +    /// Returns a raw pointer to the inner credential.
> +    #[inline]
> +    pub fn as_ptr(&self) -> *const bindings::cred {
> +        self.0.get()
> +    }
> +
>      /// Get the id for this security context.
>      #[inline]
>      pub fn get_secid(&self) -> u32 {
> diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
> index 7c1b17246ed5e88cb122c6aa594d1d4b86b8349b..811fe30e8e6ff1bd432e79290256ee0b950320e2 100644
> --- a/rust/kernel/page.rs
> +++ b/rust/kernel/page.rs
> @@ -85,6 +85,12 @@ pub fn as_ptr(&self) -> *mut bindings::page {
>          self.page.as_ptr()
>      }
>  
> +    /// Get the node id containing this page.
> +    pub fn nid(&self) -> i32 {
> +        // SAFETY: Always safe to call with a valid page.
> +        unsafe { bindings::page_to_nid(self.as_ptr()) }
> +    }
> +
>      /// Runs a piece of code with this page mapped to an address.
>      ///
>      /// The page is unmapped when this call returns.
> diff --git a/rust/kernel/security.rs b/rust/kernel/security.rs
> index 0c63e9e7e564b7d9d85865e5415dd0464e9a9098..9d271695265fb4635038e9e36c975cebb38d6782 100644
> --- a/rust/kernel/security.rs
> +++ b/rust/kernel/security.rs
> @@ -8,9 +8,46 @@
>  
>  use crate::{
>      bindings,
> +    cred::Credential,
>      error::{to_result, Result},
> +    fs::File,
>  };
>  
> +/// Calls the security modules to determine if the given task can become the manager of a binder
> +/// context.
> +#[inline]
> +pub fn binder_set_context_mgr(mgr: &Credential) -> Result {
> +    // SAFETY: `mrg.0` is valid because the shared reference guarantees a nonzero refcount.
> +    to_result(unsafe { bindings::security_binder_set_context_mgr(mgr.as_ptr()) })
> +}
> +
> +/// Calls the security modules to determine if binder transactions are allowed from task `from` to
> +/// task `to`.
> +#[inline]
> +pub fn binder_transaction(from: &Credential, to: &Credential) -> Result {
> +    // SAFETY: `from` and `to` are valid because the shared references guarantee nonzero refcounts.
> +    to_result(unsafe { bindings::security_binder_transaction(from.as_ptr(), to.as_ptr()) })
> +}
> +
> +/// Calls the security modules to determine if task `from` is allowed to send binder objects
> +/// (owned by itself or other processes) to task `to` through a binder transaction.
> +#[inline]
> +pub fn binder_transfer_binder(from: &Credential, to: &Credential) -> Result {
> +    // SAFETY: `from` and `to` are valid because the shared references guarantee nonzero refcounts.
> +    to_result(unsafe { bindings::security_binder_transfer_binder(from.as_ptr(), to.as_ptr()) })
> +}
> +
> +/// Calls the security modules to determine if task `from` is allowed to send the given file to
> +/// task `to` (which would get its own file descriptor) through a binder transaction.
> +#[inline]
> +pub fn binder_transfer_file(from: &Credential, to: &Credential, file: &File) -> Result {
> +    // SAFETY: `from`, `to` and `file` are valid because the shared references guarantee nonzero
> +    // refcounts.
> +    to_result(unsafe {
> +        bindings::security_binder_transfer_file(from.as_ptr(), to.as_ptr(), file.as_ptr())
> +    })
> +}
> +
>  /// A security context string.
>  ///
>  /// # Invariants
> diff --git a/rust/uapi/uapi_helper.h b/rust/uapi/uapi_helper.h
> index 1409441359f510236256bc17851f9aac65c45c4e..de3562b08d0c3e379a4bfd180c3a4260c48c71b2 100644
> --- a/rust/uapi/uapi_helper.h
> +++ b/rust/uapi/uapi_helper.h
> @@ -9,6 +9,7 @@
>  #include <uapi/asm-generic/ioctl.h>
>  #include <uapi/drm/drm.h>
>  #include <uapi/drm/nova_drm.h>
> +#include <uapi/linux/android/binder.h>
>  #include <uapi/linux/mdio.h>
>  #include <uapi/linux/mii.h>
>  #include <uapi/linux/ethtool.h>
> 
> ---
> base-commit: 9441d6b876529d519547a1ed3af5a08b05bd0339
> change-id: 20250918-rust-binder-d80251ab47cb
> 
> Best regards,
> -- 
> Alice Ryhl <aliceryhl@google.com>
> 

