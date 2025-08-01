Return-Path: <linux-kernel+bounces-753111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5146B17ECC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 11:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D782217D01D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEDB21FF58;
	Fri,  1 Aug 2025 09:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yr4nkXYr"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE41121772A
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 09:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754039110; cv=none; b=P1DqmRL/ZCNJ41/ICrJpamJC6AT0pCzKfo3IGFlgvAqgcaPP/F521UNgCPeGX9LIwvbs+YSvEGkxJSji34kKHLEx7aMSmA+W3YWUDO9Ah7Vb83aWykllfPchcdcCbMSri2QFAzKqZvu5Bamhh9+0wLJyzYPlj01Urn588/TyMcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754039110; c=relaxed/simple;
	bh=7kG/HUcTp9/Qvr5h6tdmy/wUlx3CrjfsxU2jp4kAN6A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A/zdKh9b2gqbTAkOaZQz8Sfx9Nm51FEQ4VlRlm4SOzTLQ34VUlFnrqxRmAfpG4caKNdCNj9+ESSl46S7Hy7hvCA3SqD7X0SObErJr9h2+nltgB5Bwm+y9L0owa4XY+piDrGevshYiaXncJy7zaziJO1lk5h3QS+1qmiQ9iIl08I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yr4nkXYr; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-455e9e09afeso4590425e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 02:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754039107; x=1754643907; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CVIXz4OClJs/jKNYaFwgOLlddhdlcUfndXSfXzIRugU=;
        b=yr4nkXYrXZsMif5bb5BJdrE3vkcrehwajutdZ6ZLDpuAlETiNTpAlBl/AdAHgTg+kM
         BtAlS+fhZG7AIyq6SbJz0BmuXEuJJ77aY6j0TMGwJZ+8xPdWxEh7MlJhkQ4vpZOp66ML
         GsmbtCVDLz88CfT8MfToT+fPiUjqkPNHNaq6yeL7cw2M3vFrpLW5G56hk2a3mq2HrdRy
         rIKhEHil4iaNeYUm4Gaq8KHyz2NqXSIFq6KgiPd6XciAT489g7jiBAHCN+28me9uLzzt
         86ocLd7nFWa96rmQjiNYCR7vbo2aGygvH1YHu/6NvlVDD/02T6wuUG0qWTPMBScWyYip
         qeqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754039107; x=1754643907;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CVIXz4OClJs/jKNYaFwgOLlddhdlcUfndXSfXzIRugU=;
        b=PWsDamBQdRIV+CdMZUDv+wY3qdYKzdS/Xx/bDHuA4auzvtLYq8ZSV5UrTtg8L3Ixr2
         XUiZyG43i5DPMxKKmqc7fv7c4uh52KNPi8oA42KHRtSKCfXC1beI/MkXyNY+8wDBTl8k
         V41eRrqKIPweyahxwN7xIZ0/uIwWInf8B+omqd88QwbHrz85CNH6yLEiAdRk/3UYaLHm
         y0V5BJ1u19Kdy3eslMXtg0XzxN7qXVRDE5dd0pKPtzIB7cO6TQDXnXp3AkpWR10A9eO/
         nlKBfD26W+QU6NdKxtH8m6DtPkuJWzH8w3Chr0/Z3dr74jloe204EriChYC+cDowU3Nl
         uHyg==
X-Forwarded-Encrypted: i=1; AJvYcCW0Ezn6+xIlF1Lt7fLeUpXmejWt5f4QNjW68/DYdB7/YSiacklB3tucwQ+hCH5UULg8ysqGD+Msyu3IPFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YznDrV51ocfg8A0J2aWOb4j7xvTeIx7v9M874LBzGXvmmqoCyxm
	DzrLDHGOj6NqOWTFmcwFXnDy2yYiswKATfGB1AcNDz2gkjCzq7bzAeaCq/j1I68ALxCGaFrK3n5
	Tl3CSc9tL+iiyhpL/dQ==
X-Google-Smtp-Source: AGHT+IGEHg2PiEkyL1lIyZM0NnEVAwjk72qlAnQYVQaHVIxWbAZGwCkMPKNfs8tba0IRFEV6/LDdvg0jCCa1GOk=
X-Received: from wmbay35.prod.google.com ([2002:a05:600c:1e23:b0:442:f9fc:2a02])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4ed3:b0:456:1e5a:8879 with SMTP id 5b1f17b1804b1-458aa31fbe8mr18057495e9.9.1754039107176;
 Fri, 01 Aug 2025 02:05:07 -0700 (PDT)
Date: Fri, 1 Aug 2025 09:05:06 +0000
In-Reply-To: <20250730163439.50753-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250730163439.50753-1-boqun.feng@gmail.com>
Message-ID: <aIyDQhLePywlGSGQ@google.com>
Subject: Re: [RFC PATCH] rust: workqueue: Add an example for try_spawn()
From: Alice Ryhl <aliceryhl@google.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Tejun Heo <tj@kernel.org>, Tamir Duberstein <tamird@gmail.com>, 
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, Alban Kurti <kurti@invicto.ai>, 
	Joel Fernandes <joelagnelf@nvidia.com>, "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Wed, Jul 30, 2025 at 09:34:39AM -0700, Boqun Feng wrote:
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
> [1]: https://rust-for-linux.zulipchat.com/#narrow/channel/291566-Library/topic/.60new.60.20or.20.60try_new.60.3F/near/529533317

Renaming sounds good to me.

> Also I find the `{ <clone> || { } }` is really good if I only need to
> clone the Arc for passing to a callback closure, but I'm not sure how
> people feel about it, so criticism is welcome ;-)

It's a neat trick, but I think it risks confusing people. I would
probably not include it in an example like this one.

>  rust/kernel/workqueue.rs | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> index b9343d5bc00f..59c1a5e14d12 100644
> --- a/rust/kernel/workqueue.rs
> +++ b/rust/kernel/workqueue.rs
> @@ -331,6 +331,33 @@ pub fn enqueue_delayed<W, const ID: u64>(&self, w: W, delay: Jiffies) -> W::Enqu
>      /// Tries to spawn the given function or closure as a work item.
>      ///
>      /// This method can fail because it allocates memory to store the work item.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::{alloc::flags, sync::{Arc, Completion, new_spinlock}, workqueue};
> +    ///
> +    /// let work_done = Arc::pin_init(Completion::new(), flags::GFP_KERNEL)?;
> +    /// let data = Arc::pin_init(new_spinlock!(0), flags::GFP_KERNEL)?;
> +    ///
> +    /// workqueue::system().try_spawn(
> +    ///     flags::GFP_KERNEL,
> +    ///     {
> +    ///         let work_done = work_done.clone();
> +    ///         let data = data.clone();
> +    ///         move || {
> +    ///             *data.lock() = 42;
> +    ///             work_done.complete_all();
> +    ///         }
> +    ///     }
> +    /// )?;
> +    ///
> +    /// work_done.wait_for_completion();
> +    ///
> +    /// // `work_done` being completed implies the observation of the write of `data` in the work.
> +    /// assert_eq!(*data.lock(), 42);
> +    /// # Ok::<(), Error>(())
> +    /// ```
>      pub fn try_spawn<T: 'static + Send + FnOnce()>(
>          &self,
>          flags: Flags,
> -- 
> 2.39.5 (Apple Git-154)
> 

