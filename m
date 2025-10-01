Return-Path: <linux-kernel+bounces-838746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFE8BB00F8
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 12:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B94431C1A6E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 10:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BB333F6;
	Wed,  1 Oct 2025 10:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dgOhwUZr"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F4027A927
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 10:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759315906; cv=none; b=PVS56721lXBujzadtN6mcrkpaqR2ZnhzQE21Nk59RerGJUYqJXly42l1WVqJM0lf4pU39C1Mol4evAX07uJhwf+cGqhAb/KAlnhFz2UofKuJAxmYqy5GCBgdJTqODBmNxR9fl7TTrJP51jjJfAzPkj/C0+nzpnNswvEhmyosptA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759315906; c=relaxed/simple;
	bh=1CPftrf/QNZ3WFkDhM8YcV3g4PMpGfeZSdBHtVYjqa8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=heam7qkEV74DCTpKjUXAO6rTGJVTjPqCzS7QbjAanfPuASjnu/wzTk7UE7yXYT7npjKFBBWRXV5VNkKjHjjnkvh3iX74uceXKBjSPWQKLLOffyfYY/wuI9SccUf2bkeOZx626b5odVxqB/8mMQ2nNtPMmKoe7TnMagbk0irh9Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dgOhwUZr; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759315897;
	bh=1CPftrf/QNZ3WFkDhM8YcV3g4PMpGfeZSdBHtVYjqa8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dgOhwUZrt5C0ehefy4LQbNrRJRcj8IgLKIrq0rGHVdFOdvwU5vyYOrpqA6zcAyBN+
	 J/IO4Br2P36wABWykJXQSqvHSdhSrZDj7QinIPsF2q54w+6d03uUg2N8HEq+OJvGBt
	 W/3t8iJ7NrrHHhKBrGhXT7+vkZQM9jNZ1AjCA/lgT3qRKfkdwxqIJX8Mt3zsnfK6CP
	 G0+9QNP02tb+0B3tZPwGT7K/920KunekcRzkIS+lqJxzUtStE32cm9UjO+uY3UVQ+r
	 5dG7sa9SQR3skr28CmD706Y5G5Y/JQs+wUsJCZ/G0ssKe76KuEV0jCzMNtF7x9HLhp
	 4T7I5v33B6I+g==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C708417E0C54;
	Wed,  1 Oct 2025 12:51:36 +0200 (CEST)
Date: Wed, 1 Oct 2025 12:51:30 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Steven
 Price <steven.price@arm.com>, kernel@collabora.com, Rob Herring
 <robh@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
Subject: Re: [PATCH v4 02/10] drm/panfrost: Handle inexistent GPU during
 probe
Message-ID: <20251001125130.76c134ae@fedora>
In-Reply-To: <20251001022039.1215976-3-adrian.larumbe@collabora.com>
References: <20251001022039.1215976-1-adrian.larumbe@collabora.com>
	<20251001022039.1215976-3-adrian.larumbe@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed,  1 Oct 2025 03:20:23 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Just in case we're dealing with a yet not recognised device.
>=20
> Reviewed-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_gpu.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/pa=
nfrost/panfrost_gpu.c
> index f94337a6c302..8d049a07d393 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> @@ -240,9 +240,10 @@ static const struct panfrost_model gpu_models[] =3D {
>  	/* MediaTek MT8188 Mali-G57 MC3 */
>  	GPU_MODEL(g57, 0x9093,
>  		GPU_REV(g57, 0, 0)),
> +	{0},
>  };
> =20
> -static void panfrost_gpu_init_features(struct panfrost_device *pfdev)
> +static int panfrost_gpu_init_features(struct panfrost_device *pfdev)
>  {
>  	u32 gpu_id, num_js, major, minor, status, rev;
>  	const char *name =3D "unknown";
> @@ -327,6 +328,12 @@ static void panfrost_gpu_init_features(struct panfro=
st_device *pfdev)
>  		break;
>  	}
> =20
> +	if (!model->name) {
> +		dev_err(pfdev->base.dev, "GPU model not found: mali-%s id rev %#x %#x\=
n",
> +			name, gpu_id, rev);
> +		return -ENODEV;
> +	}
> +
>  	bitmap_from_u64(pfdev->features.hw_features, hw_feat);
>  	bitmap_from_u64(pfdev->features.hw_issues, hw_issues);
> =20
> @@ -347,6 +354,8 @@ static void panfrost_gpu_init_features(struct panfros=
t_device *pfdev)
> =20
>  	dev_info(pfdev->base.dev, "shader_present=3D0x%0llx l2_present=3D0x%0ll=
x",
>  		 pfdev->features.shader_present, pfdev->features.l2_present);
> +
> +	return 0;
>  }
> =20
>  void panfrost_cycle_counter_get(struct panfrost_device *pfdev)
> @@ -489,7 +498,9 @@ int panfrost_gpu_init(struct panfrost_device *pfdev)
>  	if (err)
>  		return err;
> =20
> -	panfrost_gpu_init_features(pfdev);
> +	err =3D panfrost_gpu_init_features(pfdev);
> +	if (err)
> +		return err;
> =20
>  	err =3D dma_set_mask_and_coherent(pfdev->base.dev,
>  					DMA_BIT_MASK(FIELD_GET(0xff00,


