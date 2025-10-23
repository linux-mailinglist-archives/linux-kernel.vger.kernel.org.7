Return-Path: <linux-kernel+bounces-866307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40063BFF6CD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 05B843588C2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4471D6194;
	Thu, 23 Oct 2025 06:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="khCqelEB"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFAD2566F2
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761202612; cv=none; b=prf0IEPmBTEH1ot1bLxPbWSejXCJBLP3ice724e39fKDeDccC5jBrcmEW89Hoq1SlNkqdyDo5mdITOgg6Yz8jBaaElHEj5TypC3U13GnFguJfMxBG4coy2O4THd8DaURfC4VKjU3+KOnB8WXzxVe0kzZyog0oNHegxtMOqR83Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761202612; c=relaxed/simple;
	bh=BW+kg8htBMkugNFEx4R0pb35ItCAPtb2W8sPE7A0J6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ifKbUvdFIk1jkYhANEWwr4fQa8FYlAt0wJY9MB+WWfJ89fbk6i0EyR2bCfCX0iENW1goBTapqgXIwogIy1LzfWFbZupegq7zFH1PhPiwWeexMmC0Y1P+w+7yX08+mqwhImz2WINAF0UeD8zkjWuLKc545Fje+yBIKnLqrD6mlag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=khCqelEB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6Id7s020167
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:56:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+efyRDA4riV9spYnZlw/APnqKUaUaN3qfqzGJ8qH2uc=; b=khCqelEBy4lVeQ7+
	FYXiHgICW1lqub4Fz526fKpkit0d1GcoHObWhLZfP4e+1w5eMhN8G9m92i8kOQbu
	pk6tdkx9zXgqdiF3kCVo2ncrZoUNjwSuwsJghNhwBdxlGuzvtFQMbfSevvJ//YN2
	xaBzoYaf1mCYqA/vu9vEJu7lwl1UdnkxeqFlr/AhRNGDBdgGOkcKltniP2j4DY89
	mSdzsn4y/O47MJJd281VFpl0ABxugU/dlhSaPBX1+UHisWZapQFH0zWSaPTvlucQ
	Z76p1tLGpXpgKa4LLIrOoNibnam0TYiW29b4eCiRWWTONiGwArDeBYkCbNgRv4e+
	axpTAA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v08pqjvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:56:49 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-290c07feb72so4358135ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 23:56:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761202608; x=1761807408;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+efyRDA4riV9spYnZlw/APnqKUaUaN3qfqzGJ8qH2uc=;
        b=w3FI8fORyqavxQnhjIpYqZPAmAsXaddUGyASKC6aueBCu92+R7VfIeKGHHKGXThHLY
         xyKve3cT2DOYMTdBzYv0hF5xSKs4i9BNUirQtoa5NpsyS6hz/KAlBI4iJ1aLgMdSlOgn
         H75S/xZbMddE7qjBDJxZy5R6yduV61Htwkt2RzCJJEC5rRlwrvDxSCi/L4LNMZ2xDAeb
         mfDlVMmve4R6FGuCFOqE7VVzt1O5Wh5U3RvAJVVhoc1dPvdIQzAsvsKDArXBODtaCq/j
         BNW4VceaT0Fc5OGUlglAzhxnVZs+yWGYD0gVO5QkDYeZrEDDkGYrB34nGz59TlDBKTQR
         N7fQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTNlEX7TaD1TTY4h4TXutFA3g0YMxr7NQZuDYKtYmw0ewIn3AY+lnI28LEK5qJCsNIVZyRsxaR8xH5lfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YypVz2VGVh2pgFPNpg66klfVrzOCkuJq+lsKsCgxI5veunxTln4
	EbUsEUAPMwIhDxAkuiOJq4nZ3Gf4L9CejQgp6uPOwGd2nuDYEPu4yFUYRmtmNl/f2jaa3xByoXc
	J5YYaJL+GPq5I78FDmLyFg6e8CaMlF2pfFk3iypQ+dmy4sf3Go16eAb/xM1KfWQN3umk=
X-Gm-Gg: ASbGnctAafQ/d9GKgcirrlT4OrEKmeCS4Ac5jchQC5cf3nRowI70uJMzB6V8LaCL5x5
	qU/xOzJZiDuY9Zxw7svpf7gUAQahFUAArVEZhhJCIgwmG+vwRxksWl8haapOlxzCc9pW5qVB25a
	Y+uvUJFrki7gOFGrZKbNgTfLoTz4YKL1j0TRNInQoqsV1gicmc9uXoCAg/x6AHONHSSJKGMXIXi
	fVFYXuWqgGbvNxwdjHNYOj6f4hYPwD3Q/ulbXKTbYOETXeK+R7+5SfCc3jmU3tiXR4MZoTMZ6eY
	BsRSiHWTXkCOByOodM3dk11nhy/8vA0c6V8B+GzyPPPGBwMEeHF53xxXzpb/iWlogzo49H/ZXvH
	KFcip8pWxqvf6aqew9aZm5WDhpEM=
X-Received: by 2002:a17:902:e5ce:b0:290:af0e:1191 with SMTP id d9443c01a7336-2946dea1368mr22465265ad.21.1761202607976;
        Wed, 22 Oct 2025 23:56:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUW0YEaHqb+o6OIwpRYA3a26EAhwWv+kJ8gb2tFkO8g+VN+YewDwGtLNYa5D2L0rAadSuNVg==
X-Received: by 2002:a17:902:e5ce:b0:290:af0e:1191 with SMTP id d9443c01a7336-2946dea1368mr22464925ad.21.1761202607483;
        Wed, 22 Oct 2025 23:56:47 -0700 (PDT)
Received: from [10.217.217.147] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946de02357sm13016435ad.41.2025.10.22.23.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 23:56:47 -0700 (PDT)
Message-ID: <c2429e35-7d33-4500-8e0d-a992cad99f63@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 12:26:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] clk: qcom: Update TCSR clock driver for Kaanapali
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
References: <20250924-knp-clk-v1-0-29b02b818782@oss.qualcomm.com>
 <20250924-knp-clk-v1-5-29b02b818782@oss.qualcomm.com>
 <jr6qz23acm2ipspsvyxjpabg3b4bspapia2pqd7b2grrtvnct5@v7mjwnr5o6qa>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <jr6qz23acm2ipspsvyxjpabg3b4bspapia2pqd7b2grrtvnct5@v7mjwnr5o6qa>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMCBTYWx0ZWRfX4tTmfVMgX5yD
 8ZkeA0yW3SCBXdBhGeDCaU1tz6ulxQrF/wOGBl+R3+XrpLjLysd0JOULKMQ894v9O180mNqVvWE
 ZQFJP3rv4GJx4P7Rirtijg7YsAA/rvsaTpv6trSR9b2fP/AFk9l5tqukhqLVgqvFC7ITdBgd749
 oN2G0XihBXJHGWHqEG8im3za3uRLUXMSYtUZ8+pppNhP5SG3DO9NZZjD3bOHc6WQlwVvsvcw+PV
 9IXfpA/Hs/1m8R9y73oCUHJVyZf1Wl1teINWfjKwsIDQ2HnsOLPfNd8pq8oInJTd7+OjX+cm27r
 KMSu6sVjYF01g6WjgK0UEIru4t4WJxST5iEGezTFAl8CLfXaGSdouO4Gn9JTvvW3ckyXFN98VSS
 NF+ZtpUdP0qBsSGOSwVn+To5VHsW2A==
X-Proofpoint-GUID: 4n_DpnqZHE6sIt5O25Av_tUw5BgGRXRx
X-Authority-Analysis: v=2.4 cv=Up1u9uwB c=1 sm=1 tr=0 ts=68f9d1b1 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=peCUsVMnvPp5iizJ5UwA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 4n_DpnqZHE6sIt5O25Av_tUw5BgGRXRx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180000



On 10/20/2025 4:33 PM, Dmitry Baryshkov wrote:
> On Wed, Sep 24, 2025 at 03:58:57PM -0700, Jingyi Wang wrote:
>> From: Taniya Das <taniya.das@oss.qualcomm.com>
>>
>> The TCSR clock controller found on Kaanapali provides refclks for PCIE, USB
>> and UFS. Update the SM8750 driver to fix the offsets for the clocks.
>>
>> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>> ---
>>  drivers/clk/qcom/tcsrcc-sm8750.c | 34 ++++++++++++++++++++++++++++++++--
>>  1 file changed, 32 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/qcom/tcsrcc-sm8750.c b/drivers/clk/qcom/tcsrcc-sm8750.c
>> index 242e320986ef..f905f3824d7e 100644
>> --- a/drivers/clk/qcom/tcsrcc-sm8750.c
>> +++ b/drivers/clk/qcom/tcsrcc-sm8750.c
>> @@ -100,21 +100,51 @@ static const struct regmap_config tcsr_cc_sm8750_regmap_config = {
>>  	.fast_io = true,
>>  };
>>  
>> +static const struct regmap_config tcsr_cc_kaanapali_regmap_config = {
>> +	.reg_bits = 32,
>> +	.reg_stride = 4,
>> +	.val_bits = 32,
>> +	.max_register = 0x18,
>> +	.fast_io = true,
>> +};
>> +
>>  static const struct qcom_cc_desc tcsr_cc_sm8750_desc = {
>>  	.config = &tcsr_cc_sm8750_regmap_config,
>>  	.clks = tcsr_cc_sm8750_clocks,
>>  	.num_clks = ARRAY_SIZE(tcsr_cc_sm8750_clocks),
>>  };
>>  
>> +static const struct qcom_cc_desc tcsr_cc_kaanapali_desc = {
>> +	.config = &tcsr_cc_kaanapali_regmap_config,
>> +	.clks = tcsr_cc_sm8750_clocks,
>> +	.num_clks = ARRAY_SIZE(tcsr_cc_sm8750_clocks),
>> +};
>> +
>>  static const struct of_device_id tcsr_cc_sm8750_match_table[] = {
>> -	{ .compatible = "qcom,sm8750-tcsr" },
>> +	{ .compatible = "qcom,kaanapali-tcsr", .data = &tcsr_cc_kaanapali_desc},
>> +	{ .compatible = "qcom,sm8750-tcsr", .data = &tcsr_cc_sm8750_desc},
>>  	{ }
>>  };
>>  MODULE_DEVICE_TABLE(of, tcsr_cc_sm8750_match_table);
>>  
>>  static int tcsr_cc_sm8750_probe(struct platform_device *pdev)
>>  {
>> -	return qcom_cc_probe(pdev, &tcsr_cc_sm8750_desc);
>> +	const struct qcom_cc_desc *desc;
>> +
>> +	desc = device_get_match_data(&pdev->dev);
>> +
>> +	if (device_is_compatible(&pdev->dev, "qcom,kaanapali-tcsr")) {
>> +		tcsr_ufs_clkref_en.halt_reg = 0x10;
>> +		tcsr_ufs_clkref_en.clkr.enable_reg = 0x10;
>> +
>> +		tcsr_usb2_clkref_en.halt_reg = 0x18;
>> +		tcsr_usb2_clkref_en.clkr.enable_reg = 0x18;
>> +
>> +		tcsr_usb3_clkref_en.halt_reg = 0x8;
>> +		tcsr_usb3_clkref_en.clkr.enable_reg = 0x8;
>> +	}
> 
> Granted the size of the driver, it doesn't feel like these two entries
> belong to the same driver. Please split it to a separate one.
> 

Sure Dmitry, I was looking for re-usability, but if it improves
readability and clarity, I can split it in a separate driver.

>> +
>> +	return qcom_cc_probe(pdev, desc);
>>  }
>>  
>>  static struct platform_driver tcsr_cc_sm8750_driver = {
>>
>> -- 
>> 2.25.1
>>
> 

-- 
Thanks,
Taniya Das


