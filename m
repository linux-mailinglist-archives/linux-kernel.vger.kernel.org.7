Return-Path: <linux-kernel+bounces-828804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B580B9585E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28ADA4A353E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABCF3218BE;
	Tue, 23 Sep 2025 10:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qFliFiXE"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46CF321454;
	Tue, 23 Sep 2025 10:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758624796; cv=none; b=HIJvCHgMOoCC+Y0cFElg/8WSkuye3+Zto7MVwc4pgqiFFDdZ74ZSbeRtqF66kKTAjouMcJkc4dAeKAd/BO1xBV782eBVpOXzVKT2uOeiGX5bSi9Dw2ZWcMWOZ0IS9mj1BiiSMqobWiTCZRkU5d7UO4juoigfiOpOPbfj0QYBBbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758624796; c=relaxed/simple;
	bh=vftLrYglkEsmeo6xHVwldIj2Sq5yIyO4FaXSOki0OoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RbOoxevL/5yATGeOC4DQY+0Kd+UxzNwrzYlGWTul7NaWiMSzrfN+le7h/xii4bGs6nlMj4STfu+QNDgPH8DBfm94fGNGzCAeD7lKwmQqAiE3bf1rVThhH87+KdEUDkP5szvFs6CfnbQ0trcMRawsqn/N6q9tjpL0buYXoVtzftE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qFliFiXE; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58NAqblj1460248;
	Tue, 23 Sep 2025 05:52:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758624757;
	bh=m7JjzlXvIH0z19Y9RrAgsUMC9V31Bo4J2LmQf/wo/Uc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=qFliFiXE6P2NK2UON0nLZDy9RZdrekE86Y5FUJ5zVnpa9RAESLivXAwJUmwXfj4Dq
	 zffVJUpaaDUsi8/zpc8CtB9dka+qjWpJx3xZ1xna4Eo5VsLM64DHonPvEKcPlSCAxf
	 A19Fs63yqS7Wvs67OGRNn/ufTD5lpgkLEU704gf8=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58NAqbth1022630
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 23 Sep 2025 05:52:37 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 23
 Sep 2025 05:52:36 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Sep 2025 05:52:36 -0500
Received: from [172.24.233.14] (shark.dhcp.ti.com [172.24.233.14])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58NAqVUj188749;
	Tue, 23 Sep 2025 05:52:32 -0500
Message-ID: <5f508f1d-2d08-4687-86cd-d1944caa0a49@ti.com>
Date: Tue, 23 Sep 2025 16:22:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] clk: scmi: Support Spread Spectrum for NXP i.MX95
To: Peng Fan <peng.fan@nxp.com>, Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Marco Felsch
	<m.felsch@pengutronix.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Brian Masney
	<bmasney@redhat.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>,
        Geert Uytterhoeven
	<geert@linux-m68k.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arm-scmi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
References: <20250915-clk-ssc-version1-v4-0-5a2cee2f0351@nxp.com>
 <20250915-clk-ssc-version1-v4-5-5a2cee2f0351@nxp.com>
Content-Language: en-US
From: Sebin Francis <sebin.francis@ti.com>
In-Reply-To: <20250915-clk-ssc-version1-v4-5-5a2cee2f0351@nxp.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Peng

On 15/09/25 13:59, Peng Fan wrote:
> The PLL clocks on NXP i.MX95 SoCs support Spread Spectrum (SS).
> This patch introduces scmi_clk_imx_set_spread_spectrum to pass SS
> configuration to the SCMI firmware, which handles the actual
> implementation.
> 
> To ensure this feature is only enabled on NXP platforms,
> scmi_clk_imx_extended_config_oem is added. Since SS is only applicable
> to PLL clocks, config_oem_get is used to verify SS support for a given
> clock.
> 
> i.MX95 SCMI firmware Spread Spectrum extConfigValue definition is as
> below, no modulation method because firmware forces to use down spread.
> 	 extConfigValue[7:0]   - spread percentage (%)
> 	 extConfigValue[23:8]  - Modulation Frequency (KHz)
> 	 extConfigValue[24]    - Enable/Disable
> 	 extConfigValue[31:25] - Reserved
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

...

>   	if (WARN_ON(feats_key >= db_size))
>   		return NULL;
>   
> @@ -459,7 +515,7 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
>   		 * to avoid sharing the devm_ allocated clk_ops between multiple
>   		 * SCMI clk driver instances.
>   		 */
> -		scmi_ops = scmi_clk_ops_select(sclk, transport_is_atomic,
> +		scmi_ops = scmi_clk_ops_select(handle, sclk, transport_is_atomic,
>   					       atomic_threshold_us,
>   					       scmi_clk_ops_db,
>   					       ARRAY_SIZE(scmi_clk_ops_db));
> diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
> index aafaac1496b06a6e4f0ca32eee58a9edf7d4a70f..37f422b4b1ef2af2b4231a1677161aa24e07d0e2 100644
> --- a/include/linux/scmi_protocol.h
> +++ b/include/linux/scmi_protocol.h
> @@ -80,9 +80,14 @@ enum scmi_clock_oem_config {
>   	SCMI_CLOCK_CFG_DUTY_CYCLE = 0x1,
>   	SCMI_CLOCK_CFG_PHASE,
>   	SCMI_CLOCK_CFG_OEM_START = 0x80,
> +	SCMI_CLOCK_CFG_IMX_SSC = 0x80,

TI is also planning to implement the same in our upcoming platform. so 
can we use a generic ID instead of vender specfic message ID?

>   	SCMI_CLOCK_CFG_OEM_END = 0xFF,
>   };
>   
> +#define SCMI_CLOCK_IMX_SS_PERCENTAGE_MASK	GENMASK(7, 0)
> +#define SCMI_CLOCK_IMX_SS_MOD_FREQ_MASK		GENMASK(23, 8)
> +#define SCMI_CLOCK_IMX_SS_ENABLE_MASK		BIT(24)
> +
>   /**
>    * struct scmi_clk_proto_ops - represents the various operations provided
>    *	by SCMI Clock Protocol
> 

Thanks
Sebin

