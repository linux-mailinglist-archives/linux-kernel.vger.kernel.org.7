Return-Path: <linux-kernel+bounces-785323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BD6B3490D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 042B917F229
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85B13002C2;
	Mon, 25 Aug 2025 17:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z1DJUYCy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0306306D4B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143580; cv=none; b=b3Hv3EFLrVzvpSFmmDfrrHjfIK32USbN9F6/PQ2MKiMLosH/Yk3FMZOhFGbCadN0K09TSsJCjaKCcuNGtN2GlGiylB9rApKynB8DXGOLIK1cNlln9ltKeGf7+dKq3Zr775Bp87UpKt9yiZQD75DZQzE98B47fc0LFex1iWw14Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143580; c=relaxed/simple;
	bh=W4ZV0iP23nMN77zh9xn8UD1fExc+eozPldRuZJkTj2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TL0TzRSych6fKnDj7CMccSWRDm2bMJPBmwOlav3OTCFjOEf/GT7pQAcGQ4FvHhTCtUGHtj6F1uaVByf1u5o3PJZqN+M7vaC/sgfrim5tcO8rEOF+JryEGsqPHq82/r1fkfKn5Wru6Gv1Ed7ZAdqsCL0F21LM4rXadf8pAhdDSLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z1DJUYCy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PH6UYG008821
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:39:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=oIsZvuj3zyqTv/yqZeIFq35X
	0m+hZSGafrokoFxwjBg=; b=Z1DJUYCywhGvuKF3VHAarB4nGAQo5JCQzmdMIk/w
	jgNGeZU+w5q1LRcxOYUCeBj+Xk4EdY+Tho9QH5/c4gthlFqDk8H2tvsEQMLHTxjG
	u8XnK4Wp7JmR8QD7UBM3abGObz3CrfE6i7qvKAnSVhD4ZF07U3dHVIDN2u0qy4DY
	TBJy51dxvM3G2yF+9hWy/upcNPXZvzlSxlJ8DxY3nQZD+6Y3aIIhG1LnVEUNq2Vi
	KK1eNBpBNG+HakaUvpCpp24OF/SDtck/B7EhzJGBRxV4KmFQIeOgGBMoSBnDieFq
	8YUTzpqXQ7MW/1uy8g6Z8qyAUdm3uQfiU4z84yzbVc3rzQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5w2p39w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:39:37 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70d9eb2ec70so30791476d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:39:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756143576; x=1756748376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIsZvuj3zyqTv/yqZeIFq35X0m+hZSGafrokoFxwjBg=;
        b=pHfyWN5Utue61fKh+vIURiMlvuVppYXJLyF6cx0A/tDixqq1wf6UQCoc1QvIGm7KRq
         H5xSA8/qL0AYFpU5Gn3dWH4dXBJsi0//Gk8O5nbRDmt+4fDOHM+f6YDS9rfkvI5hzWhQ
         oeulkE6r6Wi4ynuYiDz7LZcwC8KmWUfBQjB3TIyogbTvn7YTTNCPkqHtUEUPhL7HJ/IZ
         mptMx8RTSbjcgSZfmfh3/qhow2Hl7vROutT5o4Xn2sHX/nxx0vk2i/OwIDs/sjZDyHqU
         OQsDx07q0l5LqreqJgDP6EHePamHc8sxSBLysjfvnk3pN+Qj/byO80nVDezU8vTKk92M
         8gpw==
X-Forwarded-Encrypted: i=1; AJvYcCWJ532TPApBTpjZiuypCoewR8/a4PdWipVDbIedg4X8/FJl9Nz9QxNPkB9D7vrnLx4tBodNWm7Bt7XrDic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7uWt9p+b4asER+vAREc0TjliID4xTAyeIaD+RGB1NzCvFY9cO
	/d9IbNg6uUYmrWak26533sEmZ0kChvVTzjE8q0sEY6oSU7q8fAfqh0Zb6CDtXJX/X4N0PpTWawh
	kSaLaaWISYgO6f0AQzW8Pw/nbiSriG3mlhoVf88NqS2S3RUDbXPAZEJPZlyL+WOYitJc=
X-Gm-Gg: ASbGncu7SYH4eplxH0WinIyOUFiWdSREEZWnd2uRr8UGsPC2yez+cTa55vZWl0Sss39
	0+lQ3NmI4cEyq4avyjU1tdMltuGqwzNMQ8pjweQ7V45gXSgOwZYFS6xTcylaT3qBe7ieyJJKJeK
	3mW1przYInq/AqWVFJoXkHcI1IKdae27BxbW1HS6OiXKpr8FJRNpGgxtgYO8JSaRs0rfzv9flk+
	NmIWcDwR3mVCmYn82LO5QSZFvZKpRPLArdAJr+oyiesVont7RunhjFGccBvF1n7JaV/e+xgHLcQ
	xMvhT366fOlyxjdD4zXYrzPQnUIDl6SwYEQDgqd27uY+x5Wz5ZL6eM6SrcQxCC/R4lPvM/MRD2s
	vG5Fa57mpNl073ZIdUkkuqmYLENmHaXd5W9etR9+qCCHGvlP14niA
X-Received: by 2002:ac8:5e14:0:b0:4b0:67c9:fd3f with SMTP id d75a77b69052e-4b2aab20a48mr171263061cf.51.1756143576279;
        Mon, 25 Aug 2025 10:39:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEu9ExTFKxMITOA8Nf6hgeYhq40ePHq4NgYZNNSuNB7d0GTcBRxbB53k6tbpruIYLU+/S4KMQ==
X-Received: by 2002:ac8:5e14:0:b0:4b0:67c9:fd3f with SMTP id d75a77b69052e-4b2aab20a48mr171262501cf.51.1756143575665;
        Mon, 25 Aug 2025 10:39:35 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3365e5fc0c4sm17741041fa.70.2025.08.25.10.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 10:39:35 -0700 (PDT)
Date: Mon, 25 Aug 2025 20:39:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v3 11/38] drm/msm/dp: separate dp_display_prepare() into
 its own API
Message-ID: <rsywfefrwv67umbi6xeybelsu5u6xqyklvtarnoluu5mzz5u5k@bkexqpdd47ew>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-11-01faacfcdedd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-msm-dp-mst-v3-11-01faacfcdedd@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Z/vsHGRA c=1 sm=1 tr=0 ts=68ac9fd9 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=oD_kwPJ1Vc7tpeseQ3MA:9
 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX+N0dw5T7au96
 OLYutC/X7+T3NEnFodaJPlrpzP9y4ugAStdnyX+QEycPdRmng5/l/N/Nc4aBIYRrNOceafkUbv7
 r0nB1WkdbYnmQEnAbqPZf6L4l+wweVfEN70yIOVM+IrWSSEWccO3KBcxXlmN3ZGIkc8R+TTndvJ
 AXSZIKitITClxBYSg2mzkPQhA4tsCmelwdpYBhGwW3k0mC94/J0CbEs0ATC3xSeGnJquXKRRi/v
 PfYQKb7var3c0/GYSDUE9YHLwchX4Q24mYWvq024svzjsnlcVq3NB4Z7k4aFdJyWmhXr2afVU+6
 gk0Of7lw5Juru7ydOVjk42qq0asJtVh/tDzLC1eeSZ8fRsF/yTcxe3VxyKdt0diQTk3bhrPJmz/
 7yXDg11C
X-Proofpoint-GUID: fsrX0VZxVTiWOIKIsWD6wq7_Uu0zdDEP
X-Proofpoint-ORIG-GUID: fsrX0VZxVTiWOIKIsWD6wq7_Uu0zdDEP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_08,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

On Mon, Aug 25, 2025 at 10:15:57PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> dp_display_prepare() only prepares the link in case its not
> already ready before dp_display_enable(). Hence separate it into
> its own API.

Why?

> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 16 ++++++++++++----
>  drivers/gpu/drm/msm/dp/dp_display.h |  1 +
>  drivers/gpu/drm/msm/dp/dp_drm.c     |  2 ++
>  3 files changed, 15 insertions(+), 4 deletions(-)
> 

-- 
With best wishes
Dmitry

