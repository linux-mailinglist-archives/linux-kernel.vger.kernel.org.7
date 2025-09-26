Return-Path: <linux-kernel+bounces-834103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA691BA3DD5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5C7F3AD20C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1422ECD26;
	Fri, 26 Sep 2025 13:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HZpmijKy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59231D7E5C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758892894; cv=none; b=Z9WcQQ3GAbL7G2j6EKzSGh6fxGOh+dJL1qvJUiz5q0lUR2iq5t2XBhJ+C+9O6ICo0G7kv7O67uUwCekRCfBfO0P0MCJVGCSk7H4z+rLqq8inJpHr+cQ9XCqmNWXt1fuM7djvUxe79GhGnqsjQDtnuCW1vfzs7kcSB7SFAmIXNLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758892894; c=relaxed/simple;
	bh=6UK7sC7g60oZo3v+HjqWDlFdtqGJFknhMavuRW6Em4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M3KcQRDqEzV6BY9plOswcLCHhHqiLtx2sEY2pFLEsGLXMPjBKGiNBjAtnaB2P+mRLfZ1znRixtKfytLr7sa/JTB74JRtFZ59HMjrn3FH+LW/PvDJRavBss1bRW3o6S66U29lXQXhk03l7wPcAl93OMVa6FCdIRmq2LzjIDlxvZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HZpmijKy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q8voM2016255
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:21:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cZn3+ViDkvz98DvcqF6j3iIY1pg2ROgrLSmJOsp8TOs=; b=HZpmijKyleTwpdqd
	2NGZSaVx6TBwzMbZ38Uh+v4xLGZnuDl6pbEJXHe9vbjm7j0pCy2o83+AqfhBBw4k
	JEnY4gNNo9jwmFNQp5qYUsoDvCdWQMtFfQ0Wx+wJEH9+U8CaU7G18Wk5njxKVHhW
	Dcr2A4cSbqU4aG4khVNsnYG5z+RWtlqj1RlxgyploIPrbjxNzPkPyWxly+xp0aJZ
	o/YdNzyAgh92tAQ5hX82OAbpfe/EztFrRpQvS1drK8AW/qnLQ7yhXbbmQFf5eLKU
	QnUlslEm5xHvogGMHl3tzM0J/teUc6PJRoqsn17kTrN58gYD0UptzTFFWVYZ40aR
	d4wU2g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0rjy8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:21:30 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4cb12718bf7so5852711cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758892889; x=1759497689;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cZn3+ViDkvz98DvcqF6j3iIY1pg2ROgrLSmJOsp8TOs=;
        b=dsxDu2Pnf/Vhn29jbHJRSGqhKFKZvglPC6ke10656Wt+DBJulZqDhxzfzpskLM8w7q
         013DLFADDIoG/1d9wtyTsGY5g0VshB9kOCVrTJSd1XNvaYsbMpzzUJA8lO5cVhZLz5Zd
         SfbMmSGAaEBexVsG4ixUeYr1In5c4U7RDLNrkWnfujh0Zbc9Lt0utJGbqg6G/tdBkQhy
         8JnKdNFlxXnGSlGJ33dhOab/OHP4W0m0kGvzhGBukPp8Ole+O4GGGhu096VtVWbQr43T
         VME9KwsmhDS2tL3M1FaWUDpjIOHwnHHzPwd0RWHjIJw79V2tnnO/u+5O7/AI4X6wrwPG
         4j6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1+ty6qU0rACsIL0fV9oxirLM/feO5fYj3QwSQheDdXGzfHem9ZxfQWHYE1qYXI51J9CV7T4MLAigyv1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+OJx9RH/YzqMdyT1EIQ5POFi93QuTTZRfZp4I7aO4ntGQU6TH
	Fx3ZKRzzNwVqfC+ofwMw+M/jNTDZPTK73MhpObZ7CBrvPnECNZqVTEWhw9G1q3CLrju6+sHqYMo
	duXJ9GMXS21noAm3Le4NChbBiVj+D7a0GLrbiL5MfcxGL1Aw9Yc1RNPlorgXaozi6jQM=
X-Gm-Gg: ASbGncuLr4Ck+TsSNqtHliiXkkFagaUAT3JkjIhNFnLE1QkPZmN0s+gGdu+T6eKhuUs
	u5DbZHpBzx+ALGiSdqSm74RphstkhC2IAhc5Ks4//ksSVhzU9hisDElbk/8xno0GBevplJ4hW0G
	+ept4hHDKDHY7lebfPOcsKfTl2eCPkCS7m0iKpx1qGnaBO0VF8mUCFQlRSIKzG7/CY2xqO6eVJQ
	Zf2zDc25XF/QkKBui5VCPDANyTtnvS/bF/bFpmHL6e/YBb+qgZnwX4Dw/ZzYcJdyXMroZQAntcA
	uXN2RdHmSX4M9SMqolFa51W9+PUF5ek2QNWl2XBM0AD6d5EE55LtFwWqNKUnY7QT/h1/DgvaNWf
	7ctGpCZgPgUp4kp/aYzEfng==
X-Received: by 2002:a05:622a:24a:b0:4d8:7b08:64b1 with SMTP id d75a77b69052e-4da488a2d68mr68988341cf.5.1758892889186;
        Fri, 26 Sep 2025 06:21:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOs5AkFGBtCeVybInal7Dj0JBGaxf5TiuRZY/p4RsOAuSofCh3ljWxN4/nJ+1DTFBl2D9FzA==
X-Received: by 2002:a05:622a:24a:b0:4d8:7b08:64b1 with SMTP id d75a77b69052e-4da488a2d68mr68987781cf.5.1758892888545;
        Fri, 26 Sep 2025 06:21:28 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3af4fe7sm2958276a12.39.2025.09.26.06.21.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 06:21:27 -0700 (PDT)
Message-ID: <c13b94ed-a240-4a32-9f11-f0e323197500@oss.qualcomm.com>
Date: Fri, 26 Sep 2025 15:21:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/20] arm64: dts: qcom: kaanapali: Add USB support for
 Kaanapali SoC
To: Rob Herring <robh@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        Ronak Raheja <ronak.raheja@oss.qualcomm.com>
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-6-3fdbc4b9e1b1@oss.qualcomm.com>
 <CAJKOXPcbJY4JEjfZLvOAXEWCTYFpe7En+Riis2t3K5fWJgNU5A@mail.gmail.com>
 <3up4xqgd2ay3tex4ckzgews3ukyrdikcmgk7tbddggj3s5gt4d@foqcpnfptjk7>
 <20250925213151.GA2455023-robh@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250925213151.GA2455023-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dP+rWeZb c=1 sm=1 tr=0 ts=68d6935a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=UeAO8m2xiAsHg9Yy08IA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: GvTxwj_cEUis3uC07Ew6ZEz4d-2K6pBI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX1/RDM+/QdKR2
 1zq7UAlV6y/xfO2DzFASTrbd0JbK8XxOaKEEX1t8F+fdyl6BRAfrzBLSEi+3PZ1R2w7uXJ6mVAR
 srdhn463FW0ZHOyq7uGOwea6JGUEKoQAcb98ma8CtWeqNjqCnmrl5s4V6m2q8HUKgG1iiSJFIS7
 Kg0gS8d326iqrJlUeq6QoI7vCzuK8k0lDU/ebH7CXN5lI4TQ6ULp3VFHbSN+VOUf3ql2A0gCol6
 tTj0gKPKIyEo11EoAoBAZ2Q6gbcqrlrTW2RHQLSwFhGFRUf6/R+gaMuzVVRcezpmGsOijDmFHTx
 A68SWGVDa3w2y3d8f092GBao0HxMNYZ7XvkhsDtYxL3Duf6ENP3rdS7872e5aNuyOpaJesOTwnK
 Um4u38ZnOfnLsdkw91MAM60OLKs3Fg==
X-Proofpoint-GUID: GvTxwj_cEUis3uC07Ew6ZEz4d-2K6pBI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_04,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

On 9/25/25 11:31 PM, Rob Herring wrote:
> On Thu, Sep 25, 2025 at 08:57:56AM -0500, Bjorn Andersson wrote:
>> On Thu, Sep 25, 2025 at 10:50:10AM +0900, Krzysztof Kozłowski wrote:
>>> On Thu, 25 Sept 2025 at 09:17, Jingyi Wang <jingyi.wang@oss.qualcomm.com> wrote:
>>>>
>>>> From: Ronak Raheja <ronak.raheja@oss.qualcomm.com>
>>>>
>>>> Add the base USB devicetree definitions for Kaanapali platform. The overall
>>>> chipset contains a single DWC3 USB3 controller (rev. 200a), SS QMP PHY
>>>> (rev. v8) and M31 eUSB2 PHY.
>>>>
>>>> Signed-off-by: Ronak Raheja <ronak.raheja@oss.qualcomm.com>
>>>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>>>> ---
>>>>  arch/arm64/boot/dts/qcom/kaanapali.dtsi | 155 ++++++++++++++++++++++++++++++++
>>>>  1 file changed, 155 insertions(+)
>>>>
>>>
>>>
>>> Second try, without HTML:
>>>
>>> I really don't understand why you created such huge patchset.
>>
>> Because I looked at the logical changes that went into the big squash
>> that was initially planned, and requested that some of those was kept
>> intact - because they where independent logical changes.
>>
>>> Year
>>> ago, two years ago, we were discussing it already and explained that's
>>> just inflating the patchset without reason.
>>>
>>
>> We used to add things node by node and that was indeed not
>> comprehensible. Overall this adds features in large logical chunks, but
>> there are a few of the patches that could have been squashed.
>>
>>> New Soc is one logical change. Maybe two. Not 18!
>>
>> I can see your argument for one patch to introduce the soc. But two
>> doesn't make sense, because that incremental patch is going to be the
>> kitchen sink.
>>
>>>
>>> Not one patch per node or feature.
>>>
>>
>> Definitely agree that we don't want one patch for every tiny block!
>>
>>> This hides big picture, makes difficult to review everything,
>>> difficult to test.
>>
>> The big picture is already obscured due to the size of the content
>> added.
>>
>> Comparing to previous targets, I see the baseline content in 2-3
>> patches, and the remainder of the series being things that usually has
>> been scattered in many more small changes in the following weeks or
>> months.
>>
>> There's plenty of features in this series that are yet to be concluded
>> for SM8750.
>>
>>> Your patch count for LWN stats doesn't matter to
>>> us.
>>
>> I agree with this. That's why the QRD is 1 patch, and MTP is 4 (this I
>> think should be squashed to 2) - compared to 13 patches for across the
>> pair for SM8750 with less scope.
>>
>>>
>>> NAK and I'm really disappointed I have to repeat the same review .
>>
>> I'm not sure what you're disappointed in, this initial series is larger
>> than any we've seen before. I really like the work Jingyi has done here,
>> aggregating the otherwise scattered patches into one series.
> 
> The QCom folks can review all this first because I don't care to review 
> the 50+ binding (just bindings!) patches sent all at once right before 
> the merge window.

Unfortunately this is sort of beyond our control. We don't expect you to
review or apply these patches immediately.

The platform announcement just happened to occur at this and not any other
time, and we can't just ask the entire company to shift it to better
accommodate the kernel release cycle..

We do have an interest in sharing the work at the earliest time possible,
and with all the legal knots included, this is what it came down to.

I (and many others) made an internal push to upstream any pre-requisite
patches that we didn't need to disclose any platform details for in
advance, so this patchbomb is actually somewhat reduced.. but of course
DT and bindings are the main course size-wise and we simply couldn't do
it earlier.

Give or take 80% of the bindings will be "boring", i.e. "add compatbile"
or "add compatible and adjust clocks" because our hw is rather
standardized and the interesting changes often happen at a level beyond
bindings

> One comment on commit messages though. Please explain how the h/w block 
> is or isn't compatible with some existing platforms. Many just state the 
> obvious "add a compatible" or such. I've yet to find what kaanapali is 
> in relation to any other QCom chip. It may be the next SoC for the smart 
> toaster market for all I know.

Perhaps this would be useful to have in bindings commit messages, but
the cover letter of >this< series states that Kaanapali is the newly
announced Snapdragon 8 Elite Gen 5.

The product page states at the very bottom of the spec sheet that
SM8850 is another name for it (although the shift to codenames
happened precisely to disconnect from specific SKU numbers,
because e.g. both SA8775P and QCS9100 are 'lemans' silicon)

https://www.qualcomm.com/products/mobile/snapdragon/smartphones/snapdragon-8-series-mobile-platforms/snapdragon-8-elite-gen-5

Konrad

