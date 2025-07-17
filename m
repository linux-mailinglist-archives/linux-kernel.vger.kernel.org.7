Return-Path: <linux-kernel+bounces-735954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31997B095CF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 22:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8380F1C2818E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5857D2264CA;
	Thu, 17 Jul 2025 20:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BLkmmo7k"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321232248A5
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752784834; cv=none; b=ii9+qIj0tLDQz1Aqb3hzJRzj/Zo4Z022BAKq4IKtOd6Dsyze45W31FGjf3GTFjWvTjC80ENqa/dda3puzIfkjO3LbkKRKixAFq80dO5wFGRF6xhnGM1ZSe+tZaq592WvjjGSx0LQ4IuCUV+6AvZM8P8f8+g5rdDs/DBMzPhjRGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752784834; c=relaxed/simple;
	bh=+PKURqZUiFLHGFdok2C2mZeAkQagOq/qdJTWlYR6YI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XjmcQHdfPJ8HO8NeaMxQN488rtqGKeRZHF2t9RflSVunybqr4l2byQ+8McxRKNmDVTYTYWwMQJ1WbX0KD8oIbVIZwe6DMonoXEGIoNDn6AMeRz7e2ZQCk1g7Vc+U1tX/ILSiFmGZJNbf6WRDI/le6vlmDugkEuTbM5XSGXlp8Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BLkmmo7k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HJNDtK022256
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HcA+kp3HypSPdvU2NDchUlEnmvRzp6s5z33xRBR58yg=; b=BLkmmo7kc3scYKxZ
	mjfnbXvyG0g7oXjZUoiUEQ44uLA6XV5nH9+mSFD+fAkInK+06RhrU+wF5uqUFPXY
	UCbek+1GQTOFiEvsYUvD655hpeVtv0OYahZP7QFc29/Q7s9AU0n+bdqxit4zCoDo
	SrDSKDeMU2P+x7tTNOxEOTHR6+GhzvPofq9jZzr19qUHAU/zoTBBgXdzXKf1F9Yb
	XFsAVz00EoI2V/4chGHDZsOaC7e/5ZOcZPyuK49/YV+lGWU9v6wawmujcXbSQuKY
	UDjd9RHMkXuQ8FBJOTN9tI5+yasOyvyrr21eXBC+xby4vgIT/6k3RqwygmyWwxyr
	aO7PFQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wqsy9309-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:40:32 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ab3bd0f8d5so1909821cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752784831; x=1753389631;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HcA+kp3HypSPdvU2NDchUlEnmvRzp6s5z33xRBR58yg=;
        b=Jlk2XKO9yjLdSrMEIvqHpb5Pb6azXnm6djOqMdsUWWx3AdZnAABj2Ai4FbC98YBnHB
         pwStNWg7UFlYtrCwN12cA4rSDe04QAzRCLrcIYkc5SqUJUWCzXMCj/pEtnFqcflsbxQk
         aHL5ZokO81OQ2XQ7vOBGG0xPoHSHvpw0Y1wPfPp3wLxUm+5DAIU5eRU7Tv6R5bdWU/pS
         QkhtWEoZdSwwqaIHWMN5bnuPRiuCjPd8QzocxUVUL93rzDMMHwfqZWRPVxLZz4EZhSUc
         /IKB+DMAha71kTi2rsrgRqnYo4r34ccUoBFRdLC1jKMSHQw9SV3f68+yXvvVrMphSybk
         ErkA==
X-Forwarded-Encrypted: i=1; AJvYcCWBnq5arUv3bO4qGT3ulFeAfQ2YUbuYLWpDRv/nKjcaeiLG7T0gMLVQrEJsAz5PxE+P6xqy0DdRRT7myjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI/640wqvnCuLjzNBGc17s07IhhFDYTSFasJTQfip1GfsaalgX
	2ct4IJ0qoaQ1e7k+TEcGDm6H/0pr+W2jZHEXVNCQang+Q9D2oHuiLfjOInw3gLlgvgrlV3npXq0
	bY2ywFOPK9ThQNStOEoOcnm0OPMuT+MZRTnpgz9tM86GA3Fa1hKSh4by92TIDKAs2e2U=
X-Gm-Gg: ASbGncuHm1botumyAAYz2wozmxZ0fm172B857dqqeATTYp5+RaQpZtq1JIXqG7WS7rO
	XkZlCD9e6oo6a5ogvpMoZZLY1XlLL4BOVmAlBnqjwVa/+ZYoAv6OrpPcwWd/mwp3XEWxyAFCbqt
	6UKWiWcYRwP58SFVBj/bgqDfx70k/tmSf935RjQ0kTEzKtOxHg/VfxonQYiTl/iZGQYBowyklCi
	RLQ8QEq/1aqlB0UyqlTmkpNJrzgDkR2hyDvUEj2UNMT+fbhY7lLoLod56UsJ0BR5E2x7vOutF8s
	htZV4QbHXhG8Zs84X7NYzDWehEqrWN69N9z/m1gZr85HWyVj48CVEubl5+EX1LRlXW7g4KX5AST
	xihO55qqdrEcT2pYw0DwW
X-Received: by 2002:a05:622a:1211:b0:4ab:5d26:db88 with SMTP id d75a77b69052e-4ab909ca3c2mr62008031cf.3.1752784830702;
        Thu, 17 Jul 2025 13:40:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGacEtOK6P1w0TqLkAVvy3zfLW2JrPG0JSKgt/e9kAEeqsdXApuxd5RMOc2e1Ib7SbZf4Jkog==
X-Received: by 2002:a05:622a:1211:b0:4ab:5d26:db88 with SMTP id d75a77b69052e-4ab909ca3c2mr62007551cf.3.1752784829965;
        Thu, 17 Jul 2025 13:40:29 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8264fd2sm1430651366b.108.2025.07.17.13.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 13:40:29 -0700 (PDT)
Message-ID: <ad726c8c-0eb0-4498-a430-f906ea61c80f@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 22:40:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/10] clk: qcom: ipq5424: Enable NSS NoC clocks to use
 icc-clk
To: Luo Jie <quic_luoj@quicinc.com>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Anusha Rao <quic_anusha@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, quic_kkumarcs@quicinc.com,
        quic_linchen@quicinc.com, quic_leiwei@quicinc.com,
        quic_pavir@quicinc.com, quic_suruchia@quicinc.com
References: <20250710-qcom_ipq5424_nsscc-v3-0-f149dc461212@quicinc.com>
 <20250710-qcom_ipq5424_nsscc-v3-2-f149dc461212@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250710-qcom_ipq5424_nsscc-v3-2-f149dc461212@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE4MyBTYWx0ZWRfX3mV2zLgmo3j7
 Xg3UvZvLF4iuoSlwh+pM27OY42ixI+bsomV2wVjfF2db4Furtk7c3wPI4TABkW0XLKB1Fs4ie3k
 payfS2MUZ2ugI/36LEJM4YXM1DnqChlJKWpYBgqr5+zX2PUgLpAXQDf3jgiFyb1ULG3uold7dni
 FtFsl12xlv4ABM1k9r+3kVoLWRhTkc+0izX6F/bnoMoQ3oAC0zvRopfThl511GM8ndVSZlHiPJp
 Aiz2DAdf3IWd88LCzTJ2Vc6HQpTfv+GMwWDaFm4aOOCt+sTNVQWD/sQ0MHvv6OsPCaQ835YwSU7
 j5SQIE3ek9LoYueq3CGiiQlAu3Qp+ghipgXtvX5ZJ9rFNxpgddcPzTU5XHbQdHw5lPKoEY+46H5
 ihIfA8YJPakyKSMX1acAjVVu5HDjOwGCUTV0Onf3SVwmuvRXUuEK2mE/57QdRW4xsHki3TeP
X-Proofpoint-GUID: TbopmKRDNS-4Rr3ysy-XEygHhycQzezY
X-Proofpoint-ORIG-GUID: TbopmKRDNS-4Rr3ysy-XEygHhycQzezY
X-Authority-Analysis: v=2.4 cv=McZsu4/f c=1 sm=1 tr=0 ts=68795fc0 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=53G8P9gWY_1ATa02Ga8A:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170183

On 7/10/25 2:28 PM, Luo Jie wrote:
> Add NSS NoC clocks using the icc-clk framework to create interconnect
> paths. The network subsystem (NSS) can be connected to these NoCs.

Are there any other similar clocks that we should expect to pop up
in the future? We should most definitely have a single commit that
takes care of everything that'll be used going forward.

grep "\[.*NOC.*CLK\]" drivers/clk/qcom/gcc-ipq5424.c | wc -l

returns a number of them that aren't described as icc clocks, most
notably the GCC_CNOC_USB_CLK is consumed as a regular clock.

> 
> Also update to use the expected icc_first_node_id for registering the
> icc clocks.

This is a separate fix

> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  drivers/clk/qcom/gcc-ipq5424.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/gcc-ipq5424.c b/drivers/clk/qcom/gcc-ipq5424.c
> index 3d42f3d85c7a..3a01cb277cac 100644
> --- a/drivers/clk/qcom/gcc-ipq5424.c
> +++ b/drivers/clk/qcom/gcc-ipq5424.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2018,2020 The Linux Foundation. All rights reserved.
> - * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2024-2025 Qualcomm Innovation Center, Inc. All rights reserved.

Please follow the latest recommendations for the copyright notices

Konrad

>   */
>  
>  #include <linux/clk-provider.h>
> @@ -3250,6 +3250,9 @@ static const struct qcom_icc_hws_data icc_ipq5424_hws[] = {
>  	{ MASTER_ANOC_PCIE3, SLAVE_ANOC_PCIE3, GCC_ANOC_PCIE3_2LANE_M_CLK },
>  	{ MASTER_CNOC_PCIE3, SLAVE_CNOC_PCIE3, GCC_CNOC_PCIE3_2LANE_S_CLK },
>  	{ MASTER_CNOC_USB, SLAVE_CNOC_USB, GCC_CNOC_USB_CLK },
> +	{ MASTER_NSSNOC_NSSCC, SLAVE_NSSNOC_NSSCC, GCC_NSSNOC_NSSCC_CLK },
> +	{ MASTER_NSSNOC_SNOC_0, SLAVE_NSSNOC_SNOC_0, GCC_NSSNOC_SNOC_CLK },
> +	{ MASTER_NSSNOC_SNOC_1, SLAVE_NSSNOC_SNOC_1, GCC_NSSNOC_SNOC_1_CLK },
>  };
>  
>  static const struct of_device_id gcc_ipq5424_match_table[] = {
> @@ -3284,6 +3287,7 @@ static const struct qcom_cc_desc gcc_ipq5424_desc = {
>  	.num_clk_hws = ARRAY_SIZE(gcc_ipq5424_hws),
>  	.icc_hws = icc_ipq5424_hws,
>  	.num_icc_hws = ARRAY_SIZE(icc_ipq5424_hws),
> +	.icc_first_node_id = IPQ_APPS_ID,
>  };
>  
>  static int gcc_ipq5424_probe(struct platform_device *pdev)
> 

