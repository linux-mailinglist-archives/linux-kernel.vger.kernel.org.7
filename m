Return-Path: <linux-kernel+bounces-831678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C49CB9D4D4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 05:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0982A327880
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 03:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3AA288C2D;
	Thu, 25 Sep 2025 03:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WMk8HYzi"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E1E188A3A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758770308; cv=none; b=cmDxaR19wEX2s2PrNGgzZkQU+nL8jZ7IieA9fXFdX6mPunsHMugXtI1DUekmI9pe6+oO9oMfrdJjVZimptjPrbj5xmrhLc7GV9zaCFZqqTYntc4JQbYE6zBDyX6YSE52EIrFd2iEcuR47m5TtmtfsxLMEB6XkeZSASLQEff3jtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758770308; c=relaxed/simple;
	bh=nEZnkeNBxYQLfH8ZaDR8kTSqqrMKhQmh6HH7IAsX8cI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbmJDDv0NVOx/Plcpkp7HzsUzl4a75cScb0NGokdWSThDgF5NeK1Xq0NtCWJSmV3KxFhmKi1bqVN4+s+Bse1QkP/hi5I0rtJ7BDd3RZb631/gpb2owLdveNpNy35cLlX6hcTg2WZBUkb6dNcruD2O6ftna0fmwURVtAxYxDMeXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WMk8HYzi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P1gYFM019919
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:18:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=c42F6ARXY3RaEvbbpKrr+xHp
	LhP9VdyHXzG9PjVHgr0=; b=WMk8HYziV61tCm9jYv8sFgXOkqAcFTGLQUT9dke/
	KXDfnJRI29bNVJzVI6uVGrf9EWFu/VtUOuiSH51QLZ13WghnNUpUvoV44EQaSwUz
	a+wwKeLEYeezwDMjkviSDorTWAlSIJFq9ck8g/t4l3ic5UXEIhz9kkHcb4TZEzl2
	3lXJD1pxS44Rz7wVopgOtsy65BISs+1h1xt38X4xsE4PrxrXGuJ2fZY8730MZI10
	hXHhFXPiaYTJhPZIdoNFf1O5+yiIsJHTD9ltS6L5kwwaZ8UNihJHUnO68Zc6oGxr
	hVEkUGmI5hkLTIMAk1oaHmAEflb/OVEeAaINVcWD6uX/XQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bjpdysud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:18:25 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4d8b8c3591fso14805861cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 20:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758770304; x=1759375104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c42F6ARXY3RaEvbbpKrr+xHpLhP9VdyHXzG9PjVHgr0=;
        b=ZZX8cPA+sIkYohpTVycwphjcFuojTm3wAvx0TVIQnLge6fXnIFaNhckyoc/oIdp7Yy
         MUXVGrgUVgAXub8AR7kloNZlP+/QF2VRnXy6cb2nvTlsCNklQLD+7b7m90E6iE9MvmGc
         37j/A6Ru1SE2FsV8SK7ZHZeOsbnQFkNWoV+N3KYsfhg5ilywJJmuhLDVuVGn5FsxuZTH
         dRliNEpY4Iimt7uXnjSfRDnz3dr9kTZtblsRqdDTPH8Ee7wtxXLc4bCUxqcFknP0ijOV
         +kdG0lOHqJPyZ/eYXdw0mF0EOi2Mzgo6nPaMMLDfmsZHckU/+fcIDUvPw142EXhKRUos
         DCwg==
X-Forwarded-Encrypted: i=1; AJvYcCWIRVPv671BWg18PDsiz2NY4E3O9WCkyxqtdI9tL1OX+v4WmMrJck1pmaKWRfpN2z0gHN7V7AHC8M8GHjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJBmg8gDZR/bgQ0VE5BomPi+zVLQmWgPFwbP29+oLrodtfE7o1
	JGMVQpJWYaplhPmA1Kaxqktg4ezVeDM2PMMrNXAXY71TZ0+XurXXjEPVJ9/Zg2Fvvn8xhf7ZRP1
	iMyIFQncOuzg95oFX7PvSdDk2nlMtqYGp00GfNHUiIMOp5H57/jLc9ojNDoFX2u3qPhg=
X-Gm-Gg: ASbGncuja3tN5crwue9/0+JWkpr6TyqBCL9DI5ab8GHJTSIYu2Cenhdfui5rYkCTlVf
	pNvHh2nWLADcn9VyqLDlGfjT2KKCqjyfLTVIHPvFbvXbsMcRIt9NO9J/fo7Iey/yvw7n7nMQA0r
	FIqwkipSwGU7lZSNv5vs0azHxTbxt02VnftNrak17rD9uYcSJAj+PwUrjrsEf3sjLy6/7YRLDpK
	OSqJrRKnXiAqtzZQP2yZGoh4mbtx8kTitl9ose1zXvHnlCse+n3qt/JgcRCs9cl69N5QvhATZhn
	x62EcySH7a+kbmCgCYTA2sPYUgpobMe9y4zo/icXAEb1uy7mnANOaZX9d2olGBqW4C3PGExKdd/
	LzWtNfUUOZDrZLe19jQDCK4OicAVRbZysy+CImsT71M5XKyJjqxwq
X-Received: by 2002:ac8:7f8a:0:b0:4da:21ee:247b with SMTP id d75a77b69052e-4da4b80884dmr24626031cf.47.1758770303654;
        Wed, 24 Sep 2025 20:18:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnAVXhBC6FzxL6grb5yeq8wd5GTCPVyHu1ff4I3dfi9wcVRL66c4b6/YGs38l5FEd6IjkO2g==
X-Received: by 2002:ac8:7f8a:0:b0:4da:21ee:247b with SMTP id d75a77b69052e-4da4b80884dmr24625741cf.47.1758770302989;
        Wed, 24 Sep 2025 20:18:22 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-583134302c7sm289411e87.5.2025.09.24.20.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 20:18:22 -0700 (PDT)
Date: Thu, 25 Sep 2025 06:18:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com
Subject: Re: [PATCH 03/20] arm64: dts: qcom: kaanapali: Add base MTP board
Message-ID: <cifdab3i36xlb3xspyoqbq6o2nz2fvmuo4p6pz57bff3hakz3m@lylbyqavrcvh>
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-3-3fdbc4b9e1b1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-knp-dts-v1-3-3fdbc4b9e1b1@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: FtZJgCUtOmnumhZm8BA6rntBxD22N1yu
X-Authority-Analysis: v=2.4 cv=Pc//hjhd c=1 sm=1 tr=0 ts=68d4b482 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=x9XpTKwQgoqkCUfBsmIA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: FtZJgCUtOmnumhZm8BA6rntBxD22N1yu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAyMCBTYWx0ZWRfX2xzfkVsBHXRb
 rCsvguPkt3fwIBFTTEwG4G5oeJTSl3CQVze3+sgZ8ZSsNYDiU0q5jhT5sNOpTkJvMBVYZ+UnRFz
 9oExGx6P0+uSHlElzIXCCJ3rXsODMcwvUIi4nxlUfkYNORfpqthYR9UVx4j72Y0sL6GgCPD/71F
 QzaSbnOeYjTBLSeXPxXxpuHURGvTevESTVbT28hEPt31HInw1bd+Z9SsdE+x6NkT16x29COECat
 uwO7qMvcFXIcNeQdn4Az4Q/mGS54RkfrHzbtCyy6rGe3jr8xjpX8t2vBnSpGaCKBj8Gfma780eq
 yHUnh4PRyDN3Es+Qn1/RV2P+o2QlwhHDj73gubQgZ9MC/64gNtj3NsVlSRtI8fAXAKVtWLtnMG3
 0ogxIB5D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230020

On Wed, Sep 24, 2025 at 05:17:20PM -0700, Jingyi Wang wrote:
> Add initial support for Qualcomm Kaanapali MTP board which enables DSPs,

It doesn't

> UFS and booting to shell with uart console.
> 
> Written with help from Jishnu Prakash (added rpmhpd nodes) and Nitin Rawat
> (added ufs).
> 
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile          |   1 +
>  arch/arm64/boot/dts/qcom/kaanapali-mtp.dts | 704 +++++++++++++++++++++++++++++
>  2 files changed, 705 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index d7f22476d510..7edfa5fa00fc 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -29,6 +29,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp433.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp449.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp453.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp454.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= kaanapali-mtp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= lemans-evk.dtb
>  
>  lemans-evk-camera-csi1-imx577-dtbs	:= lemans-evk.dtb lemans-evk-camera-csi1-imx577.dtbo
> diff --git a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
> new file mode 100644
> index 000000000000..9cf3158e2712
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
> @@ -0,0 +1,704 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +#include "kaanapali.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. Kaanapali MTP";
> +	compatible = "qcom,kaanapali-mtp", "qcom,kaanapali";
> +	chassis-type = "handset";
> +
> +	aliases {
> +		serial0 = &uart7;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	clocks {
> +		xo_board: xo-board {
> +			compatible = "fixed-clock";
> +			clock-frequency = <76800000>;
> +			#clock-cells = <0>;
> +		};
> +
> +		sleep_clk: sleep-clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <32764>;
> +			#clock-cells = <0>;
> +		};
> +
> +		bi_tcxo_div2: bi-tcxo-div2-clk {
> +			compatible = "fixed-factor-clock";
> +			#clock-cells = <0>;
> +
> +			clocks = <&rpmhcc RPMH_CXO_CLK>;
> +			clock-mult = <1>;
> +			clock-div = <2>;
> +		};
> +
> +		bi_tcxo_ao_div2: bi-tcxo-ao-div2-clk {
> +			compatible = "fixed-factor-clock";
> +			#clock-cells = <0>;
> +
> +			clocks = <&rpmhcc RPMH_CXO_CLK_A>;
> +			clock-mult = <1>;
> +			clock-div = <2>;
> +		};
> +	};
> +};
> +
> +&apps_rsc {
> +	regulators-0 {
> +		compatible = "qcom,pmh0101-rpmh-regulators";
> +
> +		qcom,pmic-id = "B_E0";
> +
> +		vreg_bob1: bob1 {
> +			regulator-name = "vreg_bob1";
> +			regulator-min-microvolt = <3008000>;
> +			regulator-max-microvolt = <4000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_bob2: bob2 {
> +			regulator-name = "vreg_bob2";
> +			regulator-min-microvolt = <2704000>;
> +			regulator-max-microvolt = <3552000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l1b_1p8: ldo1 {
> +			regulator-name = "vreg_l1b_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_AUTO>;
> +		};
> +
> +		vreg_l2b_3p0: ldo2 {
> +			regulator-name = "vreg_l2b_3p0";
> +			regulator-min-microvolt = <3008000>;
> +			regulator-max-microvolt = <3048000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_AUTO>;
> +		};
> +
> +		vreg_l4b_1p8: ldo4 {
> +			regulator-name = "vreg_l4b_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_AUTO>;
> +		};
> +
> +		vreg_l5b_3p1: ldo5 {
> +			regulator-name = "vreg_l5b_3p1";
> +			regulator-min-microvolt = <3100000>;
> +			regulator-max-microvolt = <3148000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_AUTO>;
> +		};
> +
> +		vreg_l6b_1p8: ldo6 {
> +			regulator-name = "vreg_l6b_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <3008000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_AUTO>;
> +		};
> +
> +		vreg_l7b_1p8: ldo7 {
> +			regulator-name = "vreg_l7b_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <3008000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_AUTO>;
> +		};
> +
> +		vreg_l8b_1p8: ldo8 {
> +			regulator-name = "vreg_l8b_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <3008000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_AUTO>;
> +		};
> +
> +		vreg_l9b_2p9: ldo9 {
> +			regulator-name = "vreg_l9b_2p9";
> +			regulator-min-microvolt = <2960000>;
> +			regulator-max-microvolt = <3008000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l10b_1p8: ldo10 {
> +			regulator-name = "vreg_l10b_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_AUTO>;
> +		};
> +
> +		vreg_l11b_1p0: ldo11 {
> +			regulator-name = "vreg_l11b_1p0";
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1292000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_AUTO>;
> +		};
> +
> +		vreg_l12b_1p8: ldo12 {
> +			regulator-name = "vreg_l12b_1p8";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_AUTO>;
> +		};
> +
> +		vreg_l13b_3p0: ldo13 {
> +			regulator-name = "vreg_l13b_3p0";
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_AUTO>;
> +		};
> +
> +		vreg_l14b_3p2: ldo14 {
> +			regulator-name = "vreg_l14b_3p2";
> +			regulator-min-microvolt = <3200000>;
> +			regulator-max-microvolt = <3200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_AUTO>;
> +		};
> +
> +		vreg_l15b_1p8: ldo15 {
> +			regulator-name = "vreg_l15b_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_AUTO>;
> +		};
> +
> +		vreg_l17b_2p5: ldo17 {
> +			regulator-name = "vreg_l17b_2p5";
> +			regulator-min-microvolt = <2504000>;
> +			regulator-max-microvolt = <2504000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l18b_1p2: ldo18 {
> +			regulator-name = "vreg_l18b_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_AUTO>;
> +		};
> +	};
> +
> +	regulators-1 {
> +		compatible = "qcom,pmh0110-rpmh-regulators";
> +
> +		qcom,pmic-id = "D_E0";
> +
> +		vreg_s10d_1p0: smps10 {
> +			regulator-name = "vreg_s10d_1p0";
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1100000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l1d_1p2: ldo1 {
> +			regulator-name = "vreg_l1d_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1256000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_AUTO>;
> +		};
> +
> +		vreg_l2d_0p9: ldo2 {
> +			regulator-name = "vreg_l2d_0p9";
> +			regulator-min-microvolt = <912000>;
> +			regulator-max-microvolt = <958000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_AUTO>;
> +		};
> +
> +		vreg_l3d_0p8: ldo3 {
> +			regulator-name = "vreg_l3d_0p8";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <880000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_AUTO>;
> +		};
> +
> +		vreg_l4d_1p2: ldo4 {
> +			regulator-name = "vreg_l4d_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_AUTO>;
> +		};
> +	};
> +
> +	regulators-2 {
> +		compatible = "qcom,pmh0110-rpmh-regulators";
> +
> +		qcom,pmic-id = "F_E0";
> +
> +		vreg_s6f_0p5: smps6 {
> +			regulator-name = "vreg_s6f_0p5";
> +			regulator-min-microvolt = <300000>;
> +			regulator-max-microvolt = <570000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s7f_1p2: smps7 {
> +			regulator-name = "vreg_s7f_1p2";
> +			regulator-min-microvolt = <1224000>;
> +			regulator-max-microvolt = <1372000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s8f_1p8: smps8 {
> +			regulator-name = "vreg_s8f_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l1f_1p2: ldo1 {
> +			regulator-name = "vreg_l1f_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_AUTO>;
> +		};
> +
> +		vreg_l2f_1p2: ldo2 {
> +			regulator-name = "vreg_l2f_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_AUTO>;
> +		};
> +
> +		vreg_l3f_0p8: ldo3 {
> +			regulator-name = "vreg_l3f_0p8";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <936000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_AUTO>;
> +		};
> +
> +		vreg_l4f_0p8: ldo4 {
> +			regulator-name = "vreg_l4f_0p8";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <912000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_AUTO>;
> +		};
> +	};
> +
> +	regulators-3 {
> +		compatible = "qcom,pmh0110-rpmh-regulators";
> +
> +		qcom,pmic-id = "G_E0";
> +
> +		vreg_s7g_0p9: smps7 {
> +			regulator-name = "vreg_s7g_0p9";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <1100000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s9g_1p0: smps9 {
> +			regulator-name = "vreg_s9g_1p0";
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1100000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l1g_1p2: ldo1 {
> +			regulator-name = "vreg_l1g_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_AUTO>;
> +		};
> +
> +		vreg_l2g_1p8: ldo2 {
> +			regulator-name = "vreg_l2g_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_AUTO>;
> +		};
> +
> +		vreg_l3g_1p2: ldo3 {
> +			regulator-name = "vreg_l3g_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_AUTO>;
> +		};
> +
> +		vreg_l4g_0p9: ldo4 {
> +			regulator-name = "vreg_l4g_0p9";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <920000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_AUTO>;
> +		};
> +	};
> +
> +	regulators-4 {
> +		compatible = "qcom,pmh0110-rpmh-regulators";
> +
> +		qcom,pmic-id = "I_E0";
> +
> +		vreg_s7i_0p9: smps7 {
> +			regulator-name = "vreg_s7i_0p9";
> +			regulator-min-microvolt = <900000>;
> +			regulator-max-microvolt = <972000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2i_1p2: ldo2 {
> +			regulator-name = "vreg_l2i_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_AUTO>;
> +		};
> +
> +		vreg_l3i_0p8: ldo3 {
> +			regulator-name = "vreg_l3i_0p8";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <920000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_AUTO>;
> +		};
> +	};
> +
> +	regulators-5 {
> +		compatible = "qcom,pmh0104-rpmh-regulators";
> +
> +		qcom,pmic-id = "J_E1";
> +
> +		vreg_s1j_0p8: smps1 {
> +			regulator-name = "vreg_s1j_0p8";
> +			regulator-min-microvolt = <400000>;
> +			regulator-max-microvolt = <1000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s2j_0p8: smps2 {
> +			regulator-name = "vreg_s2j_0p8";
> +			regulator-min-microvolt = <500000>;
> +			regulator-max-microvolt = <1100000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s3j_1p2: smps3 {
> +			regulator-name = "vreg_s3j_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1300000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s4j_0p7: smps4 {
> +			regulator-name = "vreg_s4j_0p7";
> +			regulator-min-microvolt = <300000>;
> +			regulator-max-microvolt = <1000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	regulators-6 {
> +		compatible = "qcom,pmr735d-rpmh-regulators";
> +
> +		qcom,pmic-id = "K_E1";
> +
> +		vreg_l1k_0p8: ldo1 {
> +			regulator-name = "vreg_l1k_0p8";
> +			regulator-min-microvolt = <300000>;
> +			regulator-max-microvolt = <1100000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2k_0p7: ldo2 {
> +			regulator-name = "vreg_l2k_0p7";
> +			regulator-min-microvolt = <700000>;
> +			regulator-max-microvolt = <1000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3k_1p2: ldo3 {
> +			regulator-name = "vreg_l3k_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l4k_1p0: ldo4 {
> +			regulator-name = "vreg_l4k_1p0";
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l5k_0p7: ldo5 {
> +			regulator-name = "vreg_l5k_0p7";
> +			regulator-min-microvolt = <700000>;
> +			regulator-max-microvolt = <1000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l6k_1p7: ldo6 {
> +			regulator-name = "vreg_l6k_1p7";
> +			regulator-min-microvolt = <1700000>;
> +			regulator-max-microvolt = <2000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l7k_0p7: ldo7 {
> +			regulator-name = "vreg_l7k_0p7";
> +			regulator-min-microvolt = <700000>;
> +			regulator-max-microvolt = <848000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	regulators-7 {
> +		compatible = "qcom,pm8010-rpmh-regulators";
> +
> +		qcom,pmic-id = "M_E1";
> +
> +		vreg_l1m_1p0: ldo1 {
> +			regulator-name = "vreg_l1m_1p0";
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1100000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2m_1p0: ldo2 {
> +			regulator-name = "vreg_l2m_1p0";
> +			regulator-min-microvolt = <1096000>;
> +			regulator-max-microvolt = <1104000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3m_2p8: ldo3 {
> +			regulator-name = "vreg_l3m_2p8";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2900000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l4m_2p2: ldo4 {
> +			regulator-name = "vreg_l4m_2p2";
> +			regulator-min-microvolt = <2200000>;
> +			regulator-max-microvolt = <2200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l6m_2p8: ldo6 {
> +			regulator-name = "vreg_l6m_2p8";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l7m_2p8: ldo7 {
> +			regulator-name = "vreg_l7m_2p8";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	regulators-8 {
> +		compatible = "qcom,pm8010-rpmh-regulators";
> +
> +		qcom,pmic-id = "N_E1";
> +
> +		vreg_l1n_1p1: ldo1 {
> +			regulator-name = "vreg_l1n_1p1";
> +			regulator-min-microvolt = <1096000>;
> +			regulator-max-microvolt = <1104000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2n_1p2: ldo2 {
> +			regulator-name = "vreg_l2n_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3n_1p8: ldo3 {
> +			regulator-name = "vreg_l3n_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l4n_1p8: ldo4 {
> +			regulator-name = "vreg_l4n_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l5n_2p8: ldo5 {
> +			regulator-name = "vreg_l5n_2p8";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l6n_2p8: ldo6 {
> +			regulator-name = "vreg_l6n_2p8";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l7n_3p3: ldo7 {
> +			regulator-name = "vreg_l7n_3p3";
> +			regulator-min-microvolt = <3304000>;
> +			regulator-max-microvolt = <3304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +};
> +
> +&tlmm {
> +	gpio-reserved-ranges = <36 4>, /* NFC eSE SPI */
> +			       <74 1>, /* eSE */
> +			       <119 2>, /* SoCCP */
> +			       <144 4>; /* CXM UART */
> +};
> +
> +&uart7 {
> +	status = "okay";
> +};
> +
> +&ufs_mem_hc {
> +	reset-gpios = <&tlmm 217 GPIO_ACTIVE_LOW>;
> +
> +	vcc-supply = <&vreg_l17b_2p5>;
> +	vcc-max-microamp = <1200000>;
> +	vccq-supply = <&vreg_l4d_1p2>;
> +	vccq-max-microamp = <1200000>;
> +
> +	status = "okay";
> +};
> +
> +&ufs_mem_phy {
> +	vdda-phy-supply = <&vreg_l4g_0p9>;
> +	vdda-pll-supply = <&vreg_l1d_1p2>;
> +
> +	status = "okay";
> +};
> 
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

