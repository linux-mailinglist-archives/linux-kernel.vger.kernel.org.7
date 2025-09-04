Return-Path: <linux-kernel+bounces-801213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C33F5B4422E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB246168215
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322192F3C0C;
	Thu,  4 Sep 2025 16:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="HTPG9K+B"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4FD2C21D8;
	Thu,  4 Sep 2025 16:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757001933; cv=pass; b=VcwQzSvIaCrWm3t+cu/7LZ/zjNUHB54hmA/3TQ+5cYkMXHm3FEB94AI/Lh1WmRRN7tqGS3dNj3uWB7f8NdYd4NvumcK89IpLwNp4SA3roC0625z5f2tMHqe8xM4h71dCSqQG01fKoZpNGxazdYdY3SvNexbISEFTPoK8e0cHPOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757001933; c=relaxed/simple;
	bh=t9lu0JvhFkb5SYNRJXlmsj74IKcd4iYS8XLjNYqVtU8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Lg3wl0wlloqdX6yqkv3IUTjNP2CccDMxSRUXTZqWkxoFtRkulVFNpFbRnHpDpHaaMgcUtyOEKP3meclk5sQSC3BgKtMUanic2DcqqVnk9r2/y331ATZp6j83rrVa6RiWIo/1dRZGe3ZRXlI2krb3LskwGu5kcyRmX4BcjYxDXzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=HTPG9K+B; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757001827; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gtRAk0lbJpwRajce8c3ou1oyR8B31wR2xCsncDDpk8GWWo9WMbzxgocK0I+fqceiwPeueps6+YVZjEQSWzwgFfD4RiY3Z7jOjvOLUaQc7h/Dj3uluxYi7GAJsgvPs8XhUeNIAhEgS13wLVqgXBCEdWOBHMaGf+GspJRkaDMJC/8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757001827; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rJ141p4G/KKeNp34zR+PuCIzRFG2OM4Vkt+bjATVJ9Q=; 
	b=e/PMtmWWs9xF3tc/vKdNOxlK9iw0XBjhurUgH3EAbAFnUNPzUK3Y3UErrizatqg0689i8WfjCKmny0dfgGc1m4fMTe1LDFBVmkXCA13RRwwVmHfuZjbUTCI5GQTNsiVJUfSByGYPuq1ffXvTKS34K1KTFfb2UEujHG6MK3bPTY4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757001827;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=rJ141p4G/KKeNp34zR+PuCIzRFG2OM4Vkt+bjATVJ9Q=;
	b=HTPG9K+B/NXU0PsSt1T7FkCP7HHqQ2Sj0WfyN3XKqSrDE+xU1QBCqbjex4lUf1Fs
	6cImP9GEyIwkDVO7/0OhbJRvwcg/ssoVtjiosxiIy4bdBle9yt3OV3jbkRiBRm32pbV
	UExPwukgNb8A2O8TWiJThBh3BBmYYN6AJ5y+jtqU=
Received: by mx.zohomail.com with SMTPS id 1757001825245717.3281844603312;
	Thu, 4 Sep 2025 09:03:45 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v3 11/14] rust: drm: gem: Introduce SGTableRef
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250829224116.477990-12-lyude@redhat.com>
Date: Thu, 4 Sep 2025 13:03:27 -0300
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
Message-Id: <F97D14AA-2ADF-4D49-9F4B-418113F79562@collabora.com>
References: <20250829224116.477990-1-lyude@redhat.com>
 <20250829224116.477990-12-lyude@redhat.com>
To: Lyude Paul <lyude@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External


Hi Lyude,

> On 29 Aug 2025, at 19:35, Lyude Paul <lyude@redhat.com> wrote:
>=20
> Currently we expose the ability to retrieve an SGTable for an shmem =
gem
> object using gem::shmem::Object::<T>::sg_table(). However, this only =
gives us a
> borrowed reference. This being said - retrieving an SGTable is a =
fallible
> operation, and as such it's reasonable that a driver may want to hold
> onto an SGTable for longer then a reference would allow in order to =
avoid
> having to deal with fallibility every time they want to access the =
SGTable.
> One such driver with this usecase is the Asahi driver.
>=20
> So to support this, let's introduce SGTableRef - which both holds a
> pointer to the SGTable and a reference to its respective GEM object in
> order to keep the GEM object alive for as long as the SGTableRef. The
> type can be used identically to a normal SGTable.
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
>=20
> ---
> V3:
> * Rename OwnedSGTable to SGTableRef. Since the current version of the
>  SGTable abstractions now has a `Owned` and `Borrowed` variant, I =
think
>  renaming this to SGTableRef makes things less confusing.
>  We do however, keep the name of owned_sg_table() as-is.
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
> rust/kernel/drm/gem/shmem.rs | 50 ++++++++++++++++++++++++++++++++++++
> 1 file changed, 50 insertions(+)
>=20
> diff --git a/rust/kernel/drm/gem/shmem.rs =
b/rust/kernel/drm/gem/shmem.rs
> index 6a8a392c3691b..1437cda27a22c 100644
> --- a/rust/kernel/drm/gem/shmem.rs
> +++ b/rust/kernel/drm/gem/shmem.rs
> @@ -178,6 +178,22 @@ pub fn sg_table(&self) -> =
Result<&scatterlist::SGTable> {
>         Ok(unsafe { scatterlist::SGTable::from_raw(sgt) })
>     }
>=20
> +    /// Creates (if necessary) and returns an owned reference to a =
scatter-gather table of DMA pages
> +    /// for this object.
> +    ///
> +    /// This is the same as [`sg_table`](Self::sg_table), except that =
it instead returns a
> +    /// [`OwnedSGTable`] which holds a reference to the associated =
gem object.

This was forgotten ^

> +    ///
> +    /// This will pin the object in memory.
> +    pub fn owned_sg_table(&self) -> Result<SGTableRef<T>> {

owned_sg_table() returns SGTableRef. I do think this is confusing.

> +        Ok(SGTableRef {

Let=E2=80=99s call this shmem::SGTable, perhaps?

> +            sgt: self.sg_table()?.into(),
> +            // INVARIANT: We take an owned refcount to `self` here, =
ensuring that `sgt` remains
> +            // valid for as long as this `OwnedSGTable`.
> +            _owner: self.into(),
> +        })
> +    }
> +
>     /// Creates and returns a virtual kernel memory mapping for this =
object.
>     pub fn vmap(&self) -> Result<VMap<T>> {
>         let mut map: MaybeUninit<bindings::iosys_map> =3D =
MaybeUninit::uninit();
> @@ -309,3 +325,37 @@ fn drop(&mut self) {
> unsafe impl<T: DriverObject> Send for VMap<T> {}
> /// SAFETY: `iosys_map` objects are safe to send across threads.
> unsafe impl<T: DriverObject> Sync for VMap<T> {}
> +
> +/// An owned reference to a scatter-gather table of DMA address spans =
for a GEM shmem object.
> +///
> +/// This object holds an owned reference to the underlying GEM shmem =
object, ensuring that the
> +/// [`SGTable`] referenced by `SGTableRef` remains valid for the =
lifetime of this object.
> +///
> +/// # Invariants
> +///
> +/// - `sgt` is kept alive by `_owner`, ensuring it remains valid for =
as long as `Self`.
> +/// - `sgt` corresponds to the owned object in `_owner`.
> +/// - This object is only exposed in situations where we know the =
underlying `SGTable` will not be
> +///   modified for the lifetime of this object.
> +///
> +/// [`SGTable`]: scatterlist::SGTable
> +pub struct SGTableRef<T: DriverObject> {
> +    sgt: NonNull<scatterlist::SGTable>,

Didn=E2=80=99t Danilo & Abdiel introduce an owned SGTable variant?

> +    _owner: ARef<Object<T>>,
> +}
> +
> +// SAFETY: This object is only exposed in situations where we know =
the underlying `SGTable` will not
> +// be modified for the lifetime of this object.

We should perhaps say why is it valid to send SGTable to another thread =
here.

> +unsafe impl<T: DriverObject> Send for SGTableRef<T> {}
> +// SAFETY: This object is only exposed in situations where we know =
the underlying `SGTable` will not
> +// be modified for the lifetime of this object.
> +unsafe impl<T: DriverObject> Sync for SGTableRef<T> {}
> +
> +impl<T: DriverObject> Deref for SGTableRef<T> {
> +    type Target =3D scatterlist::SGTable;
> +
> +    fn deref(&self) -> &Self::Target {
> +        // SAFETY: Creating an immutable reference to this is safe =
via our type invariants.
> +        unsafe { self.sgt.as_ref() }

The as_ref() nomenclature remains in place to convert *mut T to &T? I =
thought
that had changed to from_raw().


> +    }
> +}
> --=20
> 2.50.0
>=20
>=20


