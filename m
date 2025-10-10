Return-Path: <linux-kernel+bounces-848138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00149BCC9EA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 12:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F365F19E5DB4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 10:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231372ED15A;
	Fri, 10 Oct 2025 10:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TIChXsOt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9342853EF
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 10:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760093706; cv=none; b=O2jRso4XKMxLVpsaRIr3CCkuasVQ4eK1jJJj0+Maxjqqtrt8y4pBEDmYGPgxjf2TY2dbZNomVW5XRaSNLKE41510pIbNgQ0+jV28S3GwJRy74cjoH228f7YsEygMmtz/dNMxbtKpTscNFQW9SCpWTjplzj6y/zb6QMg3N3xUcMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760093706; c=relaxed/simple;
	bh=ijK5qG6cvhdXxF9G5TzG2LmSGh+cAfxXsFKKRQN6fpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DQIOlYDg04lRrk6cU+I9VzhYs8V5OrSm70OYFGlMIY39aV31DgEvte01FEeMZOcQkHUVKxgM/a69kb7mrCo2foe4UXdnShsLy8fk9GB0cC0D6EM1JhKsivjFwbf38PSUFbSA4vr2k+PkqVNgPMc/aRQkkvCI1ExyKngKY8lq52M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TIChXsOt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59A6WgAY002274
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 10:55:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Vwy3pwTMiTvFORyUGui267pugrOCUt49BYQxcWSdE2M=; b=TIChXsOt3LWh5IFn
	16G/KK/tvxPSpHI9kZxXKjQag9AuMt99elTlhgTT8DebHdq8u8Kyk4S2HSOX4hEE
	UFg5vmry2W/QTAw0xl/RnYv54jE88JD/DAOBgi/VsRxMma2MhO1SqixJTmUxg/VN
	JJEQas+OVTUnBcnPhQYFc1hnSm31+BVMlfUhB4J4bPmo+GGqDf54bOv7BN1SM9qY
	GvMzDJnHgAZ7FGsomC5Ct5CCPOp+kV9Hf7wU6kTwf4D3jCpMF2Nvmmoj9OIEuFVQ
	0jeWhAIn6jdQWZjFiQmSaj1XcT6KLKXmZdEcVkDyaCGXH2sVdmek1GNwkAnUj6Kp
	ey+hwA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49pgdsthpm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 10:55:03 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b62da7602a0so3404752a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 03:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760093702; x=1760698502;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vwy3pwTMiTvFORyUGui267pugrOCUt49BYQxcWSdE2M=;
        b=dIl0GD3FxTddKaEE7hvGT1E3+yyPNYn2O51WfQLuCPe1LmaVZXIhksgOH99QIN++YK
         wIqxPC+z7/QVB2iMez6+xvfl1+DHQYm2zHZquOUqJuoe7hLNQs7jHRTjR+ISqDLRtnp4
         BUoVuslMdDpwPMhPcAFSGSAFwTsHGY/PomRTj1IIlu4vF08yIl3omMs2866cQIaal2be
         6s+/0TYP4TVODNuRWaNUxHz0e+Oi/uTi8QLzT23XaoZwC70HvzUlznBQgN4Lip1BkXgp
         /XiSkwEF25uED4jb6GV7XeBX6T1GDs0inMsZg7rATpJ256qakUw+ocqldoFTiL+E235x
         VeFA==
X-Forwarded-Encrypted: i=1; AJvYcCV8CSvEkEgWJeLqK+8ScKSf5chpqvsMORRTZZ0AbljIXihN/Bdec52aNImsc+7/8DemLLdcnYPEVXvnnaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3iH6I8eq4KDBHz15tWCJVUcKo0oXrmOC72Tc4XAmqODdm7B4X
	2wpL2+K0rKhY4vWBqsWNbXAYUmZXDW5Vkc9yeSv+zDMr2FNEu0gf7wuWUTma68cxvPEtUQAFvq0
	runTYWfpru3QNwjRKnCbBBV20H3FjvIG2pU4bm3UQCUVQI1EL6+qj3yiXxFa8aT9pjmE=
X-Gm-Gg: ASbGnct4el9AcpGddJGu7MAxCrPM26xgo/mLCjR6EO8fGZoIfnYod3+lVrS2VP1LmAg
	ZNw2dt+mf89cozMe/T6PrR3CHfr0/HNJyLaPi/nGJjb2YX1Yg/szKfOtjyDMCPKqnDWXazAZDy+
	670AV4cuxCOSXnRR11j/sYfsA0UJ6CDdA/SZRlK5mT1PrzD1PKVe317EgreP7wnASMZ4COzlr5D
	vePiK6U65LSe13py29i0DSLD364hAz/pYy0fslQv3BpjspgbdLFHo98ZByJY6vOYt0jtLpT436a
	E36egpd1yTmIy5ncrrO19kwVN9O+nOA+2TNXhzH/Dc3ofnGSQDXKFK5bR+hNaLNcWMmRmJVs
X-Received: by 2002:a05:6a20:3956:b0:303:8207:eb56 with SMTP id adf61e73a8af0-32da8190b86mr15071679637.5.1760093701977;
        Fri, 10 Oct 2025 03:55:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOrHyLiE5Vt9JDYoYk4bw+AVJvks5v/hLpiw0jFgJz4TA9XD0cfQ6Lmwqkvx1bZPMxALt9Og==
X-Received: by 2002:a05:6a20:3956:b0:303:8207:eb56 with SMTP id adf61e73a8af0-32da8190b86mr15071633637.5.1760093701429;
        Fri, 10 Oct 2025 03:55:01 -0700 (PDT)
Received: from [10.217.217.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b529956e3sm3740156a91.5.2025.10.10.03.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 03:55:01 -0700 (PDT)
Message-ID: <dd4d4fa3-abd4-476f-a37e-c44cb6c83fb0@oss.qualcomm.com>
Date: Fri, 10 Oct 2025 16:24:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/20] arm64: dts: qcom: kaanapali-mtp: Enable more
 features
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Eugen Hristev <eugen.hristev@linaro.org>
Cc: Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-14-3fdbc4b9e1b1@oss.qualcomm.com>
 <588a7b68-2e2e-4e65-9249-fe8b18b67927@linaro.org>
 <831f6fd7-b81f-4d6f-b9bd-5a8fe514befb@oss.qualcomm.com>
 <0c9ca026-9986-4347-a86d-8bf65e2d12e6@linaro.org>
 <kocj7sf6jgj4uynvlxvbsojc4bykyj2ipb4ex56fagjqoxwcie@2trytltkhd4a>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <kocj7sf6jgj4uynvlxvbsojc4bykyj2ipb4ex56fagjqoxwcie@2trytltkhd4a>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 5Y5NuYI-zdvbZhl7Gawab-_oQ5hqHeF9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA5MDA5OCBTYWx0ZWRfX6EQtGpIeQGh1
 I7Wzuult+YnjyC/6fkEWj0+1IB3E403ETRy2DIVcHW7bLAkFOoPlRtjRhWI4pkUftnyrjyKtwE2
 ls2xdu0cs9Q5zR9+gHYzGoF31VTwtKndnbuahcfy5C6TCN3hSrJD2OTuOZaDLapFGGJgF5JJR8o
 HFNg+Sp/xbrwE8ijV8iLrX8tn382qHXUJCM0KBc9Z1iVd5r/Ed46iQ4CfXZUxybBVnDiyGoZUG+
 LGTeJa/CVRpCeeT0qf02TFlDDQyTsxtOBkBeFy8n/bUYswGC0snVGjuQYWrWhhTHW/YSjKAjcy5
 p9bcyXlcV2G/pOjI0nWKK76L9JkGS6gc0LpfF6pxG38m5CV+/NNmf2/iYoQPRfBZfgJJFYCOgB7
 xZRE97scP5fr8Zfp7J2tMh7BKOOtzw==
X-Authority-Analysis: v=2.4 cv=DISCIiNb c=1 sm=1 tr=0 ts=68e8e607 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=DphT3ukwsKVHlzpFmrcA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-GUID: 5Y5NuYI-zdvbZhl7Gawab-_oQ5hqHeF9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510090098

Hi Dmitry and Eugen,

On 10/9/2025 9:58 PM, Dmitry Baryshkov wrote:
> On Thu, Oct 09, 2025 at 05:58:03PM +0300, Eugen Hristev wrote:
>>
>>
>> On 10/9/25 16:54, Jishnu Prakash wrote:
>>> Hi Eugen,
>>>
>>> On 9/25/2025 1:33 PM, Eugen Hristev wrote:
>>>>
>>>>
>>>> On 9/25/25 03:17, Jingyi Wang wrote:
>>>>> Enable more features on Kaanapali MTP boards including PMIC peripherals,
>>>>> bus, SDHCI, remoteprocs, USB, PCIE, WLAN and Bluetooth.
>>>>>
>>>>> Written with help from Jyothi Kumar Seerapu(added bus), Ronak Raheja
>>>>> (added USB), Manish Pandey(added SDHCI), Jishnu Prakash(added PMIC),
>>>>> Qiang Yu(added PCIE), Yijie Yang(Added WLAN) and Zijun Hu(Added Bluetooth).
>>>>>
>>>>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>>>>> ---
>>>>>  arch/arm64/boot/dts/qcom/kaanapali-mtp.dts | 663 +++++++++++++++++++++++++++++
>>>>>  1 file changed, 663 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
>>>>> index 9cf3158e2712..2949579481a9 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
>>>>> +++ b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
>>>>> @@ -5,9 +5,23 @@
>>>>>  
>>>
>>> ...
>>>
>>>>> +
>>>>> +&spmi_bus1 {
>>>>> +	pmd8028: pmic@4 {
>>>>> +		compatible = "qcom,pmd8028", "qcom,spmi-pmic";
>>>>> +		reg = <0x4 SPMI_USID>;
>>>>> +		#address-cells = <1>;
>>>>> +		#size-cells = <0>;
>>>>> +
>>>>> +		pmd8028_temp_alarm: temp-alarm@a00 {
>>>>> +			compatible = "qcom,spmi-temp-alarm";
>>>>> +			reg = <0xa00>;
>>>>> +			interrupts = <0x4 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
>>>>> +			#thermal-sensor-cells = <0>;
>>>>> +		};
>>>>> +
>>>>> +		pmd8028_gpios: gpio@8800 {
>>>>> +			compatible = "qcom,pmd8028-gpio", "qcom,spmi-gpio";
>>>>> +			reg = <0x8800>;
>>>>> +			gpio-controller;
>>>>> +			gpio-ranges = <&pmd8028_gpios 0 0 4>;
>>>>> +			#gpio-cells = <2>;
>>>>> +			interrupt-controller;
>>>>> +			#interrupt-cells = <2>;
>>>>> +		};
>>>>> +	};
>>>>> +
>>>>> +	pmih0108: pmic@7 {
>>>>> +		compatible = "qcom,pmih0108", "qcom,spmi-pmic";
>>>>> +		reg = <0x7 SPMI_USID>;
>>>>> +		#address-cells = <1>;
>>>>> +		#size-cells = <0>;
>>>>> +
>>>>> +		pmih0108_temp_alarm: temp-alarm@a00 {
>>>>> +			compatible = "qcom,spmi-temp-alarm";
>>>>> +			reg = <0xa00>;
>>>>> +			interrupts = <0x7 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
>>>>> +			#thermal-sensor-cells = <0>;
>>>>> +		};
>>>>> +
>>>>> +		pmih0108_gpios: gpio@8800 {
>>>>> +			compatible = "qcom,pmih0108-gpio", "qcom,spmi-gpio";
>>>>> +			reg = <0x8800>;
>>>>> +			gpio-controller;
>>>>> +			gpio-ranges = <&pmih0108_gpios 0 0 18>;
>>>>> +			#gpio-cells = <2>;
>>>>> +			interrupt-controller;
>>>>> +			#interrupt-cells = <2>;
>>>>> +		};
>>>>> +
>>>>> +		pmih0108_eusb2_repeater: phy@fd00 {
>>>>> +			compatible = "qcom,pm8550b-eusb2-repeater";
>>>>> +			reg = <0xfd00>;
>>>>> +			#phy-cells = <0>;
>>>>> +			vdd18-supply = <&vreg_l15b_1p8>;
>>>>> +			vdd3-supply = <&vreg_l5b_3p1>;
>>>>> +		};
>>>>> +	};
>>>>> +
>>>>> +	pmr735d: pmic@a {
>>>>
>>>> Hi,
>>>>
>>>> The PMR735D is available in pmr735d_a.dtsi
>>>>
>>>> Can we find a way to reuse that include file instead of duplicating it
>>>> here ?
>>>
>>> In pmr735d_a.dtsi, the peripherals are added under the parent phandle
>>> "spmi_bus", which was commonly used in older SoCs having only a single
>>> bus under the PMIC arbiter, but in Kaanapali, there are two buses
>>> present under the PMIC arbiter, with phandles "spmi_bus0" and "spmi_bus1",
>>> so we cannot include the file as it is.
>>>
>>
>> I know the problem. I disagree with using include files in one case, and
>> having the PMIC in the dts in the other case.
>>
>> So there has to be a unified way to handle this in all cases.
> 
> Rework SPMI PMICs to follow the approach started by Johan for PM8008. I
> think this is the way to go.
> 

We got a recommendation from Krzysztof recently here for Glymur: 
https://lore.kernel.org/all/b784387b-5744-422e-92f5-3d575a24d01c@kernel.org/

For PMH0110, he suggested we could keep different DTSI files per SoC,
like pmh0110-kaanapali.dtsi and pmh0110-glymur.dtsi.

We could follow a similar approach on Kaanapali, to 
#include the following files in the .dts file:

pmk8850.dtsi
pmh0101.dtsi
pmh0110-kaanapali.dtsi
pmh0104-kaanapali.dtsi
pmd8028-kaanapali.dtsi
pmih0108-kaanapali.dtsi
pmr735d-kaanapali.dtsi
pm8010-kaanapali.dtsi

The first two files are new and common with Glymur,so they
do not have the SoC name suffix.

Hope this is fine, please let us know if you see any issue.

Thanks,
Jishnu


