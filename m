Return-Path: <linux-kernel+bounces-628088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A26EFAA5902
	for <lists+linux-kernel@lfdr.de>; Thu,  1 May 2025 02:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4183A7B018B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 May 2025 00:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C2729408;
	Thu,  1 May 2025 00:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Xu5SlSW2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B42827702;
	Thu,  1 May 2025 00:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746059100; cv=none; b=iGg+zPw+owk4p1ZU03VDCwWcLCcSRy/tQXpIhbIuwYyOWaPPLvQEk4eRfstBQpCWav93sy+XYptYFsG6RYTUrbYI2T3aVNGXUEMGzgqGEAzdvykiVEKkKAq0ue/4hBhdvk57SymwOEKAm1yQqgJmnRv6QBLjsrJouiMzD6fGGR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746059100; c=relaxed/simple;
	bh=xJ2UDrd4cgIKttYhNbDkYA5wTDZhtVAJ278Aj0uJS1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=d3ABojNdYB2/NFrnNACm/IcEAr+rYXm9z11Y0anYstYjrGRplN1JZ8lBjtY/jlz7mo81Z9+9HPe4TTKx3PMp6JRax0ExgXkfAHCw9kgUsgyIASlcvnsGgYtE+SjsFnGjp3oCBhQ119Kw0qtAygkZSYENc4LRK/LSRjlmkkQPAcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Xu5SlSW2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UGkGoE032198;
	Thu, 1 May 2025 00:24:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fQVcRy3VD1YE8fp20UK6HgnnUXx/XDq5SUQiHFy6HAs=; b=Xu5SlSW2uFtzbjd+
	1MMkHgcQVZ+x/3citZrY/idaAKlTD/dXPQ/DZxAGCoNWeXUQPGC3cN9AZOVbbIB3
	zjS7tS8Ue0K4yG5cGpFxBnNwx3gBKi6LIESFKKevcn7u74t5H6mijRn2dIbaJUAI
	zvM60P1M+CZ1xWn6uw/YQ14/sHvWIdjxUKpmtHelAbnXhm0k8H7VY/cTI3diUFmj
	fK6NQzaKWlZdLz+MqBjleFuAeC0LzdqVSjPiqHWXGUKE8OWrjTn0jWCKhSdoS20/
	zHIGmI3YqHzoTsYAtMRxF9ySpCnl2xM/C4o1yAg2mazsJrPdHUem/PMhOLv4oPwK
	U7frPg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46b6u74207-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 May 2025 00:24:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5410Ogd5000437
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 May 2025 00:24:42 GMT
Received: from [10.71.110.123] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 30 Apr
 2025 17:24:41 -0700
Message-ID: <8a5970fd-8ebb-4ed2-8276-7b5ad4ec2f9f@quicinc.com>
Date: Wed, 30 Apr 2025 17:24:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] drm/msm/dp: Fix support of LTTPR initialization
To: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>,
        Dmitry Baryshkov
	<lumag@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <freedreno@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <dmitry.baryshkov@oss.qualcomm.com>
CC: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        "Marijn
 Suijten" <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        <laurentiu.tudor1@dell.com>, <abel.vesa@linaro.org>,
        <johan@kernel.org>, Johan Hovold
	<johan+linaro@kernel.org>
References: <20250430001330.265970-1-alex.vinarskis@gmail.com>
 <20250430001330.265970-2-alex.vinarskis@gmail.com>
Content-Language: en-US
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20250430001330.265970-2-alex.vinarskis@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDAwMSBTYWx0ZWRfX29+DyCd2ybxL FAuUHkGoyITGT8DOdJ0NzNpCf2qq/1obdZEQdx19EO36nnaxgugXgC6fFV0ytbUvB/VZCaJFeL/ EUbUTCaDWsZaY+IhcmjW4ntd+TmzZz3si1uIH42YrVtSU6V/FzXlIsRg6NCM+dnGAlDs4cs3gMP
 ZETFjT16vvRG6Jem3lT5EyapDRETnXj8sBRYg8+c+FXH2J5qTIr8hpzNKoTdAd3LsGge45VMjWf qT+FwLPfa2zjDSSj/qNmzE8XSdPTlTRwfeKLWXWg3hu5Ruhi9X9k9tBhFUb/9E6+QcZwqfhgnQj +GVcm9OHBADAJYxGe2zQosMdDtaKrpfNMwg7Oio0gO5A7ou2Iw61ZcFNRNM462qnV9raotkG58+
 YpJS4kC6883qI+e2S/oA3y8/pZ7GwVaAs85Z1vMebexix6DYrni6aHGA6vxEQ1VOHskdpNic
X-Proofpoint-GUID: -VhTn66j5ouY_oBGADkIN8tq23UU_MP9
X-Authority-Analysis: v=2.4 cv=W404VQWk c=1 sm=1 tr=0 ts=6812bf4b cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=3OsKONUXKRe0ri03xkEA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: -VhTn66j5ouY_oBGADkIN8tq23UU_MP9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 spamscore=0
 clxscore=1011 phishscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505010001



On 4/29/2025 5:09 PM, Aleksandrs Vinarskis wrote:
> Initialize LTTPR before msm_dp_panel_read_sink_caps, as DPTX shall
> (re)read DPRX caps after LTTPR detection, as required by DP 2.1,
> Section 3.6.7.6.1.
> 

Thanks for the patch.

Small correction: this is section 3.6.7.6.1 of DP 2.1a not DP 2.1


> Fixes: 72d0af4accd9 ("drm/msm/dp: Add support for LTTPR handling")
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
> Tested-by: Johan Hovold <johan+linaro@kernel.org>
> Tested-by: Rob Clark <robdclark@gmail.com>
> ---
>   drivers/gpu/drm/msm/dp/dp_display.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 

No need to resend for this, I can even fix it up while applying,

With that addressed,

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

