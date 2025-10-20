Return-Path: <linux-kernel+bounces-860857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 787ECBF1296
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B93B04E3143
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B69D3128D7;
	Mon, 20 Oct 2025 12:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QZde2LkU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA608311978
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963241; cv=none; b=DrMeLwSTC+UFsPt2zykt13V5mDTzRviErxLmnjxI+qp0zpVZj5jphj2h7vU1oGWDkpudk1cVrDNe1nwk8EfPBZIqnlWsVIN+I+K98rVSguaWJq9p5oM3+f1criwVRjm2/iTBlDzOhuDUOe1+YzsFCc0mVKKpXopuNkvRrnDaQwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963241; c=relaxed/simple;
	bh=EQq+kUGZ6/zTFwt1stzUq7yNuv4FsBcmBa1ZHergOaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XYTipAX9Z0PBklW6ZMHuEcpzS7XPA2eKbPZe/mQnio7T8cl7gZ37AWxJqtJ1133rkhXrggj1d2fqGTEkIDux046xdV10khpTOYg0eACh4CUPtsiiuyoivOTF1u1UqJKjiKTbaV2YhErfWB5zHUp6py+6lVTVsV0QCzFF6pNDzLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QZde2LkU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KCA4iX016504
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EJikePWqy0tCQGU0F8IOeREMGe4Yit4HwOUigKort0w=; b=QZde2LkU1+U3acp3
	uFill/SXMV+560TMAme9O7GndBG7Cegcs+S30jJjMk6FOHBUDUQXmxmdlUAF0NVF
	Tu1by+E7aUxxGad6KYsNvy7U9QQwt/RZ1IIxspgG5QTL4FnvG4cV9s3NDvWLAMK9
	sPoWbf5QR6zaUdcylv+wg6jHN6QPGGTByA8tDA1BfdOdK9c/rTuqzkvP7dWydgdf
	DlRYUBbTA6GMPWVWpOZ59rlhrZMxRiowtzCtcA/4WZxOe/x0Xn/eFasQXFEsbI+Y
	ew6Qch1b7rx0axr6D0iW6DzbKohlBAvb8nQ16Y3jOgWqmQMPtsHVUGVh8yXtu733
	tJpQlg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v1w7vsgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:27:15 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-87c0e043c87so19122186d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 05:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760963235; x=1761568035;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EJikePWqy0tCQGU0F8IOeREMGe4Yit4HwOUigKort0w=;
        b=Y+jZ30+dx+Y9Neji1Utc95jpqSp1eWoYOHh2XLKp/WWTrEyxzkSo4Hv1GdQdMQYzXF
         cjh6CeFwbOP9if+8w9pJFRwVcQ3Ykg72sBIV4DzeWYkbi4arydDzd/cC36YD9Z9BF8KT
         0uGIxMyi06a1BdmZhIi075ch+GJV6T3XtTEfaWxR9zJumO5wmK6F+SbILNsdHfhALKCg
         XegNL8oiHeyRUzJ4qPUbjasUNIVfCA5zh3lE6N8Fa0uOwf0zxPrboHTSNqv92spsNR6+
         LYwIs7P3ZwX0AGIxK6cyPxbz+BblC0BwkAwcXgtVpJgumD8Jbk3l7ZGh574yUQp2X5W8
         fbPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzrY5s8Gck3NR+BHhC6oOm9Oy/OM70E31HaX0Bsy9CBnPiYhcH1O14xptC4z9FkXM/bCfY2/IG7VjoNMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3TFwI3+lWSXCVQP2ysYui+vO3QpoJhP76DuYIx0H0XBX+7PoH
	lLUg5aBuuKcbJR/o874AWHiocWDlfYUzxwqzjSgthW8edSfuxbZKJemVmjbvBp9DsX4iakH/8H4
	E22o45YzGVpGpOrtl2qoaR9CXQgc1LLaX2Wx8WAnvsJDZpSkIy8LKrlC2arojszL0LvM=
X-Gm-Gg: ASbGncvYeeyaf2hOlQPYuheP3iGCI2uXLsvJXLv6kcFjDZ0JSRZl/TZCsS/swnkSoTQ
	sPC5F8N6MxcbqHT64CZ6rCUilbgJGBguOS+TlrqtSUysgjB3HyKNQ6QkbwP/kcdz9LqKNexb3uo
	iT5g3oczQfXl96uxaUORCqVjbAZ7zpoS4xRueZIPPExjLAZvj3dbtWZbSYIXVzV6zUyCl71xW1b
	GvrJTU94dm4CxvMFVPCPH/p19f9n9qnrA4RPN98ulf9/lrouvCTrSNXs6/DVpfg+AazPAD2FAR3
	dKUT2a8yz1h/dCsMzpaMXLi4+Nc0ySftsrP8p3gicB+O1fxUtE/zT/xVrtGYD1UDhuwNs5oTo6E
	TnSeIIrF2qJaL6bsSjidpy1iJyjakxXYsMOUyomEYZToe7MkW7DAKX/nX
X-Received: by 2002:a05:622a:164c:b0:4d0:3985:e425 with SMTP id d75a77b69052e-4e89d30e815mr106997891cf.7.1760963234599;
        Mon, 20 Oct 2025 05:27:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnRSc0gX0xF3iPNiTo9blxag/0ZjyTcEbZyOP5gC7t0dOrIBiJtT6Xid+ZqFQvGdsGzYk5Yg==
X-Received: by 2002:a05:622a:164c:b0:4d0:3985:e425 with SMTP id d75a77b69052e-4e89d30e815mr106997591cf.7.1760963234020;
        Mon, 20 Oct 2025 05:27:14 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c4949998csm6582475a12.38.2025.10.20.05.27.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 05:27:13 -0700 (PDT)
Message-ID: <c605434b-b0f4-4a9a-8b28-cf1c77d5f20f@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 14:27:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sdm630/660: Add CDSP-related nodes
To: Nickolay Goppen <setotau@mainlining.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux@mainlining.org
References: <20251019-qcom-sdm660-cdsp-adsp-dts-v1-0-9ab5f2865a6e@mainlining.org>
 <20251019-qcom-sdm660-cdsp-adsp-dts-v1-1-9ab5f2865a6e@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251019-qcom-sdm660-cdsp-adsp-dts-v1-1-9ab5f2865a6e@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxNSBTYWx0ZWRfXxbfqNNykjcXl
 iVThER+CvjtPJ3sufd/Oni6j32Gb9jLaM4fYjJkmXUmVUfgu47fzlKT0lLg5ISibr9P9b6KBECt
 tN0DQs3iC9GMfApMsl0dwQWMBdE6ddYLtFVTbZR+roHxMb5qZD6by8o+a4ijT7ssrOorjqV7P+t
 wXfp8qRL9Djdd3hEGct2anQgUurgde6J7agoFr/yKCq4zUZnO5wVZqqFxz4rsBFqjxtiIyGfJAg
 yaA2CA5cL27aKD2lCMOEc9l+LbjTTVKYr2l3tcovYaKp3MWxBOaiQA6AJPMx+CMUG6AV3dDtrg6
 nr0cXUAEyIVnXwY+2Yy1YQSYluuoJW711KVCCX+bfWYJi/IczUZ+UHkJe5YZxFzYxDgF5nKS1Jg
 WQAKIvZKWtYM/DW3oAtGBN3mljcVPQ==
X-Authority-Analysis: v=2.4 cv=bNUb4f+Z c=1 sm=1 tr=0 ts=68f62aa3 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=OuZLqq7tAAAA:8 a=sATdV5nvz0x-xMse27EA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-GUID: D7-5ko5H4VhJB3idxgSgxs1ZeoZKFuaS
X-Proofpoint-ORIG-GUID: D7-5ko5H4VhJB3idxgSgxs1ZeoZKFuaS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180015

On 10/19/25 6:27 PM, Nickolay Goppen wrote:
> In order to enable CDSP support for SDM660 SoC:
>  * add shared memory p2p nodes for CDSP
>  * add CDSP-specific smmu node
>  * add CDSP peripheral image loader node
> 
> Memory region for CDSP in SDM660 occupies the same spot as
> TZ buffer mem defined in sdm630.dtsi (which does not have CDSP).
> In sdm660.dtsi replace buffer_mem inherited from SDM630 with
> cdsp_region, which is also larger in size.
> 
> SDM636 also doesn't have CDSP, so remove inherited from sdm660.dtsi
> related nodes and add buffer_mem back.
> 
> Signed-off-by: Nickolay Goppen <setotau@mainlining.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm630.dtsi |   2 +-
>  arch/arm64/boot/dts/qcom/sdm636.dtsi |  14 ++++
>  arch/arm64/boot/dts/qcom/sdm660.dtsi | 152 +++++++++++++++++++++++++++++++++++
>  3 files changed, 167 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> index 8b1a45a4e56e..a6a1933229b9 100644
> --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> @@ -563,7 +563,7 @@ modem_smp2p_in: slave-kernel {
>  		};
>  	};
>  
> -	soc@0 {
> +	soc: soc@0 {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		ranges = <0 0 0 0xffffffff>;
> diff --git a/arch/arm64/boot/dts/qcom/sdm636.dtsi b/arch/arm64/boot/dts/qcom/sdm636.dtsi
> index ae15d81fa3f9..41e4e97f7747 100644
> --- a/arch/arm64/boot/dts/qcom/sdm636.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm636.dtsi
> @@ -16,6 +16,20 @@
>   * be addressed when the aforementioned
>   * peripherals will be enabled upstream.
>   */

You can now remove the above comment ("Turing IP" is CDSP)

> +	reserved-memory {
> +		cdsp_region: cdsp@94a00000 {
> +			reg = <0x00 0x94a00000 0x00 0x600000>;

One zero for 0x0 is good

[...]

> +&soc {
> +	cdsp_smmu: iommu@5180000 {
> +		compatible = "qcom,sdm630-smmu-v2", "qcom,smmu-v2";
> +		reg = <0x5180000 0x40000>;
> +		#iommu-cells = <1>;
> +
> +		clocks = <&gcc GCC_HLOS1_VOTE_TURING_ADSP_SMMU_CLK>;
> +		clock-names = "bus";
> +
> +		power-domains = <&gcc HLOS1_VOTE_TURING_ADSP_GDSC>;
> +
> +		#global-interrupts = <2>;
> +		interrupts =
> +			<GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>,

Please don't break the line in this weird way, put the < right after
a '=' followed with a space, and align the '<' below one another

> +			<GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>,
> +			<GIC_SPI 533 IRQ_TYPE_LEVEL_HIGH>,
> +			<GIC_SPI 534 IRQ_TYPE_LEVEL_HIGH>,
> +			<GIC_SPI 535 IRQ_TYPE_LEVEL_HIGH>,
> +			<GIC_SPI 536 IRQ_TYPE_LEVEL_HIGH>,
> +			<GIC_SPI 537 IRQ_TYPE_LEVEL_HIGH>,
> +			<GIC_SPI 538 IRQ_TYPE_LEVEL_HIGH>,
> +			<GIC_SPI 539 IRQ_TYPE_LEVEL_HIGH>,
> +			<GIC_SPI 540 IRQ_TYPE_LEVEL_HIGH>,
> +			<GIC_SPI 541 IRQ_TYPE_LEVEL_HIGH>,
> +			<GIC_SPI 542 IRQ_TYPE_LEVEL_HIGH>,
> +			<GIC_SPI 543 IRQ_TYPE_LEVEL_HIGH>,
> +			<GIC_SPI 544 IRQ_TYPE_LEVEL_HIGH>,
> +			<GIC_SPI 545 IRQ_TYPE_LEVEL_HIGH>,
> +			<GIC_SPI 546 IRQ_TYPE_LEVEL_HIGH>,
> +			<GIC_SPI 547 IRQ_TYPE_LEVEL_HIGH>,
> +			<GIC_SPI 548 IRQ_TYPE_LEVEL_HIGH>,
> +			<GIC_SPI 549 IRQ_TYPE_LEVEL_HIGH>;

It would be neat to match the order of properites for this type of
node to e.g. the rather fresh x1e80100.dtsi, so:

interrupts
clocks
clock-names
power-domains


> +	};
> +
> +	cdsp_pil: remoteproc@1a300000 {

"remoteproc_cdsp:"> +		compatible = "qcom,sdm660-cdsp-pas";
> +		reg = <0x1a300000 0x00100>;
> +		interrupts-extended =
> +			<&intc GIC_SPI 518 IRQ_TYPE_EDGE_RISING>,

(same comment about line breaks)

> +			<&cdsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +			<&cdsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> +			<&cdsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> +			<&cdsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
> +		interrupt-names = "wdog", "fatal", "ready",
> +			"handover", "stop-ack";

1 a line, please> +
> +		clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
> +		clock-names = "xo";
> +
> +		memory-region = <&cdsp_region>;
> +		power-domains = <&rpmpd SDM660_VDDCX>;
> +		power-domain-names = "cx";
> +
> +		qcom,smem-states = <&cdsp_smp2p_out 0>;
> +		qcom,smem-state-names = "stop";
> +
> +		glink-edge {
> +			interrupts = <GIC_SPI 513 IRQ_TYPE_EDGE_RISING>;
> +
> +			label = "turing";
> +			mboxes = <&apcs_glb 29>;
> +			qcom,remote-pid = <5>;
> +
> +			fastrpc {
> +				compatible = "qcom,fastrpc";
> +				qcom,glink-channels = "fastrpcglink-apps-dsp";
> +				label = "cdsp";
> +				qcom,non-secure-domain;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				compute-cb@5 {
> +					compatible = "qcom,fastrpc-compute-cb";
> +					reg = <5>;
> +					iommus = <&cdsp_smmu 3>;
> +				};
> +				compute-cb@6 {

Please add a \n between each subsequent subnode

LGTM for the actual meat and potatoes, nice!

Konrad

