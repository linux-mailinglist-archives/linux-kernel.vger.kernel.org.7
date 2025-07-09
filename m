Return-Path: <linux-kernel+bounces-723811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60671AFEB3E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C7625434FA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C09C2E0B7C;
	Wed,  9 Jul 2025 13:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atFHJrW6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667112E174A;
	Wed,  9 Jul 2025 13:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069462; cv=none; b=d1pqTear64UItiand8sGB+xjWP0jTp+WFb6cCoGC36ydCY9PX4ATJz3E2d5G/YcODyiZDyfp28JBf5tCYL8X7G9vDjQSJuTK8nmmVhU6k7jtntM6CrwzFPRzhsMxVslFsUnbTfYs2O0Aqxwyi1gRMoJXmTHz9RSgIkGXHSoT4/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069462; c=relaxed/simple;
	bh=CYSBppkuMWh0PsivJ/24T0R73/ywLooQ6TznTg77ymo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=egJtw7nFqjgh/qcHaO4Yh39ys/NM8Meb0PJhUDBxFXimJ+NmPhMco6vKwUnnaQFTJs2wTn9U0ArLWkd1t8cWCAqoFCflW8cH/jEaWbl9MQPleiCrwhILfZ47cNkdTLtY2r7QJsoAcboEd/xHckYUlA6SK6FQFlRJxooiJvy7xSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atFHJrW6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A5CC4CEEF;
	Wed,  9 Jul 2025 13:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069462;
	bh=CYSBppkuMWh0PsivJ/24T0R73/ywLooQ6TznTg77ymo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=atFHJrW6hs3KC8pKbqwAQScD2CC58aURrBOWQiiOtkNPrNiOComwajUCe1VsYVKMV
	 hzZA14rLnely4R9sOVPE1DeQJvYvyUYK7H0MzLNRtq0F3YVQeJSe54KPTxwHjsyRv0
	 JiC8CF2EHI7tZQMUV0C/1LXu7BtvU7wGNVMvlsLn1sXF+JvoKQX7TW7b6p9Sd+N8j9
	 vKPy1g0fmSataqsFKbFHSWM6P3lt0NsyoE+PtntgEcvPc4Eym3aRMvF/InjhgStPek
	 GGAbJzZalVgCGvVpV2SKOJQ4ZE+XWy9gENisRZZJJlDUUE8Kb3tTYAebLGOoOUTJ/w
	 JVJxg7WhVH06A==
Message-ID: <7d2401d6-d897-49d7-a3be-50de0727b037@kernel.org>
Date: Wed, 9 Jul 2025 15:57:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: samsung: Implement abox generic structure
To: ew.kim@samsung.com, s.nawrocki@samsung.com, lgirdwood@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
References: <CGME20250709002150epcas2p467416bdbc16754726599a0cacb1feecc@epcas2p4.samsung.com>
 <20250709001002.378246-1-ew.kim@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250709001002.378246-1-ew.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/07/2025 02:10, ew.kim@samsung.com wrote:
> +/**
> + * @cnotice
> + * @prdcode
> + * @Sub_SW_Component{abox generic}
> + * @ALM_Link {work item url}
> + * @purpose "Disbaling the abox generic"
> + * @logic "Disbale the abox generic"
> + * \image html
> + * @params
> + * @param{in, pdev->dev, struct::device, !NULL}
> + * @endparam
> + * @noret
> + */
> +static void samsung_abox_generic_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct abox_generic_data *data = dev_get_drvdata(dev);
> +
> +	dev_info(dev, "%s\n", __func__);

This is just poor code. Clean it up from all such oddities popular in
downstream. Look at upstream code. Do you see such code there? No.

> +
> +	if (!data) {
> +		dev_err(dev, "%s: Invalid abox generic data\n", __func__);
> +		return;
> +	}
> +	return;
> +}
> +
> +/**
> + * @cnotice
> + * @prdcode
> + * @Sub_SW_Component{abox generic}
> + * @ALM_Link {work item url}
> + * @purpose "shutdown of the abox generic"
> + * @logic "Disbale the abox hardware by calling the following function
> + * pm_runtime_disable(dev)"
> + * \image html
> + * @params
> + * @param{in, pdev->dev, struct:: device, !NULL}
> + * @endparam
> + * @noret
> + */
> +static void samsung_abox_generic_shutdown(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct abox_generic_data *data = dev_get_drvdata(dev);
> +
> +	if (!data) {
> +		dev_err(dev, "%s: Invalid abox generic data\n", __func__);
> +		return;
> +	}
> +	return;
> +}
> +
> +static const struct of_device_id samsung_abox_generic_match[] = {
> +	{
> +		.compatible = "samsung,abox_generic",
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, samsung_abox_generic_match);
> +
> +static const struct dev_pm_ops samsung_abox_generic_pm = {
> +	SET_SYSTEM_SLEEP_PM_OPS(abox_generic_suspend, abox_generic_resume)
> +};
> +
> +struct platform_driver samsung_abox_generic_driver = {
> +	.probe  = samsung_abox_generic_probe,
> +	.remove = samsung_abox_generic_remove,
> +	.shutdown = samsung_abox_generic_shutdown,
> +	.driver = {
> +		.name = "samsung-abox-generic",
> +		.owner = THIS_MODULE,

So that's indeed 2013 code you upstream. We really want you to clean it
up before you post some ancient stuff like that.


> +		.of_match_table = of_match_ptr(samsung_abox_generic_match),
> +		.pm = &samsung_abox_generic_pm,
> +	},
> +};
> +
> +module_platform_driver(samsung_abox_generic_driver);
> +/* Module information */

Useless comment.

> +MODULE_AUTHOR("Eunwoo Kim, <ew.kim@samsung.com>");
> +MODULE_DESCRIPTION("Samsung ASoC A-Box Generic Driver");
> +MODULE_ALIAS("platform:samsung-abox-generic");

No, drop. This was raised so many times already...

> +MODULE_LICENSE("GPL v2");
> +
> diff --git a/sound/soc/samsung/auto_abox/generic/include/abox_generic.h b/sound/soc/samsung/auto_abox/generic/include/abox_generic.h
> new file mode 100644
> index 000000000000..1c954272e2b5
> --- /dev/null
> +++ b/sound/soc/samsung/auto_abox/generic/include/abox_generic.h
> @@ -0,0 +1,87 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * ALSA SoC - Samsung ABOX Share Function and Data structure
> + * for Exynos specific extensions
> + *
> + * Copyright (C) 2013-2020 Samsung Electronics Co., Ltd.
> + *
> + * EXYNOS - sound/soc/samsung/abox/include/abox_generic.h

Same with paths. Do you see them anywhere in the kernel?

> + */
> +
> +#ifndef __SND_SOC_ABOX_GENERIC_BASE_H
> +#define __SND_SOC_ABOX_GENERIC_BASE_H
> +
> +#define ABOX_GENERIC_DATA		abox_generic_get_abox_generic_data();
> +
> +struct snd_soc_pcm_runtime;
> +
> +enum abox_soc_ioctl_cmd {
> +	ABOX_SOC_IOCTL_GET_NUM_OF_RDMA,
> +	ABOX_SOC_IOCTL_GET_NUM_OF_WDMA,
> +	ABOX_SOC_IOCTL_GET_NUM_OF_UAIF,
> +	ABOX_SOC_IOCTL_GET_SOC_TIMER,
> +	ABOX_SOC_IOCTL_SET_DMA_BUFFER,
> +	ABOX_SOC_IOCTL_SET_PP_POINTER,
> +	ABOX_SOC_IOCTL_SET_PERF_PERIOD,
> +	ABOX_SOC_IOCTL_CHECK_TIME_MUTEX,
> +	ABOX_SOC_IOCTL_CHECK_TIME_NO_MUTEX,
> +	ABOX_SOC_IOCTL_PCM_DUMP_INTR,
> +	ABOX_SOC_IOCTL_PCM_DUMP_CLOSE,
> +	ABOX_SOC_IOCTL_PCM_DUMP_ADD_CONTROL,
> +	ABOX_SOC_IOCTL_MAX
> +};
> +
> +typedef int (*SOC_IOCTL)(struct device *soc_dev, enum abox_soc_ioctl_cmd cmd, void *data);

Follow coding style.

> +
> +struct abox_generic_data {
> +	struct platform_device *pdev;
> +	struct platform_device **pdev_pcm_playback;
> +	struct platform_device **pdev_pcm_capture;
> +	unsigned int num_of_pcm_playback;
> +	unsigned int num_of_pcm_capture;
> +	unsigned int num_of_i2s_dummy;
> +	unsigned int num_of_rdma;
> +	unsigned int num_of_wdma;
> +	unsigned int num_of_uaif;
> +	struct device *soc_dev;
> +	SOC_IOCTL soc_ioctl;
> +};
> +
> +
> +/************ Internal API ************/

Then why do you expose it via header?

> +
> +struct abox_generic_data *abox_generic_get_abox_generic_data(void);
> +
> +int abox_generic_set_dma_buffer(struct device *pcm_dev);
> +
> +int abox_generic_request_soc_ioctl(struct device *generic_dev, enum abox_soc_ioctl_cmd cmd,
> +	void *data);
> +
> +int abox_generic_set_pp_pointer(struct device *pcm_dev);
> +
> +
> +
> +
> +/************ External API ************/
> +
> +extern struct device *abox_generic_find_fe_dev_from_rtd(struct snd_soc_pcm_runtime *be);

You cannot have external API. All API is internal first.

> +
> +extern struct platform_device *abox_generic_get_pcm_platform_dev(int pcm_id,
> +	int stream_type);
> +
Best regards,
Krzysztof

