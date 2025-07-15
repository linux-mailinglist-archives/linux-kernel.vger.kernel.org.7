Return-Path: <linux-kernel+bounces-731661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C56DB057D8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51B774E130A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53EE2D8774;
	Tue, 15 Jul 2025 10:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/C1+r7q"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A4C28F4;
	Tue, 15 Jul 2025 10:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752575518; cv=none; b=FiFnudFptZhPL3Oqfq94z4HyfaV4IsNSa7Gy+rFbbRTOp+GkAvUQ+F99c88xuFUAu34DNd+fNfc4CEnuHfxtGwgMBidVndXU5nd6xgm/UGfdKe/+YLTxuGeQcB0Q978eYijrsnuSVQG3JZvZqMUuZBdKVsJE4Bydfuu4xTz8EY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752575518; c=relaxed/simple;
	bh=YziQ9wNa5Gyx65BMDUPCAoU0lFno9ULjzg/y5bl8La8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8oUza01olelNJ4CaTf9JsS9HSxsIbb1vXYFRAk5blQlwry2+hWw6NxG8bVUESMuNaJahWKlZuyLx7CoMBln8gr7SeeLm3/G/35NBB6qpng8YZmYBeeDdJksa8e6UhjNJpE+1aMx2+hHSoAlOglGSHm5v/OTjffKMHhgJdZr0KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/C1+r7q; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae361e8ec32so993880866b.3;
        Tue, 15 Jul 2025 03:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752575514; x=1753180314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=19y82vR2J5R6risS4bwxDT4Xe9S8atzVOrzkj21A8LU=;
        b=U/C1+r7qwmFDGlCpl1VtUDDbMVjIbU+weimDqut9gGorp+MhuIoRKphZ6oU6kF6Y8P
         3kIrSl2q5bnnPjW+ct9nzQszgDnlCdeIU6cx5p7Dk3gn8tCLnEhWFYN9z7b5SmPPyNGJ
         FaavXGFuszd7gePCJg/rStw6ZyUXUDEJhT0i8l6bqMUzY85ZRM5tucvvGA3KqgPx4iWo
         xA5apUIC2BHxVbBqDMQm5lj8W42VCPnfsZ6Y0R+SKBaq8Abk3qMPQNiqeaIzVUqNlVaP
         RZGTWiy5Tn8/60T0Z+RwqLSTNga8+Wcx70WBne+lxGDfosLzffnVsxc8F7ivGnwItgFU
         81yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752575514; x=1753180314;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19y82vR2J5R6risS4bwxDT4Xe9S8atzVOrzkj21A8LU=;
        b=kwU+PVpeP2eXDXcvMpG4CyHbmBDax5w2GdsCYvouK/5OzuPLW/Nxvlo9bjfX6sdEnc
         E5KrVjkQeAVXDLJ5Hk8IxtKGPPyoRLCsZJBl+VpvqMeis4PaQ2LYC4Yd4l8o3rycAi5b
         dFm9knqDq8c3b2Us5D3Hicg+3cHqtjWXN1FJEiK8sNzRnPj9AVkegKCTP+hYkmWzn99i
         ZW48nkv9BZATpNg2rFnkq5r4IlpbQM22AIP58ViRxfTnSHho05zMSIV0DfXocpOVUsQM
         9l7SodNQxpxlwVndfzLZ9j7EfuYSzbE/CSC6GRhTpK6J+hF89b28nK6lUU3wR4dbAOAI
         43aw==
X-Forwarded-Encrypted: i=1; AJvYcCVNDXC1Ve8SZwUqrDXCt0y5Dxw5R6EDMQ3uPp95OhSvBB7MGhi699UaMlql9iL0fRJFQufH4lBQ4sH+O9j2w10=@vger.kernel.org, AJvYcCWpnrrBBav+BcmEUwtfq1QmcupDMeLl0OCNOLqlUSVPcHb7kIOWV39iVaWM0RljK5Y4CLVbCy1qnGWO7/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9xOfJbcwK8mmtmw00DNM2sAxzPNuNWDgOKqNluLDbVTcOkm5i
	4ar0LVDTYP3nNcpL9fcKGEequslUvNOLQ07k7px8M68FQpsWAUNtywxV
X-Gm-Gg: ASbGncsUe0aAcv2TcyfWA5M2KJgTS3Qbac3lvagHbsuffCWSoRLpstzUPbK6M2UEUCy
	uNIrVh3ixB6iA0TP6vR7YO2BBcGaI929jSmd+hU5Ml36bbF6jp8toYU3F9rnejc8r7RkaJuMHjQ
	znL0FoHYSEbt/UnWtyFH8gIL5PGD0Cx3uBYX13e/H9vq2Tir/bQXiLSKQefcO3FUS2wyRyw+2FE
	xlO4jmyneRTyzHEQA2JTWoLbbe/e2MLYl/av4KFrADF2mizLic9Yz2livst1ucQDBJLI5OzINyA
	OhjqFymW5qk98IMJN7aWyCnrTQkWOjgNEb7Pjl9XWwtzM8Q3U/q/JXriAPH+9UP5w6n5vJdPGCi
	Hvd5dU6GhE6szvhr5407b6Xk9MqVtYuRlL9jOU+WKRtlJ5wg2bUDSG6/jJHP4mWUyjFG2eZI=
X-Google-Smtp-Source: AGHT+IGm0Eo7WMlMpiYg7eCxidmrz8W5QxCppCa1TJ8Yab6+vZVWVdqJFgb9fOWtiHq2hk4a27F8Zw==
X-Received: by 2002:a17:907:1ca1:b0:ae0:c690:1bed with SMTP id a640c23a62f3a-ae7012db12emr1692257366b.51.1752575513793;
        Tue, 15 Jul 2025 03:31:53 -0700 (PDT)
Received: from Cyndaquil. (static-35-65-100-159.thenetworkfactory.nl. [159.100.65.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8316b53sm964195366b.185.2025.07.15.03.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 03:31:53 -0700 (PDT)
Message-ID: <68762e19.170a0220.33e203.a0b7@mx.google.com>
X-Google-Original-Message-ID: <aHYuFluTAfYTDYN3@Cyndaquil.>
Date: Tue, 15 Jul 2025 12:31:50 +0200
From: Mitchell Levy <levymitchell0@gmail.com>
To: Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 3/5] rust: percpu: add a rust per-CPU variable test
References: <20250712-rust-percpu-v2-0-826f2567521b@gmail.com>
 <20250712-rust-percpu-v2-3-826f2567521b@gmail.com>
 <DBATM1CUS704.28MKE6BIBQB7G@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBATM1CUS704.28MKE6BIBQB7G@kernel.org>

On Sun, Jul 13, 2025 at 11:30:31AM +0200, Benno Lossin wrote:
> On Sat Jul 12, 2025 at 11:31 PM CEST, Mitchell Levy wrote:
> > Add a short exercise for Rust's per-CPU variable API, modelled after
> > lib/percpu_test.c
> >
> > Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
> > ---
> >  lib/Kconfig.debug       |   9 ++++
> >  lib/Makefile            |   1 +
> >  lib/percpu_test_rust.rs | 120 ++++++++++++++++++++++++++++++++++++++++++++++++
> 
> I don't know if this is the correct place, the code looks much more like
> a sample, so why not place it there instead?

I don't feel particularly strongly either way --- I defaulted to `lib/`
since that's where the `percpu_test.c` I was working off of is located.
Happy to change for v3

> >  rust/helpers/percpu.c   |  11 +++++
> >  4 files changed, 141 insertions(+)
> > diff --git a/lib/percpu_test_rust.rs b/lib/percpu_test_rust.rs
> > new file mode 100644
> > index 000000000000..a9652e6ece08
> > --- /dev/null
> > +++ b/lib/percpu_test_rust.rs
> > @@ -0,0 +1,120 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +//! A simple self test for the rust per-CPU API.
> > +
> > +use core::ffi::c_void;
> > +
> > +use kernel::{
> > +    bindings::{on_each_cpu, smp_processor_id},
> > +    define_per_cpu,
> > +    percpu::{cpu_guard::*, *},
> > +    pr_info,
> > +    prelude::*,
> > +    unsafe_get_per_cpu,
> > +};
> > +
> > +module! {
> > +    type: PerCpuTestModule,
> > +    name: "percpu_test_rust",
> > +    author: "Mitchell Levy",
> > +    description: "Test code to exercise the Rust Per CPU variable API",
> > +    license: "GPL v2",
> > +}
> > +
> > +struct PerCpuTestModule;
> > +
> > +define_per_cpu!(PERCPU: i64 = 0);
> > +define_per_cpu!(UPERCPU: u64 = 0);
> > +
> > +impl kernel::Module for PerCpuTestModule {
> > +    fn init(_module: &'static ThisModule) -> Result<Self, Error> {
> > +        pr_info!("rust percpu test start\n");
> > +
> > +        let mut native: i64 = 0;
> > +        // SAFETY: PERCPU is properly defined
> > +        let mut pcpu: StaticPerCpu<i64> = unsafe { unsafe_get_per_cpu!(PERCPU) };
> 
> I don't understand why we need unsafe here, can't we just create
> something specially in the `define_per_cpu` macro that is then confirmed
> by the `get_per_cpu!` macro and thus it can be safe?

As is, something like
    define_per_cpu!(PERCPU: i32 = 0);

    fn func() {
        let mut pcpu: StaticPerCpu<i64> = unsafe { unsafe_get_per_cpu!(PERCPU) };
    }
will compile, but any usage of `pcpu` will be UB. This is because
`unsafe_get_per_cpu!` is just blindly casting pointers and, as far as I
know, the compiler does not do any checking of pointer casts. If you
have thoughts/ideas on how to get around this problem, I'd certainly
*like* to provide a safe API here :)

> > +        // SAFETY: We only have one PerCpu that points at PERCPU
> > +        unsafe { pcpu.get(CpuGuard::new()) }.with(|val: &mut i64| {
> 
> Hmm I also don't like the unsafe part here...
> 
> Can't we use the same API that `thread_local!` in the standard library
> has:
> 
>     https://doc.rust-lang.org/std/macro.thread_local.html
> 
> So in this example you would store a `Cell<i64>` instead.
> 
> I'm not familiar with per CPU variables, but if you're usually storing
> `Copy` types, then this is much better wrt not having unsafe code
> everywhere.
> 
> If one also often stores `!Copy` types, then we might be able to get
> away with `RefCell`, but that's a small runtime overhead -- which is
> probably bad given that per cpu variables are most likely used for
> performance reasons? In that case the user might just need to store
> `UnsafeCell` and use unsafe regardless. (or we invent something
> specifically for that case, eg tokens that are statically known to be
> unique etc)

I'm open to including a specialization for `T: Copy` in a similar vein
to what I have here for numeric types. Off the top of my head, that
shouldn't require any user-facing `unsafe`. But yes, I believe there is
a significant amount of interest in having `!Copy` per-CPU variables.
(At least, I'm interested in having them around for experimenting with
using Rust for HV drivers.)

I would definitely like to avoid *requiring* the use of `RefCell` since,
as you mention, it does have a runtime overhead. Per-CPU variables can
be used for "logical" reasons rather than just as a performance
optimization, so there might be some cases where paying the runtime
overhead is ok. But that's certainly not true in all cases. That said,
perhaps there could be a safely obtainable token type that only passes a
`&T` (rather than a `&mut T`) to its closure, and then if a user doesn't
mind the runtime overhead, they can choose `T` to be a `RefCell`.
Thoughts?

For `UnsafeCell`, if a user of the API were to have something like a
`PerCpu<UnsafeCell<T>>` that safely spits out a `&UnsafeCell<T>`, my
understanding is that mutating the underlying `T` would require the
exact same safety guarantees as what's here, except now it'd need a much
bigger unsafe block and would have to do all of its manipulations via
pointers. That seems like a pretty big ergonomics burden without a clear
(to me) benefit.

> ---
> Cheers,
> Benno
> 
> > +            pr_info!("The contents of pcpu are {}\n", val);
> > +
> > +            native += -1;
> > +            *val += -1;
> > +            pr_info!("Native: {}, *pcpu: {}\n", native, val);
> > +            assert!(native == *val && native == -1);
> > +
> > +            native += 1;
> > +            *val += 1;
> > +            pr_info!("Native: {}, *pcpu: {}\n", native, val);
> > +            assert!(native == *val && native == 0);
> > +        });

