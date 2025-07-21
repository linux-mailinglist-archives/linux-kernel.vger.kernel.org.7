Return-Path: <linux-kernel+bounces-739791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7B9B0CAFC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 21:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC31D4E6308
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 19:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9AE22FE10;
	Mon, 21 Jul 2025 19:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tmRs6/gS"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29F421FF3E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 19:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753126428; cv=none; b=Y1E5dgwMujfWJEMlNv7Z7xYeJxd5dqSX6e0Wm+ds8xc6oo6ha6IX8TSDwdNjzuNh8VeKhWOdpLTmoX1DBe/TVy8W1Rst4y+D608BSFpKqmNLBZ/F/Y6sRx9/deVTOnwTde/xlxgqgAvZLRmd1rzimbuabUlqIPnOuO5TgJpXh+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753126428; c=relaxed/simple;
	bh=b0Br9Ks6fXh5lsh6KkvcovDZWilidwwTqtBK+nHUNLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mlQKSNy5YC05dQ+2J6c+cbt51DM912Pxh+gKUqhPxo0OkOSDsusbO0T/AHwd0QvUXAtMt5iZ89H2qRsPR0keHAryhgR/m5zqvMZF0EZAC89aoNYKzhNzumSV8vwEVj+nLkj+HIyo06ozhHR4M9lwOubjmA9VwIN3T4qsQ9V1onU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tmRs6/gS; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45634205adaso22830145e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 12:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753126425; x=1753731225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBrX1LhQ4C9q6FY08bFZ+5XkQcWo67qB3JLKdiHTV0U=;
        b=tmRs6/gSRQIKKgplNVfb9rW3B9zbsYsipI0QPcT1Fw2Nb+DUGUzU3JKmNxlaqBmPn5
         zAK8UmB1zIaP9Gz9Jz2fbjt3allkZwFDBX4TFNjPW3ZQsfNTdnMHC05WfSezfhKdcAfY
         SkC8pjVdBRV9mT8uEzCWVxl+mLIbRGtFLBWiYOHGQXyum7NntsUHin9oTXpIVI9slFAi
         cGjd1QG2hxDMoxhNnuLcTkrAo9rTEVCAayg+7bcSwoJtZBIrQP4FJVytG9HDVKKjT9D8
         RibmBH/IFpk6SRTf9imJ3i1VlSoOlBJShU3FBL7aTiVpcA85vCgbiF1CMZdZXYt6nbh3
         R2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753126425; x=1753731225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HBrX1LhQ4C9q6FY08bFZ+5XkQcWo67qB3JLKdiHTV0U=;
        b=n/oecCaUMD/bz4nQf0jCbw6XsYCS0FJR9Ys1snhF+82HjgaKN8Ymf4mbQx4gy3YpCR
         1pyD2I2xgOIz/P8kmEUP3abwT1bpynDvhFHF07uU57QbBY1TdWbiJaRfpUCyv4EDsnxL
         olbZeQW1HhFEHq+Q6/9bRRkjwkmnlmgNZSOhd5a3HrIBS9iTYouu4Svh3gJHPnz3Oavr
         FhPWRif42k3gOIpoxFXFg9QYa+Mo8F/b/YGDIhtVYdILvgthviG/Y5ZS7crPufmHLGVw
         iTUaFqVHipYuHLeCfAeIdxTsVNF5h9fohvr3Y+6OqeoNx5+xh3eIpMQRfocAF+PvJMwO
         yZow==
X-Forwarded-Encrypted: i=1; AJvYcCXD6A+Vj6PJX9N4yAm+rZD/CaQkwu67UY5bHlJeNFHPIBQOgbmnM4QMjOiT/OO1ySZ2nRbRYXHMc5iKjMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsQtgYEb5nlji077zwLFUuRM/77ayMM28dQo6601WpSiKpl9FQ
	igEDih098G/mVvaWZ9cfT1TEvG879UuLxtAEUBBTUTbQiV56qO/Qt/SZEJHj4I2jE6z0ecvKHUP
	vkq2qwttVdM21RfGhDJVTwmf1P9mTYvj9pCUmXQZD
X-Gm-Gg: ASbGncvswYNzcEZ6wieGk40iYvggu+tDBOQdMk7RepjcFfPyF2zUwmoswqLPuUmffll
	udfCggnHXbY7BI4zm+YIj/hLZQ6ImeNwFRJRk/PhUKMfLGW/rjfN+Ugut/yfhIpRi0LIYE+4fQ6
	eYPUtJ4cCpOA3Bogw9s+ZGl/hipmOqVonobBT8CD1kW67yswSd1/HrHymas0iImNpad06u4QNyb
	4C6mmhm
X-Google-Smtp-Source: AGHT+IGNspYtBPncBdW3w/SsuWiBzoraM8UjDYrcQv9P+WyMTcNLgDlaVPcW5XrC7nb2ZAo4MrVL17F2FHDqTh3VVdA=
X-Received: by 2002:a05:6000:4804:b0:3a4:e5fa:73f0 with SMTP id
 ffacd0b85a97d-3b60e4d5533mr15467594f8f.20.1753126425187; Mon, 21 Jul 2025
 12:33:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721-irq-bound-device-v1-1-4fb2af418a63@google.com> <DCBBFAC5-A4B4-41BA-8732-32FA96EDE28E@collabora.com>
In-Reply-To: <DCBBFAC5-A4B4-41BA-8732-32FA96EDE28E@collabora.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 21 Jul 2025 21:33:32 +0200
X-Gm-Features: Ac12FXz3PAqla3h6HMW15ltSgos8jwB8mwZW-LrpptSGLIfz_bq8PvUKZkNYscI
Message-ID: <CAH5fLghRi-QAqGdxOhPPdp6bMyGSuDifnxMFBn3a3NWzN4G4vQ@mail.gmail.com>
Subject: Re: [PATCH] rust: irq: add &Device<Bound> argument to irq callbacks
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Benno Lossin <lossin@kernel.org>, Dirk Behme <dirk.behme@gmail.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 9:14=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> Alice,
>
> > On 21 Jul 2025, at 11:38, Alice Ryhl <aliceryhl@google.com> wrote:
> >
> > When working with a bus device, many operations are only possible while
> > the device is still bound. The &Device<Bound> type represents a proof i=
n
> > the type system that you are in a scope where the device is guaranteed
> > to still be bound. Since we deregister irq callbacks when unbinding a
> > device, if an irq callback is running, that implies that the device has
> > not yet been unbound.
> >
> > To allow drivers to take advantage of that, add an additional argument
> > to irq callbacks.
> >
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> > This patch is a follow-up to Daniel's irq series [1] that adds a
> > &Device<Bound> argument to all irq callbacks. This allows you to use
> > operations that are only safe on a bound device inside an irq callback.
> >
> > The patch is otherwise based on top of driver-core-next.
> >
> > [1]: https://lore.kernel.org/r/20250715-topics-tyr-request_irq2-v7-0-d4=
69c0f37c07@collabora.com
>
> I am having a hard time applying this locally.

Your irq series currently doesn't apply cleanly on top of
driver-core-next and requires resolving a minor conflict. You can find
the commits here:
https://github.com/Darksonn/linux/commits/sent/20250721-irq-bound-device-c9=
fdbfdd8cd9-v1/

> > ///
> > /// This function should be only used as the callback in `request_irq`.
> > unsafe extern "C" fn handle_irq_callback<T: Handler>(_irq: i32, ptr: *m=
ut c_void) -> c_uint {
> > -    // SAFETY: `ptr` is a pointer to T set in `Registration::new`
> > -    let handler =3D unsafe { &*(ptr as *const T) };
> > -    T::handle(handler) as c_uint
> > +    // SAFETY: `ptr` is a pointer to `Registration<T>` set in `Registr=
ation::new`
> > +    let registration =3D unsafe { &*(ptr as *const Registration<T>) };
> > +    // SAFETY: The irq callback is removed before the device is unboun=
d, so the fact that the irq
> > +    // callback is running implies that the device has not yet been un=
bound.
> > +    let device =3D unsafe { registration.inner.device().as_bound() };
>
> Where was this function introduced? i.e. I am missing the change that bro=
ught
> in RegistrationInner::device(), or maybe some Deref impl that would make =
this
> possible?

In this series:
https://lore.kernel.org/all/20250713182737.64448-2-dakr@kernel.org/

> Also, I wonder if we can't make the scope of this unsafe block smaller?

I guess we could with an extra `let` statement.

Alice

