Return-Path: <linux-kernel+bounces-828917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C50D6B95D81
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B0C73A9905
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EB032340C;
	Tue, 23 Sep 2025 12:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JVZ1vwOg"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3FB2F6576
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 12:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758630558; cv=none; b=UEPYnOkLmv2rzX/0x8Z1h9dy0WA63YqOYrQU2RgKzUl9CVNotk3x+/ZJfumY2dTgN7bGHwPEYGLqQNiKCrIXsVixNT2XUzrUC2jTTmAYgWEPgRnSUPHupmoFa6+ZVfTsj8at4eTcL2ZwUVVmVgxwYZZ8e9gNe86E3ilxpbP8DWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758630558; c=relaxed/simple;
	bh=b0629hWOk++FdHoGQx4DsyToXSGFO5l7TnIod+y+aY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PrPg985Ffr9SoW89TKhFDrLPPDMsbpoSwgIAttdqDUCRUWseXqaQDEy2ddW6a6z1WLuyk800pGDrcGA0cqpX+Atipb5NYYGLbMNwHco2OPySYLDrsIIU2z/YfYP5CsgxsZ9uFkO3C0qsqLuxw7Yf1YLqfB83gPbRZKShpMcytQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JVZ1vwOg; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-267f0fe72a1so38618895ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 05:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758630556; x=1759235356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VpjVEQ5z5WVH3TKN5mD9AEhTYjfuhAvILNbJny3GS3U=;
        b=JVZ1vwOgBq4aQIkufGPj9BPA4DX4fDTX6z0FXBLbfGLj7tEPy5Y7YRwYn62xshYR7G
         vDNx9PCicakczMjeNngLjbgsAtp2l286ueNzFFXUkr2LhkaCkQPVeCuc2WLgCTnBDnPs
         sLxas/73RnrE9QklUW9eKo3RUDxJ2EBpBebO60D9SNm6qbap8TIZou84+OUD81vj6j/q
         cs1bLkoi699hSkdUjxn645ANmxuG7iSu2YOaS557DqrHEnkte3a21V8tcxfxic0HjF1c
         oijrG07AX8Ib75jBDj6f1QK0bouDCLRfVsIETAgOo6W7d7ZqerPDlc2cp7D7RznK5elx
         Sm7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758630556; x=1759235356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VpjVEQ5z5WVH3TKN5mD9AEhTYjfuhAvILNbJny3GS3U=;
        b=XVYUQNUh5v2rLIC+VmhYq7297jZjJ9yyM32jByS1eUazGY2X/XQGENDqwjsoh/Tu4H
         XYPfmIgedYl400DcUjvFLiZRyqopOIM6e0tx227gM1hLKJCBsA1XmpkWStMFHeVXXw6e
         xPlivZkUSN/CkoOf7JscKd/aPO1y8KMX9YPcrfzQo6XcQTwBp3FjcyCP0MO/7/9N6Ghm
         6e82TUX6Gk+hTEAisEnSXJcMIdP7OgowwlvWIulb9gJ1paiUGl9l+Y6jdxVeQ3P9Np6y
         29PQbi5DAONnTAMYTaxNswYqlDRR396WQStumkBNSMPer/IaN5K/e2mDmi2uS0SeiBKv
         MIAg==
X-Forwarded-Encrypted: i=1; AJvYcCX7dP2giE0RmYALwu4SYSM4ICnmpwUoUnqqN8uNlzDVFdHDm55hjgdRXXE8dndKfjUcThXtjCRxYzsm02I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzimbTl6NNtQqVakXkwFlpjiHW6WJRf1ntviO7J2PzJT2bU4L2B
	M/gP7m6m/8oaX4pUs5wldExyW2yh6LRp93O2wKQ73muZWs0JAwZ9/YbJg4YAXdPJkU+LzXZk+28
	mhAFUgjhN3metYZWgDlwvuTGDOGEom2p72N821+B/
X-Gm-Gg: ASbGncuooWbdzB1GH5rsKgcxrRMU/xrAuaJqR/Iev0EaUv8mjsy6b2GaJ00i89pKw5k
	AOeAywSthLCl4xdtxCTfE0RjSS6X7Z/xJ2EQjP3A5Hxxk0ZxzofG+ihPwpBINJLYGjd2Bs0PVuf
	wmlhtFdci31LapMK1ptW0EPQfqgfZiL26FQtv/5N8OqmHEqmPkfieXQSpmZypd9uXKfIScYpo3c
	MY5Ft1J6DArIg==
X-Google-Smtp-Source: AGHT+IHyp6poHtnMpA3kzSW7rSWviqzVVOw3NeVKRaOQ4IW3iAH826ZyVeXOg7aqveIlnS65wQjOHr5bvn7xKJPvUR4=
X-Received: by 2002:a17:902:ea07:b0:266:64b7:6e38 with SMTP id
 d9443c01a7336-27cc5de11bdmr33567235ad.46.1758630556307; Tue, 23 Sep 2025
 05:29:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com> <2025092338-elbow-dash-373d@gregkh>
In-Reply-To: <2025092338-elbow-dash-373d@gregkh>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 23 Sep 2025 14:29:00 +0200
X-Gm-Features: AS18NWB7QE1N4rYqtAdt4Gmw5zNv1gca0xZBJ6E4G4ribW07_KnqBaVHkfkD8kk
Message-ID: <CAH5fLghm-syjWRrj=G2==W4PorPq47bkAPfkeJ1UAsGbbRhPfQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] rust: usb: add initial USB abstractions
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 2:05=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Aug 25, 2025 at 03:18:04PM -0300, Daniel Almeida wrote:
> > This adds initial support for USB Rust drivers, not only because I see =
a
> > widespread use of module_usb_driver() in media (which is a subsystem I
> > aim to support) but also because I want to learn about USB in general
> > and this is a nice opportunity to start doing so.
> >
> > I tried to keep things as consistent with pci.rs and platform.rs as
> > possible and tested it by manually binding a device (i.e.: my Logitech
> > mouse) to the sample driver via:
> >
> > /sys/bus/usb/drivers/rust_driver_usb/new_id
> >
> > This initial patch is therefore comprised of the same patterns that are
> > known to work for pci and platform already.
> >
> > Physically disconnecting the device also worked, i.e.: nothing bad
> > showed up in dmesg.
> >
> > Note that I did not touch MAINTAINERS at all. The objective is to
> > kickstart the discussion of what to do there here in v1.
>
> I tried to apply these, but I get the following build error when adding
> to the char-misc-testing tree:
>
> ld.lld: error: undefined symbol: usb_get_intf
> >>> referenced by kernel.1a949e63ee2acc6a-cgu.0
> >>>               rust/kernel.o:(<kernel::usb::Interface as kernel::sync:=
:aref::AlwaysRefCounted>::inc_ref) in archive vmlinux.a
> >>> referenced by kernel.1a949e63ee2acc6a-cgu.0
> >>>               rust/kernel.o:(<kernel::sync::aref::ARef<kernel::usb::I=
nterface> as core::convert::From<&kernel::usb::Interface<kernel::device::Co=
reInternal>>>::from) in archive vmlinux.a
>
> ld.lld: error: undefined symbol: usb_put_intf
> >>> referenced by kernel.1a949e63ee2acc6a-cgu.0
> >>>               rust/kernel.o:(<kernel::usb::Interface as kernel::sync:=
:aref::AlwaysRefCounted>::dec_ref) in archive vmlinux.a
>
> ld.lld: error: undefined symbol: usb_get_dev
> >>> referenced by kernel.1a949e63ee2acc6a-cgu.0
> >>>               rust/kernel.o:(<kernel::usb::Device as kernel::sync::ar=
ef::AlwaysRefCounted>::inc_ref) in archive vmlinux.a
> >>> referenced by kernel.1a949e63ee2acc6a-cgu.0
> >>>               rust/kernel.o:(<kernel::sync::aref::ARef<kernel::usb::D=
evice> as core::convert::From<&kernel::usb::Device<kernel::device::CoreInte=
rnal>>>::from) in archive vmlinux.a
>
> ld.lld: error: undefined symbol: usb_put_dev
> >>> referenced by kernel.1a949e63ee2acc6a-cgu.0
> >>>               rust/kernel.o:(<kernel::usb::Device as kernel::sync::ar=
ef::AlwaysRefCounted>::dec_ref) in archive vmlinux.a
>
>
> Any hints?

Did you enable CONFIG_USB?

Alice

