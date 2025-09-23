Return-Path: <linux-kernel+bounces-828919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EA6B95DA5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 552707AD128
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F51323418;
	Tue, 23 Sep 2025 12:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="hjpwMmZY"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20B2946A;
	Tue, 23 Sep 2025 12:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758630905; cv=pass; b=W/FrFgO7CL0lmtb9owyssexv5w7y00QY8NGtT11hd9Kv7z02CFkcNOfyhmrrWIRsDyyTGZDyolvYz9HMjamaASFF0e5LNueBCBrHDueMNjJSKZqX1MV9AYg5L6Tzzg1sVaWQcq9e2ITerEFkoyybK6uJ+dt3pSuD7sFUTcPvwmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758630905; c=relaxed/simple;
	bh=sHemU9oAjvPnUJ8EsDfTv+/0D4+bWZwCTfsoU89CoTc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CO3HK+rbWQt9n94mEAJ+Jq2j6O+cDBht1ypIQ4aL2ziCSJImuRCl0FdsibHZcJHk3axJczl5b4ZmNHUnWKxve2p/EyHCw0Z0xzmqg40SasxTUxLgR8DKrmbwIahJgW9OC5WgENAo1HI+pTq5D+D3ROr+2XUevJ8lCMQzrweJvtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=hjpwMmZY; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758630884; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nRap8WPhk31E8VLE9F92eAjJNmFuvWGXpilMzOFJn1z1O6nQunx5H4TQUG6KXNCqo5uzkP3iQ5oUTM2JzDuLdespi66NphBmlJhxqyxlzUugsWH3XtB9LZ3CowledbJsRjRNGgzWQ/6BXD9iq5oZytZ+3ylkpaDbegw2MKA75lo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758630884; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dwjaDadXsKJkC8djtVlWDKTcSoQPetnpTd2zWoSAkak=; 
	b=EMXYgDOmZGa95jD58te4pnP9mIHEr6A8qMyOeWJ24/NhkocmQ2sVECOYR90lFD455N0WKNLlTthtMRQje8oW4OnZmu5KleEaWue/xBswrbLqkJjeN3gBiFAGwfBNPVJiY9exW9gd5G8x9LGTcGH/2wC1/tc6v5LBUeAIlQr3aDQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758630884;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=dwjaDadXsKJkC8djtVlWDKTcSoQPetnpTd2zWoSAkak=;
	b=hjpwMmZYx+2TjiN2sLV4Uk2t+RNCSrQABZuGZ90PRG5CA2uyqhn+KD6nLczjqbs8
	bLQrvgofRzJwipveTsRJq5/gmbyJw6f9GbeRg46m0gzDHT9BUBcW+jAfMWOwOKE/hHO
	XHb67x4OP3LWeN6zfsg0fYBBune/twbFAa4/55KI=
Received: by mx.zohomail.com with SMTPS id 1758630883193557.3474373039268;
	Tue, 23 Sep 2025 05:34:43 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 0/2] rust: usb: add initial USB abstractions
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <CAH5fLghm-syjWRrj=G2==W4PorPq47bkAPfkeJ1UAsGbbRhPfQ@mail.gmail.com>
Date: Tue, 23 Sep 2025 14:34:27 +0200
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-usb@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B4D07104-0A10-4B04-88CC-3F138A783811@collabora.com>
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
 <2025092338-elbow-dash-373d@gregkh>
 <CAH5fLghm-syjWRrj=G2==W4PorPq47bkAPfkeJ1UAsGbbRhPfQ@mail.gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

[=E2=80=A6]

>>=20
>> I tried to apply these, but I get the following build error when =
adding
>> to the char-misc-testing tree:
>>=20
>> ld.lld: error: undefined symbol: usb_get_intf
>>>>> referenced by kernel.1a949e63ee2acc6a-cgu.0
>>>>>              rust/kernel.o:(<kernel::usb::Interface as =
kernel::sync::aref::AlwaysRefCounted>::inc_ref) in archive vmlinux.a
>>>>> referenced by kernel.1a949e63ee2acc6a-cgu.0
>>>>>              =
rust/kernel.o:(<kernel::sync::aref::ARef<kernel::usb::Interface> as =
core::convert::From<&kernel::usb::Interface<kernel::device::CoreInternal>>=
>::from) in archive vmlinux.a
>>=20
>> ld.lld: error: undefined symbol: usb_put_intf
>>>>> referenced by kernel.1a949e63ee2acc6a-cgu.0
>>>>>              rust/kernel.o:(<kernel::usb::Interface as =
kernel::sync::aref::AlwaysRefCounted>::dec_ref) in archive vmlinux.a
>>=20
>> ld.lld: error: undefined symbol: usb_get_dev
>>>>> referenced by kernel.1a949e63ee2acc6a-cgu.0
>>>>>              rust/kernel.o:(<kernel::usb::Device as =
kernel::sync::aref::AlwaysRefCounted>::inc_ref) in archive vmlinux.a
>>>>> referenced by kernel.1a949e63ee2acc6a-cgu.0
>>>>>              =
rust/kernel.o:(<kernel::sync::aref::ARef<kernel::usb::Device> as =
core::convert::From<&kernel::usb::Device<kernel::device::CoreInternal>>>::=
from) in archive vmlinux.a
>>=20
>> ld.lld: error: undefined symbol: usb_put_dev
>>>>> referenced by kernel.1a949e63ee2acc6a-cgu.0
>>>>>              rust/kernel.o:(<kernel::usb::Device as =
kernel::sync::aref::AlwaysRefCounted>::dec_ref) in archive vmlinux.a
>>=20
>>=20
>> Any hints?
>=20
> Did you enable CONFIG_USB?
>=20
> Alice

+#[cfg(CONFIG_USB)]
+pub mod usb;

Hmm, but the USB module is gated by #[cfg(CONFIG_USB) in lib.rs, so not =
having
CONFIG_USB enabled should not return any errors and instead skip the USB
bindings completely.

I wonder if this has to be CONFIG_USB=3Dy?

=E2=80=94 Daniel


