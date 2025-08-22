Return-Path: <linux-kernel+bounces-781762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B24B3166E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C11FB7AD435
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3616C2FABF2;
	Fri, 22 Aug 2025 11:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qx9WY6/F"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AA22FABE5
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755862375; cv=none; b=QQGfN+dLuBL4h9NZVlvBHdYKHhonp4y6k1Kj7p80kOsMZXy0t1ccJA2rlGgxYqdCcUGPJiS249CtFSD1NBLJISMoqcZ4/+sOrVeJrvo/+cacXl9jjycGXYwv2aJpN15mJ+wmx//x5TMzlgrKlZw4b9QEWMJFzES5BckYi1uEPQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755862375; c=relaxed/simple;
	bh=MbeLJ7GhzWYYPAdLWZcANylSjO7QkTw3HNqWV+nnRtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBvlz1yJQgu3XJXp9zwuDSNnmLEHe9RPGCjwoGz61Q6hdG82HhWeT5bDc/jjmk0E+Vv3hvTnhzjcQ7m7BDFnaj5whjUdneYpQ5LFjFpMXvZJZIR2u0vGNSgVoTq3Q/G+aQnOw/NF9JuRzn4d3gDKbv4bgG3Af4rz9AAaDO2BPBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qx9WY6/F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UdtO025041
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:32:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hrhxs/e4R9oX+Zmf2Gb0jkfc
	weHfmbU1GnT4MRTHzDA=; b=Qx9WY6/FcSoUrG8bv/KEZuomjvzNDSeK9dMGlMhv
	Ql/oWRuPU6lw1yu4YDaJbDLEZx7s3CK69m3DzWM9VMnxllDyaRqzFETLNW/sV8tB
	FDt7tlhQZwMJrHs41UCGF09mnsFV9dkXtmC7/Mo57/xkjsCNC2hydsmAOF3l5Owc
	6hVVRokWqww7DjbYsfZ+KWlu11JPfb5NI8F2WvmudhINkUeDEsEqALz+ksjTIXeL
	zD951kzedtFa9nibjXklSBmshqi2b1gS+IzVW7kP4orxpLWFyZ+2UG4iNSxTq5gL
	Vvm1MtMpmMomxdMwft5DXLywg9JsUY4UXm8xxsNWiXXVow==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52ah3j5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:32:53 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70d7c7e972fso25809866d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 04:32:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755862372; x=1756467172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrhxs/e4R9oX+Zmf2Gb0jkfcweHfmbU1GnT4MRTHzDA=;
        b=npeA05WC3nQR1bCgkvjD8YY1kHPC6D7Vdqp1GZjDTpBfh56LTCeHEJ/CVco1dlxS+g
         DyOa9IikJuOQX52t+PluuMqPjVh/lGUFQY4MSBFgkZK+I8/EQHsHGY2L6ywwduzpBCOE
         HObyLsTK1m0ZY/gTJFlijXPCYw3UFqBaxG0Rc4woOR61PWBsI0cPe9DveiZaHyLnwVUu
         aF5MkKxMJsfQtAEpLyzpqLkiW+j8Pp2c+HuA1vTL6VK++fQfEf7UiZQXtvjxWelKBtp/
         OwqEDkTH0izZm6tDBmQUQ0jI1NvtibA+9cB6iE8On5CRzXTiLHfxBELTKMeel8kWGXuA
         OZfA==
X-Forwarded-Encrypted: i=1; AJvYcCUkES1KgqEahisSQ6665g2uH2rdyO032saUg9+V/dLSU1eDLb7+KcdxW32ne+f5cT/1BKOX/7nRHzZTiZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6aaq2SjOkgm1ZoG1FXrtPhD7OcNRfRVG3DbBKcIt5gEulAEpe
	dDO7TvTSFGw53zkQDedGlQpLN04OuPpREwTWha67wBEfgH9jDFAAcbTUpuzurWmK7dmm1xIvZIs
	0UBG7bQR5CEQeDpOqKBL3P3zZotKu+imOcmLYZt/cX11k9AQbspU31WThH8IXX3TEBWA=
X-Gm-Gg: ASbGncsH+essmcbqbf9nk6GDK9swE0YDU0ggOZRSfgGXmRTYk+FWjQRgNlN0CdCkBWB
	H3RUchxdS9xC30GBroW/ULUm4b66D5OjQqbupZWlWZOSTBUm/rLUjbWr5QP/Gy/yEABCt4v3Lh0
	c+t6A9Zypl3d/li5gr/L3emNZWsXgEPdteqqSqc5u2n8LOli4vdO9QOkwdoRZYlNsvT9JCq6K3w
	2TGUUW2kYv2/or3+IzKsuVPrcULvXNQHwPPUyt8UVwIe/LRsioG2RaXdBGvbNJAPBr3db9ZWefZ
	4nw6Ad/o45bzW8XOx2gEsFq5h65hvWiA5gpmKZL4Xeiy5PHO+/ZA/P5Q6OT47S5poSC1oO5HJOv
	dt10KccXlGczCRidu9DN9pieGGAUMyRj0aFIlb3snDboj+mVigNUK
X-Received: by 2002:ad4:5b87:0:b0:709:f553:f707 with SMTP id 6a1803df08f44-70d972c25f1mr33591286d6.19.1755862371612;
        Fri, 22 Aug 2025 04:32:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXQAzyXjd3aFI95Ax/cuAFmfG034WYhExtNbk9ibR6IrU4TuKhnCk3Qmr/TKCz6E53o1TsvA==
X-Received: by 2002:ad4:5b87:0:b0:709:f553:f707 with SMTP id 6a1803df08f44-70d972c25f1mr33590746d6.19.1755862370948;
        Fri, 22 Aug 2025 04:32:50 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55e084e46b7sm1165666e87.48.2025.08.22.04.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 04:32:50 -0700 (PDT)
Date: Fri, 22 Aug 2025 14:32:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        lgirdwood@gmail.com, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        krzysztof.kozlowski@linaro.org, neil.armstrong@linaro.org
Subject: Re: [PATCH v2 6/8] ASoC: codecs: wcd-common: move status_update
 callback to common
Message-ID: <ld3s5vbjjigkbesnyccyxohnekgbwkbae7zwmjd7u23km3f5fq@awxsaee7yj6m>
References: <20250822104927.2621866-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250822104927.2621866-7-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822104927.2621866-7-srinivas.kandagatla@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: irPFsAUSQnpz9lzsTkQp_CF_KjCz5qeU
X-Authority-Analysis: v=2.4 cv=B83gEOtM c=1 sm=1 tr=0 ts=68a85565 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=sWKEhP36mHoA:10 a=EUspDBNiAAAA:8 a=5fLxXxe7Dn6VKq7M814A:9
 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: irPFsAUSQnpz9lzsTkQp_CF_KjCz5qeU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX5f3csxvidP3y
 W+5cTMzo3UjVTeOMnG4ttuQE/u5+LLMHy/I2PASJmHMlKvD/PwErjFLtqrvjQyz8wlv36cOWVSV
 FSAN4jTP6jveQSMVYFEC2z/eJnJjjd2uPH4gXMnwRj09CzceTAtkDJKsHNeQkNCYuyHW41an66B
 1uH1Eo0Bfeo1X1XicJYmyPuTt7L4dDyM/1h2OBqAafyUefLMOBiOJMao3AH6XeuMy92LFeRzgSg
 OoXfF32TUMJmMewqXeDb1qK/bOfQJvzFNwMbtazzF543KIN9qaUg666wW59GrbdaHViPSe95IIu
 fmj0L2fHJ27mGT9sJ5FkvmY1hD000aeM4I6tVhaQROyF1vhOKYwmZE+EBHa6EbiMvdU3eirGWSG
 +JZbexjIh5ACOon46GjwKuRi8NVFZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Fri, Aug 22, 2025 at 11:49:25AM +0100, Srinivas Kandagatla wrote:
> Soundwire update_status, bus_config and interrupt callbacks for wcd937x,
> wcd938x, wcd939x soundwire codecs are exactly identlical, move them to
> common driver to remove this duplicate code.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>  sound/soc/codecs/wcd-common.c  | 46 ++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/wcd-common.h  | 10 ++++++++
>  sound/soc/codecs/wcd937x-sdw.c | 28 +++------------------
>  sound/soc/codecs/wcd938x-sdw.c | 41 +++---------------------------
>  sound/soc/codecs/wcd939x-sdw.c | 42 +++----------------------------
>  5 files changed, 67 insertions(+), 100 deletions(-)
> 
> diff --git a/sound/soc/codecs/wcd-common.c b/sound/soc/codecs/wcd-common.c
> index 0c1ffa015403..2592e8ed2d13 100644
> --- a/sound/soc/codecs/wcd-common.c
> +++ b/sound/soc/codecs/wcd-common.c
> @@ -9,9 +9,14 @@
>  #include <linux/printk.h>
>  #include <linux/component.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/soundwire/sdw.h>
> +#include <linux/soundwire/sdw_type.h>
> +#include <linux/regmap.h>
>  
>  #include "wcd-common.h"
>  
> +#define SWRS_SCP_HOST_CLK_DIV2_CTL_BANK(m) (0xE0 + 0x10 * (m))
> +
>  int wcd_get_micb_vout_ctl_val(struct device *dev, u32 micb_mv)
>  {
>  	/* min micbias voltage is 1V and maximum is 2.85V */
> @@ -89,5 +94,46 @@ const struct component_ops wcd_sdw_component_ops = {
>  };
>  EXPORT_SYMBOL_GPL(wcd_sdw_component_ops);
>  
> +int wcd_update_status(struct sdw_slave *slave, enum sdw_slave_status status)
> +{
> +	struct regmap *regmap = dev_get_regmap(&slave->dev, NULL);
> +
> +	if (regmap && status == SDW_SLAVE_ATTACHED) {
> +		/* Write out any cached changes that happened between probe and attach */
> +		regcache_cache_only(regmap, false);
> +		return regcache_sync(regmap);
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(wcd_update_status);
> +
> +int wcd_bus_config(struct sdw_slave *slave, struct sdw_bus_params *params)
> +{
> +	sdw_write(slave, SWRS_SCP_HOST_CLK_DIV2_CTL_BANK(params->next_bank), 0x01);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(wcd_bus_config);
> +
> +int wcd_interrupt_callback(struct sdw_slave *slave, struct irq_domain *slave_irq,
> +		unsigned int wcd_intr_status0, unsigned int wcd_intr_status1,
> +		unsigned int wcd_intr_status2)
> +{
> +	struct regmap *regmap = dev_get_regmap(&slave->dev, NULL);
> +	u32 sts1, sts2, sts3;
> +
> +	do {
> +		handle_nested_irq(irq_find_mapping(slave_irq, 0));
> +		regmap_read(regmap, wcd_intr_status0, &sts1);
> +		regmap_read(regmap, wcd_intr_status1, &sts2);
> +		regmap_read(regmap, wcd_intr_status2, &sts3);
> +
> +	} while (sts1 || sts2 || sts3);
> +
> +	return IRQ_HANDLED;
> +}
> +EXPORT_SYMBOL_GPL(wcd_interrupt_callback);
> +
>  MODULE_DESCRIPTION("Common Qualcomm WCD Codec helpers driver");
>  MODULE_LICENSE("GPL");
> diff --git a/sound/soc/codecs/wcd-common.h b/sound/soc/codecs/wcd-common.h
> index deb78241236b..0cb6365bea4b 100644
> --- a/sound/soc/codecs/wcd-common.h
> +++ b/sound/soc/codecs/wcd-common.h
> @@ -6,11 +6,16 @@
>  #ifndef __WCD_COMMON_H__
>  #define __WCD_COMMON_H___
>  
> +#include <linux/device.h>
> +#include <linux/soundwire/sdw.h>

Just forward-declare structures, there is no need for includes.

> +
>  #define WCD_MIN_MICBIAS_MV	1000
>  #define WCD_DEF_MICBIAS_MV	1800
>  #define WCD_MAX_MICBIAS_MV	2850
>  #define WCD_MAX_MICBIAS		4
>  
> +
> +

Extra empty lines.

>  struct wcd_sdw_ch_info {
>  	int port_num;
>  	unsigned int ch_mask;
> @@ -32,5 +37,10 @@ struct wcd_common {
>  extern const struct component_ops wcd_sdw_component_ops;
>  int wcd_get_micb_vout_ctl_val(struct device *dev, u32 micb_mv);
>  int wcd_dt_parse_micbias_info(struct wcd_common *common);
> +int wcd_update_status(struct sdw_slave *slave, enum sdw_slave_status status);
> +int wcd_bus_config(struct sdw_slave *slave, struct sdw_bus_params *params);
> +int wcd_interrupt_callback(struct sdw_slave *slave, struct irq_domain *slave_irq,
> +		unsigned int wcd_intr_status0, unsigned int wcd_intr_status1,
> +		unsigned int wcd_intr_status2);
>  
>  #endif /* __WCD_COMMON_H___  */

-- 
With best wishes
Dmitry

