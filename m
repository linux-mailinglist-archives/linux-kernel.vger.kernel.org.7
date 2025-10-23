Return-Path: <linux-kernel+bounces-866275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D6FBFF5C5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 737E94E937B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1217285041;
	Thu, 23 Oct 2025 06:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kmw5L+rR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A550C25A2C2
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761201340; cv=none; b=eAmewHKe8nLBJG+168ZzK8rNRP0oGKiIYYpOFCTKitvCJIQBuDMRErumZseNae323hIToP5XJbWOrPH0TbDHy5T7utPC15t3wS4NkLUD88o9OmKGOzeu1zhkyeptYHOJEZWpUhYKtCcykqiUIP9i1uWlomzVQH/9UGXZ7gDj68Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761201340; c=relaxed/simple;
	bh=ff4ytZ3X3G+eW835i4qVj2PVGW3Z/piDZN+yFg/tVwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jowqWIACVjqcX+hmvppqCFQwHi20fY6DIdnJ7Z4WBjJOatyHReMmSqmIQVt+CrC5L01+X8UdWhXbZbAYTYKFq8J3bTCWPTmu3hrPCRuasqVROn19xj6yGlqkRykgWMrbDSNGJ4iQkTlQt8aONFl9i5EGF91FE5B8X7NgB+CtOi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kmw5L+rR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6AHgL016774
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:35:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JpAujb8k3aqNqpv+Pdjy+NX3D0D5Tr6/yV3o0vk301E=; b=kmw5L+rRYQQgUwq4
	gW3dBiDZNjrt4YvNppAIrk1i4msaa5nvXYyFm7iGx3dN1usWswcwng7BEHhBAmdM
	DDkAa8JUmQVIl1g+2I/cmZNTgH1JZNoPtI8nQ8NFrwTaAYZLiSEwISHICK5rJKAG
	lFtkd/GzvNygxcewjChWG9K+stVM6zcE6qdv8I2I1pPXvKFp5ceLWlOM1+Z9cJP8
	mx27W3vBGlAZiZgEcaXj10/LFa50htamnZmL5Fsz9VXWrOXvEg6CJBspbzOg/Gw8
	RCgGNrHDU80RSBUGOnrs7C6mp5bG/CYEZNg6vcvyn2JZzhRAMh2e1YVcs2rLBvz9
	3rksdw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xhe0n67k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:35:37 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76e2eb787f2so448495b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 23:35:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761201336; x=1761806136;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JpAujb8k3aqNqpv+Pdjy+NX3D0D5Tr6/yV3o0vk301E=;
        b=V2wT8k/2OoQYUvzsQmJUnHp+GeUX1pSSByRxB+G8X2Pk0m6e1frsrwUjjnvO5hbEBt
         eHD/f+bC5gp/B6WhDth2QU3+lxu5Uhg7EOH/y34hzSiIzLTemoaGw+0tBScZz1RncIyd
         HmD8J4PrVowCU78EIDUiPE6SH1XNNvwGcWHKg3Q7npbn2bJCSG3L3PCmKydwAYecBOXo
         WW4SPHmlmQyarCac3QTv2chpoEV19Tj5Y3NC6XqlBw+pL8/eoKcKaowKYw+ofuN0Vfly
         yGY9pCxup1uAg8UgdWKRhPRikc0JkZcHvNh7Sbw9XRAqINMXq2GcoXi2w2u4HAhppJYd
         KgaA==
X-Forwarded-Encrypted: i=1; AJvYcCWnbmB5u9pykZJOi7QHIKNHK9coRyhA04APqu3SV3ODoF6dBMUj9LvNdsIo5fKBLJOaBVMdgJyxD2MZ3Jw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Z218QHmVhdbInMDxRXi5U+sxSCuri1gTSNJXxp6DyPGa6rOO
	VC2Jt/W4+1Ep2iM2QXkNEumV+o1olJd1gEkmMtExLarKZJS49pOMGTeINOEQk1KEmFJCBqaiToJ
	fuzTzM5B8eldukQbrYoIaLbY38qWuez5toHM3eWpnSqXNJEWqRnIxbrdVZHI3iLlamM0=
X-Gm-Gg: ASbGncs1KYQFNSw7vah2/XzWNm74H1ceHxqi2esnDcBiFYCdJ5Ed9LnGG1xrowVEJsA
	9JBwV/DrT6KtJAiqRv8vyspEVV3i+9Rxg3mCB1Yn+KfGCCNulOmxNvSu7Tcn3Q2dKHMbA3ML7/G
	zE0ZQkGQRtGc3TySJxsRAUyD+0V7Cq55OlJRCTAIZrbZEQikuVwK6TfnqvlYlNVv+R+EuVDS9in
	lwxpMW30UeLjCiN4IZV++gW+FYxH3/8AJzGN+nxG3kqYorCnlxVCH/3gPxR/KHjR62X1ftZ+buI
	/lWHZkSxyBGfSReVZp1QF2fHVa9r+10K5mMRqI7OAw07VEXTew4Rakt/oY/VRGE+KoCNybCWifn
	T5GtHYnoXFc6+lKRxKanraB5h60A=
X-Received: by 2002:a05:6a00:4099:b0:7a2:23cd:418c with SMTP id d2e1a72fcca58-7a223cd42b2mr24458046b3a.3.1761201336147;
        Wed, 22 Oct 2025 23:35:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqgjoOyq6fjU6mL6BfXgOkMCX6FeequRl8KVaAdKGfOEZukeMq3sizCU9wMfGDVahdPfUBNQ==
X-Received: by 2002:a05:6a00:4099:b0:7a2:23cd:418c with SMTP id d2e1a72fcca58-7a223cd42b2mr24458024b3a.3.1761201335575;
        Wed, 22 Oct 2025 23:35:35 -0700 (PDT)
Received: from [10.217.217.147] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274dba7c7sm1367091b3a.69.2025.10.22.23.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 23:35:35 -0700 (PDT)
Message-ID: <09e0b94c-2bf6-4147-a831-d3b0724fc418@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 12:05:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] clk: qcom: rpmh: Add support for Kaanapali rpmh
 clocks
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
 <20250924-knp-clk-v1-4-29b02b818782@oss.qualcomm.com>
 <thy7r7my2i3gfuy723rrq36k7hjobzqcnlzbggpagg4fgfvvzg@g5wzzxoppja5>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <thy7r7my2i3gfuy723rrq36k7hjobzqcnlzbggpagg4fgfvvzg@g5wzzxoppja5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE2NyBTYWx0ZWRfX+rxYsJ8sFjHy
 3wa4K3G5DllgZPRnq72qH6r4QWwKkalPnGjp9p3liPijz8zdMIlHD+9sgZHRfLOYtikG3a3tmNl
 /xs93ZqCYJmyU4q2ItJg4ARO57Ny9R2yCR+g8V7gukVWH4/GdTDw/NVNzFyd/APrJTFgizdUnki
 F8akbZV5/WvqFucEuZeIRbQ695DAXTS3BiZ17VdSfUYNxex5y/Bs8tks7ES84zomvWxN3+eNLg3
 LhQP3B+7+uwE/doDsdNWNEWCyKhQts/CXJtPn4iyR1FMR5Goh3uRRbGqpreRW0fjK+H6cEXBTUl
 dhG/vn3xq1sPL4hvfdF/UmI9W6Y8xQA8KCqjmqYo/edGJXhRyIRxJ0WySXtzusAC+TVLeMP7OKG
 gh4VO2ujzcCw0xVwmAdssp8+txBDYA==
X-Proofpoint-ORIG-GUID: svx0GteSsdj4JhCyRERu5luwgU75QV6I
X-Authority-Analysis: v=2.4 cv=WYUBqkhX c=1 sm=1 tr=0 ts=68f9ccb9 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=QqeVPp7IqxZMZk5Gz7sA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: svx0GteSsdj4JhCyRERu5luwgU75QV6I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510210167



On 10/20/2025 4:29 PM, Dmitry Baryshkov wrote:
> On Wed, Sep 24, 2025 at 03:58:56PM -0700, Jingyi Wang wrote:
>> From: Taniya Das <taniya.das@oss.qualcomm.com>
>>
>> Add the RPMH clocks present in Kaanapali SoC.
>>
>> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>> ---
>>  drivers/clk/qcom/clk-rpmh.c | 39 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
>> index 63c38cb47bc4..6b1f24ee66d5 100644
>> --- a/drivers/clk/qcom/clk-rpmh.c
>> +++ b/drivers/clk/qcom/clk-rpmh.c
>> @@ -395,6 +395,16 @@ DEFINE_CLK_RPMH_VRM(clk4, _a, "C4A_E0", 1);
>>  DEFINE_CLK_RPMH_VRM(clk5, _a, "C5A_E0", 1);
>>  DEFINE_CLK_RPMH_VRM(clk8, _a, "C8A_E0", 1);
>>  
>> +DEFINE_CLK_RPMH_VRM(c1a_e0, _a, "C1A_E0", 1);
>> +DEFINE_CLK_RPMH_VRM(c2a_e0, _a, "C2A_E0", 1);
> 
> No. Please make sure that you follow what others have done.
> 
> Why are these clocks named differently from clkN defined above?

Sure, I will go back and reuse the clkN definitions.

> 
>> +DEFINE_CLK_RPMH_VRM(c3a_e0, _a2, "C3A_E0", 2);
>> +DEFINE_CLK_RPMH_VRM(c4a_e0, _a2, "C4A_E0", 2);
>> +DEFINE_CLK_RPMH_VRM(c5a_e0, _a2, "C5A_E0", 2);
>> +DEFINE_CLK_RPMH_VRM(c6a_e0, _a2, "C6A_E0", 2);
>> +DEFINE_CLK_RPMH_VRM(c7a_e0, _a2, "C7A_E0", 2);
>> +DEFINE_CLK_RPMH_VRM(c8a_e0, _a2, "C8A_E0", 2);
> 
> And these should use the same pattern. If the old names are unsuitable
> because of the clash between clock names, you can rename them. But
> please, be consistent.
> 


Sure, Dmitry, will make the changes.

>> +DEFINE_CLK_RPMH_VRM(c11a_e0, _a4, "C11A_E0", 4);
> 
>> +
>>  DEFINE_CLK_RPMH_BCM(ce, "CE0");
>>  DEFINE_CLK_RPMH_BCM(hwkm, "HK0");
>>  DEFINE_CLK_RPMH_BCM(ipa, "IP0");
>> @@ -900,6 +910,34 @@ static const struct clk_rpmh_desc clk_rpmh_glymur = {
>>  	.num_clks = ARRAY_SIZE(glymur_rpmh_clocks),
>>  };
>>  
>> +static struct clk_hw *kaanapali_rpmh_clocks[] = {
>> +	[RPMH_CXO_CLK]		= &clk_rpmh_bi_tcxo_div2.hw,
>> +	[RPMH_CXO_CLK_A]	= &clk_rpmh_bi_tcxo_div2_ao.hw,
>> +	[RPMH_DIV_CLK1]		= &clk_rpmh_c11a_e0_a4.hw,
>> +	[RPMH_LN_BB_CLK1]	= &clk_rpmh_c6a_e0_a2.hw,
>> +	[RPMH_LN_BB_CLK1_A]	= &clk_rpmh_c6a_e0_a2_ao.hw,
>> +	[RPMH_LN_BB_CLK2]	= &clk_rpmh_c7a_e0_a2.hw,
>> +	[RPMH_LN_BB_CLK2_A]	= &clk_rpmh_c7a_e0_a2_ao.hw,
>> +	[RPMH_LN_BB_CLK3]	= &clk_rpmh_c8a_e0_a2.hw,
>     -I$(KERNEL_ROOT)                            \
>> +	[RPMH_LN_BB_CLK3_A]	= &clk_rpmh_c8a_e0_a2_ao.hw,
>> +	[RPMH_RF_CLK1]		= &clk_rpmh_c1a_e0_a.hw,
>> +	[RPMH_RF_CLK1_A]	= &clk_rpmh_c1a_e0_a_ao.hw,
>> +	[RPMH_RF_CLK2]		= &clk_rpmh_c2a_e0_a.hw,
>> +	[RPMH_RF_CLK2_A]	= &clk_rpmh_c2a_e0_a_ao.hw,
>> +	[RPMH_RF_CLK3]		= &clk_rpmh_c3a_e0_a2.hw,
>> +	[RPMH_RF_CLK3_A]	= &clk_rpmh_c3a_e0_a2_ao.hw,
>> +	[RPMH_RF_CLK4]		= &clk_rpmh_c4a_e0_a2.hw,
>> +	[RPMH_RF_CLK4]		= &clk_rpmh_c4a_e0_a2.hw,
>> +	[RPMH_RF_CLK5_A]	= &clk_rpmh_c5a_e0_a2_ao.hw,
>> +	[RPMH_RF_CLK5_A]	= &clk_rpmh_c5a_e0_a2_ao.hw,
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
>> @@ -990,6 +1028,7 @@ static int clk_rpmh_probe(struct platform_device *pdev)
>>  
>>  static const struct of_device_id clk_rpmh_match_table[] = {
>>  	{ .compatible = "qcom,glymur-rpmh-clk", .data = &clk_rpmh_glymur},
>> +	{ .compatible = "qcom,kaanapali-rpmh-clk", .data = &clk_rpmh_kaanapali},
>>  	{ .compatible = "qcom,milos-rpmh-clk", .data = &clk_rpmh_milos},
>>  	{ .compatible = "qcom,qcs615-rpmh-clk", .data = &clk_rpmh_qcs615},
>>  	{ .compatible = "qcom,qdu1000-rpmh-clk", .data = &clk_rpmh_qdu1000},
>>
>> -- 
>> 2.25.1
>>
> 

-- 
Thanks,
Taniya Das


