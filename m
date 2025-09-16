Return-Path: <linux-kernel+bounces-818902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EF2B597D1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68D153B0954
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2032B30EF92;
	Tue, 16 Sep 2025 13:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ATYnZIIi"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338B42F83C0;
	Tue, 16 Sep 2025 13:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758029860; cv=none; b=jtDjC1BFwwd6y0fjwfms6lCyFZTm/VPj6p034cuXLRB80s45vbB5lzd1n/STXkbSiJaB4xn3FaXGXlIgrrjhSfR1CatVO5+r/SmfaA9Oq7n5erlUhBZMH5VCnGKeiyFfGDHvI/RK6RsPMTVr5iifehWSss8oIr89iVVqPumyia4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758029860; c=relaxed/simple;
	bh=6+H0620i//14BMDJN4u5g3Iolp5ZEUPqc6sC/ytDsag=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l8lwtEvyq3d+ZOc3l7axxCGwahmQzvLqz3JKJUkwykdGgUynm+FykH7tytT0HJF4d+DEboZH73UqZZm1xbmIWE2jaRel99CrJT4bIfB+kUyfEPWSIB6LCf3NNEH6JGsn8m1O0AhIlHIJiEbkCYDC77D1uxIu7+3gKxSwCjm/r6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ATYnZIIi; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758029856;
	bh=6+H0620i//14BMDJN4u5g3Iolp5ZEUPqc6sC/ytDsag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ATYnZIIieufqejsBctWTPxGu9fNRYE+0cCgaYXlTz+mJFaw3gJbtUMjD1Rpg8m1KX
	 HKXTVxOor2SlLQB17DfLn2clLnxloFLyuGVvDNNXjudiYViIHM5vPOkRGYrmGIevRI
	 o4G+bsqSygEMuLSkZvrMJIRakTn6y2BUZtZOKVY/2afyGmJvYeM/nqfRFgKd2DOrG5
	 xofgMrpb4ECHuOD4QgxIKsJERlXrdRglTslOJmjMn1W/YTiEmiG1S7AePa0dF4hghp
	 0P3IpGkOvOCpxtOJbvV2B6HEtUJ1x1dXfwmmr610bKvmkAp2GEUPqiUfgr4HDa/Rrt
	 D3ATygDiDQzOw==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6FF3017E0147;
	Tue, 16 Sep 2025 15:37:35 +0200 (CEST)
Date: Tue, 16 Sep 2025 15:37:21 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Conor Dooley <conor@kernel.org>, Chia-I Wu <olvaffe@gmail.com>, Steven
 Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: gpu: mali-valhall-csf: add MediaTek
 MT8196 compatible
Message-ID: <20250916153721.5b09e993@fedora>
In-Reply-To: <6418135.lOV4Wx5bFT@workhorse>
References: <20250913002155.1163908-1-olvaffe@gmail.com>
	<20250915-deodorize-proxy-b18e41fa8668@spud>
	<CAPaKu7TEjG3sWamy3k_YLig=208oXLPhMmbCvPOf96iEL0-uig@mail.gmail.com>
	<6418135.lOV4Wx5bFT@workhorse>
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

On Tue, 16 Sep 2025 10:58:40 +0200
Nicolas Frattaroli <nicolas.frattaroli@collabora.com> wrote:

> On Tuesday, 16 September 2025 06:21:10 Central European Summer Time Chia-=
I Wu wrote:
> > On Mon, Sep 15, 2025 at 10:52=E2=80=AFAM Conor Dooley <conor@kernel.org=
> wrote: =20
> > >
> > > On Mon, Sep 15, 2025 at 06:51:16PM +0100, Conor Dooley wrote: =20
> > > > Acked-by: Conor Dooley <conor.dooley@microchip.com> =20
> > >
> > > Hmm, actually there seems to be a more complete binding proposed here:
> > > https://patchwork.ozlabs.org/project/devicetree-bindings/patch/202509=
12-mt8196-gpufreq-v2-1-779a8a3729d9@collabora.com/ =20
> > Right. I tried to add the compatible to the binding (this patch)
> > before adding it to the driver (next patch).
> >=20
> > If this patch is not a prerequisite for the driver change, I can drop
> > this. Or perhaps there is a better way?
> >  =20
>=20
> Depends on what you want to do with the driver change; I could pull it
> into my patch series (I need it as a prerequisite now anyway, as v3
> will get rid of the clocks for MT8196 in the binding, which means it
> needs to have a flag for this in the soc_data struct you've added)
>=20
> I think that would be the easiest solution so that we don't step on
> each other's toes, as long as you think the driver change is
> basically in its final form right now and does not need major
> revisions you'd still like to make yourself without having to
> coordinate submission through me.
>=20
> Or, the most roundabout option: I split the bindings I submitted
> into a separate series, and then we can both declare them as deps
> for our driver changes. That might thoroughly confuse maintainers
> though. But then you can declare a dep on the bindings series and
> I can declare a dep on the bindings series and your patch.

The simplest option is probably to merge this series in drm-misc-next
and rebase your GPUEB changes on drm-misc-next.

