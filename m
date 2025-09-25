Return-Path: <linux-kernel+bounces-832323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD2EB9EE9A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECA8519C7464
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F942F9D97;
	Thu, 25 Sep 2025 11:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C7g30dQO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBF22F9D96
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758799931; cv=none; b=uXpqgbpqT4EABggZQFj3SPofHy/2KBMSLBUs6lACqpmu/XB+OXMFAYh+imaMcEtLLoUnkKgbznKWWRUfs4NpFax9BdV2hxu9taJhgmCy0dUFgkJVOaf2jqxa60joWaYctv/NLHKgOBDQ61jEYBTwo3CPf/TEzTl8Z5Z0TT+oa4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758799931; c=relaxed/simple;
	bh=Z0bgXJgybcfI7M3Ov78lPDLbxmhlYHwHEUYqCSr9tts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RozFTk35j9+TSMH0woKovqu4gfLL3Idu2IsZyTY6Wn7CogoRLCqn+2eGmSihKKTy+D2wnljFDd5JWZgryzoWqs8nKBuhAwoN9ahpyWtJervv+zrObRG5vt3CoCH/qVfsBTgDF4IbISaAjCV4JhGDaysELZZOjt2vb7a4lro+Cj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C7g30dQO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P4aWWZ027688
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p1FrH9vXfDsAbwod1kWwn0oGRkVboYjE2nZxCWJX+P8=; b=C7g30dQOpHuSXuUJ
	uiQ0uecc23yRVvY2lozAi6EI4j7xbveWRIA79z4g7Wfl1lv9j1q3NLNkJ1KQd56j
	D1mAwgQkt7DadH3OCz8NWTKkPo/WP4M5Dc8z6H0ggxj4GDQxrHKkXgfWob1c01Q2
	JiYbjJCpu/Ul9bxcU7U+uTXiJzijCxEyI6U2Z0fFYFBaEszFcrcxAXrVvImDt9s+
	i3SQTNN/SUWEZIuFJ3ZMeY6wmVrYfCp3+VfNeRR/j6o6Tx+xVlIg3ByIEYZ0tGC/
	58/W8hXNlsqiU38MwDKnCe8TZI+zXHQVcee02IEaDwZv1sIDxHqqVCqZdYqcIBHH
	33Fa4A==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49cxup14bg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:32:08 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-721b84d7bb4so1193566d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 04:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758799927; x=1759404727;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p1FrH9vXfDsAbwod1kWwn0oGRkVboYjE2nZxCWJX+P8=;
        b=JLS7SdCRVS1j3U/CaZpnRtzLTxkxpDzD00KZMXW4UR/k1Za8encG4jXQHmvo9/CPLd
         zMGaUYvqH7NYxqiOffi6/fIegWtjB2Uh5T/vv40LJloAEZpAPkCHjkTUTw7u7jQ6f5Nz
         xgxTdsGLjaNC0bMzr6hD3Xf0m+CyzrBrA2W0goGnbkIeoOKuEWd9GuwgJQwDb3tsNV7A
         By0bxt5cFRCKJm/5ZfUU6IO2fhSP0v4gqU1p6picVb2Qn4KLF9wf1DS7iaiN54AbqVQM
         pE3h0bHvBb02pGxm9qZ7hLbVp1z5rFkOA3hsNOLY+bog2JHryrXN+41xaKOcekNnlD+e
         KyvA==
X-Forwarded-Encrypted: i=1; AJvYcCUVkK2R/aOM1u6n8b8yO80W116JCbJeS5HKG0mUJk08AKCE0lN6yoijCJGmUS4MiwbrcSGHkNZsW291e5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHqwn1UJ/ZwH8MvZIT9lmbdcI3if8p7coIrICgTcya/6nL8pZ8
	rQF3YS7V78Jq64K6BIfuZGVLJRX6VNsegxho90TA3iFYWP6h4u7vQaqjS0xDHkeI3VBCg6U4zn/
	FwCG45+Og33RM1rlaJdzW0v9fGcYF/SeT3417F/fH+Vx4oYcyTq+OnTpAJtlsJ/shyJM=
X-Gm-Gg: ASbGncs9Ec8HHiKYyCdVSPmWkg1YFmXc/YQTH0d4+59RJSadYLrlNgswuIZeMCUdrVJ
	1SPY3MZ74ZEJ7MCtxUVQN5100CUzN2s9FpjaW6gnBcXl1fWQZJNzoWzYemxKjnE3eZIWis1hYNZ
	EC+VUbRxxB5bCSbPp1hukyrVQQJhElCat1I0UzbM6o+VdSBeVOu2fd+ZOReCO2Rt5x5Gl9xakdD
	AP4FkxNJbz1VBxgTzbt1yH+e7D03KCYNNGSudeWUo43Z87D1L1Nrv2Xn4c/7GNJaePoP1OsRscT
	s7dQ2F0jPyp98lUBvSvM1o3uxKfGtKgqKlJQXOiKE5cA5+jhtS8NYNDnYrQ0bTOgJ2pVsRHNxpB
	88UBSl03wFnTXx2YtSQ9d8Q==
X-Received: by 2002:ac8:5a16:0:b0:4b7:94f1:7722 with SMTP id d75a77b69052e-4da41e1141emr26321331cf.0.1758799927504;
        Thu, 25 Sep 2025 04:32:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9lkEFEcx88iooA5ISTI+1vX2CSLXnbMlf3Z6B8INfnvKcWZfvN4dkZPHmHoqsUXNmvfrO8w==
X-Received: by 2002:ac8:5a16:0:b0:4b7:94f1:7722 with SMTP id d75a77b69052e-4da41e1141emr26321051cf.0.1758799927001;
        Thu, 25 Sep 2025 04:32:07 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353e5d155asm156475666b.6.2025.09.25.04.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 04:32:06 -0700 (PDT)
Message-ID: <75d8cdc7-60c1-44a8-bf6c-0fb1ef38dd70@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 13:32:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/24] arm64: dts: qcom: glymur: Add support for PCIe5
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prudhvi Yarlagadda
 <quic_pyarlaga@quicinc.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-19-24b601bbecc0@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v1-19-24b601bbecc0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=B4a50PtM c=1 sm=1 tr=0 ts=68d52838 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=zO9y4h5Up0VuW54j_sAA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDA0MiBTYWx0ZWRfX0N7jyrK62P8K
 IAquEynnU/m0/tBIBaHYTR+f0sIDPMOB+Yij9gZ2C/J2U/2ibS2tR1rFF0/2ig3YGxLgbq12SaR
 l8hJsSkvRDuUUDCV8U1uFHu1IomlPb/I+3UGfZMdzm31dHZjB1ng4uSFx12ayFxX2gmLKadR9j/
 l8TCWR/LaRD6k3+5U+PsAhW+gFNpt/h3E6maKLXnhTRqgkoH4zEahzEU+QvmFkHvX1GVYGMyig+
 nYMwR3TYH5UyncjPKifcNWc/19rda03peumjCwML9LdUZ7w29YBM8Z1Tgn8AG/q/ze41DhSVD9t
 NYHcUJILEA4TWtEBI3eJi8T0WVgH/8xkGxiFVbEgLdT6Zc5uYHwZHk9GaOdbIOFra0PXOLl6YZs
 R+inYecJ
X-Proofpoint-GUID: pStQLm5uC-YS-SHneVub7uLn25-ptFdt
X-Proofpoint-ORIG-GUID: pStQLm5uC-YS-SHneVub7uLn25-ptFdt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509250042

On 9/25/25 8:32 AM, Pankaj Patil wrote:
> From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> 
> Describe PCIe5 controller and PHY. Also add required system resources like
> regulators, clocks, interrupts and registers configuration for PCIe5.
> 
> Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---

[...]

> +		pcie5: pci@1b40000 {
> +			device_type = "pci";
> +			compatible = "qcom,glymur-pcie", "qcom,pcie-x1e80100";
> +			reg = <0x0 0x01b40000 0x0 0x3000>,
> +			      <0x7 0xa0000000 0x0 0xf20>,
> +			      <0x7 0xa0000f40 0x0 0xa8>,
> +			      <0x7 0xb0000000 0x0 0x4000>,
> +			      <0x7 0xa0100000 0x0 0x100000>,
> +			      <0x0 0x01b43000 0x0 0x1000>;
> +			reg-names = "parf",
> +				    "dbi",
> +				    "elbi",
> +				    "atu",
> +				    "config",
> +				    "mhi";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			ranges = <0x02000000 0 0x7a000000 0 0x7a000000 0 0x4000000>;

No I/O space? We can also add the (presumably prefetchable) 64-bit range 


> +			pcie5port0: pcie@0 {

pcie5_port0:

> +				device_type = "pci";
> +				reg = <0x0 0x0 0x0 0x0 0x0>;
> +				bus-range = <0x01 0xff>;
> +
> +				#address-cells = <3>;
> +				#size-cells = <2>;
> +				ranges;
> +				phys = <&pcie5_phy>;

same comment as on the other patch

Konrad

