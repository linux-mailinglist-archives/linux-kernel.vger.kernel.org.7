Return-Path: <linux-kernel+bounces-585094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECE3A78F9A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 15:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA7603B26E2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 13:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C921238152;
	Wed,  2 Apr 2025 13:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Y5MAYP2/"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0AF5BAF0
	for <linux-kernel@vger.kernel.org>; Wed,  2 Apr 2025 13:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743600071; cv=none; b=r3DdrL5zY1pI9DyFOHAMzAVGKZEreTWiALbJDU+5mu6vfBOPxNIp39fj2pMvayG0lWWZL4QYP6hV0dhS+wvfT/ZT1273ZoKC5eCFqCyJuwk2Z3lnCfQ3wzM86DQ/Ptx5ZkMLgfWckEVo+71GP6HXfqpIO2eKQLu0IVly7ue49e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743600071; c=relaxed/simple;
	bh=9sr+NddIGa5PMOQr3Z2ERC47oRBn6mBFjzbWH7raRmg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZDlBck0Gihx1ERxoTfJk3UF5vwztgYCxcIot/G4CpMNeuSCbLuw8XTme+AafdcnycjaZMY++RUSIwG4fEMuUOd+9A2x5ODji2Re3/DHuSSF2t6EYdYgwXPC9endnRxFg5TAIJh0Pw2k8OuzHmVo6k3rZx2lEkVyYoItUyNgN5Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Y5MAYP2/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1743600067;
	bh=9sr+NddIGa5PMOQr3Z2ERC47oRBn6mBFjzbWH7raRmg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y5MAYP2/VcL4GfEFkLLMiPQvcSfTTplcdvGR06cRed6GVAatmHXSXaPyHEQfldaUG
	 J6wbt8c87zWbnCOshOR/C3xgRTtpxijmi05kLPxsTYgVKTR1tBFtWvQncGgnxb1ydQ
	 MxCa9KgI4EmIJurjPOfaWR+duYL96zMSSWGjYKhb2OpHk8B6454fiB8QXPqOukhVTD
	 /UQ7LaZkWD9KWOPi+IE/fs6A9AAypcuX9JdNU79WxK1mzPc163WYeBlRDhThnOozLg
	 gdjdu2hVYbRVd4gakxeToNbeszoK5JS82jaRwR4KNmYWtmMXdfRtx1UhRiltFFZOyB
	 bBsAVPdV41OFg==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 16F2917E0B0B;
	Wed,  2 Apr 2025 15:21:07 +0200 (CEST)
Date: Wed, 2 Apr 2025 15:21:02 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Gerd Hoffmann
 <kraxel@redhat.com>, Qiang Yu <yuq825@gmail.com>, Steven Price
 <steven.price@arm.com>, Frank Binns <frank.binns@imgtec.com>, Matt Coster
 <matt.coster@imgtec.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v20 09/10] drm/shmem-helper: Switch
 drm_gem_shmem_vmap/vunmap to use pin/unpin
Message-ID: <20250402152102.01d9cfee@collabora.com>
In-Reply-To: <710cdbd4-2c6e-48b7-b12b-972ab6d12abf@collabora.com>
References: <20250322212608.40511-1-dmitry.osipenko@collabora.com>
	<20250322212608.40511-10-dmitry.osipenko@collabora.com>
	<ea4f4059-7748-4bfd-9205-8e95222144da@suse.de>
	<710cdbd4-2c6e-48b7-b12b-972ab6d12abf@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 2 Apr 2025 15:58:55 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> On 4/2/25 15:47, Thomas Zimmermann wrote:
> > Hi
> >=20
> > Am 22.03.25 um 22:26 schrieb Dmitry Osipenko: =20
> >> The vmapped pages shall be pinned in memory and previously get/
> >> put_pages()
> >> were implicitly hard-pinning/unpinning the pages. This will no longer =
be
> >> the case with addition of memory shrinker because pages_use_count > 0
> >> won't
> >> determine anymore whether pages are hard-pinned (they will be soft-
> >> pinned),
> >> while the new pages_pin_count will do the hard-pinning. Switch the
> >> vmap/vunmap() to use pin/unpin() functions in a preparation of addition
> >> of the memory shrinker support to drm-shmem. =20
> >=20
> > I've meanwhile rediscovered this patch and I'm sure this is not correct.
> > Vmap should not pin AFAIK. It is possible to vmap if the buffer has been
> > pinned, but that's not automatic.=C2=A0 For other vmaps it is necessary=
 to
> > hold the reservation lock to prevent the buffer from moving.

Hm, is this problematic though? If you want to vmap() inside a section
that's protected by the resv lock, you can

- drm_gem_shmem_vmap_locked()
- do whatever you need to do with the vaddr,
- drm_gem_shmem_vunmap_locked()

and the {pin,page_use}_count will be back to their original values.
Those are just ref counters, and I doubt the overhead of
incrementing/decrementing them makes a difference compared to the heavy
page-allocation/vmap operations...

