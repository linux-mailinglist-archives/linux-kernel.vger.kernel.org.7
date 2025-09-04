Return-Path: <linux-kernel+bounces-801519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AEBB44615
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 884D83B9907
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5C7253B5C;
	Thu,  4 Sep 2025 19:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ex+d+zAG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1F921ADDB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 19:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757012635; cv=none; b=dM2Y6IBDFp7u9OaWy2A/EwaD42gNB6AVZQYccl0JgkiFYq6ua73MYaYGtW8mKGAw7Am8je63LHoObYEc1GJa/70u1Q12cHtIwUp5n5udLMe01Jaup8rrk9Ba88I2L+BOx5aXck7EFZo4BYtjrayMaChlpIxXxt9QToMvdhvu2II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757012635; c=relaxed/simple;
	bh=Gufh1BdYpf86NnJi9lazFUH1ZWU9lOnI4QZK9kqt6AI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JRxREAvOvzOiP2+BP8Bqsb6X+dLQMY2F714HwKXRGEwqEE30eEnysDCQJOdDatb1Nq9WbWB46UmeppKFWVowPvrBD7dLDI2vSRMVknD0sdFj0/gGbav3LIDP2C0UIO9Fgf8bPQbQrixemYzFDw/ALJ6zLhHxOBP+SEEqwmPdrHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ex+d+zAG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584I3J0b008120
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 19:03:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SDRXqOYk9u/oO7fiZpDU/+GHJbO5mPAWGLkB78rVgss=; b=Ex+d+zAG7XzK6GfT
	zHvhewBWxBXjWXW5CGDYLXdH5Sxj57xPlr315X9TKytz8zI2IU5UHw4tN7Kc3Tr9
	8W95lSIiUtB96Onw++b4nOkMfRry6HS1L4i9DVGkrqLSzvROWbAA67x0jY92bfpy
	gg4GccAwOhrafeDqzPPd0Ok5PWATLCqP1zSk+KGzWKqML1SZsdS68CLXDtJ3eQTI
	Mj/j5YGIReZNwQWbyHpzhc72oOjvnxkSxrZvDE0BltKH1WSYWVe5JlSPXMSWNQNY
	7JwpVdmaZHFXdX7BjxlgYat6N/qQXX90lhChULksV7kf+1qTj3Ew9ekfGV7I2XYV
	S/bXrw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjrkb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 19:03:52 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24cb39fbd78so18582305ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 12:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757012631; x=1757617431;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SDRXqOYk9u/oO7fiZpDU/+GHJbO5mPAWGLkB78rVgss=;
        b=p8r5ZqOmJfWszEDst2wVShmYWVfoY9G5V5Pwz3w4NHZcD0/RKSCxRb5tySFHWG0gvG
         1/xvUycbvAoDogalWKzgBULTmw16CUeaWQYRiX8yF3Z7E2dbndWGQmoW+ARtfUfgbaTl
         S2YhrtBWArRKYEV0MQXJF1W7mlZf7MbizCAXIrt3QiSUh6qHQ5T5qUNMwA+/e0f+V5kR
         /92R1YhX05IF2Ks6offjGVc+UsfP53CLHDWGyMPVfbmmGK7cMEcEyj71H+HgZ+eNIfHM
         1JFADbE7RSN++25KQtDkiCRxtV8cCP9U2MyonkRr8hXIwya7YZBrOD4aZ27izoKO8PA8
         G/Qw==
X-Forwarded-Encrypted: i=1; AJvYcCWmhrcDc4yfSa25dm3e7pqWdQPfGjpFXA1JkTsGWWZjscyVO4sEeBC4diROTw8WvfRXWEKdzNhaE+tps7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/e1TSoQyXroTG1zXdKozVax2jW3vZJyuByxDY0e3JbxM8mBos
	ToCG+H4GWOeYsAJ/MmJ0tCiL4n8nE/mGPp3rhJLm3YvpftdgHUOg0j2Jv+pqy20D5zluMuY44yg
	tDukG1mf4WZDl+asdC9xgeVsVMt4CIReY5lh2wsA+4btiHir0xKsrQtA7zM2BYfkO4pc=
X-Gm-Gg: ASbGncuC1GpRUjI6FUdoqVCDUtlwo2LmEyG9r43X/FsaXAcBTAsuEve/0berTYuBc8N
	YkGQBTGpxcOPefI7E+dbdSFyza1vHAy0hLCvXiAadbvLtiR/r3HKVs7Txa9QkTDEjoutlk2H7BJ
	f26WGDDu0E8CCQ27yCN/Ude7YMcNftc7eGuzNLUhzT8/etd0xiBbng8mu1mExthdf8RK2Ica1KY
	vb0RwPIEgbk6KKhTrjiCXcyZ/pjDLQuQAtUyybGSoMPFUTVgjEgHxvycMSHsspV9Gx/LLNnee9K
	5DjsAM68ceFlJp7qKIy+3fVMWfyypTMtWvgmq3LXpH4GBveRqLw2oljj2yevF9SN3yt1F1+R3eb
	gbw==
X-Received: by 2002:a17:902:ea07:b0:24a:def1:175b with SMTP id d9443c01a7336-24adef11943mr197222655ad.54.1757012630962;
        Thu, 04 Sep 2025 12:03:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI4BIqH7bu+Rvn2HhjDhkE6EWrcPdsri+BsrvIPeqWMVW00O9ePp18ygcGWSIcdGo1rv5xYw==
X-Received: by 2002:a17:902:ea07:b0:24a:def1:175b with SMTP id d9443c01a7336-24adef11943mr197222005ad.54.1757012630403;
        Thu, 04 Sep 2025 12:03:50 -0700 (PDT)
Received: from [192.168.215.112] ([106.206.6.136])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b2570cfb0sm72554555ad.139.2025.09.04.12.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 12:03:49 -0700 (PDT)
Message-ID: <68e1f0da-1fc8-44c0-bd65-4bb275daf792@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 00:33:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: Add binding for gunyah watchdog
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck
 <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250903-gunyah_watchdog-v1-0-3ae690530e4b@oss.qualcomm.com>
 <20250903-gunyah_watchdog-v1-1-3ae690530e4b@oss.qualcomm.com>
 <ea295ff6-5395-4470-afc2-76e5e2dc9fb5@kernel.org>
 <099a7c48-c447-40d4-9076-570f5a5058a2@oss.qualcomm.com>
 <29a91114-d862-452e-b7bf-1b659ad7d831@kernel.org>
Content-Language: en-US
From: Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>
In-Reply-To: <29a91114-d862-452e-b7bf-1b659ad7d831@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b9e298 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=6iY0yay2K6ZbG8zVuLWUNQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=zWFo3qVbXcOUHq55OMAA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: auphkm1rtoFHsyucg9L_vkOoJfM32kYo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfXxMKlRL2PnGVd
 zF6C8S74FX0MJZzIvLWyPaNegBXREapdsLTSuHDXE/xubfxffUQtyz0Jh+j7AbbNhjgGrj29Mxl
 0T/8+TxY3f2WEI1rcnG39i3awyVdH3z5ofinsfB1ab8B0w42fywBGpQ2JbomdOir0N56IB7jdt3
 hp7XcQd696r3ogagyE3114o6uwOlDZG44S+nsmv9WDqlYgUIC9EV/OFaBspW2sci4o5Z/fuoU7J
 M6gnKDSDBROmMNcDdxQNn3N+FIgebIXuND/f1Kd7g2M8oxItPvSW4NNPKlUZonnQfYiRrLNcBrJ
 8H2Mqunegogk/7HNzrz0QjYP72ZELpGsopISRHdDGhcEHxcD4b1gvQgQzIKOfWAmgYk3cycbm+Z
 fMCxerzR
X-Proofpoint-ORIG-GUID: auphkm1rtoFHsyucg9L_vkOoJfM32kYo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024


On 9/4/2025 6:47 PM, Krzysztof Kozlowski wrote:
> On 04/09/2025 15:07, Hrishabh Rajput wrote:
>>>> +properties:
>>>> +  compatible:
>>>> +    allOf:
>>>> +      - const: gunyah-hypervisor
>>>> +      - const: simple-bus
>>> What? No.
>>>
>>> Don't create patches with AI.
>> This patch was not created with AI. Reference was taken from the patch [1].
> There is no such syntax like allOf in [1]. Nowhere in Linux kernel, btw,
> that's some total invention, thus my gut told me - it must be made with
> poor AI tools.
>
>> That being said, I see your point about the mistakes which were made
>> while adding the compatible "simple-bus".
>> I apologize for the same.
>>
>> I will make sure `make dt_binding_check` passes with latest versions of
>> dtschema and yamllint as pointed out by Rob and as should have been done
>> with this patch as well.
> No, that's not enough.
>
> You should ask for internal review. I did an extra effort, I checked
> that and:
>
> 1. You did post it for internal review, BUT:
>
> 2. Your internal testing system pointed out errors (schema failure) or
> failed itself,
>
> 3. You did not ask your internal testing system to RETEST the patch, in
> case this was a system failure. That's your mistake. If this was true
> failure of schema, then you obviously should not send it, but
> investigate why schema fails on your patch.
>
> 4. You did not receive review (at least no track of it) but decided to
> post it on mailing list. That's also your mistake, because lack of
> internal review does not mean you can post it to the mailing lists. Talk
> with your managers or colleagues about missing review, for example.
>
> Best regards,
> Krzysztof

I agree with your points. I will do my best so that situations like 
these don't arise and save everyone's time. Apologies.


Thanks,

Hrishabh


