Return-Path: <linux-kernel+bounces-879837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B7DC24299
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F8CF4E5E3A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F037329365;
	Fri, 31 Oct 2025 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LfBAv8w1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UJt7DQqk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCED2F0C68
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761903024; cv=none; b=QMpunHFAHtohBZDcqMslbuhtV6fDe8PX7VesgQeJhKyu3Z+gFxnCHWaSagYaq/ztUZwz700g+Uv84gI5vDRZb94Tc1+uyWJouleIqmMHrbAy5bJoBA4dLq7ddf4eOxkt6ffsSuEcRcAGAXHJVVNvABq0NWZHvgdCq/zHVg2o7vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761903024; c=relaxed/simple;
	bh=rYH6p1UwRQOjMh69pzRcI/An0pAMCpeV31BylTlA0rQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NVOsjKkHLj8MM7Dc6X1rGN/Lv78EBPeacvn0liUCvZ7kCw4/aFqZK3DilBv7SbQYyYM5uMM5MnIICXiZhUpRuUtd5okJ7ql2JC+XCP/XuZmM0D2My7OwiguEJ6tl1l82fAzIIc6dHag8kEyJVdmBJDSaGLHlq+X/vQOqE1rYPJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LfBAv8w1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UJt7DQqk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V187vh1513353
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:30:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qpeBS2pFql6V+IwGychAPEk4HDzH/LVw68M4+RrrS1c=; b=LfBAv8w14tdIN12z
	QBPnXl46Hz328zAajoIW/ctH06/9frPi9Nht3HLiBeBHFCxjP+yeDyDHtoAPKm+/
	8k0PrLAAtyjh4vBywHCdvAfhB6k56MS3AorBajjmmxBJ1yf5m2WiTsOh8tf5/MAm
	4p1x0XXPgALH8sIhMMN7JenHgZA2Ae7WZdh5Sv3ol8OjsxzkOl3nXmKsxCtcyRj3
	QNg47xLmOkhgAVMwAUy0EBJ6A0IWjvQ4qyI3xVUfcIN6TOrVaiuphRlXAEIQ9jlf
	ye3YkGCuckG1X11f4rHf80+ewMe2rjLu0iEP4istvHBiN8hdNhku57iphzY9IRrJ
	m/Ua6g==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4k69h6dm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:30:21 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7f5798303b3so5542866d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761903021; x=1762507821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qpeBS2pFql6V+IwGychAPEk4HDzH/LVw68M4+RrrS1c=;
        b=UJt7DQqkdLsdGiJAQoFKqI/A//x5P//hRHAiC33Kg701fB2K0/96Rb0Rrzap8Dm9LO
         T9nKIARhAEr1uF2I8A+6mfUn8PBXrOE/uNawZgMhXjKKXpPFFbAuKtQiCuC/LctUweTd
         ooX9Ys3qKZR++CMni/8/gw9odOrn+yjg5s94SghrWu3aHYd2cAF6OW5ujNc+rDDrlf9z
         ccicxSIQXnT+v+0Oxam5+y3ILNdFywt3evB5lg+Rd1MB7ZfitGrZWiKQznh7B9Mt0AXb
         CqfmHriEA6MGSaUIKyEiX9NTgcwmnqNGAkhofmFpV59oWsk55R1Qgjk4MjG+rE5n/fhD
         hhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761903021; x=1762507821;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qpeBS2pFql6V+IwGychAPEk4HDzH/LVw68M4+RrrS1c=;
        b=ayGXov9Ox1dPjrOVUBtG2gSKdbKMH69nIwTIWEjQme7rDQ7xtnpKl18uIwrJvmQHev
         9F87vJmGK2lsWtBIvW32NDLLRm5nsB25MilCEI3Oge2DVaneRsPNfd8/qosCdcv92n+Y
         1rl1v8+ll5+nGg189pEPHwq5eazeq15RUjSQiNF+U0dJgZ6SgrhAxWzsenbA5V+EATdT
         IyR0lFNhMT9myc9JGOH8mB29skWiStIyETqBDG3abFNr/ndfEuVdQst9mg14+sYKlkWM
         Ak0IkkCOV6ecfhBHCSNqjY4wiuM3T3o2lkyZCzr19oJzKjVHLelPREaqP2BVmfnlfgS0
         nDjA==
X-Forwarded-Encrypted: i=1; AJvYcCUClp04ouKR+4aCUpBh/bNJpKZ3FmR52q7cAj9lWEtX7IUjRifMGufvlUHON7nL7A9Jaj55HEd4s72JevI=@vger.kernel.org
X-Gm-Message-State: AOJu0YywwdTrZM4Gmw1Cjft30VasfuMdg3oJmYq6rmzI2MeD6rSclL/t
	7k0NfFXr4bonXXERhiJr6c/ueeNktBVdA4vm4GbsKrfFaD5Akqom/ZNbfue4t1pZClpfrXdqeL8
	q4FVczJQmtq6aSkvihSAJQsHCtfANcA4KBhjtIl4vUv7IRRLiBaPhT3XxIkkRZzn/zlQ=
X-Gm-Gg: ASbGncukcXVPMkxWVeK2jZ/BiK0OedZLYNIxfzbrKAc7HNvRrqG9ZI6KOx1v+Mjv/d0
	14DcAxj768Mc0rkCQFEU31RjYZCVB5+imEzok8MNByyg8bpWN9nnMkzBjf7+AdL2YDgv8m7pnhW
	UQ7mFGgr9Ue4xe7FzUiXGBfXr54NDfEsfsNmpc7W9PlswA7b+LcoRb19o98U47nj4K3bMoP5m/q
	Zw/tb7szUlh9KJdwg2fpeJ0HMzWcLMKH7NITMOpJLYtONPDxG+0CsfSj3jr9k4CHbl7kol6ZpkY
	71KbxE5KCFpEfVaWTtt4goqlW+/NeE79ChCpv6l++DJ09iYXinmsxrrZwdWQk/PO9BWKZ6s28T1
	RcmBuQ1YBisQXxVomNNpbTNIO3Dp5m3/Zf9IUQ6jPN2uFd6RUMDwBK4wj
X-Received: by 2002:a05:6214:258d:b0:798:f061:66bb with SMTP id 6a1803df08f44-8802f2a067amr24530216d6.1.1761903021311;
        Fri, 31 Oct 2025 02:30:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7xuL3S6oQLiRiRzIgeNjF3+Y1M1YfvJIBFLTYfnnQZPRwn0ILwmAHIvzUH0vueOA+61ZHZg==
X-Received: by 2002:a05:6214:258d:b0:798:f061:66bb with SMTP id 6a1803df08f44-8802f2a067amr24529656d6.1.1761903020562;
        Fri, 31 Oct 2025 02:30:20 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6407b427fb9sm1137215a12.23.2025.10.31.02.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 02:30:20 -0700 (PDT)
Message-ID: <adae8998-8b64-4814-8713-2dc63380452c@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 10:30:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] arm64: dts: qcom: sc8180x: create common zap-shader
 node
To: Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251028-dt-zap-shader-v1-0-7eccb823b986@oss.qualcomm.com>
 <20251028-dt-zap-shader-v1-3-7eccb823b986@oss.qualcomm.com>
 <c90b917e-b3bc-42fb-a127-ab47d5154d0d@oss.qualcomm.com>
 <c62a7f9d-6984-41c0-88c5-1d6c40d411dd@oss.qualcomm.com>
 <weyze7a2pqmt2klt763lbwyvpezqndm5rjnitexalru7hy3xhh@tdqx6xeqp3qu>
 <p5apfg5cbwcdmilfr3omoncvuj7z7zbj6dkex2eicjdubkyxwj@h42bzzhx4amt>
 <fuach44wl236rfm57itxmcvj376vr3m7idi4byge6mbbxcrr3h@4uzjnuefh2y5>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <fuach44wl236rfm57itxmcvj376vr3m7idi4byge6mbbxcrr3h@4uzjnuefh2y5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ndkE_vMK8S_jNFplUnFy6eWpcDpX6UbJ
X-Proofpoint-GUID: ndkE_vMK8S_jNFplUnFy6eWpcDpX6UbJ
X-Authority-Analysis: v=2.4 cv=OYaVzxTY c=1 sm=1 tr=0 ts=690481ae cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KfUywC4eykHvL1nPqbUA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDA4NiBTYWx0ZWRfX1x7q97wMAngZ
 eFZEttEOqSnicXgs0w+HnlrArPLehJc8ckF8iTy28CLl7Kh7SLhyrzeykgwPkLRg26IKZQLT3EN
 XGnMGH5pQ5a2Xxm7NgICJ6vhzQf6Yq5UuplJ9cP6T2CM0DInrFqcIB77KEeW3pdinrtgCDxMTTo
 lXjoKgZw7Ck5fh7lrDCoou1+xBAhc7Yi0TMokvhMAdRVKCE7Td4P80lqAmgSb1V6Hj5IrO2o8yo
 4iARTZVBpZz0fZ01/Gdyz+HuQd4mNGGz668/iCV8EpysWrNUVTT6jU+XUmUBipcLKJlDG5PR1QF
 56WynrA0POmoZ1A3ykrjs0XFmMQM2KvXD5xQBdHZMee8NFsPanUHJtAC1DmFJfhhC8P1j3wL7o2
 gBckhAzg9F58Ax1bvsG/xwvi8G/0Qg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310086

On 10/30/25 7:45 PM, Bjorn Andersson wrote:
> On Thu, Oct 30, 2025 at 07:58:46PM +0200, Dmitry Baryshkov wrote:
>> On Thu, Oct 30, 2025 at 12:28:31PM -0500, Bjorn Andersson wrote:
>>> On Thu, Oct 30, 2025 at 11:59:00AM +0100, Konrad Dybcio wrote:
>>>> On 10/30/25 11:58 AM, Konrad Dybcio wrote:
>>>>> On 10/28/25 10:00 PM, Dmitry Baryshkov wrote:
>>>>>> In order to reduce duplication, move common GPU memory configuration
>>>>>> from individual board files to sc8180x.dtsi.
>>>>>>
>>>>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>>>>> ---
>>>>>
>>>>> [...]
>>>>>
>>>>>> diff --git a/arch/arm64/boot/dts/qcom/sc8180x-primus.dts b/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
>>>>>> index 93de9fe918ebdadf239832db647b84ac9d5a33f6..069953dcad378448800d45e14931efe1fe1a69fc 100644
>>>>>> --- a/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
>>>>>> +++ b/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
>>>>>> @@ -14,6 +14,8 @@
>>>>>>  #include "sc8180x.dtsi"
>>>>>>  #include "sc8180x-pmics.dtsi"
>>>>>>  
>>>>>> +/delete-node/ &gpu_mem;
>>>
>>> I agree with your hmm, seems this line should be dropped(?)
>>>
>>> Dmitry, please confirm and I can fix it up as I'm applying the series.
>>
>> Oh, and this line is necessary, because sc8180x-primus has its own
>> location for the gpu_mem.
>>
> 
> Hmm, you're right, not sure why the memory map differs... But this looks
> good then.

The latest memory map for 8180 says:

GPU micro-code @ 0x98715000, 0x2000-long
(matching the Flex 5G)

Across all the revisions, Primus's range is either part of a
"reserved" region, or the CDSP's memory.

So it's either wrong or OEM-modified, with the latter being rather
an odd thing given it's a CRD..

Konrad

