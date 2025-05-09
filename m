Return-Path: <linux-kernel+bounces-642480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8FEAB1F32
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 23:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10E5054024C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 21:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF792609CA;
	Fri,  9 May 2025 21:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Jucn2dsF"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A896225C82E;
	Fri,  9 May 2025 21:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746826987; cv=pass; b=DgnK2OS32ftI3iypPJKQjJnJkBw5XiBoW9qRIedcHbSrSixOPYnB9ZaZ5pVa+Zc4fo98iCGixbkRAK+ZxLuOk/LuLLHdvCjeUkdjyPBTR0MUyhUY8Dz/pMLPXA0tTS1nB46XCTchgnT0gcR/b8pX+X9vnAV7VkzSDVeKJkYvK9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746826987; c=relaxed/simple;
	bh=3hwjDaebYOfFUJ/ZHzCyOJHtNHDwmdFy5WsivJNN/tg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gtqVOHanKENhZ6u41Mltk8dY74Wdz7z/PDyUXXILnCfDMxb340GFprhd0J/R4wbY8Bl+n8vDob9vddM2MIv3Vo31qmLPZvDB0zLjipnYazyYxaETRs1dIwEsvcIOIl41PpczT6nhra9yE8x5g7y1X2Gxk+DjW/UmleC4eeJGtH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Jucn2dsF; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1746826951; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VMGUGMc2VA7dXaFDn98icvQbJGDA45Cvk2SbMdmMorjdfpiEUem9BAceT+MvS5nXTiKJXD+5kdoshfGhKyTolhbdx2f46tDtPEDEbXbmjoPJIX18kFDJ2tmRK1Ugx6oGyKGbRcPfynddbKyyL/ibtqfB7V5fCHGVjtIK7oPXkmk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1746826951; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=owVjo58ul/GnTuZG0UmMNti1i3FStOLBCiI8f4mUzlc=; 
	b=epYErGucFPGTrkSF9PC3xfrnbI7gpmq+sntHtZ4bRPhJxTf/SY2ivg02QhgZAbok7KZ2NHcg1KZptcXeyjKRv+y47RBrObwwQO4qKecHyAm1mb5CVeHxZTooLxyiNcTQJr6tyA3xo7jG97ykKEpzcKIqo0WYTIqgsNxZ1U+rfOY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1746826951;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=owVjo58ul/GnTuZG0UmMNti1i3FStOLBCiI8f4mUzlc=;
	b=Jucn2dsFcUL+5iir6UEK3Ud3Yc+5pMcA43ECvIxdupv7UsaufyePfnYa+Q1bFjfj
	GhNOKyc1DbjddSAAgDGiJjfvddFp0/tetQT6T2MK3kXoTT1ZL7AvZphmyeOU3EEVI4r
	kqJM2ikZMQ4bic/RnUW5s/W2w20cCIPoMn/t+oik=
Received: by mx.zohomail.com with SMTPS id 1746826949914316.9241470000976;
	Fri, 9 May 2025 14:42:29 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH 3/4] rust: drm: gem: s/into_gem_obj()/as_gem_obj()/
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250501183717.2058109-4-lyude@redhat.com>
Date: Fri, 9 May 2025 18:42:12 -0300
Cc: dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
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
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Asahi Lina <lina@asahilina.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <128B16D7-2E18-440E-A2EE-C7194194D7D3@collabora.com>
References: <20250501183717.2058109-1-lyude@redhat.com>
 <20250501183717.2058109-4-lyude@redhat.com>
To: Lyude Paul <lyude@redhat.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-ZohoMailClient: External

Hi Lyude,

> On 1 May 2025, at 15:33, Lyude Paul <lyude@redhat.com> wrote:
>=20
> There's a few changes here:
> * The rename, of course (this should also let us drop the clippy =
annotation
>  here)
> * Return *mut bindings::drm_gem_object instead of
>  &Opaque<bindings::drm_gem_object> - the latter doesn't really have =
any
>  benefit and just results in conversion from the rust type to the C =
type
>  having to be more verbose than necessary.
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
> rust/kernel/drm/gem/mod.rs | 21 +++++++--------------
> 1 file changed, 7 insertions(+), 14 deletions(-)
>=20
> diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
> index f70531889c21f..55b2f1d056c39 100644
> --- a/rust/kernel/drm/gem/mod.rs
> +++ b/rust/kernel/drm/gem/mod.rs
> @@ -42,8 +42,7 @@ pub trait IntoGEMObject: Sized + =
super::private::Sealed {
>=20
>     /// Returns a reference to the raw `drm_gem_object` structure, =
which must be valid as long as
>     /// this owning object is valid.
> -    #[allow(clippy::wrong_self_convention)]
> -    fn into_gem_obj(&self) -> &Opaque<bindings::drm_gem_object>;
> +    fn as_gem_obj(&self) -> *mut bindings::drm_gem_object;
>=20
>     /// Converts a pointer to a `struct drm_gem_object` into a =
reference to `Self`.
>     ///
> @@ -99,8 +98,8 @@ extern "C" fn close_callback<T: BaseDriverObject<U>, =
U: BaseObject>(
> impl<T: DriverObject> IntoGEMObject for Object<T> {
>     type Driver =3D T::Driver;
>=20
> -    fn into_gem_obj(&self) -> &Opaque<bindings::drm_gem_object> {
> -        &self.obj
> +    fn as_gem_obj(&self) -> *mut bindings::drm_gem_object {
> +        self.obj.get()
>     }
>=20
>     unsafe fn as_ref<'a>(self_ptr: *mut bindings::drm_gem_object) -> =
&'a Self {
> @@ -119,7 +118,7 @@ pub trait BaseObject
>     fn size(&self) -> usize {
>         // SAFETY: `self.into_gem_obj()` is guaranteed to be a pointer =
to a valid `struct
>         // drm_gem_object`.
> -        unsafe { (*self.into_gem_obj().get()).size }
> +        unsafe { (*self.as_gem_obj()).size }
>     }
>=20
>     /// Creates a new handle for the object associated with a given =
`File`
> @@ -131,11 +130,7 @@ fn create_handle(
>         let mut handle: u32 =3D 0;
>         // SAFETY: The arguments are all valid per the type =
invariants.
>         to_result(unsafe {
> -            bindings::drm_gem_handle_create(
> -                file.as_raw().cast(),
> -                self.into_gem_obj().get(),
> -                &mut handle,
> -            )
> +            bindings::drm_gem_handle_create(file.as_raw().cast(), =
self.as_gem_obj(), &mut handle)
>         })?;
>         Ok(handle)
>     }
> @@ -171,13 +166,11 @@ fn lookup_handle(
>     /// Creates an mmap offset to map the object from userspace.
>     fn create_mmap_offset(&self) -> Result<u64> {
>         // SAFETY: The arguments are valid per the type invariant.
> -        to_result(unsafe { =
bindings::drm_gem_create_mmap_offset(self.into_gem_obj().get()) })?;
> +        to_result(unsafe { =
bindings::drm_gem_create_mmap_offset(self.as_gem_obj()) })?;
>=20
>         // SAFETY: The arguments are valid per the type invariant.
>         Ok(unsafe {
> -            bindings::drm_vma_node_offset_addr(ptr::addr_of_mut!(
> -                (*self.into_gem_obj().get()).vma_node
> -            ))
> +            =
bindings::drm_vma_node_offset_addr(ptr::addr_of_mut!((*self.as_gem_obj()).=
vma_node))

Hmm, I thought we were on a quest to remove addr_of_mut!() in favor of =
&raw mut?

Anyways, this is again orthogonal to your patch.

>         })
>     }
> }
> --=20
> 2.48.1
>=20
>=20

This looks good.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>


