Return-Path: <linux-kernel+bounces-844298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D77BC17BB
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 15:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED9A34F625A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 13:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6CE2D9EFC;
	Tue,  7 Oct 2025 13:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DPJOcLq6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD722D9497
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 13:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759843380; cv=none; b=QNkIzIRq8bu4abaxwqJcfYyFLTmPz06M9k0uiCk2CavJbhbCIXpitj7IZNrlkNxlmW3JpgHWFH2TbonU41843ImO5xb0nBXwBU/MQ67f2G30OLcVmPX0T30syEX8JQFt9n2hy1MQgJ2MlZtuwSDh5ocXTCFePnjX84O6f1BYt6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759843380; c=relaxed/simple;
	bh=+7JQ3HJhUGmoU94/qttg4PQSI5TtalY/UBkZ9H2xveo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZF7+gLZsLKIbvZN9Ysikkj+AkhYYk1Aljg10fNx5+95EWvQN6s1rAZydbR2Przr89z6J1ao+/E0lk3ib3CyI1kNwLpfE1u7j3JuiVPtJzU1WmrIjw2UAaP2Ezd3ylUjxGdLGnZWuaqzEiliUOmF82xC3nmmvz/Z/jedNucLzaFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DPJOcLq6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597BD4CF020414
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 13:22:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Kbgn6/LpSenMee6d8moHn/H3VNhUDIZ8Sq+ZaEVSzVg=; b=DPJOcLq6/Vym1SuM
	por6QyAVbG90qC2mF1NhHX3540Kj1dpdLqpHRRCXXjnu4HpPOFp9tpcJSRtgywix
	+JLClnmBt71UJlBsA6PNA6yZSub92AXmFb1lCsV8L6YYaFKUAFZiTcG0cidf2L6p
	XAb3NL3/pQh2s282bgN3dfwbz9/pKJHhuLNPge7hIh1m9fChzA7iqvPcB8W+Rmvy
	+4ZDggWqZaQw/dWCZupizMp7l2Ri95b+EGbaXs5gxxQWZMLinVt17CM5jnvxyXXx
	rOI4kvY9aMCsVz/p4xvxYGf6q2uh+KDj2IxmFqFKuI0WHRvdCNpBEckU1wOsXylX
	kuOXfQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49junu7adg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 13:22:57 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-798447d6dd6so17830966d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 06:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759843377; x=1760448177;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kbgn6/LpSenMee6d8moHn/H3VNhUDIZ8Sq+ZaEVSzVg=;
        b=Oct/iB86wYz5d+rB+KUOZp4dXllSOHLkXo53HjrAQN5APc5yGMCnDocS8f559hSm/u
         UoP5LG/4P0EBLtdKiD/eN6rIug/uspR9iDjNCjH8ACSlpfHPRkX3JnpTHG0pMlti+bXa
         JRckyvDfWrkHy1g9JgdMdTEFDm4ssyX5b53+ePnGLFfvkm3W8pQ4qhrmMAOISPWwOLaq
         Y7i0POYjukNYiH0l+skJZsy/FvxJaTGEFlkQBzUDEZ49QZB3TpGXWsZ+CPh9xHa7FhId
         j/yg25+ttjF2SZJqfaUk8gEF3AwVMz6awkUWJF3XcL1lyJaZajPzdouxHmYw0cOo55z+
         y4Dw==
X-Forwarded-Encrypted: i=1; AJvYcCWp7NoDVVuQ6zBePpFFU0/S6tkIIYrqLn7RpvX88U5VdYkOisGDqfMQJ5qPhYCsuzwXuy6YQRpC/DeWofE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpYr1r5MtFgbOg6Pjy+2BTK+hBlf+Fq0ECTnFqteD27RyX2gbo
	nHPmZ48H9vkZHY0Xr8P9Lsjhi8KTIycvd2WKqj+un0B4nuOQbiks7QtU7RcgeR8okx+ufNbbuIQ
	SlDWXRCKaLatJ9/7HB39hZYzSSJbYY0DsTRPgUd78/XGeq/VwIdrdQOWkKdoRV7EZjYM=
X-Gm-Gg: ASbGncvf9qYAu9HQxrG+V5WSqelqAaRnPwsJmX1ilycjEK+lmkjTlzxp8OFNoxRCCFJ
	13ArohpGkhTXJasVsqnt0DEWBNuskgNfymk1BzwAR1waqEAL3iOLh7C/fzOk+9yTe4mXUrABhoy
	Ra36Hh4yrWhcmnqaBpSE5gFigB7O2gI1EaKFE/KQIJSuK96jat98ekvTH5JR1nuJr/VuUsKL1c/
	fpRtApsajO7+rmA28TW6hg5nIG/F6hJDnOj/cj3IgKJp0t7rD2FpKiAVPu9jE2vt8opR8WuHMVc
	xBmqzx2AXDXKrXJm14TAKfZpj7vSPOVd8kTJHX8fPqb9CCLDmJFHMx/0pJ2gOGt3xuTINpys//Z
	CvPj1G8NrM2/eU/h85WSPtEfnSiw=
X-Received: by 2002:a05:6214:624:b0:77a:fa17:551d with SMTP id 6a1803df08f44-879dc8b7dd6mr144031216d6.4.1759843376511;
        Tue, 07 Oct 2025 06:22:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYfzh6eg2S5/sqTEv1qfMsJQUgQ63LkFoFtHJOHxmw7dYvN6n2iJms5yBCNClV1aC2TjYugA==
X-Received: by 2002:a05:6214:624:b0:77a:fa17:551d with SMTP id 6a1803df08f44-879dc8b7dd6mr144030556d6.4.1759843375774;
        Tue, 07 Oct 2025 06:22:55 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63788111f1fsm12568864a12.36.2025.10.07.06.22.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 06:22:55 -0700 (PDT)
Message-ID: <ac56b74d-de7e-4440-894d-7251b2b893e9@oss.qualcomm.com>
Date: Tue, 7 Oct 2025 15:22:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] media: iris: Move vpu register defines to common
 header file
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
 <20250925-knp_video-v1-5-e323c0b3c0cd@oss.qualcomm.com>
 <ab28a715-6b5e-4adc-8889-f47ee2e18d5c@oss.qualcomm.com>
 <404e40cf-8c51-d12c-d39c-6cc83779e3ca@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <404e40cf-8c51-d12c-d39c-6cc83779e3ca@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: m5Oxbx3hAMBv_mOXgQ42eOD_2i60-flP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMyBTYWx0ZWRfXwd5FerJoN5r/
 +JShVb6g1ksEArabwn9wINMZ8JcEhJ0wRx64t8wbMxjiEeaezi20lDDeTMkvIPICtGmF2Illj4s
 z4KEpD0yVRXXBAO2hkuqACajtb6Vqk+ja+x9gJYECeNniDMoygKlzlZpxtS8ATQLQTw8r5d8h9h
 ZQYeMG+wGzT/B2sQP6wDHAtOH0a49n3uKGD8Kv0Eaw7rE/62stkmDVYq4AHQ3iEBIYyh6Leg+iz
 uYqWhkjeq/5i8cnuKjeuKIjljRrlH6uZ40h/HJY1z1Mmx22IyeNP96+ChtSc4hQ02YHOE2W8XB9
 L1uTGYGq/VoQanaIKxZZlw29slx1fHXBHwPR1QzS5aJd5STLEN0W2Ps7X3hvPt6P5L6sa0IT0Dm
 ChAUyOyHd8BPPW5fwPylt8DjT6TC4w==
X-Authority-Analysis: v=2.4 cv=CbIFJbrl c=1 sm=1 tr=0 ts=68e51431 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=Pu8XC-7BNdI2FKyOeZwA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: m5Oxbx3hAMBv_mOXgQ42eOD_2i60-flP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040023

On 10/2/25 11:35 AM, Vikash Garodia wrote:
> 
> On 9/25/2025 2:40 PM, Konrad Dybcio wrote:
>> On 9/25/25 1:14 AM, Vikash Garodia wrote:
>>> Some of vpu4 register defines are common with vpu3x. Move those into the
>>> common register defines header. This is done to reuse the defines for
>>> vpu4 in subsequent patch which enables the power sequence for vpu4.
>>>
>>> Co-developed-by: Vishnu Reddy <quic_bvisredd@quicinc.com>
>>> Signed-off-by: Vishnu Reddy <quic_bvisredd@quicinc.com>
>>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>>> ---
>>>  drivers/media/platform/qcom/iris/iris_vpu3x.c      | 36 ----------------------
>>>  drivers/media/platform/qcom/iris/iris_vpu_common.c | 23 --------------
>>>  .../platform/qcom/iris/iris_vpu_register_defines.h | 29 +++++++++++++++++
>>
>> This is a slippery slope. I think it's better if you explicitly say
>> the header file contains the register map of VPU3 instead, as let's say
>> VPU5 may add a random register in the middle (pushing some existing ones
>> +0x4 down). Such changes are annoying to debug, and we've unfortunately
>> been there on Adreno..
>>
>> Because you're using this for a single common function that is both acting
>> upon the same registers and performing the same operations on them across
>> VPU35 and VPU4, it's okay to de-static-ize the function from iris_vpu3.c and
>> refer to it from vpu4 ops, keeping the register map private to the former
>> file which I think will end up less error-prone for the future.
> 
> Appreciate your thoughts on this and trying to bring the design issues faced in
> adreno. I peeked into vpu5 register map, and it follows the offsets from vpu4
> and should reuse them from "iris_vpu_register_defines.h". IMO, we should be good
> in reusing them for vpu4 and atleast for next generation.

If you're confident in that, go ahead with the current approach

Konrad

