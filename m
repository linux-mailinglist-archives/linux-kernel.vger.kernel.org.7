Return-Path: <linux-kernel+bounces-604712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA541A8979B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 11:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1399A3B7FB7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 09:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE7D27EC89;
	Tue, 15 Apr 2025 09:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Get02uRv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C86B27B50F
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 09:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744708402; cv=none; b=Go85EL/pXxULLaIquFUzQvcxtfbJ+nc46xRHf1wViugGBgcMO3m8+ylVUuV4azFHl5aXxnHBhiDHE31Q43cDEGYDiwwS+bOoDxWLRyfSia/rbmw9CnWzP+f3ZNaFlh3miVOPD3hzv5USPahVOkoRwYuNeHiqSV/14VEsCrKqcH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744708402; c=relaxed/simple;
	bh=Y3cF4eZoT0Tuq6lyHi7dJ/kFBdodGF0lWp44qmkdgv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AIZ2PzM/E1AMN5VBX6xNLs75AXD/ydwieg7ZFF+dATkJGFS7rJEm2sNCZ66mBUda0LCi3gZ58hVLhnBT0TLR0Byn6jp7mO0QJTQVya3YocP3h9x+XMGmkvUW1zgVwryxkziEY1b/kzQY2zFYo1GSSc1P/udQ2umymAk6kt5Xioo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Get02uRv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F8tIvh024991
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 09:13:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+rR/+ftTAIsUkZ0fyx0/CUkeHOOpZznIIF7t4NeJeNc=; b=Get02uRvEClbLNVW
	Za/NGMqD2SjwhAF1sQ+mUGp65SqHxDQ+/nEsap/p/jPrSq6ecxoLpky4Cz0LrCjh
	F75iploxuFy3ymU2u2C22tdJwydEt80jEY880WksKEO04ZKgtBI8Ss+IZ84pErPi
	bGu0ZcsDvYJbfUcEJZHWrE0+DgVc7xeL0Ri+7KHMuWRKTO6T+Ae3odONED1qhwh9
	PbpckzaoYHB3rjVCjV74QlB66dqzewYhrXjLyy2I1WPoA2MO2yugxjk5FhYWgkQM
	h3hUD81z06d3r+POH6pRKqxlu2Mov4PJUfeirxp/SipoaRXkjc8D+JyW66JaZv5W
	0p9Ing==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yf69qg5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 09:13:19 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c54be4b03aso102456785a.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 02:13:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744708399; x=1745313199;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+rR/+ftTAIsUkZ0fyx0/CUkeHOOpZznIIF7t4NeJeNc=;
        b=xQju6cYY4IHzvfjW+xnQcUFCwyOPBtWLyfI+I/TjJPIHwntHm34ez5fasqlvyfrL9V
         UZ+uMfw0VSCngcr2lz7yXMiC58YLXp81Egl2EcdTtFamPaITILbu4YoaAwjd8li8/jrP
         NVSs419+qpLzAGOMkyHnN+hoIQv6zJ90EkAb5ZgIiHsp16QxxThK9tl+zaZEYj3luc0d
         xWacloh6h4p3sCP2mdCnO+qfb1fn2tA3Bo/V6RtHf+UxOHsdYd43hEzV6oeQy4WPopcZ
         y/ut58rPz3TpYuQm+Med8FLBtzr5aoO69+tI2tYopwuG0Yz3ODQ8LF9tpO9q54yX3B4f
         SpJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMDEaKnLEhGVB5jo+LK0rpBDGRj44kLmOGyY+UAJP9kQgI+FcACMI6d1uQ3TDT5OnHKDVY6rrrLQzymXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1EQhEqLV270l9FIxVhSHb78dSZsv72K9kbNETtfGwehbCawMx
	KWGOut6gm/jFawjSNNySY+AOFIKtyFq3AtnDPyvpgPEkFIXDP0X7882r1LtX5EzG4H9AKeH8BZ7
	f6ca0fg0QmZqwHK6mW+667LPGETLsl+OtzPTFMnIk7so3RLDApEIvbEDWnC2MoAo=
X-Gm-Gg: ASbGncsfQ/JtSzhu0x6ycVEYnaiZ29cKXDJQ5geVvb/w9gtNay02uCzK2e5TvopWFqj
	nAZ0LAYNsWyjoK2NHEhMh2Z6K3TgIjajh3DedxUc2mHG3MOkm6DFaBsfX61QJE/xsh+LtC1dWua
	xKqWCUfqj9nRpZQk4SHTPw7zsegvOpaVeoA3spO0/XxrDVH4DvDYU8drAjp/7WXdnwcNSurBr/u
	EVr3xRXqPAsxK7jqz9K06aYpTQx3fz/hRQF/a60i8J2cUrXHO+DhnwkoYKY5lrumTm+9CLUlqDq
	nbFN6/ewWnRMIQLRSkCZmV80288qcf2m5C0nEY2nnaMyDqG4NurvHfPirNtwMHKbfbo=
X-Received: by 2002:a05:620a:450b:b0:7c0:a1ca:93cb with SMTP id af79cd13be357-7c7dd7355f2mr150177085a.1.1744708398827;
        Tue, 15 Apr 2025 02:13:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5b7ibStatFaNQd403wS1RPgFmV1TghCWOGZLKiMrn2UNIPOtfVqPrSYwuKnQ0CSbSEiFzWA==
X-Received: by 2002:a05:620a:450b:b0:7c0:a1ca:93cb with SMTP id af79cd13be357-7c7dd7355f2mr150176085a.1.1744708398451;
        Tue, 15 Apr 2025 02:13:18 -0700 (PDT)
Received: from [192.168.65.246] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36f6491c4sm6271585a12.81.2025.04.15.02.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 02:13:17 -0700 (PDT)
Message-ID: <702ba6b2-b84d-41e0-aedf-747535d6ab32@oss.qualcomm.com>
Date: Tue, 15 Apr 2025 11:13:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: sm6350: Add video clock
 controller
To: Taniya Das <quic_tdas@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250324-sm6350-videocc-v2-0-cc22386433f4@fairphone.com>
 <20250324-sm6350-videocc-v2-4-cc22386433f4@fairphone.com>
 <1c09fee5-9626-4540-83fb-6d90db2ce595@oss.qualcomm.com>
 <9eb6dfd7-2716-4150-9392-98e26892d82d@quicinc.com>
 <e3dda8bf-e19e-4dde-83a4-7876ca81e5e6@oss.qualcomm.com>
 <69fba227-ed47-4004-9451-777ca19b687f@quicinc.com>
 <cfa4003c-e8b0-40f6-821d-07f8d44752af@oss.qualcomm.com>
 <0db798bf-04b3-40b5-af90-7dda5b606727@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <0db798bf-04b3-40b5-af90-7dda5b606727@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: nFgZoRiCWGiPiu48MGnxWn8F1ODwu26k
X-Authority-Analysis: v=2.4 cv=JNc7s9Kb c=1 sm=1 tr=0 ts=67fe232f cx=c_pps a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=6H0WHjuAAAAA:8 a=KHwu0kPLBxgQqcPLut8A:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: nFgZoRiCWGiPiu48MGnxWn8F1ODwu26k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504150063

On 4/15/25 6:05 AM, Taniya Das wrote:
> 
> 
> On 4/12/2025 12:56 AM, Konrad Dybcio wrote:
>> On 4/11/25 1:37 PM, Jagadeesh Kona wrote:
>>>
>>>
>>> On 4/11/2025 2:42 PM, Konrad Dybcio wrote:
>>>> On 4/11/25 9:15 AM, Jagadeesh Kona wrote:
>>>>>
>>>>>
>>>>> On 4/1/2025 10:03 PM, Konrad Dybcio wrote:
>>>>>> On 3/24/25 9:41 AM, Luca Weiss wrote:
>>>>>>> Add a node for the videocc found on the SM6350 SoC.
>>>>>>>
>>>>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>>>>>> ---
>>>>>>>  arch/arm64/boot/dts/qcom/sm6350.dtsi | 14 ++++++++++++++
>>>>>>>  1 file changed, 14 insertions(+)
>>>>>>>
>>>>>>> diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
>>>>>>> index 42f9d16c2fa6da66a8bb524a33c2687a1e4b40e0..4498d6dfd61a7e30a050a8654d54dae2d06c220c 100644
>>>>>>> --- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
>>>>>>> +++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
>>>>>>> @@ -1952,6 +1952,20 @@ usb_1_dwc3_ss_out: endpoint {
>>>>>>>  			};
>>>>>>>  		};
>>>>>>>  
>>>>>>> +		videocc: clock-controller@aaf0000 {
>>>>>>> +			compatible = "qcom,sm6350-videocc";
>>>>>>> +			reg = <0x0 0x0aaf0000 0x0 0x10000>;
>>>>>>> +			clocks = <&gcc GCC_VIDEO_AHB_CLK>,
>>>>>>> +				 <&rpmhcc RPMH_CXO_CLK>,
>>>>>>> +				 <&sleep_clk>;
>>>>>>> +			clock-names = "iface",
>>>>>>> +				      "bi_tcxo",
>>>>>>> +				      "sleep_clk";
>>>>>>> +			#clock-cells = <1>;
>>>>>>> +			#reset-cells = <1>;
>>>>>>> +			#power-domain-cells = <1>;
>>>>>>> +		};
>>>>>>
>>>>>> You'll probably want to hook up some additional power domains here, see
>>>>>>
>>>>>> https://lore.kernel.org/linux-arm-msm/20250327-videocc-pll-multi-pd-voting-v3-0-895fafd62627@quicinc.com/
>>>>>>
>>>>>
>>>>> On SM6350, videocc doesn't need multiple power domains at HW level, it is only on CX rail which would be ON
>>>>> when system is active, hence power-domains are not mandatory here.
>>>>
>>>> 6350 doesn't have either MMCX nor a split MX - shouldn't both normal
>>>> CX and MX be in there?
>>>>
>>>
>>> All clocks & GDSC's of SM6350 videocc are only on CX rail, so it requires only CX power domain. But when HLOS
>>> is active, CX rail will be ON and operate at a level above retention, which is sufficient for videocc to operate.
>>> Hence clock driver don't need to explicitly vote on CX rail.
>>>
>>> The same is not true for other rails like MMCX and Split MX(MXC), hence clock drivers had to explicitly vote on
>>> those rails.
>>
>> I'm worried about MX being undervolted for higher OPPs
>>
> 
> From a videocc PoV there is no requirement of Mx on SM6350. The CX
> levels would be taken care by Video SW driver from their defined OPP. Mx
> at system level would be catered via the BW votes.

So I'm specifically thinking about the videocc (and other) PLLs, which
have defined vdd levels downstream - currently we're relying on random
luck rather than ensuring each one of them has its requirements fulfilled

Konrad

