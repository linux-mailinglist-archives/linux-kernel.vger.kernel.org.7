Return-Path: <linux-kernel+bounces-842959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D0ABBE101
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 14:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 490F23BC078
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 12:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7634527A907;
	Mon,  6 Oct 2025 12:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T7ioULsY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F8725783B
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 12:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759754486; cv=none; b=U2Dn274WrqV7fHYADrIojWcDQ+BLR3jxMJt0JBcILgUqHdFm9Z3ITiJdLVTTNXZ8kQ+9y6VIgGr8MpyAeyhiGIFrFFWDXDprOM96pE7GzxNorPiB0gQSNiEd0+wi1PM58aErLkcnAI3/JEN3aNDC0UGTAs/ORY2P5oXC0hNa2PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759754486; c=relaxed/simple;
	bh=0mkWvVdXxn2wUvjtU5oKLtZo4yzstBLNeZ/HFxFhqgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gZUeUYl79FjZYVIYXwUSe7F+1eCxKmelcBakHDYtZE98BNdVifypj6/6+7jMFEDC18ZG+roix5caIG3bTUKDq+TJ4kxTIAzM+clphKSj/pc62BO+F/lgKopruouI/JqjF7rzpSXKC59QfI5hRImDiDGijieGffYCPZ89P3IPtSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T7ioULsY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 595NDfGu000970
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 12:41:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ylaB+oXrxe0+pgv6AwGh4kUHExSYxwOnq/WJa7AKAso=; b=T7ioULsYmZpcoJwl
	bC8S+pVrCYbMmhaPV6dFUQHJtctpi/LoYkP91rjmwV3BvKpciKUHkQubKkgV2ZmI
	8xQ3eWdI/uWlFja2MoprBXPKeC/TEywClVGLCw1eLKKa/JvkaENcBWTaTeDG4Lkq
	6uUIC/6LM2CWPdD7FbKkpYfUF5nbTmfq1W1e8NCXP4iybW5MuBHG7HAZN2whhD/D
	HbS1zNUTxUDReRQQ57CEkvlpNEJ7YlDp0V2N2FxCwt/8La4/VNMyB0mWT/IiU+VE
	RfBnfuMAWLb5z3cK4+WRNA6XPUqRKoWzTFgK5ri6TtV+X+LDcm3szTJlTteA17mn
	gvUP3w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49js9dv1tn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 12:41:24 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ded29823ebso8264021cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 05:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759754483; x=1760359283;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ylaB+oXrxe0+pgv6AwGh4kUHExSYxwOnq/WJa7AKAso=;
        b=QGCLxOkhq+yfT/NWX58CjYC9VnG06EhnHCTJsFZvd+E7VFSbazVMkEG574ieYmJonX
         prItqzuxEujtTnVRCCjIcDdS9GialDqAOuc3VpAgT6tlCd3oXT/reUjZ0vhr93U5TvME
         8IYkrrHPTFxMHVZ2erjFtjC0yvQGwi09yssdLoKXiZnHh1Szjc8kvNfuShV1cvGYuZUL
         BtLb1fO3cga27loBcRdXbVqYH8V75iLSzFx2Dtxh5uN27ni7EPp/ghYO32/wj7Z4lkkD
         HdXrB5YE5XLOGCQu19uggNTOz9/U9xGjgtLYiQnwBCGBo6iLd4fN/wGIC2Z1POrYMb72
         zwlA==
X-Forwarded-Encrypted: i=1; AJvYcCWhU96HX6p0fP+Jpj9urkB/t/Afvf+GBYWy/iUgv9/UY4YrrS6kXAuDppjZTrVbrLT4T6CRsg7sS9jZ9as=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6oGBqAHFcMF0WDsuPgsvWTw+qofWRqagodu1mX9pzzlNv+T5e
	SJWc5HeVfqjmpLrWP3aMzLKp6WeLcwQe5EY9Jqk14Bj3fwIus2Z9w9jnFO2+OhGuCszeavWCkKO
	oRN2GDRTau4JOhSSvvIFpwgWPnCXobhwPvYOyGHjfqD+qb+PoDvq6XPHPf/d50iq9KwQ=
X-Gm-Gg: ASbGncsbPDb7twyLcVUQ10yWDdeQotEswWG9OVP3KAkDQdMSwD7zan5qM9LOC2ClRlI
	NYRykgqgaWyCWVacjQDTYpgkZQ2PS6F1ipZhnwYMu7fmVOpIVKtGTAxS6ZAGq4NlYP7BZQXeYWz
	mpJfE2pI6oieQY+NbJ5w5tlQ+nRZMjGxU0T+njHPkxFFMgmTxzkel7zmrUckKoFSOYuieOY2ajg
	FdPQ35eNtMdDqyFSpZS14eTVRn46OkFM+Tx3TQFV9Kb4XfPomq83xvFjBHMGo20eiklFHzyfXvu
	96hf0x/DJPVY8gCYHntqQ7LuHMW89nTojoTkkBz5bJA8mb6YN8HQ95vg0U5S5l0WfqyszeeyGgR
	AjSHxnqrXYvSghtiiaPRlfsqklhQ=
X-Received: by 2002:ac8:5f91:0:b0:4b7:aa56:c0f8 with SMTP id d75a77b69052e-4e576a4b14emr99167321cf.4.1759754482450;
        Mon, 06 Oct 2025 05:41:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWf8WDHwf7+GFY86q3ArprOZHi6q5sn356YIXo0h3Tx0U51KUsNyxrt2pDL2G4L8m5exlggA==
X-Received: by 2002:ac8:5f91:0:b0:4b7:aa56:c0f8 with SMTP id d75a77b69052e-4e576a4b14emr99166921cf.4.1759754481760;
        Mon, 06 Oct 2025 05:41:21 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63788111f1fsm10279311a12.36.2025.10.06.05.41.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 05:41:21 -0700 (PDT)
Message-ID: <2e4b995e-57ae-412f-ae88-c3708a5f67ee@oss.qualcomm.com>
Date: Mon, 6 Oct 2025 14:41:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: Add support for Pixel 3 and Pixel 3
 XL
To: david@ixit.cz, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Pundir <amit.pundir@linaro.org>,
        Casey Connolly <casey@connolly.tech>,
        Joel Selvaraj <foss@joelselvaraj.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, Vinod Koul <vkoul@kernel.org>
References: <20251005-pixel-3-v1-0-ab8b85f6133f@ixit.cz>
 <20251005-pixel-3-v1-2-ab8b85f6133f@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251005-pixel-3-v1-2-ab8b85f6133f@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Hrl72kTS c=1 sm=1 tr=0 ts=68e3b8f4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=ev71qlw1QQQPEuQK8qEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: 398HgqBq4W5F0nAfRtNKp3p_gOeqD3ub
X-Proofpoint-ORIG-GUID: 398HgqBq4W5F0nAfRtNKp3p_gOeqD3ub
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwNCBTYWx0ZWRfXyq3XmB8SgjUw
 +Lxj7EK2IcKh+4PscvkygWHH+0eTpmQ703kd2FoHaFm4NdSi8rXt+krZUtyyl7TQOVMpc50wNdY
 aKqCtQBVwySuPb5mm/l2CGzOK5FjePTFu8iRWvBP/V/2jqgqncXAH5PDBbMMhsrXZSkF4WBYRoN
 opJjd0jRJ9gkNbfvxeARpEoCZtF8ECsVlSvTYXkoVX1yDhpfJxBR1rT1jcftPPs/nH8EhagVCyt
 lcgrrUS7wokLH1sSq/5X9wlm1iYtF09EZAQvDkS/8VbIiyFEnB4YkEwYXAd4f2JF/LO/iIrHgr6
 Q4uJB7C3jnAb4x1xq909teKhWTQ1ezBA8KrC373xOWHsJhAM5wjSFO8eLRKW/IdStkq3D4gtIL9
 A2N/olob8juKFpSA0VBPweoTRqUQcw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_04,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040004

On 10/5/25 3:16 PM, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> This adds initial device tree support for the following phones:
> 
>  - Google Pixel 3 (blueline)
>  - Google Pixel 3 XL (crosshatch)
> 
> Both phone boards use the same identifiers and differ only slightly
> in their connected peripherals.
> 
> Supported functionality includes:
>  - Debug UART
>  - UFS
>  - Charger
>  - USB-C (peripheral mode)
>  - Display (Pixel 3 only)
> 
> GPIOs 0–3 and 81–84 are not accessible from the application CPUs,
> so they are marked as reserved to allow the Pixel 3 to boot.
> 
> The rmtfs region is allocated using UIO, making it technically "dynamic."
> 
> Its address and size can be read from sysfs:
> 
> $ cat /sys/class/uio/uio0/name
> /sys/class/uio/uio0/maps/map0/addr
> 0x00000000f2701000
> 
> $ cat /sys/class/uio/uio0/maps/map0/size
> 0x0000000000200000
> 
> Like the OnePlus 6, the Pixel 3 requires 1 kB of reserved memory on either
> side of the rmtfs region to work around an XPU bug that would otherwise
> cause erroneous violations when accessing the rmtfs_mem region.

[...]

> +&gmu {
> +	status = "okay";
> +};

It's already enabled> +
> +&mdss {
> +	status = "okay";
> +};
> +
> +&mdss_dsi0 {
> +	status = "okay";
> +	vdda-supply = <&vdda_mipi_dsi0_1p2>;

'status' should be last, with a \n before it

> +
> +	ports {
> +		port@1 {
> +			endpoint {

&mdss_dsi0_out {} instead

> +				remote-endpoint = <&panel_in>;
> +				data-lanes = <0 1 2 3>;
> +				qcom,te-source = "mdp_vsync_e";
> +			};
> +		};
> +	};
> +
> +	panel@0 {
> +		compatible = "lg,sw43408";
> +		reg = <0>;
> +
> +		vddi-supply = <&vreg_l14a_1p88>;
> +		vpnl-supply = <&vreg_l28a_3p0>;
> +
> +		reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&panel_reset_pins &panel_te_pin &panel_pmgpio_pins>;

property-n
property-names

in this order, please

> +
> +		port {
> +			panel_in: endpoint {
> +				remote-endpoint = <&mdss_dsi0_out>;
> +			};
> +		};
> +	};
> +};
> +
> +&mdss_dsi0_out {
> +	remote-endpoint = <&panel_in>;
> +	data-lanes = <0 1 2 3>;
> +};

(as mentioned above..)

[...]

> +		/* rmtfs lower guard */
> +		memory@f2700000 {
> +			reg = <0 0xf2700000 0 0x1000>;
> +			no-map;
> +		};
> +
> +		rmtfs_mem: memory@f2701000 {
> +			compatible = "qcom,rmtfs-mem";
> +			reg = <0 0xf2701000 0 0x200000>;
> +			no-map;
> +
> +			qcom,client-id = <1>;
> +			qcom,vmid = <15>;
> +		};
> +
> +		/* rmtfs upper guard */
> +		memory@f2901000 {
> +			reg = <0 0xf2901000 0 0x1000>;
> +			no-map;
> +		};

qcom,use-guard-pages instead

[...]

> +		vreg_l14a_1p88: ldo14 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-boot-on;
> +			/*
> +			 * We can't properly bring the panel back if it gets turned off
> +			 * so keep it's regulators always on for now.
> +			 */
> +			regulator-always-on;

Sounds like your panel driver is not sequencing things properly

[...]

> +&uart9 {
> +	label = "LS-UART1";

This is a 96boards-ism> +
> +	status = "okay";
> +};
> +
> +&usb_1 {
> +	status = "okay";
> +};
> +
> +&usb_1_dwc3 {
> +	dr_mode = "peripheral";

Are you sure?

[...]

> +&usb_2 {
> +	status = "okay";
> +};
> +
> +&usb_2_dwc3 {
> +	dr_mode = "host";

Does the phone actually have something connected to both USB hosts?

Would that be the weasel(?) security chip?

[...]

> diff --git a/arch/arm64/boot/dts/qcom/sdm845-google-crosshatch.dts b/arch/arm64/boot/dts/qcom/sdm845-google-crosshatch.dts
> new file mode 100644
> index 0000000000000..dc9938ffc0ab8
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm845-google-crosshatch.dts
> @@ -0,0 +1,137 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/dts-v1/;
> +
> +#include "sdm845-google-common.dtsi"
> +
> +/ {
> +	model = "Google Pixel 3 XL";
> +	compatible = "google,crosshatch", "qcom,sdm845";
> +
> +	battery: battery {
> +		compatible = "simple-battery";
> +
> +		charge-full-design-microamp-hours = <3480000>;
> +		voltage-min-design-microvolt = <3600000>;
> +		voltage-max-design-microvolt = <4400000>;
> +	};
> +
> +	chosen {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		/* for u-boot */
> +		framebuffer: framebuffer@9d400000 {
> +			compatible = "simple-framebuffer";
> +			reg = <0 0x9d400000 0 (2960 * 1440 * 4)>;
> +			width = <1440>;
> +			height = <2960>;
> +			stride = <(1440 * 4)>;
> +			format = "a8r8g8b8";
> +		};
> +	};
> +
> +	reserved-memory {
> +		framebuffer_region@9d400000 {
> +			no-map;
> +			reg = <0 0x9d400000 0 0x02400000>;
> +		};
> +	};
> +};
> +
> +&gmu {
> +	status = "okay";
> +};
> +
> +&mdss {
> +	status = "okay";
> +};

I'm sure you can push some of this into -common

> +
> +&mdss_dsi0 {
> +	vdda-supply = <&vdda_mipi_dsi0_1p2>;
> +
> +	status = "okay";
> +
> +	ports {
> +		port@1 {
> +			endpoint {
> +				remote-endpoint = <&panel_in>;
> +				data-lanes = <0 1 2 3>;
> +				qcom,te-source = "mdp_vsync_e";
> +			};
> +		};
> +	};
> +
> +	panel@0 {
> +		compatible = "samsung,s6e3ha8";
> +		reg = <0>;
> +
> +		vci-supply = <&vreg_l28a_3p0>; // downstream

which supply should /* upstream */ use then? :(

Konrad

