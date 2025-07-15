Return-Path: <linux-kernel+bounces-732289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5ECB06492
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 18:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4FEC3BF6F3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77B126E708;
	Tue, 15 Jul 2025 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JK8SFQAN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A475718DF80
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 16:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752597948; cv=none; b=L/q4usfiq1CJcmY/WlMYz5iPVoMngLhz2W6HxZlxcI8f15oBQJZJ+xT5o8nkT5es1Cv5YjRgyoKS07VGdn3y2lEgW4xS+/5wpKVS9xx2hHOudHs1akDTvmyPLJnNFXZtVU0AohYfPy3E0ztkHHXZcjHPy0fe7vFI49ZHOhzPpR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752597948; c=relaxed/simple;
	bh=CAvq3xWwlSRxIqDtyRSbsSlWz69i/WFgheviQn0G56M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aXpSEycdY/1DvOScyei/Uk2eIdUexr7a+Xjp/B1bNgV103tWfQQAxRc0YLm5V81p8Qbspu3D98j8mi55gsqI/51JaTYD5HyZ/Mjh9hSz6Xy1lfyYQDPgWigd+Wu4mT0MaD0EqeX/ZPWY0W+9ybOwTJbQoHlM6KsboRf9ZjrpZuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JK8SFQAN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FGDHfv018086
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 16:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IRW2YfXnz75lh2P5jW3xjEn1uoHSrDyBYTGEbDrJ6Pg=; b=JK8SFQANRA7aUyB3
	55eKIFgTgJNs7dRqFY8giImNIdqwHNWCiuchVxwd+3C67IotTkNXRQ/aZL+z8CvW
	DgUBeQ9pQ+YhLYEJ7pwOEL8z6E7WEzDVARYCenu6Eq2lEpeDcmcOpkQukH9c9jrG
	wu5SfTmZVXw8O3IZphJvGdzvrE6m4+6fhhqT6X+u1OgA+7dKwH1HH2pOcOasPq79
	NtO/5yC4jNQDHIrAdOs60lfVIQiS/F47+Nn22qxo8HRiYnE2w4JERJPM4yOiJf8L
	gaTngiqAju7mp5KOVmXiF5sw3nI8A9M7JcDBLBHHoqVp63h2ddXfnMhf5KBeHoC1
	IQJaBA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ug3814n8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 16:45:45 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4a9bcdc73c0so10373871cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:45:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752597944; x=1753202744;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IRW2YfXnz75lh2P5jW3xjEn1uoHSrDyBYTGEbDrJ6Pg=;
        b=MtHhCLebZvejfXpeMYvrhE6H1OqX8KdMBFIBEye3IcqsF4BUSdWdqaOgNxQ5pq2GyH
         JD+TCnH7iy544HOR9fy/3EY5Z7ORdje6Ww7lC4ic2TOD/uOzfQa9rhBC5oEq34Mrs+FA
         YF8w2ysXDIJivGx1zceD2C+hZBjHaYTMk665B3TO8zBvDeFjAgK7LwQSu5tQRn7lXzud
         YEGkEnM3UrsaMmFYvJWOx34iBTodTXCZwKbSm3nmyYfjP+UMl7d8nibFReOv/DzDzBIB
         9caOykIykJ5JPTVKaPCJ09E3RLRnpAwlXxRCXHJao+YLQ911ceib/2xp3XOAqDmC4xYg
         r5Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVXJxzM7DBznOwZChimq6VQiIRApcK14eyoNbTCmHX7TP/668XPWM/8Tn+R1e4PF3rXdYiS6EZkQ/FqAOY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/IPxBSpNOz8Y9l/t4Uf7H5LSKQVbFLRbHMXPWJnFibmEWcCZs
	Hfxh4HoM2tjJihUuHUS3tz1t8BcMTYElMwPH3J5KzwEjT+jNWxoUh5Ia59eVI7+5z1oezCIQmHR
	enAcrEFPQ9h9smuov3FRk0q1w/Wuf0dm0hUB8Z3A3lhQ+EhbQ0XMNVlyqt8Zc1Z7De2w=
X-Gm-Gg: ASbGncuYO+Y5IlyNtSYMRnoO/A1J0MXihwYG6Kbu6DoqgmUXwN+G28rNTKXeQdB7Bmp
	JZBC5QJvParVOuEGr9mAjT1ba5k4yzsyYLoZIJ7sVvcaJlUwat38HM4ttMOMNLnAq95bh4OR8mF
	jRjhbNar2HzntlZPQ3KCBJStthvWo6VXIAjonIpxBBvXqPkuObQ6ugFChF2TAjfplt//yM+4MiX
	QcsTM86oTo5tg6uSM60p8sLnAAOYTCILGFWu5tVFjDPBa+GahzjJmbMithBXS5okQd5LogQ519w
	GIdeWbBaVcwmIOkdbGLpTER+9ljLGTTrHtN8CNRLSHVG9zhEP6ZX+DfbZIipgSXpvLjFl/ncV8S
	OLqWuzQTK8bl9Oc09wbDi
X-Received: by 2002:a05:622a:428c:b0:4ab:72c1:cf31 with SMTP id d75a77b69052e-4ab90c78a06mr692821cf.11.1752597944382;
        Tue, 15 Jul 2025 09:45:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUSbiaD5h7FFwcgr9nByxMFm6MOpok7tf+ZKTIqSFYmdLyYC4qhDAeOW31yQu16CpuN+mf4g==
X-Received: by 2002:a05:622a:428c:b0:4ab:72c1:cf31 with SMTP id d75a77b69052e-4ab90c78a06mr692581cf.11.1752597943667;
        Tue, 15 Jul 2025 09:45:43 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e91c81sm1035358266b.37.2025.07.15.09.45.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 09:45:43 -0700 (PDT)
Message-ID: <3d4a1f7b-dabb-4402-9eac-6f3d93d17ff4@oss.qualcomm.com>
Date: Tue, 15 Jul 2025 18:45:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: Add bindings for IQ8 EVK
 board
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Umang Chheda <umang.chheda@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@oss.qualcomm.com
References: <20250623130420.3981916-1-umang.chheda@oss.qualcomm.com>
 <20250623130420.3981916-2-umang.chheda@oss.qualcomm.com>
 <aFy7wEmP0EzGUHX+@hu-bjorande-lv.qualcomm.com>
 <39d6a38d-6728-4998-aca2-23138677123b@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <39d6a38d-6728-4998-aca2-23138677123b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE1MyBTYWx0ZWRfXysZomG419AZL
 8+z5YtzCI9Wlz7S9UUvkDWjiQhMsdE3VQjhb8nJpGLXWlxIpD8EJuHYkFkqq5Gz1PBQTCccUoRj
 e41zoR4xu42eSiMqv70j+zNy8whB+Su9bOwhPdB6tWdRLnR39nklqmSpzmh58Jyyexsuo97WX2S
 DtrfAlgaDpGkFsNp6USNhQVx309/cWW2u5beCI12oYs56GfgYkg1XXh+/2jIuUElYDepDoQzJG9
 NpIVewa+qugKiVakTz10RjAmEiMEJBWTdV7WOm5ZF8mbERfCDIVaRfJMYM07e0ZOF7242PwcMgc
 bA9NBjds/ZRAf+ZuwkD9aX1NqRnBzpPdSW9/MXaEbSmmIY/B98RA9UqRIWKJbynqtSWoEH4glZB
 jumgqdjgamyouH/qLuGYbbIEP0z1L/ndLXF5FMBx2pscsEuF71ihVFY1eKPJt6Tx0jESoqNn
X-Proofpoint-GUID: ytSbvU11sb9lu5cQaJptCBU0aW2CKw94
X-Authority-Analysis: v=2.4 cv=SZT3duRu c=1 sm=1 tr=0 ts=687685b9 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=-Hz8NQWEh57Cco_qSV0A:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: ytSbvU11sb9lu5cQaJptCBU0aW2CKw94
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507150153

On 6/26/25 10:38 AM, Konrad Dybcio wrote:
> 
> 
> On 6/26/25 5:17 AM, Bjorn Andersson wrote:
>> On Mon, Jun 23, 2025 at 06:34:19PM +0530, Umang Chheda wrote:
>>> QCS8275 is another SoC under IQ8 series of SoCs. Unlike QCS8300
>>> which has safety features, it doesn't have safety monitoring feature
>>> of Safety-Island(SAIL) subsystem, which affects thermal management.
>>>
>>
>> QCS8300 and QCS8275 are both the "Monaco" SoC, with some differences in
>> which nodes are "okay" and "disabled", and as you say here some side
>> effects thereof.
>>
>> Describing these as "Monaco" and "Monaco with Sail" would lend itself
>> for a better structure.
>>
>>> qcs8275-iq-8275-evk board is based on QCS8275 SOC.
>>>
>>> Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
>>> ---
>>>  Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>>> index b14206d11f8b..19823bc91a3b 100644
>>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>>> @@ -54,6 +54,7 @@ description: |
>>>          msm8998
>>>          qcs404
>>>          qcs615
>>> +        qcs8275
>>
>> Please add "monaco" instead.
>>
>>>          qcs8300
>>>          qcs8550
>>>          qcm2290
>>> @@ -935,6 +936,12 @@ properties:
>>>            - const: qcom,qcs404-evb
>>>            - const: qcom,qcs404
>>>  
>>> +      - items:
>>> +          - enum:
>>> +              - qcom,qcs8275-iq-8275-evk
>>
>> Please use the qcom,monaco- prefix. Is qcom,monaco-evk unique enough?
>> We can sync up offline on this.
>>
>>> +          - const: qcom,qcs8275
>>> +          - const: qcom,qcs8300
>>
>> Please replace these two with just qcom,monaco.
> 
> We could in theory keep the SKU id as a penultimate entry in the top
> level compatible, but I'm not sure it makes sense given what we want
> to achieve (just thinking out loud) - exposing soc_id through
> qcom_socinfo & sysfs seems to be enough, and if it's not, we can
> handle the odd cases separately.
> 
> All in all, let's go with Monaco.

We iterated on this internally and the general agreement is to keep
the numerical name for existing platforms (because drivers or anything
else may be matching against it) and introducing a second label for the
same SoC could spark a situation where a driver checks for qcom,monaco
while older DTs lack it.

We'll go codename-only with future SoC submissions.

tldr:
compatible = "vendor,boardname", "qcom,qcs8300".
filename: codename-boardname.dts

Konrad

