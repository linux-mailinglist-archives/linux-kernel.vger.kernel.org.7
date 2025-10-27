Return-Path: <linux-kernel+bounces-871157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AA134C0C896
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 66F334F4ECA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E04B2F5498;
	Mon, 27 Oct 2025 08:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5nst3Dj"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964492F8BD1
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761555315; cv=none; b=vFk0dntuCeWkMv/RtjZ2gD7vVJRa9lW4EYsilbicOaHf0m2KFJbrr3B9o6ZFxU6O6Fe4vQAQgPSqdpF6BpUxj772HX2TG7R5JDtPeAwLEDQ1K1lQjUL/AMOXrAwbO/ZE8KPhxPodAlLsxp4ZDgWG1uFJsdfh12uy1zrv49xCRPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761555315; c=relaxed/simple;
	bh=z0EsUhIYngw3uqM7CqctX09gbNWPgBk6PTy9xZ3ffvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUA/43s7heTtACIVm9JpEn42Iki7+31aKrhXMv+BQp7ejQhxwUuyvYGIyQnDJVkArqAws29CGcGsz2uHiypYHUZgICpY3TxX1iAVhbvES7Rkz8+6iJ/Z8/yo9y7ZbKmagGnMobvR1Rtu2QamZegDKhYudFGNhA7qJlLkWFtXo+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5nst3Dj; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-470ffbf2150so31738665e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761555312; x=1762160112; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rTRZ3EhuIswe365aG/XvjvEwriEQziiLr/d1qgrUekA=;
        b=a5nst3DjgeVJl+Dx0Lq8o8FNTERhlno5ff1WGfJBVBgB7iJKdkN8jWSH5r5BCztlTB
         YWkdIE4Y2K/twvNtO5/YORBx+iKP2V/PJO/BshlXFmNqdz2lilC07P04zruB1Qkd/SoD
         u2TQuPE5urk+ozhh8CDBKfF9DxGd965xY0QxDf434VZPFbB7dlo1w7cGRQBNj0LmARy6
         rYltiLgGn7p/BHrWHPsYt+KiO6Wh6eXG4v2981zNQu0UyDo4G5B1Of01WeTq+W3iV40+
         HwdHHGHz264tMap+ezS8sUV/SoZ2Lag1bh5dzSFmSHJAcsYnpCJU+l5eMZN+FHe91dmj
         BwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761555312; x=1762160112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rTRZ3EhuIswe365aG/XvjvEwriEQziiLr/d1qgrUekA=;
        b=QzQlOo2n/1ayBAxJlCt+5PSpGphg3LhyI+8IK/dpgjANRzayXiNEguYW39K3JHKGGc
         nncdfW9OQnYZsDgIZjkoeWTQIUKzpbtOCFQz7gHs1PuAWWqbpJAyElELzOXqWP2C7PZy
         /igc72pMQLLHeU8RqFNzYv2Dnptan1kWLJjFB5G37QofF3JDggrPhfmXt25Ars3mQbNd
         oRQG4mYaeiTP1a/lu8EKjQFgHHYMpsDO9WZ1XIZdD0VZ5zmuFZStrQz+kAC3LZnFnP6x
         eKePyv7iek8VhCAt8qXyy+SA/edCm0/CnWGTIE2G6b5YwsQZ0VX9LUfvwm/abhqraJgM
         5LyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVvmRIkxMygtcVFuNudgX0/FWFLl31FnL62UVDMvWlxWS8UQgdu/Lx+Upu2Pnm2wTPdiYAKAYWT7Pcq14=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkV26rbgGYZuPQyzQ4MdGURxEknK3OO2Qb2ApE0NZfAzaxREQp
	mktEi//EyANztlg8jEp3+HhKiNeeloRc1Mf+cbNKr4bm0NooI+LP7N1t
X-Gm-Gg: ASbGncse+OsS6+KgFJYNgnBKsb4ILIsfUr/qJGePqk3Jsu6WUNdPa77KY1p59LX3jXF
	TKjfqtPR9K/VZ1BcRgj6qSK62O3BCRhwsEmYVSlNRoO6QX075IEBoyaID/NlGk03ioeiT7nFFOw
	cuvk6IG1eAv+MjZfFIAcSMTodXolSCF8zN38WwFSj36xC+pNMp/476roj3XW3NHgz5K775TgECW
	wQcHLYqOWbjYQTAS7ZxbyozvpqcyEjafrMWFk5MjDT06wgK4nwXdXVupQkeQVstHjvb9AGlavQq
	YpE21LlbriE/lKXEe7qE17r9NcukmJjwieiQfHjLso24ZzQ3MZYnTcajVvraw2N8YKXr0PskubA
	47cD72Jit3D0xS5FvKmFdvH8v/v3v8+ouqyWEZZlqP2KK3VFCHKeMK9nv48ArZwBi2gc0b8mmye
	mn+UZEpGi9
X-Google-Smtp-Source: AGHT+IGwkEUcJwMJhosHHfH/GxJAl3iU3iW4Mt6ujmdrpnIv7t1iBgzQ7ZFbWVwAn1+OadGrK7omzw==
X-Received: by 2002:a05:6000:4313:b0:401:2cbf:ccad with SMTP id ffacd0b85a97d-4298f582465mr10291302f8f.17.1761555311692;
        Mon, 27 Oct 2025 01:55:11 -0700 (PDT)
Received: from fedora ([94.73.38.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd374e41sm124963555e9.12.2025.10.27.01.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 01:55:11 -0700 (PDT)
Date: Mon, 27 Oct 2025 09:55:09 +0100
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
Subject: Re: [PATCH 10/22] drm/vkms: Introduce configfs for plane format
Message-ID: <aP8zbabbfLJ6F4Ok@fedora>
References: <20251018-vkms-all-config-v1-0-a7760755d92d@bootlin.com>
 <20251018-vkms-all-config-v1-10-a7760755d92d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251018-vkms-all-config-v1-10-a7760755d92d@bootlin.com>

On Sat, Oct 18, 2025 at 04:01:10AM +0200, Louis Chauvet wrote:
> To allow the userspace to test many hardware configuration, introduce a
> new interface to configure the available formats per planes. VKMS supports
> multiple formats, so the userspace can choose any combination.
> 
> The supported formats are configured by writing the fourcc code in
> supported_formats:
>  # enable AR24 format
>   echo '+AR24' > /config/vkms/DEVICE_1/planes/PLANE_1/supported_formats
>  # disable AR24 format
>   echo '-AR24' > /config/vkms/DEVICE_1/planes/PLANE_1/supported_formats
>  # enable all format supported by VKMS
>   echo '+*' > /config/vkms/DEVICE_1/planes/PLANE_1/supported_formats
>  # disable all formats
>   echo '-*' > /config/vkms/DEVICE_1/planes/PLANE_1/supported_formats
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  Documentation/gpu/vkms.rst           |  7 ++-
>  drivers/gpu/drm/vkms/vkms_configfs.c | 82 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 88 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
> index 979f8a545498..deb14e7c48ea 100644
> --- a/Documentation/gpu/vkms.rst
> +++ b/Documentation/gpu/vkms.rst
> @@ -87,7 +87,7 @@ Start by creating one or more planes::
>  
>    sudo mkdir /config/vkms/my-vkms/planes/plane0
>  
> -Planes have 7 configurable attribute:
> +Planes have 8 configurable attribute:
>  
>  - type: Plane type: 0 overlay, 1 primary, 2 cursor (same values as those
>    exposed by the "type" property of a plane)
> @@ -106,6 +106,11 @@ Planes have 7 configurable attribute:
>    those exposed by the COLOR_RANGE property of a plane)
>  - default_color_range: Default color range presented to the userspace, same
>    values as supported_color_range
> +- supported_formats: List of supported formats for this plane. To add a new item in the
> +  list, write it using a plus its fourcc code: +XR24
> +  To remove a format, use a minus and its fourcc: -XR24
> +  To add all formats use +*
> +  To remove all formats, use -*
>  
>  Continue by creating one or more CRTCs::
>  
> diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
> index 0b280c73b0cc..528f22fa2df1 100644
> --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> +++ b/drivers/gpu/drm/vkms/vkms_configfs.c
> @@ -599,6 +599,86 @@ static ssize_t plane_default_color_encoding_store(struct config_item *item,
>  	return count;
>  }
>  
> +static ssize_t plane_supported_formats_show(struct config_item *item, char *page)
> +{
> +	struct vkms_configfs_plane *plane;
> +
> +	plane = plane_item_to_vkms_configfs_plane(item);
> +
> +	page[0] = '\0';
> +
> +	scoped_guard(mutex, &plane->dev->lock)
> +	{

This "{" should go in the same line.

> +		u32 *formats = vkms_config_plane_get_supported_formats(plane->config);
> +
> +		for (int i = 0;
> +		     i < vkms_config_plane_get_supported_formats_count(plane->config);
> +		     i++) {
> +			char tmp[6] = { 0 };
> +			const ssize_t ret = snprintf(tmp, ARRAY_SIZE(tmp), "%.*s\n",
> +					       (int)sizeof(*formats),
> +					       (char *)&formats[i]);
> +			if (ret < 0)
> +				return ret;
> +			/*
> +			 * Limitation of ConfigFS attributes, an attribute can't be bigger
> +			 * than PAGE_SIZE. This will crop the result if this plane support
> +			 * more than ≈1000 formats.
> +			 */
> +			if (ret + strlen(page) > PAGE_SIZE - 1)
> +				return -ENOMEM;
> +			strncat(page, tmp, ARRAY_SIZE(tmp));
> +		}
> +	}
> +
> +	return strlen(page);
> +}
> +
> +static ssize_t plane_supported_formats_store(struct config_item *item,
> +					     const char *page, size_t count)
> +{
> +	struct vkms_configfs_plane *plane;
> +
> +	plane = plane_item_to_vkms_configfs_plane(item);
> +	int ret = 0;
> +	int ptr = 0;
> +
> +	scoped_guard(mutex, &plane->dev->lock)
> +	{

This "{" should go in the same line.

> +		while (ptr < count) {
> +			char tmp[4] = { ' ', ' ', ' ', ' ' };
> +
> +			memcpy(tmp, &page[ptr + 1], min(sizeof(tmp), count - (ptr + 1)));

This is not handling correctly formats with less than 4 characters.

For example, "+R1" is not handled because it is adding the sctring NULL terminator
to tmp. I think you need to:

memcpy(tmp, &page[ptr + 1], min(sizeof(tmp), count - 1 - (ptr + 1)));

> +			if (page[ptr] == '+') {
> +				if (tmp[0] == '*') {
> +					ret = vkms_config_plane_add_all_formats(plane->config);
> +					if (ret)
> +						return ret;
> +					ptr += 1;
> +				} else {
> +					ret = vkms_config_plane_add_format(plane->config,
> +									   *(int *)tmp);
> +					if (ret)
> +						return ret;
> +					ptr += 4;
> +				}
> +			} else if (page[ptr] == '-') {
> +				if (tmp[0] == '*') {
> +					vkms_config_plane_remove_all_formats(plane->config);
> +					ptr += 1;
> +				} else {
> +					vkms_config_plane_remove_format(plane->config, *(int *)tmp);
> +					ptr += 4;
> +				}
> +			}
> +			/* Skip anything that is not a + or a - */
> +			ptr += 1;
> +		}
> +	}
> +
> +	return count;
> +}
> +
>  CONFIGFS_ATTR(plane_, type);
>  CONFIGFS_ATTR(plane_, supported_rotations);
>  CONFIGFS_ATTR(plane_, default_rotation);
> @@ -606,6 +686,7 @@ CONFIGFS_ATTR(plane_, supported_color_range);
>  CONFIGFS_ATTR(plane_, default_color_range);
>  CONFIGFS_ATTR(plane_, supported_color_encoding);
>  CONFIGFS_ATTR(plane_, default_color_encoding);
> +CONFIGFS_ATTR(plane_, supported_formats);
>  
>  static struct configfs_attribute *plane_item_attrs[] = {
>  	&plane_attr_type,
> @@ -615,6 +696,7 @@ static struct configfs_attribute *plane_item_attrs[] = {
>  	&plane_attr_default_color_range,
>  	&plane_attr_supported_color_encoding,
>  	&plane_attr_default_color_encoding,
> +	&plane_attr_supported_formats,
>  	NULL,
>  };
>  
> 
> -- 
> 2.51.0
> 

