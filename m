Return-Path: <linux-kernel+bounces-831278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E71D3B9C452
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9588A32834F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D686287510;
	Wed, 24 Sep 2025 21:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AJjVsTMY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76AE28488A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 21:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758749159; cv=none; b=X66tivPKutcynOgmuixKsaag6ZFqQG2rRe5tUFYCHhWjIgyGNqCnS06S/h2q+wlTZMqiSCYCnZvtwuCbDqfCpQj0CHLpNK4fZrb/ASLe7hGTmQvxWN33sF5EeOB8sG3Z20IkzXWBgAETNL1wb2K/IPBy0jPXvH+lAaDSC/dO984=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758749159; c=relaxed/simple;
	bh=ghA4chtfqCcWFNtl2XB9vYQE8YPHJxNyV5Cy2nfS58A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSNAqBivqfTn6+x8xHuX5E216VQ1eCdEQR31aRlb/esi4ImvZPWaaE4pgLBl4u51PaLX19eurTkc+V3u0fTEIfUee8B6+MhGpdXkc4+kHb3rU/E9E+6Ddxzj8N+wGBcRwvTaNGyx9zS981+VUCWxbEvari5moSGL6wyWpoSdurM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AJjVsTMY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OD3csj028188
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 21:25:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/q7ck5ZyxDPq0cljoMqHt8gL
	Qtmb0+gJMZIvbJmIoeg=; b=AJjVsTMYWe8KNtGxUliteivSdRkvmVN37VkR8vQF
	81Lr7iwa6AFnulnbbWu+5Oeqs0JVdbxizZ7SbK6cXDLnHiMCvM89NE3m3c83QY9B
	D7mGjjnRSzaVRTHUqZ56u3PTtxTXR/qlHdU89+HWgbnme0gCCt7f4hfti9q1r4KR
	2YcapPTFg3cizBULbi7I25kjZ451aa7wEkWTUWydbSWqTyQ4amxLfEk7O0Q3XA/o
	s1Bp6k7brfs1hdpi6/hf7sP/vTkC2V5Q2MVmNPq0WdXr8KUgKJDQJaTgOTt+RvaK
	k+AE9gYXmECSk95qhMes4YN0gcRbryckYbSQGagVlI92Rg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hmnx50y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 21:25:56 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4d9ec6e592bso6121881cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758749156; x=1759353956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/q7ck5ZyxDPq0cljoMqHt8gLQtmb0+gJMZIvbJmIoeg=;
        b=ZNU/LmkhLEKVYfGYaoN9LOJlaMY5MIXz6tcMR0RYdlZSJtgm4ef3zmoBq+L4izsOmR
         wPx69ygOkAP4BrmC5FhROrFvEb1JGz5mpVHaWSFX0p8l7V/SXXKPp70mNs2eyqEViK+r
         TuthtOp11u+MYwm+ZGdbWbEi5C8YgFJsSuEFdaLiHwLt9wGyfgQnJ6HOdN6c22yhwvLt
         H/dUU/o2RrOBmR5CGvc+O1L3RLIb8nSaI5PmxxeKQ/gZ2JWfUjqk9nEpP83G5X9eKTIr
         PCHL0aNVgnR7Krv1ihO2VK7LoAi/eSdVgfSlK51j1sxtGCmsRuKWMnr6BgOrxZbccmbH
         8fhA==
X-Forwarded-Encrypted: i=1; AJvYcCXf6xtwfsJXS9Bm13by/0WjXF/gF6J9QNXhAcQ/k++OfK2clYCCUx2je6Zu2At4cnu2IwaxDFFl9prxRTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEW93We/nsWIJjr8HKgLC742IT76dZ1gBSW1ZbmZc1o/uk6cl2
	/5NAiiy+FHrBwcUTfS1QrQ4U0G68SxZhSFLMfTZj0qB9xo/PGdlar/0lw425qMEg+b5/pT7edDY
	/nSidPoQMQEBrKhNX7LLdUo6CnasACo3YCvg/CrSSihbT8KxV3zQ0TZNDkJ2nM6iitWU=
X-Gm-Gg: ASbGncvVSPFmlfsPoyTcTllSwD8jE9Mo9rSQTXmcKWhqHMYjhCevrq3LXCLlalutikv
	EaKoEDfTRtsCjO71scu+t6fm39AgPXaJGrOXf067Am041hZKYfvoO94aWMJwrO7iFVVgfXl+jY1
	BR10UAyvpd2wJudx4VVX/XipYMmPum+T5G9pyTUmsWTwX6fgBlYD0oc2P2JEKNzmDzjGHkDY/c6
	/zZ0soip/LIZg9rXHxRRi3CHmbYnjuttK7MyNXm7Fs4elGSMtO0e/K2/+2iZP3Hh2vVlkmzDlFr
	IALyP7krYgf8WdPHKo38X2sUcwkWXUSn84L/wyOFhXlq7SMuIt8EF+g30OvTKiUIxf2z3aTw7Gf
	AYbmY9xdwbwaTUYmKjSdFSi8Au7w+y4Jy9KWpTLAFbeAin3Tj4wlG
X-Received: by 2002:ac8:7c42:0:b0:4b7:aaa2:c8f6 with SMTP id d75a77b69052e-4da4b42c83cmr16927801cf.43.1758749155826;
        Wed, 24 Sep 2025 14:25:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFa2soASBumvR1Wp37An6aFpQ1N0R0qrYSFiiAAmklOZuBLiBN8NvuSKWYrA3++YveaEu9QLA==
X-Received: by 2002:ac8:7c42:0:b0:4b7:aaa2:c8f6 with SMTP id d75a77b69052e-4da4b42c83cmr16927471cf.43.1758749155363;
        Wed, 24 Sep 2025 14:25:55 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-583139f9915sm33226e87.39.2025.09.24.14.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 14:25:54 -0700 (PDT)
Date: Thu, 25 Sep 2025 00:25:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>
Subject: Re: [PATCH v2] drm/msm/dpu: Fix adjusted mode clock check for 3d
 merge
Message-ID: <3h57fefla2kv5mh2fmldma5v57do7uohljnzyd2pnkpsdugxle@ylqizvhtril5>
References: <20250923-modeclk-fix-v2-1-01fcd0b2465a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923-modeclk-fix-v2-1-01fcd0b2465a@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=YPqfyQGx c=1 sm=1 tr=0 ts=68d461e4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=1bp3yVi2_WrJ7BMISZwA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 8b0e7F8eWpmX50fU2IYpP-J75SaBEcFK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwMCBTYWx0ZWRfX+mMddVnihbyg
 ldjW/nHPaY20dBzfC3w569pHchOkQHL49IkpmfHQ/olmHtXblpeN+hge1pKb4C5unw4txpHi/jZ
 kJPNnO1IaBeY0KnD0qQo1/YvJgLW4aGgiqsgS3NVP9mzV+UgqTG2pT6R/WmA7dPGpSBl4hUY1y8
 WVmQHU/QXaeImrs6QzvDdIY4vRmvltbLi9ToH35IwQNVT1Nt+3HvWlDIXeYUJ29LonKyk621ksS
 4wNtRI9+/z2Cn2PSvexrar3LmD+UZCF/R2EmCejsGVF+BFokVhC2Nngv/4zsz8T3ZNNXi6pE5Fj
 4tJ/Q76M+td4X81pkORPcfJg4k5S0d82+2zhpX5bl3rMOhXYPRA9LidARsymTlwT40JNmEJCLA4
 pW6C16qV
X-Proofpoint-GUID: 8b0e7F8eWpmX50fU2IYpP-J75SaBEcFK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_06,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200000

On Tue, Sep 23, 2025 at 04:03:50PM -0700, Jessica Zhang wrote:
> Since 3D merge allows for larger modes to be supported across 2 layer
> mixers, filter modes based on adjusted mode clock / 2 when 3d merge is
> supported.
> 
> Reported-by: Abel Vesa <abel.vesa@linaro.org>
> Fixes: 62b7d6835288 ("drm/msm/dpu: Filter modes based on adjusted mode clock")
> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> ---
> Changes in v2:
> - Divide adjusted mode clock by 2 if 3d merge enabled (Dmitry)
> - Link to v1: https://lore.kernel.org/r/20250922-modeclk-fix-v1-1-a9b8faec74f8@oss.qualcomm.com
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

