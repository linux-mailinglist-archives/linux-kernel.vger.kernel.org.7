Return-Path: <linux-kernel+bounces-785551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1242EB34D75
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 23:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D78632082FC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 21:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C4529AAFA;
	Mon, 25 Aug 2025 21:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="jtic36Cv"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F066928F1;
	Mon, 25 Aug 2025 21:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756155878; cv=pass; b=OwqT2kSxPNOYrCLAtQzC2a3RNshGzAe5gIETPD8yvAqOsRxFLeRsanUkMZw4VLoCNwEaQcYz2SQPE+1Fcc0/REC5C3tBBprtHFZHnEUoyQZb0e/Kc8y3oZxBecrkxv6E72O+or55H4fcqX4orH7VTvNS5Ne84FfLIetOllZZrKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756155878; c=relaxed/simple;
	bh=b37jhv+kGMI15914BeD2tiD8jn0xOmD1cJ6McU6fLsA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=HgoqvvJ/mtlXy8XLsKFXkJUuGwXg+rGq11RxviEw5kGuKxqAScQj/0FSySiFDpU6ZmrGOHF4dRHCe6MiikrQLMkXk9nuuC1b1LVX22d1ah7dEAtmUTy23+9Cqy8fFWXSGHWTuR13u7m1uGXhcOsTeblSXxQwQzR4YylLQ5YsLPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=jtic36Cv; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756155859; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Jb/C7ul2FX6aDzriINIjzgOoTSyEO62ELGIz6Mw5McNJG32l0ilCy3jh8XcG1xqUOKRU5izgB9JAtunlrs7+n1RLlHceVP1TGztdbN2ZSaZze+K3Hj0ZBFVSqmQczv+PQw2WRaeWcx3ym5F8xamjGw+ViTXlomcG4ylZ9XQrqBs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756155859; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=aQZ34qMB2MkZ3sj3Nimg7SXXJ98jUa07zNRI6NcIVCk=; 
	b=jNpyRGLrxIikLT3DMxhBKlHqefZQpV1zXMwTlzxgKifX2VORTrVCwQFRSsaWgpuJaSLwQmJpPCv0e1CqLgEVY8t//0OskLT0ovjDUxTbYh92FgMO/wiinAB97x9jO3KfkZb7t7/JVcQjwdcIJ3kEq9amb5n2SXLkwf0nmXuSWHQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756155859;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=aQZ34qMB2MkZ3sj3Nimg7SXXJ98jUa07zNRI6NcIVCk=;
	b=jtic36CvGS09Eq7xfx2oNuKDlcInTZxL7w/UGpraRxadqCWjZKDw7p+igSx2X98C
	GZUgH6YyuRWJk4quM0gZaYb8G4KeR1koMudQdfGr74mNRNTn+B6n89T37ifUTBO0guA
	wn8NssZ78mO72MChLfSHjDQw/o692hY8A2eypCwM=
Received: by mx.zohomail.com with SMTPS id 1756155856444766.20600042314;
	Mon, 25 Aug 2025 14:04:16 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 1/2] rust: usb: add basic USB abstractions
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <DCBSZC9IDT4L.SPHF4KVM5KEW@kernel.org>
Date: Mon, 25 Aug 2025 18:03:59 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-usb@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6FFC1A6F-D403-4BCC-9B0C-CD05A07B9923@collabora.com>
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
 <20250825-b4-usb-v1-1-7aa024de7ae8@collabora.com>
 <DCBSZC9IDT4L.SPHF4KVM5KEW@kernel.org>
To: Benno Lossin <lossin@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hi Benno,

> On 25 Aug 2025, at 17:49, Benno Lossin <lossin@kernel.org> wrote:
>=20
> On Mon Aug 25, 2025 at 8:18 PM CEST, Daniel Almeida wrote:
>> +impl DeviceId {
>> +    /// Equivalent to C's `USB_DEVICE` macro.
>> +    pub const fn from_id(vendor: u16, product: u16) -> Self {
>> +        Self(bindings::usb_device_id {
>> +            match_flags: bindings::USB_DEVICE_ID_MATCH_DEVICE as =
u16,
>> +            idVendor: vendor,
>> +            idProduct: product,
>> +            // SAFETY: It is safe to use all zeroes for the other =
fields of `usb_device_id`.
>> +            ..unsafe { MaybeUninit::zeroed().assume_init() }
>=20
> You can avoid this usage of `unsafe` with this patch series:
>=20
>    =
https://lore.kernel.org/all/20250814093046.2071971-1-lossin@kernel.org
>=20
> I'd like to avoid introducing any new one of these.
>=20
> ---
> Cheers,
> Benno
>=20
>> +        })
>> +    }
>=20

Ah, nice, you spoke about this in the last RFL call, I remember it now.

Ok, I will address this in the next version.

=E2=80=94 Daniel=

