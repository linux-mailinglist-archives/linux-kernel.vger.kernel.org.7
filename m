Return-Path: <linux-kernel+bounces-817971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90E8B58AC5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 03:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B42F2A6C59
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 01:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6867A1D31B9;
	Tue, 16 Sep 2025 01:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QgA42yIt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8E4E571
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 01:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984836; cv=none; b=BUfSQKfhA2zSgajJuO9Jyi4FhRHEBuRigszkd64u/THpWHWWMu/o/GUL3Q/aveaphFyHojmScRCyDAHJTc6+4cmPgU9DE4qepbtSPTRuZAy8aDiBfNDPnbfA1wbcIuhbVqglVx6oKmx8mpy1jI8rrPiZ6Fd1rO5dE8zqCC0SMpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984836; c=relaxed/simple;
	bh=Ej1M7Lb0ez3FYXyEYoQtM5ZlcsYy2QCsELs/7QLVuSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ClH+LOfvz60kXkWMuCNHYG4H6GqxbRYIkeAlxTTLHET6sllYFC3Xof7olPYVeSf/5ZQKpau6yQTe62WvYr7op0R4pflG5/eSBvu+MzElqJAwuONFtHGPKsmGgHen5m1NL+x+QIf6FOs5oVdiR5qLFGtejmxdlDIO/JNazY9wpBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QgA42yIt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FDofTE014084
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 01:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zJ7wAHnzIyQb7pFtsPfAGf8Lzws9Z/gnzK2Icghh4B0=; b=QgA42yIt0Q+xZPlg
	xHLcCpy18CiVmLxUDr1ZMXVCdinKaF0wzhjI8GhR/5t57/NWqu6VZsnMly5VJU0U
	BE98TlKC95mpD1+3Bymf3ImTrQ9OrIomkYsNqTBV5y5h4ykz9nKLywctnDvrDlCy
	Uba4Y5Hk6FU4G8cMWeHI8j/KWkXtkMLVYnp3jw+KIJEYJKiRlr0FB4RI1CCcdfjF
	bRszxtDsMTGRvJwHxOWjKKt76rKFwFn1F73RDrju8LSd76KujZve0pTjvEFm20Is
	u9IEUn0+U/E+iiMI4xtDLkZp/Ud0R+tTCehpo7s4T7dZg0ifQx1GcrQxPHfKHGNS
	8zAVKg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494wyr733k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 01:07:08 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7761c58f77fso2598027b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757984827; x=1758589627;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zJ7wAHnzIyQb7pFtsPfAGf8Lzws9Z/gnzK2Icghh4B0=;
        b=kPe9G1dwPC9wJQRFTwxU756r9yc/uXpVx4v1/YCr/0bQkQ+ZOge/9NP5p3VFdMPpJE
         qAJQWsa2aFJxHBVSsE+n1y8G/zqmG/lzoSHofkvab+8T1P62u8zKKFohPZWqNUB2Ysv0
         pna3m7z/wcvRnL/ObSK85cRJbUzi4xxKyasPRZYFpBUmftULYYXR5sRnVGshKmotX8Sm
         2rNDknblR1EaVgMPKcnWw0zm2195bcl7V2i6CFK56AEbFvsIgjDM3lMVVL202nr3wY8E
         Vn+UNSHuD1fiUnj7Nm6Y9EVYPvQa88HA898rgi3/nCk0bR8/fsv26mH08cZsGEvQKG2L
         ZrOA==
X-Forwarded-Encrypted: i=1; AJvYcCXTs616YZQLG5q6Pcanx10PoTkxGlrY8yxAxJGdj39Zs2CGA+Z6HDhjbca/Pn7NJu6md8OY77Cfh1cwLT4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+ByJTEfRq2vz1ehxhPi77HoUDZPYIfqCDigh6drI7yPpOUfPn
	o1RYt63pBQPbUrGyOrGHgPwHFJGAf3WVYEOPzWVqJ4HqiCdugOwbjhcRMGDEJilYJXeVLKn9LhL
	fS9WYPtUhok/CoJom7WgV18crBa6dqdBkviKaAZ+Xs6S4QcHOlaAzPZxXlzRELdOzlMQ=
X-Gm-Gg: ASbGncuZWCmwW0zAN7oY5O380RccpJXOi8kFJr9VYN1wVDfMN2NStAJOikYyjAuXGTn
	oKVHYingPMFCM7S2NYwfuYm1z9bW0sCr4zPGLX+bJgJWGvKQ/rcMKtQ6/YBjub9f33aPIeDHQFc
	6Trr4BpiXhVxHqn7SNr9DO7VyjFwJUaqDjDlhtnPtmU9tFUxQmCYdYPU30F5s/+3VGMhUJYhPEG
	bp+WbBTadpVByrleeQTZwbM/MYo4/424jm7b4YgxcxY1st8A0lFCcBA6xFFDqPD1W+Z2jcOS9sH
	l3Wl3olE5vQKenf6U8OqHCDMmnufaLZnOMHxkLqcBaQnFyWVZ4q4S3YVY8SEw7D9uAeboso036c
	vrRyXz0/czBXTJu3SSJgLHZyTEt4GYKieNg==
X-Received: by 2002:a05:6a00:140b:b0:772:4759:e45d with SMTP id d2e1a72fcca58-77612187dcdmr16870652b3a.22.1757984826792;
        Mon, 15 Sep 2025 18:07:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVs31FmEgidBmlFAP6xDrtJIzXrTQX01+uXUWk8n4bzgO78tNFCFr69YkqcNPr9LfNID+jJw==
X-Received: by 2002:a05:6a00:140b:b0:772:4759:e45d with SMTP id d2e1a72fcca58-77612187dcdmr16870617b3a.22.1757984826313;
        Mon, 15 Sep 2025 18:07:06 -0700 (PDT)
Received: from [10.133.33.244] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7762c225d2asm8516269b3a.65.2025.09.15.18.07.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 18:07:05 -0700 (PDT)
Message-ID: <aa2677a3-7d5f-4abc-9bb4-7db53b9b8a0f@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 09:06:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/4] arm64: dts: qcom: Add HAMOA-IOT-SOM platform
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250910-hamoa_initial-v11-0-38ed7f2015f7@oss.qualcomm.com>
 <20250910-hamoa_initial-v11-3-38ed7f2015f7@oss.qualcomm.com>
 <aMPee9wEOrrW-KMU@linaro.org>
 <90dcca12-1a68-4049-bcbe-c333aed07a07@oss.qualcomm.com>
 <aMfT1_uyZETUEBYk@linaro.org>
 <3b81ea60-553a-48d8-b6c7-6b55673fe04d@oss.qualcomm.com>
 <aMfiCry1NDdd9AnX@linaro.org>
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <aMfiCry1NDdd9AnX@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: HjCL02XOI9sK7Ra_fGiTBrE8QKW-g_jk
X-Authority-Analysis: v=2.4 cv=SouQ6OO0 c=1 sm=1 tr=0 ts=68c8b83c cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=BKvH8aPO6oRNhvS168oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAwMCBTYWx0ZWRfXx3c091n7rjeq
 UVddb9EGpdC+s1sOjebB8GtFlxzA7hFrfu6tsAOC/H+QIS6SBny3ZAYUY8snFZ28y4lC6PGOqrM
 mMiF/O8xVtCW3Cd5xqh0Ij8HLKXVrcxdnv7heoovEN9VOYsEvQoj3iK0Ov8m1Nq+ArrCXrGFEyJ
 vXZ6X58RhYeC85EEIXKPIhgZK5QKxK07mybnrsNPEpTDMEXw4ml3bxm58Inat2VkkcXYCVygv7H
 J9hiZ9pK5aQabppe6bXEGGRDr+HDwoc4PBLVjZE2nTakBmmE0tUJDQfBY5GkmvOn4MklS4gK3Fw
 qUAeQ4b0hCS+na9FfVysU1yAJUoUOvZzamWi/ggOfcl5b++GI299S/a2lersv05uj4Ej4pP4sUi
 t9ZJRF7i
X-Proofpoint-GUID: HjCL02XOI9sK7Ra_fGiTBrE8QKW-g_jk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_09,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130000



On 2025-09-15 17:53, Stephan Gerhold wrote:
> yOn Mon, Sep 15, 2025 at 05:46:09PM +0800, Yijie Yang wrote:
>>
>>
>> On 2025-09-15 16:52, Stephan Gerhold wrote:
>>> On Mon, Sep 15, 2025 at 10:12:15AM +0800, Yijie Yang wrote:
>>>>
>>>>
>>>> On 2025-09-12 16:48, Stephan Gerhold wrote:
>>>>> On Wed, Sep 10, 2025 at 05:02:11PM +0800, Yijie Yang wrote:
>>>>>> The HAMOA-IOT-SOM is a compact computing module that integrates a System
>>>>>> on Chip (SoC) — specifically the x1e80100 — along with essential
>>>>>> components optimized for IoT applications. It is designed to be mounted on
>>>>>> carrier boards, enabling the development of complete embedded systems.
>>>>>>
>>>>>> Make the following peripherals on the SOM enabled:
>>>>>> - Regulators on the SOM
>>>>>> - Reserved memory regions
>>>>>> - PCIe6a and its PHY
>>>>>> - PCIe4 and its PHY
>>>>>> - USB0 through USB6 and their PHYs
>>>>>> - ADSP, CDSP
>>>>>> - Graphic
>>>>>> - Video
>>>>>>
>>>>>> Written in collaboration with Yingying Tang (PCIe4)
>>>>>> <quic_yintang@quicinc.com> and Wangao Wang (Video)
>>>>>> <quic_wangaow@quicinc.com>.
>>>>>
>>>>> This looks like you should have Co-developed-by: tags together with
>>>>> their Signed-off-by: tags.
>>>>
>>>> We’ve agreed on this as the preferred method for marking collaboration, as
>>>> discussed earlier in this thread.
>>>>
>>>
>>> I can't say I agree with Bjorn there, but ok, he's the maintainer. :-)
>>>
>>>>>
>>>>>>
>>>>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>>>> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
>>>>>> ---
>>>>>>     arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi | 621 ++++++++++++++++++++++++++++
>>>>>>     1 file changed, 621 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi b/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
>>>>>> new file mode 100644
>>>>>> index 000000000000..c7c3a167eb6a
>>>>>> --- /dev/null
>>>>>> +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
>>>>>> @@ -0,0 +1,621 @@
>>>>>> +// SPDX-License-Identifier: BSD-3-Clause
>>>>>> +/*
>>>>>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>>>>> + */
>>>>>> +
>>>>>> +#include "x1e80100.dtsi"
>>>>>> +#include "x1e80100-pmics.dtsi"
>>>>>> +#include <dt-bindings/gpio/gpio.h>
>>>>>> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>>>>> +
>>>>>> +/ {
>>>>>> +	compatible = "hamoa-iot-som", "qcom,x1e80100";
>>>>>
>>>>> Undocumented compatible (without "qcom," prefix). I think you can just
>>>>> drop this?
>>>>
>>>> This compatible string was also discussed previously and is the preferred
>>>> choice. I’ll add the missing 'qcom,' prefix.
>>>>
>>>
>>> Even compatible = "qcom,hamoa-iot-som", "qcom,x1e80100"; is not
>>> documented. And it doesn't make much sense to document it either, each
>>> of the boards using the SoM should have a more specific compatible and
>>> therefore needs to override this property. I think you can really just
>>> drop this line.
>>
>> Patch 1/4 documents this compatible. It’s another requirement that SoC/SoM
>> should follow, which Krzysztof pointed out in v2:
>> https://lore.kernel.org/all/aee74e0f-c957-437d-ab48-3977013c3116@kernel.org/
>>
> 
> I'm not saying you should drop the "qcom,hamoa-iot-som" compatible. My
> point is that only the compatible list you use in hamoa-iot-evk.dts is
> documented in PATCH 1/4:
> 
> compatible = "qcom,hamoa-iot-evk", "qcom,hamoa-iot-som", "qcom,x1e80100";
> 
> The compatible list you are using in hamoa-iot-som.dtsi is *not*
> documented:
> 
> compatible = "(qcom,)hamoa-iot-som", "qcom,x1e80100";
> 
> because the board-specific compatible string (e.g. "qcom,hamoa-iot-evk")
> is missing.
> 
> The compatible property you have in hamoa-iot-som.dtsi is redundant,
> because you override it with the valid one in hamoa-iot-evk.dts. And
> every other board using the SoM should do the same.
> 
> I would expect that you can just drop this line in hamoa-iot-som.dtsi.

Yes, the compatible property in this context will ultimately be 
overridden by the board file and does not have any direct functional impact.

However, DTS/DTSI files are intended to describe the hardware itself, 
and this compatible string helps characterize the SOM—even if it is 
later overridden. This is similar to the role of compatible strings in 
certain soc.dtsi files.

Therefore, I believe it is appropriate to retain this compatible and 
provide documentation to clarify its purpose.

A useful reference for this approach is the imx8mp-sr-som.dtsi file from 
another vendor.

> 
> Thanks,
> Stephan

-- 
Best Regards,
Yijie


