Return-Path: <linux-kernel+bounces-797804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB080B4158C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D5367AC5AC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 06:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263E12D879E;
	Wed,  3 Sep 2025 06:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DGbLRnAf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC251E2307
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 06:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756882254; cv=none; b=WbS2ZxZFTxvUKb04awhVO7eEqGTu+MVE6CMZ6oDEEfRdMjw5Aia9XEoEipo84uIZbeTqOSo9YSeZHz8WoM8nKLYoVoX4boKdUonB75+JNR/gdwZUyrqIxP7ioZcRJsb8E6fhKdh87IPtvbOFsDPHqng1wB8sxJQyUtozZKPZrQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756882254; c=relaxed/simple;
	bh=OZYvAJLqb8zNZnB+JiPiyr5fYxUP3/2uA4CPj714OP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IQ1H2ISeBcrK3tize0NdXeHZ5DemLpYZ1739jJMo+Nh4BMIbdqV9pfkanqpwGcSrkO7jrXkJ0xIlhmMRE4aDt0zFdJblQuio2Hr8dtfGVp4aYmTdR82QI1tcV9tj0NhAMBFNKFmpDfZSgM03sc749al6ASAxPtV9SoF5gIwUXOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DGbLRnAf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5832ZHb8012309
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 06:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d9hHMK6M77PZdvE0eh4C0zvscADxksQZEgHG4rBgto8=; b=DGbLRnAfsMgDDMb7
	cqSsjfPGazPKIOo9K5tINfJGUMJvgbnopVApApJMkdJ80koFpDpIlH84DWjmc4+r
	vInlObQABHp3Nr2u9g/oBoElHnMDIRXX+SnEk/WBbPb9ewlUBAJNeKsE19WTThkp
	l3HwmJRzwscl/f5Rnk4m5Z/GtsCXCCtqAEjt93FrIMk5WdfHl6/9vj1CY2AzSvNB
	ucoz+KCPdizVzeaSy7adUGBrBKRrqMPD60AAOBjL+4p2GwpCFK2T7S0L1xwLM3LB
	KvS3A4K1y0r/+uqnfCtuy32RhkRxZpn5BAHRbF3Jxmz73GfOtSuNnnd3cdYaqSyr
	xAq5JQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2fjdfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 06:50:52 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32b51b26802so953880a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 23:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756882237; x=1757487037;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d9hHMK6M77PZdvE0eh4C0zvscADxksQZEgHG4rBgto8=;
        b=AhLmboFalRaUWknQEXrcE7IDFkT19bo+Me1kxQvABXK+OjNGX0wFxG2mi5Tx/Aw7TV
         GrR0aoESRVi8WPEsP9tJzjczohggTq3gsce3YMW92/t28x1QfbeH0gFnxFz3S4bT0tvO
         lSj+G96kbSFlIxc5eVIqA/5XxTkhxx1lA6oV3hVygQu8/pN5elso0BdMO31Luq6vHsQi
         kR7LxrZTR8aiUK1STc2QOQZfg3GetP7X4FoVR0WDyZspMKU3IAf41HhgwS0/ZxzJ/zLM
         VVucNK/yq8KsEUM204xBPluBC4re0T5PXDAqlLNwK0dtnA4VvG7ypb4DNVxnBg+/0YwM
         ADNA==
X-Forwarded-Encrypted: i=1; AJvYcCX1O8OAs8HKZ3a0hehattmlZ/Tdo8H6Ag0tAvAnT9KbUTC6Ytcfx1Y5v9pvaX2wdm8wu9jK0MZsg1kZ2GY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHXMhuyb+NUsFXlG02XneMp7l1dDZt0ED/HoizFvna2VROvooV
	NKtX2V2zlM2BQIM6CgGl8EWyQJvKDF8jOoeUbem3qvayBEbJWjy8fza0lC7FXxc1OfBQr8u2oxM
	Jf/y9LaABo+nxGGQ8mhq75rKA8KceH/kUQD+bAGgFxRLWSAleCuEtgicLmDYPIXN0N1uoboZB5S
	8=
X-Gm-Gg: ASbGncu9BHtqgLfp6CXcby6TOCwnYyER9ocQ7k8fsNp/w/KqBmwMcZi6b0JaFTvvUwg
	49yKarowSpjDeLrFU4Y4oBaNbltd/sXyuA+FROqTZiQRVTjD8/Cl52q0Dp1xsxWWsJoy8pMdY0J
	FpAHW/X78oIQ1EKG9QfTteGiUSmmfMYsmq7aeRS4kJ7Ho1Iga/zZGpcU9VXCQ7Er/TK6SBX25S8
	sNwEz4b0bhlOvwgm/+IaXnkcW8ETa7NM5mh8mSZMW7YOro40UhDytp5ZG0RPBmq0RHQHtnFiH4n
	/H71pRycvqdY+6YTZ5xXV/9bST/022ZiZ/WQzRSQFz7myvcLz5iNhUGLPxXWANkvCAhI
X-Received: by 2002:a17:903:2302:b0:24a:aca0:7cfd with SMTP id d9443c01a7336-24aaca081f9mr170262545ad.18.1756882236679;
        Tue, 02 Sep 2025 23:50:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyFdo9cEWjCOC0ZpT9gc5RWF3uY6Cc1QxsgEsFMAs1ei1aEnR+j4ANyXrofAMXnY7o6hOvdg==
X-Received: by 2002:a17:903:2302:b0:24a:aca0:7cfd with SMTP id d9443c01a7336-24aaca081f9mr170262325ad.18.1756882236220;
        Tue, 02 Sep 2025 23:50:36 -0700 (PDT)
Received: from [192.168.0.195] ([49.204.24.116])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c8e94b34esm10185985ad.94.2025.09.02.23.50.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 23:50:35 -0700 (PDT)
Message-ID: <6b8d52f7-8c97-4aa1-9674-02aa13fba18c@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 12:20:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] clk: qcom: branch: Extend invert logic for branch2
 mem clocks
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20250829-sm8750-videocc-v2-v2-0-4517a5300e41@oss.qualcomm.com>
 <20250829-sm8750-videocc-v2-v2-1-4517a5300e41@oss.qualcomm.com>
 <484eccde-bcab-42f8-bf6f-b370fc777626@oss.qualcomm.com>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <484eccde-bcab-42f8-bf6f-b370fc777626@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfX/nKjg8+gKml5
 ZPgHmIxu9mqZjZY0D4QkAyIfeExZNwj3YrYfSjRN43oa9QryAZK2oQegqakwBMV+oiHZLeS2My0
 r+07yT+jgLjpKCfiFHHmW30aV3k35/8ccXbqOsY9iVs8C+K2ral/CnYl0U2QFPnt/xWMKmERU9+
 kD83eyRdS6agvvkgwDZgUtxxCCxl7Iq4kAgIe4dsZLwcLGZG2seXgcmIper5/JAcZhw+rYT3biF
 w7U6qmkXcp47P7btJsjz9FExMf37IOkgkyp6XZnOuLB/VmS9YwCwl7hh/J0Ejt7mqisorAlserM
 dJPT9a1GXab19hyelUUM/HcpJ/EXU1PluMRpPY+KeO6TYAxcUpZ6JUPL3W+dvKhfCGX3OQ+zoX1
 9i2Be5es
X-Proofpoint-ORIG-GUID: pRgNfkqdoL0m-cz0PuiTS702wsk-nSwz
X-Proofpoint-GUID: pRgNfkqdoL0m-cz0PuiTS702wsk-nSwz
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68b7e54c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=PZ7RaY4/qyhr7oYTfvPPhg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=W923pDGaHg0UEdA9CysA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038



On 9/2/2025 5:27 PM, Konrad Dybcio wrote:
> On 8/29/25 12:15 PM, Taniya Das wrote:
>> Some clock branches require inverted logic for memory gating, where
>> disabling the memory involves setting a bit and enabling it involves
>> clearing the same bit. This behavior differs from the standard approach
>> memory branch clocks ops where enabling typically sets the bit.
>>
>> Introducing the mem_enable_invert to allow conditional handling of
>> these sequences of the inverted control logic for memory operations
>> required on those memory clock branches.
>>
>> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
>> ---
>>  drivers/clk/qcom/clk-branch.c | 14 +++++++++++---
>>  drivers/clk/qcom/clk-branch.h |  4 ++++
>>  2 files changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clk/qcom/clk-branch.c b/drivers/clk/qcom/clk-branch.c
>> index 0f10090d4ae681babbdbbb1b6c68ffe77af7a784..90da1c94b4736f65c87aec92303d511c4aa9a173 100644
>> --- a/drivers/clk/qcom/clk-branch.c
>> +++ b/drivers/clk/qcom/clk-branch.c
>> @@ -142,8 +142,12 @@ static int clk_branch2_mem_enable(struct clk_hw *hw)
>>  	u32 val;
>>  	int ret;
>>  
>> -	regmap_update_bits(branch.clkr.regmap, mem_br->mem_enable_reg,
>> -			   mem_br->mem_enable_ack_mask, mem_br->mem_enable_ack_mask);
>> +	if (mem_br->mem_enable_invert)
>> +		regmap_update_bits(branch.clkr.regmap, mem_br->mem_enable_reg,
>> +				  mem_br->mem_enable_mask, 0);
>> +	else
>> +		regmap_update_bits(branch.clkr.regmap, mem_br->mem_enable_reg,
>> +				  mem_br->mem_enable_ack_mask, mem_br->mem_enable_ack_mask);
> 
> regmap_assign_bits() is your friend
> 

Thanks, Konrad, will use this API.

> Konrad

-- 
Thanks,
Taniya Das


