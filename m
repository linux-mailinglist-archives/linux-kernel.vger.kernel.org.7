Return-Path: <linux-kernel+bounces-870805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E49C0BBB4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 04:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FC42189EAD7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 03:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EC02D4B66;
	Mon, 27 Oct 2025 03:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lvo7a4o/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4D829C321
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 03:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761535107; cv=none; b=Ch6/4l3kjbWuKjCcK1wOSiS8LloD/BNaiPIuZFaQDM58UcX38lHx/z4VVc7rehLTWBPyfQA7AFdvNxDh25hmTORUCkI7lBE+by/rDQDR98jxJAu8RZWCcXi+C+Mjx/kb8JHzqdE0N5wLfvZ3dAKL+156g10Yge8Jl5dKvbPW0DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761535107; c=relaxed/simple;
	bh=HVX4IgIqLmSwibcSj1JBmsMBTsJCHqjQerkoJDSYMtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BSWkNIcsvyEbhgNgZrG0wx2TVcUSlQ3SDTJmXovoeGhWiSZ0No+k8VnhP0h1RXgTPveC4t2D5VK4clEVvrnkMKq7/wjRCUpFZyJIATQhkuJLxdxANBQGx8ya98QCorNjOMRUBmpL8B5FxtGOICqu8L/D++8xmdNfhtwQeEVEFoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lvo7a4o/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59QLxHqc915959
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 03:18:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hsC4kwhJQbAsgGRl/SnnoHZ5wdx1iZ5j9DLWMKdfA7E=; b=lvo7a4o/V3aNZ8nO
	pUKLRHz+KfRF7bKkEsYdsnxcgPq/uXggQZx/YTIcHP7S6PPCtG4zYfuhMuSV8vU3
	E+Js5O4zPjFAdSsdzS7RZ1440wxgQTL+60CNKq3D93YatiSZhWOKSk/yUm7hpJv6
	yhg2Stijbob+55bY+EHfqvfbZmrL56iHR9Kk62/eIGn+VFYa82YDYU8obou1YMA7
	CZXRfbXJRJTD8k+ldEyYaWvtdb5x81s8eorjxP8eGiCbaAVVAnUHSzBlGsEOS+/e
	Wjhzqe8BXdrfafQC9Zeqy/bMH1RfPL/LJTwmChVtmZQZoCso0Ef/P+TOO55cYySe
	OCyHdA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0px6k02j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 03:18:25 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-33da1f30fdfso9961198a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 20:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761535104; x=1762139904;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hsC4kwhJQbAsgGRl/SnnoHZ5wdx1iZ5j9DLWMKdfA7E=;
        b=D/ndCD7RlJ35ZuEC3jOPbpXAYXMDI6qNIGkR6AqfRI/h1RFELIP1rliRXvlMDuI0mY
         4z4N4GBlqW1RZQmKPkbQxic0bpL6RHx/iQlanbbRNd5lkhVH4DTQOMqChSaEjSrddm2y
         iuq750fOhk5HDHUzu4o2pAiFG368jwOqZKJ2rZKP3Ao/j8ITsmUWvPRuT5hYA0AhK62Z
         pLLYL20mZWuZ4jinZU2N7osytVcUV/+yEMpu3Mn6r/ebfrREaQYQoFZMg38QGYrbxSLI
         EaNtpEYsS/EFxGie7fZCr2OtpGcC9iA6BoE4IMZi5KWDJKQ9nymDaFT0Uiaqm7GbjDM6
         aGFA==
X-Forwarded-Encrypted: i=1; AJvYcCU9cg2eFqvSqnRmC+Nm/GoqokI0sZHxA96m8aJJP5NDVmjkjXQoUW6ZB4t4LVwDDnderu6MwY0OEBBOHz0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj9jHrMJRgijdTqhHQtz1NoB6vMAabZmrRWc245a3woqjlM8rE
	wMeeBsCj5pH5Y99wCPmYa6ibUweKiTP/q0fzBwoNGLEW9APAb9E6lgs+36/hM8xsSZvRF4QUyJ0
	GTF5Y7QP+p2Igvx/sNiAsQdJ0T/+QvVsuWapH9x7+k3iChzQCGHF4ESOErxVPF2Fn3/Tnx4knJL
	Y=
X-Gm-Gg: ASbGncvEjcy+Gd7uy4QMbRwx9xPNQ7J6yc3TMrJ7tz+5x68+oDLHqI8Q1vlR8QDzIvR
	ajkCsPfNa6byqO4RivaazImFdOk6SQtHMxRcEY/sMArIkF7zz8rL9VH8atmKEjRPOEpTVaHx83C
	UfEYg7NfWH8qTp8uTfjHAcOhWXPdZwv/QOU1/WUkDoLVPbMrPmAlJM0PEF7K85PlcDq717SFA9l
	Gmt4rUEiOKkjZAVlTNpx+oCsfbC+aXAx0vWSrJyUMAvKFPMqlknDHcbCBu8/3K91QjFwjJITR5b
	hIvLVI7YUhX4157AzatUmDUlRzSQL+VRPB/yQeG5+UaPlV5nUJ+go3NCVHhAwuidbm24Qu4n0bW
	yee89pkYE7x7D7p/VJ0Gc1edUcBnaP1s3NiRPraZb9ZK1202f1w==
X-Received: by 2002:a17:90b:3dc4:b0:332:8133:b377 with SMTP id 98e67ed59e1d1-33bcf87f8c3mr42789916a91.15.1761535104152;
        Sun, 26 Oct 2025 20:18:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYkyXH+hdMZG8oNznDJ4jtrmldZN/nblX3y0v8ZeYj872vhQHc0eblp/uw5lZT6uGYyCFOXA==
X-Received: by 2002:a17:90b:3dc4:b0:332:8133:b377 with SMTP id 98e67ed59e1d1-33bcf87f8c3mr42789880a91.15.1761535103715;
        Sun, 26 Oct 2025 20:18:23 -0700 (PDT)
Received: from [10.133.33.226] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed80adb7sm6656310a91.14.2025.10.26.20.18.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 20:18:23 -0700 (PDT)
Message-ID: <a8a2a55e-8bc8-4dcb-8a15-f950727bc112@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 11:18:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] arm64: dts: qcom: talos-evk: Add sound card
 support with DA7212 codec
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com
References: <20251024023720.3928547-1-le.qi@oss.qualcomm.com>
 <20251024023720.3928547-3-le.qi@oss.qualcomm.com>
 <150836aa-b69b-4dfa-8118-4c32f181e03a@oss.qualcomm.com>
Content-Language: en-US
From: Le Qi <le.qi@oss.qualcomm.com>
In-Reply-To: <150836aa-b69b-4dfa-8118-4c32f181e03a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDAyOCBTYWx0ZWRfX5TjfIs3w4gtV
 vlZk97PGU49hFfHTGxF/UV53najV5s/LY+a/DjxINV+EmiFinaxASN12zzryCR2lf18pEJvnvVJ
 NEm+wKOz2g+EMRcZNB1HQbFpe91bPAwVCyjKfXTsgHXEGk/5XAGPGJLylog7Xw+m/ciiynZwhiJ
 LOS7RD8+8y+rIrckNJ1pteelnXsQbGgeRl/Vwu67A2+ldVFMPOJ4H670ilsjGvt+EE2g93263s1
 eupbghEbnfBcr95U57GiTLuZ/Mqm6C/Rb7K5CZ2uBLsCR/r8fLuEdfsTfq62TMB2jDoBKzFZsb4
 biCcZCAM7a+kyCpTehyne2WKDf2WGQFlVuH7i7A9i0Ayc/hafeEkAiDmdKyz26LAxfBnCO6zazn
 drC8OechxufsuC+663lAKgRNLGoITg==
X-Proofpoint-ORIG-GUID: 7e4burHwLOpLX59QLjY5scuSvIJoshxx
X-Proofpoint-GUID: 7e4burHwLOpLX59QLjY5scuSvIJoshxx
X-Authority-Analysis: v=2.4 cv=WqMm8Nfv c=1 sm=1 tr=0 ts=68fee481 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=DwVtD6Y8SjwMHt-vgBoA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270028

On 10/24/2025 3:59 PM, Konrad Dybcio wrote:
> On 10/24/25 4:37 AM, Le Qi wrote:
>> Add the sound card node for QCS615 Talos EVK with DA7212 codec
>> connected over the Primary MI2S interface. The configuration enables
>> headphone playback and headset microphone capture, both of which have
>> been tested to work.
>>
>> The sound card integrates:
>>   - DA7212 codec on I2C5
>>   - Primary MI2S playback and capture DAI links
>>   - Pin control for MI2S1 signals
>>
>> Signed-off-by: Le Qi <le.qi@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> +	sound {
>> +		compatible = "qcom,qcs615-sndcard";
>> +		model = "qcs615-snd-card";
>> +
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&mi2s1_data0>, <&mi2s1_data1>, <&mi2s1_sck>, <&mi2s1_ws>;
> 
> property-n
> property-names
> 
> in this order, please

Sure, will modify in next patch, thanks.

> 
> [...]
> 
>>   &tlmm {
>> +	mi2s1_data0: mi2s1-data0-state {
>> +		pins = "gpio110";
>> +		function = "mi2s_1";
>> +		drive-strength = <8>;
>> +		bias-disable;
>> +	};
>> +
>> +	mi2s1_data1: mi2s1-data1-state {
>> +		pins = "gpio111";
>> +		function = "mi2s_1";
>> +		drive-strength = <8>;
>> +		bias-disable;
>> +	};
>> +
>> +	mi2s1_sck: mi2s1-sck-state {
>> +		pins = "gpio108";
>> +		function = "mi2s_1";
>> +		drive-strength = <8>;
>> +		bias-disable;
>> +	};
>> +
>> +	mi2s1_ws: mi2s1-ws-state {
>> +		pins = "gpio109";
>> +		function = "mi2s_1";
>> +		drive-strength = <8>;
>> +		bias-disable;
>> +	};
> 
> You can group these together (i.e. create a single entry with
> pins = "gpio108", "gpio109"...)  and move them to the SoC DTSI
> 
> Konrad


-- 
Thx and BRs,
Le Qi

