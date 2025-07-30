Return-Path: <linux-kernel+bounces-750768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03740B160D9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B9AD3B0A92
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5A4298CA6;
	Wed, 30 Jul 2025 12:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CJqtUTJV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209D27E110
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753880330; cv=none; b=BkJfeNFCMiHmutyLeHpv1eGtO0H87/vsXhgI8dKQ61CxUmz0SxU0T9pt+MJHkg7ozQLN6ujwhd97VlGbm+rd+w8eWEtThih0auRAWSbUhJg85bSmvzqIDQAFUtyS4HxjNyk/oJ2q/521b8H6q3t5DIhLkwiGBXJ+CCHqM9qVpfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753880330; c=relaxed/simple;
	bh=qdoR/T1j974HV75S4tJQPO6oa6KOE5TIDMG6swHUT34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B0dk2Tn2r9+nyO8ywzwx/ZE0YZrJ5Z2N9L3oivPRfehQYaduy5BOfAjDv+YerHI+byZE492Wfkv6nBitde9gZ99yVnY2vYT0/iAOoVLH0qygPnZZrjTV5DT4pGqk4TOMVFT2Gl2nAv1QhIBGK0RTa5LkUovMFY5vyHYFGGmj50w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CJqtUTJV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UCbubv007273
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:58:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	REl7hvnxlp9SuuNQcg8K3JJn1OMshdLROkXEqPTt0hw=; b=CJqtUTJVteGV3fk3
	UDHOk/lJylpmzDnVz73C8EOi2ZxnN8Yu1s8Aqdl7Z6Buch7wHd3l357Hg7gQ4tlg
	cTk5KsaWtiOowqWEGBb40+85BsWguXPpPef12JVGn6zMzw4pfCzvU8vTUPMJf6pi
	FCkkD9ARE+ggBj+T5DzPr0y5cZ9g+c76aIfqP8UTgMARP6z3W1XhfKv6dYCWp/eu
	HEk8MaH0eMcTMt8t+sndkbk6D4eqmb+qx7ron7c8KBBxMu+BmccryFfjMjdZQ68o
	jOlStstUnEpaE0bWou9w3BhNYUokxWSflslyoswqj9+NJyjfftLE18VqtzxmVU5p
	cIjjdA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 487jwg8591-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:58:47 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7047de9a9b1so3715026d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 05:58:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753880326; x=1754485126;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=REl7hvnxlp9SuuNQcg8K3JJn1OMshdLROkXEqPTt0hw=;
        b=Xu9InNCgxdbwcxp05/+abVzkHb9jD5xoaTzadHBeOt3M1MgKYeKfSmlJoJndfdaupT
         nJoMuBklfvSqmnaty4kklZDm7dqkrIt6eZfJU+2pu7dTqBHTVBRVxh7JpKb3Gn0Gzu0A
         Ez2cs+hhOS3CUuo9Tnjn5Ss/mD+7GKWM3bdKQrWpdsrHkQf+zb+oZ7RJ6L7rw/et/sIm
         WMynIih5kfPZm5sqiVVV8aZGyAzzltZtkcOTQNhkaIYMmVulMsv1uQKAqQGuJYza3LdY
         VYFLn9SwXRenxv/g2kzwqjkg0/8pebV5cT5AwyCE2uh0Ak8vD14om39TpHQB9diQtR3B
         r3zA==
X-Forwarded-Encrypted: i=1; AJvYcCVMoyi9e9iVB3y8s/vhFMUgbeZTOGVGXojlayijuAJWOFcKWGj45DMGEFb93NF7bi+lAEly1R2tc/swaHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRqmhOeeKwa2HrpXugBUR7FdEYI7Ps71hwp0R6iV2m6JizApE6
	zi4yEQPnjHD1MGgSdDLa9Z3+XMfpVgatl/MwayfhoZyuha6UTWsosmCDw8M+C+nLSSd8ZS/8LYh
	QW4P7UlcRG8Z7mGvmmcwOKf0tpEuDKczGxqH+AnsDG87NEOliLaKjj1FpKobq75XhXfk=
X-Gm-Gg: ASbGncti9TGvISxNl//tpPWR/gWI3NlcjItJZQiKOwyvg1yY7tIFpKt6fdAdhqe5fg6
	5MBJ7Q2CyXmsFrLbOTQYOu8UByFefAkwKTsaHtFBzKRFDaZwk8GDqsUZ5BUlp3do85DMbYceJzh
	XDFcc+A255tk6zph0aIGt8CFKpPSXPHSy+poHHx7Igq8l3g966Dq7AYKIKBLI0IyTuScajOX9PJ
	ysjNIw5VSffE21YBtYAU26UrHyDhmmhccWuTyKYbj59L8xUXL/X93BcwT67b2UJ/jkqj1RflB6F
	/k/N894MGYj5Rdmn/mq2K43vonrQz6bOlbAMR8FKNsJAQwgUbqCW1XKAnoGcDVxIZacqroy86eH
	yWNNVsS1G0x9eMklhlg==
X-Received: by 2002:a05:620a:2546:b0:7e6:3c48:408e with SMTP id af79cd13be357-7e66eec65e9mr236933585a.0.1753880326005;
        Wed, 30 Jul 2025 05:58:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvVN/RcoYodTnfrZL516pu8LNotIBvCtHLo8vMi2gcHequN79TtT5m4Nb7CMoeTdOjan/dqw==
X-Received: by 2002:a05:620a:2546:b0:7e6:3c48:408e with SMTP id af79cd13be357-7e66eec65e9mr236931885a.0.1753880325583;
        Wed, 30 Jul 2025 05:58:45 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6154cf801fbsm3305166a12.31.2025.07.30.05.58.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 05:58:45 -0700 (PDT)
Message-ID: <7217ab5f-680a-41f1-9b90-3d68d4ce5e96@oss.qualcomm.com>
Date: Wed, 30 Jul 2025 14:58:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/9] arm64: dts: qcom: qcs6490-rb3gen2: Add WSA8830
 speakers amplifier
To: Prasad Kumpatla <quic_pkumpatl@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
        kernel@oss.qualcomm.com,
        Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
References: <20250720173215.3075576-1-quic_pkumpatl@quicinc.com>
 <20250720173215.3075576-7-quic_pkumpatl@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250720173215.3075576-7-quic_pkumpatl@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=WvgrMcfv c=1 sm=1 tr=0 ts=688a1707 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=_z6rx1Am3YmXwjxqEOgA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 3sjmcoNXgYJ8T1hTEx1Pmg1678Z2mkR6
X-Proofpoint-GUID: 3sjmcoNXgYJ8T1hTEx1Pmg1678Z2mkR6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA5MiBTYWx0ZWRfX4m746avSpKXg
 +2jIume5jpwWQlPI1c36QUSZPfK1HBP4m1e7QOrxwc/YJC+o1dxuTrmqKTnoZFYaoMOdoa4stbP
 1uK+nmHX2PcXfrNtRBXmXCL3eR4ynZ0Vn1npdl00hkr59yva4Rffv6atjKo/NgEad3hUA/4ga8D
 BQr1knqZLyUXzROak7kIFDF+ibiKrTfTDOUXttbwq/6OLJPEA8BnksGH1spwhxlAP/XPMexWPn6
 35HPEn93l+Qi+ZDQHvmS9ono3OL6Q7fUJ4NNFOL1YcK1YvEkjrpU1EtYQFZBkfCnBxLM2EC3Vrj
 TM9zTlPeTyKObT2B3CKN1K/BDuwHmd6Mhv3o5bnrFjFusVxJchMDQt5BhOADjLhXrYJvyAJGMix
 qjXs9ERbz0TzQXSlJiz2jx3SofrXUfjHJPR+rgu84avV1zRlPOLIlyoUHtg5MEZqo5PCoChn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_04,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 impostorscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=697 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507300092

On 7/20/25 7:32 PM, Prasad Kumpatla wrote:
> From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
> 
> Add nodes for WSA8830 speakers amplifier on qcs6490-rb3gen2 board.
> 
> Enable lpass_wsa and lpass_va macros along with pinctrl settings
> for audio.
> 
> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
> Co-developed-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
> Signed-off-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
> ---

[...]

> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index ff5b3568c39d..fff92fd836ab 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -2872,21 +2872,27 @@ lpass_tlmm: pinctrl@33c0000 {
>  			lpass_dmic01_clk: dmic01-clk-state {
>  				pins = "gpio6";
>  				function = "dmic1_clk";
> +				drive-strength = <8>;
> +				bias-disable;
>  			};
>  
>  			lpass_dmic01_data: dmic01-data-state {
>  				pins = "gpio7";
>  				function = "dmic1_data";
> +				bias-pull-down;
>  			};
>  
>  			lpass_dmic23_clk: dmic23-clk-state {
>  				pins = "gpio8";
>  				function = "dmic2_clk";
> +				drive-strength = <8>;
> +				bias-disable;
>  			};
>  
>  			lpass_dmic23_data: dmic23-data-state {
>  				pins = "gpio9";
>  				function = "dmic2_data";
> +				bias-pull-down;

If you're adding drive-strength to one, please add it to all of
the configs

Konrad

