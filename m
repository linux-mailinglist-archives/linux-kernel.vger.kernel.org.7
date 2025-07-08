Return-Path: <linux-kernel+bounces-720960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAD5AFC297
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B82177B138B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 06:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA43F220F22;
	Tue,  8 Jul 2025 06:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qbvQV5GO"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B85A203706
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 06:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751955709; cv=none; b=ANhlFZVIf4yqKClI3l6jNvKf+0oBO3mgqkcevQT++L61C3rO3SiMSt9cYDhuvcx6DgEy5AwkvpebzvfoGXTxwv0J9HoM28j7R81s0y5xFCHEZfQGZKVPBTyeF0+1Am9vKOMpje23NFq4yxaQeS2mpVwpCP796AtQ2MrqqmR75YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751955709; c=relaxed/simple;
	bh=33R+GWbRkCcFRuT6TnW5/Rd+oHQoKKa7kk9REqlshuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pVNa2NZSrayV23HTeL4mf07qzyYucgkD2i7fSxaB9UQFHvcKkDSsrkO5cDx+dcQlQ0JtRKN3p3fWYhmMET84seUSBOFlvKTTrPZ45rKCZ2A6ViNg6uruQBQW7Bx/UpcCQC57EBVC2PX+XeXN3t65SBUI44c1bfHR3ZmuVlkN5Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qbvQV5GO; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5686LF8g434666;
	Tue, 8 Jul 2025 01:21:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1751955675;
	bh=OkSWT05sAkPYcNvVGxqzgipPqYW0hlLg3aEwAB+Xfxc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=qbvQV5GOb7kq7B8SZ4dc42Tte4zsRA7HoLDvq0GdAnBlgXNUNXew9lFe4gRa79n99
	 2pW5X7OKFM0tKwDC54m4fipn8Sqh6ptWt7bc8FP6Hf15DcBz+kDbQmzYS0z9+31NMT
	 gaHgCd5EIlpewjxdNdYQXcOuXrPbY2ml0Z4oLNM4=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5686LEq02117160
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 8 Jul 2025 01:21:14 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 8
 Jul 2025 01:21:14 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 8 Jul 2025 01:21:14 -0500
Received: from [172.24.227.193] (devarsh-precision-tower-3620.dhcp.ti.com [172.24.227.193])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5686LBQs1282310;
	Tue, 8 Jul 2025 01:21:11 -0500
Message-ID: <85c13da7-89f4-48e6-8a52-17f4df7a58b5@ti.com>
Date: Tue, 8 Jul 2025 11:51:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/tidss: oldi: convert to devm_drm_bridge_alloc() API
To: Jayesh Choudhary <j-choudhary@ti.com>, <jyri.sarha@iki.fi>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <dri-devel@lists.freedesktop.org>,
        <tomi.valkeinen@ideasonboard.com>
CC: <airlied@gmail.com>, <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>
References: <20250701055002.52336-1-j-choudhary@ti.com>
Content-Language: en-US
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20250701055002.52336-1-j-choudhary@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 01/07/25 11:20, Jayesh Choudhary wrote:
> DRM bridges now uses "devm_drm_bridge_alloc()" for allocation and

s/uses/use

> initialization. "devm_kzalloc()" is not allowed anymore and it results
> in WARNING. So convert it.
> 
> Fixes: 7246e0929945 ("drm/tidss: Add OLDI bridge support")
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>

Reviewed-by: Devarsh Thakkar <devarsht@ti.com>

Regards
Devarsh

> ---
> 
> Warning log:
> <https://gist.github.com/Jayesh2000/e42c235bb57cb0f0af06c8c3bf886ef2>
> 
>   drivers/gpu/drm/tidss/tidss_oldi.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/tidss/tidss_oldi.c
> index 8223b8fec8ce..b0f99656e87e 100644
> --- a/drivers/gpu/drm/tidss/tidss_oldi.c
> +++ b/drivers/gpu/drm/tidss/tidss_oldi.c
> @@ -534,11 +534,10 @@ int tidss_oldi_init(struct tidss_device *tidss)
>   			continue;
>   		}
>   
> -		oldi = devm_kzalloc(tidss->dev, sizeof(*oldi), GFP_KERNEL);
> -		if (!oldi) {
> -			ret = -ENOMEM;
> -			goto err_put_node;
> -		}
> +		oldi = devm_drm_bridge_alloc(tidss->dev, struct tidss_oldi, bridge,
> +					     &tidss_oldi_bridge_funcs);
> +		if (IS_ERR(oldi))
> +			return PTR_ERR(oldi);
>   
>   		oldi->parent_vp = parent_vp;
>   		oldi->oldi_instance = oldi_instance;
> @@ -577,7 +576,6 @@ int tidss_oldi_init(struct tidss_device *tidss)
>   		/* Register the bridge. */
>   		oldi->bridge.of_node = child;
>   		oldi->bridge.driver_private = oldi;
> -		oldi->bridge.funcs = &tidss_oldi_bridge_funcs;
>   		oldi->bridge.timings = &default_tidss_oldi_timings;
>   
>   		tidss->oldis[tidss->num_oldis++] = oldi;

