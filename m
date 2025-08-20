Return-Path: <linux-kernel+bounces-777608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EED1B2DBAB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 960FF7AB53B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273842E5B16;
	Wed, 20 Aug 2025 11:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XRFmaEMs"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B7B242D72
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755690581; cv=none; b=P1hfE783ze5MRPSZ2l4uExel3kXnHCpl9vrWF8LW+fzBLzq6hdjM4z77/geQI3K1bcoypv1GkVGQj+gLNmFJOfPQP7H+7K2jiekWLUppA6z45fiGKVwOnbryEe9ChTca5pbkuujc+WDP0A0AqyzdtYOxD8xbmcoGYFtVdJRd8M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755690581; c=relaxed/simple;
	bh=/W3GAMjxb6JXpBcaXEk9zeYaG0UOfu4lsuIRPhBJ840=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDymc4HB5/Bst3uqOVWUugxSmgXa9K7gnFSdkoLQLQusydlLZuz4jBlSBdPJY7f0vsFflFLJTXsPC+O7RXfGpzuVGEIcHC3oKgkm4ojYHrSyK4ygh84PwnCpgbjSQQBBNAAsGZKZH9eqCfiTOc4xzgIQx9FTRJ+QtH3v34hbWu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XRFmaEMs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K9r5HX024699
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=eQi7QofWcWU158eHa77hdKaL
	MtA3y2gGZ0Eyw0PH0w4=; b=XRFmaEMslRE5X4uO/ji+OsjfJYFnH5j7tKnrndUM
	jgnyDrwLaMjFnRz/WJDihtq5/NFBqMRvz8soLQa6BPccpTKet3utuvHsCK7FFeTS
	ihb7boZRAiH/eP4PIfDN9naahMao0qhYEch625dtktKtYZQ8OAT5PMV+NtFNM8jI
	flLUW7OapLaVLcyKx+x+paCwMpfDfJxOZpycrTJrRQ2CGrCAwD0GbFwQs3jBGNQj
	WnlJiGrLgfcTEmfBRYP79gjZeIAWkGBD7IzmZm5L4jJy22E8Zl29IBWUy3OHsitq
	aqF4QhbAQJYqoXURUqSltZcDkjaiR6ediEVV8foif/wYKg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5291kc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:49:38 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b109c7ad98so237599801cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 04:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755690577; x=1756295377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQi7QofWcWU158eHa77hdKaLMtA3y2gGZ0Eyw0PH0w4=;
        b=ntk6QZREck1YLT0pDnic0oK8vFH9Gx5HkPT0gAimrTKZNTVxwLrVdCo8gM7CZuoad/
         oGVkuwpYuJZbUQlY2UVnOu5igmCad7FD5EcUHdzs4O+IyuUWpSp4k8TGesd/NMIAI++X
         S6hW4OzUepolh9iORYQddOzmKm9LmmWnIe5SI+XX5juZSoqoHD7UI513tBQ74YwBQLpQ
         F0ojYtf3YbwRy6VRVNXqR0dLSJx7TrdRHf6sGV4L3Yzxge7nvR49vbiGP1rOokSZta4D
         L+oR05ix5xfng5coGG8tJ2rH/Fbi3Op0d4A9ZLnIaiQDMJsZDo1N6x3l/0nsDVs6UWkr
         aj2w==
X-Forwarded-Encrypted: i=1; AJvYcCUranjCD2NsDrPlGMc/fJV9w7NU1THPTFxRQ1eZ+u4Fxe07XmG1G3R57OmVFJsy9aI1dRUHsJOJsVgNex4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH5SrbQ0HASqXim9uDYnQ40kvVQHXW+K5g6RJ2u8Bg3dkoXSra
	NQAGMmrPqUQwKL8ltmE6FFrs26K3tcqKECYZ+TYoBHmIWWjaS0WyLzrvzsHDEI8FLFsEcAxBe4q
	C7FzuNi+hITD3+m/4xN73nYJiTryMN7P0+vqRCMa1eynL5A8Pc8YqykIPnkfe3pwZnxA=
X-Gm-Gg: ASbGnctHCgF94hFhTq+rmn3C0EWI5O5APwbuXo5a6iAqgsN5XIsqIrGMOtxOq2gK1b3
	JyotWTjkHMJCci9kpisKcJ0+pMA2BWN4gPV3erUWg8097xqUja3dvNWcSGGgf+58y0L42JkVa5P
	ObiN4noSV+Izb0C40I64OK8iUH1DA1oHkfIFVepimNNm6lbc+lbcnOsA6ETrn7rvzAOEnEZGZvn
	wjoDaEHdH60ApA/9ucyly8pq3d8hay5LdCtwv4WeENWxJr2IuOQ0XvNM1HcUPOJ6e+m/QffdfzX
	OpHKfgmgMciS8G+3o9L//P/faZyRXj+54Qu+ylJyITkZtpxOARNsO94XEM9/Oa6wa/KyZfCavIe
	Es8p8o38RTroUgyDBUBEv3+KBdaxsOJ/9ogGngsbj9ycLiGfTBShS
X-Received: by 2002:a05:6214:20e3:b0:70d:6df4:1b03 with SMTP id 6a1803df08f44-70d77170c76mr19313156d6.65.1755690576810;
        Wed, 20 Aug 2025 04:49:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmrvdHhyhkjHia2f4r6fnsTTnjiCF/kpkKVlmq6+LLt1eyY0mOs8rxItEF+MdJz7nJEs0lug==
X-Received: by 2002:a05:6214:20e3:b0:70d:6df4:1b03 with SMTP id 6a1803df08f44-70d77170c76mr19312816d6.65.1755690576172;
        Wed, 20 Aug 2025 04:49:36 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a625af7sm27271481fa.60.2025.08.20.04.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 04:49:35 -0700 (PDT)
Date: Wed, 20 Aug 2025 14:49:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, fange.zhang@oss.qualcomm.com,
        yongxing.mou@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, quic_lliu6@quicinc.com
Subject: Re: [PATCH v3 14/14] drm/msm/dp: Add support for lane mapping
 configuration
Message-ID: <wwn24kjpwexl66hd3wufa53lkqojb2bkpdogtxwr3uqotjpf3u@hclfgsv64ajn>
References: <20250820-add-displayport-support-for-qcs615-platform-v3-0-a43bd25ec39c@oss.qualcomm.com>
 <20250820-add-displayport-support-for-qcs615-platform-v3-14-a43bd25ec39c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820-add-displayport-support-for-qcs615-platform-v3-14-a43bd25ec39c@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=ZJKOWX7b c=1 sm=1 tr=0 ts=68a5b652 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=mR71zFEkwuVZQDQknwQA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: qda3lrEoaguJM2cWRbwxb9I0044I6aX7
X-Proofpoint-GUID: qda3lrEoaguJM2cWRbwxb9I0044I6aX7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX7Jy7S8sGFDW6
 GnN0N6qlbpPAgkE3L5WUdnQmJTM9gRjGM3U7fI4QTaz5IsdMSGukkb1wc9SPHZPY/qyYUkcFlfT
 G9HQvsb5CY5Jzq9j14bOMbiQB1M6f2MaCj2pEC4r+KutiUTh81I1U9jV2cWRMYyX9KPfmS1NE4c
 auiGQD1rxPfovpAZ5q9Id/3GBrnj2fhjFT+J7P4rmQk9IW9lYFjFAEo5GQW+hzrBvSRg+a/tEgn
 ocseWP+xoKxMd1vJ1Q38q+nOt8GEYtmFb9GNOOFNX8er18a9y+3ZLNxjHwNa0fsGslPgXNeEtMd
 1axu/c69C6BXh4ca7K0J/pauUuNMDFGlFIzNk7yTSsFVE1ruf+XCOLq+vdweHvlRV+1zETQHlKt
 jjPjFNn0TTEb2TYKbMJ/jrbYSrSaGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Wed, Aug 20, 2025 at 05:34:56PM +0800, Xiangxu Yin wrote:
> Since max_dp_lanes and max_dp_link_rate are link-specific parameters,
> move their parsing from dp_panel to dp_link for better separation
> of concerns.
>
> Add lane mapping configuration for the DisplayPort (DP) controller on
> the QCS615 platform.

Separate patch

> 
> QCS615 platform requires non-default logical-to-physical lane mapping
> due to its unique hardware routing. Unlike the standard mapping sequence
> <0 1 2 3>, QCS615 uses <3 2 0 1>, which necessitates explicit
> configuration via the data-lanes property in the device tree. This
> ensures correct signal routing between the DP controller and PHY.
> 
> The DP PHY supports polarity inversion (PN swap) but does not support
> lane swapping. Therefore, lane mapping should be handled in the DP
> controller domain using REG_DP_LOGICAL2PHYSICAL_LANE_MAPPING.
> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c  | 10 ++---
>  drivers/gpu/drm/msm/dp/dp_link.c  | 71 +++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/dp/dp_link.h  |  5 +++
>  drivers/gpu/drm/msm/dp/dp_panel.c | 78 +++++----------------------------------
>  drivers/gpu/drm/msm/dp/dp_panel.h |  3 --
>  5 files changed, 90 insertions(+), 77 deletions(-)
> 

-- 
With best wishes
Dmitry

