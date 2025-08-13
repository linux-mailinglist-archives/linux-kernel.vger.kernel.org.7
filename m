Return-Path: <linux-kernel+bounces-766273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 761E6B2448A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02DFD17785B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EE42D12EF;
	Wed, 13 Aug 2025 08:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P9gi59EG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DE52EA47D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755074526; cv=none; b=tfZsAAUbaayNwE1tmWJ6X/gBW7E6jQ+IcLPIeLkQt+Fl+F8GxwrtZiv9bZ4aRYWaYT8RyKeNcLDutLKYyC7jBLB0gWHom+gvBDMaiu/pZiPo5Tbh/O4Tb7UTOKKuN/mUFdmuhQOP7ADr3takEojyoFCBsrEKvE8sr6WDtAHP8RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755074526; c=relaxed/simple;
	bh=WNNH0ET37ePoWKGj+PIeK6vmooE+vGlIujVn+r10wJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oUeei4boRuQQ2wDco1s3Bwwkd+pd5kqcr227TF6R2G04Lg2BxthSk2cRtasQZfrZFBmBIN+Cp9j4COuwtMX3ycORwkr3/q8mJpo4HO7538WR0I0DGAA38ETgmtoFuzm9BGv2khFRw7gGfSy3bhRV50ngutVGax0h5X3Ln7QJW4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P9gi59EG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D6mL4k028908
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UAbBLVeRLE4MnH9XmfajRWZXa7M9EckNL81JeGoopF4=; b=P9gi59EGmq01oSc2
	xE7lTt3uDuL5duZrwvfHkWzjApSmX3zvezdjcXFwVjJcUhFF1JXwgTz5RFTjIIgF
	c/NyR9tEn9OkrrCE1Ra4RFL0PkU2yxgAHx+dS1VLdkaP9YQD8Y5mH4CnUiFmIyg3
	PvKLu1GDutU/j4NSH1yfHeE+v1TtCovGm1T48MA7lgRs4IX/GU860r9oFjtCu+5J
	3Okwtufa9XIj0HZPEulwfxt9xIIDBhqIr216OVYWzdIKkWLy3mb9fXQchq7r1wUR
	9spj41CMsXm0/s0rcNKYzOHWAm+Y1akS5cVwhuXMJaH1SO42lBuo6ttPWgPb00Io
	/cV4nQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxj4b45k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:42:04 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-31366819969so7873316a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 01:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755074524; x=1755679324;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UAbBLVeRLE4MnH9XmfajRWZXa7M9EckNL81JeGoopF4=;
        b=J1UKqpvZz/Fa/zQDR+l5w4ZiIV4gQW9jp8ufrrPEqNi7FpzcTR5N8BTpFKJgetWB3o
         ioxmb9TuNypTP/QzlhkKFTtjLB3NYs/tQIErM2k8NHvy/NCVqpKAe2jN/hR/a/u2Q9RP
         1YWbLGg+hjutlqulwxUAyKTBe631P5BWS6/1Toc3RKPpZI3Fnh6RrA09bd59PhmrPVFy
         BvqTAO9Tzz2aL8Qv6FFzvDd97OEFgAzKzfaMKqOXGkwh6tHmurX6XoDEB/OXWmlW7Iai
         Sy14LeanPaQeEvLzQEGBdKEac+xvTG6eOdYGtg7NBnBypo27HuzvJltfwuAh3bHYVHW2
         a8ng==
X-Forwarded-Encrypted: i=1; AJvYcCXJ3/sWlC3sprU8Bo8k5ZVCqSTnDVAOvseTNpmsRUPaUC2HQD2Q7bScl9JC/kc7RhEvPH4mEcQosBAt8vE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Nu+hOJXJMqD+W+uAh8Nz2ZQ4LO+Wx9mjIn4umz1D19PZZtuT
	lA2Z7o+saUeaFgUDbjNx+6Kz6BHK1FXpnkkN9qza5pRjkWZ9ps7Bz345ykgtdMcPSW6QTmE43jD
	rEeNC7YZuBCUef2/8hwM+kiKd6b9RpwzIYfDa8SHiexHDynWPMc094ESZKRWs455NKZ0=
X-Gm-Gg: ASbGnctuxWxfU/zO9kWqZ5rEv1ZaGrc92mzMXWLrthtkOQcerg+r21HZolCP2gf3JNr
	QxR9pkryA+aFRP3wn6fpx7Fyh79cZ+2fEXxIS1iiLsXanxWydKYOst5sU2uIk3wk5gPmGQ386zf
	js/mQHBS2z2mnx/ApylHfjukJpTTvd6+5xDxEgtrOTPFk71hddKzBvbFSBNdlmXpIQKuxlDrqlj
	ENoFCkTSuGIliEmJB7hr3rrVyAnwGVi/axQqVoN/Nla8BplqwicXwh46CkBQN1S0xnv0htOGBcS
	AA4vIyOnkZNMmkJToI59lm85hrpheD+N9T09AlwBXAoIIE1x3+ufwZxeLENoNWYgQyJZVodoMup
	RYg==
X-Received: by 2002:a17:90a:e18d:b0:321:380b:9e85 with SMTP id 98e67ed59e1d1-321d0d65539mr2869301a91.8.1755074523527;
        Wed, 13 Aug 2025 01:42:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE78DKpGzv0dikvRvGBGlmfDBiN2T03wU71V1qUXMFRMqi3RCjr6n/8XTvRYRr2gYlKm8HcZw==
X-Received: by 2002:a17:90a:e18d:b0:321:380b:9e85 with SMTP id 98e67ed59e1d1-321d0d65539mr2869266a91.8.1755074522860;
        Wed, 13 Aug 2025 01:42:02 -0700 (PDT)
Received: from [10.92.163.82] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7bb0c0sm26483924a12.20.2025.08.13.01.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 01:42:02 -0700 (PDT)
Message-ID: <46dff289-9215-4dd5-b522-c1690abfd9ca@oss.qualcomm.com>
Date: Wed, 13 Aug 2025 14:11:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Enable audio on qcs9075-evk board
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_pkumpatl@quicinc.com, kernel@oss.qualcomm.com
References: <20250724155632.236675-1-mohammad.rafi.shaik@oss.qualcomm.com>
 <l7kwna7lebazoaqxz3zdkv325kw4ohsuidfzltdy3msfiburb6@iz4atympejdx>
Content-Language: en-US
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
In-Reply-To: <l7kwna7lebazoaqxz3zdkv325kw4ohsuidfzltdy3msfiburb6@iz4atympejdx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNyBTYWx0ZWRfX8rpwK+n/sKpO
 WNb85nnLYCeY1SpABFU04YWHXlUf9taz/XdkLolyloDHalXTegAx4zpJJ+y4hc2Gh/6NYdu9lq5
 HOmE7HfUEKldRmqgNzYTyJIHx7WtqnEsvGBYyqV5vsFUoRSnMSmVo8V4q1tGCHmt1IeYsUqGnyi
 zp9WQaceyYMJMxmqAYVn6iYDcvNZfVXvRosE6OknASgftkW/jHGvuJYVgtGGbnveNlg6PwCBrca
 Ch3rPO9actzsxC0qX7Qd96Tbs2FKiJLU/2YEdOqJ2lndASAur3vJLf8+j4utdvEOsckcBsUoTl1
 r6tFAd+BNkmZscyGoU0FaQHuLmPEpv95gysuz4zSjlwE3wjWV20wDl+AFHS1EpnElbTWyz0mmaN
 3ux3MsZX
X-Authority-Analysis: v=2.4 cv=fvDcZE4f c=1 sm=1 tr=0 ts=689c4fdc cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=9s0Y7IdbV4TWvyFR1rIA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: jDqyYF4RAg1mXfkkkN6h3XhRhTHl8_0D
X-Proofpoint-GUID: jDqyYF4RAg1mXfkkkN6h3XhRhTHl8_0D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090027



On 8/12/2025 7:54 AM, Bjorn Andersson wrote:
> On Thu, Jul 24, 2025 at 09:26:30PM +0530, Mohammad Rafi Shaik wrote:
>> Enable audio support on qcs9075-evk board.
>>
>> Introduce HS (High-Speed) MI2S pin control support.
>> The I2S max98357a speaker amplifier is connected via HS0 and I2S
>> microphones utilize the HS2 interface.
>>
>> DT-Binding link for sound compatible:
>> https://lore.kernel.org/linux-sound/20250519083244.4070689-3-mohammad.rafi.shaik@oss.qualcomm.com/
>>
>> ---
>> This patch series depends on patch series:
>> https://lore.kernel.org/linux-arm-msm/20250530092850.631831-1-quic_wasimn@quicinc.com/
> 
> Please resubmit once this is tested on a clean upstream branch.
> 
ACK,

sure, will resubmit on top of clean upstream branch.

Thanks & Regards,
Rafi.


> Thanks,
> Bjorn
> 
>> ---
>>
>> changes in [v3]:
>> 	- Updated link-name from HS0 MI2S to HS1 MI2S and sorted nodes in order.
>> 	- Link to V2 : https://lore.kernel.org/linux-arm-msm/20250616070405.4113564-1-mohammad.rafi.shaik@oss.qualcomm.com/
>>
>> changes in [v2]:
>> 	- Updated commit message as suggested by Dmitry Baryshkov.
>> 	- Link to V1 : https://lore.kernel.org/linux-arm-msm/20250525155356.2081362-1-mohammad.rafi.shaik@oss.qualcomm.com/
>>
>> Mohammad Rafi Shaik (2):
>>    arm64: dts: qcom: sa8775p: Add gpr node
>>    arm64: dts: qcom: qcs9075-evk: Add sound card
>>
>>   .../boot/dts/qcom/qcs9075-iq-9075-evk.dts     | 52 ++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 54 +++++++++++++++++++
>>   2 files changed, 106 insertions(+)
>>
>>
>> base-commit: a933d3dc1968fcfb0ab72879ec304b1971ed1b9a
>> prerequisite-patch-id: 853eaf437b81f6fa9bd6d36e6ed5350acaf73017
>> prerequisite-patch-id: 6d9fd3e0257f120cff342c287774454aad2be2e8
>> prerequisite-patch-id: 736cbcd47d5e7cfcc53fcaa7da920eac757ce487
>> prerequisite-patch-id: 4eddce6daeaa125f14380586c759f8cb8997c601
>> prerequisite-patch-id: baac180e8715b5cf2922f79346440d92569704f6
>> prerequisite-patch-id: 65730290d31f18e66e2ba0dfdeb1844d7442c272
>> -- 
>> 2.34.1
>>


