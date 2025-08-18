Return-Path: <linux-kernel+bounces-773554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EB8B2A188
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20F133B23D4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08463203A4;
	Mon, 18 Aug 2025 12:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WIMQIsKp"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D7932038A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520057; cv=none; b=unW8+OZ5yGo4G9qIUCx+HYKzu15unbFnov0AdK1vXAGgrObZgGRW82KKrTLXCY3vIOE+Z7teCi286Oio+SbfiTHyEQSNiDlhULSU/IJkC0Ds3pCFP0P/OLDkAkW629dLW37wTmYlm77t3wRraO4c2nYMzJ+ArAdjVECUhTLRVbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520057; c=relaxed/simple;
	bh=nvR7xcOajIqcXGDD5teNd3zXhGzUeZ4squpuA/i5ois=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W4VO5BOBo5R8e939pJ1W63HI5ll9l9sRmPlbEKhDQiyVvJpLi4B/bIHEB9SguA4P8jYirjTkUpzwStIA1kIcNJfWjVo1tvaY/NNhCIcuX33asJqNeCwVfM0gCVtiH6mb8DGPaMUoXDUoPo9BXbRtNStEfLfN5zXti+uFapnEsaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WIMQIsKp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I89WY1007304
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:27:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jMPy8yrkDmCb5asvMqXUa+Y8wrsQZ53xq8R+umEMsHo=; b=WIMQIsKpv9GfAm5I
	ev3oeWosKVrnDa/6A03vLd/3mYs37tOJjR5sXHXUhq2MR/IvotYdBIzmOGHIWV1P
	RG2HOLA4QJCxKrCZEeVY0IlYl1Ii+wAIVevPA+u9b8AKHKaraIBDY03+Kn4eCjYg
	dqwh34Qdjb+U0rBywOm6aAnQmzT5v3S2OF81VSIiHthtXgK6xhEZjsGwv4O65sPS
	KUucP+XimOiXo+cYkbGStcdQiSub2Ug4sb0oy8C2Toug9wu3OBhV4Jcag8UXnTJq
	qYA45M/YQak4Dv+c5ga56fRQec/DQ9dAGLG9bMMY5RUIddqxfjjlPrqwKvjaQS6c
	85PxfA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jgxtcsyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:27:34 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70a9f57ef93so88210556d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 05:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755520053; x=1756124853;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jMPy8yrkDmCb5asvMqXUa+Y8wrsQZ53xq8R+umEMsHo=;
        b=VNTnhkQzDs5Gub+Nlva7eZBc+6P8y8rjzh1EiZDBpb74fadAgW65RMb2GVh5t253qT
         u062nVRdh87N3smBp7iuaaVr/qi7fE06+aumb8OgSJe9/LwhLPcViXCZBfzUFJmSaOBX
         W/tuX+P7hCNWm8gw1H9Fc+nhQ6dqtGuUvK7vMNx4Tcsc5kJ7tUMBWkmemBBav6+zPwOA
         3wrT0QnRgi8qZLW21DPdsJhVQz/N0SAybioEkyJpw8eS7HET8KaDEJXGzH21oArycESR
         MM7L4kPzxZ/9LU0Yef6w00EPvwQ1WfBlY/5fqC04yYp7Fc2Inv/NgPMfL1lvdBMJ2ZtM
         87wA==
X-Forwarded-Encrypted: i=1; AJvYcCUeyhLLDZ/A6G4HUaX/MuImmYGZF22jku0c8LJCSSC+UXtsltxbCYmeZe59W8ghQDgMLpRRpVU2mEr5Gms=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRJeaqCTUGML1126LG2p7AqhQ8j7o2dJRN2IwRAMY+XUOa3HpH
	cj4yoCdt5CJlD7lO7d85/2cu9TzFNoKJLqMturzWFcE3OQFg64qou5uAY3VoNjHZTHsacgkSZAw
	MgqbuQCAu1RMgDgbsSOo9SVmjrfEzqudz4oJUPlOs08332RV4iUjQMgdTiCyiDtoXC2I=
X-Gm-Gg: ASbGnct9f5AQTORL9SB7qvgVCobEghEs4J6hJC153/OMo3Sjqx/IAGcxFvGV9Qa7IIn
	4f4/2ZhiMrlzS5JDW3h0z+I03WvvfLR0qZVkHA0YHTLk7JCBvzbtV6C0PgIa4zcSm6OvH+nWihB
	v0LABgyV0xfpD7l1zZCrCaf/rQNKOwPHJ7f9gfvKBgPyumikPgy/Ek0jggU+yv9sa7fKG4zWawC
	p3odq2CFKfNA9Fs5AmtI3xU7ylUEYsdMTEp3H1y4RjuNfnxhJseHQAs863IIp7RdFMImDXLpEBp
	9pmzYs31uMBu1Tl2VxCRyKR6kCBskMyYc80jlgrYacpc6dbg1n5q3mcRKpHlkK9EEpc=
X-Received: by 2002:a05:6214:226d:b0:709:e54b:2633 with SMTP id 6a1803df08f44-70ba7cc55d1mr157153266d6.50.1755520053553;
        Mon, 18 Aug 2025 05:27:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyU7b2CpB2bLhXFIhOwMNDjmxVMc3MEJKn8wBDlF5tVrAmW41yFTSrE4nmNJj6aGmyyhUfOg==
X-Received: by 2002:a05:6214:226d:b0:709:e54b:2633 with SMTP id 6a1803df08f44-70ba7cc55d1mr157153026d6.50.1755520053055;
        Mon, 18 Aug 2025 05:27:33 -0700 (PDT)
Received: from [192.168.68.118] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45a1c6be103sm180437045e9.2.2025.08.18.05.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 05:27:32 -0700 (PDT)
Message-ID: <7e26efeb-d499-4f58-b42c-dd37c2f680a8@oss.qualcomm.com>
Date: Mon, 18 Aug 2025 13:27:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] ASoC: qcom: audioreach: fix typos in I2S_INTF_TYPE
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20250818122240.1223535-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250818122240.1223535-5-srinivas.kandagatla@oss.qualcomm.com>
 <6e0d3bbc-bc30-4ae0-8258-8dd19f7f29d4@linaro.org>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <6e0d3bbc-bc30-4ae0-8258-8dd19f7f29d4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ORoA9AcKXlpS4KNk11VvzXODCqQXstTo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyMCBTYWx0ZWRfX7ZRKB85KFAga
 1IXu81cJh/yyQQ/dmdyVdgWcqpWRRW8G10nrEct3XuHIjkRG7XH8J71hcnUQ0ZYBqOxaAHsMx85
 4FgszZaQ8cI9OCQHYS9UrEzNCG0apjAM/RsE/FVjy/sBJTAI7JNXvnZc5bCygmQ0tBllYSyaQ/n
 qWF4Lazi+cS8eQM5JhJkbtVK0WVfaVsHS4JhhIQeQUG8S+AYQzumzcO0njPFpoNZSDDekxX9nN5
 SkufjREIkToThpUJi4HyfHw2ZVxRJTEg0pNfr44+gMjC4XlDghwb1lVpsGufbpa5BM4/E4lNw1G
 AuATmnXlXkfZStDcD5kKZiX5nlGG7kRfxEd5qSdv4dIfw/egNR3IPazRQlRP00LZmS0gMfY7MgW
 qX0zKheI
X-Proofpoint-GUID: ORoA9AcKXlpS4KNk11VvzXODCqQXstTo
X-Authority-Analysis: v=2.4 cv=V7B90fni c=1 sm=1 tr=0 ts=68a31c37 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=GFBRK3qK-iERJEzU3l4A:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 bulkscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160020

On 8/18/25 1:25 PM, Krzysztof Kozlowski wrote:
> On 18/08/2025 14:22, srinivas.kandagatla@oss.qualcomm.com wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>>
>> Fix spelling mistakes in I2S_INTF_TYPE defines.
>>
>> Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>> ---
>>  sound/soc/qcom/qdsp6/audioreach.h | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/soc/qcom/qdsp6/audioreach.h b/sound/soc/qcom/qdsp6/audioreach.h
>> index 617bda051cf8..512886042224 100644
>> --- a/sound/soc/qcom/qdsp6/audioreach.h
>> +++ b/sound/soc/qcom/qdsp6/audioreach.h
>> @@ -27,6 +27,7 @@ struct q6apm_graph;
>>  #define MODULE_ID_DATA_LOGGING		0x0700101A
>>  #define MODULE_ID_AAC_DEC		0x0700101F
>>  #define MODULE_ID_FLAC_DEC		0x0700102F
>> +#define MODULE_ID_SMECNS_V2		0x07001031
> 
> 
> I think two patches got inter-mixed.
Ouch... that is true

--srini

> 
> Best regards,
> Krzysztof


