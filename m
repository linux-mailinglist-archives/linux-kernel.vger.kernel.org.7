Return-Path: <linux-kernel+bounces-805489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47151B4894B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 563E17A2B02
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571342F3631;
	Mon,  8 Sep 2025 10:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eG4sBqPT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242E71B424F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 10:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325620; cv=none; b=bf2op45vw5+e2poXpgvV8dpi0GLFXXqTtawhg0e77zMx0DAgL/jAt6jCIKYYp61/P/lmsfnS0l2bkRisE1znhi5HLvVxQ+IH6IlzTy5556OKcL3hEglPsY7eM5t9fYHD8P6wD1Jwoa3YZYMoe2p67WKKJHQJcY3pkJE0toOFBzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325620; c=relaxed/simple;
	bh=r/waWgH8iFc4NM8oyhtNDxdNdtdlFuFW9vf2HRoSosM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M+Ii9OO0q2q6CPeVOO0/r3HpfMS0xp/iWFDvmZEIyDKhGuYEY0yN7iGiUcpNe2p364iqXA0YkpC2ocQnG1+z7Kcy1vHMOQdVfxDZ8e94c2/QsomXiBbjgPGAlJ85dls4r/OMWiHP/dYLyz/myWs2WarlnV6h2/OGMs4dmV0jmmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eG4sBqPT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5883lWwf013595
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 10:00:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RtUukMnNWAAQi+BBVchgSoNXaZOrt4o1HkYE4SHkE2I=; b=eG4sBqPTWzYBRCbA
	dDNrzwa9pRYTxloO5rahsbNAwP660TgzsnSZaZLET4gW7JQPwMUEqtVV+4w38AEq
	EN4TgJdoh7QL7cBvX/mp15qeQUbhO8QT2FxCbe9CArGaKEJqQbvZ9W+zvSBlPZjW
	XpJyzgGJn2fQ+CB1HLkiI1lNKZ0cCp6EFdSD+rLN2owA00pc7LEQIm5UH1akDbEP
	fTxnrw6ikvhZD8YSUrx1FbgmJg/J0Ji7gbXYqZ+HjbzILgaCcKGaU0rLVacH+l/q
	sobvTLDsEvii8hf8z4jnf5q80o8gJGssdB/4CURXlUkOrlfhA0OIAcI/3svA8BX3
	NSlXLA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491qhds0mn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 10:00:18 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70a9f5a43b6so12005066d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 03:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757325617; x=1757930417;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RtUukMnNWAAQi+BBVchgSoNXaZOrt4o1HkYE4SHkE2I=;
        b=GjWdgjFS6AKPjOhjtx48EYwNG2cfcNdCwx5gW5aOwEgKELKUw+1yGz49yEGemb3CyO
         Espb5tokp2HeP4TYuNql7YJRrOcLDtgl4D1xdB5PmFaRdAOYMScUuvOD29+Q0A69Ffkf
         gQ6Dm+KhY5iDOZfwxW9PpCb/e+375MQyr/fYyBXfimvZEh8RTJMFqWEbnxVdvXu2XDGS
         1XwqcedwXh5YmYH3L/0zB87qDz9zmtT4toeTx4rRXIyyN9hbDE/JiuQDCi0ZHA6ObCko
         O5Sr4xvoum8TH108vrxtRMMXqN026rfbFS9jnajEdBrgPEtYGgGN2ULw0xBP/0smdAIx
         Rbmw==
X-Forwarded-Encrypted: i=1; AJvYcCXnr/4SvU3uzd9W92JxgrQ7pGeCW/y1iBBgYYqernJuso5+Cxef91wUS2UWkP/WczpFnE6WEErP+MG73ZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3aoOHk4YbK24eiVXBB4VMy1RZxdu6OsKKYiLaEV/43RL6u4uY
	nWCqEOgMEvc9Dv+lJDWTtENzlimtH+6MwiQAYQJbG1SAjQiAxiO12kBJiJ/DUq8jDkhQTxeCWt0
	l2/862LCW/2GCiiKCSqXUTjlbciNFUM6pYh0eFfqtcEzEBOVhPj8mynkK83GVTTsVYN4=
X-Gm-Gg: ASbGncvK7jHYp3VXr/Juncm0Cpls6OrphWqsjVqmQMKIZUSwYdZ1zASkgcO8+r7pdEg
	aru7mq189NEzIP78f7oJtkimpda7fNe5MIbjwtqJVXDxtU6jbLy+XYWjhFRHHi5uD0W0YwTlh4n
	waxpDF5ANkviMD4P8xKCF4niIVsoeFSFh8zLXp5Glr3eSOhTuRDXdMakLt39v81+ccwbJ4euzVv
	X0ZYFFEdMIhz02DS2VALD5V2JHloFW+9O4VFhCHbvYDTJKGno8oXCt2wjUpQ7kKY6ArQSAVOp78
	cPsX7e2ESlqjc+Pmn7z6c1/Z3/XT1NNtM/47T2OpNnZkM9hKwIOgoAPkmCgq5JLPqOiEkXmdRsN
	NeDFw2xv2ySiG3iKdF6MS3w==
X-Received: by 2002:a05:6214:2627:b0:70d:bcbe:4e79 with SMTP id 6a1803df08f44-739464ee140mr51773726d6.6.1757325616687;
        Mon, 08 Sep 2025 03:00:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE47Hk/U9dhX2DbPG1Fqipq+98Vftq1E+WXGEt5z7yn0rJYJRaa3YNN05gx4rx6HhQF6gkiSQ==
X-Received: by 2002:a05:6214:2627:b0:70d:bcbe:4e79 with SMTP id 6a1803df08f44-739464ee140mr51773366d6.6.1757325616007;
        Mon, 08 Sep 2025 03:00:16 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b01af44a01fsm2168466866b.23.2025.09.08.03.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 03:00:15 -0700 (PDT)
Message-ID: <1899862b-530b-4a75-93fa-c70c90d98016@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 12:00:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] i2c: qcom-cci: Add OPP table support and enforce
 FAST_PLUS requirements
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20250904-topic-cci_updates-v1-0-d38559692703@oss.qualcomm.com>
 <20250904-topic-cci_updates-v1-4-d38559692703@oss.qualcomm.com>
 <aL6Vp-3er71AJPJd@linaro.org>
 <f508bf92-a513-467a-a946-17c41e1d72d1@oss.qualcomm.com>
 <aL6X-RiCyPVbHlYN@linaro.org>
 <5178a6b1-1b5a-40d9-af40-68ee13975509@oss.qualcomm.com>
 <aL6nZdJCKmnWcswB@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <aL6nZdJCKmnWcswB@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: KKLEXjdVg7zs0En3IfL6VIRIj9Pj1URK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDAzNCBTYWx0ZWRfX9V5YOIfFhDuY
 Jqo5M5NXaOZDZJU/JiSNcdqO/Bf8YcHNwbyaHszUZufPedtR3NfmLsXGCxCsgVB8gSyq5+oIuhG
 rgoUUwwkykPTXGvRSOlmJIl6P/E7PKxXN7ZPLLayVVV1bpQ0p7vJGpJ0f2kX8l24eDoXqR8f1Vh
 KZD/XW5mimuyi4GWnZFLxWSPBBTbc/TJd5kH3M21ao3swNgNV83xlRiNTr+ESmE2Ldn5kWvhvto
 6QP/4P8Uho8r/RnFxraRkAsPRO4Fdtd/ME1cAIaFc1TmalX4ZnIQmmdPLj7UDIpbJESJOYYZjtm
 ooZt7uhBKDQref8e6+taH4KlC8rU4nkuCI73kI5hIxC9ETwyUcC7YYTsovLXSaIO/g1lfVUsAk2
 SyfjRthv
X-Authority-Analysis: v=2.4 cv=YOCfyQGx c=1 sm=1 tr=0 ts=68bea932 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=dID3koFHavZth2WqiVAA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: KKLEXjdVg7zs0En3IfL6VIRIj9Pj1URK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_03,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080034

On 9/8/25 11:57 AM, Stephan Gerhold wrote:
> On Mon, Sep 08, 2025 at 11:49:52AM +0200, Konrad Dybcio wrote:
>> On 9/8/25 10:46 AM, Stephan Gerhold wrote:
>>> On Mon, Sep 08, 2025 at 10:43:50AM +0200, Konrad Dybcio wrote:
>>>> On 9/8/25 10:36 AM, Stephan Gerhold wrote:
>>>>> On Thu, Sep 04, 2025 at 04:31:23PM +0200, Konrad Dybcio wrote:
>>>>>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>>>>
>>>>>> The CCI clock has voltage requirements, which need to be described
>>>>>> through an OPP table.
>>>>>>
>>>>>> The 1 MHz FAST_PLUS mode requires the CCI core clock runs at 37,5 MHz
>>>>>> (which is a value common across all SoCs), since it's not possible to
>>>>>> reach the required timings with the default 19.2 MHz rate.
>>>>>>
>>>>>> Address both issues by introducing an OPP table and using it to vote
>>>>>> for the faster rate.
>>>>>>
>>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>>>
>>>>> Using an OPP table for a single static rate that remains the same over
>>>>> the whole lifetime of the driver feels like overkill to me. Couldn't you
>>>>> just put the "required-opps" directly into the device node so that it is
>>>>> automatically applied when the device goes in/out of runtime suspend?
>>>>>
>>>>> And since you need to make DT additions anyway, couldn't you just use
>>>>> "assigned-clock-rates" to avoid the need for a driver patch entirely? We
>>>>> use that for e.g. USB clocks as well.
>>>>
>>>> This is futureproofing, in case someone invents FastMode++ with a higher
>>>> dvfs requirement or for when the driver adds presets for a 19.2 MHz CCI
>>>> clock which would (marginally) decrease power consumption
>>>>
>>>
>>> If 19.2 MHz CCI clock is feasible and has lower voltage requirements,
>>> then I would expect a separate entry for 19.2 MHz in the OPP table of
>>> PATCH 5/5? The DT is unrelated to what functionality you implement in
>>> the driver, and that would make the OPP table look less useless. :-)
>>
>> The frequency plan for 8280 does not recommend any rate != 37.5 MHz
>>
>> For x1e80100 however, the lovsvs_d1 corner is recommended to be 30
>> (yes, thirty) MHz, sourced from CAM_PLL8 for $reasons
>>
> 
> The 37.5 MHz rate still exists on X1E I presume, or are you saying we
> need more changes to support those odd 30 MHz?

Yes, any corner over lowsvs_d1 is 37.5, sourced from cam_pll0

> Personally, I'm not fully convinced there is ever going to be a use case
> of someone using a "non-standard" frequency. Even if "FastMode++" is
> invented most devices will probably want to use it.

Not really, there's no reason to make your i2c bus go fastfastfast if
the devices on the other end can't cope with it

> And the voltage
> requirements we're currently talking about here like "low svs" during
> camera use cases are kind of negligible compared to others too.

Again, this is an I2C controller that seems to be associated with
cameras.. No image data has to actually be processed for the
communications to take place and you can attach any odd device

Konrad

> 
> But I'm fine with either solution, just wanted to mention it. :D
> 
> Thanks,
> Stephan

