Return-Path: <linux-kernel+bounces-755605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F69B1A918
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 20:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8E2A7A4399
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 18:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96CE2264B4;
	Mon,  4 Aug 2025 18:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="laDINb6t"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBAF21A44C
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 18:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754331532; cv=none; b=II0USITFOfPLB31azOn2+eAfdWXGOf6DCvoyFNUFX4vgcLgJWODO3spvZM4hd3xiGpMJXszibbhJ7NXJjxtB5rhxriYVoUl29VI8MTOrcsQhIQMXYTzY5I1TyLXAMRy9PslcAmvFufTJufVddBqDkiebD/LrqzKRNmBP72pSRRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754331532; c=relaxed/simple;
	bh=7K1JJRpveNfg80TmuSLcXf/fCpRuzAmUJgIt0nUbHmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pa5PZvD8Rf8pDqCvZGO+iruMYVtpGibq0B8zLwOPFihoOp0nL5CptumrwjFhTAYEBALIkcqFg6y4+T+lD0Z+cMjts5sW0XnNYabuvZolrHyn8KKCuhvMG2xaeY8uOr7qGfuRFL8qhDdDo0SVJqSibIGzomLCH21ng0H/tLIBciM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=laDINb6t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574GDkwC000777
	for <linux-kernel@vger.kernel.org>; Mon, 4 Aug 2025 18:18:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Yt5mi4p22WNYCmgL4pLlpxDR0rYiRxhk5KHLynsxrC8=; b=laDINb6tmIBio3vq
	zkPKbr5L7/spnlTsUkP3s/Ahthc9e3X0OrQq5SZVTZf252MK/6NrNHa9OaYkzxvL
	2VvaeQufjQC/gK/At4GQrH1bRSAo+vODMYjpGYbyTFRXrmuJXaWTsCZRzTCpZoeZ
	rMBQxbbkkBTgui908nWVOC5nGQBxWd/yhoeleOJeDJ86kvg7wWhBaBfT1I2GCXA4
	jq35LeNNL+3lAhxbYOPO8VP6j/dqvuyyzVYhxbuppP1AgG8u/qDdKZhoBjHP5rBy
	HQNGJfRrYqZ6xU8qoJPEoMkP8s1zVpUs88dHeSoI01/+uG/IywDap5cvw5L//2oK
	kc/WNw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4898cjp6rw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 18:18:49 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76bf205f680so157218b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 11:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754331529; x=1754936329;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yt5mi4p22WNYCmgL4pLlpxDR0rYiRxhk5KHLynsxrC8=;
        b=RS0z7LcoHLBf3YjuvVS1BEkD/0+MvC4vOisblvcD0Ubj5WnhGHgu7IZwqt3RgLpO7V
         xuwACvcZ9jS/+1lYBb/TBVW6w3TO37Nng14BuIIP19x1YE6kHqj3O6iRX6OXdBY9mkye
         Tr65HSxZAX/QBYX17FFJGTDh1WL6Q7s7lM0M40M/w6cWYQkk1G8nNSqw4JyWlVluOUwM
         /fLRE6CBwdEVX3fZ/Xom4sDBzyK5HDwHsabhgliaTXYzbXC7WPk3exW45b7osmfr286D
         7cjqUI2JJ03m04w9rj0VcfvUoEu52QmL4ihc8WYNYjHEgKLZ2BwfgoRwaf0IP0wKHcoa
         kJ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUvw3XVuDWXwNnqvn1MtDmRh94mAbh+nsB+9czDkc0nyaMAIpWUYzvFeAOVWMKGqFZvHzSobovxknMsP6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YydacNt8UQE/A3FvzH5baeXaGNYjG0ayXGhUpaEllCgYHd4oU6o
	D9NjynbEPojCVDJvLfMRgQYHrQtpn3dw4esAqX+rqVNjkFUnoY7sQDqMyktQr1Wsdov/5YV/2Yc
	rwM2WdFzhI/naOx8HAnzRO5l7Jzq0G6AXQ02cFfDKnRj6/cOrDCAWaLJ17DghsfnaUac=
X-Gm-Gg: ASbGncvK0WnVt439BjlUL0L6cbvf02CZhvT8+NeGkdF3X/DhR07v6ew1mc1Fd+1jtuy
	FlMwErg5VzstvQ/PFFSyLIebTgcU2UJwUPsxXQnXVF2KMfvEbuYK/dIkbhDN4s9ylmGzsiV3zHr
	5GpnlTczxwn6cttpR8pVWU6G18rZBAZQ5iYZNy/KB3/n21K05wlMi5bs9cSthFfyjQGJs76r0By
	mtSr/D1exw+9D5+JepNNR5NciiJe9MCzhlVinOKhUmLh3D7beyiOlaVRJk6KhHhB6shEGbbGEe+
	htWkubr6Sg9su31gp8yfyfmfT8hYlv1rYb+qOUMIODlNeNfSDtQLM1lR6TUIjs5IhEHGzxfMbZW
	4zFJErbVqdBq5O0ANfE5KByK2syGMMjQu
X-Received: by 2002:a05:6a00:1d26:b0:755:2c5d:482c with SMTP id d2e1a72fcca58-76bec47847cmr5134772b3a.4.1754331528635;
        Mon, 04 Aug 2025 11:18:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvhGBzOxgi/xKVgQhhPoJg28ueZWZWVcj10/Q+74coA0plQKiU+Q2o13fdZxk56/jThGn0Mw==
X-Received: by 2002:a05:6a00:1d26:b0:755:2c5d:482c with SMTP id d2e1a72fcca58-76bec47847cmr5134751b3a.4.1754331528192;
        Mon, 04 Aug 2025 11:18:48 -0700 (PDT)
Received: from ?IPV6:2401:4900:1cb5:a9d1:15b3:77df:1800:1497? ([2401:4900:1cb5:a9d1:15b3:77df:1800:1497])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbd7d1sm11162496b3a.80.2025.08.04.11.18.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 11:18:47 -0700 (PDT)
Message-ID: <588f29a8-827f-412e-b525-a1bd3f6c2d87@oss.qualcomm.com>
Date: Mon, 4 Aug 2025 23:48:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] arm64: dts: qcom: Add Monaco evaluation kit
 initial board support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rakesh Kota <quic_kotarake@quicinc.com>,
        Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
References: <20250801163607.1464037-1-umang.chheda@oss.qualcomm.com>
 <20250801163607.1464037-3-umang.chheda@oss.qualcomm.com>
 <4rxy4iuqy3dstfuv744gw327gf5n5g6notjpmkspjme2w4sd3j@5sbqfoumb5y7>
Content-Language: en-US
From: Umang Chheda <umang.chheda@oss.qualcomm.com>
In-Reply-To: <4rxy4iuqy3dstfuv744gw327gf5n5g6notjpmkspjme2w4sd3j@5sbqfoumb5y7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=MNBgmNZl c=1 sm=1 tr=0 ts=6890f989 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=-WHn9-XdheHXZOC3f6YA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: e7hbR9S8o7X-BLs0fCJX5mR1vWffvAHI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDEwNCBTYWx0ZWRfX2FLjFTnFfgEl
 duewdccfhURd4+tQH7IXSH+KCDaeKd7aCHYNP9n11voRfQePEsh6H+6Q2lPitWtrVlZDRpZ9/MO
 lBUUI45eFB+XqH5/eUTIF4OPsLevHVouwUeK5K92zU+Sn0JCCanrr24sKQ5QIGIfl5idxD32cgb
 9qccR/u/QAx0+7VxacwwZaZefFrhC5mvBKHy21e9qI41dFBjzUwhd5MT7FsLwqGwVWEsHwDvIWF
 iAlB+Hj+4QXFkNdnQS+NqrYobXXtCK9XtL2YApyufS6MuGXg3MryOLcvAfOPHtAz+IEFsra/Lg3
 EOcej2chfngCk5w3Z6CYdKqTOtNiHxUNIZd45A0MjFIanL1v5EJhA+puXcvLosKU0Wn9z/QMnu8
 PQLlf5mSdNR4tyvC79x5dIz/6saW73lQ/bziMHJYmQcHMlf9W7J2bmKDD1ksHFKeko4mIXmE
X-Proofpoint-GUID: e7hbR9S8o7X-BLs0fCJX5mR1vWffvAHI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_08,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040104

Hi Dmitry,

On 8/1/2025 10:44 PM, Dmitry Baryshkov wrote:
> On Fri, Aug 01, 2025 at 10:06:07PM +0530, Umang Chheda wrote:
>> Add initial device tree support for Monaco EVK board, based on
>> Qualcomm's QCS8300 SoC.
>>
>> Implement basic features like uart/ufs to enable 'boot to shell'.
> 
> "boot to shell" only makes sense if the platform is new and not all
> devices are enabled in the Linux kernel. Granted by the current level of
> the platform support, DT files for the EVK should have much more
> features. Please submit a full DT at once.
> 
Currently upstream aligned changes for other peripherals are not yet ready
for this platform, hence posted base DT support, will subsequently post other patches
when they are ready.

>>
>> Co-developed-by: Rakesh Kota <quic_kotarake@quicinc.com>
>> Signed-off-by: Rakesh Kota <quic_kotarake@quicinc.com>
>> Co-developed-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
>> Signed-off-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
>> Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/Makefile       |   1 +
>>  arch/arm64/boot/dts/qcom/monaco-evk.dts | 199 ++++++++++++++++++++++++
>>  2 files changed, 200 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/qcom/monaco-evk.dts
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index 4bfa926b6a08..e78f56762b6d 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -29,6 +29,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp433.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp449.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp453.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp454.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= monaco-evk.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8216-samsung-fortuna3g.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-acer-a1-724.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-alcatel-idol347.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/monaco-evk.dts b/arch/arm64/boot/dts/qcom/monaco-evk.dts
>> new file mode 100644
>> index 000000000000..1e0635c93556
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/monaco-evk.dts
>> @@ -0,0 +1,199 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>> +
>> +#include "qcs8300.dtsi"
> 
> No qcs8300-pmics.dtsi? Why?

Ack, will add this in the next patch version.> 
>> +
>> +/ {
>> +	model = "Qualcomm Technologies, Inc. Monaco EVK";
>> +	compatible = "qcom,monaco-evk", "qcom,qcs8300";
>> +
>> +	aliases {
>> +		serial0 = &uart7;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +};
>> +
> 

Thanks,
Umang


