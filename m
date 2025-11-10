Return-Path: <linux-kernel+bounces-893439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A78CC47670
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BA2F4ECFBB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A67314D28;
	Mon, 10 Nov 2025 15:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="QeyGUmDg"
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E52E313537
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787141; cv=none; b=M7xWXJG/akmiclHv+hybXHYtZW5CJA7Xco0a2/mgGzBZmLthLftSxeGBVq5oCFlOi7EAg/Fcgf5a+JS7zlq+Q01pCPSTPQRDSdQJSDJ9dyjSsjvzU3zPGLcX0Y/EOUEKCSzo19+cAN0vsbfa7jjuAOL3bmMHNACo9eQ6NrD0oGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787141; c=relaxed/simple;
	bh=jqV0RYGag5Tnyu6MmFEVw70orsW2JaWWXU+MmaWcvrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RNFS/6ELfTE2LEV0qdMsyH24LEc6pFS/4hHTznWwUHMLLsAppIWdDYtklli+KN9yZUXPaGj9sawImR4N2PqR8+ztYS0myuaz2OgHUZv603u8wX0NSaOJNElwo6m5merlVvmCy1vYB+1dXDZKryX/2zcC3VJPIQdyagF+DpIAEEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=QeyGUmDg; arc=none smtp.client-ip=209.85.167.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-oi1-f195.google.com with SMTP id 5614622812f47-450063be247so1128403b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1762787138; x=1763391938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gLIkqGwA5TFLsjPNFy0EVjpciOH8eLZgKkAfRn9EpW8=;
        b=QeyGUmDgjPstm3N5+w3swY24zcsBNb7CFSLoX6H/G/lQ6lqC6c5yBqBR4xLQkacUnO
         FaukJqX36VGRwvNgtFTXGPgWaVkxfknsOMTTm05CBNAie6L9r8q3hb5sDkQJe16K4dVW
         7spLX5JgonIacYWJyj/a/W7o2VWBakvUEgywPaGRONAkcf9KOuIMcIj9odziJHudrR4G
         yrpkBpkkMKrYlyEEYEuKBspJiMj1EfjlkPcj6nHV6VaS9HTYI+5E0g7ubYm9wB+/CnWz
         CZw5CaSg8AfKVNF5kqi8fN3/lVvdynUVxwVwkNd/NmA2LqlJ4w3J7PBMspGkJ1HwtMnA
         TXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762787138; x=1763391938;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gLIkqGwA5TFLsjPNFy0EVjpciOH8eLZgKkAfRn9EpW8=;
        b=ehwle/Plw2dq5zNo8UcRk8SM+x8YNhncC4sGkwRrRIeRKNqWmVE1Ry6CyVxWm5EFqf
         k30jjAPNwWsG4tRIv6Y0fAcUvhg5BvYBMyQ8w3EV+7RHNR/nLqdmfjfvkB9TrH8T8Fjh
         lhlseZ+hmjmKMh1gTVlXKetkGl/1cbsifpS9mS+dk7ZPV+R3jFVVTzCpPOW2Cpy8HwjO
         jxXg3D3zx61Jq1fgK82Xp7wMtYub/N6lSypjP95S3BQwjJtdYVXM25l/P9Ea8QVcPv3h
         eNb1Ml8oPmx/5bVSHDJpaSH+V5OFg4yIYOpTEXN85saPbWtl4cj4OG5VJXtObh/Yjtcq
         AUAg==
X-Forwarded-Encrypted: i=1; AJvYcCUm6PpDFTKnN5mmijg7Jz2fi0XhJ4KVCnMWEkHpocWJRoSbyOZ25HikQsMx3lK+jHnQyR95kTCluUlYYNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YziOD2tR8B8iGf+ZRa81ZwsXLoYVdQGQ0AnhrvbDjITNNtON2bU
	T7OqCcOIc4Nz64u0TjAtreuw+gBPF+98gaGRkFS4wu+zqFnGy6m6AEsZF5EBwfYsx4s=
X-Gm-Gg: ASbGncvSPgNfC+jKwlhoOY90Hv7SCTszniFa7L3oBzyyhvcBViyqGRIqhDeWSLeE1Ua
	MDRw/LmsOa7zQ/gmTVzordYAwZ+45pN6mAockyiPODaxW/b5e2oDx9ikYQ4FYe/rVdMjeMY8/9W
	WgHFfN7xgt4MWSFR0PNf8guq3i7wAcWmYZ7q2IDkzIzQnNW5CY+fDweckHVqfoxy6bG8oCggghM
	69PGMOahouGZOhFFubH17gzSIRQyGekWh0gokkx4Jo59hS2EadkRkvoCuNcF5jsUbIfelOOpzd7
	ZLAgWDjLteUgFSgegG/suwJTomCW5zHfKy+wAy9j2N/4p6mRJ2YKgoT8xOuyjC8IEQy4p/sNwzk
	wyGV66zOueN44R23GuEFz/40QFxcd4E3QMFA1t26ENyeDmghuq8cp0LJJh9RJqEP35LBORVeBGE
	k6qK5xy/ILQl9dge7Kh91+BsDRgxvq0rmKbxhIMRw=
X-Google-Smtp-Source: AGHT+IHgQiveeEt2TcyVpw/M9TZjIcS1T8WMm/l7R5G//yZo5AlEVPBUPldB2kYOGjXywx6gsdENHQ==
X-Received: by 2002:a05:6808:c015:20b0:450:2e22:ed72 with SMTP id 5614622812f47-4502e230e41mr3451947b6e.5.1762787137562;
        Mon, 10 Nov 2025 07:05:37 -0800 (PST)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b74695bb6bsm4940807173.42.2025.11.10.07.05.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 07:05:37 -0800 (PST)
Message-ID: <4a7d6e07-82f8-437f-bccb-cf294974a53e@riscstar.com>
Date: Mon, 10 Nov 2025 09:05:35 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/7] PCI: spacemit: Add SpacemiT PCIe host driver
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, bhelgaas@google.com
Cc: dlan@gentoo.org, aurelien@aurel32.net, johannes@erdfelt.com,
 p.zabel@pengutronix.de, christian.bruel@foss.st.com,
 thippeswamy.havalige@amd.com, krishna.chundru@oss.qualcomm.com,
 mayank.rana@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
 shradha.t@samsung.com, inochiama@gmail.com, guodong@riscstar.com,
 linux-pci@vger.kernel.org, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251107191557.1827677-1-elder@riscstar.com>
 <20251107191557.1827677-6-elder@riscstar.com>
 <120b2f62-25e6-4ea3-9907-230080c61f70@wanadoo.fr>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <120b2f62-25e6-4ea3-9907-230080c61f70@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/8/25 7:00 AM, Christophe JAILLET wrote:
> Le 07/11/2025 à 20:15, Alex Elder a écrit :
>> Introduce a driver for the PCIe host controller found in the SpacemiT
>> K1 SoC.  The hardware is derived from the Synopsys DesignWare PCIe IP.
>> The driver supports three PCIe ports that operate at PCIe gen2 transfer
>> rates (5 GT/sec).  The first port uses a combo PHY, which may be
>> configured for use for USB 3 instead.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
> 
> ...
> 
>> +static int k1_pcie_probe(struct platform_device *pdev)
>> +{
>> +    struct device *dev = &pdev->dev;
>> +    struct k1_pcie *k1;
>> +    int ret;
>> +
>> +    k1 = devm_kzalloc(dev, sizeof(*k1), GFP_KERNEL);
>> +    if (!k1)
>> +        return -ENOMEM;
>> +
>> +    k1->pmu = syscon_regmap_lookup_by_phandle_args(dev_of_node(dev),
>> +                               SYSCON_APMU, 1,
>> +                               &k1->pmu_off);
>> +    if (IS_ERR(k1->pmu))
>> +        return dev_err_probe(dev, PTR_ERR(k1->pmu),
>> +                     "failed to lookup PMU registers\n");
>> +
>> +    k1->link = devm_platform_ioremap_resource_byname(pdev, "link");
>> +    if (!k1->link)
> 
> if (IS_ERR(k1->link)) ?

Yes, you're right.  I'll fix this in the next version.


> 
>> +        return dev_err_probe(dev, -ENOMEM,
>> +                     "failed to map \"link\" registers\n");
> 
> Message with -ENOMEM are ignored, so a direct return -ENOMEM is less 
> verbose and will bhave the same. See [1].
> 
> But in this case, I think it should be PTR_ERR(k1->link).

Yes, that's what it will be.

> [1]: https://elixir.bootlin.com/linux/v6.18-rc2/source/drivers/base/ 
> core.c#L5015
> 
>> +
>> +    k1->pci.dev = dev;
>> +    k1->pci.ops = &k1_pcie_ops;
>> +    dw_pcie_cap_set(&k1->pci, REQ_RES);
>> +
>> +    k1->pci.pp.ops = &k1_pcie_host_ops;
>> +
>> +    /* Hold the PHY in reset until we start the link */
>> +    regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CLK_RESET_CONTROL,
>> +            APP_HOLD_PHY_RST);
>> +
>> +    ret = devm_regulator_get_enable(dev, "vpcie3v3");
>> +    if (ret)
>> +        return dev_err_probe(dev, ret,
>> +                     "failed to get \"vpcie3v3\" supply\n");
>> +
>> +    pm_runtime_set_active(dev);
>> +    pm_runtime_no_callbacks(dev);
>> +    devm_pm_runtime_enable(dev);
>> +
>> +    platform_set_drvdata(pdev, k1);
>> +
>> +    ret = k1_pcie_parse_port(k1);
>> +    if (ret)
>> +        return dev_err_probe(dev, ret, "failed to parse root port\n");
>> +
>> +    ret = dw_pcie_host_init(&k1->pci.pp);
>> +    if (ret)
>> +        return dev_err_probe(dev, ret, "failed to initialize host\n");
>> +
>> +    return 0;
>> +}
> 
> ...
> 
>> +static const struct of_device_id k1_pcie_of_match_table[] = {
>> +    { .compatible = "spacemit,k1-pcie", },
>> +    { },
> 
> Unneeded trainling comma after a terminator.

Unneeded, but not erroneous.  In any case, I'll drop it based
on your preference.

Thank you for your review.

					-Alex

> 
>> +};
>> +
>> +static struct platform_driver k1_pcie_driver = {
>> +    .probe    = k1_pcie_probe,
>> +    .remove    = k1_pcie_remove,
>> +    .driver = {
>> +        .name            = "spacemit-k1-pcie",
>> +        .of_match_table        = k1_pcie_of_match_table,
>> +        .probe_type        = PROBE_PREFER_ASYNCHRONOUS,
>> +    },
>> +};
>> +module_platform_driver(k1_pcie_driver);
> 


