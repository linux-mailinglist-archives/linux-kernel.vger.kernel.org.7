Return-Path: <linux-kernel+bounces-847130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66845BC9EA1
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 18:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E2DD4FC191
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 16:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B632D7DCC;
	Thu,  9 Oct 2025 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AbyX240I"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998CA220687
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025370; cv=none; b=pEiSMbsdD6J5OWwAbz/336jLKxdwrDis3l37kyx9i0LZTmDSKOHtk0CpGl79i0q/HjJLM4ovuypN+1R9sx84R7yVV9YQVcceA4TU88tsb+Kbb3ueTtD4nCaoaDleYXECSrqzlwuAM8LIawgSWPhJIRgOyz5Y+L+sQvxqEYMUg1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025370; c=relaxed/simple;
	bh=MLIYIoxH8YP7pPDntgftIv7qbi4NTy5OGuGcIFBRaCg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mukjqW1+98aiT6ClBQk+kq/NzV5bCprQsV8GrLLdDEv6sjbKBOnHbNUbemfoIqje/WOwIUFdboNzsfXioX034hhsTtqETxJO/k6D8MNzLIJhmHiOuTWpk6OYKfbfNqVyEsVmVBDVhASsPjBlzDDdmYW/WC9vR3y7R/FURttCNIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AbyX240I; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760025365;
	bh=MLIYIoxH8YP7pPDntgftIv7qbi4NTy5OGuGcIFBRaCg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AbyX240InzOwObKQHOWJsSTTi9qE6E4kQESS16iAGA+5rvUNBHCY2cWA5SgsgVFDu
	 QnQ+/2rSOkb2Ba9dsRc5mIb8Cy2tnjtxqFgJZQSBT6JTnxKJ8OIsgU68GB1oP4VNhN
	 5BSxEXM5tmypkQIbocrtUZ1LL+OlFXeX94y/wDnXf/BQyFa6V4Pv6wzDOQPO2ME6wd
	 1aQdbb4bs8fxG5X0a7jEZpbMZ+QoXRdl2jnY6QTdTGVMKFFxK+WUQ1FZ2VuUzxZ8Ig
	 o9haQi93C3AXJ7/s7olC1Bx5es4qRwq2o6cQBP8psQ5bguR/q46rx9g54R+Cz0qdhL
	 u+xcrnaFKIazQ==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8DF4417E108C;
	Thu,  9 Oct 2025 17:56:05 +0200 (CEST)
Date: Thu, 9 Oct 2025 17:56:01 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
 dri-devel@lists.freedesktop.org, kernel@collabora.com
Subject: Re: [PATCH v5 12/12] MAINTAINERS: Add Adrian Larumbe as Panfrost
 driver maintainer
Message-ID: <20251009175601.0eeb27c5@fedora>
In-Reply-To: <971fd0e3-474a-4685-ade2-f4563372f74d@arm.com>
References: <20251007150216.254250-1-adrian.larumbe@collabora.com>
	<20251007150216.254250-13-adrian.larumbe@collabora.com>
	<971fd0e3-474a-4685-ade2-f4563372f74d@arm.com>
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

On Thu, 9 Oct 2025 16:47:26 +0100
Steven Price <steven.price@arm.com> wrote:

> On 07/10/2025 16:01, Adri=C3=A1n Larumbe wrote:
> > Add Adrian Larumbe as Panfrost driver maintainer.
> >=20
> > Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> =20
>=20
> Acked-by: Steven Price <steven.price@arm.com>
>=20
> Welcome! And thank you for helping out.
>=20
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 5257d52679d6..cb68fdec3da4 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2066,6 +2066,7 @@ F:	drivers/gpu/drm/arm/display/komeda/
> >  ARM MALI PANFROST DRM DRIVER
> >  M:	Boris Brezillon <boris.brezillon@collabora.com>
> >  M:	Rob Herring <robh@kernel.org>
> > +M:      Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> =20
>=20
> NIT: it looks like you've used spaces not a tab.
>=20
> Also while we're here...
>=20
> @RobH: Does it still make sense for you to be listed as a maintainer? I
> haven't seen you active on Panfrost for a while.
>=20
> >  R:	Steven Price <steven.price@arm.com> =20
>=20
> And given that I've been doing a fair bit of the merging recently I'm
> wondering if I should upgrade myself to 'M'?

Oh, I didn't notice you were only flagged as a reviewer. +1 on turning
this R into an M.

