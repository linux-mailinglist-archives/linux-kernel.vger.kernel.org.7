Return-Path: <linux-kernel+bounces-617156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49470A99B63
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 00:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A47B17D7F2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 22:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826521F5858;
	Wed, 23 Apr 2025 22:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R8GRu/FZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCF32701BE;
	Wed, 23 Apr 2025 22:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745446753; cv=none; b=bs3BL9Wquxwo/OnObQ0rCMr7cFOJjhzwyUwrHeK8rh9KC7eteBGlTU1nElTxHuKBjc2WdXS3mo6LMcyp/bold9OsSt+IXgoeJToOuxkV58c/elF76JSz+RTossWFkB9tA4c1o50TE8H0MufUTvX9YokRJIN7h5rP77CGpptKsGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745446753; c=relaxed/simple;
	bh=rYr+FLMO8Xg1G+lV0iyTwUeWwT4OeaS/7qYyq1CMP6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=D4TkGW4gLKXT395pPN8GET3Xk17Gn8zFmPe/Wm32Y0jLhgZuNNSrReWjVOglS/yED0SCOK/u/PXipE5TDo7M6bv2t8URnqoP1IIJBDGfBt8id0M44SiE55ZaHHzHNhNMR/6lGO7DqzMXijIM0jC6mktRWjj36NLCuPzaTvcNKOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R8GRu/FZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NB6N7g024369;
	Wed, 23 Apr 2025 22:18:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oeUFxMFx6nrxzSXI/SkRX4Q1OugOEfgA+K7GIguWCd4=; b=R8GRu/FZJpRG5pEu
	DP+yW0+BmptsdIdEhA8Kz3BmbRimN/uSZTbyd0AjJPFpZtD8E0TwGE1bfTLab905
	K3GgTC20xs5DbqfsRQ7PoETWvq9oBDoUSaNW65vw+H9UjbmU4Hf5VKaDyJczwoXj
	oe6KtfJeO7kCIFY0xWs4NK4Zbc7VTjr9L7pf/7ZJf3bFAzm4cvsFJ0zlmGF+hrIf
	MkFY6j6O2qJ8se+QhT6MKNQSTiDZly9v2X0tBFaj29LvtK3PNs8jskAkohPuuh1l
	wXbdBnchR22SgD8qZmDDpY/rN7SKV0hJywainD1yOCkxONOI9bx3i2Ej0lspoQ9c
	0shSYg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh3bgud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 22:18:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53NMIwJF010406
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 22:18:58 GMT
Received: from [10.71.110.123] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 23 Apr
 2025 15:18:57 -0700
Message-ID: <d9ef9d85-7d38-4bfa-84dd-1ae0878aa02b@quicinc.com>
Date: Wed, 23 Apr 2025 15:18:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] drm/msm/mdp4: drop mpd4_lvds_pll_init stub
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark
	<robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@oss.qualcomm.com>
References: <20250227-fd-mdp4-lvds-v3-0-c983788987ae@linaro.org>
 <20250227-fd-mdp4-lvds-v3-2-c983788987ae@linaro.org>
Content-Language: en-US
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20250227-fd-mdp4-lvds-v3-2-c983788987ae@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6dLsYDGlO3Qdum4Szw-okUyxaD8VzboY
X-Proofpoint-GUID: 6dLsYDGlO3Qdum4Szw-okUyxaD8VzboY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDE0NyBTYWx0ZWRfX2F41hgkfPksM gfcjU69aYf6ZywdwH4bliHUyBHahqUuBEtnYsU518CKMqUBsSLe9Qg7moeKd0AWeQCdlfflQaUa lL+zdvGbusOf5GcBOQ4ZqZyTcj64ya4pbtL3Lm65hNBVxVr2z4cYjbomVokuXb9hgxYP5MZQFEL
 iuobVGS2cu2W3sHoxPtT7jixc/3GCnLcQjPtjjcVgVwn5vLb+cIl/GBkYLbeFF3hhkQ94alOJ5c O8J9vKyT002odTAk70Hbl3YqVSCTCaBCkKcdMgeNEtSPaobqOnAHsFpIOjAhGTwgQtxBaWaig7D 6ea/X8ptVga65oYUJaV/GOxwMzhbS2J2gkFFXSKqKcavKx797aoYTuBOX/hVCZ94SR4OvbpaR88
 aPDZcUMaZQxsXv7SWf2sn59M+/x66WpTcjXKUVKtiAwhhzOR71zczLB6iM52pPRe2EMghNH7
X-Authority-Analysis: v=2.4 cv=Mepsu4/f c=1 sm=1 tr=0 ts=68096752 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=44wy0eceGWqoRLgzOdEA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_12,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230147



On 2/26/2025 6:25 PM, Dmitry Baryshkov wrote:
> Drop the !COMMON_CLK stub for mpd4_lvds_pll_init(), the DRM_MSM driver
> depends on COMMON_CLK.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h | 7 -------
>   1 file changed, 7 deletions(-)
> 

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

