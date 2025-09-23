Return-Path: <linux-kernel+bounces-829572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2797CB975F2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99C647A9A5F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B757730276E;
	Tue, 23 Sep 2025 19:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ixd2zA1N"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EFA2EAB64
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758656218; cv=none; b=dSw6YS3LT9nJp0aGvOXMpUZl4FJVCToJbZbIHeeEXCTxamYYV+eLRJb/BPkHiemWiBnZi46E6rTaBLfBNvrir9Z9g1Qv6phWtVgH2ATGS3ONjyeaQ+quEsGubqPRmtStL0v86/XU3D9Xh0OH1PgMvFSZQ+1xKvIcG8iauXluis0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758656218; c=relaxed/simple;
	bh=1iqe1y2ibI+fHdNR9WdsYwRbrTafRFMRYIggoMNDtII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S8pak+4T76tWAE2lr/qr2W4nZ4Ha5qZhYqu5/CsyqzE0MksrHAM9WBPC6BF/GUebOxYK/HkkDXXrQi/5QXVs6JNpeK3uzpdu1U34E12kPEF4liCYIBWB1VwJgMelKkQcdGAGqPsouNnTxjj3sZO2yd1ntAays+2BKxarqp/xld8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ixd2zA1N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58NEqVix015996
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:36:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aJneKB6KUlYtnPIPcPrOqQOo+8uP80oakK/pn7zFJCw=; b=ixd2zA1NnKzqnOhq
	d2ZzEpMjcuwg+2EHlZrLhD8oW9qTrB7WEKcN6uiBS9yzBJL81zzoF79Z46pj3Yev
	Wfq6KidPBDuUDUgq+1SPcO9qXZdSfyXugG/yGi+SpJTTsXn1hIFKfi71D33lRw3w
	BBzPWnTxHDuGMG0IABoE1Xl8mZkqutkvketAZXxdsFFKNw797+VM2X2k8sOJbRIO
	JYUFDiinEErxwpPb6jqrXV5pOtNxgeDZ1PjifQSObGwhNO6MnJ3ikpAOXd2G+HMG
	hAmFe3klh7x8gTlUlo37/ivHd4RWAMVV5lwoQhGQ+Dt/RP97nqVE3BVI6BeHTd3B
	V/3/RA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bjpdu1py-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:36:56 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b5531279991so5405729a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 12:36:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758656215; x=1759261015;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aJneKB6KUlYtnPIPcPrOqQOo+8uP80oakK/pn7zFJCw=;
        b=hFZlfSNTTqzUy8DaijdPvjqd0cBAeofzBs6x6GpW2L4TauEJWodXVTtWqhykpae0Ou
         QH5ka7eqU5fPsA97iKf2E7kwW8WSv9t7lZ5JR8UIFsXxzCb2iQQJMUP7oNqOaab7yHhJ
         PktuMzwh9/akrnDFw/b1813hZLOv+am1dCEoZt945qOZjPasdUkTpvupUit850UEVd4u
         jF1uMugVvEAf8LUGHWdDJcyHLUYXnUraORhENRSrRl6yBj2lSHE6dVc3sEyoEcrL7A0+
         9sAZ5SBlTYBGYAF0y7eUtRZniutMtOcs2tth0jUjiu3NsEGl0mm/vDvhAmrt+sHbzzjK
         T9CQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/xM6DANc3OMi4aHld8+Fv85L+4mCU59p1SMnE3SUHgqEIRFuUAiDPrfd/txxbGMUa+ZXUyLz9c9z8Y5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5dHKiK1PDisODrOXOlfHJ/gTSP5E2CDxq2PuyfiTJy980KLFO
	0Kxlvx2MHNr1wGxHeNalvPGyAhk8Hq+3m/s3T7VRPzd2mABZBUuwc71/1vvhX+cbZawAvJ9+iyY
	RYxNByWZIBBsi/DkHnUXtdbGTE2VbDqmixukMpuHCIxuxZYErFxCEkahPIjk7JpobA0Q=
X-Gm-Gg: ASbGncv+Ro/O+kCacXi1ZWvmleATESsHCBRAW6JnETKxFdrslavm1YLye1kZO+JAdhX
	UZ9oTOMuyS9QlgoGC5/ifN/Vb1jcxXRrs63TccVDJR4ahqiesKSQzCo5OBUiP6mJdeeokUzzj4F
	XxM72yD8ZGOKX+T1Nh5YtmGQWRe3hMo7dVuE0J1pxIwvkFk/5shCIWF1fL51zds9RzDYuNoiNTs
	olwTAoDM2LbmuMXhG+0FhwxpLC97/UM4Ry7eo27oZGFuaB3HxmQ6RyrFGRzeeaR3vziq7cSfiHl
	V+qPCXZNX3iFb/dbPE3b/uMu2vhTrJyvNaxZYaPTLJKVp8GyyaJT9x2Wz2wrow90TCXLpeyX/yM
	n/AHeNQ==
X-Received: by 2002:a05:6a20:3d1c:b0:2ac:7567:c069 with SMTP id adf61e73a8af0-2cfdac2f25fmr5659664637.17.1758656215459;
        Tue, 23 Sep 2025 12:36:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS/UpqR/9Of4sY1TBzz+iudIRPwp/SAd9XDBUzr/RWXOhBvNioYOHJ1X+iG1pgZNxz8t6Mhg==
X-Received: by 2002:a05:6a20:3d1c:b0:2ac:7567:c069 with SMTP id adf61e73a8af0-2cfdac2f25fmr5659637637.17.1758656215026;
        Tue, 23 Sep 2025 12:36:55 -0700 (PDT)
Received: from [10.73.52.96] (pat_11.qualcomm.com. [192.35.156.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f315254edsm7397688b3a.84.2025.09.23.12.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 12:36:54 -0700 (PDT)
Message-ID: <f1b53a1b-ff29-38a9-db54-8acfd1abac7b@oss.qualcomm.com>
Date: Tue, 23 Sep 2025 12:36:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/9] dt-bindings: phy: qcom,qmp-usb: Add Glymur USB UNI
 PHY compatible
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, kishon@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, robh@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <20250920032108.242643-1-wesley.cheng@oss.qualcomm.com>
 <20250920032108.242643-3-wesley.cheng@oss.qualcomm.com>
 <7gvp6pshp4eiugk3qodg2ub3azu365loturidbkxqly6nhtgq7@bxnkxeqzarkv>
 <4116b593-d36d-df10-6101-4e3539b8b812@oss.qualcomm.com>
 <pvma73qs7msh2qkoaqhfv5v57f3asduuutwf73ceyrxbpsv4sl@fd6fs6yrfjp7>
Content-Language: en-US
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
In-Reply-To: <pvma73qs7msh2qkoaqhfv5v57f3asduuutwf73ceyrxbpsv4sl@fd6fs6yrfjp7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: edNt2mV6l_qkqZunPjDMW2A-LcwlecBY
X-Authority-Analysis: v=2.4 cv=Pc//hjhd c=1 sm=1 tr=0 ts=68d2f6d8 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZdW6uxA9NKXbfdqeeS2OGA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=JfrnYn6hAAAA:8 a=EUspDBNiAAAA:8
 a=ySdWX0gGKps6jh8XKZoA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: edNt2mV6l_qkqZunPjDMW2A-LcwlecBY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAyMCBTYWx0ZWRfXyIgk8bFQzQEY
 rCJmxCXlZfFhzFZh4j8WcIkG2GqGuzDfDoY6+wH/kPJPl188GyDtNVv74jZoQk7iHxEBMmRSrpN
 zFK1bHIjaKFcW0roZ5uILupdUsKCxo6CRSrpLFUhrGhbFo4rsn1AjS305bngjEa1DobeYXeR2kb
 X3dHgIj7dnbZrZgDjjGpweKEHalxjjQAZPTKPwDxPb3zQoLSn5x1D3bJrYjIrZrzuVihdYh7rtp
 uEVpG7m2p86E7ggQKnyqAE+KsZy/sfe+gk6TX5FlauZmQhvTNevAnyXRM/a8udbJdhrOHcMBQtR
 W1yGgQ6ogh0H2zCECXQyb0Ukg2z3MznL8vf+Mix4Pdu8MOYJpu0cHIy+J6VEzljH418VLuJgSO0
 JGXtzXNC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_05,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230020



On 9/22/2025 8:40 PM, Dmitry Baryshkov wrote:
> On Mon, Sep 22, 2025 at 06:00:04PM -0700, Wesley Cheng wrote:
>>
>>
>> On 9/20/2025 8:22 AM, Dmitry Baryshkov wrote:
>>> On Fri, Sep 19, 2025 at 08:21:01PM -0700, Wesley Cheng wrote:
>>>> The Glymur USB subsystem contains a multiport controller, which utilizes
>>>> two QMP UNI PHYs.  Add the proper compatible string for the Glymur SoC.
>>>>
>>>> Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
>>>> ---
>>>>    .../bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml       | 7 ++++++-
>>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
>>>> index a1b55168e050..772a727a5462 100644
>>>> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
>>>> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
>>>> @@ -16,6 +16,7 @@ description:
>>>>    properties:
>>>>      compatible:
>>>>        enum:
>>>> +      - qcom,glymur-qmp-usb3-uni-phy
>>>>          - qcom,ipq5424-qmp-usb3-phy
>>>>          - qcom,ipq6018-qmp-usb3-phy
>>>>          - qcom,ipq8074-qmp-usb3-phy
>>>> @@ -62,6 +63,8 @@ properties:
>>>>      vdda-pll-supply: true
>>>> +  refgen-supply: true
>>>
>>> You've added it, but it's not referenced as required. Why is it so?
>>>
>>
>> Hi Dmitry,
>>
>> The refgen clock isn't always required on each and every platform unlike the
>> .9v and 1.2v rail/supply, which directly power the QMP PHY.  It only really
>> depends on how the refclk/CXO network is built for that particular chipset.
>> The refgen ensures that we're properly voting for the supply that is
>> powering our CXO buffer.
> 
> So, it should be marked as required for those SoCs that use it and set
> to false for the SoCs that don't.
> 

Got it. Will fix.

>>
>>>> +
>>>>      "#clock-cells":
>>>>        const: 0
>>>> @@ -139,6 +142,7 @@ allOf:
>>>>            compatible:
>>>>              contains:
>>>>                enum:
>>>> +              - qcom,glymur-qmp-usb3-uni-phy
>>>>                  - qcom,sdm845-qmp-usb3-uni-phy
>>>>        then:
>>>>          properties:
>>>> @@ -147,7 +151,7 @@ allOf:
>>>>            clock-names:
>>>>              items:
>>>>                - const: aux
>>>> -            - const: cfg_ahb
>>>> +            - enum: [cfg_ahb, clkref]
>>>
>>> Why is it being placed here? Please comment in the commit message.
>>>
>>
>> Main reason if to avoid having to define another IF/THEN block, but I can do
>> that as well if using enum here is not preferred.
> 
> Is it some new clock that hasn't been used on the previous platforms? Is
> it actually supplying the PHY rather than the controller (note the
> CLKREF clocks on SM8550 / SM8650.
> 

On the recent mobile chipsets, we don't utilize the QMP UNI PHY, so 
those would be n/a for this.  I checked x1e80100 and sc8280xp, and there 
might be an error with the x1e80100 MP UNI PHY definition, because I do 
see that there are TCSR clkref control for both MP QMP PHYs, and we 
should be programming those...

In short, yes, this clkref is technically "new" in that it adds the 
references to the TCSR handle that controls the output for the PHY 
reference clock.  With that in mind, I think its better if we add a 
separate IF/THEN block.

I will submit a patch in a separate series to fix the x1e80100's UNI PHY 
definition, once I get a chance to verify it.

Thanks
Wesley Cheng

>>
>> Thanks
>> Wesley Cheng
>>
>>>>                - const: ref
>>>>                - const: com_aux
>>>>                - const: pipe
>>>> @@ -157,6 +161,7 @@ allOf:
>>>>            compatible:
>>>>              contains:
>>>>                enum:
>>>> +              - qcom,glymur-qmp-usb3-uni-phy
>>>>                  - qcom,sa8775p-qmp-usb3-uni-phy
>>>>                  - qcom,sc8180x-qmp-usb3-uni-phy
>>>>                  - qcom,sc8280xp-qmp-usb3-uni-phy
>>>>
>>>> -- 
>>>> linux-phy mailing list
>>>> linux-phy@lists.infradead.org
>>>> https://lists.infradead.org/mailman/listinfo/linux-phy
>>>
>>
>> -- 
>> linux-phy mailing list
>> linux-phy@lists.infradead.org
>> https://lists.infradead.org/mailman/listinfo/linux-phy
> 

