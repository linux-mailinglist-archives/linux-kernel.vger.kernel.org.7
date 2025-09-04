Return-Path: <linux-kernel+bounces-800735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD412B43B55
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A19D1C27A81
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8792C11D0;
	Thu,  4 Sep 2025 12:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="db6hmjP+"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C0080B;
	Thu,  4 Sep 2025 12:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756988265; cv=pass; b=TynQOGZw0+wAuoNUE/bj+zNTVoPsB7C2xHK+tO3WAQVXn2A5xHaTi9kEI8WGN0daq/59LMERxnLnQZnq096KXaBy38yOeaNOc1Wv3DiIyJTkDJqMQkQmo2WhH2Oc0uXz0+euuxX6FOQdeFNjqIvksaSykl8yZOoBRMVDyR+lPuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756988265; c=relaxed/simple;
	bh=yEww7GiI7Q1CnfPqUKd7f6cvyF2fSqrfWv67wv25RKc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=o/gHIPc4GT+vO0A2TojhR3o1A5knhy1LkjYtuVbbHNjLVTa41kqNf9+dBM2DtANewmwbdqTTy5WvBFA5svvYNPZBznMKXNu4l5PqJLftRWWGnoh9wCucgGYAteLYJX0G9sTqAT3qBuc0xAiunV09KGghLfhamyUScG+G7HoXgoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=db6hmjP+; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756988227; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fu5i56MR5gqKZ1f2G9Xz5lDudtJcH3I9W17LiRO9dwOio9nAefUwa0wJVLFWte/xC1Ovn4Rl5KETEqhrBCrWXcElvCqEUhl55qIpPpbJpH4zlalIV0MB9Ixgf9iUAx0LJMR0ElgeKSi677OXr0jQnPCkrIbmFyYKf83ZZR+7M64=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756988227; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BGXLLXLza35q5x0tGMHrUvPhUFi5TzJmTtz5njAQN3c=; 
	b=FyiECescXz52cWh4CSSG2krUc1FSPcu2erNAru2tSel6xEf5USb5o+e8/pUThQDaDY1r0LQiSpelBPDytroDQvhbn4iDkMySiIe9oQ5J0tB4jRnZJk5sQFPc8sUFnLRemMKdeMMxUB08/JIoQgCnKsSUfHfH5pJVPaOKypuE+y8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756988227;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=BGXLLXLza35q5x0tGMHrUvPhUFi5TzJmTtz5njAQN3c=;
	b=db6hmjP+R5cjIOrwRt8pVfLDiTyO3EKSQbdEh8jNaMqfWDYpP/DqeSW57rUqeiBK
	FerwSW47rwkJc6501vZmzLpAn4fYPMxoBJma/YwINP2pZ6f92WaOGBnzJqh/QZeQXD4
	bC/5KX/nXv6Dcpt9KOrd1Jmw97fPclgmyP6aOYtU=
Received: by mx.zohomail.com with SMTPS id 175698822434127.246868953927674;
	Thu, 4 Sep 2025 05:17:04 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v3 02/14] rust: drm: gem: Add DriverFile type alias
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250829224116.477990-3-lyude@redhat.com>
Date: Thu, 4 Sep 2025 09:16:47 -0300
Cc: dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Asahi Lina <lina+kernel@asahilina.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <864C74E2-77D7-4983-BC62-09C62672D600@collabora.com>
References: <20250829224116.477990-1-lyude@redhat.com>
 <20250829224116.477990-3-lyude@redhat.com>
To: Lyude Paul <lyude@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 29 Aug 2025, at 19:35, Lyude Paul <lyude@redhat.com> wrote:
>=20
> Just to reduce the clutter with the File<=E2=80=A6> types in gem.rs.
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
>=20
> ---
> V3:
> * Rename ObjectFile to DriverFile
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
> rust/kernel/drm/gem/mod.rs | 23 ++++++++++++-----------
> 1 file changed, 12 insertions(+), 11 deletions(-)
>=20
> diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
> index 31c5799d995c5..80940ed11368d 100644
> --- a/rust/kernel/drm/gem/mod.rs
> +++ b/rust/kernel/drm/gem/mod.rs
> @@ -14,6 +14,13 @@
> };
> use core::{mem, ops::Deref, ptr::NonNull};
>=20
> +/// A type alias for retrieving a [`Driver`]s [`DriverFile`] =
implementation from its
> +/// [`DriverObject`] implementation.
> +///
> +/// [`Driver`]: drm::Driver
> +/// [`DriverFile`]: drm::file::DriverFile
> +pub type DriverFile<T> =3D drm::File<<<T as DriverObject>::Driver as =
drm::Driver>::File>;
> +
> /// GEM object functions, which must be implemented by drivers.
> pub trait DriverObject: Sync + Send + Sized {
>     /// Parent `Driver` for this object.
> @@ -23,19 +30,12 @@ pub trait DriverObject: Sync + Send + Sized {
>     fn new(dev: &drm::Device<Self::Driver>, size: usize) -> impl =
PinInit<Self, Error>;
>=20
>     /// Open a new handle to an existing object, associated with a =
File.
> -    fn open(
> -        _obj: &<Self::Driver as drm::Driver>::Object,
> -        _file: &drm::File<<Self::Driver as drm::Driver>::File>,
> -    ) -> Result {
> +    fn open(_obj: &<Self::Driver as drm::Driver>::Object, _file: =
&DriverFile<Self>) -> Result {
>         Ok(())
>     }
>=20
>     /// Close a handle to an existing object, associated with a File.
> -    fn close(
> -        _obj: &<Self::Driver as drm::Driver>::Object,
> -        _file: &drm::File<<Self::Driver as drm::Driver>::File>,
> -    ) {
> -    }
> +    fn close(_obj: &<Self::Driver as drm::Driver>::Object, _file: =
&DriverFile<Self>) {}
> }
>=20
> /// Trait that represents a GEM object subtype
> @@ -79,7 +79,8 @@ extern "C" fn open_callback<T: DriverObject>(
>     raw_file: *mut bindings::drm_file,
> ) -> core::ffi::c_int {
>     // SAFETY: `open_callback` is only ever called with a valid =
pointer to a `struct drm_file`.
> -    let file =3D unsafe { drm::File::<<T::Driver as =
drm::Driver>::File>::from_raw(raw_file) };
> +    let file =3D unsafe { DriverFile::<T>::from_raw(raw_file) };
> +
>     // SAFETY: `open_callback` is specified in the AllocOps structure =
for `DriverObject<T>`,
>     // ensuring that `raw_obj` is contained within a `DriverObject<T>`
>     let obj =3D unsafe { <<T::Driver as drm::Driver>::Object as =
IntoGEMObject>::from_raw(raw_obj) };
> @@ -95,7 +96,7 @@ extern "C" fn close_callback<T: DriverObject>(
>     raw_file: *mut bindings::drm_file,
> ) {
>     // SAFETY: `open_callback` is only ever called with a valid =
pointer to a `struct drm_file`.
> -    let file =3D unsafe { drm::File::<<T::Driver as =
drm::Driver>::File>::from_raw(raw_file) };
> +    let file =3D unsafe { DriverFile::<T>::from_raw(raw_file) };
>=20
>     // SAFETY: `close_callback` is specified in the AllocOps structure =
for `Object<T>`, ensuring
>     // that `raw_obj` is indeed contained within a `Object<T>`.
> --=20
> 2.50.0
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>


