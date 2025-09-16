Return-Path: <linux-kernel+bounces-818299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FA8B58F95
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EBDB1BC5573
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5956230BEC;
	Tue, 16 Sep 2025 07:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KDHRn3O0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2960D198851
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758008815; cv=none; b=NCySHWtlQLAPSAFNc7os2laKPcy1+CVp+IABvFWsr4m66TWFsV6QTjj8qaErULfNhaOfPRhiJZkU8KiCMZQjPtDw+QPRqP8/pfKGCXCRcDLi4F5/Mqfzx2XNUirXbf4WI7UY0oPUm2SR22bkwRmjyGBwqrNGEd4LXXSHI3RmqpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758008815; c=relaxed/simple;
	bh=uyJQaZWtfN3j9XQd2xpdgR07Ehkd86qVWRtNtk3XyGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OkRH5EwMGzUxW5msXt6jh4EABYtrC2+PcIj20bG2oCqh+F4KI1bvR3LHPdSl03Mj0soXlBfUgtHzK/QCR6xvehHV6sQHBUs83QUDN0Yyug1rJNcgzQDpKV3Jj7NHTwChzxG4kmlRwvTXrdQ9+kUEN5aH6dUP0suXprjabD2IFBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KDHRn3O0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G3qO3h015309
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:46:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Cf5E7W0dBAEK0vAVzeNQtS2T7DH7znSy9al2kJux2i4=; b=KDHRn3O0YweGuhKa
	78AAwlVYky48FOkUhXekKZBYxrTn0UV6A6pUQDOYXf0lyQyGmpw3i7qfM9ce+eF+
	I5DASEVgasjoNc74E76Pdwrwx7WvUzNRx5+f0Fpn6uW3yIsNyX9v/FFlBgEsGy+x
	BzlwKa42v8KxvwqHcM+FI4ONMOivRosmkQCvoLra54PAvYESWhv41YShJQMd/DMX
	3LEpwX771969JuHH3vk+NMf3zDA7J+L/6Wn5EC2a9Q+FI5bEdINlGys1bNJD4X7G
	RS4b3FcyU461GmjLDTBfHEoLeLSb1imnY96G5Om7p2rXpAQBBd0xwud5I6qb0tGd
	drwVEA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496x5as1kw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:46:51 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-77c37a2c874so6747616d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 00:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758008811; x=1758613611;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cf5E7W0dBAEK0vAVzeNQtS2T7DH7znSy9al2kJux2i4=;
        b=k+GG6ziC8XEG/T9k0rR9eAh/t5+jae1uEfrWq/ZJBjpqM8tmAs0Nyu/QtiWrVGKZLc
         RbapAdSqUBknSMRi2wztHI0N89TeldusEijDVECOahIjajt0FFZ9ziuYa3jB4MDIPZzf
         r6LG58wiJLDW9JN3g4P9hmU6tEL2IJdWQtO4343eTwpnVrE6S8efPu+xCB8mIVBzQred
         ZyCDhtvUPi/LGhgq8lzd/iz8uKyi7R7Tptj2Z5kOetwuehv71RIXSQxxXDku3AT2PmJd
         oAwDae5VWoTpnBji1wgz87tjFXkEBlz5jLhtFbwp8D2PbeCJVkNefqs6lm6qQSodFyQo
         uIZA==
X-Forwarded-Encrypted: i=1; AJvYcCXoZtKirqKRkZu/kAXsZJRi2FVEoA58YfEFYTtzqatN869+E7ep/ky0FiIL7g9xOCvQZ5PFzQ1MKYbUlp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmP1NzaOBhHhlHTq4x8XBIjD3ZcscOSnoUb3hQm177LjoNRfTs
	p7Tl7hGuX3eHr9QV4+6/f0oL/jx9ivgZI4BQFtOBca4AsmX0zO0WGSzXY3MZxpIXmr7B3r9kKhM
	1havTv/RYAVHUn43WR99Bj4C+Fvhqo5WeFuWfL78G4POCOv/OiJJmDzK4yHGbSj7xlOs1d0oX8q
	4=
X-Gm-Gg: ASbGncscmFaE70q5yhB1FN5TG/g+YHt5PdA1Who2ouD3Lp9ikd8BUeIjw/boO/boo1f
	Qs/wkz3YRemwoSvqCTVHphSUg7F12oXWJpNUn4KhoOfV+r2OQFtRd7mn051SnLKDu/LPYThrGQi
	uKBKQu5841iIKQ2TNOTlc9tQfq3vKOuHlXH62fGs9bpck3SUUEUACHwlbY5OtAvKFsLfvhZhpYL
	Zo+3iMu82aFP22xkwHu+/Uj9+sCMF5Ilb6Y7ibEuEytofDcmCzfvJ1p1CMWZ6D6btl9P7QW+Dxm
	Bmj1xSsmBH1QkwaeocBConP3XqMSgISwfkThpaGj3k/NE2d+7D5P6oVgU9A55w9r2g3QHPaVs2w
	c9tIXY6bCXiqOMpfdCs36IQ==
X-Received: by 2002:ac8:7c44:0:b0:4b5:6f48:e555 with SMTP id d75a77b69052e-4b77cfd4f60mr126155851cf.5.1758008810591;
        Tue, 16 Sep 2025 00:46:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuaL33e3U5Wrbt2sEQNvDTeXZUwrMOQ2WQWOhmosPNQ/paZrWzLCiSm37HdMbB+EBaDE2SEQ==
X-Received: by 2002:ac8:7c44:0:b0:4b5:6f48:e555 with SMTP id d75a77b69052e-4b77cfd4f60mr126155701cf.5.1758008810010;
        Tue, 16 Sep 2025 00:46:50 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62ec33ad741sm10726173a12.21.2025.09.16.00.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 00:46:49 -0700 (PDT)
Message-ID: <d5c1e2ae-e82c-47aa-97b5-a2020a8846fb@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 09:46:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/4] arm64: dts: qcom: Add HAMOA-IOT-SOM platform
To: Yijie Yang <yijie.yang@oss.qualcomm.com>,
        Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250910-hamoa_initial-v11-0-38ed7f2015f7@oss.qualcomm.com>
 <20250910-hamoa_initial-v11-3-38ed7f2015f7@oss.qualcomm.com>
 <aMPee9wEOrrW-KMU@linaro.org>
 <90dcca12-1a68-4049-bcbe-c333aed07a07@oss.qualcomm.com>
 <aMfT1_uyZETUEBYk@linaro.org>
 <3b81ea60-553a-48d8-b6c7-6b55673fe04d@oss.qualcomm.com>
 <aMfiCry1NDdd9AnX@linaro.org>
 <aa2677a3-7d5f-4abc-9bb4-7db53b9b8a0f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <aa2677a3-7d5f-4abc-9bb4-7db53b9b8a0f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: SlMgg4f5fNjTPijdJXhL8CRmdC7eoswc
X-Proofpoint-ORIG-GUID: SlMgg4f5fNjTPijdJXhL8CRmdC7eoswc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDAxMCBTYWx0ZWRfX+BQjkWM3+RSM
 z/XphDh1LtV6+QDKa0VowpG0dOTfOjz4LEge/vnad2SV8sVgamy1Qm7if3NTYB2U0vBIilo6wby
 2rnxwXS/xhKtKL66Xn78SqEQbCZsK5+kZopPLwMPMjsGcFxRobKhtX5EJQsMAwh9j+cxrbTIzZb
 U7OkKbpDvLP/coe96Vr5ek+ngQnWLkAfnzDUZUDxtbK6s/DXTWDEqrXxTmerXys0pxzTEf4UC1B
 eWsi9EQQ/VXTUwD9PJt6RXFdJgUvETwKXZOmLjQ4EpsVmUW2CsKvbDY9nAMt5UuDD+lY5axGdla
 Mn9h4SBNTsQg1R2VJx61Dw8CaFkBZ9wRQzCSr/TmB1oOM89/yGO1zyM6HpaglSLXzRzI4l5bj4O
 sBn54GK+
X-Authority-Analysis: v=2.4 cv=WpQrMcfv c=1 sm=1 tr=0 ts=68c915eb cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=thWbWRcKQ_BuJRqTtGEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160010

On 9/16/25 3:06 AM, Yijie Yang wrote:
> 
> 
> On 2025-09-15 17:53, Stephan Gerhold wrote:
>> yOn Mon, Sep 15, 2025 at 05:46:09PM +0800, Yijie Yang wrote:
>>>
>>>
>>> On 2025-09-15 16:52, Stephan Gerhold wrote:
>>>> On Mon, Sep 15, 2025 at 10:12:15AM +0800, Yijie Yang wrote:
>>>>>
>>>>>
>>>>> On 2025-09-12 16:48, Stephan Gerhold wrote:
>>>>>> On Wed, Sep 10, 2025 at 05:02:11PM +0800, Yijie Yang wrote:
>>>>>>> The HAMOA-IOT-SOM is a compact computing module that integrates a System
>>>>>>> on Chip (SoC) — specifically the x1e80100 — along with essential
>>>>>>> components optimized for IoT applications. It is designed to be mounted on
>>>>>>> carrier boards, enabling the development of complete embedded systems.
>>>>>>>
>>>>>>> Make the following peripherals on the SOM enabled:
>>>>>>> - Regulators on the SOM
>>>>>>> - Reserved memory regions
>>>>>>> - PCIe6a and its PHY
>>>>>>> - PCIe4 and its PHY
>>>>>>> - USB0 through USB6 and their PHYs
>>>>>>> - ADSP, CDSP
>>>>>>> - Graphic
>>>>>>> - Video
>>>>>>>
>>>>>>> Written in collaboration with Yingying Tang (PCIe4)
>>>>>>> <quic_yintang@quicinc.com> and Wangao Wang (Video)
>>>>>>> <quic_wangaow@quicinc.com>.
>>>>>>
>>>>>> This looks like you should have Co-developed-by: tags together with
>>>>>> their Signed-off-by: tags.
>>>>>
>>>>> We’ve agreed on this as the preferred method for marking collaboration, as
>>>>> discussed earlier in this thread.
>>>>>
>>>>
>>>> I can't say I agree with Bjorn there, but ok, he's the maintainer. :-)
>>>>
>>>>>>
>>>>>>>
>>>>>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>>>>> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
>>>>>>> ---
>>>>>>>     arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi | 621 ++++++++++++++++++++++++++++
>>>>>>>     1 file changed, 621 insertions(+)
>>>>>>>
>>>>>>> diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi b/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
>>>>>>> new file mode 100644
>>>>>>> index 000000000000..c7c3a167eb6a
>>>>>>> --- /dev/null
>>>>>>> +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
>>>>>>> @@ -0,0 +1,621 @@
>>>>>>> +// SPDX-License-Identifier: BSD-3-Clause
>>>>>>> +/*
>>>>>>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>>>>>> + */
>>>>>>> +
>>>>>>> +#include "x1e80100.dtsi"
>>>>>>> +#include "x1e80100-pmics.dtsi"
>>>>>>> +#include <dt-bindings/gpio/gpio.h>
>>>>>>> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>>>>>> +
>>>>>>> +/ {
>>>>>>> +    compatible = "hamoa-iot-som", "qcom,x1e80100";
>>>>>>
>>>>>> Undocumented compatible (without "qcom," prefix). I think you can just
>>>>>> drop this?
>>>>>
>>>>> This compatible string was also discussed previously and is the preferred
>>>>> choice. I’ll add the missing 'qcom,' prefix.
>>>>>
>>>>
>>>> Even compatible = "qcom,hamoa-iot-som", "qcom,x1e80100"; is not
>>>> documented. And it doesn't make much sense to document it either, each
>>>> of the boards using the SoM should have a more specific compatible and
>>>> therefore needs to override this property. I think you can really just
>>>> drop this line.
>>>
>>> Patch 1/4 documents this compatible. It’s another requirement that SoC/SoM
>>> should follow, which Krzysztof pointed out in v2:
>>> https://lore.kernel.org/all/aee74e0f-c957-437d-ab48-3977013c3116@kernel.org/
>>>
>>
>> I'm not saying you should drop the "qcom,hamoa-iot-som" compatible. My
>> point is that only the compatible list you use in hamoa-iot-evk.dts is
>> documented in PATCH 1/4:
>>
>> compatible = "qcom,hamoa-iot-evk", "qcom,hamoa-iot-som", "qcom,x1e80100";
>>
>> The compatible list you are using in hamoa-iot-som.dtsi is *not*
>> documented:
>>
>> compatible = "(qcom,)hamoa-iot-som", "qcom,x1e80100";
>>
>> because the board-specific compatible string (e.g. "qcom,hamoa-iot-evk")
>> is missing.
>>
>> The compatible property you have in hamoa-iot-som.dtsi is redundant,
>> because you override it with the valid one in hamoa-iot-evk.dts. And
>> every other board using the SoM should do the same.
>>
>> I would expect that you can just drop this line in hamoa-iot-som.dtsi.
> 
> Yes, the compatible property in this context will ultimately be overridden by the board file and does not have any direct functional impact.
> 
> However, DTS/DTSI files are intended to describe the hardware itself, and this compatible string helps characterize the SOM—even if it is later overridden. This is similar to the role of compatible strings in certain soc.dtsi files.
> 
> Therefore, I believe it is appropriate to retain this compatible and provide documentation to clarify its purpose.

No, if the compatible and model are not overriden, the carrier board DT is
invalid. The SoM dtsi isn't supposed to be a "functional" dt, but rather a
fragment, like a code header, containing most of the common functionality
for includers (which is derived from the presence of the Hamoa SoM).

Konrad
> 
> A useful reference for this approach is the imx8mp-sr-som.dtsi file from another vendor.
> 
>>
>> Thanks,
>> Stephan
> 

