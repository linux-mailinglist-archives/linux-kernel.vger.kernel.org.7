Return-Path: <linux-kernel+bounces-755105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADE4B1A158
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32EAF620C43
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 12:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11C1258CF0;
	Mon,  4 Aug 2025 12:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S+dEfGu+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310BE15DBC1
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 12:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754310286; cv=none; b=onR9TJkV0w/Cva4KD06ytqdD4ITbj3hiXJYpAN3n5pNSmYZTkFq+snCinHj2AYItfPZhGa1TQHZFTaog7vpPSvsnzHK2WqYjRodG7ZiDr8tFwkyK12GPXbPygKTbh4Qz131DfosGdwm6WM3GBNRJEuDsPVLiKB4uPvB69H/aPxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754310286; c=relaxed/simple;
	bh=X6OB+y3v7wjXgZyMvUtX1QmaETTwv0OrP/MFdJ4tRaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=saltCuO4eqeTGCuSuZrrMDoedWqbDQmuP57o1sd5AyOdA1MaRzGsh2plff4/DcNqx/sACp5yi9hRX9YPHdfvaByKlk24r8RMtXTJ11jh70L8bFePISdjJHmRZMCrTT+aB+aAq8e0cHcE2LuqOFB/XG4VJXOWZGEWYExUfTMdc7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S+dEfGu+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5749G90x023370
	for <linux-kernel@vger.kernel.org>; Mon, 4 Aug 2025 12:24:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V7q+KzrML4Aj2hTJom5AvJd1j16yraW+cQX6AncDhrc=; b=S+dEfGu+Xvo2PSL8
	sx++OpYqhWZhQYK2w+Jt7kWzii0uNuWEIaGCZLJvn2m0YJ9LhsIPyrr95b7NPlY8
	fcsr7jL6N9Un/DKhPN8pCT/WP/Rv6YMnwHMLzkSL8X1DovWhHMAsM6tPPWeFOftU
	e3AN+MIHk1VpfVDU0BHeSeml0fjNgt/jn5uX3cADrXjrAzqMG37r/P2xxdgQOpOg
	tHVLDuLtJPVTtkGJqNd2kpadPzTpXKN8/eayVmh6i5ArjhfiQCAUy54Y19WbNZjU
	aRNhGD184na1y6nTdwyxFp4Bab1tdENR7VGvTvAwpo8wWy29ZTWFiU5MumNPcc6x
	0ZbG7g==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489a0m4vfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 12:24:42 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7092a001573so11000956d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 05:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754310282; x=1754915082;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V7q+KzrML4Aj2hTJom5AvJd1j16yraW+cQX6AncDhrc=;
        b=EMA2tbQUlaLWw+iCeWPm6rnX6tjBXmDYorOZoDFJKNx0+dx1jH5MvQdLJXNu+uSXg4
         u3ey4UQ+XxDynqvuuywE0R9SQy2wHc7Wx2Q86vY/B6bfLYPLTfsSQBSA/swn4UqqJsVr
         u8llGIiRSFldSaaf58EZ+eXLQboU5llMQH9rvVHBYudgomtPvGkQYE25zPx5fmgc3kPE
         s7oEO5nUGtOWa+JtddSZNDkm3/kPRX8D59dIQC8/EF1FdfIZZbejSLVQsQx1d83KMv6A
         4T3aFYVIWbRx4c9RYFo8oXTG1XRS6zzDv21D4NGo1sHw/jOGDyHtl/mX4W+AwaKdWssV
         wWwA==
X-Forwarded-Encrypted: i=1; AJvYcCVPH5IBIjr76Lu2QsSr20ecMsKvsVvQ+6Dy3aKFmMZslOAdycbcKxRwP8wxSc7FU53JdpeOnF6eRaG5Uxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4kNkpM351BxwM/o/lenlN10MyqIWpRUUTOylZEHa7tU6HjObn
	EVXwkJlGxQe8WeVIrj50qCj6vdCiXiTt8yCs7BNjwsb0oflw5BGWKMcUTBY7AWYKFoXT/AJi2dD
	zVNeDnUmRv7cqLukA2rmoT4n/Ioj9UATMuKczgd2ORSVj9dibtIDT+lygRqnKNZHD7lU=
X-Gm-Gg: ASbGncsSbVtfNXjcb2Y5d45mzUowc4A2e37o6bGjVSGgJqbeRTQEGdkej79UYrOjGqK
	HZn+1PPbdTehss+xvXrKB9YQ5fvnYw8D9pfq7xOYCht0qDuCh9faQjdZH+Z/Y/1dg6kamD1wTBs
	Cc08ZO74+j0WC8soOTqZ0n+RUoS+yEGdBl8f75Uo2kKQfJqR8B/c2q9Lsy4S4u9gNGw8gjnCTAO
	0FwTvcOENFbJL91bQprabbygHXQptmD9rQMTJXC8LdtC/tRK/l10zgS0V8p3mQGpmk2EoMsp9Tc
	LVyjPLir0O4a19Lg/vjbHuZdRiWz/OOMou0+nZ/PIX4DYdhBMaWSB7y6rQLG8X7ycVishlWfvFp
	WguNRL1C3NFXgy70LrA==
X-Received: by 2002:a05:620a:3705:b0:7e6:81d9:359a with SMTP id af79cd13be357-7e696361fc9mr598166885a.9.1754310281996;
        Mon, 04 Aug 2025 05:24:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmi/HcIwoXXkI8woIdhi4ceFmLxFr8bFlUqDHXyyyLGKaBXdFINx4NRwp0ys6ezcnFAInnrw==
X-Received: by 2002:a05:620a:3705:b0:7e6:81d9:359a with SMTP id af79cd13be357-7e696361fc9mr598164285a.9.1754310281537;
        Mon, 04 Aug 2025 05:24:41 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0763d8sm736128266b.2.2025.08.04.05.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 05:24:41 -0700 (PDT)
Message-ID: <93fc49a1-ce8f-447a-9208-251e74d4bf88@oss.qualcomm.com>
Date: Mon, 4 Aug 2025 14:24:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] clk: qcom: apss-ipq5424: Add ipq5424 apss clock
 controller
To: Varadarajan Narayanan <quic_varada@quicinc.com>, andersson@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org, ilia.lin@kernel.org,
        djakov@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Md Sadre Alam <quic_mdalam@quicinc.com>
References: <20250804112041.845135-1-quic_varada@quicinc.com>
 <20250804112041.845135-3-quic_varada@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250804112041.845135-3-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=JOM7s9Kb c=1 sm=1 tr=0 ts=6890a68a cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=276k8YKwey--yEOqDJUA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: UyzHMAI3Sdn-ADRz7DCgz716ALyh0zUI
X-Proofpoint-ORIG-GUID: UyzHMAI3Sdn-ADRz7DCgz716ALyh0zUI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA2OCBTYWx0ZWRfXxE5kovexmVkb
 SVvFpw/QECH9ZPymwLzwERdo3lXkT5Atf/iuDUftJdZA1AQ18DrpOr7JU7u7qbIh0YU8NI1WGVP
 eJ0Uwhihwws0PCZRCX4E/7kVnpeNXEKYtLCXJ7hjRYyEAgbocRqE5UFAmQCdGfwcqSbIMTYr7v5
 hVb/qNIgFFNeVbup9Wn6gZVBbBwelcetNNNfEQv/YTFf/isdMNHYSCJH0PigS0OOwNSGDlaDYVp
 9aHkcE4mtL5D2DRHaEJDxKoad2PAYj5CMeDim/rq247vJKII8eAK7Bo088h8RvufZxXpLkG8mjH
 v+qm3BM66gUXxDWK3I4GukFSLBrz3l5wNNMEA2CGFgkWfloT9O8WHAZrWo4y3fEMm5b99FVhziC
 rjTP/cPZEaLXV2xrNKANKaYh4NteaWVP9w8UT718Atgv+qMQXoc1La8rBZInd9HbeEbjrHB/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040068

On 8/4/25 1:20 PM, Varadarajan Narayanan wrote:
> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> 
> CPU on Qualcomm ipq5424 is clocked by huayra PLL with RCG support.
> Add support for the APSS PLL, RCG and clock enable for ipq5424.
> The PLL, RCG register space are clubbed. Hence adding new APSS driver
> for both PLL and RCG/CBC control. Also the L3 cache has a separate pll
> and needs to be scaled along with the CPU and is modeled as an ICC clock.
> 
> Co-developed-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> [ Removed clock notifier, moved L3 pll to icc-clk, used existing
> alpha pll structure ]
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---

[...]

> +static struct clk_alpha_pll ipq5424_apss_pll = {
> +	.offset = 0x0,
> +	.config = &apss_pll_config,
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_HUAYRA_2290],
> +	.flags = SUPPORTS_DYNAMIC_UPDATE,
> +	.clkr = {
> +		.enable_reg = 0x0,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "apss_pll",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.index = DT_XO,
> +			},
> +			.parent_names = (const char *[]){ "xo-board-clk"},

Parent_data and parent_names are mutually exclusive

[...]

> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_huayra_ops,
> +		},
> +	},
> +};
> +
> +static const struct clk_parent_data parents_apss_silver_clk_src[] = {
> +	{ .index = DT_XO },
> +	{ .index = DT_CLK_REF },
> +	{ .hw = &ipq5424_apss_pll.clkr.hw },
> +};

You use indices here /\

[...]

But not here \/


> +static struct clk_alpha_pll ipq5424_l3_pll = {
> +	.offset = 0x10000,
> +	.config = &l3_pll_config,
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_HUAYRA_2290],
> +	.flags = SUPPORTS_DYNAMIC_UPDATE,
> +	.clkr = {
> +		.enable_reg = 0x0,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "l3_pll",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.fw_name = "xo-board-clk",
> +			},
> +			.parent_names = (const char *[]){ "xo-board-clk"},
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_huayra_ops,
> +		},
> +	},
> +};
> +
> +static const struct clk_parent_data parents_l3_clk_src[] = {
> +	{ .fw_name = "xo-board-clk" },
> +	{ .fw_name = "clk_ref" },
> +	{ .hw = &ipq5424_l3_pll.clkr.hw },
> +};

[...]

> +		.hw.init = &(struct clk_init_data){
> +			.name = "l3_clk",
> +			.parent_hws = (const struct clk_hw *[]){

"clk_hw *[]) {"

Konrad

