Return-Path: <linux-kernel+bounces-740936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DE6B0DBD5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD70A1C82728
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2982EA482;
	Tue, 22 Jul 2025 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="T833uzle"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72BFA32
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 13:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192406; cv=none; b=FnjWJAuGixJnEdwNbciiqUfIm2s+1cJGQM63p0Q9MTH6SpPRqbqzsjRc08S7lTo3H8yVlBYnJSofJ38whzoNrOxVDpOzGkhCTX0VbyCeatRAJdcEhnV54tl+kwyytyOuU8ETaZlMsU/FpLlkI+puszQcEo45Qu/WEdbzmUYVO5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192406; c=relaxed/simple;
	bh=gLs8DLkSNDPYVzQRcLvDQWE6moUtnjD433scJBssL6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fvGf6TG8CFVuoCrNHqlm5azBeZuWtY9uM2xCvoSLum6oYfXhGdNRM18lJ33Fo6s47251HYDUIH69NcfoJap7eO16hxyL4JhBWcIrpvf0+dxl75yRQGW2vY5PGZXuK1X6Ymi6nT94cpXZ6XaHVFl8gycYINlDvDAcF7Y/bFgs9Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=T833uzle; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56MDr30i1505092;
	Tue, 22 Jul 2025 08:53:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753192383;
	bh=3s9CkiQa9+HRJ9rELxLfOTmBRDrIuEscGfUEDrBugko=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=T833uzlejDr5cP/D2R9kcIcigAdJKhK5YJXi79zwbeayCHRj5jCnrnwb+SbSchVMD
	 cUImvfiwk/67r9n6PubxL9pN6HBbKaSbFU+hcMWMQaKiDT313EtL0EvjqBPNbe6CrH
	 Dif8FU4TCUBYTrlxJ6sin5Rp0KvJDYj92DoRegoc=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56MDr2lp2136700
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 22 Jul 2025 08:53:02 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 22
 Jul 2025 08:53:01 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 22 Jul 2025 08:53:01 -0500
Received: from [172.24.227.193] (devarsh-precision-tower-3620.dhcp.ti.com [172.24.227.193])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56MDqu2G1422371;
	Tue, 22 Jul 2025 08:52:57 -0500
Message-ID: <d1906219-f588-47f0-a43e-c2db4f9c3cae@ti.com>
Date: Tue, 22 Jul 2025 19:22:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: Remove extra semicolon in
 ti_sn_bridge_probe()
To: Douglas Anderson <dianders@chromium.org>,
        <dri-devel@lists.freedesktop.org>
CC: kernel test robot <lkp@intel.com>,
        Andrzej Hajda
	<andrzej.hajda@intel.com>,
        David Airlie <airlied@gmail.com>,
        Jayesh Choudhary
	<j-choudhary@ti.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas
 Karlman <jonas@kwiboo.se>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Neil
 Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>, Simona
 Vetter <simona@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        <linux-kernel@vger.kernel.org>
References: <20250714130631.1.I1cfae3222e344a3b3c770d079ee6b6f7f3b5d636@changeid>
Content-Language: en-US
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20250714130631.1.I1cfae3222e344a3b3c770d079ee6b6f7f3b5d636@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 15/07/25 01:36, Douglas Anderson wrote:
> As report by the kernel test robot, a recent patch introduced an
> unnecessary semicolon. Remove it.
> 
> Fixes: 55e8ff842051 ("drm/bridge: ti-sn65dsi86: Add HPD for DisplayPort connector type")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202506301704.0SBj6ply-lkp@intel.com/
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Devarsh Thakkar <devarsht@ti.com>

Regards
Devarsh
> ---
> 
>   drivers/gpu/drm/bridge/ti-sn65dsi86.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> index de9c23537465..834b42a4d31f 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -1373,7 +1373,7 @@ static int ti_sn_bridge_probe(struct auxiliary_device *adev,
>   			regmap_update_bits(pdata->regmap, SN_HPD_DISABLE_REG,
>   					   HPD_DISABLE, 0);
>   		mutex_unlock(&pdata->comms_mutex);
> -	};
> +	}
>   
>   	drm_bridge_add(&pdata->bridge);
>   


