Return-Path: <linux-kernel+bounces-848444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB8ABCDC82
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 929611A6774D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261272F8BFA;
	Fri, 10 Oct 2025 15:23:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2085F2F618B
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 15:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760109791; cv=none; b=M6sRFsow8H1/Db0dAgD5h3iWaJ5lev8bZ1s3/IOJP1/HHb1BoouK9Ac7gl89ICbxYyktdI0uU1xc5ZDAvB3E7ENP1ofdrrPKlv9FdV7wQq1tAJY4+Qk2eClTwYQBohXlmErKrqTVuiXTGLoxcmbiCJ303KAPVvWtR4Ya9ph95pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760109791; c=relaxed/simple;
	bh=b6U6I+R3YkCWG8VlZzjudcPduzhx6TE6xWqusLNS/6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CQ8pMeZSefZoAWhQT+afzsIYmtu1BgVJiUFUHtEo/jPxayAiPzl1Jc3RWJy8PRAp7ZIYp+z4kZDU9dRZ32hwgzVPj3UxULlBcG6GfTxbKq1FFX/eJxxH1W3Tiz2n224Zb6qV7OuYLvnHkVxxglcu17P2VijbsxNShZfkL0PPwLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 743511063;
	Fri, 10 Oct 2025 08:23:01 -0700 (PDT)
Received: from [192.168.20.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DDFB3F66E;
	Fri, 10 Oct 2025 08:23:09 -0700 (PDT)
Message-ID: <281dcb37-9e50-42ed-918d-3a527e738e6e@arm.com>
Date: Fri, 10 Oct 2025 10:23:08 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coco: guest: arm64: Update ARM CCA guest driver
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 linux-coco@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Steven Price <steven.price@arm.com>, Gavin Shan <gshan@redhat.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Sami Mujawar <sami.mujawar@arm.com>
References: <20251008132758.784275-1-aneesh.kumar@kernel.org>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20251008132758.784275-1-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/25 8:27 AM, Aneesh Kumar K.V (Arm) wrote:
> Make preparatory updates to the ARM CCA guest driver:
> 
>   - Switch from using a platform device to a faux device (based on
>     feedback in [1])
>   - Rename the device from `arm-cca-dev` to `arm-rsi-dev`, so that the
>     host driver can register an equivalent `arm-rmi-dev`
> 
> These changes are purely structural and introduce no new functionality.
> Subsequent patches will extend this driver to add guest device
> assignment support.
> 
> [1] https://lore.kernel.org/all/2025073035-bulginess-rematch-b92e@gregkh
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
> NOTE:
> This patch is sent early outside the patchseries to avoid userspace from
> depending on the presence of the newly introduced platform device.
> The platform device was added in v6.14-rc1.


At this point, changing the platform device name also breaks systemd's 
confidential vm detection, because its using this device name as the 
first step.


> 
>   arch/arm64/include/asm/rsi.h                  |  2 +-
>   arch/arm64/kernel/rsi.c                       | 15 -----
>   drivers/virt/coco/arm-cca-guest/Makefile      |  3 +
>   .../{arm-cca-guest.c => arm-cca.c}            | 65 +++++++++++--------
>   4 files changed, 41 insertions(+), 44 deletions(-)
>   rename drivers/virt/coco/arm-cca-guest/{arm-cca-guest.c => arm-cca.c} (85%)
> 
> diff --git a/arch/arm64/include/asm/rsi.h b/arch/arm64/include/asm/rsi.h
> index b42aeac05340..26ef6143562b 100644
> --- a/arch/arm64/include/asm/rsi.h
> +++ b/arch/arm64/include/asm/rsi.h
> @@ -10,7 +10,7 @@
>   #include <linux/jump_label.h>
>   #include <asm/rsi_cmds.h>
>   
> -#define RSI_PDEV_NAME "arm-cca-dev"
> +#define RSI_DEV_NAME "arm-rsi-dev"
>   
>   DECLARE_STATIC_KEY_FALSE(rsi_present);
>   
> diff --git a/arch/arm64/kernel/rsi.c b/arch/arm64/kernel/rsi.c
> index ce4778141ec7..569ef08750e5 100644
> --- a/arch/arm64/kernel/rsi.c
> +++ b/arch/arm64/kernel/rsi.c
> @@ -140,18 +140,3 @@ void __init arm64_rsi_init(void)
>   
>   	static_branch_enable(&rsi_present);
>   }
> -
> -static struct platform_device rsi_dev = {
> -	.name = RSI_PDEV_NAME,
> -	.id = PLATFORM_DEVID_NONE
> -};
> -
> -static int __init arm64_create_dummy_rsi_dev(void)
> -{
> -	if (is_realm_world() &&
> -	    platform_device_register(&rsi_dev))
> -		pr_err("failed to register rsi platform device\n");
> -	return 0;
> -}
> -
> -arch_initcall(arm64_create_dummy_rsi_dev)
> diff --git a/drivers/virt/coco/arm-cca-guest/Makefile b/drivers/virt/coco/arm-cca-guest/Makefile
> index 69eeba08e98a..609462ea9438 100644
> --- a/drivers/virt/coco/arm-cca-guest/Makefile
> +++ b/drivers/virt/coco/arm-cca-guest/Makefile
> @@ -1,2 +1,5 @@
>   # SPDX-License-Identifier: GPL-2.0-only
> +#
>   obj-$(CONFIG_ARM_CCA_GUEST) += arm-cca-guest.o
> +
> +arm-cca-guest-$(CONFIG_TSM) +=  arm-cca.o
> diff --git a/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c b/drivers/virt/coco/arm-cca-guest/arm-cca.c
> similarity index 85%
> rename from drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
> rename to drivers/virt/coco/arm-cca-guest/arm-cca.c
> index 0c9ea24a200c..89d9e7f8eb5d 100644
> --- a/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
> +++ b/drivers/virt/coco/arm-cca-guest/arm-cca.c
> @@ -1,8 +1,9 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /*
> - * Copyright (C) 2023 ARM Ltd.
> + * Copyright (C) 2025 ARM Ltd.
>    */
>   
> +#include <linux/device/faux.h>
>   #include <linux/arm-smccc.h>
>   #include <linux/cc_platform.h>
>   #include <linux/kernel.h>
> @@ -181,52 +182,60 @@ static int arm_cca_report_new(struct tsm_report *report, void *data)
>   	return ret;
>   }
>   
> -static const struct tsm_report_ops arm_cca_tsm_ops = {
> +static const struct tsm_report_ops arm_cca_tsm_report_ops = {
>   	.name = KBUILD_MODNAME,
>   	.report_new = arm_cca_report_new,
>   };
>   
> -/**
> - * arm_cca_guest_init - Register with the Trusted Security Module (TSM)
> - * interface.
> - *
> - * Return:
> - * * %0        - Registered successfully with the TSM interface.
> - * * %-ENODEV  - The execution context is not an Arm Realm.
> - * * %-EBUSY   - Already registered.
> - */
> -static int __init arm_cca_guest_init(void)
> +static void unregister_cca_tsm_report(void *data)
> +{
> +	tsm_report_unregister(&arm_cca_tsm_report_ops);
> +}
> +
> +static int cca_tsm_probe(struct faux_device *fdev)
>   {
>   	int ret;
>   
>   	if (!is_realm_world())
>   		return -ENODEV;
>   
> -	ret = tsm_report_register(&arm_cca_tsm_ops, NULL);
> -	if (ret < 0)
> +	ret = tsm_report_register(&arm_cca_tsm_report_ops, NULL);
> +	if (ret < 0) {
>   		pr_err("Error %d registering with TSM\n", ret);
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(&fdev->dev, unregister_cca_tsm_report, NULL);
> +	if (ret < 0) {
> +		pr_err("Error %d registering devm action\n", ret);
> +		unregister_cca_tsm_report(NULL);
> +		return ret;
> +	}
>   
>   	return ret;
>   }
> -module_init(arm_cca_guest_init);
>   
> -/**
> - * arm_cca_guest_exit - unregister with the Trusted Security Module (TSM)
> - * interface.
> - */
> -static void __exit arm_cca_guest_exit(void)
> +static struct faux_device *cca_tsm;
> +
> +static const struct faux_device_ops cca_device_ops = {
> +	.probe = cca_tsm_probe,
> +};
> +
> +static int __init cca_tsm_init(void)
>   {
> -	tsm_report_unregister(&arm_cca_tsm_ops);
> +	cca_tsm = faux_device_create(RSI_DEV_NAME, NULL, &cca_device_ops);
> +	if (!cca_tsm)
> +		return -ENOMEM;
> +	return 0;
>   }
> -module_exit(arm_cca_guest_exit);
> +module_init(cca_tsm_init);
>   
> -/* modalias, so userspace can autoload this module when RSI is available */
> -static const struct platform_device_id arm_cca_match[] __maybe_unused = {
> -	{ RSI_PDEV_NAME, 0},
> -	{ }
> -};
> +static void __exit cca_tsm_exit(void)
> +{
> +	faux_device_destroy(cca_tsm);
> +}
> +module_exit(cca_tsm_exit);
>   
> -MODULE_DEVICE_TABLE(platform, arm_cca_match);
>   MODULE_AUTHOR("Sami Mujawar <sami.mujawar@arm.com>");
>   MODULE_DESCRIPTION("Arm CCA Guest TSM Driver");
>   MODULE_LICENSE("GPL");


