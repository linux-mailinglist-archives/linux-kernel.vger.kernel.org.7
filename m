Return-Path: <linux-kernel+bounces-725080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4384AFFA99
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC47D1890105
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6DB288512;
	Thu, 10 Jul 2025 07:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhXAvlda"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEE92877FB;
	Thu, 10 Jul 2025 07:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752131684; cv=none; b=UyVrk3+gdCvlERcYoI37hITbBeT83ort7vAIFrUb7QHa3LGrCLk3TIvIkeeqiixwjAJNNzBKPdQ6yEByrtjN59rEpAJ6DINRwB4n3OqH8uoPm22irE00TVmK9j8qqNqJRq2uTxahgMXj4cRb7Nm1rWF4brUbBR2OCC7vt33hs2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752131684; c=relaxed/simple;
	bh=FvFyBYxEpy9Sn7Einro160cdlw9VKDe5feG5m85a5bA=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=XC7Os5x4CZ8JmPo6ZT8xIug/ioHNKuOuhpliVb4pcWbvSs7e/nie0L6KlAMguTGr3rbXb04z5ind0aZwyTWaxZrP9QZS3N3jr/Z8Xbff6t8Ex52C8rUu8LDeEoBkc7HKJY8PXMYMt7OQtojknRPR5sB+/y9n3L/SYCYfSiZ66Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhXAvlda; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3DAC4CEE3;
	Thu, 10 Jul 2025 07:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752131684;
	bh=FvFyBYxEpy9Sn7Einro160cdlw9VKDe5feG5m85a5bA=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=KhXAvlda8kGZUzTXYkhLg3om+Qo32HaFYb14lK9fV4FGNBGD7XebP+umP0MEXay13
	 lw5BeT46/tqhFmHXABvGhETF8s/yPBhXwqA3TleECzaorb2joMVovTZ42Rkf3Mso/q
	 hFrDdruiJnJ28JfKbla+Ypq4zDGsG7UTp6+ICk997Kbn0lP4vp1j+8Bk9yAdGoMLh5
	 HZLvuTNeU2gMoi4s1BdRRojbsK2wv3btMSk0QthDZ6wyoF4Sdflh7Y5Hf35p/SvcVc
	 rxlgxw0D+4DTo95e8qolkjude05rg1SvTWBPS1W5IhDc4JuuseQqp2ilnPJae14MiF
	 F0YUPxTzxf6pw==
Message-ID: <966d844a84836a47ddcc49da0c779633@kernel.org>
Date: Thu, 10 Jul 2025 07:14:41 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 7/9] drm/bridge: get the bridge returned by
 drm_bridge_get_next_bridge()
In-Reply-To: <20250709-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v1-7-48920b9cf369@bootlin.com>
References: <20250709-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v1-7-48920b9cf369@bootlin.com>
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

On Wed, 9 Jul 2025 18:48:06 +0200, Luca Ceresoli wrote:
> drm_bridge_get_next_bridge() returns a bridge pointer that the
> caller could hold for a long time. Increment the refcount of the returned
> bridge and document it must be put by the caller.
>=20
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>=20
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

