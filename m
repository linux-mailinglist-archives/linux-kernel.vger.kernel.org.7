Return-Path: <linux-kernel+bounces-884755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F170C3103B
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 13:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E8E44204C1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 12:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0972E0B64;
	Tue,  4 Nov 2025 12:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hjuGDS69";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="avMRRgJ7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D3E2586C2
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 12:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762259810; cv=none; b=OIaQTCab33ZKEpv+ekM55gzY8zkAue8BHoDa1nn0V/FgCttkDq3s21bEmSgsVmCRpO3BQ9PfKtbWzJoy4yr6cdHQ/AxaRGVw8bEANXjyWD0ZvI7OOx4tjoe0nZMluI8LR9UMaTR5muTTO+xlCVA66C/dNdPOmHs9bQXafrFg39s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762259810; c=relaxed/simple;
	bh=MKPjX0L8WrcR+INRuFdC1ttAlo+vyzbZXTNOgiAExVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=flhxgYxv1jTiyQw7ypbT7NPfcLm+ke6hwDXWJ3Q/urMqu2HXhaJDKmbA6WwZ9hsw1FucedONjaVm4P8lOmkKjXHw6OZ38ng/6mGg+OgWf57lQDbD/0FCoI69LlvRiWEC/mWSdnjPJH8X/YGeN//IZDT4knokSMh0qmA0cES7k/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hjuGDS69; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=avMRRgJ7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4Ab3I51794094
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 12:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8LpgcQHoTetYhZVAG0Kcq0k1eZLVh7h9jjjApr9iBmQ=; b=hjuGDS69DURgF9Zn
	huFkMJ74eyqg3+ue25UgM5CjFhczKD+hhfnzPBLeJJScvsOJ7IF3aGymdYss1VBZ
	dxunKBm3fqkCN7Orus5nqAVcXRJU4M9g9zHUVQCleqwQFuOFdFQoa1V8s0spY4J7
	s6q8N8xY6g2KUnamBQn5BdAi0sgjRn/tiNkiIfgYk1LNVDCE8n71FlnmQVgwp6od
	hSyRbDic5qdSOoArpWFbjCgwWdxuSLo0jUzaoYyvnTw2V9saXes47lrEJQgWiJfG
	485GhHPB3UniGA+/LQBYX+VsJHceM8O76hsC31q/Mn09yH1SgXEZtSTZ7KMEFk4G
	pDkYSA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a78eqskhj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 12:36:46 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-87c262c72b5so15858006d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 04:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762259806; x=1762864606; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8LpgcQHoTetYhZVAG0Kcq0k1eZLVh7h9jjjApr9iBmQ=;
        b=avMRRgJ7YsaGW9bQPnLPYV/n5103crwEo4gFVTLibr4BLWcJXh5VB1LZWZsYVkv1dB
         vzqvgUo+ywb9B2+ExrIuDmESxLXN+gIO8cK7Jqnv16IXbam5fQL7qCiOeQlbLYE051mc
         bOcJPzxclb2ZiohvTo0UaIBDeMW1k2Rd1qMFNRSdMHABw903nLnrboGM62GcBBR3HcVY
         qA10CYk3ymYuygjLXEMy6iW250bXv8/7aBBvmSYUgt8xE3x7vbF+zoPI3pbLf2wTNEKS
         5la34xKrpX31wRNE+8F0aTv+ddSPA4gur7kYOmooQ2kS+TQujIXJw60DVdiMnUneWoY2
         EpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762259806; x=1762864606;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8LpgcQHoTetYhZVAG0Kcq0k1eZLVh7h9jjjApr9iBmQ=;
        b=FA4zduNkth/yZliKoixAVtUSU4R7FVRZdsAtAYPtAg/8rK43JsaKNv4txnhWgu5ZWR
         DtzFev8jE0ToClNJKhBoVq2wMid3jeABu8JNlU/2ZS0TgZE7Qcs8JrIDjVj0I0CZe6Rn
         duHX9rx2UJCFS0og0c5Ca1KjaSyTAgxRnCWoynlggcDXlb4QvPg//J35cFHtQczNvc4o
         G4dqQSlQVlvhm2Xk3UZbwS1IXingLCIjQYWF7OuMKTjJWkDFMKoNLLr3bLaAIg4vngSE
         DMSJDmzDUfk2U7GtFlwoGx2BRAuky+q4ULqez7o6EgoNQA/GYDdab+F3uY0e8DZFyXrk
         5cvg==
X-Forwarded-Encrypted: i=1; AJvYcCW9PVqmcP1pcIUYymTagS9mdSkYvm/ufsvEytjdbs7tEaGoGfd5WFXIYD28x5M2PWGdaRPTZAbNcYfBjl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZMCiBw3i3XRUz3RDllTsx2oHTVwhA8PlkN9hL2HquXTFI3IJ0
	PLcqE6+bqxs/DKQGfXqBlB/Zd1omdhGrsY6UHqTJFw3+kC8Bqkb3+d7H+F4WMwoAthmiwi+WiLx
	FGoXF7x0PYvfmsaJz92CyrLehMOMPQh8FI0wYklLmY7u0rN5q4AY1JoAv8F7UTBL1uv8=
X-Gm-Gg: ASbGncsUXA5nbxCuzInJPkeoCE0WRUlELGLAqjggL+cCBHqImEjUsX4qYHI/DeClW9M
	I+y6utcpXZ41kcI8kOBuNvqkdAhyzj2wWwGxWlc7lnO9xzY0hcvmbT/u3a/jyTfbfPfaiwPI2fx
	7MLMTbEcmyUhIqoSRK0Rm+Pxa3OSA4NgVyH1ScpMmuxONhBn6WFJQ4Q9nvEF29z6phDTeS/K/ss
	JMbpviw/Cjw3zyuW7Xna6+Wgn1iy448xXLyB/q2TXEHy0N2ewLBRVndBeg5azoM1pEbSIe28nOc
	7Xf3J+c+CoRw1WTrq9l1Mhz04M+k9wsdpe+bWz0VdAs88y6W9WjIuXkbpcGN/wB4gIf3lW/a09W
	Xwk7kdAOkTL7+apHcYGzSbR2IpjK4k+0/6orU6rc2q5urxcV15HRahTde
X-Received: by 2002:a05:622a:835c:b0:4e8:9af1:366c with SMTP id d75a77b69052e-4ed30f7f5bbmr116285301cf.9.1762259805662;
        Tue, 04 Nov 2025 04:36:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUAyPDC5PYSrO2dIUFKmMLfBGLJx0+GvE6FlrR1aAei3V/LH//k/NgfbMKws7RxoHkAawXJw==
X-Received: by 2002:a05:622a:835c:b0:4e8:9af1:366c with SMTP id d75a77b69052e-4ed30f7f5bbmr116285021cf.9.1762259805046;
        Tue, 04 Nov 2025 04:36:45 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d6f28d0sm210833366b.16.2025.11.04.04.36.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 04:36:44 -0800 (PST)
Message-ID: <70c2f5ba-df98-4ec0-a420-915bbc65eaef@oss.qualcomm.com>
Date: Tue, 4 Nov 2025 13:36:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] arm64: dts: qcom: x1e80100: Fix USB combo PHYs SS1
 and SS2 ref clocks
To: Abel Vesa <abel.vesa@linaro.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: Taniya Das <taniya.das@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251103-dts-qcom-x1e80100-fix-combo-ref-clks-v1-1-f395ec3cb7e8@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251103-dts-qcom-x1e80100-fix-combo-ref-clks-v1-1-f395ec3cb7e8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDEwMyBTYWx0ZWRfX8SjN3SBG8wu+
 Uq9QrgN++NlLTqTC3AwSBJaO6wC/9HsxV9EWKADlJjpzXMGxuyGOUJgHMGpeWQ4Ho/wGT6ef532
 qk4LEdPjCaiKZN2jEmDKVS8VF2nUOfaRU1PM3dQuwLNdN6Hi8R3E9kdRvU9/vockTECVT7NSyI4
 XHuBHlgXAzPwdLYvAM/0i4B+W9M5vc3YND7CmZIpd5ibSS4j7H+T3Kvy9aLT4Ki7BIJ2sgUQGpX
 sIl77M4qNMQWHux3GvAvFkbEPga991q8e8m1sf7DXCrzbFLnmomNVurf4Q0ubU4x14LZo/pGM92
 5Lb0PzU9HppHjKcxlniymFdEa9oBWAMAczgvAnfTmK6MUbJsbiuI4EZkv7CplTfeKfM6Jkc68sr
 8rSm3uNGx3F/sHP8Ko90vQAHur/Zvg==
X-Authority-Analysis: v=2.4 cv=fofRpV4f c=1 sm=1 tr=0 ts=6909f35e cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=hWDvCZeVexTezMgbMN8A:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: YyMl97ci61EDYvbZgeaKXK0Rflgpg6Za
X-Proofpoint-GUID: YyMl97ci61EDYvbZgeaKXK0Rflgpg6Za
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040103

On 11/3/25 5:51 PM, Abel Vesa wrote:
> It seems the USB combo SS1 and SS2 ref clocks have another gate, unlike
> the SS0. These gates are part of the TCSR clock controller.

FWIW this is a conscious design choice

> 
> At least on Dell XPS 13 (9345), if the ref clock provided by the TCSR
> clock controller for SS1 PHY is disabled on the clk_disable_unused late
> initcall, the PHY fails to initialize. It doesn't happen on the SS0 PHY
> and the SS2 is not used on this device.
> 
> This doesn't seem to be a problem on CRD though. It might be that the
> RPMh has a vote for it from some other consumer and does not actually
> disable it when ther kernel drops its vote.
> 
> Either way, these TCSR provided clocks seem to be the correct ones for
> the SS1 and SS2, so use them instead.
> 
> Fixes: 4af46b7bd66f ("arm64: dts: qcom: x1e80100: Add USB nodes")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

