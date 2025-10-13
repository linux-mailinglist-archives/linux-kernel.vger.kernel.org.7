Return-Path: <linux-kernel+bounces-851193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 599ABBD5BC3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 61F564F0A19
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3CD2D7395;
	Mon, 13 Oct 2025 18:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ym8M83Gj"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9432D661A
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760380471; cv=none; b=c9uviO6soxO/DNiApZcqNjq5ArINPeTvCXb8i4Id7vS1qjBIE1XAGA+z/udy0Sck/vTbvTXeYlRzSIdznT3Jp0nHme+MuMSI2dcRxS0la5JdXpLwnc96Y8JMtnRg/cqFm9Uhbm3Fu1mCfVT+2zqBBmi/WCRDnu509AbBqSD7KUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760380471; c=relaxed/simple;
	bh=MhcnUYIzW/AjzXhn2E+PvO698S4Cf6FqeCfg4+Wjp0k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bosKXuhycPIk3lUzViDcHKj37ejPRta917OUfjbhRng9Mp+KdbadUp3ATh8lB3jfVqy9d0qMcrFEREYo31UipVAUtc5k+Pvy18Nua+36ZpsU9AAXUdcIrzp5eRkVyI1hcB9GZBFpIafg6wvLGy2KikexYz8lqhjury3xZWi1jtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ym8M83Gj; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b3d6645acd3so455286866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760380468; x=1760985268; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ay88j/QH+hyyaDBYdXcO1dx59pcNYIrbAIsPI7MQ/r0=;
        b=ym8M83GjNWGwF+4tsGmYsHLbaPw+5Q9ol66z0+BSv49SO2oEAvVk0y9EDa/WyxIv11
         i5R0F1Nc26odJPK0HVY8O94K7oUEXSeVXAbvDb/GpZBzlAC4547cUecaYabC3e3bim3c
         UVwAJ5mGmA1FqmR1OneRzlQVpbNhyZYqdNZI1VUMB6ygLh8lhun8FDksBYlzR/b6MRuR
         a7HAH3tHmQbE5LhVgiClt62YbVp3CfK2bkWPyI0VVMh+RqGGBLrEFVIZKNPukDtAFJE3
         +HRyzafHZEE1jCnV8WVP511z1nFi6XHzq8zbxOmUC5Ac2XLsmfuU5yXgjQP6tvmHrU7q
         8wmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760380468; x=1760985268;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ay88j/QH+hyyaDBYdXcO1dx59pcNYIrbAIsPI7MQ/r0=;
        b=r7mahPKZlEp3Uv+eY6MsLptZ3YNhEyIYynCVHtvtxkV66Rou7n1s+Q8IXvftBqhdzQ
         DYRbHlMwyrYsmamwMqXVQ3xkh6+NJ+1FX5/KXDzQSJzWXHBhVZPip/6hWhTqRh5/O4dZ
         Ljpx+N6R/FU5VdUxgYB3S9LOhp4nn3z4kpzrD2i1MP2ool4hRlPQOq6QiEK7jeAqNU4w
         E6DaF505f8NHCLjUgkrqZIKrSbG9pWhQ5TxxVsuBWHyF1KCFJqkVy1UNpiWiixWb99LB
         TlrxfPqgJ7QkXBSJnjrfnfvrliL5+YBPQF6RJmpEqbwSLYwhK6ge3ypDosB3dcnulK8H
         uwcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5Jjk9Gi9G5SYp9KWQGa3PeJZPfS5UD0vwMB7ZBBZ3aec+ClItkpXtHL+N87oeHhNadzbEqpKmTl6J0xU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp2yB8vzicXKSSjSKTFaMbao0rFhyhA0jINW+Nxotpy58zeaBg
	uCMtUdRacnnYVrW3zsSbDSBU/9DAiRoccZdova6hosGEhPVyPor0GQshKswcuo4AyCAFPmxYkFj
	8va6ZQZjtia0egqf86Q==
X-Google-Smtp-Source: AGHT+IGe1qNQN2z1oRXedOyQR3Zfee2RXdyhLUdBm0dMR5H6rdNOgRFmc0Gkgty5AvsElHYqpi3+spY3mX20Te0=
X-Received: from ejn19.prod.google.com ([2002:a17:906:593:b0:b3c:12c2:d0dd])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:2689:b0:b3e:bb87:772c with SMTP id a640c23a62f3a-b50aab9c912mr2457025366b.17.1760380467851;
 Mon, 13 Oct 2025 11:34:27 -0700 (PDT)
Date: Mon, 13 Oct 2025 18:34:27 +0000
In-Reply-To: <20251012145221.172116-3-markus.probst@posteo.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251012145221.172116-1-markus.probst@posteo.de> <20251012145221.172116-3-markus.probst@posteo.de>
Message-ID: <aO1GM4WXs37Zpm0G@google.com>
Subject: Re: [PATCH v4 2/2] rust: leds: add basic led classdev abstractions
From: Alice Ryhl <aliceryhl@google.com>
To: Markus Probst <markus.probst@posteo.de>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sun, Oct 12, 2025 at 02:52:39PM +0000, Markus Probst wrote:
> Implement the core abstractions needed for led class devices, including:
> 
> * `led::LedOps` - the trait for handling leds, including
>   `brightness_set`, `brightness_get` and `blink_set`
> 
> * `led::InitData` - data set for the led class device
> 
> * `led::Device` - a safe wrapper around `led_classdev`
> 
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

> +pub trait LedOps: Send + 'static + Sized {
> +    /// If set true, [`LedOps::brightness_set`] and [`LedOps::blink_set`] must not sleep
> +    /// and perform the operation immediately.
> +    const BLOCKING: bool;
> +    /// The max brightness level
> +    const MAX_BRIGHTNESS: u32;
> +
> +    /// Sets the brightness level.
> +    ///
> +    /// See also [`LedOps::BLOCKING`]
> +    fn brightness_set(&self, brightness: u32) -> Result<()>;
> +
> +    /// Gets the current brightness level.
> +    fn brightness_get(&self) -> u32 {
> +        build_error!(VTABLE_DEFAULT_ERROR)
> +    }
> +
> +    /// Activates hardware accelerated blinking.
> +    ///
> +    /// delays are in milliseconds. If both are zero, a sensible default should be chosen.
> +    /// The caller should adjust the timings in that case and if it can't match the values
> +    /// specified exactly. Setting the brightness to 0 will disable the hardware accelerated
> +    /// blinking.
> +    ///
> +    /// See also [`LedOps::BLOCKING`]
> +    fn blink_set(&self, _delay_on: &mut usize, _delay_off: &mut usize) -> Result<()> {
> +        build_error!(VTABLE_DEFAULT_ERROR)
> +    }

These functions should probably take a &Device<Bound> argument so that
they can use methods that require a bound device (such as IO).

> +impl<T: LedOps> Device<T> {
> +    /// Registers a new led classdev.
> +    ///
> +    /// The [`Device`] will be unregistered on drop.
> +    pub fn new<'a>(
> +        parent: &'a device::Device<Bound>,
> +        init_data: InitData<'a>,
> +        ops: T,
> +    ) -> impl PinInit<Devres<Self>, Error> + 'a {
> +        Devres::new(
> +            parent,
> +            try_pin_init!(Self {
> +                ops,
> +                classdev <- Opaque::try_ffi_init(|ptr: *mut bindings::led_classdev| {
> +                    // SAFETY: `try_ffi_init` guarantees that `ptr` is valid for write.
> +                    // `led_classdev` gets fully initialized in-place by
> +                    // `led_classdev_register_ext` including `mutex` and `list_head`.
> +                    unsafe { ptr.write(bindings::led_classdev {
> +                        max_brightness: T::MAX_BRIGHTNESS,
> +                        brightness_set: T::BLOCKING
> +                            .then_some(Adapter::<T>::brightness_set_callback),
> +                        brightness_set_blocking: (!T::BLOCKING)
> +                            .then_some(Adapter::<T>::brightness_set_blocking_callback),
> +                        brightness_get: T::HAS_BRIGHTNESS_GET
> +                            .then_some(Adapter::<T>::brightness_get_callback),
> +                        blink_set: T::HAS_BLINK_SET
> +                            .then_some(Adapter::<T>::blink_set_callback),
> +                        .. bindings::led_classdev::default()
> +                    }) };

This doesn't look like something rustfmt would output? Could you run
rustfmt if you haven't already. If it doesn't do anything, then please
format it outside of the macro and move it back in.

Alice

