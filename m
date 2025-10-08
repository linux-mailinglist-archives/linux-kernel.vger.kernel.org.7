Return-Path: <linux-kernel+bounces-845276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B566BC43E0
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 12:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B58D9402CC8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 10:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6402F532D;
	Wed,  8 Oct 2025 10:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M6+AV9lp"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC11221FBB
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 10:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759917896; cv=none; b=JEBAoYM8NE7CwALz/Ih2v79gt8OdBwOKp6adJIYxaN+sz+xCtxOPNgHw8s/4bmDR1YLBoTI6SN47/3ERIxNudnFQUNGwOxMMYalH184NSUGOQCgQGyID8VZ4E8vycByVhn6ztT5j5bYxCNofH/B3LPjBjnqAnE4e0mOEa4OdgDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759917896; c=relaxed/simple;
	bh=4XxJdtsTqZl/7D7l/ZNAwdjtgFJn9LSjtG/b7mIZlYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MqezrKaLVy3bQv+5OFe2l3bkiEP5rv6p4jxHwkHmDHwzt0GCst0sY/dQQ+9zgEUPa23fXAk5uyWZjnfHilQOnyEqhc3FVjhSI2b6FORlrTBpgLkcX34yr4Qi20y6ve+X3bvYguWFAPu2gjurqmrvZyDNBQckbvTwJVYftX51lCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M6+AV9lp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890g8t023107
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 10:04:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WY5c/4zmxkse8zO/jjJDr+KBk5pvA7tL5tyLdCm4lew=; b=M6+AV9lpMWbOcqt3
	qjpBnBgUt3+kUBPMRX550vY10O0aukIcpELdeQNvPcMa6hu50DPTf6IVHpBmJcT+
	GjnR3323XooBNylzLniaaikE0uzTgqKXZJYmevNo24pVhmoEJrbyUsli/NkbczSR
	Xzn5kzt1kG4fSfjzDVAnAThFTeglYuxKcW/VL2WLEqPuqpl08r4Hs5wZBjSumx6u
	5QFIFiIKtxFGTUhkBuVyPR8XTJ3l4+cRl2mKBAh0aKzT2Dj0MXGhYea3iTmmk5G/
	HQa+kOgIOc5lzvqmAZTewkS8xuMIOWJMbg3cPgnzBNwDfU7238zfeiyxshzx5/R9
	wD72qw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49n4wktgmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 10:04:53 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-85d43cd080eso227741585a.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 03:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759917892; x=1760522692;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WY5c/4zmxkse8zO/jjJDr+KBk5pvA7tL5tyLdCm4lew=;
        b=YCzDSPVdUmfXSL1yd9u8yBAXJCEXoDgX3EtXDTu3Y9TmeoqtPHSu7ZV28Va3SKpylN
         xnNCjNM8smq2bsTog9YE7sf6wGeX5fSK84sqomQrVAQBIziioIq8AKkwXlqAakk4T9jO
         GTBtRVTieUgqeeRfIPHPTkaEtazlTLEYRmCSt1NKsSYaWm6/8eYqVh6rYR7EFWcBUPQT
         4iMvRLjjph7Btr/Yb44hjWFZ38Hka5GOt+/XGeeKRgNq/zDw22Ut6cB57ouglQ7SR0yB
         zZHYeBBEoLu5iyB6W+dXmqXD5hyL3cMYR0qE4qniozpnbqAhTUwrURoDw2jVLcOtXgMK
         55wA==
X-Forwarded-Encrypted: i=1; AJvYcCWWA6HpVPaYnSBnH6a/Wbeb6B17b64qpyOrj3apv4iNhRe8KZVKDLOMfnO3jdSCKPCwu8Y6Hr36aWhJ10s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvuoPKPSqKD4wVQOpH8fbA5J+NhA9IScKbs9hB1QOlYd+7aN6K
	peQ5uQDMVgunXirGGJN9AXIQR6rWj5URXL4B6W08oFKd2GjmBUIQVe5PgInyFvu5YTnbwIlFPOG
	FaHv3PgX+xiGsUzvHMOdrlevqJaZGQDHojoETdzFj7LUzmAOolqmJo3zZa7h61kuv5yY=
X-Gm-Gg: ASbGncv9flSFQPyIwV4Dzp2O1OZvRtLvtgP3xXhgXhe1LTAs2FC2XNFC4Fj+U+5SI+3
	2E7CnnKnvf4aJa1HPxIxDTj0/T0aQ/+122W1k6MjM0wF7mt5rKBBdfgaMKr2Ph5tiK+8JcTQcVi
	aDVIjJUQzPvG8FmaFgfz3jv6ygNhiA5GI/wnURMqobYg+Dnwi1FVYuKbA73go3cUZ5iVMyz70xQ
	k1gjvrImBQR2+rdZsRP9MVqdOJ89TdrG+ckPZJ0SowNLoCll3icv0FUvrxQt2Y7/fm5nCQZOo5A
	4FWz8aKxcAcm3KVEmkD5EJYQGqhvuz8xaQAFgUcNjBB7WD845KPG2oxorF+pBe37iV2HoqI9x+r
	0pCFV/3+i5ZbT6Omv+o/l7y4XJA0=
X-Received: by 2002:a05:620a:2681:b0:855:b82a:eba5 with SMTP id af79cd13be357-8834ff907a4mr267583685a.2.1759917892479;
        Wed, 08 Oct 2025 03:04:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsrYk53kHAbHUIZarAeviZCZN3o96KECTh+dhZAtSwTLjkr+Lu3URbxUm9serLVoPCrHnkiw==
X-Received: by 2002:a05:620a:2681:b0:855:b82a:eba5 with SMTP id af79cd13be357-8834ff907a4mr267579585a.2.1759917891846;
        Wed, 08 Oct 2025 03:04:51 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b0c7sm1688116366b.57.2025.10.08.03.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 03:04:50 -0700 (PDT)
Message-ID: <1afcbf5c-f32a-4115-b2ed-583a10758045@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 12:04:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: qcom: qcs8300: Add CCI definitions
To: Vikram Sharma <quic_vikramsa@quicinc.com>, bryan.odonoghue@linaro.org,
        mchehab@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        hverkuil-cisco@xs4all.nl, cros-qcom-dts-watchers@chromium.org,
        catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, quic_svankada@quicinc.com,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ravi Shankar <quic_rshankar@quicinc.com>,
        Vishal Verma <quic_vishverm@quicinc.com>
References: <20250909114241.840842-1-quic_vikramsa@quicinc.com>
 <20250909114241.840842-3-quic_vikramsa@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250909114241.840842-3-quic_vikramsa@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDExNyBTYWx0ZWRfX0tEApOZ6M8a4
 e0ZL4KeXCfdGO8FhWXOKgR4pHHboQxtBBT4nBUY5uvQOZM1Bmtp1/ECB3MYDs/2zihZOc4a7hMd
 tIVkCcV8yuMGPsp/s4d0lhdwmUo4rsxWUYPKsADHLMx+fE8phQOO2f+f0c91WGqFJ/VuvbIuAzB
 Ab5DxveS9+pRTCHRbpO3g/5QRYQtpNSkQP6nvMUcKEeVL9MImFfhghuWXe9omN/3fqFQbgPOxKC
 7Szepv7ilZopqKLmWXyh23q95z2FTzjvhbos2IseF7yRsWiGS7sjtnmTAV7Y2w3H2QfQa5Ecdyn
 /zY3zFkCSanXrfNQAI47der9TZvX6x2XZv+Q9TzhSDAHm2xLemEVQ6XCqnThBp6WmzRSIrfSttt
 GDROOnJckmM974zedIQFim/zkI+bWw==
X-Authority-Analysis: v=2.4 cv=BP2+bVQG c=1 sm=1 tr=0 ts=68e63745 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=prks0494CB43s1mVRQUA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: wqF8yDopqNeudD36qFWBxqeuTLnM8IwS
X-Proofpoint-ORIG-GUID: wqF8yDopqNeudD36qFWBxqeuTLnM8IwS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510070117

On 9/9/25 1:42 PM, Vikram Sharma wrote:
> From: Nihal Kumar Gupta <quic_nihalkum@quicinc.com>
> 
> Add support for three Camera Control Interface (CCI) controllers
> on the Qualcomm QCS8300 SoC. Configure clocks, power domains,
> pinctrl states and two I2C buses (i2c0, i2c1) with 1 MHz frequency.
> Nodes are added in a disabled state by default.
> 
> Co-developed-by: Ravi Shankar <quic_rshankar@quicinc.com>
> Signed-off-by: Ravi Shankar <quic_rshankar@quicinc.com>
> Co-developed-by: Vishal Verma <quic_vishverm@quicinc.com>
> Signed-off-by: Vishal Verma <quic_vishverm@quicinc.com>
> Co-developed-by: Suresh Vankadara <quic_svankada@quicinc.com>
> Signed-off-by: Suresh Vankadara <quic_svankada@quicinc.com>
> Signed-off-by: Nihal Kumar Gupta <quic_nihalkum@quicinc.com>
> Signed-off-by: Vikram Sharma <quic_vikramsa@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs8300.dtsi | 309 ++++++++++++++++++++++++++
>  1 file changed, 309 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs8300.dtsi b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> index a248e269d72d..a69719e291ea 100644
> --- a/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> @@ -4681,6 +4681,123 @@ videocc: clock-controller@abf0000 {
>  			#power-domain-cells = <1>;
>  		};
>  
> +		cci0: cci@ac13000 {
> +			compatible = "qcom,qcs8300-cci", "qcom,msm8996-cci";
> +			reg = <0x0 0x0ac13000 0x0 0x1000>;
> +
> +			interrupts = <GIC_SPI 460 IRQ_TYPE_EDGE_RISING>;
> +
> +			clocks = <&camcc CAM_CC_CAMNOC_AXI_CLK>,
> +				 <&camcc CAM_CC_CPAS_AHB_CLK>,

Does CCI really require all three of these clocks? AXI turned out
not to be necessary on at least some platforms

Konrad

