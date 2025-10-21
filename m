Return-Path: <linux-kernel+bounces-862978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C3FBF6B6F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5512D189DF92
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7482F220F5C;
	Tue, 21 Oct 2025 13:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgKvRn6m"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC1A23EA85
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052608; cv=none; b=ARlp1zjnRXfNQuxxuAE/MWOIZVjvDWNV2bOJ+6ws7YrLb5Btp9bX16qGviyJ3TeTTKcbvlJ8uL5kHvvn8O4e9B5DGeNb7hVks5kkYPdkobK3SiL+CFUYRs0e9r4nba1OIEiBmIhfXzN4QYi0hvAxc6Pn6+7gGzNs1g/qG2MFPDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052608; c=relaxed/simple;
	bh=knG1/6Zq0XiYPG2BG5s77b/+W0LTFGc5Cok0Z3vP3bA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nq9LAigVBxVdWaTMe/9W+I/1LzY2gp9V2JefqWrC6xcDyUJxKRLtJH5uZbwqoSq0VNIeTN/GQer9g20qII/07gYlKtMFyApsS4RzdY1zPwNRB7lS3O2a5kWphwfvHcRktY18/IzOghlJFd90MS6n+zt256U3H3BVE/otw3KyfU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgKvRn6m; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63bad3cd668so10607442a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761052605; x=1761657405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/0jubacFDSdFcQnHYVbBIaUUxwO2V0rJTSsvBZVmUXc=;
        b=GgKvRn6m/DuPSC3wiV8SG8odvNRTXd+OGVddf7MakmLU9w7e4EggAcTcWO5Y720nWv
         2lKrXzc9KJZvUrc14y2cgkG64FId6FDcuG6VNzVt0xeXSVlknvAQmuaTq2XI/uO7T1Ka
         Dngq3hl96cOPya2vjVzzAB4kufGjl3WrDQvrHQ76MEzQDrrjweP4/g14p0rEOt2eaN9i
         xsx8gzcJUJrlOBcOp5e2QdCSU797GYjcTVsMY9zWKgaKHYmzxKQPXfMgu+Figo7wcJFF
         VEuAplV8yZf+J1yZ5VVwYZ0ez5XlV7fzQ8ojASIJMXqurhTRP9YfwHAhq1VxIuWlspZ4
         j3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761052605; x=1761657405;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/0jubacFDSdFcQnHYVbBIaUUxwO2V0rJTSsvBZVmUXc=;
        b=q606cIZpwo9XEmVnjGC08Zd6B4FMOkQhta9YP5GrO16epyUKs2CV8lNKFzNlSBw/sg
         cd02g1YVKoyeOSn3ygRWvhOMG6Hf5JmnH3i632ujI5rOi0lmid5FRL/krPL0saRrx1Eq
         BhELN4UBHYpyFdpBTP92GP3ZXa1LQSIWOgSkqWtUeg2YapvWipXVjTzp9UCxxzh2Kps4
         v0AO7uPi7FPNuuvpnmedLAOG0qggeINcsDPhzgEHXWDJnGsb27wysVTpWAsMw6e9gl49
         RNPCAtF/cye7lKc/ojdsfblsWqwIK2NtgkYGgx7jIPpq4fLptHyC8b4LTYG7Q0O4HKTK
         C/Xw==
X-Forwarded-Encrypted: i=1; AJvYcCXKWlgehoz9R3VJdN7anMUd3UNo4Lui5G6X08NtMOWi1Memaa7yqDdmS9opBeWQS3M8cx8VwsIM8ymWOZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfUNvyapsgE9klkuEY0ycqXUR8OpCDDWMimZff9tNnBSnz5jRl
	qZii6OuYhV07mkFtuBHmkAAF+EIsvD7ny8742IAsAgd0x0xakSAoKWKl
X-Gm-Gg: ASbGnctCyMNLo7w4r7ch0bN/EzQl4YkvHCqj/RJEPwK7GRiYN3M1QvrpW6CrxSoqHor
	6rlri7DLOcY7O4PLUzqQumoPzG28MPQwK6fVuaF11NILNDODSrDUbaw/8tEkxHPbLzSQxO99pEX
	GnXMZfc8EfD0nx9ioi6a8cBt5oD/xZBOjiaQ4HxqI5Ix7ogzKT4drYTr4SiZx0/BslYlyHD/M+9
	EwlQ+FC+gvnd/sMFihlJKfGKMmlfY+vxzV43OnPXBgvv1MG2xgu8uIEeYZ73feMlWmhiqzYvM7M
	cARhrJI1aaekUOmk400mGR72yBzZ+bXHoV7fjgJvtcAKAS+AVSwN/E74KPyDqm3hsAG41G2WnCY
	8m6tidmupEkKn31rdZ6h1xR0l5HG8udDVeBSjmKF80HNeLBzjHBtj8Obd9pAtALbdD6FCPqm5lx
	LVinquhVltEn7NCLh+srSbW0HQEPXN/LkNevOREVN1New=
X-Google-Smtp-Source: AGHT+IGLK2EmnFCqdftdxAKB6j+6Ma2jSdfUwKotGCFRUzw3RKdiF0RM9WMxavQ7l+6jXDABf8pL5A==
X-Received: by 2002:a17:907:3f25:b0:b30:ea06:af06 with SMTP id a640c23a62f3a-b647324404cmr1795728766b.24.1761052604632;
        Tue, 21 Oct 2025 06:16:44 -0700 (PDT)
Received: from [10.25.219.115] ([128.77.115.158])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e8391523sm1069741966b.18.2025.10.21.06.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 06:16:44 -0700 (PDT)
Message-ID: <f1bbd303-2798-4476-921a-62b45fdb67ea@gmail.com>
Date: Tue, 21 Oct 2025 06:16:41 -0700
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
 <64b28a11-337a-42ba-8765-d94b19070d66@gmail.com>
 <aPZMJb9VwylTIiCM@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <aPZMJb9VwylTIiCM@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/20/2025 7:50 AM, Frank Li wrote:
> On Mon, Oct 20, 2025 at 07:29:28AM -0700, Laurentiu Mihalcea wrote:
>> On 10/17/2025 7:57 AM, Frank Li wrote:
>>> On Fri, Oct 17, 2025 at 04:20:24AM -0700, Laurentiu Mihalcea wrote:
>>>> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>>>
>>>> Support i.MX8ULP's SIM LPAV by adding its reset map definition.
>>>>
>>>> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
>>>> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>>> ---
>>>>  drivers/reset/reset-imx8mp-audiomix.c | 51 +++++++++++++++++++++++++++
>>>>  1 file changed, 51 insertions(+)
>>>>
>>>> diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-imx8mp-audiomix.c
>>>> index c370913107f5..b333d7c1442a 100644
>>>> --- a/drivers/reset/reset-imx8mp-audiomix.c
>>>> +++ b/drivers/reset/reset-imx8mp-audiomix.c
>>>> @@ -3,6 +3,7 @@
>>>>   * Copyright 2024 NXP
>>>>   */
>>>>
>>>> +#include <dt-bindings/reset/fsl,imx8ulp-sim-lpav.h>
>>>>  #include <dt-bindings/reset/imx8mp-reset-audiomix.h>
>>>>
>>>>  #include <linux/auxiliary_bus.h>
>>>> @@ -17,6 +18,8 @@
>>>>  #define IMX8MP_AUDIOMIX_EARC_RESET_OFFSET	0x200
>>>>  #define IMX8MP_AUDIOMIX_DSP_RUNSTALL_OFFSET	0x108
>>>>
>>>> +#define IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET	0x8
>>>> +
>>>>  struct imx8mp_reset_map {
>>>>  	unsigned int offset;
>>>>  	unsigned int mask;
>>>> @@ -55,6 +58,50 @@ static const struct imx8mp_reset_info imx8mp_reset_info = {
>>>>  	.num_lines = ARRAY_SIZE(imx8mp_reset_map),
>>>>  };
>>>>
>>>> +static const struct imx8mp_reset_map imx8ulp_reset_map[] = {
>>>> +	[IMX8ULP_SIM_LPAV_HIFI4_DSP_DBG_RST] = {
>>>> +		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
>>>> +		.mask = BIT(25),
>>> Register defination still perfer use macro. If not, let me know.
>> I see no value in adding defines for the masks (see patch 4 commit message)
>>
>> in this particular scenario.
>>
>>
>> Is the assignment of the "mask" field for the "struct imx8mp_reset_map" item found
>>
>> at index  IMX8ULP_SIM_LPAV_HIFI4_DSP_DBG_RST not enough to deduce that the
>>
>> constant we're using is the mask for the DSP_DBG_RST bit?
> This bit is NOT software choose bit, which must be align hardware spec.
> Define macro help map name to spec and easy to look for spec by use macro.


yeah, we already have the DT binding macros for that which perfectly match the name

of the corresponding bit in the SYSCTRL0 register. I don't see how adding 6 more macros

with the SAME name as the DT binding macros and the "_MASK" suffix would help you in

this regard?


>
> There are over thousand result to seach bit 25.
>
> eventhough search SYSCTRL0, may have many SYSCTRL0 in RM.
>
> Frank
>>
>>> Frank
>>>> +		.shift = 25,
>>>> +		.active_low = false,
>>>> +	},
>>>> +	[IMX8ULP_SIM_LPAV_HIFI4_DSP_RST] = {
>>>> +		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
>>>> +		.mask = BIT(16),
>>>> +		.shift = 16,
>>>> +		.active_low = false,
>>>> +	},
>>>> +	[IMX8ULP_SIM_LPAV_HIFI4_DSP_STALL] = {
>>>> +		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
>>>> +		.mask = BIT(13),
>>>> +		.shift = 13,
>>>> +		.active_low = false,
>>>> +	},
>>>> +	[IMX8ULP_SIM_LPAV_DSI_RST_BYTE_N] = {
>>>> +		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
>>>> +		.mask = BIT(5),
>>>> +		.shift = 5,
>>>> +		.active_low = true,
>>>> +	},
>>>> +	[IMX8ULP_SIM_LPAV_DSI_RST_ESC_N] = {
>>>> +		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
>>>> +		.mask = BIT(4),
>>>> +		.shift = 4,
>>>> +		.active_low = true,
>>>> +	},
>>>> +	[IMX8ULP_SIM_LPAV_DSI_RST_DPI_N] = {
>>>> +		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
>>>> +		.mask = BIT(3),
>>>> +		.shift = 3,
>>>> +		.active_low = true,
>>>> +	},
>>>> +};
>>>> +
>>>> +static const struct imx8mp_reset_info imx8ulp_reset_info = {
>>>> +	.map = imx8ulp_reset_map,
>>>> +	.num_lines = ARRAY_SIZE(imx8ulp_reset_map),
>>>> +};
>>>> +
>>>>  struct imx8mp_audiomix_reset {
>>>>  	struct reset_controller_dev rcdev;
>>>>  	void __iomem *base;
>>>> @@ -183,6 +230,10 @@ static const struct auxiliary_device_id imx8mp_audiomix_reset_ids[] = {
>>>>  		.name = "clk_imx8mp_audiomix.reset",
>>>>  		.driver_data = (kernel_ulong_t)&imx8mp_reset_info,
>>>>  	},
>>>> +	{
>>>> +		.name = "clk_imx8ulp_sim_lpav.reset",
>>>> +		.driver_data = (kernel_ulong_t)&imx8ulp_reset_info,
>>>> +	},
>>>>  	{ }
>>>>  };
>>>>  MODULE_DEVICE_TABLE(auxiliary, imx8mp_audiomix_reset_ids);
>>>> --
>>>> 2.43.0
>>>>

