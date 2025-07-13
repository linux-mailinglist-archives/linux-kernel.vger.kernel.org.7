Return-Path: <linux-kernel+bounces-729006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67809B03076
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 11:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9EDA3B3FD0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 09:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEBC3FB1B;
	Sun, 13 Jul 2025 09:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJ1oCnWP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DC0C2E0;
	Sun, 13 Jul 2025 09:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752399037; cv=none; b=PlB/JZ8YxpXNMuxL5i6GPymlExmsPTypcw878q9eIMAMMKUKIVTDV3Pgts7FbGEAslHozhiN7LAJawCwRHHlfE8jQwu0VKQQ//6CY0Iqwvn2s0BuSnfTwdg0yZ/VzuDrjj2oMn+P6iDYF2c1BNZ16lDKkxwUSmRlckrIijzNKxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752399037; c=relaxed/simple;
	bh=nKbk6E47aaqEXS0XKE/C976P4mu6SktTQNRnupN5EMs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=l9ElnrWIrbKPWS4A0Nm5cL3q8TqatQt3OIifnwvOjirASJAsk5da5y1xHMoXSgPsjhqcfbPSwpBmGWD4WCX9FWKn+2zG6/zsFLUMRuHCULnSQPpTBqn1U3tGwAuYvRCce9SkjrVemBl/LWdyDM1Pj/nNjQ4pFORK8qHMod6thnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJ1oCnWP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E85C4CEE3;
	Sun, 13 Jul 2025 09:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752399036;
	bh=nKbk6E47aaqEXS0XKE/C976P4mu6SktTQNRnupN5EMs=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=SJ1oCnWP7GGo8/oqSsTzDM10/zjCsKRghHncNrZIA3H/wDMnv8HVZPRB5ioeqc8QU
	 x9XPmnpk4ANH8f44LGVmCp69KXLzaLYp2DCDxpieBqJUcjcQPmB1Pb/lxS8oD3RW9e
	 XaSJYkvOTecnQetUNKlAaHJY8dBxuK4ckCZoCmPBeX3CBiazFnOQuFyAvrlsyp/jhS
	 lGIa3GJnJEvs3ewACwYm6ZxSHgC3RpabeRtsxU5GJfmw1ryO/qXnIj074S/oA59xmY
	 C7d+K7CFrFmUPAACLDtykOfLIzl4UXAtLBBB8lo0gwfhUl3lVlBM9PNbO9OSjuHKAk
	 3l8iNb+AtNJdg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 13 Jul 2025 11:30:31 +0200
Message-Id: <DBATM1CUS704.28MKE6BIBQB7G@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-mm@kvack.org>
Subject: Re: [PATCH v2 3/5] rust: percpu: add a rust per-CPU variable test
From: "Benno Lossin" <lossin@kernel.org>
To: "Mitchell Levy" <levymitchell0@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Dennis Zhou" <dennis@kernel.org>, "Tejun Heo"
 <tj@kernel.org>, "Christoph Lameter" <cl@linux.com>, "Danilo Krummrich"
 <dakr@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250712-rust-percpu-v2-0-826f2567521b@gmail.com>
 <20250712-rust-percpu-v2-3-826f2567521b@gmail.com>
In-Reply-To: <20250712-rust-percpu-v2-3-826f2567521b@gmail.com>

On Sat Jul 12, 2025 at 11:31 PM CEST, Mitchell Levy wrote:
> Add a short exercise for Rust's per-CPU variable API, modelled after
> lib/percpu_test.c
>
> Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
> ---
>  lib/Kconfig.debug       |   9 ++++
>  lib/Makefile            |   1 +
>  lib/percpu_test_rust.rs | 120 ++++++++++++++++++++++++++++++++++++++++++=
++++++

I don't know if this is the correct place, the code looks much more like
a sample, so why not place it there instead?

>  rust/helpers/percpu.c   |  11 +++++
>  4 files changed, 141 insertions(+)
> diff --git a/lib/percpu_test_rust.rs b/lib/percpu_test_rust.rs
> new file mode 100644
> index 000000000000..a9652e6ece08
> --- /dev/null
> +++ b/lib/percpu_test_rust.rs
> @@ -0,0 +1,120 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//! A simple self test for the rust per-CPU API.
> +
> +use core::ffi::c_void;
> +
> +use kernel::{
> +    bindings::{on_each_cpu, smp_processor_id},
> +    define_per_cpu,
> +    percpu::{cpu_guard::*, *},
> +    pr_info,
> +    prelude::*,
> +    unsafe_get_per_cpu,
> +};
> +
> +module! {
> +    type: PerCpuTestModule,
> +    name: "percpu_test_rust",
> +    author: "Mitchell Levy",
> +    description: "Test code to exercise the Rust Per CPU variable API",
> +    license: "GPL v2",
> +}
> +
> +struct PerCpuTestModule;
> +
> +define_per_cpu!(PERCPU: i64 =3D 0);
> +define_per_cpu!(UPERCPU: u64 =3D 0);
> +
> +impl kernel::Module for PerCpuTestModule {
> +    fn init(_module: &'static ThisModule) -> Result<Self, Error> {
> +        pr_info!("rust percpu test start\n");
> +
> +        let mut native: i64 =3D 0;
> +        // SAFETY: PERCPU is properly defined
> +        let mut pcpu: StaticPerCpu<i64> =3D unsafe { unsafe_get_per_cpu!=
(PERCPU) };

I don't understand why we need unsafe here, can't we just create
something specially in the `define_per_cpu` macro that is then confirmed
by the `get_per_cpu!` macro and thus it can be safe?

> +        // SAFETY: We only have one PerCpu that points at PERCPU
> +        unsafe { pcpu.get(CpuGuard::new()) }.with(|val: &mut i64| {

Hmm I also don't like the unsafe part here...

Can't we use the same API that `thread_local!` in the standard library
has:

    https://doc.rust-lang.org/std/macro.thread_local.html

So in this example you would store a `Cell<i64>` instead.

I'm not familiar with per CPU variables, but if you're usually storing
`Copy` types, then this is much better wrt not having unsafe code
everywhere.

If one also often stores `!Copy` types, then we might be able to get
away with `RefCell`, but that's a small runtime overhead -- which is
probably bad given that per cpu variables are most likely used for
performance reasons? In that case the user might just need to store
`UnsafeCell` and use unsafe regardless. (or we invent something
specifically for that case, eg tokens that are statically known to be
unique etc)

---
Cheers,
Benno

> +            pr_info!("The contents of pcpu are {}\n", val);
> +
> +            native +=3D -1;
> +            *val +=3D -1;
> +            pr_info!("Native: {}, *pcpu: {}\n", native, val);
> +            assert!(native =3D=3D *val && native =3D=3D -1);
> +
> +            native +=3D 1;
> +            *val +=3D 1;
> +            pr_info!("Native: {}, *pcpu: {}\n", native, val);
> +            assert!(native =3D=3D *val && native =3D=3D 0);
> +        });

