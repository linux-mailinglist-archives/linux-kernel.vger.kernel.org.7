Return-Path: <linux-kernel+bounces-899493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A67ABC57E7F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EEE143553E9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BBC2877D9;
	Thu, 13 Nov 2025 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWwkvqje"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56996285068
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763043709; cv=none; b=aDT8VO+DOCLWvEpJ22499/WBGKRFyJ+DjKbATE0YS24rp6z/5vUpLYrg0ppm0K9pqi2F/m6EP8VlbEymNm8KVOprrrSMdVV5GP5wQ5w0DJeUC/B6ZRRjd4KfI3G+9U+F/y1PiSz1BcTSEdkmByTKfgUpOmOIawzk9dCtdGw4WZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763043709; c=relaxed/simple;
	bh=HnLlGXQ6hziyuWpD7ktGyynF2p4st0May1o0iDn8UrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+/fkh+60Y80zk2ngq4R5ovEHVMiupwKv4DXzEkOqw4/UY0C0cUwxyK+zHPiGbmSCBBeck3Sw+hlzhMwm/tjt6gSigHfbNmREF0+4BPpR4qOpNaOZM/vsxy4h3xkIrydPSW6yHz8rfwS8y7qokHAm5uK3ixXNbbAko3zx0ccKI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWwkvqje; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42b427cda88so620664f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763043707; x=1763648507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=we6ktqHl8CIb+a6ejDPrewCJowKT1E/8mfmEjuw9yCE=;
        b=gWwkvqje5prlHr562DnoKLbNf0My6FSxCFAE4aMjSfsRNLfV2xiRD8iqlrIOu0RcFy
         2uIEySPA2TnyKOeo8V9plDdZDLbS87Y/co8w7XGMEYFmC1FMkZIogP786OskUtk6ilPh
         ACO6+4bBXV0Ld2I5W0lS48PVLMh7N6KGRFvsUpl++iOzhkjPYWCBuBnmcYbTrZpegOnU
         E5SASORue5uccjIPwBpbwMnn/5FDoFimR84dDfZ35Oaie7GAerwutTF9aJezzIdFxaQ0
         CFHWO5AVxg0TcVq2Qusc5DXLQLbte8AbzDr3/F5YnOznePtH2rTpgG7erl8rBXmTszkO
         3rbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763043707; x=1763648507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=we6ktqHl8CIb+a6ejDPrewCJowKT1E/8mfmEjuw9yCE=;
        b=eYL2x8qdjcvCM3IItXLK0QMOvIBqrsNg99XRjBfc3nvB2OZGtGRnJ8cw96Av+C/SFE
         bhP3FrsmL2Tnf2tC+IX6wyXcUfQ7epcJ0Iod70qCmiZnC4X65TnRV0F03SLgST4lVfyr
         4Tf93zph9qIh7srkidkr3QFI7z3tEmxIIf+JnBz2BV2u8zi03lsk4oi9Euo6wmONUNGk
         LclEqDtusA7DJ0UVqyJxRvqZa6Uu50UJ//LZdZHGBysmD6O+YGDw7sGvDdZnw+gFOMWz
         s6HHYEE9sT6otiCNyUMf5KwQhpMQJ8OXerib+BW8Vfgh3L2yRF/1voCbRoBeVLpqxgRc
         eFqg==
X-Forwarded-Encrypted: i=1; AJvYcCXN0lW7WB7LTqJP69s5oOArFNugEQ6p+9AfBD0UKvVCooSZzWyC9i/bIQnWM5KyDDEg9EWg+ujfoyeD/5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYbzv9DT1YnjBOxbSr1qAy4CmBhIKqp1LlW+/5iI5XUOHGzeWt
	tnWJmlpenJhW3YktvBIKIvsvfcHvUnYgbl/PsagQs9q4weQWJZNwyWeZ
X-Gm-Gg: ASbGncvTXZGoKwZTjOKq5k5zCZ4QfZfOSogvyAAaKnxOOcJ/JdsKQ8CA6npDOdkkvIX
	ZEsvsJIFIv6IVwZJfZcqIOPp4W0JQGc3/0TfApyL06UB4UYpJwyuFnYw6exMmhDQLsKt5QQlZi3
	8EFpwnawBycjK1m1+ZT9E0MSMi2NXEN3DtGQvnSgCs4iehTXPa+KTgJxRC8BY8rcSjKycCDMko1
	fsVxpapD/ZqEZ1FqRv4513006xrC77xwZxeWjGVZVU47t7reKHigwf4Y3wauzIQc5n4uErO4vZH
	KKLjTxwS8xoE5uupLqSuyy3rBF1aFB0aa9pp7wNclbutD39rsK7kB+A1M0H/p5VFBgUK3l8d/WX
	IcaQKJb38WYL5iJGeBQP0YBOLzDtsHFoAr/SokeC99+TPMAruFKE86uVZYpUS+h3RIWFYb4yiew
	==
X-Google-Smtp-Source: AGHT+IGldfDXCrb7BH7hy572KrLOiAR1Lp75or0+sxa276AqeqbFud8+BeO55XZxpLa7Ug0Up1nVpw==
X-Received: by 2002:a05:6000:40cd:b0:42b:4803:75e8 with SMTP id ffacd0b85a97d-42b4bdb44c0mr4800835f8f.43.1763043706616;
        Thu, 13 Nov 2025 06:21:46 -0800 (PST)
Received: from fedora ([94.73.38.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f21948sm4239920f8f.43.2025.11.13.06.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 06:21:46 -0800 (PST)
Date: Thu, 13 Nov 2025 15:21:44 +0100
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
Subject: Re: [PATCH RESEND v2 06/32] drm/vkms: Introduce configfs for plane
 name
Message-ID: <aRXpeE2fCRj4uyBY@fedora>
References: <20251029-vkms-all-config-v2-0-a49a2d4cba26@bootlin.com>
 <20251029-vkms-all-config-v2-6-a49a2d4cba26@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029-vkms-all-config-v2-6-a49a2d4cba26@bootlin.com>

On Wed, Oct 29, 2025 at 03:36:43PM +0100, Louis Chauvet wrote:
> Planes can have name, create a plane attribute to configure it. Currently
> plane name is mainly used in logs.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  Documentation/gpu/vkms.rst           |  3 ++-
>  drivers/gpu/drm/vkms/vkms_configfs.c | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
> index 3574e01b928d..1fe6e420c963 100644
> --- a/Documentation/gpu/vkms.rst
> +++ b/Documentation/gpu/vkms.rst
> @@ -87,10 +87,11 @@ Start by creating one or more planes::
>  
>    sudo mkdir /config/vkms/my-vkms/planes/plane0
>  
> -Planes have 1 configurable attribute:
> +Planes have 2 configurable attributes:
>  
>  - type: Plane type: 0 overlay, 1 primary, 2 cursor (same values as those
>    exposed by the "type" property of a plane)
> +- name: Name of the plane

I'd like to mention again my comment on limiting the name to a set of
well-known characters [1].

The reason is that, in libinput, we had a format string vulnerability
due to the kernel exposing devices with names containing strings like
"%s" in the name (CVE-2022-1215):
https://gitlab.freedesktop.org/libinput/libinput/-/issues/752

In my opinion, we should avoid surprising user-space too much and allow
only a set of "safe" characters.

Maybe I'm too cautious, as this is valid code, but I'd like to bring up
the discussion again to see if someone else agrees or disagrees.

[1] https://lore.kernel.org/all/aPtgCUX5kixTh2ua@fedora/
  
>  Continue by creating one or more CRTCs::
>  
> diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
> index 07ab794e1052..be6c3ba998b9 100644
> --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> +++ b/drivers/gpu/drm/vkms/vkms_configfs.c
> @@ -322,10 +322,42 @@ static ssize_t plane_type_store(struct config_item *item, const char *page,
>  	return (ssize_t)count;
>  }
>  
> +static ssize_t plane_name_show(struct config_item *item, char *page)
> +{
> +	struct vkms_configfs_plane *plane;
> +	const char *name;
> +
> +	plane = plane_item_to_vkms_configfs_plane(item);
> +
> +	scoped_guard(mutex, &plane->dev->lock)
> +		name = vkms_config_plane_get_name(plane->config);
> +
> +	return sprintf(page, "%s\n", name);
> +}
> +
> +static ssize_t plane_name_store(struct config_item *item, const char *page,
> +				size_t count)
> +{
> +	struct vkms_configfs_plane *plane;
> +
> +	plane = plane_item_to_vkms_configfs_plane(item);
> +
> +	scoped_guard(mutex, &plane->dev->lock) {
> +		if (plane->dev->enabled)
> +			return -EBUSY;
> +
> +		vkms_config_plane_set_name(plane->config, page);
> +	}
> +
> +	return (ssize_t)count;
> +}
> +
>  CONFIGFS_ATTR(plane_, type);
> +CONFIGFS_ATTR(plane_, name);
>  
>  static struct configfs_attribute *plane_item_attrs[] = {
>  	&plane_attr_type,
> +	&plane_attr_name,
>  	NULL,
>  };
>  
> 
> -- 
> 2.51.0
> 

