Return-Path: <linux-kernel+bounces-842509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 967FCBBCE30
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 01:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D20AC3B80A7
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 23:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8B21F0E56;
	Sun,  5 Oct 2025 23:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="on41rkU5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70992905;
	Sun,  5 Oct 2025 23:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759708461; cv=none; b=jks5oRorjgYScQnR/KvXnAYy10RMtSgZIvF5CTkr1IIeuVGYIOBQF7f5Hl/Y/yexgn3NK8XRjQ0EgyDD8uEVGq0Z+uXfOPPQisRvThUrwdBNgMDOmux3J0gXoC+1TpOKx6BA8jpOwnYEkvbSK5hhB4En0D9ZxagA6EMfOvfebNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759708461; c=relaxed/simple;
	bh=6zDSAiaG5Yn78oQ+HLbBUTqMhvHHdjrEYRh8XsLjTGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=W4rE4aL8A0i9v2dlsgaZsMfgGfNZbW5m+raR98/V+p1jNx8cgIv94/zpKhdjUeNSL5UJQ3OCN7PYNeWbgZ0/YpqtQ0pslqqI+L5Vf0lQ8nlLvVo0bLEIlsfE5cWf8gT/XYkCpQShDyDbgRz73BGKef0qYcKTHSQh8cbrMJsSH6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=on41rkU5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 595Nf9G4025787;
	Sun, 5 Oct 2025 23:54:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Qn86KvLo5Zq5nm0mEJqPF9Wx0XnyTrU9sJXzFKCQSrE=; b=on41rkU5TKx3B6jl
	2A7gWWgxeP9l0dLzagfk0mQDhIs5fD/zk4zMTd/ppXrqjqqLn28vqqTYVA0hsRo2
	vEIu0/ssDGMxBYTUcDTMYVW+xmpsnbRH/W8HOnBYk3JTVC2k0DZOlODrBMf/opvO
	Rrdg4RGossUIKVTO7TzHBpdix+qpidc9Qj6aYmRrqHd98NUIwd+aOY27dQ11uqpM
	TfH7FZvC2u0WoPADuremGNSrJ/HGm4aqR+zxvuOVqXgPRmPxUzjdj/6N9OzFdzZN
	FGg0NKMs6kqo50YtoVZwVGatH8xochfFJXYUuoyPiKHjGbqpUOXRfCPpEpyR97pZ
	z1GIog==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49ju5xan4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 05 Oct 2025 23:54:04 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 595Ns3bP030825
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 5 Oct 2025 23:54:03 GMT
Received: from [10.216.28.59] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Sun, 5 Oct
 2025 16:53:56 -0700
Message-ID: <d5f87af9-be76-4343-a425-fb20a9e6c6e8@quicinc.com>
Date: Mon, 6 Oct 2025 05:23:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: qcs8300: add Display Serial
 Interface device nodes
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <marijn.suijten@somainline.org>,
        <andersson@kernel.org>, <robh@kernel.org>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>, <konradybcio@kernel.org>, <conor+dt@kernel.org>,
        <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
        <rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>,
        <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>,
        <quic_rajeevny@quicinc.com>, <quic_vproddut@quicinc.com>,
        <quic_jesszhan@quicinc.com>
References: <20250925053602.4105329-1-quic_amakhija@quicinc.com>
 <20250925053602.4105329-3-quic_amakhija@quicinc.com>
 <vsty7sy7gi2eeyifokwcqpoycmarxietkijmlkymwrmzmdsfws@x64f4ulbc6ja>
 <aaa9f760-70aa-4bee-b6ab-d6fb02ea3c78@quicinc.com>
 <CAO9ioeWHJSj74VBR=2kHJDe_p1oG9Ngs6q9+s=CySGD3KY6sPQ@mail.gmail.com>
Content-Language: en-US
From: Ayushi Makhija <quic_amakhija@quicinc.com>
In-Reply-To: <CAO9ioeWHJSj74VBR=2kHJDe_p1oG9Ngs6q9+s=CySGD3KY6sPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=FooIPmrq c=1 sm=1 tr=0 ts=68e3051c cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=gEfo2CItAAAA:8
 a=COk6AnOGAAAA:8 a=9TVuvPmJ-SUQZ-tjHVgA:9 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22 a=TjNXssC_j7lpFel5tvFf:22 a=nl4s5V0KI7Kw-pW0DWrs:22
 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-ORIG-GUID: YzWOODIdLUXruPPsViLlinqHkKmFgKmb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMiBTYWx0ZWRfX30ukWfGq3BR+
 pLInk52ZQj76yrfv11FukCoN2F1RocV7e1B5LOLgp+emm9Zhto+BCcyF9cY6Z5nPoJp1HkbmEhl
 CX7T8vJukZZLUT+WU39WOyZT6ew6i7aXL81FvC62LLY7S93e81T4E4fD47tDCwEwBF628uYptqo
 IvBnedv0qVO6I3IL7OSdIA3qjmqFrS4ow6EFxC6Zyt6xx5THs6GUwHD1dks0VwHirg5TyC0efP1
 qIX5fIaECJZGnPKj7CjgrIVRrjFaMtmPm2btq0uukzpiaKyKCwdU6ZjUq3lTM71rLcNNRJ8xSFQ
 2GB8B7nV7gMTPhcpEssJTZdXzRUSXrYXQNh3miS8SA1Wx/PXyJ6wFk3m+Qrsfxlcl9wa0LbeS58
 j4u8277uQMFUFq5JRer/U7s+VUmqrQ==
X-Proofpoint-GUID: YzWOODIdLUXruPPsViLlinqHkKmFgKmb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-05_08,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040022

On 10/6/2025 3:31 AM, Dmitry Baryshkov wrote:
> On Sun, 5 Oct 2025 at 19:49, Ayushi Makhija <quic_amakhija@quicinc.com> wrote:
>>
>> On 9/26/2025 3:32 AM, Dmitry Baryshkov wrote:
>>> On Thu, Sep 25, 2025 at 11:06:01AM +0530, Ayushi Makhija wrote:
>>>> Add device tree nodes for the DSI0 controller with their corresponding
>>>> PHY found on Qualcomm QCS8300 SoC.
>>>>
>>>> Signed-off-by: Ayushi Makhija <quic_amakhija@quicinc.com>
>>>> ---
>>>>  arch/arm64/boot/dts/qcom/qcs8300.dtsi | 95 ++++++++++++++++++++++++++-
>>>>  1 file changed, 94 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/qcs8300.dtsi b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
>>>> index e0e1f63fc45b..834ae0522f2f 100644
>>>> --- a/arch/arm64/boot/dts/qcom/qcs8300.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
>>>> @@ -3,6 +3,7 @@
>>>>   * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
>>>>   */
>>>>
>>>> +#include <dt-bindings/clock/qcom,dsi-phy-28nm.h>
>>>>  #include <dt-bindings/clock/qcom,qcs8300-gcc.h>
>>>>  #include <dt-bindings/clock/qcom,rpmh.h>
>>>>  #include <dt-bindings/clock/qcom,sa8775p-camcc.h>
>>>> @@ -4854,6 +4855,13 @@ dpu_intf0_out: endpoint {
>>>>                                                      remote-endpoint = <&mdss_dp0_in>;
>>>>                                              };
>>>>                                      };
>>>> +
>>>> +                                    port@1 {
>>>> +                                            reg = <1>;
>>>> +                                            dpu_intf1_out: endpoint {
>>>> +                                                    remote-endpoint = <&mdss_dsi0_in>;
>>>> +                                            };
>>>> +                                    };
>>>>                              };
>>>>
>>>>                              mdp_opp_table: opp-table {
>>>> @@ -4881,6 +4889,89 @@ opp-650000000 {
>>>>                              };
>>>>                      };
>>>>
>>>> +                    mdss_dsi0: dsi@ae94000 {
>>>> +                            compatible =  "qcom,sa8775p-dsi-ctrl","qcom,mdss-dsi-ctrl";
>>>
>>> qcom,qcs8300-dsi-ctrl. You might use three compatibles (qcs8300, sa8775p
>>> and the generic one), but there should be qcs8300 one.
>>>
>>
>> Hi Dmitry,
>>
>> If I am adding three compatible string for ctrl,
>>
>> compatible = "qcom,qcs8300-dsi-ctrl",
>>              "qcom,sa8775p-dsi-ctrl",
>>              "qcom,mdss-dsi-ctrl";
>>
>> while validating dt-binding and dtsi against dt-schema. I am getting below errors
>>
>>
>> /local/mnt/workspace/amakhija/linux_next/linux/arch/arm64/boot/dts/qcom/qcs8300-ride.dtb: dsi@ae94000: compatible: 'oneOf' conditional failed, one must be fixed:
>>         ['qcom,qcs8300-dsi-ctrl', 'qcom,sa8775p-dsi-ctrl', 'qcom,mdss-dsi-ctrl'] is too long
>>         'qcom,qcs8300-dsi-ctrl' is not one of ['qcom,dsi-ctrl-6g-qcm2290', 'qcom,mdss-dsi-ctrl']
>>         'qcom,mdss-dsi-ctrl' was expected
>>         from schema $id: http://devicetree.org/schemas/display/msm/dsi-controller-main.yaml#
>>
>> According to the dsi-controller-main.yaml schema only two strings are allowed one is the SOC specific and other one is generic "qcom,mdss-dsi-ctrl".
>>
>> Shall I keep only two strings qcom,qcs8300-mdss.yaml and the generic one "qcom,mdss-dsi-ctrl" or if we want to support 3 strings in compatible sting we need to modify the dsi-controller-main.yaml ?
> 
> Of course.
> 
>> Similarly, I am getting error for dsi_phy compatible string only one SOC specific compatible string is allow.
> 
> So, what's the question? You are adding support for the platform. So
> yes, you need to modify the schema.
> 

Thanks Dmitry for the clarification will modify the dsi-controller-main.yaml to support more than 2 strings in the compatible and dsi-phy-7nm.yaml schema to support more than one string in the compatible.

Thanks,
Ayushi 

