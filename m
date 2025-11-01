Return-Path: <linux-kernel+bounces-881188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CF83BC27AB3
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 10:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 85E974E40C0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 09:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8EF2C026A;
	Sat,  1 Nov 2025 09:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fvOjFWuN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GlfO9Sdc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AFD1D5170
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 09:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761988742; cv=none; b=jP1qZT9aCS/qn8ugpFG2UxhvA6q3sHs1QRvHZjP/CFVKowOBRu5YE3oTJhB/P6pT0c0GC02Rl/bFr/3dnAOx9vLwmnMWW9gKP4IYq2eBpdCoXdcPMyxCzlczFFUNvBu3gIBQ1HySFoGC8z+kQ7sHYcB7VlagBQ4bcKMxqiK6eOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761988742; c=relaxed/simple;
	bh=VpWYb0GBHZvP7olFcbzqJupOGkhU07xedBtpg5E3AlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aI4ZHk4QTaZ1YPqp2ZseEqBis1yvC0ABtQuHyvCzYMbnzJrHtzSGuJMlolziSSIEwjLzialvobWOrQhhqxPEiuwK6O7BqXZgApbEmwMtB9WAdpLBfDOgfiYNAQwUTrRtAOoSSB9e/7PCmpCeuooeSKoVmCoG4l1UP0BqH0mdwvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fvOjFWuN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GlfO9Sdc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A14lhfm602066
	for <linux-kernel@vger.kernel.org>; Sat, 1 Nov 2025 09:18:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=B+bpAKUc3ZHIXmPuXhpnOMle
	Il6MBiJm7MdnfHBg2IM=; b=fvOjFWuNpYCpyelIV1lFlH95qSGA9Yd5tv/N2sqI
	EptG1NtmlPGxSJ+Nj23SvjaHML3YycsafMJ52vAa4E6fhSHPUCgpU7kM9R5JaurC
	ScYlJL6Kda3j2hEhPHHLwm3TyvviBgoVYwxjTXMxo9ARrmZ6ibuqQMTFFtcAJGyP
	q5nShEhJWy5/KQzd3geHhA5HruSpgIinPTQ1/ouI4D7jllNJCrQemgwyzIjY6nZb
	LtqEvpWE5UIaTCvcdP7jRNNu+4HCODeN+CD91RauASylVHPdbHOg3jlO8HyDqLex
	yMD86Ru4jNtlKmL/IlU3rr/2rF9AS/w0k+6ECwHdEO/Ygg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a5bg9gaek-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 09:18:59 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ecf8faf8bdso33231621cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 02:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761988738; x=1762593538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B+bpAKUc3ZHIXmPuXhpnOMleIl6MBiJm7MdnfHBg2IM=;
        b=GlfO9Sdc2TB5bZgLt0vdIxQcY85VOM7exB6S6UN4eRKyN23qutEu178QuWQqOrBCXi
         6BQF61ihZ9M+2YUbhYNcctAF3qzvpCD/vVJo4sRsJcYXL8358ZYXoAO5XEb7td+cvdUh
         avYtAhpihdiDHPdqxmx++eTcw8qIbsOLkEIXxG+dI69OUoCrosPHKitA2s6HM6bTVXS4
         QQQT/YC2g49ypPrMRtCw2prgkb6HvWtdz5cPchYvgwjHUz7dYN/OG0m2Kc0MMzhrcN9v
         IzS5v8mDKl6Jq/1JngVdOVGsARmsUOlLUIxfBofaDcNuoXEQgBV+cSKAZSzJNntm1Cqs
         cNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761988738; x=1762593538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+bpAKUc3ZHIXmPuXhpnOMleIl6MBiJm7MdnfHBg2IM=;
        b=WIdJs+vKX70hRmNyOjTzqKMagE8c1PITjH6sDDF5KYGNafTa2lsTswkWQRPNLVqpQj
         DVBcGDsm4VkLMLGiM1mr0uBR8vnXyPI5C4iO6Z0GtlO2dGhe7Te7HB2i6jSyJ7qAnXKE
         ++qcXeLGrKtp135m3ffEL9W1LU9NTx8ichSgUEBIuJWjwbZpjWy+EG9cXPms/dzVbWiT
         vF8zxvkYPVjdCOBth6INQqy7pI+cpHEjo7YhK5f8Ek63uV1RYMMmzLZmzbJUqe/yn3yZ
         5NfpcNPYVyuUunkJQueOU1GNDWn5F7Qk2HK8rWtqCH0yX/nP1LdADvq27ZRnFjAEZBET
         3d0w==
X-Forwarded-Encrypted: i=1; AJvYcCXcueLVEXxiy5a4KfdNNbga1MFX/G/yhRN+8UCsKglpHpQa0mjWFJc5FzgcyhDf2ol/fB1zBKpHgJw8Ru8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy76htA/7kZwC3N63woJO26CXiWNuhduoGwOgkHLpdKJXlXfOHt
	n9MGbs/L36mVjVEnysGjHg5lyANeBzfYUjrDpbCf8cIPdpktM7ql7UUgRgOeV6KtSGVT1y0Nz7X
	CJJ5a86bOZ+OfLb79Ki3pPsPCakoDuvkyjqA1ek9L86ivPeVqLp5q4e5r3OJV+zDEW+o=
X-Gm-Gg: ASbGncu54zwgMzkqXr334TTxwxUpzq1A9/5YYItyN6rhzXKDbPq24nLaerz8rUnVVr1
	9m+za+d4FiS8yd4ViGecCD6Omse+k+dSBZ8n4PALdd3WwmtKHi1Q4IlhI3bO9eM4HRH6plbI4sz
	yMDrT6x8eaNPg1xwWu1Yh6oUCZn4WkxVD2v3oOvGiR6wdwpkeGHRlNBUSI4XACUfhktIHAYdhgT
	iPN5FxBr0svDlJ/Gki/61gLju8OvsHC5x9+75lrgRh/DUnUVP20TIUJGBeZUlBPgxP4ttPWyZAB
	xEgIgMq/qyBYEPpGfE8iEkJcKLcKkhMOuIWoMwBJobEF5lbEoxQicQWYEtMU2tGhSh0JDatFXJl
	mic033ozXe5n286zPwpWx3jMpzEKM0HLvuYFE3YJJ7zrtCX2rx1HTwvnobRO/At/DqQG4Io9Hf9
	4hjtJeGCzxTEmM
X-Received: by 2002:a05:622a:134b:b0:4ed:1dc7:e3de with SMTP id d75a77b69052e-4ed31025a3cmr93383541cf.67.1761988738022;
        Sat, 01 Nov 2025 02:18:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/ZC9hJig1xqZrbF6M8bbhMPgx0iojM3JAN3ePV98F8Rm9zEys8LTFYeIZIvoosK3Z9UrajA==
X-Received: by 2002:a05:622a:134b:b0:4ed:1dc7:e3de with SMTP id d75a77b69052e-4ed31025a3cmr93383341cf.67.1761988737536;
        Sat, 01 Nov 2025 02:18:57 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5941f5b5a5dsm1076632e87.56.2025.11.01.02.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 02:18:55 -0700 (PDT)
Date: Sat, 1 Nov 2025 11:18:54 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Amit Singh <quic_amitsi@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_riteshk@quicinc.com, quic_rajeevny@quicinc.com,
        quic_vproddut@quicinc.com
Subject: Re: [PATCH] arm64: dts: qcom: qcs6490-rb3gen2: Use 'edp_hot'
 function for hpd gpio
Message-ID: <a6fbpfulyhbnfoy2d6wf7hl6de3z34gxcu6f4lby7ncsyu3f2g@q6qcvdid7bko>
References: <20251031085739.440153-1-quic_amitsi@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031085739.440153-1-quic_amitsi@quicinc.com>
X-Proofpoint-ORIG-GUID: mzzDuJJwBk8hgMFlnhcoTlLq1r5hAfJs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDA3OCBTYWx0ZWRfX8T/S8W5r3Dkn
 bPXKxESOveI9nvzjp8wZWVWOMH2CSJ+Bz7gOcvZZa+erRqMfOw69xyvQg9K06NlMhu/E9jL3gDw
 NQ6hbGu5nBamyXR2FW2VTMJNxDKvzVv8K7MPk0kL/53hxXWZnhHqboDEryjqDxgha1rc2DgylLi
 JiPpj1NNsnVmgPk1kyCSri9g8MDPe/ypHYhflT4S6mGcaR9Qihp7HEJ4TFcFjzUYsaCyBcskXws
 JmSB8TYm6IYMk8wlEXh3O5tfYV7ygtV77AeFshO+JTIYmVipa8uAN9qZBbsZbafj72Src25F25B
 Fn2yr1EBo6BG/zfyQx3VnEtKA0/MyDtZPRewcLarzsIIayoYWoHRbLQzPj17XoVxi2LOFHxd8lx
 G7XPJydZbGCOEAtGTYzgpmKCwcGaMA==
X-Proofpoint-GUID: mzzDuJJwBk8hgMFlnhcoTlLq1r5hAfJs
X-Authority-Analysis: v=2.4 cv=TaKbdBQh c=1 sm=1 tr=0 ts=6905d083 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=JMR9WPqkSgFmUmKnNZwA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-01_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511010078

On Fri, Oct 31, 2025 at 02:27:39PM +0530, Amit Singh wrote:
> Currently, hpd gpio is configured as a general-purpose gpio, which does

HPD, GPIO

> not support interrupt generation.

This is not true. GPIOs support interrupt generation.

> This change removes the generic

Documentation/process/submitting-patches.rst, see the paragraph around
"This patch" words.

> hpd-gpios property and assigns the edp_hot function to the pin,
> enabling proper irq support.

What for?

> 
> Fixes: 756efb7cb7293 ("arm64: dts: qcom: qcs6490-rb3gen2: Add DP output")
> Signed-off-by: Amit Singh <quic_amitsi@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index c146161e4bb4..caa0b6784df3 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -49,8 +49,6 @@ dp-connector {
>  		label = "DP";
>  		type = "mini";
>  
> -		hpd-gpios = <&tlmm 60 GPIO_ACTIVE_HIGH>;
> -
>  		port {
>  			dp_connector_in: endpoint {
>  				remote-endpoint = <&mdss_edp_out>;
> @@ -1420,7 +1418,6 @@ &wifi {
>  /* PINCTRL - ADDITIONS TO NODES IN PARENT DEVICE TREE FILES */
>  
>  &edp_hot_plug_det {
> -	function = "gpio";
>  	bias-disable;
>  };
>  
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

