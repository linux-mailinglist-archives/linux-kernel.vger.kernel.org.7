Return-Path: <linux-kernel+bounces-813634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4295B5487E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6D66188E03A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BADF288CA3;
	Fri, 12 Sep 2025 09:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QHzpERss"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61D027A93D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671008; cv=none; b=q2kqSN37wrwlYD2TAjY9WAiT8MrdmyUJ2Zt7dDzimt4iO31V5R1yGDQXjdUZonZNGWF6wNXq7I5A5nL8Bh3N1VgnjyprFRoUC2NuMCLnlaGxRvfdjyGkPQqPiLsyAg02PixO/SG5Z/hapgP1Pk9s2hzTo7ZBI1yyWH1EOfbChTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671008; c=relaxed/simple;
	bh=SlOs1DS/YlC686LAlZecB5zz12ropOMVG2osPw6RNW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlqlXoaobgzykN0G63nnd1RjQW9V3e+silwS3YiDDAC4pCOCdSLzv03PieXmJdhcd+MoOK4YYOgCkM1mhSR41gRFvsfAhR4O45DmH8aIRZrYfwPs/2ge9d3+QiCoOYU6Ky4h3bxsXK1WKYs1yhx+Qfi9eNWs44IEpIGHOx8BPu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QHzpERss; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9faQW011151
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:56:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=OD9Udd7rbiexckZHIpahTYqB
	LCmCWRywICtA7wRkc1o=; b=QHzpERssArGdpxOQxFRxqzVwLfUS1u4bDarSxvg9
	e8jIYhrccYF7cecxuM0xPfW4v0nx8yrzK9OWVW57dfQgyvi2gMY6IvGw1DPxZfj8
	9MA05eP12GFFEe4N+yFUTnbPASptLC+grOZPNEhbM5mkOsIHcQbPVw/r6YZc5JhI
	XF7BGfqr6yghI1d+z9x9bXKUx/rUifwwBStb3cECb2UJb9D/4syH/gAB/lKvpEUT
	4X7Hn2D4viFh9INnrBXQPhkzG57ts9lJY3/zXxI36dFQicdshP3vAH4WwpCUURY/
	+YtFtceIBMW5bW6p9EZUuX50eUgVdySpPTPElq78/fMxGg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e4max1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:56:45 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b345aff439so49481841cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:56:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757671004; x=1758275804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OD9Udd7rbiexckZHIpahTYqBLCmCWRywICtA7wRkc1o=;
        b=m+NcKMq+fB39Huuo56J64OU/ELq8DZ+DbUnDe6g/b6O9lejaa05umoGNlQ4jLe1n9n
         x1P84wYqQXaR6TCgEMV/OUyH0owYWmvrMWKMv8nhKiK8QBjox2qWl4hQge6WdxbK3tv7
         xv2dU+xvTnwb4J2DM2x64BuXC8NTDt3jo/E9pBD1pfpJVJUXcsC0PZtkF77JPX8SthEG
         XgoodYX0kdKmdtRDeAfhFImc0lrRM5xJ8QX+YLhK1Q2LnAz/YHnibfKc7tWjhUwBQwAZ
         qYFuFtzF5FZBkdUEiGwlZxJO9qyk8d98oNV2RlyXHV4FZ25FU+u97/gMWOysZLoWwsYL
         2xJg==
X-Forwarded-Encrypted: i=1; AJvYcCWgSsI+wkXbFHTwpLA0KGPRDwRCknIMSKWRhkJEOc1D0QK8N0LesKtvMsbY0p4lMtRs3UkXa6mdUGaYwuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAPBccP8UVH3u1FHaQgTyKEjWbVqIsfBo3cKDJ1huW1Scs/08z
	q9DycaIdHGQo5OdxUminoxnJFvKIJTzf0DH7uNhaxudbVHAx2UYoeSyJ3SeykH7/R9/TxgT3k9F
	ZrcHIjAtO90pdGZn1HWKCBmt99d8w78ehkMGV4eM//K0FUF43KTWQl7XegTXYsGQa3Ys=
X-Gm-Gg: ASbGncvp27zgcDQ+efWsYOctck4Sfv8pp719S0WnlKtJfLf4k6iybDqSYK1wbxDw00y
	9IUdFgDqHWAvmE/Et+O4uNtajsHywgD5F0LlWuh+cm/ymANfvUe2v3ga6A++QuDN3Dg6omOgAPG
	8Tv6hyPsLIKU1RX1CMyXZDOFzfr7EwSb5gUwDVfgcqFjNfz6pvmXrc48yo2nNfDOOIM+Pk36cYM
	J0h50viid4K2dAWIU95maRufEZi757bmNBqIc6Uv1NKu6FbWJUDnxtpe9PQtluvmZdR24w8BzOj
	oEsH/Rfx9Kma0dBzH/KRwLcC4BbkhkH/5g4/JKDAs9rCz3D9sWpbFjnrQJdOIU55zAGnuwmtd68
	m8Bo8fhegM00THxOglerhcTpCEbBvmDG8R6IGIdajSbI0pbybWed9
X-Received: by 2002:a05:622a:289:b0:4b3:f3b:6b14 with SMTP id d75a77b69052e-4b77d1d50b7mr29032751cf.79.1757671003826;
        Fri, 12 Sep 2025 02:56:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrg+eZkUE6kJIyOVqREfUPXquzVktUgoDHxmRV3RNRm2kAXVXWPWukFFYePEL33rxXTVJhig==
X-Received: by 2002:a05:622a:289:b0:4b3:f3b:6b14 with SMTP id d75a77b69052e-4b77d1d50b7mr29032261cf.79.1757671003214;
        Fri, 12 Sep 2025 02:56:43 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e63c63e3csm1057056e87.83.2025.09.12.02.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 02:56:42 -0700 (PDT)
Date: Fri, 12 Sep 2025 12:56:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
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
        li.liu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v4 06/13] phy: qcom: qmp-usbc: Move reset config into PHY
 cfg
Message-ID: <ejwrkogssqdzxraacvxdbasxg2ud4t53rb6da2g4vdryyjuzoi@evdibveq7w46>
References: <20250911-add-displayport-support-for-qcs615-platform-v4-0-2702bdda14ed@oss.qualcomm.com>
 <20250911-add-displayport-support-for-qcs615-platform-v4-6-2702bdda14ed@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911-add-displayport-support-for-qcs615-platform-v4-6-2702bdda14ed@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOCBTYWx0ZWRfX09gaTrNhB0P5
 cpYmX/r5oSV6Sy/dHmRPvMOXUFd02h3g+iZm5NmhvTJpimida0B31jV5LO+x/OnhCRGgKLg1DH4
 mT3HaBV+zwlT8hvjqkm5MDHOfiDYzmSp9RNYos9rufw3dUFZFp9Kl6u8LDNIY41myPTAn9FMnAc
 3oLPVKi0E/zZxq1t24y5eFcsDV+k6R1L7GF1uHb+v5X5v0FhlC17uruCMv+Jdrx80jbsKNMK5ql
 zqbH2lpeo9gFHikzWJjRV1eDRRCA+/jjFjHEhUBx5Hz8d/xT9GYBF4sEFOUT6UrCDLzZ4H+Mksd
 4Qjcd219XkByQeBrygxmXIra6lxe2AExMTGiZV/MB9Mjr05+ltGyFb5Lw48KkS4whbGgAnvcT4v
 QuS59+E8
X-Authority-Analysis: v=2.4 cv=J66q7BnS c=1 sm=1 tr=0 ts=68c3ee5d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=kgVMhnFeOIEbK27hWpcA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: uPDieOCEL59Hc831ZixH-HSmkTTwnRST
X-Proofpoint-ORIG-GUID: uPDieOCEL59Hc831ZixH-HSmkTTwnRST
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060038

On Thu, Sep 11, 2025 at 10:55:03PM +0800, Xiangxu Yin wrote:
> Move reset configuration to be managed via qmp_phy_cfg instead of
> hardcoded lists. This enables per-PHY customization and simplifies
> initialization logic for USB-only and USB/DP switchable PHYs.
> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 56 ++++++++++++++++++--------------
>  1 file changed, 31 insertions(+), 25 deletions(-)
> 
> @@ -1147,11 +1159,6 @@ static int qmp_usbc_parse_dt_legacy(struct qmp_usbc *qmp, struct device_node *np
>  
>  	qmp->num_clks = ret;
>  
> -	ret = qmp_usbc_reset_init(qmp, usb3phy_legacy_reset_l,
> -				 ARRAY_SIZE(usb3phy_legacy_reset_l));

You can not do this, it will break compatibility with the historical
DTS. Legacy code should continue using the old list of resets.

> -	if (ret)
> -		return ret;
> -
>  	return 0;
>  }
>  

-- 
With best wishes
Dmitry

