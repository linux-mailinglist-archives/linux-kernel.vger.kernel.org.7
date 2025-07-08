Return-Path: <linux-kernel+bounces-721360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A338AFC823
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D38B21BC086F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D53269B08;
	Tue,  8 Jul 2025 10:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M9bFl1od"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68CB20C000
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 10:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751969964; cv=none; b=gZrRaLa6h+FJ15LG0/rLXyboKSkb9ey+uJGsMBlv+riC/1WmHRtPFN/j8g3RPzhoq1WJ3PYENR5P8+xIIr+IRINr5l3XZypbdNHJuyQ2ppyL3xX25L68Y1m35m+h94RDXwYN5nije7BqHGKd6se9l7Z0sLXBlqr9pd0ihmYvVvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751969964; c=relaxed/simple;
	bh=4qyGCqoOctCX+ogPWnWHpeEY30lAlTFutKfubN8uP0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y0RAc5SDzkCfQy8soKIgsMqxDOVg0llvxGBJLZIx4fLx5v7k2iGu/uOaE02ud+HjOgMRXTmEIzm89j686ZfTrXaZhRy7KypZqdlP9e03pt9lxcuXS1nT4zsoJEPYebMqGntsS0es2vXsGM9LuqWCoesRSY8MOl3LXtvs0wHtFYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M9bFl1od; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AATIM025497
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 10:19:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X8J5lvtE8rEXlZWpUd+/01lG085Osm/mImlq/Wf/j3c=; b=M9bFl1od0O73Mvar
	CVi1LSPqm3OaCNwM3NxMXQ8FA/pk9mpc9iMo1NZD7UUseSXR7pVyYyckfDVxbogE
	M3AWS5sujse7GEGQi8jH2ljNs1vQGlVx9Vfgmx+s9A4e+P4ffJ4n872473Bsj6zR
	M2NrH/lfRA/LjuG7+FWHlZbc/xP1rwjC8sVFbPIlMbtbaRhb9TcndSfgJybSt8da
	hEsLI66J6NWKjfitnGj29IkfhZ6x2Xc8a4gchC1pD+lSY8mt377wXFWSO9JuJrxO
	UslajnYy/6QG6s91dLJKMBv7MBwjph1yTmwl/8WEazYY1tgBmUkajpihdv/LUu0P
	IgBZ0w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pu0wc4g9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 10:19:22 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-235089528a0so41487245ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 03:19:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751969961; x=1752574761;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X8J5lvtE8rEXlZWpUd+/01lG085Osm/mImlq/Wf/j3c=;
        b=eyYmMmkQzwc9+VvhkONsj4VV+M2Ej9BgOwZZ98kazx+1u7xeNFtl4n5tLhc27U6QgB
         fGp8sHHjgrN8VnIad0/byDpTSUMhPdFIUrJfw2N/CIf9rWGIL0KfFvb3HWBjjb/N8/u9
         0P41ZvQA6t2QIJrDe0/GWnHzhvVEAiKR6BVoezRa1NYoh4J+yHbu8eOdkZOPtgl9EGHE
         /HgoKzGnP01g67z7/AfYzBx15E3qbLryhVwIBSwbCnMg/bsoNX7Sh1ii1rA9fQoDA0+e
         +DMLIq8oW9BNaCS9EbawzyIu4lLIJ0ll4ES+sel8+gaIW6eG6mvmbQtYtgpbB6C6yDQe
         26UA==
X-Forwarded-Encrypted: i=1; AJvYcCXhd2Oeob/kSA7M+n5DVwyoV21EwFjwtkFI5NA+bUYWlYOozZwvl+BozcjMtU1G2pm8x8RKI4RCNF21SSc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9i8od7MdNjRtm9MrevowykaokSshxgRlPAv0lh7J4L4ue0x7b
	dAKvgCBTX+ZilyPwk/pwu/HbET3N0JhbDb0Y5EjbMqjcL0HdU/DKu1btke7BSDMYVL/kLFih9Sd
	sqlwTcXFrRz1S9Aj8wAmP4spFgEy9O/r4mENWiUpBjq/w70UAgCSbOKJFBh+1Lgs5g60=
X-Gm-Gg: ASbGncsas2bL4wZqbpEAteFC/yOzuo2jZwowUZm5O98pMnte39MmB9+9jksm71J/bkQ
	tyYWpJoqipOj2sgLD3Rclh4oHSxVvmqIwkHTLIFBQXmrWwDsy2vouT/M13/0+TwuGBgK6/OWceZ
	HJgkqv+wnjBZvejV5uAuOOWU5m/nqHdTe2eVl+nMEnlrw2pS19oYthc7Si1gOT0CeshEK0SW+Kj
	jz+vkMKnIJog+8ay/ksJBNA+nriYSX9EXowSqrK3vdBoU4gqCxo8bajrSPZfj1u8kMKLZFBZeqN
	U58ZUCqv0Zy9RDTBo66Vecb4/QbsdO6P1nmfwsBQ+Eq6QXUXsW9OBvu+exAgUEI=
X-Received: by 2002:a17:903:1210:b0:234:595d:a58e with SMTP id d9443c01a7336-23dd1b589a1mr35282125ad.25.1751969960545;
        Tue, 08 Jul 2025 03:19:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2oy1IXFK4dnroISXWo5wvI3d7wBIDcdWSD2jINsA5MIuiH/xfR8VKPwrv2hUqbyGnVX8j/A==
X-Received: by 2002:a17:903:1210:b0:234:595d:a58e with SMTP id d9443c01a7336-23dd1b589a1mr35281825ad.25.1751969960142;
        Tue, 08 Jul 2025 03:19:20 -0700 (PDT)
Received: from [10.151.37.217] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455d259sm115856215ad.116.2025.07.08.03.19.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 03:19:19 -0700 (PDT)
Message-ID: <c22172c5-7794-4f88-931a-c578c906d91c@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 15:49:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] arm64: dts: qcom: ipq8074: Add the IMEM node
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250708-imem-v2-0-692eb92b228e@oss.qualcomm.com>
 <20250708-imem-v2-2-692eb92b228e@oss.qualcomm.com>
 <e7ad63b7-523d-4193-97b8-d33601de78f6@kernel.org>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <e7ad63b7-523d-4193-97b8-d33601de78f6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 6Tc7odKpHE6XNP-Rkr9kMRuQiLcA6vgp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDA4NCBTYWx0ZWRfX1vRg3Z7JYpAG
 LpITnto/eXTuXg5LYzMyX5LiJTH91bLzieEhYYYJoaXnQPj8CGvUrkwu4gEf+G2igmvCVOG/9vk
 BeIQ6zLCodw2MVSdHQbkdABd0y21ohHZPvY4yXxD5EogSQtQwxW8oC/RHUl+QJ1uSezeesY3eLH
 7IC77XdYwFp3pzcrqFqPAkXilL9JPbbEuBoHE/NW74FMEv3K0YAZwGvIfLVzwpP5nQWmUZU1WXm
 vj5P+IlKLQQRnFXQ2B67YNWbVPh4t3j8q79Lr5R0cuDye29SjfajGaDNB2FeCKIjOnLcMHFna20
 8fOmnb5Qw/YdjGvuuHrGPSr2YBiBjt6CVmblncmrZ4SmCGYHEUIiMg4wQegtfGXepB51YkQJd14
 L+rfZ2FeN6MXE8DznnUvZgTroHLlF/3opW73M6kuk6Pi9ApzFtaAdSYPasMelJ6jHV0rEGq7
X-Authority-Analysis: v=2.4 cv=Rd2QC0tv c=1 sm=1 tr=0 ts=686cf0aa cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=6ADn6bbprC_h0No-RiwA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: 6Tc7odKpHE6XNP-Rkr9kMRuQiLcA6vgp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=727 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080084


On 7/8/2025 12:17 PM, Krzysztof Kozlowski wrote:
> On 08/07/2025 07:39, Kathiravan Thirumoorthy wrote:
>> Add the IMEM node to the device tree to extract debugging information
>> like system restart reason, which is populated via IMEM. Define the
>> IMEM region to enable this functionality.
>>
>> As described, overall IMEM region is 24KB but only initial 4KB is
>> accessible by all masters in the SoC.
>>
>> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - Rounded off the size to 0x6000 (Konrad)
>> ---
>>   arch/arm64/boot/dts/qcom/ipq8074.dtsi | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
>> index fffb47ec244899cf45984adbe8c4f9820bef5c5f..2ba07a02c222958b924c5bc178ac67f955088f7a 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
>> @@ -625,6 +625,15 @@ qpic_nand: nand-controller@79b0000 {
>>   			status = "disabled";
>>   		};
>>   
>> +		sram@8600000 {
>> +			compatible = "qcom,ipq8074-imem", "syscon", "simple-mfd";
>
> It is still not simple-mfd. You should post complete node with children
> or do not make it a simple-mfd.


Sure. Based on the outcome of the series[1], will update it.

[1] 
https://lore.kernel.org/linux-arm-msm/073480a2-0b6f-4dc0-b7eb-eec500b3106e@oss.qualcomm.com/


>
> Best regards,
> Krzysztof

