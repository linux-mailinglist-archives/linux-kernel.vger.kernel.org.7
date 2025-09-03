Return-Path: <linux-kernel+bounces-797574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93183B41209
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 03:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F845175C3B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 01:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999A132F76C;
	Wed,  3 Sep 2025 01:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BAmTMmeY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF3E2E40B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 01:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756863924; cv=none; b=aKDb/aBkCuqVKi6FfB13yFs+LoH3iWDEWO2NZ6REwTaBgH/1Vk1yyWrjxcWVASEcbKH2ngiXV7rwcF9AAlHqRWeOTtXLZ1Nn/Z9wGGKNLzjpxbCsP6mo+kN9cSeQj8WOVSoP+VbmGafEpsOzEpX/1IC1MS1cuqq/Vl0sHIyC/jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756863924; c=relaxed/simple;
	bh=FwZLZxIxYTadK2Kduz15dFpZ/khEoBz4UzAbFb6JWcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BWD2O0+1mQ6aSbw1AqXjjygOSQngmKaPVCggjBiTA7BrbaUG94ULg5eyqlg22rrP3Cx4pRIcSqamPwmKMwLyAFoR8B0yNBAxQspK1ZqqCFBjt1kFu5K/fVt7An8aeOA07YPhcuUYpJB8HLY/umdoSFx7ELHXEVISgP0D57w9qgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BAmTMmeY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582EqKEu019740
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 01:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vSKVIY6OYbeZ9o9Z+5cggaWcqnF8AUnxpa/ouOb+evY=; b=BAmTMmeYz/zLdI26
	UdP/zJesx7wVFl//F4OTnvJ4Qt30IgchreDp84XnylpgCqegWdElUozRk4dlEUHp
	meAMA8ilw6GORIgES7lMb1L/s7h0NoHpOJ0fm1l7YUtjL9qfe9J504KUS4toI2Ro
	H9k+KlNTE6DZB3SDHDoSjEDtolMOGourju4JshBAohG8NlHMx3Z2UIv0R2hdLcA7
	johUpBTRzkHWq6aJ24MsQl2P6/a3O2xnZ8is4kMzLrGJLOZzdyzGfYbbIzt9galJ
	NzyzdiGxpEG7eNQSIOqxL0UZ/MziNK/xxrbFW+amR4bQGXLCFWtbwcntg2/9iU7K
	3VO05g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urw01ud7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 01:45:21 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b4d48818a04so3724395a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 18:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756863921; x=1757468721;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vSKVIY6OYbeZ9o9Z+5cggaWcqnF8AUnxpa/ouOb+evY=;
        b=t+v4PjWeFgQPjT4qA1mv3EdiAt6Hrrvk7uFjyFha7RQdwZV2Hj60hbDxcIUD2IB6WG
         ee+EM5n0KW8o1hua8YBowKlOmR/XELvab4wh870JCfn325FFT8C35ToljyPG3tKqow5s
         Vb2yF/jN54s4GCQ5e5hTBJl8AzTiqt76+0moyhjayMz68Z2vtnXPUBMJVoF3H/epRdFc
         XHImwle2s1UtorPog6ac+kwte+5PmhczYbqaCzbfy3AoqEbxPMsHU2GWusS82Zrh3H5A
         FrOEJWyePU67Nl9PgtPeVHobS/MfcNwXbT1qvwdjmMeVUlhVlCeb1cnG9GK+lHeXICtc
         O9BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq2e6uUZzgmA6cZtTGQom+dWaCjUy+vmRLa7Hz8wncGwNmzbwqgNCD33wI6lRT39wNVUrAeNAcs3Plk4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ/0VqpAguLkNtsAYBQQufv2QuDaWCx/TBVOVuVmfydW/h6Ko5
	/WtvcAjCelx+ezzi9x/3XewYZLMxa/26wFyLeZymVtwSuGeTHr4NU9V1xXZi00keF8mcqBoMGpn
	2eqhki81ytUSMMH4igR/q2LtUCiPRzmH0FIhuqeZYqX0X8LVn7jV+xTLTr3YLPLvZ0nU=
X-Gm-Gg: ASbGncu6LyvnfkIv9wefmVosx5JlLxabLtCyJvj+imYJjdATbLDLM0wlyt+MyPSP04+
	CfGyUpR/Z2pIJ4q7nYnD/7vI/WHut05kNxJ3g9e2XdIl8QKHVENxESlJDdBtVz6UO3JkDr/FZDw
	R8Q/HhWkeiA533sxlCk+xFs0v7yAiYtlt8NgczWsGrfMYpZ7c6HG0uQLlfZlhXKS512jaiW1Mol
	QhyjlpRYbpzNH0bdyT2voAbTOaphfZlFw30pgLzuX+elPbuGUdV3Ali4Xy/XnwycVIpJ4eKP16p
	p0IwE+Q9o9nFEkEVC0/DbwCHimOKSMo1PxyCZQviTzKFpkif3WYD139Zzo2PErDRxdUwnEZkCjs
	H6lNmXFfKebF5pA8fMAHxOVwT5s+wtD+wBus=
X-Received: by 2002:a05:6a20:2447:b0:232:9530:2300 with SMTP id adf61e73a8af0-243d6e00b1cmr18787182637.18.1756863920617;
        Tue, 02 Sep 2025 18:45:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPcu7WQqWP/xkbBlXV4L0CiyF0ufiS+LD89LO/RgiStFAaC6nkWqXiyzMSSMmTsSRTo8KIkA==
X-Received: by 2002:a05:6a20:2447:b0:232:9530:2300 with SMTP id adf61e73a8af0-243d6e00b1cmr18787140637.18.1756863920013;
        Tue, 02 Sep 2025 18:45:20 -0700 (PDT)
Received: from [10.249.10.141] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f992d3de9sm2574010a12.14.2025.09.02.18.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 18:45:19 -0700 (PDT)
Message-ID: <52c1f77a-b3b9-4c4f-90b8-1ff2ac042724@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 09:45:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] arm64: dts: qcom: Add display support for QCS615
 RIDE board
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiangxu.yin@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Li Liu <li.liu@oss.qualcomm.com>
References: <20250827-add-display-support-for-qcs615-platform-v7-0-917c3de8f9ca@oss.qualcomm.com>
 <20250827-add-display-support-for-qcs615-platform-v7-2-917c3de8f9ca@oss.qualcomm.com>
 <yutyrfb73wbxlweoq3mc6ezyqr56snzmznw3k6mcbc56fpfayg@3h5jwymlo3ol>
 <0c2a4877-d63b-4650-b7d4-a06a2730c73c@oss.qualcomm.com>
 <zoogyjua4l6e2bgsvxx7w26n6v2hwnp2pvkizzzsds3c6cgaag@2bvqdl2z5ds6>
 <4913e937-3892-42ac-8145-cc9c2364242c@oss.qualcomm.com>
 <snery6acisgvxtofsrbbqtpoirh5ffyha64lz4zekg3kvwrsyv@tfyydedc7ddm>
 <ae4ef090-7edc-49f8-a964-090bb94ff097@oss.qualcomm.com>
 <7sd3rvvwnte7dub6vuywi6np7rig547ugfpu626ruufx7psrds@igqdchhianju>
Content-Language: en-US
From: Fange Zhang <fange.zhang@oss.qualcomm.com>
In-Reply-To: <7sd3rvvwnte7dub6vuywi6np7rig547ugfpu626ruufx7psrds@igqdchhianju>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: NXm_7xfal6DPIeLNE6H-VHlE67qbCFjw
X-Proofpoint-ORIG-GUID: NXm_7xfal6DPIeLNE6H-VHlE67qbCFjw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfXz4Rx9cZoGPmv
 I1V87StV2U/D7IEbRnxcnN2hyhpeX69xNUyLj6KVghtTBTGwgZsaTrEg8VBkL7p6E7Hexdab1mJ
 pbI+0+zMOEAxf51l/8jTCy458bQKS9iI67gZBzqlL9wBVFHglHNnmW9pz+e8Hkd9uu1DS6zO7vt
 5x909UL1HuZGFifqRYIga+jlhKQX+hKbvaWEMvF85Gy/cmoA6LwxRHYpIAKqPwF3Mb+hFwQOqy6
 c9fmcYoxnfMInU59ArZ3dgUlUu4MITnO458EET9TFbezNK2K++GRIXBhsQ4Kq0qqzCCcTidAHOh
 Z0EOVLfK1Pg0k5fC5sNWxzrZIekE7ra0V0Q/zntEafFOvBU+90FYQ2frXH0VEMrfBhK3Pttycbi
 Lgp+mPBS
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b79db2 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=-S4KrNXkqzQhTUXETMwA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_09,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027



On 9/2/2025 9:56 PM, Dmitry Baryshkov wrote:
> On Mon, Sep 01, 2025 at 11:23:28AM +0800, Fange Zhang wrote:
>>
>>
>> On 8/28/2025 7:02 PM, Dmitry Baryshkov wrote:
>>> On Thu, Aug 28, 2025 at 01:12:14PM +0800, Fange Zhang wrote:
>>>>
>>>>
>>>> On 8/28/2025 12:41 PM, Dmitry Baryshkov wrote:
>>>>> On Thu, Aug 28, 2025 at 10:57:41AM +0800, Fange Zhang wrote:
>>>>>>
>>>>>>
>>>>>> On 8/28/2025 4:01 AM, Dmitry Baryshkov wrote:
>>>>>>> On Wed, Aug 27, 2025 at 09:08:39PM +0800, Fange Zhang wrote:
>>>>>>>> From: Li Liu <li.liu@oss.qualcomm.com>
>>>>>>>>
>>>>>>>> Add display MDSS and DSI configuration for QCS615 RIDE board.
>>>>>>>> QCS615 has a DP port, and DP support will be added in a later patch.
>>>>>>>>
>>>>>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>>>>>>> Signed-off-by: Li Liu <li.liu@oss.qualcomm.com>
>>>>>>>> Signed-off-by: Fange Zhang <fange.zhang@oss.qualcomm.com>
>>>>>>>> ---
>>>>>>>>      arch/arm64/boot/dts/qcom/qcs615-ride.dts | 150 +++++++++++++++++++++++++++++++
>>>>>>>>      1 file changed, 150 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
>>>>>>>> index e663343df75d59481786192cde647017a83c4191..f6e0c82cf85459d8989332497ded8b6ea3670c76 100644
>>>>>>>> --- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
>>>>>>>> +++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
>>>>>>>> @@ -39,6 +39,76 @@ xo_board_clk: xo-board-clk {
>>>>>>>>      		};
>>>>>>>>      	};
>>>>>>>> +	dp-dsi0-connector {
>>>>>>>> +		compatible = "dp-connector";
>>>>>>>> +		label = "DSI0";
>>>>>>>> +		type = "mini";
>>>>>>>> +
>>>>>>>> +		port {
>>>>>>>> +			dp_dsi0_connector_in: endpoint {
>>>>>>>> +				remote-endpoint = <&dsi2dp_bridge_out>;
>>>>>>>> +			};
>>>>>>>> +		};
>>>>>>>> +	};
>>>>>>>> +
>>>>>>>> +	vreg_12p0: vreg-12p0-regulator {
>>>>>>>
>>>>>>> I should be more carefull when doing reviews. I thought that it was
>>>>>>> pointed out already and didn't some of the obvious things...
>>>>>>>
>>>>>>> First of all, the nodes are sorted. By the name, not by the label.
>>>>>>> Second, there are already regulators in this file. Why are the new nodes
>>>>>>> not following the existing pattern and why are they not placed at a
>>>>>>> proper place?
>>>>>>
>>>>>> Initially, we referred to https://patchwork.kernel.org/project/linux-arm-msm/patch/20250604071851.1438612-3-quic_amakhija@quicinc.com/
>>>>>> as a reference, but its node ordering seems a bit unconventional.
>>>>>>
>>>>>> Would this revised ordering be acceptable?
>>>>>>
>>>>>> ...
>>>>>> + dp-dsi0-connector
>>>>>>
>>>>>> vreg_conn_1p8: regulator-conn-1p8
>>>>>> vreg_conn_pa: regulator-conn-pa
>>>>>> regulator-usb2-vbus
>>>>>
>>>>> So... Existing regulator nodes have the name of 'regulator-foo-bar'.
>>>>>
>>>>>>
>>>>>> + vreg_12p0: vreg-12p0-regulator
>>>>>> + vreg_1p0: vreg-1p0-regulator
>>>>>> + vreg_1p8: vreg-1p8-regulator
>>>>>> + vreg_3p0: vreg-3p0-regulator
>>>>>> + vreg_5p0: vreg-5p0-regulator
>>>>>
>>>>> While yours use 'vreg-baz-regulator'. Why? Don't blindly c&p data from
>>>>> other platforms.
>>>>
>>>> Got it, The revised format will be:
>>>>
>>>> + vreg_12p0: regulator-vreg-12p0
>>>> + vreg_1p0: regulator-vreg-1p0
>>>> + vreg_1p8: regulator-vreg-1p8
>>>> + vreg_3p0: regulator-vreg-3p0
>>>> + vreg_5p0: regulator-vreg-5p0
>>>>
>>>> Let me know if you have any further suggestions.
>>>
>>> What's the name of power rail in the schematics? vreg-Np0?
>>
>> I reviewed the Ride board schematics and found the following power rail
>> mappings:
>>
>> VREG_1P0 -> DSI0_DVDD10 / DSI0_AVDD10 -> ANX7625 AVDD10 / DVDD10
>> VREG_1P8 -> DSI0_AVDD18 -> ANX7625 AVDD18
>> VREG_S4A_1P8 -> DSI0_DVDD18 -> ANX7625 DVDD18
>> VIDEO_OUT_VREG_3P3 -> DSI0_AVDD30 -> ANX7625 AVDD30
> 
> Then it looks like regulator-vreg-NpM is okay

Got it, I'll update v8 today following this format. Thanks!

> 
>>
>> would the current approach also be acceptable?
>> or we need configure the power supplies strictly according to this mapping.
>> Appreciate your guidance.
>>
>>>
>>>
>>
> 


