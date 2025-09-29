Return-Path: <linux-kernel+bounces-835821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DA9BA826F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD6E87A3616
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 06:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E972C2BE7A7;
	Mon, 29 Sep 2025 06:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gm3nAOaX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CAF29E0E9
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759128097; cv=none; b=tDvygU/6ZNYk4E60eiBtGOwb/x1RksycH2O2EGtEIXTgj9IA4xy4GiIhyn9vXyMLO3VwQWMnP4IHy2uq6PbNRFJHtFuHTd2rSosnjlKAwW/fC1UyeJIsDrjcFt9Sxb+D6ZaFmtJmDN92vHho/uNM+KLbf4RIQhHbnXCzsmk1lKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759128097; c=relaxed/simple;
	bh=Prpla/VA5xYWtT2jo46RGuKNSAxJ9MlDb3GsI1jGACk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dSNXS3BhyzY1tC3vOXslS3w8+CFP74yDr8EsRn/1KNyfDjxmIDCd+7lFv8CfAJzBNaeO7xODsYr2unS8RRbwD5mDvoShmVAJ8/1Ndc8lJLwbx/QcFhxOgwYBtx5ReqMZoSTi9wuUFgywkFRSf73Gv0S+vxargtMpVeaONe7bCaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gm3nAOaX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SMQGpk001323
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:41:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OhaaerqbjvD3FVRgeewGN83h7Xm6Pvn+9D5rt7zkX/w=; b=gm3nAOaXe+kLbyQv
	DrjW8WT3AlIIg3oRu1fZJCUNJyDUcA6khqIQqsYtYxmF3NS5xH4BDjV4B9VfGjOg
	tCG56ed2KrYxLAjqTTUU2w6CZzwzZeqzOLlHjFs3M8mrqpeezF4Wh8/9xhUkgPo0
	LZ9Pb66lMWCLJWr8YBkJNT/v5LZUejUnkiz2cDFj65Xa5tBtB5o4P0pAup26c3MA
	0EqQX8YW6yu6tmEGBEh3lDbHMn/bGpTdjPwXQMFZj/0RiqswKRhpnGee8dsu6L6D
	ph6O0hUKOCMTmZM6DhyF7g/+zxDZO/UXX9gekkFB1yA4ZmJOXdv0NzOPidLUBNO2
	ZBBUkw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8a5v4j3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:41:34 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-26dcd7e816fso14346645ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 23:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759128093; x=1759732893;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OhaaerqbjvD3FVRgeewGN83h7Xm6Pvn+9D5rt7zkX/w=;
        b=TgR0PJjIR20/ydJUcVHCYv98XcPaT5BH4fWfgzh/NSVZHJmk+H3CZo9+puv5D7jOOM
         ZXT0gMWQVMARX6a/tIWzkNa0MOgFaYfcLTqjqfmXuCMuNnWYqYjTJTxYDU+rtp91Bekp
         jA69GMu1A4jE1WRhcPM5q7pWHiWBtCu90jRyVMrNuGpGwxvRWSU7lBPfqhy5MVLd1FTI
         ZyFplBMVIcC/JHJSOnJVH0BQ2/VxboEvJ6kmtMf49fjR7x3qcxhH27LGlOmbLCzY6lrN
         Ixgz9qRFYXoYk6Hs3EijNRmQbQQwhfqO9t2u0o7GJxAATvUPxh/6OSNEAWfjtxwG9ihd
         y2hg==
X-Forwarded-Encrypted: i=1; AJvYcCWak5Oc87qRsquXPPSNMiiKLrn4BJANjd87mRVH9Dar6+074LvzNdT+V8WB/4NAGFBctIqSTvPhuaVWOek=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgPxkpOjTfzq7smPwypf9yUL6fnBFSpSqbyq3YNwqCpgOA3gSx
	i4qIivDGcQQQm6/sQdFOCIrWp/evqtFnBBJFz0SI2c+Siig16slJF3umIQijfVXwOB/FSB2HsSj
	OOWP+XJSE4yX4OnJkrVfViKzdl54lSdQ9dOoCRaeDRCVwHnNwwm+byOCuknDFW7mV2H0=
X-Gm-Gg: ASbGncujfjjOc9De69zZVahtsbK819J5KCAF+ZYvHAU+g5vUbYYneCiNWgya34rdmeV
	RE3ugdJo/oYqtgF47glq1cLJTE99TYhXLN39IJxHK8DBjqGYNSXOhFHitU0sNxZ4FiAdMeWSwc6
	tj3W1cVMhM3cML3dAWoJQaR4ZpWxKMf2wDl4utaYIErYcAppKKNa356fJa/HGTDWoW7R2KI4iIz
	nPduJo60CuM00KW9zNo+rkoa1rdW6KnRxudvO4MuqvDwTyuuxG+Tcu+/DFTmW/Sqmt4Qqin5ERJ
	MeqCSU3J3wV1iw9c7tQHKKmNIMIy2dpBa1O2Yq8QgHSguxkdMyiz2UeCaPVTuHS2Aae6stolcoJ
	0tr1H23Mw5ZqRjDl2c+aztP0plZqWQ4Q=
X-Received: by 2002:a17:902:e74b:b0:26c:3c15:f780 with SMTP id d9443c01a7336-27ed4a986b5mr100365245ad.8.1759128092845;
        Sun, 28 Sep 2025 23:41:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAZRUafuyxfPW7GOQPReY44bTe0BcA41/EX+hnlJtSzAbjufWF65p/s+g11Y9sNTMCcF/6Hw==
X-Received: by 2002:a17:902:e74b:b0:26c:3c15:f780 with SMTP id d9443c01a7336-27ed4a986b5mr100365005ad.8.1759128092292;
        Sun, 28 Sep 2025 23:41:32 -0700 (PDT)
Received: from [10.133.33.226] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6adaf31sm121225275ad.145.2025.09.28.23.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Sep 2025 23:41:31 -0700 (PDT)
Message-ID: <5410dc83-0732-4b25-ba07-605e4956d840@oss.qualcomm.com>
Date: Mon, 29 Sep 2025 14:41:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/20] arm64: dts: qcom: kaanapali: Add QUPv3
 configuration for serial engines
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-13-3fdbc4b9e1b1@oss.qualcomm.com>
 <9685e29d-bff3-4188-b878-230d0f161ce3@oss.qualcomm.com>
From: "Aiqun(Maria) Yu" <aiqun.yu@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <9685e29d-bff3-4188-b878-230d0f161ce3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RZKdyltv c=1 sm=1 tr=0 ts=68da2a1e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=_ltKwtvy-Tbn6v8TjEMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: 5i2EkJzlzCMZXbbEdYvcm5cskh0VRdbw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMyBTYWx0ZWRfX8hxbvOh4jtnv
 kDDIlWA5wZOh3/GyQwwQaqlw0d+7yCgWoDWJz2/dVxnVJnnb5fEN079jgpPhbhFs3IPq21N9PfI
 1vatA714GAYX7V0pd2tRWvPAToR8IDJ1zc2BYvluIrHs47M8az2jP1YJ7D4f1kzBa8xh80n2Se+
 DBXJVZkhVKDOdNBmynH7beSs530m+ufXf52t5tk848AQT7+vF8b57A6aiU+C2ohKvOizYx7ry2i
 HIhI5njqhjmgB+Hjc/1NwdXzG8oIszU/FI6dYb8LeNGQRIL3XbuqVPf01o1LXRSQl0byjgYvZ0s
 b59ryRHoqFvI8q6qp4efKjTdiBk9fDEjxhwKmGIeblTh4N922/rWSimUgen6x/vY/1BfknhzdYj
 zrN+IGW8Y+FYcIp5exzUhObBUGivQg==
X-Proofpoint-ORIG-GUID: 5i2EkJzlzCMZXbbEdYvcm5cskh0VRdbw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_02,2025-09-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270033

On 9/25/2025 8:28 PM, Konrad Dybcio wrote:
> On 9/25/25 2:17 AM, Jingyi Wang wrote:
>> From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
>>
>> Add device tree support for QUPv3 serial engine protocols on Kaanapali.
>> Kaanapali has 24 QUP serial engines across 4 QUP wrappers, each with
>> support of GPI DMA engines, and it also includes 5 I2C hubs.
>>
>> Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
>> Co-developed-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> +		gpi_dma2: dma-controller@800000 {
>> +			compatible = "qcom,kaanapali-gpi-dma", "qcom,sm6350-gpi-dma";
>> +			reg = <0x0 0x00800000 0x0 0x60000>;
>> +
>> +			interrupts = <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 848 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 849 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 850 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 851 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 852 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 853 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 854 IRQ_TYPE_LEVEL_HIGH>;
> 
> odd indentation (on almost all gpi_dma instances)
> 
> [...]
> 
>> -		remoteproc_soccp: remoteproc-soccp@d00000 {
>> -			compatible = "qcom,kaanapali-soccp-pas";
>> -			reg = <0x0 0x00d00000 0x0 0x200000>;
>> +			i2c22: i2c@1a8c000 {
>> +				compatible = "qcom,geni-i2c";
>> +				reg = <0x0 0x01a8c000 0x0 0x4000>;
>>  
>> -			interrupts-extended = <&intc GIC_SPI 167 IRQ_TYPE_EDGE_RISING>,
>> -					      <&soccp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
>> -					      <&soccp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
>> -					      <&soccp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
>> -					      <&soccp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
>> -					      <&soccp_smp2p_in 9 IRQ_TYPE_EDGE_RISING>,
>> -					      <&soccp_smp2p_in 10 IRQ_TYPE_EDGE_RISING>;
>> -			interrupt-names = "wdog",
>> -					  "fatal",
>> -					  "ready",
>> -					  "handover",
>> -					  "stop-ack",
>> -					  "pong",
>> -					  "wake-ack";
> 
> Please try to use git format-patch --patience


We’ve tried using git format-patch --patience, and it did help avoid the
deletion lines issue. However, when we send out patches using the B4
tool, the formatting still defaults to the standard behavior.
The challenge now is: how can we integrate the functionality of git
format-patch --patience into the B4 workflow?
Any ideas?>
> Konrad

-- 
Thx and BRs,
Aiqun(Maria) Yu

