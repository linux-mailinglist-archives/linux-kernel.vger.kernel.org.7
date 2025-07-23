Return-Path: <linux-kernel+bounces-742395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0C2B0F12F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D784545C27
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA4B2E11B0;
	Wed, 23 Jul 2025 11:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aJZDle89"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41E2212D83
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753270245; cv=none; b=WQ/c9PmbBASYCf6xCb6HNO0V6zMVgko8BPALdyBLzWRdnAM673SYae3yUQmhHoo6+7VdTwGtzlezgq9NCjeb6bJis6GCwlQnpquASnO9E0Q7ImJYTSYjDpFYxnyACcY1UnHPp8IgY715WmGwy+RNZA3zreQpXY65E0jOPtk0iVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753270245; c=relaxed/simple;
	bh=EWatrMv7fWUYR3nk40Qt126jSA2DEWg1MgTS3LGto4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5EARDDikr2tvvvMRHcs3UvuO7pXCtxcrleT5NDOuxhx33l4QfAiP9wsnxgAcWvdwapzzrClIueKmcq2I8tKS2OHvSz7M2pzS0z8hS/t/m3cYuvsgo3SgZ8R+zY/HlKs76BnBHDmEZJ9ZcEmdkbrP5LnX4t6bZs4pV8IuSHGFlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aJZDle89; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9PGid001802
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=DAtScC9U2/LEXJjXO/aUFYiP
	mdGuZpX7tUt+7DQMPkA=; b=aJZDle89SyGyj19CclERgKtzLsiFbZdgHYAJoaec
	bfu1r57PbRZYjogk88Q6ZMC+yJUYYSSYy5CrOU0MuyG0bCUSwrF5oiMVNvLtFC/a
	3yhCoPl2snU9lPmnXSb8PG2yZxYWygTHhl92w2RaFoU6GSldFon1qMpIQLVrp+6W
	Tpg6AcPEPW03UonC99APNZQbLOorlyRDIUt9Z0EfdEQO2ftmMHsqS0pjTdSWFu4w
	M7QWAQMWAg0/9zvsHVZHdZ4RW5W0c0+8WC0Q0D31MNcmPBForsYLjeVL+uujs6a3
	PzlAlbP9yYU6cHZZSXkArgUudwt7ZrlBnCYhPY4jiU+ssg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48045w3bj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:30:42 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e33d32c501so1502330085a.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 04:30:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753270241; x=1753875041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAtScC9U2/LEXJjXO/aUFYiPmdGuZpX7tUt+7DQMPkA=;
        b=eC6yCoYQlMMxjiOEINy0PAh5HZnzBQwgjSCfiS0ThLUYtzBiwtBX3kpMwIHj8GRZya
         I6/uCWcOamEHz8PSsqTAKtPlBJkfdoT6Y4/p/SF7tsro8e5vIR9S+VZX33hxjvX6NCM3
         ymxiIxauhZEIyDSggRDMuL640n7Uvge0UMpfQiLWFEATFN0XsKxKAjucUheEC/J8Zl4k
         c7tjyFC1ZySKR9A7DDfOiTcLRV9epqdwyrqAtLvlTfUd32ZvR3iPR8NvmvZz4p+H6SNU
         hE68+sSeFJ7KRP4XFrwBQ96GPRAvE/Jre9oLdGz4heyOh3vgoCtmrKlhdwcKBLmGjF2n
         oY+g==
X-Forwarded-Encrypted: i=1; AJvYcCXJwFnD860nV9bk9uWmOZ9lr+SduEZGKP8GVg/Wd7uwukcn5trdr+cGFt6H1BSlO1BDvZED7qG7EDOTxu4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4xTU+PaUljUcK4HLooVUOrwhytkxJgkWUccTtnkFxdu9t+Inm
	C1boIdY0YgcmnWCG5GWmxq+UvDcafLjOA9VcGmBiuqgsPw5Qj13RwQohCr5vGLYhxCNJo6Gg7uH
	EBO4467xgB7dxbFmz1SfPXBkTTs0bTnFYGiP6b/2d0Uw0WBTVnNaVwGzMI68yPqKnYiuHHHcRhm
	U=
X-Gm-Gg: ASbGncuqg7SjP4tL0K1aiCI+rPEF2nsTxUj4dPimVDN+jgFSXXdLK+2FXZjcsNhNB38
	aM0Q6e/vJDarJ/Geo//uomo74sb+CCSH5gH1HY7U1yppnvO7m18dceA+ADA7fF/MtS6Lu0uQuYC
	DFqs9slMaXyeE0rtYnBruQdcIwdJ5ANQxC6J36bWG306u5c7zrUrQS+pJP69vYB8Epqx9zLG6Ci
	F06kX5pLftaO6c4EI7ngFHh7Zn1TXCXylZkXLs9bmY0B/oqFFXeb1QojnmQ1qaqmM61O135kp/w
	ljuUBBVLdZxAcFjTlqSN4nYMLJS/Feagi2xzHBuXxqv4MB7D1kBNw/Xa897lCzlPgdBZIOJCfVi
	qkip3NMIKIpnbvbwMWTwYh84XwOelA68KR9MNuGSItoZj3EOB0MGo
X-Received: by 2002:a05:6214:500d:b0:6fb:4e82:6e8 with SMTP id 6a1803df08f44-7070051b347mr30980366d6.14.1753270240600;
        Wed, 23 Jul 2025 04:30:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZ+GLEEib9onDeXbPXYW5/AUdlXc10aPzgae7rtBYPCKLr2fEo8PRMQxKOYdVJN7ScBBPsKg==
X-Received: by 2002:a05:6214:500d:b0:6fb:4e82:6e8 with SMTP id 6a1803df08f44-7070051b347mr30979846d6.14.1753270239974;
        Wed, 23 Jul 2025 04:30:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a91da0dbsm19146101fa.89.2025.07.23.04.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 04:30:39 -0700 (PDT)
Date: Wed, 23 Jul 2025 14:30:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: dts: qcom: ipq5424: Describe the 4-wire UART SE
Message-ID: <kad3hqxufsdescelmjhwy45ggnukh435wmo5wbbl6pfz2gq5ge@ycfsgtuwdkcl>
References: <20250630-ipq5424_hsuart-v3-1-fa0866b12cbc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630-ipq5424_hsuart-v3-1-fa0866b12cbc@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=LL1mQIW9 c=1 sm=1 tr=0 ts=6880c7e2 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=tshmjInBByzUM6WNTOAA:9
 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: 44cWUATxHmhS0uHYAnkXgx7-DVHiySNH
X-Proofpoint-ORIG-GUID: 44cWUATxHmhS0uHYAnkXgx7-DVHiySNH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA5NyBTYWx0ZWRfX4SpJQE19iFVY
 8j4ObPRTsaZgRt0yKmwsfheJnnwAkC++gnnxSgvzQ5ZSNQyZ1DQGCKBEXlRjVl6iYxDsssLoqo7
 +WxU6UIRg6AWwOfbQL9AlKRpmm9wU924ZPBucaEZaefXZPLMtkcJwCeXWnIhcB0/RUkMxwgZNXR
 pzDKqGlZLKUjUmyCYFUGj2+HF3Mz+ls9ajOBCg1ydLkTxj5RIlp7NDyv5ESNBKOF9amdpZCds0e
 mjNx+Zs1vTKyMUvw6/giLDzZ4rDiv/BFLTKyc1And8Uw2WGjVypVa/aWZYVwtzO711/4AtccdFE
 M54BIOB5uP7+zlX2/ZN/0wmtThCHyhByG+witWVyMqzQipZ5MGPtjvtSBDU5b6uhB0E483spjrP
 TMbiZtN/GTftRwrKTQQkub4VW72ClIQ6HhiI/JUa7D2+8Ln/AIUdkhRXGx8xcTJwStQtcTF/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230097

On Mon, Jun 30, 2025 at 02:20:15PM +0530, Kathiravan Thirumoorthy wrote:
> QUPv3 in IPQ5424 consists of six Serial Engines (SEs). Describe the
> first SE, which supports a 4-wire UART configuration suitable for
> applications such as HS-UART.
> 
> Note that the required initialization for this SE is not handled by the
> bootloader. Therefore, add the SE node in the device tree but keep it
> disabled. Enable it once Linux gains support for configuring the SE,
> allowing to use in relevant RDPs.

What about documenting it as status = "reserved" + comment and then
enabling it once QUP patches land?

> 
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---
> Changes in v3:
> - Add the pinctrl configuration for the SE (Konrad)
> - Link to v2:
>   https://lore.kernel.org/linux-arm-msm/20250624-ipq5424_hsuart-v2-1-6566dabfe4a6@oss.qualcomm.com/
> Changes in v2:
> - Correct the interrupt number
> - Link to v1:
>   https://lore.kernel.org/r/20250624-ipq5424_hsuart-v1-1-a4e71d00fc05@oss.qualcomm.com
> ---
>  arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts | 12 ++++++++++++
>  arch/arm64/boot/dts/qcom/ipq5424.dtsi       |  9 +++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts b/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
> index 1f89530cb0353898e0ac83e67dfd32721ede88f8..8dee436464cb588fdde707b06bd93302b2499454 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
> @@ -224,6 +224,13 @@ data-pins {
>  		};
>  	};
>  
> +	uart0_pins: uart0-default-state {
> +		pins = "gpio10", "gpio11", "gpio12", "gpio13";
> +		function = "uart0";
> +		drive-strength = <8>;
> +		bias-pull-down;
> +	};
> +
>  	pcie2_default_state: pcie2-default-state {
>  		pins = "gpio31";
>  		function = "gpio";
> @@ -239,6 +246,11 @@ pcie3_default_state: pcie3-default-state {
>  	};
>  };
>  
> +&uart0 {
> +	pinctrl-0 = <&uart0_pins>;
> +	pinctrl-names = "default";
> +};
> +
>  &uart1 {
>  	pinctrl-0 = <&uart1_pins>;
>  	pinctrl-names = "default";
> diff --git a/arch/arm64/boot/dts/qcom/ipq5424.dtsi b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
> index 66bd2261eb25d79051adddef604c55f5b01e6e8b..2b8499422a8a9a2f63e1af9ae8c189bafe690514 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5424.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
> @@ -417,6 +417,15 @@ qupv3: geniqup@1ac0000 {
>  			#address-cells = <2>;
>  			#size-cells = <2>;
>  
> +			uart0: serial@1a80000 {
> +				compatible = "qcom,geni-uart";
> +				reg = <0 0x01a80000 0 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_UART0_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>;
> +				status = "disabled";
> +			};
> +
>  			uart1: serial@1a84000 {
>  				compatible = "qcom,geni-debug-uart";
>  				reg = <0 0x01a84000 0 0x4000>;
> 
> ---
> base-commit: 1343433ed38923a21425c602e92120a1f1db5f7a
> change-id: 20250630-ipq5424_hsuart-0cf24b443abb
> 
> Best regards,
> -- 
> Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> 

-- 
With best wishes
Dmitry

