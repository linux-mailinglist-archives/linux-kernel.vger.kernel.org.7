Return-Path: <linux-kernel+bounces-869083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E38C06EB8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A77153A04DE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5155B32548F;
	Fri, 24 Oct 2025 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RM3X7CTq"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9792D979D
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 15:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761319007; cv=none; b=OAS1EJPwjCIboC+oLgTLIqjYS4hoqUxWJol1JO3lbqUpUsYmDqVSe+AQufqUJiaCCGMJUNZHswNK/U8HVV7LQmAqkCZDlN9EPFtc2YMhe6kFaDVexxkEDuw8o8Ma7WCXsxQh0skD6EM9aNO+5vEhYGboGVZYKh7ZTafWzlEeWRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761319007; c=relaxed/simple;
	bh=jVc9hLI9fcXAku+oALxNHVDhhx0CP4iDyHCwED8hpRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkQzwI/V02z/hsABrAlaYXikLbQ1z56oe9YwUtzhy7UMr6bj/f97C6U7XZgwvz7CvkIIuxAEZ6cyuc8jVPBIyGK2Zdl3ggfK6op0lvKA/KXCzpesZBmwIWN8ZbBn0NauiOuM5Bt8G6nlXaLylIBxbF40HHGls8HuWnka3tU7QJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RM3X7CTq; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-475dae5d473so25595e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761319003; x=1761923803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mevfSuNrxwVFTOkyY7Tm8OrvABJ1d1Eojo95+k8sZtc=;
        b=RM3X7CTqZSiGWKm11Ard7Ya2JK3OzcgT7WCRE92oCpLSwmT9i2Rt8hmOrJLjH3NrvP
         oONGswdZjhgGPUb2HNz+0Bq6j6djxl2HxJGbwu1l1FDqlwwvYERZFdDPFkAbYXP/PQpt
         VG93DSawk1mmJH1qBveFyddHMPzBS83fDRTdB2KVeiPdyzD4+6PM/26Fk8eTP1f3bA71
         AiAa5BDoP+WGqeJ/ChAuDeO+l9m6Iw9c+bj5rF/piJlbQGiurzU9U1D9/Zg0zEHXhujW
         y5UV3nvH4w+MzYHLnHO0tnxRqxR+aKtSUZ4B1M0SLJAccesDbGMi+wo7m6GkkjSk78tj
         cNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761319003; x=1761923803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mevfSuNrxwVFTOkyY7Tm8OrvABJ1d1Eojo95+k8sZtc=;
        b=LzxLIsX686LULpCNoTIuhMzVO5WjCB0RGlMrycui7lL27pQUIV36HmzJaqD3WwyA+1
         cBo5YM/aATjunItkm0fHpvZQNea8F9vsSOSXvTWbBnw6GCBFBoUF6wvNelmyk1fozdAg
         IHIgWzw2gRi3N8ApJ/xVP9MpSsaTIa75Fl0CLNMWWLYq+qfHkzHmEAJghgxF3ebZtANT
         JCVUBrwOVcDg1OU6qoVDPnWNWYUe0tJkznzjOpp96NNFG44i0BZ0eCj0jdy9l/v0lvOo
         /ny88u7kjJijq7Y6DgiRT3LvApnOiaZddy+TGW0dstDwWHe1ZFPDVXryCzZ1og70W9PW
         vswA==
X-Forwarded-Encrypted: i=1; AJvYcCVdjoJ95sPt+uTnMt4qp7XB+IqxXNmTgYgcxg4CZrpZB/QBgcVXZXlsRvApppgkoYxKe2WcGXBIPhpVkCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy71+zOG6dL0dTB5ChtNnG8ypDd2bru4b1H1GwoxU84XSFnFvCu
	0e+2xVNYzDo1Z9dRPoDgr9iytVN+AC+GHc53r7QR50rRT9tG/llDIwwN
X-Gm-Gg: ASbGnct9lXFY79Y8mp/iBhaTfr8+g41HL85PZdP5/ZJaU8q3EkDcy7LVBqN6WiAtuG/
	kgjaM2tmfjauNhoF2nd5MwfhhGZNshtr9GquIC5hRECGGVrVSUcBfP5Gt9j9Nc/nF8wOs5p5nv5
	72IB1ayS6jcJcwZLYyLbrAWMJc0aoP08lGTnTpVXog7k/C3Ze32fJSV6t5FTp4/3T1JZIzB4HVn
	X3TGSCcKWFo4IixT2u7LLCuCt3Abfr+6dJUyBYeykLS2P7ZbxM5TTVAcnVJi59v6+zIESnRa6XZ
	vGuDdchXlvEpkirKf1BgKrriFXwM2euA160erXhu7/+6CC2dGYCtk+yTbtestGmO178sze7wiTp
	SJ3CpWo3hP7OcCVbMuuweRuO6O/gPlY7GXoiLeAAzt6yL66+UDfulyfzWbNSp8Z/0stH2qoG0++
	qGg0Auw2YMMA==
X-Google-Smtp-Source: AGHT+IEA18WK4Q9IiYqGhwYZgRRsCaQtZ15viH6p/QSrbM4l3uPsWojVndH+d8P9+fufilJ2qEw4Ew==
X-Received: by 2002:a05:600c:3512:b0:46e:5b74:4858 with SMTP id 5b1f17b1804b1-47117877122mr173891065e9.13.1761319002904;
        Fri, 24 Oct 2025 08:16:42 -0700 (PDT)
Received: from fedora ([37.29.213.75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c4378cbesm150983915e9.16.2025.10.24.08.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 08:16:42 -0700 (PDT)
Date: Fri, 24 Oct 2025 17:16:39 +0200
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
Subject: Re: [PATCH 06/22] drm/vkms: Introduce configfs for plane color
 encoding
Message-ID: <aPuYV5D_QktyNSmM@fedora>
References: <20251018-vkms-all-config-v1-0-a7760755d92d@bootlin.com>
 <20251018-vkms-all-config-v1-6-a7760755d92d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018-vkms-all-config-v1-6-a7760755d92d@bootlin.com>

On Sat, Oct 18, 2025 at 04:01:06AM +0200, Louis Chauvet wrote:
> To allows the userspace to test many hardware configuration, introduce a
> new interface to configure the available color encoding per planes. VKMS
> supports multiple color encoding, so the userspace can choose any
> combination.
> 
> The supported color encoding are configured by writing a color encoding
> bitmask to the file `supported_color_encoding` and the default color
> encoding is chosen by writing a color encoding bitmask to
> `default_color_encoding`.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  Documentation/gpu/vkms.rst           |   7 ++-
>  drivers/gpu/drm/vkms/vkms_configfs.c | 102 +++++++++++++++++++++++++++++++++++
>  2 files changed, 108 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
> index a432968cc711..4ff75b53a386 100644
> --- a/Documentation/gpu/vkms.rst
> +++ b/Documentation/gpu/vkms.rst
> @@ -87,7 +87,7 @@ Start by creating one or more planes::
>  
>    sudo mkdir /config/vkms/my-vkms/planes/plane0
>  
> -Planes have 3 configurable attribute:
> +Planes have 5 configurable attribute:
>  
>  - type: Plane type: 0 overlay, 1 primary, 2 cursor (same values as those
>    exposed by the "type" property of a plane)
> @@ -96,6 +96,11 @@ Planes have 3 configurable attribute:
>    (same values as those exposed by the "rotation" property of a plane)
>  - default_rotation: Default rotation presented to the userspace, same values as
>    possible_rotations.
> +- supported_color_encoding: Available encoding for a plane, as a bitmask:
> +  0x01 YCBCR_BT601, 0x02: YCBCR_BT709, 0x04 YCBCR_BT2020 (same values as those exposed
> +  by the COLOR_ENCODING property of a plane)
> +- default_color_encoding: Default color encoding presented to the userspace, same
> +  values as supported_color_encoding
>  
>  Continue by creating one or more CRTCs::
>  
> diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
> index 450e45e66a45..a4e0e054cf2d 100644
> --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> +++ b/drivers/gpu/drm/vkms/vkms_configfs.c
> @@ -412,14 +412,116 @@ static ssize_t plane_default_rotation_store(struct config_item *item,
>  	return count;
>  }
>  
> +static ssize_t plane_supported_color_encoding_show(struct config_item *item, char *page)
> +{
> +	struct vkms_configfs_plane *plane;
> +	unsigned int supported_color_encoding;
> +
> +	plane = plane_item_to_vkms_configfs_plane(item);
> +
> +	scoped_guard(mutex, &plane->dev->lock) {
> +		supported_color_encoding = vkms_config_plane_get_supported_color_encoding(plane->config);
> +	}
> +
> +	return sprintf(page, "%u", supported_color_encoding);
> +}
> +
> +static ssize_t plane_supported_color_encoding_store(struct config_item *item,
> +						    const char *page, size_t count)
> +{
> +	struct vkms_configfs_plane *plane = plane_item_to_vkms_configfs_plane(item);
> +	int ret, val = 0;
> +
> +	ret = kstrtouint(page, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	/* Should be a supported value */
> +	if (val & ~(BIT(DRM_COLOR_YCBCR_BT601) |
> +		    BIT(DRM_COLOR_YCBCR_BT709) |
> +		    BIT(DRM_COLOR_YCBCR_BT2020)))
> +		return -EINVAL;
> +	/* Should at least provide one color range */
> +	if ((val & (BIT(DRM_COLOR_YCBCR_BT601) |
> +		    BIT(DRM_COLOR_YCBCR_BT709) |
> +		    BIT(DRM_COLOR_YCBCR_BT2020))) == 0)
> +		return -EINVAL;
> +
> +	scoped_guard(mutex, &plane->dev->lock) {
> +		/* Ensures that the default rotation is included in supported rotation */
> +		if (plane->dev->enabled ||
> +		    (val & vkms_config_plane_get_default_color_encoding(plane->config)) !=
> +		     vkms_config_plane_get_default_color_encoding(plane->config))
> +			return -EINVAL;

I think that the same problem that I mention having to configure
plane rotation in 2 steps applies for color encoding.

> +		vkms_config_plane_set_supported_color_encoding(plane->config, val);
> +	}
> +
> +	return count;
> +}
> +
> +/* Plane default_color_encoding : vkms/<device>/planes/<plane>/default_color_encoding */
> +
> +static ssize_t plane_default_color_encoding_show(struct config_item *item, char *page)
> +{
> +	struct vkms_configfs_plane *plane;
> +	unsigned int default_color_encoding;
> +
> +	plane = plane_item_to_vkms_configfs_plane(item);
> +
> +	scoped_guard(mutex, &plane->dev->lock) {
> +		default_color_encoding = vkms_config_plane_get_default_color_encoding(plane->config);
> +	}
> +
> +	return sprintf(page, "%u", default_color_encoding);
> +}
> +
> +static ssize_t plane_default_color_encoding_store(struct config_item *item,
> +						  const char *page, size_t count)
> +{
> +	struct vkms_configfs_plane *plane = plane_item_to_vkms_configfs_plane(item);
> +	int ret, val = 0;
> +
> +	ret = kstrtouint(page, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	/* Should be a supported value */
> +	if (val & ~(BIT(DRM_COLOR_YCBCR_BT601) |
> +		    BIT(DRM_COLOR_YCBCR_BT709) |
> +		    BIT(DRM_COLOR_YCBCR_BT2020)))
> +		return -EINVAL;
> +	/* Should at least provide one color range */
> +	if ((val & (BIT(DRM_COLOR_YCBCR_BT601) |
> +		    BIT(DRM_COLOR_YCBCR_BT709) |
> +		    BIT(DRM_COLOR_YCBCR_BT2020))) == 0)
> +		return -EINVAL;
> +
> +	scoped_guard(mutex, &plane->dev->lock) {
> +		/* Ensures that the default rotation is included in supported rotation */
> +		if (plane->dev->enabled ||
> +		    (val & vkms_config_plane_get_supported_color_encoding(plane->config)) !=
> +		     val)
> +			return -EINVAL;
> +
> +		vkms_config_plane_set_default_color_encoding(plane->config, val);

As I mentioned in the previous patch, I think that default color encoding
is sometimes a bitmask and sometimes the actual color?

> +	}
> +
> +	return count;
> +}
> +
>  CONFIGFS_ATTR(plane_, type);
>  CONFIGFS_ATTR(plane_, supported_rotations);
>  CONFIGFS_ATTR(plane_, default_rotation);
> +CONFIGFS_ATTR(plane_, supported_color_encoding);
> +CONFIGFS_ATTR(plane_, default_color_encoding);
>  
>  static struct configfs_attribute *plane_item_attrs[] = {
>  	&plane_attr_type,
>  	&plane_attr_supported_rotations,
>  	&plane_attr_default_rotation,
> +	&plane_attr_supported_color_encoding,
> +	&plane_attr_default_color_encoding,
>  	NULL,
>  };
>  
> 
> -- 
> 2.51.0
> 

