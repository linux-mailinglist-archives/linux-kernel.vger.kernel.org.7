Return-Path: <linux-kernel+bounces-868756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E38B7C060AC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D4D03B5CAB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E040279918;
	Fri, 24 Oct 2025 11:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niayEyWW"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11DB275864
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761305352; cv=none; b=II3zuNfDuGNrYosr+FE4MwNcbOtR1/qCDr3m1cBGKwSOejkMl0uq9f8Ue1Iu4lOg30RwA6bU2av4OrBwWNSafhvXtl+Mq+sbzyjCKH+Rg4kRmCpM8u0RVqSOAZUCszx7QEXb1Pw4N+AUmzk0tRjg3L0UsshkMjZAP8lAbHtK754=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761305352; c=relaxed/simple;
	bh=TrBaGBhRlDGf/oFozNzPjl2vxSq6m/EPCkCnukf9mcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tw4zSzKKxPU006eRTrhOlPO9BvbJXxXtHi58WkGf2BMf+cQ48ctmR/q3tGhDWWVu6xHkMwR2TTDMovYGoyxxQAPyGNGTDzWhJyPWWtJJQO9D+yLUV1G8688stxZSLTIokbHRG50+XtC2Q30EKilZtDKaGcMd3AFDAWv+ORtPiX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=niayEyWW; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso1961868f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 04:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761305349; x=1761910149; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9xMJQfYM2b5QJELS93NnB9DkzeOAVYdK40Nq6yQs7Sw=;
        b=niayEyWWRvynnqfLko/3i3XXCOQFBVNJprmDbvDo3Ck/+FVdD5ZH9cxVnGJ19wOpwE
         rfl6gkcPeg1dCqd8hs48okpZKCuhVPfDgNqsHqquJofy+d+sJ1lpzPyqC/cwrsUV2Hot
         E4P6pGmeo8oRfW7Ahmx5g2VjFFrzi+pS9u6Bq5Xr71Xqrv2e7nKKT422wRgTPbmhD9HB
         nATU6rofGeJAvQi/JNHnZh7gJ5BdR0qIkf8FpQUqLP2+zEheDQspGA+uxT4KxggQRgjp
         oXnTZ+oA+GTUVSTEBUhu7JgXTWzzaC9B6QDjW4aVEy2VjF3+I3Q0KLCRjoV2rUMe5yVg
         Na2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761305349; x=1761910149;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9xMJQfYM2b5QJELS93NnB9DkzeOAVYdK40Nq6yQs7Sw=;
        b=oBLvK1fz5A8dLDazZ2ggaa7e1UNZCtwBMww61ihJdO0+rX5BnW3K/TcI/tGjvJSIAO
         9fbaercvqBRlUBY5Ml115rfK/J69hTw6Pv4KSbTimn3SViUTP4Ohd4X72uYqUgQULcWV
         xJtL+ggN0DD9q4lsON/qudh9UEN66+FuN8EwR82X6MiFGzJLLssinBIVFL1UcVTsJFMA
         ZLdG0uxRcAC5xSrhNKfb/17E4O7ax3kzEnOa2qbpv807dgzTEDhnnFnhAkDKKJdZHbpM
         z+FhICZTFWL8DHvTWzSFBwG4UZU+DdzCP7oIlBYJU8Nb2UT2ZoHewT2Wn71MVcdXx0CW
         8Pbw==
X-Forwarded-Encrypted: i=1; AJvYcCWDrMk5ENiebvQuXk2VfSNVFKOFwGSG5HQtQb+/jVuu0b/7aAlsNZzWnEYrlWYwZi7fXXSH3+2FEHVSqVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGuVVXddJ2wVHb8i1t7BJTcMabxoK9cGTYkTjhUNtG/qbVaoB2
	1tWSK/SL6sapQQ/3F7swsqssAk2qQ8JoUjHVzsnZOsOZQPnO85VboaRY
X-Gm-Gg: ASbGnctq9o1Fqkep7DWGyvSsuJvt2rbmOjgdvUzm0Ldzy2F5N4hh5I2a6JJPTCeMQBM
	nNzu6HUWk4m+E33NaVk6X1udfB8VWusWYoHqXktYDS/rKr8QVIVFVgDddK8vuzdDpI+y45trhSw
	HdMGejhU9zFcI9r1PeV0A9dglpVeWaFlShdEWmsdpq+Glo9zCffRJ0wEDmBDUFvY5ZeiwqEpWE5
	8lDfwAh7iXKlhYqpIk15jdtntGz8oiNx4cIye9M/MfujoFfn1KGZuIO0RpaQyoBFB+PPxKAmoP3
	q1BISKKLCsLNIoP9s44HOPtIQ2sMVZERFm7v9DkDrrerC7jOtHIwejdCgfgWLOdlsTQAdAI+113
	v2Wtc6hNaHRUu9iIbcXBCvDZk7DL3+m0HKGK2cRKrs374kzpAP5aYuDK56mYPQ4GnH8cyrGzWma
	vawFEfOvHftw==
X-Google-Smtp-Source: AGHT+IEWS4OWz+EwzEUPz27QJ0JvgqtX6/43yqFialI1Uz7fDpRCKIWzIgPESbtf0+fCYUefY/LGGQ==
X-Received: by 2002:a5d:5d87:0:b0:3ec:8c8:7b79 with SMTP id ffacd0b85a97d-4299075d0d3mr1818638f8f.61.1761305348844;
        Fri, 24 Oct 2025 04:29:08 -0700 (PDT)
Received: from fedora ([37.29.213.75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c4369b33sm144041215e9.14.2025.10.24.04.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 04:29:08 -0700 (PDT)
Date: Fri, 24 Oct 2025 13:29:05 +0200
From: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Melissa Wen <melissa.srw@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Harry Wentland <harry.wentland@amd.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] drm/vkms: Fix use after frees on error paths
Message-ID: <aPtjAcNP3fuRNBs5@fedora>
References: <aPtfy2jCI_kb3Df7@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPtfy2jCI_kb3Df7@stanley.mountain>

On Fri, Oct 24, 2025 at 02:15:23PM +0300, Dan Carpenter wrote:
> These error paths free a pointer and then dereference it on the next line
> to get the error code.  Save the error code first and then free the
> memory.
> 
> Fixes: 3e4d5b30d2b2 ("drm/vkms: Allow to configure multiple CRTCs via configfs")
> Fixes: 2f1734ba271b ("drm/vkms: Allow to configure multiple planes via configfs")
> Fixes: 67d8cf92e13e ("drm/vkms: Allow to configure multiple encoders via configfs")
> Fixes: 272acbca96a3 ("drm/vkms: Allow to configure multiple connectors via configfs")
> Fixes: 13fc9b9745cc ("drm/vkms: Add and remove VKMS instances via configfs")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thanks for fixing this:
Reviewed-by: José Expósito <jose.exposito89@gmail.com>

> ---
>  drivers/gpu/drm/vkms/vkms_configfs.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
> index 07ab794e1052..506666e21c91 100644
> --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> +++ b/drivers/gpu/drm/vkms/vkms_configfs.c
> @@ -204,6 +204,7 @@ static struct config_group *make_crtc_group(struct config_group *group,
>  {
>  	struct vkms_configfs_device *dev;
>  	struct vkms_configfs_crtc *crtc;
> +	int ret;
>  
>  	dev = child_group_to_vkms_configfs_device(group);
>  
> @@ -219,8 +220,9 @@ static struct config_group *make_crtc_group(struct config_group *group,
>  
>  		crtc->config = vkms_config_create_crtc(dev->config);
>  		if (IS_ERR(crtc->config)) {
> +			ret = PTR_ERR(crtc->config);
>  			kfree(crtc);
> -			return ERR_CAST(crtc->config);
> +			return ERR_PTR(ret);
>  		}
>  
>  		config_group_init_type_name(&crtc->group, name, &crtc_item_type);
> @@ -358,6 +360,7 @@ static struct config_group *make_plane_group(struct config_group *group,
>  {
>  	struct vkms_configfs_device *dev;
>  	struct vkms_configfs_plane *plane;
> +	int ret;
>  
>  	dev = child_group_to_vkms_configfs_device(group);
>  
> @@ -373,8 +376,9 @@ static struct config_group *make_plane_group(struct config_group *group,
>  
>  		plane->config = vkms_config_create_plane(dev->config);
>  		if (IS_ERR(plane->config)) {
> +			ret = PTR_ERR(plane->config);
>  			kfree(plane);
> -			return ERR_CAST(plane->config);
> +			return ERR_PTR(ret);
>  		}
>  
>  		config_group_init_type_name(&plane->group, name, &plane_item_type);
> @@ -472,6 +476,7 @@ static struct config_group *make_encoder_group(struct config_group *group,
>  {
>  	struct vkms_configfs_device *dev;
>  	struct vkms_configfs_encoder *encoder;
> +	int ret;
>  
>  	dev = child_group_to_vkms_configfs_device(group);
>  
> @@ -487,8 +492,9 @@ static struct config_group *make_encoder_group(struct config_group *group,
>  
>  		encoder->config = vkms_config_create_encoder(dev->config);
>  		if (IS_ERR(encoder->config)) {
> +			ret = PTR_ERR(encoder->config);
>  			kfree(encoder);
> -			return ERR_CAST(encoder->config);
> +			return ERR_PTR(ret);
>  		}
>  
>  		config_group_init_type_name(&encoder->group, name,
> @@ -637,6 +643,7 @@ static struct config_group *make_connector_group(struct config_group *group,
>  {
>  	struct vkms_configfs_device *dev;
>  	struct vkms_configfs_connector *connector;
> +	int ret;
>  
>  	dev = child_group_to_vkms_configfs_device(group);
>  
> @@ -652,8 +659,9 @@ static struct config_group *make_connector_group(struct config_group *group,
>  
>  		connector->config = vkms_config_create_connector(dev->config);
>  		if (IS_ERR(connector->config)) {
> +			ret = PTR_ERR(connector->config);
>  			kfree(connector);
> -			return ERR_CAST(connector->config);
> +			return ERR_PTR(ret);
>  		}
>  
>  		config_group_init_type_name(&connector->group, name,
> @@ -756,6 +764,7 @@ static struct config_group *make_device_group(struct config_group *group,
>  					      const char *name)
>  {
>  	struct vkms_configfs_device *dev;
> +	int ret;
>  
>  	if (strcmp(name, DEFAULT_DEVICE_NAME) == 0)
>  		return ERR_PTR(-EINVAL);
> @@ -766,8 +775,9 @@ static struct config_group *make_device_group(struct config_group *group,
>  
>  	dev->config = vkms_config_create(name);
>  	if (IS_ERR(dev->config)) {
> +		ret = PTR_ERR(dev->config);
>  		kfree(dev);
> -		return ERR_CAST(dev->config);
> +		return ERR_PTR(ret);
>  	}
>  
>  	config_group_init_type_name(&dev->group, name, &device_item_type);
> -- 
> 2.51.0
> 

