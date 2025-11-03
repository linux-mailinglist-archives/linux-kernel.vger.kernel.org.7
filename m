Return-Path: <linux-kernel+bounces-883584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6F4C2DCD0
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 20:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B74923BF47C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 19:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF12B3009DE;
	Mon,  3 Nov 2025 19:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SyRSlfHE"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E322CCC5;
	Mon,  3 Nov 2025 19:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762196833; cv=none; b=YKS821oe3M2d+1tNinR8DPKbzbyR46NC6h/AIU2qB946a36WVyxWQp3Eh/zuQm0/E8LqAoRhIaZ4UvAE6YXRcGdYJKYdGLPN7GCPvkz6vbwy+EgJJNm46HRphwLGNenvdJl12VWJqNSr/d9tMXvMd7/gA/LqXF2y3wHfj7kz0To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762196833; c=relaxed/simple;
	bh=EAe2iDqaIqbjmF2gGhgbQ/Bgu6R1AlVQWXHLAfji1ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NomkoRzaKhsa9ytt4nmsjVZyoFWT9rT6g1rViFUzxHBKlf5SEUSCETIGsmcQT2kQ9IzgsMO8OYndOc+TdpTGf2V719boW79ri55j/BrtUceh9Fp6RwDuzT9xsUuUqMwMfjdJzdLxl37h7g5lmEWzoHxtrj9eLuFsQcMzycByTA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SyRSlfHE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=IQKecPKtA23w7poQU0vT9sVIj6uUAejF4wv6afW5X84=; b=SyRSlfHENky94QLtYeWxHZ3tuS
	k6yO34FkLzcaJTtL6cklwnzVYw7A+M+kNSMufZHDr1GfGNxOXTSY3+xs0HYRGvzHTZmiCv6wGbQob
	bFImjX4D2Euhl0JvcotvZhkvnnUcc51db8rOHTZuGy+ifdsfxl6jddeNUDt6wLiiwXeJ5+NyfcL1m
	TzimRN1QC5TcN9WItTNtO0PxtiWQ823HEmO42ocwImK15Yhy14xxFigejn2RkjEW6Pr/DaFOI48C4
	qdKLUTevr6ybGLfNFvG3MnsIukvrI9INt6m7PQFLbqS8FWkM7m8xcQb6BNhYNgdENxoUAPltKCsUr
	LjSSd20w==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFztP-0000000AWf1-1gNC;
	Mon, 03 Nov 2025 19:07:03 +0000
Message-ID: <810fd8d5-ae5f-489e-b78a-10bebc7d7eec@infradead.org>
Date: Mon, 3 Nov 2025 11:07:02 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] Documentation/amdgpu: Add UMA carveout details
To: "Yo-Jung Leo Lin (AMD)" <Leo.Lin@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Jonathan Corbet <corbet@lwn.net>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, anson.tsao@amd.com,
 superm1@kernel.org
References: <20251103-vram-carveout-tuning-for-upstream-v1-0-17e2a72639c5@amd.com>
 <20251103-vram-carveout-tuning-for-upstream-v1-5-17e2a72639c5@amd.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251103-vram-carveout-tuning-for-upstream-v1-5-17e2a72639c5@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/2/25 11:51 PM, Yo-Jung Leo Lin (AMD) wrote:
> Add documentation for the uma_carveout_options and uma_carveout
> attributes in sysfs
> 
> Signed-off-by: Yo-Jung Leo Lin (AMD) <Leo.Lin@amd.com>
> ---
>  Documentation/gpu/amdgpu/driver-misc.rst     | 26 ++++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 17 +++++++++++++++++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/Documentation/gpu/amdgpu/driver-misc.rst b/Documentation/gpu/amdgpu/driver-misc.rst
> index 25b0c857816e..5a71fa9c6782 100644
> --- a/Documentation/gpu/amdgpu/driver-misc.rst
> +++ b/Documentation/gpu/amdgpu/driver-misc.rst
> @@ -128,3 +128,29 @@ smartshift_bias
>  
>  .. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
>     :doc: smartshift_bias
> +
> +UMA Carveout
> +============
> +
> +Some versions of Atom ROM expose available options for the VRAM carveout sizes,
> +and allow changes to the carveout size via the ATCS function code 0xA on supported
> +BIOS implementation.

        implementations.

> +
> +For those platforms, users can use the following file to set the carveout size,
> +in a way similar to what Windows users can do in the "Tuning" tab in AMD
> +Adrenalin.
> +
> +Note that for BIOS implementations that don't support this, these files will not
> +get created at all.

   be created at all.
or
   exist.
or
   be present.

> +
> +uma_carveout_options
> +--------------------
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> +   :doc: uma_carveout_options
> +
> +uma_carveout
> +--------------------
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> +   :doc: uma_carveout
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> index 1ebfd925b761..e9f71888ce57 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> @@ -1855,6 +1855,17 @@ const struct attribute_group amdgpu_vbios_version_attr_group = {
>  	.is_visible = amdgpu_vbios_version_attrs_is_visible,
>  };
>  
> +/**
> + * DOC: uma_carveout
> + *
> + * This file is both readable and writable. When read, it shows the
> + * index of the current setting. Writing a valid index to this file
> + * allows users to change the UMA carveout size to the selected option
> + * on the next boot.
> + *
> + * The available options and their corresponding indices can be read
> + * from the uma_carveout_options file.
> + */
>  static ssize_t uma_carveout_show(struct device *dev,
>  				 struct device_attribute *attr,
>  				 char *buf)
> @@ -1904,6 +1915,12 @@ static ssize_t uma_carveout_store(struct device *dev,
>  }
>  static DEVICE_ATTR_RW(uma_carveout);
>  
> +/**
> + * DOC: uma_carveout_options
> + *
> + * This is a read-only file that lists all available UMA allocation
> + * options and their corresponding indices.
> + */
>  static ssize_t uma_carveout_options_show(struct device *dev,
>  					 struct device_attribute *attr,
>  					 char *buf)
> 
Some examples like Mario mentioned would be nice.
-- 
~Randy


