Return-Path: <linux-kernel+bounces-747054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3267FB12F28
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 12:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A027F3B8C45
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 10:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F33220110B;
	Sun, 27 Jul 2025 10:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uw+RTg8Z"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEC1EEC0
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 10:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753611267; cv=none; b=J3EAXetosnaLiozblXnM939MOhnKTN5S6O1cRh+pp54jS1q4j3jh5mvDS4Hc1h9pqzeTbbgamZtclMUlt2KcNiXqmByNZZUcGae/AA89PGiLuu9oGAwIWeefyT/oXwGBRCMkgboOSga6SMg9I81beHW2cgVnLBEzkLj1CnyHSp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753611267; c=relaxed/simple;
	bh=8qsXtxH+kgZ5916SUbXCu8QlLNqivyV04aJIMMPtIWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hejWEl2bGjZ43IwaEp6he46MuMQIxuB/xOqhjNTHcYdsY/T6zLPw+YKOAp2hwEcrN2xR1R2t+qnhbgRbJeApDVNuqLviCev1uNm4FztIqHWg3zYcyi9xpwSKljlBPAiW6WkaTF0AynWeWH5UiB0m2GDe665JtdcGqZ9a/c9Syv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Uw+RTg8Z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56R3MtKL004838
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 10:14:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lwjb0BHg6EfDOouDDm1cybRLuxEXfs9odZ3SmDOgc1U=; b=Uw+RTg8ZDBuO/gTY
	SBrRo3cR6k2ilnI+qWly3feuj+Ore1psvzEOgWm4phJSQAbG9imZKcLgF3Muso93
	0YaRq00TRzpYu1w3xDGCJCkay5SOi+sW6YRgf1NE19k1Mhq4ge1vB3zuO6te/ghw
	weJeCIQTeVI/uhk/EBNsnyERKW8NwUWG00FCrUZnMsje2bfPkcdi5vVg64nVzLzt
	AkiwDXT7CfNx8ZMjI6HsHc4nes2M+81p+Xy575y2WmoAxefINxudt20ktgmhF6Ly
	FCZOJCT03tGU00oF6zxtqx2frQECNkrl0cOb2jmakXktConyIDH/KULlJY8jydJU
	zGmJ/w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484rachw9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 10:14:25 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-754f57d3259so5467702b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 03:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753611264; x=1754216064;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lwjb0BHg6EfDOouDDm1cybRLuxEXfs9odZ3SmDOgc1U=;
        b=fIPI9XJlNIKGcwJpgOCEH87cSDV+18eFxwqGpeVvqpfs+yNdwqBnAtYnVM56rm40sJ
         QlEQrae38T3xFhZt58EsA+rl2C1w9/56SnzTTj0ybYkIpx0Q2hT+bu/5T/91idq7xrN1
         Q2ppxvpzr9STLD/WbfAVdakc5okU1o5h4izj50eoQs+k8XUs53UDj+t73tmMhs2LgNql
         SRFKM1ZJT0kWw9l1BrVxwpTeCbxPol7zNP5clEuFb02/oS8uV1Kml1sAUGYebClA7uXC
         ETg+VdqqorO40h48++y4uFQKc0LQ9JW4c0JpVjt0mMs4WtC3/dWmMLHSguLfDOJXmvCH
         vyvw==
X-Forwarded-Encrypted: i=1; AJvYcCUu7WayS2N8tjh6h5o1Kj5khkLgavKTnrpdEyO3ErUTeq7eeCBrxOLQUn8vpR7TkRcHIxwMF47pRcGoSxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YylF/eYLMNXPz9l2E2gfuOKnixZxBXLYRHr5yCtspEEWxu+BVaI
	PMoYoPZJPSTWAEkfEWhB6DJkjzifxd8c3JzH4sZsznJDOwWU7mGl4g02p33a0ZKHmj3AlrkvbEL
	Cspj+DNEYyHoD6NMp2I+DAONxJi8un3FqoPNwE3ibck6tBoJ8PDN90/4i1a7hiLabktk=
X-Gm-Gg: ASbGncv4BQuoE3WsykudIhkgwizZ+kmUg6kqU7aVEWs/BB3wz+ekKFeI5WvfkshLcSz
	+ybPxQsk6CyKzShtqQ4JABxy/Aokc+mxazdRRGltglS7W3+XjDlcGhZjV6V5HaFl9TF2Cb9xDBW
	C9IYd6l/Fo1QjRwLPWX6rq+qvq5YiRK5kaaM7+54CZ0CS4phNAN8BLR94ooyP7hJBjZTcneLUpd
	U/yaR8rRehtNTsPe0MGZAibZy412VEMS6ZDeJVBwBYOA1HGoZgJhM8AJ+L5v06O4NVCp3cpdZSX
	39Y6TrlubsD70Z2KvG6+/LtGoY4oGvu7ASuF8bi0eq5SMNT49ZhEzClC5NEjSJiN+uBJDb9pzQJ
	MITHcnV+Y7evofp1eFw==
X-Received: by 2002:a05:6a20:4309:b0:21f:5598:4c2c with SMTP id adf61e73a8af0-23d7005288amr13839134637.13.1753611264448;
        Sun, 27 Jul 2025 03:14:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8LNyK4aRWVrXyDFBP0wxYJ0pw+PA18v3/Xqj1UNu4XPeuS2DNvEXb+2BJjw1zfbwOcwCGEg==
X-Received: by 2002:a05:6a20:4309:b0:21f:5598:4c2c with SMTP id adf61e73a8af0-23d7005288amr13839095637.13.1753611263986;
        Sun, 27 Jul 2025 03:14:23 -0700 (PDT)
Received: from [10.110.115.111] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f7f6b54e8sm2802688a12.57.2025.07.27.03.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Jul 2025 03:14:23 -0700 (PDT)
Message-ID: <0cbecd24-fb1c-441a-8921-ff1651503577@oss.qualcomm.com>
Date: Sun, 27 Jul 2025 18:14:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] arm64: dts: qcom: qcs615-ride: Enable WiFi/BT
 nodes
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250726-615-v6-0-42b8150bcdd6@oss.qualcomm.com>
 <20250726-615-v6-2-42b8150bcdd6@oss.qualcomm.com>
 <ad5d7zx3ztuouvqediihpj6ukmy7dvl4eampuirp5r6ftr4lh2@6fkebmfj25yj>
Content-Language: en-US
From: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>
In-Reply-To: <ad5d7zx3ztuouvqediihpj6ukmy7dvl4eampuirp5r6ftr4lh2@6fkebmfj25yj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=WqsrMcfv c=1 sm=1 tr=0 ts=6885fc01 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=rhgo8q8DuPZwM0GwmL0A:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: 97CoSp2FpJhEMZG9PZsJ5PRwgHUanfxi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI3MDA5MCBTYWx0ZWRfX5ZRRRJeIi7HZ
 AJjuiXVfFp25Byu9B+68BiUoa+Tggx7tIIDN0hBy6DB7GWKizswTCZ7t4i5Ov7tW2mX+poK9QSz
 BKZTMdsKOEPqL77upyXg+FMccPzHqPHd6tD4nsOU8gq8pIHCyMHKWgfA0UnP3qO0OCssFqXYell
 VWHSj2Bo2FzFIvYVu59QNsPIpV2V9X4PkIaueTtvkp/LP+tYPzMNGHjf11OfotIxL/o9aqbawNb
 A3l1NhgqOYjSyy9Ab3qnqGGJj3PD2L73SlKxgp7lOPVMxntHhBY7pbulWlKYz76BxFr9DVzqe5k
 J1h6tv6r2rYv2pVwrhtFbfaMsC3qJwHFiJ1bIw/oPwU/yzxDSk4V9hgL2qAUYS3wj/+HQa0bDzC
 X4ovxT1YR/Dm+1+AstQuayTz/J6c4qVEG08skAyZQKPJ3WCFBzIz5ewFyuUON1rAiUSAqeVN
X-Proofpoint-ORIG-GUID: 97CoSp2FpJhEMZG9PZsJ5PRwgHUanfxi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-27_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 impostorscore=0 mlxscore=0 malwarescore=0
 adultscore=0 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507270090



On 7/26/2025 9:19 PM, Dmitry Baryshkov wrote:
> On Sat, Jul 26, 2025 at 11:31:31AM +0800, Yu Zhang(Yuriy) wrote:
>> Enable WiFi/BT on qcs615-ride by adding a node for the PMU module of the
>> WCN6855 and assigning its LDO power outputs to the existing WiFi/BT
>> module.
>>
>> Signed-off-by: Yu Zhang(Yuriy) <yu.zhang@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/qcs615-ride.dts | 135 +++++++++++++++++++++++++++++++
>>   1 file changed, 135 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
>> index 011f8ae077c256f079ce1b07720374a9bf721488..f6df6a88adc8cdc416a57d38b8eaabd53fbe3fcd 100644
>> --- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
>> +++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
>> @@ -18,6 +18,7 @@ aliases {
>>   		mmc0 = &sdhc_1;
>>   		mmc1 = &sdhc_2;
>>   		serial0 = &uart0;
>> +		serial1 = &uart7;
>>   	};
>>   
>>   	chosen {
>> @@ -47,6 +48,85 @@ regulator-usb2-vbus {
>>   		enable-active-high;
>>   		regulator-always-on;
>>   	};
>> +
>> +	vreg_conn_1p8: regulator-conn-1p8 {
> 
> regulator-conn-1p8 < regulator-usb2-vbus
> 
> Please keep DT sorted
> 
I'll fix the formatting issue accordingly. I really appreciate your 
continued patience and guidance.

>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vreg_conn_1p8";
>> +		startup-delay-us = <4000>;
>> +		enable-active-high;
>> +		gpio = <&pm8150_gpios 1 GPIO_ACTIVE_HIGH>;
>> +	};
>> +
> 


