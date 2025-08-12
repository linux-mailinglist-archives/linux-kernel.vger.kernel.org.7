Return-Path: <linux-kernel+bounces-764890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 673C9B22876
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2D5A2A1866
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3530627FB18;
	Tue, 12 Aug 2025 13:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="S0IPvs3h"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768D1242D89;
	Tue, 12 Aug 2025 13:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755004971; cv=pass; b=RDjfNmB0b60YT9evoOsSb9hOAuNbDlvgmy1G6wODhWBg12hyHs01b96yvFo+x2nX3dTHIp4eeKOse0bxQfyWYlMv/klwvSCgI/5you+LlQQ/4+DuWGBpCdgL6exeOGDNc0uJVKApkPN+drX8UMnZrJ8RDApU/M91LVFEkTGERl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755004971; c=relaxed/simple;
	bh=wJEfiacmZ8Ss+iACIHgAUWVIOd/2EX7Osuvbw/khPDw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YX+mnwGhk4jfwu74L+wssL5KwWWrfbo/papSgRNjpT+sgz40V+ymf78H5ZjND236kN0oJAxxJFoLguCRgwVxGuzTPAu+p+vAT6g5lATvjLcAprJSdrLLHT9ohjTSOLWNxZ67yeVCaonCTwpGQeNnkYKRMNSDJJk3Knitw9WLBCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=S0IPvs3h; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1755004954; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=La9rNnpxJ56VoQJYi9cgAr00sVVAd9KVKWw3AX9aiBiCkVliwesHuXpedEm+oXx/ASjt/wwwzQygeqiUjJkSw9p83Qd6tr6+dwHcDNUpt68V2Gr5i7ambqWOMsQh4PKmzKUFeNCm5lDgAbS1VkHRpbhb0X8Ad1J9w+Rju9JlCus=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755004954; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wJEfiacmZ8Ss+iACIHgAUWVIOd/2EX7Osuvbw/khPDw=; 
	b=RM4rjl9FNm1c5fSr6t5+PCicAzpMXy01f2TLKBM/0w19LSxMznwjn8g/gUoEX0ZdQQCLzGBFE8mBJX+W7R5BzduEK7/KUJxB/U77mXHCuK0S3S9VrpzStRIAx8djyMKa56HxQ4dxf6S9F6S+NZu+fr5w97IcMt+efdYcefyHjrM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755004954;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=wJEfiacmZ8Ss+iACIHgAUWVIOd/2EX7Osuvbw/khPDw=;
	b=S0IPvs3hV1oG33m+/zAgpt7WDsyHb1lAThCFUNtCNLSfc4BKh/VpeJA0gjuAgTxB
	FA9judP92pd0Xs+IEgjxMGJCSHPW0RkTOg+LMYh+677AsPqDFnWI+cYXyj+cftxu8JR
	B3eeBuP8uFYBaIZS1z2z04bJqhBv2gNHzMFz1Lus=
Received: by mx.zohomail.com with SMTPS id 1755004951949796.0813368240631;
	Tue, 12 Aug 2025 06:22:31 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v2 1/3] device: rust: expand documentation for
 DeviceContext
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250722150110.23565-2-dakr@kernel.org>
Date: Tue, 12 Aug 2025 10:22:16 -0300
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
Message-Id: <A56A6D46-68FF-4579-AD34-B18B804841E2@collabora.com>
References: <20250722150110.23565-1-dakr@kernel.org>
 <20250722150110.23565-2-dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Danilo,

> On 22 Jul 2025, at 11:59, Danilo Krummrich <dakr@kernel.org> wrote:
>=20
> Expand the documentation around DeviceContext states and types, in =
order
> to provide detailed information about their purpose and relationship
> with each other.
>=20
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
> rust/kernel/device.rs | 69 ++++++++++++++++++++++++++++++++++++-------
> 1 file changed, 58 insertions(+), 11 deletions(-)
>=20
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index ca82926fd67f..f5d1db568f00 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -311,28 +311,75 @@ unsafe impl Send for Device {}
> // synchronization in `struct device`.
> unsafe impl Sync for Device {}
>=20
> -/// Marker trait for the context of a bus specific device.
> +/// Marker trait for the context or scope of a bus specific device.
> ///
> -/// Some functions of a bus specific device should only be called =
from a certain context, i.e. bus
> -/// callbacks, such as `probe()`.
> +/// [`DeviceContext`] is a marker trait for types representing the =
context of a bus specific
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
> +///
> +/// Bus devices can automatically implement the dereference hierarchy =
by using
> +/// [`impl_device_context_deref`].
> +///
> +/// Note that the guarantee for a [`Device`] reference to have a =
certain [`DeviceContext`] comes
> +/// from the specific scope the [`Device`] reference is valid in.
> +///
> +/// [`impl_device_context_deref`]: kernel::impl_device_context_deref
> pub trait DeviceContext: private::Sealed {}
>=20
> -/// The [`Normal`] context is the context of a bus specific device =
when it is not an argument of
> -/// any bus callback.
> +/// The [`Normal`] context is the default [`DeviceContext`] of any =
[`Device`].
> +///
> +/// The normal context does not indicate any specific context. Any =
`Device<Ctx>` is also a valid
> +/// [`Device<Normal>`]. It is the only [`DeviceContext`] for which it =
is valid to implement
> +/// [`AlwaysRefCounted`] for.
> +///
> +/// [`AlwaysRefCounted`]: kernel::types::AlwaysRefCounted
> pub struct Normal;
>=20
> -/// The [`Core`] context is the context of a bus specific device when =
it is supplied as argument of
> -/// any of the bus callbacks, such as `probe()`.
> +/// The [`Core`] context is the context of a bus specific device when =
it appears as argument of
> +/// any bus specific callback, such as `probe()`.
> +///
> +/// The core context indicates that the [`Device<Core>`] reference's =
scope is limited to the bus
> +/// callback it appears in. It is intended to be used for =
synchronization purposes. Bus device
> +/// implementations can implement methods for [`Device<Core>`], such =
that they can only be called
> +/// from bus callbacks.
> pub struct Core;
>=20
> -/// Semantically the same as [`Core`] but reserved for internal usage =
of the corresponding bus
> +/// Semantically the same as [`Core`], but reserved for internal =
usage of the corresponding bus
> +/// abstraction.
> +///
> +/// The internal core context is intended to be used in exactly the =
same way as the [Core] context,
> +/// with the difference that this [`DeviceContext`] is internal to =
the corresponding bus
> /// abstraction.
> +///
> +/// This context mainly exists to share generic [`Device`] =
infrastructure that should only be called
> +/// from bus callbacks with bus abstractions, but without making them =
accessible for drivers.
> pub struct CoreInternal;
>=20
> -/// The [`Bound`] context is the context of a bus specific device =
reference when it is guaranteed to
> -/// be bound for the duration of its lifetime.
> +/// The [`Bound`] context is the [`DeviceContext`] of a bus specific =
device when it is guaranteed to
> +/// be bound to a driver.
> +///
> +/// The bound context indicates that for the entire duration of the =
lifetime of a [`Device<Bound>`]
> +/// reference, the [`Device`] is guaranteed to be bound to a driver.
> +///
> +/// Some APIs, such as [`dma::CoherentAllocation`] or [`Devres`] rely =
on the [`Device`] to be bound,
> +/// which can be proven with the [`Bound`] device context.
> +///
> +/// Any abstraction that can guarantee a scope where the =
corresponding bus device is bound, should
> +/// provide a [`Device<Bound>`] reference to its users for this =
scope. This allows users to benefit
> +/// from optimizations for accessing device resources, see also =
[`Devres::access`].
> +///
> +/// [`Devres`]: kernel::devres::Devres
> +/// [`Devres::access`]: kernel::devres::Devres::access
> +/// [`dma::CoherentAllocation`]: kernel::dma::CoherentAllocation
> pub struct Bound;
>=20
> mod private {
> --=20
> 2.50.0
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=

