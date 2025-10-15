Return-Path: <linux-kernel+bounces-853769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D651BDC90D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 07:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE8CC3AD966
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 05:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85512882CF;
	Wed, 15 Oct 2025 05:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tVm7KNK4"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DB43A8F7
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 05:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760504452; cv=none; b=Pcl1e+4Vkg6VpuATpHb7wiYows2nKGLkjIFDqMBKkx4CAixV/oi0GwvlLWe1JBu42GJw0MEVFzvytzplp+ERDHnn4Ef7sfhxzM/wUvd5fWgxSuQDnSfUEqz8DevR4HypD/kEx99cAIRgxf7dMoKc8cseXyVR8yDOWTBnIZI1RGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760504452; c=relaxed/simple;
	bh=vCKqXNlol2jYUyTPLQ01mGNBhW9jCfM+ve9Ps/TTE2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GG0nxuwCTY1PsNDHBmVpBcZGMyCBo7u2PQBq+61q+063Jx/6BOGH8i4NpyyEaMiOy8p3k8qNbL7hXPrOaFZll1Tnrr9qmSCYwjDH2jUbGit+7uTIXGNpuNvJC2qil6lFYk8BmDvaKAELuifxW1+QR64H5JTJUMPgOn8hgXvz+vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tVm7KNK4; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59F50LLL1759383;
	Wed, 15 Oct 2025 00:00:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760504421;
	bh=N8Nr/O2p1n7vNJNen7wumkPxZE0uRF+oLmO2lZv2enw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=tVm7KNK4YGzYE8mnZYC/eI5rIVgaEKTABn9PClCCGUggS+QdNjTS9Fs1bwuonVxOM
	 vbVqs5cQ5eKkwVXGjLWhE6aszantTZJ6wk7+D/EAdy3fx91CFqU350Ciq1uKHCM9tb
	 HSyWt2RPaU1oSdG7kXStPAl04p4BYw26JQzpaJuY=
Received: from DLEE215.ent.ti.com (dlee215.ent.ti.com [157.170.170.118])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59F50L1o145846
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 15 Oct 2025 00:00:21 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Oct
 2025 00:00:20 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Oct 2025 00:00:20 -0500
Received: from [10.249.128.221] ([10.249.128.221])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59F50DaA1332747;
	Wed, 15 Oct 2025 00:00:14 -0500
Message-ID: <7a158fa1-9a82-444c-a198-d90bf1ebf1fb@ti.com>
Date: Wed, 15 Oct 2025 10:30:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/tilcdc: Fix removal actions in case of failed probe
To: Kory Maincent <kory.maincent@bootlin.com>,
        Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>,
        Douglas Anderson <dianders@chromium.org>,
        Maxime Ripard <mripard@kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC: Bajjuri Praneeth <praneeth@ti.com>,
        Louis Chauvet
	<louis.chauvet@bootlin.com>,
        <thomas.petazzoni@bootlin.com>, Jyri Sarha
	<jyri.sarha@iki.fi>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20251014143229.559564-1-kory.maincent@bootlin.com>
Content-Language: en-US
From: Swamil Jain <s-jain1@ti.com>
In-Reply-To: <20251014143229.559564-1-kory.maincent@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Köry,
Thanks for the patch.

On 14-10-2025 20:02, Kory Maincent wrote:
> From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
> 
> The drm_kms_helper_poll_fini() and drm_atomic_helper_shutdown() helpers
> should only be called when the device has been successfully registered.
> Currently, these functions are called unconditionally in tilcdc_fini(),
> which causes warnings during probe deferral scenarios.
> 
> [    7.972317] WARNING: CPU: 0 PID: 23 at drivers/gpu/drm/drm_atomic_state_helper.c:175 drm_atomic_helper_crtc_duplicate_state+0x60/0x68
> ...
> [    8.005820]  drm_atomic_helper_crtc_duplicate_state from drm_atomic_get_crtc_state+0x68/0x108
> [    8.005858]  drm_atomic_get_crtc_state from drm_atomic_helper_disable_all+0x90/0x1c8
> [    8.005885]  drm_atomic_helper_disable_all from drm_atomic_helper_shutdown+0x90/0x144
> [    8.005911]  drm_atomic_helper_shutdown from tilcdc_fini+0x68/0xf8 [tilcdc]
> [    8.005957]  tilcdc_fini [tilcdc] from tilcdc_pdev_probe+0xb0/0x6d4 [tilcdc]
> 
> Fix this by moving both drm_kms_helper_poll_fini() and
> drm_atomic_helper_shutdown() inside the priv->is_registered conditional
> block, ensuring they only execute after successful device registration.
> 
> Fixes: 3c4babae3c4a ("drm: Call drm_atomic_helper_shutdown() at shutdown/remove time for misc drivers")
> Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
> ---

I would suggest the same, as Maxime mentioned to improve the driver to 
replace the deprecated functions with better alternatives. But as you 
mentioned, you are working on improving the driver and for now to remove 
unwanted warnings it is good to have this patch in drm misc next.

Reviewed-by: Swamil Jain <s-jain1@ti.com>

---
Regards,
Swamil>   drivers/gpu/drm/tilcdc/tilcdc_drv.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> index 7caec4d38ddf..2031267a3490 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> @@ -172,11 +172,11 @@ static void tilcdc_fini(struct drm_device *dev)
>   	if (priv->crtc)
>   		tilcdc_crtc_shutdown(priv->crtc);
>   
> -	if (priv->is_registered)
> +	if (priv->is_registered) {
>   		drm_dev_unregister(dev);
> -
> -	drm_kms_helper_poll_fini(dev);
> -	drm_atomic_helper_shutdown(dev);
> +		drm_kms_helper_poll_fini(dev);
> +		drm_atomic_helper_shutdown(dev);
> +	}
>   	tilcdc_irq_uninstall(dev);
>   	drm_mode_config_cleanup(dev);
>   


