Return-Path: <linux-kernel+bounces-889996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D188C3F085
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FFCC188CB9B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669FC2D131A;
	Fri,  7 Nov 2025 08:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eGoLrxx3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BhyljdKR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7BC2236FA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762505543; cv=none; b=GGl9CIok2PLJ2m4Lxzx2tSkiq6TWZMmLVvtO7wFzwnUkbvMfXG3yRgHBM+WGjYj6wrlKzF/ZBeKMMjTGYfut0wwR/ndDfykUrIojt4D1qkD/decU7vJJ+vKtmsG7XNPYJ6f+TZX73T5kKEZcU3LwhROs86yjnLpzglqrNWhOOpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762505543; c=relaxed/simple;
	bh=WUI8aI9SboATxAMC3sIcJDvYj3bfuIckkF3N8VBA0fI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dxNIiaunKXSalH4Zs8WEJyiQgS6s/yYoaNiq5YityzECyGiMXxxMdCTlQL+Nfs8Glm7Pa4bUXFNdz08309h+kKE6oHz8BEdU/vNKY80MugDOIcAyFCjA4BUpyoWCpFJXlXrtz2P6iZ3mRgxUmKxfVnUfDjbulqVXG3DA/unsuqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eGoLrxx3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BhyljdKR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A76wKlM629380
	for <linux-kernel@vger.kernel.org>; Fri, 7 Nov 2025 08:52:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WUI8aI9SboATxAMC3sIcJDvYj3bfuIckkF3N8VBA0fI=; b=eGoLrxx35ZUoDT9Z
	ojzyFKD3egXl3TYbOqb4VCjB3J5rna4/qatWTyyJvhBZdNYwu49xzA3H7IGfRU99
	4Au1rMkZyH6V3+gsUEUs/IgdbIkefAOznBM0eWlB9voKiDQSwHf2opkxtWtEAIy6
	5i70dPmGLLoeGLNn5IhsGllk4R0VvcxNoy2uvUd8HsyqcLButSzbnQsJwFUM3Yno
	Gkc2SIl+Q5chgk8GapalxY1FAKiaz0jovH8UsGCbIj6lP0cEZPFcRsiI4lYq3dUr
	XZcLK/GzFg1hjwaasZiLLTe3gwS4oluiLNmxTrNSHXkwpLLxFPYUzvj/agFM7mrb
	LokUKQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a92231xmj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 08:52:21 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ed6317be8cso1802441cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 00:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762505540; x=1763110340; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WUI8aI9SboATxAMC3sIcJDvYj3bfuIckkF3N8VBA0fI=;
        b=BhyljdKR9/oEMBUw3SJmohcWbR1iQIX2pmzTQMzatRhJ2aKrTW9XrtKnEhkAuXjYjc
         ySKQ5tQHnlPZphx1CEgSWDSzwtCUL6H44imlV0NSZTaNjYP/Njck4YWItMMM1wqQPAiZ
         0Qe+FOkNUXyH+IYZTGY7V36rEv+H4X8VwKfq1nuuu7sAR736yUqU9bOKASVH/owEAtA4
         c79ckOnR+AGdzsjsDNEKfah/a3/VuDax3DGi1v0r4qPsRLqySayxfmdSyY/J8MkN9PI3
         10aK74nvn9ZH8zzlkjVlKQ7yl2FMLxtUckMvsgXT3iPQje+FQT7zTaxmteZ5ZRphlTjf
         ZBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762505540; x=1763110340;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WUI8aI9SboATxAMC3sIcJDvYj3bfuIckkF3N8VBA0fI=;
        b=hY2+yFvohLj2Fj+OyVtutlRNdIs6JDFX7SmMYyUnsgVMiygOpx+8teLWAU6nq+7Hlg
         VYI4QfgG62QhVQ2kp99UL18l7uRcYTofJjALbcrlnYzTt4mC9FfQfo6gDBZ3G7v73kiF
         62uy/S0ln2dYGDGIgbrHuCx8lwzfq218s4D2DjL9sv+pV6NTE4jajwouXqWWPFhWvbIc
         zfDhCZ8wHIrWte7K2vB44w3OpiPbQlUawWOyz4/6Yi6VFsyIR01KsAW2Qv/lGQBnA/B6
         jI7Yx5qfAJSPvwqpWwCvTnidJIf4MOQC/cOLk+xqja3x8EfCLabUbWjVJeVH4eAMGaDf
         f9cA==
X-Forwarded-Encrypted: i=1; AJvYcCWltsW6+oXj+PqVMh8bDAdrpcE67augLWv8WMZ5bAf9CXaTDR4meoTV7WcfdyGNHH+mk6iK2vCClaAyZJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwhQRBrmwcwRrrCdlmeksYdelEMSmOeELjZpZF1sCHIevtUdbm
	Sc3FQBrBJQ9+7PFAHdXEiCdrdS4sh6hBtqK0j+boxpM3ZGaT8QlD1psdIkr/7vpckDuy9Cbb4Bo
	wtIvuW/d2HijnUko2SwSsgzlVLjuhlLVjVc9cQJ6M1q7h6vOrwkdxe+MPuT3qbCrlYCgsJmygXI
	8=
X-Gm-Gg: ASbGncuTvyBusudr9843JCs3+B56/McD1nnte00ftZpzviGOiEGuoyRQriVRm260Xi5
	sWoOfdGDSOfay0GbV/4dOuHKUp6J2QEAXiO0kD+rO0cYJC3MlHqofCY0LSpbMyWOi5+fLkMGmyj
	s+u1pGL7PNNgJYz9wSLApXQmCReDdY6miqQ81wWSRZehe/UANbsb0eo+aFRrmLUowG5qQTyGZ+F
	lVgpLCMKPvTasrg3+fOGZlnz/Ao90B674+VtR0mi/gVXDprX4EvIGDySgTBTjPchlBF4lrPeAUn
	ajj6Vp9OdaKUALKMPnlM9Dg0jIjeSnfSzai9u/FR9izKNtewiJ+ONvw4BBoyBPOQupPIMv0OaP3
	LYa5XVfnKXtbxwpn5aUQsK/o4jZvW9/epYpJ5WeJIDJGIbfuuJB0KRFVU
X-Received: by 2002:a05:622a:24e:b0:4e8:a001:226d with SMTP id d75a77b69052e-4ed949f2c3fmr17320081cf.7.1762505540424;
        Fri, 07 Nov 2025 00:52:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3kG67QsZQNvhXXJLPvhwblVTCY2za9wLcF0KdPzPtUN0EkUbjgVeOtcVYxRajcJ/PwybTKQ==
X-Received: by 2002:a05:622a:24e:b0:4e8:a001:226d with SMTP id d75a77b69052e-4ed949f2c3fmr17319881cf.7.1762505539996;
        Fri, 07 Nov 2025 00:52:19 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf9bd741sm177667766b.57.2025.11.07.00.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 00:52:19 -0800 (PST)
Message-ID: <83cafa2f-8fc3-4506-8987-1b5e10d8eff6@oss.qualcomm.com>
Date: Fri, 7 Nov 2025 09:52:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Support for Adreno 612 GPU - Respin
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jessica Zhang <jesszhan0024@gmail.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jie Zhang <quic_jiezh@quicinc.com>,
        Jie Zhang <jie.zhang@oss.qualcomm.com>,
        Qingqing Zhou <quic_qqzhou@quicinc.com>
References: <20251107-qcs615-spin-2-v2-0-a2d7c4fbf6e6@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251107-qcs615-spin-2-v2-0-a2d7c4fbf6e6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA3MCBTYWx0ZWRfX2mDrcqyamItd
 kj7/jbDhnlQCLqjlx7uQ3E2y+uuyueS/iZGyZhA+wniWFwxw+ARF9nEdWVUWH2pwiwOxmg4/Y76
 uJnWDGymtea6WTBwYppJoetVqL2hWnaUcuRI2LEvn5AbVaypo0DFlyVCQVO23SuzPx1Jy+ERebA
 /0J2JO16jPylpCxxT4WRRjTdIQ9+2wxJPaC66j3M0FKZYYlBoyzbOSqpB0kiKubG1BMeh8/1R+A
 runNzBj1Jza99j+0Eq4N9kwGhfGm753yyaDZCZhePK933icTqq7OXvU9vzMNM6LzdU8KQzs/NsJ
 jSPKHhoZUsQodICCpDEWP/R8YfECl3wj7urOdRWrjJMBQAnw+V0jy6X904+HSTzLFquQd1Osp4l
 wB0aM+Wn0qLPU+Gl9ZxwmQ5DGSh03w==
X-Authority-Analysis: v=2.4 cv=Csmys34D c=1 sm=1 tr=0 ts=690db345 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=glulLz7CSyDjeoE76BMA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: I-NHkaIRVpJHFcuHBE1NVx4LTgrDLuZt
X-Proofpoint-ORIG-GUID: I-NHkaIRVpJHFcuHBE1NVx4LTgrDLuZt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070070

On 11/6/25 9:50 PM, Akhil P Oommen wrote:
> This is a respin of an old series [1] that aimed to add support for
> Adreno 612 GPU found in SM6150/QCS615 chipsets. In this version, we
> have consolidated the previously separate series for DT and driver
> support, along with some significant rework.

[...]

> Changes in v2:
> - Rebased on next-20251105
> - Fix hwcg configuration (Dan)
> - Reuse a few gmu-wrapper routines (Konrad)
> - Split out rgmu dt schema (Krzysztof/Dmitry)
> - Fixes for GPU dt binding doc (Krzysztof)
> - Removed VDD_CX from rgmu dt node. Will post a separate series to
> address the gpucc changes (Konrad)
> - Fix the reg range size for adreno smmu node and reorder the properties (Konrad)

The size stayed the same

Konrad

