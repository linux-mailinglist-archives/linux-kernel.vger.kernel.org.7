Return-Path: <linux-kernel+bounces-760895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EFCB1F1B7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 02:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440551C23BA5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 00:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407DE24728D;
	Sat,  9 Aug 2025 00:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sp0P3qmt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9FF2459D0
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 00:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754700282; cv=none; b=Zw9qYCHx05OrSgGf7P6nheMO2DTgY6fqubPTXOve6WHH/3w9s+zyUSNe1woJFUtYKoTbngxGnSyG6yZeGX71P2tf9I94W2Ewbt0EcV4OMLfXChuwDezqugB2Mp7SUzW+stnQoLkC+EGzJvkuEHF8cq30b1LH7Y5+N4ya+l1lJeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754700282; c=relaxed/simple;
	bh=CprPIvMUEFV6t3GFhtB1siP6EgRbTU3tEnS7qIl1p5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JOlkX82Btz2zbREpkn1mS5w+3Jmo8b0oVwiT4EQZTvGsYAYXghmirAR6OP+T3q7eumZcEb0M7Q/x7JMim+NyqooBeEMOR8WpYwvDNZ6xzUkfKiz2yKYWcHbfTC7UoPHibA4dzBYfeHYbiwCNT3+k8MDpU8rjK7kOnOcL42wHUUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sp0P3qmt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578MY4kE028297
	for <linux-kernel@vger.kernel.org>; Sat, 9 Aug 2025 00:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BimyYxqwpniYNzfnCwL2spGT2aViDo1PZ8XTpYNqG48=; b=Sp0P3qmtKmXQpe/f
	QURhN4ZELDF+WJ/NVpssSy2nmarjSvBTWdPm0ekw85HtSc1PH2RY/KgN27K2S08C
	1ho1KwKgvqMXatZq2kd6yYiag20RzLZ+VNDIPoasyceY4Zj5g7WV3g4kl41/1JkR
	0tzZvb77iHcxsMMG9kQb6aOdurg2NmUpGKTOFwblePP3Gpw/5+65Nxso2uteK8f8
	i/9FOypktjXygWRseP+c9VtvSooiDXc8qUw4ep8miwb7pVw1a7hePRA+6QzPkL5v
	pE85Z1JULGR3l4T4s2PYmW1m/Mnw/25XrCRd/bGiKdGQg7BzK+559HwxZBPMJalZ
	vHOtGA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpw3bcq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 00:44:39 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b0a3557d05so50285461cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 17:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754700279; x=1755305079;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BimyYxqwpniYNzfnCwL2spGT2aViDo1PZ8XTpYNqG48=;
        b=KNNoulBm4IbwnRDNzgz1Q1IL0logEN9vUb+jFXtEcJH3Lu+ELhvbt2ZGrE/hudw7HF
         KG+mbVeaGqNSJNLDqMqDF4o8u3H90MCkr2AHBGf+FhJnp4X9JTUxxIn/XtJE0nzXLpUj
         rnpqhGQhAtfrpod08k0ox9c8DSEUM6EndJTzg7c48kC+XDnivFwRME0VGB4C4WzjtPdm
         DMnyPJwtJ50N4Mg21HHQt/pe5SpZJZ6ohrB1lyv0V9IE005BAFUT5Zr8zT27/jzUZoEv
         5/DoJMTv2MYd/7TCbuTc0wRgDnoN5x1gY7yOJEb+3UsfSBtBKogwp7RMP1ZF+v/eIULN
         22Kw==
X-Forwarded-Encrypted: i=1; AJvYcCXbe9pqVXPqvastkmNG7y6e6de/O2imFJ73ApGTR79p5MsgUCnMZVO/wbykIVyaULm0CSIJ3z6/rPyfaTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRdPkGgT0C0YK03KDxtjM9Y0Q7RE3GHFpGMgP9crMvcHk3d+fS
	/wmtxAZ36gOwGetGFmVb2mjCT9mxmjxiIln31GQEUdXzuS3Vk3Efip9C1677pXQyymuX9bISS/d
	f0lc6zDYQV4ZxwA7Bl8/rhnuaxyed5eUiPPiiwXpwcPGcbEGKBMfVReYPhOqkB+hRhSc=
X-Gm-Gg: ASbGncv9nRs1McOnRlR3MuCCjuNIaOEVC2Ur8yh/WXyuhXJtsOP+Dx1FXu1KTnstC/r
	W32D1/qavUFJr4dtxYRYNnVct4+murHOGiLzXrGgeydPQRHHjfhU05AghsCHQg4Wfx3UUP4/aC1
	g8H52OSBbe/6bU+jGJYGJ9tLoWG1gct4rhy73uruoQLbJTxzxeZW4R4xQfxHokmfCuMNdOIyKdh
	KnFJ8UwMa/o7W6+gqHB+uY8qXr/ZpR8DsNN2R3WDMvwtuev9+MLoqEz9SkyjIigt1gjGTaI1OyG
	x/CyFDcvAThqtswqzrm7+joHLeXQ0jKjVBS64Y8ASqp/QCMsWZNE/qq3rU2ByXKiuB3JrP9ozCo
	Ibn18lN6wgvRSRq+zmSFBEFTka+xTS4vdyOl0fw9We3k=
X-Received: by 2002:ac8:598e:0:b0:4b0:7b3a:5301 with SMTP id d75a77b69052e-4b0aed6356amr68264491cf.46.1754700279086;
        Fri, 08 Aug 2025 17:44:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGztjJ9/tKVCY5VSQ/JjsHMYVrDuTUfZGB4dEQs28y5gyOkr+EEh8mAop45dGh/F3eQP/56BQ==
X-Received: by 2002:ac8:598e:0:b0:4b0:7b3a:5301 with SMTP id d75a77b69052e-4b0aed6356amr68264071cf.46.1754700278515;
        Fri, 08 Aug 2025 17:44:38 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0c3:3a00::4c9? (2001-14ba-a0c3-3a00--4c9.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::4c9])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c99078sm3171328e87.102.2025.08.08.17.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 17:44:37 -0700 (PDT)
Message-ID: <365288c5-f1ba-4875-bf6b-59a34ed52ac7@oss.qualcomm.com>
Date: Sat, 9 Aug 2025 03:44:35 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/12] drm/msm/dp: Read DPCD and sink count in bridge
 detect()
To: Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov
 <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongxing Mou <quic_yongmou@quicinc.com>
References: <20250808-hpd-refactor-v2-0-7f4e1e741aa3@oss.qualcomm.com>
 <20250808-hpd-refactor-v2-3-7f4e1e741aa3@oss.qualcomm.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <20250808-hpd-refactor-v2-3-7f4e1e741aa3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOCBTYWx0ZWRfX04ky+wjblTDl
 /fB/nQywwoSJWWEG1xqrz4l3k1y2vmhd3YLnU1axRjbtkpQEEn3BGFGkVzLl6UCXOxHL443KM4S
 nziYkQfcvxBhdHu/ym4upZ76ky6K4Kh1Bnvo/qQ4TgHdtTZpb2ZWEzR6p/3Y4j18lmjF/lTn7KY
 ViAIgRuWjzbofsBBPj3aktgqlcJ28KuepF+FIIEsVVnIgqth1JQCiWWxCSjrbhN4+QsgmCzSAfl
 tu4fu5LGIg6YuWflk42LNtrepjS0cVZiTVZ6YxD8yR18nJj4ayr+SpFP7OlhHU93tL9/Ifv83z/
 hem3+ACjsJhweMEahA+5+nGKeYrX4jqmtiQn5s+QOkWHpNbINgVmi39qw3Hp0dSmWTo7YcRnC+Z
 Pvq6NfYt
X-Authority-Analysis: v=2.4 cv=J8Cq7BnS c=1 sm=1 tr=0 ts=689699f7 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=iK85lhrOwLHDTm4cRBAA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: GYQTHTimQDkIacUjzSMPnEinu3Y5Ghht
X-Proofpoint-ORIG-GUID: GYQTHTimQDkIacUjzSMPnEinu3Y5Ghht
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_08,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060008

On 09/08/2025 03:35, Jessica Zhang wrote:
> Instead of relying on the link_ready flag to specify if DP is connected,
> read the DPCD bits and get the sink count to accurately detect if DP is
> connected.
> 
> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/msm/dp/dp_display.c | 54 +++++++++++++++++++++++++++++++++++++
>   drivers/gpu/drm/msm/dp/dp_drm.c     | 18 -------------
>   drivers/gpu/drm/msm/dp/dp_drm.h     |  1 +
>   3 files changed, 55 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index bfcb39ff89e0..e2556de99894 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1142,6 +1142,60 @@ static int msm_dp_hpd_event_thread_start(struct msm_dp_display_private *msm_dp_p
>   	return 0;
>   }
>   
> +/**
> + * msm_dp_bridge_detect - callback to determine if connector is connected
> + * @bridge: Pointer to drm bridge structure
> + * Returns: Bridge's 'is connected' status
> + */
> +enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge)
> +{
> +	struct msm_dp_bridge *msm_dp_bridge = to_dp_bridge(bridge);
> +	struct msm_dp *dp = msm_dp_bridge->msm_dp_display;
> +	struct msm_dp_display_private *priv;
> +	int ret = 0, sink_count = 0;
> +	int status = connector_status_disconnected;
> +	u8 dpcd[DP_RECEIVER_CAP_SIZE];
> +
> +	dp = to_dp_bridge(bridge)->msm_dp_display;
> +
> +	priv = container_of(dp, struct msm_dp_display_private, msm_dp_display);
> +
> +	if (!dp->link_ready)
> +		return status;
> +
> +	msm_dp_aux_enable_xfers(priv->aux, true);
> +
> +	ret = pm_runtime_resume_and_get(&dp->pdev->dev);
> +	if (ret) {
> +		DRM_ERROR("failed to pm_runtime_resume\n");
> +		msm_dp_aux_enable_xfers(priv->aux, false);
> +		return status;
> +	}
> +
> +	ret = msm_dp_aux_is_link_connected(priv->aux);
> +	if (dp->internal_hpd && !ret)
> +		goto end;
> +
> +	ret = drm_dp_read_dpcd_caps(priv->aux, dpcd);
> +	if (ret)
> +		goto end;
> +
> +	sink_count = drm_dp_read_sink_count(priv->aux);

Should be guarded by drm_dp_read_sink_count_cap()

> +
> +	drm_dbg_dp(dp->drm_dev, "is_branch = %s, sink_count = %d\n",
> +		   str_true_false(drm_dp_is_branch(dpcd)),
> +		   sink_count);
> +
> +	if (drm_dp_is_branch(dpcd) && sink_count == 0)
> +		status = connector_status_disconnected;
> +	else
> +		status = connector_status_connected;
> +
> +end:
> +	pm_runtime_put_sync(&dp->pdev->dev);
> +	return status;
> +}
> +
>   static irqreturn_t msm_dp_display_irq_handler(int irq, void *dev_id)
>   {
>   	struct msm_dp_display_private *dp = dev_id;
> diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
> index f222d7ccaa88..e4622c85fb66 100644
> --- a/drivers/gpu/drm/msm/dp/dp_drm.c
> +++ b/drivers/gpu/drm/msm/dp/dp_drm.c
> @@ -15,24 +15,6 @@
>   #include "dp_audio.h"
>   #include "dp_drm.h"
>   
> -/**
> - * msm_dp_bridge_detect - callback to determine if connector is connected
> - * @bridge: Pointer to drm bridge structure
> - * Returns: Bridge's 'is connected' status
> - */
> -static enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge)
> -{
> -	struct msm_dp *dp;
> -
> -	dp = to_dp_bridge(bridge)->msm_dp_display;
> -
> -	drm_dbg_dp(dp->drm_dev, "link_ready = %s\n",
> -		str_true_false(dp->link_ready));
> -
> -	return (dp->link_ready) ? connector_status_connected :
> -					connector_status_disconnected;
> -}
> -
>   static int msm_dp_bridge_atomic_check(struct drm_bridge *bridge,
>   			    struct drm_bridge_state *bridge_state,
>   			    struct drm_crtc_state *crtc_state,
> diff --git a/drivers/gpu/drm/msm/dp/dp_drm.h b/drivers/gpu/drm/msm/dp/dp_drm.h
> index d8c9b905f8bf..0f0d4bacb194 100644
> --- a/drivers/gpu/drm/msm/dp/dp_drm.h
> +++ b/drivers/gpu/drm/msm/dp/dp_drm.h
> @@ -25,6 +25,7 @@ int msm_dp_bridge_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
>   		   struct drm_encoder *encoder,
>   		   bool yuv_supported);
>   
> +enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge);
>   void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
>   				 struct drm_atomic_state *state);
>   void msm_dp_bridge_atomic_disable(struct drm_bridge *drm_bridge,
> 


-- 
With best wishes
Dmitry

