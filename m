Return-Path: <linux-kernel+bounces-845415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBDDBC4C91
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DAF2D4EBFB1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADC7277009;
	Wed,  8 Oct 2025 12:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oI4DYbkW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7515325B1D2
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 12:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759926619; cv=none; b=VH8LIAhi8FhG2zNBf95JP7vDWtLKsqr8Phw8UASXOh3OdrcH0CLJp2eD9cnuFT2yAnuklPf9QCcz0GuX4gQmA+lmnwblhpQxdztTXfN4L2yKlSgYY+g1E0R2xmz6oNudNuv/QcHBhxszPEIXTf4++r44VZhG0CsOiJDM/8xxpKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759926619; c=relaxed/simple;
	bh=3NutFA/lGn0R2mNE8a1/k3ypM4Mn0sub0aw8bFRL2HY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lQfxhCVTJ1MHd3CgRi9RjiDnzwvbQnevULBeGelztQPsLh3Y9zf/drnrpNn35XRUCdyfkQuHKQeu4h/rEkylZtt1oJH+gR1i/OwbHz4VAx0xL1Ttp4hl3rPwDhpyNxIKXbz9jKneoVM+AIz/0+ygOZWpj0bP4baiYW0bsamBmYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oI4DYbkW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890U0g026718
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 12:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vYwOmmq6eh7c1BlgA/tZn39no0yivZDY9RCiDcAFj/w=; b=oI4DYbkWuaD6yH94
	nOZtDEflYZ5xYXXjFMhsljICpLt/7npA7QQoc66K/oRpaHpkYa8OgviwiXofRYBp
	08atq97uw49H8M7CEsDfpErHmHNcgQHOc6/fzjC6Np34FrxGo/zF0s2KzbEM+hhs
	w5ar8HUJZL9mucZ4KWnkdchApE9TCJLOh2ppNLO+J3uG46c5BeaqgGa5Nv9BQDY/
	KFZO0WRkztMRsQ1FJ+y6YcH/x+wxzSrQxU/S965lejl646L5GzQI1xjlMt1WXGla
	y9nGquhxWkbQECj089H/pYvNAKPwF2hdgbX6KAfuypGmczb025yeOJODkshfg14W
	xPaW3A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49n89hj7cv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 12:30:17 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-860fe46b4easo254686485a.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 05:30:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759926616; x=1760531416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vYwOmmq6eh7c1BlgA/tZn39no0yivZDY9RCiDcAFj/w=;
        b=d6iaJpHplIEd71IxiiOOnd5sE9hZw6oG0Kbi331IZ96FahuDLT77n3cbMh/1cy7Uur
         IN2vSPblYuMhom7ogzdrbCLOruR23xFXmf+wX6ADcAqW1pnH8WIleC7lWgKmy58n76sI
         VPXG8cmMML9RGQTp0tlkXVuKlv2behISfwdbjbBwlHcn5BkQtJTA7fzqMNfruHH6jMr0
         g0HK7BmWMG0GG8XBSrHD80LLRWPe0UnktscJifNxk+444MqnA5kJvp3BMP2ZzyMMvIvF
         St7GRzEkWjjX0Gy3RnvbhtElkF7v4i+V4vBgQlW7uXiZltrZmmx4pJkqR9YyA12Occ2O
         1KvQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4COwdQN4DhhvfIBUA80AwkUMKBmeBST/ksdoejyKl/jXyCw1s11dOPuCejhxZlc3x7R7LZ8mDIbxbg+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR/jk7zzSO8jaCHFQaM321PGMKho8xZeh1ns2nDPlgnre/Bjqk
	kYexU5Zzs612tGtK5gbn3uf9AjdC2nVqvAyCDyl8Vwn5/SA1f8gHQx8TNblipNrFD5BtVe/zN4U
	TC3d102eFJJjtpyNwBB5KWjzpq9MMhPbnhilMSqBM4PpHubRFFpn1H1io6T5XQDeZ5dc=
X-Gm-Gg: ASbGnctBvJTuigSTmwsJhBh9/uRSY9jns096wQfHzWLcQ7RZJ/YcYBLQxoRUGJAA1En
	rcIn4UvZeenB8O8vExKbss5V8AbBT2zmxtpuDB+ECxWDTRsetcACLdeEd/FcFRrfyZyyb1wX6Un
	CdTcJIJb5SMg2xCixziqODFIcTgSAa3+coj6KdTPuLut3s1xgbIJcT7D8KqUBqs7gJo5WaW2/vz
	1PnE7ctW5CrL5qtAASlpWFGlE+GXZTnTvJ6qZiJcCOaI0pf2U9nzQVZGbHjCMRC5QqxZjibMzKX
	/Ly9noQuUtYvjLtBXd3nXdrhYdODnbK3eOKW3BpxtBZRF58dbOhWUj6ThLNdmHWaSyELL/fweqL
	ikrE4I4KD5AvKCTdDdvwDDDJcVf8=
X-Received: by 2002:a05:622a:30c:b0:4d9:5ce:374e with SMTP id d75a77b69052e-4e6f4acde1fmr5303641cf.8.1759926616100;
        Wed, 08 Oct 2025 05:30:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/AlwhfCmrZxt1Uz+PeJCgLqUiBaGU6v5l4sYwpfDnGoDIJcA7elnm7lMZ7gtM4iXdb4tK9Q==
X-Received: by 2002:a05:622a:30c:b0:4d9:5ce:374e with SMTP id d75a77b69052e-4e6f4acde1fmr5303051cf.8.1759926615439;
        Wed, 08 Oct 2025 05:30:15 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652a9ea1sm1633510466b.16.2025.10.08.05.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 05:30:14 -0700 (PDT)
Message-ID: <c7848ee9-dc00-48c1-a9b9-a0650238e3a1@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 14:30:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] arm64: dts: qcom: ipq5424: Add QPIC SPI NAND
 controller support
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: quic_varada@quicinc.com
References: <20251008090413.458791-1-quic_mdalam@quicinc.com>
 <20251008090413.458791-5-quic_mdalam@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251008090413.458791-5-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDE0NiBTYWx0ZWRfX+LR/RWOQSfnQ
 +9EYTPTI1OpiAtj28wvibpT1nbiseQjNObzT6+zPFPadsgPnXqqXwvlFTQ7mqLTFbc8LxMfSX5y
 DoiU4BHSwYIxboYXR7btBa+s8yRFzo8sP94x+4KjbTlg7t0D4rHH899jILkMOZNgWoxlG+fnpyv
 ze0Bwi0i8yIWi9p07KOnOFmkfWMZj7mqDKYROjQdpJrTIKyF1zmqujSHw82dINxbu4h5xVFDhoA
 xpihAaVpzKa6T/+BNv6nWcu6Bi66QnT7N9xrK38d8qK01MIcPoPR9HEeyXMV2JLkYRg/pjr9Ku5
 wVgDk+PAHGr8qjiD/WRDAgNvv5biXuo2QegAh5wXdJa8ccmjWrSLsx3lGXLksEw2luw6w0R1gJQ
 5+0+3TKUmRQTGE2J/dqzuLponY709g==
X-Proofpoint-ORIG-GUID: ZRGeFkzL1x0Bsmz8i6rOZGNvIuxjBfis
X-Proofpoint-GUID: ZRGeFkzL1x0Bsmz8i6rOZGNvIuxjBfis
X-Authority-Analysis: v=2.4 cv=cKbtc1eN c=1 sm=1 tr=0 ts=68e65959 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=-ept-RJRzOG-hoP0ccsA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510070146

On 10/8/25 11:04 AM, Md Sadre Alam wrote:
> Add device tree nodes for QPIC SPI NAND flash controller support
> on IPQ5424 SoC.
> 
> The IPQ5424 SoC includes a QPIC controller that supports SPI NAND flash
> devices with hardware ECC capabilities and DMA support through BAM
> (Bus Access Manager).
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---

[...]

> +		qpic_bam: dma-controller@7984000 {
> +			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
> +			reg = <0x0 0x07984000 0x0 0x1c000>;
> +			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_QPIC_AHB_CLK>;
> +			clock-names = "bam_clk";
> +			#dma-cells = <1>;
> +			qcom,ee = <0>;
> +			status = "disabled";
> +		};
> +
> +		qpic_nand: spi@79b0000 {
> +			compatible = "qcom,ipq5424-snand", "qcom,ipq9574-snand";
> +			reg = <0x0 0x079b0000 0x0 0x10000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			clocks = <&gcc GCC_QPIC_CLK>,
> +				 <&gcc GCC_QPIC_AHB_CLK>,
> +				 <&gcc GCC_QPIC_IO_MACRO_CLK>;
> +			clock-names = "core", "aon", "iom";

1 a line, please, also below

> +			dmas = <&qpic_bam 0>,
> +			       <&qpic_bam 1>,
> +			       <&qpic_bam 2>;
> +			dma-names = "tx", "rx", "cmd";
> +			status = "disabled";

Is there anything preventing us from enabling both these nodes by
default on all boards (maybe secure configuration or required
regulators)?

Konrad

