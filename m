Return-Path: <linux-kernel+bounces-816175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 056FBB5708C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A49984E1615
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 06:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3541428751B;
	Mon, 15 Sep 2025 06:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bey7w97y"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A2827E045;
	Mon, 15 Sep 2025 06:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757918567; cv=none; b=OignkUuadie3dGTPJSC4L51gN+2e5gloWmMO0/Y1sx8EC63ZhXIyI81B37XYUD8vU6uJLWTyqVkciECbhQnrLEXFbFtrWXaguNXm+BFC0G+zaBMaauB4UPzA7xAzgUfTfjKXpx0omTob0U7LLePOxkLWtD7PKGZpRpQ2adeWdeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757918567; c=relaxed/simple;
	bh=dOUlmwtjQ7dFqHBYte2ksVsiBR2UJ6V2cqwUM9/Qyf0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kInMiQbBBjJUsxpMiilDJGpJBd00LRTMJk+dsYs8Fgw8kQO5yxbyoAiojjX1tfArJf1a3Ou+Z65ik8W1aeZLjqA5RPBNFKWRY+1/j+dAvr+Tgc5IVc7zy97XQOQbJEZea4e/B6qAJyoc2Wy8VhiM6OFikxH/qsDbT+V+SAvxzms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bey7w97y; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757918557;
	bh=dOUlmwtjQ7dFqHBYte2ksVsiBR2UJ6V2cqwUM9/Qyf0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bey7w97y3A/+4kjYut9Z4evws1FAIusM2YegGYIePSac8lorZw+rSQA/uhixwRjrF
	 TFP8uehhYxvTBmldzsMNsERWsgapJW8u+Hk8sr6rasl3G3uyJh50fEb6VzlsWp07PI
	 WVCc1Z8Oh4ohIsrP9CPsuDJRoBDCPUOKCsharMM+yHZ0l5NdReF2HjGVFO9m2lMjFk
	 cU/Wmxb+skS2F8AbXqocdpalPP+Ou/dpyr9UOEyoJF+CSIiU0DH7LcibQk9T7+oMN+
	 R2tO05DbP1w7PbsRXvxWnxEkAfya+kPWW5Hw4BnR4SStoRu1HOz10uLh5JL+/bRBmP
	 eCHI22bPmH3HQ==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7D89E17E046C;
	Mon, 15 Sep 2025 08:42:36 +0200 (CEST)
Date: Mon, 15 Sep 2025 08:42:24 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Chia-I Wu <olvaffe@gmail.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 2/2] drm/panthor: add custom ASN_HASH support for
 mt8196
Message-ID: <20250915084224.08fcc2a4@fedora>
In-Reply-To: <20250913002155.1163908-3-olvaffe@gmail.com>
References: <20250913002155.1163908-1-olvaffe@gmail.com>
	<20250913002155.1163908-3-olvaffe@gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Sep 2025 17:21:55 -0700
Chia-I Wu <olvaffe@gmail.com> wrote:

> Add panthor_soc_data to control custom ASN_HASH. Add compatible string
> for "mediatek,mt8196-mali" and enable custom ASN_HASH for the soc.
> 
> Without custom ASN_HASH, FW fails to boot
> 
>   panthor 48000000.gpu: [drm] *ERROR* Unhandled Page fault in AS0 at VA 0x0000000000000000
>   panthor 48000000.gpu: [drm] *ERROR* Failed to boot MCU (status=fatal)
>   panthor 48000000.gpu: probe with driver panthor failed with error -110
> 
> With custom ASN_HASH, panthor probes fine and userspace boots to ui just
> fine as well
> 
>   panthor 48000000.gpu: [drm] clock rate = 0
>   panthor 48000000.gpu: EM: created perf domain
>   panthor 48000000.gpu: [drm] Mali-G925-Immortalis id 0xd830 major 0x0 minor 0x1 status 0x5
>   panthor 48000000.gpu: [drm] Features: L2:0x8130306 Tiler:0x809 Mem:0x301 MMU:0x2830 AS:0xff
>   panthor 48000000.gpu: [drm] shader_present=0xee0077 l2_present=0x1 tiler_present=0x1
>   panthor 48000000.gpu: [drm] Firmware protected mode entry not be supported, ignoring
>   panthor 48000000.gpu: [drm] Firmware git sha: 27713280172c742d467a4b7d11180930094092ec
>   panthor 48000000.gpu: [drm] CSF FW using interface v3.13.0, Features 0x10 Instrumentation features 0x71
>   [drm] Initialized panthor 1.5.0 for 48000000.gpu on minor 1
> 
> Note that the clock and the regulator drivers are not upstreamed yet.
> They might as well take a different form when upstreamed.
> 
> Signed-off-by: Chia-I Wu <olvaffe@gmail.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> 
> ---
> v2:
>  - remove CONFIG_DRM_PANTHOR_SOC_MT8196 and panthor_soc*.[ch]
>  - update commit message
> ---
>  drivers/gpu/drm/panthor/panthor_device.c |  2 ++
>  drivers/gpu/drm/panthor/panthor_device.h | 14 +++++++++++++
>  drivers/gpu/drm/panthor/panthor_drv.c    |  6 ++++++
>  drivers/gpu/drm/panthor/panthor_gpu.c    | 25 +++++++++++++++++++++++-
>  drivers/gpu/drm/panthor/panthor_regs.h   |  4 ++++
>  5 files changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
> index 81df49880bd87..c7033d82cef55 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -172,6 +172,8 @@ int panthor_device_init(struct panthor_device *ptdev)
>  	struct page *p;
>  	int ret;
>  
> +	ptdev->soc_data = of_device_get_match_data(ptdev->base.dev);
> +
>  	init_completion(&ptdev->unplug.done);
>  	ret = drmm_mutex_init(&ptdev->base, &ptdev->unplug.lock);
>  	if (ret)
> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
> index 4fc7cf2aeed57..9f0649ecfc4fc 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> @@ -31,6 +31,17 @@ struct panthor_perfcnt;
>  struct panthor_vm;
>  struct panthor_vm_pool;
>  
> +/**
> + * struct panthor_soc_data - Panthor SoC Data
> + */
> +struct panthor_soc_data {
> +	/** @asn_hash_enable: True if GPU_L2_CONFIG_ASN_HASH_ENABLE must be set. */
> +	bool asn_hash_enable;
> +
> +	/** @asn_hash: ASN_HASH values when asn_hash_enable is true. */
> +	u32 asn_hash[3];
> +};
> +
>  /**
>   * enum panthor_device_pm_state - PM state
>   */
> @@ -93,6 +104,9 @@ struct panthor_device {
>  	/** @base: Base drm_device. */
>  	struct drm_device base;
>  
> +	/** @soc_data: Optional SoC data. */
> +	const struct panthor_soc_data *soc_data;
> +
>  	/** @phys_addr: Physical address of the iomem region. */
>  	phys_addr_t phys_addr;
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index be962b1387f03..9dd90754865ac 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -1682,7 +1682,13 @@ static struct attribute *panthor_attrs[] = {
>  
>  ATTRIBUTE_GROUPS(panthor);
>  
> +static const struct panthor_soc_data soc_data_mediatek_mt8196 = {
> +	.asn_hash_enable = true,
> +	.asn_hash = { 0xb, 0xe, 0x0, },
> +};
> +
>  static const struct of_device_id dt_match[] = {
> +	{ .compatible = "mediatek,mt8196-mali", .data = &soc_data_mediatek_mt8196, },
>  	{ .compatible = "rockchip,rk3588-mali" },
>  	{ .compatible = "arm,mali-valhall-csf" },
>  	{}
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
> index db69449a5be09..9d98720ce03fd 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -52,6 +52,28 @@ static void panthor_gpu_coherency_set(struct panthor_device *ptdev)
>  		ptdev->coherent ? GPU_COHERENCY_PROT_BIT(ACE_LITE) : GPU_COHERENCY_NONE);
>  }
>  
> +static void panthor_gpu_l2_config_set(struct panthor_device *ptdev)
> +{
> +	const struct panthor_soc_data *data = ptdev->soc_data;
> +	u32 l2_config;
> +	u32 i;
> +
> +	if (!data || !data->asn_hash_enable)
> +		return;
> +
> +	if (GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id) < 11) {
> +		drm_err(&ptdev->base, "Custom ASN hash not supported by the device");
> +		return;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(data->asn_hash); i++)
> +		gpu_write(ptdev, GPU_ASN_HASH(i), data->asn_hash[i]);
> +
> +	l2_config = gpu_read(ptdev, GPU_L2_CONFIG);
> +	l2_config |= GPU_L2_CONFIG_ASN_HASH_ENABLE;
> +	gpu_write(ptdev, GPU_L2_CONFIG, l2_config);
> +}
> +
>  static void panthor_gpu_irq_handler(struct panthor_device *ptdev, u32 status)
>  {
>  	gpu_write(ptdev, GPU_INT_CLEAR, status);
> @@ -241,8 +263,9 @@ int panthor_gpu_l2_power_on(struct panthor_device *ptdev)
>  			      hweight64(ptdev->gpu_info.shader_present));
>  	}
>  
> -	/* Set the desired coherency mode before the power up of L2 */
> +	/* Set the desired coherency mode and L2 config before the power up of L2 */
>  	panthor_gpu_coherency_set(ptdev);
> +	panthor_gpu_l2_config_set(ptdev);
>  
>  	return panthor_gpu_power_on(ptdev, L2, 1, 20000);
>  }
> diff --git a/drivers/gpu/drm/panthor/panthor_regs.h b/drivers/gpu/drm/panthor/panthor_regs.h
> index 8bee76d01bf83..8fa69f33e911e 100644
> --- a/drivers/gpu/drm/panthor/panthor_regs.h
> +++ b/drivers/gpu/drm/panthor/panthor_regs.h
> @@ -64,6 +64,8 @@
>  
>  #define GPU_FAULT_STATUS				0x3C
>  #define GPU_FAULT_ADDR					0x40
> +#define GPU_L2_CONFIG					0x48
> +#define   GPU_L2_CONFIG_ASN_HASH_ENABLE			BIT(24)
>  
>  #define GPU_PWR_KEY					0x50
>  #define  GPU_PWR_KEY_UNLOCK				0x2968A819
> @@ -110,6 +112,8 @@
>  
>  #define GPU_REVID					0x280
>  
> +#define GPU_ASN_HASH(n)					(0x2C0 + ((n) * 4))
> +
>  #define GPU_COHERENCY_FEATURES				0x300
>  #define GPU_COHERENCY_PROT_BIT(name)			BIT(GPU_COHERENCY_  ## name)
>  


