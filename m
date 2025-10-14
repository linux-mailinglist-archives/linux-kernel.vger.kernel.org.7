Return-Path: <linux-kernel+bounces-851709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF81BD71CE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D014189D541
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 02:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F63306B3E;
	Tue, 14 Oct 2025 02:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gnNcNtJY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB84305954
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760409576; cv=none; b=ddvx20jdoSDe0SqaSdaAMCR4FMbojUxijQNd3EDekaUuThcHYUuGk/EKWt3FBFnIcux4UHbvsIsUFJyL8WD0m9SSbkF8TXPiExcDU6x4PVJHXlrkJ2URetNAGdYaBV0gqhMVvpWPqzkRf6dOEKSxMSUe8BifL5w7J4MQthqWHII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760409576; c=relaxed/simple;
	bh=gJl0FfQuDtF2eNgYEi2LJEGUJxfSedvbty82t8RTVFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fJ5xAq9oA2Z2Af8/mP07HqJoBFLu8LrHLsA0qOgxgMgjBx0ybZUr8i6WQjuicCxwAvz6LUTtpcZzaw7wiG2YwcP8LIcUqj3oOHoDXuYkUKsIei9I3zwHyFtSZ9oCpSZTzT2hd/SIwDeBV18aWjWWUaTYbCMeyqeXbkXz9to7u1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gnNcNtJY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DHDTE2016735
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:39:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e1liYZOex6u3499p/8XbqN27JoYRD6zSaqlCfAiBYXU=; b=gnNcNtJYdDP4XeIJ
	OyO1R5md2VLhg1Lopy5qqpA4VK7aTRyqXZ0RNDAtYgH1qcUeag59B5gjWmODsqLm
	PoaUN0y9fDPVZ5aucviQfnha1CtPnFRiOYAQshyYOcs3Bbyz8E1KhmOEVhdV7YiJ
	LoqrFKUMGYVFZypIfIDkkK0mDLLOmo+CRIjRk3CB50sXZnlMlwOkcWpv7u0cHBeB
	lh9gOVMkAyQGG1toqIE1bfqh5KnCtzkgGpXTQaQx9A+Fi4DG1O5ibemE7qkAlEhW
	pgyzlptyX2arTnET5bUNX49nBBqBgi7aK7IdDB5EQhXu6WCWGgypaIk9xUgBf5XC
	itkJdg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rw1ab6gf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:39:32 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-28973df6a90so92390725ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 19:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760409571; x=1761014371;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e1liYZOex6u3499p/8XbqN27JoYRD6zSaqlCfAiBYXU=;
        b=w8hRHIA2uouA3IHR5cWX7SV/Z9P0L8SlZRwsZaRJ+V1cfg1r2kCoXiILvWpyiCnRU4
         n8q3yxYfTNb9pKIs/yNZfZu1N1tmsgzD8bXAak1qLB9i3ivUHRAsNggm6AOxhLC9jIUm
         p0k2k7zUBaa27DpAldTA2fw7XOHfVFyakhI6kZxE4rRwD5zcTcbofdFdq2On8PxRccVY
         BuXLEb/zJEnHZqKWoHa+RqyxMygLg7Kncme9AxngpWUnjbT5j5yiNBb826VV2ODyBDZG
         WGK2LmEcBl5rwqAPVOP9Xg/nvml4b0v9RdEnm6jotDKz46FN+IqToF5QcaMJiYsZcLpE
         HI4g==
X-Forwarded-Encrypted: i=1; AJvYcCXx5EiQ3KceP0YeRtosW0fjDpjj54VJ9AwfgYa9eeIv5FWxqaEs/LjYTkI2STjkz9Od7Ndy1T0tERTZB4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YziRF+adq3lvEON+h8gUHoEl8ME43/Bzd1hl7yEAdbx+m8XaNIJ
	uaaGeSItIJqtp/iQWvS46fybtrtTV3/vlMBzASPUcB5n5B7QHOVlsNGOkWLxoTXQp+3CvRWs9/x
	O5XjmLeGwVLIS0IwO2LltVJlld9HD1NC9zs8GbYvvw9kuL1K+vUBFjJWQzVG63Kk786Y=
X-Gm-Gg: ASbGncvowTQtg++PfllOurPHm3t5UyhxjARP8UmNW66DDk9Jau2Jwr6xqikjqqYYRPw
	bp1cet6rt+uMSg9khSDOy97U6DrOhJtXZqd+OgCmmlmxSG+B9od2DpWIrYbvU1hkzsGFoEYPOn1
	SN6P7TbJvU3LWN5SSkWiWAueAHPBrYr82cGtsDqn+PFxTZbiEOHWhExwUn8DT0/xbvGnVbC+3Yf
	nC93j5J5gz1gTRQtoTgGvNFOmHxA2QGUfgtLMuvhu7o88zhEh5YokU5Lwz3A8sEWlW80u4RUUdC
	YQpUPX1vjW3umAWHey5eyfMFgHxXz+NTR7t2LYt1ER/1GqrfYJA1wYgBGZ+QDzdN1kcDZhTwTOS
	D
X-Received: by 2002:a17:903:3c66:b0:269:9e4d:4c8b with SMTP id d9443c01a7336-29027379a40mr313265515ad.21.1760409571382;
        Mon, 13 Oct 2025 19:39:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzomiFefnWgNLltTkzNNBTfg0uOb7fx//fR5/hrzk7NEI1Z5j0/t2K0xrD/6XVsL6pRiF72w==
X-Received: by 2002:a17:903:3c66:b0:269:9e4d:4c8b with SMTP id d9443c01a7336-29027379a40mr313265215ad.21.1760409570900;
        Mon, 13 Oct 2025 19:39:30 -0700 (PDT)
Received: from [192.168.1.3] ([122.164.228.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f837dcsm146768865ad.111.2025.10.13.19.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 19:39:30 -0700 (PDT)
Message-ID: <654b804d-fbeb-45ea-a6fd-9d551224c934@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 08:09:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: ti,hd3ss3220: Add support for
 VBUS based on ID state
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251008175750.1770454-1-krishna.kurapati@oss.qualcomm.com>
 <20251008175750.1770454-2-krishna.kurapati@oss.qualcomm.com>
 <odikli6rfdyid5oqavurtqytgnwgh5hpmka2jt5tprpdw7cd72@icpnjnkfowt7>
 <20251009131543.GA379737-robh@kernel.org>
 <cbpne2d7yr2vpxmrrveqajlp3irzsglxroxyyjmviuci2ewted@6ewwp6yyybk5>
 <2a088c8f-5555-490e-a70d-308a876924ca@oss.qualcomm.com>
 <CAO9ioeX51SzaMS4TK7=xfCXBNYi7SGsMBZAv4FrZ1LzONWFw3A@mail.gmail.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <CAO9ioeX51SzaMS4TK7=xfCXBNYi7SGsMBZAv4FrZ1LzONWFw3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=K88v3iWI c=1 sm=1 tr=0 ts=68edb7e4 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=8YinarrYfdS0Dhyguhy4yQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=DEfk8Nzn-u4LZ7i_Gp8A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: ZJEDbPbHDRQrzEogUH8l78EZLeUiBgGc
X-Proofpoint-ORIG-GUID: ZJEDbPbHDRQrzEogUH8l78EZLeUiBgGc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAzNSBTYWx0ZWRfX1kXbxxPs+Gzb
 Ka+z05QV2FV1PX0TvIuG9/ULu15YEfnTzhyjQuQ0jjqWB6hCIpqMR2X7yu6/csBrXUhZacM7lI3
 0rhdzlEZy7Gd7VsXe3rOW8L8yn/dPYD4vJZXdB7cYdrJDZLkWL/646pB4WGathD2FZk4QJL1Sda
 mSkeKXWysm68JCI40YIiftO0q8nxHfirqAksuBRmRcFH94PyDfXTTuRJ0/DIbne7LByo825jABA
 XtgF1Fw8ZwGVK4o/mtpQBdYogTTGeKKv9gqllZWEaqrjcALuUQymdLCS/eEvM03t1qJ81dFEPQ4
 xHOj1VN1ZQ7jMUK+AZTny62lSSbLRhS1+U8Kgtc7TorO21/a/bFIDjjAXwW1spDda/FqOZhMReD
 vasIFop3DMtxzfTVQK7sQBndH0K6HA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_09,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130035



On 10/13/2025 2:38 PM, Dmitry Baryshkov wrote:
> On Mon, 13 Oct 2025 at 04:17, Krishna Kurapati PSSNV
> <krishna.kurapati@oss.qualcomm.com> wrote:
>>
>>
>>
>> On 10/9/2025 8:08 PM, Dmitry Baryshkov wrote:
>>> On Thu, Oct 09, 2025 at 08:15:43AM -0500, Rob Herring wrote:
>>>> On Wed, Oct 08, 2025 at 09:31:59PM +0300, Dmitry Baryshkov wrote:
>>>>> On Wed, Oct 08, 2025 at 11:27:49PM +0530, Krishna Kurapati wrote:
>>>>>> Update the bindings to support reading ID state and VBUS, as per the
>>>>>> HD3SS3220 data sheet. The ID pin is kept high if VBUS is not at VSafe0V and
>>>>>> asserted low once VBUS is at VSafe0V, enforcing the Type-C requirement that
>>>>>> VBUS must be at VSafe0V before re-enabling VBUS.
>>>>>>
>>>>>> Add id-gpios property to describe the input gpio for USB ID pin and vbus-
>>>>>> supply property to describe the regulator for USB VBUS.
>>>>>>
>>>>>> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
>>>>>> ---
>>>>>>    .../devicetree/bindings/usb/ti,hd3ss3220.yaml       | 13 +++++++++++++
>>>>>>    1 file changed, 13 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml b/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
>>>>>> index bec1c8047bc0..c869eece39a7 100644
>>>>>> --- a/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
>>>>>> @@ -25,6 +25,19 @@ properties:
>>>>>>      interrupts:
>>>>>>        maxItems: 1
>>>>>>
>>>>>> +  id-gpios:
>>>>>> +    description:
>>>>>> +      An input gpio for USB ID pin. Upon detecting a UFP device, HD3SS3220
>>>>>> +      will keep ID pin high if VBUS is not at VSafe0V. Once VBUS is at VSafe0V,
>>>>>> +      the HD3SS3220 will assert ID pin low. This is done to enforce Type-C
>>>>>> +      requirement that VBUS must be at VSafe0V before re-enabling VBUS.
>>>>>> +
>>>>>
>>>>> Stray empty line?
>>>>>
>>>>>> +    maxItems: 1
>>>>>> +
>>>>>> +  vbus-supply:
>>>>>> +    description: A phandle to the regulator for USB VBUS if needed when host
>>>>>> +      mode or dual role mode is supported.
>>>>>
>>>>> Why are we adding the property here while we can use the vbus-supply of
>>>>> the usb-c-connector?
>>>>
>>>> Normally, that's my question on both of these, too. However, it does
>>>> look like both are connected to the chip. There's VBUS_DET which is
>>>> connected to Vbus (thru a 900k resistor). So having these here does look
>>>> like accurate representation of the h/w. The commit message should make
>>>> this more clear. Honestly, that's really the only part I care about.
>>>> How it works is not so important.
>>>
>>> The VBUS_DET pin is used by the controller to detect the VBUS provided
>>> by the USB-C partner and to identify when it's safe to turn on the
>>> device's VBUS supply. I think this still fits into the description of
>>> the connector's vbus-supply.
>>>
> 
>>    In case we put the vbus supply in usb-c-connector node, is there any
>> way we can get its phandle reference in hd3 driver given that the
>> connector node is not a child or parent of port controller node.
> 
> Sure. Use devm_of_regulator_get() passing connector node to the function.
> 

I am not sure if I am asking the right question, but in case there are 
multiple connector nodes, each one corresponding to one port controller 
node, how do we get the reference of proper connector node in hd3 driver 
since the port controller node and connector node are not parent/child 
or each of them don't have reference to one another.

Regards,
Krishna,

