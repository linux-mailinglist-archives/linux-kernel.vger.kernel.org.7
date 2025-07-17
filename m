Return-Path: <linux-kernel+bounces-734529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAB3B082CB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 04:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D77EE7B25C0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 02:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6351DFDA1;
	Thu, 17 Jul 2025 02:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BzlEQ4E/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6781DACA1
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 02:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752718471; cv=none; b=FSWh9P5Wae3O/D/o5ySxs5Z9OHt/7JKe0IWnp7IQd+fj6WfmhMQEbtW1I/DRpZKhT5uP4mtTeR0+AJqWr2dJsmGAYNA0SE9m+NBKswdvVwuC8Qaip4/XELRG5PNDMNNKb7IvYrc6IeSwoRX/rk8OBy9DWN5WvOkBq71852keVk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752718471; c=relaxed/simple;
	bh=Ocf7rDEVq/yfElBauBHcGF2Xn4oeGqrWWXKA3Ya4w88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dYOQvB4Gl0LcCxW0J1JurCF4Ig6VV+S4+5+00xO3HnUDS/0icicl8Den6w1vvTDkcPru9Cqe9M6Iu44RVJPbGllUdvYJ/YMH6uexN6oYpOujI9X3UzZgJ+ieujS28kFA6VPapWwakOsGI5JP0uyNYGJ9YZKtRX84aeStmrwPsV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BzlEQ4E/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GGDWDD007301
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 02:14:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DTC0WRX4p9Xlvnf+T/Nq7VBMyv7m6ojUA5HCSntnl+g=; b=BzlEQ4E/sVojPRjG
	tn7FhnQ150jJYWfSIObH3trPsWcVJfaZRfEM+hu7takN7pHDO9ImELomAtdNQiBZ
	D1FheRegFz2/wet9oqnpy3EA6LvuIRAEvt1xmRt0kgLeWbRlK4yKHTGZkkS7zPEA
	a9wKeXyjfjJndJNtQ5RWbpbT0RKrU1jsj2COxdqNg+CRetxt9tCOstfrP5Hd/51E
	9fY/YhaLKyow72R5OMOh7POJ4yDF0wATDb+/rOJELOtkhOT1aRQG0GyzRwg+PzDO
	cHMbXmsazoLybXtn3Qoge2ax9V9xZ+Y2/FkUi+SdLalwxeXITSwaAc2IwFd/Iw0J
	Xvs21A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wfca7647-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 02:14:28 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-23632fd6248so3840195ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 19:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752718467; x=1753323267;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DTC0WRX4p9Xlvnf+T/Nq7VBMyv7m6ojUA5HCSntnl+g=;
        b=mMp2H5+PesKSD0nHdmW4orgKAOLW3htH9LC33DILoqI+aNUDtQvBQOhvodhtsiUDjV
         kuWp00yqXYdQ3CnUCnvGQHTpti4KafetWk4Z0QLOh9n9lVczc8S3FP4smhsQuNJ7IQKO
         /MJpWShJabzqc8UaGesj6WiHQzrjMdgrp11Q+bGvKn8kteJSxkqq/afIZx6ap5RTFx9w
         RkfcrQYLfC3j0DBTPvL9yEJI66PFYlp9O+93hyxNkzKM3fulp3zE2uihAMBZwXJxibEy
         v6ZaJo5sogZIQ0nqhULtvdK2L2ETx30QsbHQ/lLunbTfTIPN+HcOso7Ql4bde9Pa52/+
         W7iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoM7JCnqkw9Ux2sTijECBSmJaEada3LBIX8T6yo80o84Rthyfac2zsRTFxUggkifa+1hKlS2ot7J+2DYE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Q9XJkQa2YC0Hfj1ZOu5e6pLlzqHSTbQbXas8LRuJ35FY+gsm
	rCIZYxOB9QKOXDLrlSGBAIljjELcFhatlY2udwf/8FqStUUWjVRE5FYSTIDnelfqypjbN5jnC3t
	x0DZfFiDo1nKSTKbwKu5zEGfdDWeSDgN6Mekb5EDMq3HgqZmvDnEBo9BxIwFIpqSOees=
X-Gm-Gg: ASbGnct9vD5Wx0YjisJKMkJKPDgQnsXV1BAlOBrL6UcpvKI232BEriHuAzhRWlaOc7h
	fTeiu7uYfzWY8xAzH7rJmSLq8CVy/ugpNOLOkhzcVvmHTLPlpCeZ2hQpmmuOZeHr+4ba4J5N/ya
	H+pMlhEIJjrcTpKbQGN+5DaJ0JB94BSIr6EvZMOH7cU0DhsTfm//RVJ8KUvHneS6kI5QktgPNwU
	zFrP3Y3bAmqPE0eD/Vovj10AyPT3ieTjoE8fAgj5Trb0c9zPp4IHIcWwoMHVq+AK+DIyvnEUR6E
	7WbuUmG1e1/byD0r1NqYZip9PUi6UKFC7YPLUbebEOyHUfjkDJuTs3t5vU80dk5UWxiwNDOY2VC
	LHCmuNZkqNdl4kvA01WZ3M8HOaXQ9
X-Received: by 2002:a17:903:80e:b0:23e:3164:2bf1 with SMTP id d9443c01a7336-23e31642e68mr7927095ad.53.1752718467250;
        Wed, 16 Jul 2025 19:14:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGn4xLdliAVfCrSfN9/WNrtrgGxPkMsfecnWK61oAUnA5ybvMwzlXtm6829MrraE7ebG577YQ==
X-Received: by 2002:a17:903:80e:b0:23e:3164:2bf1 with SMTP id d9443c01a7336-23e31642e68mr7926835ad.53.1752718466838;
        Wed, 16 Jul 2025 19:14:26 -0700 (PDT)
Received: from [10.133.33.249] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42864b9sm132765355ad.30.2025.07.16.19.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 19:14:26 -0700 (PDT)
Message-ID: <bffff2bc-6f42-49f4-9147-a4d706929e93@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 10:14:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: arm: qcom: Document HAMOA-IOT-EVK board
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250716-hamoa_initial-v1-0-f6f5d0f9a163@oss.qualcomm.com>
 <20250716-hamoa_initial-v1-1-f6f5d0f9a163@oss.qualcomm.com>
 <604a5823-c563-4d37-ab14-e3164f3b1cd8@kernel.org>
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <604a5823-c563-4d37-ab14-e3164f3b1cd8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDAxOCBTYWx0ZWRfX6dXJGDezCzOX
 Z2chybV/ORVV3ZZS1QlbBtWy7KNfbOF4MgLsfG0br/VMOsQLq9bOSPQgN2oMK7DAEIlLE6P1SMP
 stVPZsynCzxJ0ZK92g6mDYyN79+3QmCb7EAh598Q/U2wZZ7S6zTRIH76vy3K5ioRWcZyrRaHf4x
 w7dRJDY+p+u725XSlRImhvBOWQnS2TEV5ISg5fTyeOKSnNfX+feMV0NkgrQG4YToYP2ePQCCzFL
 hifJUOYy4RHj8b5RRpDKT+H/LIYe1G52lS+/8efXjmZU1eWd18VrshdF9zlRUqw7P36QrA/fUxO
 4zAiWSiHb+Q+KgNchnq/bJQsWDyQzw/hjOQ2N14DxG3wRGzLUyoQEr2EBmxCxTKUF0QakXqPGui
 pAnNVt6bWcMtSJojLWl2MAeNoN5bYozc/YNfYlOiS15MzKYPf36tMLmcw8f9gq7jBn6nsCLa
X-Proofpoint-GUID: S8hDLi6wX1bF2DL7MEKOtp3QfbiJY9yC
X-Authority-Analysis: v=2.4 cv=SeX3duRu c=1 sm=1 tr=0 ts=68785c84 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=VgApEbnXb6FI9c-La98A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: S8hDLi6wX1bF2DL7MEKOtp3QfbiJY9yC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170018



On 2025-07-16 17:30, Krzysztof Kozlowski wrote:
> On 16/07/2025 11:08, Yijie Yang wrote:
>> Document the device tree binding for a new board named "EVK" based on
>> the Qualcomm Hamoa-IoT platform.
>>
>> The "hamoa" name refers to a family of SoCs that share the same silicon
>> die but are offered in multiple speed bins. The specific SoC used in
>> this board is the x1e80100, which represents one such bin within the
>> Hamoa family.
>>
>> Although "qcom,hamoa-iot-evk" is introduced as the board-specific
>> compatible, the fallback compatible remains "qcom,x1e80100" to preserve
>> compatibility with existing in-kernel drivers and software that already
>> depend on this identifier.
>>
>> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
>> ---
>>   Documentation/devicetree/bindings/arm/qcom.yaml | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>> index ae43b35565808ed27cd8354b9a342545c4a98ed6..83b09ec1100ca03044c832212a99e65cc1177985 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>> @@ -100,8 +100,8 @@ description: |
>>           sm8550
>>           sm8650
>>           sm8750
>> -        x1e78100
>> -        x1e80100
>> +        x1e78100 # hamoa
>> +        x1e80100 # hamoa
> 
> 
> Huh? Why, no drop.

Okay, I’ll leave it as is.

> 
> 
>>           x1p42100
>>   
>>     There are many devices in the list below that run the standard ChromeOS
>> @@ -1162,6 +1162,11 @@ properties:
>>                 - qcom,x1p42100-crd
>>             - const: qcom,x1p42100
>>   
>> +      - items:
>> +          - enum:
>> +              - qcom,hamoa-iot-evk
> 
> Don't duplicate entries. Look how this file is organized.

Sure, I will merge.

> 
> 
> Best regards,
> Krzysztof

-- 
Best Regards,
Yijie


