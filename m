Return-Path: <linux-kernel+bounces-868319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3426C04DE4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF79D4F9C22
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4549D2F3C1A;
	Fri, 24 Oct 2025 07:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QFraqqxm"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF0F2F3617
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761292537; cv=none; b=b4dc73jAYk8Xn2uAgrkWy4xkq7LcENUe5C4xZwS7yNWmUST5UGmSaT038ypaye5V7/MmfcbtIXKeCeHHBsVyEu7mdkNlruLYueL9GxN7UGWyfIu5oFPc4tHogg08HK19CrVxSHS2hyl9OuauDtRAgMOobFcfmDzLwQZBLwtqWOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761292537; c=relaxed/simple;
	bh=UFp0rwfJ7OinZOtB8woT8V69BxcYe8f2uGbPThsPnAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kzuw739jEbCw43k6nr1n/hSvUWOBrI2hYX9ebN00tN8MQC8o3bf/LaGDuv/NKOv/QUE/CsMYBLqB2GvRwG6qsdF3wt1bJZi84HH6eaKGiMvIYVbDva/7ArxWypNEjoo1GWGivde0o4pgMTx9J5IZsSlqlkn10nXtx017iB6JKTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QFraqqxm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3FLFY014876
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:55:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YXG68zxkoFTr/T5HZB5JaHrMfcPhG5bgKEnx+70f134=; b=QFraqqxmnmEMEzCA
	eme0XSu5wVdiHBKlLLZ2ojmPaPvd3jt1tj/r58Vyjf5EUGOcXAPiQUiulVJ5AARM
	GbdSOvhdAiF4nIV39yBQCPLgq/CDzM4vSe1/xTEgnf5oXlrC+x/INO/HknZyOgD0
	IxYkgsRvjbGD5LuVg6WYn3HY7Jh6eIETefFtblINWHxQDDAVpBhDH3mTi/+5ZvR4
	8k0W/ZTh0qoiL0O4acrT5XB50JVoKswnrWx40k4DN1yX4D7FQujmVU6Ye0dkYh0C
	yQ1C74mGKBtoS1DLuDBiaqYtVXFrhoVmT42GE3/pOcjRZ4yPXPf+XJ8Obu3LayBN
	BnFKnA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v08pufxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:55:34 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-873eac0465eso5968196d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761292534; x=1761897334;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YXG68zxkoFTr/T5HZB5JaHrMfcPhG5bgKEnx+70f134=;
        b=nG54wGgv6FIZi7iR1QF+SRwgnAMZhleXr3jL8OhdFW9NaZlZV2davwDFmJ9xFmTmrk
         lVQxeM91N2ORyPy1tkBRXExGmkBTgPGDZyiE+YsZ/Pfc7kkYH36ewpmokOjSFRG5ROuu
         QFAw69Lw0BHDw3UGvoAQwZdQyWiR2PR3yKO/1mDZX99I9xxRyMlBvCNeWPrijRYqk1Cq
         To4IFntVvLugfuEQQ2InY25jfOPZJLQzD1YzOJs0liDMdyoWa++OApd1t1J+PGP+0NHv
         qkTmENZrhI+Ny+aa4ID1AbNtRHCSCCj2QCWaLCsQ7/Bf2JCZPHVNfLN3wmw0RHYsMHfM
         8wHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfOiSe/u7Arz3MW56rz7GI6fIb0urIMqpiryU0MwtA/SKitrCesj1e0BCUaqri4/XRwHbmTzIj/2/w8Ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvC+w35XBU68O1kQVikfm2tpDDWe9GlXq4AGnzD6CuRHfqnoPW
	ZC02zgzfOISR09nnrV+UK72nsoZ1JSmDgjYR7zx09cQZp2vLW8/cvU8vO6BsOVYFdCJBwn7y3uj
	UAZ7Ap1cCrF0EYLf0uhi1mRyBRdwcZs8gaP7Zl3oKA1WrvmtqWtZFkVmwCwwz1S0OFxY=
X-Gm-Gg: ASbGncu54Mhc+MU8vGBrYqAV0yAilBpy5wp6wdDXk5AbFMrauJ/FK23HYm3vUjvKb5n
	GetRhGD2VZapm02UJXFkL4m4HEHESUBenmD8PYgAvCl6BMyKj5+WgMdL/5QeOlBslv/RSCPdIJp
	mjSHZyW7IlcwlcYudD3+6dhWTzOR1aC4U4QbehTYxlt9z96EpxW2ReyFdq/6lccj6UXq4S6/tFQ
	UcjbJSQ+89CcFLU/zU8dI3wYmQzF+zH15CaYkMqLajXf40yWQb3XXNM68sYC/Bdpi6QxlmGpLrk
	7SuFdLUgG8VxRURWE9ft5rKhhw7FQRi/OHDSgtqS2xFgRGNAE+5kM099SrOOEzyu6bs/QAcMnvO
	dtexHA36BYasdN9S6Yc2a5xxHUkj/oP58wlXuIKs4r1s+450QPgvmWXks
X-Received: by 2002:ad4:50ac:0:b0:87f:b0f2:91f3 with SMTP id 6a1803df08f44-87fb0f29208mr17301216d6.8.1761292533821;
        Fri, 24 Oct 2025 00:55:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCB0bSo2J/IJ0DIn47T5u6kinAgTO16yEd6Im0+tOd+RYrXLjQsLNxZVU3R7LS4PIuS4fb/g==
X-Received: by 2002:ad4:50ac:0:b0:87f:b0f2:91f3 with SMTP id 6a1803df08f44-87fb0f29208mr17301106d6.8.1761292533307;
        Fri, 24 Oct 2025 00:55:33 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e3f32423esm3747494a12.32.2025.10.24.00.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 00:55:32 -0700 (PDT)
Message-ID: <5e64c246-a424-42c9-b102-e1a2af579936@oss.qualcomm.com>
Date: Fri, 24 Oct 2025 09:55:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] drm/msm/a6xx: Add support for Adreno 612
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jie Zhang <quic_jiezh@quicinc.com>
References: <20251017-qcs615-spin-2-v1-0-0baa44f80905@oss.qualcomm.com>
 <20251017-qcs615-spin-2-v1-1-0baa44f80905@oss.qualcomm.com>
 <44ff81bf-8970-475c-a4f5-c03220bc8c3f@oss.qualcomm.com>
 <97aeb6a1-fda2-440f-b14b-2f3dbc2d7e8e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <97aeb6a1-fda2-440f-b14b-2f3dbc2d7e8e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMCBTYWx0ZWRfX2ayPuA6jDqtG
 mxP5VzD//47YgKwZUbe3vXDd8b4Hhea1iTqq9sPZPuOp3MqyOqTt3W9hTqKmlrbckjSAt/b8srJ
 1lTAmfuurdxW6BWku7wEgwMUzTM7SSAXNn/LfMy2tAC4PneQb8+SgP7NBgkt5Rewt/P5C8DzFsg
 7dTJGkGhEl4xkr13jkUDTp+w1oydIECTqlHsQ39LWyt/i6vB9BxPROS57WrPDnE3VFyfTk3zuLK
 3/A0JLc6NMpS0xZUVHmFHKw6tM1sXa2Z8VWlIDoQwyuCUwQRPgwYvOFj2jSxF7vZEhyVEL4xylq
 pNQUS6e16q0Yte6uZhChgs8MqJKwwX6YH9dqjOUMj2qSvHSOe5RFhh0a3m8xIWzClWe7g8fDY1L
 j/g1QnQfLlc+KGbuJ8+f28F4W/KTAA==
X-Proofpoint-GUID: qhuncvNTUwCPIhYTiGrZ4u_SihoQ82a3
X-Authority-Analysis: v=2.4 cv=Up1u9uwB c=1 sm=1 tr=0 ts=68fb30f6 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=ik8sJufeG61Tn7V1IDgA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: qhuncvNTUwCPIhYTiGrZ4u_SihoQ82a3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180000

On 10/24/25 12:57 AM, Akhil P Oommen wrote:
> On 10/22/2025 8:43 PM, Konrad Dybcio wrote:
>> On 10/17/25 7:08 PM, Akhil P Oommen wrote:
>>> From: Jie Zhang <quic_jiezh@quicinc.com>
>>>
>>> Add support for Adreno 612 GPU found in SM6150/QCS615 chipsets.
>>> A612 falls under ADRENO_6XX_GEN1 family and is a cut down version
>>> of A615 GPU.
>>>
>>> A612 has a new IP called Reduced Graphics Management Unit or RGMU
>>> which is a small state machine which helps to toggle GX GDSC
>>> (connected to CX rail) to implement IFPC feature. It doesn't support
>>> any other features of a full fledged GMU like clock control, resource
>>> voting to rpmh etc. So we need linux clock driver support like other
>>> gmu-wrapper implementations to control gpu core clock and gpu GX gdsc.
>>> This patch skips RGMU core initialization and act more like a
>>> gmu-wrapper case.
>>>
>>> Co-developed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>> Signed-off-by: Jie Zhang <quic_jiezh@quicinc.com>
>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>> ---
>>
>> [...]
>>
>>> @@ -350,12 +350,18 @@ static const struct a6xx_gmu_oob_bits a6xx_gmu_oob_bits[] = {
>>>  /* Trigger a OOB (out of band) request to the GMU */
>>>  int a6xx_gmu_set_oob(struct a6xx_gmu *gmu, enum a6xx_gmu_oob_state state)
>>>  {
>>> +	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
>>> +	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
>>>  	int ret;
>>>  	u32 val;
>>>  	int request, ack;
>>>  
>>>  	WARN_ON_ONCE(!mutex_is_locked(&gmu->lock));
>>>  
>>> +	/* Skip OOB calls since RGMU is not enabled */
>>
>> "RGMU doesn't handle OOB calls"
> 
> Technically RGMU can handle OOB calls. But we are not initializing rgmu.

Oh, I glossed over that..

IIRC the reason we delayed 612 support in the past was to make sure
that the RGMU FW is consumed, so that runtime requirements don't
suddenly change one day.

If you have no interest/way in getting it wholly supported right now,
can you at least make sure that the driver requests the firmware and
exits if it's absent?

Konrad

