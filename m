Return-Path: <linux-kernel+bounces-871398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC15C0D227
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D7FC3B89E2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C532F7AC7;
	Mon, 27 Oct 2025 11:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eDfdDeu2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF61220694
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761564086; cv=none; b=OfNqYJIfopoA+1Q8AsTdXKv4SOeNkyiIqhLrWXZjreZM5FOECjaWpeELtiL3Ebf5Z+bOBvCYJzNl9KIchhofeGgp4+KA/Hc1eeaE2U63zg7Jm2K2NMjoECeeWn+JWjd87xIbkssJFxs+5wUIHljurtvUoNy7/SFYzNqANeBk9Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761564086; c=relaxed/simple;
	bh=JlLCjaPPh0XvqCGOxp2vOnr+N9mFDWWjCBAvtWR26GI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C2xo/IRbYTr/Hj5WahVPdox/Mz4VPjAqfKjZ5Fdr2GLtmIBNhzUuOnJkKAHjWujizroxf18lsTaHz05hcmIo7CYDToQ6oS83J2QIm1rfw6dR/Y4fjDmgX8Pb65JF6vCFKz1tBhC17SXhe7EIhEIUEZ6HBcsX0cdhvO/JL+WtNcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eDfdDeu2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R915uF1104476
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:21:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XVvtHevChTjRcEf/R4PrdHh8FUUsCzlToSPrj6WpnT8=; b=eDfdDeu2SlH/Td6j
	3RFRWL4JT8SrnXNk/GbhcEq1Yk5Sg+Bo1Pbsx6x1Gi4pPQeRa19PK6iL3n3wXB8I
	Dtljid1N6RT8HKxmEaDI13+s7JYIFK1bN2Brxg3cZlkARePC/V2FP5+jGOCM4m1K
	a2BbCNAWSnSfrgWKEk/8jQGOBXHPNZU6uQA3APDryPH9rpHDQfyVc0g87qX5KJQ4
	K5jM51pjmkYchMH1oI+SAOYGBysly2Fhep1p6UORN2Fl8jLl9eViTgEMnQBBfb6a
	+8zOUE03PkUw1UcRlVjypKViDMvHezvshLGjskutgzXgiO/y1iX50ccbZoEnuwjF
	0Gv3Jw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a1uc59qr2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:21:23 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-277f0ea6fbaso54718275ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 04:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761564083; x=1762168883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XVvtHevChTjRcEf/R4PrdHh8FUUsCzlToSPrj6WpnT8=;
        b=D2UQ5uMGi7h+67Ts4hHuTtblX+etoeF3xcwD6mWQ/RulRfAEkwxiBGlPz33NWVmpbE
         pE1or+HwzanjGK0g6s5l6lG/y16qq+9sgXTHxoAehuC1Wu8UrM7rYBZ3THgQPYCw/LTL
         5Sg3aj4/aAR6Pn8GLflnnH/EpMH9ucDFGerqpQ5K2qqU+O5bU+bvW96/GPJmQ9wXSaE2
         xzgsxt+9zPOSC6EJESMCi6HbQSFIgIsFeCVIJG1jRWRVQK41ei6H2sLbiwvOmG+01k9e
         uj5giTys7KuNT4vGSk7k5gcNs9AjY0WBkHOfAjVnBPCdfa3CGOlMn4k/Ukgrhv7i23qu
         Wz3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3FzE5bF7I1CpJDnwjmgeLsCl1XPjbk8KJbdXFnV+X0CD7v6KO8+T0vuY1n582PKDfB9BVarOIB8diAnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFbIXnDq8MPQE8aURCKSqjFkAuJ4xiDX3tmvc04W6OdZbdU/wP
	uHl6GGXFm55F+RlhOMGzNcNl50ZT+oS2CpJhD1Jwss9RKM48Ywd1ZPpyJmUCxH28kfInjN6nOH8
	HN4zwAOkcAR3fJx5RZ/kZkTJ5SSUhFHjGKgWzh7DejbTa9vW/orTb7sZiZ+A6YqKYBXA=
X-Gm-Gg: ASbGnctMZMbBZ5a3uTq4ScF5Emgfcvax+As4aS/FTSZ+kZ3tdxZnFVeD8Mx4G+2wxHf
	/x37BsA2KxWievzRvWdDUIu9KGQX6nJ4NpPvhq4kKhGvDwAkTSuQM8mYtJpDKmUbXZqENlQIvU0
	CnW+iz7XNIe1IrehPTkQviPx2VmjiHLxc7DW6xKk4xsak5Lmttc6cP/aIEE5X9is3+U3S0F80+S
	tXCCjOYTofqxrcsSxC75e6wPQFhLPdpogU1Ylh4NXxvh03boBEQZYKpEk38hzLWQrblFOyUWGm5
	8NDrY3xdcBQqk6kjbEBmHo3l8uuxhAyocoEf0aypooAHxE1WbFWxEDfqcQ5DVntvaP/YXVmAorq
	4gsuO0DIAn+3rwg27nYJ0BompAV3zRlJhwh8=
X-Received: by 2002:a17:902:f691:b0:290:bd15:24ae with SMTP id d9443c01a7336-290c9cf34e6mr372400655ad.4.1761564082874;
        Mon, 27 Oct 2025 04:21:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExw90y1BtsPiKONU4IswMqcJENAejckfFy4OkOxXu7umr4qg5fdTyIbLw0rlv38LlnFk+GbA==
X-Received: by 2002:a17:902:f691:b0:290:bd15:24ae with SMTP id d9443c01a7336-290c9cf34e6mr372400445ad.4.1761564082387;
        Mon, 27 Oct 2025 04:21:22 -0700 (PDT)
Received: from [192.168.1.3] ([122.169.146.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d2317csm78838865ad.48.2025.10.27.04.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 04:21:22 -0700 (PDT)
Message-ID: <aeec371a-ec8c-4a19-ab5f-1ea10f55d6bc@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 16:51:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: dts: qcom: lemans-evk: Add OTG support for
 primary USB controller
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org
References: <20251024182138.2744861-1-krishna.kurapati@oss.qualcomm.com>
 <e83730a4-f270-47e6-9bea-336c142eed11@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <e83730a4-f270-47e6-9bea-336c142eed11@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: pZWX_6iUzx085jY2PrIKqfORsvLSpYob
X-Proofpoint-ORIG-GUID: pZWX_6iUzx085jY2PrIKqfORsvLSpYob
X-Authority-Analysis: v=2.4 cv=Z4Dh3XRA c=1 sm=1 tr=0 ts=68ff55b3 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=os7cmxGP5G+7zi0Bb7vKnA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9kjh7eMwnbizjImSWngA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDEwNSBTYWx0ZWRfXyi6cfWJgoNb+
 uyR2OJobJweToBpgNXiiJ5+jMcvVWoEDWoP0AsV8RaceXr16fjTb1rqJ5XVWNVPnKclAgBptCBY
 YeUIOxDqho9Nj2YMPDUKPp/4mvI3gf6mSdm3qgcrvbBsByL0ff+ZWV0o9SN+vahTzmxAadrqkow
 ahTK1iToIt9zsIlczdlE8LWNEYR0T1SCtD4jWZBP/ffVUdvuVMgEIaZ7AT/WVC6XU0tDtBskUgp
 hHiV/HvhJIKo7Wnlpz7bzbZO5TEslk/xRp9wkW/gLbDB6pYtH1LnofNSZDRtwFikb2nR3Yo63OB
 Pc0Bm2mzO03e/57tL7GrsaJ5RktTxrL1h89wPqpCOUjCp5eEjpYcbaMZfammTs5OKoBoaeIQFdR
 RSD4Le+DuM07meNtFDzf1QSxRVLslg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270105



On 10/27/2025 2:06 PM, Konrad Dybcio wrote:
> On 10/24/25 8:21 PM, Krishna Kurapati wrote:
>> Enable OTG support for primary USB controller on EVK Platform. Add
>> HD3SS3220 Type-C port controller present between Type-C port and SoC
>> that provides role switch notifications to controller.
>>
>> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
>> ---
>> Changes in v3:
>> - Moved "usb-role-switch" to lemans dtsi file
>> - Moved vbus supply to connector node
>>
>> Link to v3 bindings and driver support:
>> https://lore.kernel.org/all/20251024181832.2744502-1-krishna.kurapati@oss.qualcomm.com/
>>
>> Link to v2:
>> https://lore.kernel.org/all/20251008180036.1770735-1-krishna.kurapati@oss.qualcomm.com/
>>
>>   arch/arm64/boot/dts/qcom/lemans-evk.dts | 122 +++++++++++++++++++++++-
>>   arch/arm64/boot/dts/qcom/lemans.dtsi    |   1 +
>>   2 files changed, 121 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
>> index c7dc9b8f4457..2baad2612b16 100644
>> --- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
>> +++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
>> @@ -37,6 +37,35 @@ chosen {
>>   		stdout-path = "serial0:115200n8";
>>   	};
>>   
>> +	connector0 {
> 
> "connector-0"
> 
> [...]
> 

ACK.

>> +	vbus_supply_regulator_0: vbus-supply-regulator-0 {
> 
> Other regulators (as can be seen in the diff context below) are
> named regulator-xyz-abc, please follow
> 

ACK.

>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vbus_supply_0";
>> +		gpio = <&expander1 2 GPIO_ACTIVE_HIGH>;
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		enable-active-high;
>> +	};
>> +
>>   	vmmc_sdc: regulator-vmmc-sdc {
>>   		compatible = "regulator-fixed";
> 
> [...]
> 
>>   &usb_0 {
>> -	dr_mode = "peripheral";
>> -
>>   	status = "okay";
>> +
>> +	ports {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		port@0 {
>> +			reg = <0>;
>> +
>> +			usb3_hs_ep: endpoint {
> 
> Please define these ports in the SoC DTSI and plumb them through &labels
> in this one
> 

ACK.

Will update in v4.

Regards,
Krishna,

