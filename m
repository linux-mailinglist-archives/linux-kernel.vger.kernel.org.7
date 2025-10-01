Return-Path: <linux-kernel+bounces-839173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3DFBB0F88
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 17:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A406322259
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 15:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C3A30AD09;
	Wed,  1 Oct 2025 15:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zwjp3r5P"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE60309EFA
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 15:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759331036; cv=none; b=eKbJwIUJ8TPScm3b4CcwkCjWDXBiI1S4PedrBkPrpikAE40zElW+K7OOJW5dBucoM2q+G4lRZN46dZHVnfmEqsD0byMcZecKY4sNVen04KVY8ZlU9GWntxHMd7vPjmoGJcpiFf+x4R8dxioCkV0c4zIWYMSF7q6wAoKQVBZJjis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759331036; c=relaxed/simple;
	bh=Ne/1emli/qNR+CSGY/RT6fRMcITyKtKShhbED1YmozE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eUYplmlM/Knwc2QPWgqzy03d//QFNY9bl7tQljjQbpu6gFcZeWJBatJxFQTkULP4xEQP9OwEeBLC7pKffiC4a1X6490Nu7i+pReBSfjCK2z73848fKJ1fXWvNMvDGaMkpmuyOznEabCmd3gXNaAtsa1uL7BtEqaZ6e6LMoLefnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zwjp3r5P; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5919eXiI016961
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 15:03:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZJfQa+8s08ZkdGhtiYIX3xBNflVlw/lYZrO+tw+/a4M=; b=Zwjp3r5PKA0yInJc
	AWwujlGWsfudP7B/ofYT7pw+8BkB3BxaPYp0PEp/7wMKJz0klyYxgwdab25SQjFU
	C+AXnLlbokpthItSIMSlKycWwx/EFFp4r0aS5SuW3SADMz/cO0c5NxOYUVf9XZWV
	XSEpVaVOvNeTYj0aUDdu4cABCjj9drtoFKHcsn9pLIFmZImB4HaHnY4AnhFClonw
	VvhMMQVom7g1eZZCDEI0xx+sCslXMePJlubtziMLGzcMgTxfarGXz7p5csCmB4Lm
	15dkXtuqDTnEwSE4AUJHH/7d/ZsEfY5VI3IRa1JS+P1IFulyZ7j989N1Hh/iZqls
	8iWyYQ==
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e93hmpuu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 15:03:53 +0000 (GMT)
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-429278a11f7so50188615ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 08:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759331031; x=1759935831;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJfQa+8s08ZkdGhtiYIX3xBNflVlw/lYZrO+tw+/a4M=;
        b=R/a8G+zdUq5Vsbo2DTwttYbSAxzaro2HI7/3QqIs4+3LDCwuJO4vc3gHYo8HC75heD
         IrWi3z8+3GofpVcOqYxmRqhkPmhLsGxMy8PlgteBmKoN6UOitBIdc++2ajcin7hDLvsU
         gi2zQaDQvGm5GnnfKb2nQIfGF2cqX6v40CqEcidiWYwoBQpwKsYGsVjKjQMbzoikolbh
         LWQlxDxu5+UAqdqpQZFHWd4+pQ3uwdddWzrzmD+gskjpMATULfYYhmKhWt4OdBXY7ZUk
         JwR//FoOC7KFHCTwK3QPwrOWN20skKTmFHFUYEjQOMEj5izcvn6cMeao2Qa/iWYGENnl
         cDYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYHA24aJ9P1qgBbExDjE+RClNHG9oXb6TpcWSLJnKBEEW7a3FnG2vKSXyi8qrDj93P6xUdq8iQDT9VSls=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNM3HJMjcwaGrDQ/frFIUkIjyXFmm/OGz5jmBpETvDIb6rLvTO
	fD2Ua9WXy+J+LpOHSWk+ucGiryxp/ktDctAS7YbnvCebGMxW9LgzCCqkiYPf9Dugk6Uwya9NMnm
	jLZ3MB8txOZago/UbPWW78wRMrAFHFSuJ+RHo6ne87qmSewCceBKNtqkWOKNjsRg/vdQ=
X-Gm-Gg: ASbGnctiqMZF4WsAoGkx6pJM+dhL9eA3P7XBViWxkSu+beGsEWM9CsTY1upxYK6t7sR
	pht93kuugIyZbtSGvCr9tX8hmSpxO/YNhiU4KjR92BtDzssGCrJ3csBDhS5moGxuEb2Fy+UgcXP
	tmjXt3lqAZt5PhFtBo2ogZSdbIGsYSr6DEIT49Pl0cgsoAPMlXnK135KQDwq9t9Jvfo/LUo5buT
	LXJ7MGlRzo1DRv3JJlAnVva1bRtgjwj5x6sufCz6DlgC/eVfBzgeZGo40/JIeXjIwEvjadwspnq
	fggSKtusU2Qw5zQt1V5CHOr9CIulymRb6GZXFmBgswyXxnbf9EqoJJEhXulcJPVRjyGN0KyB
X-Received: by 2002:a05:6e02:1d8b:b0:42d:7dea:1e04 with SMTP id e9e14a558f8ab-42d81680306mr60427075ab.25.1759331031182;
        Wed, 01 Oct 2025 08:03:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAh/o38qCjV/z7AmcOIL1eFdOOFJR0dPaq1/cxvmmMMiAnwbipvHaISIPwZ6i6ggPYkIYvPQ==
X-Received: by 2002:a05:6e02:1d8b:b0:42d:7dea:1e04 with SMTP id e9e14a558f8ab-42d81680306mr60426075ab.25.1759331030487;
        Wed, 01 Oct 2025 08:03:50 -0700 (PDT)
Received: from [192.168.68.121] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-46e611970easm25118405e9.2.2025.10.01.08.03.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 08:03:50 -0700 (PDT)
Message-ID: <b3147370-11da-4202-abac-36218487578f@oss.qualcomm.com>
Date: Wed, 1 Oct 2025 16:03:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slimbus: qcom: remove unused qcom controller driver
To: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250724132808.101351-1-srinivas.kandagatla@oss.qualcomm.com>
 <CAL_JsqKG+dcMgp1QF4F3Oxh5Shvagg6cSde=g1JMcEAquZhH_Q@mail.gmail.com>
 <990cb5af-3846-44a3-b373-ded62d3309b9@oss.qualcomm.com>
 <CAL_Jsq+zC91GPdzQQa9F8KEw5UL4xc13u5U_5vTyQG1WeJa5rw@mail.gmail.com>
 <82906e08-9583-4f4c-91ad-d5b53b2dffd6@kernel.org>
 <CAL_JsqLtLbCqzHzcaGAuYwxqr=e9HZFX8X20tndx7US-XjhH3Q@mail.gmail.com>
 <CAL_JsqLcinpeJyib+JG7UFspUqXDTzCLguF3Nt4JJY9YncTb9A@mail.gmail.com>
 <b8c1365a-545d-40ae-a39c-e15a3e1f07e7@kernel.org>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <b8c1365a-545d-40ae-a39c-e15a3e1f07e7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MSBTYWx0ZWRfX/umFk6GxcW5l
 e5myzJuaXEBhfxXFKKqJyHrdLmq9NKUq2hi6cnZnIaKZTMTYHsNXLPANewbHERAAmqpDyi1qnc3
 q6dpkjG4bAQDrubidrAOEkKmj7GUbsjWKmGjBkiu10p4pvTLjK6Khur2xJHAtoPJS0B7xxgI3ka
 EgP9EgbN8YCq4IH4TilXOk+bBhqsRPTFSiAu8RLpYBsAKgBft7waZYjnB+fVZpv+3gHR1ZdBpA1
 KFwEA/eFh+jLQj8nxhKGg6VdIO+Oi1Xv0S1k517MWpWN2hsNfQK4TMYaHvg2U+646UDqW7LP4Zq
 FEV6mHmU8RKREmsssQrIQOmS5WCX11Vm5hFnC6tXH91ODylj8P3IQX9VRgGEUIpfS18RcDCfvBo
 bzDBaRA/3dofVrhAlbagxxAB3Pzl7w==
X-Proofpoint-GUID: 57Z9Byiw6Eu29A9M-me9OtcWf0pb1tXZ
X-Proofpoint-ORIG-GUID: 57Z9Byiw6Eu29A9M-me9OtcWf0pb1tXZ
X-Authority-Analysis: v=2.4 cv=Rfydyltv c=1 sm=1 tr=0 ts=68dd42d9 cx=c_pps
 a=vy3nvQW9C2dqy/lMnN3IYg==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=WCg39QfALH1NCTeANmoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mHQ74H5e8mo-RpSg_uaF:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270041

On 10/1/25 3:21 PM, Srinivas Kandagatla wrote:
> 
> 
> On 10/1/25 3:19 PM, Rob Herring wrote:
>> +Greg
>>
>> On Fri, Sep 19, 2025 at 12:25 PM Rob Herring <robh@kernel.org> wrote:
>>>
>>> On Fri, Sep 5, 2025 at 12:30 AM Srinivas Kandagatla <srini@kernel.org> wrote:
>>>>
>>>>
>>>>
>>>> On 9/5/25 12:08 AM, Rob Herring wrote:
>>>>> On Tue, Aug 19, 2025 at 8:44 AM Srinivas Kandagatla
>>>>> <srinivas.kandagatla@oss.qualcomm.com> wrote:
>>>>>>
>>>>>> Thanks Rob for reporting this,
>>>>>>
>>>>>> On 8/19/25 2:35 PM, Rob Herring wrote:
>>>>>>> On Thu, Jul 24, 2025 at 8:28 AM <srinivas.kandagatla@oss.qualcomm.com> wrote:
>>>>>>>>
>>>>>>>> From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>>>>>>>>
>>>>>>>> Qcom Slimbus controller driver is totally unused and dead code, there is
>>>>>>>> no point in keeping this driver in the kernel without users.
>>>>>>>>
>>>>>>>> This patch removes the driver along with device tree bindings.
>>>>>>>>
>>>>>>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>>>>>>>> ---
>>>>>>>>  .../bindings/slimbus/qcom,slim.yaml           |  86 --
>>>>>>>>  drivers/slimbus/Kconfig                       |   7 -
>>>>>>>>  drivers/slimbus/Makefile                      |   3 -
>>>>>>>>  drivers/slimbus/qcom-ctrl.c                   | 735 ------------------
>>>>>>>>  4 files changed, 831 deletions(-)
>>>>>>>>  delete mode 100644 Documentation/devicetree/bindings/slimbus/qcom,slim.yaml
>>>>>>>>  delete mode 100644 drivers/slimbus/qcom-ctrl.c
>>>>>>>
>>>>>>> This adds warnings to dt_binding_check:
>>>>>>>
>>>>>>> Documentation/devicetree/bindings/slimbus/slimbus.example.dtb:
>>>>>>> /example-0/soc/slim@28080000: failed to match any schema with
>>>>>>> compatible: ['qcom,apq8064-slim', 'qcom,slim']
>>>>>>
>>>>>> Will replace this example with slim-ngd and fold it in the original patch.
>>>>>
>>>>> Still warning in linux-next...
>>>> Its done now!
>>>
>>> Now I get this:
>>>
>>> Documentation/devicetree/bindings/slimbus/slimbus.example.dtb:
>>> slim@28080000 (qcom,slim-ngd-v1.5.0): 'audio-codec@1,0' does not match
>>> any of the regexes: '^pinctrl-[0-9]+$', '^slim@[0-9a-f]+$'
>>>         from schema $id:
>>> http://devicetree.org/schemas/slimbus/qcom,slim-ngd.yaml#
>>> Documentation/devicetree/bindings/slimbus/slimbus.example.dtb:
>>> slim@28080000 (qcom,slim-ngd-v1.5.0): #address-cells: 1 was expected
>>>         from schema $id:
>>> http://devicetree.org/schemas/slimbus/qcom,slim-ngd.yaml#
>>> Documentation/devicetree/bindings/slimbus/slimbus.example.dtb:
>>> slim@28080000 (qcom,slim-ngd-v1.5.0): 'dmas' is a required property
>>>         from schema $id:
>>> http://devicetree.org/schemas/slimbus/qcom,slim-ngd.yaml#
>>> Documentation/devicetree/bindings/slimbus/slimbus.example.dtb:
>>> slim@28080000 (qcom,slim-ngd-v1.5.0): 'dma-names' is a required
>>> property
>>>         from schema $id:
>>> http://devicetree.org/schemas/slimbus/qcom,slim-ngd.yaml#
>>
>> Still failing in linux-next.

I was running the check against the the yaml file which missed this
warnings, I should have run this against the folder instead which could
have caught this. May be this is something that could be improved in the
check by pulling in the dependency yamls too.


make -j`nproc` dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/slimbus/slimbus.yaml


--srini
> 
> Rob, sorry for delay..
> 
> will send a fix,
> 
> 
> --srini
> 
>>
>> Rob
> 


