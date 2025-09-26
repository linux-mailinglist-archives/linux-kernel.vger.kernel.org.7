Return-Path: <linux-kernel+bounces-833986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0ADBA3852
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE5A0327E4C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F782773DD;
	Fri, 26 Sep 2025 11:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="opsE6fbD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327D2248F48
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 11:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758887090; cv=none; b=YuUwXcXlU/f4EW4McBpmanzUicJrEl+PzeN+IvZl9Eka6CTdoGZLkBYrwQ/L4IeOxWaHeRJxJcRBa//T23rwFGnuT3MJ+5skL0iuy5JNmpw2Ksnmp2KS6+OSG6fpok7SjwXdbkRqvsYMlY6fx1gInPh2Cs3IqCayX2lgJvWmZh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758887090; c=relaxed/simple;
	bh=jafD62n3oYEBDKuYo3x5ICEIx1nzpV4cTgn3R7efROY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qRoGZb3qmEMrrBJI1k4B3z5wQqIfnkZF3+I/LJQSf55VsOuiO6Urpi2VLlIoO6O5OfCEZcBKlsgakWj20vyDoM76FUv51CE7oT9oWU4BU5ClyvqarDS5xRbyw8fhXunOcob6lsBhJMW6Hk0QW5vaW2hyVKlmIxkCDlsgGkHukIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=opsE6fbD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q8vZ2m030515
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 11:44:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oazNeDOXBpNTA9CUERHFDVRMmm0DeM7PNOxF45++cQo=; b=opsE6fbDl/ENPXKt
	eCNa+YeipF2nS9vJmn3AXtZPRjm4GimhVqxxO6Wsw+f3gMIa5ePU1+gTBuwnZ95g
	WYtJdTV3oBtxadZOm/V4gknB+XIp2C+XhhC3dDFzuU+u2Fywvryx9r8lmGXYOEso
	V7aFtgWi4t+naiCCsMehgHb2GAwQx8bES1caEN1fUVhxB5JGUyBGiu76swQGMe8T
	y0Fm0JGFExvF9j38+y38IBpef9F5ONhoOhz67QYC6b7qbleQrf4MNF8E/iuadvuB
	jkRCHlUCwXcrA/Wj+mAM33G1yrUjPm+MJz/IX0WvKIIh+xNR0LeZnN0ivZEhGrP0
	pr7/hg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0u2pec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 11:44:48 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-85e95d986e2so31522685a.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 04:44:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758887087; x=1759491887;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oazNeDOXBpNTA9CUERHFDVRMmm0DeM7PNOxF45++cQo=;
        b=CkyP1YGlWg5noqIMSZKXK87vEtiRBuCmzGb35y/Vawxdm7jSIY1s7yb/6LUxSX0fL6
         fNneVtmn6FVs/41CR8Iko5/vBJOJFrG1TX0Pz+zRNAWAhQ+OgNTE1a+2v9NBYxahoFGz
         5EoH2erfD4LGSEMkPSXlmWJrHmc3/QHR2BkWgWfNW3bnDkTKY9OLgjwDAuNa5NOOW+WS
         0/Z8f63uLw3JuXX9J3bftkyDoB3qzH3uEvaywqYZgDBb1redIi5n5ZcFh8qQtmkX+hyT
         u0z8SEQn7alCOVgc2yVsenBfsU027VpGZscqYbmzLRgNYvRO4UWsYQ0Rg5askoOu5tBP
         8k+w==
X-Forwarded-Encrypted: i=1; AJvYcCWCCuHtg5DS+ICgiPP2b3Kt1aKNdWSuL1lQPG3f0uQ6D2RvLXzygCrAWnKwXaqAM3UhTWcsvEEc3/mWnIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw54YjGj0bZdhfeeCXq0MYYoTDZoj7biw0U7VPUNWD1nNNuFlcI
	nV0lVqIFJDGMQyVr73soYo2p0J6i8AgLepxVOW4EetL+TXDJlOS9wD0ChJV4c7t7WWdEPlOy4uQ
	tB1bHTe0vfBSnATrXJwAxgXrNAF7UOBRAjj3MmGlCL1AEb+UOrsS18+FabMF1xqdbdiVt8RLInP
	I=
X-Gm-Gg: ASbGncuLTS87kPGhIR7xuk+fH+05dgwe2EoipEuGO8cYqR8TcvJ3DOsr6Mm4VrTjFP2
	JzvC+zq8wKp8/U1J99bqLikJxp8vDEfTqhszhvW1pVkQGKBAblej/Z/XVrap+A/Jp9dhN0y2qPi
	ziyeT3zh/4k5UkC65q9dbnn+zkx1yJDtuoujOX7CAeBLXzl2Fj0ycuVZs1PFKdPt8zFrvdbE7CA
	HQ29vVBtLJUqg4zzdbPfpbmCGoh7hzc0hlE0PmiJQymCCvhUVr3h0fOIsFAuaUnFks/p0l0mEyq
	jxrhhfa/o2EJPzp65RR2ssIURWcvZFm2XzHOFj5qV4alUCdMNyo+hNp6ryXJ0sfAKnFCq/FETZU
	7z7TtVuPa+9tbQY0fJ5nqqA==
X-Received: by 2002:ac8:57c9:0:b0:4d8:85db:314 with SMTP id d75a77b69052e-4da4bfc05b4mr56721201cf.11.1758887087270;
        Fri, 26 Sep 2025 04:44:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUJgskH5/9pO1Sz5CQgZsxdYJG0av5mRyh8GQfkS2NLlVmdflNR0Y7Vg+ttb4L9svIeMZhPg==
X-Received: by 2002:ac8:57c9:0:b0:4d8:85db:314 with SMTP id d75a77b69052e-4da4bfc05b4mr56720871cf.11.1758887086719;
        Fri, 26 Sep 2025 04:44:46 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353f86f974sm353684466b.40.2025.09.26.04.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 04:44:46 -0700 (PDT)
Message-ID: <ccb57be5-7f8a-4008-a650-4683d34bfeff@oss.qualcomm.com>
Date: Fri, 26 Sep 2025 13:44:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] media: iris: Add support for multiple TZ CP configs
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Reddy <quic_bvisredd@quicinc.com>
References: <20250925-knp_video-v1-0-e323c0b3c0cd@oss.qualcomm.com>
 <20250925-knp_video-v1-3-e323c0b3c0cd@oss.qualcomm.com>
 <050b2cc8-ddbd-4a79-879e-4a2c9e7d95f0@oss.qualcomm.com>
 <94f6754f-cc56-09c5-3730-3f36c22e4786@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <94f6754f-cc56-09c5-3730-3f36c22e4786@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: i6TfAyTDecVC51f-bmPYEMhfEpzeZ9Lb
X-Proofpoint-GUID: i6TfAyTDecVC51f-bmPYEMhfEpzeZ9Lb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX56q0Zi5QoRNF
 g0m/4zcuYtCPNH2cgjw6Sr7Xyteer3l6XUHXJLo1X78g+3aPpcVFNtz5eLpEfTs0wZI6rooTg75
 HQysTaMH31ejz3aDJc3rBfFSq51fzcSilVl11WVhCYkhLeB09hzPDDhQcRE/euJf8AwlbicI85V
 4C0REFr6SosLCjBiKJ07CFBpZdziDQivN9FjNBw1U/zrG2kB+RVhpDG1RiJczLCG1Cl2/ooRbfe
 4+pHxLHXWAcyUWljIC4zEA3CF4IJ53DE+gVmONbOHLnLfyJhinjzu2mZj97CLKpg82dHPYsOu2c
 h/aJfjidgzBlmlxI5aWLlKrhHwiAXT8nljjqVG+RTu/MMLFLnkzX5l+C/UVTR5SAZafAJml7yZu
 d9UCQ+/gZH1jvKSHSKHES/9CN3cXNw==
X-Authority-Analysis: v=2.4 cv=ZsHg6t7G c=1 sm=1 tr=0 ts=68d67cb0 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=-AzuYhFZr7sfLd3NIz8A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_03,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

On 9/25/25 9:27 PM, Vikash Garodia wrote:
> 
> On 9/25/2025 2:31 PM, Konrad Dybcio wrote:
>> On 9/25/25 1:14 AM, Vikash Garodia wrote:
>>> vpu4 needs an additional configuration w.r.t CP regions. Make the CP
>>> configuration as array such that the multiple configuration can be
>>> managed per platform.
>>>
>>> Co-developed-by: Vishnu Reddy <quic_bvisredd@quicinc.com>
>>> Signed-off-by: Vishnu Reddy <quic_bvisredd@quicinc.com>
>>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>>> ---
>>
>> [...]
>>
>>> -	ret = qcom_scm_mem_protect_video_var(cp_config->cp_start,
>>> -					     cp_config->cp_size,
>>> -					     cp_config->cp_nonpixel_start,
>>> -					     cp_config->cp_nonpixel_size);
>>> -	if (ret) {
>>> -		dev_err(core->dev, "protect memory failed\n");
>>> -		qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
>>> -		return ret;
>>> +	for (i = 0; i < core->iris_platform_data->tz_cp_config_data_size; i++) {
>>> +		cp_config = &core->iris_platform_data->tz_cp_config_data[i];
>>> +		ret = qcom_scm_mem_protect_video_var(cp_config->cp_start,
>>> +						     cp_config->cp_size,
>>> +						     cp_config->cp_nonpixel_start,
>>> +						     cp_config->cp_nonpixel_size);
>>> +		if (ret) {
>>> +			dev_err(core->dev, "protect memory failed\n");
>>> +			qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
>>> +			return ret;
>>> +		}
>>>  	}
>>
>> Do we need to do any "un-protecting" when unrolling from an error?
> 
> Not needed for unwinding part.

Thanks for confirming

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

