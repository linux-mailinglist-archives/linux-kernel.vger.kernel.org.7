Return-Path: <linux-kernel+bounces-794967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 346C1B3EB5E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CF891B23955
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668352E6CC6;
	Mon,  1 Sep 2025 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="KpZcuocW"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821B62D5943;
	Mon,  1 Sep 2025 15:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756741145; cv=pass; b=YsVEgegHGf2tTZ8rItSHMzhBgGDDlY/Pu51GeiSfOcPcDcE3DcTe4AuXNjyBx409dggEpkoKwgPciOMTPZkPXQ4dQJY+eO6YYWjGtO7FLqL4TpbY9+bqA80n2TJyI/Ml/nKs5yNPGAI1epZUIBaUjc0mMafJswA4Hu3ac9oled0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756741145; c=relaxed/simple;
	bh=oXtRpDppDRhZDsD0K+kzBYFVF9cg3cSo5ZL0eZ6RV3s=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eqMi1Vdf4p3fnlAp2DsY1XPpX6YI9Og0haG8QCkUVUOjTR0K3jTyxEHJ3kkl56BjjWC2nWxb3rWYOujfYbLhNvTk/fD2lH3x3Yii1ogI/N0Bpwt+70L8KZxLHvfCjfCfMw4vLH5p2zDw2OkyVJU1bAWlkHScd06+NMG8odnEFEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=KpZcuocW; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756741050; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kGhneXmVXbR6/QfsJolRQDGhH48dehg/RmylKlOpuadFuZqXRIumn7Xv80GYgFFh0b/6jK3bB/ekrBS2G4mSfmY9iMgv322T9v5txORynQMxx0X46CLIIoK8pHC+QegFmusBjENR9XXeZE4tnOl9gWw8wOHYP58FWrdj+QiB7s8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756741050; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=J7yNOxJZhdfDkiP8jJZkUqR/tXFBeS7v4u5qWtcTUEY=; 
	b=HKAhVfOrzmyG5XLUQ0XJDV2MtCbypoEuvWQWY+4NYyRmjaGKyeTifj/bPLLX8bmvIZKDhUGFeg2WbHsPoVCZGnSlHKMXEcPfpJKAb9IKt0AyLiSDomNzAjHJv53687X5IbVHZ3uidTVBhE7jwpE1ZtE3g9oC6jH5huf3Zc6r4vc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756741050;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=J7yNOxJZhdfDkiP8jJZkUqR/tXFBeS7v4u5qWtcTUEY=;
	b=KpZcuocWTgw2nu+e2eochKKy2UEKN00BFb65rWUcDTSr5jeUUSquOBYJE7KGwZhM
	Du2wepEg4XMQswrwUOSyodSxJZmSMkC/3Fj6W7Q971Q2DctqMVxLFIAFD6k3f8mo44G
	HIfJx04iViT7NFpPXe1vmybQo3Urk5qkptmsUQgg=
Received: by mx.zohomail.com with SMTPS id 1756741048112173.95372647627437;
	Mon, 1 Sep 2025 08:37:28 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v3 01/14] rust: drm: gem: Simplify use of generics
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250829224116.477990-2-lyude@redhat.com>
Date: Mon, 1 Sep 2025 12:37:10 -0300
Cc: dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>,
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
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Asahi Lina <lina+kernel@asahilina.net>,
 "open list:DRM DRIVER FOR NVIDIA GPUS [RUST]" <nouveau@lists.freedesktop.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C036DE82-747A-4DCE-845F-CE832DA8991A@collabora.com>
References: <20250829224116.477990-1-lyude@redhat.com>
 <20250829224116.477990-2-lyude@redhat.com>
To: Lyude Paul <lyude@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hi Lyude, thanks a lot for working on this! :)

> On 29 Aug 2025, at 19:35, Lyude Paul <lyude@redhat.com> wrote:
>=20
> Now that my rust skills have been honed, I noticed that there's a lot =
of
> generics in our gem bindings that don't actually need to be here. =
Currently
> the hierarchy of traits in our gem bindings looks like this:
>=20
>  * Drivers implement:
>    * BaseDriverObject<T: DriverObject> (has the callbacks)
>    * DriverObject (has the drm::Driver type)
>  * Crate implements:
>    * IntoGEMObject for Object<T> where T: DriverObject
>      Handles conversion to/from raw object pointers
>    * BaseObject for T where T: IntoGEMObject
>      Provides methods common to all gem interfaces
>=20
>  Also of note, this leaves us with two different drm::Driver =
associated
>  types:
>    * DriverObject::Driver
>    * IntoGEMObject::Driver
>=20
> I'm not entirely sure of the original intent here unfortunately (if =
anyone
> is, please let me know!), but my guess is that the idea would be that =
some
> objects can implement IntoGEMObject using a different ::Driver than
> DriverObject - presumably to enable the usage of gem objects from =
different
> drivers. A reasonable usecase of course.
>=20
> However - if I'm not mistaken, I don't think that this is actually how
> things would go in practice. Driver implementations are of course
> implemented by their associated drivers, and generally drivers are not
> linked to each-other when building the kernel. Which is to say that =
even in
> a situation where we would theoretically deal with gem objects from =
another
> driver, we still wouldn't have access to its drm::driver::Driver
> implementation. It's more likely we would simply want a variant of gem
> objects in such a situation that have no association with a
> drm::driver::Driver type.
>=20
> Taking that into consideration, we can assume the following:
> * Anything that implements BaseDriverObject will implement =
DriverObject
>  In other words, all BaseDriverObjects indirectly have an associated
>  ::Driver type - so the two traits can be combined into one with no
>  generics.
> * Not everything that implements IntoGEMObject will have an associated
>  ::Driver, and that's OK.
>=20
> And with this, we now can do quite a bit of cleanup with the use of
> generics here. As such, this commit:
>=20
> * Removes the generics on BaseDriverObject
> * Moves DriverObject::Driver into BaseDriverObject
> * Removes DriverObject
> * Removes IntoGEMObject::Driver
> * Add AllocImpl::Driver, which we can use as a binding to figure out =
the
>  correct File type for BaseObject
>=20
> Leaving us with a simpler trait hierarchy that now looks like this:
>=20
>  * Drivers implement: BaseDriverObject
>  * Crate implements:
>    * IntoGEMObject for Object<T> where T: DriverObject
>    * BaseObject for T where T: IntoGEMObject
>=20
> Which makes the code a lot easier to understand and build on :).
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
>=20
> ---
> V2:
> * Don't refer to Object<T> in callbacks, as this would result in =
drivers
>  getting the wrong gem object type for shmem gem objects once we add
>  support for those. Instead, we'll just add a type alias to clean this
>  part up.
> V3:
> * Fix nova compilation
> * Also, add an associated driver type to AllocImpl - as we still need =
the
>  current driver accessible from BaseObject so that we can use the =
driver's
>  various associated types, like File
> V4:

?

This is v3. Can you clarify this before we go further? :)

> * Add missing Object =3D Self constraint to type bounds for =
create_handle,
>  lookup_handle. I forgot that if drivers can have private gem objects =
with
>  a different data layout, we can only guarantee gem objects with =
handles
>  are of the same gem object type as the main one in use by the driver.
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>

=E2=80=94 Daniel


