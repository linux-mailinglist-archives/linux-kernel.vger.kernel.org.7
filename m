Return-Path: <linux-kernel+bounces-807522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE92B4A589
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5802162D48
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC6B25393E;
	Tue,  9 Sep 2025 08:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fUVli2wr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609DF1D514B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 08:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757407153; cv=none; b=W+g5esrGG5UyrN3SVr9RgbFU2D/kdODfGt2Ic8gX/4/mIWgO+f0ZsWbGzM26EkOpYKtQt1nOjNDmAh4SS0J1/BFkta7ZRDM+vqfDISJG4KdS2eGEa1DwO+7osNIc5Ncm/nU+689q33C+llzCDAcxdGyit973hQNnAc/GPS8Fh3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757407153; c=relaxed/simple;
	bh=9x89MYAZJz0x+vKABEiiN6j8efnz+wNuTOK2EljyTs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a00ZUE4NO0qpfrTyLAE1M4M4xpaKECEEMr6IqBVa0Jfxs9/KPYuPQnDoyeNe9mo0p1H5F6vAc0JT62r0SO/uE/8ETBeAEYkK6KH0vInYbJc7NLpcyXQF7s1/88Tq67ccln50oG43mC/UTq2tKpsi5Ivdf0Tt+ektzHLRHK2AWSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fUVli2wr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5896T31G022803
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 08:39:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VsL4naCSuZYadG1mnMalW2GA4pHt+PHpJI7P94ns/zE=; b=fUVli2wr20waZAWs
	+qfrr/MmV99cqUjx+DG4BK4pmP78Au0HO3E/J9wcXnfRS65pKEUuNMjb3F3bJdfM
	U8I3aIbv9a8ymXUXbt+jlPF1MWZPpi7RMtIx0v1hrH3HtguyhlIo8+TiZKxTgBNe
	9wjk/J/ouJQgw/UMAILAcqc8uFyp6Fp6PgGalCGZJLKQjEABP8BNt6bFWKSN8fJA
	288sWQgLJP1lcJCsOTp3QLuOt46L+N31rg1P+UeB0FJDEvYBpflkwRMh5OE+DisT
	uCwFKsk87jWdgrV1hylzeL4CwUneIjMA/9uICYdbTK+pu/HA1aoSBzj9x3YTl0I1
	G1r0DA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491t37v1cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 08:39:10 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-74910ab069bso3418856d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 01:39:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757407149; x=1758011949;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VsL4naCSuZYadG1mnMalW2GA4pHt+PHpJI7P94ns/zE=;
        b=pEnrFhVQiZetmoCuGhda7/dZtMra1aJejsi2zInHc1Hq8WVZ36axR7A5/K4ohRphF/
         LgrxwmjSpYQlZm73GZxm8L9QaKAZrHp0jQcexwyyHsg9iqIX4o/PD5mRYneitsAkKvNl
         3/WA1IPlPyP7LIqT0AEjiDpmBLNIdbAfV+6KWz2/UT1D+VUEVhhKHjIYQWIsQW6vwErU
         qLNu6DaiO5RE7f+PP/sS1eaN0tOmK5aGPC89LQ7ZO64QY54ZfVnjax0qun7f0xWmDkI9
         j6AG1owLeiTC/TVeNYITeTubEQ1Zjcj1qnjGULI9O+JDahD5hxvqtX+hmjVwqTvCL1zF
         d9uQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUvby+KHLc16QtkctzyMqgicOqm3BDE1sGEx/z+jWGvAr4wDlhbRLAWsCdjoC3oxuZ+5JTHRJhcpiNgkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuuNw4mROSAD1/rhlV11KltRJ+pLBqrTgRqhcvIvB81S7MLdzk
	w9+cIuiLb5jKz1CJl3oo0IBeD9g5tluN5DUeaTKbtaDg8YBHAeBSJ6MPdV6o6jlbm5xabBw5uIZ
	Pd7xWVCglRi8h/LrSmHH2+OVXBNO0q25vlNT7VLRyX6CmdUrHbwfFYtP3n9oOq1imka0=
X-Gm-Gg: ASbGncvGMFme1Jmu+/40NuwOm/rJh1FLLLAoBURUZzvT1xj08ae+H7tEpSTlW0h5EZI
	nQjLRfa4okff2tVc790hCjT2W/z99pVH1yiS6tkozbdJ/3TAtLFShAeeFpUtyjZ20dETxYHGav7
	2cbK+5M3T1aUg9dplo3GxNFQefXzzSmlr2l58Y9dYLDxzjpov/dlC2+W1r0O1q8UYpQucO3YNNA
	s1vh90TI82yi2TM0nAvjMEbPzh0Z8B2MOMg9EOjOH1hpSZ4FnjE8dY6ddLSJtGar9QbU47iUvuw
	d/ebGdqsZVl1WstKtrtYwcFjuxa+mL1IAgNuUSkLVJscVzGfyswTHqtxpky1Cl2W2GPY0OMLoos
	VSeQQ4d+KzySD8vxA2BGIGQ==
X-Received: by 2002:a05:6214:628:b0:736:261c:d636 with SMTP id 6a1803df08f44-738fc406159mr87757856d6.0.1757407149043;
        Tue, 09 Sep 2025 01:39:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYGwk8ZE59MI/Irv05zhk5fDouLJXaxh2LsAl6wlKuzaOHesC4R2VhSrJb0gbbgWFknhr1lg==
X-Received: by 2002:a05:6214:628:b0:736:261c:d636 with SMTP id 6a1803df08f44-738fc406159mr87757736d6.0.1757407148563;
        Tue, 09 Sep 2025 01:39:08 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62bfe9a0198sm866920a12.10.2025.09.09.01.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 01:39:08 -0700 (PDT)
Message-ID: <4fed1de1-fe02-4631-866e-80bbfd2ab455@oss.qualcomm.com>
Date: Tue, 9 Sep 2025 10:39:05 +0200
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
 <1899862b-530b-4a75-93fa-c70c90d98016@oss.qualcomm.com>
 <aL6rYq5gmX8CdeE-@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <aL6rYq5gmX8CdeE-@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Z1WXt_-8bLphH9cJreVHu2F1wiEC7XZL
X-Proofpoint-GUID: Z1WXt_-8bLphH9cJreVHu2F1wiEC7XZL
X-Authority-Analysis: v=2.4 cv=NdLm13D4 c=1 sm=1 tr=0 ts=68bfe7ae cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Q5Xro-IcwC490qZTrIQA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA2NiBTYWx0ZWRfX514hTxRB9IOS
 6Rd5OrqIMstPSRFHmmKwHAF5IAiXwhvi9rNNj/Qrb1l7NZwQiZB/NBAZIdGA3cf4H0nYuyxOTfk
 H2brb/JKzHKDDP9rKi+U0DR0D5U1UKP7rHH3KRfvCJ0cLaB+UizhPD3cNShgwBA9TzRnbo9LcDk
 Hbh8e7wzQvvJsXUN8OGf3vxnDOfN9o4qFrcgwFbO5S4BkanT8svibiukcaXsX7FEy5FIPtXqTvX
 Nmp8UXaS7s4m4exEPfL+2XtOZcCZbJn3cwQwvQsHwoYiD3CMNIu3GzQ5skvp0hSjUNbGhgYcGvO
 jbCTUoa90/pjn0VoGsHLjRYkxQZCoREuYedRfTyzUBBD70FSOE7DkdnUAQVZD7rWJQIdgQZKsg2
 GA5LgqG4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080066

On 9/8/25 12:09 PM, Stephan Gerhold wrote:
> On Mon, Sep 08, 2025 at 12:00:13PM +0200, Konrad Dybcio wrote:
>> On 9/8/25 11:57 AM, Stephan Gerhold wrote:
>>> On Mon, Sep 08, 2025 at 11:49:52AM +0200, Konrad Dybcio wrote:
>>>> On 9/8/25 10:46 AM, Stephan Gerhold wrote:
>>>>> On Mon, Sep 08, 2025 at 10:43:50AM +0200, Konrad Dybcio wrote:
>>>>>> On 9/8/25 10:36 AM, Stephan Gerhold wrote:
>>>>>>> On Thu, Sep 04, 2025 at 04:31:23PM +0200, Konrad Dybcio wrote:
>>>>>>>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>>>>>>
>>>>>>>> The CCI clock has voltage requirements, which need to be described
>>>>>>>> through an OPP table.
>>>>>>>>
>>>>>>>> The 1 MHz FAST_PLUS mode requires the CCI core clock runs at 37,5 MHz
>>>>>>>> (which is a value common across all SoCs), since it's not possible to
>>>>>>>> reach the required timings with the default 19.2 MHz rate.
>>>>>>>>
>>>>>>>> Address both issues by introducing an OPP table and using it to vote
>>>>>>>> for the faster rate.
>>>>>>>>
>>>>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>>>>>
>>>>>>> Using an OPP table for a single static rate that remains the same over
>>>>>>> the whole lifetime of the driver feels like overkill to me. Couldn't you
>>>>>>> just put the "required-opps" directly into the device node so that it is
>>>>>>> automatically applied when the device goes in/out of runtime suspend?
>>>>>>>
>>>>>>> And since you need to make DT additions anyway, couldn't you just use
>>>>>>> "assigned-clock-rates" to avoid the need for a driver patch entirely? We
>>>>>>> use that for e.g. USB clocks as well.
>>>>>>
>>>>>> This is futureproofing, in case someone invents FastMode++ with a higher
>>>>>> dvfs requirement or for when the driver adds presets for a 19.2 MHz CCI
>>>>>> clock which would (marginally) decrease power consumption
>>>>>>
>>>>>
>>>>> If 19.2 MHz CCI clock is feasible and has lower voltage requirements,
>>>>> then I would expect a separate entry for 19.2 MHz in the OPP table of
>>>>> PATCH 5/5? The DT is unrelated to what functionality you implement in
>>>>> the driver, and that would make the OPP table look less useless. :-)
>>>>
>>>> The frequency plan for 8280 does not recommend any rate != 37.5 MHz
>>>>
>>>> For x1e80100 however, the lovsvs_d1 corner is recommended to be 30
>>>> (yes, thirty) MHz, sourced from CAM_PLL8 for $reasons
>>>>
>>>
>>> The 37.5 MHz rate still exists on X1E I presume, or are you saying we
>>> need more changes to support those odd 30 MHz?
>>
>> Yes, any corner over lowsvs_d1 is 37.5, sourced from cam_pll0
>>
>>> Personally, I'm not fully convinced there is ever going to be a use case
>>> of someone using a "non-standard" frequency. Even if "FastMode++" is
>>> invented most devices will probably want to use it.
>>
>> Not really, there's no reason to make your i2c bus go fastfastfast if
>> the devices on the other end can't cope with it
>>
>>> And the voltage
>>> requirements we're currently talking about here like "low svs" during
>>> camera use cases are kind of negligible compared to others too.
>>
>> Again, this is an I2C controller that seems to be associated with
>> cameras.. No image data has to actually be processed for the
>> communications to take place and you can attach any odd device
>>
> 
> My point is: In the unlikely case that support for faster I2C speeds is
> added in newer SoCs, I think you'd just get a new "standard" base clock
> frequency, add a new cci_data struct with adjusted timings and everyone
> will use that (even for the lower I2C speeds). I doubt anyone will
> bother adjusting and validating this for just one "corner"/voltage level
> less. There are much more effective targets for power optimization than
> the few bytes of I2C communication. :-)

There are OEMs that customize some of the timings (e.g. Sony) and I would
expect SV efforts to at least cover the recommended frequency plan (which
like for x1e sometimes contains >1 frequency)..

That said, I do agree with you it's a rather niche/improbable corner of
the SoC to worry about.. But using required-opps in dt-bindings for
non-trivial hardware (CCI is a little bit more "fun" than the today's
state of the upstream driver makes it seem) simply feels like asking for
trouble (i.e. a ""real need"" for an opp table will probably come around
one day, so I don't think the additional 10 lines of code to support it
are that much of an issue either).

Konrad

