Return-Path: <linux-kernel+bounces-738700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D9EB0BC12
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 07:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A12133B02D2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 05:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A7F21ABAE;
	Mon, 21 Jul 2025 05:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="EqG9bz1o"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960991DACA7
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 05:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753076574; cv=none; b=eXvU74p9uHykUNRAcB9TWs7cHrIntrSR8EnsE64112ZR3+bA6t8q/Y3z0CuGMC/qo9OiotI0MVa6aNpaHSu7Krqrq7g4AzrmVe8Db5HaeuzouS0CXC0Gz1xo1fMxVTpeU2v4cZLukpfEM8nP3ubUD2mIrkBM7kRIW2M85IMkL4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753076574; c=relaxed/simple;
	bh=JrKcpk3Qj3IVMgAVLgxJUQFX8REPMADjoTMxMUlt74E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUM6vpdLDBahQftt+omING7Vg7cPo6jb3zI/ZkAvJPqGpotwdCsEqtyUdshqfckoWnDmrNdij+hD6r8wlHrj5WtWMQhkODmbnRZpCi5XFL8BNspa+NcN3lbWIlrp22P67tczGwmhZ6vy20M4O1ADMbhnFj08qUb+frDPIx93HC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=EqG9bz1o; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b390136ed88so2485109a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 22:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1753076573; x=1753681373; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OINyTmS0kTaq+9cL6TTezFQf3vvpNluR/qiFYj4mJCI=;
        b=EqG9bz1oWKHBTxcFcsD2oIKa6R7rBT5gGBsj0YVI+vYbhosis5JTTyEsUeKSp7m/Lc
         eAoHwq+DVxTDNeff8ka8tHYm8P6d+AXusbecLyzKlKJ1PZNfRHueLs97lLU/bRXFwCBe
         /DH6rcQnfreNL4KgDnHF/xcqo73Vn1KByd/o4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753076573; x=1753681373;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OINyTmS0kTaq+9cL6TTezFQf3vvpNluR/qiFYj4mJCI=;
        b=O3cLHbgzehIB4Ey+xbyrvkRuCTE5mliCYa2WbguBRxhhGkX8qFxTtgtS2enHfFuMs9
         8a8D1JMhiqsTKtuieqptgQsezr9WKznYPfC7qz/7SN/3CdG51unft9Ou+UrGMYCyBLiy
         CjLFmDCj+h7LxkdffjJfi62w4IIRFgu17N+Kx72cKBDuCMDOpuQ0JghQQVaqNMA2jndR
         hO43wYA/mLrw8CpM7YxmEEsEUTsn2hKX0lTPFUrbSBPQLe6AI/7f8mUrkEfBgc1wxB20
         w90EZDZeqxOnj+bcYdaMLeosHrSAkQq3CMW0B411lQD3ffXOpoxzX6FjP41260zldY0q
         /hvg==
X-Forwarded-Encrypted: i=1; AJvYcCX+ue8KRCHgzibAZjrKJqe9fAdL2hueMxHSDrgcvpsRVb19lft3rnXilxVnxCoIY/d8Z5ycTDwfJpdbAN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn8PN4FNqNw3IYe+L13FJAtTX8SgmsKxHENLPXLiDDg0pamIwP
	GQdt3wIRR5048l4dr+mtkjECxk2tPCNxEReAYzd0oDTPpQuHAbBJHbAYO8q4DRMKvzI=
X-Gm-Gg: ASbGncuYq6KqbTIjLoZFDICA7936AU2kzRuTWEdxoq7UOWGO3qSRwCioX01aw+bk/qF
	zA9iJoNW19tise5bVA/gkyN/nNUetgQUkHYxyuJrYJVO7P3PNw6ju+rBCeuF3FINlmz/O9YAhtd
	aBK23l/Xqzzc1lxQoZwGDHmTGWe+MC4zvslUGAw5gyzH5qRuwbfbiKLE48fVs6b+1S1LYWEe1F4
	/vKM8XwOAwr/Y6jrial8g/GJWZYTjRDKUO1dg1p+xOT3Xn0Kon3H7znq1tFgZ++9s8leTK51uY4
	rIHNcgWckX4pl5url1VZIDj9/u8FMtTIif7oKtFGhOWoDvQIOJHw5kABuXouT0HwALPnWA0HB9b
	ErUoxT6xKxXLeJrXwjyYd3NNbIyk4Uw8DVNmN7zvt8BKE27oym+V5Rw==
X-Google-Smtp-Source: AGHT+IHtO0lcTnjLg7RoB8oempV8RRmalCV8Gc4fgDN+BPSBAehU6IhbE6a83mK5rPASvrdvcGJqIg==
X-Received: by 2002:a17:902:e949:b0:237:d734:5642 with SMTP id d9443c01a7336-23e3b84f73emr154394105ad.41.1753076572632;
        Sun, 20 Jul 2025 22:42:52 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([221.148.76.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6ef82esm49929675ad.209.2025.07.20.22.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 22:42:52 -0700 (PDT)
Date: Mon, 21 Jul 2025 14:42:47 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jens Axboe <axboe@kernel.dk>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [PATCH 3/4] rust: miscdevice: add uring_cmd() for MiscDevice
 trait
Message-ID: <aH3TVzxTlTUaDQXp@sidongui-MacBookPro.local>
References: <20250719143358.22363-1-sidong.yang@furiosa.ai>
 <20250719143358.22363-4-sidong.yang@furiosa.ai>
 <CADUfDZpmD-WfVsrzNOt6T6132M+EHCGtRcnQH7p0z2f3f6dBvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZpmD-WfVsrzNOt6T6132M+EHCGtRcnQH7p0z2f3f6dBvw@mail.gmail.com>

On Sun, Jul 20, 2025 at 04:08:19PM -0400, Caleb Sander Mateos wrote:
> On Sat, Jul 19, 2025 at 10:35 AM Sidong Yang <sidong.yang@furiosa.ai> wrote:
> >
> > This patch adds uring_cmd() function for MiscDevice trait and its
> > callback implementation. It uses IoUringCmd that io_uring_cmd rust
> > abstraction.
> >
> > Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
> > ---
> >  rust/kernel/miscdevice.rs | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >
> > diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
> > index 288f40e79906..5255faf27934 100644
> > --- a/rust/kernel/miscdevice.rs
> > +++ b/rust/kernel/miscdevice.rs
> > @@ -14,6 +14,7 @@
> >      error::{to_result, Error, Result, VTABLE_DEFAULT_ERROR},
> >      ffi::{c_int, c_long, c_uint, c_ulong},
> >      fs::File,
> > +    io_uring::IoUringCmd,
> >      mm::virt::VmaNew,
> >      prelude::*,
> >      seq_file::SeqFile,
> > @@ -175,6 +176,15 @@ fn show_fdinfo(
> >      ) {
> >          build_error!(VTABLE_DEFAULT_ERROR)
> >      }
> > +
> > +    fn uring_cmd(
> > +        _device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
> > +        _file: &File,
> > +        _io_uring_cmd: &IoUringCmd,
> > +        issue_flags: u32,
> > +    ) -> Result<isize> {
> 
> Would i32 make more sense as the return value, since that's what
> io_uring_cqe actually stores?

Agreed. thanks.
> 
> > +        build_error!(VTABLE_DEFAULT_ERROR)
> > +    }
> >  }
> >
> >  /// A vtable for the file operations of a Rust miscdevice.
> > @@ -332,6 +342,25 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
> >          T::show_fdinfo(device, m, file);
> >      }
> >
> > +    unsafe extern "C" fn uring_cmd(
> > +        ioucmd: *mut bindings::io_uring_cmd,
> > +        issue_flags: ffi::c_uint,
> > +    ) -> ffi::c_int {
> > +        // SAFETY: The file is valid for the duration of this call.
> > +        let ioucmd = unsafe { IoUringCmd::from_raw(ioucmd) };
> > +        let file = ioucmd.file();
> > +
> > +        // SAFETY: The file is valid for the duration of this call.
> > +        let private = unsafe { (*file.as_ptr()).private_data }.cast();
> > +        // SAFETY: Ioctl calls can borrow the private data of the file.
> 
> "Ioctl" -> "uring cmd"?

Thanks it's a bad mistake.

Thanks,
Sidong
> 
> Best,
> Caleb
> 
> > +        let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
> > +
> > +        match T::uring_cmd(device, file, ioucmd, issue_flags) {
> > +            Ok(ret) => ret as ffi::c_int,
> > +            Err(err) => err.to_errno() as ffi::c_int,
> > +        }
> > +    }
> > +
> >      const VTABLE: bindings::file_operations = bindings::file_operations {
> >          open: Some(Self::open),
> >          release: Some(Self::release),
> > @@ -354,6 +383,11 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
> >          } else {
> >              None
> >          },
> > +        uring_cmd: if T::HAS_URING_CMD {
> > +            Some(Self::uring_cmd)
> > +        } else {
> > +            None
> > +        },
> >          // SAFETY: All zeros is a valid value for `bindings::file_operations`.
> >          ..unsafe { MaybeUninit::zeroed().assume_init() }
> >      };
> > --
> > 2.43.0
> >
> >

