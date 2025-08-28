Return-Path: <linux-kernel+bounces-789831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AACB39B4A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BE561882588
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263AE30DEB5;
	Thu, 28 Aug 2025 11:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="euIsnO5m"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6DE19ADBA
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 11:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756379753; cv=none; b=t4EONm6CgZXhfZuiLcsux8ozful4Bl8wMVfFw3rrpyS9UdyUW08TRmlNWfGUHXdUaRy9qj2Ku7LO2Y34jQGdpV2WBynYXdjq2kSq7C3SZxVBdlQOMQAlW56++uKTxZYywsN3Hc34gYDBpXS0L7UuX0Flja1BZMj2b1bEZBTzRac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756379753; c=relaxed/simple;
	bh=Erw0Zf5hiM6l3I9UY8d2WIa04sjb+pn9ISqGFBazVuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOELVTRekd4vBfq9ZU+UGJw3dnAfrdid4XJSQdbr0un0jMXdPtn2jj51gqCqr8KUEADhlZ2GL+bb+TWF+VD52IewvPiiSW69qPKcIUfFKv82ysHiTkDdIVLRaRM0gOzE2V35Fh/rdrd4rxxEv472ZO6+qJWL81ZtUH+iYj7utQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=euIsnO5m; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SADug8007069
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 11:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=bskH2lX0CKt25YPYuNFvtUmU
	RIgxsqpxQSWfGiy2I00=; b=euIsnO5mVFneMGtMApTR0zl2y0MNWfdrM5ekAscH
	S8vtB4DcyCMi9yodY+kTlonIbTkd/TRJ07UsWrgCoVnr3RxHpdz/15n/Uf/bt5Bi
	I02uVaNZnCqQzZ+SL3B1sniMf8rwH5vX25t4DMukf/MFF20Qm2DRza57LLhi0j2y
	+1yByUKyMDy1CWN4j8DFT0GEzH0EN6Qa446dgbUYQcMNITPc0c7idRfhzkRAekng
	hwhKWYNGqj7iFx56VBiXfR76Et8OsE8DBbaN88AezBovqTDACnwFsFRm7Fb220+t
	kH/FMFl21KYDMHxsfAfI0KqBH0PpALbjg3lixNz16bq5cA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48tn67g5jv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 11:15:51 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70dfcc58976so2112266d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 04:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756379750; x=1756984550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bskH2lX0CKt25YPYuNFvtUmURIgxsqpxQSWfGiy2I00=;
        b=H9AgpZtkB33GzZmUm6b4XYlCn3D5cvEyurz9uf/ZBc+yAUc00992ob+c6c4skhWTN3
         2l1sswcSObzONqbm9qQPLO+6Twf+VDMulqPdY2lTQ4cLA3Nm2eAnkzu2iYgG1VLal4KC
         JOzFPwXVq13kL5pCo9MImt/3wCiAHlR3oyLCKGclLNwkBEE1xgemNvo0oBiDTAbXVl6y
         luWk2jdqELKB0TcUHasOxEo8MCRWF+krh3vE2xAqsPUCuXNuh4EK48VZGZ5+6vK+eJrh
         BIEvmZTc9GQ2D+ELhm1BfpIf7TKGPiWl21boC5lFLClKewa20cr9LSW+HPzs39FJojB1
         UJCw==
X-Forwarded-Encrypted: i=1; AJvYcCVMIGBKWa1t9oFo7OsNXNxCKwb9VMbj1a68Q54lfcCzawwP6YGMM6jPTaUAQi1hsoz9hI54yB/NgVK4xXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZCZB4wJVesa2R2L/qTQA+SOXTnulnpiNfxfyaao0TQljYjZLH
	wlkdit5g6gZMrPYBcLh1d+3fsuLeNdOVVd0n8g83gXLb63iGh3Zbhl/wPC5vroPiDd765VpxoVT
	D7tjcdJm7ToTSLaFXJs7m/uc4r3IcynKOQFaX7+zmXEgTbdug6+hCulS2cPYvmHjjCTU=
X-Gm-Gg: ASbGnctSKjO424/LLQHgNwUTzrsMdaPwh7PLl3ZPoFWBy0/px48y9zFKM1NpkMvnX+K
	3zO+uxUOy61AfcDG51wGLFoFpefakIUcWl2BGBGCUb5FgCwwAHdwA/Zx1ow6XkWJb7WELwhS3Of
	D1fEoGg10F/qE4Hm6Ki5RHmGuLUTqJbYG0mcQ+Ad6DB+CJTP3Iu5F22ldGH9m3yh5oP//bzGZ1+
	tXcEnaWIblZvn2h5D/KFbp6Muia9xIYPb0wNr1WyF/MZYtFxqtMtjl1gjJuEtc/S3VObIv4zwKL
	EuhGGoVm9nDeMEPxTb6QAen0HOZIiZnDdcHahRiiWH1TBFsejKFY85/X9F2XAEeeFbMikz7FpwR
	QGpMeLDiJlY/ENlYq5XDh/NmbprjRY0FhXmg5oeZENyXg0FEX5Xtf
X-Received: by 2002:a05:6214:d48:b0:70d:c49e:2583 with SMTP id 6a1803df08f44-70dc49e26bfmr163670916d6.67.1756379749572;
        Thu, 28 Aug 2025 04:15:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHR/I0kG9+z/qZVHlLX8H/kcR/onSu4ccUbMJ7Yzq0rYwxLFRv3gZslN4tolgLltQntNbol+g==
X-Received: by 2002:a05:6214:d48:b0:70d:c49e:2583 with SMTP id 6a1803df08f44-70dc49e26bfmr163670466d6.67.1756379749031;
        Thu, 28 Aug 2025 04:15:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3365e20dad4sm31331811fa.9.2025.08.28.04.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 04:15:48 -0700 (PDT)
Date: Thu, 28 Aug 2025 14:15:46 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yijie Yang <yijie.yang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/3] arm64: dts: qcom: Add base HAMOA-IOT-EVK board
Message-ID: <hbvc72fy2bnx5ggmmcpbrgy5jkhrlvewfv3ofh7z6blnj5l27e@4m2js7nf3g6b>
References: <20250828-hamoa_initial-v8-0-c9d173072a5c@oss.qualcomm.com>
 <20250828-hamoa_initial-v8-3-c9d173072a5c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828-hamoa_initial-v8-3-c9d173072a5c@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA4NSBTYWx0ZWRfX7FH6xnhSCAkk
 aOMRyDE1R5r7Y6ReHCfBacb0F/FlDLn3kzZvs7QL0oJkuuR3pLkaxUkAUqmbVx+s8R3rz8Vg3+b
 UUpt8xx6+8COlDSlF7jOvWh2ZKFwbM37lhxyqUcD1pBb49LhcNjR+yar0CYfy3jqy9+U3+6yk10
 Iy343UT8iqJxOtVEJCGBXKXFxL+gkD6nQGU1drY9ER/qVGZ5G/1L6efJQycB5K4PvYZvRkOxPxg
 0GHjgXlyyrQPzEXmmOcRjx8mY3RQFfD+F0z3C4llh6GHnCWE5pf5ywTeXtFUkIwLmO4j59zYFL5
 33rWWfLfQvKlbCXT9RqjdQxVRdyDK2waxBXhYuk5a8zPiD2/RgJ6KVAT25loz0CkV9UswYL0t2I
 K2cyWQJg
X-Proofpoint-GUID: EHJV63JjI6CEf4pnSjK7yRA6szh0S15V
X-Proofpoint-ORIG-GUID: EHJV63JjI6CEf4pnSjK7yRA6szh0S15V
X-Authority-Analysis: v=2.4 cv=P7c6hjAu c=1 sm=1 tr=0 ts=68b03a67 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=m4PJ2_s-LGQMiO66xH0A:9
 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 adultscore=0 phishscore=0 malwarescore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508280085

On Thu, Aug 28, 2025 at 12:48:47PM +0800, Yijie Yang wrote:
> The HAMOA-IOT-EVK is an evaluation platform for IoT products, composed of
> the Hamoa IoT SoM and a carrier board. Together, they form a complete
> embedded system capable of booting to UART.
> 
> This change enables the following peripherals on the carrier board:
> - UART
> - On-board regulators
> - USB Type-C mux
> - Pinctrl
> - Embedded USB (EUSB) repeaters
> - NVMe
> - pmic-glink
> - USB DisplayPorts
> - Bluetooth
> - Graphic
> - Audio
> 
> Written in collaboration with Quill Qi (Audio) <le.qi@oss.qualcomm.com>,
> Jie Zhang (Graphics) <quic_jiezh@quicinc.com>, Shuai Zhang (Bluetooth)
> <quic_shuaz@quicinc.com>, and Yongxing Mou (USB DisplayPorts)
> <quic_yongmou@quicinc.com>.
> 
> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile          |    1 +
>  arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 1247 ++++++++++++++++++++++++++++
>  2 files changed, 1248 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 94a84770b080..5e19535ad63d 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -13,6 +13,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= apq8039-t2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-ifc6640.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= hamoa-iot-evk.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-rdp432-c2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-tplink-archer-ax55-v1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp441.dtb
> diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> new file mode 100644
> index 000000000000..b1a8380d6639
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> @@ -0,0 +1,1247 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +/dts-v1/;
> +
> +#include "hamoa-iot-som.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. Hamoa IoT EVK";
> +	compatible = "qcom,hamoa-iot-evk", "qcom,hamoa-iot-som", "qcom,x1e80100";
> +	chassis-type = "embedded";
> +
> +	aliases {
> +		serial0 = &uart21;
> +		serial1 = &uart14;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	pmic-glink {
> +		compatible = "qcom,x1e80100-pmic-glink",
> +			     "qcom,sm8550-pmic-glink",
> +			     "qcom,pmic-glink";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		orientation-gpios = <&tlmm 121 GPIO_ACTIVE_HIGH>,
> +				    <&tlmm 123 GPIO_ACTIVE_HIGH>,
> +				    <&tlmm 125 GPIO_ACTIVE_HIGH>;
> +
> +		connector@0 {
> +			compatible = "usb-c-connector";
> +			reg = <0>;
> +			power-role = "dual";
> +			data-role = "dual";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +
> +					pmic_glink_ss0_hs_in: endpoint {
> +						remote-endpoint = <&usb_1_ss0_dwc3_hs>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +
> +					pmic_glink_ss0_ss_in: endpoint {
> +						remote-endpoint = <&usb_1_ss0_qmpphy_out>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +
> +					pmic_glink_ss0_sbu: endpoint {
> +						remote-endpoint = <&usb_1_ss0_sbu_mux>;
> +					};
> +				};
> +			};
> +		};
> +
> +		connector@1 {
> +			compatible = "usb-c-connector";
> +			reg = <1>;
> +			power-role = "dual";
> +			data-role = "dual";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +
> +					pmic_glink_ss1_hs_in: endpoint {
> +						remote-endpoint = <&usb_1_ss1_dwc3_hs>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +
> +					pmic_glink_ss1_ss_in: endpoint {
> +						remote-endpoint = <&retimer_ss1_ss_out>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +
> +					pmic_glink_ss1_con_sbu_in: endpoint {
> +						remote-endpoint = <&retimer_ss1_con_sbu_out>;
> +					};
> +				};
> +			};
> +		};
> +
> +		connector@2 {
> +			compatible = "usb-c-connector";
> +			reg = <2>;
> +			power-role = "dual";
> +			data-role = "dual";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +
> +					pmic_glink_ss2_hs_in: endpoint {
> +						remote-endpoint = <&usb_1_ss2_dwc3_hs>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +
> +					pmic_glink_ss2_ss_in: endpoint {
> +						remote-endpoint = <&retimer_ss2_ss_out>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +
> +					pmic_glink_ss2_con_sbu_in: endpoint {
> +						remote-endpoint = <&retimer_ss2_con_sbu_out>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +
> +	vreg_edp_3p3: regulator-edp-3p3 {

Here is a list of the top-level nodes defined in this DT. Does it look
sorted?

	aliases
	chosen
	pmic-glink
	regulator-edp-3p3
	sound
	regulator-vph-pwr
	regulator-nvme
	regulator-rtmr0-1p15
	regulator-rtmr0-1p8
	regulator-rtmr0-3p3
	regulator-rtmr1-1p15
	regulator-rtmr1-1p8
	regulator-rtmr1-3p3
	regulator-rtmr2-1p15
	regulator-rtmr2-1p8
	regulator-rtmr2-3p3
	regulator-wcn-3p3
	usb-1-ss0-sbu-mux
	regulator-wcn-0p95
	regulator-wcn-1p9
	regulator-wwan
	audio-codec
	wcn7850-pmu


-- 
With best wishes
Dmitry

