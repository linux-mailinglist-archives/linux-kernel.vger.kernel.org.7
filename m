Return-Path: <linux-kernel+bounces-846676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D79BC8B3A
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 13:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FBD53AFB4B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 11:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4D12E0939;
	Thu,  9 Oct 2025 11:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fe6sUAEk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0B02E0410
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 11:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760008030; cv=none; b=HzHwpMPUA62nil0v1ciEeSNV59KLcxM82Pdyj9AeEh2qeN/sfMwUS64f047cf6/HFR58aRozowCTKBWa5ltWGHRBl8oQyi2KXyVWXIv3BVTOVXzLRSJ2ULeRzSiOmMKrvsjxIBizBrmfwZkxV49nb1cpkIbhO+ant4CTOj8uQY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760008030; c=relaxed/simple;
	bh=WWubvD43PWZ6o8KecQDz3YIFtK4U6xbWp0w73kFN5Ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SBmXuzGB4BQLd0knp7AP3KZlVOWt/xMNn1k/n4lE8vw+6UqF+RBgZLfXz4B/AoW/qedzBLle+ri85FhrbTujA2wVcqcsE7xhCek1bkOCMxk6xV/MWWrH2NRgDWC1kI7zRO1szi+pTDnSXSm67sW1Oo6MDVGnhBhmkxNzUIXqJmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fe6sUAEk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996F62Q020782
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 11:07:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uSHlKW8ET00Z5qZQeB9H2UAxItDmMS/qKwjutI9tfOw=; b=Fe6sUAEkSIW6p0Z0
	dUwm1AoCXaxT8c/6x1kFuxPe1q5tm/CcrmoUY9XmQX/R4GWxwesmSs5c8TLYyQwu
	bSkyU7FKXgi2rYgJIsH0HJgIWSYNHwu7j4psQRujpRQLGsWzv4FCDJtxLRH+KBND
	FvWpsrQpChnShIzoaN7VKU8hzFKNFClaEekyzt2/iMPWgA175JuyUIySIakVrks9
	gH5lWnPoA1kQa/ex858mxYMJWFaOkDPeE+RidB5pX6+5ryGJCmmIOl6Php6O1jGE
	6bFNwHnPDcZ28jd/Tg53RvasY2eKxXg3hRLXZJGCc4IIjUyADeZmhGGwidIFruc2
	Zr+a1w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4ntg8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 11:07:07 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e0f9bedf1aso2850841cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 04:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760008027; x=1760612827;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uSHlKW8ET00Z5qZQeB9H2UAxItDmMS/qKwjutI9tfOw=;
        b=KFuiYP9v9gKcUVD8/Hj2DfNfD7VwLc0qPdnC7jXgzCJd/9RPvTmWBHNJHdBdvorCoZ
         LQuEl1QLBGUYZdq9QAeywVb4yb6ZWBjcCjoIOQvKrTiGGdsKe1T4cm5Zr1M3Nptd+fRE
         TH/bOIOAWV1zQliEJ6BwA+hFKexYbXF6WKQoO9CVsrcaD2mSdHUh9Cg7ORG4LDK3AbWX
         AK6yuIE+9aNpU6jGg5UO8kQvrastuLmfgxhOqFcfD3hVc3uKKpIkgrqETjctv0AM3Gzl
         cGrpE1umg2pAmMV9oVnGTEw2nd1oEA6TGDqgzhWabkcqkaduQxSvIz+/yJ2UU9uMIwUT
         0fnA==
X-Forwarded-Encrypted: i=1; AJvYcCXthE0VFrjhyn5INGvH5J/Hucv0ErTMMnushFCKX0PdQLj5bEgM9sHYQLkQULvpeKDfeLcdsWw9oQiB2U0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu21lgFFTU1KUPGF7USKqJYvupklc6RnJl18PUB0LzfU2tC1xy
	8lJMnPE+/1xLKHedLl6TWh5y5NMWPFHFpXFcNSgkh3pCcTAgIq9NA2DG5sTiqxagNugUCL8L70T
	+DyEkk44xHf+DeEmsCct0dVIVBLGDnL9ShlwRw86Oyw+HFk5EqqVKyIKQ63O6w7MMvYo=
X-Gm-Gg: ASbGnctPnceer85H+PKC7GJ1m7giixXwA6tP6YUss2nkI+TK0hOBh3/qMVocqPdLf5f
	UgYDDScLylYtWMTfUb26be3TmpTT590Fug/Y5JO9NkT5rmqhTXvmvFjVgvfMoRjxaChg8WSWF2g
	k7zxPebTQ9mp7jvH2EluKQLpqwv82ZWM2DqdrLuW6DS6ss2P3qi+dCmAq+pGFFURSvNvTrLzyOl
	heq3i0XaiLGMRPphSaAwJmiUrPaS8RWTAJIZUChwmqoC7MQRR3c4WBGKqvV4NiYm6B2rCEGa9J7
	mYV8p8gaXzEMcUiyRTTQ+G3GHuLJd0gb0WCIsjFOO8I1nqA2n1kjKMMDwLvhH/pflEiqH5lCuWN
	vSUdC6pN50vukuBYSS0tfKOdE4cE=
X-Received: by 2002:ac8:5847:0:b0:4d2:c24f:8495 with SMTP id d75a77b69052e-4e6ead5a000mr60501061cf.10.1760008026515;
        Thu, 09 Oct 2025 04:07:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwDbcEzxCyfYTlY0t2P75Vfr1QE3YCjucibBy5M84RFYeL4LsFGeLGBCi7RCwpIHWn/mh2XA==
X-Received: by 2002:ac8:5847:0:b0:4d2:c24f:8495 with SMTP id d75a77b69052e-4e6ead5a000mr60500651cf.10.1760008026058;
        Thu, 09 Oct 2025 04:07:06 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865a83482sm1889554066b.26.2025.10.09.04.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 04:07:05 -0700 (PDT)
Message-ID: <6d898a68-631c-4442-9a1c-237f672e296f@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 13:07:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 3/6] ASoC: soc: qcom: sc8280xp: add support for I2S
 clocks
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20251008-topic-sm8x50-next-hdk-i2s-v2-0-6b7d38d4ad5e@linaro.org>
 <20251008-topic-sm8x50-next-hdk-i2s-v2-3-6b7d38d4ad5e@linaro.org>
 <630bb2b0-0ab4-4083-96a2-9aa485041797@oss.qualcomm.com>
 <d702a630-eee8-4889-98fc-62f4907791b0@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <d702a630-eee8-4889-98fc-62f4907791b0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: T8IcZLlSGz4gc4bPoYUQCA6pEU7063tU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX6YsC6JiAvrXl
 9PkB442Xc3dISomz5MHGnqzoiZNlyeWFpNlBnP6ZPeH4mkhEOFx6AugbHfDfLzvAVn9xQ2xOAbm
 2ACWacmZklWA55PcD/vjaiflsIojU8WYkPXExVH2GCbJqh6lSFwbu5zofbJqrAuwTeJFU4J8+eY
 HuljGV7jUjW19QqHSoAjJrl+Jop6W8KA+0iBytvvOzFrG2Xkd/ZarpEwwOGZQNfhEdvyLHUcntY
 z6VTzLgnVb4u/CUGp6/LzVNP9lGrNsBVgrkIVo1JrleOFaw52oGDmzbQCs+vnFpHUG77F2tAUJS
 eLiElMM74zPFjH82esNmvoq6XwW7MqaioWs/mzU0M08sjqlsM4DEDDBA3gBDK2XavJHChQeyZ8n
 Hn22SYCCdvyK/Ib3T5j41RjKeb/7/w==
X-Proofpoint-GUID: T8IcZLlSGz4gc4bPoYUQCA6pEU7063tU
X-Authority-Analysis: v=2.4 cv=b6a/I9Gx c=1 sm=1 tr=0 ts=68e7975b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=KKAkSRfTAAAA:8 a=GCCr0xkA3K9mKd9kojEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 clxscore=1015 spamscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On 10/9/25 11:45 AM, Neil Armstrong wrote:
> On 10/9/25 11:41, Konrad Dybcio wrote:
>> On 10/8/25 8:56 PM, Neil Armstrong wrote:
>>> Add support for getting the I2S clocks used for the MI2S
>>> interfaces, and enable/disable the clocks on the PCM
>>> startup and shutdown card callbacks.
>>>
>>> The rate can be easily calculated since the card forces 48Hz,
>>> 2 channels at 16bit slot size.
>>>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---
>>
>> [...]
>>
>>> +static int sc8280xp_snd_i2s_index(struct snd_soc_dai *dai)
>>> +{
>>> +    switch (dai->id) {
>>> +    case PRIMARY_MI2S_RX...PRIMARY_MI2S_TX:
>>
>> I have mixed feelings about the range syntax here.. it's only 2 entries
>> per and it's quite error-prone (no errors in this case, but it
>> encourages the thinking that things are always contiguous)..
>>
>> [...]
>>
>>>       switch (cpu_dai->id) {
>>>       case PRIMARY_MI2S_RX...QUATERNARY_MI2S_TX:
>>>       case QUINARY_MI2S_RX...QUINARY_MI2S_TX:
>>
>> whereas e.g. here we see that it's not really the case, but it's
>> tempting for someone trying to 'clean up' the code to change it to:
>>
>> case PRIMARY_MI2S_RX...QUINARY_MI2S_TX
>>
>> and the reviewers may not catch it
> 
> I understand your point, but I just took what was already in the file...
> 
> Is my change correct, yes, is the style of the code improvable, yes.
> 
> I'll do my best to fix the style issue later on.

That works, thanks

Konrad

