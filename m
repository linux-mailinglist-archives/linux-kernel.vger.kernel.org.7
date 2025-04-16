Return-Path: <linux-kernel+bounces-602694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F68DA87DF0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 12:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBB8A3A5ED2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 10:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976A4277014;
	Mon, 14 Apr 2025 10:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VwHz/LfM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7E626FA49
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 10:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744627662; cv=none; b=Di6rmxWqcbnhKwhSjyykZVzsaD1HtVO+UOr45eUADONpdlblKcqQ4nM0fSimjZitH6qekEq9C+2fXJi/OnE0cKtskp36fIFNkb0T6vcrivZJzvuuDjEnYE2i9wiluCY4L8LIcM3XlM1GaO33UVWWYlboE01UgBIcAhbNEm5QYWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744627662; c=relaxed/simple;
	bh=wxuBbqGByqSECpl/rppsp33LJpWUnwZMAHdHED9K2W4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AZVExvyKRkrFshxSDtpnjfTbJ3atbOUVmGX3ndNCSxm7VNv953uXGaWdoKg5nA/vONBf0Ct1PRMk74muJ92SSDD6dx8XFvoe8g9DAJcVsZGagbr//MfRdR1ZX+hoEgzHr+aAAi3mh4nX3RKHN7keRK6sjhJ2fMQECCNx2wLmKOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VwHz/LfM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E99rrH016334
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 10:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bM2RV+Suw/zbUWzXn09cRjN5HRnOqD2gtwnQ2MvP//E=; b=VwHz/LfMJr68b0g5
	D/uyNEG9msNUIWBa4XjaeNk3JLDyCqnHD/rpIJupzzOfAEga3PQz/Il2P0+dTrAu
	HmKniWCT/DtopJ4teirBhf5ohQ9s+qsxerQGXta3Z21zlGMC0NHgYWmzmhe2JySi
	krJuEyKtSnqR9LHAZTS7ZupRiwVDi5N26K22kWCzgWdzEqqTHyHB6ElXnxHZrNTL
	PkYOKag2gRTZgGfoWe/mhzivAOU5CO2hA6XET3xXeJc46lb3pYLam1zee/cwuTrP
	gF2u0sDpV/SZ7kJAz5B0jE1d3Og2XQ57vVAF0Lm6239i9DSHQrZNuQrSlMLuYyLc
	q37uKQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yfgjc8dn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 10:47:38 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6eeb8a269a7so13275546d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 03:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744627658; x=1745232458;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bM2RV+Suw/zbUWzXn09cRjN5HRnOqD2gtwnQ2MvP//E=;
        b=dZi2i7zJo/UjlCvd0xI+u/Uqt2T2XcexNlcz/mhM9Da3FNsqxcvsMpaqTmzI96EnS5
         ol8OgTA+Gud6rdXKD+dRFa9dWrHIAFt1phFRwz0PCQosBw3k3RNEmhfNrPt7iBnXl2qa
         ufQ/avF/UWPn3+qQ4llWczVpYHSgR7iXza4AayL/wTbqFkBUz8lVGcBncq0uj5IdsnfQ
         O0m/q+szdHHz8Df/0MSX0neB8tGqZDh7NFwf37g9BqWu957fG4EehamaIwnrX9oYspvG
         7gLU16qzmEutxMXAYoVzodZwD6wIPcvlFV9+LPmYyx/eWFc6iC9fMCaozx+hkpeHbDkn
         i+rw==
X-Forwarded-Encrypted: i=1; AJvYcCUH12WcfJkfpq0ZNyBNuZnei3JRAzr9aWyte+OvIuyDh6v/1DzpKauOnEL14UhUBcZzjM/bScv8ADfnhbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjgHxXMNGR6EYr8rneQeCZ8q3OkRQYzZ7vwxPqM5j9VPGew6iL
	WgMDVJD1dwQrRddgoS+oeiJKjvPwFhtAHov1/lcRKIcOg7uhJHrRV/mgb2Db5PXZZZTzs85M2wO
	oCgubDcZXeRnzg7BPD2+uqU5Qqa3BdJVzejN6GU0tKlL8jrDFt6JFdhUHSI1NJ+M=
X-Gm-Gg: ASbGncu+7NBqYXd2oP7x0IV1/BE/G8sUOggdGwyFi+GB3z/Gc00A70Ow8RHTzPFrVGo
	Xm6SAFHRPOVXr/I6MVCYZgbg970gQIvNkGZVdQaRJBPA9sGc00dugkgGoefavJCMisQpNiSdGXQ
	+ahMwr3LfrH8wqsZkqJQ9APWjfWWGgAqeoUWEsWcOx8ohLRQBdh3QRMkdwvr6O+uHWtQaIeG5nw
	d1EGFhcg15cueS+dhFJ7jqUzFjSbI+SsPU3mzJG0AB1OyK9kvvfUKHQLjRkkDxS4+EUI9RUa1F8
	4AXlaA1qitqEpGQDCqtOrmA5/Ky5OxRvA9CKK7312f6PRRbH0JuWeS04/iavmOHGkA==
X-Received: by 2002:a05:6214:c2f:b0:6e8:fbaf:fad8 with SMTP id 6a1803df08f44-6f230d993ccmr60971586d6.5.1744627657919;
        Mon, 14 Apr 2025 03:47:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFu72AAkR/AXWzXk/CwAV6q6at62CYqDKg85ggMLzHIgAENoMhkZ9LxzZcd/K/JgZzp/29Hdg==
X-Received: by 2002:a05:6214:c2f:b0:6e8:fbaf:fad8 with SMTP id 6a1803df08f44-6f230d993ccmr60971346d6.5.1744627657290;
        Mon, 14 Apr 2025 03:47:37 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1bea588sm899736466b.67.2025.04.14.03.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 03:47:36 -0700 (PDT)
Message-ID: <218c9580-de47-41a6-a3ae-8b7477fafe30@oss.qualcomm.com>
Date: Mon, 14 Apr 2025 12:47:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] arm64: dts: qcom: ipq5424: Add PCIe PHYs and
 controller nodes
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: quic_varada@quicinc.com, quic_srichara@quicinc.com
References: <20250402102723.219960-1-quic_mmanikan@quicinc.com>
 <20250402102723.219960-2-quic_mmanikan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250402102723.219960-2-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: cErnENVdAMxwfNR_CrjN2XppoUirkRe5
X-Proofpoint-ORIG-GUID: cErnENVdAMxwfNR_CrjN2XppoUirkRe5
X-Authority-Analysis: v=2.4 cv=Cve/cm4D c=1 sm=1 tr=0 ts=67fce7ca cx=c_pps a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=xjS2aVtHvALSJzGC0oAA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_03,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504140078

On 4/2/25 12:27 PM, Manikanta Mylavarapu wrote:
> Add PCIe0, PCIe1, PCIe2, PCIe3 (and corresponding PHY) devices
> found on IPQ5424 platform. The PCIe0 & PCIe1 are 1-lane Gen3
> host whereas PCIe2 & PCIe3 are 2-lane Gen3 host.
> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---

[...]

> +		pcie0_phy: phy@84000 {
> +			compatible = "qcom,ipq5424-qmp-gen3x1-pcie-phy",
> +				     "qcom,ipq9574-qmp-gen3x1-pcie-phy";
> +			reg = <0x0 0x00084000 0x0 0x2000>;

This is 0x1000-wide

> +			clocks = <&gcc GCC_PCIE0_AUX_CLK>,
> +				 <&gcc GCC_PCIE0_AHB_CLK>,
> +				 <&gcc GCC_PCIE0_PIPE_CLK>;
> +			clock-names = "aux",
> +				      "cfg_ahb",
> +				      "pipe";
> +
> +			assigned-clocks = <&gcc GCC_PCIE0_AUX_CLK>;
> +			assigned-clock-rates = <20000000>;
> +
> +			resets = <&gcc GCC_PCIE0_PHY_BCR>,
> +				 <&gcc GCC_PCIE0PHY_PHY_BCR>;
> +			reset-names = "phy",
> +				      "common";
> +
> +			#clock-cells = <0>;
> +			clock-output-names = "gcc_pcie0_pipe_clk_src";
> +
> +			#phy-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		pcie1_phy: phy@8c000 {
> +			compatible = "qcom,ipq5424-qmp-gen3x1-pcie-phy",
> +				     "qcom,ipq9574-qmp-gen3x1-pcie-phy";
> +			reg = <0x0 0x0008c000 0x0 0x2000>;

So is this

> +			clocks = <&gcc GCC_PCIE1_AUX_CLK>,
> +				 <&gcc GCC_PCIE1_AHB_CLK>,
> +				 <&gcc GCC_PCIE1_PIPE_CLK>;
> +			clock-names = "aux",
> +				      "cfg_ahb",
> +				      "pipe";
> +
> +			assigned-clocks = <&gcc GCC_PCIE1_AUX_CLK>;
> +			assigned-clock-rates = <20000000>;
> +
> +			resets = <&gcc GCC_PCIE1_PHY_BCR>,
> +				 <&gcc GCC_PCIE1PHY_PHY_BCR>;
> +			reset-names = "phy",
> +				      "common";
> +
> +			#clock-cells = <0>;
> +			clock-output-names = "gcc_pcie1_pipe_clk_src";
> +
> +			#phy-cells = <0>;
> +			status = "disabled";
> +		};


> +		pcie3: pcie@40000000 {
> +			compatible = "qcom,pcie-ipq5424", "qcom,pcie-ipq9574";
> +			reg = <0x0 0x40000000 0x0 0xf1c>,
> +			      <0x0 0x40000f20 0x0 0xa8>,
> +			      <0x0 0x40001000 0x0 0x1000>,
> +			      <0x0 0x000f8000 0x0 0x3000>,
> +			      <0x0 0x40100000 0x0 0x1000>,
> +			      <0x0 0x000fe000 0x0 0x1000>;
> +			reg-names = "dbi",
> +				    "elbi",
> +				    "atu",
> +				    "parf",
> +				    "config",
> +				    "mhi";
> +			device_type = "pci";
> +			linux,pci-domain = <3>;
> +			num-lanes = <2>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +
> +			ranges = <0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x00100000>,
> +				 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x0fd00000>;

I think the BAR spaces on all these hosts are only 32 MiB long

Konrad

