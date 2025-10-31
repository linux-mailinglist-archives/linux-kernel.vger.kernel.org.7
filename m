Return-Path: <linux-kernel+bounces-879627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5B8C239BD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46A5E426003
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 07:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3983F303CBE;
	Fri, 31 Oct 2025 07:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hEZ7Ub+K";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FRWZoBTo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53A12EACEF
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761896942; cv=none; b=aq4JCi0UTr2KYgt+h70j+KFO1GfdYaK2byMXpCL6rr7BxOhjqkFcf0xR4CL6NS3Ua+V8MPAzlJ3fLu3yNwe6cF9ci5gKfQdiGE6DkX9uJf4h5Ifi7rYGnBveST8u+M6ZW2gORMBmcKyGiegT3iHDLKsDf6FW8jou/Xgp85QKX1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761896942; c=relaxed/simple;
	bh=WLK53698RWkUe7j/W5XhFQUqclIVw+fDPkYKh+/+kQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XePwXQUb/Mh2a6v04pLw9wQW8oLITyPsnJmfDw0iWEUbKPT3SIx9MqXSgPmm4rEfir2lfG8mgC0DBdHS7bsrE6TqaJfDx6rpxlidv+KJ3W0RDkZtMc7I5/hH3Jb+VpZkr8gv6yQeaRvj1jBdS8xE4cfvGKjZSQYiDGc6zSjHqnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hEZ7Ub+K; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FRWZoBTo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V18VaN1513952
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bkxZLmVqscAeCOrO5e8bzA9KVYKvBCS70DXfZ9a5INM=; b=hEZ7Ub+KiNJNjnqi
	KTqHrGvNz7Fw98MUy+xnTk8YC5LwhSLpdutV17TWMXz7E+hMZAcjPgz/g0BDPLXA
	lph6yOYk10HXTurJYepn3eK7YA6M+xoo7ETWw+mVuw9D1zmgb40mGRH6mLwQSBHc
	sOULQr5tTgXAuIhDYY6bjxgBXKO0MBgO4FD+oIAjzcH3aQOzst0lft3JNxAHg9jl
	KY/dfQa+krpqOXWrHUPtk4b2mwiT1lDbCAZG85e5zO+IGLfk5aP+l7VLTEcVz6YR
	gy7aWbRVAoriU7GE4wdGXUqEtyKZTVFCOx2OCTxAhJO88Jj6aujm7UPEcmxSe/UX
	Ahvllg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4k69gvdh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:48:59 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-290e4fade70so23457215ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 00:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761896939; x=1762501739; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bkxZLmVqscAeCOrO5e8bzA9KVYKvBCS70DXfZ9a5INM=;
        b=FRWZoBToGN5dSUx8NyDwrV0z+flUZIs6rmYXxXga6vPkn5cPmNy/dBuETovyvKy1uD
         mARbuySOtGdYOWGhLWIkJa+kbiiXVLVx6pKw28HhfolaW2LtWYeiOnTCCm2QpZp4QB2W
         Wr+0GU2RxD8z6mTSFzmAy3pdjBXn6gNnz3sfHvpFRe6PQoKtFY2waF+wD21lGE6wkm5A
         J2492Jln6jookDexYSwub+Gh7IypjFsONfLGs5t3zhPbfYmFfQnmzMdmas72PzpfgB5o
         pzcrfSldfZuot/wpg1ANJ5oCy6TPOZ+HyGx0eBACzt5DJL8wBem8zDyn28eKTkszVIrs
         NOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761896939; x=1762501739;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bkxZLmVqscAeCOrO5e8bzA9KVYKvBCS70DXfZ9a5INM=;
        b=B9LpExnUxQAhbhWCypRPlFgakLtW2SOcoU2KpaXDWb52RjP2do6mBwsk9OLI9zlQ2G
         +yYq+1vH/KdwZQKBiEQStXlLIwrifNM9aFStFDKMbLYlbi2RzyjfZZLxRlpTH3/tc26s
         t5rBDw4LivlmwsGBzFWWYl+Ltu3aMBuJQZvrUaPwCWfN8JUEUEfrz6oMfEyn0qVCwDOL
         bkN1O78vXuJmCRbJMhx+nZXHhguYzAoBz6EVG4mS4QBFS6hRCht//Xo8hETqo0CN0Pfq
         2mBRd5VXSFB42yHZNOAXgMoG2FOmO/ThZTxBvGYF7t/cmUKdkPpSeKFGaUXmLZpwuPxj
         aAww==
X-Forwarded-Encrypted: i=1; AJvYcCXp6/ql+pdhia9tPLGif5EIq8U85WNjw/FuoNaEz46bzojxe/X9wxxD235nkw+PRxS7FF6dDjq0CjJk4tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrUTr4xnrghWesg6ZcdgxaiewpYIM1J6rzrhXPLRrL+EE/wA+2
	cHJ7qqPuSH3dDRrRmgP1Ldkz6jAoMUs4pIPqYb7i0TfNkM8nOmCZYsX/C7alFh0qbiXSULsiEAk
	CMKdlvB6xniBDzsFvr6qWlOxtD3mDpVqdx4r0s0ow+KVBpsscArVh/cYKj8gssoyMfqM=
X-Gm-Gg: ASbGnctXOkUXuzDcW1TV91Zl/OnM8wN864eClP8/ozZCxn2QcZbtlMeCjJqQUhOhkx0
	GJnOAKtin0jm6jHVi6QjD3KNf84CCPEAtAHbe64ecxixcy/V2oAmBiwvb2adfGym8S9GZFyWgt3
	N6+4Xf6qEjStCizjmxPvrRPu5kSwhxySnhB7/0jglIcd5eZEg5Kj4G3DDjuFdc4IuyGmy9i6+MK
	HDkdw3OssZb4AXLkMXWnHLSnW7hHWP4qNBVx5rlmvB6yHGg9SG9opMVcJt/ELoSTSu+FQakhrBf
	WPFZwWDTIDNPnBElm2faCLw6FzoftBOU0tJ24NB4vKR1/q3rkVfaMYaJzomvkqnLpl//UpX10+n
	0QWZDmcqEwnT7tQWO8kOd25HQmXlpKLMUqw==
X-Received: by 2002:a17:902:e5cf:b0:293:b97:c30b with SMTP id d9443c01a7336-2951a3a6519mr34263125ad.9.1761896938485;
        Fri, 31 Oct 2025 00:48:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWUdY+fpB177Qc3WIW6c5K/s8cZs2yiw2nxJ7R+yZ5EloOzojzhdxV2zptF/DJFbH/nAVyvA==
X-Received: by 2002:a17:902:e5cf:b0:293:b97:c30b with SMTP id d9443c01a7336-2951a3a6519mr34262775ad.9.1761896937935;
        Fri, 31 Oct 2025 00:48:57 -0700 (PDT)
Received: from [192.168.1.3] ([122.178.56.191])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295268716d9sm13356245ad.16.2025.10.31.00.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 00:48:57 -0700 (PDT)
Message-ID: <4876cb9e-4b93-418e-963f-982fc7ba4a18@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 13:18:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/3] arm64: dts: qcom: sm8750: Add USB support for
 SM8750 QRD platform
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
References: <20251024151521.2365845-1-krishna.kurapati@oss.qualcomm.com>
 <20251024151521.2365845-4-krishna.kurapati@oss.qualcomm.com>
 <a117b105-a734-4f67-9bb2-c06728e79083@kernel.org>
 <6297468b-77d0-4202-8ec1-3e731acc43de@oss.qualcomm.com>
 <6234e22a-c119-419c-83b7-2a53467951da@kernel.org>
 <a8046f0d-ee74-457a-aafa-6473c67c6ab8@oss.qualcomm.com>
 <bgnu7pvxxmcucip4ytfxii3f73vhc4zw3yxobpc6d4s5enc7lj@nrpmu3f3tgxh>
Content-Language: en-US
From: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <bgnu7pvxxmcucip4ytfxii3f73vhc4zw3yxobpc6d4s5enc7lj@nrpmu3f3tgxh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: GtT2-8uPhg4D3_7qVsIUbgHHNZeGvsMY
X-Proofpoint-GUID: GtT2-8uPhg4D3_7qVsIUbgHHNZeGvsMY
X-Authority-Analysis: v=2.4 cv=OYaVzxTY c=1 sm=1 tr=0 ts=690469eb cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nBTQbq2h+7tEuhtSPO5ERQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=v7ZzXi2vkUtTpdPo9KEA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDA3MCBTYWx0ZWRfXwyMVRTo2tXLe
 Dly2RnkxIvi1De/pb68WxuJFPhmpACbFIcXjaz7K5JKu2FhptRPIAZ8YkqGsBCil0dioTmG1mNf
 tENPHrCvWVZ5imhqij1UpgxKlFglaXECy8l1MEtRIaAbf4gTHRGpMDiMgSNizT8O4IxW4/s6Q3h
 A/0sT2Io8ZE4kxmLvmjLrSJSjewYU52gNJWy4qbJqEw8VVKcyO8ugCwoAG7TgciOAKs7+3PwQFy
 fX9aW3lA8XCuiyodXTdran+SbKIajW3KHZgTrUDQ61Y3W2p8kIf2WvNhQtEBG7EnHFtLEcL6RV1
 xbUP1H5qmvhX7Rte9xN53jGuQD2oxZ4kwhtuDfxjAjgmYFtelZUygeMCSMLS4xV03OMKHRRxNi5
 yKT318tjL8l+DMJypAw5t2NC7bkwOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310070



On 10/29/2025 6:36 PM, Dmitry Baryshkov wrote:
> On Wed, Oct 29, 2025 at 06:00:02PM +0530, Krishna Kurapati PSSNV wrote:
>>
>>
>> On 10/29/2025 5:35 PM, Krzysztof Kozlowski wrote:
>>> On 29/10/2025 12:42, Krishna Kurapati PSSNV wrote:
>>>>
>>>>
>>>> On 10/29/2025 1:37 PM, Krzysztof Kozlowski wrote:
>>>>> On 24/10/2025 17:15, Krishna Kurapati wrote:
>>>>>> From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
>>>>>>
>>>>>> Enable USB support on SM8750 QRD variant.  The current definition
>>>>>> will start the USB controller in peripheral mode by default until
>>>>>> dependencies are added, such as USB role detection.
>>>>>>
>>>>>> Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
>>>>>> [Krishna: Flattened usb node QRD DTS]
>>>>>> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
>>>>>
>>>>> NAK.
>>>>>
>>>>> You ignored every previous tag - multiple reviews and tests, and then...
>>>>>
>>>>>> ---
>>>>>>     arch/arm64/boot/dts/qcom/sm8750-qrd.dts | 22 ++++++++++++++++++++++
>>>>>>     1 file changed, 22 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
>>>>>> index 13c7b9664c89..fc5d12bb41a5 100644
>>>>>> --- a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
>>>>>> +++ b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
>>>>>> @@ -1054,3 +1054,25 @@ &ufs_mem_hc {
>>>>>>     	status = "okay";
>>>>>>     };
>>>>>> +
>>>>>> +&usb_1 {
>>>>>> +	dr_mode = "peripheral";
>>>>>
>>>>> You sent something different with issues.
>>>>>
>>>>> Really, this was a correct patch. Was reviewed. Why you decided to drop
>>>>> all this, drop everything which was correct?
>>>>>
>>>>> Your explanation:
>>>>> "- Removed obtained RB tags since the code has changed significantly."
>>>>> is just wrong. Almost NOTHING changed, except completely unimportant two
>>>>> node merging.
>>>>>
>>>>> NAK
>>>>>
>>>>
>>>>
>>>> Apologies Krzysztof,
>>>>
>>>> On first patch that adds changes to base DTSI, there were changes moving
>>>> to newer bindings and merging child node and parent node. I should've
>>>> removed RB tags received on that patch only. But I was over cautious and
>>>> misinterpreted the rules and removed them on the other patches as well.
>>>> Will be careful the next time.
>>>>
>>>> Also is there any issue with marking dr_mode as peripheral here in usb_1
>>>> node ?
>>>
>>> No, I think I looked at your other patch. Tthis was reviewed at v4 and
>>> v5, which then it was changed breaking sorting order. This one looks
>>> correct.
>>>
>>
>> Ok.
>>
>> I will send v10 tomorrow. Can I add yours and Dmitry's RB tag on the MTP and
>> QRD patches and then send it ? I will implement feedback from Dmitry on SOC
>> dtsi patch in v10.
> 
> Could you please answer the questions that I asked for this series?
> 

Replied to the questions and will update in v10, mentioned dependencies.
Also will add qmp pipe clock in gcc properties.

> Also, why is there no link to v8 in your cover letter?
> 

My bad. Missed adding it.

Will fix it up in next version.

Regards,
Krishna,


