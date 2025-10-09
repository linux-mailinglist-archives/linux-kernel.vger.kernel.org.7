Return-Path: <linux-kernel+bounces-846905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3701BC962A
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 15:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 067974FA767
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 13:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925952E9EA0;
	Thu,  9 Oct 2025 13:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eHQFTH11"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303C32D0C6C
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 13:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760018064; cv=none; b=bH2o8flArFKpYPSTJhHbCkNUNzO1W2ed2obwBHlKx8AwQmTnMlUObF6bvAEzAzbqQkCf3v1WzU3GkTzMHgW/g3XFFQ9dtXCEi6dFVfpVjUyALYOWs285o9x9C51pm9Yjp2mdJYawps0i0QcngdaXPCQ4HT+Uk6k4GlIDeqFUhRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760018064; c=relaxed/simple;
	bh=S0Qf3p1cD+btDLTWszuB+Mr4Kk8Kan6qouc5lMU4MsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pF0zTQpvenoYXMFEDfttzpnVxMbNi9019cNf34taXKpMH9uRUYQuFPxO6PXnxdHYH2ZsCpZZwCBozKqaQG9kAJ580Shccf6Rj6sYQg17iNBT0I5d9SIdiYTqdtwFeaoHunwtHTS3DXJEQEnpZ9/89q4aP7jknJXfuouSHkwG9kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eHQFTH11; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996ETR6023705
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 13:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bT1BAW7H+Z9jwKo3kVgnMq1pxPx+D7qU+QOZRPdcRJw=; b=eHQFTH112zOQ8B25
	vG2ZkFJprOarGTJLj3mBtwWZEF3jzVq9ZZqSO1dY+54VYnCshjrxif+/FKMMKV6g
	hW2Yp2SHi0u9JHJmoifVn+k/I7QtkWoPgS9Sn7krf23xpp6VTucoV/cn9Ackhv3g
	c37zEGAK5KVlFBj6zTVHGhbx9k84FriOr8gR428gVuvFxYOYlO2QwgWd6m82gZZh
	d85IXlzuZcmZj8rlhUUANzFMAjfDL1MyBA0kwMn5ixIOkrt+ydqhH2M9P1k70VV/
	eflIu4PopE4STSe0mwGYIhzdE4xe6JXX4Vzu90SMMlX9+qDgGhDAVo7PaFkQonwG
	0BetnQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4m322s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 13:54:22 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-277f0ea6fbaso21571695ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 06:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760018061; x=1760622861;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bT1BAW7H+Z9jwKo3kVgnMq1pxPx+D7qU+QOZRPdcRJw=;
        b=eJnTL4FqKvP7fjg1sNuopfP755edRzlo9Ia8Jd2WTkUTb8r4887Y8gjHLHXxiEJxTA
         mD63+RM2lXL7X7SmtacgcNoGjk5RK8f15soGDf7Jsu9f1y0R5M+HiJLTHZoU4n7k3C1K
         V8lgfPwCyxknrITunWW3hi2HEYhM+z/4PrfNg5hALNaF/9qGzMa4i2tWzVJ+iL+dmTU8
         B4xDrTn9UpfVdV7rlN4Cq3Vyl2e/tckt7aqhZAurRz89AeMp/5Uxl6dcFcHQLyF2AP++
         lgrFxtg7xoAUZrLK2kpjbzGgy9gDfG9QjhUKhBf4ejwzK/dlnAmntkUHFhBmLPw4rnAM
         5Ygw==
X-Forwarded-Encrypted: i=1; AJvYcCVnjZ01fwFp0f0mImKfiH9PNMIEYIg1d+5pJ7xnaEBILQ3bDCZqggKnaBMd0mr+vp0i+YRG4SPZGR04AsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiIhFnC7IBD8kH2V2iHc9Wunl34hEDBeTyuI6D0eRinotcK6QT
	j3/Ff94mnbLpFgFI8VN2HFsL7QmiDH/QCXr3q1SwflBc8a7Zkz8Kj+mtkQ/gEqbi6wmZMSauIUN
	hUuOCxXkpxzhwSRQa9QZ2p8Mm+YKu8pjCJOiNwLdjDYs2ipt5DQW5UMPmzRW8PXgeppM=
X-Gm-Gg: ASbGncut2IiZjIpnLnPzEmkIX+UfOCdql/CNY86xNJEtW0UkWZXouj577gg0m0Vm4Ww
	RnjWwlCdN/QC6XY5d4ooIt4lxf6may8/2fUBZxSMSAWhxpHId+L4OdMe9DG0vyha5HeSmrGqLx2
	1wZFUvn8xt4heVdo6vXDTA+nIyVHaE1uVw8oUNo8GC76uXEQ2shkQuvISXIPdfQDLTY+Bjcfldl
	osdfvHoFZp4cH70wk9L+0fS0xedHb99zjabDrhyOfPpJyMYz3Kr3zuidGIHKaLXklpHmYsce+51
	JEcVN3tHaEmEKE05QxYG82szmjMVN8x53/SG/rINDS89TsmCZ+RJtD5qSH7Mk7yqakhOiGD4JJA
	nvg==
X-Received: by 2002:a17:903:298e:b0:28e:756c:7082 with SMTP id d9443c01a7336-29027374b38mr95773865ad.15.1760018061496;
        Thu, 09 Oct 2025 06:54:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJPH0bAlJvZir41ss8hqpNJRhwMQplwddOBUuqYzrHWOEttmDmU+J9gfXIh5Kv1JATtgZ2UA==
X-Received: by 2002:a17:903:298e:b0:28e:756c:7082 with SMTP id d9443c01a7336-29027374b38mr95773525ad.15.1760018061026;
        Thu, 09 Oct 2025 06:54:21 -0700 (PDT)
Received: from [10.217.217.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e1d56esm29919685ad.28.2025.10.09.06.54.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 06:54:19 -0700 (PDT)
Message-ID: <831f6fd7-b81f-4d6f-b9bd-5a8fe514befb@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 19:24:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/20] arm64: dts: qcom: kaanapali-mtp: Enable more
 features
To: Eugen Hristev <eugen.hristev@linaro.org>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-14-3fdbc4b9e1b1@oss.qualcomm.com>
 <588a7b68-2e2e-4e65-9249-fe8b18b67927@linaro.org>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <588a7b68-2e2e-4e65-9249-fe8b18b67927@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX4jc/IJJxF/GL
 Y0VRE623lD6bW6dJ0OkeSx70i8osJcsxnzPHaq4c7bIECsaHwZgEu3/z5AxOOFIG8RMNSgO5yEg
 vDY87AtyPeMcJIc0EiuBuqT91d1d3NLyzFajCfbSLKcvHFdzhdSClzFW/mLsbMUf+Jkb3s1Tg9m
 3OAI07kFbuJuKvPGE5GPm/ZdkoOUzIfT6bn+5EHx2Bvzi0vdohqXfINvlkvgzae+10hS32RMiYX
 rNAalZFuvUCynJThAfBSW3vIZV07OkKkDAIyCK+hTDkb24cI4+Ln8wgNXxFQ1QVCcMc6DYP6vJ+
 zWeX7/tfeEjUoni5ZcHARYqmxxaSpm2cUIM9mhszAXGV9yoZnXhVz77m819WwV96HrmqyLECymd
 fNxYNvZTQu+XlaqPH0vQXCOqeQhkkg==
X-Authority-Analysis: v=2.4 cv=B6G0EetM c=1 sm=1 tr=0 ts=68e7be8e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=_UWpYu-_HEzktCU8uygA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-GUID: dRSNAlQreoCSPXOzHBPWqga5rBIyXRjX
X-Proofpoint-ORIG-GUID: dRSNAlQreoCSPXOzHBPWqga5rBIyXRjX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

Hi Eugen,

On 9/25/2025 1:33 PM, Eugen Hristev wrote:
> 
> 
> On 9/25/25 03:17, Jingyi Wang wrote:
>> Enable more features on Kaanapali MTP boards including PMIC peripherals,
>> bus, SDHCI, remoteprocs, USB, PCIE, WLAN and Bluetooth.
>>
>> Written with help from Jyothi Kumar Seerapu(added bus), Ronak Raheja
>> (added USB), Manish Pandey(added SDHCI), Jishnu Prakash(added PMIC),
>> Qiang Yu(added PCIE), Yijie Yang(Added WLAN) and Zijun Hu(Added Bluetooth).
>>
>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/kaanapali-mtp.dts | 663 +++++++++++++++++++++++++++++
>>  1 file changed, 663 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
>> index 9cf3158e2712..2949579481a9 100644
>> --- a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
>> +++ b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
>> @@ -5,9 +5,23 @@
>>  

...

>> +
>> +&spmi_bus1 {
>> +	pmd8028: pmic@4 {
>> +		compatible = "qcom,pmd8028", "qcom,spmi-pmic";
>> +		reg = <0x4 SPMI_USID>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		pmd8028_temp_alarm: temp-alarm@a00 {
>> +			compatible = "qcom,spmi-temp-alarm";
>> +			reg = <0xa00>;
>> +			interrupts = <0x4 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
>> +			#thermal-sensor-cells = <0>;
>> +		};
>> +
>> +		pmd8028_gpios: gpio@8800 {
>> +			compatible = "qcom,pmd8028-gpio", "qcom,spmi-gpio";
>> +			reg = <0x8800>;
>> +			gpio-controller;
>> +			gpio-ranges = <&pmd8028_gpios 0 0 4>;
>> +			#gpio-cells = <2>;
>> +			interrupt-controller;
>> +			#interrupt-cells = <2>;
>> +		};
>> +	};
>> +
>> +	pmih0108: pmic@7 {
>> +		compatible = "qcom,pmih0108", "qcom,spmi-pmic";
>> +		reg = <0x7 SPMI_USID>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		pmih0108_temp_alarm: temp-alarm@a00 {
>> +			compatible = "qcom,spmi-temp-alarm";
>> +			reg = <0xa00>;
>> +			interrupts = <0x7 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
>> +			#thermal-sensor-cells = <0>;
>> +		};
>> +
>> +		pmih0108_gpios: gpio@8800 {
>> +			compatible = "qcom,pmih0108-gpio", "qcom,spmi-gpio";
>> +			reg = <0x8800>;
>> +			gpio-controller;
>> +			gpio-ranges = <&pmih0108_gpios 0 0 18>;
>> +			#gpio-cells = <2>;
>> +			interrupt-controller;
>> +			#interrupt-cells = <2>;
>> +		};
>> +
>> +		pmih0108_eusb2_repeater: phy@fd00 {
>> +			compatible = "qcom,pm8550b-eusb2-repeater";
>> +			reg = <0xfd00>;
>> +			#phy-cells = <0>;
>> +			vdd18-supply = <&vreg_l15b_1p8>;
>> +			vdd3-supply = <&vreg_l5b_3p1>;
>> +		};
>> +	};
>> +
>> +	pmr735d: pmic@a {
> 
> Hi,
> 
> The PMR735D is available in pmr735d_a.dtsi
> 
> Can we find a way to reuse that include file instead of duplicating it
> here ?

In pmr735d_a.dtsi, the peripherals are added under the parent phandle
"spmi_bus", which was commonly used in older SoCs having only a single
bus under the PMIC arbiter, but in Kaanapali, there are two buses
present under the PMIC arbiter, with phandles "spmi_bus0" and "spmi_bus1",
so we cannot include the file as it is.

Thanks,
Jishnu

> 
>> +		compatible = "qcom,pmr735d", "qcom,spmi-pmic";
>> +		reg = <0xa SPMI_USID>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		pmr735d_temp_alarm: temp-alarm@a00 {
>> +			compatible = "qcom,spmi-temp-alarm";
>> +			reg = <0xa00>;
>> +			interrupts = <0xa 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
>> +			#thermal-sensor-cells = <0>;
>> +		};
>> +
>> +		pmr735d_gpios: gpio@8800 {
>> +			compatible = "qcom,pmr735d-gpio", "qcom,spmi-gpio";
>> +			reg = <0x8800>;
>> +			gpio-controller;
>> +			gpio-ranges = <&pmr735d_gpios 0 0 2>;
>> +			#gpio-cells = <2>;
>> +			interrupt-controller;
>> +			#interrupt-cells = <2>;
>> +		};
>> +	};
>> +
> 
> 
> [...]
> 


