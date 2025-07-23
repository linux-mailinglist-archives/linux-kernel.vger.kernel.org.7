Return-Path: <linux-kernel+bounces-742548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02507B0F384
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB8155661C6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4982E7F34;
	Wed, 23 Jul 2025 13:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K+CuX0ki"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568902E7625
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753276177; cv=none; b=i9ce4V75RZuvAfUOL0MJNAB+aiPYPFP303PUToSSs1ymmZS81zzz4ZzLf4VKY1jc467xg+/Yc/Epvf3h+DhYxOZ6xETwFLXJH7+r4J5IH4++nO9CTAeBvw3j0TaOExKki7ww/K9kpq9Ei8e/4g1haQ63nCtU+s5edmq3odmyXo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753276177; c=relaxed/simple;
	bh=9bMIpxSp6P/2t9mAoqFS3nb+kCc2rNSG9SuI6TcUh4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Dr8i/9VT82tPDg8e1AEEYKWTwttVOEoVxRF8Kwq2OQOjgsx99VOPyG/IG3rj5L2Hkw9neJ4ywvBVwoapH5rBAVUblzYBFCEgvRzqxIRSt49vGolCR4N6z+ZYCDxnmbBIWOuPjL2IDDx9ys7fyGsRvM4azZfRbd4bCRDFkfFLefY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K+CuX0ki; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9FENA007882
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c1fE2F5w2oy/8xTtLiO5hyxrW9pDzDdrUHLDqce5e0Y=; b=K+CuX0ki4cf5X9BY
	AOGV4DBS00dKH/9foYodblzNrJQjknVLhVv/a0fhKRw1CxZ20xX3QwBDh765KtNV
	djkB+KBxXQEy1KGzRK27tozgbEdz7RF1uLYydzPw2OlRA0erip1kJQa2UT+Pye9t
	BBPwBbX68RzmzCc1Pu3OgvUER+CDYB8hM4RvAPyRrO3Me2Mv8yqwJ8veI97vSr6/
	dDHu8Oqz7HG/7rCsKr6ht1juqoAmNZTLX2ihU/lkGxvq6IdHyHviPJzSK1CO0D7/
	2NERgKuKOR+dwHKUtlz5EQ/hkZogh0Q8yTA3QUmTc30TK4nQWN6iJxQhsdbbzDL0
	0Fc92g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48047qd741-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:09:34 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7dea65840b8so69902785a.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 06:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753276173; x=1753880973;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c1fE2F5w2oy/8xTtLiO5hyxrW9pDzDdrUHLDqce5e0Y=;
        b=KqloWCfm/8ojq9Ly3MOoyNJ3R/EeWjHpZWo8Kx3d1QzOY1BimhCdQsdJdCMhpO9Ryh
         c172VT5LjeN1F8bDyNPgCPbSpGLZVCA1FCZX1e0MTzt9XFrpJ2kopKj7uDlkiRjIxml3
         arH2OOEY2tyd5g5jdW6mtc8XBQ5oP2D8el3kQK4u6jH+Pm43Hz/t1b5qAatwFHfMreZm
         OQ5ddRCG92ASYqkY0BduCBHF4oO6DOvfPv++YueoFSg02y6OfnGd0PWqkJev6Ch6P88B
         YYbx7/HIOf705RD1bPEerP6dCu9+cHkwx1VSXLOIil0+Xshf7SgUuF+ibpKJtPD4nsNX
         ewgw==
X-Forwarded-Encrypted: i=1; AJvYcCXf8HYbmOr9z038zYCDioq4UBOBlQ04lQ61RuAd9MxDKFss+JskuYzjlxxjQk23MeLzu4mYxiIfh12PVd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwCf65FkHAJnviKNuMZn/TKsJfEOUEUWDakZ2p0EoJxAiVqF4H
	O9uPICZD7WFz6yQKdEMMv5QSWDVsYrauXD6ocFIs3/Olwz2RXbbHSZXZB4GrV8cKnl6wW8xONfc
	6jMc1DOhIvoY3QCX5wvhKptcuxzzMNV2sd1GH+mRuapktTY1sma8nuN1Q/ii8oQ2EEbw=
X-Gm-Gg: ASbGnctknLsRM9nkC2NNIZ9y79dSlI7NM5lCufW/u+e3CqZyZOWVi+ZoSliJfpMXaeA
	yiezOU/gQbFgNr57ZGjkyzfSe4SqvI1TJcbFoEiMQ/n3T6k+2lVljwbpTXsGJ1RhCTQauWz58O5
	5WNBpzTLUQdxwEZkxd0zfxEbVTsSVR33tRRiSgCGWhgtVdWrPv4UWCsKZOzde+Td/nlKrryLnvW
	y8fVCRFmuumWSYwKEeJWsEHasoMJELXG6xWqzA7lklqvE4BMEcVCBJSD3QWgb8g3a9/Q25HmPUx
	u6iGgkZTfWc3mKsNn1nJlx/rkx1sHryIhMRcanEjZpm99GJsuZ1zKRkvMQb4tM3zRKmYHKF5+Bo
	Uul7xC1ylRvpXH+Peww==
X-Received: by 2002:a05:620a:2727:b0:7e3:4535:4f7b with SMTP id af79cd13be357-7e62a174a0bmr158139085a.12.1753276173167;
        Wed, 23 Jul 2025 06:09:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg+9k+t833aHUHXP8ePI1nQxSBGAeS4mxQTKC61GZLuKY579K2Vn6dySszIzHD/n1n2LN2ag==
X-Received: by 2002:a05:620a:2727:b0:7e3:4535:4f7b with SMTP id af79cd13be357-7e62a174a0bmr158137185a.12.1753276172434;
        Wed, 23 Jul 2025 06:09:32 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7c77c0sm1045393666b.35.2025.07.23.06.09.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 06:09:31 -0700 (PDT)
Message-ID: <75a1935a-b6c1-4339-8b4d-12af9ead51e6@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 15:09:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] clk: qcom: apss-ipq5424: Add ipq5424 apss clock
 controller
To: Varadarajan Narayanan <quic_varada@quicinc.com>, andersson@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org, ilia.lin@kernel.org,
        djakov@kernel.org, quic_srichara@quicinc.com, quic_mdalam@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20250723110815.2865403-1-quic_varada@quicinc.com>
 <20250723110815.2865403-3-quic_varada@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250723110815.2865403-3-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDExMiBTYWx0ZWRfX1vaHaC13A4rv
 diJT/Hwk5tt8EwWdnWZ6JI4JdsLq7lTGich9UhLxWRGyR6WcdAJ1YZ8kfhGU74NtpTyTjbqhGhT
 M5anfQuoLmB3DH7m5OR7vL6U5KqmCapxDmButsk15QEgpU+8n7dAVUjQjqZ8T45yRvWakd0oCJT
 69nSSol4nSZvssV1l0/AmCxH4qWbHRt0MPIxWxyz+VgVeUeKC7PKCvEApm7a4n+/818I11RBjR4
 Q+3ftHYU/kJOmDyZKScsLjfaXC+dUkYfTsITwEnzdOQvTCdHavHEXJ3sej1KP19zEc8vUxkN+pO
 dO/j2RmPewJ8FJTcB5VP2uYl82lSubnkNY6p1K4JA5EcZQR3YQBuPEC80XIdbJww8AMtmfO/09y
 r2JylMLcVd2i8kfj4vglsdSsB1keyg+GPDvPNfifsivETOD7kyVobdpIrkxBGcjqdGIkWsEf
X-Proofpoint-ORIG-GUID: C0TPXY1kNGm5Nooo5W1r3q_aEBNsj4bH
X-Proofpoint-GUID: C0TPXY1kNGm5Nooo5W1r3q_aEBNsj4bH
X-Authority-Analysis: v=2.4 cv=IrMecK/g c=1 sm=1 tr=0 ts=6880df0e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=osBE9IlwIbL1kcFus-gA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230112

On 7/23/25 1:08 PM, Varadarajan Narayanan wrote:
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
> v2: Model L3 pll as ICC clock and add relevant structures
>     Use CLK_ALPHA_PLL_TYPE_HUAYRA_2290 register offsets instead
>     of duplicate ipq5424_pll_offsets definition.
>     Inline clock rates.
>     Fix MODULE_LICENSE
> ---

[...]

Since the last time this was posted, we got some additional infra code..

> +static int apss_ipq5424_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct regmap *regmap;
> +	void __iomem *base;
> +	int ret;
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	regmap = devm_regmap_init_mmio(dev, base, &apss_ipq5424_regmap_config);
> +	if (!regmap)
> +		return PTR_ERR(regmap);
> +
> +	clk_alpha_pll_configure(&ipq5424_l3_pll, regmap, &l3_pll_config);
> +
> +	clk_alpha_pll_configure(&ipq5424_apss_pll, regmap, &apss_pll_config);
> +
> +	ret = qcom_cc_really_probe(dev, &apss_ipq5424_desc, regmap);
> +	if (!ret)
> +		dev_dbg(&pdev->dev, "Registered APSS & L3 clock provider\n");
> +
> +	return ret;

You can now replace the entirety of this function with qcom_cc_driver_data

Konrad

