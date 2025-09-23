Return-Path: <linux-kernel+bounces-828927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB951B95DE8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A3294827E1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D50322A27;
	Tue, 23 Sep 2025 12:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="dAjaEmgk"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB4D2ED842
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 12:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758631768; cv=none; b=JNOqcmwf3gqavJOTOe1m2af0KatsqjOJJ1iOuPODw1JGxFW1EoPTI27xgiSw1GCuFqLj6lXoJFU/8jVrNL/FJY7316Opzz2Bajr0e5C7O6rsg52f0FS+tFhpTyot2aMege/7ykpve5Aezx5McyeFfWMPceVJ+jfBMgK6a4t5o7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758631768; c=relaxed/simple;
	bh=viMHlMgc2DeVPr1JzbzU5Lkyrq+sYbfd7FhWBYhy4fY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CDl+SsbpkGBEUoJVr1DoLEJQdr5+cZ16dyQyKmeh1JUNCawZoiSmmJluFDPM+6RpE3ZfvNVccxb0hc6IBi1VuAspGWmw8plGK0N9enoe6rK5aFbmp3igKpPKNBdvU3H2jeELHfSazzMonzGjBPcLzg/d99sq67EM8EjIo97XtAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=dAjaEmgk; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-4257f2b59ffso6970475ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 05:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758631765; x=1759236565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ZU9aQ8bM7T2Ftc+EDUk8mZlFRUJvemFzpUBxk0Wb8I=;
        b=dAjaEmgk2y/UZ1dYIOFTm5C8p92Lk/An3f8xyNUz1ElBUboF4ZQ3WbirrpFT/PHKYG
         J0w40nIjk1dhlYeUlDKnpVQMutNAY3NshcSKxroTQbjfsiUH9AcNj7VPfvB3zxlqHV5N
         Kk7T4AWMzRkxZudAb9Id0E9tCVIY/sWehnpA2jXPUN3j+//FUTNjngibEfYZOlnQHqdF
         SRFsY9Utl3ymLON3YwCwK4+ZX4Q4cEIevm4QUEz1fxhGW5P2f0NEKjgiCLhm0ksQBGH+
         AFp6+68lQC5AZETSNd989ygpNJjNALRtXAnClUwJluJUQ2zXziz4VF23tuMR9s7PDCKO
         iSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758631765; x=1759236565;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZU9aQ8bM7T2Ftc+EDUk8mZlFRUJvemFzpUBxk0Wb8I=;
        b=dCDNPggWxzfRlgMP4lV+fKXj/lgGR392t+GKyQu7HMCTBwBYF7ooyz0BpYqeryM7Tb
         ArBVcITc7V8GDUkgFYeMCFuuc3PY4AmjGZJ8QtHF2NN+m7dtx8COTxvXTk16eLwAwkDH
         wyfwv3uahUH+VSIhZ82kgyPoCYw+8Bjoo88qWe0YgRuTE74KVbfHSnDq2+xhKdS2GQel
         bXcPb2NVwEmtNdXU9u32F+ji6YkYgI+8mebMa93DboB/40Fg8qf/qbjxvCZ1hDwjQu6O
         cYzW4B5uCRFZLEBUEcRWY051+7V22C9spzFmyt/uWPQkVrd3Db13RKATkq+42EATX5kh
         AYGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXz94R4J8a5HUDVGRdA1H7hQ+0XNb+06LHqB9aMHYRhhejUgech/2Wg5lky6BkZ1b5UvBELs8GWSgsPx+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMYCscl7wR9tq19vpCxJYcAjL1+OyFa1Lnfvjqt4Pz7KxFs4P1
	SdtC2sSldZsI6pct/jYPaq1QiyAXW42SX80hkUA87FqIfa70kQdMpGk4G7YFQrdvtC8=
X-Gm-Gg: ASbGncutpeegylK1Qhb1rU2JL7i7qjVn7kpvV8U3PXxKqCKsDkyUJWUmHgl0LdK2dp1
	4cbJ9+93E6yyAe9k0JzXndUFdVMTF8AxciSp0iqLUukntyB3BqwbWTz7Zdxf5isrwOeCp/LXgZf
	bNygF0xMxW3EJqZXDrYsMaglT6fPByqTzbDv3MIGjt7t35UjkWj8l4RTPmQ8yQUSP/vFZBwszQ7
	kt2kbRB3zplOYi6qSL6E2tZZgcDIs8TQxFX1ZoGBVHl3/qwlqTjyPWqrpgvtNcreUq3ig/ajYaV
	7nvSL9bZqcHcEOczcMcNeGVWWmhYQYX2ZoANeYB+hI8bFyt4H+sVa2G9dIjJ01/kVKRNUJhUlGx
	irqxdFApaEGluQuvTROeJHPWrmsHuzwzTz3VgG0H0q/MRkj4QHkWCa0W3jeqVLQ==
X-Google-Smtp-Source: AGHT+IFj1XQAMzFpu45XELaWdmBGc77d+Kzj8EzJZoLjGXq7RU8vmmffnX+IA/9d84nt85uqzgtH9A==
X-Received: by 2002:a92:c24b:0:b0:424:2c9:26b5 with SMTP id e9e14a558f8ab-425823254efmr34685275ab.9.1758631764817;
        Tue, 23 Sep 2025 05:49:24 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-556f74174cfsm3556602173.57.2025.09.23.05.49.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 05:49:24 -0700 (PDT)
Message-ID: <786f4a5e-f62e-4cd0-a017-7b61408f34aa@riscstar.com>
Date: Tue, 23 Sep 2025 07:49:22 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] spi: spacemit: introduce SpacemiT K1 SPI
 controller driver
To: Yixun Lan <dlan@gentoo.org>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, ziyao@disroot.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de,
 spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250922161717.1590690-1-elder@riscstar.com>
 <20250922161717.1590690-3-elder@riscstar.com>
 <20250922230639-GYA1303776@gentoo.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250922230639-GYA1303776@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/25 6:06 PM, Yixun Lan wrote:
> Hi Alex,
> 
> On 11:17 Mon 22 Sep     , Alex Elder wrote:
>> This patch introduces the driver for the SPI controller found in the
>> SpacemiT K1 SoC.  Currently the driver supports master mode only.
>> The SPI hardware implements RX and TX FIFOs, 32 entries each, and
>> supports both PIO and DMA mode transfers.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>> v3: - Added imply_PDMA to the SPI_SPACEMIT_K1 Kconfig option
>>      - Fixed a bug pointed out by Vivian (and Troy) in word-sized reads
>>      - Added a comment stating we use 1, 2, or 4 bytes per word
>>      - Cleaned up DMA channels properly in case of failure setting up
>>      - No longer use devm_*() for allocating DMA channels or buffer
>>
>>   drivers/spi/Kconfig           |   9 +
>>   drivers/spi/Makefile          |   1 +
>>   drivers/spi/spi-spacemit-k1.c | 965 ++++++++++++++++++++++++++++++++++
>>   3 files changed, 975 insertions(+)
>>   create mode 100644 drivers/spi/spi-spacemit-k1.c

. . .

>> diff --git a/drivers/spi/spi-spacemit-k1.c b/drivers/spi/spi-spacemit-k1.c
>> new file mode 100644
>> index 0000000000000..2b932d80cc510
>> --- /dev/null
>> +++ b/drivers/spi/spi-spacemit-k1.c
>> @@ -0,0 +1,965 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Support for SpacemiT K1 SPI controller
>> + *
>> + * Copyright (C) 2025 by RISCstar Solutions Corporation.  All rights reserved.
>> + * Copyright (c) 2023, spacemit Corporation.
>> + */

. . .

>> +static irqreturn_t k1_spi_ssp_isr(int irq, void *dev_id)
>> +{
>> +	struct k1_spi_driver_data *drv_data = dev_id;
>> +	bool rx_done;
>> +	bool tx_done;
>> +	u32 val;
>> +
>> +	/* Get status and clear pending interrupts */
>> +	val = readl(drv_data->base + SSP_STATUS);
>> +	writel(val, drv_data->base + SSP_STATUS);
>> +
>> +	if (!drv_data->message)
>> +		return IRQ_NONE;
>> +
>> +	/* Check for a TX underrun or RX underrun first */
> s/RX underrun/RX overrun/

OK.

>> +	if (val & (SSP_STATUS_TUR | SSP_STATUS_ROR)) {
>> +		/* Disable all interrupts on error */
>> +		writel(0, drv_data->base + SSP_INT_EN);
> should clear status of SSP_STATUS instead of disabling ISR, see commet below

The status is cleared immediately after reading, above.  We hold
the status value so we can act on the current state of the FIFOs.

>> +
>> +		drv_data->message->status = -EIO;
>> +		complete(&drv_data->completion);
>> +
>> +		return IRQ_HANDLED;
>> +	}
>> +
>> +	/* Drain the RX FIFO first, then transmit what we can */
>> +	rx_done = k1_spi_read(drv_data);
>> +	tx_done = k1_spi_write(drv_data);
>> +
>> +	/* Disable interrupts if we're done transferring either direction */
>> +	if (rx_done || tx_done) {
>> +		/* If both are done, disable all interrupts */
>> +		if (rx_done && tx_done) {
>> +			val = 0;
>> +		} else {
>> +			val = readl(drv_data->base + SSP_INT_EN);
>> +			if (rx_done)
>> +				val &= ~(SSP_INT_EN_TINTE | SSP_INT_EN_RIE);
>> +			if (tx_done)
>> +				val &= ~SSP_INT_EN_TIE;
>> +		}
>> +		writel(val, drv_data->base + SSP_INT_EN);
>> +	}
> It occur to me, enabling/disabling interrupt in trasfer_start()/ISR is
> unnecessary, which bring extra overhead, why not enable them once
> and only handle status clear bit? I mean bits has "R/W1C" in SSP_STATUS

Disabling the TX interrupt when we are done sending means we
won't get a pointless "more room in the FIFO" interrupt.

Disabling the RX interrupt when we have received what we want
means we won't get interrupted again, even if (for some reason)
there is more in the FIFO to consume.

I think this is OK.

					-Alex

>> +
>> +	if (rx_done && tx_done)
>> +		complete(&drv_data->completion);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int k1_spi_probe(struct platform_device *pdev)
>> +{
>> +	struct k1_spi_driver_data *drv_data;
>> +	struct device *dev = &pdev->dev;
>> +	struct reset_control *reset;
>> +	struct spi_controller *host;
>> +	struct resource *iores;
>> +	struct clk *clk_bus;
>> +	int ret;
>> +
>> +	host = devm_spi_alloc_host(dev, sizeof(*drv_data));
>> +	if (!host)
>> +		return -ENOMEM;
>> +	drv_data = spi_controller_get_devdata(host);
>> +	drv_data->controller = host;
>> +	platform_set_drvdata(pdev, drv_data);
>> +	drv_data->dev = dev;
>> +	init_completion(&drv_data->completion);
>> +
>> +	drv_data->base = devm_platform_get_and_ioremap_resource(pdev, 0,
>> +								&iores);
>> +	if (IS_ERR(drv_data->base))
>> +		return dev_err_probe(dev, PTR_ERR(drv_data->base),
>> +				     "error mapping memory\n");
>> +	drv_data->base_addr = iores->start;
>> +
>> +	ret = devm_k1_spi_dma_setup(drv_data);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "error setting up DMA\n");
>> +
>> +	k1_spi_host_init(drv_data);
>> +
>> +	clk_bus = devm_clk_get_enabled(dev, "bus");
>> +	if (IS_ERR(clk_bus))
>> +		return dev_err_probe(dev, PTR_ERR(clk_bus),
>> +				     "error getting/enabling bus clock\n");
>> +	drv_data->bus_rate = clk_get_rate(clk_bus);
>> +
>> +	drv_data->clk = devm_clk_get_enabled(dev, "core");
>> +	if (IS_ERR(drv_data->clk))
>> +		return dev_err_probe(dev, PTR_ERR(drv_data->clk),
>> +				     "error getting/enabling core clock\n");
>> +
>> +	reset = devm_reset_control_get_exclusive_deasserted(dev, NULL);
>> +	if (IS_ERR(reset))
>> +		return dev_err_probe(dev, PTR_ERR(reset),
>> +				     "error getting/deasserting reset\n");
>> +
>> +	k1_spi_register_reset(drv_data, true);
>> +
>> +	drv_data->irq = platform_get_irq(pdev, 0);
>> +	if (drv_data->irq < 0)
>> +		return dev_err_probe(dev, drv_data->irq, "error getting IRQ\n");
>> +
>> +	ret = devm_request_irq(dev, drv_data->irq, k1_spi_ssp_isr,
>> +			       IRQF_SHARED, dev_name(dev), drv_data);
>> +	if (ret < 0)
>> +		return dev_err_probe(dev, ret, "error requesting IRQ\n");
>> +
>> +	ret = devm_spi_register_controller(dev, host);
>> +	if (ret)
>> +		dev_err(dev, "error registering controller\n");
>> +
>> +	return ret;
>> +}
>> +
>> +static void k1_spi_remove(struct platform_device *pdev)
>> +{
>> +	struct k1_spi_driver_data *drv_data = platform_get_drvdata(pdev);
>> +
>> +	k1_spi_register_reset(drv_data, false);
>> +}
>> +
>> +static struct platform_driver k1_spi_driver = {
>> +	.driver = {
>> +		.name		= "k1-spi",
>> +		.of_match_table	= k1_spi_dt_ids,
>> +	},
>> +	.probe			= k1_spi_probe,
>> +	.remove			= k1_spi_remove,
>> +};
>> +
>> +module_platform_driver(k1_spi_driver);
>> +
>> +MODULE_DESCRIPTION("SpacemiT K1 SPI controller driver");
>> +MODULE_LICENSE("GPL");
>> -- 
>> 2.48.1
>>
> 


