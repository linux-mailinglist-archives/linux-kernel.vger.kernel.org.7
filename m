Return-Path: <linux-kernel+bounces-762454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE5AB206C3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02CFE2A1466
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51ED72BE7DC;
	Mon, 11 Aug 2025 11:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q4NDh5La"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7982BE657
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754910152; cv=none; b=CEqVLmKz3EqLMGjG77MNglnTkBSxcUWBllbL4gvHyt/NN6V/anj6w5fDh6+o/r2N1QYuWWyqNAg4qPpZCIy6iUTtTduZqFlZqEaGJvN9EbnT9dj/C8I7qlD2n/0grp4BmFOa6YNZWfYIjZ/MK/gMJ2H7+w+vXXieWOdLhb5z/7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754910152; c=relaxed/simple;
	bh=PZvpmMGKZoBLVkqYrM3rKvbs5tN16syyK8pG0HEe30E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VGoXBdQrE+3ITBDJ2UqN8Vd5tedyvDFr1E+ma090cX3SNjCbK63o5iAhJESKcslcSGwlNSXwV4yeKzetT/iN6ELR3oHm+wJbrjur2X0I0f5iCfLFv5iUuf5Ti8En3UKOObiRv7sqWSZbSVGnNsQd3RvBXM/bQZMS4Dwfdn3TU3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q4NDh5La; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-459db47f138so16482355e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 04:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754910149; x=1755514949; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XoFLgAaU3dTMlkB3ivuNiJh7YAxvoPGHMa/b1QxLM0U=;
        b=q4NDh5Latt5zJ/bzhTzRV3KKeCBgd40ySBv5apIR4hMVMPIGRbT80C5QupvbSq3vEc
         WlJt0AhlF9IBFWwVF3Z76EyLrCpqSWKMa0JSPwbUNGZSPunKLL/1zinw3oJyTZf0dPef
         nhyigFjmRhWVh3P95UhwW2jfZqOLZEZ2i82H0Zl4qF0BgCrUFlKE5r6qZ+KrBLtbr58U
         2J9FbkEIYLa8fOFnWjamOJUuqH6OYJQWEHzTsLznt4toYX560yL7/53oSGK+GYfShXvv
         RQxEYQrmAYgzFK542LL6JHUxMOcQ5OdMYo/nsve9tscUxy+spFW48OgK/9Ko9O6DKKa+
         OXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754910149; x=1755514949;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XoFLgAaU3dTMlkB3ivuNiJh7YAxvoPGHMa/b1QxLM0U=;
        b=jz/FxBrUm7arFQQkQXiBWXROWlzf0bL5oxRUZ6I41k/kftHHpBu/WU/6Oa16OM3KbL
         UCmA3n8/8EPeLd5iwwm0RJ3wcg1poLOvHw11KXGm+DnKxcd30Sn8fmlLHAhXSAsCKvAF
         EVG7sy0MSwVkwex5SWsE+UJ0QM59hdnPSMM455Nl06cq3dyjUraKC9ZwEwoivKhT6tnU
         rUmzybH4sqrGS0yWsnTOMVxbzySKBSdKDXR3QqKnIfwEiJUiSFsKCW1dACwQstuo/l/f
         u1ys/8gNyOdQlK21nUfv+0/qXEVxa/h60quxWe/Tm18qu2xZ9A47nZ1aMB58di4vJE7V
         +yZg==
X-Forwarded-Encrypted: i=1; AJvYcCUpl+8Lsbsu0/wDuOoxLGEZKogJn3RVFA2l4W0U74fAtBbMBjLwrEZbpeLcA8oL/Ttzxsd31OnpvOehwCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMWXPWvk0QV1Jjf9uslNzot9IZL85CnrF0N7dtRnBvrAKlceMD
	t4rCkxPn2PsMto7AiuhSNfkaOyPXcVBmstOa4/aCjjq8ZVobP7QllhlXmWR8zTCD+eQ0n8rdcOU
	v7QJKyEay0TS54G/PvA==
X-Google-Smtp-Source: AGHT+IEHj90/RHzHpvJsu5QjMlw4g2edIeCdvOyz1s9R5fzcMKzgwi4o+H+e3XIfZKtOyXsp93grjLNDgnKyY0Q=
X-Received: from wmbay18.prod.google.com ([2002:a05:600c:1e12:b0:459:e01c:3d6d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:15d1:b0:459:e025:8c5b with SMTP id 5b1f17b1804b1-459f60d2211mr79186135e9.30.1754910149427;
 Mon, 11 Aug 2025 04:02:29 -0700 (PDT)
Date: Mon, 11 Aug 2025 11:02:28 +0000
In-Reply-To: <20250810-topics-tyr-request_irq2-v8-4-8163f4c4c3a6@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250810-topics-tyr-request_irq2-v8-0-8163f4c4c3a6@collabora.com> <20250810-topics-tyr-request_irq2-v8-4-8163f4c4c3a6@collabora.com>
Message-ID: <aJnNxMmWarz9MWKH@google.com>
Subject: Re: [PATCH v8 4/6] rust: irq: add support for threaded IRQs and handlers
From: Alice Ryhl <aliceryhl@google.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org, 
	Joel Fernandes <joelagnelf@nvidia.com>, Dirk Behme <dirk.behme@de.bosch.com>
Content-Type: text/plain; charset="utf-8"

On Sun, Aug 10, 2025 at 09:32:17PM -0300, Daniel Almeida wrote:
> This patch adds support for threaded IRQs and handlers through
> irq::ThreadedRegistration and the irq::ThreadedHandler trait.
> 
> Threaded interrupts are more permissive in the sense that further
> processing is possible in a kthread. This means that said execution takes
> place outside of interrupt context, which is rather restrictive in many
> ways.
> 
> Registering a threaded irq is dependent upon having an IrqRequest that
> was previously allocated by a given device. This will be introduced in
> subsequent patches.
> 
> Tested-by: Joel Fernandes <joelagnelf@nvidia.com>
> Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> +/// # Examples
> +///
> +/// The following is an example of using [`ThreadedRegistration`]. It uses a
> +/// [`Mutex`](kernel::sync::Mutex) to provide interior mutability.
> +///
> +/// ```
> +/// # use kernel::c_str;
> +/// # use kernel::device::Bound;
> +/// # use kernel::irq::{
> +/// #   self, Flags, IrqRequest, IrqReturn, ThreadedHandler, ThreadedIrqReturn,
> +/// #   ThreadedRegistration,
> +/// # };
> +/// # use kernel::prelude::*;
> +/// # use kernel::sync::{Arc, Mutex};

I would probably remove the # and keep imports visible in the example.

> +/// // Declare a struct that will be passed in when the interrupt fires. The u32
> +/// // merely serves as an example of some internal data.
> +/// //
> +/// // [`irq::ThreadedHandler::handle`] takes `&self`. This example
> +/// // illustrates how interior mutability can be used when sharing the data
> +/// // between process context and IRQ context.
> +/// struct Data {
> +///     value: Mutex<u32>,
> +/// }

This example struct should use #[pin_data].

> +///
> +/// type Handler = Data;

I think the type alias is confusing in this example. I'd either rename
the struct or use "Data" everywhere.

> +/// impl ThreadedHandler for Handler {
> +///     // This will run (in a separate kthread) if and only if
> +///     // [`ThreadedHandler::handle`] returns [`WakeThread`], which it does by
> +///     // default.
> +///     fn handle_threaded(&self) -> IrqReturn {
> +///         let mut data = self.value.lock();
> +///         *data += 1;
> +///         IrqReturn::Handled
> +///     }
> +/// }
> +///
> +/// // Registers a threaded IRQ handler for the given [`IrqRequest`].
> +/// //
> +/// // This is executing in process context and assumes that `request` was
> +/// // previously acquired from a device.
> +/// fn register_threaded_irq(
> +///     handler: impl PinInit<Handler, Error>,
> +///     request: IrqRequest<'_>,
> +/// ) -> Result<Arc<ThreadedRegistration<Handler>>> {
> +///     let registration =
> +///         ThreadedRegistration::new(request, Flags::SHARED, c_str!("my_device"), handler);
> +///
> +///     let registration = Arc::pin_init(registration, GFP_KERNEL)?;
> +///
> +///     {
> +///         // The data can be accessed from process context too.
> +///         let mut data = registration.handler().value.lock();
> +///         *data += 1;
> +///     }
> +///
> +///     Ok(registration)
> +/// }
> +/// # Ok::<(), Error>(())
> +/// ```

Alice

