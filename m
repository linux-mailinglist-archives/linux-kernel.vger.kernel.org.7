Return-Path: <linux-kernel+bounces-806277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 762D0B49481
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5400F1BC1506
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0248231158E;
	Mon,  8 Sep 2025 15:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U97Th268"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B555131158D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346963; cv=none; b=LMUGayMJ9AphtNzPAqXSJNQm7HdEE4SWT7Nd/8tB0uK4DqdJrKwKrD63USRTeNVBe1o2HvPILAw/GiUCq/vQbsK7e5Lokdb+TI5in5FCQ34Bo2RUd5/u9hIQeruesnz+q8p8lAIt5tVn/hNzev4IvtwEj117/HN5If04469cO1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346963; c=relaxed/simple;
	bh=KAC3wN1aJK43E+9u9yRPapQ08U4z5xBJ5LwIPKP+JAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r1cQju6OETE7prJHUoUM+GY5j036YI5gs+dIQyxMou7pyjUg8NY27lTx2xOrydGumT+EeEDZBuJIgkHaO5SUus+8gFBIzZJsYgu/3v9gpbP8FYcrNWixRyhvnr7nreaDsrXwME4DtTHlLja3NRqrsO8WZDifiEQhuR9y+jLLtts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U97Th268; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5888votT009866
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 15:56:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2xaA2EzI7/V6N3p3V/3RVjm7H6QsTCKQ0e8YQDvM8Sk=; b=U97Th268gp41E2h7
	/woc3CRWfZfL6VAWfnAUpxGirfUDSm28ol7dYOZQghd8IjyDO2BpK9QYsvD05Tp2
	qSHbDzYzK6URki9H+SpQ/duaklPkbwwEXDw3K+DDfxn7ru1guHiFS0JTdMtynkS/
	7CFkoyRGNXv9l7XKLIxJmok2cLkTqkLp44tQA4yhbN3zx1+M18AUbGfncUojLzDe
	2PiH1HWxqznrelpKdtgcoxnNWxLxxHsUwle+M5OKyZtR5HpTDAE6heo8sFVvze2w
	PJzfFSIgiu08PHD+8OPJCAl1H9Wi2MYF5Spx6j+4pSgWsxpBLQZ6+LnPFOQEsnl7
	0apnTw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490c9j57ry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 15:56:00 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b6027bf032so7592511cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757346958; x=1757951758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2xaA2EzI7/V6N3p3V/3RVjm7H6QsTCKQ0e8YQDvM8Sk=;
        b=mHfbzTC+RhhwO+soF8n+tWabhW5BgsE9DxWFdJ2zCLU8QGgo+LJccKNB5Fas4J8NXW
         wF4IGqoO03mQJ+M6eHOrquxE7i1ytMSFdigXD/45fS45uVp1V4ZimbLZMW793ijeNuIH
         +UsITgrGL0QHNzQJ8GLpoNP7oR/Lzu1gt4Wk0pPZ2bwbeCfj8LeiOk3RDveU28z3j0WE
         eT2FTBQx4SFwOVOTp+Zh//PDLiWI91gC0Sg+QG07eqzD8UIVwTr/S2MHuHRS6PgGzXMd
         dblMr3C0ayRxAjHbm4X/0NgxT3pK00eV/9eEr6t5Mi+rrXrbPQH9EE4d/8P5jvbr2bEf
         j6IQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWHjJSLyY4nDNEGl/HOkt09J3w9WAF2TnYRK+hRJxyFjaZLLrpY5graEBpw4hFZ4awjx6jrNkjKPgvq3g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsc/nNrzfGsZzyHrRiN3dhzfL47zyrxJkepCdQ4oIndv7zgZy+
	UkXRBwLPoeD6dG5+kTtLZYXHcTgWBrywigFKxodsHyLsEjZj85QgAzvpNyMF0UoTFx6aKoK9aOk
	E7pN3B3RvegwVMNxayYkOf3cdXBBfhPBOXIJ/lli4BB18J/kjlD82awCImsGsVeibfms=
X-Gm-Gg: ASbGnctbepsohTw6sv9cYxf9k7X+OU9T3DI0RZHe3zDtXnGd3hpOd/MIpegRrKiZD6w
	O4mRo6TUDvoX+zJSJeLjW/Qbay9AVnlj+0muE3NeLbIQUhbweb4ij4xB1vJ5OwYWmCh2MVaNmRX
	RxUNHQ1TgOI4L0pmQigaQB+jCxVQVNffN+LOnehojA4WHOMdpF1KDkgIQdoZQjf7CabJGKPD7B0
	gi8ScBf+vrQ2KrzL6yrwjq85WRn1h0V2hu1C5TX8ASCxak1lhCcDEmahbG7byVH17fe8DG5shQG
	xA18X+uCoD/KqSmbpwTQPLfec89GmoQtHQJhCcwhHO6FYA5rA8yXsapRpvd1q7gURasapy7wLK9
	TSHtDprD3cyQumqwpSr8LHg==
X-Received: by 2002:a05:622a:350:b0:4b5:eb40:b1c4 with SMTP id d75a77b69052e-4b5f842e182mr68367821cf.10.1757346958218;
        Mon, 08 Sep 2025 08:55:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+m3DUDT2VOeoBUBd/sfW/1V6KtiWmR40kAcM7D0XaeflwxuM4VlQhxuoiXlAywg4NPIPM7g==
X-Received: by 2002:a05:622a:350:b0:4b5:eb40:b1c4 with SMTP id d75a77b69052e-4b5f842e182mr68367571cf.10.1757346957675;
        Mon, 08 Sep 2025 08:55:57 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b040a410817sm2197805766b.101.2025.09.08.08.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 08:55:57 -0700 (PDT)
Message-ID: <5bbe50f6-5fa3-4685-8f2c-67986c5171ab@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 17:55:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] arm64: dts: qcom: monaco-evk: Add sound card
To: Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Umang Chheda <umang.chheda@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250905192350.1223812-1-umang.chheda@oss.qualcomm.com>
 <20250905192350.1223812-5-umang.chheda@oss.qualcomm.com>
 <7bzlof2wyqqorhh4xck46wd43zlehm4vhej2oaxajo4dxn5p7p@oc3vikzxcwke>
 <nphea3rtl3z2tgpyn4g4hf7ticbg4kyhgv4ht25etfxspsgkv6@dm67wp7x4mdt>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <nphea3rtl3z2tgpyn4g4hf7ticbg4kyhgv4ht25etfxspsgkv6@dm67wp7x4mdt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMiBTYWx0ZWRfX3TjOhdFc2h74
 kT0/A3yWV2ElygJ2PSkoGaBnB1pIT3yajBR6WNOYIl5Pyo9QdUs00OmJ6S/4ZlBDALOvO7lJJBb
 5neRrxeA8tKNHgWsPIr88q7gZlDilcT40xYGtd7VBHkAcyvOa2iBTBKWNvmHgXJMgH3CGYrsF+R
 +jCk2Eqj8ZpPCGSD9XG8Oo6Oh8MmvInWg8NffzmOA4WD5yxPErW+TFZApBAqWMN2GvD9d3ldGQB
 VR+9Ep5j1sASufOfRHuqm1g3aOGssgNLj8qdhFfiLs2DZoOwNGnFDsad/Iy2FnKczbbiDdTNqCc
 tFBvv6jFURRgEQyeVX72sr5zKwctaRu3JWkas3WC545GaAQqEBn9Nh2pDEutfJrRamxirtyxsuA
 mjeRbXGW
X-Proofpoint-ORIG-GUID: wtLJB8pRsFYP2XRfGpUbRC89Wbfuzmw2
X-Authority-Analysis: v=2.4 cv=PpOTbxM3 c=1 sm=1 tr=0 ts=68befc90 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=MWXjAKqjvAffJSE-xswA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: wtLJB8pRsFYP2XRfGpUbRC89Wbfuzmw2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_05,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060022

On 9/8/25 4:55 PM, Bjorn Andersson wrote:
> On Sat, Sep 06, 2025 at 10:26:23PM +0300, Dmitry Baryshkov wrote:
>> On Sat, Sep 06, 2025 at 12:53:50AM +0530, Umang Chheda wrote:
>>> From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
>>>
>>> Add the sound card for monaco-evk board and verified playback
>>> functionality using the max98357a I2S speaker amplifier and I2S
>>> microphones. The max98357a speaker amplifier is connected via
>>> High-Speed MI2S HS0 interface, while the microphones utilize the
>>> Secondary MI2S interface and also enable required pin controller
>>> gpios for audio.
>>>
>>> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
>>> Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/monaco-evk.dts | 52 +++++++++++++++++++++++++
>>>  arch/arm64/boot/dts/qcom/qcs8300.dtsi   | 37 ++++++++++++++++++
>>>  2 files changed, 89 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/monaco-evk.dts b/arch/arm64/boot/dts/qcom/monaco-evk.dts
>>> index 93e9e5322a39..f3c5d363921e 100644
>>> --- a/arch/arm64/boot/dts/qcom/monaco-evk.dts
>>> +++ b/arch/arm64/boot/dts/qcom/monaco-evk.dts
>>> @@ -6,6 +6,7 @@
>>>  /dts-v1/;
>>>
>>>  #include <dt-bindings/gpio/gpio.h>
>>> +#include <dt-bindings/sound/qcom,q6afe.h>
>>>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>>
>>>  #include "qcs8300.dtsi"
>>> @@ -24,6 +25,57 @@ aliases {
>>>  	chosen {
>>>  		stdout-path = "serial0:115200n8";
>>>  	};
>>> +
>>> +	dmic: audio-codec-0 {
>>> +		compatible = "dmic-codec";
>>> +		#sound-dai-cells = <0>;
>>> +		num-channels = <1>;
>>> +	};
>>> +
>>> +	max98357a: audio-codec-1 {
>>> +		compatible = "maxim,max98357a";
>>> +		#sound-dai-cells = <0>;
>>> +	};
>>> +
>>> +	sound {
>>> +		compatible = "qcom,qcs8275-sndcard";
>>
>> qcs8300
>>
> 
> If the Monaco EVK actually is QCS8300... But, I presume qcs8275 and
> qcs8300 are identical when it comes to sound?
> 
> @Mohammad, if this is the case can't we just support the
> qcom,monaco-sndcard instead to avoid this confusion?

Commit 34d340d48e59 ("ASoC: qcom: sc8280xp: Add support for QCS8275")

Unless we choose to ignore that compatible and add "monaco", but I don't
think dt maintainers will love that

Konrad

