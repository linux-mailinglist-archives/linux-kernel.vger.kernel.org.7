Return-Path: <linux-kernel+bounces-860581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 420CABF0746
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61EAA18832A8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63392EB846;
	Mon, 20 Oct 2025 10:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ldLjFHkB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE0223507E
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760955082; cv=none; b=ugZjeoBqHAsnEN8dvRgA4ny1U9RZZtBDXRwnorycB5v+JIDaFNMdmyePnMJZKVyMC1Xk1dz5XOGdZpuYTDdPLuyPdrpIdz/v+FPePlXRPouUCy0NHW8RyldI/6EY4mtSj69yySEVzv8+DL+n+wQQzNYsGNZ7tgis5uBYrwTDi98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760955082; c=relaxed/simple;
	bh=xiWPSbRHjdTXtgl8HnRR1aOilTdtj6C4ganZdg7k5+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NChcxI4DjdjMORRqNLE1shMrmGJxMhQ3xNMciqnPhpx6F2OF5VgOXZwATnNYgCMeZa4T7FF03tTWtHv6KHN09VD8SaNZKcowV9qokRuhKbZ8ljMQiNQTZdhd6GIeqVqGK1N3HuaPVVhsmJBKTBk2ECko+cMoOEh0AjdqBpdOEqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ldLjFHkB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JMHCjk026557
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O+hVZ794o65ZjNkTU3MJh24n55cLx/Qd4eKxjXTl1tw=; b=ldLjFHkBYPVvaf1n
	KnZv+e/tIDva9J88nVfyPM87YuolpoSyFCrFginK3EHDsLMgD5MuBpKUDOXSiNAj
	ZsibqKkd6fjnVbB28XXZQ2UY3Fw/m1BSFdMUJVBuTBDPQByZH2psZ6Z53hg5O5ek
	cD0Aa0rCPQJmhlhTlNlTlNpByOb+UAq4Z/GeSfALYbQ7kUI4ZSTJuIBUOgh++6g+
	ddWwHYFoD/bB8zBfuWn1lZnZF6IeTJHklqZcN9h/hzwUXb0RjKKxgmodOtVTva17
	8SCK5T+RIeqH4mJWrbSZ8ra3ehS9BtzC5BdKSMTaZCCROAUUHK7MqGy3ciQgU5LR
	S2jE5Q==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3nfcc64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:11:20 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77f1a7d00c9so969576b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760955080; x=1761559880;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O+hVZ794o65ZjNkTU3MJh24n55cLx/Qd4eKxjXTl1tw=;
        b=pp4CEE4IELk8EoEz/AVoLhfKXGVFKxuJ2krVs9F9J3Yums88DN9Qc5A74iULYRpkZe
         tsN1gxhZtCzapRwKHTsnrcrwaqUx42GJaBTMx7I6ERMtqdiqSvdLFB1+vZ5T7RHm4S2S
         m4RSZYenncegsksXyxpNTif7XkZ383se9ELErDRUyF0PeTewjtM337dLm0BZ34kNqyUQ
         QY/Kht/ssDaX12gdQLHPdQwwx7ZRMRBW5sOB/P/0dgbnnhIaObQ/owHSKajfKs1qyKJu
         zJ6SBdHHr+MFycI+fbXRgyxyubdg1TjOy12djvkQTt74Oqnf7VIOw3whZ0e06cs60CUc
         yDOA==
X-Forwarded-Encrypted: i=1; AJvYcCWNBibmM7cDHyuEWYtL7V1bHxwrD3ek8R0+f6FGrNSdGUF5bjX2g5wslYjQEV7cllqYG4jZ3pd1f95b9XM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz3u0mKtFf17+u5IPP4gMexJuOOhXjgwKkxiHH3oX23SZJVXd4
	TIF3fE3lRMwx36VHKsDUxaP3xYsawxykJZd1F0+2S1LpjHThAEpICGNW1YVLsCHsq2s1COP/u1g
	9KWtEux/ZzYBo1VpeSVI5Sb1m1nryMmg55j54UD8cMyWBYqog0hVgJcjCO+EZdjTSwS0=
X-Gm-Gg: ASbGncsJORt0SNJvCwsCf2AqXUiE7vNxRW5iLIWplKIOn+8/yCjSpCz4JZ38rAKn62k
	bdeMkKaJBOhze5tdxlDLVCfqN/BY+yM3NT7GLxyBKlg9vvn24D93mGtPZITGy1AX4SgY5ayuURQ
	uWzj0HpYpW5jv+92n6hhe0Vlj7SAP9cj22ms8LG/DaSUyRm9fyiwi8A56Jt57dKNiEqS7lLbAdG
	s5N1wPO/MigMQE429PGnE6RcDU5/YHBtFvcasW9B7arV/oyRlvpuwnqbFqiHDFxFh9u8HRQ/hrx
	XUjFYD2Oldp7ZgtOb6BsGeVSdtzyNx/6bqDJ2RCD6yfr1ppgSCQX9efdIe2uJduRx+TIj64OvNg
	XeklNyAgHE3k+OVJcGx8CI8b26j2h8y+0Z6qKMolhPITHDnAo8viRea3Cltwy9YKUVw==
X-Received: by 2002:a05:6a21:164a:b0:334:b19c:9bc9 with SMTP id adf61e73a8af0-334b19c9d95mr7179596637.5.1760955079686;
        Mon, 20 Oct 2025 03:11:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHabaF4y08G8QCgS3i2i3+rxV0qWmYjTjDj+Zl/4dasU2uJXxqrMdEiJaZUP0aEJXma7cp6pA==
X-Received: by 2002:a05:6a21:164a:b0:334:b19c:9bc9 with SMTP id adf61e73a8af0-334b19c9d95mr7179563637.5.1760955079132;
        Mon, 20 Oct 2025 03:11:19 -0700 (PDT)
Received: from [10.133.33.107] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b77bf6sm7309840a12.41.2025.10.20.03.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 03:11:18 -0700 (PDT)
Message-ID: <1d2b6c69-4ea8-472b-a18d-0bd39042184c@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 18:11:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] clk: qcom: rpmh: Add support for Kaanapali rpmh
 clocks
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
References: <20250924-knp-clk-v1-0-29b02b818782@oss.qualcomm.com>
 <20250924-knp-clk-v1-4-29b02b818782@oss.qualcomm.com>
From: "Aiqun(Maria) Yu" <aiqun.yu@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250924-knp-clk-v1-4-29b02b818782@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: vLVDmRPmTH0XbzGUiv9RaAGg8AFbRNeL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyNyBTYWx0ZWRfXxjt7Cr24m4d3
 y5aDKoeC7XlpEVYkNhTBqejyAt0biT+luKoPtYaXALq9XVhTsejvNFL03ln4gbRZ14eoeU4+wfp
 eGNJlj8VKqcKNr1XU/ixAER4BRy5e4tjAHSrZKrAkhOSxY/Jv0G7Qu9TwZA48H7CkQTRED5D4Yo
 XyRS1+UhZfT+vLQGj00d7dJ0temIswZ551wGVmeasoJdxnP4mPUhjcV70/fJwDUdO7nxmPtSn/P
 welQ33+nVzZxjaygXWK1JM68+1/1VBB914JIZWt6I5vHVs+rolvlyzh0n5435Km+pzMVzrk78UK
 Vn+Ceo3tjkTMtcR4n98fJusH44np8RbJ37lKSYkAIWFAiX8IC1LorctDUVZu36g7ByJiRbTgl7C
 oYrzqOkkKve/csGPVECuPucDaZuS9A==
X-Proofpoint-GUID: vLVDmRPmTH0XbzGUiv9RaAGg8AFbRNeL
X-Authority-Analysis: v=2.4 cv=EYjFgfmC c=1 sm=1 tr=0 ts=68f60ac8 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=1BWIhq4ta8SIVIyFiOkA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180027

On 9/25/2025 6:58 AM, Jingyi Wang wrote:
> From: Taniya Das <taniya.das@oss.qualcomm.com>
> 
> Add the RPMH clocks present in Kaanapali SoC.
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/clk-rpmh.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
> index 63c38cb47bc4..6b1f24ee66d5 100644
> --- a/drivers/clk/qcom/clk-rpmh.c
> +++ b/drivers/clk/qcom/clk-rpmh.c
> @@ -395,6 +395,16 @@ DEFINE_CLK_RPMH_VRM(clk4, _a, "C4A_E0", 1);
>  DEFINE_CLK_RPMH_VRM(clk5, _a, "C5A_E0", 1);
>  DEFINE_CLK_RPMH_VRM(clk8, _a, "C8A_E0", 1);
>  
> +DEFINE_CLK_RPMH_VRM(c1a_e0, _a, "C1A_E0", 1);
> +DEFINE_CLK_RPMH_VRM(c2a_e0, _a, "C2A_E0", 1);
> +DEFINE_CLK_RPMH_VRM(c3a_e0, _a2, "C3A_E0", 2);
> +DEFINE_CLK_RPMH_VRM(c4a_e0, _a2, "C4A_E0", 2);
> +DEFINE_CLK_RPMH_VRM(c5a_e0, _a2, "C5A_E0", 2);
> +DEFINE_CLK_RPMH_VRM(c6a_e0, _a2, "C6A_E0", 2);
> +DEFINE_CLK_RPMH_VRM(c7a_e0, _a2, "C7A_E0", 2);
> +DEFINE_CLK_RPMH_VRM(c8a_e0, _a2, "C8A_E0", 2);
> +DEFINE_CLK_RPMH_VRM(c11a_e0, _a4, "C11A_E0", 4);
> +
>  DEFINE_CLK_RPMH_BCM(ce, "CE0");
>  DEFINE_CLK_RPMH_BCM(hwkm, "HK0");
>  DEFINE_CLK_RPMH_BCM(ipa, "IP0");
> @@ -900,6 +910,34 @@ static const struct clk_rpmh_desc clk_rpmh_glymur = {
>  	.num_clks = ARRAY_SIZE(glymur_rpmh_clocks),
>  };
>  
> +static struct clk_hw *kaanapali_rpmh_clocks[] = {
> +	[RPMH_CXO_CLK]		= &clk_rpmh_bi_tcxo_div2.hw,
> +	[RPMH_CXO_CLK_A]	= &clk_rpmh_bi_tcxo_div2_ao.hw,
> +	[RPMH_DIV_CLK1]		= &clk_rpmh_c11a_e0_a4.hw,
> +	[RPMH_LN_BB_CLK1]	= &clk_rpmh_c6a_e0_a2.hw,
> +	[RPMH_LN_BB_CLK1_A]	= &clk_rpmh_c6a_e0_a2_ao.hw,
> +	[RPMH_LN_BB_CLK2]	= &clk_rpmh_c7a_e0_a2.hw,
> +	[RPMH_LN_BB_CLK2_A]	= &clk_rpmh_c7a_e0_a2_ao.hw,
> +	[RPMH_LN_BB_CLK3]	= &clk_rpmh_c8a_e0_a2.hw,
> +	[RPMH_LN_BB_CLK3_A]	= &clk_rpmh_c8a_e0_a2_ao.hw,
> +	[RPMH_RF_CLK1]		= &clk_rpmh_c1a_e0_a.hw,
> +	[RPMH_RF_CLK1_A]	= &clk_rpmh_c1a_e0_a_ao.hw,
> +	[RPMH_RF_CLK2]		= &clk_rpmh_c2a_e0_a.hw,
> +	[RPMH_RF_CLK2_A]	= &clk_rpmh_c2a_e0_a_ao.hw,
> +	[RPMH_RF_CLK3]		= &clk_rpmh_c3a_e0_a2.hw,
> +	[RPMH_RF_CLK3_A]	= &clk_rpmh_c3a_e0_a2_ao.hw,
> +	[RPMH_RF_CLK4]		= &clk_rpmh_c4a_e0_a2.hw,
> +	[RPMH_RF_CLK4]		= &clk_rpmh_c4a_e0_a2.hw,
> +	[RPMH_RF_CLK5_A]	= &clk_rpmh_c5a_e0_a2_ao.hw,
> +	[RPMH_RF_CLK5_A]	= &clk_rpmh_c5a_e0_a2_ao.hw,
> +	[RPMH_IPA_CLK]		= &clk_rpmh_ipa.hw,
> +};
> +
> +static const struct clk_rpmh_desc clk_rpmh_kaanapali = {
> +	.clks = kaanapali_rpmh_clocks,
> +	.num_clks = ARRAY_SIZE(kaanapali_rpmh_clocks),
> +};
> +
>  static struct clk_hw *of_clk_rpmh_hw_get(struct of_phandle_args *clkspec,
>  					 void *data)
>  {
> @@ -990,6 +1028,7 @@ static int clk_rpmh_probe(struct platform_device *pdev)
>  
>  static const struct of_device_id clk_rpmh_match_table[] = {
>  	{ .compatible = "qcom,glymur-rpmh-clk", .data = &clk_rpmh_glymur},
> +	{ .compatible = "qcom,kaanapali-rpmh-clk", .data = &clk_rpmh_kaanapali},
>  	{ .compatible = "qcom,milos-rpmh-clk", .data = &clk_rpmh_milos},
>  	{ .compatible = "qcom,qcs615-rpmh-clk", .data = &clk_rpmh_qcs615},
>  	{ .compatible = "qcom,qdu1000-rpmh-clk", .data = &clk_rpmh_qdu1000},
> 
Remind to review this patch.

-- 
Thx and BRs,
Aiqun(Maria) Yu

