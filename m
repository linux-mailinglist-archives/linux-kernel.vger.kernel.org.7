Return-Path: <linux-kernel+bounces-833974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9B5BA374F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 722AB6259F4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6ACA2F5A00;
	Fri, 26 Sep 2025 11:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HM+TxST6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B778D2F532D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 11:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758885281; cv=none; b=vFaT3n0j2QnLSYZFtrPdIN5BbRcVYB9ytJ/lmhXhvhLAKfBMJZ9k8HtT8NqWpg41Md2+1sjWyoIY1lU2I+d+bETbgIOYWkobcQviTWiYBGRIXf/8eUtM567L8DPO8cEu4xX0sBar0uTO6l54VGtEbI/Gw3HY1ISJOAC6E+bfD4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758885281; c=relaxed/simple;
	bh=iDSw11pyqhbkgwpWYT4ZdIm+jKHusW8fE0X5DlrCeps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ebChi8oBV3HRq0MqL6iSYyZpzX058OXWu/UJMqq3STaB8lX3d14IaSp6kr8ouJ6RGr2sOw1dXvTfBtcy0vFnsze4MWz1cSltbe+ygtmaIXyuVEUT64qM1FGVwcoAW5GmlzGVEZTgLNn8VL3Sd9OO7h4H6sn14tBQCBpRE3W+bSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HM+TxST6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q8vX9t009596
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 11:14:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v+mnnPyYM8R/xd6RV1KS2fBetyQnGZ7XuXS5A/9vnvA=; b=HM+TxST67Rpp7mdH
	8aW6xAI6VB8Ar3P4jmTQbwZAaj5FTztaFpXnrVr0r7k+7fXvt/DP93az8OLYOc87
	m0DCiP61MsORkID1E10nl98bf3F5+CUFtwpwjW5O/VZsI287MzG493CW8KUP8MRv
	MkXsCRuWcOygkl3R/Ej3xxdFzrntteW3H5Ej6p8RxebkfMlq6CMcEst09K2wLRv0
	TFLeCDAh9iefz9zqOyIKwqXJX5zzo2SVo24KHsI99dWZfM3CK/MBmwN2jD6GfSRV
	uTFo+QHkzwELffMv6fJ+gfjyU4NH62c4Euk3NAxSt+eD8nIktF8ab3MXYFnWoG0F
	Sq6ODA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0vtm8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 11:14:38 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-82b15c1dca8so79648085a.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 04:14:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758885278; x=1759490078;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v+mnnPyYM8R/xd6RV1KS2fBetyQnGZ7XuXS5A/9vnvA=;
        b=rEFZe3LN+WOND3urL5JiSy+kv4VMhzFG49wtjB/ZM3Sn1vEXGx9m102rb7VU/HsOr+
         ZhPzNVTbLO0oIqpHZ6KoXSLmi39fLg1tcQqK/nHtiH9IFKsPIIxIed5I3toel+6qp2TB
         IMRHx1rc389vkIjWOE77P6TDmEiUfwMY9fQchdkTwQlyPgf5dKgthTC2LCeEcOe3yU0X
         BYhQaCONrV6IdH6vMfl4BModlRn2W822RMbWvRzm441knsTPMfDIUN/T0DngZF+1iI3J
         vUsk+nYSYph6LxF2zmpIKYM4x3TnlkfdaQH+xzJ4b8hCl7q5gRAWAsERqaIBKKwfz+Mb
         rXMg==
X-Forwarded-Encrypted: i=1; AJvYcCUyfvttVweve2lp3SwmC6WjtxDZzvXa9aJGD3b6NStzZu9viRE9FQjM41Z3YB7ZfC+XAj3zt0ynBHr4y/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW5idG3PPWM5I0udBKrmczoqdePQMNDW6q5wgD0js5HZlU/Bqw
	WxmvMrVhKlcCCMtM7rvHrV7plQIlKsUJao/DZmKwEj/6e8g3yo54HpaXwgZdrFoZQqJt3BxtYM8
	jbcHvzGrS2nXA7nRqYgfHx/XTo3lhwLjXDTVqS9V7cRN0N04LRsvDkLw3/p9hB0l2xC4=
X-Gm-Gg: ASbGncsOErrBHazI5N4AjinJpIxuwah9CgJDutnDonO5WQO1w5xPAXn/sYrb4f0WtNM
	iA0QWeCQQbqDXfHMwgtd3vAJtyV0ku7cAOEadizZRbXPFzfMbQXrkE5yjNmuvVewi6TjM5LyYUH
	R3IgeEFl4zzk0i1iuppuD6qMitNq39gKgSSKN5uNL2z3JrhjUOuzRLgElgLm84hctCGlio7t/kd
	HIGtHGavR5vHzp+RbixXR8yB1gJ6/8gsdCtMQ5EeZ3H/QVQUmpsNAIdJLBXZGnernnpFg8q4FcL
	utL2wD15phDAOt2tO46E9Cm2lPcr44cDj37g1Cdy5UOb5C3Z+xNUCKEiTK60G9dZLSKsnSRbvMi
	v4ZSJCmNsOPeCvwFaxKIqtw==
X-Received: by 2002:a0c:c785:0:b0:801:2595:d05d with SMTP id 6a1803df08f44-8012595d527mr37523856d6.3.1758885277719;
        Fri, 26 Sep 2025 04:14:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVyVqDH56Rhc9V37bZmDRMzW77b/9dCZm0TB6JT1QzTWqi62x3w727VCI3OQtYuS6z3lWFeA==
X-Received: by 2002:a0c:c785:0:b0:801:2595:d05d with SMTP id 6a1803df08f44-8012595d527mr37523606d6.3.1758885277246;
        Fri, 26 Sep 2025 04:14:37 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3629badsm2664309a12.9.2025.09.26.04.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 04:14:35 -0700 (PDT)
Message-ID: <4777e507-c329-4c22-a45f-099fc57e31e8@oss.qualcomm.com>
Date: Fri, 26 Sep 2025 13:14:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dt-bindings: clock: qcom: Add SM8750 video clock
 controller
To: Taniya Das <taniya.das@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20250829-sm8750-videocc-v2-v2-0-4517a5300e41@oss.qualcomm.com>
 <EAIobHjo8rM1e0LwqDqaUllC0qjV5ElMMhk6KgT1oNnFt_-k7ctM2_6kym9OjEtse5o4pOFM7yCkXgrSGRZhuw==@protonmail.internalid>
 <20250829-sm8750-videocc-v2-v2-2-4517a5300e41@oss.qualcomm.com>
 <d965949c-a7a0-43df-9bf1-c1232fc7e38e@linaro.org>
 <555039f9-a168-4a9c-b45c-d4583c553bc9@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <555039f9-a168-4a9c-b45c-d4583c553bc9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kCg1lRQCy-xRY9Q8Af4u7p5U6MVSgWBL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfXz+H/qIvogysT
 4gGG9XCO7QMeSF0RJDNs9OzHHRvw+R1yyCyy6xjw8HsJuUv09Wr3Sf6DoweplBp0uy0h9diYx/j
 OepvL507V4lLu8dOpD16S7drzUIWHwZJNhjI0j7YGnJzv757/3BUoeoRm/6xsG0+IUycJadwosN
 Plq09j1pw0sUuuIo22xzEveoYOj6jK6nJHDNKSySD6CesHgtetDLVxNyivUKIgFTntqyvncJ9BG
 wxvR1orZn9MbvY/PvzdmwR7NAK99gVgBLwOPJE6eG3RjzmFWVELzo2eyaFNOv2pLQAqrk21vPul
 tGC56ykKA1+QC65mmgffsn1ieTnbmjx+xgUrsHsvt3HjxaoU3i6jgxY2raxmWRB82QWDAwnTqCI
 xzdpq4zvHRNdWhbdt7XwDscGFe1wNw==
X-Authority-Analysis: v=2.4 cv=OstCCi/t c=1 sm=1 tr=0 ts=68d6759e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=pvYLOa8aNrQGL8lVqOcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: kCg1lRQCy-xRY9Q8Af4u7p5U6MVSgWBL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_03,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509250171

On 9/26/25 11:18 AM, Taniya Das wrote:
> 
> 
> On 9/15/2025 4:28 PM, Bryan O'Donoghue wrote:
>> On 29/08/2025 11:15, Taniya Das wrote:
>>> Add compatible string for SM8750 video clock controller and the bindings
>>> for SM8750 Qualcomm SoC.
>>>
>>> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
>>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>>> ---

[...]

>>>   properties:
>>>     compatible:
>>> @@ -25,6 +26,7 @@ properties:
>>>         - qcom,sm8475-videocc
>>>         - qcom,sm8550-videocc
>>>         - qcom,sm8650-videocc
>>> +      - qcom,sm8750-videocc
>>
>> Shouldn't this be qcom,pakala-videocc now ?
>>
> 
> As of now, Bryan, all of Pakala is using the SM8750. We can migrate
> everything together to maintain consistency.

We settled on keeping new compatibles numerical for already-numerical
platforms (except board compatibles where all the fuss was / as it makes
sense)

Konrad

