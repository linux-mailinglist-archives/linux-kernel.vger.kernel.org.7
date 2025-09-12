Return-Path: <linux-kernel+bounces-813790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 824AFB54AB1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3737A680782
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E062FF66A;
	Fri, 12 Sep 2025 11:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZZ8d9YlT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683652D660B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757675301; cv=none; b=HSQNKTBRD3zGv9YPF2bTzYN8BSPs/P6V6wznDS9Z1N8GH1oIExHLjkcezJ8zHNkQu+k3KZ73NemMpCmNxxb5gk563idh0H1xXvqEWchZI1Mx/3Y2Ht3L/vAeKSRX6jDcFD+up8MjTkbopVemS+5GyinCPqV5WkLaa9dwya3FQB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757675301; c=relaxed/simple;
	bh=SdMLcvVYFfT8vLpy1kmVurQSEeQL47wxS31jcgfF/pI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EiUCspAqZqAkv6Jud2jfHTkliVVoULcNuT3LEggoup49966F+YI4/G5+dtEhcv+rGAEp3jdE/YkT47ExB1GeQ9PglqXPn/R9IQNuMbgTY2zX9sPoC7ml+4FniFk9K9HeBVOi1Est3lspbzzv7HzWvBr59/Mx2APOgjJyWJy5kKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZZ8d9YlT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9fKQw009089
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:08:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Uokk/WWg6coArADdOgc7mvwj7p78n+lj8V4PK0/8Pc4=; b=ZZ8d9YlTOOStIca8
	NM5xJlgS34cKzY8iFqmNHBzCpqgK3kO9FoIteJeIwXRKlUb4Y5eD/D3V5FIwMB+K
	ymjRCNqfjf+KBe8ZydDlVbq1n0zPQo3vu1vPcCSo1HPbVE0tsqayPaIRA/HKAuIB
	z4slbvYJsmQ2DNMsJ2rJlsvsaXfBy3eqfDAHliUuKa7uIM5ry/cx2ZyiOgYICA8P
	30cFNOcdeEteEfG/eS25So3gEJyAw/bxBS1S9q9y3N/I105ntrZqVSG5iyL5wGf+
	+Pf0hCYhzbTCZvDis7UYH8RH6dOFxLWPjpX0ZxnWmCa4muHG0/mAT1Hf4SxlW18c
	5753Lw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490cj13cpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:08:18 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-81621e5b962so45301285a.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757675297; x=1758280097;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uokk/WWg6coArADdOgc7mvwj7p78n+lj8V4PK0/8Pc4=;
        b=mNjhtrHBQfArdo4WsYHx7dNU58aq8clh5R/F+iNrVx9LEo49pBMta0C8Bt3dN98wb1
         mXEETyaWy4/87m8a0ewXaU07N0PIRjGkbn3hmt6nMD7yBPJF0kT1R7HH64IsOFgJOESP
         ygLUAs7yCtH895azVsFKAfEduVNXfGDd3fFsI1yLcYLpB0bVIPHnWiOPsm1aJ7/0F0uh
         dlYLtyztlXdO13V15siAbJi0fQOIGhi7Hp3WQ6xkrZz9bIvQmLFyn+m5VWItjSPiLING
         M8shozzZylhkvlhxQhvI9eWd5Na1edSWO/ylAxIRBhDWyRLdcB9EGotm+S6E1iUmKdm9
         weOA==
X-Forwarded-Encrypted: i=1; AJvYcCWlhK/RM5wDzGx9FqU8kGkIt6/uA0emdgRf2iUSG7dODjgGV0A+PYDbHgE4E5zEXbENmnA/Bd7aBcJ3T9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJnKNZ5+jzRbPkaEpuKkl+llyrWxZDnbWnfnEauczCaS3tFbNE
	IWCYb+VwEjt5nBzObdqO6+wyOBmDXaSysVcIG2IbxGHv1dF3wq52sYbdsLEHvkTCX+shJHxw7Vi
	ClZeKbuGTQlENe8PyKj6RDgA4TEAOG4tCroFBeDgPUxMleASJcoJZoSA/g81g+3zQa24=
X-Gm-Gg: ASbGncsOxNM2Ghdf0o0whzMCGBOQd369mSLjCpHkQhLirFkB0G+dvjeh4rL+/okxo4A
	Kaa/XRLmiKplRI9qQCa5CZxEKWI5/qpS628tIiBtO+O8OhXGN6FYPL2Ci7/gKGjWS4jKmCVXZQX
	X4H36vRmCR4ibGpDoc1Ox8B7SpNvLs2gpxXAGuyOY00C8ro5nyryTTj6LoJ/qBPI1eb72f45R2D
	LZ05vKOMrqnUqm1fEyPGZwiSXQPIxLI7tdXsjAVO1k5Cjj1HvSi8AsyhzeV6lu6bgJYxk+snBHp
	Fc5ebXqTun4iY8tOd0aSTze4PANL9iJUL4CDMHpKpeG+Rv08+3YuAOBtOiIjzwJXFr9DFtuuIkN
	actOiPh2cn6Wro0FfhWsCWw==
X-Received: by 2002:a05:622a:205:b0:4b5:eaee:1c04 with SMTP id d75a77b69052e-4b77ce87c27mr21934301cf.0.1757675296982;
        Fri, 12 Sep 2025 04:08:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4jHhw/0hyABv8RVQp3e5MRh69QWXm/R7Xr8cosuIOallnrpV/vm6x9Sn/KbICuXgxrabMlA==
X-Received: by 2002:a05:622a:205:b0:4b5:eaee:1c04 with SMTP id d75a77b69052e-4b77ce87c27mr21934001cf.0.1757675296567;
        Fri, 12 Sep 2025 04:08:16 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62eead54362sm614906a12.36.2025.09.12.04.08.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 04:08:16 -0700 (PDT)
Message-ID: <503e1fde-39ea-4107-947b-18b705f2bc51@oss.qualcomm.com>
Date: Fri, 12 Sep 2025 13:08:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] clk: qcom: videocc-sm8750: Add video clock
 controller driver for SM8750
To: Taniya Das <taniya.das@oss.qualcomm.com>,
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
 <20250829-sm8750-videocc-v2-v2-3-4517a5300e41@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250829-sm8750-videocc-v2-v2-3-4517a5300e41@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 3bXDFyga6_cyef3wZeOpE1Ozlb1JRVPd
X-Proofpoint-GUID: 3bXDFyga6_cyef3wZeOpE1Ozlb1JRVPd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNCBTYWx0ZWRfXy/liyT+BCgq/
 0m1F/ZbTWvWS3ZS51XG7p6+n2j8Jpph/lPT70bgeP4E8lwk136EnaMRewCGzq5H9Eu7Ll0H7JoA
 IaZNHHBsr0lUkBvPhxk1wJT1b+z5HOOww4NFQjPYqEbc+i+AbjYSapaIP4jzMuyUWblZ2zR3p6L
 N319sxb8OggbXtfkNGkcY2uMofaHKOISB3ExVxuxyhu9INKFeSSXPtUwDxEq6eh6uOLSFwyDCZN
 AGEGf/zLfe+krzqItGhCTIp9mUtevORqwozP59aa1nOzdcZ6dghD781fDIk2uAf1G0Jqh3kJwcz
 9/iE3/nqXSWaQUCCf0R9e3t/R6HYY4oO+9yMpmUmWRZsMdxOhiGHwnD8hOE8hwQXToyi/PiloOk
 vm5QFtur
X-Authority-Analysis: v=2.4 cv=QeFmvtbv c=1 sm=1 tr=0 ts=68c3ff22 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=MRVLr9g2OpiS_xmof_MA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060024

On 8/29/25 12:15 PM, Taniya Das wrote:
> Add support for the video clock controller for video clients to be able
> to request for videocc clocks on SM8750 platform.
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---

[...]

> +static int video_cc_sm8750_probe(struct platform_device *pdev)
> +{
> +	struct regmap *regmap;
> +	int ret;
> +
> +	ret = devm_pm_runtime_enable(&pdev->dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = pm_runtime_resume_and_get(&pdev->dev);
> +	if (ret)
> +		return ret;
> +
> +	regmap = qcom_cc_map(pdev, &video_cc_sm8750_desc);
> +	if (IS_ERR(regmap)) {
> +		pm_runtime_put(&pdev->dev);
> +		return PTR_ERR(regmap);
> +	}
> +
> +	clk_taycan_elu_pll_configure(&video_cc_pll0, regmap, &video_cc_pll0_config);
> +
> +	/* Update DLY_ACCU_RED_SHIFTER_DONE to 0xF for mvs0, mvs0c */
> +	regmap_update_bits(regmap, 0x8074, 0x1e00000, 0x1e00000);

regmap_update_bits(..., GENMASK(x, y) /* full field width */, 0xf)

would be easier for the next person to check against docs in case this
needs to ever change or be validated
> +	regmap_update_bits(regmap, 0x8040, 0x1e00000, 0x1e00000);
> +
> +	regmap_update_bits(regmap, 0x9f24, BIT(0), BIT(0));

The register description mentions a ticket which I believe says this
is not necessary in production hardware

> +
> +	/*
> +	 * Keep clocks always enabled:
> +	 *	video_cc_ahb_clk
> +	 *	video_cc_sleep_clk
> +	 *	video_cc_xo_clk
> +	 */
> +	regmap_update_bits(regmap, 0x80a4, BIT(0), BIT(0));
> +	regmap_update_bits(regmap, 0x80f8, BIT(0), BIT(0));
> +	regmap_update_bits(regmap, 0x80d4, BIT(0), BIT(0));

Please use the new _desc infra

Konrad

