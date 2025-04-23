Return-Path: <linux-kernel+bounces-616241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F199CA989C3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 14:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 171621B672D8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 12:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB898632B;
	Wed, 23 Apr 2025 12:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H9M+wcqI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA734215F63
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 12:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745411146; cv=none; b=RVI/WsLiJYFQm8K18UymW0mexcvL/C9iWkQ1hWLjZ5cmt5sdyQTjHJLr4NfAeaBHLcgoRHZM4WX05K2Nz4OeDdJHz82SRYJGKUWTwjvqtWTInwwa7VEcYBq0JBDPsPs+uTznwz1F/HDjJfJBqS5R4eXS5AA/ZBSTkwcIl+zIWe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745411146; c=relaxed/simple;
	bh=Q2TQQJx49EZoqt+s+UoqOFRUn9Ry2bGHUuUAHKOsrh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bbn/+PUHM3DfFuV/txeqE975kxFeNfE8QGGJe2dZhr1chItyIjf6UGPZ+o9iWyGoWcU00m/YQRNblyo/C5hx0n+hJtQlRDF2pUcDW31d7FpYRd3xaXzxabnOw4BjoI8Qb1+YhFWU2hHMzm1zAzfkkRDnocYEVYNsIE4uOba3nVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H9M+wcqI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NApUm4014055
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 12:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t2kUl9QgvO/uB6b51hcAn/oawqIiVbquzPdGvE1gnSU=; b=H9M+wcqITMErLoAk
	nCZGjwKmkqvEHEVExGXss+3rF0Imtxhh59d0youCTSamwjbJnF4KWRQ7zUSdrdE1
	7TFGsNEVGYrvgU7GPSAkBGDhcmdGmW2kf7RFQOwCNIVYuHFB/axONCL/Xpu3mDzY
	x5Sc7cM/yN+ay62Mt11+v8EWNlxGfYR7Iiyl7WR0pbqkoeRaFRop8CyqcQg0fBUO
	5rRqoS83uZvcyLewGFkwOjxhZCC5kowdwcsm+9Y2rdMRdGShrSTIn9AuW3YzTmUA
	SUA75r2+1394TjRCzieHwQ4D8c/GDx0lp7SRa45EexVwMcSepdKPN3d6A+Vaiv/i
	QCr4cg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh3a2ue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 12:25:43 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e8fd4ef023so15110976d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 05:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745411142; x=1746015942;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t2kUl9QgvO/uB6b51hcAn/oawqIiVbquzPdGvE1gnSU=;
        b=jq/Y5U1fdFIzu/89tKDCUho4pLduSFvHvPmeDFC9xstP8ZimFM31NBfZKbhd0M4d7Z
         BXNYZ7JbKlCMg1HPWXnfF5Yyl4t5XusL2ry/AyUOH75x8jN6xuEjdhsCaffLtttBIMuk
         h49p9c2HqE9o+S65lMS+DcKpA+Y20xpNFXaBKoOrEsr6TZenkiBVKrPYy4oIkalYoTOO
         HTOdM8xHf5epsf4zzGGfwLH4iyvV6d0qqYZqmMoL/pRcb3kjiMwcTKBCSOa3snsQBf7R
         Ag8N56X6bEo20TRGcwzVo+F0tOgIaLiJ55Y9gNLGzSuAaVerWC1O/G4SxjB8VXzHGelI
         xSkw==
X-Forwarded-Encrypted: i=1; AJvYcCXN8ZO9YAs3N/yl2O/k8uQqdBb95NwU2jRXfKZZj70i9Htw8JeLFu1IUFoyJ/5n7ziwmEJV7Etg7SQ97hY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcfrf8sXBPZ+v1VXfVZnFzpx/gjYhSxIercU7hJjCr5/42yc1l
	ewQSogTtYRjgmA/f6anTzVFCGO7ECVYpMRqTA+Fj7XmvLar+q50sDnnsmiYHxviEYoaFXSYOuaH
	UUFpOroYdyxBnHN9Z2dWEAdb6mtIxfqDCyrf+wjW+9xVreMsghjkcMEI32d8APb8=
X-Gm-Gg: ASbGncuFvQcUT2twVK9hqtrkPa7wrEYDHFHP01HhTHHfV/JU7sodkM+cMeM7R3CDK1I
	8regy1QqMrufoc4TzhZZ5xp0VI9vFdTzpQ9EGEVTx+CzEja/FnqWalCLXQFbZKBxqU35SKEqx5G
	Tk57T/3ZZdMQ5ynfkoIP5dgPihzDQCtlH3eQbV/CgLN3GYzU86tuTGjpIrSHPzQJywXy8WLA/Ly
	KiBeRNdIaZKJ/7qouvv0WwnlSL+/VnNheQrDyYSWlnXmPROYzDYIx/ImazbnTyGs9hWsnoBz2Pn
	YC9GXN0GyYWt36WP6pdPnVl3Ux1oiZ6QCQ40Ga3mVO2jTBK5sLL/8bnf4q6/E+NK1eg=
X-Received: by 2002:ad4:5d68:0:b0:6ed:122c:7daa with SMTP id 6a1803df08f44-6f4b4715783mr16544086d6.4.1745411142447;
        Wed, 23 Apr 2025 05:25:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8oXZ9JnKtVNQzSjdw+36R1Viqv7RB6F1PrfW3UoImxkzoWPf3HA1/z5215kcW7wchhdalKQ==
X-Received: by 2002:ad4:5d68:0:b0:6ed:122c:7daa with SMTP id 6a1803df08f44-6f4b4715783mr16543846d6.4.1745411142040;
        Wed, 23 Apr 2025 05:25:42 -0700 (PDT)
Received: from [192.168.65.183] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f6255778b3sm7388108a12.19.2025.04.23.05.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 05:25:41 -0700 (PDT)
Message-ID: <8671d7f8-0d41-4574-a0de-aa40c1ed3c0b@oss.qualcomm.com>
Date: Wed, 23 Apr 2025 14:25:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/7] drm/msm/adreno: Add module param to disable ACD
To: Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Rob Clark
 <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Anthony Ruhier <aruhier@mailbox.org>,
        Dmitry Baryshkov <lumag@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
References: <20250419-gpu-acd-v5-0-8dbab23569e0@quicinc.com>
 <20250419-gpu-acd-v5-4-8dbab23569e0@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250419-gpu-acd-v5-4-8dbab23569e0@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA4NiBTYWx0ZWRfX+8YeQCF4xads sR2yzxaYSEnh5QSVIb6G/uFBF0SzH9IowZgChjqCjzs7GoLaMxqPjmegdPMsv/84r3Wa+ErAZe/ VYnJwlPQ7BVOWYheNsgR+f4ldEoRBPeTcn9xJqdLJjotoy87FujNjdIsqyoS1agIlwMZU2TiWkZ
 AtHkL1eMh9zELapnGjYHt0guhHe4stZFn/UlOK/vg/Xl3HldCuBSOHpql97OOFeuB/yoBgklYxp RcseRrIpfsPuCiSO2G7oq/7IFyhXbQqLviCYelnUgx0bBqK8uydGCPwjc5q1KPy3XP+8uG3+WjX se8V/8qCJmkuZdUbDOUpOKQR/Weyrf5s61bNXqhXw/oZbJNHyZFmwFoNIYxvIWkvFZok8aIVLXR
 AvpELqQ/2Mp5U0b+WVj9E38rMOi5koWWoN08pVBS32Vp1HTtrE8DYZTtUgB6ZBnMb77+LYQt
X-Authority-Analysis: v=2.4 cv=bs1MBFai c=1 sm=1 tr=0 ts=6808dc47 cx=c_pps a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=b3CbU_ItAAAA:8 a=EUspDBNiAAAA:8
 a=T2YAUAM4dRpUgQIxx5oA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=TjNXssC_j7lpFel5tvFf:22 a=Rv2g8BkzVjQTVhhssdqe:22
X-Proofpoint-ORIG-GUID: lvm9paa0qw-6IobqQQqr-NKqMhoxAoI2
X-Proofpoint-GUID: lvm9paa0qw-6IobqQQqr-NKqMhoxAoI2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_07,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230086

On 4/19/25 4:51 PM, Akhil P Oommen wrote:
> Add a module param to disable ACD which will help to quickly rule it
> out for any GPU issues.
> 
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> Tested-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> Tested-by: Anthony Ruhier <aruhier@mailbox.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c      | 7 +++++++
>  drivers/gpu/drm/msm/adreno/adreno_device.c | 4 ++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 48b4ca8894ba38176481b62b7fd1406472369df1..38c0f8ef85c3d260864541d83abe43e49c772c52 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -1670,6 +1670,13 @@ static int a6xx_gmu_acd_probe(struct a6xx_gmu *gmu)
>  	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
>  	struct msm_gpu *gpu = &adreno_gpu->base;
>  	int ret, i, cmd_idx = 0;
> +	extern bool disable_acd;

'extern' in local scope is.. rare but sure, why not

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

