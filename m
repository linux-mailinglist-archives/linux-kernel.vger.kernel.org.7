Return-Path: <linux-kernel+bounces-866171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1ABCBFF0F7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DB7BD354422
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 04:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2430E17D2;
	Thu, 23 Oct 2025 04:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="OmW0jC/A"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0002718A956
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761192281; cv=none; b=NtQ0pKYcezXTkLDYL29BcFDDeLTWJEtsOBA+/sSRKRbeK8/EeJ0TJkM6lCy93C3jUk5Ht46deWTMocjMYvuRWo2mK5sO/XtBkAjmzTrrd9qTf/4/cwZh4ZG7cV6RHMcL1Xgt0HcSpw7XaKwbjrdPSKPdCnaDPIUZtuSRnSrMecg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761192281; c=relaxed/simple;
	bh=VbiuVZ6RBebsfqyvVJ5Ds+gMyCUnbR04fiSy1wFclDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NuF+vFWMxW3Zf4Z68SAPlnJ7roakOdrXfOu4uzbZpFkhyzqftPqGA7Z4uLrSISkf3vJgvEDPqdOqGi0FDwEhSceKdYXWUHMl5L76tZHZT4X+huJgjBU4UAS+KtdK5N0JvcscQiNIzv5AzlZGHmzUZ5mHxSKx6noSozg3p1cZREU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=OmW0jC/A; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-63bea08a326so425696a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 21:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1761192277; x=1761797077; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HHSZMDPvtfAX1xsUrEgKm9tbChBih95VIvPG69sbWIA=;
        b=OmW0jC/A2MeYOY+X11md1QEu+nxH9C3QMEqvjPZhMsD75B+NMNBbOG8wacwpZiwVcB
         02fWGea9YivvrVZEyvx8HGKXKwFitZMeh8XkpyGtmGHmlN4jXTfkYdIfTlbdqYQGXIA5
         4mNBsXNh3mxBt36wxXmx6rSkfBT1voaHThz4p7SnNV/vSW97yOIJxdiwiO+Goct2ae0S
         ozBJPki4wpY8/7ie62wJCz48Y3odP6wjeLbmGCw4ey4XQHQ2X4z4s1Nf1qjWx0pWn0kR
         CZq6SPZyZZHEsD837ZGKK5Cs9riXpgY7gv5gM6n9ODGwMAGsXVMoGLGxpTNBDt0ORuXi
         DzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761192277; x=1761797077;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HHSZMDPvtfAX1xsUrEgKm9tbChBih95VIvPG69sbWIA=;
        b=kfZzeTBlUPnHmwFRltGCqD5VC2pSj//RwSCChKna97XMyQMImfETQfdtQn1mvdcFVk
         kTfOQlwPOXiSGWdgNeoMk9HDHlShR6loX2q+A77Pal2tZGK6hlv0tamtX/myU4xg5DvO
         hkrPjILC0BFA9thyxn8ifmqsqRzD/Y733iANTV/Bs4Q7qwmu8t9ZR0UsrtADGsTab09/
         6So7SX9AUwsGoaXKIIQSMm5CwDn1RJoDT74tlz5JHTHFEWpy3vSGDBGUoHgSrzVDyEqf
         0TvOEJ12ffF9OcornCgEFwCVtuHZZJhK9z4ndAyqJN55Z9QxP1DHTqpF1y6c5xqHQ77E
         BM9w==
X-Forwarded-Encrypted: i=1; AJvYcCX598tJ4rg9o+RSfJ16JM+C+yViOJby0VmzyO3Qc0uICYNNn6+iKKNXUiyC95XMQInnYnm0QjQN0ppichE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk5y5ONyfsoKIaIFpLUUIoErUxv0I8HfKOWIrFTvIT7HjBP4Ep
	SzThrSh711R9y7jNhtzoP4Z+FtmWxYOmjvCQa64GXAm2vhG8cpQqFlYqiqibMBGj7io=
X-Gm-Gg: ASbGncviEve4P4eYTfIvebHMkevfjhKqWUssWcCrb9uhwmFbzCSzjlCw5QsF/3uERqG
	a2aEAEfNvsYtbKM97RDiFZT2uoAGsLv47OUWzG0mhIp9cG2AGjmfkR/RzKTzaMSzTK7ZMTtqd78
	dXlwo/3JDx1F7zMHytdpdDxqdH2W9sdUaX5mV7PaX+wSWqgVQN+pP2jLQrhSeWcNP+VAwH0nGug
	YSsYx8+Z8+PBkAu07F6/+6YxHfFf00Ka54eeVjchKOdlQTC466jbpEcrdkjytFruGL/yN1TBQVr
	lQWnrG6o9x1koaDQFi1FScPhhpK9SRn1/I2ddEcvs0FSpbl04upzOhELNExMGYT5VdKneccgE+f
	aWf6iTHwp3+1gxkNTY94nNuslzF6pQ1LUyN/hwNCQijQVqC0XJEtDoop7vlslOe2Lvjw4wWoRY9
	oPIYEmrDpR
X-Google-Smtp-Source: AGHT+IGJiS3xjlcmck6jYeKg58UKDvZ1VJYr2SNmkONX0VTIjq/vCHDBgtScrL9mLTDQswuRHlg1UQ==
X-Received: by 2002:a50:c949:0:b0:637:e271:8071 with SMTP id 4fb4d7f45d1cf-63c1f6d5dd8mr18546472a12.27.1761192276905;
        Wed, 22 Oct 2025 21:04:36 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.151])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e3ebb3738sm579215a12.3.2025.10.22.21.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 21:04:35 -0700 (PDT)
Message-ID: <41dbea85-8aa1-4034-8106-e28c37e398b8@tuxon.dev>
Date: Thu, 23 Oct 2025 07:04:33 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/9] soc: microchip: add mfd drivers for two syscon
 regions on PolarFire SoC
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Daire McNamara <daire.mcnamara@microchip.com>,
 pierre-henry.moussay@microchip.com, valentina.fernandezalanis@microchip.com,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-riscv@lists.infradead.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251013-album-bovine-faf9f5ebc5d4@spud>
 <20251013-patient-matrimony-6162c8f92e2e@spud>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20251013-patient-matrimony-6162c8f92e2e@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Conor,

On 10/13/25 20:45, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The control-scb and mss-top-sysreg regions on PolarFire SoC both fulfill
> multiple purposes. The former is used for mailbox functions in addition
> to the temperature & voltage sensor while the latter is used for clocks,
> resets, interrupt muxing and pinctrl.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/soc/microchip/Kconfig               | 13 ++++++
>  drivers/soc/microchip/Makefile              |  1 +
>  drivers/soc/microchip/mpfs-control-scb.c    | 45 +++++++++++++++++++
>  drivers/soc/microchip/mpfs-mss-top-sysreg.c | 48 +++++++++++++++++++++
>  4 files changed, 107 insertions(+)
>  create mode 100644 drivers/soc/microchip/mpfs-control-scb.c
>  create mode 100644 drivers/soc/microchip/mpfs-mss-top-sysreg.c
> 
> diff --git a/drivers/soc/microchip/Kconfig b/drivers/soc/microchip/Kconfig
> index 19f4b576f822..31d188311e05 100644
> --- a/drivers/soc/microchip/Kconfig
> +++ b/drivers/soc/microchip/Kconfig
> @@ -9,3 +9,16 @@ config POLARFIRE_SOC_SYS_CTRL
>  	  module will be called mpfs_system_controller.
>  
>  	  If unsure, say N.
> +
> +config POLARFIRE_SOC_SYSCONS
> +	bool "PolarFire SoC (MPFS) syscon drivers"
> +	default y
> +	depends on ARCH_MICROCHIP
> +	select MFD_CORE
> +	help
> +	  These drivers add support for the syscons on PolarFire SoC (MPFS).
> +	  Without these drivers core parts of the kernel such as clocks
> +	  and resets will not function correctly.
> +
> +	  If unsure, and on a PolarFire SoC, say y.
> +

This empty line could be dropped.

> diff --git a/drivers/soc/microchip/Makefile b/drivers/soc/microchip/Makefile
> index 14489919fe4b..1a3a1594b089 100644
> --- a/drivers/soc/microchip/Makefile
> +++ b/drivers/soc/microchip/Makefile
> @@ -1 +1,2 @@
>  obj-$(CONFIG_POLARFIRE_SOC_SYS_CTRL)	+= mpfs-sys-controller.o
> +obj-$(CONFIG_POLARFIRE_SOC_SYSCONS)	+= mpfs-control-scb.o mpfs-mss-top-sysreg.o
> diff --git a/drivers/soc/microchip/mpfs-control-scb.c b/drivers/soc/microchip/mpfs-control-scb.c
> new file mode 100644
> index 000000000000..d1a8e79c232e
> --- /dev/null
> +++ b/drivers/soc/microchip/mpfs-control-scb.c
> @@ -0,0 +1,45 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/array_size.h>

Looks like this one can be dropped or maybe you want to use
ARRAY_SIZE(mpfs_control_scb_devs) as 4th argument of mfd_add_devices().

> +#include <linux/of.h>
> +#include <linux/of_address.h>

Looks like this one can be dropped.

> +#include <linux/mfd/core.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_platform.h>

Same with this one?

> +#include <linux/platform_device.h>
> +
> +static const struct mfd_cell mpfs_control_scb_devs[] = {
> +	{ .name = "mpfs-tvs", },

I think you can use:

MFD_CELL_NAME("mpfs-tvs")

> +};
> +
> +static int mpfs_control_scb_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	ret = mfd_add_devices(dev, PLATFORM_DEVID_NONE, mpfs_control_scb_devs,
> +			      1, NULL, 0, NULL);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

You can use directly:

	return mfd_add_device(...);

> +}
> +
> +static const struct of_device_id mpfs_control_scb_of_match[] = {
> +	{.compatible = "microchip,mpfs-control-scb", },

This looks un-documented.

> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mpfs_control_scb_of_match);
> +
> +static struct platform_driver mpfs_control_scb_driver = {
> +	.driver = {
> +		.name = "mpfs-control-scb",
> +		.of_match_table = mpfs_control_scb_of_match,
> +	},
> +	.probe = mpfs_control_scb_probe,
> +};
> +module_platform_driver(mpfs_control_scb_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Conor Dooley <conor.dooley@microchip.com>");
> +MODULE_DESCRIPTION("PolarFire SoC control scb driver");
> diff --git a/drivers/soc/microchip/mpfs-mss-top-sysreg.c b/drivers/soc/microchip/mpfs-mss-top-sysreg.c
> new file mode 100644
> index 000000000000..9b2e7b84cdba
> --- /dev/null
> +++ b/drivers/soc/microchip/mpfs-mss-top-sysreg.c
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/array_size.h>

Looks like this one can be dropped or maybe you want to use
ARRAY_SIZE(mpfs_mss_top_sysreg_devs) as 4th argument of mfd_add_devices()

> +#include <linux/of.h>
> +#include <linux/of_address.h>

Unused?

> +#include <linux/mfd/core.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_platform.h>

Unused?

> +#include <linux/platform_device.h>
> +
> +static const struct mfd_cell mpfs_mss_top_sysreg_devs[] = {
> +	{ .name = "mpfs-reset", },

MFD_CELL_NAME() ?

> +};
> +
> +static int mpfs_mss_top_sysreg_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	ret = mfd_add_devices(dev, PLATFORM_DEVID_NONE, mpfs_mss_top_sysreg_devs,
> +			      1, NULL, 0, NULL);
> +	if (ret)
> +		return ret;
> +
> +	if (devm_of_platform_populate(dev))
> +		dev_err(dev, "Error populating children\n");

Is it OK return 0 above if there are failures here?

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id mpfs_mss_top_sysreg_of_match[] = {
> +	{.compatible = "microchip,mpfs-mss-top-sysreg", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mpfs_mss_top_sysreg_of_match);
> +
> +static struct platform_driver mpfs_mss_top_sysreg_driver = {
> +	.driver = {
> +		.name = "mpfs-mss-top-sysreg",
> +		.of_match_table = mpfs_mss_top_sysreg_of_match,
> +	},
> +	.probe = mpfs_mss_top_sysreg_probe,
> +};
> +module_platform_driver(mpfs_mss_top_sysreg_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Conor Dooley <conor.dooley@microchip.com>");
> +MODULE_DESCRIPTION("PolarFire SoC mss top sysreg driver");


