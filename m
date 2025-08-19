Return-Path: <linux-kernel+bounces-775916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 772BBB2C668
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A65188C05B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE52341ACB;
	Tue, 19 Aug 2025 13:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxwatY5c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339B3202C2B;
	Tue, 19 Aug 2025 13:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755611887; cv=none; b=daNA/ZmdHAFj7dA4h3OqHXWutCLXH+zIQNWWi22x/4fHvvUGtsqnbvcXha2KFC6XhDXXQt4jBChq82vcpUeFUmkpKDOeDY6KuGW68+KysVvYM5wYdfjPMw4Baf32Lg2q3JWcOkuYkawziLIv85fIt7+FcmSDvGJjsyCMB4hIFXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755611887; c=relaxed/simple;
	bh=j1RSaqSBfdEgRZZK4r1EKSpaMqq1K5TQ7okIVP5zzlw=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=npwTtuAi02w4OTpoMq08OVjN3Wgt3/eY2jFBWNyCmLoDCr0QrpODfpH/AGp3YTFn3TA387dxNgh8YhXwS7vxt0tGCGJmHq5i76spphkK8YSGNd4c89Zg4UmZyOq9Cieb57qKvvSbj3IdDBexcd/t4YIq1YEKQ+R8DCnCwYepeWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxwatY5c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D65BC4CEF1;
	Tue, 19 Aug 2025 13:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755611886;
	bh=j1RSaqSBfdEgRZZK4r1EKSpaMqq1K5TQ7okIVP5zzlw=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=NxwatY5crFE7fECYQEVBOyoOpjfP5/45PpoptNh0DX5HMNjlR78x6TXhATmaA+bzq
	 4Lujs3/Xpx8qVH+EW3iLIDPQfcsLZ5zwfeCgcNaZ7JxiF2qHhJRpXuv3KWeTi0mq6y
	 UEz1EdD23lMfhpqmWrGRowMgtXIy4WnBZx/T0fDjfN1QpgM8fB0DLO8P8mLFH3p7hf
	 7e8GGuZrDnh8Ps4HHjfe45pI6M4e46Yt8Y7aBMqv+b0744Y+fESCvh32S/ZbKareoS
	 7BwF3oZAKOWHUNzMZRniG87VfOZfezS5oxkraL1dSiP2NNpYYgtHgn7kWBbw2iHH9g
	 in2WzE4R2PUIQ==
Message-ID: <c738eb0e7c6f9383d92a3bc488236d3c@kernel.org>
Date: Tue, 19 Aug 2025 13:58:04 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v2 4/9] drm/omapdrm: use
 drm_bridge_chain_get_last_bridge()
In-Reply-To: <20250801-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v2-4-888912b0be13@bootlin.com>
References: <20250801-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v2-4-888912b0be13@bootlin.com>
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

On Fri, 1 Aug 2025 19:05:26 +0200, Luca Ceresoli wrote:
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

