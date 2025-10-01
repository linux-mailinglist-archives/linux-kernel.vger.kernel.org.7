Return-Path: <linux-kernel+bounces-838755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEB8BB013E
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 13:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FD333A8982
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 11:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD312C21FC;
	Wed,  1 Oct 2025 11:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BVcY/f+X"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478E6284681
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 11:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759316425; cv=none; b=G4HVk5iQwRoY2zEmayyjNuJ7orhlVRZHArxhA96kQWqynfUewhGmUXtBsOgUVomvU8EnBuGxgciJDnBTi5QeuwDydLSo+zwhWTO8QNXxKeqmg3oR/znFRY8uE+CVMVh8Raaofb4abUIRYLrNW2rp0R79OAOwgbj091hwgz5JM2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759316425; c=relaxed/simple;
	bh=SW3XEJJoCSwUDOgZwA8JUPnvb5XNbAOw9b1x8zcyrL8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jtl+pBNp5rdX8v3m/nszgHW4s8LQO1GOguVGlgiCR9xgP6LvqvySrqg+LC+mzSrLV5hWl5jPObbVMBAiLfqpeUN6kfWqHYiOBQ5LVpGaTyM0dVS6miE5n8wuAsHYiSHpkt+yHlplpEotPEvM18YnCYi5kR6q+zHZcc2c18T78kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BVcY/f+X; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759316421;
	bh=SW3XEJJoCSwUDOgZwA8JUPnvb5XNbAOw9b1x8zcyrL8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BVcY/f+X469vGIJQQSyZP0xFq3AxplPhuYCUUZk/GmTbeVX/t11C0onkeH5KYHsOH
	 9XpyoB4TnsArqN705kTdmdbrpsUbYUmRf5nzLtN+PL9xaWKncLDXcyzbBFeOBGzgnl
	 DpK7G/sHviOKR4DR5oIfs8plIAS/Bdl2L5Y634//vZIRvVrPLL9t3GVs+yVAOFIXYu
	 kGbWdAny8t3/h8H4c/pZS1hweAHJBs16dfe5dI7/sHT13tBltNMHPmj2rT6CVAi3eZ
	 RVHdLojjuSOXO2aG7I9hXBod0BAndT0mWFa1+8l72u37238Ynxo6/nAFgZhJbX1MOa
	 LX9jJKCXOXZmQ==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 23AB117E02B0;
	Wed,  1 Oct 2025 13:00:21 +0200 (CEST)
Date: Wed, 1 Oct 2025 13:00:17 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Steven
 Price <steven.price@arm.com>, kernel@collabora.com, Rob Herring
 <robh@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
Subject: Re: [PATCH v4 06/10] drm/panfrost: Don't rework job IRQ enable mask
 in the enable path
Message-ID: <20251001130017.5eefe8ce@fedora>
In-Reply-To: <20251001022039.1215976-7-adrian.larumbe@collabora.com>
References: <20251001022039.1215976-1-adrian.larumbe@collabora.com>
	<20251001022039.1215976-7-adrian.larumbe@collabora.com>
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

On Wed,  1 Oct 2025 03:20:27 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Up until now, panfrost_job_enable_interrupts() would always recalculate t=
he
> same job IRQ enablement mask, which is effectively a constant.
>=20
> Replace it with a compile-time constant value, and also in another couple
> places where an equivalent expression was being used.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_device.h |  4 ++++
>  drivers/gpu/drm/panfrost/panfrost_job.c    | 19 ++++---------------
>  2 files changed, 8 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm=
/panfrost/panfrost_device.h
> index 474b232bb38e..ac7147ed806b 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> @@ -26,6 +26,10 @@ struct panfrost_perfcnt;
> =20
>  #define MAX_PM_DOMAINS 5
> =20
> +#define ALL_JS_INT_MASK					\
> +	(GENMASK(16 + NUM_JOB_SLOTS - 1, 16) |		\
> +	 GENMASK(NUM_JOB_SLOTS - 1, 0))
> +
>  enum panfrost_drv_comp_bits {
>  	PANFROST_COMP_BIT_GPU,
>  	PANFROST_COMP_BIT_JOB,
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/pa=
nfrost/panfrost_job.c
> index ba934437a8ea..54764ce91dea 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -428,17 +428,10 @@ static struct dma_fence *panfrost_job_run(struct dr=
m_sched_job *sched_job)
> =20
>  void panfrost_job_enable_interrupts(struct panfrost_device *pfdev)
>  {
> -	int j;
> -	u32 irq_mask =3D 0;
> -
>  	clear_bit(PANFROST_COMP_BIT_JOB, pfdev->is_suspended);
> =20
> -	for (j =3D 0; j < NUM_JOB_SLOTS; j++) {
> -		irq_mask |=3D MK_JS_MASK(j);
> -	}
> -
> -	job_write(pfdev, JOB_INT_CLEAR, irq_mask);
> -	job_write(pfdev, JOB_INT_MASK, irq_mask);
> +	job_write(pfdev, JOB_INT_CLEAR, ALL_JS_INT_MASK);
> +	job_write(pfdev, JOB_INT_MASK, ALL_JS_INT_MASK);
>  }
> =20
>  void panfrost_job_suspend_irq(struct panfrost_device *pfdev)
> @@ -757,9 +750,7 @@ panfrost_reset(struct panfrost_device *pfdev,
>  		drm_sched_start(&pfdev->js->queue[i].sched, 0);
> =20
>  	/* Re-enable job interrupts now that everything has been restarted. */
> -	job_write(pfdev, JOB_INT_MASK,
> -		  GENMASK(16 + NUM_JOB_SLOTS - 1, 16) |
> -		  GENMASK(NUM_JOB_SLOTS - 1, 0));
> +	job_write(pfdev, JOB_INT_MASK, ALL_JS_INT_MASK);
> =20
>  	dma_fence_end_signalling(cookie);
>  }
> @@ -832,9 +823,7 @@ static irqreturn_t panfrost_job_irq_handler_thread(in=
t irq, void *data)
> =20
>  	/* Enable interrupts only if we're not about to get suspended */
>  	if (!test_bit(PANFROST_COMP_BIT_JOB, pfdev->is_suspended))
> -		job_write(pfdev, JOB_INT_MASK,
> -			  GENMASK(16 + NUM_JOB_SLOTS - 1, 16) |
> -			  GENMASK(NUM_JOB_SLOTS - 1, 0));
> +		job_write(pfdev, JOB_INT_MASK, ALL_JS_INT_MASK);
> =20
>  	return IRQ_HANDLED;
>  }


