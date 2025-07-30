Return-Path: <linux-kernel+bounces-750491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0402B15C2F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0F6C541244
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6523C277013;
	Wed, 30 Jul 2025 09:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GAbYsTCt"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3CA26D4F9
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753868366; cv=none; b=HKFzdWdxiad4Aw+BRhdcRxenhODTVy49J3ambVFi3FzwPvAzRfNNsxY+7iE9G1oK3gzOJm3nvj8NZG6q4kXz29SkWTRtmJG/7hOVEGefyJBDjz5uhEFn9442XdmrIueM6bpDGZVldRHRoMl3Sesr0rRq/e3Y1S+yDG1czS5mHrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753868366; c=relaxed/simple;
	bh=FFwMpkhOYSBmnp5I4Qk19pzDCl+8/KeHG7bi2vq6ggY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nnWSIYt10FGyKkqYYFSq/MnOmemGrV41bTG/Dj8Ilb1LHaTXZVv2uXsdxfgoOmnilY4gYdeKMfdHoTwwIPWS+qzSghzDlWr37jwezEORClNII03WjsfHbPF8mhJtabfpaF2qOhvBDBfGSoQio9x/Z5S4s5md4Ky1dUm3bmfdBRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GAbYsTCt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56U5fJqU023593
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M4xxlIsUwBSemAmhdAK1Q9uezrhoKQ5cmwiav1SEhOQ=; b=GAbYsTCtbk/iLWdk
	p9LGJXfinV82t7J8kW6q+nZwKb3xfKmiiefeLdA6mXmsCzmN0qjzindinnEl5JzB
	lNzKpZR19fPOsG5/kTBsr9kT5b0PMDXh6Uorula6Z8SoFRzQl5c3Oj11Z+FT/BbV
	goToaiTtMBpjyGcy7VVO2xyPDiI4SwE8iwflU8VatxUbkHJpexyjRND5YZ7IZGBd
	xs4bLAyq67DEtTS/3sIZ2UO7CcJgfulQd4/Gvwl6JHejrkFo2P0qswVDKT41NHXl
	tebtiTkBC81TlG9sWscvwz/SlrBJmiVvQEKARC9Epx80JTI0t9qqo8gHieyOoVo5
	RPjtXw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484r6qu7rs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:39:24 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ab716c33cdso29805321cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 02:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753868363; x=1754473163;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M4xxlIsUwBSemAmhdAK1Q9uezrhoKQ5cmwiav1SEhOQ=;
        b=lnM34GUGwuGewnDgWbS59NlvdGUazG8tqtpX0y0CxmMxdmJptTSX6nXah/ldpCz58B
         xqc99Nx1YohrXqwRMTeKakUPcLjHCEifcUIpfWivYuYgLU2GiWTdy23+ojV6pTBfHWD7
         CMAcOK13g5duC+aNzUm84bNfDkC12Y4pe+uKaxq0SjTA2b6NL59O7J33cmw9i3gE71ih
         sOSMcpPHnHfcLmSx3r88cfl2n9eeCI3EUKl2s7WdBAkL5cNse2POphwTw9Hmd6tv00fS
         4v/pxwmDIFLKK6tLJxtpOJ3scVK6aNee7V/7wULm/D9msRxDfRypC0gASPKGAFpdebA8
         Auag==
X-Forwarded-Encrypted: i=1; AJvYcCXUjpe51J4b8EbBzXQ8tA1TLVBTnwCycKeiCanIS5w2SJjmyIsvW1ujDQNXnU34HctrrWoO+gkcl9EEJ0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJAnMEb6ojVb3aCl1P0lqt7f9zxRMJ6UlCTntkDTbBGxvoC2T3
	R/MzS1zXiCAaiUqCb85p1YTCE0zHSpGeNi/soNAie3AAeGMO4xFDSKMtW/sF9VBOqbotdXht4Qp
	aPRgl7yce3EKfVv3GjdRUeaxfIEefAa+esaB4XkQnFbnFRPT9YwN8Ea3XKs0Xk95d9sU=
X-Gm-Gg: ASbGncsoxbNUIrs0uSx0wjKTO7Y5WAJjIT8kDoadC7EeJPGc0ZJEe6BoX6e9VhCyiuS
	rDST/LE4BAJv3CTPYpSTT01DTy3Xjf55S1MZ2eJuPM3Zrsrf9rn2IAMILaKNswGpOo2LJ+kiKoi
	WxGXCY9pCCikDKV0hg+wI9TAXZM9mBuwIFhPT/+mticxs/IYMeJdNDXyDpWZ8R6fSNCSZDK5gOe
	/wHWuBHXfvnNN1NJrMEDR3sCz9XBpT+ZrUBOhT7l0hq4iIwDBeGGP+Fpz1oa3X5UpFjrnym7oO0
	qx3i7USzvBkIc3o6+De0qEdhylRVdEnLCqrmwqwzx80i/p7Pw89pLvEkSjb1D0qdvHXthbzceHz
	xS41p8wOdutnFIsoaYA==
X-Received: by 2002:a05:622a:4d91:b0:4ae:dc63:462a with SMTP id d75a77b69052e-4aedc6347b7mr22328941cf.0.1753868362920;
        Wed, 30 Jul 2025 02:39:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNmC57TxqA5fJorGH135uruMdHSiL4OQkD3t41/Mi83JfFgYns87im7Ap3ZJoIyYR/7aVvuw==
X-Received: by 2002:a05:622a:4d91:b0:4ae:dc63:462a with SMTP id d75a77b69052e-4aedc6347b7mr22328541cf.0.1753868362361;
        Wed, 30 Jul 2025 02:39:22 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af6358acb2asm717167866b.56.2025.07.30.02.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 02:39:21 -0700 (PDT)
Message-ID: <3c69deb7-3a23-4627-a64f-3179785bf6f5@oss.qualcomm.com>
Date: Wed, 30 Jul 2025 11:39:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] clk: qcom: apss-ipq5424: Add ipq5424 apss clock
 controller
To: Varadarajan Narayanan <quic_varada@quicinc.com>, andersson@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org, ilia.lin@kernel.org,
        djakov@kernel.org, quic_srichara@quicinc.com, quic_mdalam@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20250730081316.547796-1-quic_varada@quicinc.com>
 <20250730081316.547796-3-quic_varada@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250730081316.547796-3-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA2NyBTYWx0ZWRfX/4liSAE1cmLj
 ZEagD2463sNp4jRFX1dffwmnZ9Iqh/USh06Ea/BXJx4nlUUxlIqezc4pZfKQY2rY1FXN5i+4SLi
 ts1jPpBJZwT8k4bRnj1XfMq/nsaytncUgHnFKlSmnKuf53q3JQUSWCK7SjYgwrku/g7Vr2C/gNK
 DlZiCU+MBUTXwmRYNMJ1QQhsXtcozMWBZbOGLnNVEEyAXLg/gbsjXRXf4zEDmEKICx7kH5vlgM6
 F0dxOBtAjf1KR+7lz0MsdK9wAoIIB5YiCnsC3gTCb2Wh8B9P/s+27fmgXyF/Cv8IjNilizcNnow
 XNNHgRhENCqKqwExYe/jhB4J/ifhSGTdo+lKSYijVgJhBsIO1uYEWwDFCwtiREeeQNDJv/MATgy
 qzn1vcex5J3NXMAwQnFiSciVc7sirfJmi2NSdCueO6lANaaTnVEFdYyvdNXVNOdFxFq3dhqr
X-Proofpoint-ORIG-GUID: JOZ-fCA2xDhJiitoXhEesOOjWbng3krD
X-Authority-Analysis: v=2.4 cv=ea89f6EH c=1 sm=1 tr=0 ts=6889e84c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=i-JfjlNmehoY5ENsB_0A:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: JOZ-fCA2xDhJiitoXhEesOOjWbng3krD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_03,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300067

On 7/30/25 10:13 AM, Varadarajan Narayanan wrote:
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
> +				.fw_name = "xo-board-clk",

This is not consistent with your dt-bindings.

You should instead define an enum that reflects them and use .index
(see e.g. gcc-sm8750.c)

> +			},
> +			.parent_names = (const char *[]){ "xo-board-clk"},
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_huayra_ops,
> +		},
> +	},
> +};
> +
> +static const struct clk_parent_data parents_apss_silver_clk_src[] = {
> +	{ .fw_name = "xo-board-clk" },
> +	{ .fw_name = "clk_ref" },

Similarly here, neither one exists

Konrad

