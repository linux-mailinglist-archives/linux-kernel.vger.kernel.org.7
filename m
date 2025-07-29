Return-Path: <linux-kernel+bounces-748918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB462B14796
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 07:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D558A189E4E2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 05:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081F6234984;
	Tue, 29 Jul 2025 05:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e+aJXax7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29B52AE90
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 05:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753767156; cv=none; b=Xaqz+TmuLhZXyllRCpN6d4G6ph8TZGMvZd6YtKO6bH5NyiGXZtqPh3JwL6xKdIKiBzRdMqkSeCeyKZT5DrhnKDTlmUl06yLmBM8y1FY0tvsIVvDMo2ouzBvScgnNycTWYZun5/kjdRtjTKE8vj7UD9Z99sg4IAHNq/u8LuHeGag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753767156; c=relaxed/simple;
	bh=nuMlNotkWbwaJdkiNuDkwLG9m0fVeiM/6XTgBomor9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QD1Hg6USDvB641Uui3vZgQ2AlSKageL8pzW9Q7zcRMqNRRNesR31s7PiWHnKFUWsK55nRI8iURj0qxJijodUigBQhOx1AzkVyXP+PFU7Ee/e/ZngzqbKPmVQqxWM5uMyPgKKrSMfLB0bicDTlaEShu2GJssg1+SIfbvfYUPfoD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e+aJXax7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SL1290012314
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 05:32:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8TQM0bLQT4y+lcUbM3B1dK2Ki/fMYU8F5ddDAixVjsc=; b=e+aJXax7rLwgWRzN
	zHvKL3inCRbYsevrhnI43gASHlW96+kGozu0ne3vPnWuEmgwXxe7PwZWD5CPw/t/
	HzLyttRlHe3F4SFE3CdDiaJChjX5bqXRisduB5fH7XrJgZmidFIZDJ43zh6IppBa
	L0IxdIQXCBp0Oxn4HbTsvvSQDN2b/l4nnoQElvIYdr191JwDUumQODqIK017I6hy
	+gbTG1VMH1iTobPFlClnxS53ZVqDFPoXCYY6K1II+EQIk9UoiE6jzTi7SeoTudyG
	99LrbIA8O5cCvIMQNlQVnRy6ZsWq4cCVudZFlv4T2h3pborD1uLU7OqzHqvNbKnn
	RHqLhg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484qsk6v4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 05:32:33 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2369dd58602so53863785ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 22:32:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753767153; x=1754371953;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8TQM0bLQT4y+lcUbM3B1dK2Ki/fMYU8F5ddDAixVjsc=;
        b=vm4g1GqKo5rS9+Nyo7kJKpTQOFxF3FnxjW0x/o/g2pucSiTEa2c+yJOsakupJjj1w/
         NSeXOtnB0/LyuJDU02i/9DRWG0RyrZZxjJAIXeqYZF9clbiJIjKDZugZVmSXXvMAMZp3
         rO7iBwm8/cef9wFmntQV1cvsuq22cc8cgzjjJaSCwfTG64FqB+Ds0JgGy4xsDJue1P8h
         YEXZOeh942HRup0wpXLiI3wWYrbbSz+YU1xuLFHArsHM7Fx0DVFlmsEKGHed40Yjbd9u
         UELYAbuoJzDko3PQwQUGp/IwnxRRkRiLqMxwJkGXAO4JoNF9B06lYWb2S/rUWw3tecaa
         Jg4w==
X-Forwarded-Encrypted: i=1; AJvYcCXh0Xr8pW59JFlKgf3tchJdgwHyVPo9J8VP1r6m6xE/TcrJ3tib21qq88UBaiP3kuEHivP4bGfAOwj2HbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHmRq/cjN0roTaDKHuqyGlybnbcKcLLVLqLF1aPr1QggOV1lXi
	qQJl0OFDfzlnncAqdr0dl9LWQOZ5/29rFCtHSQdo+7KUq08m5iLG8cYWBNc2pumzIQ+gJg97vHM
	IBPXn17u/WbK3/Q+Jhe2XjbnK7dxCEaPNSL1hCVHAl+Zte1LOMRnqyWkVdW1vch4Zins=
X-Gm-Gg: ASbGncuXlc1Z/0UVTrKuGsDolMDSLtKDWmCiLoeFYTTSa7Ahz29ZLH/pWYjwys5Qs5m
	smvOopMc/q5bCgbYYrwbEdYQ1nnudRCoGnUZ7rh0EfGY2CqJ0vvIP9MTUoONDYLmxFSKbEu9B1i
	acdIYrVVtZktocE3XeYYqMutlP3DDR0KJGao86m2iLvdpZvPcuf0zTLkN2MWkZivig6zHltDb3L
	iFj6e2ushV4NBFJCOp3bT1mxdRZ0ecUD/OZclRJExn4j9720hN0gQQ+wY2xy6+2OjAgYdOeSZk/
	9L+XC2MGh5VZo+5t4CpnrjQAwmN4aBqYq0u4QNtg9I24I340CQ/T/aM4mSHHhhnBdkpo1szDT7b
	o7w==
X-Received: by 2002:a17:903:1105:b0:235:7c6:ebdb with SMTP id d9443c01a7336-23fb307acd2mr217929595ad.10.1753767152690;
        Mon, 28 Jul 2025 22:32:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzMEYvT4QnWI434D6bbEM0kf3Z29Y5c75ODQRyFfOAHIRi23LKLWWLZmICAFHxXw4XEgMbSg==
X-Received: by 2002:a17:903:1105:b0:235:7c6:ebdb with SMTP id d9443c01a7336-23fb307acd2mr217929175ad.10.1753767152226;
        Mon, 28 Jul 2025 22:32:32 -0700 (PDT)
Received: from [10.218.21.68] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-240765051e6sm3120425ad.82.2025.07.28.22.32.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 22:32:31 -0700 (PDT)
Message-ID: <cd4f5dfc-095c-495f-ae4f-782646d6c601@oss.qualcomm.com>
Date: Tue, 29 Jul 2025 11:02:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: qcs9075-evk: Add sound card
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_pkumpatl@quicinc.com,
        kernel@oss.qualcomm.com
References: <20250724155632.236675-1-mohammad.rafi.shaik@oss.qualcomm.com>
 <20250724155632.236675-3-mohammad.rafi.shaik@oss.qualcomm.com>
 <452c6a6a-3d65-4712-a105-386d8540f2ff@oss.qualcomm.com>
Content-Language: en-US
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
In-Reply-To: <452c6a6a-3d65-4712-a105-386d8540f2ff@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KdDSsRYD c=1 sm=1 tr=0 ts=68885cf1 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=NuTrWsM2-O6NPpDJVOsA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: Zci3DYxnn0rNzY3kojYIPcxrP_Mkt1Qy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDAzOSBTYWx0ZWRfX6oC+NSUGHYzj
 4+p+bUMCuRY4d0Gz5tfLDKEft6us90YD9U4MV+iGlFy79y+5+6hMthHjloqrfk3JhVbIdh2GbX8
 rfieJTjijGOS+xlTWuLoEdvhV7VfGN8bzekpplVKMgQ9BAzdX1RhNDKUri5Y+EYTf0l/B6cQN0X
 ACD8Og0EyIoHdhc9DKGYDKz/RXeiKx0ODKm3+k9/bnhZEH9iNANb465PS/+1HIEkTUIooZGwgtY
 EMrBAymprNmLbYaBuhg9gptQs8chCnaTa+OjjFzo3QCyXlCjHD/mfvzn9rScyu/05hN/X3WNzrG
 2Zxxegrmk/s7fJ8UbgyHqbdXVRNkLiN6a02gBFu2avIp1yj160e2QuOPZUjThEW2AuxlIjEcV0k
 Cwi0e6z0pI5yjdzFp5YQfS52Sp7vBorrYp9fMTMgtnuBME+1Ayhn6nmSig/5f15V6wJd+/Xn
X-Proofpoint-ORIG-GUID: Zci3DYxnn0rNzY3kojYIPcxrP_Mkt1Qy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_01,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 mlxscore=0 spamscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507290039



On 7/25/2025 2:47 PM, Konrad Dybcio wrote:
> On 7/24/25 5:56 PM, Mohammad Rafi Shaik wrote:
>> Add the sound card node with tested playback over max98357a
>> I2S speakers amplifier and I2S mic.
>>
>> Introduce HS (High-Speed) MI2S pin control support.
>> The I2S max98357a speaker amplifier is connected via HS0 and I2S
>> microphones utilize the HS2 interface.
>>
>> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
>> ---
>>   .../boot/dts/qcom/qcs9075-iq-9075-evk.dts     | 52 +++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 14 +++++
>>   2 files changed, 66 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qcs9075-iq-9075-evk.dts b/arch/arm64/boot/dts/qcom/qcs9075-iq-9075-evk.dts
>> index ba8a359d8fee..a2d9aaa641a1 100644
>> --- a/arch/arm64/boot/dts/qcom/qcs9075-iq-9075-evk.dts
>> +++ b/arch/arm64/boot/dts/qcom/qcs9075-iq-9075-evk.dts
>> @@ -5,6 +5,7 @@
>>   /dts-v1/;
>>   
>>   #include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/sound/qcom,q6afe.h>
>>   #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>   
>>   #include "qcs9075-som.dtsi"
>> @@ -20,6 +21,57 @@ aliases {
>>   	chosen {
>>   		stdout-path = "serial0:115200n8";
>>   	};
>> +
>> +	dmic: audio-codec-1 {
>> +		compatible = "dmic-codec";
>> +		#sound-dai-cells = <0>;
>> +		num-channels = <1>;
>> +	};
>> +
>> +	max98357a: audio-codec-0 {
> 
> It would make more sense if audio-codec-0 came before audio-codec-1
> 
Ack,

will update in next version.

Thanks & Regards,
Rafi.
> Konrad


