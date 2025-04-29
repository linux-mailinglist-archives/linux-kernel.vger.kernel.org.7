Return-Path: <linux-kernel+bounces-625664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7366AA1B34
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 21:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 424E44A8538
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 19:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74BE25A2AB;
	Tue, 29 Apr 2025 19:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JYhB/F+I"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AFF259C94
	for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 19:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745953913; cv=none; b=hevCt1ijocrq+AR1WS8uuBKKRtHcUJS4XSHaCE0vK/R2SnXK0cw9NTSZze7lXAcBCX1Bwx9eoNd3nr5gN0SzgzVgrtLSXcn64QsR3E+U0KZWIvgMMeJhINPoC0rtbU7NovTTtaUgbapbopyyXUWeAiyIsxVFMRtI5VK5ErA4tBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745953913; c=relaxed/simple;
	bh=OkK1nuaCR4f+liV3BJU9Hn/XfSqQ7ubqyxI2NRvoeoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eco3meXuBLI40Tf95FXyw6PWv4cyv/IPWqxcn38UuwXnKXMNpp75KcXcpgXX8x6/ropFs+gi8XOeB8AfJkrEbm51Gjt8BmJdCTuFxBqq0IJM0bzUuI8ZWEbMizDmG6TrAlOzXdTHGhKNTh3T775YHgKEXpbUz8fpSPaQon94IfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JYhB/F+I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TA9G5V015867
	for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 19:11:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eOuPzQ1u72JzG/hJiGVhd19vPe7xFI8iogxywpgJCzM=; b=JYhB/F+IWpwTlCJg
	KnfJ9GlG7u9YoydPi8PMQ4Trv+safIXYDPIlpDS5gjU/sOv/vrup/F6PlwkEZnU3
	CcJ/LOO61aJFvV57YZFg4oIbFf/ppg8UppuvlbnUciSnJGUdmQWyO+3+jm0i7XLb
	66TXe/axtOCzJWWuCtQnDKXFVkWqKZO2ksYm1l+1rttxvWDEFNcsNrqurytgbVCp
	G3DOrJob7G8CVcFiSSP4UrgUe6iotdW9wAsyvMPfviaLbp0t7zFj03khF6kPXjvK
	J7Tv1alpmhzxlnyS+SsQFJo6tKKPuHwdia/jb2gOf6pV/YIK3iUXZR5aGwULlUPg
	O4K5Sw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468r8hvhk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 19:11:50 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c547ab8273so34734185a.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 12:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745953909; x=1746558709;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eOuPzQ1u72JzG/hJiGVhd19vPe7xFI8iogxywpgJCzM=;
        b=PC3tODYKVhqCqM6XwHnv3vaKPzzE5JtaPGC8ZDcUQP2GpdXN71JRoftFAtd+Pl0YNk
         IIW4s+7itwmg7bxS7g98q9tV9UZUNQm8zJSQhi3nggnK7JjsYykbvETtytdt97trmMJ7
         mfstyqy8MrSPVmgfQa9kw7H+uJJZwpzyj30+R/vpZks9b7AcRT16F4cWbIinghKoz0tG
         NjLEbmFJvNp2NXMhU6WkUJqMG0kVKoA9WnSNpN5uqWgZXumOC2k8xjEyfkVju/YxLARk
         pH9IIt1nXo42W+R81QX+CxcYXLfXjCnU49RecYxkdqSezbCTIknJ2AiPZmE9YmWthM36
         KWJg==
X-Forwarded-Encrypted: i=1; AJvYcCUCglyY+Xax6GSTLyBiYs8ltLmo/iB8LaX3wrWE+UWr7zWrIF7fswCtPbL3s2KFcIDdyRzIMMQSS1Y5kHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YytGF9B+A8GECYpUyB5nEteuZ+SIUPspaumw59jco3NQuNhS0eb
	p18Mf02h64fmEC5iQ4C4kg7CF5YVq8gS0KqOJetghYOLKBvtDf3WP9k3BF9R+nV+GPKtxYW6KDf
	Tw5FR6CgvlrCmQGxR19ZrDocLl5tQtVzRrEGjr6fWkiJSb3fJVAV0QoQNSCWmesQ=
X-Gm-Gg: ASbGnctoCltSCKqAOcPSqkiKvP4jRQtrtIYf7F8Buo808xJAVlKYUp5HtS8qosSXk5n
	TCFEx+1pxtWAAcD8Rs/oRQTjdWx/JKKAk3nrIhKdE80B29zBFCRw3/MYbOS6tF0P4+YZ8mGeT6e
	Ivwr6epfyAohbWu0HChv+El1rBZ1tjT0TidoEXf5Zh7eFvTom5sVw6UvxmR7ULtvqClLcfPRjSm
	RoNm9wbz6EeQOZR10xYptz+Vku6sZFEKR7fk2zFhnHE06nq2dcbeATgoGBZ7xO8K05w7mvOKGR4
	D8gjSGIoTOSQdyyG3x3Yrq3klzbVbUHE8uRBaQw1ay92720emBG7OhRHkF5QqzJM+g==
X-Received: by 2002:a05:620a:262a:b0:7c5:6fee:1634 with SMTP id af79cd13be357-7cac740676emr18903585a.3.1745953909282;
        Tue, 29 Apr 2025 12:11:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECUOmkr/kU1YdONLI/cWvvS8Ar/800yEHeVe/K9arB9rF847RbVX558EdSx3WQcz0J6BfL6w==
X-Received: by 2002:a05:620a:262a:b0:7c5:6fee:1634 with SMTP id af79cd13be357-7cac740676emr18901585a.3.1745953908944;
        Tue, 29 Apr 2025 12:11:48 -0700 (PDT)
Received: from [192.168.65.43] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f703831dc3sm7752043a12.67.2025.04.29.12.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 12:11:48 -0700 (PDT)
Message-ID: <9b6c5f67-0bbc-490f-9982-4e28218aa6eb@oss.qualcomm.com>
Date: Tue, 29 Apr 2025 21:11:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8750-mtp: Add sound (speakers,
 headset codec, dmics)
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250424-sm8750-audio-part-2-v1-0-50133a0ec35f@linaro.org>
 <20250424-sm8750-audio-part-2-v1-2-50133a0ec35f@linaro.org>
 <dd271e8c-e430-4e6d-88ca-95eabe61ce94@oss.qualcomm.com>
 <e61e17ca-fed7-4712-96fc-a9a2339de1fb@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <e61e17ca-fed7-4712-96fc-a9a2339de1fb@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: qUuVUC0zXfVen3numZogRckV1LgpCHNY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDE0MSBTYWx0ZWRfXwCACfCuEfZG1 abfVAk4Eshxs5efdN5x3OTac20AlT02bkRsHanR/A+zOUqt81L433E7bZ+YNDw/FqD75yukKfC7 Cf+dcTI4Po3ci6LXhsoThnszhqC7hNx2RRWntgg20mxG/SnxA0yoDGbImEN6iWP29gM2XsDVb1A
 EcCC5VeBwT+xE/KEmc5zVrKRrN/Rt+mvUar/LxREZ7+bGyJqO7KF5vxGDNFjZJwJomVtE3teM0N wfrlcSImn/azOay2daggliq0HOVseEQUdr3l4L5jIL5Em7aPihNDlFGEghSvZ1+fEIevKSZ+va9 BTzLs8mhXOmd8kvHXfRIOf8lgyw3N5aOBR9Q2lpMb30WCSLcCXvlsuOt+rMNDRBxn6E/KVhaLUi
 e0bP8tLqijXnOyKXocoAsE/dabcfvNljrlKhY7vO+PDG2v0Cp70kUafy0/PHhRH+HAnXMYJB
X-Authority-Analysis: v=2.4 cv=cfzSrmDM c=1 sm=1 tr=0 ts=68112476 cx=c_pps a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=KKAkSRfTAAAA:8 a=8veyJhrg5W-E9c7t-7UA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: qUuVUC0zXfVen3numZogRckV1LgpCHNY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_07,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290141

On 4/28/25 4:41 PM, Krzysztof Kozlowski wrote:
> On 25/04/2025 11:30, Konrad Dybcio wrote:
>> On 4/24/25 11:40 AM, Krzysztof Kozlowski wrote:
>>> Add device nodes for most of the sound support - WSA883x smart speakers,
>>> WCD9395 audio codec (headset) and sound card - which allows sound
>>> playback via speakers and recording via DMIC microphones.  Changes bring
>>> necessary foundation for headset playback/recording via USB, but that
>>> part is not yet ready.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>
>> [...]
>>
>>> +	sound {
>>> +		compatible = "qcom,sm8750-sndcard", "qcom,sm8450-sndcard";
>>> +		model = "SM8750-MTP";
>>> +		audio-routing = "SpkrLeft IN", "WSA_SPK1 OUT",
>>> +				"SpkrRight IN", "WSA_SPK2 OUT",
>>> +				"IN1_HPHL", "HPHL_OUT",
>>> +				"IN2_HPHR", "HPHR_OUT",
>>> +				"AMIC2", "MIC BIAS2",
>>> +				"VA DMIC0", "MIC BIAS3", /* MIC4 on schematics */
>>> +				"VA DMIC1", "MIC BIAS3", /* MIC1 on schematics */
>>
>> Is this a mistake in what the codec driver exposes, or just a fumble
>> in numbering $somewhere?
> 
> Which mistake? MIC4? Schematics call name things differently. They
> always were, so to make it clear for people without schematics I wrote
> which MIC it actually is.

I'm not sure how to parse your response

are you saying that there are MIC[0..4] that are/may be connected
to different codec ports, and that the MIC4/1 lines are plumbed to
VA DMIC0/1 respectively?

I think I got confused about the MIC BIAS3 going to both and none
matching the index, but perhaps that's just because it comes from
the WCD (which is the third piece of hw involved beyond VA and the
mic itself)

> 
>>
>>> +				"VA DMIC2", "MIC BIAS1",
>>> +				"VA DMIC3", "MIC BIAS1",
>>> +				"VA DMIC0", "VA MIC BIAS3",
>>> +				"VA DMIC1", "VA MIC BIAS3",
>>> +				"VA DMIC2", "VA MIC BIAS1",
>>> +				"VA DMIC3", "VA MIC BIAS1",
>>> +				"TX SWR_INPUT1", "ADC2_OUTPUT";
>>> +
>>> +		wcd-playback-dai-link {
>>> +			link-name = "WCD Playback";
>>> +
>>> +			cpu {
>>> +				sound-dai = <&q6apmbedai RX_CODEC_DMA_RX_0>;
>>> +			};
>>> +
>>> +			codec {
>>
>> 'co'dec < 'cp'u
>>
>> [...]
> 
> That was the convention so far, but we can start a new one, sure. Just
> ask the same all other patch contributors, because each of them will be
> copying old code, which means cpu->codec->platform

I've been doing just that for the past couple weeks indeed

>>> +		/*
>>> +		 * WCD9395 RX Port 1 (HPH_L/R)      <=> SWR1 Port 1 (HPH_L/R)
>>> +		 * WCD9395 RX Port 2 (CLSH)         <=> SWR1 Port 2 (CLSH)
>>> +		 * WCD9395 RX Port 3 (COMP_L/R)     <=> SWR1 Port 3 (COMP_L/R)
>>> +		 * WCD9395 RX Port 4 (LO)           <=> SWR1 Port 4 (LO)
>>> +		 * WCD9395 RX Port 5 (DSD_L/R)      <=> SWR1 Port 5 (DSD_L/R)
>>> +		 * WCD9395 RX Port 6 (HIFI_PCM_L/R) <=> SWR1 Port 9 (HIFI_PCM_L/R)
>>> +		 */
>>> +		qcom,rx-port-mapping = <1 2 3 4 5 9>;
>>
>> Does this deserve some dt-bindings constants?
> 
> No, because these are hardware details/constants. Drivers do not use them.

I'd argue it makes sense here - it makes more sense to pass meaningfully
named constants to the driver, rather than blobs with a comment

Konrad

