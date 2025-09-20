Return-Path: <linux-kernel+bounces-825755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FDEB8CC09
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 17:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ED23463D86
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 15:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D07E257852;
	Sat, 20 Sep 2025 15:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="czmdbAT7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686CF1EBFE0
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 15:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758383134; cv=none; b=SqS2vedaI7+xu508r+XKXwf3rt+qUXRY4m3W/aywO6QYgs7EjFJBxZmYMj1pzAfh+obvs5L9dzrdL8BD4Lmbz/VDmRYszniA9t1N9xlglHnKGDinhE+NjNcP64xu7aoahPskdnSvTkMVb/VLnslHrkBoEXcGBWuFyIoEkNc9vGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758383134; c=relaxed/simple;
	bh=Nl6xjEQfSXy+EzHx39jXmBvZzxp/pB/P0JE01Sc6v58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXi6duSTBlmCGQg2RAYmaFwAJHXbQUhtkfgOgEX5tAX8p+GSQ+lA8jPTfdGgK9cAiuHIWfp4qEzKFI2jA8Q0RA62WjToODej7KOnzKJuU5pZAQcGJnrWW5vgnAbQ2lKGRsqCIj7b4njjqPGNKqGwu5HJZOfKqSsbGk9Rn3B3OBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=czmdbAT7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58KDumQp020292
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 15:45:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qj9Mkgauf53Q3rI1Zh3EAmXOJsaMhRLtKBTPf4B3uw0=; b=czmdbAT7wkJWx1eU
	aiEERe3/8lHnX/l0Vsob2ixeaJmfQCSm9B47xAVQ7x/YLgQHldhH60GEpTHedAbr
	i8nxreJ3VUWd+LKaHo9Roku++kATERJ1ZuEtavsmDBhwr2aLKXKrTWwet2JgaN8l
	puXW6nj9sfR2Ypn+OnnnfhKoG3RGI+Sm3m3Ppl5WXz+XHOVUbN5dxI+OjCFziqA8
	F1QzLKHl9z+KiOynotCqZg6Nz+YDXHfJws7/l7Eqt4h6g+w/KZT9mTXdqVgf/87d
	6AKO2W8pDjBNI3kiZUq/pUF5dblQL2IJQPoDv0iAGuNwHqvO4xFYpDRFFG/0hK5m
	UhfL6w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499nekrscw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 15:45:32 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b5f290579aso63406651cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 08:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758383131; x=1758987931;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qj9Mkgauf53Q3rI1Zh3EAmXOJsaMhRLtKBTPf4B3uw0=;
        b=dOI3MiEqs+EOVRRqmMl/dc3dySgcruFbRw6AnXthJiFKFCZYBezYn1XeAxmU6z/BG9
         yfL92gPSReKUGK03lW6MCVyQcv4Z60xgnZtyvu7ZCJWaWOkoEZ2M7b9gekRMxx8tv9Q/
         IXvMwkE1Nto8Fv3fIuMnFVv1dkxBgwVZK03D/6Zxsa0PEUSBMp4IAV4JwQRg3BGtLNkb
         kmkdjBVJ7mYh6UPStvH5oJGtefD6cultwFGpjT5Z0ECZ1IjqaAKf4ebCTq/ffsiqJ460
         Wv73uo/VLiPMd3JkEOMx7BkcCAY2GhkobZ4+1Wq5E+PflRYk6B+C/ERI1jhZtkne232F
         ccqg==
X-Forwarded-Encrypted: i=1; AJvYcCV6Si/RtDK07a72i9uD+gJj//Ef+ZPoiRxcl8B56lK4IxuZ87DOjMDaE8Nk/elfDP1QEP88tDPYGhTLcUc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykrctof3rMSHu0QoexVylMx0pwsjSV2guWjnYZGXpatKGFYcDE
	0zkEve3wkHBAU0+zTdV2LsNzOshEiIdkq/0flnm/Fm9TscxYtNCGf2IPRV/AOHU3PlvAya+A6n6
	Ab0rNDt2BDgKfbYF+wlq1Ta6rueJHeVFhb772823RJT1764gCpI6eE2FC5VqnmjKPAMU=
X-Gm-Gg: ASbGncvwOdBrYA91CWCCRUcKtGNAnoxfGXiLO2qCPzx/RKcqjEygMpP3gqaSWOzlAMX
	PsNtXc7Vsw8N4Rw1HaU3VZ82YRe9l01HLPg1+W9Kl5gk2W6v5Pa4gtrgwLmB0IRRz5tw0AksnKb
	VYL+YbB8H3Rg9ZwgRCleioOI0Z1uXPVqZac7cD962IGjH1bdbtlYN2GiBdVqeeZQa+wyzlI+ddt
	c4GtQHTOEI4BFX+afqUPYEBOT/rbTEjaPRylLNE7Sod2kNQKFtfNx/TxLO3Hhjqf3Quf93rNiNJ
	VeM1OO+hUI0iR7Adrsi52rNHSmt7bSLS5BKPAiwx/9iMowjk2nRed66RnxkcW57WYtpUZQTzXhd
	f+WXE1jvylNDaAKYZr2w2BhjhmD1oNBKN1dRJTwY/bLf2Shlv1ZTd
X-Received: by 2002:a05:622a:5a8a:b0:4b7:9ae7:4cd4 with SMTP id d75a77b69052e-4c06fc182ffmr82291671cf.17.1758383131036;
        Sat, 20 Sep 2025 08:45:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxccfhluWWA1PKa9JbM8SB2Mm4trU8h1+nmugmq0WGg+KKieQrxWNJgbkXESoz1nPjhIc5sQ==
X-Received: by 2002:a05:622a:5a8a:b0:4b7:9ae7:4cd4 with SMTP id d75a77b69052e-4c06fc182ffmr82291381cf.17.1758383130432;
        Sat, 20 Sep 2025 08:45:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57946afcc2csm1630691e87.38.2025.09.20.08.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 08:45:29 -0700 (PDT)
Date: Sat, 20 Sep 2025 18:45:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Eric =?utf-8?Q?Gon=C3=A7alves?= <ghatto404@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] arm64: dts: qcom: r0q: add gpio keys
Message-ID: <qiiuezocvxvj5bhrr77v6o2amaaaepdx54pqoewvhtnxce5ccz@g7bhkrb6a4pd>
References: <20250920014637.38175-1-ghatto404@gmail.com>
 <20250920014637.38175-2-ghatto404@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250920014637.38175-2-ghatto404@gmail.com>
X-Proofpoint-ORIG-GUID: erZbniaxDgD5Tlk3rIHPQ4ZqMbg2zq29
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDA0MSBTYWx0ZWRfXyiyWZf2hMHci
 jts3O3kYLh0X0/6sqRIzkc/z12efxuFjxtWD/l08GxHbsAi+GI56siVJWS51HDX1YYUeJxV6Afg
 gInY109Umq+HFqHO9GwN6D2dC3Vg/dcQKoL3PkFbeTl9Vj3X+rFw+hPavPBH4xx4OuT3GqfzswO
 UCxNfKDvk4DcSKXWnstZeWxn8HHribhQ47JBuVDP3zhu6XLvRnNYCoNGAMTmqA6+osH2Rd8yO/B
 cOfNf4ZfJun97OQTFy84Ou/Ho2GOp/oy9uws2N/6GHZ56/xwRlY1FyLsQhbsQ+RvO4fm/toc1p+
 K5wgfwNmtDOYIfzSh3dWPo/PacZnY6d4CKGP2YDhNPOUqPmoTuRgwS47o7CEUfD6d7Vglz060bA
 aNKzBP5q
X-Authority-Analysis: v=2.4 cv=b+Oy4sGx c=1 sm=1 tr=0 ts=68cecc1c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=0Ibn0V_brF-Ol4aD8WAA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: erZbniaxDgD5Tlk3rIHPQ4ZqMbg2zq29
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_06,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200041

On Sat, Sep 20, 2025 at 01:46:33AM +0000, Eric Gonçalves wrote:
> Add GPIO keys support to Samsung Galaxy S22 (r0q).
> 
> Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
> ---
>  .../boot/dts/qcom/sm8450-samsung-r0q.dts      | 53 +++++++++++++++----
>  1 file changed, 44 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts b/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
> index 880d74ae6032..70e953824996 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
> @@ -2,11 +2,12 @@
>  
>  /dts-v1/;
>  
> +#include <dt-bindings/input/linux-event-codes.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> -
>  #include "sm8450.dtsi"
>  #include "pm8350.dtsi"
>  #include "pm8350c.dtsi"
> +#include "pmk8350.dtsi"
>  
>  / {
>  	model = "Samsung Galaxy S22 5G";
> @@ -28,13 +29,19 @@ framebuffer: framebuffer@b8000000 {
>  		};
>  	};
>  
> -	vph_pwr: regulator-vph-pwr {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vph_pwr";
> -		regulator-min-microvolt = <3700000>;
> -		regulator-max-microvolt = <3700000>;
> -		regulator-always-on;
> -		regulator-boot-on;

Please don't mix up refactorings and new features. Split this patch into
several.

> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		autorepeat;
> +
> +		pinctrl-0 = <&vol_up_n>;
> +		pinctrl-names = "default";
> +
> +		key-vol-up {
> +			label = "Volume Up";
> +			linux,code = <KEY_VOLUMEUP>;
> +			gpios = <&pm8350_gpios 6 GPIO_ACTIVE_LOW>;
> +			debounce-interval = <15>;
> +		};
>  	};
>  
>  	reserved-memory {
> @@ -47,6 +54,15 @@ splash-region@b8000000 {
>  			no-map;
>  		};
>  	};
> +
> +	vph_pwr: regulator-vph-pwr {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vph_pwr";
> +		regulator-min-microvolt = <3700000>;
> +		regulator-max-microvolt = <3700000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
>  };
>  
>  &apps_rsc {
> @@ -119,8 +135,27 @@ vreg_l1c_1p8: ldo1 {
>  	};
>  };
>  
> +&pm8350_gpios {
> +	vol_up_n: vol-up-n-state {
> +		pins = "gpio6";
> +		function = "normal";
> +		power-source = <1>;
> +		input-enable;
> +	};
> +};
> +
> +&pon_pwrkey {
> +	status = "okay";
> +};
> +
> +&pon_resin {
> +	linux,code = <KEY_VOLUMEDOWN>;
> +
> +	status = "okay";
> +};
> +
>  &tlmm {
> -	gpio-reserved-ranges = <36 4>; /* SPI (not linked to anything) */
> +	gpio-reserved-ranges = <36 4>; /* SPI (Unused) */
>  };
>  
>  &usb_1 {
> -- 
> 2.51.0
> 

-- 
With best wishes
Dmitry

