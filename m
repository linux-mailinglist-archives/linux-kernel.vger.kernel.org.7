Return-Path: <linux-kernel+bounces-867177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 315E7C01C95
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05CA43A23BC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4BA30E0FC;
	Thu, 23 Oct 2025 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L8K8R2Qz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADFB314B88
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761229603; cv=none; b=VoaLOixQFh2XelqZZrmMez24S9YxnIphbtNCiHxjpByowXQkyHjrdxmwIRmVKyv2B3j2dTqjzIRCqZzGuq8B1oo9GXMUWQtE/KtuhSJUCLGjWdOS5Ql9YMCJ3wnlt5hELFtYGqbPN9qbC1C8Gp0aa4KceucygHkIIBMXhi3IBWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761229603; c=relaxed/simple;
	bh=6Dh7Yg0+vP21f+60Nq7W/bN/03nnTxIu+SP1Lecg8Ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YuXvhqNQ49TLJTjSF7XujGnBsQkS85bR2rcFRQmUeIAKpJHvw9nRcXM2pFLXumu+hkUfbwLtjwEWbrcbbzdS/gBoo+b6BmGc845mf4fSV30Tex+wikYAacdiTurkvXEnHeGGcoUKfOOiHa2ozCaYQ7d/NogxoppgEC63jF60DcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L8K8R2Qz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7CX56011737
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:26:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3WpAc+PUCG+PgTasZqEo6/+en3vqm4BKm8HG4lD3pyk=; b=L8K8R2QzWt5ejcux
	w6dtflrM4NxCFS6nDJqWNVleFx9XEbpxOoCma+8UvbOVsAG/ZbXKXNJr/OmdI+in
	N2E1QttneS0PlC1XkLkfAStjbqNFyBppQ+GfGEdUS7GSc0Kcg+SvkgTVoe1sk7ni
	coOp5rgkg4l0GJ15U2xKRqqbzx1fU6udTIYUkshywybrw2QUNyS10CIVrewIUKqF
	rxEjSZ+aRLsJyT20Ch+41JcoVB4Ef4rzyyI0xmv2UVMgXaxQbD4n3uq+Aob5ygP9
	ZN+54t4jgDgFNizM6y4ZENOSjipGQFwyF7vjLJwxmOCCSqlTPkXU/K8LqYcGQ9c6
	feAoJg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y524ax02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:26:41 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e887bef16aso2229341cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761229600; x=1761834400;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3WpAc+PUCG+PgTasZqEo6/+en3vqm4BKm8HG4lD3pyk=;
        b=oHmH8Cluk/psMLPn0YqJFK510Jn8tu1Vwln/N6hpOZjbrnkyX+BcOmCeTI3Nyq49PN
         cYc1dWd89qhoV9d5vu1eI0IqAnbN2GLwzg9dCt+tOqQr9xcZm6+2BivrFjxGZ6acBj83
         165/wGoll3jrfEDAp4aD9Ar7jygIYWLEBnfcN9TX/FTTh1d1h4fAuCd63l9PNQYN+QBy
         EamPSnx2X9JgyRkX6LqtxVo7ZxKMenBGPQFZuz2BVw0rK5x6G30BkVL3q0lfrKwXUgks
         wGByJw9SQJyatcWkqLmpANl00tBn+higmVZqSg+BTKRFejMuqvZqYcs/takrnAiAjd7U
         ubQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9WZnwdANdO9SfOC+3+Fc0QL9CcpvxlDInakBnDeMtSSVqOYhdtXQU1YG1QOP7rbPvX0Vv6GAHEd93E04=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWsJOHfIdSixjuIyULamL0yWOPdXzbpF1gGslT6egW+cwDKPNk
	ffdSI2xrmuREqBzwU/HLw6CEDX3z6OZ+50pmpBAImsycm08iWTmFuTsjM5VZlYz8fKOx/6+sqC5
	4HtkmJLdGYKHhOaWmBYsDdtZpuo5zg31FywnnuOyX3Yfrmvo1gwYMeYZcspJgcioSAv0=
X-Gm-Gg: ASbGncvNHsGr8U5rOpHW/vsYdqfcx8G/BV4Oo6UcoLMfZ0zS3zpvByKEagHBln5NQH5
	Z3seFX/jdODTHff/PUJsKeV6/IIWagDqlvH5cV8FOxcURHnw8sQ2qzSjgj2+AQUsEDvqfbNt4lT
	hYOmJlVKHpqkf8HangQ6CPDmEAjX6+J8Ax/e+utf1iR/fTIkOoJ5Zp6BvY8rihqneTK7LMVXzfo
	Jon6TgSJQ6gvxv0grARmuPEPHyVXwlP920mI59IDFvTJobdvRy6Z7SN9dnj99ttRIwM5G59oKkc
	CG2A7zNthSOXUaGGJMWtsSU5GrWkFqtbZUKL7ponndu18BXy+ibgq2k8ZZ5GpsO9VhJtn10wJw6
	oPuvODNAbh/lfoW00OMw1p9Lo7ztr7Bw1l/irG0hAWbMQvo+TMBBSkOKY
X-Received: by 2002:a05:622a:1b8b:b0:4d8:8b29:228a with SMTP id d75a77b69052e-4ea116853e4mr97534781cf.3.1761229600077;
        Thu, 23 Oct 2025 07:26:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5ZP14A8wZovVdz+EeQ60VU6uSydX3ml/L46LeJtOIXp78YopylnEKIB1ItmdcpXxyu8VsNQ==
X-Received: by 2002:a05:622a:1b8b:b0:4d8:8b29:228a with SMTP id d75a77b69052e-4ea116853e4mr97534421cf.3.1761229599431;
        Thu, 23 Oct 2025 07:26:39 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e3f322e30sm1795042a12.27.2025.10.23.07.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 07:26:38 -0700 (PDT)
Message-ID: <a58956a3-b9cd-408f-98af-7ec31f2277dd@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 16:26:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: qcom: ipq5424: add cooling maps for CPU
 thermal zones
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com,
        kathiravan.thirumoorthy@oss.qualcomm.com
References: <20251023043838.1603673-1-quic_mmanikan@quicinc.com>
 <1039aea3-47c6-4205-826a-636e595f127d@oss.qualcomm.com>
 <053cdafd-1abd-4f1c-8f48-9da38591fcaa@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <053cdafd-1abd-4f1c-8f48-9da38591fcaa@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE1NSBTYWx0ZWRfX5fFouKyZ5ueY
 LTm2lBdHekc8njKqgc8iN/8IhljUAL4PLe76I1m8/DCq8+wD1YUX3S/kkmDTpkMO38A9EjkfarM
 ypE5lg5+MLfbkeHTgiV9fFZ2xdnimvtSpcLD4dT6sMYVH2RriOmf3/Mcb86cV2yncJVI2OJwcUx
 AJe3kcakrP+BGATTal4CLoqAgWm1NQFMPstfPwmVbAkTEHH7YHsTcqoIF6oCM1JyonXzIivy4+S
 nlTg8cqFyqWHNgD49eTYgtJIcoviTMxsdcR1iXDZX5/cBA/veWWz4f0pEf7HP4/s/K9Cs03aU2c
 3x+rpPJrn0JROAo2tvk0C3WBHmkcE1sjsEqBqa+NNj4yoQ5fEYKxJ+Gjqva4Pkpn9ZkR4DjPRu2
 E3BbBLPgt7mBYxxofM7AXIqSOE9tqQ==
X-Authority-Analysis: v=2.4 cv=Uotu9uwB c=1 sm=1 tr=0 ts=68fa3b21 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=b9mZcHlmi3zSiLOk7sAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: DkLWxU9J7wJuTqeqsqAHID_Po8ZorVc0
X-Proofpoint-ORIG-GUID: DkLWxU9J7wJuTqeqsqAHID_Po8ZorVc0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220155

On 10/23/25 2:21 PM, Manikanta Mylavarapu wrote:
> 
> 
> On 10/23/2025 2:09 PM, Konrad Dybcio wrote:
>> On 10/23/25 6:38 AM, Manikanta Mylavarapu wrote:
>>> Add cooling-maps to the cpu1, cpu2, and cpu3 thermal zones to associate
>>> passive trip points with CPU cooling devices. This enables proper
>>> thermal mitigation by allowing the thermal framework to throttle CPUs
>>> based on temperature thresholds. Also, label the trip points to allow
>>> referencing them in the cooling maps.
>>>
>>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>>> ---
>>
>> [...]
>>
>>>  		cpu1-thermal {
>>> @@ -1254,18 +1269,28 @@ cpu1-thermal {
>>>  			thermal-sensors = <&tsens 12>;
>>>  
>>>  			trips {
>>> -				cpu-critical {
>>> +				cpu1_crit: cpu-critical {
>>>  					temperature = <120000>;
>>>  					hysteresis = <9000>;
>>>  					type = "critical";
>>>  				};
>>>  
>>> -				cpu-passive {
>>> +				cpu1_alert: cpu-passive {
>>>  					temperature = <110000>;
>>>  					hysteresis = <9000>;
>>>  					type = "passive";
>>>  				};
>>
>> This means "software will start throttling the cpufreq at 110C"
>>
>> Is this what you want?
>>
> 
> Hi Konrad,
> 
> Thank you for reviewing the patch.
> 
> Yes, the intent is to initiate software-based cpufreq throttling at 110°C.
> 
>> Also, is there nothing like LMH on this platform that throttles the
>> device way earlier, without OS intervention?
>>
> 
> IPQ5424 platform does not support LMH.

Thanks for confirming

Usually it seems like the trips are ordered by temperature but I don't
think there's a strong preference

The hysteresis value is a little high, but I'm assuming that came out of
some internal tuning

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

