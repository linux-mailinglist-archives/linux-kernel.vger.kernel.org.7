Return-Path: <linux-kernel+bounces-735220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D51B08C48
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D9861893520
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B52D29AB02;
	Thu, 17 Jul 2025 11:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jIP3C2QI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB07288514
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 11:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752753571; cv=none; b=aiSjO5MSvG267sP2lYK08mRs5T36ungTGR0BWFTGi5SOEUurdgO607BfumgwSUTM2SmoOFWM+LxIqWa+Ihd0FU8oeRmBLxeNDDmEMguJkWq+IDTa3JPxEP6Gi2uaAAycPYx47q+DKuOxEObBYycirBHYumVTBK+1JxcIONB7+b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752753571; c=relaxed/simple;
	bh=VlfFX7mQA7obeq2af9paLgAuGzTyy1CUXFA7pbF06DQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aLH1z3be9wNQyt1NKDLxqeprYKN/PeiZWNSTlHaJECmzVKqf6y8X8Bgl5JgSDJ43M5Wy7i7c2tecXATvHSHvU1gEm4JUJyrowrLqdeIEweQHwNfzjBryqHxADcxEab3hCctGLGpMc5WU+YF1FzLGCQpbr/2z4ljGMMU8VbwxUlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jIP3C2QI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HBhVjj004464
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 11:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RC8QbYC4Tyk41SorqPKs/ueg5eS7morHmOcMxL4tVz8=; b=jIP3C2QIXyVLjSaR
	yX55JQ1SrF93rBkCLuiB1OXShnGwp91XaeU8spdoPkx7fYmiYJgQ4a86rNngqmM5
	K4gzrdpDW7OrciMD8mbHg3BA9XYChHWJTby97VFNc2w1tI6O93vvoe/Brdi2d62b
	5P3FF9jcPmcWaxkQWLi03mEMIfnEwW35GjaOb+0+B0LBG6yzWGG6YMUuzhV4pH/W
	FmUqx5xTUlHiRsOQka1avg2rXWS3LaQhE5+Jtmb7f9s4yCt4mTyxcwVv4eEH570V
	TghBNl7rLBX06H0OyuPPGtCH+voKX7VHG51w5cpwM3U2b21LDIbJ64a6ntwAINY8
	ooDBbw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47xsuksahd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 11:59:29 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6fb030f541bso3546556d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 04:59:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752753568; x=1753358368;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RC8QbYC4Tyk41SorqPKs/ueg5eS7morHmOcMxL4tVz8=;
        b=h8oPjLcEMrosxWEXA6SE7Ht6QHqPe9Nl3AjYLPPGYzhRRQ6i0Zj/38+GTM8QeRQPuJ
         Ky8XNGA0+mmQExRuMYQA/aHnVkoAkBzLN66w7R3d3ZNDD1aW5phsDRxfgqvfimq7RDTY
         LAsh9sWVbLR/i/viQCTQf92TMGlscrFDeHJKl0PQV0Ceik/52RzOTuFCtXHNRF103ugh
         wvXFuKqlpTUGkeNf9w8TA1FIlylRB/cXdK1U0pI+iJVIlbOgWhgCJSIDF9rh0JR3WW7b
         1hH+6AeQDeMYq3h7+ZsvteCLGlgZoOlwrosW7kRuiLpG+8R0mKVKbIE6BPKiLN2ko8es
         UkVw==
X-Forwarded-Encrypted: i=1; AJvYcCXieHPlSH8vxG9HS3GXtRpSLxw5yBVOu4wvuh434HTMdsgnVEnh14KTIocE1pHTsuejkTjHF4yB7wC1UjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAxhRdBugT9V4gEXP3o711x9SgtF7McBkY4ju/Moyz80izJ3bx
	N9uHTXMN/vFN4arccZaBHwKDoq5t4EW/b/4qbJAPsiM91MM2zxFB6nmfVKCtND2d9SsDfhOnikw
	z7MJ7AtQLNciRBUsudyYk1oO/VeeHSsYUdUyvouinX0QN6YsfuOBBNBba1K1aCxtFtJM=
X-Gm-Gg: ASbGncuZH8ceiqiAldaICo4N4S2WvLuhjw9jnp6bwri/r7u+WJ5ak5E2ZieRX14U+Yt
	3YRfyS+14SE/z0DrEvMWplFExtA5eG+19JGGlGFrjykyMn22qdvVTyivbSoTlV5FOpRTz7hRZkg
	3J2Qeg/xshZi4vdb85mUVJ6UrU7aMYATizMQycwl/kdddyTCmGaDe0MjQQcKSYjNEPzDTx7PGNU
	vUq2yylZvfybAUcuokrsNCjLTWcaXhmSc3RHdNyghjuSXLauFFM+v9o9xTdICYR8ymKmCf/HZPL
	mbht+EcdvsEcco0rtYbyVHjdeY2RaiGSv0+K/Up+xQ758AthhOKAh8bIQw165evZIB+YjQgMM94
	LEM80xKKGe+Ks+JF53bcr
X-Received: by 2002:a05:6214:318c:b0:702:d3c5:2bf1 with SMTP id 6a1803df08f44-704f48364afmr47557336d6.3.1752753567853;
        Thu, 17 Jul 2025 04:59:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGx+fJon1hM47o3ro2qoIpBT/ZwbZ2MVf5+gvcrkJWunY7L635zgL0jQnJFiBoidFlr1XdTcQ==
X-Received: by 2002:a05:6214:318c:b0:702:d3c5:2bf1 with SMTP id 6a1803df08f44-704f48364afmr47557166d6.3.1752753567447;
        Thu, 17 Jul 2025 04:59:27 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8265d88sm1362294166b.94.2025.07.17.04.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 04:59:26 -0700 (PDT)
Message-ID: <5f382858-1a43-424e-a774-00511f2e1cac@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 13:59:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: qcs6490-rb3gen2: Add missing clkreq
 pinctrl property
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250717-clkreq-v1-1-5a82c7e8e891@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250717-clkreq-v1-1-5a82c7e8e891@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: RWkwzbkf1-le5bgkPPHrNOXUbALQ_RhQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEwNSBTYWx0ZWRfX6vTS9ifahBa0
 V7tNvjNOF6YcGimWZIjTmhlUjg09cwSfXYWbHvMf3f9ZTkFLIoGoQOUD26IM/t81HnvNBkdK082
 0tlbwMSC3EGDRXRoqvl9tDL0nis7MFflOBhtL6wfMDFgHk7HFD8kVwSb1Dzv/1YsyvLzrI+11pL
 Y6h1I12hOMoULnOdL612rT49ibxoRakZrAYUNdM0dzBfi4RAtsi9sY6r/QLEXfS1TUwv2CW7ww5
 KpvzzHQYxy7NyyLeTGVXpqmbaBN1B++NplEItctLF4bOlPOVxH9hoOAatcOZIGZSViHyOhoj8TB
 MYSgHDQqw0i5w8EZof3AKlWwI3f14Gc8pWIwABZDhLMU/odI9nlqNSgN5ykbIugawiKpuWHdBcS
 isy2vH7U/vxkW6xLbL3iXZ8xHWXRkEjnE7psB90UN+JyL19rpv73SQOkaGJkp+JpBg2td5Bz
X-Proofpoint-GUID: RWkwzbkf1-le5bgkPPHrNOXUbALQ_RhQ
X-Authority-Analysis: v=2.4 cv=JJk7s9Kb c=1 sm=1 tr=0 ts=6878e5a1 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=6pHcnep46kEejBPVP2gA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxlogscore=680 adultscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170105

On 7/17/25 12:40 PM, Krishna Chaitanya Chundru wrote:
> Add the missing clkreq pinctrl entry to the PCIe1 node. This ensures proper
> configuration of the CLKREQ# signal, which is needed for proper functioning
> of PCIe ASPM.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

