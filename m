Return-Path: <linux-kernel+bounces-877970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18353C1F774
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A82A74036CE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31EA34F254;
	Thu, 30 Oct 2025 10:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gLnFPXdS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IYoZ1UPv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C3E41C69
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761819038; cv=none; b=RXvTtzIF6PnPrA4nZJgoYEBbCaVrkenB3M+U8+11+VWwjq3/UpemaDbjePEqEI1MLkQ32k6xuXs4doV+33+1KBLQZIjDMhFM4Uu3RBPCI36KcdCnIxymtxNBuwRs7axhlxmKimHANHoEYyzNVyJZ8xQabRoXZY3wwx0Ia3mUAhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761819038; c=relaxed/simple;
	bh=gjnSCp4ErGtgQj+kyj3ZUfn8tTM3HyOSMBbh/HFVyZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OYhQzRq3p/mKRf7sKIXa1YsrdSzjmYr2ww+CA0Iflc+c0ds+eriM8X+xHH/O2VC4pt8lsdF81j3wRfDbP0rnHrSlpaaOHGqO+zgQssicxgGfvX9D3trDxLfUFiSaiP0VvbggW0xUs42froh4v9FDFKr9pKX00XnCraF3t7audms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gLnFPXdS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IYoZ1UPv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U7SXI01656060
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:10:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1Tk2wViz0AltOKov0bmJb8BdIdTqWdxh4mEaQnxEC6I=; b=gLnFPXdSWwkwwiQX
	ITzByOKkfCISwdeJRVCp3CqTB6wV7P0TZ/xFIVSjGCLktLBzEbyHaLzcDB7Scw69
	I8qck80SIUpsPYw27yfeVdq1Qvjajye/r9vOIT0OOoHlkAw4eqtlk6ZILBq6orW7
	ugHFPpdjKGS7bcKm0BL28Yj7A5sOcBsyrxFjrNQae+wQxXEZxJ4mKyfrRpIC93ZS
	+pm1FgDfXCVUSXH+z6iOeuM99Or9y2uHXZq5FiBsYl+OlIkS3FNOV0NghRAIWH2J
	XgjmE1MZD5EdcGh8EhYWQ35rbCSy+RP0K2ZWiQqzhVp0jXwFNThY2Dcf6nMidcBz
	NFAfWQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3tptsxa9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:10:34 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4eb9f5d6a75so1354781cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 03:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761819034; x=1762423834; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Tk2wViz0AltOKov0bmJb8BdIdTqWdxh4mEaQnxEC6I=;
        b=IYoZ1UPvcPSIK0l5xFy1EldVvi3Cb+8CCr42sav769vB2aFegLRavEROCxfxOZymQL
         2c5YqX3THD+CSBtxqxfPWZCNnhQbLFzJ6O6csPDzPdpFIo1TfeQ/b0qeHAj4tnz3SWk9
         Umamto7RlheK/5NM1PfJMbX5p8/8Vn9LLxoLZNSfoIYg4MnoxHmRB7yIR3EQBsmOq0Rk
         g55uZ82tan6ynh4DpFR1NYjv+EHAhZtwab7fVqIMpguS2AaGOCmovIGVdHqYU2b+0U7g
         vfEGIiUGg94xV9+7p0ZMSqf63LQuRdhekgw/fCzYMTcvHYkQDwf+WxcQuw6X8pdcevr6
         XRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761819034; x=1762423834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Tk2wViz0AltOKov0bmJb8BdIdTqWdxh4mEaQnxEC6I=;
        b=gGljGUtjeFE1+xnTm9NfJZNi8ZtKK44/eT8N/vDgKd5bzxplnW64v0MirmSBDguLBE
         YYxYBJvI3jm18lWeAD2gNprFfBX+SrwpMy6PBvEfmyPzto/zBXvkFXcroNqbhn7ofbkG
         XNZa+8Deuo3ql87dBFRV/oN0Abs2JvB1Rk9rz2D4mfo02xMotRscEm5pRfkoTInckuw3
         GSE/ehsN4e6Mnd4hZPNoIqDG6JTRJiMKIlDzJIoN4t+lsdkbBCd12M+RJIZ3MBywlNZ7
         Deo4E63Q4KvhOIdmvGA+A20SF+TByQttnS/l9rJihpQKhBYkI4EZiW1rU32IRHK6AY4c
         sJgg==
X-Forwarded-Encrypted: i=1; AJvYcCVEmx7y/pfE2svFQk7WkPvcjqkPe0lsMGtNZOibhs/e3vo1abryT5PIBKoJkcAU5eBv2YevmOR+QIqXEdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnep1lBW7II5Idx6eF2g0+TPNWOZiQ7F1oNlADJFtw9UfXz0oz
	PMNg1n7V19+636ZJ/15iUmYEHzui55wn3U2R65nL/aN1m5iUx69kJge7RpGc+rIqfyC0Avy/lvM
	WP15IVQ+k9L/Jonu75xyw4lF/YxhZ1eQQf3y6zQQZ/HIC3u266LQ4ZbhwDd6aV38PzC0=
X-Gm-Gg: ASbGncuJUn+tNRgVGiMZTozU8zyIWq1Kzlymr+5AwwSWoWCz+1ZPLnixlXgT8GQUDHx
	spUShpxPNXGnOVyUNUOOElUMwbhNh5IfYfoMyqyNix9ojDpp4MuceypqjVkMJIvyjRBvbA80ruR
	lZ5thK1QaiPYqDeYu1P0OKD6Liq9lT6jiYzkEun6RTiw0nva4c4leDJhid0BKXb5eeuavrG/HcD
	6k1pdWm0FgDafiwvyYtSzaa1JzBPch1fFSxf4v8guP1F8LxpAlPVDneB21xndvf9r671fxlsm0q
	4mavZhYwExzPC/ddH7pmQWX6grR/tYaLkV39yfLsh0CjWzxdPkZ53WSjna2oueCrI3KNKHNNPd3
	RM+uNU80/B+66uqM4yTVDMR5NbIWNlJVksi9GC9PzcOlH8FWQUdUS0AsF
X-Received: by 2002:a05:622a:155:b0:4ec:f7e4:8a0e with SMTP id d75a77b69052e-4ed15c06266mr55893341cf.9.1761819033573;
        Thu, 30 Oct 2025 03:10:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELF81IfIckZ963pva8kKMpBiIb1HN/EuzgABEmtwD7DsEXTHRgYJQc5q52Dl9jk2M9977eNw==
X-Received: by 2002:a05:622a:155:b0:4ec:f7e4:8a0e with SMTP id d75a77b69052e-4ed15c06266mr55893041cf.9.1761819033073;
        Thu, 30 Oct 2025 03:10:33 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64061a5b7b5sm1874821a12.1.2025.10.30.03.10.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 03:10:32 -0700 (PDT)
Message-ID: <6d6f3981-af6b-4fb6-a379-dc72d08363d7@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 11:10:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: qcom: hamoa-iot-evk: enable pwm rg leds
To: Tingguo Cheng <tingguoc@hu-tingguoc-lv.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Tingguo Cheng <tingguo.cheng@oss.qualcomm.com>, kernel@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Fenglin Wu <fenglin.wu@oss.qualcomm.com>
References: <y>
 <20251030-add-rgb-led-for-hamoa-iot-evk-v2-1-3b3326784d7b@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251030-add-rgb-led-for-hamoa-iot-evk-v2-1-3b3326784d7b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA4MiBTYWx0ZWRfXwxa+7dMmHNgd
 ypWongsJo0id9u08At0rVn1a8edvTTMTOrSazR7auLDr7Fxz8C867YltzixZiEj3pHl2niSS6Jc
 tYeTIwCG3sVRyvP6IY3kidth8x+gF1FFxtvdmSn6pN9Fp66Yl5pVcpURNCS6ulkOc8ZBFmBuf7Z
 WXLjeul0Bcwv2/lUTxZpyWY6gWTKR+1OsyXK1grLToVx89nqsn/AeOiwfCMba7VK8suSUKhB2NS
 jeaczOcFDB0eI2UzoBSiHwdctiLUIziDA1fbXQUkb81QsivPQu3izq7w7+2lrgnVoQWWn+XApRv
 nLvQWt3WIeLyG48MznaUURLVpG7LsUt6ChD4XQ6ZuXPsF5pkotwkRau6UdgndUaXY+oW7+U5KGD
 5E56tCTWPGxlmPdyPOV1h4MQVaAdZw==
X-Proofpoint-GUID: PzFm-HYxyz6_eHMzH8vDR3RjK194UHmU
X-Authority-Analysis: v=2.4 cv=MuRfKmae c=1 sm=1 tr=0 ts=6903399a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=2cCYZ7mipiWG3OMYrP4A:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: PzFm-HYxyz6_eHMzH8vDR3RjK194UHmU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300082

On 10/30/25 8:42 AM, 'Tingguo Cheng' via kernel wrote:
> From: Tingguo Cheng <tingguo.cheng@oss.qualcomm.com>
> 
> Add RED and GREEN LED channels for the RGB device connected to PMC8380C
> PWM-LED pins. Omit BLUE channel to match default hardware setup where
> it's tied to EDL indicator.
> 
> Signed-off-by: Tingguo Cheng <tingguo.cheng@oss.qualcomm.com>
> ---
> Changes in v2:
> - Rebased on next-20251030.
> - Remove BLUE led channel to align with the default hardware configuration.
> - Link to v1: https://lore.kernel.org/r/20251017-add-rgb-led-for-hamoa-iot-evk-v1-1-6df8c109da57@oss.qualcomm.com
> ---
>  arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> index 36dd6599402b4650b7f8ad2c0cd22212116a25fe..ef59e5ff59f2cbe0ee60a020a5d2929c67ad511b 100644
> --- a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> @@ -5,6 +5,7 @@
>  
>  /dts-v1/;
>  
> +#include <dt-bindings/leds/common.h>
>  #include "hamoa-iot-som.dtsi"
>  
>  / {
> @@ -879,6 +880,28 @@ usb0_1p8_reg_en: usb0-1p8-reg-en-state {
>  	};
>  };
>  
> +&pm8550_pwm {
> +	status = "okay";
> +
> +	multi-led {
> +		color = <LED_COLOR_ID_RGB>;

This should be LED_COLOR_ID_MULTI (RGB suggests all three R/G/B
channels are accessible)

Please try the attached patch.

Konrad

From a13436fc3ee649b40efa8d0f21467b8534d7ebe2 Mon Sep 17 00:00:00 2001
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 11:08:44 +0100
Subject: [PATCH] leds: rgb: leds-qcom-lpg: Allow LED_COLOR_ID_MULTI

There's nothing special about RGB multi-led instances. Allow any color
combinations by simply extending the "if _RGB" checks.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 4f2a178e3d26..c8afc68e442f 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -1382,7 +1382,7 @@ static int lpg_add_led(struct lpg *lpg, struct device_node *np)
 		return dev_err_probe(lpg->dev, ret,
 			      "failed to parse \"color\" of %pOF\n", np);
 
-	if (color == LED_COLOR_ID_RGB)
+	if (color == LED_COLOR_ID_RGB || color == LED_COLOR_ID_MULTI)
 		num_channels = of_get_available_child_count(np);
 	else
 		num_channels = 1;
@@ -1394,7 +1394,7 @@ static int lpg_add_led(struct lpg *lpg, struct device_node *np)
 	led->lpg = lpg;
 	led->num_channels = num_channels;
 
-	if (color == LED_COLOR_ID_RGB) {
+	if (color == LED_COLOR_ID_RGB || color == LED_COLOR_ID_MULTI) {
 		info = devm_kcalloc(lpg->dev, num_channels, sizeof(*info), GFP_KERNEL);
 		if (!info)
 			return -ENOMEM;
@@ -1454,7 +1454,7 @@ static int lpg_add_led(struct lpg *lpg, struct device_node *np)
 
 	init_data.fwnode = of_fwnode_handle(np);
 
-	if (color == LED_COLOR_ID_RGB)
+	if (color == LED_COLOR_ID_RGB || color == LED_COLOR_ID_MULTI)
 		ret = devm_led_classdev_multicolor_register_ext(lpg->dev, &led->mcdev, &init_data);
 	else
 		ret = devm_led_classdev_register_ext(lpg->dev, &led->cdev, &init_data);
-- 
2.51.2



