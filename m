Return-Path: <linux-kernel+bounces-825107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B64FAB8AF9B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 20:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A3CB3B9ED5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DB3272E6E;
	Fri, 19 Sep 2025 18:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ocbb0xK4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627C1262FD7
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758307747; cv=none; b=nRcelShYDmNsGERMvbGTUI9lP0jawSvXDs4SvWvUnAESQlNX4tqNL/cSSsR+xE/d5Rj+Fq7r0YO2h43kmcLF1x42Mni4VbSd7HyqlQGOTOdX+uYRR3vz6dovb07RcpGAor5RwQ9FmLSqpE48g3Y4KRmBwALR+kqkxRtNBIoF+80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758307747; c=relaxed/simple;
	bh=tDpff8O9qf1+POqcMf7/vsOvLzgZ1HmZhTtn5x1unOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNWHjaJPS9+epyTclqGTKH75lhvhL739sGGVGvtRHXeoutuZ3Eov6ouqGIMj+5gKt+ybQdOiP+lqfwqoYC3IBM8ggLDxraUCHk/0H84APyz2+sZ+TVpGWcBJO3vn424mc4wNNMmlnxL5uqi+2LIAvonpj0R/BViyeFOXuw2s6W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ocbb0xK4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JHV87J013449
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=1xZa8NKZpDGoqnGXensXWLoa
	+hUVxbdOY1y1b66zJ+E=; b=Ocbb0xK4Ljujs9Rpfrf+140ehslrxIZaeV5ZsHXA
	sdEMwZoFTfb1Ql+BuaLOuDI/yc//8QfcddWVzrrz6XZzs5l52mLhX6M6HOZMh/dl
	/AoK4LDROWC8q2OdtxEBsFupe2CEPy+PAG6UOj3XCgBK3t8TlA4VIxHHIe4xuPbK
	wyy/EkBWHD1qo++duSE1fcHFjLQHzgsV9sQYLrzRdsnq4W7R+rnHpU9/2mg1muZT
	TzuoUhs8Xc6phG3Ve2179+Kh+lSmOFF2hLYBUmnUEtTIWt3KAygpVBwq43chfh3Y
	XsIAAwZTWzD5NTg8AKs/WIDXuyPAiS9QOzRg2awX+Eg6iA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499bmy07yv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:49:04 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-78f28554393so34731816d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 11:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758307743; x=1758912543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xZa8NKZpDGoqnGXensXWLoa+hUVxbdOY1y1b66zJ+E=;
        b=jdwimb70WfV676HsJMCHxp8rE3MIzui6DP2TqaqVdBcTATO1jr8OnJel6jGqPK42JP
         FTAiikHEKUX87/m1xz5NNAqvCw6OYNyEvAm1II6Ae8UWLR7D9v1rURCFBODS6x7RAaqp
         GsXdfXuOPpUg2DXPR7IkZBffG11zNFFn09yeyvKfpgjnq7IDDHcF5jMnxU2JnJRb8rqV
         /28UtFJqXtes5fMc1w1rfedlhyoRpkMQrSJzMpNM+Hw2kGhVzRnf7yt82r01z9EXTsWZ
         80SIReHxiA3fPOQ5A8McK92rLfZ80360Rz6enNNnSSYhuitNLdEylwqy66H0mEVyvDty
         n2lA==
X-Forwarded-Encrypted: i=1; AJvYcCUz7z7yt+YQ++8KJha51l/nrlEfkWGy44wrbuqOK/9/RVVUg9Fim6jAD5MHnlHet0OxVxq6Clx0ha1e6R0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeLPGelzdB4XIjsa3BvgnBGQWqbAa+taI4+ulIw6+VUoayyxne
	RPvy2SItFhWrlz1MyejG084PgFbLAcIFKrIL7RRjl9AvhDbcbaZaRqmHQT9LlQDxMOCQjxoafXz
	fBEIWGNj6WSWsY8h1KtYfOsfyp6FGQsTA0Yveknpl78aavki4XcJc1w5YaMT+FGCOUAE=
X-Gm-Gg: ASbGncuT+ttLxZ+yfMGffdp2TrQwYpcx43OPNlAoLgxCG9zpVKtW/mKUcjKwYszmG4a
	TFPvxj/KFhkRcId3q4QhatJ6S/IyxL37LUd38qIanVRCIEGVmzpBg/wiaYZIT2bD1F7K36BwmKv
	wxDiLbSo3UwasBEDOHfLSdD4y+MtSlDNS6X7daeMOfEhtnSFM9VS/yxwm6KWJPNjVe8it9Z3Nsb
	SkaVD4EplvDwH7b52Bjc1cIEcwPvEJ1E0EL+JVG0x1tm949IH2mK8GDo+eIDjp1IibG4B9iqpQM
	HuM0LZVwnriF/wQpsgkuBs+lC1t11LJ4uVr7wOeOsNyfChIG6YwXAxfc3HXxgi7AULBVqTONXZk
	yc/0V6KbbbwPO2lizFRFoVvnCewtBOLwj6hJShhVAHXtz/VFxwUiI
X-Received: by 2002:a05:622a:551a:b0:4b5:dd8c:1d3 with SMTP id d75a77b69052e-4c073d929f7mr60166631cf.77.1758307743330;
        Fri, 19 Sep 2025 11:49:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFd704pWx6mR4liYWHfvStigqH2zSqR9FouEegfxS0MAneRfE6nX5yLKo0d8lSjuQhI5Fty2w==
X-Received: by 2002:a05:622a:551a:b0:4b5:dd8c:1d3 with SMTP id d75a77b69052e-4c073d929f7mr60166031cf.77.1758307742681;
        Fri, 19 Sep 2025 11:49:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a9e1d901sm1499917e87.135.2025.09.19.11.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:49:01 -0700 (PDT)
Date: Fri, 19 Sep 2025 21:48:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v5 07/14] phy: qcom: qmp-usbc: Move USB-only init to
 usb_power_on
Message-ID: <zjegjucwluzzh2x56mn7dpk4ocmbdrhyvubkxprpiuko5cifvv@ygvbal3vpssv>
References: <20250919-add-displayport-support-for-qcs615-platform-v5-0-eae6681f4002@oss.qualcomm.com>
 <20250919-add-displayport-support-for-qcs615-platform-v5-7-eae6681f4002@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919-add-displayport-support-for-qcs615-platform-v5-7-eae6681f4002@oss.qualcomm.com>
X-Proofpoint-GUID: Qz_PU3oFetEv6-1yODKtaQljuBNB5DXE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE5MDE2NCBTYWx0ZWRfX8lK5KSiTW+yo
 nbVCHfBb/Z/J3g4ufFAJdV7yhCE5gYlkVT5WwlT3K9sBwl+lqoP8G1kOb9/HSaXObeb4kCCUHv2
 XsZttdlwuRXGqf0TqjK0EIfdO3L2EglfpcjojNp4w5aizEZoRj0CM52e5CQ7KNlKI302INrO6J6
 V0EWf+UidUXsy5ZAgCQ0gmlZCrAMThO7L269Ct0NBZIci04JWe4z7ZRUvQoHeSDxTNYD37Y3aSV
 Kjv0/ZuzrBV1rhUc7Ftslpm2MJ5cuu4DUQWxfz0kE4rLpeDUq2u+sV+SP9FEl52fXL9qiPkyM4G
 7auBjaYKQJTq/wPRUf/Gwwaxr/P6LQIo2CGlKdkVf0d8u2lnY3vrJ3pxkw2yAobuVKtv6ihnbuH
 hLC9cfba
X-Proofpoint-ORIG-GUID: Qz_PU3oFetEv6-1yODKtaQljuBNB5DXE
X-Authority-Analysis: v=2.4 cv=ftncZE4f c=1 sm=1 tr=0 ts=68cda5a0 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=0ERirU_vq5G6WO8xEvsA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_02,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509190164

On Fri, Sep 19, 2025 at 10:24:24PM +0800, Xiangxu Yin wrote:
> Move USB-only register setup from com_init to qmp_usbc_usb_power_on,
> so it runs only for USB mode.


Please rewrite the commit message to start from the problem description.

With that fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 

-- 
With best wishes
Dmitry

