Return-Path: <linux-kernel+bounces-828029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C01B93C4A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D02D1893625
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 01:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDD11DB54C;
	Tue, 23 Sep 2025 01:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lde4wz/T"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828EA15530C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758589212; cv=none; b=GZdcD44HA2rbIEqvaTveflgh8/U83dqdp7notXpeyut3/bv1q175DX53E4P8LcekQbi1+d8erZMXvrM3Ep5Jx8y24GVwbSFzHbRUvDW6CpQIC2dWW7BEkyQVvbgGgg35h6Pn7wJolCJ5wNC42iLkPhMJ+pZOw3FK2IAs8d4ev84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758589212; c=relaxed/simple;
	bh=dlQdFts8UOM21Z7m6BJhEeiMH5cFC4v6+wXAIsrbMlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jsn5SZXb94j2JlBR+Fwi/NtQx+DvS+AAanGk+wIUR1OIdtO6Nlh/SGt1+7Bz98ANoIoLh93OfVIE6ZCks4PROO/VRZkZeVIuo3WZsAZB6YYIt1W+rgIzX5sIGahtSwE0UzSibIbaFSWlQm/qFdmXsDYQEf2ez+u9GD0zZiPdG/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lde4wz/T; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MIPD0c019670
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XWLc1VvNWjlvWYqGGxKBcg7/p+JOxI4yci5dyPnXzGo=; b=Lde4wz/TlbDmZV/d
	RoQtBSG6l4gjxMIm1vx37YEBU/427uzg/x7fhRLL/SN754dd4f8htIAaWo9oILaz
	UmxWRuJEhTqYSh7OPKE90yVEtwHNGGpY/lXrfpcaMJxBwnh9uhb4o533jeLdV41P
	d82uZrrpCnU0n2U55hH/6tnC+MMcToM+WBbv8a3hoGtKy9oRRNOa2Yx3DFheCQHS
	vfJxozcgNJM7okXNx3cMoXEn4sDHxBoPkzWkUlXbDWzk1en4sqcReln4JH0a7dGt
	l8zI6va5suuJfvrymkyz8mDQurLtM3GVLv3vYMNoM7bVaCXf9A5FH4BX3Co5/qVP
	GbxmMw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kv0xnfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:00:08 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-268141f759aso53857885ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 18:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758589207; x=1759194007;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XWLc1VvNWjlvWYqGGxKBcg7/p+JOxI4yci5dyPnXzGo=;
        b=m+ltMl/zgfc77TjaIYyKjQ4mqM4AhlKvwUZ4zkMYe1DoN1iFj4wYPNwnF/0QG6BPvD
         H790gIJ+Kb6l82in+2BQi6c5dMgyd2M/F8zng5JAaA2JPh2QMhcAFH2IbssuzxkAErbb
         ZV0O4hSjm0QCKj01DJLuX55S9odFV4KE84BxBLvfb8iL1emmtwJdmO2k88bufL7CitX+
         OH+aEMzrEj+qhjjzNgsJ/tgJvYx0UI0zUuHaEZxW7KatVcbwBYYEyd3YWpl2twcqNfXj
         g+py0OxTe681PQ4Cux5oS4fzlGHDvCEsnZwNITeHJrgDjN9r0myBorsad/fraAIsWnv+
         gBYg==
X-Forwarded-Encrypted: i=1; AJvYcCVCXBaKLc/2Y3CYxlafMqIQiBPi7uZCFUUDNC3SO+nKZ/cAIgNzTV1D9G48AaMoDbejTEQ7vKvplKrCFOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5TyuYoXcLKATkP4cm/AN5N8A0CQQKgV/0L4z86oJsEUMWRZJv
	t+lNrxxpsbiPX+51uROoL1afcgz8bUG0xsVXWqmJPPS0JR0AjH41tiGa+KBXvAGoweh1KvyziOd
	5VNmXPjdJ0/P5qlcFO4NZMkyHtCQenR4+BwYXc+bYHBP8ehpIioFFq1q9JisMRL4JjhU=
X-Gm-Gg: ASbGnctcj5c1eWj36Thj+0HVcYLQuoHurgI1QSpfHEBJdW05ZS+ZZaVTZtUO8WbaUns
	vxoHpehJZL4bCoziit2VuuMFWx2V8nQZDaM1dy1q7faZYN/YZ3x9kXunAwIr3C4B6ad6aPMpTt3
	PgFYTwJR38Z+xsxtRmU7s1FsbBqfKE4OU9iLQCEsOtB1TXlgl+qlSJcofb+KF7u2yql2ltEjsHA
	jIr+uO+YuSHqAnj5HdOAcFDG6cAL2JqNjfRJo5NwfhF9MtOz3ZKwQyokbRIiWv4Ev47M7ZE2eU8
	kor+57JWn5DN2m+QrEhcsmzP62ZiSUy2c/lcFPtVpXxgWVL50GZCkXsQrb2N0O4ietn9wHSuoSI
	/6axqvfdTP/q62K+zUL1KXjEHIlwBOIE=
X-Received: by 2002:a17:902:ebcd:b0:267:b2fc:8a2 with SMTP id d9443c01a7336-27cc28b71e4mr8498415ad.23.1758589207342;
        Mon, 22 Sep 2025 18:00:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1/GZAeFp7rCGex6eqi3pw2AUQEj40WLJVjcaoY5Pse3ZDm9IPKaBVgK/AuqXdN1xlZJyImw==
X-Received: by 2002:a17:902:ebcd:b0:267:b2fc:8a2 with SMTP id d9443c01a7336-27cc28b71e4mr8498055ad.23.1758589206880;
        Mon, 22 Sep 2025 18:00:06 -0700 (PDT)
Received: from [192.168.1.239] (syn-075-080-180-230.res.spectrum.com. [75.80.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269803661cesm145268935ad.147.2025.09.22.18.00.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 18:00:06 -0700 (PDT)
Message-ID: <4116b593-d36d-df10-6101-4e3539b8b812@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 18:00:04 -0700
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
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, kishon@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, robh@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <20250920032108.242643-1-wesley.cheng@oss.qualcomm.com>
 <20250920032108.242643-3-wesley.cheng@oss.qualcomm.com>
 <7gvp6pshp4eiugk3qodg2ub3azu365loturidbkxqly6nhtgq7@bxnkxeqzarkv>
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
In-Reply-To: <7gvp6pshp4eiugk3qodg2ub3azu365loturidbkxqly6nhtgq7@bxnkxeqzarkv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: -8ksHToRbbLjY89i3y7CgZugLJoFtMJ4
X-Authority-Analysis: v=2.4 cv=RO2zH5i+ c=1 sm=1 tr=0 ts=68d1f118 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=agQD+r7xwyS+FYqxhQjztw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=JfrnYn6hAAAA:8 a=EUspDBNiAAAA:8
 a=RTc6a8mmi5jc5_0K4gkA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfX8XGBlRZR5Bio
 iE9E1UZUgXHlm815Q9o9SwhV2DqlUQRTMcspNTZYCwV0NuR/wA2g/LvrXoHNnZHjSpIIZ+xwh8G
 V5KYNzNKi5ThDxV8Sf74Nh2ENp3aO7zVsdlWAOk+fTGoDpLt6u4y+nGW1SGfcMfl1uAnHL4vuJQ
 axhYXzmck7fZ2Bm1irVEgs2+FNpIBbSXJGXIfyEwqNjROM1wKND4hCX4VCWgHhTlFZvZcVnaR41
 J/sBxGTVKye0ld9kjO3fPgIkvSHg2qRf9Rrfq0fbMAeUyUDortK8J0LGQhZYpd08G8QLG0Pt5iX
 KUPTo/CJeaxSqQEbU8D9FZbZPZsT1Jg9FAu+hGFeR23LO+x6ki4QwDosUsrdB1fUu9p7VetzMaa
 WlTLtHgz
X-Proofpoint-ORIG-GUID: -8ksHToRbbLjY89i3y7CgZugLJoFtMJ4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_05,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200025



On 9/20/2025 8:22 AM, Dmitry Baryshkov wrote:
> On Fri, Sep 19, 2025 at 08:21:01PM -0700, Wesley Cheng wrote:
>> The Glymur USB subsystem contains a multiport controller, which utilizes
>> two QMP UNI PHYs.  Add the proper compatible string for the Glymur SoC.
>>
>> Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
>> ---
>>   .../bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml       | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
>> index a1b55168e050..772a727a5462 100644
>> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
>> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
>> @@ -16,6 +16,7 @@ description:
>>   properties:
>>     compatible:
>>       enum:
>> +      - qcom,glymur-qmp-usb3-uni-phy
>>         - qcom,ipq5424-qmp-usb3-phy
>>         - qcom,ipq6018-qmp-usb3-phy
>>         - qcom,ipq8074-qmp-usb3-phy
>> @@ -62,6 +63,8 @@ properties:
>>   
>>     vdda-pll-supply: true
>>   
>> +  refgen-supply: true
> 
> You've added it, but it's not referenced as required. Why is it so?
> 

Hi Dmitry,

The refgen clock isn't always required on each and every platform unlike 
the .9v and 1.2v rail/supply, which directly power the QMP PHY.  It only 
really depends on how the refclk/CXO network is built for that 
particular chipset.  The refgen ensures that we're properly voting for 
the supply that is powering our CXO buffer.

>> +
>>     "#clock-cells":
>>       const: 0
>>   
>> @@ -139,6 +142,7 @@ allOf:
>>           compatible:
>>             contains:
>>               enum:
>> +              - qcom,glymur-qmp-usb3-uni-phy
>>                 - qcom,sdm845-qmp-usb3-uni-phy
>>       then:
>>         properties:
>> @@ -147,7 +151,7 @@ allOf:
>>           clock-names:
>>             items:
>>               - const: aux
>> -            - const: cfg_ahb
>> +            - enum: [cfg_ahb, clkref]
> 
> Why is it being placed here? Please comment in the commit message.
> 

Main reason if to avoid having to define another IF/THEN block, but I 
can do that as well if using enum here is not preferred.

Thanks
Wesley Cheng

>>               - const: ref
>>               - const: com_aux
>>               - const: pipe
>> @@ -157,6 +161,7 @@ allOf:
>>           compatible:
>>             contains:
>>               enum:
>> +              - qcom,glymur-qmp-usb3-uni-phy
>>                 - qcom,sa8775p-qmp-usb3-uni-phy
>>                 - qcom,sc8180x-qmp-usb3-uni-phy
>>                 - qcom,sc8280xp-qmp-usb3-uni-phy
>>
>> -- 
>> linux-phy mailing list
>> linux-phy@lists.infradead.org
>> https://lists.infradead.org/mailman/listinfo/linux-phy
> 

