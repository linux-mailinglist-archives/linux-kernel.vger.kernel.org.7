Return-Path: <linux-kernel+bounces-873421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60401C13E46
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E801E188F7B1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4B6221271;
	Tue, 28 Oct 2025 09:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iExINopB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6345B13AA2F
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761644660; cv=none; b=vA6dClb4hv1eiHyxi/sEixrp+n6ZOH5KhSN5x2Sh3BdPRx4zOu2ymb+XVSi/kwOEWtcC3cmgCPkcPcES3EpjbD+ds8cL8Gnsund6wB0soEaIyF4jXzcVd4DkgeXt9te474SAUTH90zJ6yfWGscKyRl8hctkeptxQnHupiULWrY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761644660; c=relaxed/simple;
	bh=7QdSCc3ghckTTATUxUHS06CaambC2oJeybgZ5vYyCds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hr1Tl7Hrpo5aDomZlS+fcKBgfU9VlEUvNUQL3QUmyhjR4a2Yclh3nCtzxrXXf1In17r5kEO/HJ5PZj6jkykJtJdjushN2CRiYRTBaMoEfuHTI00BjBCfnntZSiM6vF1IO199kkbJMluFH14X1c0T+nuNwNDklJFAT+4k9w9v0dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iExINopB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59S32Lmn354204
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:44:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XaeEsRLrplO4MaerwlgBvJVzq65FTCNVJ8CSSdZ4EPU=; b=iExINopBfH1xC/zj
	zi4nh4V/E/V4wImPUNlT/ZBgHgbxX8rgL9frFbQ56+TDqTqE4se8w/ymE5Vq8dv/
	l+9srRYT5tjfxU/XWEVC2ee2cXqTt4YgeVEIyaXznFXpvWRt1ULNb+GDHG6hy2fn
	TAVc3vMTCWRNqE19aDNMaidRUIKZtkf0bDx6ITkyUzIpOeR2KGQUzHbikw/MUTdY
	Mr8qs4l3Uapyr7ElB1/ZW5xDmszdyLEE8RuyXlpNVrM7/o/dcyUsmnGYnwQP5yjc
	c/HyvAn4mKVwUcG3QJEhUFM+/l/3JZSDafX46v3JSqEwDqD/XV4zaHWTOfrqXkec
	dcNl8g==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2njrs47t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:44:18 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87bb67409e1so12648336d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761644658; x=1762249458;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XaeEsRLrplO4MaerwlgBvJVzq65FTCNVJ8CSSdZ4EPU=;
        b=j6y+hOYuD/+Bs5GXAIoJqr7R1l9gbLpABuCYdg7/6uX/yNsi3b1/oZq2S/abo0efkA
         96YpNI1rr3qo0BR8G2ZajZu8Q+3glVibjtBoghum/F3gOzmf6IPCRHTDV7OqErJGPDg0
         UPxD6bGqjxr4jEwoCYuWxkk/91e4lgXIV+C3AuuNeRQ2mEZ1UsnSlUhRpq2sZMuwkpNG
         y0YX6M0LSf489fO7/CFEvKh6+PvWvl8U5+pvR+z6j9u/JbwzVWWiD92ARZ8PrIOJCDkv
         579o9VPwEtSYUS2lJdMjYG5vXOhXK4MyGg8PzpnwzXh1GOiYYgGPx/QaKskeLhmlu70z
         dxtg==
X-Forwarded-Encrypted: i=1; AJvYcCVeLu6svxiVNPTgJNb9aY6Q3yeM2Mee19Gldlb/IFhfmjPRMh3t5yJfMd5Cn3L8zlBDGnT9rwNzNWLRLpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWg+k3Q6dWe2zB8jFXPf8/j3WB8kuSx5hEXfMvex4hDEK1TX0H
	gEazB5WqgP5JNAjOdSbiBmonTOwGaq55/fYLOWFKnVoUO6dM288LON4CA6/q8LqHPWNzzBZOWVn
	RUZOB9wYngS9/5j8SmLagOdLFW6u5RdXe/B4ZOjvX7ZqMqntX/PbsZK6gAm1E3DjBGMg=
X-Gm-Gg: ASbGncv+VTNzWUBKLJ/E5HralIhSXNbO1vynVq4+Oysvqj1iAUIU76peod3PNQKcQqk
	xyY48BrO9o4SkGzEtadu6eTL1T37Xbja7TYHPtenhGOnxYbdLzcRXbL97A2Q5L+JbaV25hXA7lm
	Lhq2eUztoI1AxD+rx0VWSYMSi6UztKCU4NpaL0Jhh5ZQsVoDscde/s87n8ix//QPJj66TxDVp8M
	Zc1dPEpJ4SO1jmwqQWV6C18HwEvVP1OU2pvWjcYSZEMVwzRjqdi5hsjcIfP6gxTG7A9zUFAAYSz
	xSs4cjrwMy3A9zVEX6aHRsxy0DPpu9NZ7YrBZvzkj97BjDFrXlj9BzLtjnF6a7XzAUudb6ZSIlc
	eIOHh3s0wdlBoEd5rzXVM/IkGbYKKSJd2vdmUYmx7sYzJWRFTxoNCaulL
X-Received: by 2002:a05:6214:1c8c:b0:774:48fb:f8f2 with SMTP id 6a1803df08f44-87ffaed6fafmr22851536d6.0.1761644657678;
        Tue, 28 Oct 2025 02:44:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7Qv7PHcmjyjQmOMGkJTFeywIqgyCGA5tiYOWaXPw2UiIkmKnkUlROizozxRcfdt+yrAEQfQ==
X-Received: by 2002:a05:6214:1c8c:b0:774:48fb:f8f2 with SMTP id 6a1803df08f44-87ffaed6fafmr22851386d6.0.1761644657197;
        Tue, 28 Oct 2025 02:44:17 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef6bfd7sm8287323a12.4.2025.10.28.02.44.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 02:44:16 -0700 (PDT)
Message-ID: <7558d070-762c-4c81-aed7-1b087d131483@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 10:44:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: qcom-pm8xxx-xoadc: fix incorrect
 calibration values
To: Antony Kurniawan Soemardi <linux@smankusors.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251028-pm8xxx-xoadc-fix-v1-0-b000e1036e41@smankusors.com>
 <20251028-pm8xxx-xoadc-fix-v1-2-b000e1036e41@smankusors.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251028-pm8xxx-xoadc-fix-v1-2-b000e1036e41@smankusors.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dqvWylg4 c=1 sm=1 tr=0 ts=69009072 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=wxLWbCv9AAAA:8 a=QdeQeJuzzvJw2AYENUoA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=QJY96suAAestDpCc5Gi9:22
X-Proofpoint-GUID: A8ZQ2OxYFMm59N8F2ARc_YKoqn34WaRB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA4MiBTYWx0ZWRfX+ATFclQKByl/
 mP+UJZfiWUWkabDupBOmtMBeMZOsh9pZDTFwOg7qs4U7qaD89yM7kzDrjlXkPy1Xpyd1eqfUTGe
 MVvO+ovCH1taupCUF4ClsbyhNn/dPbO+wOvDm8l/h+7pyMMzrnUXB+EjUudOV67tEoZel6zafrN
 yZFnlwYMSnD7cLX4+04rZuQ3FlQ/t9CylcEkgpLucOpq6EAhQzO9t91+ggFTFBKx6l+esHq3Y5H
 6ghdXBrxWN+ya3Z0LxJ7aK8I57ngc6Dz7BOlWFfiikiwH/nYlWX5gHjIs7VMrqDzAcPz1DZj2ix
 bf1kXJTy+OaUI6aVXui7kJR4Q+f765B23FYJEK0oOWfRalLj3wredaLNImavPN/nSVc7aHiGjIY
 Gy9V/NAZ9lyUY7HHv93+Qpj7hL+eFg==
X-Proofpoint-ORIG-GUID: A8ZQ2OxYFMm59N8F2ARc_YKoqn34WaRB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510280082

On 10/27/25 6:29 PM, Antony Kurniawan Soemardi wrote:
> On msm8960 phones, the XOADC driver was using incorrect calibration
> values:
> absolute calibration dx = 625000 uV, dy = 4 units
> ratiometric calibration dx = 1800, dy = -29041 units
> 
> As a result, reading from the IIO bus returned unexpected results:
> in_voltage_7 (USB_VBUS): 0
> in_voltage_10 (125V): 0
> 
> The issue was caused by not setting the ratiometric scale (amux_ip_rsv)
> from the predefined channels. Additionally, the downstream code always
> set the ADC_ARB_USRP_DIG_PARAM register to PM8XXX_ADC_ARB_ANA_DIG [1].
> That value does not include the SEL_SHIFT0 and SEL_SHIFT1 bits. Enabling
> those bits caused calibration errors too, so they were removed.
> 
> With these fixes, calibration now uses the correct values:
> absolute calibration dx = 625000 uV, dy = 6307 units
> ratiometric calibration dx = 1800, dy = 18249 units
> 
> Reading from the IIO bus now returns expected results:
> in_voltage_7 (USB_VBUS): 4973836
> in_voltage_10 (125V): 1249405
> 
> [1] https://github.com/LineageOS/android_kernel_sony_msm8960t/blob/93319b1e5aa343ec1c1aabcb028c5e88c7df7c01/drivers/hwmon/pm8xxx-adc.c#L407-L408
> 
> Signed-off-by: Antony Kurniawan Soemardi <linux@smankusors.com>
> ---
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> index 8555f34036fb13c41ac720dc02c1dc39876e9198..a53d361456ec36b66d258041877bd96ab37838c4 100644
> --- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> +++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> @@ -503,10 +503,11 @@ static int pm8xxx_read_channel_rsv(struct pm8xxx_xoadc *adc,
>  		goto unlock;
>  
>  	/* Decimation factor */
> -	ret = regmap_write(adc->map, ADC_ARB_USRP_DIG_PARAM,
> -			   ADC_ARB_USRP_DIG_PARAM_SEL_SHIFT0 |
> -			   ADC_ARB_USRP_DIG_PARAM_SEL_SHIFT1 |
> -			   ch->decimation << ADC_DIG_PARAM_DEC_SHIFT);
> +	ret = regmap_update_bits(adc->map,
> +				 ADC_ARB_USRP_DIG_PARAM,
> +				 ADC_ARB_USRP_DIG_PARAM_DEC_RATE0 |
> +				 ADC_ARB_USRP_DIG_PARAM_DEC_RATE1,

The PM8921 datasheet suggests a single valid value of BIT(5)=1, BIT(6)=0
for a "1K" (1/1024?) ratio, although a comment in this file suggests
BIT(5)|BIT(6) is also valid and corresponds to 1/4096.. I wouldn't be
surprised if that is the case

The previously set bits are a field called DECI_SEL but are otherwise left
undescribed

Hope this is useful

Konrad

