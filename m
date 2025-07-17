Return-Path: <linux-kernel+bounces-735009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B0BB08968
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17A5A170A29
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA3328935C;
	Thu, 17 Jul 2025 09:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bqWLdI83"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC50635
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 09:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752745072; cv=none; b=aiZ6dcsBUsENTUaY5uIGSrS0BGUPVuAlMCv1N8Do8eN/rl+qIUnw7cZt9Pm8Gy6vpjuUpQ1AogDH9U+40kbHm53F0AR5E34JYohhaaMDokDqVL4SOMZFhlWNdamAWIl6vyQ/t0u8bW2GRTl7yxsx4S+orAbRw/lD/X6VjgrzjkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752745072; c=relaxed/simple;
	bh=GbK2yVCCDDiG6f9NqPxCDdSWHw8yuMPwK1X0I1wo5Sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JQ03TVyX5yLxspfRh+1zeBznmWy4LM2wUsOl25WySxKs3x+OHUaLQ2b8Bhwf4dlGeLSklVTGM6rVH1edUfW4rl3ZTWbKJmBYrpmpMKLPi6TMJoBBHxktWVtEMrlWxKREHoG5TP4Xonq+VUv9xzljlbYXrlSUz5v2ZR07YATM7iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bqWLdI83; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56H9b60e2705714;
	Thu, 17 Jul 2025 04:37:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752745026;
	bh=grVloWar2O621fo+lHDBYQS6zJaquwGGstUgJpQKtxI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=bqWLdI83FpU0lpfxPEaArnuH/G6gIqCUioxaySxEYehblTjj1rEGffjtNwJhNDC7x
	 GIGPl4rGSOjYyF4bWbpIai6ox4QPEhcWgWDjeceje+nkyXfR7ddQB6M6jipgM7OcoW
	 IaK4tvBOmfm1d4DyTRiUjKIlH6ujF0GWx2n1Hg/A=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56H9b5Io2698835
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 17 Jul 2025 04:37:05 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 17
 Jul 2025 04:37:05 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 17 Jul 2025 04:37:05 -0500
Received: from [172.24.227.193] (devarsh-precision-tower-3620.dhcp.ti.com [172.24.227.193])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56H9awA31949552;
	Thu, 17 Jul 2025 04:36:59 -0500
Message-ID: <8728de80-f154-46fa-a8a6-da40cb5fdc65@ti.com>
Date: Thu, 17 Jul 2025 15:06:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/17] drm/bridge: cdns-dsi: Don't fail on
 MIPI_DSI_MODE_VIDEO_BURST
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Jyri Sarha
	<jyri.sarha@iki.fi>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Vinod Koul
	<vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Andrzej Hajda
	<andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert
 Foss <rfoss@kernel.org>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej
 Skrabec <jernej.skrabec@gmail.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Dmitry Baryshkov <lumag@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>,
        Francesco Dolcini <francesco@dolcini.it>,
        Aradhya Bhatia <aradhya.bhatia@linux.dev>,
        Parth Pancholi
	<parth.pancholi@toradex.com>
References: <20250618-cdns-dsi-impro-v4-0-862c841dbe02@ideasonboard.com>
 <20250618-cdns-dsi-impro-v4-17-862c841dbe02@ideasonboard.com>
Content-Language: en-US
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20250618-cdns-dsi-impro-v4-17-862c841dbe02@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Tomi

Thanks for the patch.

On 18/06/25 15:29, Tomi Valkeinen wrote:
> While the cdns-dsi does not support DSI burst mode, the burst mode is
> essentially DSI event mode with more versatile clocking and timings.
I don't fully agree with this statement, DSI burst mode and DSI event 
mode are two different things having separate requirements. DSI burst 
mode maps to MIPI_DSI_MODE_VIDEO_BURST. I don't see a separate flag for 
event mode but I guess,

> Thus cdns-dsi doesn't need to fail if the DSI peripheral driver requests
> MIPI_DSI_MODE_VIDEO_BURST.

MIPI_DSI_MODE_VIDEO_BURST is currently not supported by the cadence DSI 
host driver, so only if DSI peripheral driver is saying that burst mode 
is the only one it supports in that case only we should fail.

> 
> In my particular use case, this allows the use of ti-sn65dsi83 driver.
> 
> Tested-by: Parth Pancholi <parth.pancholi@toradex.com>
> Tested-by: Jayesh Choudhary <j-choudhary@ti.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>   drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> index 114d883c65dc..09b289f0fcbf 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> @@ -1052,10 +1052,6 @@ static int cdns_dsi_attach(struct mipi_dsi_host *host,
>   	if (output->dev)
>   		return -EBUSY;
>   
> -	/* We do not support burst mode yet. */
> -	if (dev->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
> -		return -ENOTSUPP;
> -

Removing this check also gives a false impression that burst mode is 
supported by the driver and can also lead to failures too in case device 
is only supporting burst mode.

I think it makes sense to fail only if burst mode is the only one being 
supported by the device, something like below should work I believe,

if (dev->mode_flags & MIPI_DSI_MODE_VIDEO_BURST == 
MIPI_DSI_MODE_VIDEO_BURST)
		return -ENOTSUPP;

Regards
Devarsh

>   	/*
>   	 * The host <-> device link might be described using an OF-graph
>   	 * representation, in this case we extract the device of_node from
> 

