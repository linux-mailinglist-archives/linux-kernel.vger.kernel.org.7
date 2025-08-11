Return-Path: <linux-kernel+bounces-762600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB01DB208D6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D014D3B3ACC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C7117BEBF;
	Mon, 11 Aug 2025 12:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="Rbxhtke7"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D11130E58
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754915688; cv=none; b=PocdS25kJOoEv8inSRoWvz5zdm8/KzQFFt3+ENxFjn9ojrTCwEyztG25n6Wah2Q3TCdl01we3xWXsRyzbrAkPzBd7O4fUHjh8M9OJHYI0h0x4Lp8ddMT5fmOPQjVJWTCfF0rP9sMIgRadJt0oZXvH1rz9ftt6uRvSB28Fkk5qH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754915688; c=relaxed/simple;
	bh=XPovIlxIpK3Xyq5m0fxGOWM6Yw0u3P4oVgNQIGmTFhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUBDUIrpTMrQdIsT9Wb5HRwVook3c6OrTiOeFVx7u5hMgP3wma4F7niyCH2xeyAo4YoiR57GQe9kHoeFQWWJ8k2tBWPr4PITJsyAPEzdH6Azdl6SU5wYJigiOPqdfH8cj8es3XV0ngagWe1PIMnNl0M2Dyy9v7QRnLJvF6NrKCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=Rbxhtke7; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24022261323so50193285ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 05:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1754915687; x=1755520487; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jnhz3gg9UqvoEaKu6PtG0eWIp3XZKcHUtlBjEIsc8uo=;
        b=Rbxhtke7Do6Ln4tLtq8h1ckX80tU+9AHWKU5Rx/rTnAzIRru4dvk8wYDPfow0gx3wF
         ZXxkylJiiFCeRlF0SP/9RdP0+2bd9JqsNpbXxv7o7KTRRx6OT2fHVEV866luFxX3Lu/M
         wk8+vKfBea78XyvCcEIGZWb+tLPu8bS/ed1u0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754915687; x=1755520487;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jnhz3gg9UqvoEaKu6PtG0eWIp3XZKcHUtlBjEIsc8uo=;
        b=jqX9CWoV2hydriWOkxSsq0ZyuhXw2LzQXzSKbCII11KR48FXSizX6Kf8D7UJcR9R5V
         5PHSylafNzTEkS80qlKaN0toIv+mhPnAjY/MkxdPbCTNv1IrXAlmh1TVduDrGdLxpIic
         FvLTipUL3sSabTOZNPVogZ0vl6vo6FEPf+Ds7esFeEeNE7/5DzIX+xV/0CcvynmtjeeZ
         iKoeI29Kn+lUzKTM48LuQ0xoEcKXW7Vr1nDMhbmNhb8E8Xsnc0kXpWnsQrv0INWetswX
         kg6YdEnXtWRb0BjSAhy+3sj867GGRb+NapKo/DlI1jSqsAYsZqbPTmr1OmE3k6Y7Qfd5
         biTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnFxdBvHd+C5+iZkt5UcOgpEkePSLkYIeD+bxajJBaEJb4YcqhWGr7+IIOgg6KuWqZy0796CXamvLN90Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+e3ZMNkVLxNeYjciFOtsNRG4RJwdE2hmgptBxHQXjaHJx+f5y
	gO5kOHXbxaiuLa5FYlE0qI9uUTe0CbuOtdp6NiknYLhowB/KSII6nBHB4l5vGKoGNcAiqnDr4ga
	7hGNA
X-Gm-Gg: ASbGncs8j9U+Kd+3vXcZd72rBnSM6i49qRBNrTwF5Pt1QtrYL9DSjTkObgSunoCEx6Q
	54KkQ8OrZynJbAo/VS77QeIfCLeO13P2P0j/HyFyEnBtxOOHtU6nov3P8OfQfsqL9D2wJvcKN5L
	7USmcynxVJzH6MsqU+wpoLXqwWWfhdMgnPiA5uU1l0BX+u7/z9szfoNKxr4Cy+O1NZAX6BuIbfG
	CHZzvNqH0i4R2aE5I0VIIBWLEz55fVfLKJ+Elk0kHiBv6QqdTPljTQMdkrDr1ElF8wdko03DUk4
	LEUDo4lSzytobcMLQp46ttEPlFFXe+/Mx8j+HT1jNLj1uVIctYiMSCoBfFxweKAA7I1r+4y4wFS
	EF6is4IhwZvlQmIgE247fdngsX0sp0M5VQhDMZpIfv9F5vI9Y0UF+/4Ar
X-Google-Smtp-Source: AGHT+IHKUm9OnDYHdk/WKwUbriS/iwTepKs5TyQMaFN4XNopewnVVvMHIJNAzd7+96ZNmHDCNZ6O7Q==
X-Received: by 2002:a17:902:f54d:b0:235:e1e4:edb0 with SMTP id d9443c01a7336-242b0792788mr291538425ad.22.1754915686551;
        Mon, 11 Aug 2025 05:34:46 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899adc3sm273742055ad.118.2025.08.11.05.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 05:34:46 -0700 (PDT)
Date: Mon, 11 Aug 2025 21:34:40 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Benno Lossin <lossin@kernel.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Miguel Ojeda <ojeda@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/4] rust: io_uring: introduce rust abstraction
 for io-uring cmd
Message-ID: <aJnjYPAqA6vtn9YH@sidongui-MacBookPro.local>
References: <aJWfl87T3wehIviV@sidongui-MacBookPro.local>
 <DBWX0L4LIOF6.1AVJJV0SMDQ3P@kernel.org>
 <aJXG3wPf9W3usEj2@sidongui-MacBookPro.local>
 <DBXTJQ27RY6K.1R6KUNEXF008N@kernel.org>
 <aJdEbFI2FqSCBt9L@sidongui-MacBookPro.local>
 <DBY6DMQYZ2CL.2P0LZO2HF13MJ@kernel.org>
 <aJijj4kiMV9yxOrM@sidongui-MacBookPro.local>
 <81C84BD8-D99C-4103-A280-CFC71DF58E3B@collabora.com>
 <aJiwrcq9nz0mUqKh@sidongui-MacBookPro.local>
 <DBZ0O49ME4BF.2JFHBZQVPJ4TK@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DBZ0O49ME4BF.2JFHBZQVPJ4TK@kernel.org>

On Sun, Aug 10, 2025 at 10:06:21PM +0200, Benno Lossin wrote:
> On Sun Aug 10, 2025 at 4:46 PM CEST, Sidong Yang wrote:
> > On Sun, Aug 10, 2025 at 11:27:12AM -0300, Daniel Almeida wrote:
> >> > On 10 Aug 2025, at 10:50, Sidong Yang <sidong.yang@furiosa.ai> wrote:
> >> > 
> >> > On Sat, Aug 09, 2025 at 10:22:06PM +0200, Benno Lossin wrote:
> >> >> On Sat Aug 9, 2025 at 2:51 PM CEST, Sidong Yang wrote:
> >> >>> On Sat, Aug 09, 2025 at 12:18:49PM +0200, Benno Lossin wrote:
> >> >>>> We'd need to ensure that `borrow_pdu` can only be called if `store_pdu`
> >> >>>> has been called before. Is there any way we can just ensure that pdu is
> >> >>>> always initialized? Like a callback that's called once, before the value
> >> >>>> is used at all?
> >> >>> 
> >> >>> I've thought about this. As Celab said, returning `&mut MaybeUninit<[u8;32]> is
> >> >>> simple and best. Only driver knows it's initialized. There is no way to
> >> >>> check whether it's initialized with reading the pdu. The best way is to return
> >> >>> `&mut MaybeUninit<[u8;32]>` and driver initializes it in first time. After 
> >> >>> init, driver knows it's guranteed that it's initialized so it could call 
> >> >>> `assume_init_mut()`. And casting to other struct is another problem. The driver
> >> >>> is responsible for determining how to interpret the PDU, whether by using it
> >> >>> directly as a byte array or by performing an unsafe cast to another struct.
> >> >> 
> >> >> But then drivers will have to use `unsafe` & possibly cast the slice to
> >> >> a struct? I think that's bad design since we try to avoid unsafe code in
> >> >> drivers as much as possible. Couldn't we try to ensure from the
> >> >> abstraction side that any time you create such an object, the driver
> >> >> needs to provide the pdu data? Or we could make it implement `Default`
> >> >> and then set it to that before handing it to the driver.
> >> > 
> >> > pdu data is [u8; 32] memory space that driver can borrow. this has two kind of
> >> > issues. The one is that the array is not initialized and another one is it's
> >> > array type that driver should cast it to private data structure unsafely.
> >> > The first one could be resolved with returning `&mut MaybeUninit<>`. And the
> >> > second one, casting issue, is remaining. 
> >> > 
> >> > It seems that we need new unsafe trait like below:
> >> > 
> >> > /// Pdu should be... repr C or transparent, sizeof <= 20
> >> > unsafe trait Pdu: Sized {}
> >> > 
> >> > /// Returning to casted Pdu type T
> >> > pub fn pdu<T: Pdu>(&mut self) -> &mut MaybeUninit<T>
> >> 
> >> Wait, you receive an uninitialized array, and you´re supposed to cast it to
> >> T, is that correct? Because that does not fit the signature above.
> >
> > Sorry if my intent wasn´t clear. More example below:
> >
> > // in rust/kernel/io_uring.rs
> > unsafe trait Pdu: Sized {}
> > pub fn pdu<T: Pdu>(&mut self) -> &mut MaybeUninit<T> {
> >     let inner = unsafe { &mut *self.inner.get() };
> >     let ptr = &raw mut inner.pdu as *mut MaybeUninit<T>; // the cast here
> >     unsafe { &mut *ptr }
> > }
> >
> > // in driver code
> > #[repr(C)] struct MyPdu { value: u64 }
> > unsafe impl Pdu for MyPdu {}
> >
> > // initialize
> > ioucmd.pdu().write(MyPdu { value: 1 });
> >
> > // read or modify
> > let mypdu = unsafe { ioucmd.pdu().assume_init_mut() };
> 
> This is the kind of code I'd like to avoid, since it plans to use
> `unsafe` in driver code (the `unsafe impl` above is also a problem, but
> we can solve that with a derive macro).
> 
> Where are the entrypoints for `IoUringCmd` for driver code? I imagine
> that there is some kind of a driver callback (like `probe`, `open` etc)
> that contains an `Pin<&mut IoUringCmd>` as an argument, right? When is
> it created, can we control that & just write some default value to the
> pdu field?

There is `uring_cmd` callback in `file_operation` at c side. `Pin<&mut IoUringCmd>`
would be create in the callback function. But the callback function could be
called repeatedly with same `io_uring_cmd` instance as far as I know.

But in c side, there is initialization step `io_uring_cmd_prep()`.
How about fill zero pdu in `io_uring_cmd_prep()`? And we could assign a byte
as flag in pdu for checking initialized also we should provide 31 bytes except
a byte for the flag.

Thanks,
Sidong
> 
> ---
> Cheers,
> Benno

