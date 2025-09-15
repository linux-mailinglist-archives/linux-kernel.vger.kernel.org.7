Return-Path: <linux-kernel+bounces-816542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2056DB5752F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0EA0189DC95
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4611F2F60B3;
	Mon, 15 Sep 2025 09:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IovRb94M"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD532ED15C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757929579; cv=none; b=aT5FL7ki2ICKKX9fhunFYUXWTXoIjI0rnGIjkm/0wD3G6ENF1GnzAlqYOM0SEU8NnDw+YE/ZXDmg2sJripSGyozwB1Wlae8KtLjnBauE3s6rhO449i6/+dEpX+sglWJf8D2pT0DJ21w7WbisQYpPEDcf+Tw/q4MGkznNFzp9Ohk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757929579; c=relaxed/simple;
	bh=M8e2y27K3A6dpsBSo9MEi4W0aa6bQrCDhahqiCtj7eI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NKEedP/7BL8aOw8R7FHMIHNyk4c4KwFlAHYSjzTPWk9ZZ24DCx5COpYPL5sofVSDyHKe+jR3/WVC+J6W/8ZqCe8h+QE5+n5dqLi5WYH5+tLxazZ+6PoxGzNK+HviQ/a4Ez0M1zWWVV8SpX8QhYMOpyFSVjPDLQm8oU1QkY4aLe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IovRb94M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F8FfSI021910
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XKYBpf/YuTgi1/R2heAtYg9SuIoT+bGQO1rttRChYWM=; b=IovRb94MHriGQZXU
	DQR8Y7pY7IeSfAOCKiKpCMkWWPuay301yCzM1dQgf3UmSJQvPozLVJ/Ko8TvM0qS
	SVhGp3vaOb1cvUUaMsdmB395sMr8z+ecOKjpbe6vho4QCt9fr1y0QSe7p+isYS2h
	zfLUswMwfIS5f27E+pAlG5PRnSKPhZQdxqMvsSJchRokVznu4WwipHuKttbJ/jc5
	1MwPe6NxBHX+9iUUjI2IlylvQ3qhQzpjE+2k1b1YmhWlkaB1S4rBzLO1FLONQuNy
	QBCg4/xyXVxXXHVh+1YjWKK75eHfpI3AfddO/NHpCa25jjGLFAxaBo2Gaa2j2YvZ
	oQ8rBg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49510acd8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:46:16 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77260707951so5941521b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 02:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757929575; x=1758534375;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XKYBpf/YuTgi1/R2heAtYg9SuIoT+bGQO1rttRChYWM=;
        b=QSuwVZw9GRC2qpHkki/ELqSPXoYSWNzdBxHRYDOPf0wovH7zOI26F/2DfdWpW6xcFG
         rItr2mWaPXV87lzPrNDpzpi6IJX2EeoULezePE2E6TindAF9BMkYQ5kBcAu3eExEb4DW
         PVh2U4T+sYF2P2lcIYQ8jRcBUv6dNtLOlB3XXByjOQL/rSJ5AoH9hCYK6xeELXuiPF2S
         Bk8gZnIaKAJqzFmC/UDL6rhqEzVNOtr2BIySdKjpYrjLGTMAU8AKiYT64l3qP/gZhJ/A
         35rN1xwWPY5wp3RECzr/JI2auoFJRWGa+JoRpHmhh5lZzGvX0D8ZJvTT1bnPwV7VFxBp
         b0gw==
X-Forwarded-Encrypted: i=1; AJvYcCWZKKmIKc5WmfeQ/Kmp9UQ0zswS02sl05g09asdE+3wHpZcw29xM61MPl8qSbOkzpSd9DJD7bQrxKim2S8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0KBUPKGkIqRNyU4C4FJbEv/zKTSX5R23esuHMIa+gnf5E7q5P
	9qwXOWtITCYdqPO+I1q+y7TDddP1KImYnNYzqZ6+rh2Gy5JwjyhaMkYg07xJuUhxlp8HatmTQ4X
	F55+xy1z/0cUHefEM4JXSVhFTDXsCeS1YNALlZzVWivs1Xy1K6qIaf0KhAyfGNoPoKEsh2turE7
	MzKA==
X-Gm-Gg: ASbGnctuX0V5RICvmSuNjm4gGUeVgXJ+1FrKe5LlMQub4NalMlvnSBi1Iew+6G6/fcc
	eu+I9FtudBXSvUwG/JzJHJPuUazNDHk2GNUeiNzEbT+QO3lePtOn0fYt5fF6AtU75AKt4x2dfLp
	eeB4/V42KSbxqj4j79RJ9bVyowINVEfWwLtHoXy2A561eBSbdwN6soYqQuwoKUs+TyQJHE2PxN3
	5NWme7VVklKn8W1i23oavoqZ69QJb8W4l+/ZlmSVaMeQdNK4n5CDVE0vChPAn0pGW3wsXBhsKcB
	BINAnE/Zm4FZsBvWDSofQ+fiOtH2Qmu5/DU4FIJFH1P3DI2R0jYGKrAmIUIu1Z5vFyIbei6exHe
	og0CMCy1XwF+24cdJOoITylAJfaciQcbnVg==
X-Received: by 2002:a05:6a20:1586:b0:240:328c:1225 with SMTP id adf61e73a8af0-2602a49d995mr14316727637.12.1757929575002;
        Mon, 15 Sep 2025 02:46:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHa4BidIfDh3AtMcW/itG57vXFSTbsRdVvF4+01fyHzNCi0wK6V3NSVHYYncqWgx10dq0+bFw==
X-Received: by 2002:a05:6a20:1586:b0:240:328c:1225 with SMTP id adf61e73a8af0-2602a49d995mr14316695637.12.1757929574550;
        Mon, 15 Sep 2025 02:46:14 -0700 (PDT)
Received: from [10.133.33.238] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-777d3ca57e2sm3503834b3a.33.2025.09.15.02.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 02:46:14 -0700 (PDT)
Message-ID: <3b81ea60-553a-48d8-b6c7-6b55673fe04d@oss.qualcomm.com>
Date: Mon, 15 Sep 2025 17:46:09 +0800
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
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <aMfT1_uyZETUEBYk@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=I/plRMgg c=1 sm=1 tr=0 ts=68c7e068 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=HIKkmpGtg5vrm0Pab0QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAzMiBTYWx0ZWRfX4k+pLIxAcmRz
 nAjtFH29Zv6ugmuvejLYNAXWEnwLJS8rKuHHkbipQIrtFCNsLoUBTjasNNR/50Ym4N6jUyUlYfi
 SBablQHwq8q5sASQr9eAN91h0Ef5aY3x/or/nJ7mWXSh9SGQvYWbhiMto4oC6mbp6QEizyTEEqC
 uC2YbwQRSpasI+6oZAT09lEdOBU/0s67TsW6ZTi3+2LotQcr8SVtNzmBQzl/JNd8pAdX+LAu4QQ
 SJTqwrQcps9ejBDZ+V4WRw/0/rnVU+ZtGTS7jyqUghsgbc7yZngo/AKakudZn1zzrlCLSzIz4Fm
 36FhMS6Wm7nDc9ExLbvTtO7WCHrp0H8NHHym7wORIJq/sVgtrbX8s18fRtpMp7R59dNJwLt9oLa
 m2z54xGo
X-Proofpoint-ORIG-GUID: Xmdwsz3pKkawXIywrpoYjyCYE28Mvhrw
X-Proofpoint-GUID: Xmdwsz3pKkawXIywrpoYjyCYE28Mvhrw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_04,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130032



On 2025-09-15 16:52, Stephan Gerhold wrote:
> On Mon, Sep 15, 2025 at 10:12:15AM +0800, Yijie Yang wrote:
>>
>>
>> On 2025-09-12 16:48, Stephan Gerhold wrote:
>>> On Wed, Sep 10, 2025 at 05:02:11PM +0800, Yijie Yang wrote:
>>>> The HAMOA-IOT-SOM is a compact computing module that integrates a System
>>>> on Chip (SoC) — specifically the x1e80100 — along with essential
>>>> components optimized for IoT applications. It is designed to be mounted on
>>>> carrier boards, enabling the development of complete embedded systems.
>>>>
>>>> Make the following peripherals on the SOM enabled:
>>>> - Regulators on the SOM
>>>> - Reserved memory regions
>>>> - PCIe6a and its PHY
>>>> - PCIe4 and its PHY
>>>> - USB0 through USB6 and their PHYs
>>>> - ADSP, CDSP
>>>> - Graphic
>>>> - Video
>>>>
>>>> Written in collaboration with Yingying Tang (PCIe4)
>>>> <quic_yintang@quicinc.com> and Wangao Wang (Video)
>>>> <quic_wangaow@quicinc.com>.
>>>
>>> This looks like you should have Co-developed-by: tags together with
>>> their Signed-off-by: tags.
>>
>> We’ve agreed on this as the preferred method for marking collaboration, as
>> discussed earlier in this thread.
>>
> 
> I can't say I agree with Bjorn there, but ok, he's the maintainer. :-)
> 
>>>
>>>>
>>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
>>>> ---
>>>>    arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi | 621 ++++++++++++++++++++++++++++
>>>>    1 file changed, 621 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi b/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
>>>> new file mode 100644
>>>> index 000000000000..c7c3a167eb6a
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
>>>> @@ -0,0 +1,621 @@
>>>> +// SPDX-License-Identifier: BSD-3-Clause
>>>> +/*
>>>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>>> + */
>>>> +
>>>> +#include "x1e80100.dtsi"
>>>> +#include "x1e80100-pmics.dtsi"
>>>> +#include <dt-bindings/gpio/gpio.h>
>>>> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>>> +
>>>> +/ {
>>>> +	compatible = "hamoa-iot-som", "qcom,x1e80100";
>>>
>>> Undocumented compatible (without "qcom," prefix). I think you can just
>>> drop this?
>>
>> This compatible string was also discussed previously and is the preferred
>> choice. I’ll add the missing 'qcom,' prefix.
>>
> 
> Even compatible = "qcom,hamoa-iot-som", "qcom,x1e80100"; is not
> documented. And it doesn't make much sense to document it either, each
> of the boards using the SoM should have a more specific compatible and
> therefore needs to override this property. I think you can really just
> drop this line.

Patch 1/4 documents this compatible. It’s another requirement that 
SoC/SoM should follow, which Krzysztof pointed out in v2:
https://lore.kernel.org/all/aee74e0f-c957-437d-ab48-3977013c3116@kernel.org/

> 
> Thanks,
> Stephan
> 

-- 
Best Regards,
Yijie


