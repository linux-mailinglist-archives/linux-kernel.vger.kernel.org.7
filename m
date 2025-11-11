Return-Path: <linux-kernel+bounces-895327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE90C4D7F3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA4AC1887CCC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF6C357A44;
	Tue, 11 Nov 2025 11:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lm5HOzGd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iRi46if7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CBA35773E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861490; cv=none; b=d11cOa4dhmXacb8EcZ23fGD1Ujw9LbsKHdHCQldFlEkJnsEbMCHq1QpQfe47xecyD4Vujd39elCaSO18fpYKVHPn+XcIKLwMQ/8j8Qtz5ge9J0kHnVEKD9FoVWZcgypNaKHOFN/czEjiu84+Q9m2K37oj1NZFjx8z4U0hWqpmV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861490; c=relaxed/simple;
	bh=2jdR9UZN8vrYGOyw9mgAGC34N9X/4WjexBYalBj+GOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQmcglno6Mj4zZOMS0UIJ1p/rQvDNpa038HEBUJtenqVnwhwqYYsfHZ+c95PJmNe6GKh/DzKJGDRA8yLE7H+HiAXJuxCGzOZdsDcHvYI3JbFwIkUTU/ktUrBozSN7l9p2Qfv0ytMTKsLghX4AS4ecGfcH5ER3JV7am4toFBZuzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lm5HOzGd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iRi46if7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABBGYJt2231965
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3FiluKets0muxwM6OjhgoIhZXgLD1JIGYw3ipakbsjE=; b=Lm5HOzGdnbTyTCPV
	iFCxv12StfNk2DsH92eRpah86wMg3rd5K1npkB8BUGb95nJ3XmR5JfYSgF3TqUNi
	Rkb7fR6KSL9NYqbZqYYHA/BUMuZtf+IsxelzHCNCVHM/HyK8B1umreJSlRrA7fEW
	pRjxA7hh5VAwkxL2xRN08kClpGWx3sfjuvzDNQZDiDN2NwHxhLNN+gH1mq0hs1tD
	BmghwZT4tHACBBaJxHbotom8DTSl8VSnHGn6rxPnOj9+iRidnsZQx3WQD8e1Ru3P
	oizENnv8BEWGcQQeE72jgkhl5KmpZYhdxr3AimhRJkIZgN2eww2JP6+C49I0u2Uq
	FbkJLA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abkwsatxf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:44:47 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29846b05267so276395ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 03:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762861486; x=1763466286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3FiluKets0muxwM6OjhgoIhZXgLD1JIGYw3ipakbsjE=;
        b=iRi46if7w8nOQD0/NiFGJxNQrB2s2dVvhiU0DEbvHsyLFUReSiHT2VxsEg12FIGTSe
         Dcz8/xjtorRWFqfTb9AcBEyb2QVVuQ/peipvT+RL9ixkU3tw6Q8p3Ua4hvJnb+OKTU5R
         mzmKKmrzQAV1Y1OBjUYfmcbLWaGBv4C9cwNdoKCaqHShC9UZQad7AIR8MlIHwdhZycRk
         7CHMOaHhDrnQjRMNSXBn7FE7LvSHbzRwIjO1mKW8W1YDLQyERhnCMUrUdP0NuuFTkWiD
         n+KgKRoOWxFIKf+SWbDTA2wQpLN3W+bMDt9Xo07m+trU4xqvevOxF128X80Qm4nVHm7v
         lNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762861486; x=1763466286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3FiluKets0muxwM6OjhgoIhZXgLD1JIGYw3ipakbsjE=;
        b=TNAkn27VaMEWn8mqxOxXvJfdDLx8gE/8AWIRCgjI1kqCcM4XE+xte24J29GQk1HDg5
         WHItnaQ/XbImN+CpuTbhQIE9EeoEj0T1mN9rNnQUnDY/CBXnNJtfkgb21el/9/TzuvPq
         y2R4HNDeGeVP3f5CJqgGsbV5KKmZi5i/5OtTExxXYdYpi60E3WBhxH4F/vwHihaNO3Kg
         8fm/v/tC+rosrU8DrwUD+Rv1aHtMXKaTnDfQfjh1u9BCebFths6GmAte84QIN9v8e1Mi
         afYtzxirsJXb9+Aht5pDRhCGO6bSr9MEVCLWmeU4/8CZwKLkEntoXb8O4wS3fm2IX1gb
         v1cA==
X-Forwarded-Encrypted: i=1; AJvYcCX1pI3zKd2PvvNqh3jNHqgGkdZ2fj1sG5LrugwcN7nX+gxft9rf6ivk13uLXtHxO+X/H6Alcq8hGHRKiIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAwavpJA0m2j6Cp+lpreJRzbm6/Bs0yM+nD/xgZspMAFtKVySU
	tiwm73ZzESRp7T+pRTmEGSfnxy0yROSL3ieXXEbZMMqZBEMhuuqVHR70A/+zLXoT1dXZX0H5ghT
	/ebzS+B1NAV/1/3Ae150kBVznYQ4r5gQBZ4i9nkw3wOoHs5rbbv4q0mQnyHZu/C+ejNQ=
X-Gm-Gg: ASbGncsVWYrsrpy9iB5TYEZaAX+UK/8SeWQB7jg5oMiF0IBT0Xyq4FDUf9uLEE0UPJp
	E3LNeIGMom4Iuvii1wGO/0EcXfULeRVv1ei3a8biZ8zpGaREHN3geA8MKl9A4+OxFov9OGOaWBb
	GwVLVnZq0p0nuLMKqDFDiu68pUteF93trmdiklo0wdgh9+Ty3640xFRe0pij9GDgGHd1zm0ZnhD
	YDT3oPC3S5NAMey1jXN4QTHPkJDlXHpD+6WrWsEdmD1f8xrwpQ2uFnobGBA8MHmRvNfmYaQTtam
	PviaDd5+fTUuKyWqjrbUoo9AkjT/wjTz+eYWzBWnvcYiiA/lY5DnK22GTBkXMcUmVDLNo3zdB/y
	x752kGVzOa6VWvUYyl8TbK1uCkCqAGkcsb0PC4rJFIs8Br0dpA+X01wFDYoiCgi8t+g==
X-Received: by 2002:a17:902:e5cf:b0:297:f88a:c15d with SMTP id d9443c01a7336-29841097556mr20085025ad.10.1762861486127;
        Tue, 11 Nov 2025 03:44:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSpcUVI0Oxi4dBF1jiNdiLhSc8OBazrJzvb/OcOGmMaHiDiWNsCym4f/nDxoriQsjRvlF/MA==
X-Received: by 2002:a17:902:e5cf:b0:297:f88a:c15d with SMTP id d9443c01a7336-29841097556mr20084915ad.10.1762861485497;
        Tue, 11 Nov 2025 03:44:45 -0800 (PST)
Received: from [10.133.33.249] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c7409esm177939655ad.64.2025.11.11.03.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 03:44:45 -0800 (PST)
Message-ID: <507b121b-98c0-4632-8a61-e9d7a6a13a3e@oss.qualcomm.com>
Date: Tue, 11 Nov 2025 19:44:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] clk: qcom: rpmh: Add support for Kaanapali rpmh
 clocks
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, jingyi.wang@oss.qualcomm.com,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251030-gcc_kaanapali-v2-v2-0-a774a587af6f@oss.qualcomm.com>
 <20251030-gcc_kaanapali-v2-v2-4-a774a587af6f@oss.qualcomm.com>
 <swma6lyjfmyhl5ookdzvpjn5qresgsze5wptg45jfgj7ub6a4t@bdgfstw6gzoq>
Content-Language: en-US
From: "Aiqun(Maria) Yu" <aiqun.yu@oss.qualcomm.com>
In-Reply-To: <swma6lyjfmyhl5ookdzvpjn5qresgsze5wptg45jfgj7ub6a4t@bdgfstw6gzoq>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDA5MiBTYWx0ZWRfX0w+mXHY9ahIK
 BSZa3uYJntEpk2wihTfwcsGoi4kZQ/7BCwO8bjodC56V/bMYHfaSkfmzz7QwkCFFonhI0YFcZJ+
 yqyA4pZsPcqiZBOlqW2tNLHQe8clX/pO/QQx5jEml6eWEZ/JoGEtY8sIXLhipDZruZ0VThz9QcH
 9Tjk0AzIfUC+9MVQVilouMjHIuOAma3FOM3OT6Qc7s0TCe3qftm3t9BptC/i5eXF6W7EsIew2JO
 SgoirT2K3sJRR7Zlg0DZDhp4cr+Plt48mwubZnd04XFUBsDSRrwB4JPCO9ZRXsmhTk6bIDIsO7h
 cF7KxpU+4vXJABJeW1Dc/QaRx+H1TTE13FWSgs5dsKJeT5U7Xa5p1t9Og6dyuRymxFB+WdD+/8o
 HsD2R8ar0OfMpJTc0zxLb1e7PoNrgQ==
X-Authority-Analysis: v=2.4 cv=Vosuwu2n c=1 sm=1 tr=0 ts=691321af cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=lvgvr5Ydm3pkVxXdM2UA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: FKuPKW7N8XAu4VcSMabSaRq3Ndato8IC
X-Proofpoint-ORIG-GUID: FKuPKW7N8XAu4VcSMabSaRq3Ndato8IC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511110092

On 11/11/2025 6:46 PM, Dmitry Baryshkov wrote:
> On Thu, Oct 30, 2025 at 04:39:07PM +0530, Taniya Das wrote:
>> Add the RPMH clocks present in Kaanapali SoC.
>>
>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
>> ---
>>  drivers/clk/qcom/clk-rpmh.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 42 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
>> index 1a98b3a0c528c24b600326e6b951b2edb6dcadd7..fd0fe312a7f2830a27e6effc0c0bd905d9d5ebed 100644
>> --- a/drivers/clk/qcom/clk-rpmh.c
>> +++ b/drivers/clk/qcom/clk-rpmh.c
>> @@ -395,6 +395,19 @@ DEFINE_CLK_RPMH_VRM(clk4, _a, "C4A_E0", 1);
>>  DEFINE_CLK_RPMH_VRM(clk5, _a, "C5A_E0", 1);
>>  DEFINE_CLK_RPMH_VRM(clk8, _a, "C8A_E0", 1);
>>  
>> +DEFINE_CLK_RPMH_VRM(ln_bb_clk1, _a2_e0, "C6A_E0", 2);
>> +DEFINE_CLK_RPMH_VRM(ln_bb_clk2, _a2_e0, "C7A_E0", 2);
>> +DEFINE_CLK_RPMH_VRM(ln_bb_clk3, _a2_e0, "C8A_E0", 2);


Shall this suffix necessary to have e0?

>> +
>> +DEFINE_CLK_RPMH_VRM(rf_clk1, _a_e0, "C1A_E0", 1);
>> +DEFINE_CLK_RPMH_VRM(rf_clk2, _a_e0, "C2A_E0", 1);
> 
> What is the difference between these clocks and clk[3458] defined few
> lines above? Why are they named differently? If the other name is
> incorrect, please fix it.

Good shot. Only now I can understand the previous comments.
IMO for kaanapali Taniya was addressed to have the right rf_clkN naming
here.

I think the point is glymur is not using "rf_clkN" for rf_clk, sm8750 is
not using "ln_bb_clkN" instead it is using clkN:

static struct clk_hw *sm8750_rpmh_clocks[] = {
	[RPMH_CXO_CLK]		= &clk_rpmh_bi_tcxo_div2.hw,
	[RPMH_CXO_CLK_A]	= &clk_rpmh_bi_tcxo_div2_ao.hw,
	[RPMH_LN_BB_CLK1]	= &clk_rpmh_clk6_a2.hw,
	[RPMH_LN_BB_CLK1_A]	= &clk_rpmh_clk6_a2_ao.hw,
	[RPMH_LN_BB_CLK3]	= &clk_rpmh_clk8_a2.hw,
	[RPMH_LN_BB_CLK3_A]	= &clk_rpmh_clk8_a2_ao.hw,
	[RPMH_RF_CLK1]		= &clk_rpmh_rf_clk1_a.hw,
	[RPMH_RF_CLK1_A]	= &clk_rpmh_rf_clk1_a_ao.hw,
	[RPMH_RF_CLK2]		= &clk_rpmh_rf_clk2_a.hw,
	[RPMH_RF_CLK2_A]	= &clk_rpmh_rf_clk2_a_ao.hw,
	[RPMH_RF_CLK3]		= &clk_rpmh_rf_clk3_a2.hw,
	[RPMH_RF_CLK3_A]	= &clk_rpmh_rf_clk3_a2_ao.hw,
	[RPMH_IPA_CLK]		= &clk_rpmh_ipa.hw,
};
static struct clk_hw *glymur_rpmh_clocks[] = {
	[RPMH_CXO_CLK]		= &clk_rpmh_bi_tcxo_div2.hw,
	[RPMH_CXO_CLK_A]	= &clk_rpmh_bi_tcxo_div2_ao.hw,
	[RPMH_RF_CLK3]		= &clk_rpmh_clk3_a.hw,
	[RPMH_RF_CLK3_A]	= &clk_rpmh_clk3_a_ao.hw,
	[RPMH_RF_CLK4]		= &clk_rpmh_clk4_a.hw,
	[RPMH_RF_CLK4_A]	= &clk_rpmh_clk4_a_ao.hw,
	[RPMH_RF_CLK5]		= &clk_rpmh_clk5_a.hw,
	[RPMH_RF_CLK5_A]	= &clk_rpmh_clk5_a_ao.hw,
};

> 
>> +
>> +DEFINE_CLK_RPMH_VRM(rf_clk3, _a2_e0, "C3A_E0", 2);
>> +DEFINE_CLK_RPMH_VRM(rf_clk4, _a2_e0, "C4A_E0", 2);
>> +DEFINE_CLK_RPMH_VRM(rf_clk5, _a2_e0, "C5A_E0", 2);
>> +
>> +DEFINE_CLK_RPMH_VRM(div_clk1, _a4_e0, "C11A_E0", 4);
>> +
>>  DEFINE_CLK_RPMH_BCM(ce, "CE0");
>>  DEFINE_CLK_RPMH_BCM(hwkm, "HK0");
>>  DEFINE_CLK_RPMH_BCM(ipa, "IP0");
>> @@ -901,6 +914,34 @@ static const struct clk_rpmh_desc clk_rpmh_glymur = {
>>  	.num_clks = ARRAY_SIZE(glymur_rpmh_clocks),
>>  };
>>  
>> +static struct clk_hw *kaanapali_rpmh_clocks[] = {
>> +	[RPMH_CXO_CLK]		= &clk_rpmh_bi_tcxo_div2.hw,
>> +	[RPMH_CXO_CLK_A]	= &clk_rpmh_bi_tcxo_div2_ao.hw,
>> +	[RPMH_DIV_CLK1]		= &clk_rpmh_div_clk1_a4_e0.hw,
>> +	[RPMH_LN_BB_CLK1]	= &clk_rpmh_ln_bb_clk1_a2_e0.hw,
>> +	[RPMH_LN_BB_CLK1_A]	= &clk_rpmh_ln_bb_clk1_a2_e0_ao.hw,
>> +	[RPMH_LN_BB_CLK2]	= &clk_rpmh_ln_bb_clk2_a2_e0.hw,
>> +	[RPMH_LN_BB_CLK2_A]	= &clk_rpmh_ln_bb_clk2_a2_e0_ao.hw,
>> +	[RPMH_LN_BB_CLK3]	= &clk_rpmh_ln_bb_clk3_a2_e0.hw,
>> +	[RPMH_LN_BB_CLK3_A]	= &clk_rpmh_ln_bb_clk3_a2_e0_ao.hw,
>> +	[RPMH_RF_CLK1]		= &clk_rpmh_rf_clk1_a_e0.hw,
>> +	[RPMH_RF_CLK1_A]	= &clk_rpmh_rf_clk1_a_e0_ao.hw,
>> +	[RPMH_RF_CLK2]		= &clk_rpmh_rf_clk2_a_e0.hw,
>> +	[RPMH_RF_CLK2_A]	= &clk_rpmh_rf_clk2_a_e0_ao.hw,
>> +	[RPMH_RF_CLK3]		= &clk_rpmh_rf_clk3_a2_e0.hw,
>> +	[RPMH_RF_CLK3_A]	= &clk_rpmh_rf_clk3_a2_e0_ao.hw,
>> +	[RPMH_RF_CLK4]		= &clk_rpmh_rf_clk4_a2_e0.hw,
>> +	[RPMH_RF_CLK4]		= &clk_rpmh_rf_clk4_a2_e0_ao.hw,
>> +	[RPMH_RF_CLK5_A]	= &clk_rpmh_rf_clk5_a2_e0.hw,
>> +	[RPMH_RF_CLK5_A]	= &clk_rpmh_rf_clk5_a2_e0_ao.hw,
>> +	[RPMH_IPA_CLK]		= &clk_rpmh_ipa.hw,
>> +};
>> +
>> +static const struct clk_rpmh_desc clk_rpmh_kaanapali = {
>> +	.clks = kaanapali_rpmh_clocks,
>> +	.num_clks = ARRAY_SIZE(kaanapali_rpmh_clocks),
>> +};
>> +
>>  static struct clk_hw *of_clk_rpmh_hw_get(struct of_phandle_args *clkspec,
>>  					 void *data)
>>  {
>> @@ -991,6 +1032,7 @@ static int clk_rpmh_probe(struct platform_device *pdev)
>>  
>>  static const struct of_device_id clk_rpmh_match_table[] = {
>>  	{ .compatible = "qcom,glymur-rpmh-clk", .data = &clk_rpmh_glymur},
>> +	{ .compatible = "qcom,kaanapali-rpmh-clk", .data = &clk_rpmh_kaanapali},
>>  	{ .compatible = "qcom,milos-rpmh-clk", .data = &clk_rpmh_milos},
>>  	{ .compatible = "qcom,qcs615-rpmh-clk", .data = &clk_rpmh_qcs615},
>>  	{ .compatible = "qcom,qdu1000-rpmh-clk", .data = &clk_rpmh_qdu1000},
>>
>> -- 
>> 2.34.1
>>
> 

-- 
Thx and BRs,
Aiqun(Maria) Yu

