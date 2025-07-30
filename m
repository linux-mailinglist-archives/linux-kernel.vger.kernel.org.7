Return-Path: <linux-kernel+bounces-750065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFFCB156EB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 03:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFCDF3B1097
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 01:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268F61624E1;
	Wed, 30 Jul 2025 01:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rr5GduGN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D00535953
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 01:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753837923; cv=none; b=Crhyjt1Aab8l5Vdt71hNMT58M9RLkAlWTPZGO6QNbl5yjIgX4zqqKvTDpwsn3RCU+KbsaLAbbbNfnayN3Ve6PlTrNwXoMzAJQ9t2GsVtJJa8wd9r9sVnfjM//zQ+4lZUcNG2CXQEuscQA9HQVpV+IB6LVSDqZyNXrd0PLSZI1hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753837923; c=relaxed/simple;
	bh=MHe3b4BP/rd8BGA3my6rqgxXrdcg8EovAKTwLcRgysk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LO8ZyN/C4T3ekO0RaBuV4ErvwJh1VeHPAUGu/hgHWPekS8qH7uN0ejz7CTCWiGjr+hhbGRIvJfjG7Gw1BI9mm14fqju/XZdUIS9E+2vdevbWqHalgLvr4O6Fpx8aEjrcnB5hVMsdbePa6UJ3qusz5s+yXkJf3lOY8g3Gdmq6WBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rr5GduGN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56TJZ8NT016320
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 01:12:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	miz0PseruPjSZd+CVdETUFjrzDtc25orV3mrsOr/9zw=; b=Rr5GduGNy1xGilme
	Wl/xC/pdskPnSBsZYqGZhzdAPfZcnRQUB6QqAzW9Ay/1MmyG/G5us5fLTLp/Ne6w
	AL9DcotdkDTSo6m4IcmYnxCYNfJb/Cbo1csFrS5x69i8YRVoVrTiAgW4PqMlwcHq
	lbOxyd+6IRWPVnRdTxYrZR40MMdzZPpquOm3chZC7FVEhYIcfxP0DxeMUlcNOpZA
	a0gk1NB4xVN08e/qepFROMovel4Yvz3+AZg5ezqDoy/7kdIRyjRzko2OIqo+4awN
	XdloyZXNW8ecFlihwkLzNWZRlpGwX95cw3KX6kZMuoT6cbNjsk3Op6mCfp2+vHu5
	grcwfw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 486v6y2ave-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 01:12:00 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23ff7d61fb7so3223905ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 18:12:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753837912; x=1754442712;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=miz0PseruPjSZd+CVdETUFjrzDtc25orV3mrsOr/9zw=;
        b=j1QV2xy+qX6c8F1rFSbdem5tRc+7QGgvYDjUIMjFjAfsZCVVASQpKfPYHT7dsvzEvO
         OhTRcnBbR9MH9hezDdbPd01iBhI9Lk/A7/dBs2dv/Wa+C2JVYUiFoELGhl/NmHrk0kai
         50p2rhVv9/55Yu3sZPvZWHi7GISqIZpeFq1DAvcPkUD+SyF1Q8oPbFupqEHloyrsnJK3
         nobgMGvgR7m7MnI/i3ekSVpy5OiKM2HWmAb2OkfV7a4z5ONsSbKemHOqYhIkc6xY6gNU
         otGRvdmx09TznDTxIU4XcJUPv9UE1qbS/DV8ppRD0Xe7G7AoJloLXJNhtMFdYABDJdtx
         bjew==
X-Forwarded-Encrypted: i=1; AJvYcCXUA2bxA83YsvRhlo57n76bTHFbRHiXCJR4iYwic+UcOr9gFMi1ePAHzsATWeHzcmAaNUdcrAqTppO3llA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTqurcF1iKMr6vgkzCrtskp712kmikCyGU//FROtvtlrye0fN6
	jj0ljQPSzFsHpdTkRu31yfIyMfA+DiSNufRgwpPpfN4p2JdxnuknAXm5fGY8hQqhUNElrikWA0u
	apSTtibCYQfBjf9xgyfZJHGjumXPOo4V4+90JMhHftPv2dpSGehkoJTqq0f1yGqlIfXY=
X-Gm-Gg: ASbGncu4gWGQy3SGt9sb+fblrHfjImWyz8Vitg/A7qlPTqFWP/9ERkIyqhWyuGccAev
	12388RIifQvK3GIe2jqsu5l6nikTwFPFKeG7bsoVA3ppdJIqHxgGvL47QclZhNxlBTERkW+az7a
	5wCbYpbCkXM4ctMEP4bSMuayXnxb5vlihJu46Yjy87bNiuvJM1ujViscOiuPFan7qCFxDXxXRks
	RlZXewg7ZrMQ/ME0Kni2ul+xwrR0mOxIbt5eWFcCbB5sfXGKGw1EGlZqoh+OfiBgqQWPwt1PPip
	hJYYaePRzWF5TPiT7QkrQjktF7Z1zLbZ/R8/dOaPgqk9M6IDqblQu6vNKlpnmj8raZqyOOJPS44
	K/9wVah5VmBuocIja6TPnaU+AtDFy
X-Received: by 2002:a17:902:ec8e:b0:215:b1e3:c051 with SMTP id d9443c01a7336-2409682d77amr19020795ad.11.1753837912089;
        Tue, 29 Jul 2025 18:11:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHc2N/evxqpTQvdOuTKy5QnuEBs9o8FuQXaOOg7qV2xhaoKtYpWGxcAt5pbkg8C0kY1upfa8w==
X-Received: by 2002:a17:902:ec8e:b0:215:b1e3:c051 with SMTP id d9443c01a7336-2409682d77amr19020395ad.11.1753837911580;
        Tue, 29 Jul 2025 18:11:51 -0700 (PDT)
Received: from [10.133.33.126] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2402bd30cacsm54545025ad.66.2025.07.29.18.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 18:11:51 -0700 (PDT)
Message-ID: <ef9c302a-28f9-4bc9-912c-92bf5ca7bbf3@oss.qualcomm.com>
Date: Wed, 30 Jul 2025 09:11:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] arm64: dts: qcom: Add HAMOA-IOT-SOM platform
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250729-hamoa_initial-v3-0-806e092789dc@oss.qualcomm.com>
 <20250729-hamoa_initial-v3-3-806e092789dc@oss.qualcomm.com>
 <5hgynbka274jerw5x6ekfuoj45k6bqt2hdbsx2puniqornil4s@pdgavjb2jeci>
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <5hgynbka274jerw5x6ekfuoj45k6bqt2hdbsx2puniqornil4s@pdgavjb2jeci>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDAwNSBTYWx0ZWRfX4NnHMJiVzgMQ
 EdXQoIaPvfZwXqSrHH3tLoJG0diI25SMELyzTFWGFI+0TIIw2w6YP+0Bk13cAB8s7Jxa/cH55j9
 qDzP52IePlUo3EORK+NuF8SEWwYBvG9cK7v+mIzJDjVYOlYcz2/lrsXJ5jha1x+jYBp8vD6vHTK
 agEgljbJj0b7OgbX2qfgOOjSiGS50OpZyasn8xdyitSAv9u2kzi9vV9IjcacSF9NkfH9Qxsei+q
 lKDhQJa3xKcb9bpRwXr4GRTQ4Qu93NSTBX2YbiGkoNUuv8+CaYrQX51CeMxOnbEKgw9IjLkwGvD
 8zTC9mP9o7nTOpe4lyOHMShPvSxlwCj1unEm5sWDdKap2/EF8EUSrYKwjwXchDk308DdyvQTc+w
 yEPdb5IhnvvvJuoGOaxk51UOyTxoMzFLAyQ56zkEreZ+cdjTaUTXoY4QMHyvnUxsH4RDHdsd
X-Proofpoint-GUID: gDkLR6cks6VaKDzhETYg2W0wzIWqg6F-
X-Proofpoint-ORIG-GUID: gDkLR6cks6VaKDzhETYg2W0wzIWqg6F-
X-Authority-Analysis: v=2.4 cv=QYlmvtbv c=1 sm=1 tr=0 ts=68897161 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=0hyxuiq35rhVEzr4ykQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_05,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507300005



On 2025-07-29 18:44, Dmitry Baryshkov wrote:
> On Tue, Jul 29, 2025 at 09:31:59AM +0800, Yijie Yang wrote:
>> The HAMOA-IOT-SOM is a compact computing module that integrates a System
>> on Chip (SoC) — specifically the x1e80100 — along with essential
>> components optimized for IoT applications. It is designed to be mounted on
>> carrier boards, enabling the development of complete embedded systems.
>>
>> This change enables and overlays the following components:
> 
> What does this mean, how can it overlay something?

What I want to convey here is that I referenced some nodes defined in 
x1e80100.dtsi within this file to add additional properties. I’ll revise 
the wording to make this clearer.

> 
>> - Regulators on the SOM
>> - Reserved memory regions
>> - PCIe6a and its PHY
>> - PCIe4 and its PHY
>> - USB0 through USB6 and their PHYs
>> - ADSP, CDSP
>> - WLAN, Bluetooth (M.2 interface)
>>
>> Written with contributions from Yingying Tang (added PCIe4 and its PHY to
>> enable WLAN).
>>
>> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi | 609 ++++++++++++++++++++++++++++
>>   1 file changed, 609 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi b/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..5facc5544c3df05b89b25fbcb5cd331e93040f15
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
> 
> Should not be necessary, otg is a default.
> 
>> +	usb-role-switch;
> 
> This should be a part of the x1e80100.dtsi, but please see commit
> 7db0ba3e6e6c ("Revert "arm64: dts: qcom: x1e80100: enable OTG on USB-C
> controllers"")
> 
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
> 
> Why? Is it actually host-only?
> 
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
> 

-- 
Best Regards,
Yijie


