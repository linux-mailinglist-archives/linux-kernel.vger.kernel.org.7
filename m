Return-Path: <linux-kernel+bounces-855710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0676BE20C3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AC65405907
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 07:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08A42FE04B;
	Thu, 16 Oct 2025 07:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F6bmnbrS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95882BDC34
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760601404; cv=none; b=O2F+MWUGavaekJs4S5apEqn0w0tjDJ4sZ95/2xu/E6+NkxEuncJU6rogkIVv4zRd+FzIWfyK/sEbVfKpt0+zaNVmxOQB863phzl0fEFn4lT1LqnX2sd3lhaqpNykGQt57uLictkGQz++w0icTdBy6IYQ59tlQO0frMPUOU4nsoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760601404; c=relaxed/simple;
	bh=Jh1z2qwS+DdEu4z545f3xi+xVgiwgZciXQlB+qgqp6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QsYIdpMP/i5pXwghILk6vI1TgDM/MrukONBNDT6swmQcvkDT879M9hw0NlwyTu+inVCITU/M/chnsfU/8Kx4+nEDm6VbmmfBlEmGMDh/O2AvU+MZyhmnUIukPWRprUT+xKGthfDM4NYOX3LKERfjP6opMk3Td3AYnNufFGPfd+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F6bmnbrS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59G7PsXw003752
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:56:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u4HgNC7aJrqDGVyNBmRY6dlyNS/Fi4BfzYUKhOJfqN0=; b=F6bmnbrSrzGPZ0Tf
	Dp1aRK2t/IlRZOCD9IFw7m5t1ia7V3sdnJpne5pfBMgyHE1e+SwRZEpPntd+OZA4
	1QDGc7OtFosRWbe5dV1ZKMQZdt00Ix0+qTQKl1aitCb5RmM4n3MDfbcI9rF/sKTk
	QwFhT+64/cjG4HPcJtkJelCWeX+sgUtsYVKbF4SID29AAeJ+YjDJTsDS4KYZKj/G
	m4kKjpVLCEUI2E1JNtzXPnh35eR4J+RxsrzcYqd7ofopnMt6NemwhzESrUVshhQI
	9klBz0BKLsSqE1Dp5jIkbZ7TcmS4jkLYWIxPggoMUW+MKDJZEglkwIHdXGfxPL//
	itzVlA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfd97j02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:56:42 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8572f379832so14359085a.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 00:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760601401; x=1761206201;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u4HgNC7aJrqDGVyNBmRY6dlyNS/Fi4BfzYUKhOJfqN0=;
        b=slJU7I3aMll8bUACHjBC4xDQv9t9cfnGgyafVWnzZET0C6fOCcpassSgviyckNtXsG
         vIJEbY4zq6WKO5T1WSZtOXb4Yt70MlOKoLrtRDt211RPU/bL3NhmtX3rgzlq7eoPJjw7
         J4FhNjX19M4uwArLoq1j7aqe4Wf1GQYThuHbc9GifDl8pcQIx3CduNkFYq1QQNtJ6Plb
         eZOns9k3Cqk24ZrgjkgvsGYp+KLgDfMRvWBzI8DsmW0nIwTVxvtg1gwrJLcubqGD2054
         FyjC5a6LX7bzRHsJkilVWDEGGEYQ8QQ8E8iXkEXX2HamwZIqcqQh01TuG7hf61pJi0Lk
         FLlw==
X-Forwarded-Encrypted: i=1; AJvYcCX4YJ+6A43mtbi7gVtLwLoZVy1IBsyihwYfcITohPyf50/ArezUBkOzWhpTC08PFe4kkrN0ID61AonYTW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhMOooCWD+ta1ZxqXJT7OjK9KR0tQYKuh/eRQYYiJhuPPN7GhM
	ti4oCNtQpx79boMm14yYuNCEXlrAOrk7eGz4gumbe9KhEecr6O+VldxP7ZFX2MPamZGXXZMTR4S
	FweQiI4ID1/rqken2XpJyVKWxhxAdZks8UliS1ZXdull22GIAciwdTaA/M0bQ2FjeQHU=
X-Gm-Gg: ASbGncsOyGHBPhBUcITiuqHql0sCaf/mE4Wv42b3bWhERqMGcllaBSC+lM3e9FAnohJ
	djP04OKnweRkcGeIXcPQsUlU3XbuObvbxjpD6jhSLsvTQhHeOEgrNLYQTWleiIjFxDKCti0zqUw
	Yp79EAOTcoXiMFx9RBh/rdwxrymiyUhM00kFPTyAK7ZNq3lvt5MOOtuG6htuWzW5+ML+qOUBLXn
	C5BPW3lO4XL4huassa2AVSoP6gUH1JUBXM7HY4FLLczkowwpbwtNaeNOKo+n/d9xT517eW2fXmr
	ldhsFIuKwTO5U7YOO68GK8eQgFEELBm+1SGQ/7qLwnDTmiT4R/CS1iGL4LmkEFPrepd1vsDVEqf
	yHpxDHmmU9RIuQEFAf0PRKzgneRGUyX0jbTj17dJnZEv81NKqAxzvzJC/
X-Received: by 2002:ac8:5f14:0:b0:4ce:8b2e:feaa with SMTP id d75a77b69052e-4e6eacc8772mr273177251cf.6.1760601400649;
        Thu, 16 Oct 2025 00:56:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVX7ZQEtzFyJmnhIE9yt6cHr2wIqLsibKBKtjRREvjjvyyBcO5SEJwCNH5bR44oCWeIBhpyQ==
X-Received: by 2002:ac8:5f14:0:b0:4ce:8b2e:feaa with SMTP id d75a77b69052e-4e6eacc8772mr273177161cf.6.1760601400213;
        Thu, 16 Oct 2025 00:56:40 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63be969163csm4142038a12.13.2025.10.16.00.56.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 00:56:39 -0700 (PDT)
Message-ID: <abc9d825-1e98-4838-9e9c-ca18ba191e11@oss.qualcomm.com>
Date: Thu, 16 Oct 2025 09:56:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] dt-bindings: i2c: qcom-cci: Document Kaanapali
 compatible
To: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Atiya Kailany <atiya.kailany@oss.qualcomm.com>
References: <20251014-add-support-for-camss-on-kaanapali-v2-0-f5745ba2dff9@oss.qualcomm.com>
 <20251014-add-support-for-camss-on-kaanapali-v2-1-f5745ba2dff9@oss.qualcomm.com>
 <e2c43a8c-a9cc-46a1-9ddd-5d6dfc7e917b@linaro.org>
 <49eaf7ec-ac71-4bf3-9a4e-25fa633d815e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <49eaf7ec-ac71-4bf3-9a4e-25fa633d815e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: hTnTD3DhACNr3izQ9FPMtrKBcq2Hvmtg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX2YqAN81wEYWA
 9Ai6KAQCdXXNbMj2EkU8qP+7r5yUJFuEW3ZkTx5vLt9WM9EudoJcalMp3L3G2sbYXhs1OCqs3LB
 kS8VzZhjLg4dmV7ki/npAKUjc3+2i2qvMqAR3Mje0zSG1oQ6NoIXbnskjO1MStuNQt06H6BlLE6
 1MO1wnL2pM/+MOdhnwsmeFHeriHqnCYFmeZrxAhAQ++FYrOAvpcK9H4dfG0ySZZu/Bp8Ef1EpOm
 Lm+dJ6h/icA6IZT21mNd281OLhiJXHq/CSubCz+lKRDX9reUIdeSXwZ3yDg7lpelns5E6rVXmS7
 TFBC+2LQV7t2fkefHAUzIJcBCn+hEpF/+2PrC5D6ImI7ZyxSsWEoOws4mLDteosAIYddEdMK4fZ
 P8eSSDPWDy3adVOEJE6IBMOZ/qEL3w==
X-Proofpoint-GUID: hTnTD3DhACNr3izQ9FPMtrKBcq2Hvmtg
X-Authority-Analysis: v=2.4 cv=PdTyRyhd c=1 sm=1 tr=0 ts=68f0a53a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=UKwaH1GiQmKLMY0bYhoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

On 10/16/25 3:56 AM, Hangxiang Ma wrote:
> On 10/16/2025 3:30 AM, Vladimir Zapolskiy wrote:
> 
>> On 10/15/25 05:56, Hangxiang Ma wrote:
>>> Add Kaanapali compatible consistent with CAMSS CCI interfaces. The list
>>> of clocks for Kaanapali requires its own compat string 'cam_top_ahb',
>>> aggregated into 'qcom,qcm2290-cci' node.
>>>
>>> Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
>>> ---
>>>   Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml | 6 +++++-
>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
>>> index 9bc99d736343..0140c423f6f4 100644
>>> --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
>>> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
>>> @@ -25,6 +25,7 @@ properties:
>>>         - items:
>>>             - enum:
>>> +              - qcom,kaanapali-cci
>>>                 - qcom,qcm2290-cci
>>>                 - qcom,sa8775p-cci
>>>                 - qcom,sc7280-cci
>>> @@ -128,6 +129,7 @@ allOf:
>>>           compatible:
>>>             contains:
>>>               enum:
>>> +              - qcom,kaanapali-cci
>>>                 - qcom,qcm2290-cci
>>>       then:
>>>         properties:
>>> @@ -136,7 +138,9 @@ allOf:
>>>             maxItems: 2
>>>           clock-names:
>>>             items:
>>> -            - const: ahb
>>> +            - enum:
>>> +                - ahb
>>> +                - cam_top_ahb
>>
>> Why is not to give the clock "ahb" name like on QCM2290?
>>
>> On QCM2290 the macro in front of the vlaue is GCC_CAMSS_TOP_AHB_CLK,
>> and name "ahb" is good for both, I believe.
>>
>>>               - const: cci
>>>     - if:
>>>
>>
> 
> On Kaanapali the macro has been changed to CAM_CC_CAM_TOP_AHB_CLK. GCC clock domain doesn't manage the AHB clock but CAMCC does. I think it's better to create a new and more complete clock name to denote the differences between them.

Are there any other "AHB" clocks going to this block?

If not, then this is more confusing instead

Konrad

