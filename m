Return-Path: <linux-kernel+bounces-775920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9E9B2C673
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACAD17219C0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC59343D6A;
	Tue, 19 Aug 2025 13:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3nxfmbW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BDE343215;
	Tue, 19 Aug 2025 13:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755611932; cv=none; b=Iu3rtEqOKAwO2WKVx+ASalO6JzCY5Y59BTKYv4PwW9ytDt5e3OKPBjaL1Dat9st7HI9s+eVXNUOpZdWMIne7Vohyk82AU3kwWjPEH/OFQ4kjw9gdXrpBVe3bzUiKkN4h97CwSnQ2gzlR0KSA4ZsvR77ms2P8HbcJQDJGZ7d9ovs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755611932; c=relaxed/simple;
	bh=lGALG2x3T//Hs0NSa99qVBWekgVznZxRh9n5n0vE+ME=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=FtO6go3KvIyR12bE70Ju8IWZcPT31Z29DfVa+K/wkKip+HCtkgkhJHEVmBTCWdTWcN0cQ6xrLxlF8a4i7TryNRs7z7qSaaRBGICJmNwZO963oP99CCQ3V82QHzx8Hq9VcS9w9M6nmRaM4vNI5Xk4G3UQJdltr42Q+YYB8FXcQXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3nxfmbW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4CAC4CEF1;
	Tue, 19 Aug 2025 13:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755611932;
	bh=lGALG2x3T//Hs0NSa99qVBWekgVznZxRh9n5n0vE+ME=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=i3nxfmbWhXRRp9ugYwK2TdPPUdQf1WlzVb4O/5XokxjtTbmAJADofa8z96YOVWwxD
	 SYffRWoG7t6brh3eLfyZ+AGacdnSyolOLCvlE2dj60GHnbQMOfhg1pJp+Wsi1NAVDm
	 WeaNzcJIQRbHGz5DAE6HQGPEFvPmA1tOlaAnrAEntx3Tuvg40MBXDr/xlglec8sfPF
	 /XH80kCaKV7PNziV3N657nm6TldxWyjhjZh/xeoOAAI8ocjagPwi19/s+BLSVZzZa+
	 +E29gJTNyCbIbpnxirGn10W3/7dhW6vYTygKtvbvuX7k7pjLo4Nex4h1SIHktERV9u
	 ngB8pcTA0HvCg==
Message-ID: <078a95b5a85cbf73bcbeb9e110b2bac2@kernel.org>
Date: Tue, 19 Aug 2025 13:58:49 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v2 9/9] drm/imx: parallel-display: put the bridge
 returned by drm_bridge_get_next_bridge()
In-Reply-To: <20250801-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v2-9-888912b0be13@bootlin.com>
References: <20250801-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v2-9-888912b0be13@bootlin.com>
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

On Fri, 1 Aug 2025 19:05:31 +0200, Luca Ceresoli wrote:
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

