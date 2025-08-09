Return-Path: <linux-kernel+bounces-760896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D344AB1F1BB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 02:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A717A068C9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 00:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C755B19D084;
	Sat,  9 Aug 2025 00:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bBvuEjws"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAB92472B4
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 00:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754700333; cv=none; b=QCiFeXxdkae4AaliQyqua6vlITcW/l+MS6aYK4MClqLj9LBe9BOyrtj31sp6LN0SAI3StbS/z4h7uFtY7t0cBv5JHBtoOTPcJrZ/HYiep6+2o5DN5p/ouUADu3jH1zQ01LLilcR/DB5tyZYiMMLKVXa45LD8hw+a2hHj/oF84nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754700333; c=relaxed/simple;
	bh=2vsLgS26yFMejf/z5b0FmAu6mvHHLVIqHOFBtaF9nAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fRLamz6pe3Y4egiiUHkz4QfR3+7V+iqWke27am9SDwl8WDnPI3XrVRJQagNDNvOoHa894EigpuIHyzUNiFbDj4ain9NuxPG4n3zz0lGqA6S21Z9KNjolTrWaAlg7hIqcG4nnThvFoHiY89sdb/XOObE/McfYSc6QrUtR7WJsCJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bBvuEjws; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578FOWHl008373
	for <linux-kernel@vger.kernel.org>; Sat, 9 Aug 2025 00:45:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+SdmD8y1mIxLj5DFoiniCJvWmuKL4tKZkoBsj7bVLx4=; b=bBvuEjwsd1/kxE2D
	ZDXgvJfxNQCPttMaRWVcjiODIqCxZdVCSSpeaPAL5y3oE/RF5yYvvLIBa4nE7ZDO
	o6s8aRij5d3v9ZeXxITxp2fjw62faOGIiDjghxKg6GRUQcNKT8qf/ZGzKf0iC9zX
	mAw/g+nQX6nCJcHmJYEQYiq8sem9vb1zoPkFtzH9RFYgUxqPgTR9BeqR8CpgVQc9
	pjU2ZXAHpJVB2tDAcp2K5aO+bBA3EpMb9O+nbANZHwtetKBcc3GznisbOvqGHPcC
	6JsWYTFOMjSS7HnlltjidLxb4dTuTLxVsGBOcIG/3ktdGD9fW8+KAO6fFHPlMoNI
	50leHQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48c8u28kpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 00:45:29 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b06a73b580so39031271cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 17:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754700328; x=1755305128;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+SdmD8y1mIxLj5DFoiniCJvWmuKL4tKZkoBsj7bVLx4=;
        b=k65yuJ5/KxfI1GBRAWg0kTfBUTbq5D8sPH4pGWu7uNJyniGMjM9hZNpgVifCEnCtXe
         X/6eqSvBDZGR5wRUfSteNHJ2rnCT8uawidogXbnUNPOQyqp0jFiy4spl56+VBs/fWLiI
         bnaMaQHBHlTpGz6ncH7qMHTtCv1OX+wWVtnkb1Dzuw8ZhPxS7VGsqL4pR7cjgVOL/eYz
         cZJfSkkRI2zSRn/1ZSMV1tTi7aCS+cHrJW6XQxreYvKZismVtCoF8qylZwulJyRAVTUl
         dHCchX/QQFhJjTaICt8B036L+a589oiKD/Yf/JwRwdzjqvCVNIXuu+ttIASL5qoYg8qs
         zq+A==
X-Forwarded-Encrypted: i=1; AJvYcCUz6mdMG9dlHjQttQ3N0gPRKS5yfWp0y/hDLtOhNvHNXHOvhA+HcYhOEn08QaZCmqecI6LdzWX7GR4DE0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ8n2nylQwdOzLSLAaziE2UJ/XT9Onn0xyWb+dFrDk8bguL4os
	lfRwad6nr9FZyGk97E4m9ivkXmrqw22oe5I1AGepm6APSL/CNfvcC002lqCDOmfGYboOvrF9tRW
	egxA/FxaTYHlmean4gxGdzhbxTbj3OQoPy0VT+gVOwYSlKFlOwOtpMgmdVSL0iSM2EBU=
X-Gm-Gg: ASbGncvr2xNV/8gNXUiOnve7R+mh6OMU8qomY1u9SYsh14+VvChMHEnR4D/hw/DnQO/
	MGIsrpYymG7EgXpkutKtkca+CGpfzF1koHeepLqTXC2rifRgQhh5SHBiADBSxNuJvdL7PLHd8gU
	FGSiSQ4FebtdH9r2ZxIs+2rDerSryEuf3THJ5qNLJ76uIzYoTb4G2YQtLsxoEchqjW00JAl864X
	IVxv7O1/3fjJe3xPElNu94gNbDsHRhHmx6/dmWbSDrwnWlFb/VSFMnB9rU+Qo6m4aGbJFBN9vc1
	IJK+wclzpRNc0TNUOng67qU8jv/ChVCFZQV/Yo8nDUqt1Pse+zrs8S26d6y81hW1L8OWNiZUkY7
	0gzR7PsFQxuL1pwnNzUE7EPDKpq4ktAo9xmpOpWLOa0I=
X-Received: by 2002:a05:622a:115:b0:4af:21a0:c65b with SMTP id d75a77b69052e-4b0a074ef32mr134768351cf.13.1754700328002;
        Fri, 08 Aug 2025 17:45:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfQjmXMV853672JK0fEpKkYRjhS8uwOvkShC3Xw9ZNKFNAKoVWBbGdYfzTQ4X2DquHWVzT1A==
X-Received: by 2002:a05:622a:115:b0:4af:21a0:c65b with SMTP id d75a77b69052e-4b0a074ef32mr134767951cf.13.1754700327474;
        Fri, 08 Aug 2025 17:45:27 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0c3:3a00::4c9? (2001-14ba-a0c3-3a00--4c9.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::4c9])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-33238271bdfsm31713131fa.6.2025.08.08.17.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 17:45:25 -0700 (PDT)
Message-ID: <e217fb72-36e4-4222-b5da-9608af57c665@oss.qualcomm.com>
Date: Sat, 9 Aug 2025 03:45:22 +0300
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
X-Proofpoint-GUID: CVWZpShrnNIvLZqb-133Ma3_qXYGiJOk
X-Authority-Analysis: v=2.4 cv=Q/TS452a c=1 sm=1 tr=0 ts=68969a29 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=tir8h9pnGiVj9xZly-MA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: CVWZpShrnNIvLZqb-133Ma3_qXYGiJOk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA5MCBTYWx0ZWRfX6cCzbuDx5Zl1
 pFgZOLjD0oVMP+xeSzypx5F6cDTxxcHX4jireb6lN54C+LzL24Kh7g0T5R1GxMrB1262nT+5UDX
 ob/yMSxUqRpjDjwTsJlgttHlLWFG1MaJRC9NFdG7qUMNo66Rur7YlSPbMqKbclgvfYdXf4enKcZ
 yBMmz+mV9SUyJBTZpB1DKgjbq9XnScV7VapgnOV0u9PILr0+N64THfBZ+M+AMfz4emiaCSCtdX8
 DNlT/l1N+akds2173RSNJ66x7JoCZN1qD9ARC9HfIBmvVAmaVBFnsNQe6YBU+sdMhUWKBe3aLU5
 jvBDfBdD2maW4mLaMzrOuBv/UXf8d8fwHAn9iHvZP3z1y4AeqCdWYCm6unZhZFpmE6omjkzaq1z
 JHjJdHke
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_08,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060090

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

This feels like two unrelated changes.

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
>   
> @@ -1680,6 +1675,12 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
>   		force_link_train = true;
>   	}
>   
> +	rc = msm_dp_ctrl_on_link(msm_dp_display->ctrl);
> +	if (rc) {
> +		DRM_ERROR("Failed link training (rc=%d)\n", rc);
> +		dp->connector->state->link_status = DRM_LINK_STATUS_BAD;
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

