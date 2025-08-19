Return-Path: <linux-kernel+bounces-775917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC19B2C66D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3EB6188E511
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F04B342CB9;
	Tue, 19 Aug 2025 13:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbP2odHc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9745F25E814;
	Tue, 19 Aug 2025 13:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755611911; cv=none; b=XZ0QyEyw1TeCju804kJyGni+nSU2z0UEZxyCZoSdfJneinpyRgQK+zZgAGVgfjZ6WAqN0yyZAWiWzybVaIJQnZ+/mPDvJZae+FFFj3ey3w6A4Tnc2S6R1IKTr2ptqFWnzuZa4pWtqvLaRvXuyQxbQt75oK7zwVqFE7eprLRMP2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755611911; c=relaxed/simple;
	bh=VfNREE1NRpLohbGRAU4pi3ndwFMWBBmz2ZzA0sg2qiY=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=m7luD7eXZHqe+12BiDjMLBLbemHcimwQ1BAtzVy3T0SfLuT9/ZI5J/TrWTvlyi6eW7izn2sB4jpwL6kLU66WggC2tWOB4P8o/LqRP6jI9GZ2SITkxC40lHy0cCNWSo5g5GCkMkQ0Vkthjo0l3aBLyhIavx0pZgXsg+OFy6vlhik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbP2odHc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9844C4CEF1;
	Tue, 19 Aug 2025 13:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755611911;
	bh=VfNREE1NRpLohbGRAU4pi3ndwFMWBBmz2ZzA0sg2qiY=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=LbP2odHcaQtLA+mKrpqzrHaSnPgZ9K5DfdbCkbBIfuO+XH0YWQD6ef3Hmn78pyEiQ
	 R1VSgY4WPySRI1pZLKRDF57zx17P5KaMUCqizWKDdSfmaCGF1/J2bSf1OQsXktaOzD
	 gDlRnrD6HJ+QRfuVuQSFFG/OVB6vtIkVJmQw+GtgvZ9Vz+fh+WdOBp5SRVJJRXPJgB
	 Z+CyqfFZEVVNzCRVMtgTl/n4vLewOYM0GKk5UhsHfwUf127ZMYHJK74cCsqah8/oBW
	 AR9YG5VWp2BA4QL84FuP7ZeiQbqvN8+Oz9ipcx6pahQs8FDJKnz21iOfceHsbPvAnE
	 k/gHjXwYFmcHQ==
Message-ID: <1950cb116ce138970b79559c7b078c09@kernel.org>
Date: Tue, 19 Aug 2025 13:58:28 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v2 8/9] drm/bridge: put the bridge returned by
 drm_bridge_get_next_bridge()
In-Reply-To: <20250801-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v2-8-888912b0be13@bootlin.com>
References: <20250801-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v2-8-888912b0be13@bootlin.com>
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

On Fri, 1 Aug 2025 19:05:30 +0200, Luca Ceresoli wrote:
> The bridge returned by drm_bridge_get_next_bridge() is refcounted. Put it
> when done. We need to ensure it is not put before either next_bridge or
> next_bridge_state is in use, thus for simplicity use a cleanup action.
>=20
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>=20
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

