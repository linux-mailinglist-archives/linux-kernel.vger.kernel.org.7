Return-Path: <linux-kernel+bounces-827853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E769CB9346D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEA721906AC3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 20:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6345D2BEC20;
	Mon, 22 Sep 2025 20:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SEhbu2QF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F8C2765F8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 20:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758574386; cv=none; b=okFEinQvgoZy6J6zdSRSN+Ntny70d0tN/yJOUOIrVE5TZoVLw/AQtLoavLagrH0/5b8RykBELuxav6sso8j2Zoc9S2zb0ON2bUN5mAj4kzup70kGD3oulS6Z4O/BXfQihyvlcEA3LB2ALAwu0wJTxTIHEikIn3lEttQ72nAKpiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758574386; c=relaxed/simple;
	bh=wJKOVxTWl3mVaWN7uXpUfUAhskBfIXlt5pRVs9BcJVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r1p9Zux3aw24SHpk0j+UZY3fds+8vVn3yGQOtNGze3f48vJEMhKlSF7Q7d+VmNwrJYTFL5JYkGIa8/af346CHhHE6IWJcIp7931ZioeDGLw1jjnARO7s2ducM9DAjZSfThoUWGQddKfRd0ew3fubTcJ8vhGXNtxiDvY+lQlImnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SEhbu2QF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MHcwXl005834
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 20:53:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w9Wu9mtQgEpP2zjRZmcsIaHLYNEVblC9DYlSfNlL2BY=; b=SEhbu2QF5h7XomJp
	Vj1CGhEN9jpJfKWjsFGKoxC2XGuNzsxqyQR1EQlCU1FtmoCbrCnYtukQ1tmxqHfh
	kNGii2eEpwlFZgIwtwqSnKpfxUtam162ni19KUpK/0YNUG+/MmpI5pvrzSdkYX83
	T0Kkczmxihstc0P5l05b8ENE/RG/YO+4TVZjJWk7BLxhJ16r/L813d/dxqSixjVI
	NAssD0i3oL30XMleY9IRtugLXGYLUqAaR2zRYY7cSTQ3Z3xztY3N1e8qBV+W6/Ef
	dMe5Buu5tjK4GwMXuxCmq7Yn29cWKSHGcNZ+qe6ICjlW3v3yjonqtGzVJw+RXB4+
	n0YVdw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kv0x58p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 20:53:03 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32ea7fcddd8so9297118a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758574382; x=1759179182;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w9Wu9mtQgEpP2zjRZmcsIaHLYNEVblC9DYlSfNlL2BY=;
        b=wNhLlwwtO7iRgYqIn3VGtRvV1Z/4X06v2QI8l5YpWb6ps/Fc+aX6R4eXm3GHG/WgKg
         w5MS+f2VqPfG8+Y725f0bgESG1WiFe5JyJQpAHgfg+Fal6Jpj1capuiOcozOz+ipZhPF
         M5m1KmNXgI/59uZLdXKn4G0+3UOu0ox1NeptyO7NUPNnYso3Oaqa5ARUCbtp/ADWXKSj
         1VAK2GdoGaMzCmhOR2CAkw5jFVH2DDT4tKbyFqplFv/L1WKuoiXdWeXDwaA1KR/OJCQY
         6zTnyUBO2Jmtz/ntjxK9XdjhHRogLihNK4bRyI08BprMuQ7RneL72gmOTNuluh5JQWC8
         Lrew==
X-Forwarded-Encrypted: i=1; AJvYcCU0TVb6sTybTBtNreS+cz3sJ5eGug5tdD6KRzaKYwTy8+FCIY09PmmibvsviEABLWDUcxuoastcvpFNlf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQWfEnPcHgCzHbwPgcIczpql0BjG7JU+uBoK+2vfrCvWgv3m0a
	Fhscg6hwvjjcbJVCznLYIW/maBDlFfSa91te/lzSEg6ca9HoRp1W9SuTeflQvIyNFrum+i/dJAs
	kNSMzwSrs637Evyt263F84Cw+j4t9VLpZiuw/K6YifI9xIGvqpKuWo0OsptLiMcKdBAc=
X-Gm-Gg: ASbGnctv8L7yRUHCbyfRfNt73GsPK/OcpCfIEOY2Fzvvn+hYyjYfdN9LE7Fg5ETyUb9
	v2YWEJuHHciczevTNSREd4OguWMUzGbVE8VPqwWb+S8AxahDxnzDYdsxPcpaJcgXp/uJEUR9PxO
	T9QkOlhQhhDHhsNJYJbKGSHLmTQBgA6A9C/kFsfE/MTP1RKq49HhxHaAKEildoMUfnf3NVPOetc
	tablPfDGscoYjhADXIDTM3/1i6TFXeyJk1vL0InmSH7c2prythIHHIqJ8cKJPMnUKcQ68W7iMN5
	gggYdVOD2qzlMeKqvJdUS2h8+45cRleRc/JEgLwVvIkuch+XrWpYqDrGDlnCP4qTHy4JCnaaMBG
	9mARFaTs/ORtk3MZBKWVoN3pLXPfHGrk=
X-Received: by 2002:a17:90b:1847:b0:329:ca48:7090 with SMTP id 98e67ed59e1d1-332a9a03323mr314252a91.37.1758574382407;
        Mon, 22 Sep 2025 13:53:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmGBgoTPZCCqPtAA5u6G0ADv+sA5Otpw3FKsEi++cUEokO+1hOzsSKXTEDIDmo6qjE4PrGIQ==
X-Received: by 2002:a17:90b:1847:b0:329:ca48:7090 with SMTP id 98e67ed59e1d1-332a9a03323mr314228a91.37.1758574381933;
        Mon, 22 Sep 2025 13:53:01 -0700 (PDT)
Received: from [192.168.1.239] (syn-075-080-180-230.res.spectrum.com. [75.80.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33046a4d0basm16048941a91.27.2025.09.22.13.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 13:53:01 -0700 (PDT)
Message-ID: <588fd98b-ed22-2940-a749-d4601f77b0b1@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 13:52:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/9] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy: Add
 Glymur compatible
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, kishon@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, robh@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <20250920032108.242643-1-wesley.cheng@oss.qualcomm.com>
 <20250920032108.242643-2-wesley.cheng@oss.qualcomm.com>
 <nkkimxkdp3q3iiyv4ic6rxnwwedq5tnnn2zismqf4pdocvmono@xltxaqz6rb5q>
Content-Language: en-US
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
In-Reply-To: <nkkimxkdp3q3iiyv4ic6rxnwwedq5tnnn2zismqf4pdocvmono@xltxaqz6rb5q>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Fzp3mB2xfW-yXzFKXtQ-mPi_aY4cC4LL
X-Authority-Analysis: v=2.4 cv=RO2zH5i+ c=1 sm=1 tr=0 ts=68d1b72f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=agQD+r7xwyS+FYqxhQjztw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=JfrnYn6hAAAA:8 a=EUspDBNiAAAA:8
 a=Sr9xLzlp0V7X-QRcIyAA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfX1cRUM5jI+e72
 ENpkfGT/C7f0TsY0YNkfUsDbFhTL59nwUbTBDlQ5YYQ2RcV6yQqRqWsJQaNEFrtNZ/jt3+ZlPn5
 8m78Cgnrg4C93pC/61AegZNROC7H/K7uy5O9xj/208HNuFeP1XOGY5v0jMTR8wsoR4+afRGVqFT
 /hjkwJuBSn9BzislbaYGr2PLDcE9u9x7amf6pHvDaCaiBLHmosk5bKIvZYwFHg339nDzi/Vv3rr
 6Tg3gvZI3fZHcxYGC3dJW5qsdTZNCW+hM4180PLXbT2H3zAdIk16kdKLUQEJzccZZbNZYN0ImVD
 flALFFOkjjNSDt+xsIk+iXy9fAuUpqqmDSKbitLsY0VeHdVH0pnuCShI+eVUz9esMiN79Hq48qL
 4B2ud87/
X-Proofpoint-ORIG-GUID: Fzp3mB2xfW-yXzFKXtQ-mPi_aY4cC4LL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_04,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200025



On 9/20/2025 8:18 AM, Dmitry Baryshkov wrote:
> On Fri, Sep 19, 2025 at 08:21:00PM -0700, Wesley Cheng wrote:
>> Define a Glymur compatible string for the QMP PHY combo driver, along with
>> resource requirements.  Add a different identifier for the primary QMP PHY
>> instance as it does not require a clkref entry.
> 
> Are register programming the same for both of them or not? If it's the
> same, it might be not necessary to have different compatibles.
> 

Hi Dmitry,

Yes, the register programming sequences are the same, but the number of 
clocks are different between the primary and the other controllers. 
Specifically, on the primary USB controller, we don't have a clkref in 
the TCSR.  Was just adding a separate compatible ID to define the max 
clock items.  However, I do see that even if I only need 4 clks (for the 
primary) it technically doesn't break the DT bindings definition, as 
minItems = 4 and maxItems = 5 for the clock and clock-names fields.

I'll just go back to one compat for the primary and other controllers.

Thanks
Wesley Cheng

>>
>> Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
>> ---
>>   .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml    | 45 ++++++++++++-------
>>   1 file changed, 28 insertions(+), 17 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
>> index 38ce04c35d94..e0b10725a1c5 100644
>> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
>> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
>> @@ -15,22 +15,28 @@ description:
>>   
>>   properties:
>>     compatible:
>> -    enum:
>> -      - qcom,sar2130p-qmp-usb3-dp-phy
>> -      - qcom,sc7180-qmp-usb3-dp-phy
>> -      - qcom,sc7280-qmp-usb3-dp-phy
>> -      - qcom,sc8180x-qmp-usb3-dp-phy
>> -      - qcom,sc8280xp-qmp-usb43dp-phy
>> -      - qcom,sdm845-qmp-usb3-dp-phy
>> -      - qcom,sm6350-qmp-usb3-dp-phy
>> -      - qcom,sm8150-qmp-usb3-dp-phy
>> -      - qcom,sm8250-qmp-usb3-dp-phy
>> -      - qcom,sm8350-qmp-usb3-dp-phy
>> -      - qcom,sm8450-qmp-usb3-dp-phy
>> -      - qcom,sm8550-qmp-usb3-dp-phy
>> -      - qcom,sm8650-qmp-usb3-dp-phy
>> -      - qcom,sm8750-qmp-usb3-dp-phy
>> -      - qcom,x1e80100-qmp-usb3-dp-phy
>> +    oneOf:
>> +      - items:
>> +          - enum:
>> +              - qcom,glymur-qmp-usb3-prim-dp-phy
>> +          - const: qcom,glymur-qmp-usb3-dp-phy
>> +      - enum:
>> +          - qcom,glymur-qmp-usb3-dp-phy
>> +          - qcom,sar2130p-qmp-usb3-dp-phy
>> +          - qcom,sc7180-qmp-usb3-dp-phy
>> +          - qcom,sc7280-qmp-usb3-dp-phy
>> +          - qcom,sc8180x-qmp-usb3-dp-phy
>> +          - qcom,sc8280xp-qmp-usb43dp-phy
>> +          - qcom,sdm845-qmp-usb3-dp-phy
>> +          - qcom,sm6350-qmp-usb3-dp-phy
>> +          - qcom,sm8150-qmp-usb3-dp-phy
>> +          - qcom,sm8250-qmp-usb3-dp-phy
>> +          - qcom,sm8350-qmp-usb3-dp-phy
>> +          - qcom,sm8450-qmp-usb3-dp-phy
>> +          - qcom,sm8550-qmp-usb3-dp-phy
>> +          - qcom,sm8650-qmp-usb3-dp-phy
>> +          - qcom,sm8750-qmp-usb3-dp-phy
>> +          - qcom,x1e80100-qmp-usb3-dp-phy
>>   
>>     reg:
>>       maxItems: 1
>> @@ -46,7 +52,7 @@ properties:
>>         - const: ref
>>         - const: com_aux
>>         - const: usb3_pipe
>> -      - const: cfg_ahb
>> +      - enum: [cfg_ahb, clkref]
>>   
>>     power-domains:
>>       maxItems: 1
>> @@ -63,6 +69,8 @@ properties:
>>   
>>     vdda-pll-supply: true
>>   
>> +  refgen-supply: true
>> +
>>     "#clock-cells":
>>       const: 1
>>       description:
>> @@ -110,6 +118,7 @@ allOf:
>>         properties:
>>           compatible:
>>             enum:
>> +            - qcom,glymur-qmp-usb3-dp-phy
>>               - qcom,sc7180-qmp-usb3-dp-phy
>>               - qcom,sdm845-qmp-usb3-dp-phy
>>       then:
>> @@ -129,6 +138,8 @@ allOf:
>>         properties:
>>           compatible:
>>             enum:
>> +            - qcom,glymur-qmp-usb3-dp-phy
>> +            - qcom,glymur-qmp-usb3-prim-dp-phy
>>               - qcom,sar2130p-qmp-usb3-dp-phy
>>               - qcom,sc8280xp-qmp-usb43dp-phy
>>               - qcom,sm6350-qmp-usb3-dp-phy
>>
>> -- 
>> linux-phy mailing list
>> linux-phy@lists.infradead.org
>> https://lists.infradead.org/mailman/listinfo/linux-phy
> 

