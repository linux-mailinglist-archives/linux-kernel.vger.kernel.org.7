Return-Path: <linux-kernel+bounces-642474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1166AB1F20
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 23:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56B934E8831
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 21:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B2725FA34;
	Fri,  9 May 2025 21:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="T1/40aG5"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9DA231A21;
	Fri,  9 May 2025 21:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746826707; cv=pass; b=AFz9utBM77kDmtrW5Gq0hzakQM2al2FI+1Ln29sNgrD7to3W2rrFqD2LKwdRpHGhP2BxDiKsHlWmFrVviuNx5T1GFIaKiPbWIKP52ckCu3RaJd1xod0huDPK1sGiUC/yH6H/Q6UqwbDk34zgbWfNm5oMCgv0hiXyvAXIS7XVGx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746826707; c=relaxed/simple;
	bh=JR3oarlI6eN+Z0j9+LCA/IM58p818z+VC8vRoHsKcxM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RFhQ46hsY/xENynLilH89hvVrnjAdIAKwPnddBTj0violxHEElrX+yd8jaSvdsqqSrMh25SvYennbfNozhACDbO9/nZBmqNRqKSXAdbeRrQg2mb+DqteR1CP0nU4T7qF7tq14AITpAHOCRDd3uJiOrjE0nUPxTqQ47dj9nyY24M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=T1/40aG5; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1746826660; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WKLU011SkivK0CNI3kcoJf+l62KFY2BaL9IORqjf32F2qaFwW2n+oZkocV/RyAwQllsqiMudkyp0+JyMd6wGRJGmF8hOSYbS0COt0fxW3I6WCPjTGxtAED+ngGBYxZMU/mbBrjA8rbLMsRV9rk8dqpvw4GXQ7dMPS2VQzd0uEjE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1746826660; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8uQ/Q3BZqWs3AB74fmSdEwMz4hZv89bD/2dhgqYOFcA=; 
	b=RlRw7YotPSJCKobOTnXOogLGVeSgZdNDHjNWiaX3zvpSkwlNzgsk/jyzxVWHdM0AwbX3rSi7Z8ULF0euyiypZrK+gD22fwa3gtv1/rX5RbhOPUU9oFoNWYlRBNFTwt6bWR0mgU9J1Z5B0w6bSPU3SIcJwBsGFQVHDJS1+eQaCJ8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1746826660;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=8uQ/Q3BZqWs3AB74fmSdEwMz4hZv89bD/2dhgqYOFcA=;
	b=T1/40aG5XAwBQa9Lngu832NkdWK/kp+55bqU87dAFsnovWg4PPz2ZO/Gki6pxCp5
	E7Tde/p9crMaG0mA577r6TCqJknvHJXibFsTnMAbNmAo9TtviIqmU6AgOBUsgU3qsAP
	dVzyB2gyy6FLHDLkIP7PRd6VCVFNn+S8b9iVSDMM=
Received: by mx.zohomail.com with SMTPS id 1746826657711256.6976409448082;
	Fri, 9 May 2025 14:37:37 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH 2/4] rust: drm: gem: Refactor
 IntoGEMObject::from_gem_obj() to as_ref()
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250501183717.2058109-3-lyude@redhat.com>
Date: Fri, 9 May 2025 18:37:20 -0300
Cc: dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
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
 Asahi Lina <lina@asahilina.net>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>
Content-Transfer-Encoding: quoted-printable
Message-Id: <036A1696-C113-4C71-93AD-D5EA92EA3552@collabora.com>
References: <20250501183717.2058109-1-lyude@redhat.com>
 <20250501183717.2058109-3-lyude@redhat.com>
To: Lyude Paul <lyude@redhat.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-ZohoMailClient: External

Hi Lyude

> On 1 May 2025, at 15:33, Lyude Paul <lyude@redhat.com> wrote:
>=20
> There's a few issues with this function, mainly:
>=20
> * This function -probably- should have been unsafe from the start. =
Pointers
>  are not always necessarily valid, but you want a function that does
>  field-projection for a pointer that can travel outside of the =
original
>  struct to be unsafe, at least if I understand properly.
> * *mut Self is not terribly useful in this context, the majority of =
uses of
>  from_gem_obj() grab a *mut Self and then immediately convert it into =
a
>  &'a Self. It also goes against the ffi conventions we've set in the =
rest
>  of the kernel thus far.
> * from_gem_obj() also doesn't follow the naming conventions in the =
rest of
>  the DRM bindings at the moment, as_ref() would be a better name.
>=20
> So, let's:
>=20
> * Make from_gem_obj() unsafe
> * Convert it to return &'a Self
> * Rename it to as_ref()
> * Update all call locations
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
> rust/kernel/drm/gem/mod.rs | 67 ++++++++++++++++++++++++--------------
> 1 file changed, 42 insertions(+), 25 deletions(-)
>=20
> diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
> index df8f9fdae5c22..f70531889c21f 100644
> --- a/rust/kernel/drm/gem/mod.rs
> +++ b/rust/kernel/drm/gem/mod.rs
> @@ -45,8 +45,12 @@ pub trait IntoGEMObject: Sized + =
super::private::Sealed {
>     #[allow(clippy::wrong_self_convention)]
>     fn into_gem_obj(&self) -> &Opaque<bindings::drm_gem_object>;
>=20
> -    /// Converts a pointer to a `struct drm_gem_object` into a =
pointer to `Self`.
> -    fn from_gem_obj(obj: *mut bindings::drm_gem_object) -> *mut Self;
> +    /// Converts a pointer to a `struct drm_gem_object` into a =
reference to `Self`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `self_ptr` must be a valid pointer to `Self`.

Must also obey the reference rules. This is a bit obvious but it should
probably be mentioned regardless.

> +    unsafe fn as_ref<'a>(self_ptr: *mut bindings::drm_gem_object) -> =
&'a Self;
> }
>=20
> /// Trait which must be implemented by drivers using base GEM objects.
> @@ -63,14 +67,13 @@ extern "C" fn open_callback<T: =
BaseDriverObject<U>, U: BaseObject>(
>     let file =3D unsafe {
>         drm::File::<<<U as IntoGEMObject>::Driver as =
drm::Driver>::File>::as_ref(raw_file)
>     };
> -    let obj =3D
> -        <<<U as IntoGEMObject>::Driver as drm::Driver>::Object as =
IntoGEMObject>::from_gem_obj(
> -            raw_obj,
> -        );
> -
> -    // SAFETY: `from_gem_obj()` returns a valid pointer as long as =
the type is correct and the
> -    // `raw_obj` we got is valid.
> -    match T::open(unsafe { &*obj }, file) {
> +    // SAFETY: `open_callback` is specified in the AllocOps structure =
for `Object<T>`, ensuring that
> +    // `raw_obj` is indeed contained within a `Object<T>`.
> +    let obj =3D unsafe {
> +        <<<U as IntoGEMObject>::Driver as drm::Driver>::Object as =
IntoGEMObject>::as_ref(raw_obj)
> +    };

Ugh..IMHO we need to have aliases for all of these. This is, of course,
orthogonal to your patch. Just a nice-to-have for the future :)

> +
> +    match T::open(obj, file) {
>         Err(e) =3D> e.to_errno(),
>         Ok(()) =3D> 0,
>     }
> @@ -84,14 +87,13 @@ extern "C" fn close_callback<T: =
BaseDriverObject<U>, U: BaseObject>(
>     let file =3D unsafe {
>         drm::File::<<<U as IntoGEMObject>::Driver as =
drm::Driver>::File>::as_ref(raw_file)
>     };
> -    let obj =3D
> -        <<<U as IntoGEMObject>::Driver as drm::Driver>::Object as =
IntoGEMObject>::from_gem_obj(
> -            raw_obj,
> -        );
> -
> -    // SAFETY: `from_gem_obj()` returns a valid pointer as long as =
the type is correct and the
> -    // `raw_obj` we got is valid.
> -    T::close(unsafe { &*obj }, file);
> +    // SAFETY: `close_callback` is specified in the AllocOps =
structure for `Object<T>`, ensuring
> +    // that `raw_obj` is indeed contained within a `Object<T>`.
> +    let obj =3D unsafe {
> +        <<<U as IntoGEMObject>::Driver as drm::Driver>::Object as =
IntoGEMObject>::as_ref(raw_obj)
> +    };
> +
> +    T::close(obj, file);
> }
>=20
> impl<T: DriverObject> IntoGEMObject for Object<T> {
> @@ -101,9 +103,10 @@ fn into_gem_obj(&self) -> =
&Opaque<bindings::drm_gem_object> {
>         &self.obj
>     }
>=20
> -    fn from_gem_obj(obj: *mut bindings::drm_gem_object) -> *mut Self =
{
> -        // SAFETY: All of our objects are Object<T>.
> -        unsafe { crate::container_of!(obj, Object<T>, obj).cast_mut() =
}
> +    unsafe fn as_ref<'a>(self_ptr: *mut bindings::drm_gem_object) -> =
&'a Self {
> +        // SAFETY: `obj` is guaranteed to be in an `Object<T>` via =
the safety contract of this
> +        // function
> +        unsafe { &*crate::container_of!(self_ptr, Object<T>, obj) }
>     }
> }
>=20
> @@ -144,11 +147,25 @@ fn lookup_handle(
>     ) -> Result<ARef<Self>> {
>         // SAFETY: The arguments are all valid per the type =
invariants.
>         let ptr =3D unsafe { =
bindings::drm_gem_object_lookup(file.as_raw().cast(), handle) };
> -        let ptr =3D <Self as IntoGEMObject>::from_gem_obj(ptr);
> -        let ptr =3D NonNull::new(ptr).ok_or(ENOENT)?;
>=20
> -        // SAFETY: We take ownership of the reference of =
`drm_gem_object_lookup()`.
> -        Ok(unsafe { ARef::from_raw(ptr) })
> +        // SAFETY:
> +        // - A `drm::Driver` can only have a single `File` =
implementation.
> +        // - `file` uses the same `drm::Driver` as `Self`.
> +        // - Therefore, we're guaranteed that `ptr` must be a gem =
object embedded within `Self`.
> +        // - And we check if the pointer is null befoe calling =
as_ref(), ensuring that `ptr` is a
> +        //   valid pointer to an initialized `Self`.
> +        // XXX: The expect lint here is to workaround
> +        // https://github.com/rust-lang/rust-clippy/issues/13024
> +        #[expect(clippy::undocumented_unsafe_blocks)]
> +        let obj =3D (!ptr.is_null())
> +            .then(|| unsafe { Self::as_ref(ptr) })
> +            .ok_or(ENOENT)?;
> +
> +        // SAFETY:
> +        // - We take ownership of the reference of =
`drm_gem_object_lookup()`.
> +        // - Our `NonNull` comes from an immutable reference, thus =
ensuring it is a valid pointer to
> +        //   `Self`.
> +        Ok(unsafe { ARef::from_raw(obj.into()) })
>     }
>=20
>     /// Creates an mmap offset to map the object from userspace.
> --=20
> 2.48.1
>=20
>=20

With the extra safety requirement,

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=

