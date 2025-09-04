Return-Path: <linux-kernel+bounces-800890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16301B43D60
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D254C3BBD39
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4B8305074;
	Thu,  4 Sep 2025 13:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="UsJjKoTY"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE212FF15B;
	Thu,  4 Sep 2025 13:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992950; cv=pass; b=i3h31AGRWd7Cmoy3zku5M/fnWTQds4wZuIY599fQA23tp5r6vW+dc7c87L/K3Xy5T1TSSz8mb1hl2zQybDMekhxXC23bCdoOilESmwiAvGA45vAy2xnl6qKO6S61EAtQLJj3XB6DGISaN0mZyjT42uv+9wZYd62f5tjw6laoz7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992950; c=relaxed/simple;
	bh=nPk9ZOXqvwoqWRAeTf74Qvfb/iFRVJTM6jVqOIXTPUk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=auV0LSbTA00WoyjAstBtXmykU6oSsf6Kq2DDAaEwJdNRkkqs0d/Cg0w9JLWwB2taHIqhWZzGuaNYAr4bqPtOza6HfTspzbpFvMXD/Lh7S4MahsK4zGcihgiJACpoOWviJELYV0ADpGTfBJKrA/07W+Uuh+bZochXJe5zLMwq6gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=UsJjKoTY; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756992924; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XDjhWHa4NmN0rbRoKzcTFdfJ8XYbE0/NfMze/eLl+ScNVXSFTyTW/9B8yG20U7WxXAqn/0ttZ9K3IIvlIS6EIo7aSP+7AkfzCSbaHxwojn/8jbGsPUZY3U5MaHncXgWAlGjEfqjhOlAdty5yKqiA90cEv+50lRI48Kdlq0pysy0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756992924; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BDP7uwNrDy2L82t2/eHdfQJEVvQlEfERp6xLzY9YInM=; 
	b=Rkz4B8gGPJIIikNnVuiC9W1AbtGfp4jJ7TXvO8Rkd0ntZn+ibnXZIaVAFkRFyIWyMcGMNVYW7yp6e7tX6JtM9lyijzXL0o1QnY3ngTv/ObJf8gNFWXKO19CmZVKYwlWVfcsXFic8oV8aLkvwgqkdeW/wSEITLGRzMCGD+KBUaiM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756992924;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=BDP7uwNrDy2L82t2/eHdfQJEVvQlEfERp6xLzY9YInM=;
	b=UsJjKoTYefuGH+/A8dOzjmVdktkPOr7NxfdR3BrNcsADvs7Kai8hnyRuD770lPGS
	6WEhqGlEjaA4FhYMJs0durFPB9iZzOs6elB1fclJq+Ag1QVrznljQdzu1EiGXj1H64I
	q+txlE2KryahxIOW1DLWeB7Pm8wm1yVx/gD4JQq8=
Received: by mx.zohomail.com with SMTPS id 1756992922006491.6688209679671;
	Thu, 4 Sep 2025 06:35:22 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v3 08/14] drm/gem/shmem: Extract drm_gem_shmem_release()
 from drm_gem_shmem_free()
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250829224116.477990-9-lyude@redhat.com>
Date: Thu, 4 Sep 2025 10:35:05 -0300
Cc: dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
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
 Danilo Krummrich <dakr@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A6150946-73B6-43AE-B12C-B0E692E9E3A5@collabora.com>
References: <20250829224116.477990-1-lyude@redhat.com>
 <20250829224116.477990-9-lyude@redhat.com>
To: Lyude Paul <lyude@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 29 Aug 2025, at 19:35, Lyude Paul <lyude@redhat.com> wrote:
>=20
> At the moment the way that freeing gem shmem objects is not ideal for =
rust

This does not read very well IMHO.

> bindings. drm_gem_shmem_free() releases all of the associated memory =
with a
> gem shmem object with kfree(), which means that for us to correctly =
release
> a gem shmem object in rust we have to manually drop all of the =
contents of
> our gem object structure in-place by hand before finally calling
> drm_gem_shmem_free() to release the shmem resources and the allocation =
for
> the gem object.
>=20
> Since the only reason this is an issue is because of =
drm_gem_shmem_free()
> calling kfree(), we can fix this by splitting drm_gem_shmem_free() out =
into
> itself and drm_gem_shmem_release(), where drm_gem_shmem_release() =
releases
> the various gem shmem resources without freeing the structure itself. =
With
> this, we can safely re-acquire the KBox for the gem object's memory
> allocation and let rust handle cleaning up all of the other struct =
members
> automatically.
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
> drivers/gpu/drm/drm_gem_shmem_helper.c | 23 ++++++++++++++++++-----
> include/drm/drm_gem_shmem_helper.h     |  1 +
> 2 files changed, 19 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c =
b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index b20a7b75c7228..50594cf8e17cc 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -175,13 +175,13 @@ struct drm_gem_shmem_object =
*drm_gem_shmem_create_with_mnt(struct drm_device *de
> EXPORT_SYMBOL_GPL(drm_gem_shmem_create_with_mnt);
>=20
> /**
> - * drm_gem_shmem_free - Free resources associated with a shmem GEM =
object
> - * @shmem: shmem GEM object to free
> + * drm_gem_shmem_release - Release resources associated with a shmem =
GEM object.
> + * @shmem: shmem GEM object
>  *
> - * This function cleans up the GEM object state and frees the memory =
used to
> - * store the object itself.
> + * This function cleans up the GEM object state, but does not free =
the memory used to store the
> + * object itself. This function is meant to be a dedicated helper for =
the Rust GEM bindings.
>  */
> -void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
> +void drm_gem_shmem_release(struct drm_gem_shmem_object *shmem)
> {
> struct drm_gem_object *obj =3D &shmem->base;
>=20
> @@ -208,6 +208,19 @@ void drm_gem_shmem_free(struct =
drm_gem_shmem_object *shmem)
> }
>=20
> drm_gem_object_release(obj);
> +}
> +EXPORT_SYMBOL_GPL(drm_gem_shmem_release);
> +
> +/**
> + * drm_gem_shmem_free - Free resources associated with a shmem GEM =
object
> + * @shmem: shmem GEM object to free
> + *
> + * This function cleans up the GEM object state and frees the memory =
used to
> + * store the object itself.
> + */
> +void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
> +{
> + drm_gem_shmem_release(shmem);
> kfree(shmem);
> }
> EXPORT_SYMBOL_GPL(drm_gem_shmem_free);
> diff --git a/include/drm/drm_gem_shmem_helper.h =
b/include/drm/drm_gem_shmem_helper.h
> index 235dc33127b9a..589f7bfe7506e 100644
> --- a/include/drm/drm_gem_shmem_helper.h
> +++ b/include/drm/drm_gem_shmem_helper.h
> @@ -112,6 +112,7 @@ struct drm_gem_shmem_object =
*drm_gem_shmem_create(struct drm_device *dev, size_t
> struct drm_gem_shmem_object *drm_gem_shmem_create_with_mnt(struct =
drm_device *dev,
>   size_t size,
>   struct vfsmount *gemfs);
> +void drm_gem_shmem_release(struct drm_gem_shmem_object *shmem);
> void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem);
>=20
> void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object =
*shmem);
> --=20
> 2.50.0
>=20
>=20


Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=

