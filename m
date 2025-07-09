Return-Path: <linux-kernel+bounces-722975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C08AFE14C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 446281886ACB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 07:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F312701AB;
	Wed,  9 Jul 2025 07:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzZlOOem"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3941EA73;
	Wed,  9 Jul 2025 07:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752046200; cv=none; b=jcUeYG57eXnJjKJkTCJ7qvdKwm7glvq7kOyq+smuZpkWWU7S2FNj7Gl81rNvs14FhY9MEbroEX6PZvXxCBw1ujQ8igXLUkYnYSEgr8UYuUUvtmhl3wilMTQ7IDx6PaRe22ztMvSQuAppF9azz4CbcTdv4/ectWFZ627VqRdcJHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752046200; c=relaxed/simple;
	bh=mesKawbAqGOsh7bohcTkyaAxH/esyPJDz/sQbVjit0Y=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=bplDiAHW0d9wtf6KCZ40F6k2XF46JsTJPg1p2X8oqS2ZYMuCVsDKdn+IWIjqG7HooFJyMzzOkyW1j7pAvV6H/njU+v3HTAO3tesmQcBS9UqrSMSty3QOUm0prRTPXB+Sql+iOq/6/x69vdmrEOQ3QHPNaXzNFASwbMzVShqN88M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzZlOOem; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E28AC4CEF0;
	Wed,  9 Jul 2025 07:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752046199;
	bh=mesKawbAqGOsh7bohcTkyaAxH/esyPJDz/sQbVjit0Y=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=rzZlOOemBNXpeusjY0UrbQO/c5QAsb36WqTetr2iL0Lq5uA907BSKf/xcgxFM7IQC
	 qjjtpQXn9/ADEjnNHaI2wg4Jfq6ZTxV6OfJoCt7p/RxaW+l1dI06C5QLbsPKC0ndQG
	 +9zEKOZ7vWzLKfeIaQdxNbdnsQ/7HtVfJHeDAiALy5Av8twX67E9sQ/QHpRDCHJZ0B
	 Nz+8MdUoS8Uo/SLI4mmzOKRD4BcEig5HmCif7zKeIjdIVNYdW7nJZ66OzFaNAa4c6H
	 soTFho4+NP36L2+ZjY4LVanxNLtaC8dNojW+m5v2/y17Fq+kcWZJvdmHYRGj2Dhx1/
	 5aHrlnkxlDoFQ==
Message-ID: <346bd17a09abc913bcb2565137aa93fc@kernel.org>
Date: Wed, 09 Jul 2025 07:29:56 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v9 3/5] drm/mxsfb: put the bridge returned by
 drm_bridge_chain_get_first_bridge()
In-Reply-To: <20250708-drm-bridge-alloc-getput-drm_bridge_chain_get_first_bridge-v9-3-db1ba3df7f58@bootlin.com>
References: <20250708-drm-bridge-alloc-getput-drm_bridge_chain_get_first_bridge-v9-3-db1ba3df7f58@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, "Andrzej
 Hajda" <andrzej.hajda@intel.com>, "David Airlie" <airlied@gmail.com>, "Fabio
 Estevam" <festevam@gmail.com>, "Hui Pu" <Hui.Pu@gehealthcare.com>, "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, "Jonas Karlman" <jonas@kwiboo.se>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Liu Ying" <victor.liu@nxp.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Marek Vasut" <marex@denx.de>, "Maxime
 Ripard" <mripard@kernel.org>, "Neil Armstrong" <neil.armstrong@linaro.org>, "Pengutronix
 Kernel Team" <kernel@pengutronix.de>, "Robert Foss" <rfoss@kernel.org>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, "Shawn Guo" <shawnguo@kernel.org>, "Simona
 Vetter" <simona@ffwll.ch>, "Stefan Agner" <stefan@agner.ch>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Tue, 8 Jul 2025 17:48:20 +0200, Luca Ceresoli wrote:
> The bridge returned by drm_bridge_chain_get_first_bridge() is
> refcounted. Put it when done. Use a scope-based free action to catch all
> the code paths.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

