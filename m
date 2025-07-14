Return-Path: <linux-kernel+bounces-730199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A59B04149
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB0683ADCEA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D584242D99;
	Mon, 14 Jul 2025 14:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EpD1CUUy"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78702586C7
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752502612; cv=none; b=FOUwVxeOHhIHVfbi64JnWzl83d2stbUjJElC1wwVngTl+xtd9P2Of3kL6skBMQY3y87rvFBcKTLYbNG3IXeOyu4/yl9KEY7C22JClNlp9QRMR2Ou0UvEwJx9Uyll0voW22gcJU6mPOPPX5WACZ8xJ7aEoWhlu2Oq2Vtu9bdLWU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752502612; c=relaxed/simple;
	bh=Lq4V4cI9f+RGqhTnj9OGNLQCB5/+4U22BJ53BLS03q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OOhEzvSKlMtnr/KrNqNmzBxphiFGlvs4/tk9pYjJ1HoBrE/o8Nc/LuH5MQjOsgeFZQkftiE3m+ShWEYuaAs9ifGhSDY+e8R/wdAPvtBU5VrIGlkAOy5WLF5II6ezkXM99/vFJ9pjWousfD47C++v/fd6w130uqaxgQ5FrRBr4r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EpD1CUUy; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-553d27801b4so249984e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752502609; x=1753107409; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cI2qt4NB/mo+O9FErgJgDmsE0AmvcZBo4EL9xQ0SmF0=;
        b=EpD1CUUyhZcbiDg21XQm6OUmXg9nVFV7t0dcqQht5lnyyyL58ut77Pwj8dVUG+Q3x/
         kaIKK6WP3copDX8eyMGkX5eTXdZJMiPPZD7/z8iV/NW0/rzMpqeRM+lCDPoIu+ZTnF0w
         JOVKOSBFFpK9uQ1JMUzlGKOI2VezXDI7gNP6sfaYAEpeJJpFO1szhh6rgNltAZzJL7RO
         LfN6Qm5EdEHYNZE0cLIAE+emD327dc1tK/GP4LSPM/oxMDtYt7k0I/Mbfo3vybEW4Gda
         DiDsdj9FDnqfK0HQPOB/fJGj304NiQBcD4pz6HljL+RxZIp+2YFBGODGLlFVuuTW3H04
         okcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752502609; x=1753107409;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cI2qt4NB/mo+O9FErgJgDmsE0AmvcZBo4EL9xQ0SmF0=;
        b=dhY6jrUYCez/6ViebW0dNUPQzBA787+aNTFxCfgVPRqfp5OGyRIf9+Mv6C7OSetPzi
         ugVaJYWBF/rJ4+lXFM6CGUhBJX2uodyYUGAT02kA7Z8VqL0RDNxB9VeCsob3r5CW3Bi3
         CP2ardLwAkvU7bzcQreq/QnIgxwzuulTL6fUUyxfDp6cIkTUCqDkShJ/OO436g3aOA+D
         58b8YnjKS/ZL1KyT05p3E4pWht5Jepadlkj0n+537gUtPbNZ6oX+dHF3K38l2CU7uGH7
         hcEFUJenvmp7IY9eubrdk8pVC8hpr9pY1rGZj1hUDaeEroNCkgCftLPoRipK7ULIJ+J7
         36rQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIbe4oW7rP1Xkp6njwojEvJteVKcCvufkijBUTcZX4AJ1JqljSXd1bOrdR3LPEtuTYin05vECUkQxYZ/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyVvHtVAZ90XvmKxjvyRYvA5zX6PNtXMpk80y/0HDf6ALNCeWO
	0gk7dliUt7WtTgkbMqkHH97AFlAH5mhJJS6GyAPhKJifbGCDGzZQQkLRKSDMH8Mn/y0=
X-Gm-Gg: ASbGnct/Lh583vGnSL0vqja3b0L+gJmYzsBcGnJqoYL2cnfSsORndTTCGJ4DDVcIr/a
	85Oj4QSMOUjoC7W4y2Rv38W7mDapq1tL0oL5haJdscDBLnFbIIKenRT3sXRk7ZerwxeY/g+a675
	hRGsJbMcEPVREZorjahq9npn0NibDvNk1kWu8aJk7NE83WlmN69l50gNjr2bv2BuGDv23KZX874
	kVsTY0iSl68+4OtaN2JkCq2Li0zSaj2MsLXdXWXCOSuP/1/7NUEgz1h3+dFZRHzwtwBxuRoq0JW
	kfWU351B3nRjr4BnIBXJnGveYhzpPQykoHdCess9g0c65xO4JF/9yX7g1cMHJWRQ9LV8g6FhPfK
	/+z+23JmYf8u2y4EB6ZBgKXqTR5b6xqpAvx9jbe2mlw9saMGB2KlXSf7po6nhzcY+bmF6/ophNZ
	Wp
X-Google-Smtp-Source: AGHT+IGTRrIlX7t9ZryRjbDW/jQgLD10lUwwmpwKvz9xBujx9a/Ky++DAJpYUrrJvDtsrPqoHdxBsQ==
X-Received: by 2002:a05:6512:1293:b0:558:f60d:d4a1 with SMTP id 2adb3069b0e04-55a048faf48mr1262310e87.5.1752502608759;
        Mon, 14 Jul 2025 07:16:48 -0700 (PDT)
Received: from [192.168.1.100] (88-112-128-43.elisa-laajakaista.fi. [88.112.128.43])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b60737sm1957066e87.156.2025.07.14.07.16.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 07:16:48 -0700 (PDT)
Message-ID: <11b573d5-ce4d-476c-b94c-216d427cd838@linaro.org>
Date: Mon, 14 Jul 2025 17:16:46 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] phy: qcom-mipi-csi2: Add a CSI2 MIPI D-PHY driver
Content-Language: ru-RU
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Bryan O'Donoghue <bod@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250710-x1e-csi2-phy-v1-0-74acbb5b162b@linaro.org>
 <20250710-x1e-csi2-phy-v1-2-74acbb5b162b@linaro.org>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20250710-x1e-csi2-phy-v1-2-74acbb5b162b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/25 19:16, Bryan O'Donoghue wrote:
> Add a new MIPI CSI2 driver in D-PHY mode initially. The entire set of
> existing CAMSS CSI PHY init sequences are imported in order to save time
> and effort in later patches.
> 
> In-line with other PHY drivers the process node name is omitted from the
> compat string while the soc name is included.
> 
> At the moment we follow the assignment of lane positions - the bitmap of
> physical input lanes to logical lane numbers as a linear list per the
> existing DPHY @lanes data-member.
> 
> This is fine for us in upstream since we also map the lanes contiguously
> but, our hardware can support different lane mappings so we should in the
> future extend out the DPHY structure to capture the mapping.
> 
> The Qualcomm 3PH class of PHYs can do both D-PHY and C-PHY mode. For now only
> D-PHY is supported.
> 
> In porting some of the logic over from camss-csiphy*.c to here its also
> possible to rationalise some of the code.
> 
> In particular use of regulator_bulk and clk_bulk as well as dropping the
> seemingly useless and unused interrupt handler.
> 
> The PHY sequences and a lot of the logic that goes with them are well proven
> in CAMSS and mature so the main thing to watch out for here is how to get
> the right sequencing of regulators, clocks and register-writes.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>   MAINTAINERS                                        |  11 +
>   drivers/phy/qualcomm/Kconfig                       |  11 +
>   drivers/phy/qualcomm/Makefile                      |   6 +
>   drivers/phy/qualcomm/phy-qcom-mipi-csi2-3ph-dphy.c | 491 +++++++++++++++++++++
>   drivers/phy/qualcomm/phy-qcom-mipi-csi2-core.c     | 281 ++++++++++++
>   drivers/phy/qualcomm/phy-qcom-mipi-csi2.h          | 101 +++++
>   6 files changed, 901 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1ef99240a57ed1ad0d4501998970c7c3b85d3b81..69519e2d6dfb65771a3245735283645bb50a249a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20536,6 +20536,17 @@ S:	Maintained
>   F:	Documentation/devicetree/bindings/media/qcom,*-iris.yaml
>   F:	drivers/media/platform/qcom/iris/
>   
> +QUALCOMM MIPI CSI2 PHY DRIVER
> +M:	Bryan O'Donoghue <bod@kernel.org>
> +L:	linux-phy@lists.infradead.org
> +L:	linux-media@vger.kernel.org
> +L:	linux-arm-msm@vger.kernel.org
> +S:	Supported
> +F:	Documentation/devicetree/bindings/phy/qcom,x1e80100-mipi-csi2-combo-phy.yaml
> +F:	drivers/phy/qualcomm/phy-qcom-mipi-csi2*.c
> +F:	drivers/phy/qualcomm/phy-qcom-mipi-csi2*.h
> +F:	include/dt-bindings/phy/phy-qcom-mipi-csi2*
> +
>   QUALCOMM NAND CONTROLLER DRIVER
>   M:	Manivannan Sadhasivam <mani@kernel.org>
>   L:	linux-mtd@lists.infradead.org
> diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
> index ef14f4e33973cff4103d8ea3b07cfd62d344e450..d0ab70827519c2b046d0fb03c14bb4d8ae2ec9a1 100644
> --- a/drivers/phy/qualcomm/Kconfig
> +++ b/drivers/phy/qualcomm/Kconfig
> @@ -28,6 +28,17 @@ config PHY_QCOM_EDP
>   	  Enable this driver to support the Qualcomm eDP PHY found in various
>   	  Qualcomm chipsets.
>   
> +config PHY_QCOM_MIPI_CSI2
> +	tristate "Qualcomm MIPI CSI2 PHY driver"
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	depends on OF
> +	depends on COMMON_CLK
> +	select GENERIC_PHY
> +	select GENERIC_PHY_MIPI_DPHY
> +	help
> +	  Enable this to support the MIPI CSI2 PHY driver found in various
> +	  Qualcomm chipsets.
> +
>   config PHY_QCOM_IPQ4019_USB
>   	tristate "Qualcomm IPQ4019 USB PHY driver"
>   	depends on OF && (ARCH_QCOM || COMPILE_TEST)
> diff --git a/drivers/phy/qualcomm/Makefile b/drivers/phy/qualcomm/Makefile
> index 3851e28a212d4a677a5b41805868f38b9ab49841..67013d27cb0387b9d65dcbe030ea6e5eaaabbe91 100644
> --- a/drivers/phy/qualcomm/Makefile
> +++ b/drivers/phy/qualcomm/Makefile
> @@ -5,6 +5,12 @@ obj-$(CONFIG_PHY_QCOM_EDP)		+= phy-qcom-edp.o
>   obj-$(CONFIG_PHY_QCOM_IPQ4019_USB)	+= phy-qcom-ipq4019-usb.o
>   obj-$(CONFIG_PHY_QCOM_IPQ806X_SATA)	+= phy-qcom-ipq806x-sata.o
>   obj-$(CONFIG_PHY_QCOM_M31_USB)		+= phy-qcom-m31.o
> +
> +phy-qcom-mipi-csi2-objs			+= phy-qcom-mipi-csi2-core.o \
> +					   phy-qcom-mipi-csi2-3ph-dphy.o
> +
> +obj-$(CONFIG_PHY_QCOM_MIPI_CSI2)	+= phy-qcom-mipi-csi2.o
> +
>   obj-$(CONFIG_PHY_QCOM_PCIE2)		+= phy-qcom-pcie2.o
>   
>   obj-$(CONFIG_PHY_QCOM_QMP_COMBO)	+= phy-qcom-qmp-combo.o phy-qcom-qmp-usbc.o
> diff --git a/drivers/phy/qualcomm/phy-qcom-mipi-csi2-3ph-dphy.c b/drivers/phy/qualcomm/phy-qcom-mipi-csi2-3ph-dphy.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..1a99efee88cc94ec0d29a335cd29f88af8a00c02
> --- /dev/null
> +++ b/drivers/phy/qualcomm/phy-qcom-mipi-csi2-3ph-dphy.c
> @@ -0,0 +1,491 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * camss-phy_qcom_mipi_csi2-3ph-1-0.c
> + *
> + * Qualcomm MSM Camera Subsystem - CSIPHY Module 3phase v1.0
> + *
> + * Copyright (c) 2011-2015, The Linux Foundation. All rights reserved.
> + * Copyright (C) 2016-2025 Linaro Ltd.
> + */
> +#define DEBUG

Still under debugging?..

Well, the phy should be a multimedia device, and this driver is not
the one, thus you can not use it to connect sensors and put the IP
into a media pipeline.

-- 
Best wishes,
Vladimir

