Return-Path: <linux-kernel+bounces-764740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 358F9B226A5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95DF2505219
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14421A3155;
	Tue, 12 Aug 2025 12:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="LEUrQJQu"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2E81885AB
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 12:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755001179; cv=none; b=ulb/pZcUp4EU7xpX3KOT8Z4ZoEsnek0lFHqbATSY0tk1L95BcXgQWM55880POUOpsVO47pyrwcMb2mNkTGxbP9ZVwUvswNRqb3E1o5yPdElPrjtAyuZZKo5fuKBVTtZ87F45510XaDkYmot05BQRWWAH8jY+USNKoR5qPZS8UAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755001179; c=relaxed/simple;
	bh=DO2hOpqceDHGa1aberEVvfFqSZmCuI5QPRwo4mV4UKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVkGUnFVQwBbP/gZnzJ9RB+HOCMk3f/1EUvNn3W5tvJWCSy8nZJSWrFlpP9NiOlAQeMSSO/Vztq85bkKiGH3Zhqvv4Hb117bqNB780TARwDQyRQCcm0uU3PJ2oLMXlm+Up4JtHcq1gnuGuCeQVxnoWNO1YO2cHJUvoXwx24i5U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=LEUrQJQu; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-321a5d6d301so1618536a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1755001177; x=1755605977; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0WtrPdFclzyky29znvflcoUgELQSFsAMKkPJYvWhod4=;
        b=LEUrQJQuHSL7OJHtUJq7cUS5FdyvOoaZS2JFVGpF7gOU/GzRLwpFY9smHa2m3JeXoy
         dSxRcYYlHFzTjni5ZYjRyYkJQW/3/Xvu1aaAaK+YdOQh+hsJFP91OB+ptSgU+P2eG6p6
         ijVxeblf42aX6SM8gFZbO2IzcKWHWo3lslN5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755001177; x=1755605977;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0WtrPdFclzyky29znvflcoUgELQSFsAMKkPJYvWhod4=;
        b=nwm8zAoKp7IW2RrxLObh645OLXjQPKAAbxyaN6nIBK8NWRz3bCbIYgH/5l0pSiNkPm
         +j/cC6w+R4WQyk6mMHm234lpkW/FkuWdDGO4viPqynFyMPnXhuyWQqpEfSNpwtmiQfRA
         3KAhun4CwSvSfZwO4HSSyqirjwb8h5Kj1WGP1qDeETOHqgFoJfv9EirYeqXotligEB5q
         yQh75fmaWC4RhsBW9QKCfZdYAH9qPDHqCuJDeHZRIRYR35qxL2YFfy3uZlgJYGUHYeZm
         k07qQIZtQ+2gQUxxPsO6LO9BoxyOXzaVOVQgRq0GzwFXsFDz74gdcNVFXXe9Kt4OaFsQ
         gDVg==
X-Forwarded-Encrypted: i=1; AJvYcCXxPaUpY4VM8LXeCGIDuH57i1f1Gv6eF7TqJWuT1GNY/8VHQjuo6RTLBC0i83K7hZccZNBqy0NrX/3BLoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ4CXyMbWuGZysZnAdBqEegL65tuFaxljUSCrqOgB6R9tejsrU
	YX777kWojntmZCbDeeVxVpQt+qIVIS8F8aLds/9jIIe8bu8lkG3YgqAONLhVfvhh4/k=
X-Gm-Gg: ASbGncvjJ15DpiQhuutoWm0PngnGRmT3XAumgMqKXY4YNGLBj82d/Wt6uwRFwK/xWGl
	1ku6FNxtSdt+917Avlcq8m2HZSq3PKtWq0K5Jp8TvaVSGeTHLnwGVEuKJANVkv7KDkyNxz7SsoO
	qrKGIMuTCGw7w2+TOzofqtIhHw4WKL3siTlwjbw/GbMkblrAKgBL1hrhvnkZCDk4b2M7NHT1Xg1
	WQ/IXLcLztIH+9+t5jqlBL4cs69z6jKHer5OoyZ3HAIRiSzc6mddA+dSbFDN3rsTqw60UHhmbMN
	y5CZxRpxdo8vUNpfumiC/9TNtV7C8/K6xpuaBBSbaZtNglERfHtEr2xMid7XkbAKSEn/prIlibh
	2+5GuN9IRlATd1t6gxr537FaunP0SuG/2g4pqS9e+t5A+6vzbj4Tv3/wk
X-Google-Smtp-Source: AGHT+IGIpo0Z7v2fqEAJrnogogtfT2bJ1aJfSHElMkCVD8SyNbyvOMbAMybK7ab5ReG2rDBpbQNOJg==
X-Received: by 2002:a17:90b:584f:b0:312:ffdc:42b2 with SMTP id 98e67ed59e1d1-32183c43e3cmr20797155a91.23.1755001177078;
        Tue, 12 Aug 2025 05:19:37 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b435a19a01asm7699444a12.17.2025.08.12.05.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 05:19:36 -0700 (PDT)
Date: Tue, 12 Aug 2025 21:19:30 +0900
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
Message-ID: <aJsxUpWXu6phEMLR@sidongui-MacBookPro.local>
References: <aJdEbFI2FqSCBt9L@sidongui-MacBookPro.local>
 <DBY6DMQYZ2CL.2P0LZO2HF13MJ@kernel.org>
 <aJijj4kiMV9yxOrM@sidongui-MacBookPro.local>
 <81C84BD8-D99C-4103-A280-CFC71DF58E3B@collabora.com>
 <aJiwrcq9nz0mUqKh@sidongui-MacBookPro.local>
 <DBZ0O49ME4BF.2JFHBZQVPJ4TK@kernel.org>
 <aJnjYPAqA6vtn9YH@sidongui-MacBookPro.local>
 <8416C381-A654-41D4-A731-323CEDE58BB1@collabora.com>
 <aJoDTDwkoj50eKBX@sidongui-MacBookPro.local>
 <DC0B7TRVRFMY.29LDRJOU3WJY2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DC0B7TRVRFMY.29LDRJOU3WJY2@kernel.org>

On Tue, Aug 12, 2025 at 10:34:56AM +0200, Benno Lossin wrote:
> On Mon Aug 11, 2025 at 4:50 PM CEST, Sidong Yang wrote:
> > On Mon, Aug 11, 2025 at 09:44:22AM -0300, Daniel Almeida wrote:
> >> > There is `uring_cmd` callback in `file_operation` at c side. `Pin<&mut IoUringCmd>`
> >> > would be create in the callback function. But the callback function could be
> >> > called repeatedly with same `io_uring_cmd` instance as far as I know.
> >> > 
> >> > But in c side, there is initialization step `io_uring_cmd_prep()`.
> >> > How about fill zero pdu in `io_uring_cmd_prep()`? And we could assign a byte
> >> > as flag in pdu for checking initialized also we should provide 31 bytes except
> >> > a byte for the flag.
> >> > 
> >> 
> >> That was a follow-up question of mine. Can´t we enforce zero-initialization
> >> in C to get rid of this MaybeUninit? Uninitialized data is just bad in general.
> >> 
> >> Hopefully this can be done as you've described above, but I don't want to over
> >> extend my opinion on something I know nothing about.
> >
> > I need to add a commit that initialize pdu in prep step in next version. 
> > I'd like to get a comment from io_uring maintainer Jens. Thanks.
> >
> > If we could initialize (filling zero) in prep step, How about casting issue?
> > Driver still needs to cast array to its private struct in unsafe?
> 
> We still would have the casting issue.
> 
> Can't we do the following:
> 
> * Add a new associated type to `MiscDevice` called `IoUringPdu` that
>   has to implement `Default` and have a size of at most 32 bytes.
> * make `IoUringCmd` generic
> * make `MiscDevice::uring_cmd` take `Pin<&mut IoUringCmd<Self::IoUringPdu>>`
> * initialize the private data to be `IoUringPdu::default()` when we
>   create the `IoUringCmd` object.

`uring_cmd` could be called multiple times. So we can't initialize
in that time. I don't understand that how can we cast [u8; 32] to
`IoUringPdu` safely. It seems that casting can't help to use unsafe.
I think best way is that just return zerod `&mut [u8; 32]` and
each driver implements safe serde logic for its private data. 

> * provide a `fn pdu(&mut self) -> &mut Pdu` on `IoUringPdu<Pdu>`.
> 
> Any thoughts? If we don't want to add a new associated type to
> `MiscDevice` (because not everyone has to declare the `IoUringCmd`
> data), I have a small trait dance that we can do to avoid that:
> 
>     pub trait IoUringMiscDevice: MiscDevice {
>         type IoUringPdu: Default; // missing the 32 byte constraint
>     }
> 
> and then in MiscDevice we still add this function:
> 
>         fn uring_cmd(
>             _device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
>             _io_uring_cmd: Pin<&mut IoUringCmd<Self::IoUringPdu>>,
>             _issue_flags: u32,
>         ) -> Result<i32>
>         where
>             Self: IoUringMiscDevice,
>         {
>             build_error!(VTABLE_DEFAULT_ERROR)
>         }
> 
> It can only be called when the user also implements `IoUringMiscDevice`.
> 
> ---
> Cheers,
> Benno

