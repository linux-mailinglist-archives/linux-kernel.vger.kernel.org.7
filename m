Return-Path: <linux-kernel+bounces-736898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA983B0A4DD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 965F4AA0B17
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 13:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFE52DC327;
	Fri, 18 Jul 2025 13:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="UozkiPgl"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E22218EA8;
	Fri, 18 Jul 2025 13:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752844221; cv=pass; b=BcqtffXQ+YSWQE35dw+Db9L0ak4IyDPw7IPYcMmVZjmK+v6no641Wd8x6Bq2zccj+n5i7nVKIEOIuteSWDCY0kLJFtzg9DT756k8NRENUvYLsil+T1NPg0qQtH4BWqMBXTyBlO4krmWRCj9ijn12FlOPmkpqL6p1h86cle0wZ3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752844221; c=relaxed/simple;
	bh=FJEqeqkRdVcwjxS2tptIUlZ/piS5Nm+IBw5fm66u6gU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Qq4xOS/k1K3AgkO1sFCJVewhLtuIZDqqGXswR1UwuMWU8NSJh2y5r8+ARQvVBPHsrusWb1obudcw3dfxKhi4DW2sBw28q0tW0xinTTNwZDnJnlQTkd565ezXtFZxz4ZRdyQ9FP02WuAE8N5tZg2ZsnrwuAHBwjNjH0EM8gjS+t0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=UozkiPgl; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752844201; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=W0a11xWUSCHN5MFqq5EWs3Ux53GOOnfRiGwYEnhUOZOJrz/8oat71RRHCTZ/iaLbfymPLGEAlFhH5eNKs7F+GIzNqAVsrHtAGvtMMPHVfcXQJj4//MUw1tSF1quY/ETzPJDnhXao7bClwPsWc8Vwv2NR6KsC0Q7hb6TDgiNhvHQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752844201; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Q6WEZlv79GvHGDyDAONzLm9yEqiwKE68ufLFe6YvfbI=; 
	b=OlQKk2di/esq9GBXDYGoEcThhn+NMbaMyhCTyzDLc7tNfat/AEXQ49ye9TXcBwEITS3+T2e07agAgCycUPsFJCupk8wXXBRcLMV/l+mrSnUagYIl4CTX+evJt48pDxuJAOGQcDY8H0ADmjFDQzhMn/ywltoh8fnOjJ6os0ohUZ8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752844201;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=Q6WEZlv79GvHGDyDAONzLm9yEqiwKE68ufLFe6YvfbI=;
	b=UozkiPglz3ajikvUUSVRC1+pXQgew64sMIiTIKp+KTlBjYhkI+wYX+PT5s/plRp1
	tVNR0uoeUdYOlNxKaMKa8RhLvV9eGz+oHBuuPd6iQGnDyvnCZudiyQKs2BIw1QckEJk
	N2SGCswuGFKhtoNc7vKDQv/2It4hgFpqDAXGM5h0=
Received: by mx.zohomail.com with SMTPS id 175284419917769.13110536163424;
	Fri, 18 Jul 2025 06:09:59 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH 1/3] device: rust: documentation for DeviceContext
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250717224806.54763-2-dakr@kernel.org>
Date: Fri, 18 Jul 2025 10:09:43 -0300
Cc: gregkh@linuxfoundation.org,
 rafael@kernel.org,
 ojeda@kernel.org,
 alex.gaynor@gmail.com,
 boqun.feng@gmail.com,
 gary@garyguo.net,
 bjorn3_gh@protonmail.com,
 lossin@kernel.org,
 a.hindborg@kernel.org,
 aliceryhl@google.com,
 tmgross@umich.edu,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <664AA6FF-4EFD-49FD-91A6-4D66B8614529@collabora.com>
References: <20250717224806.54763-1-dakr@kernel.org>
 <20250717224806.54763-2-dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Danilo,

> On 17 Jul 2025, at 19:45, Danilo Krummrich <dakr@kernel.org> wrote:
>=20
> Expand the documentation around DeviceContext states and types, in =
order
> to provide detailed information about their purpose and relationship
> with each other.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
> rust/kernel/device.rs | 63 +++++++++++++++++++++++++++++++++++--------
> 1 file changed, 52 insertions(+), 11 deletions(-)
>=20
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index ca82926fd67f..d7ac56628fe5 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -311,28 +311,69 @@ unsafe impl Send for Device {}
> // synchronization in `struct device`.
> unsafe impl Sync for Device {}
>=20
> -/// Marker trait for the context of a bus specific device.
> +/// Marker trait for the context or scope of a bus specific device.
> ///
> -/// Some functions of a bus specific device should only be called =
from a certain context, i.e. bus
> -/// callbacks, such as `probe()`.
> +/// [`DeviceContext`] is a marker trait for structures representing =
the context of a bus specific
> +/// [`Device`].
> ///
> -/// This is the marker trait for structures representing the context =
of a bus specific device.
> +/// The specific device context types are: [`CoreInternal`], =
[`Core`], [`Bound`] and [`Normal`].
> +///
> +/// [`DeviceContext`] types are hierarchical, which means that there =
is a strict hierarchy that
> +/// defines which [`DeviceContext`] type can be derived from another. =
For instance, any
> +/// [`Device<Core>`] can dereference to a [`Device<Bound>`].
> +///
> +/// The following enunumeration illustrates the dereference hierarchy =
of [`DeviceContext`] types.
> +///
> +/// - [`CoreInternal`] =3D> [`Core`] =3D> [`Bound`] =3D> [`Normal`]
> +/// - [`Core`] =3D> [`Bound`] =3D> [`Normal`]
> +/// - [`Bound`] =3D> [`Normal`]
> +/// - [`Normal`]
> +///
> +/// Bus devices can automatically implement the dereference hierarchy =
by using
> +/// [`impl_device_context_deref`](kernel::impl_device_context_deref).
> pub trait DeviceContext: private::Sealed {}

Overall this looks good to me. I think that one point you could perhaps
consider is that, to me at least, it wasn't clear that the contexts were =
only
valid for a given scope. Or what was precisely meant by =E2=80=9Cscope=E2=80=
=9D.


I.e.: I thought that once you saw Device<Bound>, for example, that would =
be
valid indefinitely. If we retrieve one of our past conversations at [0]:

>=20
> > Fine, but can=E2=80=99t you get a &Device<Bound> from a =
ARef<drm::Device>, for example?
> > Perhaps a nicer solution would be to offer this capability instead?
>=20
> I think you're confusing quite some things here.
>=20
>   [...]
>=20
>   (2) Owning a reference count of a device (i.e. ARef<Device>) does =
*not*
>       guarantee that the device is bound. You can own a reference =
count to the
>       device object way beyond it being bound. Instead, the guarantee =
comes from
>       the scope.
>=20
>       In this case, the scope is the IRQ callback, since the =
irq::Registration
>       guarantees to call and complete free_irq() before the underlying =
bus
>       device is unbound.


I see that you mention the word "scope" a few times, but perhaps it =
would be
more instructional if you say a few more things on this topic.

For example, when you mention probe(), it would be useful to emphasize =
that the
Core state would only be guaranteed for the _scope of that function_, =
and that
it wouldn't mean that "the state Core is active from now on", or "I can =
assume
that we have a Device<Core> from now on in other parts of the driver".

Kind of like you do here:

> +/// The core context indicates that the [`Device<Core>`] reference's =
scope is limited to the bus
> +/// callback it appears in.

But generalizing to all states if possible.

The difference is very subtle so this can sound a bit confusing. Let me =
know if
you want me to clarify this further.


[0] =
https://lore.kernel.org/rust-for-linux/DBB0NXU86D6G.2M3WZMS2NUV10@kernel.o=
rg/

=E2=80=94 Daniel=

