Return-Path: <linux-kernel+bounces-824995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAEEB8AA9A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1917B1CC4014
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F25321446;
	Fri, 19 Sep 2025 16:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lzejlcw+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF30320A00
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 16:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758301046; cv=none; b=WJUtNG5fhyRSB+WVFcb98vWA5Tp4AWuR7ExGZqG6TczmCuSAx4EX4NbtS6RYigCmzfkDxxPxgogSipLO/mDPn5xINSSmrwrBASRWo2KerugzLc86D4PBceGmODtqbDd+ztewISte90CZrxvBKN7dQm1gNxWE83wBs3zXVgFNkpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758301046; c=relaxed/simple;
	bh=ctfjzDj1Y6E0fdIK5UdF6Txrjk8dtRoB1xXgHseP35A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcmzO9JSQfKjiEsI3/vlC4FBrCGSHAbLgw2apSvVf31IqgoVoFFTfq9qDaoEstCFq3nAFkLphmeJORkUvcjApCFO37qrykYkLoEWniv5+QPfeYnUkQiI/O4Gow/agFDOw2iwBW00gUOyRqBXX1ztgoHEDZFBg02sz2r2i1jQM7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lzejlcw+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58J9A0Vd011018
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 16:57:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2SMDH20YTKikXCE41BaWkB66
	TeohJUYWgem0sV6RAUA=; b=lzejlcw+i1oBedZfaNudsMlavk3kgScMIid84gJe
	pW9ux9XX/6CJYWa/LZgO89bvsDFUDjY6X/zCuvr/wbSvFpz1jdcSrXoVLklOmTyu
	+nKbzo2RQ/JzD78ltijCipZSZEPetdnBGRGBWGDcIbSTd0kWdPJ/vbNUwpRZUE7J
	V2V+o57ltvjq0m6g1RYMnnVivLzSljWY12aW4lDtd3JMkZ1xuhQxZaYOqg/KeIO1
	GnWJw/NrV42nrWBcRA5wHTydBSca0OMox5kU/0096QiaI9+ncNl82tQA22s7lWfZ
	UWmqNzEUx0axd44nKN2Hb8L2OZdALFJ914tp8V+mj+KO9g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4985wx7581-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 16:57:24 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b5d5cc0f25so40152881cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758301043; x=1758905843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SMDH20YTKikXCE41BaWkB66TeohJUYWgem0sV6RAUA=;
        b=TWk++u5jLzYQAjV1ym3gPrTM4CscbZE9AUheDIqZlW0Lo3dFljfmYIYc8eMhVmF69o
         Vu1sDFwM2aVZIIOkaQuuJMsJG0dKxOYObF+i0x+Y4w7Qq3Ok7KZbD2Jrspui98oZ8Gm7
         tGoEn4PX4vld4Z6OYvXfb5NtZMuCFvz89P9NwJ4wRLiEY4TBk8x/Drz1DgA72mdVNw2c
         iaMgmOiBX2rXV+7NZ6tdlbRxCmy57Z40vDyxtFYke/t5qC5NxxZHn9ZczO6czu800zrF
         ipAuefX3NltOYZrhOssiZY2OT43qesKKlyiZLvVVlRdoCTMw9mIdYuCyC172zcLkkgPb
         100Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHZtVSyY8mMyMF2ZSaScYN7X/vr2SP+guEfOnkvjLu1Eeg6di+BlH+qojGfRIgyeMObITLyhwf4QrK7Tc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWJ/AKp3/pn1mrHNZCJ3Ln3Qpsl6DX2Xbm98kFKcVgOXT2vms+
	iaI6PtCCqDbQRDwKThgobhmTSsTGb1LuJWybH2tUQAgigdoZ29POTu7PFy6k/IWtD5SBCYbtiH8
	Sf7+9i1L1YhjaueeeksRpWmVLx9kKLZ1FoxmnbeJUI+HzP6lRUdjEz/C90bMrZArt0ag=
X-Gm-Gg: ASbGnct0nvgehiqacXKkbFU/6b0EV5djWNgWLzh0VOwUG93qTxZrGGs7UgKjhiNGCnc
	MseFRkXlQS4ECNf8QUNI4wcQhaV84OLSj/FMNgorN/d2HpNsmbNEmmuQye6tkaZlRbqNKvF2ajs
	a1lBs5sJQyDpRy5TWaAVNVTs7rhr1n8bGmrC8QG+PLrmFdPYYoVcrJj58afxQCgYW2/0CKCZ30V
	h7wW0Gg2Y2P26jhXi5PSJ96iTPApLU5YW6t7YVQ5LhxJUKekyGjhi4xlISHFJm4UZWKXWaLfUUS
	grRz+iE9mW+DCbQycVdEGxOUTMRdVR1T8SnAQN+DnwacLa5atqs26ox19XFeSDyUvW7lcJBMKxa
	JZlnD9oolFuw/5+2Nf4DJTP0RaLN6LqZpYeqPR1bo+ju+WBERJXtR
X-Received: by 2002:a05:622a:550b:b0:4b7:a887:9e68 with SMTP id d75a77b69052e-4c06fc182a2mr52471521cf.4.1758301043034;
        Fri, 19 Sep 2025 09:57:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3Y/hhgM/FH1MUqyFEYlRSM4m13q51NUGUOwCJl1YfmyFvHD8/eWgbghS7pUxj3fFOk2haZw==
X-Received: by 2002:a05:622a:550b:b0:4b7:a887:9e68 with SMTP id d75a77b69052e-4c06fc182a2mr52470981cf.4.1758301042221;
        Fri, 19 Sep 2025 09:57:22 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-36371919865sm9009371fa.62.2025.09.19.09.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 09:57:20 -0700 (PDT)
Date: Fri, 19 Sep 2025 19:57:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jun Nie <jun.nie@linaro.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jessica Zhang <quic_jesszhan@quicinc.com>
Subject: Re: [PATCH v16 10/10] drm/msm/dpu: Enable quad-pipe for DSC and
 dual-DSI case
Message-ID: <46syobyexy3ya3jjemmxc5g4tfkup62cks7gg7qpbnrga4fdhw@4ramayspl5uw>
References: <20250918-v6-16-rc2-quad-pipe-upstream-4-v16-0-ff6232e3472f@linaro.org>
 <20250918-v6-16-rc2-quad-pipe-upstream-4-v16-10-ff6232e3472f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918-v6-16-rc2-quad-pipe-upstream-4-v16-10-ff6232e3472f@linaro.org>
X-Proofpoint-ORIG-GUID: o-XGO4Za_YMenqWRGTF2zf_ZpxY78Bj4
X-Proofpoint-GUID: o-XGO4Za_YMenqWRGTF2zf_ZpxY78Bj4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDIxOSBTYWx0ZWRfX9rD5W0h1QhmN
 K7/+Epcr0m+r8QugIIl7LnuJ2YxWXIxSM9xlle+2OnFLl3Co1FhnmdoIiy2mshEf8omWtRY0kfa
 5R3FAJgfJSA5fa5Bgfn2BxgU4CbaNRX3GlumFjBJRfJQRqz2hX+fUAdIxqtySmCXswhw75fyXE4
 ey1/rlqDwUVu7Zri8zAHLPuM5R6FXxK5HM53vMPzCsZVrU0Pj+H5WUB2bXFMp2dwAnFipV58ZBF
 7FdWgaif6TK+bw1Yrfl3ad/Ybh4aNVofrrg10lLgsQOcelLOsEqdmUxRCXfNcaEDfffjvm64ooQ
 J8aYiBnjn3sBIDXcWBMT2DcoJviSF0LYMV2PO5JV4CZFPBWh+VdTj/S+LxXBjOgV9aKbRsQh4x4
 i8sawxkq
X-Authority-Analysis: v=2.4 cv=Fq8F/3rq c=1 sm=1 tr=0 ts=68cd8b74 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=CHF6AoUvwY4jIHrWGZsA:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509170219

On Thu, Sep 18, 2025 at 09:29:02PM +0800, Jun Nie wrote:
> To support high-resolution cases that exceed the width limitation of
> a pair of SSPPs, or scenarios that surpass the maximum MDP clock rate,
> additional pipes are necessary to enable parallel data processing
> within the SSPP width constraints and MDP clock rate.
> 
> Request 4 mixers and 4 DSCs for high-resolution cases where both DSC
> and dual interfaces are enabled. More use cases can be incorporated
> later if quad-pipe capabilities are required.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c         | 27 +++++++++++++++++------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h         |  6 ++---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c      | 28 ++++++++----------------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h |  2 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h   |  2 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h      |  2 +-
>  6 files changed, 35 insertions(+), 32 deletions(-)
> 
Please fix the LKP report.

-- 
With best wishes
Dmitry

