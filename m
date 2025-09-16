Return-Path: <linux-kernel+bounces-818384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A80E2B5910B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E61D1780C8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0282288CA6;
	Tue, 16 Sep 2025 08:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mW65n6/i"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5592580F9
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758012166; cv=none; b=uH4qPErm5OqPOI2551FK8+cRlgcsAg+4WOF5bg3ejxx0kWtbaAKBhhXnEPtt+uK1duZde/DRBOcRnYr/U9Xmbdoeuwy+URyqcBHjiH75pdj/7u0xTjyYTyo276OJ8eE/6brm4n5dHFT/YhaA1z6sAvCe1Tf4B/bJclpLRqJK45M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758012166; c=relaxed/simple;
	bh=zWJzRdOiaxDsYLrstjuU5mof3JSkrBSxG6+zqCW4wUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pm4QhCZMjQwGICJtomL7BiS7V00cohq/q3AtyNLM9paZQOMvgJBgRFPbpLN4iQfruozaPvKQ6QpZUWe4Hmd2EO7cLVbwvKAkXIuDIqYZ36SG6JZ1rJ99QhxQsYlXJsl6DSs2I92YN3LMmDVm+Ud6damM8VTuluxtnJ6fXDN/Xnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mW65n6/i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G3plei001666
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:42:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yeg01tZKWracZvs2m+zBsbIUFkzq3IrS1xIM9ER4uT4=; b=mW65n6/i7D0zch3o
	Pu+QoWe8dfrRue7/v7YqWKeDrDN2i64B+qWpggWykgTIClOoLcLMZjUrD3CFMeJk
	AiP+0b55fVKi+Mcl3LVvLxYqQsHNApJaR+q2TTU25t7jR9F6cABsqKnuAsXlYxMN
	bZxtWa+HsgaIqM4/g9WXQcU9Ad0/S1txxt7Xxm3eJt9Az0vzTxsvrwj6B57xS81V
	9zFnLurbr+md/RaLnJOlc2AcsYmdIj3ymRG/xWKTrOP6n/GiEY6rRmieJBXcGvB/
	Gcxkm8Wf+q+0OSzUvzVols5CMf9fXUE0U6QeVp8/MGuY5/YDytaB9pCFmNfENg5d
	m9sCPw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 495eqpy0g4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:42:44 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32df881dcc5so3038816a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 01:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758012163; x=1758616963;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yeg01tZKWracZvs2m+zBsbIUFkzq3IrS1xIM9ER4uT4=;
        b=s2YpHs6Gbx7fIrUNWA/yNlHhoeFxOP9RneYw9tE9wtsOaFbYallrTeW12rdzYE63kn
         CKep4VUzy4yzkoLhzCI8nNGlhIQrOyoJd0rXgVl52cxJ3R9uUq86ky7/pIX74+l+bojZ
         bp/F1DQ79wnuqJw0MIxJocwqISG6nHv6BdHH/Fi5Revy3M6lytWG9WWfzc6Qs7N2wNBl
         dUb5CscRjO9EfSFOuERAIZ7nqj7HWYwa1qDiPyDWRwY+JnebcxVjWEUxp/zCD/KsSNc1
         8mMVmmqIGqF3/RtdkY0LsirwcvCsx7C7CuM+CXw99N6ST2rwOAdkKIMz1yzk6emOrLi0
         q1RA==
X-Forwarded-Encrypted: i=1; AJvYcCWWKDreqryD+F6Ge53Y2c+w9DfOnLxTTJih8dWKxiSWrXupeaaQMYFOy0+++MRYa3nq/PeXVzz4OU1AnzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR7C2NdvzbTqpKibB//aFP75laHFgkAHGZHpIHW/OvkofN+R8p
	Vy4rrPfA9JrUWItenH2AS3bnSwHgUv2wVAJveWm1jiau2dLNdURV48BRTOBjYP69ksXyL6snSkY
	JSQ4/OcPtoMGiB051rzTHSiJMi8uVn2K9FGWZHQSU23o0owTqyXMoesyFSPzy5E56zRA=
X-Gm-Gg: ASbGncs07qp4onvErtSLqUmJjEf00EyhM4NOTEQ1jaJMQv1L0E+pUFIbIb7WlI9Vb2p
	YgwtAWW+d5795ZOr6q+zICO0L7fhndPyvHHnGkMgbp1uOI5O155XMU9fW/Y03UGW2R3VZum7IFl
	7pA6/SYqzjSop3K22C0aJo/ZVccrBy3kDoUAQnTvQhD4IsFPgQW5Pt+uF+RmURv+AgNsD+3kt8X
	QkK3hZunw2lf6vDecahruqfmbzx1mU6t9wKbQReo9zVDswUVwubompvZOzYIT6Ag4MjS2daz8RT
	ACTsn102gFyLsxtD7W8BGyWuTs0HHnTL0A3lz4vJhgAnXKZsDNO5t+izGzW+a5t+6/oP9/kDrXa
	L6btiP2cZZorHYOAJj03nHVtO+vt1LPt2
X-Received: by 2002:a17:90b:4f46:b0:32e:3c38:2052 with SMTP id 98e67ed59e1d1-32e3c38275emr8297629a91.22.1758012162941;
        Tue, 16 Sep 2025 01:42:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFYNr+REGvUDSu3d4mFMsdXpfUIGA7+I7Ce3HV8tezeHqBCm66TJGUtSsRPMBPiqBEQXoTdA==
X-Received: by 2002:a17:90b:4f46:b0:32e:3c38:2052 with SMTP id 98e67ed59e1d1-32e3c38275emr8297570a91.22.1758012162240;
        Tue, 16 Sep 2025 01:42:42 -0700 (PDT)
Received: from [10.133.33.37] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7769a0d00d7sm8621214b3a.37.2025.09.16.01.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 01:42:41 -0700 (PDT)
Message-ID: <0d658857-e1f0-4e5f-808f-ac3c051d8910@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 16:42:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/4] arm64: dts: qcom: Add HAMOA-IOT-SOM platform
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
 <d5c1e2ae-e82c-47aa-97b5-a2020a8846fb@oss.qualcomm.com>
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <d5c1e2ae-e82c-47aa-97b5-a2020a8846fb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ue7P8YIUzDFE_8SUy6Q4NRGUcFugfuYe
X-Proofpoint-ORIG-GUID: ue7P8YIUzDFE_8SUy6Q4NRGUcFugfuYe
X-Authority-Analysis: v=2.4 cv=XJIwSRhE c=1 sm=1 tr=0 ts=68c92304 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=nAuJzNkJE3ImTGlgKg8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDE4NiBTYWx0ZWRfXwSdquxx4yyam
 H4fzB7yJwfw9pqWhfOodOGwsI+CL9drTDXBlvPbZL2S5/LwiGqNQZKeqpY8ky4wnpv+CU873Rke
 U1JhpQnsXsHz1IY0LTV6tNLB4/a7ONwBeP0F41QxMlVgYW/Bt2xpKqpNaF1rkDN1w4PsimIGosc
 2nrZPkJ3W1My4K2j3xfirPdvR4N8jq7WHTgTPQGK5DmMW2msiw4yq7nV2CqPu1cVIgHIX0twB3G
 ZFAB/0u8hCtzXpeRo9fALvDavrV4a8xx2FM0mjqOpS09bv80hwdupAOwMPIw7BCmnbAWjGorjmn
 GdRL5mcIbcSJMMy1UWtWzbM7IjTP4eCv0PqbGT0xCA9TVaAnqRATq8iJPmi6w3GYJxOzc0d3ah+
 pgZN/W8l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130186



On 2025-09-16 15:46, Konrad Dybcio wrote:
> On 9/16/25 3:06 AM, Yijie Yang wrote:
>>
>>
>> On 2025-09-15 17:53, Stephan Gerhold wrote:
>>> yOn Mon, Sep 15, 2025 at 05:46:09PM +0800, Yijie Yang wrote:
>>>>
>>>>
>>>> On 2025-09-15 16:52, Stephan Gerhold wrote:
>>>>> On Mon, Sep 15, 2025 at 10:12:15AM +0800, Yijie Yang wrote:
>>>>>>
>>>>>>
>>>>>> On 2025-09-12 16:48, Stephan Gerhold wrote:
>>>>>>> On Wed, Sep 10, 2025 at 05:02:11PM +0800, Yijie Yang wrote:
>>>>>>>> The HAMOA-IOT-SOM is a compact computing module that integrates a System
>>>>>>>> on Chip (SoC) — specifically the x1e80100 — along with essential
>>>>>>>> components optimized for IoT applications. It is designed to be mounted on
>>>>>>>> carrier boards, enabling the development of complete embedded systems.
>>>>>>>>
>>>>>>>> Make the following peripherals on the SOM enabled:
>>>>>>>> - Regulators on the SOM
>>>>>>>> - Reserved memory regions
>>>>>>>> - PCIe6a and its PHY
>>>>>>>> - PCIe4 and its PHY
>>>>>>>> - USB0 through USB6 and their PHYs
>>>>>>>> - ADSP, CDSP
>>>>>>>> - Graphic
>>>>>>>> - Video
>>>>>>>>
>>>>>>>> Written in collaboration with Yingying Tang (PCIe4)
>>>>>>>> <quic_yintang@quicinc.com> and Wangao Wang (Video)
>>>>>>>> <quic_wangaow@quicinc.com>.
>>>>>>>
>>>>>>> This looks like you should have Co-developed-by: tags together with
>>>>>>> their Signed-off-by: tags.
>>>>>>
>>>>>> We’ve agreed on this as the preferred method for marking collaboration, as
>>>>>> discussed earlier in this thread.
>>>>>>
>>>>>
>>>>> I can't say I agree with Bjorn there, but ok, he's the maintainer. :-)
>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>>>>>> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
>>>>>>>> ---
>>>>>>>>      arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi | 621 ++++++++++++++++++++++++++++
>>>>>>>>      1 file changed, 621 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi b/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
>>>>>>>> new file mode 100644
>>>>>>>> index 000000000000..c7c3a167eb6a
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
>>>>>>>> @@ -0,0 +1,621 @@
>>>>>>>> +// SPDX-License-Identifier: BSD-3-Clause
>>>>>>>> +/*
>>>>>>>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>>>>>>> + */
>>>>>>>> +
>>>>>>>> +#include "x1e80100.dtsi"
>>>>>>>> +#include "x1e80100-pmics.dtsi"
>>>>>>>> +#include <dt-bindings/gpio/gpio.h>
>>>>>>>> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>>>>>>> +
>>>>>>>> +/ {
>>>>>>>> +    compatible = "hamoa-iot-som", "qcom,x1e80100";
>>>>>>>
>>>>>>> Undocumented compatible (without "qcom," prefix). I think you can just
>>>>>>> drop this?
>>>>>>
>>>>>> This compatible string was also discussed previously and is the preferred
>>>>>> choice. I’ll add the missing 'qcom,' prefix.
>>>>>>
>>>>>
>>>>> Even compatible = "qcom,hamoa-iot-som", "qcom,x1e80100"; is not
>>>>> documented. And it doesn't make much sense to document it either, each
>>>>> of the boards using the SoM should have a more specific compatible and
>>>>> therefore needs to override this property. I think you can really just
>>>>> drop this line.
>>>>
>>>> Patch 1/4 documents this compatible. It’s another requirement that SoC/SoM
>>>> should follow, which Krzysztof pointed out in v2:
>>>> https://lore.kernel.org/all/aee74e0f-c957-437d-ab48-3977013c3116@kernel.org/
>>>>
>>>
>>> I'm not saying you should drop the "qcom,hamoa-iot-som" compatible. My
>>> point is that only the compatible list you use in hamoa-iot-evk.dts is
>>> documented in PATCH 1/4:
>>>
>>> compatible = "qcom,hamoa-iot-evk", "qcom,hamoa-iot-som", "qcom,x1e80100";
>>>
>>> The compatible list you are using in hamoa-iot-som.dtsi is *not*
>>> documented:
>>>
>>> compatible = "(qcom,)hamoa-iot-som", "qcom,x1e80100";
>>>
>>> because the board-specific compatible string (e.g. "qcom,hamoa-iot-evk")
>>> is missing.
>>>
>>> The compatible property you have in hamoa-iot-som.dtsi is redundant,
>>> because you override it with the valid one in hamoa-iot-evk.dts. And
>>> every other board using the SoM should do the same.
>>>
>>> I would expect that you can just drop this line in hamoa-iot-som.dtsi.
>>
>> Yes, the compatible property in this context will ultimately be overridden by the board file and does not have any direct functional impact.
>>
>> However, DTS/DTSI files are intended to describe the hardware itself, and this compatible string helps characterize the SOM—even if it is later overridden. This is similar to the role of compatible strings in certain soc.dtsi files.
>>
>> Therefore, I believe it is appropriate to retain this compatible and provide documentation to clarify its purpose.
> 
> No, if the compatible and model are not overriden, the carrier board DT is
> invalid. The SoM dtsi isn't supposed to be a "functional" dt, but rather a
> fragment, like a code header, containing most of the common functionality
> for includers (which is derived from the presence of the Hamoa SoM).

Understood, I will remove this line.

> 
> Konrad
>>
>> A useful reference for this approach is the imx8mp-sr-som.dtsi file from another vendor.
>>
>>>
>>> Thanks,
>>> Stephan
>>

-- 
Best Regards,
Yijie


