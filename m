Return-Path: <linux-kernel+bounces-755112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E34B1A16C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8EC41886154
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 12:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB95258CEF;
	Mon,  4 Aug 2025 12:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mDEInrEL"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003C424502C
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 12:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754310590; cv=none; b=gjaabXvnvjR3W5kpePS6Nm+m+jAvPUEUR27H/GN6gQyaK+bgrbjY/apzaUWmE1r6yHq6wgj57TjtmTpb2Mlsdi4WM/L9xihh/ee5wla3QbQ45ZhGYy/zFYacEms/ZhLdZO7yOVKwctVEd+w2cAuQOmwjF/ZCc5tFyianp5S78W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754310590; c=relaxed/simple;
	bh=4IgNvZ6G4kfzEtJr9T7I01xrlCdqSwSMulF7NEZfjwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:In-Reply-To:
	 Content-Type:References; b=ldVpeQBU2y5WAMe+qHScGFSLNyydKuzLdDCP/5xz/RyQ1C1sZvGC+HmjRVJayHLmTnbHE1LZOl4l2yRB2EsFWkduVLEq/2nuyyt04W1G9LxopUp+OKzsCb4QkT3uWRSuXNGU3VANVXnYtgJzmhbinKJfS21C3d6yEXAC7vJZbMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=mDEInrEL; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250804122946euoutp01c9ee7f1ddd89a71e0a586265b2ca6035~YkC7piJ-u0405804058euoutp01c
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 12:29:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250804122946euoutp01c9ee7f1ddd89a71e0a586265b2ca6035~YkC7piJ-u0405804058euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754310586;
	bh=gjGB41TXtm7EJnthNQJ5AzH/mdp0g+a0I4A+4VD5ihE=;
	h=Date:Subject:To:From:In-Reply-To:References:From;
	b=mDEInrELoNLfcEi0qQqGhoPscJPLbfywfONf9iwGjom7/m4P2oaBgltCT5rqQPzBK
	 FozQsBa/llzQ/kvf8ivuYsRC0I9t8zrPeI/XhCdQCfdnsXMNt8mPl+9riL/FWohqKH
	 dVHrxQLzpSeIU/L1jePSWmNJd46TmuBdxf1eaGYg=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250804122945eucas1p2078d2152e2306b4b5fea70c11d6408e0~YkC7GTraK0290002900eucas1p2B;
	Mon,  4 Aug 2025 12:29:45 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250804122943eusmtip25bc1a12bb6a7913207f8a655cad8e263~YkC5rdxV30364903649eusmtip2Q;
	Mon,  4 Aug 2025 12:29:43 +0000 (GMT)
Message-ID: <e0121a48-1a69-453b-b58b-8e282956165b@samsung.com>
Date: Mon, 4 Aug 2025 14:29:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] drm/bridge: samsung-dsim: Fix potential double-free in
 TE GPIO handling
To: Miaoqian Lin <linmq006@gmail.com>, Inki Dae <inki.dae@samsung.com>,
	Jagan Teki <jagan@amarulasolutions.com>, Andrzej Hajda
	<andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, Jernej
	Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Marek Vasut <marex@denx.de>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250804122418.104360-1-linmq006@gmail.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250804122945eucas1p2078d2152e2306b4b5fea70c11d6408e0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250804122429eucas1p29db20ca392de43a1d6c113dcd4b1b47d
X-EPHeader: CA
X-CMS-RootMailID: 20250804122429eucas1p29db20ca392de43a1d6c113dcd4b1b47d
References: <CGME20250804122429eucas1p29db20ca392de43a1d6c113dcd4b1b47d@eucas1p2.samsung.com>
	<20250804122418.104360-1-linmq006@gmail.com>

On 04.08.2025 14:24, Miaoqian Lin wrote:
> The devm_gpiod_get_optional() function uses device-managed resources that
> are automatically cleaned up. The
> gpiod_put() calls in both the error path of samsung_dsim_register_te_irq()
> and in samsung_dsim_unregister_te_irq() are redundant and may lead to
> double-free when the device is removed.
>
> Fixes: e7447128ca4a ("drm: bridge: Generalize Exynos-DSI driver into a Samsung DSIM bridge")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/gpu/drm/bridge/samsung-dsim.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
> index bccc88d25948..6ffaee6b7738 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -1691,7 +1691,6 @@ static int samsung_dsim_register_te_irq(struct samsung_dsim *dsi, struct device
>   				   IRQF_TRIGGER_RISING | IRQF_NO_AUTOEN, "TE", dsi);
>   	if (ret) {
>   		dev_err(dsi->dev, "request interrupt failed with %d\n", ret);
> -		gpiod_put(dsi->te_gpio);
>   		return ret;
>   	}
>   
> @@ -1790,10 +1789,8 @@ static int samsung_dsim_host_attach(struct mipi_dsi_host *host,
>   
>   static void samsung_dsim_unregister_te_irq(struct samsung_dsim *dsi)
>   {
> -	if (dsi->te_gpio) {
> +	if (dsi->te_gpio)
>   		free_irq(gpiod_to_irq(dsi->te_gpio), dsi);
> -		gpiod_put(dsi->te_gpio);
> -	}
>   }
>   
>   static int samsung_dsim_host_detach(struct mipi_dsi_host *host,

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


