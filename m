Return-Path: <linux-kernel+bounces-789237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23765B392A0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 06:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF4F9366626
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 04:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45888265298;
	Thu, 28 Aug 2025 04:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dcnU/UKp"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D0118BBAE
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 04:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756355863; cv=none; b=DANrQ/tXN0xSolLqIu4kxdV6384jwh55RZR3jHeygx/WcHHIRr8ysXE7v8qXHbh8t5K8yWpzgXVhxusSdxaVUCGtTTq4Pazn2J9ARbto+ltppuNMhwH99nxxyBdm9EwTyCBkZ/dmROdtHxQNtnGHcbuwIWyFeNnmWVlwNpyKBXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756355863; c=relaxed/simple;
	bh=SM63ocr5WsyFmPZZ1tnmppGJHmbIYvZPuWLBmaoI4Rg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cKc5Ka14s+5d0gOAmC+UbzPca6xTjehioC+C/QYqWFk9EKtcbYARdcAoaW6RUtePvvkRuhsYMLQNd4I1TVohMf9PMFcAcKfs9KcIKAD/t9cZQoBuEA0kafJo37dWD9FZtkEUdEtyJQAauR31F5S3UFqoto/iQ1aukUdwPF0y4to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dcnU/UKp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S3cM6e001842
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 04:37:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZN3zJQ0NotG45c6r+mVj4ZgNnunBtwsO/2vGLq1cU7I=; b=dcnU/UKpf1cQXtzS
	3xoqGAa5i9w/zkrunMfLVEksvjQeWUVWxwDT2zbRE0Ar/SnjH525rMUS2DlKoYl4
	aTlMoGexKfN+MGfOsZbg5pDHZfaLH5jHZ4Dz6+X7LVxpbzrMeZRQd5vID7UBkeK6
	iKMJUKUM5i1apfnNRJT1Mx/xf6RA/29FMJIcDaV8G1czgZ5FMAzKvyXLMMcL1BOp
	9EEtoSIjnI+pmjg2+hdyO8+mYnGcjENOefknaHjo8VSCxlTTsgshlevmlYqjTNkn
	hNWsEZAQOp1hLtydGMycH3Anf54B2Uklyf0EYVbWTZErOiURcWE2UwH+bEhdHxDb
	NtMZMg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48t47b9wwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 04:37:40 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-771e43782aaso517981b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 21:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756355859; x=1756960659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZN3zJQ0NotG45c6r+mVj4ZgNnunBtwsO/2vGLq1cU7I=;
        b=mDp6Mp2f+gsjl456CwPlvuvpiYOIjyRB9NyNo5RibeCFkOqeiuh3cZt3DARfJ+I+T3
         0omQxzIVzJW3KTYWzLpxwnky1eBdQMINQeq0YImKDnDsEYs7SxQv/AwGgvRpmX60vcjc
         BspvU3I6N8YZKaa2yNfHvXY7INiBrt6zBaA4XI02poVZzkHWAFW4ODk91j52gw9lhdEt
         oLMYfYpLPbOZF3W8rWxIE0zDj9aaunmg4GUSYVq4WoztdY9uQ5htLFntoE6nXNcoqi0B
         urQUZnVW0vrw4ymlKJ+Pt+1dFEJs6+r4Lp3Q8zo42zpSklnV7wy5x9gkIJ/xoKQZ9u2T
         kIRw==
X-Forwarded-Encrypted: i=1; AJvYcCUfz72wn3bsSnpbQH/D9lrVZLC48UPIxqNMzlnKdhjkHai5PR7v23JIH6Ll3qnTwnZ2QQj8+ATHhcCBQJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ57jBdZJ12ZsfYEII69qbqJMSXSbgQy5JMOvwOg16aKLLx/hj
	1Gxy6zh3Zb1GO7SUnQxaeHkn5HNnjSTbbDmav/sBf0Ek6cs/1Vkxa31Uf6M24yHg3FEAMxcn+yg
	sCm1s4FoCMdhoYhZsdvyyq6gpC9rxtl0Upx+w9mPWVQXf7Gnsi6U/KVzdrfMYSiKY99Y=
X-Gm-Gg: ASbGncshR4QJI+sKocRG8oDEvS9RCTixmTldlKBQA9z9iQGtH2HbjYra5RQ7yfzi+iI
	kd0tQBBCJKTxMfgCdZKKQLpkMC3SukM2KjpaNB11XRC1bSHgB6hHo59p699OBnHMI+rrbOyxh0h
	hdqaEcVW69wiyjByBgcU1pOdR7kij4cQF411R9J+mVwPPqaF8Byrd1N4urv7D8B1PdwSfj8p+4P
	Pw/aN9I2H+oqomHVBMwRoFNzTjfd9rphqowybQ+jxX6AIQHPv1TqaQxHgdFbXvAXbcRhW3MWzfx
	CvVpZQerpi2L5Acgq4jweKz/xlCNtKvuo86cRP050pp3HINTn0VUUYhlbg4l0fF0CbJDSlFHWLI
	ZTubZ0HRpL4LaulSOPxChP7O6m5IU6IVVcg==
X-Received: by 2002:a05:6a00:88e:b0:772:8fd:d51b with SMTP id d2e1a72fcca58-77208fde388mr5754928b3a.31.1756355858510;
        Wed, 27 Aug 2025 21:37:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvUtJzjXtSzEtE8U7MgmMc74kpMRniCEFwC+y50o0XAfxBhc/m+tAro39rUU4Ln47bgmIxMg==
X-Received: by 2002:a05:6a00:88e:b0:772:8fd:d51b with SMTP id d2e1a72fcca58-77208fde388mr5754535b3a.31.1756355852032;
        Wed, 27 Aug 2025 21:37:32 -0700 (PDT)
Received: from [10.133.33.203] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771e814cbe1sm9130782b3a.27.2025.08.27.21.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 21:37:31 -0700 (PDT)
Message-ID: <43916db8-a9a3-4193-9619-567b0af5fa7b@oss.qualcomm.com>
Date: Thu, 28 Aug 2025 12:37:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] arm64: dts: qcom: Add HAMOA-IOT-SOM platform
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Yingying Tang <quic_yintang@quicinc.com>
References: <20250827-hamoa_initial-v7-0-f9b81d564bb2@oss.qualcomm.com>
 <20250827-hamoa_initial-v7-2-f9b81d564bb2@oss.qualcomm.com>
 <gbdg5hkuzd2oynypnz2j6icauqthnweg4tjimeph4bqwvjdkuc@srkxskvxc6sm>
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <gbdg5hkuzd2oynypnz2j6icauqthnweg4tjimeph4bqwvjdkuc@srkxskvxc6sm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: LaTtif3K9T08wYa2x52FnxP0f0NfObK4
X-Authority-Analysis: v=2.4 cv=CYoI5Krl c=1 sm=1 tr=0 ts=68afdd14 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=QAnuVJbiv_cUMF1-cxkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: LaTtif3K9T08wYa2x52FnxP0f0NfObK4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDEyOCBTYWx0ZWRfX7d0hXDyFBKn8
 oZLM1KvRhy+0cqdIBbwnMMx/HMfdywLrrwNlpHBvKG5ZF2PQ0SbZXzne7MufhtTRk2hZY4LiuXW
 dGWPZ6t1xijcKhDywAZVee3++DIaKH3HWQa0jiYP9Tk+xKapvA6jNdnf0AE6Ez/avpfMENKmmH1
 xK4ZDIyRiC4OIW966l92m4vmFRe9tay0KJoQBcMWybNyZerbpcq0hjY+o+yh//SF4n8LjtWpLEm
 Hs9g3hPqzIA0zVQSMZk/h0F4HHkspZQ6HBHR5ZF49/jGGaK2T4Te73lKwuLj1qXrJhmOv/LlDa8
 9LYxbqCMOw0Ry1aWZj6L8P4f1uB93or/7T3cHjgcILCC2JjcXjadgERkjuCc9Ve+U+rjGL5ncHD
 q94esuqH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_01,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508270128



On 2025-08-28 06:34, Bjorn Andersson wrote:
> On Wed, Aug 27, 2025 at 10:52:19AM +0800, Yijie Yang wrote:
>> The HAMOA-IOT-SOM is a compact computing module that integrates a System
>> on Chip (SoC) — specifically the x1e80100 — along with essential
>> components optimized for IoT applications. It is designed to be mounted on
>> carrier boards, enabling the development of complete embedded systems.
>>
>> This change enables the following components:
>> - Regulators on the SOM
>> - Reserved memory regions
>> - PCIe6a and its PHY
>> - PCIe4 and its PHY
>> - USB0 through USB6 and their PHYs
>> - ADSP, CDSP
>> - WLAN, Bluetooth (M.2 interface)
>>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> Co-developed-by: Yingying Tang <quic_yintang@quicinc.com> # PCIe4 and WLAN
>> Signed-off-by: Yingying Tang <quic_yintang@quicinc.com>
>> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
> 
> I'm sorry, but I can't merge this as checkpatch doesn't approve of the
> way you write the Co-developed-by, and I don't like it either - in
> particular when looking at the 3rd patch,
> 
> As this is all from Qualcomm, please change this such that one person
> (the author) certifies the origin of the patch (in accordance with DCO
> 1.1 bullet a). You can attribute the additional authors by writing
> "Written in collaboration with Yingying Tang <and other names for the
> 3rd patch>" above the tags.

Okay, I will follow the style you suggested.

> 
> PS. Please run checkpatch before sending your patches.

I will.

> 
> Regards,
> Bjorn
> 
>> ---
>>   arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi | 609 ++++++++++++++++++++++++++++
>>   1 file changed, 609 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi b/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
>> new file mode 100644
>> index 000000000000..5facc5544c3d
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
>> @@ -0,0 +1,609 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#include "x1e80100.dtsi"
>> +#include "x1e80100-pmics.dtsi"
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>> +
>> +/ {
>> +	compatible = "hamoa-iot-som", "qcom,x1e80100";
>> +
>> +	reserved-memory {
>> +		linux,cma {
>> +			compatible = "shared-dma-pool";
>> +			size = <0x0 0x8000000>;
>> +			reusable;
>> +			linux,cma-default;
>> +		};
>> +	};
>> +};
>> +
>> +&apps_rsc {
>> +	/* PMC8380C_B */
>> +	regulators-0 {
>> +		compatible = "qcom,pm8550-rpmh-regulators";
>> +		qcom,pmic-id = "b";
>> +
>> +		vdd-bob1-supply = <&vph_pwr>;
>> +		vdd-bob2-supply = <&vph_pwr>;
>> +		vdd-l1-l4-l10-supply = <&vreg_s4c_1p8>;
>> +		vdd-l2-l13-l14-supply = <&vreg_bob1>;
>> +		vdd-l5-l16-supply = <&vreg_bob1>;
>> +		vdd-l6-l7-supply = <&vreg_bob2>;
>> +		vdd-l8-l9-supply = <&vreg_bob1>;
>> +		vdd-l12-supply = <&vreg_s5j_1p2>;
>> +		vdd-l15-supply = <&vreg_s4c_1p8>;
>> +		vdd-l17-supply = <&vreg_bob2>;
>> +
>> +		vreg_bob1: bob1 {
>> +			regulator-name = "vreg_bob1";
>> +			regulator-min-microvolt = <3008000>;
>> +			regulator-max-microvolt = <3960000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_bob2: bob2 {
>> +			regulator-name = "vreg_bob2";
>> +			regulator-min-microvolt = <2504000>;
>> +			regulator-max-microvolt = <3008000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l1b_1p8: ldo1 {
>> +			regulator-name = "vreg_l1b_1p8";
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <1800000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l2b_3p0: ldo2 {
>> +			regulator-name = "vreg_l2b_3p0";
>> +			regulator-min-microvolt = <3072000>;
>> +			regulator-max-microvolt = <3100000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l4b_1p8: ldo4 {
>> +			regulator-name = "vreg_l4b_1p8";
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <1800000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l5b_3p0: ldo5 {
>> +			regulator-name = "vreg_l5b_3p0";
>> +			regulator-min-microvolt = <3000000>;
>> +			regulator-max-microvolt = <3000000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l6b_1p8: ldo6 {
>> +			regulator-name = "vreg_l6b_1p8";
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <2960000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l7b_2p8: ldo7 {
>> +			regulator-name = "vreg_l7b_2p8";
>> +			regulator-min-microvolt = <2800000>;
>> +			regulator-max-microvolt = <2800000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l8b_3p0: ldo8 {
>> +			regulator-name = "vreg_l8b_3p0";
>> +			regulator-min-microvolt = <3072000>;
>> +			regulator-max-microvolt = <3072000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l9b_2p9: ldo9 {
>> +			regulator-name = "vreg_l9b_2p9";
>> +			regulator-min-microvolt = <2960000>;
>> +			regulator-max-microvolt = <2960000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l10b_1p8: ldo10 {
>> +			regulator-name = "vreg_l10b_1p8";
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <1800000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l12b_1p2: ldo12 {
>> +			regulator-name = "vreg_l12b_1p2";
>> +			regulator-min-microvolt = <1200000>;
>> +			regulator-max-microvolt = <1200000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +			regulator-always-on;
>> +		};
>> +
>> +		vreg_l13b_3p0: ldo13 {
>> +			regulator-name = "vreg_l13b_3p0";
>> +			regulator-min-microvolt = <3072000>;
>> +			regulator-max-microvolt = <3100000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l14b_3p0: ldo14 {
>> +			regulator-name = "vreg_l14b_3p0";
>> +			regulator-min-microvolt = <3072000>;
>> +			regulator-max-microvolt = <3072000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l15b_1p8: ldo15 {
>> +			regulator-name = "vreg_l15b_1p8";
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <1800000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +			regulator-always-on;
>> +		};
>> +
>> +		vreg_l16b_2p9: ldo16 {
>> +			regulator-name = "vreg_l16b_2p9";
>> +			regulator-min-microvolt = <2912000>;
>> +			regulator-max-microvolt = <2912000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l17b_2p5: ldo17 {
>> +			regulator-name = "vreg_l17b_2p5";
>> +			regulator-min-microvolt = <2504000>;
>> +			regulator-max-microvolt = <2504000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +	};
>> +
>> +	/* PMC8380VE_C */
>> +	regulators-1 {
>> +		compatible = "qcom,pm8550ve-rpmh-regulators";
>> +		qcom,pmic-id = "c";
>> +
>> +		vdd-l1-supply = <&vreg_s5j_1p2>;
>> +		vdd-l2-supply = <&vreg_s1f_0p7>;
>> +		vdd-l3-supply = <&vreg_s1f_0p7>;
>> +		vdd-s4-supply = <&vph_pwr>;
>> +
>> +		vreg_s4c_1p8: smps4 {
>> +			regulator-name = "vreg_s4c_1p8";
>> +			regulator-min-microvolt = <1856000>;
>> +			regulator-max-microvolt = <2000000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l1c_1p2: ldo1 {
>> +			regulator-name = "vreg_l1c_1p2";
>> +			regulator-min-microvolt = <1200000>;
>> +			regulator-max-microvolt = <1200000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l2c_0p8: ldo2 {
>> +			regulator-name = "vreg_l2c_0p8";
>> +			regulator-min-microvolt = <880000>;
>> +			regulator-max-microvolt = <920000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l3c_0p8: ldo3 {
>> +			regulator-name = "vreg_l3c_0p8";
>> +			regulator-min-microvolt = <880000>;
>> +			regulator-max-microvolt = <920000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +	};
>> +
>> +	/* PMC8380_D */
>> +	regulators-2 {
>> +		compatible = "qcom,pmc8380-rpmh-regulators";
>> +		qcom,pmic-id = "d";
>> +
>> +		vdd-l1-supply = <&vreg_s1f_0p7>;
>> +		vdd-l2-supply = <&vreg_s1f_0p7>;
>> +		vdd-l3-supply = <&vreg_s4c_1p8>;
>> +		vdd-s1-supply = <&vph_pwr>;
>> +
>> +		vreg_l1d_0p8: ldo1 {
>> +			regulator-name = "vreg_l1d_0p8";
>> +			regulator-min-microvolt = <880000>;
>> +			regulator-max-microvolt = <920000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l2d_0p9: ldo2 {
>> +			regulator-name = "vreg_l2d_0p9";
>> +			regulator-min-microvolt = <912000>;
>> +			regulator-max-microvolt = <920000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l3d_1p8: ldo3 {
>> +			regulator-name = "vreg_l3d_1p8";
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <1800000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +	};
>> +
>> +	/* PMC8380_E */
>> +	regulators-3 {
>> +		compatible = "qcom,pmc8380-rpmh-regulators";
>> +		qcom,pmic-id = "e";
>> +
>> +		vdd-l2-supply = <&vreg_s1f_0p7>;
>> +		vdd-l3-supply = <&vreg_s5j_1p2>;
>> +
>> +		vreg_l2e_0p8: ldo2 {
>> +			regulator-name = "vreg_l2e_0p8";
>> +			regulator-min-microvolt = <880000>;
>> +			regulator-max-microvolt = <920000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l3e_1p2: ldo3 {
>> +			regulator-name = "vreg_l3e_1p2";
>> +			regulator-min-microvolt = <1200000>;
>> +			regulator-max-microvolt = <1200000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +	};
>> +
>> +	/* PMC8380_F */
>> +	regulators-4 {
>> +		compatible = "qcom,pmc8380-rpmh-regulators";
>> +		qcom,pmic-id = "f";
>> +
>> +		vdd-l1-supply = <&vreg_s5j_1p2>;
>> +		vdd-l2-supply = <&vreg_s5j_1p2>;
>> +		vdd-l3-supply = <&vreg_s5j_1p2>;
>> +		vdd-s1-supply = <&vph_pwr>;
>> +
>> +		vreg_s1f_0p7: smps1 {
>> +			regulator-name = "vreg_s1f_0p7";
>> +			regulator-min-microvolt = <700000>;
>> +			regulator-max-microvolt = <1100000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l1f_1p0: ldo1 {
>> +			regulator-name = "vreg_l1f_1p0";
>> +			regulator-min-microvolt = <1024000>;
>> +			regulator-max-microvolt = <1024000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l2f_1p0: ldo2 {
>> +			regulator-name = "vreg_l2f_1p0";
>> +			regulator-min-microvolt = <1024000>;
>> +			regulator-max-microvolt = <1024000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l3f_1p0: ldo3 {
>> +			regulator-name = "vreg_l3f_1p0";
>> +			regulator-min-microvolt = <1024000>;
>> +			regulator-max-microvolt = <1024000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +	};
>> +
>> +	/* PMC8380VE_I */
>> +	regulators-6 {
>> +		compatible = "qcom,pm8550ve-rpmh-regulators";
>> +		qcom,pmic-id = "i";
>> +
>> +		vdd-l1-supply = <&vreg_s4c_1p8>;
>> +		vdd-l2-supply = <&vreg_s5j_1p2>;
>> +		vdd-l3-supply = <&vreg_s1f_0p7>;
>> +		vdd-s1-supply = <&vph_pwr>;
>> +		vdd-s2-supply = <&vph_pwr>;
>> +
>> +		vreg_s1i_0p9: smps1 {
>> +			regulator-name = "vreg_s1i_0p9";
>> +			regulator-min-microvolt = <900000>;
>> +			regulator-max-microvolt = <920000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_s2i_1p0: smps2 {
>> +			regulator-name = "vreg_s2i_1p0";
>> +			regulator-min-microvolt = <1000000>;
>> +			regulator-max-microvolt = <1100000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l1i_1p8: ldo1 {
>> +			regulator-name = "vreg_l1i_1p8";
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <1800000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l2i_1p2: ldo2 {
>> +			regulator-name = "vreg_l2i_1p2";
>> +			regulator-min-microvolt = <1200000>;
>> +			regulator-max-microvolt = <1200000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l3i_0p8: ldo3 {
>> +			regulator-name = "vreg_l3i_0p8";
>> +			regulator-min-microvolt = <880000>;
>> +			regulator-max-microvolt = <920000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +	};
>> +
>> +	/* PMC8380VE_J */
>> +	regulators-7 {
>> +		compatible = "qcom,pm8550ve-rpmh-regulators";
>> +		qcom,pmic-id = "j";
>> +
>> +		vdd-l1-supply = <&vreg_s1f_0p7>;
>> +		vdd-l2-supply = <&vreg_s5j_1p2>;
>> +		vdd-l3-supply = <&vreg_s1f_0p7>;
>> +		vdd-s5-supply = <&vph_pwr>;
>> +
>> +		vreg_s5j_1p2: smps5 {
>> +			regulator-name = "vreg_s5j_1p2";
>> +			regulator-min-microvolt = <1256000>;
>> +			regulator-max-microvolt = <1304000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l1j_0p8: ldo1 {
>> +			regulator-name = "vreg_l1j_0p8";
>> +			regulator-min-microvolt = <880000>;
>> +			regulator-max-microvolt = <920000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l2j_1p2: ldo2 {
>> +			regulator-name = "vreg_l2j_1p2";
>> +			regulator-min-microvolt = <1256000>;
>> +			regulator-max-microvolt = <1256000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l3j_0p8: ldo3 {
>> +			regulator-name = "vreg_l3j_0p8";
>> +			regulator-min-microvolt = <880000>;
>> +			regulator-max-microvolt = <920000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +	};
>> +};
>> +
>> +&pcie4 {
>> +	perst-gpios = <&tlmm 146 GPIO_ACTIVE_LOW>;
>> +	wake-gpios = <&tlmm 148 GPIO_ACTIVE_LOW>;
>> +
>> +	pinctrl-0 = <&pcie4_default>;
>> +	pinctrl-names = "default";
>> +
>> +	status = "okay";
>> +};
>> +
>> +&pcie4_phy {
>> +	vdda-phy-supply = <&vreg_l3i_0p8>;
>> +	vdda-pll-supply = <&vreg_l3e_1p2>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&pcie6a {
>> +	perst-gpios = <&tlmm 152 GPIO_ACTIVE_LOW>;
>> +	wake-gpios = <&tlmm 154 GPIO_ACTIVE_LOW>;
>> +
>> +	pinctrl-0 = <&pcie6a_default>;
>> +	pinctrl-names = "default";
>> +
>> +	status = "okay";
>> +};
>> +
>> +&pcie6a_phy {
>> +	vdda-phy-supply = <&vreg_l1d_0p8>;
>> +	vdda-pll-supply = <&vreg_l2j_1p2>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&qupv3_0 {
>> +	status = "okay";
>> +};
>> +
>> +&qupv3_1 {
>> +	status = "okay";
>> +};
>> +
>> +&qupv3_2 {
>> +	status = "okay";
>> +};
>> +
>> +&remoteproc_adsp {
>> +	firmware-name = "qcom/x1e80100/adsp.mbn",
>> +			"qcom/x1e80100/adsp_dtb.mbn";
>> +
>> +	status = "okay";
>> +};
>> +
>> +&remoteproc_cdsp {
>> +	firmware-name = "qcom/x1e80100/cdsp.mbn",
>> +			"qcom/x1e80100/cdsp_dtb.mbn";
>> +
>> +	status = "okay";
>> +};
>> +
>> +&tlmm {
>> +	gpio-reserved-ranges = <34 2>, /* TPM LP & INT */
>> +			       <44 4>; /* SPI (TPM) */
>> +
>> +	pcie4_default: pcie4-default-state {
>> +		clkreq-n-pins {
>> +			pins = "gpio147";
>> +			function = "pcie4_clk";
>> +			drive-strength = <2>;
>> +			bias-pull-up;
>> +		};
>> +
>> +		perst-n-pins {
>> +			pins = "gpio146";
>> +			function = "gpio";
>> +			drive-strength = <2>;
>> +			bias-disable;
>> +		};
>> +
>> +		wake-n-pins {
>> +			pins = "gpio148";
>> +			function = "gpio";
>> +			drive-strength = <2>;
>> +			bias-pull-up;
>> +		};
>> +	};
>> +
>> +	pcie6a_default: pcie6a-default-state {
>> +		clkreq-n-pins {
>> +			pins = "gpio153";
>> +			function = "pcie6a_clk";
>> +			drive-strength = <2>;
>> +			bias-pull-up;
>> +		};
>> +
>> +		perst-n-pins {
>> +			pins = "gpio152";
>> +			function = "gpio";
>> +			drive-strength = <2>;
>> +			bias-disable;
>> +		};
>> +
>> +		wake-n-pins {
>> +			pins = "gpio154";
>> +			function = "gpio";
>> +			drive-strength = <2>;
>> +			bias-pull-up;
>> +
>> +		};
>> +	};
>> +};
>> +
>> +&usb_1_ss0 {
>> +	status = "okay";
>> +};
>> +
>> +&usb_1_ss0_dwc3 {
>> +	dr_mode = "otg";
>> +	usb-role-switch;
>> +};
>> +
>> +&usb_1_ss0_hsphy {
>> +	vdd-supply = <&vreg_l3j_0p8>;
>> +	vdda12-supply = <&vreg_l2j_1p2>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_1_ss0_qmpphy {
>> +	vdda-phy-supply = <&vreg_l2j_1p2>;
>> +	vdda-pll-supply = <&vreg_l1j_0p8>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_1_ss1 {
>> +	status = "okay";
>> +};
>> +
>> +&usb_1_ss1_dwc3 {
>> +	dr_mode = "otg";
>> +	usb-role-switch;
>> +};
>> +
>> +&usb_1_ss1_hsphy {
>> +	vdd-supply = <&vreg_l3j_0p8>;
>> +	vdda12-supply = <&vreg_l2j_1p2>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_1_ss1_qmpphy {
>> +	vdda-phy-supply = <&vreg_l2j_1p2>;
>> +	vdda-pll-supply = <&vreg_l2d_0p9>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_1_ss2 {
>> +	status = "okay";
>> +};
>> +
>> +&usb_1_ss2_dwc3 {
>> +	dr_mode = "otg";
>> +	usb-role-switch;
>> +};
>> +
>> +&usb_1_ss2_hsphy {
>> +	vdd-supply = <&vreg_l3j_0p8>;
>> +	vdda12-supply = <&vreg_l2j_1p2>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_1_ss2_qmpphy {
>> +	vdda-phy-supply = <&vreg_l2j_1p2>;
>> +	vdda-pll-supply = <&vreg_l2d_0p9>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_2 {
>> +	status = "okay";
>> +};
>> +
>> +&usb_2_dwc3 {
>> +	dr_mode = "host";
>> +};
>> +
>> +&usb_2_hsphy {
>> +	vdd-supply = <&vreg_l2e_0p8>;
>> +	vdda12-supply = <&vreg_l3e_1p2>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_mp {
>> +	status = "okay";
>> +};
>> +
>> +&usb_mp_hsphy0 {
>> +	vdd-supply = <&vreg_l2e_0p8>;
>> +	vdda12-supply = <&vreg_l3e_1p2>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_mp_hsphy1 {
>> +	vdd-supply = <&vreg_l2e_0p8>;
>> +	vdda12-supply = <&vreg_l3e_1p2>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_mp_qmpphy0 {
>> +	vdda-phy-supply = <&vreg_l3e_1p2>;
>> +	vdda-pll-supply = <&vreg_l3c_0p8>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_mp_qmpphy1 {
>> +	vdda-phy-supply = <&vreg_l3e_1p2>;
>> +	vdda-pll-supply = <&vreg_l3c_0p8>;
>> +
>> +	status = "okay";
>> +};
>>
>> -- 
>> 2.34.1
>>

-- 
Best Regards,
Yijie


