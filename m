Return-Path: <linux-kernel+bounces-796462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4817B400FE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74842540F7B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2FF29B79B;
	Tue,  2 Sep 2025 12:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZW02tLJN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F0129BD8E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756816973; cv=none; b=dxp8AGwzT9rrLrtBGB+0nBSCX2cNIv8ILgCOKE7Qx2fk9xL77ZblPlvDuIDeOteHbwejOJfYBT1t1l5ksBxcrJqEatdYDajEWpJf5Br3SP/n6rMvqHOEcivldadEOHHaG1XSdi4EOFZy/u+4JpCCFQXBUo+PNUTLnBWZhE98xQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756816973; c=relaxed/simple;
	bh=BRbYHAyl8xdkn+oGdyKAQjVa+sf1mqiPO3EGMphqzKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uOCVTItbLBC6TGBrivXLZVvu9fj//znhFrdl5QBhx/ohpvkYMANLWL9A45tafJLFW7k5wZewTxY49Q0SHYEJCdYkQgq4jZDA4CQmfJCD5ahUAIgJ2j7Myy/1zgQkTJoOOdh1Q0kIeSgmnU6KWrLc1oAWqX8F2BvVPZH5ssbiSoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZW02tLJN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582B1cTC016270
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 12:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Fcn0vd/4OqThYKIU5akXrtN3ig7Q+X2xG5B243+6bRg=; b=ZW02tLJN3fczyvK1
	XI71rD6lja9OxvpCClMr3qdBLVa3mL4U8y32tvDxCR0kRCszGpznFKzhJGfWPo0m
	p9xnZTL2t/sI94MtNlNwA2MnDeJSL46Pm2fpdOwOQhjXmLigecGeIRxYluFCNH9e
	o0DQpT/CrjrzK/YWs61s34B/Egas2vb7DbXIYOFpo/Dln0in2L4XhX2wjhKClHMe
	mSfX4vKv88uT9pMjFPRwcVpKekAn7PJxQvpMp0AClPvDRDYkjeoULvVmIjDsxVP3
	OZjzy53MQ8ip5CTUobQwXshC6BwMegrZzyqvUW/ua4LqEKb4oAiM9ntMAnBLhvls
	hZmI2g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk8ykrw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 12:42:50 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7724e0faa10so141350b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 05:42:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756816969; x=1757421769;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fcn0vd/4OqThYKIU5akXrtN3ig7Q+X2xG5B243+6bRg=;
        b=WtMk/vnLpOwrff4cdDCwpUdWxTL+GnMk+GV1xr8myZKHqxRhRYstY4yhs27FDSkj8d
         95g6SvQmKPQzlRayiSwKXnQvb5DdC9NBZRFkcwIhDLnIJYQ+RYiN3xLBXoV9Rw+X05XY
         HX8YVpgMpxlokrChhBPeD9XKrjEmBviEipUyGYnUCUNc1XWRZgrgMs6cu18fACv66XAS
         jYoCk2u0Jnmm2pURzlmPgqULWllojozaRC+k2/cucKOe/vy0oGkYMY4+4oliLg5GlvWt
         7DQI+F2KKDYINlPxHSvv4JsChBs9ys17QXrDb6x78vIqQ/TKD1r1a/MlSWPh+4I4SMOq
         ZJYA==
X-Forwarded-Encrypted: i=1; AJvYcCVWpFvrP2VLFtQWcPrg4tYsgC5pDvXkwWBgM50/fMdsAya7LMblNEKTBshEt6WgDMrVBpf0CkSrjRU/Hic=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTHn9922v6g+A5wbyVi0NFQ4lKBRPe9BDZnOXGmLOv8lZKe+5p
	xQO6FqnHegVQIfuLCA/tgTnynAupPsXkjs7T4ipgVtmY8rtrX2FOmrD1sHx0gLfPSfGqFsW3oHO
	C+hpf0GNUxVZeVOk+99nub+Jy+UAqa48lYgG2QSTuoST1fvMRBTs6kTRsclXfrdh3zPw=
X-Gm-Gg: ASbGncsdB51x+qE8rgU8SLh6PW1lHrPBZrrdYQ4E9NgN3BlML93XtybgOEXPWukY/wc
	d2p4l0x1RD05dFH5eWLpBB0qYOJeJv0BeMBjczX3VoFyjzXF4WUrYkDM49E/tO/Iu77qAa62gO4
	gtK/u53q3/jdJVq1FZaGWFP5aMi7mWj573Wcu7slUR5RifZZcd+MHl5G3GpIY16pAG6kGfH/OEf
	ZkyBD5sR9tKt1bELlMTfB4ZgowocRBdDh5y4X8xYEXMRKKxw0BBSFVA8/Uzm7P7oW4KbEO9eVBT
	eb9D3Bj3Xsx1KZ8dUu5D4eOmFDhc2yG1micZo9SIsLLnSjdUH723+eT0vdBASPEVKNsE
X-Received: by 2002:a05:6a00:3cc4:b0:73e:2b50:426 with SMTP id d2e1a72fcca58-77232928de3mr8413134b3a.4.1756816968976;
        Tue, 02 Sep 2025 05:42:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfYJNADMfUdd3x6TJ2qZnSsX3jb0tBI6fQSqaB3/B/vNwZoWfypHhtZcyFs2y0AMAtHZFIwg==
X-Received: by 2002:a05:6a00:3cc4:b0:73e:2b50:426 with SMTP id d2e1a72fcca58-77232928de3mr8413114b3a.4.1756816968379;
        Tue, 02 Sep 2025 05:42:48 -0700 (PDT)
Received: from [10.218.41.33] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4bcd09sm13180925b3a.49.2025.09.02.05.42.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 05:42:47 -0700 (PDT)
Message-ID: <9e3e8bc6-25ca-44fd-86fe-949205b0f078@oss.qualcomm.com>
Date: Tue, 2 Sep 2025 18:12:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: Add Monaco EVK initial board
 support
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>,
        Arun Khannna <quic_arkhanna@quicinc.com>,
        Monish Chunara <quic_mchunara@quicinc.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Swati Agarwal <swati.agarwal@oss.qualcomm.com>
References: <20250826181506.3698370-1-umang.chheda@oss.qualcomm.com>
 <20250826181506.3698370-3-umang.chheda@oss.qualcomm.com>
 <tzw3meuh4ioyolhx5l4uoz6ztlt73dl5ijd6rsornusfgzmq65@v3d56czx5otn>
Content-Language: en-US
From: Umang Chheda <umang.chheda@oss.qualcomm.com>
In-Reply-To: <tzw3meuh4ioyolhx5l4uoz6ztlt73dl5ijd6rsornusfgzmq65@v3d56czx5otn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ga5JrVDTf1ulRMd9jLsGsa6Jawfm6q5x
X-Proofpoint-ORIG-GUID: ga5JrVDTf1ulRMd9jLsGsa6Jawfm6q5x
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68b6e64a cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=7RHfIQOaIPkK4HzrbJ0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfXzyjQMhUbWUyj
 lYyBiD+6k3ZzUFXGX4kKLcdv6j9Hzjk9cLviN9AMYU+e/Z6l0sjm6SHJIxB7sbFSiCVM4X/w0zy
 0ypcZoHNkgegW7V9Uep+nweqzjKB4Mav8nyDTvX9oq7CrGNbf06IpqEtaPGX38pkDwKci1J4TyW
 Tg48YEK0s2yPKXDViub9SvSSMrIGcsot+1aZLYYWG3Iqs1qtnNLCL8WpQ/ies7y5V62/6+TiH6I
 ksiJbf0eqc5zm7kWX7pB8qmKWV0e8lzi4xJRS0UEGiqs3NSpOFZNnVAFQw8NrkeS8JLF9FQKiYL
 why4IGqyxTkDIGcnJcxbe94imgQg2mJtsJAY0Vs6p5kpaLicIneCDyMRiL0pD4lJBxh6HDf/NsN
 CA9wdPTE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042

Hi Bjorn,

On 8/27/2025 11:28 PM, Bjorn Andersson wrote:
> On Tue, Aug 26, 2025 at 11:45:06PM +0530, Umang Chheda wrote:
> 
> Please add "qcs8300: " to the prefix and drop the words "initial" and
> "support" from subject.
> 
>> Add initial device tree support for Monaco EVK board, based on
>> Qualcomm's QCS8300 SoC.
> 
> Drop this sentence and embed the useful information in the next
> paragraph, which introduces us to the purpose of the patch.
> 
> "Monaco EVK is a single board computer, based on the Qualcomm QCS8300
> SoC, with the following features:"
>>

Ack.

>> Monaco EVK is single board supporting these peripherals:
>>   - Storage: 1 × 128 GB UFS, micro-SD card, EEPROMs for MACs,
>>     and eMMC.
>>   - Audio/Video, Camera & Display ports.
>>   - Connectivity: RJ45 2.5GbE, WLAN/Bluetooth, CAN/CAN-FD.
>>   - PCIe ports.
>>   - USB & UART ports.
>>
>> On top of Monaco EVK board additional mezzanine boards can be
>> stacked in future.
>>
>> Add support for the following components :
>>   - GPI (Generic Peripheral Interface) and QUPv3-0/1
>>     controllers to facilitate DMA and peripheral communication.
>>   - TCA9534 I/O expander via I2C to provide 8 additional GPIO
>>     lines for extended I/O functionality.
>>   - USB1 controller in device mode to support USB peripheral
>>     operations.
>>   - Remoteproc subsystems for supported DSPs such as Audio DSP,
>>     Compute DSP and Generic DSP, along with their corresponding
>>     firmware.
>>   - Configure nvmem-layout on the I2C EEPROM to store data for Ethernet
>>     and other consumers.
>>   - QCA8081 2.5G Ethernet PHY on port-0 and expose the
>>     Ethernet MAC address via nvmem for network configuration.
>>     It depends on CONFIG_QCA808X_PHY to use QCA8081 PHY.
>>   - Support for the Iris video decoder, including the required
>>     firmware, to enable video decoding capabilities.
>>
>> Co-developed-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
>> Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
>> Co-developed-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
>> Signed-off-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
>> Co-developed-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
>> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
>> Co-developed-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
>> Signed-off-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
>> Co-developed-by: Arun Khannna <quic_arkhanna@quicinc.com>
>> Signed-off-by: Arun Khannna <quic_arkhanna@quicinc.com>
>> Co-developed-by: Monish Chunara <quic_mchunara@quicinc.com>
>> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
>> Co-developed-by: Vikash Garodia <quic_vgarodia@quicinc.com>
>> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
>> Co-developed-by: Swati Agarwal <swati.agarwal@oss.qualcomm.com>
>> Signed-off-by: Swati Agarwal <swati.agarwal@oss.qualcomm.com>
>> Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/Makefile       |   1 +
>>  arch/arm64/boot/dts/qcom/monaco-evk.dts | 463 ++++++++++++++++++++++++
>>  2 files changed, 464 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/qcom/monaco-evk.dts
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index 94a84770b080..057a81ea04ed 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -30,6 +30,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp449.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp453.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp454.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= lemans-evk.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= monaco-evk.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8216-samsung-fortuna3g.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-acer-a1-724.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-alcatel-idol347.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/monaco-evk.dts b/arch/arm64/boot/dts/qcom/monaco-evk.dts
>> new file mode 100644
>> index 000000000000..8d58e62f6c87
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/monaco-evk.dts
>> @@ -0,0 +1,463 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
> 
> This is the wrong copyright statement.

Ack, will update this in next patch.

> 
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>> +
>> +#include "qcs8300.dtsi"
>> +#include "qcs8300-pmics.dtsi"
>> +
>> +/ {
>> +	model = "Qualcomm Technologies, Inc. Monaco EVK";
>> +	compatible = "qcom,monaco-evk", "qcom,qcs8300";
>> +
>> +	aliases {
>> +		ethernet0 = &ethernet0;
>> +		i2c1 = &i2c1;
>> +		serial0 = &uart7;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +};
>> +
>> +&apps_rsc {
>> +	regulators-0 {
>> +		compatible = "qcom,pmm8654au-rpmh-regulators";
>> +		qcom,pmic-id = "a";
>> +
>> +		vreg_l3a: ldo3 {
>> +			regulator-name = "vreg_l3a";
>> +			regulator-min-microvolt = <1200000>;
>> +			regulator-max-microvolt = <1200000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +			regulator-allow-set-load;
>> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
>> +						   RPMH_REGULATOR_MODE_HPM>;
> 
> Are you sure that all these should have LPM and HPM as allowed modes? I
> would have preferred HPM-only and then selectively enable LPM, to avoid
> issues when LPM is entered.
> 
> Such as what happened in fba47ba8c8a8 ("arm64: dts: qcom: qcs615: Set
> LDO12A regulator to HPM to avoid boot hang")
> 

Ack, we will enable only HPM mode for now, and enable LPM modes selectively
later after confirming LPM voting support from all the clients.

> Regards,
> Bjorn
> 

Thanks,
Umang

> 
>> +		};
>> +
>> +		vreg_l4a: ldo4 {
>> +			regulator-name = "vreg_l4a";
>> +			regulator-min-microvolt = <880000>;
>> +			regulator-max-microvolt = <912000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +			regulator-allow-set-load;
>> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
>> +						   RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l5a: ldo5 {
>> +			regulator-name = "vreg_l5a";
>> +			regulator-min-microvolt = <1200000>;
>> +			regulator-max-microvolt = <1200000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +			regulator-allow-set-load;
>> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
>> +						   RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l6a: ldo6 {
>> +			regulator-name = "vreg_l6a";
>> +			regulator-min-microvolt = <880000>;
>> +			regulator-max-microvolt = <912000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +			regulator-allow-set-load;
>> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
>> +						   RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l7a: ldo7 {
>> +			regulator-name = "vreg_l7a";
>> +			regulator-min-microvolt = <880000>;
>> +			regulator-max-microvolt = <912000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +			regulator-allow-set-load;
>> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
>> +						   RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l8a: ldo8 {
>> +			regulator-name = "vreg_l8a";
>> +			regulator-min-microvolt = <2504000>;
>> +			regulator-max-microvolt = <2960000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +			regulator-allow-set-load;
>> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
>> +						   RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l9a: ldo9 {
>> +			regulator-name = "vreg_l9a";
>> +			regulator-min-microvolt = <2970000>;
>> +			regulator-max-microvolt = <3072000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +			regulator-allow-set-load;
>> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
>> +						   RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +	};
>> +
>> +	regulators-1 {
>> +		compatible = "qcom,pmm8654au-rpmh-regulators";
>> +		qcom,pmic-id = "c";
>> +
>> +		vreg_s5c: smps5 {
>> +			regulator-name = "vreg_s5c";
>> +			regulator-min-microvolt = <1104000>;
>> +			regulator-max-microvolt = <1104000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l1c: ldo1 {
>> +			regulator-name = "vreg_l1c";
>> +			regulator-min-microvolt = <300000>;
>> +			regulator-max-microvolt = <512000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +			regulator-allow-set-load;
>> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
>> +						   RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l2c: ldo2 {
>> +			regulator-name = "vreg_l2c";
>> +			regulator-min-microvolt = <900000>;
>> +			regulator-max-microvolt = <904000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +			regulator-allow-set-load;
>> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
>> +						   RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l4c: ldo4 {
>> +			regulator-name = "vreg_l4c";
>> +			regulator-min-microvolt = <1200000>;
>> +			regulator-max-microvolt = <1200000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +			regulator-allow-set-load;
>> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
>> +						   RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l7c: ldo7 {
>> +			regulator-name = "vreg_l7c";
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <1800000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +			regulator-allow-set-load;
>> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
>> +						   RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l8c: ldo8 {
>> +			regulator-name = "vreg_l8c";
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <1800000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +			regulator-allow-set-load;
>> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
>> +						   RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l9c: ldo9 {
>> +			regulator-name = "vreg_l9c";
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <1800000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +			regulator-allow-set-load;
>> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
>> +						   RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +	};
>> +};
>> +
>> +&ethernet0 {
>> +	phy-mode = "2500base-x";
>> +	phy-handle = <&hsgmii_phy0>;
>> +
>> +	pinctrl-0 = <&ethernet0_default>;
>> +	pinctrl-names = "default";
>> +
>> +	snps,mtl-rx-config = <&mtl_rx_setup>;
>> +	snps,mtl-tx-config = <&mtl_tx_setup>;
>> +	snps,ps-speed = <1000>;
>> +	nvmem-cells = <&mac_addr0>;
>> +	nvmem-cell-names = "mac-address";
>> +
>> +	status = "okay";
>> +
>> +	mdio {
>> +		compatible = "snps,dwmac-mdio";
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		hsgmii_phy0: ethernet-phy@1c {
>> +			compatible = "ethernet-phy-id004d.d101";
>> +			reg = <0x1c>;
>> +			reset-gpios = <&tlmm 31 GPIO_ACTIVE_LOW>;
>> +			reset-assert-us = <11000>;
>> +			reset-deassert-us = <70000>;
>> +		};
>> +	};
>> +
>> +	mtl_rx_setup: rx-queues-config {
>> +		snps,rx-queues-to-use = <4>;
>> +		snps,rx-sched-sp;
>> +
>> +		queue0 {
>> +			snps,dcb-algorithm;
>> +			snps,map-to-dma-channel = <0x0>;
>> +			snps,route-up;
>> +			snps,priority = <0x1>;
>> +		};
>> +
>> +		queue1 {
>> +			snps,dcb-algorithm;
>> +			snps,map-to-dma-channel = <0x1>;
>> +			snps,route-ptp;
>> +		};
>> +
>> +		queue2 {
>> +			snps,avb-algorithm;
>> +			snps,map-to-dma-channel = <0x2>;
>> +			snps,route-avcp;
>> +		};
>> +
>> +		queue3 {
>> +			snps,avb-algorithm;
>> +			snps,map-to-dma-channel = <0x3>;
>> +			snps,priority = <0xc>;
>> +		};
>> +	};
>> +
>> +	mtl_tx_setup: tx-queues-config {
>> +		snps,tx-queues-to-use = <4>;
>> +
>> +		queue0 {
>> +			snps,dcb-algorithm;
>> +		};
>> +
>> +		queue1 {
>> +			snps,dcb-algorithm;
>> +		};
>> +
>> +		queue2 {
>> +			snps,avb-algorithm;
>> +			snps,send_slope = <0x1000>;
>> +			snps,idle_slope = <0x1000>;
>> +			snps,high_credit = <0x3e800>;
>> +			snps,low_credit = <0xffc18000>;
>> +		};
>> +
>> +		queue3 {
>> +			snps,avb-algorithm;
>> +			snps,send_slope = <0x1000>;
>> +			snps,idle_slope = <0x1000>;
>> +			snps,high_credit = <0x3e800>;
>> +			snps,low_credit = <0xffc18000>;
>> +		};
>> +	};
>> +};
>> +
>> +&gpi_dma0 {
>> +	status = "okay";
>> +};
>> +
>> +&gpi_dma1 {
>> +	status = "okay";
>> +};
>> +
>> +&i2c1 {
>> +	pinctrl-0 = <&qup_i2c1_default>;
>> +	pinctrl-names = "default";
>> +
>> +	status = "okay";
>> +
>> +	eeprom0: eeprom@50 {
>> +		compatible = "atmel,24c256";
>> +		reg = <0x50>;
>> +		pagesize = <64>;
>> +
>> +		nvmem-layout {
>> +			compatible = "fixed-layout";
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +
>> +			mac_addr0: mac-addr@0 {
>> +				reg = <0x0 0x6>;
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +&i2c15 {
>> +	pinctrl-0 = <&qup_i2c15_default>;
>> +	pinctrl-names = "default";
>> +
>> +	status = "okay";
>> +
>> +	expander0: pca953x@38 {
>> +		compatible = "ti,tca9538";
>> +		#gpio-cells = <2>;
>> +		gpio-controller;
>> +		reg = <0x38>;
>> +	};
>> +
>> +	expander1: pca953x@39 {
>> +		compatible = "ti,tca9538";
>> +		#gpio-cells = <2>;
>> +		gpio-controller;
>> +		reg = <0x39>;
>> +	};
>> +
>> +	expander2: pca953x@3a {
>> +		compatible = "ti,tca9538";
>> +		#gpio-cells = <2>;
>> +		gpio-controller;
>> +		reg = <0x3a>;
>> +	};
>> +
>> +	expander3: pca953x@3b {
>> +		compatible = "ti,tca9538";
>> +		#gpio-cells = <2>;
>> +		gpio-controller;
>> +		reg = <0x3b>;
>> +	};
>> +
>> +	expander4: pca953x@3c {
>> +		compatible = "ti,tca9538";
>> +		#gpio-cells = <2>;
>> +		gpio-controller;
>> +		reg = <0x3c>;
>> +	};
>> +
>> +	expander5: pca953x@3d {
>> +		compatible = "ti,tca9538";
>> +		#gpio-cells = <2>;
>> +		gpio-controller;
>> +		reg = <0x3d>;
>> +	};
>> +
>> +	expander6: pca953x@3e {
>> +		compatible = "ti,tca9538";
>> +		#gpio-cells = <2>;
>> +		gpio-controller;
>> +		reg = <0x3e>;
>> +	};
>> +};
>> +
>> +&iris {
>> +	status = "okay";
>> +};
>> +
>> +&qupv3_id_0 {
>> +	status = "okay";
>> +};
>> +
>> +&qupv3_id_1 {
>> +	status = "okay";
>> +};
>> +
>> +&remoteproc_adsp {
>> +	firmware-name = "qcom/qcs8300/adsp.mbn";
>> +
>> +	status = "okay";
>> +};
>> +
>> +&remoteproc_cdsp {
>> +	firmware-name = "qcom/qcs8300/cdsp0.mbn";
>> +
>> +	status = "okay";
>> +};
>> +
>> +&remoteproc_gpdsp {
>> +	firmware-name = "qcom/qcs8300/gpdsp0.mbn";
>> +
>> +	status = "okay";
>> +};
>> +
>> +&serdes0 {
>> +	phy-supply = <&vreg_l4a>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&tlmm {
>> +	ethernet0_default: ethernet0-default-state {
>> +		ethernet0_mdc: ethernet0-mdc-pins {
>> +			pins = "gpio5";
>> +			function = "emac0_mdc";
>> +			drive-strength = <16>;
>> +			bias-pull-up;
>> +		};
>> +
>> +		ethernet0_mdio: ethernet0-mdio-pins {
>> +			pins = "gpio6";
>> +			function = "emac0_mdio";
>> +			drive-strength = <16>;
>> +			bias-pull-up;
>> +		};
>> +	};
>> +
>> +	qup_i2c1_default: qup-i2c1-state {
>> +		pins = "gpio19", "gpio20";
>> +		function = "qup0_se1";
>> +		drive-strength = <2>;
>> +		bias-pull-up;
>> +	};
>> +
>> +	qup_i2c15_default: qup-i2c15-state {
>> +		pins = "gpio91", "gpio92";
>> +		function = "qup1_se7";
>> +		drive-strength = <2>;
>> +		bias-pull-up;
>> +	};
>> +};
>> +
>> +&uart7 {
>> +	status = "okay";
>> +};
>> +
>> +&ufs_mem_hc {
>> +	reset-gpios = <&tlmm 133 GPIO_ACTIVE_LOW>;
>> +	vcc-supply = <&vreg_l8a>;
>> +	vcc-max-microamp = <1100000>;
>> +	vccq-supply = <&vreg_l4c>;
>> +	vccq-max-microamp = <1200000>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&ufs_mem_phy {
>> +	vdda-phy-supply = <&vreg_l4a>;
>> +	vdda-pll-supply = <&vreg_l5a>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_1 {
>> +	status = "okay";
>> +};
>> +
>> +&usb_1_dwc3 {
>> +	dr_mode = "peripheral";
>> +};
>> +
>> +&usb_1_hsphy {
>> +	vdda-pll-supply = <&vreg_l7a>;
>> +	vdda18-supply = <&vreg_l7c>;
>> +	vdda33-supply = <&vreg_l9a>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_qmpphy {
>> +	vdda-phy-supply = <&vreg_l7a>;
>> +	vdda-pll-supply = <&vreg_l5a>;
>> +
>> +	status = "okay";
>> +};
>> --
>> 2.34.1
>>


