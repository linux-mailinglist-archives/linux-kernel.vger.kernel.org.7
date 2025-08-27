Return-Path: <linux-kernel+bounces-787478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 880A6B37707
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 03:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F6012A6169
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 01:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D0C1EB9E3;
	Wed, 27 Aug 2025 01:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mv52OYtl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5711DD9D3
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258567; cv=none; b=sLy5PsMCIWOrE89eOoMtuQ+JfRhZCArJSyul39xKs4jxPsYFzX2AHBH+qyvwg3P6Pplkh/Z1sqP9Q7rStNJnjMCYGxw06CJCnTBdcH12JP/cH9J9xnRn99hV0BYAJeOLQG8tEYWp6+vl2x+Q6XZPMXKUcKqUZ9yL8dfx1MbrU1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258567; c=relaxed/simple;
	bh=dLtbAOy3Al7ntneY5m6QeaS3+rQWEwiiPaCM5hdVMLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=of1ePcGCF9WRKKc95jL1H6CRPQuySAW5wlbNbObZW3ILYsyK3ieF99ldt5CI0kJjjfT+KSIWhHQ+V5dwjJe+aAXl6rQsevjHL0HqvRIzbTzeVTrwPra5JzUinQmiM0i2PZ2deIDc68WYTJ7bv7B9/s3puiuf6fLmPQd0NT+iQFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mv52OYtl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QGC5TI004416
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:36:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=1PV4FHH7FYcoWRrCgIX4mrtV
	qFom0HRFEZhw9/QxUVw=; b=mv52OYtlJPP3UQm75wK9b6C1nlhoQMOYAXG+6TCR
	paihzPxa52dYVf1THiYBACbpJ0enZFNNzv5LM/jq+vMFgFrYOtyssa1q/1GzztUZ
	LyRoWu4Bea0yeMM4lhP916GV04r7RryiohBOH/436vPLywAByFVgbL38U/kE/HZn
	m0AcODpFlQEAs8QhQpjPLcjn8qvLdHrJ2Kot6JafaBb4WGepAmYCSWkoom+zfaZX
	oles/FVBr7ezEIRgiM+fwest0BsdNR7W09WUMqESdrbA72u6P+2aoBO2bKYuS6FT
	bgaOAEcMcl6dceDj/wEs6ofNx+Lo0luaffd7+DUG26u7Rg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5we2r1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:36:03 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b109bd3fa0so61716731cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 18:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756258563; x=1756863363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PV4FHH7FYcoWRrCgIX4mrtVqFom0HRFEZhw9/QxUVw=;
        b=TrF1Y0cXjQt/F3lWZSvI2nxVLw0rZVjfFucliziZxhg2t93Dh8K8doZp9d1VK04fQU
         HhMaFzq2Nju2l/QSjzQbqByHau0HQhyQdGLycORVYd0/yAarXV/nfMSiduuaIuqGF0Ah
         +dTe1ex/HPkYe1svq43YpZFlCaPKiN8C/g8JT+5AK5Nvdhfar3yTL9g2+YtlTkhYDVj7
         ek5N0V63G/Qu74/uyQ8tevh7mEKzYA6fsufEdykri1USwN4Vc++UCNjIlopl5XN8LYPB
         VjVIrYm1SIIYTybSbvNOJp+ONlNYPgxIIgU4vf3m+VtC6v3kaMvC0l2bfomeCBsRty4V
         i1ZA==
X-Forwarded-Encrypted: i=1; AJvYcCV73G24CDQAdeA7Gf3sbgmEsmnQMPw4SUoW4zc7C2mDK4SpN9y7+siufSIMLPjZ+zIhynK0pSfqncTLdOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqugZCzz7jmsTlUSiFpXR0BisOtk0M5zz4oCZa4D7KhiMcK6zp
	NlskYqDcV+3VZQgMH1LHanlbBOJP4Y6Dnj7GEZK2a9GVRJrOYff93ennhR+RpBahRJHwl6Hk1IZ
	DnFGVohgYtViWWQcKpJmB22QiakPBxGtTvN6BsetPcxQcbGH5z8JW8JLgAP8pBcaoHls=
X-Gm-Gg: ASbGncsvFUOQ/XUnKy0kKZ3EACgamnDRfqUJ87S8082bnHlXfm5UWl5xJ6TkiZyIBAl
	qkOc0m6SCKwyM4n2kLytnk5WGYM/dEkUVMGPG7hO+fdXCnp5s2pcuQ0iENL2H9DGWQdjvmSz6Md
	Sp9i5YktuXPgkjfpW8mVUU/ZIq/Xi/oVVev8bjdm+ev9jg071IWgW7oPBCN62w709SpKQWCKxsW
	Fhdi/jsA+ymWkQMTxpeT24un4d3Tx3FY4lVPq9goPX0U/V21SXIkVxFJla+zXZIvVxdCRGhjxX4
	AJsQXB5WsB9uHmp+jcR7aPnjifgP6x01ocezMUG2tAO9EcXpS/d8Jk8HwTMeQwikpbolfU/vLej
	pgxvz3T4/SNksw68kc5NNRk5tzjyaI7rp9ulicgGznErIBhgwYunE
X-Received: by 2002:ac8:5e14:0:b0:4b0:67c9:fd3f with SMTP id d75a77b69052e-4b2aab20a48mr236543461cf.51.1756258562665;
        Tue, 26 Aug 2025 18:36:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/dgryyUxS5WO/q5gj1Tl3Ipo6ZRLnJI6T4Ubswm19yZunDtrbO1VFLpdWSQydKXSKYMyCTA==
X-Received: by 2002:ac8:5e14:0:b0:4b0:67c9:fd3f with SMTP id d75a77b69052e-4b2aab20a48mr236542971cf.51.1756258562040;
        Tue, 26 Aug 2025 18:36:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35c02dcdsm2540804e87.13.2025.08.26.18.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 18:36:01 -0700 (PDT)
Date: Wed, 27 Aug 2025 04:35:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Sushrut Shree Trivedi <quic_sushruts@quicinc.com>,
        Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Monish Chunara <quic_mchunara@quicinc.com>,
        Vishal Kumar Pal <quic_vispal@quicinc.com>
Subject: Re: [PATCH 3/5] arm64: dts: qcom: lemans-evk: Extend peripheral and
 subsystem support
Message-ID: <kycmxk3qag7uigoiitzcxcak22cewdv253fazgaidjcnzgzlkz@htrh22msxteq>
References: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
 <20250826-lemans-evk-bu-v1-3-08016e0d3ce5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826-lemans-evk-bu-v1-3-08016e0d3ce5@oss.qualcomm.com>
X-Proofpoint-GUID: WJIF0U1sNjN4YcHUN2iuyaZCjEmX6oq5
X-Proofpoint-ORIG-GUID: WJIF0U1sNjN4YcHUN2iuyaZCjEmX6oq5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX5v7f4QlILUSo
 HqzOn+VamRfA38+cvUbLaLk++0z7CFROGXSpEY094CNSDrrXrcZSFRxBxZSols9JIIjxWNLYp8h
 80eUeNLu5Zcolhpj4PSdQP2KSZoZac+BtRUi1XsdrY2iGCHxcgtAmkqivM3dCM6ibdLXunFkCMB
 x6OBSGirfFyp91V5mPVIOYczA6/BW5mAERhS15CyhjLB7l8Zzi5lPFgdpr0JMl5wEI9d++c5gwB
 WATdG8ym5Z+TakdpGyYBWj5gJ6nbzX7GqX2wvaCekQyEnWBeRfxCLhs1x4UsGBIx6Sl80rpq9sn
 EC8hNc/XcJ4rcwxSyhD6w6YPXzMaDdfedcsiEMJH2XN7mSzMfzcb1U/TBNb0GHcEuMwNEA0G5T0
 ERgdOXa5
X-Authority-Analysis: v=2.4 cv=BJazrEQG c=1 sm=1 tr=0 ts=68ae6103 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=GE9niwbHW9fFSqPIJ0AA:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230033

On Tue, Aug 26, 2025 at 11:51:02PM +0530, Wasim Nazir wrote:
> Enhance the Qualcomm Lemans EVK board file to support essential
> peripherals and improve overall hardware capabilities, as
> outlined below:
>   - Enable GPI (Generic Peripheral Interface) DMA-0/1/2 and QUPv3-0/2
>     controllers to facilitate DMA and peripheral communication.
>   - Add support for PCIe-0/1, including required regulators and PHYs,
>     to enable high-speed external device connectivity.
>   - Integrate the TCA9534 I/O expander via I2C to provide 8 additional
>     GPIO lines for extended I/O functionality.
>   - Enable the USB0 controller in device mode to support USB peripheral
>     operations.
>   - Activate remoteproc subsystems for supported DSPs such as Audio DSP,
>     Compute DSP-0/1 and Generic DSP-0/1, along with their corresponding
>     firmware.
>   - Configure nvmem-layout on the I2C EEPROM to store data for Ethernet
>     and other consumers.
>   - Enable the QCA8081 2.5G Ethernet PHY on port-0 and expose the
>     Ethernet MAC address via nvmem for network configuration.
>     It depends on CONFIG_QCA808X_PHY to use QCA8081 PHY.
>   - Add support for the Iris video decoder, including the required
>     firmware, to enable video decoding capabilities.
>   - Enable SD-card slot on SDHC.
> 
> Co-developed-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> Co-developed-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> Signed-off-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> Co-developed-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
> Signed-off-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
> Co-developed-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> Co-developed-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
> Signed-off-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
> Co-developed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> Co-developed-by: Monish Chunara <quic_mchunara@quicinc.com>
> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> Co-developed-by: Vishal Kumar Pal <quic_vispal@quicinc.com>
> Signed-off-by: Vishal Kumar Pal <quic_vispal@quicinc.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 387 ++++++++++++++++++++++++++++++++
>  1 file changed, 387 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> index 9e415012140b..642b66c4ad1e 100644
> --- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> @@ -16,7 +16,10 @@ / {
>  	compatible = "qcom,lemans-evk", "qcom,qcs9100", "qcom,sa8775p";
>  
>  	aliases {
> +		ethernet0 = &ethernet0;
> +		mmc1 = &sdhc;
>  		serial0 = &uart10;
> +		serial1 = &uart17;
>  	};
>  
>  	chosen {
> @@ -46,6 +49,30 @@ edp1_connector_in: endpoint {
>  			};
>  		};
>  	};
> +
> +	vmmc_sdc: regulator-vmmc-sdc {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vmmc_sdc";

Non-switchable, always enabled?

> +
> +		regulator-min-microvolt = <2950000>;
> +		regulator-max-microvolt = <2950000>;
> +	};
> +
> +	vreg_sdc: regulator-vreg-sdc {
> +		compatible = "regulator-gpio";
> +
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <2950000>;
> +		regulator-name = "vreg_sdc";
> +		regulator-type = "voltage";

This one also can not be disabled?

> +
> +		startup-delay-us = <100>;
> +
> +		gpios = <&expander1 7 GPIO_ACTIVE_HIGH>;
> +
> +		states = <1800000 0x1
> +			  2950000 0x0>;
> +	};
>  };
>  
>  &apps_rsc {
> @@ -277,6 +304,161 @@ vreg_l8e: ldo8 {
>  	};
>  };
>  
> +&ethernet0 {
> +	phy-handle = <&hsgmii_phy0>;
> +	phy-mode = "2500base-x";
> +
> +	pinctrl-0 = <&ethernet0_default>;
> +	pinctrl-names = "default";
> +
> +	snps,mtl-rx-config = <&mtl_rx_setup>;
> +	snps,mtl-tx-config = <&mtl_tx_setup>;
> +	snps,ps-speed = <1000>;
> +
> +	nvmem-cells = <&mac_addr0>;
> +	nvmem-cell-names = "mac-address";
> +
> +	status = "okay";
> +
> +	mdio {
> +		compatible = "snps,dwmac-mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		hsgmii_phy0: ethernet-phy@1c {
> +			compatible = "ethernet-phy-id004d.d101";
> +			reg = <0x1c>;
> +			reset-gpios = <&pmm8654au_2_gpios 8 GPIO_ACTIVE_LOW>;
> +			reset-assert-us = <11000>;
> +			reset-deassert-us = <70000>;
> +		};
> +	};
> +
> +	mtl_rx_setup: rx-queues-config {
> +		snps,rx-queues-to-use = <4>;
> +		snps,rx-sched-sp;
> +
> +		queue0 {
> +			snps,dcb-algorithm;
> +			snps,map-to-dma-channel = <0x0>;
> +			snps,route-up;
> +			snps,priority = <0x1>;
> +		};
> +
> +		queue1 {
> +			snps,dcb-algorithm;
> +			snps,map-to-dma-channel = <0x1>;
> +			snps,route-ptp;
> +		};
> +
> +		queue2 {
> +			snps,avb-algorithm;
> +			snps,map-to-dma-channel = <0x2>;
> +			snps,route-avcp;
> +		};
> +
> +		queue3 {
> +			snps,avb-algorithm;
> +			snps,map-to-dma-channel = <0x3>;
> +			snps,priority = <0xc>;
> +		};
> +	};
> +
> +	mtl_tx_setup: tx-queues-config {
> +		snps,tx-queues-to-use = <4>;
> +
> +		queue0 {
> +			snps,dcb-algorithm;
> +		};
> +
> +		queue1 {
> +			snps,dcb-algorithm;
> +		};
> +
> +		queue2 {
> +			snps,avb-algorithm;
> +			snps,send_slope = <0x1000>;
> +			snps,idle_slope = <0x1000>;
> +			snps,high_credit = <0x3e800>;
> +			snps,low_credit = <0xffc18000>;
> +		};
> +
> +		queue3 {
> +			snps,avb-algorithm;
> +			snps,send_slope = <0x1000>;
> +			snps,idle_slope = <0x1000>;
> +			snps,high_credit = <0x3e800>;
> +			snps,low_credit = <0xffc18000>;
> +		};
> +	};
> +};
> +
> +&gpi_dma0 {
> +	status = "okay";
> +};
> +
> +&gpi_dma1 {
> +	status = "okay";
> +};
> +
> +&gpi_dma2 {
> +	status = "okay";
> +};
> +
> +&i2c18 {
> +	status = "okay";
> +
> +	expander0: pca953x@38 {
> +		compatible = "ti,tca9538";
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		reg = <0x38>;
> +	};
> +
> +	expander1: pca953x@39 {
> +		compatible = "ti,tca9538";
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		reg = <0x39>;
> +	};
> +
> +	expander2: pca953x@3a {
> +		compatible = "ti,tca9538";
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		reg = <0x3a>;
> +	};
> +
> +	expander3: pca953x@3b {
> +		compatible = "ti,tca9538";
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		reg = <0x3b>;
> +	};
> +
> +	eeprom@50 {
> +		compatible = "atmel,24c256";
> +		reg = <0x50>;
> +		pagesize = <64>;
> +
> +		nvmem-layout {
> +			compatible = "fixed-layout";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			mac_addr0: mac-addr@0 {
> +				reg = <0x0 0x6>;
> +			};
> +		};
> +	};
> +};
> +
> +&iris {
> +	firmware-name = "qcom/vpu/vpu30_p4_s6.mbn";

Should it be just _s6.mbn or _s6_16mb.mbn?

> +
> +	status = "okay";
> +};
> +
>  &mdss0 {
>  	status = "okay";
>  };
> @@ -323,14 +505,196 @@ &mdss0_dp1_phy {
>  	status = "okay";
>  };
>  
> +&pcie0 {
> +	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 0 GPIO_ACTIVE_HIGH>;

I think Mani has been asking lately to define these GPIOs inside the
port rather than in the host controller.

> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie0_default_state>;
> +
> +	status = "okay";
> +};
> +

[...]

> @@ -356,6 +720,29 @@ &ufs_mem_phy {
>  	status = "okay";
>  };
>  
> +&usb_0 {
> +	status = "okay";
> +};
> +
> +&usb_0_dwc3 {
> +	dr_mode = "peripheral";

Is it actually peripheral-only?

> +};
> +

-- 
With best wishes
Dmitry

