Return-Path: <linux-kernel+bounces-626209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 412E0AA3FF7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 03:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80DEC1BA4E96
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 01:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6899A10A1E;
	Wed, 30 Apr 2025 01:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NEkhqHnF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9CE2DC79A;
	Wed, 30 Apr 2025 01:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745975029; cv=none; b=WoDWHFrkQqn3bgq5RetyfbF23eBdRUKc2123bgd/CagVruxpaqFlBN1tf69lmt+klUvkiuKJi1x7SLcIVoP0MjNMDKe86I5wPYkQmD6WTld00eNicMOAjxe9FHcy+eFQBL3bFoRuYhA4+aQX1WozOXPddUFPeJIii9SEr+glGkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745975029; c=relaxed/simple;
	bh=WGkpNTZUsK7CU1xL3gjLJERNuiZl8dOwUAb+SUP1Ig8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YpYP1L0Bdh/EDdsw/ZO+nqMleA0X1aQQcy2Pj0Vfq7lAoy3ERlSIx1+EV605UGtS+9sLfqn3BADlWvw6dSKKLzwXuDzbTJco3itBjvht2iQM0dvzaoN77m/S4a1AWDaQXOnt3fi49KNX/DotuwKdXaknmA/hewk1cbnlPLm0l3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NEkhqHnF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TLb0HA017451;
	Wed, 30 Apr 2025 01:03:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bAKObRc30JspqidXyvLoAP4jdwVTBsyhDzP1ky/muf0=; b=NEkhqHnF/kW58ChE
	M7Xt+CQf0AqUv7fe+UulAJYKcKNjQs8VGEPCTdD+gfYk3rSnFVsGQhZaoHNKnSTk
	33lIRhXs8yVI16t7fOKjtA+KLVEqrCpaTBFNJCweAQ3kdKXMqFPY8g0xVwzHvBbe
	350yC2DT95MnqcYLrQsWL3/nSDsIxomJ4qtR3y88cufTD8tNTYas1KLiHuQ0TmLL
	cHfgoh093CvwTQv1w+f1oj6qc4QWcH6me6J27Qm2zXWI1DogPN9zQoc++ee+K1vd
	QvE5BgGkMz1M5/aOnRi722XKZ8VK/AAI2jDA60b8q++pTKSNU3+frsD1BUl8u2Ol
	qPrtlA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46b6ua8bx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Apr 2025 01:03:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53U1391a027862
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Apr 2025 01:03:09 GMT
Received: from [10.110.114.218] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 29 Apr
 2025 18:03:07 -0700
Message-ID: <cd88b992-5d71-495f-a0cc-8ebc07544117@quicinc.com>
Date: Tue, 29 Apr 2025 18:03:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/msm/hdmi: use new helper for ACR tables
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>, Sean Paul
	<sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        "Dave
 Stevenson" <dave.stevenson@raspberrypi.com>,
        =?UTF-8?Q?Ma=C3=ADra_Canal?=
	<mcanal@igalia.com>,
        Raspberry Pi Kernel Maintenance
	<kernel-list@raspberrypi.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        "Neil
 Armstrong" <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman
	<jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "Dmitry
 Baryshkov" <lumag@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <freedreno@lists.freedesktop.org>
References: <20250408-drm-hdmi-acr-v2-0-dee7298ab1af@oss.qualcomm.com>
 <20250408-drm-hdmi-acr-v2-3-dee7298ab1af@oss.qualcomm.com>
Content-Language: en-US
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20250408-drm-hdmi-acr-v2-3-dee7298ab1af@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=BNizrEQG c=1 sm=1 tr=0 ts=681176ce cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=ZDreyfFLjIJ5M6uCXacA:9
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDAwNSBTYWx0ZWRfX3swtVQukh+U/ yn6eLt+ll67OoW8sU81QSjytvoJfn8AYb8UX2DqKjnZhxob09xSmT7oBb1XXpBPOchwj5onOgAM g61g5L14TwliACEnCps2gcQ7a566tx3pMMGGsu9jJ8d0LOoS6C5TTJbd/aMYjs+sIs/jDGxQmUp
 hViAQEUHMG/ILeUeeS4TXnEEsjN30s4azxmtMpnIePzCIe+WQLDcV6vW+8Cfe/Ev2+PXuIVZjMt RKgfwPJ8Cpycge2E6uz1WCExmTxPWVgoIH/yRwkPCw86KkQZ1i0pf/RwrvNody2AhxRdTJtV6OP mhEaljGXWWfFva2H9ErUhEuEq0OMnU5MuOmYNp0a3UO20IlFN8FfnZgXpvmQXM2Cvu6tGBBPtYv
 8uUPTn9V1USB8R+J9/spn++NrwJkFAiZ9uaanluWxeGVlS96Y+LvrVuS92T3MrcKbnNtxvZ0
X-Proofpoint-GUID: vde4wTqUCmlvS-pDbeysOkYKQSAYRv5b
X-Proofpoint-ORIG-GUID: vde4wTqUCmlvS-pDbeysOkYKQSAYRv5b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_08,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=674 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504300005



On 4/8/2025 6:54 AM, Dmitry Baryshkov wrote:
> Use new drm_hdmi_acr_get_n_cts() helper instead of hand-coding the
> tables. Instead of storing the rate 'index', store the audio sample rate
> in hdmi->audio.rate, removing the need for even more defines.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/msm/hdmi/hdmi_audio.c | 107 +++-------------------------------
>   1 file changed, 9 insertions(+), 98 deletions(-)
> 

LGTM,

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

