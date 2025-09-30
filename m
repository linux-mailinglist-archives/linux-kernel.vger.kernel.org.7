Return-Path: <linux-kernel+bounces-837914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C1DBAE0A5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74F9D178B8D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4E223817E;
	Tue, 30 Sep 2025 16:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PolTssNT"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08CC1E260D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759249770; cv=none; b=BxeSrye/YSHub+zFBljKzcTDnnHqwBNhv2alit7cZUfOYzkKUZQHqU0tCtOD1ZSsmFhej8oFd+bMvwNWRqGgWEJOieFrihJBFdHArgvSBcXAWs9LYvgbBlq02RFkAlGpQ46UZOj6dmPwcoOKkNmGjYVAfB7wjQPsI59GYcnPXlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759249770; c=relaxed/simple;
	bh=2kqE3MdFlsyIlKM4AXOI/bfovHhPnQfahB0ssoeeF0c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Js9qOa7q5NmksWtG37FlXC3zxaXFtd3OOw4s94Rc+xbd5aokWUz0zf6j8BXRg+5zCxANUoA9llgpKa9zeSGy6dlMrotyimdUZq1Ck5tmiR4dx8pjExOgqIl9xDlRg5Cdh2yZ94IvvUPXquGcQGdbLcAZPx2de0TTuSBoMETTCL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PolTssNT; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759249765;
	bh=2kqE3MdFlsyIlKM4AXOI/bfovHhPnQfahB0ssoeeF0c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PolTssNTD/USvUl+E8EPJJxihv6AllZ4tybpwcB+Lx+uOtrK9A4XzieEF2h0abKvP
	 REOKUxCTJiev/5Ke0JauBbNNM0IX0gZrcMFVmlhdz9WpEVoKmMVUn+bQaZsFjtUTKm
	 51B08R7qwVAHwh10JCkMociGcrekAsNWjxGQO+R+uUV2DcBYDqdvOBuo2mUr2f5p0i
	 zbkpKQcGRGJ3eZN+Fho0rg6JtT1t0yPC5V0AhKZuSU/+qaXjcO9z8+/aJVVf6W5TGE
	 gLLFBVYnVOOA43QHW8I+COItf8bHKz6NWF5MiSUqcU9gmwtf+QMeCNMJVFN1q3pAG6
	 Hz1v/kBYgvPSA==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B0BA117E010B;
	Tue, 30 Sep 2025 18:29:24 +0200 (CEST)
Date: Tue, 30 Sep 2025 18:29:20 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?TG/Dr2M=?= Molinari <loic.molinari@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Jani Nikula
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Rob Herring <robh@kernel.org>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Melissa Wen <mwen@igalia.com>, =?UTF-8?B?TWHDrXJh?= Canal
 <mcanal@igalia.com>, Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>, =?UTF-8?B?TWlrb8WCYWo=?= Wasiak
 <mikolaj.wasiak@intel.com>, Christian Brauner <brauner@kernel.org>, Nitin
 Gote <nitin.r.gote@intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, linux-mm@kvack.org, kernel@collabora.com
Subject: Re: [PATCH 2/8] drm/gem: Introduce drm_gem_get_unmapped_area() fop
Message-ID: <20250930182920.5604ca49@fedora>
In-Reply-To: <cd9084e1-16d9-4fd6-9c64-1876d53d5225@collabora.com>
References: <20250929200316.18417-1-loic.molinari@collabora.com>
	<20250929200316.18417-3-loic.molinari@collabora.com>
	<20250930123003.75370854@fedora>
	<cd9084e1-16d9-4fd6-9c64-1876d53d5225@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Sep 2025 18:09:37 +0200
Lo=C3=AFc Molinari <loic.molinari@collabora.com> wrote:

> On 30/09/2025 12:30, Boris Brezillon wrote:
> > On Mon, 29 Sep 2025 22:03:10 +0200
> >
> > Lo=C3=AFc Molinari <loic.molinari@collabora.com> wrote: =20
> >> +unsigned long drm_gem_get_unmapped_area(struct file *filp, unsigned l=
ong uaddr,
> >> +					unsigned long len, unsigned long pgoff,
> >> +					unsigned long flags)
> >> +{
> >> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >> +	struct drm_gem_object *obj;
> >> +	unsigned long ret;
> >> +
> >> +	obj =3D drm_gem_object_lookup_from_offset(filp, pgoff, len >> PAGE_S=
HIFT);
> >> +	if (IS_ERR(obj))
> >> +		return mm_get_unmapped_area(current->mm, filp, uaddr, len, 0,
> >> +					    flags);
> >> +
> >> +	ret =3D shmem_get_unmapped_area(obj->filp, uaddr, len, 0, flags);
> >> +
> >> +	drm_gem_object_put(obj);
> >> +
> >> +	return ret;
> >> +#else
> >> +	return mm_get_unmapped_area(current->mm, filp, uaddr, len, 0, flags)=
; =20
> >=20
> > Looks like the above code covers the non-THP case too, do we really need
> > to specialize for !CONFIG_TRANSPARENT_HUGEPAGE here? =20
>=20
> It does cover the !CONFIG_TRANSPARENT_HUGEPAGE case=20
> (shmem_get_unmapped_area() would just call and return the=20
> mm_get_unmapped_area() address) but the idea here is to avoid the GEM=20
> object lookup cost by calling mm_get_unmapped_area() directly.

I'd expect the extra GEM lookup to be negligible compared to the overall
mmap() operation to be honest, but I guess if we really want to avoid
the overhead, we could still write it without this ifdef.

	if (!IS_ENABLED(TRANSPARENT_HUGEPAGE))
		return mm_get_unmapped_area(current->mm, filp, uaddr,
					    len, 0, flags);

	...

My main concern is that shmem_get_unmapped_area() evolves with more
!TRANSPARENT_HUGEPAGE cases, and by calling mm_get_unmapped_area()
directly, we miss the opportunity to get optimizations for these cases,
just like we missed them by not forwarding the ->get_unmapped_area()
requests to the shmem layer so far.

>=20
> >> +#endif
> >> +}
> >> +EXPORT_SYMBOL(drm_gem_get_unmapped_area); =20
>=20
> Lo=C3=AFc


