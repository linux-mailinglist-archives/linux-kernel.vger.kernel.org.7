Return-Path: <linux-kernel+bounces-868748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AF5C0603A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 383651C27924
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416ED3161A4;
	Fri, 24 Oct 2025 11:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+sFcwOm"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA77312836
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761304832; cv=none; b=TgiKp5OGRLSAk29UVnbSnuoeIan/1zAOJjvdfxLQ0TOOQ+tgoHT6y8xdGPWUv3SPIVwQbucsDrFoBxzuNADeKBPJbODJCPnRGusEwMfr2HV4JnZ658OLS2pweK1/T0E5kok3cmQFxZCpdl1OIrF4uL166Bs0JxOdr2ff3v9hQEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761304832; c=relaxed/simple;
	bh=ibL0qXphvFLNBhgkIrZxCh+fRmRXwYDXApfQvVASh2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0bca+Y+G6t9BJd3BOjUBVq+A9/QJ3SLDJoZy+QOBYZBst/NdQxyFpw0HvRoL1OtMvKPnfwv10Gz/fvagTZmQU0+ehF2075GjqpCmIZhI7vnO3tuXKuRvzBRZA3xFchPa8hXfri2RSmlBfKINxXG0YMmaJo+7v2o9rvzHDJVujs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+sFcwOm; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-470ffbf2150so19273245e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 04:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761304829; x=1761909629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YTnCOy1eHrQUiIAhpXZ/ug4Pk50ITgMgot9TQrvcHTg=;
        b=Y+sFcwOmvkJAPJzth7SVhksRWLTSx4tIwdn+tSVbe64M82aXSRGDiflGBDEIyN3ofP
         1FC8sRkVWVPeQw8e3qhehSRntdzBdLMjztR+3iA633Y2Ngd8JHcDiXQSFYrFaqNoRmLj
         zZnuRF9weO+x6NSJAPYO5JcCGGrvyFOx21422BylqbeXY3BRlW1zj0TZVK5MdBCo+LtQ
         PVpkqHCduRUL+MGi7jm0OHuvfeH6jPP1EUFwsdzViFOVrwTqPxw8ijKNH2eyfww44bVq
         +R/K805yF6V7UppfcozX54Ub4yV9DqDPpu/o3RF8nU4N1pmHsxEItmvCDHJ+Izd9I6+T
         L6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761304829; x=1761909629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTnCOy1eHrQUiIAhpXZ/ug4Pk50ITgMgot9TQrvcHTg=;
        b=EeiZzPQGl/NwyOgsEuGSh9SRkZhsnYevT+IX1Md/ShIcHh0akhJHEepg858mcNuLOa
         KxMJyWBVYRxNY8HK5jiVw1bI4pw0J17s+UlpiH57xQyXNA8086/WXhkeySaFMlGllhpL
         a5tPqKFHd4BCUW45klFv0xBBXhdTA9nrYJUN15ZL9WmrTy9jDIg5qEKauXxo2+jVmO8s
         gHR7RddNWqIz/g6MgtmxRNLR/McoMBxb3GqFWuxlEi5mdf4h1F19xBNAxgKrutz1FVwu
         Km8mpXLHpwto8zJrVk3J4N8EOmWsJT5ouXlsm4BivIa4eWuWuQZTY4lEdGOn1M4W8R2R
         es6g==
X-Forwarded-Encrypted: i=1; AJvYcCUljeSKV3tIFyqtokClaQaHQtr4tl9rA/alyR0XEtHn7wvejF8fWTxPtm6XnomeeBkjdEwIWXLTMvnUA7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxej8NCqKgcMNS6YZ5uA/D1GL+M4lLJPPecWxUlXk33JzwHo+RQ
	wizp2rs4+PzuY/s5pn5FfcEwuHLjZBUtcNaXQz6y2Y8ogrtRxVb98pLr
X-Gm-Gg: ASbGncuw1oBqlSiSMKRvkO4ULMoWIL3a4EOcuO6C0k7Jr4v7iIQ62MlZvslX+VaRYQu
	BqGvNkKvmXPoryAeZHX8v+qPgWJNGyAkqmq3Jd6e/NzBqyNE1BrzNp6V8lcNfiiXji2eu5uZe31
	Y6hmkQhiXdYs3QWF1/MwCCxPsSMiWUe35gsca7LlzFLRTPb2YQtcmVMCL10E4sQD3SDA4Ig6n7f
	5pWywSW15ovj5NxpDioWhPWuX81p6nqe2JDY0K2Z0jLKexRa+uJvacMW3MyszsrgdMeyurr1gXB
	PneZ763ikFUa1ZqVI4G0xS2hQXOpa1RnkXrWqNIgsCbhg0NrId+i9P1kbPIydLJurd2iCgApj6E
	kMifzqvLscZSdYMPX2T/p0GLMHBMy7eBGej5FT8MdUmOG5d7vuKMwK0b1W45dz+N5BImT/QqICI
	A=
X-Google-Smtp-Source: AGHT+IGe6elZkVAHh0p16ObU2d4NFjdkgPKJgZC3rlEc6qKcM2kxG+6kZ0Y62hj18nRKDU33xe6X5w==
X-Received: by 2002:a05:600c:64c5:b0:471:611:c1e2 with SMTP id 5b1f17b1804b1-475d24088b0mr22106845e9.3.1761304828970;
        Fri, 24 Oct 2025 04:20:28 -0700 (PDT)
Received: from fedora ([37.29.213.75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475cae92067sm90537365e9.4.2025.10.24.04.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 04:20:28 -0700 (PDT)
Date: Fri, 24 Oct 2025 13:20:25 +0200
From: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Melissa Wen <melissa.srw@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	victoria@system76.com, sebastian.wick@redhat.com,
	thomas.petazzoni@bootlin.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 02/22] drm/vkms: Introduce configfs for plane name
Message-ID: <aPtg-U56nmP2L1vH@fedora>
References: <20251018-vkms-all-config-v1-0-a7760755d92d@bootlin.com>
 <20251018-vkms-all-config-v1-2-a7760755d92d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018-vkms-all-config-v1-2-a7760755d92d@bootlin.com>

On Sat, Oct 18, 2025 at 04:01:02AM +0200, Louis Chauvet wrote:
> Use directory name as name for the plane.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/vkms/vkms_configfs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
> index 07ab794e1052..ea245e2e2fd2 100644
> --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> +++ b/drivers/gpu/drm/vkms/vkms_configfs.c
> @@ -376,6 +376,7 @@ static struct config_group *make_plane_group(struct config_group *group,
>  			kfree(plane);
>  			return ERR_CAST(plane->config);
>  		}
> +		vkms_config_plane_set_name(plane->config, name);

Could this break the UAPI?

Until now, the name was NULL. In __drm_universal_plane_init(), when the name
is not set, "plane-%d" is used to compose its name.

Therefore, if we now use the directory name as the plane name, we are changing
a bit how VKMS behaves.

It is not a big deal, but I think that a "name" file could be a safer approach.

Jose

>  		config_group_init_type_name(&plane->group, name, &plane_item_type);
>  
> 
> -- 
> 2.51.0
> 

