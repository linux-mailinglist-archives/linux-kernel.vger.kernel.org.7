Return-Path: <linux-kernel+bounces-815952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7430CB56D5F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 02:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 272C8177259
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 00:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB441A841C;
	Mon, 15 Sep 2025 00:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nbXahh8E"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED9B19F40A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757896132; cv=none; b=n8CF/tw2BTQOSyVc3SWhrqxjF7Cduq7PeW5vyDd32Jle0tlfamTVOPf3o3pyJv+UFCWDOvWrWDjbvDYcNL8Pd/nfoc9gbYXrFVqZhB+vwIh/abOf4JTkMyjsEeT40doI/4kNlvdvEdXm+vYQcJq5ztG0hdT814l2QBPlrxddiJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757896132; c=relaxed/simple;
	bh=DGEMYii1dljXPL3QVeSucucjB7aPf01GIJs4N26OkpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3tBG/HTcoq/AOeykW2h7DTl2f4VXMUNGQ10mti12xGGCkxx9WaeXxw1qh1I8Y5MRtLUKyFp7RTb6yc+ZJfOk6ESt6GO7Uhm0dUC6wxKgA3xlWicjFB3FNos+8WIoD+FepFHfC5VJhAHLCSLP5zaDdlp06inkypK9wNF+5DH7AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nbXahh8E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ELj1CV005878
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:28:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=SyKM1h0GSKOlVPBkK30I+Cjq
	aPcyAMQRT1D/uIY26Wc=; b=nbXahh8E+zGEKOp+10e/8F9ifcyyJVeByZp0KJ5h
	q2ue0vxr+S05PKnsJqLbhGopjpYqbKHHduyp87oqF/kx9yY0UrwElWjCY1UbuyI7
	A7StHanXKF0ClJPQxgdg096bYYDEHP9ufQuNDSke5MwxxElxHDqfwYMW2ldJib2m
	Us9Rxp/SqvZ/b9JwA4V3L6AhN18xDXkqD1JupiW4/Zcx4FngvVXa8SBsA3hmrw3U
	b7ABU8NOWvC39CaMZVwoFhfjLvcWlb0TN1l5ioGXX/3frTMFIHuSi1QwKlRDmC6n
	b/TS52FENd1FGNoJXv78GhR7OcX7Qx5SH+hznkxVIURW0Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4950pv2ygt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:28:49 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b5d5cc0f25so76220061cf.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 17:28:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757896129; x=1758500929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyKM1h0GSKOlVPBkK30I+CjqaPcyAMQRT1D/uIY26Wc=;
        b=Zaa64CPYoY0st0qXNRHqvPt7PR3eZXfPn2k0GosWHhbpDmzPH2rO5z3FgdJS0aZMbh
         FQhJ47QDe6zfPhT1k7MoIdqO/KzZNUIWDFPcdvpiJLwWhcEYtQYlfbeJdcFjJZ3yQaBM
         jTEsCHf3DmSKYlcOrCMh3WEGZSfEVp+y3UoMtcBEBn3aX5KcCoG5E0LJwTiHQxMI5zIA
         IDir8SkOpjq2XTaa56Kb5q1tZIGqWTwLD/2qkyV/iMQrcn0T8J+KbJWqP0gkuT90CxPy
         InmW4Vbn5PKe0ElQ1e/WweIzqYdP/Gyki/U2CyxBaa6Swx1tNuitXb2lhJROR//d6D4r
         2Z4w==
X-Forwarded-Encrypted: i=1; AJvYcCWF7bTaLkLz9wlFQg2KKE4flRAKzTPyUZUDkdsGTpYptNg25fPEFJJSCZxgEz/vAYSH0FI5o4JGnrYpQYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMnsGCmlYmbEDZoBitCi3SjolfMGrkInkpj7r0dayjYW4M1nBj
	lOwRFWGfuj+nxjqV4EmqlTfYzglTSNb7teF8dJJqwI3yYnSoANTOyHO2fi32ICZlF2ITKdejrwY
	Psf3+8pdN6CTtFHDic7yDNbSny5sq0WAm7bFCp+FBhUhZy0eaQs5QNH1ht0jlxW8IegI=
X-Gm-Gg: ASbGncuPTXE4iYhJ9SyIibrIB4cbWVk3SL/xB6FvPnb1BSC0p2MUhVClWV4lGkluK2j
	34BeA6b5G+xWIlYThszdO//A0mJTJJs9nughssfct/0K0vQ9fy0k8nAw6oVb6Pc8rWGMn1iiO5s
	0djn/OcmVwARSE7H56h9OsHXyCCirEkEMhAbaBhk2iSvd/Udm3N48OkDqDXUVoWL7baW9bVz4ms
	OtasXlw4nZDW80vVh0KwfmKqlW8sFf6g/3Ku+Jn0X+nAVTr4C9TLB78iTIYX0/GMIYRiLiu0fIQ
	zIFWHwVlXgTo06Q2NLZWhsh6d8ArdaFTYm6pgQxcMVWC0HnDr54DH7C4UPyV6CqgcflRpeI9Cah
	xmSTrvuvzVD/T85YgIrmudby4NirlVeN72l7vhvu9Ia4ko66ADni0
X-Received: by 2002:a05:622a:4c1b:b0:4b7:a92a:fbe9 with SMTP id d75a77b69052e-4b7a92afe44mr5644691cf.60.1757896129038;
        Sun, 14 Sep 2025 17:28:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRYV3+8LgmWl/IF1xYw+B+ap1+M6TIYz/bETHr2Gj9Qam/Z3z65nJtYPJNQs8mLgaw0qTr2Q==
X-Received: by 2002:a05:622a:4c1b:b0:4b7:a92a:fbe9 with SMTP id d75a77b69052e-4b7a92afe44mr5644431cf.60.1757896128527;
        Sun, 14 Sep 2025 17:28:48 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f1a8212e3sm23679371fa.41.2025.09.14.17.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 17:28:46 -0700 (PDT)
Date: Mon, 15 Sep 2025 03:28:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Paul Sajna <sajattack@postmarketos.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amir Dahan <system64fumo@protonmail.com>,
        Christopher Brown <crispybrown@gmail.com>
Subject: Re: [PATCH 05/11] arm64: dts: qcom: sdm845-lg-judyln: Add display
 panel
Message-ID: <zp274p5tsjkpamzlmxxlwnrlunqgagzmoybuqgedrnfye6t536@rbx2vwxc3nld>
References: <20250913-judyln-dts-v1-0-23b4b7790dce@postmarketos.org>
 <20250913-judyln-dts-v1-5-23b4b7790dce@postmarketos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913-judyln-dts-v1-5-23b4b7790dce@postmarketos.org>
X-Proofpoint-ORIG-GUID: NB4EvfkqHeFZ-cUEuO0biLZOnej-_caE
X-Authority-Analysis: v=2.4 cv=PsWTbxM3 c=1 sm=1 tr=0 ts=68c75dc1 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=Gbw9aFdXAAAA:8 a=sfOm8-O8AAAA:8
 a=BATXc3X0Y3vKR66eh8IA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=9vIz8raoGPyDa4jBFAYH:22 a=TvTJqdcANYtsRzA46cdi:22
X-Proofpoint-GUID: NB4EvfkqHeFZ-cUEuO0biLZOnej-_caE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyOSBTYWx0ZWRfX2KXcvdvn0Yl/
 FRVgC6vU2G1tUg1p0WNBNKMX3enDHOqrIKeB4QPqDuQw5ubzCihuZwugY2x7Ve5ITP2EQVLdkW5
 Z/cp5CPf3E1M+K/CuV2tHfligT1l4pCACVV+S3h50oIlbBTvTbUQLe6ch+GVoWUasaJNwuhqbNW
 v55wCj5ZKFGaVFgeQJkd1k1QE6pEhmd4gZmvVXWZwcpxZ3l0GFpyxbzfWTmrjj6J4pN1vG/dEzd
 PYWzHXRusMSuxbSDPzrqYt4lBAhYHfAGVEecXnUCe2HRroPMX/0+K+eKPMfDtI0gSOVkGOqSxTM
 Y2SE6MejJhNTyHeoQbOGct/rz1mbno/yv1Hq4MRaqrgWb0P7UYMAQldYOrCWaDE6xkSkqhd+zil
 e3cYhxBr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-14_08,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130029

On Sat, Sep 13, 2025 at 04:56:38PM -0700, Paul Sajna wrote:
> And supporting msm drm nodes, including backlight
> Depends on https://lore.kernel.org/all/20250910-judyln-panel-v1-1-825c74403bbb@postmarketos.org/T/#r9a976ca01e309b6c03100e984a26a0ffc2fe2002

This should be a part of the cover letter. Once this commit lands, there
is not point in having this information in the commit message.

> 
> Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
> Co-authored-by: Amir Dahan <system64fumo@protonmail.com>
> Signed-off-by: Amir Dahan <system64fumo@protonmail.com>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi |  4 +-
>  arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts  | 99 ++++++++++++++++++++++++++
>  2 files changed, 101 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> index df826bca2bef5e3f85cf49708020a47b8d6bd8bb..1bf2f2b0e85de174959ec2467076a95f471a59d4 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> @@ -461,8 +461,8 @@ &cdsp_pas {
>  	status = "okay";
>  };
>  
> -&dispcc {
> -	status = "disabled";
> +&gmu {
> +	status = "okay";
>  };

It's enabled by default, no need to reenable it again.

>  
>  &gcc {
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts b/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
> index da093b581c857c5acc9f0e72c9d3519977e13eab..fae85d4c1520e044d8166bb22a8f5762fda250b2 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
> @@ -23,6 +23,13 @@ framebuffer@9d400000 {
>  			format = "a8r8g8b8";
>  			lab-supply = <&lab>;
>  			ibb-supply = <&ibb>;
> +
> +			panel = <&fb_panel>;
> +
> +			fb_panel: fb-panel {
> +				width-mm = <72>;
> +				height-mm = <153>;
> +			};

This is independent, please split to a separate patch.

>  		};
>  	};
>  
> @@ -72,6 +79,70 @@ &pmi8998_charger {
>  	monitored-battery = <&battery>;
>  };
>  
> +&ibb {

Please keep entries sorted out.

> +	regulator-min-microvolt = <4600000>;
> +	regulator-max-microvolt = <6000000>;
> +	regulator-over-current-protection;
> +	regulator-pull-down;
> +	regulator-soft-start;
> +	regulator-always-on;
> +	qcom,discharge-resistor-kohms = <300>;
> +};
> +
> +&lab {
> +	regulator-min-microvolt = <4600000>;
> +	regulator-max-microvolt = <6000000>;
> +	regulator-over-current-protection;
> +	regulator-pull-down;
> +	regulator-soft-start;
> +};
> +
> +&mdss {
> +	status = "okay";
> +};
> +
> +&mdss_dsi0 {
> +	vdda-supply = <&vdda_mipi_dsi0_1p2>;
> +
> +	status = "okay";
> +
> +	display_panel: panel@0 {
> +		reg = <0>;
> +		compatible = "lg,sw49410";
> +
> +		ibb-supply = <&ibb>;
> +		lab-supply = <&lab>;
> +
> +		backlight = <&pmi8998_wled>;
> +		reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
> +
> +		pinctrl-names = "default", "sleep";
> +		pinctrl-0 = <&sde_dsi_active &sde_te_active>;
> +		pinctrl-1 = <&sde_dsi_sleep &sde_te_sleep>;
> +
> +		port {
> +			panel_in: endpoint {
> +				remote-endpoint = <&mdss_dsi0_out>;
> +			};
> +		};
> +	};
> +};
> +
> +&mdss_dsi0_phy {
> +	vdds-supply = <&vdda_mipi_dsi0_pll>;
> +
> +	status = "okay";
> +};
> +
> +&mdss_dsi0_out {
> +	remote-endpoint = <&panel_in>;
> +	data-lanes = <0 1 2 3>;
> +};
> +
> +&pmi8998_wled {
> +	status = "okay";
> +};
> +
>  &tlmm {
>  	thinq_key_default: thinq-key-default-state {
>  		pins = "gpio89";
> @@ -80,6 +151,34 @@ thinq_key_default: thinq-key-default-state {
>  		drive-strength = <2>;
>  		bias-pull-up;
>  	};
> +
> +	sde_dsi_active: sde-dsi-active-state {

And here too.

> +		pins = "gpio6";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-disable;
> +	};
> +
> +	sde_dsi_sleep: sde-dsi-sleep-state {
> +		pins = "gpio6";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	sde_te_active: sde-te-active-state {
> +		pins = "gpio10";
> +		function = "mdp_vsync";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	sde_te_sleep: sde-te-sleep-state {
> +		pins = "gpio10";
> +		function = "mdp_vsync";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
>  };
>  
>  &uart6 {
> 
> -- 
> 2.51.0
> 

-- 
With best wishes
Dmitry

