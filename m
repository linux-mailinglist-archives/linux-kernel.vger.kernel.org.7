Return-Path: <linux-kernel+bounces-840124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A67DDBB3A01
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 12:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC645188ABB4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 10:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876A13090F9;
	Thu,  2 Oct 2025 10:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fX5oX2Mo"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEF72EDD52
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 10:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759400459; cv=none; b=PuB1lwywZhy0eIpyZATrk4d45nN9pGUVGMvfFMg8mzGD+s/GI81Hr00NAfEVWcSu4jedjUsRtpCXp0xgrmO04HvZBxz+okPZAapKfsQ5LYdEDUM0HuNBnP4jgPeGBdESrJhPelZgWG03+5bBCHPsJcl3yEBf9zKDGnqIm5Ddj64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759400459; c=relaxed/simple;
	bh=nzoqLNFIK38vVpPjcoTb1MLrDPGwb/rryPpdcdZUm4k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mYGxzZt55twFBHdoqVNWOKpWFG3G0TzCQ/GVoncAC3EldCQp2bmi6FtGCb6ezBIwhJ/cUhd/WfPQJumvt3Pf3Dwzk9y7uDzzmW/0mfT+UYJy9uL01MCNE8hYkD013MiF7hwsK1f2w/HBbu67ffkLsHKtNda6+58UcfB9zFCRIkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fX5oX2Mo; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D4ABA4E40E09;
	Thu,  2 Oct 2025 10:20:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9AD736062C;
	Thu,  2 Oct 2025 10:20:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1FCA6102F1BC9;
	Thu,  2 Oct 2025 12:20:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759400451; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=uAA/uXnOcv4MfSqZ0e/gJwFBUMeRZs+rL70NE0BRk30=;
	b=fX5oX2Mo+fGknxJzSqCDenWT4Q4l88JtNhTUpuCtsL/E84Pxmxd2eo6HJTUmqzPz3wRnL4
	oLBNNtM0MkJkS8qxUSG+DwtX34rEN4jjpCfHNnVpc0dQJ06UeOt9YouKQywq4NrjwER8/S
	znbbU7XlbSBtJNokklAzhcfwVUnZCapWsi6V12yhhxl8aEkegr7g2LZuFj9C7He6U2Ggmx
	5q7yy3oY2yJLZRhB4tZLdFIiw/HrC5g4d29iu2zf65bQG8mAx54Ia71AaZt2HyIGb5MzPV
	b/NkAkeAo4r61gtyjXk5GXS0QIjmmbAQJ3+pvnI80nqGCJzCySXyNhQTzSgr3g==
Date: Thu, 2 Oct 2025 12:20:41 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc: louis.chauvet@bootlin.com, hamohammed.sa@gmail.com, simona@ffwll.ch,
 melissa.srw@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 sebastian.wick@redhat.com, xaver.hugl@kde.org, victoria@system76.com,
 a.hindborg@kernel.org, leitao@debian.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/16] drm/vkms: Add configfs support
Message-ID: <20251002122041.7248d8ff@booty>
In-Reply-To: <20250901122541.9983-1-jose.exposito89@gmail.com>
References: <20250901122541.9983-1-jose.exposito89@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello Jos=C3=A9,

On Mon,  1 Sep 2025 14:25:25 +0200
Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com> wrote:

> Hi everyone,
>=20
> This series allow to configure one or more VKMS instances without having
> to reload the driver using configfs.
>=20
> The process of configuring a VKMS device is documented in "vkms.rst".
>=20
> In addition, I created a CLI tool to easily control VKMS instances from t=
he
> command line: vkmsctl [1].
>=20
> The series is structured in 3 blocks:
>=20
>   - Patches 1..11: Basic device configuration. For simplicity, I kept the
>     available options as minimal as possible.
>=20
>   - Patches 12 and 13: New option to skip the default device creation and=
 to-do
>     cleanup.
>=20
>   - Patches 14, 15 and 16: Allow to hot-plug and unplug connectors. This =
is not
>     part of the minimal set of options, but I included in this series so =
it can
>     be used as a template/example of how new configurations can be added.
>=20
> Finally, the code is thoroughly tested by a collection of IGT tests [2]. =
The IGT
> series is almost fully reviewed (1 patch is missing) and it is waiting on=
 this
> series to be merged.
>=20
> I don't know what is preventing this series to be ACK by a DRM maintainer=
, but
> please, if there is something missing or that needs to be fixed let me kn=
ow.
>=20
> I CCed the configfs maintainers in case they can give feedback about the =
design
> of the configfs API or the configfs related code, just in case that is on=
e of
> the complicated points to review by DRM maintainers.
>=20
> Best wishes,
> Jos=C3=A9 Exp=C3=B3sito

I reviewed the whole series and it looks really good. The step-by-step
approach of patches 1.11 especially made it very easy to follow.

With the doc fixes suggested by Harry you can add my:
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Luca

--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

