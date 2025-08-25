Return-Path: <linux-kernel+bounces-783859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B3DB33390
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 03:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA85F17B666
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 01:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE5F21D5B3;
	Mon, 25 Aug 2025 01:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W9KN47ch"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F441CEAC2
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 01:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756085587; cv=none; b=KGt9bfej2kv3xpH7DkzE5wWSCiHhjWNgxNL/citvNfdSousNwCtn6JvDNTId6SxxK8E41rYYTfq2G6IGgMoUbUjCddDwfb4gszuUYLzcdh4wwmZOsnDiJSNHQgg3b06afTYZ2+16S3povLXAChlENFZmmBvX1Jsx0xM0aX7X0Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756085587; c=relaxed/simple;
	bh=IEnN5jzC0xPifQD1FTMG4+swJ7cJ8LQtCAIwc/49fU4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ekb0kS6ox7a78g91rU5Tf8FZpkvDNciskZTlcl9WX7dIktaUH5JlY9JyHY+J9g9SjZ5gSoTMFq67FskRhCFP+79tLTAw6tBRAn04YgW/GkzeP+4/J5XVtKoWQvhjOv9OjN81z36AK9HlXtMft/hvLNbjqonwRoRLCUaC7KlKn3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W9KN47ch; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57OLqfeK009314
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 01:33:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K6E22yah7RSaBBMqG2z+3SW7CvB325/vsH5zTcMNA9Q=; b=W9KN47ch+CdMX9XM
	MP7DMdWXixwcEekg2jQ1kogTdnBPsM6//cCJVzKzGoXNggSXYcTIwzRTAesfC1R9
	ebmxW2ujk5pR4O5HAMUpnprbBnn9q1pk6bagr3GW/Qxe2d3imsG6gGOxzJmKrm0Z
	vXabB3r61hRyM606cAe87ZO53ewpZSptRMbNTzh8V+9ns/b2s+JrrczBJpeqtOEk
	lQUL8JAJyrR6QrCiLQOo1KJiBuYetCr73jB4Ts4M6Q9oiIt/jOsYHNBWl6xtIOnj
	nECZM3J/Y07kmbY6vrr/76knhY1MVyzL/Thf9sl5Jxfo9XsxT5hMWWxXhT4dcI2e
	UreKDw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q6de39te-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 01:33:05 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-246072fe091so53886615ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 18:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756085585; x=1756690385;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K6E22yah7RSaBBMqG2z+3SW7CvB325/vsH5zTcMNA9Q=;
        b=aZTK7KM+eUHvjQnimn5mQqmNYw+g0vufsQmdqnicQ1hU52hlqeJChuowna43fEoSL2
         fUZUjNOZ0RIc/dBCwEtx8rKJMprIraL/qT62YPN3+/d++WFGQQ4EOJYxAQUd2eScdgIZ
         GXuQEJ3V8DjefYMbUMC7k6l4KffbSKqhtRv3rcF9+Gk3iOrokowqZgfwZc/8hru70dpx
         Cro/9/Uz2b2u37KDZ1bYTqwzsZDqiOEJzq0rAT+hlbZlvuPfK9IPic2XqzaUWFrLEcqt
         HMRA6NzhcLRNvv2l3irSHsVNzXGHRn2J5BZxrr1YldV1a6xrlPDPSjxYf5I1HzMFnpui
         BOrg==
X-Forwarded-Encrypted: i=1; AJvYcCWcbYulWuYvtLz1fn+SgtYQFW+hdrBrnu1SpiVv5U3RtqzAvKQeX1N6IpAOcp4kJ2SsbtL4GOt9wE3SX+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf+GNf3RSWN3OAx6Wmm0PfbFX+MNC/qKnf45r2xPK+0dHeTgUM
	l9Xqb3QEha0wSlLlrKVq7W1v3dsOv18coeaB5hgs9Dnt2/Ujz+ir75AXv5bzmMCI0d5fqxp/mgZ
	F/skBUfaLORLaydt1wctby2E9rEciNtKPJCZVFCr13xN20fcyHSMaKsu6rf3GsnHjaB4=
X-Gm-Gg: ASbGncuKgO0De8gGSvtUec4lxh6A0bcuRPRrMJdZeRXOJ1nJ6fDVlq2sOXecZUrsAgd
	XEv5vnyJUW6Ax1K+jT0eQm2vraJ8+A35779VfnepTUEF8m4pFh33ilN44HoAd0e8wyofGnbmlud
	ruZXkHnMMsalktfmLRo7YialgjEtoV9jc9tVrLTcpDE8E+8MaPbjfuDl2UWQNYi9Sf+zzBY9DNH
	v2lGoqmR5TXjC4HGS7fcoezT8Xgwy0LNUAHY3NsAwIly/qTe4DxgoWzbKQzh2fcaMD/raPme4LP
	tkB5Tv6a/2JBCrzPgxjFdRBQznIaadlshaIx83dcna12OS5bjidwSDGDO8noIHu3Swd8LCe+F7C
	D5Fx/QQFydBa40nw9WjmkYjmwsqwsdw==
X-Received: by 2002:a17:902:ecc6:b0:243:38d:b3c5 with SMTP id d9443c01a7336-2462ef1564amr146761555ad.47.1756085584619;
        Sun, 24 Aug 2025 18:33:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJHNnP7iSIPuTBnCfkd1kHAo6DmPEz7vDeIdsiBninAkHPKiPmI83toT+uDqJlo73Uw+Et1Q==
X-Received: by 2002:a17:902:ecc6:b0:243:38d:b3c5 with SMTP id d9443c01a7336-2462ef1564amr146761305ad.47.1756085584073;
        Sun, 24 Aug 2025 18:33:04 -0700 (PDT)
Received: from [10.133.33.155] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687b0feasm52811395ad.46.2025.08.24.18.32.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Aug 2025 18:33:03 -0700 (PDT)
Message-ID: <74038a79-8c59-496c-9a61-08dc786f9c10@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 09:32:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Enable CTCU device for QCS8300
From: Jie Gan <jie.gan@oss.qualcomm.com>
To: Mike Leach <mike.leach@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250624095905.7609-1-jie.gan@oss.qualcomm.com>
 <c7cca483-f1d3-45b4-abef-ec5019ad57dd@oss.qualcomm.com>
 <c6f74d55-6ea8-498f-a05a-000599f93ac6@oss.qualcomm.com>
 <b5f8fce0-afe8-409b-b43d-fa9f413cd442@oss.qualcomm.com>
 <CAJ9a7VgZ61oL4LLxKSon3LXsYDtaHaPcGNxW=cwzhSOs3ea1PQ@mail.gmail.com>
 <bbbec517-cc2b-444b-b76b-a4930902d667@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <bbbec517-cc2b-444b-b76b-a4930902d667@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNyBTYWx0ZWRfX6nHZj2u6faOm
 nPaBffkmnlWxWhlOkknDsw2zFi+G4enQ1sSPuw6KlkZyn8CQSdSNDuef0b/rIbpBPhaqBAextxc
 w6QvvHcX63uO+zYhiL39x0hlgrwDh8aQE2hpOu51X6cMexseuuj/V0yWfeGLCvjGSjdR6I80QoP
 5xp3MgFnM/B8z/vh+qcd8/3dLKJ9afCx9cfOYyX/lT3j9JtY7JcR+XIiR+7PxnoPw3hGoH6+0lh
 JPEtjvwTJe0Bc5nibijQAb6IKP2uWAVitbNI0o9C+1A6AqtGGLu7OfsE+nqb3u9QXkCNS86Bv+h
 K7o/0AjQlpCem+iFxZJAXFcqRqAfxIhgDV0w7xeHyA19bZph04NZqs4vuGF18eF1z0oKdJPqUSA
 +g1qiLAR
X-Proofpoint-ORIG-GUID: ahDsXbnbQdQfzI7TaY7RDV7Ga9gW-KTw
X-Proofpoint-GUID: ahDsXbnbQdQfzI7TaY7RDV7Ga9gW-KTw
X-Authority-Analysis: v=2.4 cv=K7UiHzWI c=1 sm=1 tr=0 ts=68abbd51 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=KrWnKaeQ6KOPjblB_ggA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-24_08,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230037



On 8/5/2025 6:25 PM, Jie Gan wrote:
> 
> 
> On 8/5/2025 5:53 PM, Mike Leach wrote:
>> Hi Jie,
>>
>> On Tue, 5 Aug 2025 at 05:11, Jie Gan <jie.gan@oss.qualcomm.com> wrote:
>>>
>>>
>>>
>>> On 7/28/2025 9:08 AM, Jie Gan wrote:
>>>>
>>>>
>>>> On 7/15/2025 8:41 AM, Jie Gan wrote:
>>>>>
>>>>>
>>>>> On 6/24/2025 5:59 PM, Jie Gan wrote:
>>>>>> Enable CTCU device for QCS8300 platform. Add a fallback mechnasim in
>>>>>> binding to utilize
>>>>>> the compitable of the SA8775p platform becuase the CTCU for QCS8300
>>>>>> shares same
>>>>>> configurations as SA8775p platform.
>>>>>
>>>>> Gentle ping.
>>>>
>>>> Gentle ping.
>>>
>>> Gentle ping.
>>> Hi Coresight maintainers,
>>>
>>> Can you please help to review the patch?
>>>
>>> Thanks,
>>> Jie
>>>
>>>>
>>>> Thanks,
>>>> Jie
>>>>
>>>>>
>>>>> Hi Suzuki, Mike, James, Rob
>>>>>
>>>>> Can you plz help to review the patch from Coresight view?
>>>>>
>>>>> Thanks,
>>>>> Jie
>>>>>
>>>>>>
>>>>>> Changes in V2:
>>>>>> 1. Add Krzysztof's R-B tag for dt-binding patch.
>>>>>> 2. Add Konrad's Acked-by tag for dt patch.
>>>>>> 3. Rebased on tag next-20250623.
>>>>>> 4. Missed email addresses for coresight's maintainers in V1, loop 
>>>>>> them.
>>>>>> Link to V1 - https://lore.kernel.org/all/20250327024943.3502313-1-
>>>>>> jie.gan@oss.qualcomm.com/
>>>>>>
>>>>>> Jie Gan (2):
>>>>>>     dt-bindings: arm: add CTCU device for QCS8300
>>>>>>     arm64: dts: qcom: qcs8300: Add CTCU and ETR nodes
>>>>>>
>>>>>>    .../bindings/arm/qcom,coresight-ctcu.yaml     |   9 +-
>>>>>>    arch/arm64/boot/dts/qcom/qcs8300.dtsi         | 153 +++++++++++ 
>>>>>> +++++++
>>>>>>    2 files changed, 160 insertions(+), 2 deletions(-)
>>>>>>
>>>>>
>>>>>
>>>>
>>>
>>
>> You need to send a new patch addressing the comments made by Krzysztof..
> 
> Hi Mike,
> 
> I just proposed an idea to add a common compatible for CTCU device, its 
> not about the patch series itself. We dropped the idea and prefer to add 
> the board specific compatible for each platform.
> 
> Thanks,
> Jie

Hi Suzuki, Mike, James

We already have the tag from dt-binding and dt maintainers. We haven't 
additional modification for this patch series. Can you please help to 
review the patch series from Coresight View?

Thanks,
Jie

> 
>>
>> Regards
>>
>> Mike
> 
> 


