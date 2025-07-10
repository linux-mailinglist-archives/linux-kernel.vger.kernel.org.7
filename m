Return-Path: <linux-kernel+bounces-725072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A90AFFA7F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18CEB16FFFB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27B62882C4;
	Thu, 10 Jul 2025 07:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKAuITkq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C96E2877FB;
	Thu, 10 Jul 2025 07:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752131591; cv=none; b=IQqqTOFtEA4IpS5LO5/mWgbM0C9VVMM4WlG3zagqy3nvehMZxexSab5M5dRzWyOWYz+5qJYgP7H7n0kO8FDSggdAxwT+e3fXQV0PMYSx6lph1RyGG+mh+f0A+8wd0mbDdtv11tUV6mDgZM/fhpWNxEyquBcD20Uee+yKPQJqEZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752131591; c=relaxed/simple;
	bh=swtW+ZXga7xhQRN3PDVAmuLXUcGh09yYcwhConUBkmM=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=aepRNm6RUSHlwiqteN0N83GcpCDUKjARnyGEBcjGcBArITdIsRKGLNygixkFFD5zRI9m9Y55oQU5im4U/4FGzL6sA7SSb+ftGjXb9J9438w1kHIYo02p+cKyLJvosr9AVDu5yeKeX8bQjqPVKkclUYeq1iO03pyJQFrwNMLYJ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKAuITkq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96832C4CEF4;
	Thu, 10 Jul 2025 07:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752131591;
	bh=swtW+ZXga7xhQRN3PDVAmuLXUcGh09yYcwhConUBkmM=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=nKAuITkqsb2naB9snjWW/pHegn8VLqiYiNKoXBP1sMkdgv20fOZu/V4I5IzMrkrR1
	 WYv0c9SpDAGlQ/kk0Cth27W7FY+pU1DBvFFPyaf02FeGjbgRaWxEcdkdTlHM2gO3qA
	 vyLpnfU8euZ8q9sGt2HvNho7vHQGvvm3DNzI/OwkOhjm1McL9wfaOMyu6zyneDNPyX
	 KwyqdUsCGt8Q6jnvBucJXf3I0xw2kQVzbne2/aUuQ11pPb/5Vti+uw17YpvSXVytv3
	 XAOJsIzxQxXuhGCgVGpEXn0ZcZogiPOs1IIssH50SCpsSO2ZGTEws2Y/TG448M6g+n
	 N6od825biFIYQ==
Message-ID: <85f1ee594f02802fd5a019fa5ade999a@kernel.org>
Date: Thu, 10 Jul 2025 07:13:08 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 3/9] drm/bridge: imx93-mipi-dsi: use
 drm_bridge_chain_get_last_bridge()
In-Reply-To: <20250709-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v1-3-48920b9cf369@bootlin.com>
References: <20250709-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v1-3-48920b9cf369@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, "Andrzej
 Hajda" <andrzej.hajda@intel.com>, "David Airlie" <airlied@gmail.com>, "Fabio
 Estevam" <festevam@gmail.com>, "Hui Pu" <Hui.Pu@gehealthcare.com>, "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, "Jonas Karlman" <jonas@kwiboo.se>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Liu Ying" <victor.liu@nxp.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, "Pengutronix Kernel Team" <kernel@pengutronix.de>, "Philipp
 Zabel" <p.zabel@pengutronix.de>, "Robert Foss" <rfoss@kernel.org>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, "Shawn Guo" <shawnguo@kernel.org>, "Simona
 Vetter" <simona@ffwll.ch>, "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, "Tomi Valkeinen" <tomi.valkeinen@ideasonboard.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Wed, 9 Jul 2025 18:48:02 +0200, Luca Ceresoli wrote:
> Use drm_bridge_chain_get_last_bridge() instead of open coding a loop with
> two invocations of drm_bridge_get_next_bridge() per iteration.
>=20
> Besides being cleaner and more efficient, this change is necessary in
> preparation for drm_bridge_get_next_bridge() to get a reference to the
>=20
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

