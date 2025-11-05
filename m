Return-Path: <linux-kernel+bounces-886144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D03C34D85
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 10:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2EC01501628
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 09:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA61830217A;
	Wed,  5 Nov 2025 09:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TQpg7/52";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZR+wDkz0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E120B2FF168
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 09:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334500; cv=none; b=LqeMoExKNG6xYfBGoUOPnD1ljmKD4ic7Nckyj7sNB7KQ1Kei3ksvVjUe4y7YzH2H1qZsYNwdiVd8snoxr1mPDcfKMtYrXukVsd81hAXDwjimtVAIC2wHc552VjYR6dvuJx+4dt/zCJhQTUgjzPpwJC5BhQpVePHOkXg4bNxIy+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334500; c=relaxed/simple;
	bh=edPMV5f4+rFOo6X5Ti0mgKPSsr8IMaRSu9nvfdUv6f0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i5lFAgxGeiZUFWjyQtfdgVNvk9SRaIZL3jIgiWsB1c8Rg/nwjUmUQY+FzgQSPZUbrQd88YetPkIDSEl1OaXoQPzigcBNT79toCqRhISbTEU6vCPMKRw0e4qPz+U8UAev+E42Ef0z+DcV6vc7//z6LK3hivD3630x1nywlwUaiK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TQpg7/52; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZR+wDkz0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A57xT6W3165840
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 09:21:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IsACQYPCm1rz0cB2gcKTd/VxCtL9e1W9lNXbjFsOf50=; b=TQpg7/52eFhlPrnp
	LhDJOjOfgaikifBBd68Bt76e2RwDhz/AwoHRTuEW6a/g2LQnj33yWoiW6wDv96Jy
	Mx30mkQKP3xSe7pePqyeTeIo7PmQ4uyAmFJQ7/hKzFI0P39bGXtptuTZ0fuGSBwB
	CtmboPIDKGPYuUnqFcba/+6KtWObmigfXiekwu/vfBSksTeVkh90Kr1ih6TgwasH
	OcsuD9R0l+CtPsRoRD3VeqNZbEaIb4ePPyxMyDy5x41tuxXQCREDbVS8APJ/RueQ
	PVkWQaiQD5yT4X/DHEWzQM2Zyin1Km2hjjXAMB35awqsj/alAkYOIHUuH6OxEqwF
	1hwJdw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7ketk2j6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 09:21:37 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-341616a6fb7so2805610a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 01:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762334497; x=1762939297; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IsACQYPCm1rz0cB2gcKTd/VxCtL9e1W9lNXbjFsOf50=;
        b=ZR+wDkz0n2WeQXpUYJ/S/iEObUKhXRxEXHLs3JuobM+mVwi8F2RLF7cpuiwNJpR2xk
         vJTwgWMlDOsAfZBiZRTDbNfGiS4hpcPxa7NQQFUfJXiUclTV3k1V2Iaw0Lzj7Psnve4r
         kyI3UY1uzBTG/YXugIHmafhyQ+Mew7ApgsVw2JM86RaqSEYOiOoP8F45yzTa4H+Mms4v
         S8LBrQDkpnIHrIznJfpmIwio4jkoZ6k7bl5diiWiSSyHMWYYPlxwd2hV6kL+d3IEvqTA
         hxw7DOkah+E6bpTkuO4kRy7IbHvxI2KXM81HazrZ+BEp3UmxlLGegELOWMWY8ElrHP5F
         80Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762334497; x=1762939297;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IsACQYPCm1rz0cB2gcKTd/VxCtL9e1W9lNXbjFsOf50=;
        b=jZHMLdEQfz+On4xbdU7BWl+dzm9l5J64xqCgpXisemTkexJTg+VD4HkwJOEbdR5BWt
         o0rU5hV+sWkLn6lU0D6VNBJiUjcuMFnF/reAudc1zReYn2w6KKja6lYX2KuKlznoB4Y1
         T+O0YwcKVjbd7JfeykIkkfB80TGgM0noxs+35k5BV2ZL0TEExmR1UvqlZfYnD0Ks7ywJ
         Wubxso/tSxAbI4kg3nXUszEctaapOzIrPn4g7mO5TfEpmpxTZxMahIvv8u3Uf8jtdYxz
         2oIVO6hTAPJpJnMDRC0wRld49jYcPOMwSfSl4daj8h2Sjc0Ei4RvBLq8QAvgs9yYvj8d
         sXOw==
X-Forwarded-Encrypted: i=1; AJvYcCWkgfGQFDS8o9TDp+Q136c9cwaELn4t/dFStHyQzznnOmRdYf9jnnIwc/Y5Jlzk9m+6oI6QrHvcVV1Pc0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy1ffuQ+hNd5v8OP0sLDQOK1fVPHaq8o8FPfNmmDlPTk8XdHbx
	yFOUwD6uvik3lF3BUcW0YnEJnWiB2EJQx4Zj8AtesShKgJiuwzrob3iebHv7TlrSTxW8OtWUPYv
	UCjPA21ZFYnga8up9kvTzIhmIwJ9PxqA0+65ku6c8CaK1iuHp6swo04N5h/mhhngdZGg=
X-Gm-Gg: ASbGnctAyb2seA6U7ljwEEhjLhS/aA+kwlS68WErAXf1xNRUmJoRoI6G7BX54dS37c6
	Z0JvxgiDZ6V1+sLoTeAWwBzFr3mu/m8dL1zm+/I2DruJB/4dCtJFeYe0MMaU2yuuwr7Xo7fLmes
	lXNW1xM2X2kTcNIfnkAnuOqvf8c72Wi0t9tS/PJmxis6EDzqHpj7NOwouCa3MravB381pjeWJOz
	DBCG4U9MzgiibZKrBiBob/qvkyMbncaHZgfmQWhW5kMEDJB2WLDV5UsvGd/khoff1fK+Am4wvpt
	wgAa8TMLeA0zay/HNfKfuFKRzS3glgIyVowERcRSicljo7jd8Ofq3uC3elV26NBRUbkjEE1Uwf5
	hYZ34KUriFrthL18nz56RpwKUUw==
X-Received: by 2002:a17:90b:3bcc:b0:341:212b:fdd1 with SMTP id 98e67ed59e1d1-341a6c494a6mr3530319a91.16.1762334496572;
        Wed, 05 Nov 2025 01:21:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQpzk6XoGY00QwbdKuVcQLA2m3DPrvsCtENWGLbUBFoSKr4BBAUYZ4VuPu8w72h9csLCtO6Q==
X-Received: by 2002:a17:90b:3bcc:b0:341:212b:fdd1 with SMTP id 98e67ed59e1d1-341a6c494a6mr3530288a91.16.1762334496022;
        Wed, 05 Nov 2025 01:21:36 -0800 (PST)
Received: from [10.218.33.29] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a69b629fsm2229043a91.20.2025.11.05.01.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 01:21:35 -0800 (PST)
Message-ID: <1e464f5d-f4ed-4ee5-b966-fc7de586340a@oss.qualcomm.com>
Date: Wed, 5 Nov 2025 14:51:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: qcom: sc8280xp: Add missing VDD_MXC links
To: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Ulf Hansson
 <ulf.hansson@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
References: <20251104-topic-8280_mxc-v1-0-df545af0ef94@oss.qualcomm.com>
 <20251104-topic-8280_mxc-v1-5-df545af0ef94@oss.qualcomm.com>
Content-Language: en-US
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
In-Reply-To: <20251104-topic-8280_mxc-v1-5-df545af0ef94@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDA2OSBTYWx0ZWRfX2gAE5H92XrLi
 sp2dryg+8/15hfRrbuxDt+CaJHH4p5DTVbGrUZohZr8auxNNLEcPn2Joaz7vawXnVweSQKGZFD8
 x6elYK63mKeTTqO1bMUjMm9Ntu2yvkDaYMazrhRT+2Q98JJSzfvA6RF9nE3SsLDP+h2Os8YMfR5
 DK/lPblPf42i8JYwa8YeTjUaZRYUwarM9YKpx+DUZg3VdvkLYsCAJZ00KWh7etQovW1NBLszZM2
 cvavpD7gXPonFFnlY97cyZsJqscNrXQDc2pOB6hkfvb9Sc3jkryvAOqpH3gA99IfhN8j6iZVuLl
 rv/PGZObIn0rJqbVHQrlrev3cqc5M4EUs0d6RhVdidZKorw/f0s0ENH8CxTJGPdf1EfG/ftlunf
 /PQMX59RTgAxlrW4r8t1CEOXjelk3A==
X-Proofpoint-GUID: H56R8oSnt2SqxJYsQY_X-BZElpT7VJHW
X-Authority-Analysis: v=2.4 cv=IdSKmGqa c=1 sm=1 tr=0 ts=690b1721 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Z_SZGEFGBxMoMc4a6_cA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: H56R8oSnt2SqxJYsQY_X-BZElpT7VJHW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050069



On 11/5/2025 1:01 AM, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> To make sure that power rail is voted for, wire it up to its consumers.
> 
> Fixes: 9bd07f2c558f ("arm64: dts: qcom: sc8280xp: Add in CAMCC for sc8280xp")
> Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 5334adebf278..643a61cc91b4 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -4586,8 +4586,10 @@ camcc: clock-controller@ad00000 {
>  				 <&rpmhcc RPMH_CXO_CLK>,
>  				 <&rpmhcc RPMH_CXO_CLK_A>,
>  				 <&sleep_clk>;
> -			power-domains = <&rpmhpd SC8280XP_MMCX>;
> -			required-opps = <&rpmhpd_opp_low_svs>;
> +			power-domains = <&rpmhpd SC8280XP_MMCX>,
> +					<&rpmhpd SC8280XP_MXC>;

I see that none of the CAMCC PLLs/clocks are on MXC rail on SC8280XP target.
So, MXC support is not required for CAMCC.

Thanks,
Imran

> +			required-opps = <&rpmhpd_opp_low_svs>,
> +					<&rpmhpd_opp_low_svs>;
>  			#clock-cells = <1>;
>  			#reset-cells = <1>;
>  			#power-domain-cells = <1>;
> @@ -5788,8 +5790,12 @@ remoteproc_nsp0: remoteproc@1b300000 {
>  			clocks = <&rpmhcc RPMH_CXO_CLK>;
>  			clock-names = "xo";
>  
> -			power-domains = <&rpmhpd SC8280XP_NSP>;
> -			power-domain-names = "nsp";
> +			power-domains = <&rpmhpd SC8280XP_NSP>,
> +					<&rpmhpd SC8280XP_CX>,
> +					<&rpmhpd SC8280XP_MXC>;
> +			power-domain-names = "nsp",
> +					     "cx",
> +					     "mxc";
>  
>  			memory-region = <&pil_nsp0_mem>;
>  
> @@ -5919,8 +5925,12 @@ remoteproc_nsp1: remoteproc@21300000 {
>  			clocks = <&rpmhcc RPMH_CXO_CLK>;
>  			clock-names = "xo";
>  
> -			power-domains = <&rpmhpd SC8280XP_NSP>;
> -			power-domain-names = "nsp";
> +			power-domains = <&rpmhpd SC8280XP_NSP>,
> +					<&rpmhpd SC8280XP_CX>,
> +					<&rpmhpd SC8280XP_MXC>;
> +			power-domain-names = "nsp",
> +					     "cx",
> +					     "mxc";
>  
>  			memory-region = <&pil_nsp1_mem>;
>  
> 


