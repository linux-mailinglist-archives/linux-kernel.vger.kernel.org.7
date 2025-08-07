Return-Path: <linux-kernel+bounces-758766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B36FAB1D3A5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6774618873D7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC2C23F405;
	Thu,  7 Aug 2025 07:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="MSOoUILZ"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BF12AD32
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 07:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754552804; cv=none; b=jddMcNZzeCL0lUmowX6IUOFRtpqKWopL1PeVVZnSe3KYkls9GSLdQ/iY6RX8huenjZ6BS04OlHj2CWcdhZbI0fJw0vH3IxtPoi3sJ4FgHhZlKEtECKaExARnvazQg/sVV8+1Kibis8IsQvlEb1Fl/8pRONFm8NZEhDwVelplheE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754552804; c=relaxed/simple;
	bh=rFB1wig4ecHf0PRR92x6pcq2Sf2DAobCtEQ8ikk0LR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtJJaDBZRPmsT78IY91mIKxmTO6mwmqadt1FnZsrxKqFnLT1C93tGi9FzAxKNZ5eeNLn0fY7F83Vim7ycwArCmn5XonPQG703+jd9d967yoGo5mfb7ySjrO3GBzZwF/YtH9rGuKeP7pODeySOAFwrmJVSeuBmkv6oWkb2qCDnZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=MSOoUILZ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76b6422756fso1157134b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 00:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1754552802; x=1755157602; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HF9umwp9Y28asf6+OPLYyndmZD30y/3WqPWlvcSTu1s=;
        b=MSOoUILZN2s5oYOl9Vohe/Aw09jw2OrAuB7zNXawHdUKzkifR6RbgRQDkgG0ZSlWNC
         BvQWiH5MoRCV0rRIj7EF1WwVB3jR77kOJlwVOzJyih+vdsd9XiuVPQpYpy6wvzKMG5kX
         qrw8R8E+MIsqUD4jHSsWbtRVThYnqumabe/Uc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754552802; x=1755157602;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HF9umwp9Y28asf6+OPLYyndmZD30y/3WqPWlvcSTu1s=;
        b=UFaQorDDCisgP80Sqhn5fXEvVnMXIBO0kehem8t5e54E7cm60mLTQ1b6o4/0qU9Eje
         5NGReQCGcovV9uJxW+OfoXl0ON92LkEQxphTZZj1ezmJ1rgJ3/hmCVuFwD6SHvX85xa2
         psx0MHPetf2q8ZFgKth7sRwm4Vj8XumlT8YPL6hjqYE97AqocDDM5Lfeg+qmLbFkLQh/
         lPxwYpjAuO5W3rhpKIVh+wZ8cwLCm4740fz/LRV7yRhpaJnE/Per7K45N9KrqZE8uUSS
         rwBWyzzuSKnBvCIiqgVLljPRfxMMgmni1RWvY5tP9ip8yO1n9zu0OngkIKEW4xJv2JRk
         wyXg==
X-Forwarded-Encrypted: i=1; AJvYcCWYs1oA8nUoJnWvCYJ8BIxHTWqiaAWoZhn39fppQ4D34HnehninJ9+gPdLKBKIACAV5x8irOoa8Nryqndw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAte+L9O+83RppwQvMzhdgkezqv9ftkp44UjUIM+KxNXzhh3xI
	N1Oh5VU3ifrtwGqD5WXvNhXwOBovL7INvOe4OoFV86B+hDQ69AD1V40fGoj1Kyy9ON0=
X-Gm-Gg: ASbGncvm8gYjjY9/7xdLUiJzCkBW2GPg2Q7QJ/hVudvggGPi4ayiNiy7BuAahi4fJJX
	HzApQnGjozNsv5HbkeQ/R3I11GXFH+Jx/CQrKmxc/dByLGw3WiGLkqUX5cS8l2f5xQmczSJWabA
	n3pqxK912zG2qowXgYkRNqzuShu5qx5q7Wl79dkM4xZi13H4K6EhVo6N2jOTOE7U4vN4+V0UYFc
	Q9DjHGFY3eIJzbFUC2Bc3sQwZvr0cPTDTHIJV0ocCXexOOh0aD/o3i9eGrGiGBrX69xBaWgv1ed
	UnX97hPs78T8WQLKRraNOE04hyx1jMLMD5k3kBVqXDwvqPff0fq59ZBp9LrZvfuNkCjGMBqofza
	FOUC8FTsr7VuCqhgzUUKHO1sEWMAynGp+667Kpu2sgGZupZFQ30Cl9M+xoQorhQ==
X-Google-Smtp-Source: AGHT+IHrl0OYwhOOLM+IkPxGunWxJPMNM0YaWGeu7A++wfheky0kC3Rbf02TFHu0ZTweWVVGWP3MeQ==
X-Received: by 2002:a05:6a21:33a1:b0:23d:d9dd:8e4f with SMTP id adf61e73a8af0-240313b0efdmr8733231637.28.1754552801756;
        Thu, 07 Aug 2025 00:46:41 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbd174sm17344464b3a.63.2025.08.07.00.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 00:46:41 -0700 (PDT)
Date: Thu, 7 Aug 2025 16:46:36 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] rust: miscdevice: add uring_cmd() for
 MiscDevice trait
Message-ID: <aJRZ3NUm2xp2H4iX@sidongui-MacBookPro.local>
References: <20250727150329.27433-1-sidong.yang@furiosa.ai>
 <20250727150329.27433-4-sidong.yang@furiosa.ai>
 <BC40C40D-D835-4B5E-927C-A55939110114@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BC40C40D-D835-4B5E-927C-A55939110114@collabora.com>

On Fri, Aug 01, 2025 at 11:04:36AM -0300, Daniel Almeida wrote:
> Hi Sidong,
> 
> > On 27 Jul 2025, at 12:03, Sidong Yang <sidong.yang@furiosa.ai> wrote:
> > 
> > This patch adds uring_cmd() function for MiscDevice trait and its
> > callback implementation. It uses IoUringCmd that io_uring_cmd rust
> > abstraction.
> 
> I can´t parse this.

Okay, I'll fix this.

> 
> > 
> > Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
> > ---
> > rust/kernel/miscdevice.rs | 41 +++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 41 insertions(+)
> > 
> > diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
> > index 288f40e79906..54be866ea7ff 100644
> > --- a/rust/kernel/miscdevice.rs
> > +++ b/rust/kernel/miscdevice.rs
> > @@ -14,6 +14,7 @@
> >     error::{to_result, Error, Result, VTABLE_DEFAULT_ERROR},
> >     ffi::{c_int, c_long, c_uint, c_ulong},
> >     fs::File,
> > +    io_uring::IoUringCmd,
> >     mm::virt::VmaNew,
> >     prelude::*,
> >     seq_file::SeqFile,
> > @@ -175,6 +176,19 @@ fn show_fdinfo(
> >     ) {
> >         build_error!(VTABLE_DEFAULT_ERROR)
> >     }
> > +
> > +    /// Handler for uring_cmd.
> > +    ///
> > +    /// This function is invoked when userspace process submits the uring_cmd op
> > +    /// on io_uring submission queue. The `io_uring_cmd` would be used for get
> > +    /// arguments cmd_op, sqe, cmd_data.
> 
> Please improve this. I don´t think that anyone reading this can really get
> a good grasp on what this function does.
> 
> What does `issue_flags` do?
> 

Agreed, Let me revise this comments to make them easier to understand.

issue_flags includes flags options for io_uring. it's defined as `io_uring_cmd_flags`
in "include/linux/io_uring_types.h".

> > +    fn uring_cmd(
> > +        _device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
> > +        _io_uring_cmd: Pin<&mut IoUringCmd>,
> > +        _issue_flags: u32,
> > +    ) -> Result<i32> {
> > +        build_error!(VTABLE_DEFAULT_ERROR)
> > +    }
> > }
> > 
> > /// A vtable for the file operations of a Rust miscdevice.
> > @@ -332,6 +346,28 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
> >         T::show_fdinfo(device, m, file);
> >     }
> > 
> > +    /// # Safety
> > +    ///
> > +    /// `ioucmd` is not null and points to a valid `bindings::io_uring_cmd`.
> 
> Please rewrite this as "the caller must ensure that  `ioucmd` points to a
> valid `bindings::io_uring_cmd`" or some variation thereof.

Okay, Thanks.
> 
> > +    unsafe extern "C" fn uring_cmd(
> > +        ioucmd: *mut bindings::io_uring_cmd,
> > +        issue_flags: ffi::c_uint,
> > +    ) -> ffi::c_int {
> > +        // SAFETY: The file is valid for the duration of this call.
> > +        let ioucmd = unsafe { IoUringCmd::from_raw(ioucmd) };
> 
> What file?
> 
> Also, this is what you wrote for IoUringCmd::from_raw:

Sorry, it's typo. It should be rewritted.

> 
> +
> + /// Constructs a new `IoUringCmd` from a raw `io_uring_cmd`
> + ///
> + /// # Safety
> + ///
> + /// The caller must guarantee that:
> + /// - The pointer `ptr` is not null and points to a valid `bindings::io_uring_cmd`.
> + /// - The memory pointed to by `ptr` remains valid for the duration of the returned reference's lifetime `'a`.
> + /// - The memory will not be moved or freed while the returned `Pin<&mut IoUringCmd>` is alive.
> + #[inline]
> + pub unsafe fn from_raw<'a>(ptr: *mut bindings::io_uring_cmd) -> Pin<&'a mut IoUringCmd> {
> 
> Here, you have to mention how the safety requirements above are fulfilled in this call site.

Okay, Actually, I'm little confused because it seems that the unsafe code deleted in email.
Anyway I would mention it in next.

> 
> > +        let file = ioucmd.file();
> > +
> > +        // SAFETY: The file is valid for the duration of this call.
> 
> Same here.

Thanks.
> 
> > +        let private = unsafe { (*file.as_ptr()).private_data }.cast();
> 
> Perhaps this can be hidden away in an accessor?

It seems that there is no accessor for private_data in File. 

> 
> > +        // SAFETY: uring_cmd calls can borrow the private data of the file.
> > +        let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
> 
> This is ForeignOwnable::borrow():
> 
>     /// Borrows a foreign-owned object immutably.
>     ///
>     /// This method provides a way to access a foreign-owned value from Rust immutably. It provides
>     /// you with exactly the same abilities as an `&Self` when the value is Rust-owned.
>     ///
>     /// # Safety
>     ///
>     /// The provided pointer must have been returned by a previous call to [`into_foreign`], and if
>     /// the pointer is ever passed to [`from_foreign`], then that call must happen after the end of
>     /// the lifetime `'a`.
>     ///
>     /// [`into_foreign`]: Self::into_foreign
>     /// [`from_foreign`]: Self::from_foreign
>     unsafe fn borrow<'a>(ptr: *mut Self::PointedTo) -> Self::Borrowed<'a>;
> 
> You must say how the safety requirements above are fulfilled in this call site
> as well. In particular, are you sure that this is true? i.e.:
> 
> > The provided pointer must have been returned by a previous call to
> > [`into_foreign`],

Okay, I would mention that the this call fulfilled the requirements.
> 
> 
> > +
> > +        match T::uring_cmd(device, ioucmd, issue_flags) {
> > +            Ok(ret) => ret as ffi::c_int,
> > +            Err(err) => err.to_errno() as ffi::c_int,
> 
> c_int is in the prelude. Also, please have a look at error::from_result().

Thanks.


Thank you for detailed Review.
Sidong

> 
> > +        }
> > +    }
> > +
> >     const VTABLE: bindings::file_operations = bindings::file_operations {
> >         open: Some(Self::open),
> >         release: Some(Self::release),
> > @@ -354,6 +390,11 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
> >         } else {
> >             None
> >         },
> > +        uring_cmd: if T::HAS_URING_CMD {
> > +            Some(Self::uring_cmd)
> > +        } else {
> > +            None
> > +        },
> >         // SAFETY: All zeros is a valid value for `bindings::file_operations`.
> >         ..unsafe { MaybeUninit::zeroed().assume_init() }
> >     };
> > -- 
> > 2.43.0
> > 
> > 
> 
> - Daniel
> 

