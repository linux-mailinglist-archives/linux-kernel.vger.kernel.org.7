Return-Path: <linux-kernel+bounces-782719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A92AB32412
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 23:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8752A7BEBAD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2B5334371;
	Fri, 22 Aug 2025 21:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ePuPJsON"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F4728D8E5;
	Fri, 22 Aug 2025 21:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755897694; cv=none; b=lAhFHapJtetywSoG/2mq73rcOmqnzexwTyDmAlBv7wgMWkXJJ3VvNEg25lGhKHbt5PvfbxrQkBN6xr5LXoSDGBV639keeABzv9fH9dFTmsS7c9y8gEVjcyXoyeRkOFnA2bgQcOT5KqOaIlmHUtuw8kkKn3AIu8K1VQ3QbbDBOn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755897694; c=relaxed/simple;
	bh=indzKJgCHhhvbcY3UCPHYwJ0LOGF/a7I+W4xUAwzF10=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=huLT31H+yVBiETAIYsZyUzwb+lhFxYYwAeD8BaNrXVjxu8WytzcdHFVCIccvTrpONi80n/C2KZwjkjTq4OkGm6XF2JDF8yT33+AncAjVDrYNlgGzrO4UO5zfR3BmQXsAAr39j7RKizpYPxeYplepUQMlI3nYY/knbX+PMmkb/H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ePuPJsON; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MHV2gn027301;
	Fri, 22 Aug 2025 21:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2wN4UHnTw+Lt8Yv16eGvjXG4ZGd+elsyoHEvk1TK4P0=; b=ePuPJsON4W+WTFmx
	3js9ctMmpn1SESQomwrA97Nwxph4ONOZurN15AcFRzEYcQsfaifNI/FpCx1U8vJ0
	1syYxd9TwO3l9UtXK+TbjYZoFOVKXhL56SuLwGS24GSw7gO7Tg1XQCchFG84ifAI
	E3YMKpPbq2qvm6Nlj4XJBEIPBKRMJdI1uQhExYsFsgbhik5e37Dyj2Iik5h0/bFl
	wmfwGihlFjY0bMakVCR+JOJAdQCX37uoKEz3vMmZog2RKMg4u0a0+JQUKWKwelys
	82E5PqPWoL8DLfdHGUs+ingNTD2FjAkQUSbvk2d7kHecMlcwxCjhbteDgD8/j8kn
	ubM8iQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48pw108gnw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 21:21:20 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57MLLJG3009759
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 21:21:19 GMT
Received: from [10.47.235.76] (10.49.16.6) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 22 Aug
 2025 14:21:19 -0700
Message-ID: <3a58fca1-84ae-4ee2-8800-0680a34480de@quicinc.com>
Date: Fri, 22 Aug 2025 14:21:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] dt-bindings: firmware: arm,scmi: allow multiple
 instances
To: Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi
	<cristian.marussi@arm.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <arm-scmi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@oss.qualcomm.com>,
        Nikunj Kela
	<quic_nkela@quicinc.com>
References: <20250730-8255-scmi-v6-1-a7d8ba19aded@quicinc.com>
 <e5c5c2da-ae77-4738-9f0f-33c51111f91c@quicinc.com> <aKbTKq04umCgS_eL@pluto>
 <a59908c9-38d8-492d-9e3f-5560d272689b@linaro.org> <aKbeRVsLpXcpiyHb@pluto>
 <aKbwYALhw3ZFqGii@bogus>
Content-Language: en-US
From: Deepti Jaggi <quic_djaggi@quicinc.com>
In-Reply-To: <aKbwYALhw3ZFqGii@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Rr7pAX6MkdIh2DK7qi0jQ9ZIv4TwsE3O
X-Authority-Analysis: v=2.4 cv=Z+fsHGRA c=1 sm=1 tr=0 ts=68a8df50 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=3H110R4YSZwA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8 a=7CQSdrXTAAAA:8 a=_GsXmPnImtuemZSCr8UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
 a=cvBusfyB2V15izCimMoJ:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDE2MCBTYWx0ZWRfX8B15tILWGI0V
 XX8O5siF/Dx72aX71WF8kTXh1+FigXooKoYmsdv+jJlZraOwqhsiJkt+yPN7tFxR12xYXE5n/4m
 cXJADJEhT55rrRfERT5byms0WkoKbCwoYM8MXw35O943PGNX50Ba5OjOoSBWUdeYs7Lk5dsiD+f
 IvB9ONcRKo4g1vlZVMsemG80ori2XdZ0JyOntXnbIM41G5TbcCVJyRjZc0mdRH1dffrB4qzijZp
 nTgG6EjtbU2Uqxqf80/2CMToiUwSZrw7HSykEJmMRCVAC0kLmUUzbacic3atGDLONPFAlfUCvHF
 hTn87gr5yT495BzzwwGWR1pyo4nZnMw7BIN9fNOVu2eCHskgfnJ163ePfj1+XtDo4pWTjP89q9a
 SsFf91eM
X-Proofpoint-ORIG-GUID: Rr7pAX6MkdIh2DK7qi0jQ9ZIv4TwsE3O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_05,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508220160


On 8/21/25 03:09, Sudeep Holla wrote:
> On Thu, Aug 21, 2025 at 09:52:21AM +0100, Cristian Marussi wrote:
>> On Thu, Aug 21, 2025 at 10:29:00AM +0200, Krzysztof Kozlowski wrote:
>>> On 21/08/2025 10:04, Cristian Marussi wrote:
>>>> On Wed, Aug 20, 2025 at 11:44:26AM -0700, Deepti Jaggi wrote:
>>>>> On 7/30/25 14:30, Deepti Jaggi wrote:
>>>>>> From: Nikunj Kela <quic_nkela@quicinc.com>
>>>>>>
>>>> Hi,
>>>>
>>>>>> Allow multiple SCMI instances by extending the scmi node name to include
>>>>>> an instance number suffix.
>>>>>>
>>>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>>> Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
>>>>>> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
>>>>>> Signed-off-by: Deepti Jaggi <quic_djaggi@quicinc.com>
>>>>>> ---
>>>>>> Changes in v6:
>>>>>>           - Dropped 'this change' from description
>>>>>> 	- Link to v5: https://lore.kernel.org/all/20250423005824.3993256-1-quic_djaggi@quicinc.com
>>>>>>
>>>>>> Changes in v5:
>>>>>>           - Added Reviewed-by tag
>>>>>> 	- Link to v4: https://lore.kernel.org/all/20240910163456.2383372-1-quic_nkela@quicinc.com
>>>>>>
>>>>>> Changes in v4:
>>>>>>           - Dropped 'virtual' from subject and description
>>>>>> 	- Link to v3: https://lore.kernel.org/all/20240905201217.3815113-1-quic_nkela@quicinc.com
>>>>>>
>>>>>> Changes in v3:
>>>>>>           - Added Reviewed-by tag
>>>>>>           - Removed the patch from original series[1]
>>>>>>
>>>>>> Changes in v2:
>>>>>>           - Fixed scmi nodename pattern
>>>>>>
>>>>>> [1]: https://lore.kernel.org/all/20240903220240.2594102-1-quic_nkela@quicinc.com/
>>>>>> ---
>>>>>>    Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 2 +-
>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
>>>>>> index abbd62f1fed0993ab98fa44bdb9a0575f8e1c78e..be817fd9cc34b14009a3b1d69e78b802215571b6 100644
>>>>>> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
>>>>>> @@ -27,7 +27,7 @@ anyOf:
>>>>>>    properties:
>>>>>>      $nodename:
>>>>>> -    const: scmi
>>>>>> +    pattern: '^scmi(-[0-9]+)?$'
>>>>>>      compatible:
>>>>>>        oneOf:
>>>>>>
>>>>>> ---
>>>>>> base-commit: 0b90c3b6d76ea512dc3dac8fb30215e175b0019a
>>>>>> change-id: 20250728-8255-scmi-ed963ef8f155
>>>>> Gentle ping!!
>>> You cannot ping gently while screaming!!! (you see how gentle this feels?)
>>>
>>>>> Could you please review the patch?
>>>>>
>>>> I thought this was already reviewed/acked and merged since ages....
>>>> ...also the wording-change in the commit message LGTM.
>>>>
>>>> Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
>>> It was. Twice! This is just unjustified ping.
>> I'd like to add a new tag at this point.
>>
>> Reviewed-!!-by-!!: Cristian Marussi <cristian.marussi@arm.com>
>>
> I wish I could apply something fancy like this 😁. I will apply it soon.

I guess my “Gentle Ping!!” wasn’t so gentle after all :) .Sorry about that.
I sent the reminder because I had updated the commit message and the 
patch hadn’t been merged yet.
I wanted to make sure the changes are good to go and that nothing else 
is needed from my end.

Thank you for reviewing the patch—I appreciate everyone’s time and feedback.
I’ll wait for the patch to be merged.

>

