Return-Path: <linux-kernel+bounces-845406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E438EBC4BED
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5A8719E1B7F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DCBA31;
	Wed,  8 Oct 2025 12:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mMpM7mc4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6461FC0ED
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 12:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759925876; cv=none; b=aPx+BOhkRUfCME4XLUMRmzakFlkdqQekHwH//O1Qq5Ntf6+9Uid328AH1mXhq9XMAiBf/bk15OFktWAIB6SMQerINTPMg0ax7bwdOFh0psxetcmaBrwMBdJqBjBTpGN7VoGPgtvG3d1NW36sQcJ0vols38VHVZUEE/a0K1O0bs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759925876; c=relaxed/simple;
	bh=PVHRpg631XDxnFVtcCZtQd6DaoP/boLeDvf5wQFW280=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MyCR80cWLKYJv+Lilo7Q8YRk0W9xMiphFdhi+n5zhP9kIMYt3wh9pRlasY+S38PWGfXIi+rRex7Oub4+5uIPwfgWRO7GYC7sUF13QibevQ0krb6l/Ad1pgm366kJGXU9AlamULFE41ev8+cgzcNAIeeaZPRIDEW9UzrEeFcaCGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mMpM7mc4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890PJl014215
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 12:17:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1X/DVcD1GjvfXhX2ArtmK5xnsWxolZ/LvXbotElllEo=; b=mMpM7mc4ZencBVWk
	Nv5V9Y05R0y1ecRzZ4bpYaD/OD1Fn0qXgKmTlgTNNXZKF1sG6twp/5MgBOFbG+UV
	JVaU7UoSGKAgOxBfkOe+XDlkXiK5mr9QDxmhm9w2I3QN7U9YWfcSNWRfK2P0bE1Z
	UJvK9GItUZaarBr1I/fnd9k2IIyHhRl6eE6pe5c1+kN+MunHsnvnRKpBW7MPr+jU
	q93JpaFFrDPVRWrE+NJgnSWqjbtMLq7d28iKesqEKKE7gpQ17tTbYzHwH5QGt05e
	yXQRJM0cZjJV+o3eGmFS4L5sqjGVUmzwrNdmf5w9aHV2y+wR1lDcbJrGEXBIVq0/
	LRyK+g==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49mgd0p4ee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 12:17:53 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-798447d6dd6so20465736d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 05:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759925873; x=1760530673;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1X/DVcD1GjvfXhX2ArtmK5xnsWxolZ/LvXbotElllEo=;
        b=TK+PzRrvJNrDXJnZskF/PQCHGaxTLYQs9sh3uOwz1iBQwPf02FE3zPocm+8YJtpl5U
         W00RTNw6pmE+eR8TJXZX0E89/oD5C9qZ+7mu8H4ClW7LI+x0clL2MsswX1ZHjfTuzqTO
         F8httUQ7J31xyM6PVS3E3T/Z1xlCVdz4cEXpxkEc2BuOmiv7yKm9Y6TxcEjIClwrr8J4
         sCFuAU9plwo8Ll2Nl0RFtnc/okKs+pht85tXw52AeXL00e+F0QIOzv+enVzRU1yr9Sad
         VXiVV3QerGARd4diQ3E3AtI1FeeKJlHQA8NyHlt+vnXH+SI0GTSmxcGYd3YN7ZN4EXjb
         TlWA==
X-Forwarded-Encrypted: i=1; AJvYcCVf98phdpfun77RTPO5sP35Of+xbuhoEXd8Bl3s0RL96HlYtciMWXUpzbbVyKMstBFRwTWGwVLM43jjdQY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyffgflif/5vwbMCArK2Oa2OlwTNmwkZGCqaEI9nWfat0DkSn+n
	bXp7wsdatnHfu76aKJhdTWyK6M+IToE28yjJ8Lu6ymAGChYTacZkXJ/HsN4tdkoxx33Xa3cCePD
	uZEbIie8ZPyFbJKkBKckGrU2j1f+lv9EgRcSvRL9xyuYdEjKMIX8rkHL+1ujK8LK4kq0=
X-Gm-Gg: ASbGncuP70LboeX/h0mPoxsAFeym0b4qDEfdpEw1S+lL6Kkx5YbwNr2Ljdvfmtczw0p
	XbAvzLSChmmwm/t+Qn9r7i1YiSXMpgZH5Q2zVSlpzLU4V6YgbLXMfRDLW8nqrMVOGyX8VscjTeM
	1tYb7Nqj4geA4GLcD58TsEBC9KyXL4CiGgFpOfad5MfvEmEG1rFiRjgBSVilPSq4jXCqWWV8pH9
	0o/5QNBx9lbk9p6BfbrjIbWJESH8yslXysZAOFIVqubn78UoRaPmPvOq7NQJnh2214tUxtDcGlu
	IyUtS8aEMsEtxrZmJ2TEf8EIH5EHffrFqp/hIS9l0J4R9kwFydNAoRst+kTPJ5FO50WIpsWneO/
	azPwNzSc1t6C25wh3o2P5KekL78g=
X-Received: by 2002:a05:622a:cc:b0:4b5:eaee:1c04 with SMTP id d75a77b69052e-4e6eac002f8mr27371221cf.0.1759925872505;
        Wed, 08 Oct 2025 05:17:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHE6rcrDHWT7DP/F4+y/G3pwK0hzfh73g82zoNrFA5XNDYX6nUSTfGMcfiA0x6v/CXm74kh+Q==
X-Received: by 2002:a05:622a:cc:b0:4b5:eaee:1c04 with SMTP id d75a77b69052e-4e6eac002f8mr27370951cf.0.1759925871973;
        Wed, 08 Oct 2025 05:17:51 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865f7420asm1632686366b.43.2025.10.08.05.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 05:17:51 -0700 (PDT)
Message-ID: <d0e2b0e3-4e32-4cff-81c8-fe943084c570@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 14:17:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 2/3] arm64: dts: qcom: sm8750: Add SDC2 nodes for
 sm8750 soc
To: Sarthak Garg <sarthak.garg@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com,
        kernel@oss.qualcomm.com
References: <20251007054445.4096630-1-sarthak.garg@oss.qualcomm.com>
 <20251007054445.4096630-3-sarthak.garg@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251007054445.4096630-3-sarthak.garg@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 5W7ZODvoZXXEuf0sGQZORMtEXX8itGFA
X-Authority-Analysis: v=2.4 cv=T8aBjvKQ c=1 sm=1 tr=0 ts=68e65671 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=17NNhpa1916AHXIy7EUA:9
 a=lRRPjgcFXaC3W-_4:21 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: 5W7ZODvoZXXEuf0sGQZORMtEXX8itGFA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDEyMyBTYWx0ZWRfX2hhbwksAWMb0
 PCSF/h12pTL9hhLlt14Jb8iklc+jJXVlOmDFIwf8kf/t8Da8bmBuHEOtxPeP9VRfhEXcVDaOGgn
 zn7hYkwhpiaeIzTkLBU7mVXdX2kJLgyWRZDbvwHO2fpRK9S6RnXGxt2mLn1ZUF+zbdiavhCoab7
 vKcWD32R7cWejY/N1AZx7QvQOTggiy5dj5ga1DzbAdup4o0DmNTPmSrIhgrFxtyhpNRRA2vDcUO
 dm/heY0QFUdW1H342AuMyX7ceZTnQVOTG5rrYl861TtfuKSUqMBgb6AtC0oB0qzXXDweYK/3HT0
 lgLo/XvPO0b1lDueCdyr2bKQcFrixX+3TUXFnWTAUf02R2RQQiQZAGJwbxPpQdKHuZ3RvEeAdyk
 HaZLS2InL4w+6c2SIcPahNNLSogUGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510060123

On 10/7/25 7:44 AM, Sarthak Garg wrote:
> Add SD Card host controller for sm8750 soc.
> 
> Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
> ---

[...]

> +		sdhc_2: mmc@8804000 {
> +			compatible = "qcom,sm8750-sdhci", "qcom,sdhci-msm-v5";
> +			reg = <0 0x08804000 0 0x1000>;
> +
> +			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hc_irq", "pwr_irq";

One a line, please

> +
> +			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
> +				<&gcc GCC_SDCC2_APPS_CLK>,
> +				<&rpmhcc RPMH_CXO_CLK>;

Please align the '<'s

> +			clock-names = "iface", "core", "xo";

One a line, please
> +
> +			interconnects = <&aggre2_noc MASTER_SDCC_2 QCOM_ICC_TAG_ALWAYS
> +					&mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
> +					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
> +					&config_noc SLAVE_SDCC_2 QCOM_ICC_TAG_ACTIVE_ONLY>;
> +			interconnect-names = "sdhc-ddr", "cpu-sdhc";

and here

> +
> +			power-domains = <&rpmhpd RPMHPD_CX>;
> +			operating-points-v2 = <&sdhc2_opp_table>;
> +
> +			qcom,dll-config = <0x0007442c>;
> +			qcom,ddr-config = <0x80040868>;
> +
> +			iommus = <&apps_smmu 0x540 0x0>;
> +			dma-coherent;
> +
> +			bus-width = <4>;
> +			max-sd-hs-hz = <37500000>;
> +
> +			resets = <&gcc GCC_SDCC2_BCR>;
> +			status = "disabled";

A \n before 'status' is customary

> +
> +			sdhc2_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-100000000 {
> +					opp-hz = /bits/ 64 <100000000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +				};
> +
> +				opp-202000000 {
> +					opp-hz = /bits/ 64 <202000000>;
> +					required-opps = <&rpmhpd_opp_nom>;

This can work at SVS_L1

Konrad

