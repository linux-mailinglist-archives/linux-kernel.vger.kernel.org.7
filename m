Return-Path: <linux-kernel+bounces-725732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6452CB00305
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61CE01C429E8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2370A2E543D;
	Thu, 10 Jul 2025 13:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uRH+8VwZ"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C602D97A6
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752153143; cv=none; b=nhuFiBndaEQIvEOnPYjjnPg0q9rQ2CBNTe7zcL0U3lZ39wabj/niN9JQRYXue4zTV2GoJbzIJmsJ2T8za3Gy+fcasAqq16bQT1SG256A/J5cp3Ta2K0vc7KdKZLOmMinWnOd2531PFack5pXwgS4I2VCmugHFJ1tGGvYgPBNDoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752153143; c=relaxed/simple;
	bh=v5jQ3s/R87Vhp/eDVWaCk7wmbifWJ7wiNyzKE7pAD0Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YKmcbXrwFf3EDHdosEKOA3E45DWTgSixCLJFOijcimkF45NOuyNd+RUM+QUeIzFXNVv2Bwd+jLfj1LARwAuSRHNXIMY/DCPEljzRxhVpDkhCX2Vb3B8rvoQxE2gsY8dOPLhChPVE68TYMB1MTFlUR1TNsYjK/Y1ok3ZTuR1M4pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uRH+8VwZ; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-606aea61721so841602a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 06:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752153138; x=1752757938; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ap1R9e/cDQ1sEqkKOWD4Vp82gWlwuZouO7xiUWeKWnA=;
        b=uRH+8VwZICmekMwyQ4BX4a93ftHBwjajKSVFtYiX9lMZ40FhIB0qJUJT2tC2U8Jehm
         /9WRPLElJbFf0kH66SsBx36j/zcVvJdAWsI4a5lPAPgRfBaiTB6pcpO6W5qBlsSMz09D
         BmvuBRt7P2cQ1dzPNOhneNwnnX51X4jueVb14DqeukDuXUe1N0LcBeebmHj6d7NGZbkB
         1x5+MSE++XkHA339xGl6q6bkBN8+g+qPMyYAi/Vg+CBnMnwCgi8W4tX7cH4DHjpEQF9o
         pmDkNZm6u/zPyxMNF3faSHPcAy8TXccKWrOlI84vqw8GsQkj9ffLeR0GTSclsvTODxC+
         OQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752153138; x=1752757938;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ap1R9e/cDQ1sEqkKOWD4Vp82gWlwuZouO7xiUWeKWnA=;
        b=WdTso1ILlK4zuHqj5VVjBkPqJuFXYPNOlu/+VORLu75CQtSRPNFIIDspFFQJi/VS9u
         bKcb6nA0MwAf2XGeAxHmSfyOc44py9CnQWpU3Dpy47mHiHfANcO+8gcLsoUrtzd/7rXk
         tY1SbjuSjuTHjaPmQn9419v1++8w4KhgcYD+RZCHJJpUYDgSdQLNzsppYBx4PyBVCtAD
         vmA3+BYTGync+HqTiDjB1ZlkDPemy20/XniIO4WiqCVgLuPrfX78L3cCK66Js/ZsPKdJ
         MEh/fetqhHaZZ6ZW8hTIYt7y3IxeatFwMJ42DmRbh60KuLPi352no4zaWLf6i7iDHnJG
         GA4A==
X-Forwarded-Encrypted: i=1; AJvYcCVKrPwTKS0a2BceXCMjarbDxFbZAbANsRMhl3ys2io5djvi5qOdpvICa1GByF9DmnOSSYq5Kk3+3EcnM04=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAmDYHHweukSEUXNueMkA1Sp6/GaWwRR2S6oc96yNzw1TI7dJD
	1k6fQRf2lrbeuckRQtpFmGkx2Gr320FOSciCpp52SoqB4uOE2JI0Rw6fhysOaRhfmQxkmGm1lgB
	NXKtvwNCk/M3B9G5ShA==
X-Google-Smtp-Source: AGHT+IG0ILLj9d8WnJNXkj7H5NLxRVP6OhdcLw4cNDXGREqcAS6SJ6UaZjs49uvxkvSDmNG27zZCPWaafelN2HA=
X-Received: from ejad26.prod.google.com ([2002:a17:906:41a:b0:adf:d372:c8df])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:f87:b0:ad5:8412:1c9 with SMTP id a640c23a62f3a-ae6e1459573mr328776666b.59.1752153137929;
 Thu, 10 Jul 2025 06:12:17 -0700 (PDT)
Date: Thu, 10 Jul 2025 13:12:17 +0000
In-Reply-To: <aF7lVYl7p33kByoK@tardis.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250627-workqueue-delay-v2-1-84b046fdb4fc@google.com> <aF7lVYl7p33kByoK@tardis.local>
Message-ID: <aG-8MVc8SumJoWSk@google.com>
Subject: Re: [PATCH v2] workqueue: rust: add delayed work items
From: Alice Ryhl <aliceryhl@google.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Benno Lossin <lossin@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Fri, Jun 27, 2025 at 11:39:17AM -0700, Boqun Feng wrote:
> On Fri, Jun 27, 2025 at 09:38:42AM +0000, Alice Ryhl wrote:
> [...]
> > diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> > index d092112d843f3225ea582e013581b39e36652a84..3a7ab7d078fc2091ad556bfde997b9f73f618773 100644
> > --- a/rust/kernel/workqueue.rs
> > +++ b/rust/kernel/workqueue.rs
> > @@ -131,10 +131,69 @@
> >  //! # print_2_later(MyStruct::new(41, 42).unwrap());
> >  //! ```
> >  //!
> > +//! This example shows how you can schedule delayed work items:
> > +//!
> > +//! ```
> > +//! use kernel::sync::Arc;
> > +//! use kernel::workqueue::{self, impl_has_delayed_work, new_delayed_work, DelayedWork, WorkItem};
> > +//!
> > +//! #[pin_data]
> > +//! struct MyStruct {
> > +//!     value: i32,
> > +//!     #[pin]
> > +//!     work: DelayedWork<MyStruct>,
> > +//! }
> > +//!
> > +//! impl_has_delayed_work! {
> > +//!     impl HasDelayedWork<Self> for MyStruct { self.work }
> > +//! }
> > +//!
> > +//! impl MyStruct {
> > +//!     fn new(value: i32) -> Result<Arc<Self>> {
> > +//!         Arc::pin_init(
> > +//!             pin_init!(MyStruct {
> > +//!                 value,
> > +//!                 work <- new_delayed_work!("MyStruct::work"),
> > +//!             }),
> > +//!             GFP_KERNEL,
> > +//!         )
> > +//!     }
> > +//! }
> > +//!
> > +//! impl WorkItem for MyStruct {
> > +//!     type Pointer = Arc<MyStruct>;
> > +//!
> > +//!     fn run(this: Arc<MyStruct>) {
> > +//!         pr_info!("The value is: {}\n", this.value);
> > +//!     }
> > +//! }
> > +//!
> > +//! /// This method will enqueue the struct for execution on the system workqueue, where its value
> > +//! /// will be printed 42 jiffies later.
> > +//! fn print_later(val: Arc<MyStruct>) {
> > +//!     let _ = workqueue::system().enqueue_delayed(val, 42);
> 
> Nit: maybe use a different jiffies value? Because you call
> MyStruct::new(42) later, and we want to demonstrate that the '42' in
> enqueue_delayed() is the value for delay, not the '42' in
> MyStruct::new() ;-)
> 
> Just use 10 jiffies, maybe?
> 
> > +//! }
> > +//!
> > +//! /// It is also possible to use the ordinary `enqueue` method together with `DelayedWork`. This
> > +//! /// is equivalent to calling `enqueue_delayed` with a delay of zero.
> > +//! fn print_now(val: Arc<MyStruct>) {
> > +//!     let _ = workqueue::system().enqueue(val);
> > +//! }
> > +//! # print_later(MyStruct::new(42).unwrap());
> > +//! # print_now(MyStruct::new(42).unwrap());
> > +//! ```
> > +//!
> >  //! C header: [`include/linux/workqueue.h`](srctree/include/linux/workqueue.h)
> >  
> > -use crate::alloc::{AllocError, Flags};
> > -use crate::{prelude::*, sync::Arc, sync::LockClassKey, types::Opaque};
> > +use crate::{
> > +    alloc::{AllocError, Flags},
> > +    container_of,
> > +    prelude::*,
> > +    sync::Arc,
> > +    sync::LockClassKey,
> > +    time::Jiffies,
> > +    types::Opaque,
> > +};
> >  use core::marker::PhantomData;
> >  
> >  /// Creates a [`Work`] initialiser with the given name and a newly-created lock class.
> > @@ -146,6 +205,33 @@ macro_rules! new_work {
> >  }
> >  pub use new_work;
> >  
> > +/// Creates a [`DelayedWork`] initialiser with the given name and a newly-created lock class.
> > +#[macro_export]
> > +macro_rules! new_delayed_work {
> > +    () => {
> > +        $crate::workqueue::DelayedWork::new(
> > +            $crate::c_str!(::core::concat!(::core::file!(), ":", ::core::line!())),
> 
> We can use `optional_name!()` for this.
> 
> > +            $crate::static_lock_class!(),
> > +            $crate::c_str!(::core::concat!(
> > +                ::core::file!(),
> > +                ":",
> > +                ::core::line!(),
> > +                "_timer"
> > +            )),
> 
> and maybe extend `optional_name!()` to support a suffix? Or we make a
> concat!() for `CStr`? Anyway I don't think this blocks the patch, if you
> don't have time, I will create an issue for this.

I'll use optional_name!() for the first one. We can add suffix support
separately.

Alice

