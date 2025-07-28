Return-Path: <linux-kernel+bounces-747729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5503AB13761
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75FC91896533
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8E52153ED;
	Mon, 28 Jul 2025 09:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fULjTh3Q"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEE31DD9D3
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753694307; cv=none; b=qzezMVN/gvZox0+XHXaHv1B8vmy9aLXmRnbZo5x9VG4TdmaRRi+zvs7cFthJedgfFoKi24IQMXB1BuQWF56UIPf916Ur2oBbSoZ/TGWFbNnyRG6rVZdLPj6zZuTDhV42zgQbMRX73oQ5j+TNLnaFw48QeIpBa2nBJw8DXmioqHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753694307; c=relaxed/simple;
	bh=TQy4wpeke2IpAX8Ay7c73Lotd/eKc8KcfKiU4s6AF4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uhq2Lcd4NOBRU314ntCiy4hdJrrZ5Kghoaqp0djnIj6i/yN1leonWYjtixK7a8D3NL5uHGCnfw5WQNrE4Wy5oQPsA7+moKNUWqupYUvAcLZ1J6ruceHvYmlc8P6H7ZRvTSMG1Jr6AYj8xddgAis7kVbOhu0/OfeL+rtVnU5skBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fULjTh3Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56S4rZF6023360
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:18:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7SGp8zd3BLivqufn6oxM03DzQ7qXGoIy8XhcA82Nfs0=; b=fULjTh3QvCJxpoNW
	yHJuZZsVo6qbDdaSWNHnQHucn+ww/4AUZPJfo+TFRzSBGrtz77CnCMnk4NXEC3wh
	vG1/Sx/Q96lXXVBBakRrrNgzO/4Mdq4t3g6Lg1yyXN3RWMEMf082l6PPllsq4l4Y
	e89NjV5/SCMojQIVZOJLfhRkaP80c/oPFVp4rcZq78rkFfK7TS8iJPoG4ea9SL/T
	n5C7rrzmKtVt7wBxKCJYjgpEyXb7YRNf1rRRTJQMz6fW9UEjyL3BIv4d211LzjWg
	DmQe5rTyECL5eOTLNQDf3qOIGWBwUjDiUmpS/CR5RjNSzY5x08xaYjuvk5Jiem71
	pCIvWA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 485v1x9b17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:18:25 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ab7406bfa1so10662981cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 02:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753694304; x=1754299104;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7SGp8zd3BLivqufn6oxM03DzQ7qXGoIy8XhcA82Nfs0=;
        b=pvQixpBID911moOLr+x6avo7CFEduBld8z69eB1EkoFPs/QUDM9g23eASOLMPFbuYy
         CdQOdLCRQMww6Vz3qFi3cdyI8fReGWborSBThlmMDdCyMxivjjhUDGPLUceCorE3yY6k
         b2mvpDlYMLab2Ddi66lkl+63YVeHxpDtZ1PTdWWzLkro4Fov6+WoGB8qItJ/fyfjFImK
         MPHQNXe/aUEcHvq82aefGUPHgapDXRSungjen6VTSySBxnDLz7clmnY49DzX9yRELqcO
         1+zaDtl3L/Tu614sireFe3xUDnDUjyxA33Q0x5pvlk/IjmRI52jUZTDnF5X/hoKMjpXX
         5HdQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7vtv0s/lfTU9eTcFHwLfdIOhSOLuYTTiCSK7lWBUi+foWDR+vyQ2bPFxqiPGualoPPSoQGee9wlLUmnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPXTLJV6aSOF5y7G8NYpqBlupsd82wKoM+o/uMFbDdO1qnsKou
	Zyaka1Rm/lKy2Bmd26Iha8zlJSIRvjMDI53udHMd1HftNtHeKfUi66RS3L8/EfJvBr3pm7jZJOh
	Ao58bmpy16LupEHdsT59VK2pBJNl0feIYvp/J0Dv3mA5BPRHu/tRsOG/EiBqsoXHtKyi3NOtxGg
	U=
X-Gm-Gg: ASbGnctJ3guTdyIYT0fisTxPclQBhsOaB0rFp7CmjBkJ/nrFuPGZZ/syNfVrT04FTpC
	jVpNXvgpy5W0u8TsyUDpkPg3TyYrVyrsA5d0z9iQIv/cp5YlAG9OgtTj8MULZs1kNFb3oE8UJbX
	QIYTIWW2ZyjA/35OFnCwrTnBOSpkuok2UIRo6tog81SGrDJyFlijg4uzmi4mY2yfO2xgaCu4DZF
	UBYwVD2v288vEXvCDulkAW81mMekblH+RQ6Fxo8k777VmSq/YcIvbbZpZjYbsXC1n5eQkJP5dkM
	Uyhrr1sfbbXYrHPUifu8oVp9xbxnMfD9HMYTn2PSTavmbuZRVXNbGpFINdNUzehskL7dA1XAhnB
	wzsWWm1AK3adHF3G/Ug==
X-Received: by 2002:a05:622a:155:b0:4ab:592f:3ae8 with SMTP id d75a77b69052e-4ae8f0bf7d1mr70574911cf.14.1753694303798;
        Mon, 28 Jul 2025 02:18:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG99s9jbeEPXz6eIs8dgyiMqI98NLRjj666o9an4AuVAJtsvSCWH09AjQ1FNN+sQ7fK1Gh0xg==
X-Received: by 2002:a05:622a:155:b0:4ab:592f:3ae8 with SMTP id d75a77b69052e-4ae8f0bf7d1mr70574711cf.14.1753694303234;
        Mon, 28 Jul 2025 02:18:23 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61500a5728bsm2856429a12.23.2025.07.28.02.18.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 02:18:22 -0700 (PDT)
Message-ID: <0d99a9e8-5ad6-4826-9fb7-753724dc53ad@oss.qualcomm.com>
Date: Mon, 28 Jul 2025 11:18:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] leds: flash: leds-qcom-flash: update torch current
 clamp setting
To: Fenglin Wu <fenglin.wu@oss.qualcomm.com>, kernel@oss.qualcomm.com,
        Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
        Fenglin Wu <quic_fenglinw@quicinc.com>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250725-fix-torch-clamp-issue-v1-0-4cf3ebaa4c67@oss.qualcomm.com>
 <20250725-fix-torch-clamp-issue-v1-1-4cf3ebaa4c67@oss.qualcomm.com>
 <fb79df7b-1c7b-4085-9f12-35b7cd56bb87@oss.qualcomm.com>
 <f4f46e92-3d49-4bcf-a23e-223c758f56e9@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <f4f46e92-3d49-4bcf-a23e-223c758f56e9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA2OCBTYWx0ZWRfX1sInNDL5XBvo
 GmJyrF8gCzs0CxkL9MgVmZ9t/UIzZZYHee7w/u/DcRgMNtNVo+TJe0vO62iVUEzTk6A4F0fjm7i
 kLuMT49cC5v1RHu0tN/yWvFdg/rqIo2yg2nYT1VplofBPVbBR95Uuk8RK8H0hqfand6aZnSv+4G
 lebNl9UAbFYcxxvFPIN6w9nskaDkKorUEjytVT7NvNMtQc3AFiDzQyLj1gGbAkkLo6c+39njmEI
 5SD6DIa3jHT+IyIxWWXRZnr3+UwUgEFfbgD9luPQhzkD3HUe+d2g3p8tWxDY9R0qRnOo+tHdElh
 rFlzlgZMo3Fz0WAm/jU7ok9ugh8j+zxQGa1i7npqhl/3NbYudr/ht1FuFNt4sGVGeN0XURnCL7n
 Hq5HDTMopk9HdnNvHSVMwtUZ5DCEiXRyFr8vfnKmAkL9YWmy68DebzuezL3PTw19KeX9es7y
X-Authority-Analysis: v=2.4 cv=JKw7s9Kb c=1 sm=1 tr=0 ts=68874061 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=7tzVVK5p8Zpjar64nkwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: rT9p4f2aliWBVRq4oZmMJZEjw9IJ1QyG
X-Proofpoint-GUID: rT9p4f2aliWBVRq4oZmMJZEjw9IJ1QyG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280068

On 7/28/25 4:27 AM, Fenglin Wu wrote:
> 
> On 7/25/2025 8:37 PM, Konrad Dybcio wrote:
>> On 7/25/25 12:04 PM, 'Fenglin Wu via B4 Relay' via kernel wrote:
>>> From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
>>>
>>> There is a register to clamp the flash current per LED channel when
>>> safety timer is disabled. It needs to be updated according to the
>>> maximum torch LED current setting to ensure the torch current won't
>>> be clamped unexpectedly.
>>>
>>> Fixes: 96a2e242a5dc ("leds: flash: Add driver to support flash LED module in QCOM PMICs")
>>> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
>>> ---
>>>   drivers/leds/flash/leds-qcom-flash.c | 16 +++++++++++++---
>>>   1 file changed, 13 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/leds/flash/leds-qcom-flash.c b/drivers/leds/flash/leds-qcom-flash.c
>>> index 89cf5120f5d55bbb7e24faa8c3a946416f8fed46..9c2e41cfddcf2d50d5a633cb157084371a631d74 100644
>>> --- a/drivers/leds/flash/leds-qcom-flash.c
>>> +++ b/drivers/leds/flash/leds-qcom-flash.c
>>> @@ -1,6 +1,6 @@
>>>   // SPDX-License-Identifier: GPL-2.0-only
>>>   /*
>>> - * Copyright (c) 2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
>>> + * Copyright (c) 2022, 2024-2025 Qualcomm Innovation Center, Inc. All rights reserved.
>>>    */
>>>     #include <linux/bitfield.h>
>>> @@ -111,6 +111,7 @@ enum {
>>>       REG_IRESOLUTION,
>>>       REG_CHAN_STROBE,
>>>       REG_CHAN_EN,
>>> +    REG_TORCH_CLAMP,
>> This is not the name of this register on at least PM8150L
> The register is referred to as 'TIMER_DISA_MITIGATION_CLAMP' in the documentation. 'TIMER_DISA' indicates the flash module operating in torch mode. We can remove 'MITIGATION' to create a shorter name for the enum.>>
>>>       REG_THERM_THRSH1,
>>>       REG_THERM_THRSH2,
>>>       REG_THERM_THRSH3,
>>> @@ -127,6 +128,7 @@ static const struct reg_field mvflash_3ch_regs[REG_MAX_COUNT] = {
>>>       REG_FIELD(0x47, 0, 5),                  /* iresolution    */
>>>       REG_FIELD_ID(0x49, 0, 2, 3, 1),         /* chan_strobe    */
>>>       REG_FIELD(0x4c, 0, 2),                  /* chan_en    */
>>> +    REG_FIELD(0xec, 0, 6),            /* torch_clamp    */
>> Please keep it sorted by address
> I need to keep the 'therm_thrsh1/2/3' register fields at the end of this array because 'mvflash_4ch_regs' doesn't include a 'therm_thrsh3' register. Placing the 'therm_thrshx' registers in the middle would require creating a placeholder, which I couldn't figure out how to do effectively. Do you have any suggestions?

Designated initializers (i.e. [REG_CHAN_EN] = REG_FIELD(...),)

Konrad

