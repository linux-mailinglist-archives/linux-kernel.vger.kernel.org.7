Return-Path: <linux-kernel+bounces-744026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A09B1070E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FF221C839E8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4ACF2571C2;
	Thu, 24 Jul 2025 09:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DRYW6abE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AD7255F26
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753350876; cv=none; b=dWcvvUzkFsF7MIIkw+aUuvvScTg5tRUunXMgs7DYGjmepSm0HMUhf4w8Fdrh1FHMg8zgjdWYb9eB9aAAiVJjVSMIPW8VimIQRvIPQZiJjzFpcR1kQ2Fv/W51GRVaqJOzM9JWC0Z7IxSIN/2M+NsQp3xfXfKNITp69HjSe5PDPhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753350876; c=relaxed/simple;
	bh=+5q2qNOD8Tn/j37N5KG5nuQJGGlh1MNufHfPZ2yKNhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rN1pzgnY7f5Xs+mwP1s/BVq8WO6byruj8feaPnM1ih+AgurnUU6plFlMUS4vNuzggt44bqgfhdBLhYkXULpCknWds9w51c+EHfKWzBWGImlnrDQNgPxak702FXglxPxF7fvaqpLWVObgsU1fwhPJ7c7tf7gmsbE3bPWfrtgOmiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DRYW6abE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9XKso005792
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CxvzvN8HZ7PTYaCkkSpGFCHtnjuMT1vwIoj9nxyQaEY=; b=DRYW6abE5xyNhb0J
	v3KL9CO9afFiolYYcJ/nLQz8Wfcg5l2Pm7vrci2TFsd0my9WH63hMXJwpiZbtxJ+
	jiYM6LRPQeEzduA6wEJ+1hOUyfRdM4O5a4sKGEpcGuz5EClL6NEoFSm4JA8PAQCM
	vlY1fUAJbjbq3yTrAwuGejptctnhmMKX0yGD4qZLDJhigShgMsEy8JqfP/zEbnzJ
	Y+7/2ZFiId2zIVDOm7gxeJ+xgkWvxw+pKyH23iR4fi+ifBEUpiWypf2NGeJpzWUh
	Mpn225DK9LNnO4eH+6d6o2ujZ0kUyeBOj+9zxDvbUiUoz/STTObu7xcwbyHfDzV9
	9WO0vg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48047qg9pb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:54:33 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e34399a08fso210170985a.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 02:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753350873; x=1753955673;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CxvzvN8HZ7PTYaCkkSpGFCHtnjuMT1vwIoj9nxyQaEY=;
        b=VDnt8jrzrJdZ+a7p0i13M3JI282COZ4wYsrKhhK7gh8tHh6P6XlJNB3YJBPSgDbOnN
         OTt2AJAAS7IRXHl4Te8IgDOh0SkP30Y0K9tuG2g7iE2PGQklVaxb7hxifgUxtbbxrg9F
         9BfTg+4hofgmvihylUtZyHsSIcKhyAWmj/+2K8mdf6qN/+KLxSJ2+YoQt6ptAJF+3T5O
         dSoYseIzeXKJ3+6jx3pipRF3pyJnF1Zyt4HFWnLgVURm53H4MomOcyLYC0QSEsK1J3WZ
         EY0TO49jfEJcGlwcr8WaimQF3FoFy5AFLrIzlUeqr0eWxtmNqToVfEXYMOFQ9p3t3MOu
         8tMA==
X-Forwarded-Encrypted: i=1; AJvYcCWt0eaNXr/AIVFcVB/OL8J3XpHqfZujNdKYWsAATzrQFs9SYg85Tm7gAPe8gyvOXvJdysJQH6IDNsnBCX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YydRAj3DMsCbOcxXX3MWnu8ATlh+rP70xcSwf9tao+ZaDNm2SqD
	WPwo9sv97SabSP4ihIeOCRL3bIc5I8OeCPJDl+KqvROxXlUUaIi5Zt77jsiWWDgbQDTEurWaCh0
	IBHxd47PZYTPz6gMUHU2gJa7Vp7s/IZ9lsVL4v8eaITqeb14NSuaaB9BSb9izA2WhAtZ3oE0n1N
	c=
X-Gm-Gg: ASbGncvV5S+f5MoPAWM0xlI4sSH7KaJvQ/MQw2/Tm9FXHYIX/NyI3V1zEDKJ6PXGnja
	D3RMO4+wCGSp/KWhnzBYeFhlkfiBVLZmgbOmgjs9sieGZAmH0QOxmxoQQ2HVbN8kWdFFKOaezea
	OHN/zGV9GqEpMRjLRz2mUJvWL0/TeccY/dXgUbuqSRcasp+gVaPutXwbgsl7Lyp8I7yMchfVu56
	FY0slIrkNZfWX/FYWEFI4MK1ywceFY51Kd2sgsSIGlMtDOZVHdNAqQ963P0k8E4sq1x/jhY9+he
	q1CFS+2NoVtOOZ8hGwF0A+NdUHZqsv/3ozxnt00DT/tZa5GOsOXq8F+37yW/xC3ooIk=
X-Received: by 2002:a05:6214:5185:b0:704:a757:979 with SMTP id 6a1803df08f44-707004aa0ffmr81875626d6.1.1753350872814;
        Thu, 24 Jul 2025 02:54:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0wcvFy3RX/SAF5EVqrfzAK6u3mdIncXaZCbiRJWRoP7EdfCWvSPBX3cKc1kjBtcKk9HMI2A==
X-Received: by 2002:a05:6214:5185:b0:704:a757:979 with SMTP id 6a1803df08f44-707004aa0ffmr81875236d6.1.1753350872189;
        Thu, 24 Jul 2025 02:54:32 -0700 (PDT)
Received: from [192.168.68.118] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b76fcb8205sm1638486f8f.55.2025.07.24.02.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 02:54:31 -0700 (PDT)
Message-ID: <0a1b44b4-fc3a-4ffe-ae1e-0b39a6f66d4f@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 10:54:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/23] arm64: dts: qcom: sm8650: use dedicated audioreach
 dtsi
To: Neil Armstrong <neil.armstrong@linaro.org>, andersson@kernel.org,
        konradybcio@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250723222737.35561-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250723222737.35561-4-srinivas.kandagatla@oss.qualcomm.com>
 <93d80822-afa0-4bff-9e73-3ece36e8c23a@linaro.org>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <93d80822-afa0-4bff-9e73-3ece36e8c23a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA3MyBTYWx0ZWRfX82fdoUnACulb
 uOfGjDcvragmek9Dptequ8DED8LjZ2tKPnX4vGfjVyY+iKfkyAWePeel+KE1cUH3kvqFXYULtZs
 5QRurXkmDBtoiCYAxYn3XO1a3QZGD5J1fes8jHeizb6uQt9Zpc9ipXuhaZzFjjk0WKEgtHWak2o
 j3c5usfEZrMcgY2vaiDqgl9t1dHfgU+3TJU1VNxREpsJXPK3ppWFEHE9bW07IeNqDJNmAN1WrGS
 pZoXoezK5hAR2eHIZtWjJdYHeklbETjJ2acYCEuGsMI7RKpdAIdcR2iryyH5kQbLUZJ8s2ih9iL
 Z5M21fo7yn9P5E0YlsY2jEGxVASoFf9oGjtCHEz6aFcOWNIOcqU3Qo5zBmluzUK0P5gbsYx7bs8
 bBrqRcJK2lhXG2X4N/Bh0BFkvaxWvllAmKZ69NwjKpi3nlc3V9ZaemenBXLDvBUBaKxyFziZ
X-Proofpoint-ORIG-GUID: p7K16k2hPSvmugvbgwSC_WAwRVIf-w_X
X-Proofpoint-GUID: p7K16k2hPSvmugvbgwSC_WAwRVIf-w_X
X-Authority-Analysis: v=2.4 cv=IrMecK/g c=1 sm=1 tr=0 ts=688202d9 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=STcPxrrilPF-DVHAOgQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=615 phishscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240073

On 7/24/25 9:26 AM, neil.armstrong@linaro.org wrote:
> On 24/07/2025 00:27, srinivas.kandagatla@oss.qualcomm.com wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>>
>> Make use of audioreach-audio.dtsi and remove the gpr nodes from SoC dtsi.
>> This move removes duplication.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8650-audio.dtsi | 10 +++++
>>   arch/arm64/boot/dts/qcom/sm8650-hdk.dts    |  1 +
>>   arch/arm64/boot/dts/qcom/sm8650-mtp.dts    |  1 +
>>   arch/arm64/boot/dts/qcom/sm8650-qrd.dts    |  1 +
>>   arch/arm64/boot/dts/qcom/sm8650.dtsi       | 43 ++--------------------
>>   5 files changed, 16 insertions(+), 40 deletions(-)
>>   create mode 100644 arch/arm64/boot/dts/qcom/sm8650-audio.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8650-audio.dtsi b/arch/arm64/
>> boot/dts/qcom/sm8650-audio.dtsi
>> new file mode 100644
>> index 000000000000..14ae50e72e4b
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sm8650-audio.dtsi
>> @@ -0,0 +1,10 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights
>> reserved.
>> + */
>> +#include "audioreach-audio.dtsi"
>> +
>> +&q6apmdai{
>> +    iommus = <&apps_smmu 0x1001 0x80>,
>> +         <&apps_smmu 0x1061 0x0>;
> 
> As patch 1 comment, I'm not fan either of this intermediate dtsi, or
> perhaps there's
> some bigger plans for those files ?

Thanks Neil,

It more of duplicating the same thing over and over and i expect them to
consistent across all the SoCs, however its not the case, some of stuff
that needs to be in board level dts is now added into SoC level dtsi..

Moving to intermediate dtsi could avoid things like this.

> 
> Anyway per-se, it's not necessary and it should be in the SoC dtsi.
Will give that a go with some inline include in SoC dtsi.

> 
> Thanks,
> Neil
> 
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts b/arch/arm64/
>> boot/dts/qcom/sm8650-hdk.dts
>> index 259649d7dcd7..94fa52437d79 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
>> @@ -8,6 +8,7 @@
>>   #include <dt-bindings/leds/common.h>
>>   #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>   #include "sm8650.dtsi"
>> +#include "sm8650-audio.dtsi"
>>   #include "pm8010.dtsi"
>>   #include "pm8550.dtsi"
>>   #include "pm8550b.dtsi"
>> diff --git a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts b/arch/arm64/
>> boot/dts/qcom/sm8650-mtp.dts
>> index 8a957adbfb38..07e62918422e 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
>> @@ -7,6 +7,7 @@
>>     #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>   #include "sm8650.dtsi"
>> +#include "sm8650-audio.dtsi"
>>   #include "pm8010.dtsi"
>>   #include "pm8550.dtsi"
>>   #include "pm8550b.dtsi"
>> diff --git a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts b/arch/arm64/
>> boot/dts/qcom/sm8650-qrd.dts
>> index 7552d5d3fb40..7f26095e6f07 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
>> @@ -8,6 +8,7 @@
>>   #include <dt-bindings/leds/common.h>
>>   #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>   #include "sm8650.dtsi"
>> +#include "sm8650-audio.dtsi"
>>   #include "pm8010.dtsi"
>>   #include "pm8550.dtsi"
>>   #include "pm8550b.dtsi"
>> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/
>> dts/qcom/sm8650.dtsi
>> index e14d3d778b71..5212000bf34c 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
>> @@ -23,7 +23,6 @@
>>   #include <dt-bindings/power/qcom,rpmhpd.h>
>>   #include <dt-bindings/power/qcom-rpmpd.h>
>>   #include <dt-bindings/reset/qcom,sm8650-gpucc.h>
>> -#include <dt-bindings/soc/qcom,gpr.h>
>>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>>   #include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
>>   #include <dt-bindings/thermal/thermal.h>
>> @@ -4447,6 +4446,9 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
>>                     label = "lpass";
>>   +                gpr: gpr {
>> +                };
>> +
>>                   fastrpc {
>>                       compatible = "qcom,fastrpc";
>>   @@ -4506,45 +4508,6 @@ compute-cb@7 {
>>                       };
>>                   };
>>   -                gpr {
>> -                    compatible = "qcom,gpr";
>> -                    qcom,glink-channels = "adsp_apps";
>> -                    qcom,domain = <GPR_DOMAIN_ID_ADSP>;
>> -                    qcom,intents = <512 20>;
>> -                    #address-cells = <1>;
>> -                    #size-cells = <0>;
>> -
>> -                    q6apm: service@1 {
>> -                        compatible = "qcom,q6apm";
>> -                        reg = <GPR_APM_MODULE_IID>;
>> -                        #sound-dai-cells = <0>;
>> -                        qcom,protection-domain = "avs/audio",
>> -                                     "msm/adsp/audio_pd";
>> -
>> -                        q6apmbedai: bedais {
>> -                            compatible = "qcom,q6apm-lpass-dais";
>> -                            #sound-dai-cells = <1>;
>> -                        };
>> -
>> -                        q6apmdai: dais {
>> -                            compatible = "qcom,q6apm-dais";
>> -                            iommus = <&apps_smmu 0x1001 0x80>,
>> -                                 <&apps_smmu 0x1061 0x0>;
>> -                        };
>> -                    };
>> -
>> -                    q6prm: service@2 {
>> -                        compatible = "qcom,q6prm";
>> -                        reg = <GPR_PRM_MODULE_IID>;
>> -                        qcom,protection-domain = "avs/audio",
>> -                                     "msm/adsp/audio_pd";
>> -
>> -                        q6prmcc: clock-controller {
>> -                            compatible = "qcom,q6prm-lpass-clocks";
>> -                            #clock-cells = <2>;
>> -                        };
>> -                    };
>> -                };
>>               };
>>           };
>>   
> 


