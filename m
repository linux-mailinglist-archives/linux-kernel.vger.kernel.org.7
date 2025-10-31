Return-Path: <linux-kernel+bounces-879713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C5CC23CBD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E433234E95C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B643522AE45;
	Fri, 31 Oct 2025 08:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="2QsFma29"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCD82EBBA1
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761899259; cv=none; b=tS1ujK8iWtaW8reV4R/WlevXpPVtYF3GdEYZ8obs7s8itb1RL/LFoRBhElRPCwonjt02tapcEtvEG3REDVYwrMt3rUt2xGRr14a+91evBcHBiM9+zIp2NY6aZVkYX4lxbl+itX3+dbkcuGuJzpjCYlHMnO97COZHL7YSLF9OlYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761899259; c=relaxed/simple;
	bh=rVDvV5O7tt6XqEenPj3MzYJP8+4hW6vIqA/KDPdJn44=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Xa/N4BLuyyT8i+E/J6k5JclpzHtecwtvgkDQUsNHYiv+UBcCYTnC+z2ok+6pZYK3DnZZvXZSRH6PP/EcYHdxVMuJW90H0YBXv0AqFFeqbS8uKSyiYt0hxhLx4rSlLf1BCiwbKrQ6RgqZSqKaWKXSgnuXfthSRoS0owPHxvLD5k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=2QsFma29; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C493CC0E94C;
	Fri, 31 Oct 2025 08:27:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 40D1960704;
	Fri, 31 Oct 2025 08:27:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0386711808C56;
	Fri, 31 Oct 2025 09:27:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761899253; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=76uNIUxc2i2CUF22jYSwyi2Mw9C6H4Old0YYKI8BGFg=;
	b=2QsFma29dzgoL8GUr672ddHPgk5H3bRCZwyWPO/lcE/c8IRQfgnWlJ7VmzRwUphzggoN0z
	xS4+8Zu5tnHf8b1uK+F2AtZVmJX+l0SmZIqwiScFnnCh4Vn4CfLaTqUUQ/wrtpdbPDl67z
	DwJWtTSOjFhAiohmYoTzzRSF1rXfG4VCpk7nUXb2EgMm1bivB5qEYmmkrLxBn72OIoQeqa
	CKkkXOfExYybIlCeIRa6DaCaYWq2lyD7q2ehignpSCor58ClX4aY2duiBY62IgjdPRgcA5
	j9bryYwyrdzqDUXRKbKg6XDgTTBkbLIlTqUN/iboXCRwEHzZfEXmkqyK8GT5xw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Oct 2025 09:27:29 +0100
Message-Id: <DDWD5P3SKWMV.1LITMN6MAKGMA@bootlin.com>
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/9] drm/bridge: fsl-ldb: Add support for i.MX94
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
To: "Laurentiu Palcu" <laurentiu.palcu@oss.nxp.com>, <imx@lists.linux.dev>,
 "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
X-Mailer: aerc 0.20.1
References: <20250911-dcif-upstreaming-v5-0-a1e8dab8ae40@oss.nxp.com>
 <20250911-dcif-upstreaming-v5-3-a1e8dab8ae40@oss.nxp.com>
In-Reply-To: <20250911-dcif-upstreaming-v5-3-a1e8dab8ae40@oss.nxp.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Laurentiu,

On Thu Sep 11, 2025 at 1:37 PM CEST, Laurentiu Palcu wrote:
> i.MX94 series LDB controller shares the same LDB and LVDS control
> registers as i.MX8MP and i.MX93 but supports a higher maximum clock
> frequency.
>
> Add a 'max_clk_khz' member to the fsl_ldb_devdata structure in order to
> be able to set different max frequencies for other platforms.
>
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

[...]

> @@ -270,8 +281,9 @@ fsl_ldb_mode_valid(struct drm_bridge *bridge,
>  		   const struct drm_display_mode *mode)

I'd suggest a couple possible code style improvements here:

>  {
>  	struct fsl_ldb *fsl_ldb =3D to_fsl_ldb(bridge);
> +	u32 ch_max_clk_khz =3D fsl_ldb->devdata->max_clk_khz;

You don't need a variable to use it only once.

>
> -	if (mode->clock > (fsl_ldb_is_dual(fsl_ldb) ? 160000 : 80000))
> +	if (mode->clock > (fsl_ldb_is_dual(fsl_ldb) ? 2 * ch_max_clk_khz : ch_m=
ax_clk_khz))

And here you can use the ternary operator to compute the multiplier only:

	if (mode->clock > (fsl_ldb_is_dual(fsl_ldb) ? 2 : 1) * fsl_ldb->devdata->m=
ax_clk_khz)

Up to you whether you want to take my proposals above. The patch looks good
anyway, so with or without those changes:

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

