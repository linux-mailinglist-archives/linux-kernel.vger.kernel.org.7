Return-Path: <linux-kernel+bounces-779517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0223B2F519
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 852937AFA3A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D2C2F1FF6;
	Thu, 21 Aug 2025 10:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BLWEMZoB"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67DD26F476
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 10:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755771572; cv=none; b=tQg07uo1W9VIj2p2tpO+Bn9rVE5Dt8jnQLC0J+vq4vOLVQKBa/P1wBMVWRNqFOdj7itGn1YgHUWl2+Vne5JJegZ9EyOi89AAd0PYSFSwvAsz3vAR0gzbGPLRh+rQunbc6AC5kc3uIUYhKqsLuWRlF2fUtAbmOKvMzjM5/J8YC/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755771572; c=relaxed/simple;
	bh=8U+1N8shakGM/vV89T8/5P0L7ugNzq0oe+JNJ1XQQ6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTgJr3EspWquSPesbmKazXgWoJZTPo3wesAJQwlHM/xyWlGrnjUs60NQzPySHavzFetY2rdnPyBELUY2+KfZQAxnTRLao73fCPs9qNJ5pGKQ7Nb4D7QVF4hGJx4XD3TOPe1WHBY6iHIgBugU+bRrKLUehq3p75iZ1CLUbATrSlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BLWEMZoB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L9b6Un014666
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 10:19:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Uoq3hV35IcU7uY4Ov76moRej
	5YDOR8ZK6zl7rWMs9yM=; b=BLWEMZoBa8sTAGbVhorRYwP0QTfGVF7nluuj3RWr
	1ACssFpLK0HoWvU3B5GM+bl0pClPsW6HfuMaTb0ZAB36nj5ovnlbyfZggBtHf/14
	NuILvpl1PqMAIkKozlPnfifIgsAYx/ml1QudZ+LOS+j2yaiGJK7zbmPxC7L+h2sE
	l9NPCVZHhGtT8rfryvh4X8phHH6Yop8DwflMLNpLIIVqeRbH7cFblFA2/XqxL8h4
	K8c1ImBRrhdPkrJ7f/aIaPTN8SBEeAjgaqb6TVh1v3os4nfBFrPiYuMMTbryDp+s
	xDIVP28XwSV8b3PuE/i+FXsrIVfrxqsiBzhn/Ogha1cRBQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n528w0e1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 10:19:29 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70a9f534976so26387076d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755771569; x=1756376369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uoq3hV35IcU7uY4Ov76moRej5YDOR8ZK6zl7rWMs9yM=;
        b=Da6A0Rsp2gtDzYo+d3eZMVqCO6ShXV3rCFtYN9DeuryEFzVOQ6ztLlD2C4DXZCDp9t
         uskHOy0DOn0DgzLnkg1A+EWANDjdJS8KFX5Zk1WAPnK5dTMPRYjMJkw10nVx5g4Daebr
         eOTGTRywPhiAIPOs51v5P2SZ+nEK9VYIioRlELYrBtuH9M9Pibj5PWOS6ndsINbRoLyA
         TIRiA4DXWDNqf5tI864hNe64EGzx8wEvwWRX9TZIfRc7KvhJIiZVvKhXwov3/W6RbTwn
         cHYAF6ODfCD4iM+8FHTUej1xWb2qdCLKWZK5Y6TGfpyusJVcwdHyuyZjLUYWVT09rQHH
         uMyg==
X-Forwarded-Encrypted: i=1; AJvYcCUAoZ9uVv+GRbEyG9Vg9Luo3jeeR0oS20L7krN+FLtEnMuuVS0TgEJ5E068MI+HDc9BnXmNMfswGmmccWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6iTIu0TMdGOJRSdWEfAXpLkJQwPL3nSsaorBc3d/mQLkiIB5J
	aOuVdpIhebH/5Mrs5pvhHRXJ84bMfQr6BqOVhVZGWrhc87QS+XtTD7ziu29IHo3/a8OZTUgzAQC
	f70D/jrpsNXhERxqSgRZLV5KCX7CJUAsqmXTTLtUdteSKpTr/rp+fgLH3V23TXP+HB18=
X-Gm-Gg: ASbGnctOeL2pOAYds//8C/nKvp/QM/qLESG//7wafWDZWL8tKu6DoWwLF8nhCN7iKa3
	8fF07qqmYIChZzoaW9tY3eA+f35dTF6FwlD4dbxickqSfRreSEqtzWxmeDf3/9cqCIHZQmUTIUy
	JAPOMr3MCya7A3Ay11wNo0vM2Q72tq09rJGd7OPxiJDSIg/toSApkrzPJQA7yss36AHZxMhxeex
	GrIcAMyngxZg6Jd6sfMCL3pn6+EzNAowacBih7T8oDz+iW9DEvUksy1F29EiL29CuiF8yeVsMsd
	sZ7/ok6LhC0S4ferQX9tnuwPaIU2U+wvLVlX5jckDplbVC9+XlJbUgF7DzwpB1kaxLuieYYww9E
	8LX8c6w41l+9l0xKbqROZulyoqr8Ob3dffArdwSazmxLBPXa7932D
X-Received: by 2002:a05:6214:3005:b0:6fa:ab49:4482 with SMTP id 6a1803df08f44-70d88f9b87emr15996646d6.35.1755771568995;
        Thu, 21 Aug 2025 03:19:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHF6WPBsgznhHt+ts7DhqqaGYYvO9aU0zVdhS4+riVCnl7vdR8eHXlreLz13JV2r3MGZN4QFw==
X-Received: by 2002:a05:6214:3005:b0:6fa:ab49:4482 with SMTP id 6a1803df08f44-70d88f9b87emr15996376d6.35.1755771568433;
        Thu, 21 Aug 2025 03:19:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef4425fbsm2950888e87.154.2025.08.21.03.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 03:19:27 -0700 (PDT)
Date: Thu, 21 Aug 2025 13:19:25 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH 5/6] arm64: dts: qcom: sm8550: Additionally manage MXC
 power domain in camcc
Message-ID: <eaxppztxjggd7kdg3p5actz5rcsiy7czw7lnv5jrvnab26gxdj@pwmwlupaievv>
References: <20250821-topic-sm8x50-upstream-pll-multi-pd-voting-dt-v1-0-a510c72da096@linaro.org>
 <20250821-topic-sm8x50-upstream-pll-multi-pd-voting-dt-v1-5-a510c72da096@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821-topic-sm8x50-upstream-pll-multi-pd-voting-dt-v1-5-a510c72da096@linaro.org>
X-Authority-Analysis: v=2.4 cv=fpOFpF4f c=1 sm=1 tr=0 ts=68a6f2b1 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=eIWQzYl4t5esjhT04gkA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Cs0IKO_Uss2yYNoTEo0Duamf_JlxURE4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX+YdkY2wnE4i4
 HE16FNbkU1/bb6pObih6LQBzPV9nLW1CmvFSh61ey7VuvhM3lD8H7Xwiq6ufMYNsERkbdT17iCt
 xKKaXBBAmtKJLW0dzVvO17Q1za+xMr8e7vzF+fBkgjzt3Pu7Q7Qht15r1T1Iu9XMWCEo5lsxrH5
 KxYMv8wjFgifKWIngry7aq5ZzcdkMHQEYagzE5GvZ6sPAJdorJ7Rhc9RRlA6AN74QS9ydHQgsT7
 QKQIsfK+V4zZXbaBoP6Duv2sHXcydG9ZK7lfLWkvhws5p4ZCq4TTdF3Lsbm+niXao9MZsBwsQ0j
 6W3PzRU01zOjd2sTOze8tJsVrQ3VvGD+pe7uMAuhqV3TpzmGkQ4Nna5N7uWTRG/iQzIB5RTJd2X
 r67YOVaxpVRjKutFD88Bg4MlFPTXlQ==
X-Proofpoint-ORIG-GUID: Cs0IKO_Uss2yYNoTEo0Duamf_JlxURE4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Thu, Aug 21, 2025 at 09:16:38AM +0200, Neil Armstrong wrote:
> From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> 
> Camcc requires both MMCX and MXC rails to be powered ON to configure
> the camera PLLs on SM8550 platform. Hence add MXC power domain to
> camcc node on SM8550. While at it, update SM8550_MMCX macro to RPMHPD_MMCX
> to align towards common macros.

The last phrase no longer applies.

> 
> Fixes: e271b59e39a6f ("arm64: dts: qcom: sm8550: Add camera clock controller")
> Reviewed-by: Taniya Das <quic_tdas@quicinc.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index d4bffcc244c98e87464cb2a4075c21f3cd368482..54ea21e1778a7c104cdf6865f84a7f8b5a8691ca 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -3625,8 +3625,10 @@ camcc: clock-controller@ade0000 {
>  				 <&bi_tcxo_div2>,
>  				 <&bi_tcxo_ao_div2>,
>  				 <&sleep_clk>;
> -			power-domains = <&rpmhpd RPMHPD_MMCX>;
> -			required-opps = <&rpmhpd_opp_low_svs>;
> +			power-domains = <&rpmhpd RPMHPD_MMCX>,
> +					<&rpmhpd RPMHPD_MXC>;
> +			required-opps = <&rpmhpd_opp_low_svs>,
> +					<&rpmhpd_opp_low_svs>;
>  			#clock-cells = <1>;
>  			#reset-cells = <1>;
>  			#power-domain-cells = <1>;
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

