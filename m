Return-Path: <linux-kernel+bounces-842877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B7EBBDDB7
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 13:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1B7D188436F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 11:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC89126CE2C;
	Mon,  6 Oct 2025 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bc2S6BiZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C095621C9F4
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 11:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759750015; cv=none; b=SxpL49j53a2aLVE2QkXvaq3jA7V9UPTCB/kT8OgDUwxHHIx5UY+D2WFOHlLS1g1+ZKhNlc/mli8Xqohi4qyIXvzJRVLA53w9IM8o9XGQ3EdOZGnJyBdD2XSU0dUoUj2iSHR3msiYZt1xaLLaYYx6CqnPTPaPr7I22DrC8/8zBAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759750015; c=relaxed/simple;
	bh=OJJklOwu3/0SKE5EsxHn29Z7yBO5CNM0dSLYYxjUZCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lhFyD2jXLGJCM5T2wmcWSwv5H2o9BJOK8SCwLzBp/CXemdpggzAP+2BzV1bn1jLagys6cvI/GtJvsuUN9dkGqTAs0uzGPGUy7veWLws1JcyWBPIp/mSCuH6YvV0T/O78F5aRV90qIy5IKofA166RZkBNB3ieUfTjVCBOZ3fnu04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bc2S6BiZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5960HjJd017099
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 11:26:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ha4U0nUFlXsSLIdmAWsMkj190valyUtBSyykuTVk9/4=; b=Bc2S6BiZQlMJIPA/
	U2os9d1vCU4hGWgRx2V/73jUppow+qi876Utd4KzELGvMSmpGPGHNy1oiPq2KLWu
	acK+BZy08Li0olxyXydSoXHiQbkYqyW5DXJ9XB2dJCpP37EXQjit38EbItfSUj4b
	ZWYVJUPhBvX9jLEnxnYqqTyYsQWs9wtA8jewHgWnBfNslYVu0LwNhjw1xvTBH5JM
	4Pyy4rbF+cQ5B/OpNBLXPZNQfkv0azKiSiLEAlpOvpcTsJSni2quDPl/nF7E0fpr
	3bqNvrr008vbEuMYlrDJ5J0K1zwkgajFPWlGVBnyJLWdVQfCpt8h1TOjlzP1jnj5
	c2/QTw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jvrhkh87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 11:26:53 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e4b4e6f75fso14352121cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 04:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759750012; x=1760354812;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ha4U0nUFlXsSLIdmAWsMkj190valyUtBSyykuTVk9/4=;
        b=Y1LTDJ5VM2bAbowSNANzpcGQlBUy6OFQLvTCQps64SmhFfuDtEOENrcgI6KtQSePD8
         2XbyUCsm6unalQltEp1eO+0gTH2yX0XTuzQs3MYNqEts/vuPDoWqEPjeVlJpyf5etcDo
         0n+rqqv4Y/MQBqejCzaz+R6rRcubwp6wk/tBInspW3EQnKtOYjBzeu2bY8z0JDv2kwJB
         ewVqmgkdxfhoj851THNgbMEUQ2WkBS0Vr4W5IC6J/FPuNmy/y6H7DvLlElr/HYhBoqQF
         4uivGy2HTrdRxYJrsL5aY1EZ1x54a0D7Kr5kJeBoQIRMHuwlxWzvfQdKZkoAhW/t6/JX
         lDag==
X-Forwarded-Encrypted: i=1; AJvYcCUPc69rf2GbgcnxqC01A/6d2qrZKbC2PW/rDq+HS3xdVMetA0dkJAFEpglO0m6RkT/q8Cgo0E91hNTnnnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmFZPLlvPBRnBBui2qf+wQH3N6/6OPaiY2GPbfdxVoU7r/eI6X
	whESOYP5nFRSz7GKfQS1jMF699nX99lDoh3GgI3wAQk2+N9tqT+HifTRsdaKGsso/U1o/apQmgu
	kuaSXpSkbqBdjNphPzbLhMqa2Ze8uaezT9JnWEE6dp3bXDoE21utuS2TEhytzjrKAhR4=
X-Gm-Gg: ASbGncs1gRTuqG7HMdZLwSMjvkQEqYW8h3rzTCz8YiEbZ9uXlDvA/sNXuCgAU9Hu8iT
	8onlsNHwJrCsYv0pNuk3A52+Sx9oXx1BZmD6ds7HTMF5H/tl6Fc29LzGRNL7+1pfVoblJK7uGa+
	MDFCpoSYmh0dGBqyKtpDVuhVD5Y0VSFYoxkG4epbxYRyXF8WvgzBVze/evv481QA8bex7vM6aRn
	dm8td5F8qD33TSh+EzZDzI9HyFG44hHE5zVua3doQZYuAdii7SLLuInQm/RxOxhp1bMS0UXn1Jl
	bTTuF8ZilTYymoTjb8FKrPj5wYJMNEkOLvBBoxKImZkvCebxTJZpFbRD066DMQ9CUF/b+Q10esW
	0T/RNvQTBhKaP95mfr9mRBy2TjEQ=
X-Received: by 2002:ac8:5fce:0:b0:4b5:e606:dc13 with SMTP id d75a77b69052e-4e576ae6a6bmr98905911cf.10.1759750011451;
        Mon, 06 Oct 2025 04:26:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFr5JugyuxL6R7D1qRUKV0mDdmfW8tgzw1IX2E9rrHEvRPTlDCKIkmW585y0xMCFlDqneE/DQ==
X-Received: by 2002:ac8:5fce:0:b0:4b5:e606:dc13 with SMTP id d75a77b69052e-4e576ae6a6bmr98905681cf.10.1759750010736;
        Mon, 06 Oct 2025 04:26:50 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4c83adec08sm419592766b.56.2025.10.06.04.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 04:26:50 -0700 (PDT)
Message-ID: <cfd85d73-a019-4cb1-8162-3c12611d9296@oss.qualcomm.com>
Date: Mon, 6 Oct 2025 13:26:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: qcom: qcm6490-fairphone-fp5: Add UW cam
 actuator
To: Luca Weiss <luca.weiss@fairphone.com>,
        Griffin Kroah-Hartman <griffin.kroah@fairphone.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        =?UTF-8?Q?Andr=C3=A9_Apitzsch?=
 <git@apitzsch.eu>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20251002-dw9800-driver-v1-0-c305328e44f0@fairphone.com>
 <20251002-dw9800-driver-v1-4-c305328e44f0@fairphone.com>
 <dfc093a1-e13b-4342-9015-5a896bf18d5a@oss.qualcomm.com>
 <DDB553DRF89P.15C4AKUO7IQXH@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <DDB553DRF89P.15C4AKUO7IQXH@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAzNiBTYWx0ZWRfX4xaT3J29/CBj
 e9Jm2V8yj+Qrge3CXH6sIjUOZLkxCD1BsjiNB64LdSQhEA7W8iX9Wsj6/YxQjpujWoi9EVRyvT2
 wFMYdVkAvqOBhhE2PZDdo0ybhB5SsvZ4wpC6vFpQdWrT3iuL4W5zTirAMTW51QJoy5t2WDueveh
 xMmtvXAvc5F+ovRpR3DFe88nvNsOEFoz0sFexa2DrKy8WGsYS7LHHI6R6B31u6XfxlbPT+oowKf
 W9HPRUIG8rzj6jq4MJCx/B8pOicX7Ywh5N0BaUC84qi2omqT/o3biaWCBDkQvzHSQ0OK8na9SYX
 IMYymWs+Sb6BGhOQJ/GRNEBPMo90qYV/6BajgggCu8bCSy4IqWD/8ToP0Vh0wviLQXHDetHVxBC
 Lc96kVG5hx/XRMKHsSyS9FMcWnvsUg==
X-Proofpoint-GUID: jwJMEOPi6jdhai3zXb0Ffs8sIhRp6bWb
X-Authority-Analysis: v=2.4 cv=XIQ9iAhE c=1 sm=1 tr=0 ts=68e3a77d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=HDjIzE35AAAA:8
 a=6H0WHjuAAAAA:8 a=gTkJHdstRq_Xg2VDakwA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=y3C0EFpLlIT0voqNzzLR:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: jwJMEOPi6jdhai3zXb0Ffs8sIhRp6bWb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_04,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040036

On 10/6/25 11:44 AM, Luca Weiss wrote:
> Hi Konrad,
> 
> On Mon Oct 6, 2025 at 11:20 AM CEST, Konrad Dybcio wrote:
>> On 10/2/25 12:15 PM, Griffin Kroah-Hartman wrote:
>>> Add a node for the Dongwoon DW9800K actuator, used for focus of the
>>> ultra-wide camera sensor.
>>>
>>> Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
>>> index 2dd2c452592aa6b0ac826f19eb9cb1a8b90cee47..0e86cd5ff527925c7dba15c4e0ee5fc409fe4ce6 100644
>>> --- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
>>> +++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
>>> @@ -627,6 +627,15 @@ eeprom@50 {
>>>  };
>>>  
>>>  &cci0_i2c1 {
>>> +	camera_imx858_dw9800k: actuator@e {
>>> +		compatible = "dongwoon,dw9800k";
>>> +		reg = <0x0e>;
>>> +		vdd-supply = <&vreg_afvdd_2p8>;
>>> +
>>> +		dongwoon,sac-mode = <1>;
>>
>> This property exists, but isn't documented (you need to extend the bindings)
> 
> Please see the patchset this one depends on, which adds dt-bindings and
> adds prerequisite driver support:
> 
> https://lore.kernel.org/lkml/20250920-dw9719-v2-1-028cdaa156e5@apitzsch.eu/

Sorry, I overlooked that!

Konrad

