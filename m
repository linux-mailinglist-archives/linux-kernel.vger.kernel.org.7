Return-Path: <linux-kernel+bounces-860688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF16ABF0B48
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC5AC3E37EB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736AB2580D7;
	Mon, 20 Oct 2025 11:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MTAHstol"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AE7246783
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760958004; cv=none; b=nTYAgDl1gUxi7LSjGsA9z1l9SmuVGSndbxr/8xlXQNDCX7u6TsFfkYhm+W86A2wL8dJPi/pjs4U/xMe/YKjEoae6e4YeXcASrCZpcLuHM+/n3peRPxHg/yPdh7SC1uYhloWWAp6CflXJ+99cuSELqmXATE2W7MfqZfDPWkzgxQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760958004; c=relaxed/simple;
	bh=14IBdIk0VWgOI+eCkc53st4gjSAtuHjTlT42n1vEQwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDxhdkoJQ7RB2egZWB3dffSNvk01PbruymFcCNpbCbkqruFYqJFUqcwStXdh8F/NwZHkkYIAfE+39fFO5Q1IcxtkOq7V661njkipdK6ETI4O3yNdDwJ7nWF4Eba8kbEuA5BVzJhXHDwVEX2OsW9yrV5C/D1ns8JVPcIm1+MxMP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MTAHstol; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59K0CugL001320
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:00:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=9z3Rdc/B4X/+lumDyrvl1D4/
	e+rPgF8EjJhDbz0wnyQ=; b=MTAHstolc6eUPrq0Rv4wui6J8qUera4HlBzcxo1m
	nAH/JrmV23OkNMh5TA5+TPFsmRUSy6q6J/u7hwKFX7Bc41TcSa6cn/ywOKt25jbP
	fF4+8iANCSnUf4r/NPD7qqLMaYHZb2CBnJFmv3Maxos818qo+DQWNR19kWxGGvMX
	336cOxNgGlBoRhAFEcU++7xqK/NsYKJwZ03UXHvII4kibKEzTrnKpGP7I8doWnUt
	ujoWesrIqHjg+gnNykKWmXgGeDRCYuzQiiXntz00tp+HriDQh91g4+1vTvS5fEVK
	/mYF0Ze4g4pE8yGC6Ps12bX3GFMjSTMnaZG045XfgrGS1g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49w08w24yv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:00:02 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-87bf4ed75beso159084096d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 04:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760958001; x=1761562801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9z3Rdc/B4X/+lumDyrvl1D4/e+rPgF8EjJhDbz0wnyQ=;
        b=MKNWLc6pwkOa62yzDbXyCvHuMc5GZVDSMVJ5hB9/kIGeuNLojmspfe98H7JOSCNe79
         BkBC3IoeN79e+Tb6wKJmS9XZcXKuDY9of3Nih8/wygTXfXADSv3kVMwjDo4WKTILPmgs
         3r5m0jzSkra5F8txQlyPUYglbsVlJ9eqwMeCG4qsugqdtG4I4mQMhcC5xrWWk2N5T+3o
         KQqrDsGtn6CFs/yyYeTLY19dRDe1otyTCscd00TseR+EYMr2K7dIOLiiDH+kXc+emEGb
         DHCT1lhcAxgYqs+tsWVqznqLkMyaGJ/8Oqwk1YerR6lecD87lMILGuwUBOQXu1ppeoA3
         obcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvJgUAgUFjjwLxUbHaXR9bYuvZIh5dvAfth0IwqpATKXKwUZwGlXwMSxgGsjPEqCkh06KKVOjB+JXC1XQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxDWokXSPPcn6oJ4lOvHfKjMjBDwnAcGUcZB74OGV+mBimCBUf
	fiKAaNw6Fqrd2sM3ixLypn2AKTheeZ+lHtYXvGeeVjHoOy3hkMAs6VaEzA1SJrdFLqnUdU4jumw
	VVruMBze7njaX0bQSnFzXjzEj3fqMweWG4l+mMyAfz80Tnl26MPlb1CJP4LAAnHbQCug=
X-Gm-Gg: ASbGncu9lQ9+rhiAu06it5HvmGvRSBqCzdqhGCXj+kVdw2+PdCm12mQHwwCzj3d8o7H
	9sQ6k6YyKtKeNBoIdToMK64YJMzrmxzyO1kSfogq4lltNSBSvrLzhEUFGmZZ1giMAeJKmD+xiR9
	2tXA0TKF2YqNiV1eaNuUwpwZnlqdp17b3miIHny6SETeXDd1dL6muerHcpKTNNw26cWws7MYf5n
	VWGL7GBLydHLPvfew145s4SDacOfGmXF9oaMX0eXYk8mZ5i/xVOw3nMarol3Cl4ZUHH4HLAyr97
	Y0I4d5g6VS/9xGdUfz4RNejJQAkLlSK5hD7xWuqQ9/WK6+Xlfc9BNhM5r0U5IyVcC6qag4MWu/F
	noW8ggjG8O3ed3jMsogUGO+bfQVdD079l8LZ9sSc4jLM0FkqDLN4Dq3orgJpfqD/+y46VZUpEHR
	jonDKybR/d0YE=
X-Received: by 2002:a05:622a:1a2a:b0:4e8:8b15:3180 with SMTP id d75a77b69052e-4e89d3ae832mr157357731cf.70.1760958000908;
        Mon, 20 Oct 2025 04:00:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9kgWQDQxssxXi9g79uzGEY8tRPOM8E9DkJHZayEc3eZVMwNKfchjA2PDtn+fdHPDEn54rYQ==
X-Received: by 2002:a05:622a:1a2a:b0:4e8:8b15:3180 with SMTP id d75a77b69052e-4e89d3ae832mr157357491cf.70.1760958000412;
        Mon, 20 Oct 2025 04:00:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591def1b37dsm2416453e87.87.2025.10.20.03.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 03:59:59 -0700 (PDT)
Date: Mon, 20 Oct 2025 13:59:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com
Subject: Re: [PATCH 4/9] clk: qcom: rpmh: Add support for Kaanapali rpmh
 clocks
Message-ID: <thy7r7my2i3gfuy723rrq36k7hjobzqcnlzbggpagg4fgfvvzg@g5wzzxoppja5>
References: <20250924-knp-clk-v1-0-29b02b818782@oss.qualcomm.com>
 <20250924-knp-clk-v1-4-29b02b818782@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-knp-clk-v1-4-29b02b818782@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: sx1WYUCfqFQQfrjKD4OIvg4XuiBhAN2m
X-Proofpoint-GUID: sx1WYUCfqFQQfrjKD4OIvg4XuiBhAN2m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE5MDA5MCBTYWx0ZWRfX8Ix0dJQ4+OEe
 pf02kseFuS2q0b3tGKtA1UXBttwQOfCqKgZI6L2TZbK7k9U6ycjds1KOhdtSrfMdefu3xJenDEV
 E66XowqC8BUTqvepGGxdW/tzpjTj9SGWNRBdxhjG07GIaUtAMNGjHfNX7FsL+aZZ74XKLB6Icvf
 sIoPCMjrzvwtqJqqhOskKwXwjeEJkIljr3oh6OChZ0s0MUD8YBnkBvzebGXb86Yfai4NVec0CnK
 06Rhi6gXBs+toLujHvTyTNxIXZu1/X56EVZwQN+MS4VHjso+nmlO9+BXiNrkpnGYos7XE6Li43T
 s+oL6Fp9pCKV4wHSHctlH/ubrxrK9qKL4nsKJP6UIEyxH3HHwn4HManJ4duU8mJMv5uwZ6ZilTg
 K0viAVwID8FVSj+Xf2VS25g6Rj5okw==
X-Authority-Analysis: v=2.4 cv=V5NwEOni c=1 sm=1 tr=0 ts=68f61632 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=1BWIhq4ta8SIVIyFiOkA:9 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510190090

On Wed, Sep 24, 2025 at 03:58:56PM -0700, Jingyi Wang wrote:
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

No. Please make sure that you follow what others have done.

Why are these clocks named differently from clkN defined above?

> +DEFINE_CLK_RPMH_VRM(c3a_e0, _a2, "C3A_E0", 2);
> +DEFINE_CLK_RPMH_VRM(c4a_e0, _a2, "C4A_E0", 2);
> +DEFINE_CLK_RPMH_VRM(c5a_e0, _a2, "C5A_E0", 2);
> +DEFINE_CLK_RPMH_VRM(c6a_e0, _a2, "C6A_E0", 2);
> +DEFINE_CLK_RPMH_VRM(c7a_e0, _a2, "C7A_E0", 2);
> +DEFINE_CLK_RPMH_VRM(c8a_e0, _a2, "C8A_E0", 2);

And these should use the same pattern. If the old names are unsuitable
because of the clash between clock names, you can rename them. But
please, be consistent.

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
    -I$(KERNEL_ROOT)                            \
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
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

