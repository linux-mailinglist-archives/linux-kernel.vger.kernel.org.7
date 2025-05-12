Return-Path: <linux-kernel+bounces-643617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFFAAB2F6F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 08:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40D2C17538D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 06:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03199255238;
	Mon, 12 May 2025 06:17:58 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FE6192B90
	for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 06:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747030677; cv=none; b=LZHNxpiUnEHWUTFoJfMg+6O0WUx23EHdZcPHAlHVQ9CWCaVL35Gn5iU9zuU3VhhxQgLL4ueZKmakph8uVTpYeq5agXmQdUwoyfb6ert72iqB87iTeca+rU1Q4JZUM5TYAsyqdRnrtJFoBm6oKTmSpmybUiOfIYDe6zj0lq607sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747030677; c=relaxed/simple;
	bh=X6l2NY96xDhiFItBX2VqZRO1nDIzDA+IKenMV0QTV3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4Vi3HmuAFlGccJGDbiAcsXTiMu0Fcf0V9owb8ywu8UfLFyaanfNQic3AomWMOlz6Ww4ucEd8wu11kfJWnXTKIEjIxJDZ4ijk4nGu3nLGNv0qNL89dftAjGP/TbB5PtWhZ/uFjvTiPSysvgRAoBRSXDW4GAA3TX2DKGCxIlNm88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1uEMTu-0002PJ-UB; Mon, 12 May 2025 08:17:42 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1uEMTu-002KAO-0e;
	Mon, 12 May 2025 08:17:42 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1uEMTu-000RQ1-08;
	Mon, 12 May 2025 08:17:42 +0200
Date: Mon, 12 May 2025 08:17:42 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dong Aisheng <aisheng.dong@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 2/3] pinctrl: imx-scmi: Get daisy register offset from DT
Message-ID: <aCGShsaItUTf2Z14@pengutronix.de>
References: <20250512-pin-v1-0-d9f1555a55ad@nxp.com>
 <20250512-pin-v1-2-d9f1555a55ad@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512-pin-v1-2-d9f1555a55ad@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mon, May 12, 2025 at 10:14:15AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Parsing the "nxp,iomuxc-daisy-off" to get the daisy register offset,
> then no need to hardcode the register offset in driver for new SoCs.
> 
> To keep backwards comatibility, still keep the register offset for i.MX95.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/pinctrl/freescale/pinctrl-imx-scmi.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 
> @@ -315,6 +307,18 @@ static int scmi_pinctrl_imx_probe(struct scmi_device *sdev)
>  	if (!pmx)
>  		return -ENOMEM;
>  
> +	ret = device_property_read_u32(dev, "nxp,iomuxc-daisy-off", &pmx->daisy_off);

"off" is really a poor acronym for "offset" as it unnecessarily confuses
the reader by suggesting this is about turning some feature off. Please
add the three bytes and just call it offset.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

