Return-Path: <linux-kernel+bounces-751253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92393B166EB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38F2D161A71
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB99B2E3B0D;
	Wed, 30 Jul 2025 19:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+OhMKTI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B5B2D613;
	Wed, 30 Jul 2025 19:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753903691; cv=none; b=MBM1T3bG6TprmTOGxgJFKBQFt8QD+M/m3XnkP9hwqbT9Gt2hmp4O1m6I21/HST9DSGanHVj6mD33kRBvEOCacbkLwjEuvi3fjqgua53DXQFw0Dojs2ZP07DOBURIxgiDpOAFP0tMFRy7tVFJVikmq/107tvvCWVyDGhLglio0I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753903691; c=relaxed/simple;
	bh=TYlUKBz/U7F0smL1Nhou3hsVgjS5e6LWsWxW8aR82m0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=SbUsLILDGZEG7Ad71Q76gSD4OYp4Rj67voRYTC8zauVwoU7qwQFYwVyfj+/eIXUyYQH9qTrXDg6JTxW8kIFlM5mUtCh46AZtD/oxATfKw0cjN8urSMT4XEWbbV0idci+kMZZkDDNJ1n47iTfGdGj4KiICTlMsZtnI7wCdXZqLjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+OhMKTI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B71C4CEF9;
	Wed, 30 Jul 2025 19:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753903691;
	bh=TYlUKBz/U7F0smL1Nhou3hsVgjS5e6LWsWxW8aR82m0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=j+OhMKTIJ6Y5pGIQhJUpxf1Pl4DL2XEAUniK6mcu6bzioxJLspM3djWIs0B7iHx5r
	 +lW7tLk4Ra7aVO6yhaSTZ/1fAgVm5s153/+2zJOACLcp1MUdUKZDcGG6poJuo5TVT3
	 VnU1W7n7a+DxvJ72BbYXFoxJCDNYFMdfhfoD/ivhXvxysR7vXgKJ3lti4rq6YfGNv9
	 0IG0dnLdim8YOc5fsU1pLvdsOc0XC4MEi98T+uPqfbGhUmDcOPm9+WFiH7G6m2RdYg
	 m764rjhin+PMdgBOKcEt3Xm2IZjcZtITQrjPH80WTztPLALdRGFdy0hLoy+hlLlwoO
	 y/cxztbeUHEtQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Jul 2025 21:28:05 +0200
Message-Id: <DBPMYTZSIEQ5.3NPJM1CYVO3CK@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Tejun Heo" <tj@kernel.org>, "Tamir Duberstein" <tamird@gmail.com>, "Hamza
 Mahfooz" <hamzamahfooz@linux.microsoft.com>, "Alban Kurti"
 <kurti@invicto.ai>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Paul E.
 McKenney" <paulmck@kernel.org>
Subject: Re: [RFC PATCH] rust: workqueue: Add an example for try_spawn()
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250730163439.50753-1-boqun.feng@gmail.com>
In-Reply-To: <20250730163439.50753-1-boqun.feng@gmail.com>

On Wed Jul 30, 2025 at 6:34 PM CEST, Boqun Feng wrote:
> `try_spawn()` could use an example to demonstrate the usage, and
> arguably it's the most simple usage of workqueue in case someone needs a
> deferred work, so add it.
>
> Cc: Joel Fernandes <joelagnelf@nvidia.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
> Miguel, Alice and Tejun, while I'm at it, should we also rename the
> function to `spawn()` because of the motivation mentioned here [1]?
>
> [1]: https://rust-for-linux.zulipchat.com/#narrow/channel/291566-Library/=
topic/.60new.60.20or.20.60try_new.60.3F/near/529533317
>
> Also I find the `{ <clone> || { } }` is really good if I only need to
> clone the Arc for passing to a callback closure, but I'm not sure how
> people feel about it, so criticism is welcome ;-)

I'm not so sure, see below :)

>  rust/kernel/workqueue.rs | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> index b9343d5bc00f..59c1a5e14d12 100644
> --- a/rust/kernel/workqueue.rs
> +++ b/rust/kernel/workqueue.rs
> @@ -331,6 +331,33 @@ pub fn enqueue_delayed<W, const ID: u64>(&self, w: W=
, delay: Jiffies) -> W::Enqu
>      /// Tries to spawn the given function or closure as a work item.
>      ///
>      /// This method can fail because it allocates memory to store the wo=
rk item.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::{alloc::flags, sync::{Arc, Completion, new_spinlock}=
, workqueue};
> +    ///
> +    /// let work_done =3D Arc::pin_init(Completion::new(), flags::GFP_KE=
RNEL)?;
> +    /// let data =3D Arc::pin_init(new_spinlock!(0), flags::GFP_KERNEL)?=
;
> +    ///
> +    /// workqueue::system().try_spawn(
> +    ///     flags::GFP_KERNEL,
> +    ///     {
> +    ///         let work_done =3D work_done.clone();
> +    ///         let data =3D data.clone();
> +    ///         move || {
> +    ///             *data.lock() =3D 42;
> +    ///             work_done.complete_all();
> +    ///         }
> +    ///     }
> +    /// )?;

Not doing your pattern and instead adding a `2` postfix we get:

    let work_done2 =3D work_done.clone();
    let data2 =3D data.clone();

    workqueue::system().try_spawn(flags::GFP_KERNEL, move || {
        *data2.lock() =3D 42;
        work_done2.complete_all();
    })?;

There are some discussions of introducing some better syntax for (cheap)
cloning, so maybe we can use that in the future.

---
Cheers,
Benno

> +    ///
> +    /// work_done.wait_for_completion();
> +    ///
> +    /// // `work_done` being completed implies the observation of the wr=
ite of `data` in the work.
> +    /// assert_eq!(*data.lock(), 42);
> +    /// # Ok::<(), Error>(())
> +    /// ```
>      pub fn try_spawn<T: 'static + Send + FnOnce()>(
>          &self,
>          flags: Flags,


