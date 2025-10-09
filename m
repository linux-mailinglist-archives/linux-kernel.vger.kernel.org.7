Return-Path: <linux-kernel+bounces-846350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D5ABC7A5B
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 09:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ACA564F552E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 07:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C622D063D;
	Thu,  9 Oct 2025 07:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHQoGAWV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51342D061A;
	Thu,  9 Oct 2025 07:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759994037; cv=none; b=Fw+rjd5GYbVWcVTw9fyuo88eq1ZtbfVdJ8aNxbndmyOM3tYNRtVADSq9HcSjeJgfv9utCdvXcqrucJC+Auf7o4lC4YvOoRP+QpdoMxCWWxVApnfgXHMM3Bo/nTBefWUNg7eGxvvRbsjVpiQ6kTtnaokppXUF4U/sgBNPG8cgHwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759994037; c=relaxed/simple;
	bh=ZezL9yWOKaatZ+fH8iqjui9xK6y/9zO1W4UtEXV3Bcg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W0+tknn+BjGXHdgmZDF3h+w7J2cBpMuyuoGnZx85irakfZG/feG3TFUgj9bwpdPkhMpsWUAbS/LBfze2eqtgMDw9zWZLLxhi/vr4YM/8Q90ImDeUj8e6H71eYJXEMRK2yR4IUdE/t4AxYuToN51bHRQUXf4SVE7O3foJVrYpaJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHQoGAWV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70653C4CEE7;
	Thu,  9 Oct 2025 07:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759994037;
	bh=ZezL9yWOKaatZ+fH8iqjui9xK6y/9zO1W4UtEXV3Bcg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bHQoGAWVQWeurySCB8ltwF4QfgjsnxicefPwuKHECbon1mask6EJXAiy2q2tHHW0Q
	 zfFdkWEUpcOQUvq5tUI9PDIZPAbbAuqbf6EccI35NpL2L2bLOJKzXY2DdBE0XIoioE
	 UbWiuSbNVO5m9lYcpOqmGR9IQ04wQOOSb2YJRjrMYqZRQVkgXF8kiW2pZ5Y0p3Nmfj
	 jGWLCYGZIUmbQycvtEn0ka+2y45BDdaAFHPtM8P7EkBlSVN0O+hXdKWcKNiev2YeaZ
	 OHHZjIK0wy7YweU+rXulMVpTf0O0cOjrYS9Iak2m7esqznLobqcoP2OulssH95LtpO
	 T0tJvLYUd/qZg==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Gavin Shan <gshan@redhat.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Sami Mujawar <sami.mujawar@arm.com>
Subject: Re: [PATCH] coco: guest: arm64: Update ARM CCA guest driver
In-Reply-To: <20251008132758.784275-1-aneesh.kumar@kernel.org>
References: <20251008132758.784275-1-aneesh.kumar@kernel.org>
Date: Thu, 09 Oct 2025 12:43:49 +0530
Message-ID: <yq5aldlka6oi.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:

> Make preparatory updates to the ARM CCA guest driver:
>
>  - Switch from using a platform device to a faux device (based on
>    feedback in [1])
>  - Rename the device from `arm-cca-dev` to `arm-rsi-dev`, so that the
>    host driver can register an equivalent `arm-rmi-dev`
>
> These changes are purely structural and introduce no new functionality.
> Subsequent patches will extend this driver to add guest device
> assignment support.
>
> [1] https://lore.kernel.org/all/2025073035-bulginess-rematch-b92e@gregkh
>

I noticed that, this will break autoloading of the driver. 

> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
> NOTE:
> This patch is sent early outside the patchseries to avoid userspace from
> depending on the presence of the newly introduced platform device.
> The platform device was added in v6.14-rc1. 
>
>  arch/arm64/include/asm/rsi.h                  |  2 +-
>  arch/arm64/kernel/rsi.c                       | 15 -----
>  drivers/virt/coco/arm-cca-guest/Makefile      |  3 +
>  .../{arm-cca-guest.c => arm-cca.c}            | 65 +++++++++++--------
>  4 files changed, 41 insertions(+), 44 deletions(-)
>  rename drivers/virt/coco/arm-cca-guest/{arm-cca-guest.c => arm-cca.c} (85%)
>
> diff --git a/arch/arm64/include/asm/rsi.h b/arch/arm64/include/asm/rsi.h
> index b42aeac05340..26ef6143562b 100644
> --- a/arch/arm64/include/asm/rsi.h
> +++ b/arch/arm64/include/asm/rsi.h
> @@ -10,7 +10,7 @@
>  #include <linux/jump_label.h>
>  #include <asm/rsi_cmds.h>
>  
> -#define RSI_PDEV_NAME "arm-cca-dev"
> +#define RSI_DEV_NAME "arm-rsi-dev"
>  
>  DECLARE_STATIC_KEY_FALSE(rsi_present);
>  
> diff --git a/arch/arm64/kernel/rsi.c b/arch/arm64/kernel/rsi.c
> index ce4778141ec7..569ef08750e5 100644
> --- a/arch/arm64/kernel/rsi.c
> +++ b/arch/arm64/kernel/rsi.c
> @@ -140,18 +140,3 @@ void __init arm64_rsi_init(void)
>  
>  	static_branch_enable(&rsi_present);
>  }
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
>  # SPDX-License-Identifier: GPL-2.0-only
> +#
>  obj-$(CONFIG_ARM_CCA_GUEST) += arm-cca-guest.o
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
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Copyright (C) 2023 ARM Ltd.
> + * Copyright (C) 2025 ARM Ltd.
>   */
>  
> +#include <linux/device/faux.h>
>  #include <linux/arm-smccc.h>
>  #include <linux/cc_platform.h>
>  #include <linux/kernel.h>
> @@ -181,52 +182,60 @@ static int arm_cca_report_new(struct tsm_report *report, void *data)
>  	return ret;
>  }
>  
> -static const struct tsm_report_ops arm_cca_tsm_ops = {
> +static const struct tsm_report_ops arm_cca_tsm_report_ops = {
>  	.name = KBUILD_MODNAME,
>  	.report_new = arm_cca_report_new,
>  };
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
>  {
>  	int ret;
>  
>  	if (!is_realm_world())
>  		return -ENODEV;
>  
> -	ret = tsm_report_register(&arm_cca_tsm_ops, NULL);
> -	if (ret < 0)
> +	ret = tsm_report_register(&arm_cca_tsm_report_ops, NULL);
> +	if (ret < 0) {
>  		pr_err("Error %d registering with TSM\n", ret);
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
>  	return ret;
>  }
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
>  {
> -	tsm_report_unregister(&arm_cca_tsm_ops);
> +	cca_tsm = faux_device_create(RSI_DEV_NAME, NULL, &cca_device_ops);
> +	if (!cca_tsm)
> +		return -ENOMEM;
> +	return 0;
>  }
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
>  MODULE_AUTHOR("Sami Mujawar <sami.mujawar@arm.com>");
>  MODULE_DESCRIPTION("Arm CCA Guest TSM Driver");
>  MODULE_LICENSE("GPL");
> -- 
> 2.43.0

