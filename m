Return-Path: <linux-kernel+bounces-842888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E51C0BBDE40
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 13:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB2C33ACF90
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 11:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F46726FD9A;
	Mon,  6 Oct 2025 11:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KggantfS"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A81B20FA9C;
	Mon,  6 Oct 2025 11:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759750728; cv=none; b=aPOxFjoliA+qe7oIb3B4wz08g40A5GS3UGqBsC63W1moZmoDqnMOnO2K1ZcNj1LJ2uemN74J9YwwYrym5Weass9WA2QCcngiSB7p14UerGSmYrKgf+pxUDXBABMWNKxVx2Wz46YAGfkjZbu66NSe79QVmR4k4cswI8AtO/o4dSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759750728; c=relaxed/simple;
	bh=lUyf8dRTZJ7H+iCSUJCsHO6JJYThEWG8/fGHYur8uXI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IBN7wcHK2Sbh2ceMD2Ka/3x5tZ+n2pFgDf2SMVZ8Wxux8CtWilcjv48bV23R5GTePrOZTlCR61RmWjp7t1nPlDhKWDjrjL0bIvneyYO0gAYBwAKHbNoTbVoC/N/kZoBxwpyUZkyHaMqQoZsXEM4NLJsSoMgRiKLdtpdbhWwiqzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KggantfS; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759750724;
	bh=lUyf8dRTZJ7H+iCSUJCsHO6JJYThEWG8/fGHYur8uXI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KggantfSacRddPWuPTYjy0Vo9SJFsnxyKDMjdMxtJA2lOfn+8ZbuYwYYTtsw+LFpm
	 TWC7DcRAVyQlPNFNQh2aTWTmcDHwqVPY0zzo1curXryvy1HFC1PhctEqUXy0kkGQdp
	 7oSZEzx2fxof7oSJUuMWAGwXvNwUbLaYlJvgLgm8chzhSu/HU3dCybidZMPtzwc9Ar
	 rCQ6w4Fxe86teKnTm3zJIwrMzq1APHGTHuIuYH2TnmaKXTA2xKlhRguo245AcDchv4
	 oeEEbnadKNn3WfFesMDILKQ2Migox/dXrpwPgZAQVicdFDGj4tq5i2BdHwSoXmxhdx
	 0VonwL9gEWhIw==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5229717E0AC3;
	Mon,  6 Oct 2025 13:38:44 +0200 (CEST)
Date: Mon, 6 Oct 2025 13:38:32 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Matthew Brost
 <matthew.brost@intel.com>, Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?=
 <thomas.hellstrom@linux.intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Steven Price <steven.price@arm.com>,
 Daniel Almeida <daniel.almeida@collabora.com>, Liviu Dudau
 <liviu.dudau@arm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 1/2] drm/gpuvm: add deferred vm_bo cleanup
Message-ID: <20251006133832.6d385b23@fedora>
In-Reply-To: <CAH5fLgipghDp3W+Gr0YfHT0HOp3vcF+mfBAbtiAiLOKRYt43Sw@mail.gmail.com>
References: <20251001-vmbo-defer-v3-0-a3fe6b6ae185@google.com>
	<20251001-vmbo-defer-v3-1-a3fe6b6ae185@google.com>
	<CAH5fLgipghDp3W+Gr0YfHT0HOp3vcF+mfBAbtiAiLOKRYt43Sw@mail.gmail.com>
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

On Mon, 6 Oct 2025 13:30:59 +0200
Alice Ryhl <aliceryhl@google.com> wrote:

> On Wed, Oct 1, 2025 at 12:41=E2=80=AFPM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> >
> > When using GPUVM in immediate mode, it is necessary to call
> > drm_gpuvm_unlink() from the fence signalling critical path. However,
> > unlink may call drm_gpuvm_bo_put(), which causes some challenges:
> >
> > 1. drm_gpuvm_bo_put() often requires you to take resv locks, which you
> >    can't do from the fence signalling critical path.
> > 2. drm_gpuvm_bo_put() calls drm_gem_object_put(), which is often going
> >    to be unsafe to call from the fence signalling critical path.
> >
> > To solve these issues, add a deferred version of drm_gpuvm_unlink() that
> > adds the vm_bo to a deferred cleanup list, and then clean it up later.
> >
> > The new methods take the GEMs GPUVA lock internally rather than letting
> > the caller do it because it also needs to perform an operation after
> > releasing the mutex again. This is to prevent freeing the GEM while
> > holding the mutex (more info as comments in the patch). This means that
> > the new methods can only be used with DRM_GPUVM_IMMEDIATE_MODE.
> >
> > Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com> =20
>=20
> In this version, I got rid of the kref_put_mutex() usage, but I
> realized that maybe we should bring it back. With the current code,
> it's actually possible to observe a zombie vm_bo in the GEM's list
> because we don't drop the refcount while holding the mutex.

Alright, let's get back to the kref_put_mutex() approach then.

