Return-Path: <linux-kernel+bounces-870804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A788C0BBAB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 04:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78F314E2561
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 03:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF7C2D4B5F;
	Mon, 27 Oct 2025 03:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FIeBylaI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9DA1BC58
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 03:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761535070; cv=none; b=Rn5Wh1FidAzhAQJWmkJl4lRLpJUja3QJAoltyewU0Hxhik7KlpXadRH3kQc8wcectaFiDWS+nYrByOhNQoihZG75BZSiKin1NQ39Cd/IRo8yXz8g1pPuODiooNoPnaSgbvTbBp1Iw6p0VJxOXMxHwXxOR3UodlYBa2oCV6P1D7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761535070; c=relaxed/simple;
	bh=RcNsLrNqaDct2SLCTPZbtlt/bTq7zf5bG55Uf5Vb1Pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s5odwDf8nPUTW4ljsCKw2X7XCww2u9okXKvN7DN/v/+VpXol7qkBJQDhvWgyS8WbxI9Wfy6qipGh/oddFkxvYHbW+ZdkOG9Ii39lvEFOGhHYqc/uDNleO86a6836G2elBdkFGhfyAsSMwSfBEGzSJ1c5QLgNt6ycwVQxkHiNr60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FIeBylaI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59QMlNDE1056755
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 03:17:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JO7Tw88if2zflMQMKJ+hg7JVLU1fFgiOs9+KVopxqFo=; b=FIeBylaItpydTNIx
	QA1UPRy+AP4sq/84YQlWUl96i3c4j+daupyZyEWWxKAyEkJU9O7sZgs3Ef4uHtc+
	Lor/0MDCS44o3oL3lZ9tyVQXmY69TRZ3X8v6q+Z3d/J/QHlIzG+yoLHo9p11OrOn
	I7zQUHdTwipfOaAk1BhtDMBjqwQFYqHpQZMl6fy8KFYSIsYFwYQSvz47DSkCG7Dd
	05/QkjsDdcj3WJatOBxH17iCElpKy0rP082NvxQ1yLZEuZ9gmpAh9OPCZHJuK6rQ
	KEgYf8bYyvyF0Wff42cusZXD0sX99/sMcaZtxf/8YxRNSR9mShGAB0fuzN2BxCjq
	CBuQpw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0nkak3v5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 03:17:47 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-290bd7c835dso39436135ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 20:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761535066; x=1762139866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JO7Tw88if2zflMQMKJ+hg7JVLU1fFgiOs9+KVopxqFo=;
        b=WVWe6S0qum5E2g3ROebL6FrI8kxzeKM9S1plJIjS5HX3atXR5/hqbnBl6ddk2USXXp
         FGe4HD/jdADiTlezOzG57fXjCgiLqpmjN86j3tMqgV+X+vKKH9lIqVST2h4UzgpRmjB/
         wV53nMCFx9fqHn/v2zbGrCzNmGusI/Vnloo/RoaW4hc3B+EBFsure1VQkpMlKokPRtM6
         aRqdGYFU4E3eguuwW7mIfu+U5p9SqwkWY/8CNrMZ+BgH6010u4JPQaXl8Mo7FSzlGs+B
         gkDeJiymGrFQOpPTbO/NeCs4PCbTTHaRmAbTdgGupf5+4PKKEI3OzKiQtPcc6CllJkhc
         jkxw==
X-Forwarded-Encrypted: i=1; AJvYcCXJbO+1wYmlMsDS5F6jKFpo0nWKlPnWgyOKK8ahm7A+OuhJqJiSIXYxUTI7DAQOkhHnuwHH1YA8T9W9qVk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx86Am2pIK7iQAeOzxQMsetxIeRznDgWCI+FfXIY49Jx6GeUIYk
	PtwyoGInDwyAVydeS8x3s3/bO4kmzuVfwyL9oC6z1xTrM05rBaxE1Ckh3ec3Xk1tDxrI+aeJyxN
	wxH7r3dWhyLaqLmYQ4bUrpMlvTu6XCgaIhYDzy+aEPk1Pd4kUQQwRidE3Zgi9C9fqDbI=
X-Gm-Gg: ASbGncsziShfdS4Yq79RcnN86xvojka3rTHwSSSyTR9x5dQN9tI8RUGW4vifAC/KyKx
	A2BeW+6YCx2a2DscBfp6KbbymBdCgTadxtq4CeQvjH439ZVgVbXCZf1z7ju1np413txjWcmdsfC
	Y0dAIAIF8odr20wWkFmzOnVs9QDojMDua5YjFbEg4qtEVS6ITlyRp+cI31PyHuEoWzmZdfUYQvq
	PM8NG30pM5kuBrxn6lAYjNAo8Wma5tsJ8tHEcc6CIdz52sAdC+kmd1D+Mko2xZ0RQqnp3SvdScC
	bLzrSs9G5Xls0rX1x4RwmM9FOeShCy0htjsnqA3O5buGCzDZnTVP9dgZQOFRikip4EEZyiuqNnc
	t7QKgGqboViYUK9Hc9s3xnzqlkp/DYCZRXtpczNBZ7xcHMYIhug==
X-Received: by 2002:a17:903:4b07:b0:288:5d07:8a8f with SMTP id d9443c01a7336-290c9cd4b60mr387050685ad.24.1761535066347;
        Sun, 26 Oct 2025 20:17:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWC4qQG9kVvhlPmWIkq/0n4oOKkhrgreGs8rf9+HeLIiS71LPMdzaS/kJ8l61Kckt2fliuyw==
X-Received: by 2002:a17:903:4b07:b0:288:5d07:8a8f with SMTP id d9443c01a7336-290c9cd4b60mr387050335ad.24.1761535065743;
        Sun, 26 Oct 2025 20:17:45 -0700 (PDT)
Received: from [10.133.33.226] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d274aasm63274935ad.56.2025.10.26.20.17.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 20:17:45 -0700 (PDT)
Message-ID: <e19e3ff4-bee0-4c40-bb6d-76d25e324024@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 11:17:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] arm64: dts: qcom: sm6150: Add gpr node
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com
References: <20251024023720.3928547-1-le.qi@oss.qualcomm.com>
 <20251024023720.3928547-2-le.qi@oss.qualcomm.com>
 <cc7399ed-db57-42cf-a944-6213a8df8491@oss.qualcomm.com>
Content-Language: en-US
From: Le Qi <le.qi@oss.qualcomm.com>
In-Reply-To: <cc7399ed-db57-42cf-a944-6213a8df8491@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AYW83nXG c=1 sm=1 tr=0 ts=68fee45b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=lSFguUpnHfwc5t4ioxcA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: PFYEfV3JTqBtLy_BfjalrH_Q8X66dDzO
X-Proofpoint-GUID: PFYEfV3JTqBtLy_BfjalrH_Q8X66dDzO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDAyOCBTYWx0ZWRfX14GY03eiji7Y
 AxHIhnLbra/05tJeA4dDokIvcjNs9iT8sr1gRWyr9yOUKffkLj4rSHL7pEGd3n3NVJT4JnMN802
 60y73MKn6+t1DNmC9ProXzY8hWaN5j/M2xzl/qLWywWDSGir5qCeARquKmeJenqwHgSB6ptu8Zc
 NSETAAdCD1qTDLgl3qW37E3urGFXgBWhn/vaep7B6nDC1gvQEqrv+nZAxqiaF1vd1YOQM0/zD9i
 CdeSGkJ/bfQR1Q9gHUmn2RYPaKo12b1PK5P32DiYGa0iQW5+2CYVZA7wvD2uC74Nm+JnWUFHzxA
 Xk1PdIQqXcyZOOtMnG6Mbvt5a2QrzWB0DwLlEEgD2uc/5jlUNJqidPzE6ACzNoq9FPmCHDSBB2F
 6eR3ccjGfhqUyC4hMNmejVw0KFCguA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270028

On 10/24/2025 4:13 PM, Konrad Dybcio wrote:
> On 10/24/25 4:37 AM, Le Qi wrote:
>> Add GPR(Generic Pack router) node along with
>> APM(Audio Process Manager) and PRM(Proxy resource
>> Manager) audio services.
> 
> This is a really weird
> way of breaking your message that makes
> it difficult to read
> 
> (stick to something more like 72 characters, please)

Thanks, will modify this in next patch.

> 
>>
>> Signed-off-by: Le Qi <le.qi@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm6150.dtsi | 36 ++++++++++++++++++++++++++++
>>   1 file changed, 36 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm6150.dtsi b/arch/arm64/boot/dts/qcom/sm6150.dtsi
>> index 3d2a1cb02b62..ec244c47983e 100644
>> --- a/arch/arm64/boot/dts/qcom/sm6150.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm6150.dtsi
>> @@ -16,6 +16,7 @@
>>   #include <dt-bindings/power/qcom-rpmpd.h>
>>   #include <dt-bindings/power/qcom,rpmhpd.h>
>>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>> +#include <dt-bindings/soc/qcom,gpr.h>
>>   
>>   / {
>>   	interrupt-parent = <&intc>;
>> @@ -4246,6 +4247,41 @@ compute-cb@6 {
>>   						dma-coherent;
>>   					};
>>   				};
>> +
>> +				gpr: gpr {
>> +					compatible = "qcom,gpr";
>> +					qcom,glink-channels = "adsp_apps";
>> +					qcom,domain = <GPR_DOMAIN_ID_ADSP>;
>> +					qcom,intents = <512 20>;
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>> +
>> +					q6apm: service@1 {
>> +						compatible = "qcom,q6apm";
>> +						reg = <GPR_APM_MODULE_IID>;
>> +						#sound-dai-cells = <0>;
>> +
>> +						q6apmbedai: bedais {
>> +							compatible = "qcom,q6apm-lpass-dais";
>> +							#sound-dai-cells = <1>;
>> +						};
>> +
>> +						q6apmdai: dais {
>> +							compatible = "qcom,q6apm-dais";
>> +							iommus = <&apps_smmu 0x1721 0x0>;
> 
> I see that the documentation mentions a mask of 0x0 (like you did
> here), but downstream does something funny here:
> 
> iommus = <&apps_smmu 0x1721 0x0>;
> qcom,smmu-sid-mask = /bits/ 64 <0xf>;
> 
> with the latter value being consumed by the driver manually and when
> it binds some sort of DMA_BUFs, the effective SID (ID & mask -- notice
> there's no bitflipping of the mask part here unlike in the SMMU driver)
> is prepended to the address:
> 
> smmu->pa |= ((sid & mask) << 32);
> 
> We can then check that the SMMU driver reads the SMR mask as a 16b field,
> meaning the result is (sid & 0xffff) and not (sid & 0xf)..
> 
> If we take the hardcoded-downstream mask and compare it with the HSR,
> we can notice that all the streams in the 0x172X range correspond to
> LPASS_ADSP, so perhaps it's a design choice that the DSP end only cares
> about the least significant digit
> 
> TLDR this seems to be all OK
> 
> Konrad

Thank you so much for the detailed explanation.

-- 
Thx and BRs,
Le Qi

