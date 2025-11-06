Return-Path: <linux-kernel+bounces-888231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A25C3A41D
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 11:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE8754FE5C4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711B029346F;
	Thu,  6 Nov 2025 10:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yk0b7d3p";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YWNIhlgm"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DFE2475D0
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 10:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762424692; cv=none; b=RRfg6K5pNZCPDo6RyNR8IhdzO22szUdtWYykjdv3eeIo+AYZJ9KIdw5uBK4wM7eF21sFTdTf+Z1pLuFQ5AZtoJtbHA7TO9IilyRXnApK7M1zhu8yg8ioSN9nqo5JRFR8Q+EVG3owd00MbVcQGA5gLBkglwHnNhG/8hAMEuo09xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762424692; c=relaxed/simple;
	bh=dUL9GA96UgBhGGpRlyDPakJvLtn7TCQFXMkd8MOLcIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D/ITRjNYaXncyag/Qv3pxLyms2qN+JnSab0WwUNoJAVsxXD0f/C14tPPd5DlxCslzC6lvR/bljW4zLSNvb7OH+Yb78i3ZV2xDpJMnv9oGmHo08M+D0b97+dRfuoRa3gFMAGbCrgE7/BhGAxTxtnaUCVLcazmPZ3E7TpP6WfeFb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yk0b7d3p; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YWNIhlgm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A66t1js3155448
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 10:24:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T3FPnVd8Ym8aaSbQ+iSIfEc2x9aZ55hFWfCZeM+5Wn0=; b=Yk0b7d3pvO4uD4Dw
	CEzWzPelUV832HOP55EnjA4bC1zLBdAQy5QaLh0i9oVaEuLwO3aH0EHFuHoqc3+g
	epx2HLVkOM93EgStASer8I3dzyRPGtUZOfrZA/SKcFWkI1V3xRVeuIizemkB1xio
	DRGVbZy361ydF9WSy0KybC/KcfFhfLXLMKx1AxDs/zOyvoF1X+tcKQ379UrLMiT0
	x8+nUImIXvDVcJqsG7R8p6hAHAyIauc6y1YEBr5PwKD8AHMMK6n6ZgLJ4Y7QMbkn
	G3SIm36pU4xT+4FW2pZ5+7NaDd/2IykrcbsjFesAVxbyQCSFBH8rykMv9LlktUnP
	SNoFBA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8pu0gkmd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 10:24:49 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-87ff7511178so741346d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 02:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762424689; x=1763029489; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T3FPnVd8Ym8aaSbQ+iSIfEc2x9aZ55hFWfCZeM+5Wn0=;
        b=YWNIhlgms6jpM/svfr+zbi20VHBG3TptG50L+lfTA+86l3ngtk++djfKkAeEDdiKtt
         GxbMeIKgnp9bR7P1gVxIySdoalHeSWY0jQEDGd1t/Imhbw/wa04nFiW2VKL+CD2IXvyn
         ppmX4h7wqvrJ8yuihSlbrTbKDIUEnlULaQLW6gi0BrzsUGSzRSu2Mqfc9lAbS64hKqxB
         iLBfhPLR1zY9t8wM3vOJjfdOyaHL0NZb5I/I/kWEspFFJKuwT3m1IW04N6Cl9nlBxIgh
         3/nl4+k3fl7PEpkppvTL/6qtzzsv2HjHqgs7b6TMiUyxDO4055R96NRYUPkhnudXlA8W
         jdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762424689; x=1763029489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T3FPnVd8Ym8aaSbQ+iSIfEc2x9aZ55hFWfCZeM+5Wn0=;
        b=ckfqLb0nMX7sUEnQqzA/IsFmKHQXF3bHy/FTn7YUhuovkcULoq8hDUxp0+D19Fp0Ki
         KAhVRlcFRw67ZJWFj6tI9/s5Pmc2XFo8v4g5fdW0x10+lnySO0LwZZ/A8fhZJ5GjeHAr
         uTXbFUkZQ9QA2rn4qbMLZTipJWo4VmeLc/UKBTcAmihjYNB7WMWgjSo+qhITe8SP0eg6
         EqyyJV6qwTvg2mlqAkT8reDa4aSZCG4CVv2SoKw+ZTGGlINg+Vt+Ru+3vTcDv8Y3yeXm
         1b5LoAAxC/INx90YOoJbrzc1vYpwjvcMAFJf2lv552IWKZuaFoasfE8JwWvg386DkKuE
         CeAw==
X-Forwarded-Encrypted: i=1; AJvYcCXfx5skCS1zvEsxTNEkSDv5XLbQIfLH1XrrOPiVJo1UDpmbkrctHjED3p1DlUWNb13i1W38/0I/gGqUX9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbBiingRSfOR8Rd9HjUnXIYhSJ1lPE4hPxp/Oh+njNwlfqT91u
	K5Rv++oIMWCiLvBKP4GFmZ8wug5SKZm32DuHZQcUaP7u2aaqYgJyI8gbXVJsbI2rOKN/wxNgQ9y
	2RQRVfH1eU/NJZxs5ibCcbxG3PNzD3xSUAYdzTR/3tBkYsdWWcphtbOh3xmFcAHoZEro=
X-Gm-Gg: ASbGncu+yKWcNomACVbbeovKkpBBXdIrah9nuNjkH5i6iKv7dvUoOGqr/p7ep5OXtgD
	riUTbs7fu0wVXJQw4J/NdMNPk1ZxT7hcEbJcERRZKAcuC+/GHDTYAB4osV7iTboKzhFXeQm9hae
	hjj8mYK2BzKB+wDg0H55dMAQYOjGfED40dj0iLhtRnY5uTXTTntAPuL6qoAvSnPJtyhw2bd6T2C
	t7snsitTUIXwCLGeVJftZvavUI0QVJDOPszcwCy+Aj1biDyYA/ytb+NZe0S3+fO/ZhI7KStO6wc
	tOTe5DICF31N8GeWhoDj4bnwhd6PZYM9apbhXzza8cwXcpSykV+66J56ESCEsa1mwz5a2aYdJdS
	7KmNj+WK17iuVp+Ccgnv/BX1wnX8Wg3DPA7/nZ66BDcikXcrXkA/dXwT8
X-Received: by 2002:a05:6214:e8f:b0:880:6fa4:f55c with SMTP id 6a1803df08f44-8807119c620mr62546866d6.6.1762424689241;
        Thu, 06 Nov 2025 02:24:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpTl+eYBXYQhxhYOgBBa23gIVBWM8pYsUUYotO6fUO+xNK+otH2KrRd+c7raZez9sRJ/s6sQ==
X-Received: by 2002:a05:6214:e8f:b0:880:6fa4:f55c with SMTP id 6a1803df08f44-8807119c620mr62546686d6.6.1762424688668;
        Thu, 06 Nov 2025 02:24:48 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7289335256sm185975366b.5.2025.11.06.02.24.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 02:24:48 -0800 (PST)
Message-ID: <e7ff4fa3-7885-48f1-8b0b-66d677147e41@oss.qualcomm.com>
Date: Thu, 6 Nov 2025 11:24:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: qcs6490-rb3gen2: Use 'edp_hot' function
 for hpd gpio
To: Amit Singh <quic_amitsi@quicinc.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_riteshk@quicinc.com,
        quic_rajeevny@quicinc.com, quic_vproddut@quicinc.com
References: <20251031085739.440153-1-quic_amitsi@quicinc.com>
 <1398b513-0948-4775-a71d-dd06ee2296f9@oss.qualcomm.com>
 <e00ebe76-ba73-42f5-8278-5cc3ee24709d@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <e00ebe76-ba73-42f5-8278-5cc3ee24709d@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA4MSBTYWx0ZWRfX70dtiS69CRnm
 OhLmWroKFDzwQ8hbRTO/kFUYFoRUkOhBmh98LVWkVMfwDsOTXyiZKv8XJONHhsVYFwnjYb3mvx9
 Q7yq5k0LWMK/FSBLMy7KW/HUAtCkdyms0xWmeGcucW/BgtnbkXLx4qfPnZXxS+TUYuLvef2dAz9
 Zql1ENRbuZnPiD1OEvcL4M2uM4ywBhxE++46JlflV6m+U3ruh1au0Q4VgLn5uoE62xgMkY12Iey
 vchM4NpScnHMuHlhjLiIW8CrLHQfsqJE1gYtGa4lphSF9KsZFk8kqXWPc2lxkecb68rdZ1Hpnv2
 xdXcrKM8Aep9utcbD2565nIXa4w4ZgIZz2XQhoH4OUjdoieLY1qtDj1MOSGig7KghaQi0uvUKg0
 EeAx/WoPM+iaGLFlIdkxnF7IMZhDuA==
X-Authority-Analysis: v=2.4 cv=bIYb4f+Z c=1 sm=1 tr=0 ts=690c7771 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=SbLgC22CVVW6PPrUsBoA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: FKAMOcFftMieruJ5nX-ewJSK1S1-AMyx
X-Proofpoint-GUID: FKAMOcFftMieruJ5nX-ewJSK1S1-AMyx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060081

On 11/6/25 9:23 AM, Amit Singh wrote:
> 
> 
> On 10/31/2025 2:37 PM, Konrad Dybcio wrote:
>> On 10/31/25 9:57 AM, Amit Singh wrote:
>>> Currently, hpd gpio is configured as a general-purpose gpio, which does
>>> not support interrupt generation. This change removes the generic
>>> hpd-gpios property and assigns the edp_hot function to the pin,
>>> enabling proper irq support.
>>>
>>> Fixes: 756efb7cb7293 ("arm64: dts: qcom: qcs6490-rb3gen2: Add DP output")
>>> Signed-off-by: Amit Singh <quic_amitsi@quicinc.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 3 ---
>>>  1 file changed, 3 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>>> index c146161e4bb4..caa0b6784df3 100644
>>> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>>> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>>> @@ -49,8 +49,6 @@ dp-connector {
>>>  		label = "DP";
>>>  		type = "mini";
>>>  
>>> -		hpd-gpios = <&tlmm 60 GPIO_ACTIVE_HIGH>;
>>
>> I think this change will take away DRM_BRIDGE_OP_DETECT which is very
>> much desired to have.. (via display_connector_probe())
>>
>> Konrad
> 
> Yes, this change will indeed remove DRM_BRIDGE_OP_DETECT.
> We'll be relying on the internal HPD line (edp_hot) that's directly connected to the DP controller instead.
> 
> Do you foresee any specific issues with this approach?

No, looks like I was overly cautious

Konrad

