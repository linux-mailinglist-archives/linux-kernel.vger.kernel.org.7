Return-Path: <linux-kernel+bounces-777581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F2DB2DB1E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CD4A175A2A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EE8217716;
	Wed, 20 Aug 2025 11:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="De0r0LQu"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B85258ECE
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755689631; cv=none; b=Im1pdsTSm9PjmQKUJW5XRnd8ZzDCIUWK7YlgtQyjRwl/Yu8rG40uECZ39uluSBtlGUSibss09FP2UgqOZcAbl47en0fppbXaPMnVuK2Bc2JES7WB74wQnVKYtQgH8pwBzsg1TNKcJKNGLVTbiqJytCWIhCJDkE+sF+wTXctt690=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755689631; c=relaxed/simple;
	bh=vyISLxlxFshMv5vNX343+X6/oujfjSfnV6UlyxBdsZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cmo3v8/2yg18ge/XWz11/Uu1JMKl6k03iBSS93ROYXdKUNUCQ/ZUhVvCHa5HiBwVIhNxz1JvZ6GBg9u5KrNJX2nGxeABmqgcWfhDIckv1F7jUnW6khk1mTL/7MDPEe68HnigAVpLOx9chRirq+sK/fqS5QyIPrfeujek1nV3Ixw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=De0r0LQu; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45b49f7aaf5so3270845e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 04:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755689627; x=1756294427; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ugbrjfycGGYv9g6XZ7CvlqKYlU0TANKv6+n9B4FAsKw=;
        b=De0r0LQuO8vC8TNZSez1EtxThEgWlvGB5KKCt1A6jBxpdKpb1nwYpG3imj0R7n0wiL
         eetxnbEXsLDSEDgea2UcdDcejvwKyc216RWl3+6LpcDdeGr/9wSly6IUAmhUAbqQS3zr
         TcEOmA67V8exwJRUtuKr+l/eoFoLe/LFDRbZVivxIE+wEF5a5F27RsNyTacJGRAo51sh
         y8P3uAgIHMFpqEjMGiXcxxq6c1Y90caz3cL/9OMtUn77ZbSPjpC2ng1qGusFJA6AHAb7
         jtwixrDicVOiGGPf0vCjALfWhJKF2ENUSyrZBhyiXRVZmIhVHDGe+5Ro5qtaSoefemu7
         b2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755689627; x=1756294427;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ugbrjfycGGYv9g6XZ7CvlqKYlU0TANKv6+n9B4FAsKw=;
        b=v7rZ2cPaVMawFE5xkxFHcflSSVPEF05//ykNlL7h8JMnUNsBNvzJPPAUIaGXWxC4DN
         HtWLZHonyNXSoYdvEYBBoXPg6y7SE07l31DR7OqimFQ6uFr4TQJI1KRShDWR5fkFrzWq
         myYBnToyGJrPMeYeqqExqe31pRM2CW1XambhPJA5ZqTFgKA4ZMEJGSbaXB5RATsFPSa/
         aLJAjiK4pMvguOElJqIcX9BM8pE3+se6+lgEvrF2P20ION1+HXR8SwTfKoiZum1Ypy3m
         Wf3Onpxcp9F81sNkoEgu6Yj6fAWILawNL6Ug1Q+acZQHxZxXJnf/ePWmzjiB8mWiFFUm
         VPFA==
X-Forwarded-Encrypted: i=1; AJvYcCXTEfedpLl7t73G7nPaGv71ODSYXLuq/Q3ju1dCRqjV+Lz1VdwfgdSGgGdCbRe+MHVDrdTonHbNo3sFzbU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+kGXSHi4zhxMDJPf7qoGj4hV3FiuTTzK8RD39/Je1qgMlCPYE
	xdzBXNRkIN3jqCXsjFhU4Vx2s5oxxPIjrPcRVOgu4RNqjMuothLN1CX1Qu126pYnE4lo/OUvUyG
	Tpdnb4fA=
X-Gm-Gg: ASbGncv4XyMXhncGNeOOuLqYNPSSKSW10GDXoyrV9KcW+X9oUVhZ1syUpN/SWvGKz3w
	y1HpIl0UnyYXemY+EwMXxCks3qhPd51rvtnT6gPj1CeBFk66Bvf+4B9yyCrxELdl7pZ7ZF4rMz8
	+2iLBlJvkkGC7XOqXRLycUF874gXRHTZo6ViOLXJnTupz8nPJQcIaduEDs0Fh2/Sp5Gxvbfd0Rp
	nlC+5eo1kWQFWUBvdizr1UaBzRGVzxTtBnf1m2eKkv+GeWAXK96iqXAE2uWme1MNqgu4GtTYIrX
	mLWeyZQCJgK5S2X46zJ1F/aEuOjE/fA+8Avqy6Q04N9QHJ1JsPuwOzKo5O+3Xk3JLuWt1/Y2yqp
	pIu3llqckSbDMx6kIItEh48qSwZhAmcFEZJ2BEqVkHeB1qzyjYLUa6vwoSUuD/Rw=
X-Google-Smtp-Source: AGHT+IH7iCukwoZsXoHCBFisFNz+2esQIDXoYVnh1NB1CjQ0M403MgCIFjPMkQoJ9ICZUuJA5NHDvA==
X-Received: by 2002:a05:600c:8b17:b0:458:bfe1:4a8a with SMTP id 5b1f17b1804b1-45b479b73b8mr18896805e9.14.1755689626246;
        Wed, 20 Aug 2025 04:33:46 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b47c526d9sm31877735e9.15.2025.08.20.04.33.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 04:33:45 -0700 (PDT)
Message-ID: <667fd351-7ee5-4c42-81fe-60061118f37f@linaro.org>
Date: Wed, 20 Aug 2025 12:33:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/11] media: iris: Enable Secure PAS support with
 IOMMU managed by Linux
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 linux-remoteproc@vger.kernel.org
References: <20250819165447.4149674-1-mukesh.ojha@oss.qualcomm.com>
 <20250819165447.4149674-12-mukesh.ojha@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250819165447.4149674-12-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/08/2025 17:54, Mukesh Ojha wrote:
> Most Qualcomm platforms feature a proprietary hypervisor (such as Gunyah
> or QHEE), which typically handles IOMMU configuration. This includes
> mapping memory regions and device memory resources for remote processors
> by intercepting qcom_scm_pas_auth_and_reset() calls. These mappings are
> later removed during teardown. Additionally, SHM bridge setup is required
> to enable memory protection for both remoteproc metadata and its memory
> regions.
> 
> When the hypervisor is absent, the operating system must perform these
> configurations instead.
> 
> Support for handling IOMMU and SHM setup in the absence of a hypervisor
> is now in place. Extend the Iris driver to enable this functionality on
> platforms where IOMMU is managed by Linux (i.e., non-Gunyah, non-QHEE).
> 
> Additionally, the Iris driver must map the firmware and its required
> resources to the firmware SID, which is now specified via the device tree.
> 
> Co-developed-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>   drivers/media/platform/qcom/iris/iris_core.c  |   9 +-
>   drivers/media/platform/qcom/iris/iris_core.h  |   6 +
>   .../media/platform/qcom/iris/iris_firmware.c  | 156 ++++++++++++++++--
>   .../media/platform/qcom/iris/iris_firmware.h  |   2 +
>   4 files changed, 155 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_core.c b/drivers/media/platform/qcom/iris/iris_core.c
> index 0fa0a3b549a2..57417d4d7e05 100644
> --- a/drivers/media/platform/qcom/iris/iris_core.c
> +++ b/drivers/media/platform/qcom/iris/iris_core.c
> @@ -17,6 +17,7 @@ void iris_core_deinit(struct iris_core *core)
>   	mutex_lock(&core->lock);
>   	iris_fw_unload(core);
>   	iris_vpu_power_off(core);
> +	iris_fw_deinit(core);
>   	iris_hfi_queues_deinit(core);
>   	core->state = IRIS_CORE_DEINIT;
>   	mutex_unlock(&core->lock);
> @@ -65,10 +66,14 @@ int iris_core_init(struct iris_core *core)
>   	if (ret)
>   		goto error_queue_deinit;
>   
> -	ret = iris_fw_load(core);
> +	ret = iris_fw_init(core);
>   	if (ret)
>   		goto error_power_off;
>   
> +	ret = iris_fw_load(core);
> +	if (ret)
> +		goto error_firmware_deinit;
> +
>   	ret = iris_vpu_boot_firmware(core);
>   	if (ret)
>   		goto error_unload_fw;
> @@ -83,6 +88,8 @@ int iris_core_init(struct iris_core *core)
>   
>   error_unload_fw:
>   	iris_fw_unload(core);
> +error_firmware_deinit:
> +	iris_fw_deinit(core);
>   error_power_off:
>   	iris_vpu_power_off(core);
>   error_queue_deinit:
> diff --git a/drivers/media/platform/qcom/iris/iris_core.h b/drivers/media/platform/qcom/iris/iris_core.h
> index aeeac32a1f6d..57eeefb38f22 100644
> --- a/drivers/media/platform/qcom/iris/iris_core.h
> +++ b/drivers/media/platform/qcom/iris/iris_core.h
> @@ -73,6 +73,12 @@ struct iris_core {
>   	int					irq;
>   	struct v4l2_device			v4l2_dev;
>   	struct video_device			*vdev_dec;
> +	bool					has_iommu;
> +	struct video_firmware {
> +		struct device *dev;
> +		struct qcom_scm_pas_ctx *ctx;
> +		struct iommu_domain *iommu_domain;
> +	} fw;
>   	const struct v4l2_file_operations	*iris_v4l2_file_ops;
>   	const struct v4l2_ioctl_ops		*iris_v4l2_ioctl_ops;
>   	const struct vb2_ops			*iris_vb2_ops;
> diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/media/platform/qcom/iris/iris_firmware.c
> index f1b5cd56db32..e3f2fe5c9d7a 100644
> --- a/drivers/media/platform/qcom/iris/iris_firmware.c
> +++ b/drivers/media/platform/qcom/iris/iris_firmware.c
> @@ -3,10 +3,18 @@
>    * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
>    */
>   
> +#include <linux/device.h>
>   #include <linux/firmware.h>
> -#include <linux/firmware/qcom/qcom_scm.h>
> +#include <linux/kernel.h>
> +#include <linux/iommu.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
>   #include <linux/of_address.h>
>   #include <linux/of_reserved_mem.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_device.h>
> +#include <linux/firmware/qcom/qcom_scm.h>
> +#include <linux/sizes.h>
>   #include <linux/soc/qcom/mdt_loader.h>
>   
>   #include "iris_core.h"
> @@ -17,15 +25,14 @@
>   static int iris_load_fw_to_memory(struct iris_core *core, const char *fw_name)
>   {
>   	u32 pas_id = core->iris_platform_data->pas_id;
> +	struct qcom_scm_pas_ctx *ctx;
>   	const struct firmware *firmware = NULL;
>   	struct device *dev = core->dev;
> -	struct reserved_mem *rmem;
> -	struct device_node *node;
> -	phys_addr_t mem_phys;
> -	size_t res_size;
> -	ssize_t fw_size;
> -	void *mem_virt;
> -	int ret;
> +	struct reserved_mem *rmem = NULL;
> +	struct device_node *node = NULL;
> +	ssize_t fw_size = 0;
> +	void *mem_virt = NULL;
> +	int ret = 0;
>   
>   	if (strlen(fw_name) >= MAX_FIRMWARE_NAME_SIZE - 4)
>   		return -EINVAL;
> @@ -39,36 +46,64 @@ static int iris_load_fw_to_memory(struct iris_core *core, const char *fw_name)
>   	if (!rmem)
>   		return -EINVAL;
>   
> -	mem_phys = rmem->base;
> -	res_size = rmem->size;
> +	if (core->has_iommu)
> +		dev = core->fw.dev;
>   
> +	ctx = qcom_scm_pas_ctx_init(dev, pas_id, rmem->base, rmem->size, false);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	ctx->has_iommu = core->has_iommu;
>   	ret = request_firmware(&firmware, fw_name, dev);
>   	if (ret)
>   		return ret;
>   
>   	fw_size = qcom_mdt_get_size(firmware);
> -	if (fw_size < 0 || res_size < (size_t)fw_size) {
> +	if (fw_size < 0 || rmem->size < (size_t)fw_size) {
>   		ret = -EINVAL;
>   		goto err_release_fw;
>   	}
>   
> -	mem_virt = memremap(mem_phys, res_size, MEMREMAP_WC);
> +	mem_virt = memremap(rmem->base, rmem->size, MEMREMAP_WC);
>   	if (!mem_virt) {
>   		ret = -ENOMEM;
>   		goto err_release_fw;
>   	}
>   
> -	ret = qcom_mdt_load(dev, firmware, fw_name,
> -			    pas_id, mem_virt, mem_phys, res_size, NULL);
> +	ret = qcom_mdt_pas_load(ctx, firmware, fw_name, mem_virt, NULL);
>   	if (ret)
>   		goto err_mem_unmap;
>   
> -	ret = qcom_scm_pas_auth_and_reset(pas_id);
> +	if (core->has_iommu) {
> +		ret = iommu_map(core->fw.iommu_domain, 0, rmem->base, rmem->size,
> +				IOMMU_READ | IOMMU_WRITE | IOMMU_PRIV, GFP_KERNEL);
> +		if (ret)
> +			goto err_mem_unmap;
> +
> +		/*
> +		 * Firmware has no support for resource table for now, so, lets
> +		 * pass NULL and zero for input resource table and input resource
> +		 * table respectively.
> +		 */
> +		ret = qcom_mdt_pas_map_devmem_rscs(ctx, core->fw.iommu_domain, NULL, 0);
> +		if (ret)
> +			goto err_unmap_carveout;
> +	}
> +
> +	ret = qcom_scm_pas_prepare_and_auth_reset(ctx);
>   	if (ret)
> -		goto err_mem_unmap;
> +		goto err_unmap_devmem_rscs;
> +
> +	core->fw.ctx = ctx;
>   
>   	return ret;
>   
> +err_unmap_devmem_rscs:
> +	if (core->has_iommu)
> +		qcom_mdt_pas_unmap_devmem_rscs(ctx, core->fw.iommu_domain);
> +err_unmap_carveout:
> +	if (core->has_iommu)
> +		iommu_unmap(core->fw.iommu_domain, 0, rmem->size);
>   err_mem_unmap:
>   	memunmap(mem_virt);
>   err_release_fw:
> @@ -109,10 +144,97 @@ int iris_fw_load(struct iris_core *core)
>   
>   int iris_fw_unload(struct iris_core *core)
>   {
> -	return qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
> +	struct qcom_scm_pas_ctx *ctx;
> +	int ret;
> +
> +	ctx = core->fw.ctx;
> +	ret = qcom_scm_pas_shutdown(ctx->peripheral);
> +	if (core->has_iommu) {
> +		iommu_unmap(core->fw.iommu_domain, 0, ctx->mem_size);
> +		qcom_mdt_pas_unmap_devmem_rscs(ctx, core->fw.iommu_domain);
> +	}
> +
> +	return ret;
>   }
>   
>   int iris_set_hw_state(struct iris_core *core, bool resume)
>   {
>   	return qcom_scm_set_remote_state(resume, 0);
>   }
> +
> +int iris_fw_init(struct iris_core *core)
> +{
> +	struct platform_device_info info;
> +	struct iommu_domain *iommu_dom;
> +	struct platform_device *pdev;
> +	struct device_node *np;
> +	int ret;
> +
> +	np = of_get_child_by_name(core->dev->of_node, "video-firmware");
> +	if (!np)
> +		return 0;
> +
> +	core->has_iommu = true;

You set has_iommu = true and then you check this flag throughout this 
patch..


> +	memset(&info, 0, sizeof(info));
> +	info.fwnode = &np->fwnode;
> +	info.parent = core->dev;
> +	info.name = np->name;
> +	info.dma_mask = DMA_BIT_MASK(32);
> +
> +	pdev = platform_device_register_full(&info);
> +	if (IS_ERR(pdev)) {
> +		of_node_put(np);
> +		return PTR_ERR(pdev);
> +	}
> +
> +	pdev->dev.of_node = np;
> +
> +	ret = of_dma_configure(&pdev->dev, np, true);
> +	if (ret) {
> +		dev_err(core->dev, "failed to allocate domain\n");
> +		goto err_unregister;
> +	}
> +
> +	core->fw.dev = &pdev->dev;
> +
> +	iommu_dom = iommu_get_domain_for_dev(core->fw.dev);
> +	if (!iommu_dom) {
> +		dev_err(core->fw.dev, "Failed to get iommu domain\n");
> +		ret = -EINVAL;
> +		goto err_iommu_free;
> +	}
> +
> +	ret = iommu_attach_device(iommu_dom, core->fw.dev);
> +	if (ret) {
> +		dev_err(core->fw.dev, "could not attach device\n");
> +		goto err_iommu_free;
> +	}
> +
> +	core->fw.iommu_domain = iommu_dom;
> +
> +	of_node_put(np);
> +
> +	return 0;
> +
> +err_iommu_free:
> +	iommu_domain_free(iommu_dom);
> +err_unregister:
> +	platform_device_unregister(pdev);
> +	of_node_put(np);
> +	return ret;
> +}
> +
> +void iris_fw_deinit(struct iris_core *core)
> +{
> +	struct iommu_domain *iommu_dom;
> +
> +	if (!core->has_iommu)

This is fixed in your code is it not ?

You presumably are going to change this later otherwise suggest dropping

---
bod

