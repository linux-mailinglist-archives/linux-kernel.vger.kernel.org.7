Return-Path: <linux-kernel+bounces-773738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA37B2A850
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83870586B28
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6A72253F2;
	Mon, 18 Aug 2025 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ArxOw4lS"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B977335BBF
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525282; cv=none; b=M4Nivw4x8IhMfL/QnPIxeNFRDcuvIFAuDsC5Lqi4DOGKSu+O+1anHhoMYYlKy9jbzwAgKUQSSnDlTf4AUIOklKEZFiFUgFGYfni72Rb2V0Tlbe5FtoQBD4GHaqv58hG/3cuYpszxmmC7Rbmgje9IMoiMEtyfZE4VL3+qnHlzx0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525282; c=relaxed/simple;
	bh=0hUvDxAeE7pM0L/uSr+rO+vIOw8U3fLyKq+FUQ9aY4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K5Y8UOJoWlYAGknlZZaWOT7++wxlfnSIQJae7ZwUSwEDrxZBen97b4lkY+80qwIv6rwDCWZSAxmNHeFkm8DbNfASr0Xm8BIHc5d0IXH05sGImGvXBU8f3115FP23D5y3kWlZXveRIkmwDD63QmNNLr4qCyaVskZfetiNbR8awQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ArxOw4lS; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a1b05a49cso30127535e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755525278; x=1756130078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ajbb6uzJgO4JgEqQefnygZnHUM70xCyJcHToGkwu0DU=;
        b=ArxOw4lScpctX7HElRKvj1EpvQNImZ3Nt5qF/gOdk0mmImRfv2fpcCW9RXHiZVG+Fh
         aSmelL9KEdbP1FbZYUUmcKWWZf2RIG66G9X+Rp7v8RqyC6GHw4FrnkNSnBtsXh9KCPcY
         vSUHy/7Lgk9auIv8+W4ff8sZ1ZMXTyZBXqNbhpLUSP+CHobSY260V8XnAArE9yC4Qkmj
         iffTxpY8KheV39qYcSUizUga87a2H0Ga6prjXyTc0TdxkIzwsUNf6MW2obUzU2ROvExS
         0xLg4JQ6KKQvHDhed+eybxZM3FkGBqYR6h+FVzAmIID3NFrWisP90eb8lfgi4BQIV7Ar
         JMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755525278; x=1756130078;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ajbb6uzJgO4JgEqQefnygZnHUM70xCyJcHToGkwu0DU=;
        b=fWOzKT0Wht9fy8QhDodRKnaB9TTiVsS+aHgbc3TRfWWajBHbRLX9wvTUC3FukQ0IMo
         y1X5RRh8abTxuTGlidGrRAEJr93XwquXT10UI4JMhDX7NKbdCxAzjNL3MogMMtLDtc2K
         XYzE5Mn6vIPEAzsyhG8GuLeqXvp4BRiUtjvLUarrXwJ2QUIZRqkDW10/2J+MHtpVcmmC
         kPYoIsgQV/G6GBtQI2WGg0gr6lr2Zmz7Up871WZmSS0OrqoRHB1WW6/QurJOKtSRiXNO
         TT0RS0ZffjgRwqBJvChEUFfDRsN5/30Uroiq8d2IaJZ4n/2+izja8OKaSpc6pp4Obgde
         5IPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEpw9309iLR6MkitPQu7mjmmeU50F0PiDKN/99iTTAwZSEb9U1pIAxU87OTDYyTPZWPIs2Wn/8Bgf13C0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY3FxA+4lgPitX94GsKv2gJ0Ww7oyAnAH39k4ZXMAqArU5L+hV
	Hc8VjsQ+eX+LJ+JaHsAExIKEf0jrUSPLIOTshYcqfFKl6fC30Wws6sRTKMoqu9adIJo=
X-Gm-Gg: ASbGncujSEDAY2W0c8+GNww2/R/aoDpwOD6LQWlPY5ejWNnnb2CFFOzpDtCG+fSw8i1
	3Ph54ubtEn8ym8edX59BLQb1Fg2p5ctRaNYrky5e9YdZTvBiwMpJ6X9LPeK3dRbsNpApxesJ/9N
	JoprrvwpYQ8HUOaqaC4gvyGpfmUG4p/m3BT5k/urPoy172c+uR9zkrYlExi397Ax9vKxO+2W16z
	oM7WRAnvNvLj2cHuxDDWFF89UdQRKuAZFAmBvk+M+HmqRAaRkGJzZeV0D1n3IRCku5unOheGUtL
	bj4ps2Czg3DIydGU1RUd8KhroW6oECZ9KO7iOBHpMrCwK/uWVI6q1PHaC2EW3QUW599oW2UxJwz
	mu6PG/34lNk6ul0J+Yp4QL/oBpTk=
X-Google-Smtp-Source: AGHT+IFsqQPe2NKcX8XP+TiqznD4ogEZ/CDbCC23S0D8qqY54BvYFiH5p+gzA/UnoS6QDPc9lUMMiQ==
X-Received: by 2002:a05:6000:2408:b0:3b8:f864:2fec with SMTP id ffacd0b85a97d-3bb66943367mr9469963f8f.2.1755525277815;
        Mon, 18 Aug 2025 06:54:37 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bc5e232534sm10596525f8f.24.2025.08.18.06.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 06:54:37 -0700 (PDT)
Message-ID: <7c4cb21a-e1ea-4931-9b51-91cfc8217155@linaro.org>
Date: Mon, 18 Aug 2025 14:54:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] spi: spi-fsl-lpspi: Make prescale erratum a bool
To: Frank Li <Frank.li@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, Clark Wang <xiaoning.wang@nxp.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Larisa Grigore <larisa.grigore@oss.nxp.com>,
 Larisa Grigore <larisa.grigore@nxp.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
 Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com,
 linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
 <20250814-james-nxp-lpspi-v1-8-9586d7815d14@linaro.org>
 <aJ4sktG1NoMPu5wZ@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aJ4sktG1NoMPu5wZ@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/08/2025 7:36 pm, Frank Li wrote:
> On Thu, Aug 14, 2025 at 05:06:48PM +0100, James Clark wrote:
>> This erratum only ever results in a max value of 1, otherwise the full 3
>> bits are available. To avoid repeating the same prescale values for
>> every new device's devdata, make it a bool.
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   drivers/spi/spi-fsl-lpspi.c | 12 +++++++-----
>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
>> index 332a852b746f..1013d5c994e9 100644
>> --- a/drivers/spi/spi-fsl-lpspi.c
>> +++ b/drivers/spi/spi-fsl-lpspi.c
>> @@ -96,7 +96,7 @@ static const char * const pincfgs[] = {
>>   };
>>
>>   struct fsl_lpspi_devtype_data {
>> -	u8 prescale_max;
>> +	bool prescale_err : 1;
>>   };
>>
>>   struct lpspi_config {
>> @@ -144,13 +144,16 @@ struct fsl_lpspi_data {
>>   /*
>>    * ERR051608 fixed or not:
>>    * https://www.nxp.com/docs/en/errata/i.MX93_1P87f.pdf
>> + *
>> + * Devices with ERR051608 have a max TCR_PRESCALE value of 1, otherwise the full
>> + * 3 bits are available (0-7).
>>    */
>>   static const struct fsl_lpspi_devtype_data imx93_lpspi_devtype_data = {
>> -	.prescale_max = 1,
>> +	.prescale_err = true,
> 
> I think prescale_max is good and clear enough, you can treat 0 as no
> limit for prescale.
> 
> Frank

Ack

>>   };
>>
>>   static const struct fsl_lpspi_devtype_data imx7ulp_lpspi_devtype_data = {
>> -	.prescale_max = 7,
>> +	.prescale_err = false,
>>   };
>>
>>   static const struct of_device_id fsl_lpspi_dt_ids[] = {
>> @@ -329,12 +332,11 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data *fsl_lpspi)
>>   {
>>   	struct lpspi_config config = fsl_lpspi->config;
>>   	unsigned int perclk_rate, div;
>> -	u8 prescale_max;
>> +	u8 prescale_max = fsl_lpspi->devtype_data->prescale_err ? 1 : 7;
>>   	u8 prescale;
>>   	int scldiv;
>>
>>   	perclk_rate = clk_get_rate(fsl_lpspi->clk_per);
>> -	prescale_max = fsl_lpspi->devtype_data->prescale_max;
>>
>>   	if (!config.speed_hz) {
>>   		dev_err(fsl_lpspi->dev,
>>
>> --
>> 2.34.1
>>


