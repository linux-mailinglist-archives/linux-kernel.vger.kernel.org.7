Return-Path: <linux-kernel+bounces-886241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C9AC3511E
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 11:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A694200AD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 10:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64F03002DF;
	Wed,  5 Nov 2025 10:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RC+kGHDT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZVs+ePiA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B462FFFB3
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 10:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762337808; cv=none; b=Zw2RZ0HLuhmZr9PJihbFcGv3PR7HrJIFWI7feW7RmprQov5AT8u4TEyZdgaTfP1a2OFE/VUGWN+8RDwF2SQ4R5NIQyBg2LfUKmONgbwMl5c3za+aCl0dBQkeFCu1j+UpazJS68YfdxMHAem36ylUw136sAFtNwouCAdmInvC9zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762337808; c=relaxed/simple;
	bh=eYXTB12G4Jjz2dQ1iA0d+Zq4M53rRq5th60nE7Q8+ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fO++yFfYMR20xh2TCn8GGgq6i4wRHhQKSAmokGGuAzMnKEj9T6g2KyOVDnIz7tdvkQZM2w381lLtCpEFLhTh/ghY/Uffb4r+yp+uNKcpNcpclq8Y558sUlj1DLIwLTRRAmlTYMFJ9m0l2BJd2vLgeNBr1iKAjHGHJNO8FFVlZgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RC+kGHDT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZVs+ePiA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A571Zvl051155
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 10:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ta2hRtjIGYutwa8+T+jr5APKYGbkaeiNFYgNPk9GyZs=; b=RC+kGHDTS6JoWG5p
	L8H+qjW8iRH0MF7ABUr10ZTs/K10OcVvNiLn757+xRnXzXhNBg9e5RxrjkaFMVzX
	bLSVssRbVCLzIPtcjeePxnq+H6M2Ni74pWaGQn+9rZaMlLOC3c9j4hh5TWNBwoJ2
	QRB7mnBcBvqZLudzjzwmMEuIr0HM4qta+QM1cUkNzOulkiR3y6cNAkk2+jCxEqU0
	D15P0oA3gImp7EeOJO75rXrXwg4H/SpwV0jJVLMWr0hP7UvMgj7P78z+9tbDslJ+
	HIa8FLKtDvTwiuMssPMTDVEEqkE/MK9t8nuLcpFrQr5Fj8WbtUOyM6yGBKn6twzN
	dZFL1g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a81u0gj14-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 10:16:46 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-294ecd3fdd4so82772095ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 02:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762337805; x=1762942605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ta2hRtjIGYutwa8+T+jr5APKYGbkaeiNFYgNPk9GyZs=;
        b=ZVs+ePiAyFZ6vcAjN5ZKktYWy9gpDkAMhE9YbKHpRvGB+OU/a2bMmOaUC6LvH/ohmY
         kCwqkHuaoLkjX5AkAvPdOZ9uZjvaVIgN0GEhX2QeSmtOpvQxU1n+b/TNQjup3wh95Y9G
         TPokpxO0C8TrR0Vy5F0g7U6xZJvPCLEWL5KTfy5cQFi95lda7j5choaKBS7nOb2A4+zF
         4lKATIJsEhWbvkQiZXaQtCcxxM5O2K34EHJ8KCro+Vg4EIdZ2Jk4qtfOVaPA5xHyV1xN
         VRX3mKJjZkDHp28/87LpzpiUNUh+OCIVUVoBUXmNXw+2yXrfwVJHTF35LqmxkwXJJxGc
         xQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762337805; x=1762942605;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ta2hRtjIGYutwa8+T+jr5APKYGbkaeiNFYgNPk9GyZs=;
        b=w3ducYKL+2UK7yuLHcCHVxGwcgptsg8+do2kYPiRplis9z2vX24LELRUXn4dlrxzNp
         i4UiYhDqfPszF79KzNvW+HcVBQVcwaDCTiGprAuPfHsveJIjt0fSdGV2zymrDreICYhr
         rWd6CRa0YlneUhMDAAYucny1R1z2WZV7/IL61reqAMo6I+ECSTeP4Qq7qIU2nqanAZNw
         NwktZq6cGi77TZwaEztvdq0wOtHt95hI5YB2+difGTYNz2d4rzIvL3oi0r9SsSTC7uUA
         1j+NniuhBZrUk6GHtLhcXQBS1R43vfvupib4dJdCVMDwr72R2gdtvNm7Ljlq2roQLf5y
         R82Q==
X-Forwarded-Encrypted: i=1; AJvYcCVbYLYL/TERTA359WR64Y/lZfDHFwjEtva0xEXEBAR5Ow+izvSAuorhDJRSb4r/lKXxo6XLa9mNhkwoRSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfZDC04hE/MMYWjB5wvLm4kRbsKWkxOt7wLiWbH3EEWRHY2DO1
	22DsrOJmfw5OFyK4MoLyRc33/fcRTc3VSvWhmSdLiL16DMX5R/rypJAMBqbF/vBMJAodUjVfjnG
	M8xtxBFXNAzN5bevSc8vH5MTG8gr+wZLF8IMU0PcrTD4LCjoJQ+O3ESwBI16Vyqt7LevF12Bny+
	A=
X-Gm-Gg: ASbGnctGjfZODSWp+edKN0HBBKOq3bbSqa9ozpPGEnZp6zsgEszBkosxACfRfE6tEjI
	T5xT4JHyJM6gsfd5gjKi/yQJTf+XWMWZU1Y1Z+hLsLY5YVKICF8MdNHF4wIOD6ml/bg2aTnRR7J
	oZFQKaJwmR2fEB8v15F6Nuzlg4YegGCc783C06kfcdUbg1ncNG51D/e88PqhbNqPkOoeWMyJctm
	epIWVkVmeKiGeHsq9eTI5OCk8Vksl1qrpp4TU+ns6w0AsvBRdPFu+NUnnQNA19J5STEagkoYozw
	IM6cNrHJcLDYLG4zmUt0A6Hci5ahOKmFNkjU8MxnsKt0Othyf+6U6CiGEDuG30fCwQMIfRh0VYk
	6gC0k9LMD1l656c98bk8qmRIhnZXi/HvvkFxLNIGoeO6L7DwXm+CEj1BjQZknRUK08v2A4w==
X-Received: by 2002:a17:903:1ce:b0:292:dca8:c140 with SMTP id d9443c01a7336-2962adb9205mr41766615ad.44.1762337805118;
        Wed, 05 Nov 2025 02:16:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEERiVnLzKuHQJ0gmzb0TNIDrn5liDBDTJoghkGYIdT79j0+ZWIT8X5xbtlRH3ZR2fs/EOZQg==
X-Received: by 2002:a17:903:1ce:b0:292:dca8:c140 with SMTP id d9443c01a7336-2962adb9205mr41766255ad.44.1762337804622;
        Wed, 05 Nov 2025 02:16:44 -0800 (PST)
Received: from [10.133.33.81] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2960199831esm55608125ad.37.2025.11.05.02.16.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 02:16:44 -0800 (PST)
Message-ID: <dc2d7940-8750-4ba7-9e4d-05c8b4bbb819@oss.qualcomm.com>
Date: Wed, 5 Nov 2025 18:16:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/7] dt-bindings: arm: Add support for Qualcomm TGU
 trace
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: andersson@kernel.org, alexander.shishkin@linux.intel.com,
        kernel@oss.qualcomm.com, mike.leach@linaro.org, suzuki.poulose@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, coresight@lists.linaro.org,
        devicetree@vger.kernel.org
References: <20251104064043.88972-1-songwei.chai@oss.qualcomm.com>
 <20251104064043.88972-2-songwei.chai@oss.qualcomm.com>
 <20251105-industrious-oxpecker-of-valor-af17fa@kuoka>
 <746b292f-fc3a-43a8-89b1-76f61ccc0630@oss.qualcomm.com>
 <7ba7e32b-f00a-4f77-88da-047126a8c3f9@kernel.org>
 <b9e7f8ba-a629-4316-a6dd-d765ed0037ee@oss.qualcomm.com>
 <38452e04-255e-477d-8262-53aeb3c87a01@kernel.org>
Content-Language: en-US
From: Songwei Chai <songwei.chai@oss.qualcomm.com>
In-Reply-To: <38452e04-255e-477d-8262-53aeb3c87a01@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: fstQwsDNd59786636hHsMc5CUGg5mGD3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDA3NiBTYWx0ZWRfX8hAhsT4nzI7a
 mE8jeOGR8cj6jZO7L+uXZI7StdXE/nTR3mkeutq96mO8fZYB93ExIjV/pCe4YJUEHaeB0Iz+G8G
 2iP3QdeQhZk9cKSxmNXhRTdS0Cq3rzoH3SJHYY4dhuDQzfob0zZ7G9zepSP+qFrsJMftZv9GRl5
 PUXveUtIVd3+AAcHYW2s08PyGe6HCCX+n7uQQom47vj0YtvBGkbSPBUeGekUS34RDWdP0ecgSYp
 xHMXFJ/M7i1LOCMQSCenc68fiR9xy9vl9itsRgjjzJ3rew1Vne4Aho2/nzPMkjQ62mWaVNwl+KO
 X4OTj6fPwtZ/ycSFnHEgmR6ZVzJYNKlzBU00UiqF/U8gvb95EMu6BqZK3OVQG2ZPkUQP+aEHCZ5
 nchkbFjOQEUJYzjoO6iqQeD4t8RrQg==
X-Authority-Analysis: v=2.4 cv=KaXfcAYD c=1 sm=1 tr=0 ts=690b240e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jwEE-YN-BAOtPsYX2CoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: fstQwsDNd59786636hHsMc5CUGg5mGD3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050076


On 11/5/2025 5:03 PM, Krzysztof Kozlowski wrote:
> On 05/11/2025 09:49, Songwei Chai wrote:
>> On 11/5/2025 4:15 PM, Krzysztof Kozlowski wrote:
>>> On 05/11/2025 09:11, Songwei Chai wrote:
>>>> On 11/5/2025 3:49 PM, Krzysztof Kozlowski wrote:
>>>>> On Mon, Nov 03, 2025 at 10:40:37PM -0800, Songwei Chai wrote:
>>>>>> The Trigger Generation Unit (TGU) is designed to detect patterns or
>>>>>> sequences within a specific region of the System on Chip (SoC). Once
>>>>>> configured and activated, it monitors sense inputs and can detect a
>>>>>> pre-programmed state or sequence across clock cycles, subsequently
>>>>>> producing a trigger.
>>>>>>
>>>>> I do not understand: You got review which you ignored and then you
>>>>> removed pieces of this code to make it incorrect. Go back to previous
>>>>> versions so you won't waste our time re-doing review.
>>>> Hi Krzysztof,
>>>>
>>>> The previous reviewed-by is no longer applicable because in this
>>>> version, we moved
>>>>
>>>> the driver from /drivers/hwtracing/coresight/ to
>>>> /drivers/hwtracing/qcom/. This means the
>>>>
>>>> required compatible has changed from "/qcom,coresight-tgu/" to "/qcom,tgu/".
>>>>
>>>> Since this involves changes to devicetree binding, i didn't not carry
>>>> over the previous review tags.
>>> And which part of changelog explains the exact reasons to drop review
>>> tags? Not mentioning that changelog is almost impossible to find, buried
>>> under 10 pages of some repetitive introduction
>>>
>>> Did you read submitting patches?
>> As I mentioned above, the |compatible| string in this version has
>> changed compared to
>>
>> the previously reviewed binding. Therefore, I believe it's a default
>> rule that the previous
>>
>> |Reviewed-by|tags are no longer applicable. If the community requires a
>> note in the changelog to explain this,
>>
>> I will make sure to include it in the next version.
>>
>>
>> “
>>
>> Did you read submitting patches?
>>
>> ”
>>
>> Yes, the explanations in the cover letter were written by me, so I have
>> definitely read them. All of these explanatory documents are
>>
>
> Heh, why I am even reviewing this... you indicated in your address list
> that you do not wish review from me, so I will keep that in mind and not
> provide review.

Hi Krzysztof,

Apologies - I just realized i forgot to include you in the To list earlier.

Your input has always been valuable and welcome to me and i've learned a 
lot from our past discussions.

>
> Best regards,
> Krzysztof

