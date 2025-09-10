Return-Path: <linux-kernel+bounces-810014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0A7B514A4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAC973AFAC2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FA0316900;
	Wed, 10 Sep 2025 10:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PIWW5xCj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AED418FC97
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501844; cv=none; b=V1r2nOsqSoeSnKtB1naPxiyovitMXEGUoQ24k7ZAntcxDTaqSNnmHzxK4+G74/CaPjl0AyN8wwXtyQM+FlWpKKt87FTnBjQXCbjKB6K6q21hrg0Sozf5ojCPlyc/5QnIxqxP55YhxdgbceSZZGMUQ5e6TDttKLSY/L6cUf/Rr3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501844; c=relaxed/simple;
	bh=GHR8dlv+537EvAqrl5fzNrzJ0kc33AB/+gWTIB98rnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MjKVLMIJR27MB7qhcR3MfB5yybX571tvz9B0IW/nCHu19EvhZ8/LwN9GZGoSEIIFq4HhOONikPa8q2pb8y5EIovMlKvpPNU6oO2X2CG5qfc7JmxuLab9ZzhGA5OnzoVN6xTEjNxg15XvdoIPZktGQ/mmVDMCWDwPUh6if6tMx9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PIWW5xCj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AAFESc012468
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VLrbVYuWBuZbmXNhwxf9odJPcM2JY5vCi7vwVIAzE/0=; b=PIWW5xCjS09BawAn
	v7bQYHBsVubmkWnyc84WZxu7VifUGnD0/QMeawM050oawTVJwOTKvsZiJwefkq92
	+OSeIbJwO8gEzmKKANIJJX3LGCOD6M16EUaIcPaPDxRxZFYpFvFrPRDsiS7Oiqe8
	GmaLL+eQLBUVzeWmVERV3qauzVNOFE46FsDIsre4fYgDSgl+Uw64+BlPLYdaDVfp
	qIKREhSyHlMjAbrPZt7VNDqIV0046Q/so+0YInC+UE/3Vq8tQaFTG2oJPS/db6IT
	99RRVZ0TzaTfRAGkCop6P7j2HD4efT580UV0n0X3MV9b9EDjZ8NCXg5fdcfpRdMw
	neJoiw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490bwsbq12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:57:20 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-775f709b3ceso1102309b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 03:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757501840; x=1758106640;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VLrbVYuWBuZbmXNhwxf9odJPcM2JY5vCi7vwVIAzE/0=;
        b=VRdAriOp5tZ9gy8jkkLpabToshRiJ5Mb4CjzHN6LU6JvEIs5rZCazkssII0v3RMHkC
         QpBNAax0FzQk1AYJq9OAwNxOLBiydt//05mG5PQo2MRSt6Rqp898WF7X3GfxiBg/W1Qj
         UvLr1yFz8o/Qt6BuNwDHB0LgPk3p3EwHJltt65BmRGIievFw7RuAwzycaEPXcMm5NmGA
         zvDM/KrXXCqrdVDh33+Tb9SJv+fZgCaCMs9qOrUCK8/6Rwbt4X1ndcTLPn148oxGkltJ
         AUPgzIvz19fzgrXx9tP+PKyYVk0vuhKqs/LFkk7lR+wAEKQcYQbtIv7D/3ZzS1hVXbsZ
         Hs5w==
X-Forwarded-Encrypted: i=1; AJvYcCWvFx0kjtbz9JveJlER9M6gdb4AUN1Kg5nhVeFRFDxuYdEePhmsM0T+cY8ZrDXsXxlTvkAQEgQEdhpPs0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGFTDIEHdEhrjjFX3Wsz2bJ/slXpXEwVX1JQLY2dMYYvJQO2nS
	YVuBjemztHuvQJb328mhJdE6fXrkHyi2Kl5TW+l9Zp0f3cg7WCH6lw1NNFGCLcz8gL4snrppo0Y
	gZRZUa6QiTp7JGEct1SlwxMhFmCTe0G3nqhoqOOWe2cqstbryZhnNKDaxVYnskyMSxFA=
X-Gm-Gg: ASbGncsh5xxU+b137PZLJUaCipNWoqTtNg7uMjuD1GBVAZcbiLNfaQzsKDFOaXWkf6B
	cb/40g5zFa3P6AuYF8Mu08FGFJBHCexo5kNlcXqnXlW1CpbLF5ATwl4hj3zbUN236iUdt09jHf4
	bgCSxVL7ROfhXfvpJZ8+Ra3Fn/2AIQmRIcp4znKtHIZRMj8sCUmrxJGkDY08wQLvgRV2Rw4qKBd
	zP89nT1HroCfWlAHqcT1bjwaXNIrT3o+sU5je2QtM3fYN4VgMBuzpMdVu20qHOWKujqRxfbl+nO
	5655gpnfJpSIHq16IiHklGiPhx0AgjsHlGKc0uaPSkH1HYma5o2UxhcdwY1/7SJMsuNiHZ58Xgo
	=
X-Received: by 2002:a05:6a00:92a5:b0:772:59d2:3a49 with SMTP id d2e1a72fcca58-7742dda745amr16974631b3a.13.1757501839775;
        Wed, 10 Sep 2025 03:57:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFd6cAY5KUWWKRCtZ5BO2LMkzPi8rG6m9xuEQDohogxbjye/JxfepADt3ID1u913pa8j6uKwQ==
X-Received: by 2002:a05:6a00:92a5:b0:772:59d2:3a49 with SMTP id d2e1a72fcca58-7742dda745amr16974587b3a.13.1757501839259;
        Wed, 10 Sep 2025 03:57:19 -0700 (PDT)
Received: from [10.217.219.207] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-775f4976bcasm2333665b3a.100.2025.09.10.03.57.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 03:57:18 -0700 (PDT)
Message-ID: <d7937258-9cf9-4887-a117-58ac3d4473de@oss.qualcomm.com>
Date: Wed, 10 Sep 2025 16:27:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Qualcomm CCI I2C clock requirements enforcement
To: Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250904-topic-cci_updates-v1-0-d38559692703@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20250904-topic-cci_updates-v1-0-d38559692703@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: GmQLngburlboHPgGLex7fZKsKiPIwzi1
X-Proofpoint-GUID: GmQLngburlboHPgGLex7fZKsKiPIwzi1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfX1WbKYL1K6E1U
 VBMG+d7Vt90XdAd2n9b03MDOVn7/Yv3ermzByIKIRSpdDq6BkKsGX9ePPK6AtAXu38OVVo2J59U
 vYUpy2lDFDiEiJMFBvnh/OZ4dj9wGWsTvAdhDI631zV4mtCmPXM7mTgVt1HAtH+Cyd650kxMKW6
 7VTeGrIFtKhuVAx+1KTEXbjN4wpEEV4ccfGo6wX/e/2rlRa6JxQ6Q3hkksS5FS59G6sGyShb0md
 IGyK1+JQ1mK9Y+P+bfVibc+74U7BMT0Yeeq6mlVYE7ffH7oUGvU2CTWn1RelFoUi2RlQF/ydm8F
 mkW794Q4WgIgPCsLx7cd+JM7An2ZR2/wALznxeJLDbd03zX1vjq0N8/4LykOLq7RNgroG8RRhJn
 BjdlZWXj
X-Authority-Analysis: v=2.4 cv=G4kcE8k5 c=1 sm=1 tr=0 ts=68c15990 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=3WXPGMdjBYCeSjfzpvMA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018



On 9/4/2025 8:01 PM, Konrad Dybcio wrote:
> The hardware requires the faster of the two (37.5 MHz as opposed to
> 19.2 MHz) clock rates to hit the required timings for I2C Fast+ Mode.
Should mention "source clock rates" to not confuse with derived 
frequency/timings for Fast+ mode.>
> Additionally, the magic presets for electrical tuning registers on SoCs
> supporting that faster mode ("cci_v2" in the driver) are calculated
are/is calculated> based on that faster frequency.
> 
> Moreover, while its unlikely that it would ever exhibit as an issue
> given CCI is a slow & tiny core, we do need to express a minimal voltage
> level for any given clock rate, which is where the (optional -
> backwards compat) OPP table addition comes in.
> 
> This series helps ensure all these requirements are met.
> 
> Patch 1 is a related but independent fix, can be picked right away
> Patch 5 can be functionally merged as-is, but depends on patch 2 for
> bindings
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
> Konrad Dybcio (5):
>        arm64: dts: qcom: sc8280xp: Fix CCI3 interrupt
>        dt-bindings: i2c: qcom-cci: Allow operating-points-v2
>        i2c: qcom-cci: Drop single-line wrappers
>        i2c: qcom-cci: Add OPP table support and enforce FAST_PLUS requirements
>        arm64: dts: qcom: sc8280xp: Add OPP table for CCI hosts
> 
>   .../devicetree/bindings/i2c/qcom,i2c-cci.yaml      |  2 +
>   arch/arm64/boot/dts/qcom/sc8280xp.dtsi             | 16 +++++++-
>   drivers/i2c/busses/i2c-qcom-cci.c                  | 45 +++++++++++++++++-----
>   3 files changed, 52 insertions(+), 11 deletions(-)
> ---
> base-commit: 4ac65880ebca1b68495bd8704263b26c050ac010
> change-id: 20250904-topic-cci_updates-800fdc9bada4
> 
> Best regards,


