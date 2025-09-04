Return-Path: <linux-kernel+bounces-800825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B65DDB43C99
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 189261C80578
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26573002CA;
	Thu,  4 Sep 2025 13:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q2YlZfvG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EBB2FF671
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 13:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756991278; cv=none; b=RMugMGzuF1ucGs+5QzNRcXhgvTb2eAVlmDXwrzYQhfAZePkpqddp/2ac8ioqa2PXCpF+NxqTXnKzsBlBahffZtN5SnzkW/+V7l3K7xO/3vaCMobjXZoPaz7JYIwlRDVs2uGo7l+eWBY7HfBojf8RDWWNQD5twejLs+qNEQKLDGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756991278; c=relaxed/simple;
	bh=i7Wda34KnkW6Mxr7vtlQckQo/CbsEm0PTQVYdp+T5xs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X2P0fx4ZjCICQsINfkUQZB3ow2oq79Jct0x2WfnV162RByXZhVYRkPpB1GGE0o9vy3tjeBTQI/Nq7eivpcMQhYjPcFV9xn+i+aRx4pSOHQ246NzxK+7ZyGMmi0PAx44exiXEzByW2KmIyHzEl77+PsQxV6VS08eimfSTtH6CABY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q2YlZfvG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849XAeq007689
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 13:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9Mtw+zFHKgxX84KUgMXqN5jBwQU2U9/gl7V5VWSgAWU=; b=Q2YlZfvG4o9UW02k
	2VII0m74/LXq2+KAz6t97mFJwlCCvWTVWyu2yKNWFrEiniPlrSQS7SWDh/DDl7Tc
	Mvn410RPsrzMgBUjY3DG7QomEUsl8s3V3bpEQxLvcQhm7YiY0mg5OgqyQygwwpNP
	jDyue7AxlEs2eQ6S3lAHmUknWcGJk+w/VRhTUrry+XZsk288P68dgnhQbBR4lpxx
	ZELotPA66tWDVikcgeTAyXvVsgS6ftKwhseBvTaPFqxK3jXX8Yk/ae4VDReawUQu
	fIQGDh4FxfbMSdK8tDMAp6Ohsu0WgHBud/KILIxsv0tR6ONxAjwbhFdHmZioy3tD
	9b0bqw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura8yeq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 13:07:56 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7725b4273acso1820239b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 06:07:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756991275; x=1757596075;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Mtw+zFHKgxX84KUgMXqN5jBwQU2U9/gl7V5VWSgAWU=;
        b=lYoq4KBnx7v1+XE4RcqMj833KLn139cxpJEG7pjJkG5kTeAPIcOB+VoireWCbFN/Hg
         OoVd9HXENoyi5SryYPbdTRwD5CdX0k4qrw+N7IK+F7qxyKjDRmaJhRfHHsbn1Zc3pon+
         pLDkEP6kEpZRlcR3kuStvgpwnW9Y3BZ+YVItwc48banvnhJoDbPZRgO2VI3kBVSHwkIa
         dFRV5bNqNYV0c1T0fL5sxwOJ73BEbqPIatWu68JhDxSk38kRfASLYqPHeGktRn17GvyT
         Y7S2kAJ3VW98XyX/6/Jw0PUuAXrM/eDAJxUDMtavLn7McwC5sqkx8hqQDSogiaUAj/zo
         5ZOg==
X-Forwarded-Encrypted: i=1; AJvYcCWUG/ZfIN+H64QabHZTPd+pdS+dHdeGGs0DZbWAABujfroJXg309U1i3n3Je3e14K8725Q4u1PtjijkYAI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8OdVnotxNS+1NleF7y8AprTYItrT5TboLYimLxXVI1lGEjgyc
	I+wL45EdsRmJ4konnUrLb27wH2gBsxnrbXQOM+P6y1YM3huCyeEiXwibtVrksu04/YfneYiO/YH
	/A1N7/8KGps01Tii0KxgNumnyS6hawYZDU0IOIpeUi5whMnD0X3fC5wngP74oBTWtAN0=
X-Gm-Gg: ASbGncsfxzdIGGMW5xew+BVxaLAxNXSE1SS3qe6ke90xQs2W0JwhqOn6sblu+kpsGS/
	dgqbv0UVWcZmBvccp7Gcyz/9Xf4Xuj3/FID7vt6B4LKGvonv9TuP0BFn39E2EPoIxhzFMND1+ea
	HwldvnB4xMmmJGChOaS8jrU4gWlVMBaGPc6OniW/eQ4ziIGUCGo0RBTTcOCaAj6AXg7P6d6OKe+
	qkH5rQn+wnuemh262HehUm2cddltvfoswoX1Jy6ntSQSSY1rEQxCWSFXLU2rbYy9ORTlS3dUQQp
	OB1v+Jh6PKPrfvDojvqIW477vPRvfcbcaDdwMneVlJSxBmCiFl5zbhg7iY+tJu9T9oM1cFXnhFY
	O
X-Received: by 2002:aa7:8895:0:b0:772:3b9d:70f0 with SMTP id d2e1a72fcca58-7723e21a808mr24935258b3a.2.1756991274705;
        Thu, 04 Sep 2025 06:07:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOsIwWe48mV57+hdURmb7F/1RRflaAlxIyQfsmlF9Uie2Mg78PBmOG7S/u4oBd2+T479KtpA==
X-Received: by 2002:aa7:8895:0:b0:772:3b9d:70f0 with SMTP id d2e1a72fcca58-7723e21a808mr24935209b3a.2.1756991274177;
        Thu, 04 Sep 2025 06:07:54 -0700 (PDT)
Received: from [192.168.215.112] ([106.206.58.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772590e0519sm11838396b3a.84.2025.09.04.06.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 06:07:53 -0700 (PDT)
Message-ID: <099a7c48-c447-40d4-9076-570f5a5058a2@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 18:37:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: Add binding for gunyah watchdog
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck
 <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250903-gunyah_watchdog-v1-0-3ae690530e4b@oss.qualcomm.com>
 <20250903-gunyah_watchdog-v1-1-3ae690530e4b@oss.qualcomm.com>
 <ea295ff6-5395-4470-afc2-76e5e2dc9fb5@kernel.org>
Content-Language: en-US
From: Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>
In-Reply-To: <ea295ff6-5395-4470-afc2-76e5e2dc9fb5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: -xZp7IErrgi0knIvFWepDEEQaJgrMplm
X-Proofpoint-GUID: -xZp7IErrgi0knIvFWepDEEQaJgrMplm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfXxf9Ie03BGnHA
 3ruAxJqKMi04TZ5UIwVeevuzl4cMyny9KtT+4xKuYb44XMPFZvNNaKYXcJWSRvltFUCbu5LKd0H
 660SDAZTYMGxqRl3OP5UhnnczqzPSWMOep9YYoI5AdfagMdTuymgJ4f8Ncz4fSkCX8uz8btmcZH
 mYwSNntF1KPFnTUHv7rIdSzAzMXpzqQVbku6av+UPI2Wcb7BYd0dmVSbYKJ1gjcsBOPsks97xYh
 eqO0Cxy56wuMZabd3aA5MdoP4mANNSP0eFghZQmlX42DbZd9SyDn4HTeiMqKNngdaqgzsLrPXMb
 W96bZK9pa4mqHElN5xyMlv4eBskVE+NS4yqcgF06/sIxvfcWUD6t7+97gyG9gJb+rgMbyzmLPEr
 pw35yohK
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b98f2c cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=0ySTwGsjrHEnVRIoGa4+sA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8
 a=gEfo2CItAAAA:8 a=NEAV23lmAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=7snBibKccnROOREnhvIA:9 a=QEXdDO2ut3YA:10 a=i6qsmYmKKdoA:10
 a=csto0wWSG80A:10 a=zc0IvFSfCIW2DFIPzwfm:22 a=d3PnA9EDa4IxuAV0gXij:22
 a=sptkURWiP4Gy88Gu7hUp:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020


On 9/4/2025 3:22 PM, Krzysztof Kozlowski wrote:
> On 03/09/2025 21:33, Hrishabh Rajput via B4 Relay wrote:
>> From: Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>
>>
>> The Gunyah Hypervisor applies a devicetree overlay providing the
>> pretimeout interrupt for the Gunyah Watchdog that it will be using to
>> notify watchdog's pretimeout event. Add the DT bindings that Gunyah
>> adheres to for the hypervisor and watchdog.
> Wasn't tested, so limited review.
>
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching. For bindings, the preferred subjects are
> explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
>
> A nit, subject: drop second/last, redundant "bindings". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
>
Noted. Will go through the referenced links and update accordingly.
>> Signed-off-by: Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>
>> ---
>>   .../bindings/watchdog/qcom,gh-watchdog.yaml        | 76 ++++++++++++++++++++++
>>   MAINTAINERS                                        |  1 +
>>   2 files changed, 77 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/qcom,gh-watchdog.yaml b/Documentation/devicetree/bindings/watchdog/qcom,gh-watchdog.yaml
>> new file mode 100644
>> index 000000000000..bde8438c6242
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/watchdog/qcom,gh-watchdog.yaml
>> @@ -0,0 +1,76 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/watchdog/qcom,gh-watchdog.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Gunyah Virtual Watchdog
>> +
>> +maintainers:
>> +  - Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>
>> +
>> +description: |+
>> +  The Gunyah Hypervisor provides an SMC-based watchdog interface for its virtual
>> +  machines. The virtual machines use this information to determine the
>> +  pretimeout IRQ which the hypervisor will be using to communicate pretimeout
>> +  event.
>> +  See also: [1]
>> +
>> +  [1]: https://github.com/quic/gunyah-resource-manager/blob/1b23ceb0dfa010b3b6b5a5f7a4ec1e95b93ab99d/src/vm_creation/dto_construct.c#L519
>> +
>> +properties:
>> +  compatible:
>> +    allOf:
>> +      - const: gunyah-hypervisor
>> +      - const: simple-bus
> What? No.
>
> Don't create patches with AI.

This patch was not created with AI. Reference was taken from the patch [1].

That being said, I see your point about the mistakes which were made 
while adding the compatible "simple-bus".
I apologize for the same.

I will make sure `make dt_binding_check` passes with latest versions of 
dtschema and yamllint as pointed out by Rob and as should have been done 
with this patch as well.


[1] 
https://lore.kernel.org/all/20240222-gunyah-v17-2-1e9da6763d38@quicinc.com/


Thanks,

Hrishabh

>> +
>> +  "#address-cells":
>> +    description: Number of cells needed to represent 64-bit capability IDs.
>> +    const: 2
>> +
>> +  "#size-cells":
>> +    description: must be 0, because capability IDs are not memory address
>> +                  ranges and do not have a size.
>> +    const: 0
>> +
>> +patternProperties:
>> +  "^gh-watchdog":
>
> I could not express more: NAK. Does not match any DT style. Please do
> some internal reviews first. This patch does not meet minimum quality
> criteria for public posting.
>
>
> Best regards,
> Krzysztof

