Return-Path: <linux-kernel+bounces-860685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A93BF0B1E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E03ED4F256E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BC12561D1;
	Mon, 20 Oct 2025 10:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNrUILw6"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F7D25485F
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760957873; cv=none; b=MDhPP/gGFO+L67L1r6VdtYFOR6Ks2TuFsEIdWDuD7wPHRNk66tWFmQT8sSM64ENJT7TXNbL/qbi++BbeSQoEIP48xZl7ulYIi3BXgCRTic47efg9M7kGXVGYCtNRxVDGkmo3pwyoSbxH7bS8EoBIu0M9v992A6knyfVTyoze8D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760957873; c=relaxed/simple;
	bh=Bla6ToecjH8EIjNTcUj1wMY0Ir7o6x4mV6qZgP7BkbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K51i9zg77lLt5WekeUHbFJiAVKI2kFTSWR0kqPHwDjpikj63kkInPQf1NA39DQQ8Ejw3d737E/g8tOgApzgS2qQzZCj/AiCLSBGrSvWtpNnneNYc9bcz3g5/ogGTF6NROx8c2x768+1WZBIlKa0ZCbGZT1XEemPP2EDLHE9awoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNrUILw6; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3b3a6f4dd4so784710466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760957870; x=1761562670; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PufIutwJX/MUqRq87e43IN62sjFrJG1C0t3fcKqtI5s=;
        b=FNrUILw6LOtaHQihoIE9wHkvYgf9oOMFbx2ZNVlx2/RxMcvvlSC5+OJZhXVgvUhnY2
         OvYeHf1m9G9WXkg4POX2hnk/P043OVsTtV57DDR3GJmnTDFoG2Sgjxvx47b/uA740Gha
         QErYg3bjncYMJzc3PaReMIczVBARZbS14BrI2lgIsgZWlVU0atZXU+M/QE3/fz4MBWSW
         ldA9S0EGg9qz+K2JEfhKba0SLl+i5oZZoKzc3XlWAsq72s0BvaQkaLaLCfXWmBsFH5dQ
         sRXlMq1wEnOPPGWWP9kQNMsysFO35GzDoI0PwR2VVsMmHDEAqiFSAHnNTwPIAjDyNup6
         54OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760957870; x=1761562670;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PufIutwJX/MUqRq87e43IN62sjFrJG1C0t3fcKqtI5s=;
        b=HXsX8IVZMQccZ8v1zMSzFlOzbkseV0Asb5qw3oao8AJDjo5QeweB6rx3UEcgTeA7er
         IEFFSBVe1bEWwWKZa2LA21JVvjJq46LZCoWVqKzQy/hQuf8jBNXiSkwG0C7JuH7LGy4w
         p3x9qDM4LJfCSeN5ludwkbw9CXW2Z6dqMQmdjb1RCv+p9f7AzWLCh8SuF1ShUH9kca1/
         qNqSxVKQAcF75Ex0M2UNyCvtoBhguF3qfpviKIs5PMU5Y1Y++DdinTwo9qBCzbgOekh2
         MSZqqUBzKEdEtHTTahRIVR9bkTNb1ksqlZWN/K7qaeIgJbjB0WfClD35FpzdF2wEP0qX
         5JLg==
X-Forwarded-Encrypted: i=1; AJvYcCUHGcV6HHRW0Jf8ih3aFMu2SR/Li4XOmlyZDxv1RRVAx/lVio9gGyhUsuQNyEDV6i8K3xavaFOky54tGRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKDgNy7/uMSmLvn+2n2WqATYY4elFarie25lN0cQ0mLRdixRdj
	CUlHnTGHm9X/fJcfGYsFI11eevjnShMwjrTinATFAsoYCTZg3L8wNU7i
X-Gm-Gg: ASbGncuqY5h65JDNgL5Cck+PR2cyGpz9Dpo7EhMMstoMqkveG1HZhTK5WGRWG/lGabP
	I3X0hw8QwIKvAG7Ss2T9Ypk+a8MQaWx0A1jBllY1z9ww1bFhKKf55sgqJJMMDHBf5LCsU6QVQNL
	/+YKYL5EX+6cuOYTVsDKJO/GnXCDEXr05cf7wvfqqExWXxhnE54TM+M6g1Fb2FxEx8o0I53ef2u
	ec9HB7T3RiPbHid1CTRhA0dJtOZJjE05xVfUEgnVgU98nlzkI9ZoJ6Urn9ksKDDrbcs0suXx+jn
	qqRjjK+ijXikoLTsN2X34WDoLScg7vb4fQg0GR9CnJGUKRqWVtS8nAY2HDmd8PFZ62zYCQf5VGH
	RmCW8STo3UDFxWilyveysGEoNivCYRHSXG3sKGc8KVkDdl8OJPl9KtY8nwTJCI1t9fFyXB4uyM5
	W6iVWVBpJvz4wjQhKGTIZDVxCIEX9DUmFJJUVZ3jn94GA=
X-Google-Smtp-Source: AGHT+IEGNGRqyCA4oo2Whj2ekIc3ahNm9oAu93O5XQjpUk9MWXWOqPcdHqIk3lFTx8TLeoPA3wFzBw==
X-Received: by 2002:a17:907:2687:b0:b57:78fa:db46 with SMTP id a640c23a62f3a-b64764d7dabmr1614004666b.43.1760957870288;
        Mon, 20 Oct 2025 03:57:50 -0700 (PDT)
Received: from [10.25.213.231] ([128.77.115.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e7e984f2sm749179166b.13.2025.10.20.03.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 03:57:49 -0700 (PDT)
Message-ID: <26f1b9ef-2e90-476c-8f95-6bae08f69eb1@gmail.com>
Date: Mon, 20 Oct 2025 03:57:46 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] reset: imx8mp-audiomix: Fix bad mask values
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
 <20251017112025.11997-2-laurentiumihalcea111@gmail.com>
 <aPJSk2spnihEEkas@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <aPJSk2spnihEEkas@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/17/2025 7:28 AM, Frank Li wrote:
> On Fri, Oct 17, 2025 at 04:20:18AM -0700, Laurentiu Mihalcea wrote:
>> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>
>> As per the i.MX8MP TRM, section 14.2 "AUDIO_BLK_CTRL", table 14.2.3.1.1
>> "memory map", the definition of the EARC control register shows that the
>> EARC controller software reset is controlled via bit 0, while the EARC PHY
>> software reset is controlled via bit 1.
>>
>> This means that the current definitions of IMX8MP_AUDIOMIX_EARC_RESET_MASK
>> and IMX8MP_AUDIOMIX_EARC_PHY_RESET_MASK are wrong since their values would
>> imply that the EARC controller software reset is controlled via bit 1 and
>> the EARC PHY software reset is controlled via bit 2. Fix them.
>>
>> Fixes: a83bc87cd30a ("reset: imx8mp-audiomix: Prepare the code for more reset bits")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> Just curious, why previous version can work?


good question. I assume this was never tested so I don't think the question

of this working in previous versions or not is applicable here. I also looked for

the usages of these macros in the DTS and there seems to be no consumer.


I discovered the issue while testing the patches from this series. As for testing,

I used a dummy consumer driver/node and manually checked the register values

after each reset assert/de-assert operation.


>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
>> ---
>>  drivers/reset/reset-imx8mp-audiomix.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-imx8mp-audiomix.c
>> index 6b357adfe646..eceb37ff5dc5 100644
>> --- a/drivers/reset/reset-imx8mp-audiomix.c
>> +++ b/drivers/reset/reset-imx8mp-audiomix.c
>> @@ -14,8 +14,8 @@
>>  #include <linux/reset-controller.h>
>>
>>  #define IMX8MP_AUDIOMIX_EARC_RESET_OFFSET	0x200
>> -#define IMX8MP_AUDIOMIX_EARC_RESET_MASK		BIT(1)
>> -#define IMX8MP_AUDIOMIX_EARC_PHY_RESET_MASK	BIT(2)
>> +#define IMX8MP_AUDIOMIX_EARC_RESET_MASK		BIT(0)
>> +#define IMX8MP_AUDIOMIX_EARC_PHY_RESET_MASK	BIT(1)
>>
>>  #define IMX8MP_AUDIOMIX_DSP_RUNSTALL_OFFSET	0x108
>>  #define IMX8MP_AUDIOMIX_DSP_RUNSTALL_MASK	BIT(5)
>> --
>> 2.43.0
>>

