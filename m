Return-Path: <linux-kernel+bounces-749292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0393FB14C6F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26ACE3A829A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29F628A3FC;
	Tue, 29 Jul 2025 10:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gCYAx5kw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85597CA52
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 10:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753785879; cv=none; b=RZmscTzv9j0gd5OQFWUGv/ilEnpeIpiVfwA6biZoZfVq7vyh1NdXg5mIWIIuOOkX2zgPWUDFC9ougIHFGlvaRKFxwkigGc3/SY55qXo1R5rUPeOJat+ztSrxN5Vb/3UJdMcTfZpCbedAvAi3BOh6EQ8NZBAAd4bdF/cOogY7GUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753785879; c=relaxed/simple;
	bh=kx22wv5y0uXVNzKUlfVRlqHXCQoKxTvLhRy/WnFVjwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCS8UmMAUTHMNsJDgYuJmj3He7SY9lVuBs8HTnOTLEAr15smGBhwYlp4yQaqWZJ3fgtNTjbeSIZSdft0o8zxVxR1WCVt8Je458Teas9t4IJ86gwC40hxYYw3kau/I803Wd2SSh25LcKPCfRVxrOS+KJ4vHB2EP0oApRUi+OrD3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gCYAx5kw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T9EPDI027028
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 10:44:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ifvFUWHBxlHpG5HvBD9gHPh0d62pMERGDZHT82cOib4=; b=gCYAx5kwy7bReV7F
	YmxR1RsK9dcc9PCrqyyONUgZNecZEPHlt09FLU902mok9+F7mTe7R1Tef2T8V0mJ
	ooTDR/OS6YTQjy31o2zoSeXT2fgkq7Qjm3rTkTe6+YfbG6neMbp8/wVGkgWeO/FS
	+vjQaBSZgB6JQkP8ozCbkSpyZ8dGH2ICTCbdXchn/KQC+6UkPR6/gtu81g/65KuK
	hDHtZXV6CNGQaMikj6UTGcGi93Lt1goStLiWRsDCR2qTKvyXR3Casja0dGQgcRdc
	7N4UtD35mFhnhuN4awBxHF9pZ5xSuN9Mrc0+7Eo+Oj1eohGLX1NVjQ7wINAZWhFY
	p+dEOQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484q3xqrv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 10:44:35 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7073a52a800so41973576d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 03:44:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753785874; x=1754390674;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ifvFUWHBxlHpG5HvBD9gHPh0d62pMERGDZHT82cOib4=;
        b=Wiyercgo+lDd3i4RkXGtANMU/rveSBxqA9OT9VJe91hJRCHOZY/WzM7DuWrzf46Feu
         aOFhYhseOJPciJZdsWJK4O1yCeXedIaMsgOdmPoLDYE9bp7FZUexzdfPX9ijLzVKWfNN
         ihG+LxkEmcPL2iSapzBb6e0F5O1rOs4gadZMpKnXWsoUB9/ftd8gVUp+oLHEDzwIYPL0
         XecGVKGYT6/A+ew7LzFUvhQzamBhUgzFcNGA8B1hO+ICD+p7nkUtFDy0qItcrqNQW2BU
         K0IgsU/JRPqussyvbk6jK9WeFkwtD+0jt9CjITHZNdW78QXORRWfmWvdzB26HWSPicTV
         8w0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7DcsgQcW3AWUsnSLe8zzGqPw5ZR0JlR8Mbw+o7NjIgN18h+ioSE9/4k3OJckfPJT1unPbR5TI4iZBa2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy77aZ20g/MEcKpMa+U8lp1sl1mZwlG5BiNh7HApa6Bf/aPAR2i
	CLu8N5kecGVYnFMTl8EWr0NVvfBmH4kbj3TEtcdw344Xz3uC4oTLFNtAkTknT5GS4f5E/gVkA/5
	zRzm6w0Dr9rA5c3fAmfiOmX/gI0bRhBAhNfvupn8psbn3yf63T4B4HpaWYpCRXO+7cqA=
X-Gm-Gg: ASbGncvaFo76t6odU/hoUU9lME7vERtv0IfWv9WMTUfK3KBQy1rQN/ciioKYAMbqVOT
	o++mlVc9Pte7aEET5ynT+D/zQ8k0agwL/OfSqUZawbbS3XvnkUipxgl+cQzDCNdsRuQxtncA43l
	F0Vg3wbmC+4qgf+89zfGRux2oaiVTdR0LPpVDK5uV1BV90C/p0/YzX7xD2j783MxiwaDLko3ETQ
	EIFTOWXSceAxoJAgJAWdHEXoT+k1LPNunQ43RBtYWGC/hq+y1G0MkLcMKxZMmnz4SQaV+mkcu4M
	DjrFm8wHwSAvNEz2f1CuY/WmFwZtnA/2emZIE7enb9rp1HUoac+kbFSON8pF3kCuH1dW8ymRj+7
	ZripCZ5/yv36iOGgOldQuyaPINp1KBhwbsPSTg1TTDJ5M6eEq83QE
X-Received: by 2002:ad4:4eae:0:b0:707:4998:711d with SMTP id 6a1803df08f44-70749987306mr99408436d6.34.1753785873932;
        Tue, 29 Jul 2025 03:44:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrGN4aDSAG3bfZTJoY3d8K+R1vNk2yff6sOU7VXP4ynjFrwUfnFzchjFlOFvtJOZvI6ffYQA==
X-Received: by 2002:ad4:4eae:0:b0:707:4998:711d with SMTP id 6a1803df08f44-70749987306mr99408056d6.34.1753785873403;
        Tue, 29 Jul 2025 03:44:33 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b6316da6esm1650139e87.24.2025.07.29.03.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 03:44:32 -0700 (PDT)
Date: Tue, 29 Jul 2025 13:44:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yijie Yang <yijie.yang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] arm64: dts: qcom: Add HAMOA-IOT-SOM platform
Message-ID: <5hgynbka274jerw5x6ekfuoj45k6bqt2hdbsx2puniqornil4s@pdgavjb2jeci>
References: <20250729-hamoa_initial-v3-0-806e092789dc@oss.qualcomm.com>
 <20250729-hamoa_initial-v3-3-806e092789dc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250729-hamoa_initial-v3-3-806e092789dc@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=JovxrN4C c=1 sm=1 tr=0 ts=6888a613 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=iKAs9ygTOJ3BdjUPMb0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: uDYhRux-wCKZzpWhlHpsGyCgwofAQTU3
X-Proofpoint-GUID: uDYhRux-wCKZzpWhlHpsGyCgwofAQTU3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDA4MiBTYWx0ZWRfX2rlJPFeFBCXq
 A91Ky5r3wrx2mUwcmrJh7nEWSIvz4OysisdcXjJ/GJvtDzu2qf9x/ZGBM5bJ8o4tQTJ9DW0erK3
 jgibBPW5pAEjs9h8sGv50MFLKJkmOlFTFnlEUv28yIXX/qTsFby/Lk8ko/jEh7lYV2rCS6jjY8H
 MdAOK2dPV4vMAhkQlxnWGpnqQhTvMU+qX0BFmYQaAaJIW7uUn+ohDEux9pWi0laOLjF7XYzy0Gg
 MgGlQgg6qxGd8BFSzqJm5WREnUGtNuj6RJyJRKVF7n1sx3kIhyOwsUyFGc1e4GBADKZDoku8OuY
 UgyGvOeUHNFXK30LOYmKTSrcx1ufUK485OwpvVSCnu6efe0Tc0bsePdCVid4hahMSxIqo5Kcmq6
 rtCy3zbOaKwDTO9s9hGDlwQpw0cuwRNCRGhKsncSv+vaHDXXdJYlxorWtXNj6a+3bYlAudpG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_02,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290082

On Tue, Jul 29, 2025 at 09:31:59AM +0800, Yijie Yang wrote:
> The HAMOA-IOT-SOM is a compact computing module that integrates a System
> on Chip (SoC) — specifically the x1e80100 — along with essential
> components optimized for IoT applications. It is designed to be mounted on
> carrier boards, enabling the development of complete embedded systems.
> 
> This change enables and overlays the following components:

What does this mean, how can it overlay something?

> - Regulators on the SOM
> - Reserved memory regions
> - PCIe6a and its PHY
> - PCIe4 and its PHY
> - USB0 through USB6 and their PHYs
> - ADSP, CDSP
> - WLAN, Bluetooth (M.2 interface)
> 
> Written with contributions from Yingying Tang (added PCIe4 and its PHY to
> enable WLAN).
> 
> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi | 609 ++++++++++++++++++++++++++++
>  1 file changed, 609 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi b/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..5facc5544c3df05b89b25fbcb5cd331e93040f15
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
> @@ -0,0 +1,609 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include "x1e80100.dtsi"
> +#include "x1e80100-pmics.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +
> +/ {
> +	compatible = "hamoa-iot-som", "qcom,x1e80100";
> +
> +	reserved-memory {
> +		linux,cma {
> +			compatible = "shared-dma-pool";
> +			size = <0x0 0x8000000>;
> +			reusable;
> +			linux,cma-default;
> +		};
> +	};
> +};
> +
> +&apps_rsc {
> +	/* PMC8380C_B */
> +	regulators-0 {
> +		compatible = "qcom,pm8550-rpmh-regulators";
> +		qcom,pmic-id = "b";
> +
> +		vdd-bob1-supply = <&vph_pwr>;
> +		vdd-bob2-supply = <&vph_pwr>;
> +		vdd-l1-l4-l10-supply = <&vreg_s4c_1p8>;
> +		vdd-l2-l13-l14-supply = <&vreg_bob1>;
> +		vdd-l5-l16-supply = <&vreg_bob1>;
> +		vdd-l6-l7-supply = <&vreg_bob2>;
> +		vdd-l8-l9-supply = <&vreg_bob1>;
> +		vdd-l12-supply = <&vreg_s5j_1p2>;
> +		vdd-l15-supply = <&vreg_s4c_1p8>;
> +		vdd-l17-supply = <&vreg_bob2>;
> +
> +		vreg_bob1: bob1 {
> +			regulator-name = "vreg_bob1";
> +			regulator-min-microvolt = <3008000>;
> +			regulator-max-microvolt = <3960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_bob2: bob2 {
> +			regulator-name = "vreg_bob2";
> +			regulator-min-microvolt = <2504000>;
> +			regulator-max-microvolt = <3008000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l1b_1p8: ldo1 {
> +			regulator-name = "vreg_l1b_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2b_3p0: ldo2 {
> +			regulator-name = "vreg_l2b_3p0";
> +			regulator-min-microvolt = <3072000>;
> +			regulator-max-microvolt = <3100000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l4b_1p8: ldo4 {
> +			regulator-name = "vreg_l4b_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l5b_3p0: ldo5 {
> +			regulator-name = "vreg_l5b_3p0";
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l6b_1p8: ldo6 {
> +			regulator-name = "vreg_l6b_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l7b_2p8: ldo7 {
> +			regulator-name = "vreg_l7b_2p8";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l8b_3p0: ldo8 {
> +			regulator-name = "vreg_l8b_3p0";
> +			regulator-min-microvolt = <3072000>;
> +			regulator-max-microvolt = <3072000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l9b_2p9: ldo9 {
> +			regulator-name = "vreg_l9b_2p9";
> +			regulator-min-microvolt = <2960000>;
> +			regulator-max-microvolt = <2960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l10b_1p8: ldo10 {
> +			regulator-name = "vreg_l10b_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l12b_1p2: ldo12 {
> +			regulator-name = "vreg_l12b_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-always-on;
> +		};
> +
> +		vreg_l13b_3p0: ldo13 {
> +			regulator-name = "vreg_l13b_3p0";
> +			regulator-min-microvolt = <3072000>;
> +			regulator-max-microvolt = <3100000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l14b_3p0: ldo14 {
> +			regulator-name = "vreg_l14b_3p0";
> +			regulator-min-microvolt = <3072000>;
> +			regulator-max-microvolt = <3072000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l15b_1p8: ldo15 {
> +			regulator-name = "vreg_l15b_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-always-on;
> +		};
> +
> +		vreg_l16b_2p9: ldo16 {
> +			regulator-name = "vreg_l16b_2p9";
> +			regulator-min-microvolt = <2912000>;
> +			regulator-max-microvolt = <2912000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l17b_2p5: ldo17 {
> +			regulator-name = "vreg_l17b_2p5";
> +			regulator-min-microvolt = <2504000>;
> +			regulator-max-microvolt = <2504000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	/* PMC8380VE_C */
> +	regulators-1 {
> +		compatible = "qcom,pm8550ve-rpmh-regulators";
> +		qcom,pmic-id = "c";
> +
> +		vdd-l1-supply = <&vreg_s5j_1p2>;
> +		vdd-l2-supply = <&vreg_s1f_0p7>;
> +		vdd-l3-supply = <&vreg_s1f_0p7>;
> +		vdd-s4-supply = <&vph_pwr>;
> +
> +		vreg_s4c_1p8: smps4 {
> +			regulator-name = "vreg_s4c_1p8";
> +			regulator-min-microvolt = <1856000>;
> +			regulator-max-microvolt = <2000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l1c_1p2: ldo1 {
> +			regulator-name = "vreg_l1c_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2c_0p8: ldo2 {
> +			regulator-name = "vreg_l2c_0p8";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <920000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3c_0p8: ldo3 {
> +			regulator-name = "vreg_l3c_0p8";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <920000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	/* PMC8380_D */
> +	regulators-2 {
> +		compatible = "qcom,pmc8380-rpmh-regulators";
> +		qcom,pmic-id = "d";
> +
> +		vdd-l1-supply = <&vreg_s1f_0p7>;
> +		vdd-l2-supply = <&vreg_s1f_0p7>;
> +		vdd-l3-supply = <&vreg_s4c_1p8>;
> +		vdd-s1-supply = <&vph_pwr>;
> +
> +		vreg_l1d_0p8: ldo1 {
> +			regulator-name = "vreg_l1d_0p8";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <920000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2d_0p9: ldo2 {
> +			regulator-name = "vreg_l2d_0p9";
> +			regulator-min-microvolt = <912000>;
> +			regulator-max-microvolt = <920000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3d_1p8: ldo3 {
> +			regulator-name = "vreg_l3d_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	/* PMC8380_E */
> +	regulators-3 {
> +		compatible = "qcom,pmc8380-rpmh-regulators";
> +		qcom,pmic-id = "e";
> +
> +		vdd-l2-supply = <&vreg_s1f_0p7>;
> +		vdd-l3-supply = <&vreg_s5j_1p2>;
> +
> +		vreg_l2e_0p8: ldo2 {
> +			regulator-name = "vreg_l2e_0p8";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <920000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3e_1p2: ldo3 {
> +			regulator-name = "vreg_l3e_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	/* PMC8380_F */
> +	regulators-4 {
> +		compatible = "qcom,pmc8380-rpmh-regulators";
> +		qcom,pmic-id = "f";
> +
> +		vdd-l1-supply = <&vreg_s5j_1p2>;
> +		vdd-l2-supply = <&vreg_s5j_1p2>;
> +		vdd-l3-supply = <&vreg_s5j_1p2>;
> +		vdd-s1-supply = <&vph_pwr>;
> +
> +		vreg_s1f_0p7: smps1 {
> +			regulator-name = "vreg_s1f_0p7";
> +			regulator-min-microvolt = <700000>;
> +			regulator-max-microvolt = <1100000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l1f_1p0: ldo1 {
> +			regulator-name = "vreg_l1f_1p0";
> +			regulator-min-microvolt = <1024000>;
> +			regulator-max-microvolt = <1024000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2f_1p0: ldo2 {
> +			regulator-name = "vreg_l2f_1p0";
> +			regulator-min-microvolt = <1024000>;
> +			regulator-max-microvolt = <1024000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3f_1p0: ldo3 {
> +			regulator-name = "vreg_l3f_1p0";
> +			regulator-min-microvolt = <1024000>;
> +			regulator-max-microvolt = <1024000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	/* PMC8380VE_I */
> +	regulators-6 {
> +		compatible = "qcom,pm8550ve-rpmh-regulators";
> +		qcom,pmic-id = "i";
> +
> +		vdd-l1-supply = <&vreg_s4c_1p8>;
> +		vdd-l2-supply = <&vreg_s5j_1p2>;
> +		vdd-l3-supply = <&vreg_s1f_0p7>;
> +		vdd-s1-supply = <&vph_pwr>;
> +		vdd-s2-supply = <&vph_pwr>;
> +
> +		vreg_s1i_0p9: smps1 {
> +			regulator-name = "vreg_s1i_0p9";
> +			regulator-min-microvolt = <900000>;
> +			regulator-max-microvolt = <920000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s2i_1p0: smps2 {
> +			regulator-name = "vreg_s2i_1p0";
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1100000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l1i_1p8: ldo1 {
> +			regulator-name = "vreg_l1i_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2i_1p2: ldo2 {
> +			regulator-name = "vreg_l2i_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3i_0p8: ldo3 {
> +			regulator-name = "vreg_l3i_0p8";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <920000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	/* PMC8380VE_J */
> +	regulators-7 {
> +		compatible = "qcom,pm8550ve-rpmh-regulators";
> +		qcom,pmic-id = "j";
> +
> +		vdd-l1-supply = <&vreg_s1f_0p7>;
> +		vdd-l2-supply = <&vreg_s5j_1p2>;
> +		vdd-l3-supply = <&vreg_s1f_0p7>;
> +		vdd-s5-supply = <&vph_pwr>;
> +
> +		vreg_s5j_1p2: smps5 {
> +			regulator-name = "vreg_s5j_1p2";
> +			regulator-min-microvolt = <1256000>;
> +			regulator-max-microvolt = <1304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l1j_0p8: ldo1 {
> +			regulator-name = "vreg_l1j_0p8";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <920000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2j_1p2: ldo2 {
> +			regulator-name = "vreg_l2j_1p2";
> +			regulator-min-microvolt = <1256000>;
> +			regulator-max-microvolt = <1256000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3j_0p8: ldo3 {
> +			regulator-name = "vreg_l3j_0p8";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <920000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +};
> +
> +&pcie4 {
> +	perst-gpios = <&tlmm 146 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 148 GPIO_ACTIVE_LOW>;
> +
> +	pinctrl-0 = <&pcie4_default>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +};
> +
> +&pcie4_phy {
> +	vdda-phy-supply = <&vreg_l3i_0p8>;
> +	vdda-pll-supply = <&vreg_l3e_1p2>;
> +
> +	status = "okay";
> +};
> +
> +&pcie6a {
> +	perst-gpios = <&tlmm 152 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 154 GPIO_ACTIVE_LOW>;
> +
> +	pinctrl-0 = <&pcie6a_default>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +};
> +
> +&pcie6a_phy {
> +	vdda-phy-supply = <&vreg_l1d_0p8>;
> +	vdda-pll-supply = <&vreg_l2j_1p2>;
> +
> +	status = "okay";
> +};
> +
> +&qupv3_0 {
> +	status = "okay";
> +};
> +
> +&qupv3_1 {
> +	status = "okay";
> +};
> +
> +&qupv3_2 {
> +	status = "okay";
> +};
> +
> +&remoteproc_adsp {
> +	firmware-name = "qcom/x1e80100/adsp.mbn",
> +			"qcom/x1e80100/adsp_dtb.mbn";
> +
> +	status = "okay";
> +};
> +
> +&remoteproc_cdsp {
> +	firmware-name = "qcom/x1e80100/cdsp.mbn",
> +			"qcom/x1e80100/cdsp_dtb.mbn";
> +
> +	status = "okay";
> +};
> +
> +&tlmm {
> +	gpio-reserved-ranges = <34 2>, /* TPM LP & INT */
> +			       <44 4>; /* SPI (TPM) */
> +
> +	pcie4_default: pcie4-default-state {
> +		clkreq-n-pins {
> +			pins = "gpio147";
> +			function = "pcie4_clk";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		perst-n-pins {
> +			pins = "gpio146";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +
> +		wake-n-pins {
> +			pins = "gpio148";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	pcie6a_default: pcie6a-default-state {
> +		clkreq-n-pins {
> +			pins = "gpio153";
> +			function = "pcie6a_clk";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		perst-n-pins {
> +			pins = "gpio152";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +
> +		wake-n-pins {
> +			pins = "gpio154";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +
> +		};
> +	};
> +};
> +
> +&usb_1_ss0 {
> +	status = "okay";
> +};
> +
> +&usb_1_ss0_dwc3 {
> +	dr_mode = "otg";

Should not be necessary, otg is a default.

> +	usb-role-switch;

This should be a part of the x1e80100.dtsi, but please see commit
7db0ba3e6e6c ("Revert "arm64: dts: qcom: x1e80100: enable OTG on USB-C
controllers"")

> +};
> +
> +&usb_1_ss0_hsphy {
> +	vdd-supply = <&vreg_l3j_0p8>;
> +	vdda12-supply = <&vreg_l2j_1p2>;
> +
> +	status = "okay";
> +};
> +
> +&usb_1_ss0_qmpphy {
> +	vdda-phy-supply = <&vreg_l2j_1p2>;
> +	vdda-pll-supply = <&vreg_l1j_0p8>;
> +
> +	status = "okay";
> +};
> +
> +&usb_1_ss1 {
> +	status = "okay";
> +};
> +
> +&usb_1_ss1_dwc3 {
> +	dr_mode = "otg";
> +	usb-role-switch;
> +};
> +
> +&usb_1_ss1_hsphy {
> +	vdd-supply = <&vreg_l3j_0p8>;
> +	vdda12-supply = <&vreg_l2j_1p2>;
> +
> +	status = "okay";
> +};
> +
> +&usb_1_ss1_qmpphy {
> +	vdda-phy-supply = <&vreg_l2j_1p2>;
> +	vdda-pll-supply = <&vreg_l2d_0p9>;
> +
> +	status = "okay";
> +};
> +
> +&usb_1_ss2 {
> +	status = "okay";
> +};
> +
> +&usb_1_ss2_dwc3 {
> +	dr_mode = "otg";
> +	usb-role-switch;
> +};
> +
> +&usb_1_ss2_hsphy {
> +	vdd-supply = <&vreg_l3j_0p8>;
> +	vdda12-supply = <&vreg_l2j_1p2>;
> +
> +	status = "okay";
> +};
> +
> +&usb_1_ss2_qmpphy {
> +	vdda-phy-supply = <&vreg_l2j_1p2>;
> +	vdda-pll-supply = <&vreg_l2d_0p9>;
> +
> +	status = "okay";
> +};
> +
> +&usb_2 {
> +	status = "okay";
> +};
> +
> +&usb_2_dwc3 {
> +	dr_mode = "host";

Why? Is it actually host-only?

> +};
> +
> +&usb_2_hsphy {
> +	vdd-supply = <&vreg_l2e_0p8>;
> +	vdda12-supply = <&vreg_l3e_1p2>;
> +
> +	status = "okay";
> +};
> +
> +&usb_mp {
> +	status = "okay";
> +};
> +
> +&usb_mp_hsphy0 {
> +	vdd-supply = <&vreg_l2e_0p8>;
> +	vdda12-supply = <&vreg_l3e_1p2>;
> +
> +	status = "okay";
> +};
> +
> +&usb_mp_hsphy1 {
> +	vdd-supply = <&vreg_l2e_0p8>;
> +	vdda12-supply = <&vreg_l3e_1p2>;
> +
> +	status = "okay";
> +};
> +
> +&usb_mp_qmpphy0 {
> +	vdda-phy-supply = <&vreg_l3e_1p2>;
> +	vdda-pll-supply = <&vreg_l3c_0p8>;
> +
> +	status = "okay";
> +};
> +
> +&usb_mp_qmpphy1 {
> +	vdda-phy-supply = <&vreg_l3e_1p2>;
> +	vdda-pll-supply = <&vreg_l3c_0p8>;
> +
> +	status = "okay";
> +};
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

