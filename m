Return-Path: <linux-kernel+bounces-741179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6781B0E119
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C42F1AA0D48
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A129727A129;
	Tue, 22 Jul 2025 15:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KOdJ17GG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B7926A1D9
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753199963; cv=none; b=RuSh93Q4rE0vnvO64CnRB8vWhCLYUxooOwh64qsIDUQ+Y9SMwYXm9+NfN7y8FDoqfcI1cfDC8wvsbqJTMhK5IxMd05OqkWVS8d6UiU/78F1rAhRZLMd+zoG9bGGvtbetJc9JJHwvUzZC0txtIEeFDFmTTH6PJvPP89CLmwwqEtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753199963; c=relaxed/simple;
	bh=etXG2QjYXt4ypIwgXdsA2+f49B2ACiCfy0PAh35eVr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MFecDP7bAnN45OXPEB0PCAdecg/XfAjxevG046AT5Oa+XPLuNW2zr/J59qrBTfM6r/OQ/WaCSTGBbxsTVdrC59TH6PsIPXjoyfKOk+pDZP4qifSVuzZ47pp5uPZ62GGZ4G2jV2lrWI9xqFzjUEHwE46OHvjB2xy3AUr+khbDTZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KOdJ17GG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MEdxsb012849
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 15:59:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mTyy1CipuhbQRfNCBRSyXjJv1hgdiRR7+tJ5iNmsnAU=; b=KOdJ17GGDbo9lpqH
	H6ardiip86tP/UMdKxoaolWWtAtJOm+e0mt05Ds+Q08liBic8Oxm+i18NtFQg09v
	BOu4X3+70GhjLgJ4mNzodJH9HlG93wYqSxOa9GGsEDt49d/6FLkmtMb9ZrlIXUSb
	aISEYpAAebpL0ufdLcZOWCC1W1aJhpFIALVp9FqdeYJU5/QAY6wFaJHI7nFKbsjG
	CZF3LIR/OfT4xoF4uiTm6NG1QwMs9y1ZTyAelEUNRuMZSOAqNbdTpSCz8yM7Nyn/
	ASkaQRiuNIfjNBz9OfWpeO7MvhbAC3gjMC1867heZb5CFw3k+MPaZLUjp0/l5zB0
	mYIh/Q==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481g3emvf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 15:59:19 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b31cc625817so19573a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:59:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753199958; x=1753804758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mTyy1CipuhbQRfNCBRSyXjJv1hgdiRR7+tJ5iNmsnAU=;
        b=I2xqYgpJbqDF4riP58ql0SltsR0M4DT3IW7nnZuBmGjN4nd908Tnj45Ydu+uS29rUL
         7zkyJlbghUEBDWsB6JyBXaT35p5YmljcYBqBvQujz5y4V7CnAkq95n1EhfEHXoMAhpz8
         PGOpzI5E0Nw/4BXaqp2CO6QEgIyuQEikiW2pZfB2pK/TrXMkmGP52P4BK9pe7JpBRQpo
         ncHAq4MXQS+Gp3hvlAjqXq2QhXlyPTxhd737iYLNFNTGyzJI2ddy+KgnYcu/KvVXUGzT
         gvtZEOUq0S0SsWPm82E/VoQcg8ZNsPNw8GvueKhtV0LeNB0PzQcvocvameOjx238yP3D
         K1aw==
X-Forwarded-Encrypted: i=1; AJvYcCXIlFAMUjyg3pNE6MUp41NHXNm1uxhfJeskOQ58HvDNUYe6RkodY9fDfwGzDLq1QCgInEmfA1jwgdSwjxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYrKjW4k4htvfQzXlCHTIUml1+MNdKi2n/+FyfTI5GxNajJC7R
	tZN0cSqgG7Cd1Va4Phu7GzRNe4BF7YF+NJzYJ58bRnS/bV46AWJ2RzWCdWGNEzntsTwXVxswEuT
	QlfUH3Mws2D4EbEpAim8N2otdIoFqJKXZdi5ercDCw+cy7HKKpN14g9airff7K5CW3TiXjCtN/G
	98iw==
X-Gm-Gg: ASbGncuscX8te18O3ucCc+kWx32jd5OBPQfSh6LXgYpZz6/60JjBSq3c9nArKNg2ndc
	jaIJi+nwfj8Ut3wyWGR0CfyC4+5L5HjeJwfP/dtZG8BTfdsN7GBcWreOuR6PGlhULjiGWPfCisr
	t3tYqgRuVvBHjdnEFEHMx3Re9pRazcNCS8BtjVbYeiS2eqd6xngx8Fkv1G0XkCPP2lnIhK1o8Nr
	w/p4cejs5BxrKCfLkC8AGqbe4zfoUv4bOV9eymUEzNRscrA+aKJZLVJqmyhNA3F+YW+GH6Jtp5t
	8FfOUoQK9h4Pf38103fe4gFDayCdZlL62vJLizfEjGPebtGHQtvdS181/tg2GGpdT4c6uaz3lD7
	KzFQcYR//4eAlHir8
X-Received: by 2002:a17:90b:3e8c:b0:310:c8ec:4192 with SMTP id 98e67ed59e1d1-31e3e1cf38fmr5373548a91.10.1753199958375;
        Tue, 22 Jul 2025 08:59:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWKoL6qC1AwoV9Qr0uAwS3sJQ0/j8VqGu6gL6rJOQZI8dGchC2xPfMsL5859SptMBKiJYuUQ==
X-Received: by 2002:a17:90b:3e8c:b0:310:c8ec:4192 with SMTP id 98e67ed59e1d1-31e3e1cf38fmr5373514a91.10.1753199957812;
        Tue, 22 Jul 2025 08:59:17 -0700 (PDT)
Received: from [10.110.89.141] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cb7742596sm9835265a91.27.2025.07.22.08.59.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 08:59:17 -0700 (PDT)
Message-ID: <a63cab56-2d32-4d38-83f9-911561807e9d@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 23:58:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: qcs615-ride: add WiFi/BT nodes
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250707-615-v4-0-1a2f74d167d7@oss.qualcomm.com>
 <20250707-615-v4-2-1a2f74d167d7@oss.qualcomm.com>
 <smnw6whsw5todddsoveeanohcaesfip27udzkbw5wk5dwlztzz@ic3xemwrbjwg>
Content-Language: en-US
From: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>
In-Reply-To: <smnw6whsw5todddsoveeanohcaesfip27udzkbw5wk5dwlztzz@ic3xemwrbjwg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: N_r3TscQ8NiZw4lDhn7wVcKp1ntl4QVI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDEzNCBTYWx0ZWRfX9/p9fZ9UY7MH
 xpKbWyr3EuLYRlroln1h9X1ihnrSReO7wzlBQ4FlaXHU/Wvyt8JBJ5YFvn9CEamQYdEYZJpF32q
 QYRWOU6VB67rOuIqYbYncE6WBbxDQd//c38fbvV+kE3z6dRuuprUqCclcfr0JQGeNjOLpuPEIL+
 6Eg76Wx+8Z33NZumRDZanDT3C3nulW2wI4EXNeGJK7/byNUR0NfzphJmvsYR6/VbSxKjsQzo5Lc
 cJQCvgl4eId/NfqSRdzH+mDZRCYqK2VmHZFs7i0mt9W+RJUVbEsdLw/pPAPvKTgRdIfPExUP4pM
 80Ja9M7uX75lRYhVV6Morvokh5pQapCYYYc4kvLOAYq4OT/q/FfJmmQGmAKRvr6DEdFAvW0EVr9
 VRRIBAJwUFXY9HRMGT1LVtW1IRxiAwIVX9tUxWx7bgF10PUkVM7NBW2ibA33v2cc/kNnvJER
X-Authority-Analysis: v=2.4 cv=Q+fS452a c=1 sm=1 tr=0 ts=687fb557 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=63fHwRzrVC1gocosa9EA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: N_r3TscQ8NiZw4lDhn7wVcKp1ntl4QVI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220134



On 7/19/2025 6:13 PM, Dmitry Baryshkov wrote:
> On Mon, Jul 07, 2025 at 10:51:06AM +0800, Yu Zhang(Yuriy) wrote:
>> Add a node for the PMU module of the WCN6855 present on the qcs615 ride
>> board. Assign its LDO power outputs to the existing WiFi/BT module.
> 
> 
> What is "existing WiFI/BT module"? There is no module in the DT. Not to
> mention that PMU is a part of the WCN6855.
> 
>>
>> Signed-off-by: Yu Zhang(Yuriy) <yu.zhang@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/qcs615-ride.dts | 135 +++++++++++++++++++++++++++++++
>>   1 file changed, 135 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
>> index 011f8ae077c256f079ce1b07720374a9bf721488..2df8e7e3c1d3b6d6353a6753b8387c7411edd927 100644
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
>> +	vreg_conn_1p8: vreg_conn_1p8 {
> 
> No improvement. Please try again.
> 
you mean should be "vreg_conn_1p8: vreg-conn-1p8",right? I'll update it, 
thanks.>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vreg_conn_1p8";
>> +		startup-delay-us = <4000>;
>> +		enable-active-high;
>> +		gpio = <&pm8150_gpios 1 GPIO_ACTIVE_HIGH>;
>> +	};
>> +
>> +	vreg_conn_pa: vreg_conn_pa {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vreg_conn_pa";
>> +		startup-delay-us = <4000>;
>> +		enable-active-high;
>> +		gpio = <&pm8150_gpios 6 GPIO_ACTIVE_HIGH>;
>> +	};
>> +
> 


