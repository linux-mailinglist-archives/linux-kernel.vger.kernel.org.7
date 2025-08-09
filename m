Return-Path: <linux-kernel+bounces-760897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9124AB1F1C4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 02:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ED8B586F30
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 00:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C28265CCF;
	Sat,  9 Aug 2025 00:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SjDZdxC1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E1125FA00
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 00:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754700684; cv=none; b=SuqJi4cu/QgCzuGGlsfWh7CabNwPjakpPMNdnGvIuPssJmvEatclm1oxicFpI+IibcdN1ehKZ2blb+u+Eke29QqPDEuWV2vFfoLnotw4iuFmH2VdG2zZACvH78g/VUmA1zYWrTNFmzD8e7o+U068aUYj7LF6TFkndqlxS29r8tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754700684; c=relaxed/simple;
	bh=iu4Ybvml72DCjeYe+gkpRfB8TpgjwkqBkssTQJjn2jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=or9sACG7+dYWIqp3o97/g+GZ9TnIFU/X+tm+LIj9bbtN980Kb5jo1mIieMwQ9oFU4DWAVulYa2zfFgttvEbGJQbF9EMoQRgbP1V9x8xbdST+a/egjYGveSM144AvMY856tKg9KGqdnFMSmgTP7BFlvgvYvPq6F4+p/RjP1Dw8CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SjDZdxC1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578HUOVw007705
	for <linux-kernel@vger.kernel.org>; Sat, 9 Aug 2025 00:51:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hoY+FkRGPvkEWeTlAjY+LGALIacEK+UKYHyKEaey/U0=; b=SjDZdxC1B2ihfoPV
	zJAtoPipUXkKb9YvMUdmfZBd2sq8xucQF1NTwsjKMkMVf0fV5kwBpGW0A/CQ3176
	kQ7cKSeB10YCLn0QYM9H2lhzJhinXEOq+PIocIugDPcCO6qS3TSccJqkGDqtrQTP
	fqeDz4OR+5Ih7n6reDWAK4e+ts4LdA+mkqL6xeZ3YqgeekY9rjretjbHRREnbZgb
	rTTGDjAcJ1l0DaRxBwMRcy8qlXRa6WJihdvoaMXV7lSYjYWPCE4NbnIph4DzmnS8
	Z69XxojM+rCFAhHfWXrMXhrKP70vNfBHnwAVGOZ6P5reSlqPozzsisDW/9V6s2pG
	2lU+Aw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ddkkt6fy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 00:51:21 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e667b614ecso549563885a.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 17:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754700680; x=1755305480;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hoY+FkRGPvkEWeTlAjY+LGALIacEK+UKYHyKEaey/U0=;
        b=nQONIXNIII/hFhf2VhEfj+LLE659k/o4wjlXY+T9SE/pW3P8RzlRcCVrbmvFgXp97b
         Dtwo7EOkVUzeqxFojD8fizDboJQWCbCbQ4TleskA51n2QIW+42e0vI/O3Ca+cwb4Ok8e
         o16yRn0AtrZ8On0O93XAR/UrCFePLuOgRxrOScmnXVHIpzQmoa5m5EiBT9TCOMkN//Wm
         bVEA/t/PPS9pJ/0xwvQGq6vBeihouwKstCYfzwb9oJKZsI7F1IUaN57ZGc6HEdtEiCX/
         pavOssJh5XeJDMV/7nc02POkjT7mxWWTRtOX1elvssUMPaAT/ZszXX4qokPLtpoFh5Iy
         QYSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0xQShb5E9OYi6eGV3f6I5METrfmWC2gEu9LJrE9TjGvjPnVf5ERDSr7DxKKMyCUFoshYCm0eZASXsogQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTCzsf0KSAQ7DiSghDQQ/8kDyp0h9Q9Gg2fbyvLJm6O8pwKuSv
	QP0En6oQSUZMW0ddtAwN8bp5ozMuyqp4iOXCEkoc3JN7rFprAeIqxO5HyOm1LMkKM8hvxu6HB6d
	LSYObb3pL3fv1qn0G1uNv49/+ZgE/K/LFrxkzNU7dyFTLfDEz1g+SOhxSmXxIkWa5yh0=
X-Gm-Gg: ASbGnctpuX6xU2LYPOofhHyF62KIoOKzI70jm3aH6qOmB+Iz0djkb+XxZfHLdb3W93E
	KfgBwu4m2XMD4eKLDryvb6b+qXsvcQkH0NlyB8gKjz/RkhoksDV4TGwKqdQ7nBr9u7ZnYFBbxWu
	CIEq3EEI3UA08tkz6ch97nEjVdemiMfSSc8QGYxWNKiFzyJi/HZd76IrA/EgPAKzZIDdvwi87Bt
	RpfeUVbe1Sbka6DR+6IAg+4jaC5hvSRayqpW8TF+oIyvUa5bcIYVJBy+n2VsE69kZt5sWjBFOdo
	vbvdL4N2tfqH61j667+Hs0rftLpJmeeNERQTvk+ce3e6xACRtomvSH0ffsKPoKLIfkQzrcaeNls
	gA3m5CrAz9M22lNRYytsM0Auh7JP8HxPXCjdceKRh2q8=
X-Received: by 2002:a05:620a:25ce:b0:7e6:2f6a:5bae with SMTP id af79cd13be357-7e82c7e299fmr653881385a.62.1754700680402;
        Fri, 08 Aug 2025 17:51:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPoGDX+jX9Hh/iCn+TDzNM/k/SOiIlgU5Ry8cmMIkFdfpBCLAzWw1Nb92a+F2Yl2/QRzGpgg==
X-Received: by 2002:a05:620a:25ce:b0:7e6:2f6a:5bae with SMTP id af79cd13be357-7e82c7e299fmr653879285a.62.1754700679888;
        Fri, 08 Aug 2025 17:51:19 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0c3:3a00::4c9? (2001-14ba-a0c3-3a00--4c9.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::4c9])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-33238272dd4sm31445181fa.17.2025.08.08.17.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 17:51:17 -0700 (PDT)
Message-ID: <8f59ad23-4f86-4006-8163-a1feca3ae346@oss.qualcomm.com>
Date: Sat, 9 Aug 2025 03:51:14 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/12] drm/msm/dp: Move link training to
 atomic_enable()
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
 <20250808-hpd-refactor-v2-4-7f4e1e741aa3@oss.qualcomm.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <20250808-hpd-refactor-v2-4-7f4e1e741aa3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA2NiBTYWx0ZWRfXz+KqAf7B2dcB
 LQZjLSiDHD3JvcGdhwWP2bQmZCu2nyHJ33d8bcoTFFgku6w6y/s+UIzk8bxrTlvBih2ol8ehhiv
 9n8+29PMk8PN6uGcqES++AwEXIARQdyAoK+MRnOsIKLTNFH0yVYCtX1xjTUzCIHPZAuyYj324Mk
 XV+3eD2HO8NuYRt5n8mvZnTbaWCq6zBM/AZ9ECAKrxoh1LyjJJdyHvVxLhqnHBvmB5FYYTMf9lm
 8gbfSnKDmUa+fYhWFvruGdY57C7rJkfM1Ou8f9Awz0Knj1UehXP9TUiDUnDAWsTcgWx8K6+4Cvh
 XZiBaCineJE0JRTFVPNi6eJ1e7RKYyowAoTkZErWPHx2Lw7O+we9oXnAapGda/h7knzn+55m9EK
 H4PZV+xY
X-Proofpoint-GUID: blmnbZg4_yn3n8ENncuD36j-Glp5n74X
X-Proofpoint-ORIG-GUID: blmnbZg4_yn3n8ENncuD36j-Glp5n74X
X-Authority-Analysis: v=2.4 cv=Xpv6OUF9 c=1 sm=1 tr=0 ts=68969b89 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=tir8h9pnGiVj9xZly-MA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_08,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508080066

On 09/08/2025 03:35, Jessica Zhang wrote:
> Currently, the DP link training is being done during HPD. Move
> link training to atomic_enable() in accordance with the atomic_enable()
> documentation.
> 
> Link disabling is already done in atomic_post_disable() (as part of the
> dp_ctrl_off_link_stream() helper).
> 
> Finally, call the plug/unplug handlers directly in hpd_notify() instead
> of queueing them in the event thread so that they aren't preempted by
> other events.
> 
> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/msm/dp/dp_display.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index e2556de99894..c849befe58f0 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -427,11 +427,6 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
>   	msm_dp_link_psm_config(dp->link, &dp->panel->link_info, false);
>   
>   	msm_dp_link_reset_phy_params_vx_px(dp->link);
> -	rc = msm_dp_ctrl_on_link(dp->ctrl);
> -	if (rc) {
> -		DRM_ERROR("failed to complete DP link training\n");
> -		goto end;
> -	}
>   
>   	msm_dp_add_event(dp, EV_USER_NOTIFICATION, true, 0);

Also at this point we enqueue event, which will set link_ready to true 
(which is obviously incorrect).

>   
> @@ -1680,6 +1675,12 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
>   		force_link_train = true;
>   	}
>   
> +	rc = msm_dp_ctrl_on_link(msm_dp_display->ctrl);
> +	if (rc) {
> +		DRM_ERROR("Failed link training (rc=%d)\n", rc);
> +		dp->connector->state->link_status = DRM_LINK_STATUS_BAD;

Add a comment why it's set directly rather than through 
drm_connector_set_link_status_property().


> +	}
> +
>   	msm_dp_display_enable(msm_dp_display, force_link_train);
>   
>   	rc = msm_dp_display_post_enable(dp);
> @@ -1839,7 +1840,7 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
>   		return;
>   
>   	if (!msm_dp_display->link_ready && status == connector_status_connected)
> -		msm_dp_add_event(dp, EV_HPD_PLUG_INT, 0, 0);
> +		msm_dp_hpd_plug_handle(dp, 0);
>   	else if (msm_dp_display->link_ready && status == connector_status_disconnected)
> -		msm_dp_add_event(dp, EV_HPD_UNPLUG_INT, 0, 0);
> +		msm_dp_hpd_unplug_handle(dp, 0);
>   }
> 


-- 
With best wishes
Dmitry

