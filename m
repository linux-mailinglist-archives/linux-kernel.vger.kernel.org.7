Return-Path: <linux-kernel+bounces-578921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9BFA73CA0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 18:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1568E3B8157
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 17:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB88215F48;
	Thu, 27 Mar 2025 17:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BN69UswT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBB01B0409
	for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 17:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743097216; cv=none; b=Inheh0myB1PNGU82EXfmOqTM2AgsQPoVu9xJV2ygJ+VjqhWrHACMtniDsIMYLu/DBcfIx1EBGkHz7AYRdHHovG5BIBcVUiwbgazc1j7iml3DD1dI5dV+cIfa58Qe6bmxcO3U9Dncq43vjoucPOHGUMqQeJbThNfpac2AFlIYtYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743097216; c=relaxed/simple;
	bh=AwqjU+9UBunv+Rz46t1pT1kpMqAUwzK5WZPsuMLf0zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ss/rcJ0tsLbEeoVDV7vTGoThf7oRxtyiZRA+nxd8ozR+wSffQls8uCaYHN1ae0YvJF/uzI78MzUtoN29sH8P6E7E8TM9SsLQXMW8IrfVHnWIGkAikGRW4bMlrp/JpH33UiemIfIF8DHHXNqrO5EpuwAz7oc5zDUjrM4fITNELYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BN69UswT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52REo9MW002256
	for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 17:40:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HAnKU+8WTJQfX9xGmYZ9jIU0o6jrNSszROdygX/BM+g=; b=BN69UswTm30Pimb6
	hGt81/2M/gdAxC5pg28QnBqRPLl9hMHDSGe/urxIreJ0pJM6PaC1Klm1oc9WomYm
	A/XefSmGoQzs+XBzTy5z0U2OzaANHALZrT4MUTDypIGz3P5JqflGFsK7CxsNCqhe
	kGIjvOcsPlkifK7ennr9xujGMtUC2sdHDD9q6f4NdafWjEWntX56rRql0ekH8FRi
	3BV145Q4TsnSSLVbSIF5QC/3bnXPtENyXDtmasOG6qNN+P3YeY7ZnW9LtL86oR3e
	wNVa4v8HboQ4DhqDOfc+speKV4z+WJVB2WDl8+bbDz2daczBg+ZrdRGzK53NJdv5
	iyERtw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45m0xdy204-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 17:40:13 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c5e2872e57so239680485a.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 10:40:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743097213; x=1743702013;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HAnKU+8WTJQfX9xGmYZ9jIU0o6jrNSszROdygX/BM+g=;
        b=hllXeQZjWbsY1IsPmHxY5xeP87x4TN9sxypv8vVKh1E7i5Ls2HftT2MSWegKhIF+nb
         iS10Gtil91Al2FbUQtdUtyxVXr0BeGmz8n1ZDekVnLRObLg4uG1XnJrBJivtZadVlVb9
         HKLE6E9S/Q7ZCZPz6tmZSEPLJoxmbJ9Mu5JGMoGVbbdltl4lIzSOgJn7tKtZXDaKFxNE
         lmutbBO98j9ztFkNPMRuJabBiwN4fBgyePOgjXkQJKnyUcW2l1Wj53qcRgD5Q2SGXyaw
         oQpGpVQSBwjSJyaBO5K5AtRN1QHs6e+ZRspgDCJvh3LYIWoNeba6MgJ0uRZGyJcFfPa9
         1FiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb9wDtFFaj7JFf6vGx16QD5VOGRLKlGts7zmxANbIXzUSnNqoq/6fuh2zY5RFt2CsT29Qg+Up0XPLUwAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRqv6dB0z4NmaJpC93ZQnO248glHjrIxbuxUqT8ObnV7n9pzBh
	vre5WEtiHCCO+iRWO9utHwN1WN3/tcky8NLFJhofTEBp+gX9Hv0CU8+4R3CGnaQuXFctuQyRbwl
	3t3Kux/KUxTf5+9vgdjEXq1XwWbaJrzdPMze9D2YUxfcM1cSOAiFlGp0DuxPdTwA=
X-Gm-Gg: ASbGncsSxeu87kMHdOVCaaKiiYGmU/Q4wj5BpFW8Zs2IQ0htLSr94W0tq3tB9L9TWkP
	kCyX78TEQxyyStTTd6Lm5YuW4jZ8QndvZt0WnqcpnLhX6NV3pV9faM0k8dNhQUl6Ai9tA7K3pAS
	exkRr4i0RK8TjT6KUJ7451II9ar8aJvNYPwZ6iio4LCsbZCrXdNO/2YR/to0jvRuYf0kIcPFwvt
	IK3W16Pj+yTEGRMXOcOxKUhNQKKe85PbxYGHftJzAdRmAx3vq/JiC1qBbXDMFr34eXrC3pj4HDB
	PCa+RoPs3bN7sIJ8x6nu89dSb8uSKdEIVCr0NdpPdK4x84z1APweKsek/h81RescT7EurHQMBAD
	mEnb0nLZss9IDQAcoDig0pZ/65DDvYlHxCwyw2OkKwE8fLXxtw/xUj+39Vi3xnSoT
X-Received: by 2002:a05:620a:2544:b0:7c5:5801:ea9a with SMTP id af79cd13be357-7c5ed9d9a49mr552449985a.11.1743097212764;
        Thu, 27 Mar 2025 10:40:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkRSeLScZxYeiAYG4QqXzG0n51R6iF2AKOozxwSHJWdm6gWamrwJp83iGBY7841frVHEVArQ==
X-Received: by 2002:a05:620a:2544:b0:7c5:5801:ea9a with SMTP id af79cd13be357-7c5ed9d9a49mr552444385a.11.1743097212194;
        Thu, 27 Mar 2025 10:40:12 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ac:ffd6:501:5ae1:b167:ae27? (2001-14bb-ac-ffd6-501-5ae1-b167-ae27.rev.dnainternet.fi. [2001:14bb:ac:ffd6:501:5ae1:b167:ae27])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54b0957ffcfsm27071e87.138.2025.03.27.10.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Mar 2025 10:40:10 -0700 (PDT)
Message-ID: <07c48ba0-dcf5-4ece-8beb-f225652c5014@oss.qualcomm.com>
Date: Thu, 27 Mar 2025 19:40:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/dp: fallback to minimum when PWM bit count is zero
To: Christopher Obbard <christopher.obbard@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>
References: <20250327-wip-obbardc-qcom-t14s-oled-panel-brightness-v2-1-16dc3ee00276@linaro.org>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <20250327-wip-obbardc-qcom-t14s-oled-panel-brightness-v2-1-16dc3ee00276@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: lGKnaVWtKyvTBPHwJYz4J_zysmE0Nc2J
X-Proofpoint-GUID: lGKnaVWtKyvTBPHwJYz4J_zysmE0Nc2J
X-Authority-Analysis: v=2.4 cv=Q43S452a c=1 sm=1 tr=0 ts=67e58d7d cx=c_pps a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=8uZFVrZtLw_Y6pPcPrcA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_03,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503270120

On 27/03/2025 19:25, Christopher Obbard wrote:
> According to the eDP specification (e.g., VESA eDP 1.4b, section 3.3.10.2),
> if DP_EDP_PWMGEN_BIT_COUNT is less than DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN,
> the sink is required to use the MIN value as the effective bit count.
> 
> Some eDP panels report DP_EDP_PWMGEN_BIT_COUNT as 0 while still providing
> valid non-zero MIN and MAX capability values. This patch updates the logic
> to use the CAP_MIN value in such cases, ensuring correct scaling of AUX-set
> backlight brightness values.
> 
> This improves compatibility with panels like the Samsung ATNA40YK20 used
> on the Lenovo T14s Gen6 (Snapdragon variant with OLED) which report a
> bit count of 0 but declares an 11-bit PWM capability range.
> 
> Co-developed-by: Rui Miguel Silva <rui.silva@linaro.org>
> Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
> Signed-off-by: Christopher Obbard <christopher.obbard@linaro.org>
> ---
> Changes in v2:
> - Split backlight brightness patch from T14s OLED enablement series.
> - Use PWMGEN_CAP_MIN rather than MAX (Dmitry).
> - Rework commit message to reference eDP spec.
> - Rebase on drm-misc-next.
> - Link to v1: https://lore.kernel.org/all/20250325-wip-obbardc-qcom-t14s-oled-panel-v2-4-e9bc7c9d30cc@linaro.org/
> ---
>   drivers/gpu/drm/display/drm_dp_helper.c | 50 ++++++++++++++++++++++-----------
>   1 file changed, 33 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
> index dbce1c3f49691fc687fee2404b723c73d533f23d..0b843d5b634f89f144b62b30311834d118b79ba9 100644
> --- a/drivers/gpu/drm/display/drm_dp_helper.c
> +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> @@ -4083,7 +4083,7 @@ drm_edp_backlight_probe_max(struct drm_dp_aux *aux, struct drm_edp_backlight_inf
>   {
>   	int fxp, fxp_min, fxp_max, fxp_actual, f = 1;
>   	int ret;
> -	u8 pn, pn_min, pn_max;
> +	u8 pn, pn_min, pn_max, bl_caps;
>   
>   	if (!bl->aux_set)
>   		return 0;
> @@ -4094,8 +4094,39 @@ drm_edp_backlight_probe_max(struct drm_dp_aux *aux, struct drm_edp_backlight_inf
>   			    aux->name, ret);
>   		return -ENODEV;
>   	}
> -
>   	pn &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
> +
> +	ret = drm_dp_dpcd_readb(aux, DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN, &pn_min);
> +	if (ret != 1) {
> +		drm_dbg_kms(aux->drm_dev, "%s: Failed to read pwmgen bit count cap min: %d\n",
> +			    aux->name, ret);
> +		return 0;
> +	}
> +	pn_min &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
> +
> +	ret = drm_dp_dpcd_readb(aux, DP_EDP_PWMGEN_BIT_COUNT_CAP_MAX, &pn_max);
> +	if (ret != 1) {
> +		drm_dbg_kms(aux->drm_dev, "%s: Failed to read pwmgen bit count cap max: %d\n",
> +			    aux->name, ret);
> +		return 0;
> +	}
> +	pn_max &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
> +
> +	ret = drm_dp_dpcd_readb(aux, DP_EDP_BACKLIGHT_ADJUSTMENT_CAP, &bl_caps);
> +	if (ret != 1) {
> +		bl_caps = 0;
> +		drm_dbg_kms(aux->drm_dev, "%s: Failed to read backlight adjustment cap: %d\n",
> +			aux->name, ret);
> +	}
> +
> +	/*
> +	 * Some eDP panels report brightness byte count support, but the byte count
> +	 * reading is 0 (e.g. Samsung ATNA40YK20) so use pn_min instead.
> +	 */
> +	if (!pn && (bl_caps & DP_EDP_BACKLIGHT_BRIGHTNESS_BYTE_COUNT)
> +	    && pn_min)
> +		pn = pn_min;

I wonder, what stops you from implementing this part according to the 
standard, rather than adding a hack for 0 value.

> +
>   	bl->max = (1 << pn) - 1;
>   	if (!driver_pwm_freq_hz)
>   		return 0;

-- 
With best wishes
Dmitry

