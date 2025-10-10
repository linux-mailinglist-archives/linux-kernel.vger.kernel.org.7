Return-Path: <linux-kernel+bounces-848168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6843ABCCCA9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 13:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC9BF425476
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 11:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AF8286883;
	Fri, 10 Oct 2025 11:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rGikc5D8"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9454414
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 11:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760096493; cv=none; b=nFkCGuMbpZONTI8HeTqHOMLO5lccGlhIYl6FBSNTVguK21saGwZ5c8oEhB67ibRXJp4ZJLUlzIhsqVVTK2vyF4kH1zoMBVUUdun7cYEMdeEMgJokFPjbib6JsQKX45SBvjlZxZL90F81bUQcRHloT1o7m0CZgwPbIG3imqFc12E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760096493; c=relaxed/simple;
	bh=tkTiJxl8UaIbZrZ5Iepj0nO+SegQeIHdV23Q7udL7N4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Dezx5uGkshE0SfY4UdFyGC12xW8s1K1vZ7tuT4I88uQj0xS7acjy2RSTdEgsruMQMN48vPEVTAPDEcPQO5SjWRLLB8yHGiArTPyG286J1EIumx1kLXIao1KzZZS5/lhPhtVXlPEk0+3JJ3boVXE+WEWU4LC1oIF9cm4M+4LD7RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rGikc5D8; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46e473e577eso12926495e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 04:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760096490; x=1760701290; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sP1h7PdQ3Yf2Ey8PajK3BooFysbtdE3P3YzTihFpbEs=;
        b=rGikc5D8PvagHb1ouCLTYxB4MT2aFUJAbupk3y9xPxbgsZ13XjaiSkJTenEzflWWDs
         nPMImH8020/xg9npDzx5TSEJyS5PuTvmOpH6i72tl89XVU8BpzclJ1FyUcV99+OYsjjI
         478KRY/sdawONQbYjaZWSZkFbbW+ni3dlw2oGHJj/+WMENIxhbDsIaqVomE9zCz9u5iI
         HebcHkLTkdONlZtKvYi+SfDqVgd3GRT5Uj0MYjj57RYV2arnTwSa5/Zv65gsG8dXZwpw
         Q8Q1Xj29fM3+X8ZHB+IZP2vjmir9uxXGj4mOds/m5fSc57I+CMo/goTTnIOEQjERHTHn
         pF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760096490; x=1760701290;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sP1h7PdQ3Yf2Ey8PajK3BooFysbtdE3P3YzTihFpbEs=;
        b=eiAWCilHST2hKDzjdOSncRsMh1/ZHCfEGwS5/N7OnZBpBjhmLa2j/bkSgxDh/0mDB5
         cdRaJE0Sc6ePLzjU8FfT4LwYwC7+ngnxraBrv/uzXixK4Ac27EkpEgPyQlRKQhhGe58v
         rZwNZqx6j3F27G0XJXzQZILh1HLraFj5JVaXJgys3OFHrTbc2MaMfC1mBkVqhyvQdAwy
         zFIYkR5Ow5WuHOealLBAaWbIXJcgzvcPKJRhMDXByiyMosGHlYnfJcpXQ7SHPex8nWhN
         alEXCkhTby2jA3EdISJDI89XzN1eXPhG0u/0CR+DNvAAuvWNg4tLuVdBG5wOn5gjp5nv
         qjPw==
X-Forwarded-Encrypted: i=1; AJvYcCU5yQs03NzytoQvFgAs4y7L5YoxGGRXhT+h8SKbmbseLb2yV2McxoKb0se0YGuFKS7DjlGhpqfBDm07rLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLiYEbrKmty4O8V6fnFkvlRYN33ba6OsZcIsReToh9Z+wdCyN6
	pbageLFodoF+NnkhEhGpm5J7a0IqnC4w/X6PU/Q2wXhG5nyCVlu0QGLtRf1B36LJ4888u/MXFAM
	e/9gWWiPV4QbLEswn5w==
X-Google-Smtp-Source: AGHT+IH3iJKq/ZtJ/E8VBomZJGoJfltkSLDyqS69fUM9FlpvzWFrevx3ZuXdfXPbtVyCDBNDeQ3SHEuV9o3AiXY=
X-Received: from wmv6.prod.google.com ([2002:a05:600c:26c6:b0:46e:15a3:1c9b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d1a:b0:46e:4a78:dea9 with SMTP id 5b1f17b1804b1-46fa9af17d4mr78562825e9.17.1760096490360;
 Fri, 10 Oct 2025 04:41:30 -0700 (PDT)
Date: Fri, 10 Oct 2025 11:41:29 +0000
In-Reply-To: <20251009181203.248471-3-markus.probst@posteo.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251009181203.248471-1-markus.probst@posteo.de> <20251009181203.248471-3-markus.probst@posteo.de>
Message-ID: <aOjw6QtVArJ807MX@google.com>
Subject: Re: [PATCH v2 2/2] rust: leds: add basic led classdev abstractions
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

On Thu, Oct 09, 2025 at 06:12:34PM +0000, Markus Probst wrote:
> Implement the core abstractions needed for led class devices, including:
> 
> * `led::Handler` - the trait for handling leds, including
>   `brightness_set`
> 
> * `led::InitData` - data set for the led class device
> 
> * `led::Device` - a safe wrapper around `led_classdev`
> 
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

> +/// The led class device representation.
> +///
> +/// This structure represents the Rust abstraction for a C `struct led_classdev`.
> +#[pin_data(PinnedDrop)]
> +pub struct Device {
> +    handler: KBox<dyn HandlerImpl>,
> +    #[pin]
> +    classdev: Opaque<bindings::led_classdev>,
> +}

Is it not possible to use Device<T> with a `handler: T` field here? That
avoids the box. I don't think other abstractions have needed that. If
it's needed, then why is LED special?

> +/// The led handler trait.
> +///
> +/// # Examples
> +///
> +///```
> +/// # use kernel::{c_str, led, alloc::KBox, error::{Result, code::ENOSYS}};
> +/// # use core::pin::Pin;
> +///
> +/// struct MyHandler;
> +///
> +///
> +/// impl led::Handler for MyHandler {
> +///     const BLOCKING = false;
> +///     const MAX_BRIGHTNESS = 255;
> +///
> +///     fn brightness_set(&self, _brightness: u32) -> Result<()> {
> +///         // Set the brightness for the led here
> +///         Ok(())
> +///     }
> +/// }
> +///
> +/// fn register_my_led() -> Result<Pin<KBox<led::Device>>> {
> +///     let handler = MyHandler;
> +///     KBox::pin_init(led::Device::new(
> +///         None,
> +///         None,
> +///         led::InitData::new()
> +///             .default_label(c_str!("my_led")),
> +///         handler,
> +///     ))
> +/// }
> +///```
> +/// Led drivers must implement this trait in order to register and handle a [`Device`].
> +pub trait Handler {
> +    /// If set true, [`Handler::brightness_set`] and [`Handler::blink_set`] must not sleep
> +    /// and perform the operation immediately.
> +    const BLOCKING: bool;
> +    /// Set this to true, if [`Handler::blink_set`] is implemented.
> +    const BLINK: bool = false;

We have a macro called #[vtable] that automatically generates this kind
of constant for you. Please use it.

> +impl Device {
> +    /// Registers a new led classdev.
> +    ///
> +    /// The [`Device`] will be unregistered and drop.
> +    pub fn new<'a, T: Handler + 'static>(
> +        parent: Option<&'a device::Device>,
> +        init_data: InitData<'a>,
> +        handler: T,
> +    ) -> impl PinInit<Self, Error> + use<'a, T> {
> +        try_pin_init!(Self {
> +            handler <- {
> +                let handler: KBox<dyn HandlerImpl> = KBox::<T>::new(handler, GFP_KERNEL)?;
> +                Ok::<_, Error>(handler)
> +            },
> +            classdev <- Opaque::try_ffi_init(|ptr: *mut bindings::led_classdev| {
> +                // SAFETY: `try_ffi_init` guarantees that `ptr` is valid for write.
> +                unsafe { ptr.write(bindings::led_classdev {
> +                    max_brightness: T::MAX_BRIGHTNESS,
> +                    brightness_set: T::BLOCKING.then_some(
> +                        brightness_set as unsafe extern "C" fn(*mut bindings::led_classdev, u32)
> +                    ),
> +                    brightness_set_blocking: (!T::BLOCKING).then_some(
> +                        brightness_set_blocking
> +                            as unsafe extern "C" fn(*mut bindings::led_classdev,u32) -> i32
> +                    ),
> +                    blink_set: T::BLINK.then_some(
> +                        blink_set
> +                            as unsafe extern "C" fn(*mut bindings::led_classdev, *mut usize,
> +                                                    *mut usize) -> i32

I think you can just do `blink_set as _`.

> +                    ),
> +                    .. bindings::led_classdev::default()
> +                }) };
> +
> +                let mut init_data = bindings::led_init_data {
> +                    fwnode: init_data.fwnode.map_or(core::ptr::null_mut(), FwNode::as_raw),
> +                    default_label: init_data.default_label
> +                                            .map_or(core::ptr::null(), CStr::as_char_ptr),
> +                    devicename: init_data.devicename.map_or(core::ptr::null(), CStr::as_char_ptr),
> +                    devname_mandatory: init_data.devname_mandatory,
> +                };
> +
> +                let parent = parent
> +                    .map_or(core::ptr::null_mut(), device::Device::as_raw);
> +
> +                // SAFETY:
> +                // - `parent` is guaranteed to be a pointer to a valid `device`
> +                //    or a null pointer.
> +                // - `ptr` is guaranteed to be a pointer to an initialized `led_classdev`.
> +                to_result(unsafe {
> +                    bindings::led_classdev_register_ext(parent, ptr, &mut init_data)

So it's ok that `init_data` is valid for the duration of this call and
no longer? It doesn't stash a pointer to it anywhere?

> +extern "C" fn brightness_set(led_cdev: *mut bindings::led_classdev, brightness: u32) {
> +    // SAFETY: `led_cdev` is a valid pointer to a `led_classdev` stored inside a `Device`.
> +    let classdev = unsafe {
> +        &*container_of!(
> +            led_cdev.cast::<Opaque<bindings::led_classdev>>(),

Please use Opaque::cast_from instead.

> +    // SAFETY: `led_cdev` is a valid pointer to a `led_classdev` stored inside a `Device`.
> +    let classdev = unsafe {
> +        &*container_of!(
> +            led_cdev.cast::<Opaque<bindings::led_classdev>>(),
> +            Device,
> +            classdev
> +        )
> +    };

Instead of repeating this logic many times, I suggest a Device::from_raw
method.

> +extern "C" fn blink_set(
> +    led_cdev: *mut bindings::led_classdev,
> +    delay_on: *mut usize,
> +    delay_off: *mut usize,
> +) -> i32 {
> +    // SAFETY: `led_cdev` is a valid pointer to a `led_classdev` stored inside a `Device`.
> +    let classdev = unsafe {
> +        &*container_of!(
> +            led_cdev.cast::<Opaque<bindings::led_classdev>>(),
> +            Device,
> +            classdev
> +        )
> +    };
> +    from_result(|| {
> +        classdev.handler.blink_set(
> +            // SAFETY: `delay_on` is guaranteed to be a valid pointer to usize
> +            unsafe { &mut *delay_on },
> +            // SAFETY: `delay_on` is guaranteed to be a valid pointer to usize
> +            unsafe { &mut *delay_off },

To create a mutable reference, this safety comment should argue why it
is the case that nobody will access these fields for the duration of
`blink_set`. (For example, from another thread?)

Alice

