Return-Path: <linux-kernel+bounces-854536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43017BDE9EB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28CB81892C52
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF72326D73;
	Wed, 15 Oct 2025 13:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DB6qsVum"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AEA321421
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760533455; cv=none; b=pzWpFGAOADM6N/y2HMbNqiZ/2kRrMQ9no12ek5aJqOgT/ghFb8S/lWJuuP1RAJUkSjvJnLv+564+zthqLnBec9xGF956UJ/k/JzW+Ayxa8+KV48dZkLm+sBelFKl7CkrmL65YANYj+sfKBVtzA1Vg5w45N20YcK4TpRNXKX/BTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760533455; c=relaxed/simple;
	bh=b4Z+2kCXQ06dTUoVr/Yo2GI1CjYUUAo6eQ+cCxbPpmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCYodAkCDGdDmzK9jNsjWuhDua65LFZ8DvnQzd/rIk09Cx5uqMdsVPnW8AnFi7u9eQmhfvjdyiiZudS4ouxiCl/oUiIhgdNQT4FYuyi9ktcjC/WlAN7JndW0MIs7lS/fJhGVTa8gCk3lAXKEkvwVjq8InQm+9QE3hjSGIascPyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DB6qsVum; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FAUNhV003544
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=wOxtkt7XNtAF+fNsKokkDiRs
	zjGDLcWBT1cZVg386fg=; b=DB6qsVumdbsoZJi0q4FYx+LYyEM7NjFj/3Mossxk
	+XDF8Hh32g/HQsrqELpb6cE8dXFbgBT7KlYkuf4/5TGwV7Wn2DCoa5QCV8diMgEA
	Oizj3HveJRzx8tthkFrGq1PVUatZ2gN1sD/uOX0P0ow2+62OZB9Tp9MUoE6pfN6E
	DmTgGcUbLU74+/msBRw8DmM8Utpo73PKbU4b1Nm40WV/gFQB1Sid9qRJeLtkt9wp
	1NaPG9JiLrjQEwURlD22mS949TexTs7QmHVLch+lMf+mQqL0gKTcj6wg87ALyJom
	4nPYRWLrtNsW29hGbHtbm8ugaJvAQ081wstY8IokwMlfaQ==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49sua8k2fc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:04:11 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-73934dd7a22so121823377b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760533451; x=1761138251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOxtkt7XNtAF+fNsKokkDiRszjGDLcWBT1cZVg386fg=;
        b=G3ZSpCLrLo5BsR41XxzA/fRWb6Z1N6/VcyH5+DV/h58UaksNHhuUnb6JM6ympssEH6
         mT7pNS2HKWNtTc+18uhvr7JdhBxG/Vhw0WcD5eI0YxgFCvjtywmsPtdIfBN1xk6G/8bK
         w3uXqnO12y3CNO1kM9KkqLCRMrJjPutYMwyjjP7bD6avdU5ygNXgSj5Ak7iPjxodgIOC
         DueO6aZuyuC55c+YTPS1nS9ITcZHSOJAHLkWay8438jzpo44VoK+V4WK9ZEixDmi1Hnr
         4Alb2OPWXP20YzF3WwOUxItklQsXIAPawxwslqpX4FXwSxy5VB/KHXcXv9A14IioFpku
         oLMg==
X-Forwarded-Encrypted: i=1; AJvYcCW2eu9nrAxgg15A4d4GnAjwAVXlsBxqPiuI3ONy7thEmbAaIZB/T5XrtgL9x81HmnvF06cnAG9F308m1Rs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2kjpyDWdbodiADSaWUJLr17ml6Fm2BQHXX2gglnSsPEo5S2r/
	Ewl9BAUI8JpkBORMaMSMsjq+JNCIop39p8w/pggFYcRQosur+n82Aal5e5pXEChn9cU+jbyCbuF
	v0gMOZYdFVEoYReiZvnaShkwgViPjIG6ceRNCL954oKQIhiRQXXKDmxMqjuOtTqhqHmY=
X-Gm-Gg: ASbGnct08Rr6CdEi4WtJ2I/SZo4m0DzmR5mxvj2fqbV1r4a+N1WVoOSxGhie6fOAefE
	H96Y8gbl/eOHSP/7ge7fOeqXbB8G1N7GtxNN+d1lGfsEFd4C4BSQfpduOON48pUCIVUKKVyfhC4
	MYg1NbzrEa7XqJtJ8umxRLjwYUvNpFmLfkHTJA2NYUzjLBLbV5/7x16h43GM0vFpR/IQE2A1NkK
	xqG+1lxB22RtbvQ/GyB9DciBOOMJcjY/KLVfFMW6lJILiQDiZFOGqzRkbtjEGxGTvogORhC1ouW
	SR9Fhl4uoKHqsMxfmzUOFCtUNC7ZddZnTbes9sVCy4TMyHnANmMx8vNUCX7b1igEJHnHv0lypbk
	Y6LeE7NAGqnjT+CcZOjk9MNkx1f5iU/YS7pu7QzXMQple6LP5rfDsg06MDWGNJM+T7He4B7kLxU
	QvIHlmYxpd0wA=
X-Received: by 2002:a05:690e:1557:20b0:63c:efd6:c607 with SMTP id 956f58d0204a3-63cefd6ca19mr13123301d50.3.1760533449814;
        Wed, 15 Oct 2025 06:04:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5Az03cIeX6jAKim1Y6OpSzpqgIz3WsG/1vJDxt9LC2vpCqHgl2aTiXSs/Zi9aDo/PKtvh3Q==
X-Received: by 2002:a05:690e:1557:20b0:63c:efd6:c607 with SMTP id 956f58d0204a3-63cefd6ca19mr13123235d50.3.1760533449058;
        Wed, 15 Oct 2025 06:04:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59088563d19sm6208728e87.63.2025.10.15.06.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 06:04:08 -0700 (PDT)
Date: Wed, 15 Oct 2025 16:04:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sudarshan Shetty <tessolveupstream@gmail.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: qcom: talos-evk: Add ADV7535 DSI-to-HDMI
 bridge
Message-ID: <53ef53b423uespn7xspqfxnnvqvhzb5b22a4oaimf6g2qy7ruo@273oegazxbaz>
References: <20251015122808.1986627-1-tessolveupstream@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015122808.1986627-1-tessolveupstream@gmail.com>
X-Proofpoint-GUID: _iDyMbOYtkUsvPi8kaKXg6jKCLCzCkGe
X-Authority-Analysis: v=2.4 cv=e5MLiKp/ c=1 sm=1 tr=0 ts=68ef9bcb cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8
 a=Mdf5GqcyFXJwrPG7iDEA:9 a=CjuIK1q_8ugA:10 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDEzNCBTYWx0ZWRfX2ADBEa0S29HV
 jc5vRcgpfoou3L+gvIfqFGa34ShdC/IlU3l9bX0/UgNdeAXM5n6oHW4Ss6z5Zf2HAHPvQ9qdoWX
 v6LTQPMbIIl3aXfA6LKce7WbyaZSruQUyTrsduOJw8fqh5AVjtwdB3rTQvYTpwcoRJoJp0bTLtC
 KS2tHn7cb3YrOydj0cfB+pUIFlbkOin9mSaCDdnC0plOr2Oh7K7KTARBATRZYBn8sHADmlXWcQx
 GhQxzl3Q2h5MpC7Y2jPgJtdSHbbH5SYubqsUnb18tVO5TXKAyGUnWbzIiwaTA3nTXcc9pGb/4mh
 Qq31MOOyE0rcvO7ulvc+Q7V2zyxwb9cHHxyip+1UkT+sISSiFxb5zPKUgDRyk96Jk8LgvCBU8G/
 rSqqs81kJrOhto7W5l/RYowy7zq/nQ==
X-Proofpoint-ORIG-GUID: _iDyMbOYtkUsvPi8kaKXg6jKCLCzCkGe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510140134

On Wed, Oct 15, 2025 at 05:58:08PM +0530, Sudarshan Shetty wrote:
> Hook up the ADV7535 DSI-to-HDMI bridge on the QCS615 Talos EVK board.
> This provides HDMI output through the external DSI-to-HDMI converter.
> 
> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/talos-evk-som.dtsi | 21 ++++++
>  arch/arm64/boot/dts/qcom/talos-evk.dts      | 76 +++++++++++++++++++++
>  2 files changed, 97 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/talos-evk-som.dtsi b/arch/arm64/boot/dts/qcom/talos-evk-som.dtsi
> index 55ec8034103d..b58cae02c9cb 100644
> --- a/arch/arm64/boot/dts/qcom/talos-evk-som.dtsi
> +++ b/arch/arm64/boot/dts/qcom/talos-evk-som.dtsi
> @@ -244,6 +244,27 @@ eeprom@5f {
>  	};
>  };
>  
> +&mdss {
> +	status = "okay";
> +};
> +
> +&mdss_dsi0 {
> +	vdda-supply = <&vreg_l11a>;
> +
> +	status = "okay";
> +};
> +
> +&mdss_dsi0_out {
> +	remote-endpoint = <&adv7535_in>;
> +	data-lanes = <0 1 2 3>;
> +};
> +
> +&mdss_dsi0_phy {
> +	vdds-supply = <&vreg_l5a>;
> +
> +	status = "okay";
> +};
> +
>  &pcie {
>  	perst-gpios = <&tlmm 101 GPIO_ACTIVE_LOW>;
>  	wake-gpios = <&tlmm 100 GPIO_ACTIVE_HIGH>;
> diff --git a/arch/arm64/boot/dts/qcom/talos-evk.dts b/arch/arm64/boot/dts/qcom/talos-evk.dts
> index 25057f4f6a91..f7e8be3667d1 100644
> --- a/arch/arm64/boot/dts/qcom/talos-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/talos-evk.dts
> @@ -14,6 +14,82 @@ / {
>  	aliases {
>  		mmc1 = &sdhc_2;
>  	};
> +
> +	hdmi-out {
> +		compatible = "hdmi-connector";
> +		type = "d";
> +
> +		port {
> +			hdmi_con_out: endpoint {
> +				remote-endpoint = <&adv7535_out>;
> +			};
> +		};
> +	};
> +
> +	vreg_v1p2_out: regulator-v1p2-out {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vreg-v1p2-out";
> +		regulator-min-microvolt = <1200000>;
> +		regulator-max-microvolt = <1200000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	vreg_v1p8_out: regulator-v1p8-out {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vreg-v1p8-out";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	vreg_v3p3_out: regulator-v3p3-out {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vreg-v3p3-out";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};

Please describe the power grid. Are these regulators being fed by
nothing and generating energy from the thin air?

> +};
> +
> +&i2c1 {
> +	clock-frequency = <400000>;
> +
> +	status = "okay";
> +
> +	adv7535: adv7535@3d {
> +		compatible = "adi,adv7535";
> +		reg = <0x3d>;
> +		avdd-supply = <&vreg_v1p8_out>;
> +		dvdd-supply = <&vreg_v1p8_out>;
> +		pvdd-supply = <&vreg_v1p8_out>;
> +		a2vdd-supply = <&vreg_v1p8_out>;
> +		v3p3-supply = <&vreg_v3p3_out>;
> +		v1p2-supply = <&vreg_v1p2_out>;

I think this is not correct. Please consult your schematics isntead of
adding dummy regulators.


-- 
With best wishes
Dmitry

