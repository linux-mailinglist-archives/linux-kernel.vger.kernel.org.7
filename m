Return-Path: <linux-kernel+bounces-725078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0731AFFA93
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 733621BC6418
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9C1288C80;
	Thu, 10 Jul 2025 07:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyoHTKL6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FEB288C2A;
	Thu, 10 Jul 2025 07:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752131648; cv=none; b=PIu+NIklWj+IsyssSXGCArlbvOMI50j7mixbCywm1BKmzOBw04HNVF8XgOrQAg5huxxB6NoVxkZeSq6gAuvQj8Vy9WcBn+g58xVcCGb80je7iM8MiEbhURpmEKPVNHxSlr4YKgInTjJrL3txKE1NDBx6FycQvFyFvK/YUw4UEos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752131648; c=relaxed/simple;
	bh=5fQOMq6JhnmsvgxFUq50HdHYFmRTYxKZ4vzuLcA43T8=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=O5Z9w4rU2kDiI/AwlMGCZexrMr3twdzHopTShTTyIAQsNsD1UCofUp/2g2yEmqvMw7jGvqbBUGxl76Y2n19woB1M3/9tnfMZFTdmeTIT8oKCxozkOOGf1lUzVp3hU/uiTWbLLNloA5jxfvQFRI0+E/+0Q+1JIj4Ga0TqusAjtWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PyoHTKL6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7351C4CEF6;
	Thu, 10 Jul 2025 07:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752131648;
	bh=5fQOMq6JhnmsvgxFUq50HdHYFmRTYxKZ4vzuLcA43T8=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=PyoHTKL6leJ/3r46CMvcb9x3yEkmOgmD0iPkLzmdxI8nr11KCQmcZjZnyHeLlCgUY
	 T9RyJxG1XNbav/TcKr39X//7FmHctBpGz5p4/57EpAaCZEzi1lqiyoXEkXzqXlg4MZ
	 jfWweMXOlVzX7SU2fpK8iqmglVC9892dJUWkIrRe5DEX39IFmxBNi+RbhO5nSglO0K
	 A7Tg1Fclz9vB/gB5T2fBHd1Hv1hqfE6PO+ZBfKdczCmdH7XZSrTj3TqKtvCr8BCm08
	 vbfPmauCLRQAe4yQhJsjHeubM2HPPsnjkGUQuH/i/l2wLF+NbgnUIf90BtecgLVQBe
	 4VdKBFc6Shl5Q==
Message-ID: <ad4f5b60c0fa5c2936713c93a9c17591@kernel.org>
Date: Thu, 10 Jul 2025 07:14:05 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 5/9] drm/bridge: add drm_bridge_is_last()
In-Reply-To: <20250709-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v1-5-48920b9cf369@bootlin.com>
References: <20250709-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v1-5-48920b9cf369@bootlin.com>
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

On Wed, 9 Jul 2025 18:48:04 +0200, Luca Ceresoli wrote:
> Some code needing to know whether a bridge is the last in a chain current=
ly
> call drm_bridge_get_next_bridge(). However drm_bridge_get_next_bridge()
> will soon increment the refcount of the returned bridge, which would make
> such code more annoying to write.
>=20
>=20
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

