Return-Path: <linux-kernel+bounces-882062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FFFC29878
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 23:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B73DC3AE1E7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 22:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2C91DE8AF;
	Sun,  2 Nov 2025 22:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fDKimwy2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="czp78i7z"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10401A9F84
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 22:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762122100; cv=none; b=A/yP0zBrkzteBIN2YK24PLJdTwDhhiFQ6LPAr6fq905qEbcApiyc0wJTdizbIIXMIo/Ue/1VuBbf/AMC79jNIpz6LoeXbCFMri467e83tdrsz6w2x18RcafhL+izy1ENkUiTmO3JyEDfShaTM3BOawmYuSnodbETjZ1rgbFBXUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762122100; c=relaxed/simple;
	bh=gbVoUCYvZOZMTIY2Rtk2MuTaedqMcgW8WWB/h7K2CsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uk8mRfwRerlKKmcKhP4unb7hMZURLFcFvvcgGCL5pkcnlX+l4FqbXy9DpUNn6kn/3J2EaZ5Af+7ioa57GY9ZaaAiQZQDAz+kmRh53BVIB382zS510FKPbOWuD6VEaNUzncZ/v11yyQqgdc6XlqsLnpU3KF1SHAGK77mEYhZzGcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fDKimwy2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=czp78i7z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A2KlY031046162
	for <linux-kernel@vger.kernel.org>; Sun, 2 Nov 2025 22:21:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Fy0+zB1zFcmNDPBHzfEZnFa8
	agZt/sFQo0/x5Ko7o68=; b=fDKimwy2eBdQWL3qZfpEPPgtkkMfxroO9fm5czNR
	Z4vkwatgq5iq9X2qfJL0bNDe2cnzUfGl9fZcnpjki6bMvkee9o5Q7fnR2vaFS8+V
	B5OWZTgy/9+mRIg1FHcTaC7iPdT+xV9yNbJh+28yqJZ2GZwsjdnowkuKXVrQeCuM
	9Edd09cghNSyCbdYyUOtFbcTMPjYiuXTlDGgszfFIxnnSYz07hAxJhq1lBPD0+TN
	1Ev8Cc/+A5YWXTMnZIaZdI2lob6OYMld9ebE8n+qQ6sMb4P2I1T9UdANZS7AePIb
	p+0apkQSA4XWuMPzxlUC2uxAL3QukEEb2ulViBBZTb0pCw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a5bcm2nes-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 22:21:37 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ecf77618a5so127401881cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 14:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762122097; x=1762726897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fy0+zB1zFcmNDPBHzfEZnFa8agZt/sFQo0/x5Ko7o68=;
        b=czp78i7zLFO6nbV15V5pF1ECraf3RO13Ic3Go/kEgn+FGu/kHf+WKgyx0thBowm0Uf
         8YXGdiOUzsGjR5VCeGXRmlTT1JWrmhmBFtBdetnIVmBepii2XQcypx/c1FPJwJ6ELXMy
         7CD+gnHF/1dc/BEGKS6ToEl6TNEHPvtMf2qymeIR9x4UjXqgH13USl9nv2/CQ1T0aHHN
         LYovirol+z+HBsRbl24SZVF2+8of05G6MIq6EJJi7olGGTR9CV6zLkfNQpA4ugCvQfNQ
         OQHzaqnBV0Iy74bzUPxGrROBTtn3YyyIGP9eK03ffcURHoEv70+JiUOsJSMAAymIAvVH
         z/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762122097; x=1762726897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fy0+zB1zFcmNDPBHzfEZnFa8agZt/sFQo0/x5Ko7o68=;
        b=FdCH4zbV2wYqG3DzyVuvrtmaMOiawsbbhlPTNVVnvgt8MGCNgco4JE6TgKIoKy5APM
         eNidYkbvXBqDHQ4HcwZSTW1dj3p8OlE2Sse3YduHTdQgcOQNOFofXlzBWcynSty5MSt2
         HbLxb5q6TTWoOPpOoabDgPe0SApJxzbzZ5Qwx/r8tsdZO4Xbpt/OfFaMoHELSfPMO+ur
         +aBej975WAFz8sW5BPg3/veQiHB99jGNj7Gn5SuhXg1NYJnPWFl8r/2au2VI66c7i7Cg
         HlLRZqHjKg8e/pmNEX93KOI/WPHoorO5HOLgwqk7pfL4B+XqXomRHm3BlNFW7G2qHoUv
         pi3w==
X-Forwarded-Encrypted: i=1; AJvYcCUcKCEfmcNqwFdnlri5px9R57jh6lmprncflfFma5bQX/kTKVQF7w+Lxg28GFf+Zd2dRHGDSHn0807bfWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEftbo8SRekHMlI6pI4rNNKedPB/FWqtiqebYgLq6nzGD+C9NV
	3FXaLIbg480/FIoS8lliijTb23UK8TrsblX19NuGGxb7cpGvWcSJwS4+bF9sbp0iGz5ziySIqtt
	tR02Z2Bit699/wm+7bVGBTOhdldtlABb+7EjDma6Ajtd+NQD78mx7ltBjOfobCTXBetM=
X-Gm-Gg: ASbGnct+zzA2/JQNUYZ2Ei8EBhwY02PSFkLyCRKpd0O2Dd3wWnuyKpj3w+8dDoLMqqC
	2CHB6Vlf9eRkTWsT/xvuEwQE9sI8PwQbxpZJQybYUh05Sfgj95TrCfecnqAcIx4upCbjziaApLo
	gCwps7aKEPL6VzXv/pFCb0FVuP/v6zdosLyDClxtaaDzrt7mYsATI22RAFa092ZR0pUNbsmEc+5
	WnKnngWUB43uxiN1EEIazWSXM9gljVipoCGW3p2FN4GCdmAA8h87LOUG5rnj9JKjk+du2fkg4aP
	T4Rs3rwgljltZpUFvbG/0bqaciQ4oePw2n7u0UOnaRI/81gPgN8rdyZMph7ZW8uH0ZhEFN45yIR
	gxabC0fqleJUcKI+psaOjgFu3XfnKJfryr+KO4XyQG+wXbWKGy4JhaJ14JzOSDldciLbTozfwk2
	HLxjsLJIvEnPGG
X-Received: by 2002:ac8:58c6:0:b0:4ec:f156:883d with SMTP id d75a77b69052e-4ed30f873a3mr150821611cf.43.1762122096610;
        Sun, 02 Nov 2025 14:21:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKSuBp5T5gQKe8Rxj77+3COdbWI4x8CvKxpNjeJKe55iGjnrgP/lpO6D3eNUdIWsNdHSe8Ig==
X-Received: by 2002:ac8:58c6:0:b0:4ec:f156:883d with SMTP id d75a77b69052e-4ed30f873a3mr150821431cf.43.1762122096189;
        Sun, 02 Nov 2025 14:21:36 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5942e83f33asm136383e87.49.2025.11.02.14.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 14:21:34 -0800 (PST)
Date: Mon, 3 Nov 2025 00:21:31 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: maud_spierings@hotmail.com
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/6] arm64: dts: qcom: x1e80100-vivobook-s15: enable
 ps8830 retimers
Message-ID: <vijkpvomiv3nonumyqoeut2k3ajftf7cafx56ngjlc3uuwqfcb@7o75sm3kh36d>
References: <20251101-asus_usbc_dp-v1-0-9fd4eb9935e8@hotmail.com>
 <20251101-asus_usbc_dp-v1-3-9fd4eb9935e8@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251101-asus_usbc_dp-v1-3-9fd4eb9935e8@hotmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAyMDIwNyBTYWx0ZWRfX5TXIyFMyOCKV
 7jLM1Cd2Tsdz5qwrtMW03gIiMH3XJlmrf11QJr6caKpgqc1Y0PqVsxIQu97zXvubNYkLDRUSgsl
 9kVaJBhW7pfzMWzlSjH6sO3VrQh1soN0cxGAUAL66BopCtHJzXmqrx81QeVxUNANA9h8K1UiZna
 +5EUppEDYhSgrOKddnzA90QiQzeUtJcDg/MXYHcPI+1uCGvbS8pMSSr3PjxgvnZz1Vlqrew+cFT
 4/siXTXCSxw53PfrgkVbPblODDenY5gjnFv1NNIsaSivUQABGerYL62fwQA79Go5fZ5fVK0H7jE
 YoTkF/TBG+2pMWigIgyYtjtfh7c+1V1grzhiJR3XReJPJ8hmIXAr3v5TPtzzgx50SkK9fEhnV7G
 n44Ky2u5J6GmugzB5KFxflAnmo0kHw==
X-Authority-Analysis: v=2.4 cv=EszfbCcA c=1 sm=1 tr=0 ts=6907d971 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=69EAbJreAAAA:8 a=pijrH-o4oxMIDQe8xl8A:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: yjbsdLcaDKtkHKjOSG-7Z5fOmuD1ou6V
X-Proofpoint-ORIG-GUID: yjbsdLcaDKtkHKjOSG-7Z5fOmuD1ou6V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511020207

On Sat, Nov 01, 2025 at 01:54:14PM +0100, Maud Spierings via B4 Relay wrote:
> From: Maud Spierings <maud_spierings@hotmail.com>
> 
> The Asus vivobook s15 has two usb type c ports on the left side, these
> use parade ps8830 retimers like the others, enable them to also enable
> dp altmode
> 
> Signed-off-by: Maud Spierings <maud_spierings@hotmail.com>
> ---
>  .../boot/dts/qcom/x1e80100-asus-vivobook-s15.dts   | 310 ++++++++++++++++++++-
>  1 file changed, 302 insertions(+), 8 deletions(-)
> 
> @@ -158,6 +174,102 @@ vph_pwr: regulator-vph-pwr {
>  		regulator-boot-on;
>  	};
>  
> +	vreg_rtmr0_1p15: regulator-rtmr0-1p15 {

'vph-pwr' > 'rtmr0'

> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_RTMR0_1P15";
> +		regulator-min-microvolt = <1150000>;
> +		regulator-max-microvolt = <1150000>;
> +
> +		gpio = <&pmc8380_5_gpios 8 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&usb0_pwr_1p15_reg_en>;
> +		pinctrl-names = "default";
> +
> +		regulator-boot-on;
> +	};
> +
> +	vreg_rtmr0_1p8: regulator-rtmr0-1p8 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_RTMR0_1P8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +
> +		gpio = <&pm8550ve_9_gpios 8 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&usb0_1p8_reg_en>;
> +		pinctrl-names = "default";
> +
> +		regulator-boot-on;
> +	};
> +
> +	vreg_rtmr0_3p3: regulator-rtmr0-3p3 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_RTMR0_3P3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&pm8550_gpios 11 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&usb0_3p3_reg_en>;
> +		pinctrl-names = "default";
> +
> +		regulator-boot-on;
> +	};
> +
> +	vreg_rtmr1_1p15: regulator-rtmr1-1p15 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_RTMR1_1P15";
> +		regulator-min-microvolt = <1150000>;
> +		regulator-max-microvolt = <1150000>;
> +
> +		gpio = <&tlmm 188 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&usb1_pwr_1p15_reg_en>;
> +		pinctrl-names = "default";
> +
> +		regulator-boot-on;
> +	};
> +
> +	vreg_rtmr1_1p8: regulator-rtmr1-1p8 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_RTMR1_1P8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +
> +		gpio = <&tlmm 175 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&usb1_pwr_1p8_reg_en>;
> +		pinctrl-names = "default";
> +
> +		regulator-boot-on;
> +	};
> +
> +	vreg_rtmr1_3p3: regulator-rtmr1-3p3 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_RTMR1_3P3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&tlmm 186 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&usb1_pwr_3p3_reg_en>;
> +		pinctrl-names = "default";
> +
> +		regulator-boot-on;
> +	};
> +
>  	/*
>  	 * TODO: These two regulators are actually part of the removable M.2
>  	 * card and not the CRD mainboard. Need to describe this differently.
> @@ -506,15 +618,62 @@ touchpad@15 {
>  &i2c1 {
>  	clock-frequency = <400000>;
>  	status = "okay";
> -
> -	/* PS8830 USB4 Retimer? @ 0x8 */

No retimer on this bus?

>  };
>  

-- 
With best wishes
Dmitry

