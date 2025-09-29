Return-Path: <linux-kernel+bounces-835710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A84D9BA7DC9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 05:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499F817F2CF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 03:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C57214A9E;
	Mon, 29 Sep 2025 03:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lECdPicK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7A11D5AC6
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 03:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759116282; cv=none; b=pcXg43KQ8XRF6vI5TFT/uY8cX9MP00PhZwofOKiqn3Ew6YgYqUgvZCTWWgTr9eNmVhv3y8OMHc5maKsGABDrSI3QFrdMkf4Go9jCxP4zJ5XiUV7VgviLkWh1Ny9jKbOh4WgJosYDmPeKLXboA/zwHFp/dVk7ZreGAV8BcCZfUAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759116282; c=relaxed/simple;
	bh=D3ShDed3HG3LUEbET3C9AT6/wMXItMBmCOPHHkTjQ0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LxbMqmG+27BMzsd89o4wJAMcZUR5ch1xcaSkMvl2H2mzZEzYvtqgLM1h4jNb4VJd8XU4/07GLm92v42JodQ/WPjBRut0SfV567z/qBXFS276AcY6sE2O4pYqx6jPzFYnVSR1vNRn//mTnxnCPs1gKPC6yG1QX6G0FlbiQgLMTGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lECdPicK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SMQGaa001323
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 03:24:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SPI/IGNzmpVzsu2TV5zRIOisRDssgk6yT0zJDgxdhVY=; b=lECdPicKftamhm5c
	M5cn6QTkPT27EvNFfYVn7fHDfeEVtdHcPCMhdSVSaG8Cl97KYqcou8SCW8VT89yT
	y6FuaTxzEkOSJ20SACTIjrT3l8Hc8NcygZtEHy3/Uro+1VNNILqBNiSSVUpbd1aA
	5Y3M3cksvqVQllpmZrGVnGpmcJtDyF1PXCehGGmvJgbTPoeuT/X0aOM5v3POy4Ze
	g8D5ZTVoHUXeA7P34d5A3lXjwHVx6ab3eoWj+tLKY5ssAzDS4RxiPLMJo3EDOmB7
	5F//HSeoU87STy2UoCQytMspoF97SHufUJUBWFwQbVJw/CdWhIMe2dGQSUdFxdtB
	AscnMw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8a5uqrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 03:24:39 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b5529da7771so3065162a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 20:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759116278; x=1759721078;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SPI/IGNzmpVzsu2TV5zRIOisRDssgk6yT0zJDgxdhVY=;
        b=K/eC4pGcEozXskqKmupEOUxfXTuZ0Ua2egFImN6YM5svIySzVgHPuPL/C6vXE5mX4F
         jhL6WbAvDXIDO5KY2yums2XrgFlnuVLtLKml4DggqbQW4vuf4tYOYJP6BAOASydTk4zI
         CMSg97DY6h2IYNnQs9Yk+LdGsYtBlpXu1CpQYbxrK18VEdvXudoUDszaCr8xKqC/UUBt
         rEtjLNVnhglQETs5OIcIUE2MKjxIvLdfcuRF/4GClXL4+OGgAY6D4q7+JI7qyxRXcZE/
         6n6j3HdpKXkMu8/QSY9vw8vSKk0zTVKWTmGZ/kRuc4wLhvi/DzQG88wpfX0C3wZNncIt
         /rCg==
X-Forwarded-Encrypted: i=1; AJvYcCXgJmXLBP17THh0WfcwJfwYexe3okMfiZBjd3ldqrR0GROiDRySeXDdd+71azo2q4/RCKQd/zUYTRo0Lyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc8kUAQT7ogy/OxOuAIfEtFSsDFb5HslaRL8FfbbHGHtuRarmS
	36UL6IIIwwMgpttffT09HYrZ5i/0bw1FKMRjAMqgwX4Ds/7xhbuByp6b7NhYYpBY48AMc/Twaoh
	FBAUiA/zRAIj+hFKDBJHnAmc7oyVTSEtWrANwkBsAVavzyXS3fKdNrWp0jorxuZ+wYpU=
X-Gm-Gg: ASbGncvKxfKgc8zhy2FJJKniwWvdtDJl1ndE+IypJBqMQbuAiJQb2cD1cc5I/bfSVqm
	n3nR/veR/37ElPqa7B734T8nsNtW0pq4MxVSMBZLObFpqAfDKT3wmwCsCx5YcnUPTizfPM5HFpq
	/dKGJILizL9OQzEuquugcF3ijkbyq/wVA3lyluAEbV5OQcONTLSD01JBPDI4jNoHJkmA7MuZywN
	6iDiVGq1W/5YyJRkqsxxq6fW/x02k7AvExUt/EVJGWgR0Yr7ysiiT5uZfsJLrG0OjjiVkUmwXZB
	eZFevCca1GLCYk2bGIFVbXIF9vxnB4K1Vf2MX5mc4cZ0fCmkklJQULnXT3P2vq4RLz5nWIVsB8S
	fLeIJiEgq5lN3CwnKz4TVPQOecaw1+tdgM64=
X-Received: by 2002:a05:6a20:7f90:b0:2cb:93ab:7edb with SMTP id adf61e73a8af0-2e7bfc1d5demr18048515637.4.1759116278087;
        Sun, 28 Sep 2025 20:24:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsuwplX5s3wzM16BteuBJjcC9lkMFTr4GJ3fvGWLuY/Kv6bWpjJ7PJvca9nh6C+m8ci2AxPw==
X-Received: by 2002:a05:6a20:7f90:b0:2cb:93ab:7edb with SMTP id adf61e73a8af0-2e7bfc1d5demr18048483637.4.1759116277569;
        Sun, 28 Sep 2025 20:24:37 -0700 (PDT)
Received: from [10.133.33.234] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102b23092sm9906163b3a.60.2025.09.28.20.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Sep 2025 20:24:37 -0700 (PDT)
Message-ID: <3b0ff070-609d-4ee4-8cbb-f110d74940c5@oss.qualcomm.com>
Date: Mon, 29 Sep 2025 11:24:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/20] arm64: dts: qcom: kaanapali-mtp: Enable more
 features
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-14-3fdbc4b9e1b1@oss.qualcomm.com>
 <ejcchgc3isc5f6tmiqbxqihmk5efmbcyhv3ehuoerb5ulkd5an@g7a2wc422l6n>
Content-Language: en-US
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
In-Reply-To: <ejcchgc3isc5f6tmiqbxqihmk5efmbcyhv3ehuoerb5ulkd5an@g7a2wc422l6n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RZKdyltv c=1 sm=1 tr=0 ts=68d9fbf7 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=pSh5v0xwnJqw1PdnfigA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: Ye3eKgrth8xfrAx0IRZiUHYDdGG9IrwV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMyBTYWx0ZWRfX8kE+GzYDLerW
 zjbuiBgIX8gNLuMf0Z3hYj2ttufkmUNWpBcK8wYq3zeYXBV09AgAxiHipQJVn/PwEvHFk4LEbhR
 Sh/EtR8tMEITeekvEohtagnPRBojE6TIzeZtjP/lJ4WNgMehQ/D4QY7FYD/ROTtX2qCOXK3Nnz+
 5SLz+9FGzGUFfpZvfQo+H+nInl+xDLIK++52eaxkrSFDwLcSY5q3U8h8fkeGAsYNHcpAhIR6Q2W
 XFNjCCTCVfwqwsxOXVQvoEdwhAN48camUhGf7en/JsxZmquTDmay7huzIyMS+jGa9TRPprsrzFl
 1ax2rKs44Wjo86GbwyQdjxJIzKofg/7UjKpzIjUD6Oj7LiLnkNvVXiDhAsRZO42KVn6fJeGirgF
 yDpBwQpXesjakxCIkgScMXYScY5QLg==
X-Proofpoint-ORIG-GUID: Ye3eKgrth8xfrAx0IRZiUHYDdGG9IrwV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_01,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270033



On 9/25/2025 10:09 AM, Dmitry Baryshkov wrote:
> On Wed, Sep 24, 2025 at 05:17:31PM -0700, Jingyi Wang wrote:
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
>>  /dts-v1/;
>>  
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/input/linux-event-codes.h>
>> +#include <dt-bindings/leds/common.h>
>>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>  #include "kaanapali.dtsi"
>>  
>> +#define PMH0110_D_E0_SID 3
>> +#define PMH0110_F_E0_SID 5
>> +#define PMH0110_G_E0_SID 6
>> +#define PMH0110_I_E0_SID 8
>> +#define PMH0104_J_E1_SID 9
>> +
>> +#include "pmk8850.dtsi"
>> +#include "pmh0101.dtsi"
>> +#include "pmh0110.dtsi"
>> +#include "pmh0104.dtsi"
>> +
>>  / {
>>  	model = "Qualcomm Technologies, Inc. Kaanapali MTP";
>>  	compatible = "qcom,kaanapali-mtp", "qcom,kaanapali";
>> @@ -15,6 +29,7 @@ / {
>>  
>>  	aliases {
>>  		serial0 = &uart7;
>> +		serial1 = &uart18;
>>  	};
>>  
>>  	chosen {
>> @@ -52,6 +67,304 @@ bi_tcxo_ao_div2: bi-tcxo-ao-div2-clk {
>>  			clock-div = <2>;
>>  		};
>>  	};
>> +
>> +	gpio-keys {
>> +		compatible = "gpio-keys";
>> +
>> +		pinctrl-0 = <&key_vol_up_default>;
>> +		pinctrl-names = "default";
>> +
>> +		key-volume-up {
>> +			label = "Volume Up";
>> +			linux,code = <KEY_VOLUMEUP>;
>> +			gpios = <&tlmm 101 GPIO_ACTIVE_LOW>;
>> +			debounce-interval = <15>;
>> +			linux,can-disable;
>> +			wakeup-source;
>> +		};
>> +	};
>> +
>> +	thermal-zones {
>> +		pmh0101-thermal {
>> +			polling-delay-passive = <100>;
>> +
>> +			thermal-sensors = <&pmh0101_temp_alarm>;
>> +
>> +			trips {
>> +				trip0 {
>> +					temperature = <95000>;
>> +					hysteresis = <0>;
>> +					type = "passive";
>> +				};
>> +
>> +				trip1 {
>> +					temperature = <115000>;
>> +					hysteresis = <0>;
>> +					type = "hot";
>> +				};
>> +			};
>> +		};
>> +
>> +		pmh0104-thermal {
>> +			polling-delay-passive = <100>;
>> +
>> +			thermal-sensors = <&pmh0104_j_e1_temp_alarm>;
>> +
>> +			trips {
>> +				trip0 {
>> +					temperature = <95000>;
>> +					hysteresis = <0>;
>> +					type = "passive";
>> +				};
>> +
>> +				trip1 {
>> +					temperature = <115000>;
>> +					hysteresis = <0>;
>> +					type = "hot";
>> +				};
>> +			};
>> +		};
>> +
>> +		pmh0110-d-thermal {
>> +			polling-delay-passive = <100>;
>> +
>> +			thermal-sensors = <&pmh0110_d_e0_temp_alarm>;
>> +
>> +			trips {
>> +				trip0 {
>> +					temperature = <95000>;
>> +					hysteresis = <0>;
>> +					type = "passive";
>> +				};
>> +
>> +				trip1 {
>> +					temperature = <115000>;
>> +					hysteresis = <0>;
>> +					type = "hot";
>> +				};
>> +			};
>> +		};
>> +
>> +		pmh0110-f-thermal {
>> +			polling-delay-passive = <100>;
>> +
>> +			thermal-sensors = <&pmh0110_f_e0_temp_alarm>;
>> +
>> +			trips {
>> +				trip0 {
>> +					temperature = <95000>;
>> +					hysteresis = <0>;
>> +					type = "passive";
>> +				};
>> +
>> +				trip1 {
>> +					temperature = <115000>;
>> +					hysteresis = <0>;
>> +					type = "hot";
>> +				};
>> +			};
>> +		};
>> +
>> +		pmh0110-g-thermal {
>> +			polling-delay-passive = <100>;
>> +
>> +			thermal-sensors = <&pmh0110_g_e0_temp_alarm>;
>> +
>> +			trips {
>> +				trip0 {
>> +					temperature = <95000>;
>> +					hysteresis = <0>;
>> +					type = "passive";
>> +				};
>> +
>> +				trip1 {
>> +					temperature = <115000>;
>> +					hysteresis = <0>;
>> +					type = "hot";
>> +				};
>> +			};
>> +		};
>> +
>> +		pmh0110-i-thermal {
>> +			polling-delay-passive = <100>;
>> +
>> +			thermal-sensors = <&pmh0110_i_e0_temp_alarm>;
>> +
>> +			trips {
>> +				trip0 {
>> +					temperature = <95000>;
>> +					hysteresis = <0>;
>> +					type = "passive";
>> +				};
>> +
>> +				trip1 {
>> +					temperature = <115000>;
>> +					hysteresis = <0>;
>> +					type = "hot";
>> +				};
>> +			};
>> +		};
>> +
>> +		pmd8028-thermal {
>> +			polling-delay-passive = <100>;
>> +			thermal-sensors = <&pmd8028_temp_alarm>;
>> +
>> +			trips {
>> +				pmd8028_trip0: trip0 {
>> +					temperature = <95000>;
>> +					hysteresis = <0>;
>> +					type = "passive";
>> +				};
>> +
>> +				pmd8028_trip1: trip1 {
>> +					temperature = <115000>;
>> +					hysteresis = <0>;
>> +					type = "hot";
>> +				};
>> +			};
>> +		};
>> +
>> +		pmih0108-thermal {
>> +			polling-delay-passive = <100>;
>> +			thermal-sensors = <&pmih0108_temp_alarm>;
>> +
>> +			trips {
>> +				trip0 {
>> +					temperature = <95000>;
>> +					hysteresis = <0>;
>> +					type = "passive";
>> +				};
>> +
>> +				trip1 {
>> +					temperature = <115000>;
>> +					hysteresis = <0>;
>> +					type = "hot";
>> +				};
>> +			};
>> +		};
>> +
>> +		pmr735d-thermal {
>> +			polling-delay-passive = <100>;
>> +
>> +			thermal-sensors = <&pmr735d_temp_alarm>;
>> +
>> +			trips {
>> +				trip0 {
>> +					temperature = <95000>;
>> +					hysteresis = <0>;
>> +					type = "passive";
>> +				};
>> +
>> +				trip1 {
>> +					temperature = <115000>;
>> +					hysteresis = <0>;
>> +					type = "hot";
>> +				};
>> +			};
>> +		};
>> +
>> +		pm8010-m-thermal {
>> +			polling-delay-passive = <100>;
>> +
>> +			thermal-sensors = <&pm8010_m_temp_alarm>;
>> +
>> +			trips {
>> +				trip0 {
>> +					temperature = <95000>;
>> +					hysteresis = <0>;
>> +					type = "passive";
>> +				};
>> +
>> +				trip1 {
>> +					temperature = <115000>;
>> +					hysteresis = <0>;
>> +					type = "hot";
>> +				};
>> +			};
>> +		};
>> +
>> +		pm8010-n-thermal {
>> +			polling-delay-passive = <100>;
>> +
>> +			thermal-sensors = <&pm8010_n_temp_alarm>;
>> +
>> +			trips {
>> +				trip0 {
>> +					temperature = <95000>;
>> +					hysteresis = <0>;
>> +					type = "passive";
>> +				};
>> +
>> +				trip1 {
>> +					temperature = <115000>;
>> +					hysteresis = <0>;
>> +					type = "hot";
>> +				};
>> +			};
>> +		};
>> +	};
>> +
>> +	wcn7850-pmu {
>> +		compatible = "qcom,wcn7850-pmu";
>> +
>> +		pinctrl-0 = <&bt_default>, <&sw_ctrl_default>, <&wlan_en>;
>> +		pinctrl-names = "default";
>> +
>> +		bt-enable-gpios = <&pmh0104_j_e1_gpios 5 GPIO_ACTIVE_HIGH>;
>> +		wlan-enable-gpios = <&tlmm 16 GPIO_ACTIVE_HIGH>;
>> +
>> +		vdd-supply = <&vreg_s2j_0p8>;
>> +		vddio-supply = <&vreg_l2g_1p8>;
>> +		vddio1p2-supply = <&vreg_l3g_1p2>;
>> +		vddaon-supply = <&vreg_s7g_0p9>;
>> +		vdddig-supply = <&vreg_s1j_0p8>;
>> +		vddrfa1p2-supply = <&vreg_s7f_1p2>;
>> +		vddrfa1p8-supply = <&vreg_s8f_1p8>;
>> +
>> +		clocks = <&rpmhcc RPMH_RF_CLK1>;
>> +
>> +		regulators {
>> +			vreg_pmu_rfa_cmn: ldo0 {
>> +				regulator-name = "vreg_pmu_rfa_cmn";
>> +			};
>> +
>> +			vreg_pmu_aon_0p59: ldo1 {
>> +				regulator-name = "vreg_pmu_aon_0p59";
>> +			};
>> +
>> +			vreg_pmu_wlcx_0p8: ldo2 {
>> +				regulator-name = "vreg_pmu_wlcx_0p8";
>> +			};
>> +
>> +			vreg_pmu_wlmx_0p85: ldo3 {
>> +				regulator-name = "vreg_pmu_wlmx_0p85";
>> +			};
>> +
>> +			vreg_pmu_btcmx_0p85: ldo4 {
>> +				regulator-name = "vreg_pmu_btcmx_0p85";
>> +			};
>> +
>> +			vreg_pmu_rfa_0p8: ldo5 {
>> +				regulator-name = "vreg_pmu_rfa_0p8";
>> +			};
>> +
>> +			vreg_pmu_rfa_1p2: ldo6 {
>> +				regulator-name = "vreg_pmu_rfa_1p2";
>> +			};
>> +
>> +			vreg_pmu_rfa_1p8: ldo7 {
>> +				regulator-name = "vreg_pmu_rfa_1p8";
>> +			};
>> +
>> +			vreg_pmu_pcie_0p9: ldo8 {
>> +				regulator-name = "vreg_pmu_pcie_0p9";
>> +			};
>> +
>> +			vreg_pmu_pcie_1p8: ldo9 {
>> +				regulator-name = "vreg_pmu_pcie_1p8";
>> +			};
>> +		};
>> +	};
>>  };
>>  
>>  &apps_rsc {
>> @@ -674,6 +987,304 @@ vreg_l7n_3p3: ldo7 {
>>  	};
>>  };
>>  
>> +&pmh0110_d_e0 {
>> +	status = "okay";
>> +};
>> +
>> +&pmh0110_f_e0 {
>> +	status = "okay";
>> +};
>> +
>> +&pmh0110_g_e0 {
>> +	status = "okay";
>> +};
>> +
>> +&pmh0110_i_e0 {
>> +	status = "okay";
>> +};
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
>> +	pm8010_m: pmic@c {
>> +		compatible = "qcom,pm8010", "qcom,spmi-pmic";
>> +		reg = <0xc SPMI_USID>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		pm8010_m_temp_alarm: temp-alarm@2400 {
>> +			compatible = "qcom,spmi-temp-alarm";
>> +			reg = <0x2400>;
>> +			interrupts = <0xc 0x24 0x0 IRQ_TYPE_EDGE_BOTH>;
>> +			#thermal-sensor-cells = <0>;
>> +		};
>> +	};
>> +
>> +	pm8010_n: pmic@d {
>> +		compatible = "qcom,pm8010", "qcom,spmi-pmic";
>> +		reg = <0xd SPMI_USID>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		pm8010_n_temp_alarm: temp-alarm@2400 {
>> +			compatible = "qcom,spmi-temp-alarm";
>> +			reg = <0x2400>;
>> +			interrupts = <0xd 0x24 0x0 IRQ_TYPE_EDGE_BOTH>;
>> +			#thermal-sensor-cells = <0>;
>> +		};
>> +	};
>> +};
>> +
>> +&pmh0101_flash {
> 
> spmi > pmh0101_flash
> 

will fix

>> +	status = "okay";
>> +
>> +	led-0 {
>> +		function = LED_FUNCTION_FLASH;
>> +		function-enumerator = <0>;
>> +		color = <LED_COLOR_ID_YELLOW>;
>> +		led-sources = <1>, <4>;
>> +		led-max-microamp = <500000>;
>> +		flash-max-microamp = <2000000>;
>> +		flash-max-timeout-us = <1280000>;
>> +	};
>> +
>> +	led-1 {
>> +		function = LED_FUNCTION_FLASH;
>> +		function-enumerator = <1>;
>> +		color = <LED_COLOR_ID_WHITE>;
>> +		led-sources = <2>, <3>;
>> +		led-max-microamp = <500000>;
>> +		flash-max-microamp = <2000000>;
>> +		flash-max-timeout-us = <1280000>;
>> +	};
>> +};
>> +
>> +&pmh0101_pwm {
>> +	status = "okay";
>> +
>> +	multi-led {
>> +		color = <LED_COLOR_ID_RGB>;
>> +		function = LED_FUNCTION_STATUS;
>> +
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		led@1 {
>> +			reg = <1>;
>> +			color = <LED_COLOR_ID_RED>;
>> +		};
>> +
>> +		led@2 {
>> +			reg = <2>;
>> +			color = <LED_COLOR_ID_GREEN>;
>> +		};
>> +
>> +		led@3 {
>> +			reg = <3>;
>> +			color = <LED_COLOR_ID_BLUE>;
>> +		};
>> +	};
>> +};
>> +
>> +&tlmm {
>> +	wlan_en: wlan-en-state {
>> +		pins = "gpio16";
>> +		function = "gpio";
>> +		drive-strength = <8>;
>> +		bias-pull-down;
>> +	};
> 
> Why are the TLMM pin entries sorted?
> 
>> +
>> +	sw_ctrl_default: sw-ctrl-default-state {
>> +		pins = "gpio18";
>> +		function = "gpio";
>> +		bias-pull-down;
>> +	};
>> +
>> +	key_vol_up_default: key-vol-up-default-state {
>> +		pins = "gpio101";
>> +		function = "gpio";
>> +		output-disable;
>> +		bias-pull-up;
>> +	};
>> +
>> +	pcie0_default_state: pcie0-default-state {
>> +		clkreq-n-pins {
>> +			pins = "gpio103";
>> +			function = "pcie0_clk_req_n";
>> +			drive-strength = <2>;
>> +			bias-pull-up;
>> +		};
>> +
>> +		perst-n-pins {
>> +			pins = "gpio102";
>> +			function = "gpio";
>> +			drive-strength = <2>;
>> +			bias-disable;
>> +		};
>> +
>> +		wake-n-pins {
>> +			pins = "gpio104";
>> +			function = "gpio";
>> +			drive-strength = <2>;
>> +			bias-pull-up;
>> +		};
>> +	};
>> +};
>> +
>> +&pcie0 {
> 
> This is also in the wrong place. Please keep the nodes sorted.
> 

will fix

>> +	pinctrl-0 = <&pcie0_default_state>;
>> +	pinctrl-names = "default";
>> +
>> +	status = "okay";
>> +};
>> +
>> +&pcie0_phy {
>> +	vdda-phy-supply = <&vreg_l3i_0p8>;
>> +	vdda-pll-supply = <&vreg_l1d_1p2>;
>> +
>> +	status = "okay";
>> +};
>> +
>> @@ -702,3 +1343,25 @@ &ufs_mem_phy {
>>  
>>  	status = "okay";
>>  };
>> +
>> +&usb_1 {
>> +	dr_mode = "peripheral";
> 
> Is it really peripheral-only?
> 
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_1_hsphy {
>> +	vdd-supply = <&vreg_l4f_0p8>;
>> +	vdda12-supply = <&vreg_l1d_1p2>;
>> +
>> +	phys = <&pmih0108_eusb2_repeater>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_dp_qmpphy {
>> +	vdda-phy-supply = <&vreg_l1d_1p2>;
>> +	vdda-pll-supply = <&vreg_l4f_0p8>;
>> +
>> +	status = "okay";
>> +};
>>
>> -- 
>> 2.25.1
>>
> 
Thanks,
Jingyi

