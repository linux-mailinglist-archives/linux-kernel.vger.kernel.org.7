Return-Path: <linux-kernel+bounces-757601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFF2B1C416
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E541F18C0B02
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F63A24DCEC;
	Wed,  6 Aug 2025 10:15:27 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E741EDA1B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 10:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754475327; cv=none; b=W4izTDHi2hHIG1fAqGmalVYjSJjzgjF9c5CxPKFFv6EntxyuLy61ItJxw1OoA5aXISIYTSJssBy6lr7/CONxm9hn2iaLhOPIIKEn7bZiOgdwxzkXe1pWlt7lrMlcCugV15uAVZMpRc/zMkoS1KxkW3eH0g4JNdAMsOEGzydKA8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754475327; c=relaxed/simple;
	bh=qAFftSbiUIueK7+K9HYn59Wqe8NdbxwzxxndmF7SLM0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j2IXBP/lyTe/KLEi8YjO/ElJrJs1SkagWH4VYH3Hpdh+Oau3i40swWWfReN3EJuIUlux+eHOw5tQZRyTdHlX56K1PbRPSzHhrXVBpB5/pfPn28P9pJs4C2KK6es+q6rrnDR+psyEJsYMSDw9ys/H3nrayGGINc5j8K0ADK/Glg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1ujbAy-0002kc-Ip; Wed, 06 Aug 2025 12:15:16 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1ujbAx-00CBzX-0r;
	Wed, 06 Aug 2025 12:15:15 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1ujbAx-0009Bg-0a;
	Wed, 06 Aug 2025 12:15:15 +0200
Message-ID: <41b37595c42e4f492704a31970936d52b96dae97.camel@pengutronix.de>
Subject: Re: [PATCH RFC 0/6] amdgpu: Avoid powering on the dGPU on
 vkEnumeratePhysicalDevices()
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Philipp
 Zabel <philipp.zabel@gmail.com>, Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 06 Aug 2025 12:15:15 +0200
In-Reply-To: <601a40fd-e508-4e9d-8dd3-14329f3a637b@amd.com>
References: <20250731-b4-dont-wake-next-v1-0-e51bdc347fa3@gmail.com>
	 <601a40fd-e508-4e9d-8dd3-14329f3a637b@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mi, 2025-08-06 at 10:58 +0200, Christian K=C3=B6nig wrote:
> On 31.07.25 07:36, Philipp Zabel wrote:
> > This is an attempt at fixing amd#2295 [1]:
> >=20
> >   On an AMD Rembrandt laptop with 680M iGPU and 6700S dGPU, calling
> >   vkEnumeratePhysicalDevices() wakes up the sleeping dGPU, even if all
> >   the application wants is to find and use the iGPU. This causes a dela=
y
> >   of about 2 seconds on this system, followed by a few seconds of
> >   increased power draw until runtime PM turns the dGPU back off again.
> >=20
> > [1] https://gitlab.freedesktop.org/drm/amd/-/issues/2295
> >=20
> > Patch 1 avoids power up on some ioctls that don't need it.
> > Patch 2 avoids power up on open() by postponing fpriv initialization to
> > the first ioctl() that wakes up the dGPU.
> > Patches 3 and 4 add AMDGPU_INFO to the list of non-waking ioctls,
> > returning cached values for some queries.
> > Patch 5 works around an explicit register access from libdrm.
> > Patch 6 shorts out the syncobj ioctls while fpriv is still
> > uninitialized. This avoids waking up the dGPU during Vulkan syncobj
> > feature detection.
>=20
> This idea came up multiple times now but was never completed.
>=20
> IIRC Pierre-Eric last worked on it, it would probably be a good idea to d=
ig up his patches from the mailing list.

Thank you, I wasn't aware of those patches [1]. Pierre-Eric did mention
them in https://gitlab.freedesktop.org/mesa/mesa/-/issues/13001, but I
didn't pick up on that back then.

[1] https://lore.kernel.org/all/20240618153003.146168-1-pierre-eric.pelloux=
-prayer@amd.com/

Is that the latest version? It looks to me like the review stalled out
on a disagreement whether the GB_ADDR_CONFIG query should be a separate
ioctl or whether it should be added to drm_amdgpu_info_device. The
discussion was later continued at
https://gitlab.freedesktop.org/mesa/libdrm/-/merge_requests/368,
seemingly coming to the conclusion that keeping the register read (but
cached) is the way to go? I didn't find a newer series with that
implemented.

> >=20
> > regards
> > Philipp
> >=20
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > ---
> > Alex Deucher (1):
> >       drm/amdgpu: don't wake up the GPU for some IOCTLs
> >=20
> > Philipp Zabel (5):
> >       drm/amdgpu: don't wake up the GPU when opening the device
> >       drm/amdgpu: don't query xclk in AMDGPU_INFO_DEV_INFO
> >       drm/amdgpu: don't wake up the GPU for some AMDGPU_INFO queries
> >       drm/amdgpu: don't wake up the GPU for mmGB_ADDR_CONFIG register r=
ead
>=20
> That is both unnecessary an insufficient. Unnecessary because we already =
have a mechanism to cache register values and insufficient because IIRC you=
 need to add a bunch of more registers to the cached list.

This series was (just barely) sufficient for my purpose, which was only
to make vkEnumeratePhysicalDevices() not wake the dGPU on my Laptop.
I didn't realize there already was a caching mechanism in the lower
layers.

> See Pierre-Erics latest patch set, I think we already solved that but I'm=
 not 100% sure.

If I found the correct version, it seems Sima's suggestion of pushing
runtime pm handling down from amdgpu_drm_ioctl into the amdgpu ioctl
callbacks [2] would be the best first next step?

[2] https://lore.kernel.org/amd-gfx/ZnvJHwnNAvDrRMVG@phenom.ffwll.local/

regards
Philipp

