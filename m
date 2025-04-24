Return-Path: <linux-kernel+bounces-617177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BD3A99BC9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 00:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B28A1B816BA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 22:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8896722F750;
	Wed, 23 Apr 2025 22:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mHK4LwmZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD2B21FF29;
	Wed, 23 Apr 2025 22:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745448903; cv=none; b=RxwC0BrbzSsEd93VXB7ZWLBi3djXg4JI9UqsFUe+k0Glr/ncWBoPGIBZgNlocHBPx0UeHNbaUVW39NFM66X7UV88RQPIH9fG3vR6wFD532SXoXVeDkQTKTOg3QbUefvLe4YGkPtPPrIfDgq7CI1pPRmJyMdJ/a4VjfV42+ZZikE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745448903; c=relaxed/simple;
	bh=cTt26zimTHQT4a8RC/zrPi54PEZCTj1Td8rNlVaYJro=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mn6FQVxc9lMsJggkwxVKQNHGGEXPcUTj0e+K0XBqsE4RHL1JZZfgNv3eYNXhJ66Dvh8QRriT5K4r495+Exz3Nm/rPujUZ/dmvDQSMg4o9bMZ7//rW8L5LGvHNmTBafRO9X7OdVoKcgFX0Ap9vdbJlw3meSc8kIub+CB5Zo6Fcqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mHK4LwmZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NLcV8S013853;
	Wed, 23 Apr 2025 22:54:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xWikESqioRfIAFYUYT9uxkIpYDASxQjRphX41aBMCrs=; b=mHK4LwmZSEaWH8cF
	EH6Z7lJ4er4bwCL7AicmXTjdfvRY23WgTiak7DdpD0Q78mXxAO7gPDmJVzDeM3YA
	ZdTdXfkl76pK1l2O7FBK91BMxeFQweBtCZmcBhtjfmMZXep01v4jCGsUWozNJnSs
	GlrfdSUH9/rRFUy16bAPhOESOWJgwFOMK4+zcRCcvWPtcRk3WAx/juuqhF8bSIqh
	1JN6Ji7+oV9lESlT/hg6siQYLRqlwPKFz2kZSQ0gH0EINx46Uokib1GJOlapq/h9
	yw79PIWdi+BboscDwRJRJ08i1cT2B1oIL3dlKBsKoboxgY1ZwFd4H8FeT0e7Udiq
	VPs2OA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh3bkhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 22:54:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53NMskYD017488
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 22:54:46 GMT
Received: from [10.71.110.123] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 23 Apr
 2025 15:54:45 -0700
Message-ID: <d7e2e8fc-faec-4619-aa50-87b078058653@quicinc.com>
Date: Wed, 23 Apr 2025 15:54:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] drm/msm/mdp4: use parent_data for LVDS PLL
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
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn
 Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250227-fd-mdp4-lvds-v3-0-c983788987ae@linaro.org>
 <20250227-fd-mdp4-lvds-v3-4-c983788987ae@linaro.org>
Content-Language: en-US
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20250227-fd-mdp4-lvds-v3-4-c983788987ae@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDE1MiBTYWx0ZWRfX4hLKxNYnpSSr yaCA3Zz017MsIk/gw3k3M4tU9CaBQ9XTtGGqPCWay0NxxdadEg07tZRthAp0yOmmr5KzYtP6ilZ A8hIxI8XkMLWfyrufDz+pbQY1WMzFXKHrvyWnSKzHB5o84CAsl+q74sHMkv9qvang/H326zQSnI
 kA4pAZsI65ptCHj3Uz2/1bJh21KedYU4aVj6Yd2PSJ2KumJ1zCBVU8eftJRcdk0yJNk2hcdRySE voDyIH6GyoXqMaQ3jCAz3xZVWPwqU46duuoyC599rKH3gQrXahwj0R5vgHRhbrORj/6/KMCBmJ2 tZHGx/FwMVsWgO0dY+mxmPZBE+fThMuWV0AOylcNN9y9rsbb2AUx/dOvjRN2QIqWwV3iUYfAXPS
 /oVMT7k+3W7VBTSgPVTFLbxNd08hvoHUDZ7hbrRNhBvuQovc7OgT79wcvVdGYNNXxkx6bO6+
X-Authority-Analysis: v=2.4 cv=bs1MBFai c=1 sm=1 tr=0 ts=68096fb7 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=rgZRmvi8jEFL0H6JymwA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: AMWpETZbfv92cQisTEF7Y1WXfmnOvugk
X-Proofpoint-GUID: AMWpETZbfv92cQisTEF7Y1WXfmnOvugk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_12,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=901 mlxscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230152



On 2/26/2025 6:25 PM, Dmitry Baryshkov wrote:
> Instead of using .parent_names, use .parent_data, which binds parent
> clocks by using relative names specified in DT in addition to using global
> system clock names.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_pll.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

