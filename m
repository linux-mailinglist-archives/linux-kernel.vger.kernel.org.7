Return-Path: <linux-kernel+bounces-883037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C3683C2C564
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 15:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF9914E9F63
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 14:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18E2279DC9;
	Mon,  3 Nov 2025 14:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="AuK7I6pW"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3B9148850
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762178857; cv=none; b=NboFmIorkkZLy2VFYZW9lsX30CirM/qc2dckY9LJrl5mG1S9YhREaaSKMeJdeExaqQrZ5sCgI2M2K5YFfESh/D7ncwYzxDDW3NdSe5xmomxXYsknic7WohcEu7/DpNu5rxNfr7QPbiVYU24dxXIMjJFnLi4m5j1fWCLWx+v1uao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762178857; c=relaxed/simple;
	bh=zGZUkrSKKsYnAxn5dIDSUtNe4q/9E6c28nR/r2Tsowo=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=UttdAjH+L9qeVQUE2151AF3lhowwEgaCzCL/JmIr084rz7MXdxhbd6buyiRSfrTvHgGEuYYvM6DFMRKcDNg+AA9As6F8K3OaLLVOPuzQgZc9en82SPJMdWFIa0GCkUulDt5cq/1Rhovcp5bYq7HE6FcfpCzE90B1J6b9Jfl5TPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=AuK7I6pW; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from mail.ideasonboard.com (unknown [IPv6:2401:4900:1c69:314e:ee86:ae6e:30:9d13])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6B42DC73;
	Mon,  3 Nov 2025 15:05:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762178740;
	bh=zGZUkrSKKsYnAxn5dIDSUtNe4q/9E6c28nR/r2Tsowo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=AuK7I6pWGaQTcsoFp69tDNHBbEj6eEHMi//NqCquqi+ICFsjc0G0FMvMJHmsiWk0M
	 lJkDKJetTmJwKgb5rgySv5rs4NnNzjGeaiWzAn7YtIEYnRQ/u7Ok5D7994y/bKqA9A
	 8Y0HomuTBTNvsGfaU0nOWtwq8AysRNsS0/JY5Qgs=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <176217826196.8690.15955501577381404885@freya>
References: <20251031-b4-vc-sm-cma-v1-0-0dd5c0ec3f5c@ideasonboard.com> <20251031-b4-vc-sm-cma-v1-13-0dd5c0ec3f5c@ideasonboard.com> <d0517fad-9253-4c39-a063-a2c09e74237f@kernel.org> <176217826196.8690.15955501577381404885@freya>
Subject: Re: [PATCH 13/13] platform/raspberrypi: vchiq: Register vc-sm-cma as a platform driver
From: Jai Luthra <jai.luthra@ideasonboard.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>, Phil Elwell <phil@raspberrypi.com>, Stefan Wahren <wahrenst@gmx.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, Sumit Semwal <sumit.semwal@linaro.org>, Christian =?utf-8?q?K=C3=B6nig?= <christian.koenig@amd.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Florian Fainelli <florian.fainelli@broadcom.com>, Krzysztof Kozlowski <krzk@kernel.org>, Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, bcm-kernel-feedback-list@broadcom.com
Date: Mon, 03 Nov 2025 19:37:28 +0530
Message-ID: <176217884879.8690.13419980100895110857@freya>
User-Agent: alot/0.12.dev28+gd2c823fe

Quoting Jai Luthra (2025-11-03 19:27:41)
> Quoting Krzysztof Kozlowski (2025-11-02 15:03:55)
> > On 31/10/2025 18:27, Jai Luthra wrote:
> > > From: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > >=20
> > > Register the vc-sm-cma driver as a platform driver under vchiq.
> > >=20
> > > Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > > Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
> > > ---
> > >  drivers/platform/raspberrypi/vchiq-interface/vchiq_arm.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >=20
> > > diff --git a/drivers/platform/raspberrypi/vchiq-interface/vchiq_arm.c=
 b/drivers/platform/raspberrypi/vchiq-interface/vchiq_arm.c
> > > index 6a7b96d3dae6275a483ef15dc619c5510454765e..09d33bec46ec45175378f=
ff8dd1084d0a8a12dd6 100644
> > > --- a/drivers/platform/raspberrypi/vchiq-interface/vchiq_arm.c
> > > +++ b/drivers/platform/raspberrypi/vchiq-interface/vchiq_arm.c
> > > @@ -63,6 +63,7 @@
> > >   * the interface.
> > >   */
> > >  static struct vchiq_device *bcm2835_audio;
> > > +static struct vchiq_device *vcsm_cma;
> >=20
> > Please don't write singletons. How do you handle probe of two devices?
>=20
> This driver instantiates all the devices under the vchiq bus during its
> probe.
>=20
> The VCHIQ firmware doesn't support device enumeration, hence we have to
> list out the supported devices here.

And as Laurent just pointed out to me, yes these shouldn't be globally
defined singletons.

I'll move them inside struct vchiq_drv_mgmt in v2.

>=20
> >=20
> > > =20
> > >  static const struct vchiq_platform_info bcm2835_info =3D {
> > >       .cache_line_size =3D 32,
> > > @@ -1421,6 +1422,7 @@ static int vchiq_probe(struct platform_device *=
pdev)
> >=20
> >=20
> > Best regards,
> > Krzysztof
>=20
> Thanks,
> Jai

