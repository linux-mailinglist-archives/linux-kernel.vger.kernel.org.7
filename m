Return-Path: <linux-kernel+bounces-871265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3C9C0CC63
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 49CC64F6185
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12632FB978;
	Mon, 27 Oct 2025 09:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G13we1Ia"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0B82FB09E
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761558665; cv=none; b=LCPDRq0FpLi3mtSZr3H/mQI+AGPF7eedUC439pl4Efs9Q0LVOvauK6qK/cDP6oRC+cQSa7tm6/Z7zw4cx2UOT/Bf5v36EMkAJ+QQLHj8+U4vz5N4TCzR+hvgaR7eaDw6EsIMTVyOXKxFc2b3BadeZqQ8lxs/fIc2GOk+Bl0gNPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761558665; c=relaxed/simple;
	bh=9KuN2Xm5jw7TgRZXPSk3P9TAJLH7k2ZyHKs1la0a+4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BJ5BlH6+PJ2FuqT5Qc9GcNR6iIhD9QI9Lt5/MKR6Vf7Ql8Wm8QVzkP0lHkgpY8Qf7zVhKEb4ooCFwiva1BvYGCGjeACZJiHcwZ8ZuK6B5nkZuBjdM7ssAGzs78th0Am4GrU9x0KdGGDB3gADSLDoy1v7myZzw/t56BoVKBXuED4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G13we1Ia; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63c21467e5bso332246a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 02:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761558661; x=1762163461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mw12YdzTi9NB3y1kJkoK+Kxt9YSNjct8ry46vaendzw=;
        b=G13we1IaFJGFCltdOonHjJqbkNUxhdvAb8xA1SPfRYVfyQ48kbPr3F4Qej/teyDd9+
         6AwzTSZEut0clR1zyY4wuowDwgfugm5K/8xdvTGIttkWYsvzW98zY+6gI19OATaEN/aj
         3VdeBfjvEG+7VJemRR6Q/QkXnsP4gIZGUF1k8rKEMW1+5ImgR3Fil/L5V9CbcaIKMa47
         yW71RgJNAhXI0e9s+xQkO4iah5orSkyu+b7alEm3j/ykUpk9JQ9bgAvYIoUWC8ixer6U
         rxJ5I4qaTYh6m7vXN9oSLu9+8Rgx32QTCjDJyO5BSUZe4CWjKZ51VCOIBMGFUdFgpYTc
         ESIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761558661; x=1762163461;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mw12YdzTi9NB3y1kJkoK+Kxt9YSNjct8ry46vaendzw=;
        b=BnhF+uX77YsQPX9V1lo0DuIIty653hRy1XF7e66urxyPiVQWRcPPTuXx9fr+Xq6KOc
         RvDNTada3riusb9vG8/6zxiFQrdr6m9tqXAyWJRDJDqFlBP2R4YzKcRNim23UZywozRw
         6D9at577MKv6oSom247fK8s1aG+8NXpZJWs1gB6BBTcPGcRphlxILW5Sqm3tVUSXqh/h
         NbD4US39TJ5aiYBeOIHy4SsFtIgr06B6PqDjl/4jAJkk97fV8lSSw6YF7aLrsJspXUuE
         4To0FsroLVgUZVdpSOqFzxcGKPzYsW+B/UDjMyK4BTPioF9YBARcrX1ZLzNjKYo/ZkMo
         GlhA==
X-Forwarded-Encrypted: i=1; AJvYcCXzD5zC4OBKl5oHNt3xDvkGgXp3rx+7zO9SS3u8ZRlYCyvpF9Gk2clh08bj3PnZr3Vi6nlYJt01De43Fkg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9JkrUVaifQdY1JxTiBjf13A56VVAKH+MJhOOjuqnlDVdFkoQO
	Pzbd06RUXdpSJ+WMBH6leQkDE1Cb1hMpJZG0AdcwLGK7/Km4uZBu/ELX
X-Gm-Gg: ASbGncuXMhQ/HIcyqrA8Lo7Q/grZha+rVLuqGHh2/Anku9Xy64eflumagm67JG5B+Y6
	BRa7DD3bDuoAGxd0OnvK8+Ni9xqNFo+/aRpNMTw1oVAx4YaOwQB55yYxRPkh7IZlDSS0P8P+Kdm
	NkqIEctEnZFfm7yff0BOtbMKjlSPJZ7LcaZbZ0wnOxozAi3m6piYmITfgrTIOw3kujFnsIt4qjS
	ZWyP01AVmmc/dia+nlIgEo2+andyGQIi274AXXjMC+aoxUgQ512208AG/ICMc5qDjd05/vY0gwf
	DM+Yl1zl4l783vbvNDXZahbrFCYz4ItKr8EKEUe1QmnJ87EzYCXDaApVE0iOEhUc5QDY+wJsVw1
	AC3bTq6HeOspxg2yR8lzp+lBFOHVlss0aBaZ4H6NDK02a1egiJoBF+lrVVwooz/IYmNHrUpWfEG
	hxBpJdFgRniyqZeTEhTUW2doJNNyCeug==
X-Google-Smtp-Source: AGHT+IERBzNr1pRW9aQQMHx51xdoW3UzXmbId6nlUYrZzGZ0Z6AgDbAWku/q0c+3JyA6dFoSGcQW5w==
X-Received: by 2002:a05:6402:2787:b0:63b:d7f0:d940 with SMTP id 4fb4d7f45d1cf-63c1f6300fbmr32209099a12.1.1761558661210;
        Mon, 27 Oct 2025 02:51:01 -0700 (PDT)
Received: from [10.25.208.2] ([128.77.115.157])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef82907sm5888719a12.12.2025.10.27.02.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 02:51:00 -0700 (PDT)
Message-ID: <9e5f5166-75c3-4c7c-804a-8cb24c67f416@gmail.com>
Date: Mon, 27 Oct 2025 02:50:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] clk: imx: add driver for imx8ulp's sim lpav
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Daniel Baluta <daniel.baluta@nxp.com>, Shengjiu Wang
 <shengjiu.wang@nxp.com>, linux-clk@vger.kernel.org, imx@lists.linux.dev,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20251017112025.11997-1-laurentiumihalcea111@gmail.com>
 <20251017112025.11997-4-laurentiumihalcea111@gmail.com>
 <20251022140315.GA11174@nxa18884-linux.ap.freescale.net>
Content-Language: en-US
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <20251022140315.GA11174@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/22/2025 7:03 AM, Peng Fan wrote:
> Hi Laurentiu,
>
> On Fri, Oct 17, 2025 at 04:20:20AM -0700, Laurentiu Mihalcea wrote:
>> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>
>> The i.MX8ULP System Integration Module (SIM) LPAV module is a block
>> control module found inside the LPAV subsystem, which offers some clock
>> gating options and reset line assertion/de-assertion capabilities.
>>
>> Therefore, the clock gate management is supported by registering the
>> module's driver as a clock provider, while the reset capabilities are
>> managed via the auxiliary device API to allow the DT node to act as a
>> reset and clock provider.
>>
>> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>> ---
> ....
>> +struct clk_imx8ulp_sim_lpav_data {
>> +	void __iomem *base;
>> +	struct regmap *regmap;
>> +	spinlock_t lock; /* shared by MUX, clock gate and reset */
>> +	unsigned long flags; /* for spinlock usage */
> This does not need to be here, put it as function local variable should
> be fine.
>
>> +	struct clk_hw_onecell_data clk_data; /*  keep last */
>> +};
>> +
>> +struct clk_imx8ulp_sim_lpav_gate {
>> +	const char *name;
>> +	int id;
>> +	const struct clk_parent_data parent;
>> +	u8 bit;
>> +};
>> +
>> +static struct clk_imx8ulp_sim_lpav_gate gates[] = {
>> +	IMX8ULP_HIFI_CLK_GATE("hifi_core", CORE, "hifi_core", 17),
>> +	IMX8ULP_HIFI_CLK_GATE("hifi_pbclk", PBCLK, "lpav_bus", 18),
>> +	IMX8ULP_HIFI_CLK_GATE("hifi_plat", PLAT, "hifi_plat", 19)
> For the parent name, my understanding is they should be the one
> from clk-imx8ulp.c, but I not find them, or may I miss something?


we want to use parent names local to the SIM LPAV provider (i.e. names specified via clock-names)

instead of the global ones. See definition of "struct clk_parent_data".


while we're at it, maybe it would be a good idea to drop the ".name = pname" assignment bit

as that won't work anyways since we're relying on local parent names?


>
>> +};
>> +
>> +#ifdef CONFIG_RESET_CONTROLLER
>> +static void clk_imx8ulp_sim_lpav_aux_reset_release(struct device *dev)
>> +{
>> +	struct auxiliary_device *adev = to_auxiliary_dev(dev);
>> +
>> +	kfree(adev);
>> +}
>> +
>> +static void clk_imx8ulp_sim_lpav_unregister_aux_reset(void *data)
>> +{
>> +	struct auxiliary_device *adev = data;
>> +
>> +	auxiliary_device_delete(adev);
>> +	auxiliary_device_uninit(adev);
>> +}
>> +
>> +static int clk_imx8ulp_sim_lpav_register_aux_reset(struct platform_device *pdev)
>> +{
>> +	struct auxiliary_device *adev __free(kfree) = NULL;
>> +	int ret;
>> +
>> +	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
>> +	if (!adev)
>> +		return -ENOMEM;
>> +
>> +	adev->name = "reset";
>> +	adev->dev.parent = &pdev->dev;
>> +	adev->dev.release = clk_imx8ulp_sim_lpav_aux_reset_release;
>> +
>> +	ret = auxiliary_device_init(adev);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "failed to initialize aux dev\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = auxiliary_device_add(adev);
>> +	if (ret) {
>> +		auxiliary_device_uninit(adev);
>> +		dev_err(&pdev->dev, "failed to add aux dev\n");
>> +		return ret;
>> +	}
>> +
>> +	return devm_add_action_or_reset(&pdev->dev,
>> +					clk_imx8ulp_sim_lpav_unregister_aux_reset,
>> +					no_free_ptr(adev));
> clk_imx8ulp_sim_lpav_unregister_aux_reset() clean up the resources, if
> moving this before auxiliary_device_add(), then no need
> auxiliary_device_uninit() when add fails?


the whole chunk guarded by the #ifdef CONFIG_RESET_CONTROLLER should go away

anyways once I switch to devres as Frank suggested


>
>> +}
> Regards
> Peng

