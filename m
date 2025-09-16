Return-Path: <linux-kernel+bounces-818703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B48BB5956A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ED764E16AC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2B030748F;
	Tue, 16 Sep 2025 11:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="vIWVq06o"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B8D30748C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758022825; cv=none; b=nz25HeH7x8paU5/VKIhZk3TDhgfgv7mmZHeREFvAHlHUiZfZYH5756OD4L17AxK6tFVwiXQUI81pL/uCI4eXyUgv7BnH58yXkByG8nWQcJblnusOiUhYCXUoXg8GPDnIBXplUUGzWBj3/pa9abkeNxaOs6pfuVgEbCpW9KuLwec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758022825; c=relaxed/simple;
	bh=DWGsCJBwWSfp0jBKDSajSLRJIJmy7F7Xb4M4dO4geHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UXphp7nrCkHWII/bmruEk+lHMz6A4E+NWXZnzLqMdclVHuYZAFJ3uh051pdu84Cqw8+AA3YRqJfUWM8dmP84npsC3Ven7aHjX/Q+sKAtpnKEt0PdXF2LXz2PoSkd/i+2cOI7Tpxk0Cob5JUxC8FQOgVAwy5vQ2+x0Jwje57HrKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=vIWVq06o; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0AEE26DF;
	Tue, 16 Sep 2025 13:38:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1758022741;
	bh=DWGsCJBwWSfp0jBKDSajSLRJIJmy7F7Xb4M4dO4geHU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vIWVq06o8Qsf5JUCCJ63t+CddeCNfTrge/j8ZFdT0DKxukC70BPMQOa9Q1DipAok4
	 3j2CqyUPjgfnX9bu+Bt08NntVqC4zIyVQTA73T2328rJN/jnM2HX4iXEcioqqxEMZS
	 5QqQptkGsUTlvpK/eMgQk48/ihAtmohvpKhqMQ+4=
Message-ID: <a306a386-bbd9-408c-b76d-0ecebc1f32ae@ideasonboard.com>
Date: Tue, 16 Sep 2025 14:40:13 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] drm/tidss: oldi: Add property to identify OLDI
 supported VP
To: Swamil Jain <s-jain1@ti.com>
Cc: h-shenoy@ti.com, devarsht@ti.com, vigneshr@ti.com, praneeth@ti.com,
 u-kumar1@ti.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, jyri.sarha@iki.fi,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, aradhya.bhatia@linux.dev
References: <20250911110715.2873596-1-s-jain1@ti.com>
 <20250911110715.2873596-2-s-jain1@ti.com>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <20250911110715.2873596-2-s-jain1@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11/09/2025 14:07, Swamil Jain wrote:
> From: Jayesh Choudhary <j-choudhary@ti.com>
> 
> TIDSS should know which VP has OLDI output to avoid calling clock
> functions for that VP as those are controlled by oldi driver. Add a
> property "is_ext_vp_clk" to "tidss_device" structure for that. Mark it
> 'true' in tidss_oldi_init() and 'false' in tidss_oldi_deinit().
> 
> Fixes: 7246e0929945 ("drm/tidss: Add OLDI bridge support")

What bug does this fix? It's just adding a new field which it sets to
true/false...

 Tomi

> Tested-by: Michael Walle <mwalle@kernel.org>
> Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> Signed-off-by: Swamil Jain <s-jain1@ti.com>
> ---
>  drivers/gpu/drm/tidss/tidss_drv.h  | 2 ++
>  drivers/gpu/drm/tidss/tidss_oldi.c | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_drv.h b/drivers/gpu/drm/tidss/tidss_drv.h
> index 84454a4855d1..e1c1f41d8b4b 100644
> --- a/drivers/gpu/drm/tidss/tidss_drv.h
> +++ b/drivers/gpu/drm/tidss/tidss_drv.h
> @@ -24,6 +24,8 @@ struct tidss_device {
>  
>  	const struct dispc_features *feat;
>  	struct dispc_device *dispc;
> +	bool is_ext_vp_clk[TIDSS_MAX_PORTS];
> +
>  
>  	unsigned int num_crtcs;
>  	struct drm_crtc *crtcs[TIDSS_MAX_PORTS];
> diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/tidss/tidss_oldi.c
> index 7688251beba2..7ecbb2c3d0a2 100644
> --- a/drivers/gpu/drm/tidss/tidss_oldi.c
> +++ b/drivers/gpu/drm/tidss/tidss_oldi.c
> @@ -430,6 +430,7 @@ void tidss_oldi_deinit(struct tidss_device *tidss)
>  	for (int i = 0; i < tidss->num_oldis; i++) {
>  		if (tidss->oldis[i]) {
>  			drm_bridge_remove(&tidss->oldis[i]->bridge);
> +			tidss->is_ext_vp_clk[tidss->oldis[i]->parent_vp] = false;
>  			tidss->oldis[i] = NULL;
>  		}
>  	}
> @@ -580,6 +581,7 @@ int tidss_oldi_init(struct tidss_device *tidss)
>  		oldi->bridge.timings = &default_tidss_oldi_timings;
>  
>  		tidss->oldis[tidss->num_oldis++] = oldi;
> +		tidss->is_ext_vp_clk[oldi->parent_vp] = true;
>  		oldi->tidss = tidss;
>  
>  		drm_bridge_add(&oldi->bridge);


