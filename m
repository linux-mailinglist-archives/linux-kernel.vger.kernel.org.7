Return-Path: <linux-kernel+bounces-725079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A05AFFA97
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36E3C5479EC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E90288512;
	Thu, 10 Jul 2025 07:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFiMwCD0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6442882B9;
	Thu, 10 Jul 2025 07:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752131668; cv=none; b=pYQC6dP2FOgOn3nYUYSQwk7FPpe1HzR6JIboExbdUhiqAN1RmoluChq+/TMLAZorE9K4eqofUezi2OnVP+UnGRSlvhbpe9r9Mculvp8k2Ao8zrsQ/dn4kOkzd+/Jz9RXbHOTGlpVIAI8DNiHqQx4fNh7Vy5IAn1rwRqb7Eir7JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752131668; c=relaxed/simple;
	bh=tP+8bldkAQNqJdv4sqZNu7H5cEZhw5wYrPA9vUNr0mo=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=PvbDxGYU3VapO4Sp/xxy6JCv0ASBDcEeIi/WAR+DsJYvSOpH7qXiaxC8RFc06CRX5Syf7eFeTBBfQfpzbmah9cNueba0q1JvE3vjFPBw0JZLXWnsJAgqwQNGgvEh/DkKHSgZZ9urGpMPtKPTE7niowfhh5rvq8Ls5vOiIqtBIWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sFiMwCD0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D15C4CEF6;
	Thu, 10 Jul 2025 07:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752131668;
	bh=tP+8bldkAQNqJdv4sqZNu7H5cEZhw5wYrPA9vUNr0mo=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=sFiMwCD0Y2Z9UW0eLCtW626dxI748arN+PuRycIknSn+6NkgxZqVDaacCIVF/QlJK
	 OUIopgZEnY6OEBcGbsMJGQ8tU0kO1iUhRyoJ+bP+Pf8Id9qPHRGxh06RSS0VfbJlak
	 +lg50+GFgLIUfAyhSG9XGmvA8FGJO1o4Tpxl91RHewW22qA8KHtK7fmOkBUirI98Zn
	 7kJsOWH1URzv1l/RNa4CjJN54FX4KntaPz5wMOG+XbPwerR/y92+9+j1UZ0h5MhtKf
	 IVYhZ1Cpoi6D2IrEvMD2PcmnvXOaXP0Jl3aw7HcrZFDqLVyEgt1DiYpyLQR74uxzqq
	 zaijhGa6tO1VQ==
Message-ID: <64be94fba98675539bf02b1dc4c66e0d@kernel.org>
Date: Thu, 10 Jul 2025 07:14:23 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 6/9] drm/display: bridge_connector: use
 drm_bridge_is_last()
In-Reply-To: <20250709-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v1-6-48920b9cf369@bootlin.com>
References: <20250709-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v1-6-48920b9cf369@bootlin.com>
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
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Wed, 9 Jul 2025 18:48:05 +0200, Luca Ceresoli wrote:
> Simplify code to know whether a bridge is the last in the chain by using
> drm_bridge_is_last().
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

