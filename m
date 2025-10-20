Return-Path: <linux-kernel+bounces-861127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC99BF1D83
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D162406F30
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081F3324B3A;
	Mon, 20 Oct 2025 14:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgIhKfy4"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87744301013
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760970576; cv=none; b=NI5B646SVde10b2bvU0cA0LKu978io+abqYAK/JW8AUjpGsTjg9Mt7/u8Pmnv9a06BPsU0kc4OHEzztceOAbL8RhLFQnlg//tANtnQrO/XXRBJOgqEW3RB2j1Nx1mTFPjNV/9zCE3goOo7CN+2e/qKDdeEOtlrWdlsb6j1AyybQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760970576; c=relaxed/simple;
	bh=X7IGd3KK52vsYXMhrM/sak5eUWBh9m0RLIV6Uoj15+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cSilDAnJAQFtCBxenYLImpuYXi+iiW48GOwXLJKNnY4R3AQcY1ELxjKA78zpB0m0vs4mvkh2zSX0HOrvf+IPUrXWBHPxgdJRNQzwVMmhpzvi62i39y+zNoRDNLZVT4A56awAkeobYjruWLwj8/jtc8IQ95GgS0KY3uEvERny/uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgIhKfy4; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b6bbfc57b75so107104666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760970573; x=1761575373; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2JR/OKSNOnF+l4tQRJr2FhhTssgUWExohKzJa6PLCZs=;
        b=KgIhKfy42b75V72wMvAz0SmIKxr0YxpNl+4X8ImLHv4zPHDmNKZlbfzV820EqrZbBf
         PJhinJslT8SSrauCRc6ic4A0ENA8sSujNRqThnY1UM5RDqB2zRwAs8Z3EwXyb6WInIor
         eAT+2+V/B7TaJ29iZP07re6jnS99bD2ziSPqKkE590WjrqujP7yMsaz6+YYQqwHQ5Z1l
         mpJr8EhS2TRZNAWXVAi6eWenqcN15yQQJfY6W8NmGjOxlcrV+HyFGvJ5KHytBKhlLD24
         PS1GiWRgh19f0oTSoBS7L7qJpgMWkowYEdXsV0IOLlOwtV6D+pjXm8MBHvBImzlAUHLc
         wRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760970573; x=1761575373;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2JR/OKSNOnF+l4tQRJr2FhhTssgUWExohKzJa6PLCZs=;
        b=mcnod2nlYxn1jNTZC86cn/j1qc6EnGatZqRze5mV4sAvv205FQXo1QOHnWRoC6DMYY
         9iYlDhseJassH8Yqd2CkGgW6Dt3kJ1doHo76ous1dHBla3INGD24LBlrQcyCk3s1VDc9
         /p9Y0Dl+MGjQkUwO8SCutmkpPMHAT00sUFDPW5ZmKdHih2GV330N+gGuXpqiirO4Lq2h
         SqJo9ROWsQ8ZTcb5cjrkyJN44HtJZxdZmjHxWlwrSbTU6lW1pptmwwdPmNxBIA9gA8pH
         QK2++zy9GU3NWsId1I2NOtY0+4hLbOM6ltefzvQO/07qlnBTPgQyaWrXbiUx4oJzy+gQ
         ftJw==
X-Forwarded-Encrypted: i=1; AJvYcCUBIm20aRTYANmTeSzb934lecgbe8ClWNiJo5CBOx4+BJnwh1PuDF1FTkR6Ej14ZzSOCpX3lgwm8w4wtYg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjpblg4P2pEwhv1IlZ8gplCYxPmOkeuRaxsqaLU0SKQkMeZlct
	2kV2t+4Qlv/ENm1xxvs/kkn09dEitc6Swas0RVMe5UqiX4wHdfKM9YaM
X-Gm-Gg: ASbGncu5Eqr7cqrQ9lyKuxY9xnFBHlOqiuERFPYFqOiQmXxiJ/xaXmC3MeQXwibQLkp
	vS7syrxfkiqGIYZakaPryuuNAYhWgsAVobHQbVsjwYhdjaLWreehJXIjqR/VHG+/E9Uw1WYqMh9
	LB+zfL+kjCituAY/RA8g/mAH1W5rpTp6PgXnqTpb9u5MLBwsNZ/16/z8Eker7NVnsKbkc42Yjv9
	SXZ8L/5bJQ78on8502pwdoJfdp2nrdPxlP506wS77izDGDm+3px5tse4r8iflZVvp9Tk8x10Fms
	l07EaMujfMevmY5n3R6zRsmmNvvuv78bTY4JbyRoG2wU8WS8TWbwJhKqhdDNeqPAYEMqOtqPZIZ
	ekG6gnqfi31baEqo5UIwJZFehEgqhwWs+MZSmT91Lt+aMYbk9oQWUKVoogzwgJLBfK/wOJFIEUj
	sM/9lbY8FymD0rxOHfPtOs58dOimIgyTPF
X-Google-Smtp-Source: AGHT+IG/fdWt7ok35oOxO1wrbFMUAezRTf+f2uzPz94aKfhnEmWUajzGD6PhgGurEGjl/Gai/41dbw==
X-Received: by 2002:a17:906:7315:b0:b3c:9bee:eb95 with SMTP id a640c23a62f3a-b645c9cd378mr1808744466b.3.1760970572663;
        Mon, 20 Oct 2025 07:29:32 -0700 (PDT)
Received: from [10.25.213.231] ([128.77.115.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e8391523sm803404466b.18.2025.10.20.07.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 07:29:32 -0700 (PDT)
Message-ID: <64b28a11-337a-42ba-8765-d94b19070d66@gmail.com>
Date: Mon, 20 Oct 2025 07:29:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] reset: imx8mp-audiomix: Support i.MX8ULP SIM LPAV
To: Frank Li <Frank.li@nxp.com>
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
 <20251017112025.11997-8-laurentiumihalcea111@gmail.com>
 <aPJZdAQwdoOP3cqN@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <aPJZdAQwdoOP3cqN@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/17/2025 7:57 AM, Frank Li wrote:
> On Fri, Oct 17, 2025 at 04:20:24AM -0700, Laurentiu Mihalcea wrote:
>> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>
>> Support i.MX8ULP's SIM LPAV by adding its reset map definition.
>>
>> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
>> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>> ---
>>  drivers/reset/reset-imx8mp-audiomix.c | 51 +++++++++++++++++++++++++++
>>  1 file changed, 51 insertions(+)
>>
>> diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-imx8mp-audiomix.c
>> index c370913107f5..b333d7c1442a 100644
>> --- a/drivers/reset/reset-imx8mp-audiomix.c
>> +++ b/drivers/reset/reset-imx8mp-audiomix.c
>> @@ -3,6 +3,7 @@
>>   * Copyright 2024 NXP
>>   */
>>
>> +#include <dt-bindings/reset/fsl,imx8ulp-sim-lpav.h>
>>  #include <dt-bindings/reset/imx8mp-reset-audiomix.h>
>>
>>  #include <linux/auxiliary_bus.h>
>> @@ -17,6 +18,8 @@
>>  #define IMX8MP_AUDIOMIX_EARC_RESET_OFFSET	0x200
>>  #define IMX8MP_AUDIOMIX_DSP_RUNSTALL_OFFSET	0x108
>>
>> +#define IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET	0x8
>> +
>>  struct imx8mp_reset_map {
>>  	unsigned int offset;
>>  	unsigned int mask;
>> @@ -55,6 +58,50 @@ static const struct imx8mp_reset_info imx8mp_reset_info = {
>>  	.num_lines = ARRAY_SIZE(imx8mp_reset_map),
>>  };
>>
>> +static const struct imx8mp_reset_map imx8ulp_reset_map[] = {
>> +	[IMX8ULP_SIM_LPAV_HIFI4_DSP_DBG_RST] = {
>> +		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
>> +		.mask = BIT(25),
> Register defination still perfer use macro. If not, let me know.

I see no value in adding defines for the masks (see patch 4 commit message)

in this particular scenario.


Is the assignment of the "mask" field for the "struct imx8mp_reset_map" item found

at index  IMX8ULP_SIM_LPAV_HIFI4_DSP_DBG_RST not enough to deduce that the

constant we're using is the mask for the DSP_DBG_RST bit?


>
> Frank
>> +		.shift = 25,
>> +		.active_low = false,
>> +	},
>> +	[IMX8ULP_SIM_LPAV_HIFI4_DSP_RST] = {
>> +		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
>> +		.mask = BIT(16),
>> +		.shift = 16,
>> +		.active_low = false,
>> +	},
>> +	[IMX8ULP_SIM_LPAV_HIFI4_DSP_STALL] = {
>> +		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
>> +		.mask = BIT(13),
>> +		.shift = 13,
>> +		.active_low = false,
>> +	},
>> +	[IMX8ULP_SIM_LPAV_DSI_RST_BYTE_N] = {
>> +		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
>> +		.mask = BIT(5),
>> +		.shift = 5,
>> +		.active_low = true,
>> +	},
>> +	[IMX8ULP_SIM_LPAV_DSI_RST_ESC_N] = {
>> +		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
>> +		.mask = BIT(4),
>> +		.shift = 4,
>> +		.active_low = true,
>> +	},
>> +	[IMX8ULP_SIM_LPAV_DSI_RST_DPI_N] = {
>> +		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
>> +		.mask = BIT(3),
>> +		.shift = 3,
>> +		.active_low = true,
>> +	},
>> +};
>> +
>> +static const struct imx8mp_reset_info imx8ulp_reset_info = {
>> +	.map = imx8ulp_reset_map,
>> +	.num_lines = ARRAY_SIZE(imx8ulp_reset_map),
>> +};
>> +
>>  struct imx8mp_audiomix_reset {
>>  	struct reset_controller_dev rcdev;
>>  	void __iomem *base;
>> @@ -183,6 +230,10 @@ static const struct auxiliary_device_id imx8mp_audiomix_reset_ids[] = {
>>  		.name = "clk_imx8mp_audiomix.reset",
>>  		.driver_data = (kernel_ulong_t)&imx8mp_reset_info,
>>  	},
>> +	{
>> +		.name = "clk_imx8ulp_sim_lpav.reset",
>> +		.driver_data = (kernel_ulong_t)&imx8ulp_reset_info,
>> +	},
>>  	{ }
>>  };
>>  MODULE_DEVICE_TABLE(auxiliary, imx8mp_audiomix_reset_ids);
>> --
>> 2.43.0
>>

