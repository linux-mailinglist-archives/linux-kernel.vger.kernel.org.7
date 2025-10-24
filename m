Return-Path: <linux-kernel+bounces-868415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC1CC051A0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 24895359071
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9AC308F0B;
	Fri, 24 Oct 2025 08:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LZqMlZqg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D6F3081D4
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761295161; cv=none; b=KkUaMyQb1NW5UHY3oEE33kOFSyY95NFhjCcs7kqBUOIj3hhNkCnIImPhX60eOnd7BuJSx9HzsfIoounwHI6NaQk1iotOYL2hlvTL/86VTnO6DrJtsCx66+b/+xi8grXWcTTwYNSGl5fba6qwGCqlnPbBaNVTgq0kRuSOXyRVL6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761295161; c=relaxed/simple;
	bh=uopKghKQJQC+vDU7zK18VSdaclR1gXuEayi1yBzX8Pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AMS/bz0BKpJodLGqG2hNzUxUfzVOMXouix1lLG0DO3oNZ5VE26riAp75iuDPQsSV92PKuKJgDlh6ArTC4YzwISDxK5DuE92GxWl/wxMixZjCa4ng9h0TQQILUweRVmnszcrQwnloHBvYCcvu+ygtyMYXgD8srXy3nTm0pRpxbRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LZqMlZqg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3FpWV003822
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:39:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mP156TZe01h9/msLZKaMsMU3teKXdisSYTct+iW2lOg=; b=LZqMlZqgyZDjhJTD
	5xG5l6Eubl9O4gA0EBsxv37EcBa6ly+orSWj/pIRgF6N6WLc786JImiQ1a9vA66I
	2MRQT4GDMsKyI9yA+pJMVYE7O90Uo4GoTbbnNDOSOKxxdTsqy608SAiHOB4fgVa8
	mO7J799Fb+uIBu5h9hJ9EMIq7t4QRYcDeKsmTjsXmC88X04IG3Pjujw1FLoIbsUa
	32m9VQDfk1xgm1XNW4qNP1odHhQjIZqCwBZgPmv51u0KYMu+uvp6iwsm4XYN/1EK
	hS3UYoiBqUK1X40P35wUJLLoCmiL8/1goP4Y/XYWM5XrfqPxcuKGxD6Fe8TlN3lP
	1y+fzQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v27jb9qy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:39:17 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-87c0e043c87so4606526d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761295157; x=1761899957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mP156TZe01h9/msLZKaMsMU3teKXdisSYTct+iW2lOg=;
        b=RiH6nmPl0PRnA3Pdoz2BawGkMxL87Yf8k2/ySjM2wUdXHaykHxhtQgaQXYwMpsqcL+
         L4eYDvm3l60n4S5pvbLLog96+tw5AskfI1xEywHH6njnKuzVhwzJNbGMvn1Om1/GxiBD
         Q+y0vmIy5WYkC9rdssQkBUyNjIYIq7WDDaQpvZH70qPujL4t2Q9E1pOHHRp2RHkdR8Vj
         CFlU/+azRFmF7He1/6DK/UTa2J8Sv86C3hbfwDQ1/O+sjFZhJovxT75ECUy0EZ/OEBYE
         v63oo7aXpC/oWvcIUaZXZSQ5BVMNz8Sl9kLXw2DA/AANsTf+c5PN5mfa6kOn62oC7leB
         lr4g==
X-Forwarded-Encrypted: i=1; AJvYcCUCsfOkU+oCz0NuVv1DIUq5PvildfSqqSwGhlbhreu03YAsEiBNuLIG8ElMT8GJ851Zg/EotVCr8aRBv7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpJUIRdYqHXBO1ElfNJs2Em92Zx/3sQu932ZeDP9Nyd1yr/xej
	75eP5RjJhnP6u+5m/OuwGINQVLuMHCJlhkQsK1KS4z2Tlim/+4diuqNoh4BD30g8km81bGa8K3N
	VA7AlFdugA89lFm31CGX1tKdvc5MYKdSyem057zyJLMk2QJ7f2FLWKCSTzM+Jsd25wfA=
X-Gm-Gg: ASbGnctvTtonWujspe1sTD+Wggp3hLPh0h74oKYlZIKkOsZ6b4dCOogf0+/Ho0DrPhF
	GrF4/ZGu1pmQXocrv49OYj/GPoMKYKJj82R/ck5OFMEqz/KxySsW3GnNmu+w4p8A3f3J4gct2SN
	3sIQ96tbJ5Cl+uGUfaU96YkhpPT5Kwce1nJ/eTbCZ0mrtuVqFF+76XOulSdDTZjUGlMSXKjJFVP
	XGpsHO5xjkggZGKfFjQ9CQuBFHioKC+MSnNxSMFSTikttugXa5cli0PT4x+0dNNxaoWVl9/my2A
	wie9NuxcxzIyt0Rm2yIXXVI9m+qxnHG2V7wrjl4XhPxfq9ju7yMVlneLGVW0EcOHFCQ1pOcgBHk
	gz/rcnxXBHoMfKoSOQZFD6Y8jx7T1ldVoHPl+UEEADpTuPMvl0tZNYXeG
X-Received: by 2002:a05:6214:f05:b0:81f:3abf:dc1f with SMTP id 6a1803df08f44-87c206aa6f8mr219047656d6.8.1761295156976;
        Fri, 24 Oct 2025 01:39:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOrOr8mjjpJmal/kAMyGTYRQL+8CiGnozYYDyOe6Y1EwTvskD2SQQMA7irtDBZeKIs5gIx/A==
X-Received: by 2002:a05:6214:f05:b0:81f:3abf:dc1f with SMTP id 6a1803df08f44-87c206aa6f8mr219047526d6.8.1761295156545;
        Fri, 24 Oct 2025 01:39:16 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e3ebb3848sm4107106a12.1.2025.10.24.01.39.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 01:39:16 -0700 (PDT)
Message-ID: <fbab492a-e279-4ab1-91ad-2b4000f7229a@oss.qualcomm.com>
Date: Fri, 24 Oct 2025 10:39:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] clk: qcom: branch: Extend invert logic for branch2
 mem clocks
To: Taniya Das <taniya.das@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
References: <20251024-sm8750-videocc-v2-v3-0-6286bbda3c8e@oss.qualcomm.com>
 <20251024-sm8750-videocc-v2-v3-1-6286bbda3c8e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251024-sm8750-videocc-v2-v3-1-6286bbda3c8e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxOCBTYWx0ZWRfXzV0s4RKK19MZ
 9RuQCDgYV4Kd4QZYXh1ITs33+HRgTc3mvnHoTbge1KN9IqqS/aQ7OfcbRbsdUQfBK2JfCHhrzo9
 7St74w9NnRK2Dp+X/rYnkY/NpvFW968rhoWsnvdh/0MnSk5wiyZGDbjpouzsnL3TpyHubt0ySvp
 gkkUw3/2EKq/h/lUhuKAby5t9pskoVeq1XWy2yvw7JqCI9agRHTKbwtv/aBgqc9gvLsQgIBfHeQ
 RadA2V79BILmb0J670FD/I8Mm10xlIxqoBJARyDIIjsc6ESt8sKo8Xdf9rRhbhZIcQsHad7/Syq
 6Kw31cGC6dL+F0YQA8JhntrnG33tfjuQIaZCCKc76gWRg3EWuSswJKFulIQccO5e+gd3ZnqjpTJ
 g981DJe4C1E8BMPfyQ8mornadnKSJw==
X-Authority-Analysis: v=2.4 cv=G4UR0tk5 c=1 sm=1 tr=0 ts=68fb3b35 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Uv4cyzw5Fqc3vRoc6LAA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: BLLhTiquMAcSQUDt4yn3dIIrCjtB92x7
X-Proofpoint-ORIG-GUID: BLLhTiquMAcSQUDt4yn3dIIrCjtB92x7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180018

On 10/24/25 6:24 AM, Taniya Das wrote:
> Some clock branches require inverted logic for memory gating, where
> disabling the memory involves setting a bit and enabling it involves
> clearing the same bit. This behavior differs from the standard approach
> memory branch clocks ops where enabling typically sets the bit.
> 
> Introducing the mem_enable_invert to allow conditional handling of
> these sequences of the inverted control logic for memory operations
> required on those memory clock branches.
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/clk-branch.c | 10 ++++++----
>  drivers/clk/qcom/clk-branch.h |  4 ++++
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clk-branch.c b/drivers/clk/qcom/clk-branch.c
> index 0f10090d4ae681babbdbbb1b6c68ffe77af7a784..4094ffc53d0c91dfa9e4263134c3a996100ad078 100644
> --- a/drivers/clk/qcom/clk-branch.c
> +++ b/drivers/clk/qcom/clk-branch.c
> @@ -141,9 +141,10 @@ static int clk_branch2_mem_enable(struct clk_hw *hw)
>  	struct clk_branch branch = mem_br->branch;
>  	u32 val;
>  	int ret;
> +	bool en_val = (mem_br->mem_enable_invert ? false : true);

" = !mem_br->mem_enable_invert"
>  
> -	regmap_update_bits(branch.clkr.regmap, mem_br->mem_enable_reg,
> -			   mem_br->mem_enable_ack_mask, mem_br->mem_enable_ack_mask);
> +	regmap_assign_bits(branch.clkr.regmap, mem_br->mem_enable_reg,
> +						mem_br->mem_enable_mask, en_val);
>  
>  	ret = regmap_read_poll_timeout(branch.clkr.regmap, mem_br->mem_ack_reg,
>  				       val, val & mem_br->mem_enable_ack_mask, 0, 200);
> @@ -158,9 +159,10 @@ static int clk_branch2_mem_enable(struct clk_hw *hw)
>  static void clk_branch2_mem_disable(struct clk_hw *hw)
>  {
>  	struct clk_mem_branch *mem_br = to_clk_mem_branch(hw);
> +	bool en_val = (mem_br->mem_enable_invert ? true : false);

This value is a boolean already, you can inline it below

Konrad

