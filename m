Return-Path: <linux-kernel+bounces-865289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BC3BFCB69
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B34A15060BE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C047347BD1;
	Wed, 22 Oct 2025 14:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H7m6lo4b"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B8334A3AC
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761144843; cv=none; b=Hk5QWz7nz6+jhTFXp7+rsUKSFRVyAzvCULiKFkOqKV3c5j6psa6lDcNEcGJwy8p8F3uc5YO1uqaVBRxPbE3RLxp80W9cyvaNE/lUMDGd/lI54GNfoQ+ZUFs46hvXrjQ7qPESlDAsB8ImsXeHf8DNYyH2M80eAs5Xde6cPi0eDA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761144843; c=relaxed/simple;
	bh=aSEOuyGeDRREyMKLRrB1/egW0lrvI6dtGdeS4KFmgiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G7apyuEe9WgetO4WvV98i9luirKWcUx2986qoVd7fDT4w/O8YYvnVCqJ4p+cSJaY5hJfP0UTS/PyHlLuMEEx1XNMyEvTL28+cQoV2U6Ovpyz7ygotwpDoXSjBDSNR+eBv8F4V/P1XLAJTiqPZcG5ACv8dF4HDYeonFXoNbh3t+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H7m6lo4b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MBhlWm029841
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:54:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i1D55EkVM9ROmsSy8YnVa/jnMbgKIG284477dKPaODQ=; b=H7m6lo4bJ9+Nvn6z
	ct5jbWjwmzbAOzaCstoLQBztO6WF6xC5WIt6ihDUfRccP6V/DKONApuU/GEsLr+I
	L77XyOkHno3F5887p+xcGVd5uBBjjW8CPCpQajeMbNlH7WhiG+KVPrMOQC6JJpaG
	0eUEl4QQ7rJKK1esggRU99FZHlXSqjl9Imok3MxVzqle3HdMF6LNaflLPAl9kwdU
	98n0CIA/4TvadIKNkA8uq7obz/SCmk1iZmLfcBhoEXIgNbtFnkg5sJ4CNepyfK+P
	ei05QVnTU6Ko8YsXUU/+NFE+5o6NIre4GfZ6y4q1ftPp+RMF8OaePEWaj+ogxRhK
	yOmeIQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2ge503x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:54:00 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e8aab76050so4471011cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761144840; x=1761749640;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i1D55EkVM9ROmsSy8YnVa/jnMbgKIG284477dKPaODQ=;
        b=ip3BcscKqFX2cNcNSpY0CXmIGG/D5Y6Y+f1+em8QMLXo+gu7bap3KofA9fYUlfGfpb
         Qg3Sp3EaU+gJvjC1E3ulZYheDsHqX74hk8dKnnm+i71TMl5qIBm41SiR12/2TESab/mt
         p+R2sMYhKBZDkQpeJnCrU0petSruj/rfo+PEmZ2rgoCc7j0wM6QucFqnZsfLnSykqoaK
         JoZDRFF3ATB+ojTlO2M2nSC7SWfZWpEmHR/BOZVHak1uTlj4tx2jts+lBgx/Tc2c4fmS
         CfUCJVMuBugTQUJFgirjxSEb/43OM8RYdXAspF0/ojMWBxtp/7T13v+Tgo1WsFIkLoAq
         fz+w==
X-Forwarded-Encrypted: i=1; AJvYcCWpeNc0GKwfiYWVPdHwbjEShqwEvZ8IE6d7/zttgweT4f4OBAs5EoGooZpyo39pelSxsAhXgLVzUT3+5h0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQCy2A7RlhLIO1XnkE8OCey3FgXi6uRFYXRrbVSVHzwycSeIG1
	TmZBoEfw7j9EBZeXwXqG2UUFrndeT21Xr9xaX0lFqQNN8NHANqnJQKnDXIQatgiL7elSp5N68bC
	L6ncpdRUKlHKFwkk04/AnczyMZHLHx32MnbzW4weQWIMEq7bVaP/rKJUri0wmt6H06EbMzQN6OC
	s=
X-Gm-Gg: ASbGncv4DLG8PTjJSrFbsC2NKRlSj/D9dDMTlAqPM8TfNdnFbqZ8oK7dTlAPTVormPa
	xGwVWbJpQWT2GqRX9ZKQz4ZXPbDgiIBwbT+I8hQfMpesWIoDF3gQNRsRB1x3445ltow1erDez4T
	J4WvbwPxO2wLdM9/flMveMt/ae/jUTP2lcE2CgsPTVTdJVlScxRgw6WKsaBN+xihYvEDYovYWTC
	pLl3j2N9IRE3g3UHxSi//DtjMq/8CrQM4wuyXc5lHL5ab7Tq+UwrYCELzz32gBEEzE/cUdZdzw9
	JAhAl3rknHJ5urbdt0LnUPsiBIMvLj4dFscYnxm64GemLwew7N14k1NpLw938PfeYGMZLiWaWhj
	R+RU6fBVdyUyvBwoHqzWzrBqOBjmAxG+i5oqzbt+vOvcWFZq7nZpI03K0
X-Received: by 2002:a05:622a:20a:b0:4e8:9ed2:78fa with SMTP id d75a77b69052e-4ea116a2337mr58384801cf.1.1761144839880;
        Wed, 22 Oct 2025 07:53:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYvZrPUqnLoE15E4DKPCHcqL6kLKjuVsKLcLPIxjePxERoJWVvHeMNwix7xgXgKYhV7otIeg==
X-Received: by 2002:a05:622a:20a:b0:4e8:9ed2:78fa with SMTP id d75a77b69052e-4ea116a2337mr58384401cf.1.1761144839366;
        Wed, 22 Oct 2025 07:53:59 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d3fb6a63csm25808766b.29.2025.10.22.07.53.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 07:53:57 -0700 (PDT)
Message-ID: <59592a3d-447a-4c99-8654-d3cb9b9f9a58@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 16:53:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] arm64: dts: qcom: Add DisplayPort and QMP USB3DP
 PHY for SM6150
To: xiangxu.yin@oss.qualcomm.com, Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, fange.zhang@oss.qualcomm.com,
        yongxing.mou@oss.qualcomm.com, li.liu@oss.qualcomm.com,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20251021-add-displayport-support-to-qcs615-devicetree-v5-0-92f0f3bf469f@oss.qualcomm.com>
 <20251021-add-displayport-support-to-qcs615-devicetree-v5-2-92f0f3bf469f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251021-add-displayport-support-to-qcs615-devicetree-v5-2-92f0f3bf469f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMCBTYWx0ZWRfX4Yk1loOq70hy
 GRNFopTrt/MUX5a2FbuZyMgKvcsF53IBqyxis2sT4MgzW067ZFA3YHq3IWcqB/PQ+GWrICiqfxq
 ZjdP3cOkb3vmt2aigSCZUfmaqDskDuPcU0Qtn9ZS9TgnuJCiHb7oHmaEeoHOuXBO4Mpz9+ElkoL
 8N6xBRPF+wsQtgagnbVbYs2BPHN9Jhf9VOupiVNADxhI+IXEDJfIXGwP2ctwPxXL4TBA8oZLbln
 15JYJVMxxY7RY3NpjAi2HOs4OzJUi2kc6615psiCShWWjauGwxDJjVWeHLhF46mpxzWGAkW8tUd
 0vlXsi8cCzGNf8t038A61KYnPilzHMNOx+u2R8DlpYfHIMx9bH0pZNSfne9JLp6eWoJXEX9SUjr
 36Z3Kdee20sTicfUhe0LXqatJKkQag==
X-Authority-Analysis: v=2.4 cv=KqFAGGWN c=1 sm=1 tr=0 ts=68f8f008 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Qc9Wp3Nav7UuNmgFpJYA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: Hh1Fj8tdcdPju90g6vdOATCHIaPFxPO8
X-Proofpoint-ORIG-GUID: Hh1Fj8tdcdPju90g6vdOATCHIaPFxPO8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180020

On 10/21/25 5:18 AM, Xiangxu Yin via B4 Relay wrote:
> From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> 
> Introduce DisplayPort controller node and associated QMP USB3-DP PHY
> for SM6150 SoC. Add data-lanes property to the DP endpoint and update
> clock assignments for proper DP integration.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---

[...]

> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +						mdss_dp0_in: endpoint {
> +							remote-endpoint = <&dpu_intf0_out>;
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +						mdss_dp0_out: endpoint {

Ideally there should be a \n between the last property and
the following subnode

other than that

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

