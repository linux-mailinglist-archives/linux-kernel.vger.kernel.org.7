Return-Path: <linux-kernel+bounces-760996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51501B1F2C3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 09:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B91757AF3D0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC32A2797BE;
	Sat,  9 Aug 2025 07:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VOvv5hT9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7593A21770C
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 07:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754723436; cv=none; b=Bp8ba18vkuxFLQ2K76p1ZMqAnV49bOr5TDR9R1bkwDgIEfokK105PHj2nZal1oAWcNZa6qi74sBh4h8MIaDBaOFd1KFmQYtct4DjVJV0YNE/zStBWAAcuwl1/HtkBd9TI6Qt2PltYaCqV/iXPiuaVFI7vMh4SxmaKArwOeicpjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754723436; c=relaxed/simple;
	bh=VSlk9CbaXe7iLpE73Vs5c8bTyeM0TolS33K/bOG9ko8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPP9U9DT9H9BsfGDUr3eLdjPbZm0N1Bq283DRnbPX0uP40xfvbYRsVc0BFrlpKqym8mgP/x01aqR8yjqVhxO3CwSdktqn5rfQr9r4RxxSewf5NFOTtgXCL1zykqadPEsyQKVuF7aaNPS4TpjL4dCPRWvq6DUWQHZRi75kQy+jwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VOvv5hT9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5794lahm023146
	for <linux-kernel@vger.kernel.org>; Sat, 9 Aug 2025 07:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=lGIoJPjVaweh6fzYPRiYjwF1
	gDXSBBuomIgkEtxpmgc=; b=VOvv5hT9xA6M62f5MM1zOyfhwAmy9+7nRw7qqBEn
	K5YHfyVMcX8uqXXsFj24oIpbM9eaRa/X7tLbke90A42h2tyoeP/N3+NG8/ClM8OU
	dwKi6sdSEH6Jb/TptdXr8mXCcnM1SADPEQITkwy8N2RAiasyJjXAbRAn5gpCuVMh
	tYw/xdbOHz1AqiA+EAj+Og6dUu1+zjlisXCNZTbVOdw0cMkYwsx1yGFG1JBWSCgI
	vZCcIvSYDEdu88QNVqCs87SRP64C9jOGebb8HWfHtj32yKGEPVWzEneRKwL3hMVH
	HJnMvCu7XBZAZAZGJ7w0LGW3YMbckvwgDmZT6XSRPi4S4w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dym9g566-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 07:10:32 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4af199d0facso82221041cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 00:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754723431; x=1755328231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGIoJPjVaweh6fzYPRiYjwF1gDXSBBuomIgkEtxpmgc=;
        b=uKWTrqGmjKCWUv9JsHuggYWkmwkjH8tA3Z3e1jjuFfIGSAUwoY3q1Q/OSzYNOKoWCZ
         QHurJC+MA39xyPCYjddch40zlQ1XDOXzwqXbAu4Idf/CQFlbXems07ZeztpNjnjntXjF
         YbyMOA8r/9AV9NIokbvhu1cYoSHzwBv4CxBdoFMPoNhRj5RVJmNbISe7rV+3T01+tGMu
         2aWDXIrBNp9c0WrqRoASFOuhYoDB4OPKUmtFypNqyLi3haQ5ti1l2U00yWeza6PCq8Zs
         1rze4Kp4Zk+qkvqwHnOo5rOIL8TGZPNonD3A+PRkEozJfk6FFhpzR2KffoHdnzTXRKSF
         ITBg==
X-Forwarded-Encrypted: i=1; AJvYcCXR7D7kWoB8//z38LSNAl3mPU/kM4olpmSL3P0OODw1bUuXGH6lPmqP/NvVB4+KlzU5ThBxso8klpwc9dE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRbPMG5rDdfCJYoU2nmI/2rGMUHNHCWA9EYWkDabw3tmrcvKuL
	4XMclQCNSngvs6cEBWwGE5D88UWF4K7BXjtGoOpZl3lBQ89Q3dG4o1QLNfdTZ3KiRfDtlTk79e7
	KnThzvgGLsDxS5dlAu6r6rpEvZU1fOlQ2ue3gZhazAJ7VFf0TgSzioSRMiNSi+Ne95Gk=
X-Gm-Gg: ASbGncuws1qNczHvMamKxNqmB+gdj5vC1nXTL5vN4XkoaGI6hBIUBlKNvzU9zMCAfDl
	s21FuFao9P6dSHoUSmiEBI7FQPIcosEdktBeL350gxeVGOqFl7m/gib+VrxCw1WK4Q+YE2+4G8i
	I4EfJLcPqyLWfz89mok10bc9/Upf39E34ikA/iFxi8Tp4SS0GPK5txhq9UTGNLTYmsxXFo9k8zK
	Bm9I5SPd0M4WEVKoa8Df9APZI42L3IVE2D8MpQ+GDoZq8gLQIIOP+A5UCozlL82ys0T9G9TIB8z
	yWNNistxlTuThucLe+AUz712OFN8w0E2rMcDCEHZFLfICfvvzgXI2RsS66Xabgd2zInGffb9ugx
	FY1nFQpWx7xkB4mq22xJaZB4/dX9wJfRQ5ph/hVOSF8+4wIbe3RIq
X-Received: by 2002:a05:622a:1aa0:b0:4ab:640d:414e with SMTP id d75a77b69052e-4b0a06eedfdmr151125871cf.3.1754723431177;
        Sat, 09 Aug 2025 00:10:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEV6uIbGHBTb/R1Jt3TX1bc0j6npBwpC0efjKBnU0qNU5KhhatLsSTXZdchZFM7R1iG73Hy5w==
X-Received: by 2002:a05:622a:1aa0:b0:4ab:640d:414e with SMTP id d75a77b69052e-4b0a06eedfdmr151125621cf.3.1754723430746;
        Sat, 09 Aug 2025 00:10:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88cb7c4dsm3320058e87.170.2025.08.09.00.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 00:10:28 -0700 (PDT)
Date: Sat, 9 Aug 2025 10:10:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yongxing Mou <quic_yongmou@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v2 09/12] drm/msm/dp: remove redundant checks related to
 ST_DISPLAY_OFF in plug handler
Message-ID: <45shie2h45zmrrgtkt5k4v5hb7cjspjkdfugy3mvsjsbeggrm5@mfyhk5ntwmqe>
References: <20250808-hpd-refactor-v2-0-7f4e1e741aa3@oss.qualcomm.com>
 <20250808-hpd-refactor-v2-9-7f4e1e741aa3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808-hpd-refactor-v2-9-7f4e1e741aa3@oss.qualcomm.com>
X-Proofpoint-GUID: uIz04TSDXd4SJkrHT-bcTILZLEDvbAXx
X-Proofpoint-ORIG-GUID: uIz04TSDXd4SJkrHT-bcTILZLEDvbAXx
X-Authority-Analysis: v=2.4 cv=YZ+95xRf c=1 sm=1 tr=0 ts=6896f468 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=e5mUnYsNAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=S3fc_xTQ5om5qnv2m30A:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzNiBTYWx0ZWRfX/5LXjnEyn18R
 X88JdqJq/wyafRZ5/d3TVjB9REAPPzVjFEsdNp8lmrBdsIznT6eSslCjF1pczcVgu1drRSHPsTF
 MGSPaH8IND/4kNMi76IU/WYpyGAZubGM6nD1X5C37TLb59v0D6WLFNhtYtuZIHqrmIoEQ6LM01o
 PLjG7H240lECxntxhOZzAZznxBhvV6xsYhh7P1zJWJNPtP9LjO4W7lDnE3wC2+cg3ufojNSFmxY
 uQZMIFmnoa26mEFvNIrX9hEgaQEWnRRtO74h85rZAPP4G8l2l4Aq7nTNGAIzv+UjjEmDEB0ByFU
 HML1kYZ9J7f4Abqqs/6KumKZYytc5dw0qBI8Tus+6Y+bEJg31e7Yv3rZP4pwyir08WFZLuy7Fns
 WS52yBGS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-09_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508090036

On Fri, Aug 08, 2025 at 05:35:21PM -0700, Jessica Zhang wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> In commit 8ede2ecc3e5ee ("drm/msm/dp: Add DP compliance tests on Snapdragon
> Chipsets"), checks were introduced to avoid handling any plug event in
> ST_DISPLAY_OFF state.
> 
> Even if we do get hpd events, after the bridge was disabled,
> it should get handled. Moreover, its unclear under what circumstances
> these events will fire because ST_DISPLAY_OFF means that the link was
> still connected but only the bridge was disabled. If the link was
> untouched, then interrupts shouldn't fire.
> 
> Even in the case of the DP compliance equipment, it should be raising these
> interrupts during the start of the test which is usually accompanied with
> either a HPD pulse or a IRQ HPD but after the bridge is disabled it should
> be fine to handle these anyway. In the absence of a better reason to keep
> these checks, drop these and if any other issues do arise, it should be
> handled in a different way.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> ---
> Note: Taken from https://patchwork.freedesktop.org/series/142010/
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 3 ---
>  1 file changed, 3 deletions(-)

I think this patch and the next one should be folded into the 'drop the
HPD state machine' patch. It would be easier to review.

> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index eabd6e6981fb..dd3fdeaacc91 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -495,9 +495,6 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp, u32 data)
>  	drm_dbg_dp(dp->drm_dev, "Before, type=%d hpd_state=%d\n",
>  			dp->msm_dp_display.connector_type, state);
>  
> -	if (state == ST_DISPLAY_OFF)
> -		return 0;
> -
>  	if (state == ST_MAINLINK_READY || state == ST_CONNECTED)
>  		return 0;
>  
> 
> -- 
> 2.50.1
> 

-- 
With best wishes
Dmitry

