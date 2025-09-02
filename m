Return-Path: <linux-kernel+bounces-796607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4180B4034D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9F24168C9C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BC130F536;
	Tue,  2 Sep 2025 13:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="p4oO/dYZ"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282982D6623
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 13:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819562; cv=none; b=dJ9EpFaBlU7sKnqsaFE2Iat4q7Ia3GJjUccARn/HvoT5YG4qc6GPwQoW6s5Qol3gHmrzadftyXD/a/ZhKNSJvZK4TDi+d2hEryfytUT3jZAGTSzWrNc5A4ogjvsk0G3Y3UqldbVRmXE7okDr6WHr0Y/tyrzuUVTaQWffmITNSD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819562; c=relaxed/simple;
	bh=LQjKOCEZCm4JrIHLl25Vv5vI+T6vTsGFOZPILiJ/W80=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LABBSfyahPBhSe0ZaGv7Tp7bKJBHJrUDjlxNJpZiRV0aaou8QUtljGM7QRnXd97k3/f9i1GrWzVxjfOAHyo6iZfusrXRwzJqHwrJVwd+W6vwtuvR8AwsUjDMTiQFP5j5fkMkJM42YBQIjx4uUEnoFEC8TTs/pinwAS2bKswBHf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=p4oO/dYZ; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 4C9CDC8EC73;
	Tue,  2 Sep 2025 13:25:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3DFDD60695;
	Tue,  2 Sep 2025 13:25:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B57261C22DE7E;
	Tue,  2 Sep 2025 15:25:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756819557; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=XIirHbmhMXtXJvBragEAoA34vDbeRH+sFU2CxhY0avI=;
	b=p4oO/dYZqsjHaBWF2R21vdndofK8Rwq2ahC4NHgNBN6Na34iwePjcKiBJwIUyHrNgRN+jZ
	1/B9jHrL65yqpQ/iP6EkjTGV/X41XIZsFeLBAaLFx5RNpIFrysU+q8fYB6V7pZGgPrVheY
	8dsnqTVDZbE9WWVK070d8TJQ1C7t5msZwr4cK3f7GP4m5ruaNVvbepKHzW1+aGJ4u73Ds9
	rwaCTOnmgd+upmN8gFf+BZrb1xdC+UCYzMtJRiJm3QkrsiHVHs3H4UlSV/Ruykes0wEIJf
	Pa9eNBLaJSw7zNfTU2C+gQPjfR+vh7f7icL1DrcbR+E4LAk2cO0Ujjp3WLW+Tw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Liu Ying <victor.liu@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Zijun Hu <zijun.hu@oss.qualcomm.com>
In-Reply-To: <20250801-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v2-0-888912b0be13@bootlin.com>
References: <20250801-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v2-0-888912b0be13@bootlin.com>
Subject: Re: (subset) [PATCH v2 0/9] drm/bridge: get/put the bridge
 returned by drm_bridge_get_next_bridge()
Message-Id: <175681953112.353165.466531296795467773.b4-ty@bootlin.com>
Date: Tue, 02 Sep 2025 15:25:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3


On Fri, 01 Aug 2025 19:05:22 +0200, Luca Ceresoli wrote:
> Note: the cover in v1 was mentioning by mistake
> drm_bridge_get_last_bridge() instead of drm_bridge_get_next_bridge().
>                ^^^^
> 
> This series adds drm_bridge_get/put() calls for DRM bridges returned by
> drm_bridge_get_next_bridge().
> 
> [...]

Applied, thanks!

[1/9] list: add list_last_entry_or_null()
      commit: cb86408b1fc2e3f6fe45ebe8509a5404060e01e0
[2/9] drm/bridge: add drm_bridge_chain_get_last_bridge()
      commit: d77ad5178e90f5aa4ce6085510b3b2f742abc5f0
[3/9] drm/bridge: imx93-mipi-dsi: use drm_bridge_chain_get_last_bridge()
      commit: 5849eff7f06709c98baa7989806165fe30bd0cbe
[4/9] drm/omapdrm: use drm_bridge_chain_get_last_bridge()
      commit: c3183f71c3f1f004a0ca0b84c45c40d8b84dce3d
[5/9] drm/bridge: add drm_bridge_is_last()
      commit: e4cedfd4f0fc839bb3c783d7e827e9755e1af5cf
[6/9] drm/display: bridge_connector: use drm_bridge_is_last()
      commit: 306734a1c76ce35fa613ea823a31ddbcdbf1eef5

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


