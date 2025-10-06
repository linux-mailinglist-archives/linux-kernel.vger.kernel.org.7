Return-Path: <linux-kernel+bounces-842830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 729BEBBDBE0
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 12:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 287983A4E17
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 10:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C3B253B42;
	Mon,  6 Oct 2025 10:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WPsqXsmu"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED9E2222A1;
	Mon,  6 Oct 2025 10:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759747492; cv=none; b=AJ3vTdJUONbh26jJYPDgmIxyClOWVbpZQYn0LlCt8haMNoB/lprGs4eSPzIqSwM+kUp+d1rSl7aU1ce/7b0nII6LZAD+a08L1aDxEqRQ94imw2w+RfDRNDlgxDRhKOk1a0zFi9la4obskahfa1i3HWMgGdzXkzViZyAmwam0ZfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759747492; c=relaxed/simple;
	bh=fLvuSoH1WdE5hbSuvDMNnWSwYLy3Tv99lG2NP74ASYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=deCStW90abCpAoV+VWu6oHJy5USpPOsraaPa6fP6JQ4h9k55ekJ5Zp2yARaBc6BH3Kg9G9l+fJnoRgcibIcnqyJbdxu8Pv8VamIDrFIkGjD2oGgB5//etVC9SBxwJ2L2hXgYzE97Kw1AfbXShn1Q8K7QQPpcPV6JKGqIRylolr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WPsqXsmu; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 596AiRjL3592281;
	Mon, 6 Oct 2025 05:44:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1759747467;
	bh=u+nD8HNdH2N+reg5mrRLQzAfdOKRWqLsO8iNzTlmxnQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=WPsqXsmussjX3OTMl3+oHxR69jmbAHzCOAQ341/cEYsYNxaESt89YrtV5ifBkvLvH
	 IbMl+HayyTp+R766+HNOJcK312cSKKWiwqke0pfj+QXO4crgNII7Zvcvy6K1JEkwSl
	 yrIpinh8OfxXnAo5sd67x52c3D3ftIq+bk2wOp0k=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 596AiRYl3250715
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 6 Oct 2025 05:44:27 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 6
 Oct 2025 05:44:26 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 6 Oct 2025 05:44:26 -0500
Received: from [172.24.233.14] (shark.dhcp.ti.com [172.24.233.14])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 596AiL6x3546968;
	Mon, 6 Oct 2025 05:44:22 -0500
Message-ID: <98d588bd-7b46-4df4-b31c-2bb53a47c279@ti.com>
Date: Mon, 6 Oct 2025 16:14:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] clk: conf: Support assigned-clock-sscs
To: Peng Fan <peng.fan@nxp.com>, Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Marco Felsch
	<m.felsch@pengutronix.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Brian Masney
	<bmasney@redhat.com>,
        Dhruva Gole <d-gole@ti.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>,
        Geert Uytterhoeven
	<geert@linux-m68k.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arm-scmi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
References: <20250915-clk-ssc-version1-v4-0-5a2cee2f0351@nxp.com>
 <20250915-clk-ssc-version1-v4-3-5a2cee2f0351@nxp.com>
Content-Language: en-US
From: Sebin Francis <sebin.francis@ti.com>
In-Reply-To: <20250915-clk-ssc-version1-v4-3-5a2cee2f0351@nxp.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Peng,

On 15/09/25 13:59, Peng Fan wrote:
> Parse the Spread Spectrum Configuration(SSC) from device tree and configure
> them before using the clock.
> 
> Each SSC is three u32 elements which means '<modfreq spreaddepth
> modmethod>', so assigned-clock-sscs is an array of multiple three u32
> elements.
> 
> Reviewed-by: Brian Masney <bmasney@redhat.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   drivers/clk/clk-conf.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 69 insertions(+)
> 
> diff --git a/drivers/clk/clk-conf.c b/drivers/clk/clk-conf.c
> index 303a0bb26e54a95655ce094a35b989c97ebc6fd8..dd6083597db3f8f27d86abf5640dfc3fb39a9b88 100644
> --- a/drivers/clk/clk-conf.c
> +++ b/drivers/clk/clk-conf.c
> @@ -155,6 +155,71 @@ static int __set_clk_rates(struct device_node *node, bool clk_supplier)
>   	return 0;
>   }
>   
> +static int __set_clk_spread_spectrum(struct device_node *node, bool clk_supplier)
> +{
> +	struct clk_spread_spectrum *sscs __free(kfree) = NULL;
> +	u32 elem_size = sizeof(struct clk_spread_spectrum);
> +	struct of_phandle_args clkspec;
> +	int rc, count, index;
> +	struct clk *clk;
> +
> +	/* modfreq, spreadPercent, modmethod */
> +	count = of_property_count_elems_of_size(node, "assigned-clock-sscs", elem_size);
> +	if (count <= 0)
> +		return 0;
> +
> +	sscs = kcalloc(count, elem_size, GFP_KERNEL);
> +	if (!sscs)
> +		return -ENOMEM;
> +
> +	rc = of_property_read_u32_array(node, "assigned-clock-sscs", (u32 *)sscs,
> +					count * 3);
> +	if (rc)
> +		return rc;
> +
> +	for (index = 0; index < count; index++) {
> +		struct clk_spread_spectrum *conf = &sscs[index];
> +		struct clk_hw *hw;
> +
> +		if (!conf->modfreq_hz && !conf->spread_bp && !conf->method)
> +			continue;
> +
> +		rc = of_parse_phandle_with_args(node, "assigned-clocks", "#clock-cells",
> +						index, &clkspec);
> +		if (rc < 0) {
> +			/* skip empty (null) phandles */
> +			if (rc == -ENOENT)
> +				continue;
> +			else
> +				return rc;
> +		}
> +
> +		if (clkspec.np == node && !clk_supplier) {
> +			of_node_put(clkspec.np);
> +			return 0;
> +		}
> +
> +		clk = of_clk_get_from_provider(&clkspec);
> +		of_node_put(clkspec.np);
> +		if (IS_ERR(clk)) {
> +			if (PTR_ERR(clk) != -EPROBE_DEFER)
> +				pr_warn("clk: couldn't get clock %d for %pOF\n",
> +					index, node);
> +			return PTR_ERR(clk);
> +		}
> +
> +		hw = __clk_get_hw(clk);
> +		rc = clk_hw_set_spread_spectrum(hw, conf);
> +		if (rc < 0)
> +			pr_err("clk: couldn't set %s clk spread spectrum %u %u %u: %d\n",
> +			       __clk_get_name(clk), conf->modfreq_hz, conf->spread_bp,
> +			       conf->method, rc);
> +		clk_put(clk);
> +	}
> +
> +	return 0;
> +}
> +
>   /**
>    * of_clk_set_defaults() - parse and set assigned clocks configuration
>    * @node: device node to apply clock settings for
> @@ -174,6 +239,10 @@ int of_clk_set_defaults(struct device_node *node, bool clk_supplier)
>   	if (!node)
>   		return 0;
>   
> +	rc = __set_clk_spread_spectrum(node, clk_supplier);
> +	if (rc < 0)
> +		return rc;
> +
>   	rc = __set_clk_parents(node, clk_supplier);
>   	if (rc < 0)
>   		return rc;
> 

Here you are setting the clock's ssc before the setting the parent and 
rate, is it possible to move it below setting of parent and rate? 
because the ssc is enabled after the parent and rate is set to a clock.

Thanks
Sebin

