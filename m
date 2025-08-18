Return-Path: <linux-kernel+bounces-772932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC5EB29980
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F11483AD5A9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988762737F6;
	Mon, 18 Aug 2025 06:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R55iCj8P"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D4C272E6A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755497674; cv=none; b=cUImYQ8rtyivCpREZXctWjMFF4RUmo+zRt0VbKTzAZ6NImynArYaU2eIoxGBuMJLANrsC3lfe78GhmDDlEHzGEZSYkjqG4Q8WKS6ZrhuE7k4tgHSeCrnMe37Rs510pO6XmiEG5dOJNU4TsQAjg+K9oQr2MkVtcrrS/9LI5qORZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755497674; c=relaxed/simple;
	bh=b9af0JOkk3qCsNlz3GAfeWhsFnruqX66qp60DveQtB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fXAzLqjkfW6AGTzfZVy8B85piSvpmxLqG+atOTkVXM/uYVNx7yvq32AEBc5UFHz14RrfurVhdNmU095/RbH58L15At/OLNxktMpq2+Hfwm4xUZc+ZvIhWNs3p/AkSVShmxCLA0M2MtlzhDUs+ysp/zljXKap2IxzbON1zJX7PWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R55iCj8P; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I0Tqp7018175
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:14:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wzuB+yfYTi8NabTXC8LU3lRMaFxlb+s9tmJJs7u++Y8=; b=R55iCj8PdUBLmAL6
	rB6tlNwvLf539S3tLlZ6yJvgahID3eSDs4UTuhaHn/gcvNF82Xr3RBdOmtRiGFhr
	6hqIBmDjuG23qWiH5jPBLqCvvMH5mMpXP518s/mCYgifMNIDBHyEDY6ZRVLiwxxo
	hbu8tKLXBrUW7wZ1Fe9CwXYWBhllr6LYvlyiWqh41m9W9t7HPWQdtm+qorJKDn8a
	c81bIxofaOmMR21d1A6FOfOh5LYjQ0uV7yUNSMomZRSqHBpjOOIp3my6i+jZUV6G
	DhC0WxGhui4YPLch1jPXftPZfjQm98QTDQhlnNC3n+aQW/oipOvDbfztudH7Ob8o
	XRNkVA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jj743fcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:14:32 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70a88dd1408so87899416d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 23:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755497671; x=1756102471;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wzuB+yfYTi8NabTXC8LU3lRMaFxlb+s9tmJJs7u++Y8=;
        b=DWx+HANk9EZGcKK8xAmd9vs4NOmHPYCPF48f8we3CEGKyww18Udb0gDNmkyjUxniRF
         jlVeR8KZHMAL1YPvxgANch8B3yJzJMGSf2xy8VHrh/v44Br2TlumOh5HX/yh2Z3fScqY
         PWI1nzQv1dVg1eneUiYlYj6ytVhPDbM4b3F076XmrApl5MT4DrUQEwubLXJQ8ItNHlox
         dk8wuEaySLqF5xOSMcYNPALV8qO7KI4YQu9IvFAoi9yWtd89U6fLo2ps7WaZy7CuU7PC
         7AuJzoyXSsym1liduBiWaexOMJqPZSn8UeDJ7ii/UHMQINn5eAdVFHBcGfr1hpcLMxRD
         cDVw==
X-Forwarded-Encrypted: i=1; AJvYcCWEshhjHZARQfrCiqBFnUmS/wjwz0JD6U5iXbA2ahNA82g8HUn/MEyuPvz++4jJueQxMAGoj/eBzXav3x4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoq+227wmVIep2ydIam6Z0tKQPLWzjegHeazIEXmfNG8bC6z3U
	glhsNE46oFegLg2KSBC/agawn+co0wH5OJfXqN7COKcpihjhsQ4BJ1RqCj3lVZHJE/sOpXdZRdH
	DCNx0gAto9Q++ZFpV6PrzEchlAv8Mv5Icm7P9jvZhrBLayLAqYSr0wAtmWwq19GC1lFU=
X-Gm-Gg: ASbGncuGDWSs/VCTKyyLQzcvUkuoFSfFZ57ZmYCd39VXc4IWz8j2WBEqt0q0ONipIu9
	5mHzK4ODUboe6OkO39bKPEah3veLqZLHSugYTvx36bQgf6EfuTk+miBxgk8fewhVErOc9qUMO9P
	2dfPah3kAIYhtMv9OnwEwJ6UybXHw9+dYCp1PLggQx7FjbosWhNO6LLFirYXTMm9K5NqYYPPTO/
	kOyY8bqd0puyFq1Bcn/+X3ACmGF6EHD/96XRVm2p/e8nKL1fucef2QTIdrmx6rsXy+5k+PAY5pe
	OXKiPIetpDqeEAyF7kNZHaZDxlzdBFRkNBR6QIAI6ANQmpU75iYYm8KRs+w5APKzd0s=
X-Received: by 2002:a05:6214:268d:b0:709:7e2e:646e with SMTP id 6a1803df08f44-70ba7aac450mr169979326d6.16.1755497671012;
        Sun, 17 Aug 2025 23:14:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFt/A/2HlQJpAZauyOKwbvMLnEHhxmdbD3mg22b9mV8n2s7/74fr1dltPVGUwmpFKeXxzIQFw==
X-Received: by 2002:a05:6214:268d:b0:709:7e2e:646e with SMTP id 6a1803df08f44-70ba7aac450mr169978966d6.16.1755497670527;
        Sun, 17 Aug 2025 23:14:30 -0700 (PDT)
Received: from [192.168.68.118] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3bb67d86755sm11364274f8f.48.2025.08.17.23.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Aug 2025 23:14:29 -0700 (PDT)
Message-ID: <321dc1ac-1837-4d49-bb7c-7da49316b208@oss.qualcomm.com>
Date: Mon, 18 Aug 2025 07:14:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] ASoC: codecs: wsa883x: Handle shared reset GPIO
 for WSA883x speakers
To: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, kernel@oss.qualcomm.com,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>
References: <20250815172353.2430981-1-mohammad.rafi.shaik@oss.qualcomm.com>
 <20250815172353.2430981-3-mohammad.rafi.shaik@oss.qualcomm.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20250815172353.2430981-3-mohammad.rafi.shaik@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: eLD0L3OchxYVbstxvFrBWF_Y5GXO-MwN
X-Proofpoint-ORIG-GUID: eLD0L3OchxYVbstxvFrBWF_Y5GXO-MwN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMyBTYWx0ZWRfXynIPMUuOQXs/
 HtZdNyCe39EKT0YgRjxC7j/3CxsnA+B51iQYJthorwX7Zf/HFFv0cGr6O5FgK47IFdAHWPLZe1N
 gMxCgdYiuJ/bHqPva+GtT+2KH30lBXGWCkjteGT4JBn3Xr5Cwb6FAt9S7wsroRWVG4XaHAWX/t9
 fje/FV2mfL2A+I8k1/c9NMhDH0swgSDtFUL+RysGJRPgxgZ1Nmm7CEEPZ014t6xeg40DzgesaNv
 +r8Hw5teDEMX394Vb3khcaIPgDGf671vcWJdAY9/wdfWC55zhb3chQSgXDdZr//BfTkFyqkQJdj
 DZXr8xcut/w8MTQ7KXYkovsZTDas9vkkCbesv1+37uNCMGeLN8G15GVoRC+bnet8B1dqBTBDyYV
 /bHR+Tu6
X-Authority-Analysis: v=2.4 cv=MJtgmNZl c=1 sm=1 tr=0 ts=68a2c4c8 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=GII5O7IxXX2w1O2W61QA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160033

On 8/15/25 6:23 PM, Mohammad Rafi Shaik wrote:
> From: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> 
> On some Qualcomm platforms such as QCS6490-RB3Gen2, the multiple
> WSA8830/WSA8835 speaker amplifiers share a common reset (shutdown) GPIO.
> 
> To handle such scenario, use the reset controller framework and its
> "reset-gpio" driver to handle such case. This allows proper handling
> of all WSA883x speaker amplifiers on QCS6490-RB3Gen2 board.
> 
> Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> ---

lgtm,

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

--srini

>  sound/soc/codecs/wsa883x.c | 57 ++++++++++++++++++++++++++++++++------
>  1 file changed, 49 insertions(+), 8 deletions(-)
> 
> diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
> index 188363b03b93..ca4520ade79a 100644
> --- a/sound/soc/codecs/wsa883x.c
> +++ b/sound/soc/codecs/wsa883x.c
> @@ -14,6 +14,7 @@
>  #include <linux/printk.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/reset.h>
>  #include <linux/slab.h>
>  #include <linux/soundwire/sdw.h>
>  #include <linux/soundwire/sdw_registers.h>
> @@ -468,6 +469,7 @@ struct wsa883x_priv {
>  	struct sdw_stream_runtime *sruntime;
>  	struct sdw_port_config port_config[WSA883X_MAX_SWR_PORTS];
>  	struct gpio_desc *sd_n;
> +	struct reset_control *sd_reset;
>  	bool port_prepared[WSA883X_MAX_SWR_PORTS];
>  	bool port_enable[WSA883X_MAX_SWR_PORTS];
>  	int active_ports;
> @@ -1546,6 +1548,46 @@ static const struct hwmon_chip_info wsa883x_hwmon_chip_info = {
>  	.info	= wsa883x_hwmon_info,
>  };
>  
> +static void wsa883x_reset_assert(void *data)
> +{
> +	struct wsa883x_priv *wsa883x = data;
> +
> +	if (wsa883x->sd_reset)
> +		reset_control_assert(wsa883x->sd_reset);
> +	else
> +		gpiod_direction_output(wsa883x->sd_n, 1);
> +}
> +
> +static void wsa883x_reset_deassert(struct wsa883x_priv *wsa883x)
> +{
> +	if (wsa883x->sd_reset)
> +		reset_control_deassert(wsa883x->sd_reset);
> +	else
> +		gpiod_direction_output(wsa883x->sd_n, 0);
> +}
> +
> +static int wsa883x_get_reset(struct device *dev, struct wsa883x_priv *wsa883x)
> +{
> +	wsa883x->sd_reset = devm_reset_control_get_optional_shared(dev, NULL);
> +	if (IS_ERR(wsa883x->sd_reset))
> +		return dev_err_probe(dev, PTR_ERR(wsa883x->sd_reset),
> +				     "Failed to get reset\n");
> +	/*
> +	 * if sd_reset: NULL, so use the backwards compatible way for powerdown-gpios,
> +	 * which does not handle sharing GPIO properly.
> +	 */
> +	if (!wsa883x->sd_reset) {
> +		wsa883x->sd_n = devm_gpiod_get_optional(dev, "powerdown",
> +							GPIOD_FLAGS_BIT_NONEXCLUSIVE |
> +							GPIOD_OUT_HIGH);
> +		if (IS_ERR(wsa883x->sd_n))
> +			return dev_err_probe(dev, PTR_ERR(wsa883x->sd_n),
> +					     "Shutdown Control GPIO not found\n");
> +	}
> +
> +	return 0;
> +}
> +
>  static int wsa883x_probe(struct sdw_slave *pdev,
>  			 const struct sdw_device_id *id)
>  {
> @@ -1566,13 +1608,9 @@ static int wsa883x_probe(struct sdw_slave *pdev,
>  	if (ret)
>  		return dev_err_probe(dev, ret, "Failed to enable vdd regulator\n");
>  
> -	wsa883x->sd_n = devm_gpiod_get_optional(dev, "powerdown",
> -						GPIOD_FLAGS_BIT_NONEXCLUSIVE | GPIOD_OUT_HIGH);
> -	if (IS_ERR(wsa883x->sd_n)) {
> -		ret = dev_err_probe(dev, PTR_ERR(wsa883x->sd_n),
> -				    "Shutdown Control GPIO not found\n");
> +	ret = wsa883x_get_reset(dev, wsa883x);
> +	if (ret)
>  		goto err;
> -	}
>  
>  	dev_set_drvdata(dev, wsa883x);
>  	wsa883x->slave = pdev;
> @@ -1595,11 +1633,14 @@ static int wsa883x_probe(struct sdw_slave *pdev,
>  	pdev->prop.simple_clk_stop_capable = true;
>  	pdev->prop.sink_dpn_prop = wsa_sink_dpn_prop;
>  	pdev->prop.scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
> -	gpiod_direction_output(wsa883x->sd_n, 0);
> +
> +	wsa883x_reset_deassert(wsa883x);
> +	ret = devm_add_action_or_reset(dev, wsa883x_reset_assert, wsa883x);
> +	if (ret)
> +		return ret;
>  
>  	wsa883x->regmap = devm_regmap_init_sdw(pdev, &wsa883x_regmap_config);
>  	if (IS_ERR(wsa883x->regmap)) {
> -		gpiod_direction_output(wsa883x->sd_n, 1);
>  		ret = dev_err_probe(dev, PTR_ERR(wsa883x->regmap),
>  				    "regmap_init failed\n");
>  		goto err;


