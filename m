Return-Path: <linux-kernel+bounces-767965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 099A7B25B51
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 499F51BC4B03
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 05:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704EB2236E3;
	Thu, 14 Aug 2025 05:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XvVOo5Xg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6411DF27F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 05:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755150654; cv=none; b=cBnAE+VBpmknFowO6fmi9+rwcxFvpW86qjuovuMVERjBBKbROlxxRnMm8A6jibwvNz1KHrN/lo9iPJDWRIFbJo6gaetL/9ZY3m1Rvc1ivuHgeQxIo3cG1EcZxDHurt2hlg9MC4UN3N0zCi0zbr/6d+ssFgEWxJXEPAbJfIAuaUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755150654; c=relaxed/simple;
	bh=lomnEJ9yPVx44OUpUFVsAUpjLoAdKXlzeGHzBgBZ8co=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CllLHgDWci4g92FWmPvwDO2cVl4SPTpg4dmXMSsx1O7y9a8LqnL1vrRWepseL4jcAgElP328KQxMcdd4dzg6GvGTitz+DH/+okrbmusEYBybo09NU5FlYTKW3mFd0ImmhFM5RzlgX9yWoYXvqNKmPKFHwwnZo6j9nW7qfqrYr00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XvVOo5Xg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DMNdQG026997
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 05:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZOJ5RR3PqgCQNdZV6tHlQpMWfAVJArmZDw7MU6+DL7M=; b=XvVOo5XgoxdS+3Sf
	Bq2yXWJ0hiwSTa0MEuZoW4IjIJC86W8OrGPMHs40+cf+tOMSGGaYuKi7i2oPVGqe
	gSWw1VbakLMUewkEiRv1vIbQjopB4W4bdMf67x+MclV95o1iXuDkfsK1sau/aKQv
	VhIikW19P9Bevhi8z17Bu4IrPqlmDJJp4k9OK73+oqjS7XZt9u5HR6yfL8wFwz77
	0gV49EtbSLRjR1YvMPZeSDnV9uKscVy7QYe2Iot+qf+vee8/8A7pjLGkH4JCW5K/
	HorgUiylHUufqpREbDbZCaH+kbcZdkZg5+arxe1Kgc/kbYdf+Mo/szhMVvUp85zv
	DNaEqg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffhjt9bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 05:50:51 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24458194d82so6432605ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 22:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755150651; x=1755755451;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOJ5RR3PqgCQNdZV6tHlQpMWfAVJArmZDw7MU6+DL7M=;
        b=IdEXPbbdABy78jW7W9g/A3KZ2v56qZfVQ6e31pTnez2wIatiNBbGEiFjDzfT8rLJZZ
         dvH2IR6dJxstKgARaVf7MBZByAHPi3zH7hDH5XbtOpGgz99qQ0sjHEGm1gWPocPhWMg9
         144/FOQvT28+hgGGSkwrxgCgM2KTJqsSkvadL9wJp9P6I+kYE/XKEwVYESLmw26w0RvW
         eaZG4jMUO2zRnvYW+ZNLlmR+o+0h5/FtOtynaZCkCONdegIQf/JUNTk3E07rh1Jm699b
         gqw9kIkdY2MPnFcrCUeq3l73mio7e1Rz8dPM4mAnfm64JO/TgJiq8UAb+abqZvqPrqSb
         oYDg==
X-Forwarded-Encrypted: i=1; AJvYcCVQcLll9OipICX5JCCkAkgSze/lWlBMYCYR+7HKaW4nuZzMO/GAy/rdZiZslqe8Y3SPUfudNNgttfMUu50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+mFVvEXY+jP2JW6E6KybnCOirb9VVI2LUc3ejDm2MslmPr8Rr
	kKPVwETozhwSOSkKLBB9R6Vj9pDbXmdfXkG6WDaRSi4850GZguDZ130RCyMAtKsJRvHCAf5EyiZ
	JXsNtHzHix85KdAMIE9Ynm6KRTaGkszcQD1GXBYyMJfcSyW+sZjx0R3V4prBX8mUnFg==
X-Gm-Gg: ASbGncuR+qpEZQK2dvUPQoPlkLHYOhYMBeTlT6Wz9IC9XUe9h0MQlN6y6Ln9qyIBOke
	YORYzGyERLdzTRxTF2TNXRXMHAicbUmphE35g7hru5qWJnnyzy8WvxPMJzsjPc7O3a/lNm/a5Z+
	yJl2hC3VW1UU0r9/RC+Y4lZCAnXlUEvwpDEvel+uSKM/KiarxsvofEjwyrHGT5V5cwwuVCQnj/E
	jotmdEbHgLuFHwQgIb3bhwYzizvU2zpMhxCGLNCCK+uQlMDen3XS22C4TT4G6/uuDBnRDN84Y/m
	bLtZSRfZnisuuo/4ybIYri9X7U5Tbo/+afRmjKrXaFofM9QGENPah5Hl+0FaF8d0KZmZ60C439a
	ZTlnRX/UslX7PGbZ5E+XfBGuE2t/x1+qFr0qUBQ==
X-Received: by 2002:a17:902:e784:b0:242:9bc6:63c3 with SMTP id d9443c01a7336-244586efd7amr26911705ad.54.1755150650522;
        Wed, 13 Aug 2025 22:50:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg+3/0CB4U2pDNP5uuELEloHSNUMx8oZuD+AyTPJ8LiDQNxpnVIDTDJbE8IvvpsAU7Y3B2/w==
X-Received: by 2002:a17:902:e784:b0:242:9bc6:63c3 with SMTP id d9443c01a7336-244586efd7amr26911215ad.54.1755150650056;
        Wed, 13 Aug 2025 22:50:50 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2430558a0b7sm52896745ad.85.2025.08.13.22.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 22:50:49 -0700 (PDT)
Message-ID: <22d6cbc1-90ad-44b0-80fa-c3c67abdae8d@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 15:50:41 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/11] qcomtee: enable TEE_IOC_SHM_ALLOC ioctl
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
 <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-10-ce7a1a774803@oss.qualcomm.com>
 <3ec0a8d0-7900-45bd-b0d3-90ee8ca7730c@oss.qualcomm.com>
 <d81abdef-18fa-496d-8493-e8f336c43800@oss.qualcomm.com>
 <d74404ec-44ad-412f-98ef-eed288ecf1bf@oss.qualcomm.com>
 <87c884ed-0975-4ac2-a0fa-16e830a57c72@oss.qualcomm.com>
 <8bcb37ed-2885-4f4d-abed-5dd5ec6a254c@oss.qualcomm.com>
Content-Language: en-US
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
In-Reply-To: <8bcb37ed-2885-4f4d-abed-5dd5ec6a254c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NCBTYWx0ZWRfX6yNKOIjuXbyx
 P3lN7YaWcPi0HCthRzJAreB3ZxnwNj6f8hlsgnqmQtWUAVDiiVPAtxC+0hexRsFhl4UBsOzT/iT
 iyWM4i0u0nZY4zrD0g0hSnfFn3mP0E+be+I8LuxouL3evCnR8BQVZXFt3+cw4llN1ijQBGncXNK
 BItTp8koKcsUldPv2wtDPh+pJiVnPGhGPTLze5sQFcGzEh75BR9Elz+veCtlvnEx8wCR335eDHh
 prC+5h0y+3CR7t0rAT/++foZaLw/PXn3ZpkV2x/GwYt28oPG61T9qMDoaftSqZbB33pQGkFlO03
 2V4OsmNRJwgtPni8NFmhg8AnsCYsOzCK1XafF2HfgsmWCZhuIQRxhcLNBP5zl1nzVQPbbxHHofW
 iIiHh+Of
X-Proofpoint-GUID: ooLBOfU3H6XN23YBQUlmjhOVUXV3mw22
X-Authority-Analysis: v=2.4 cv=TJFFS0la c=1 sm=1 tr=0 ts=689d793b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=oZdMm6XVNGq0ThNLGeAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: ooLBOfU3H6XN23YBQUlmjhOVUXV3mw22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110074



On 8/14/2025 9:20 AM, Konrad Dybcio wrote:
> On 8/14/25 1:19 AM, Amirreza Zarrabi wrote:
>>
>>
>> On 8/14/2025 8:49 AM, Konrad Dybcio wrote:
>>> On 8/14/25 12:24 AM, Amirreza Zarrabi wrote:
>>>>
>>>>
>>>> On 8/13/2025 8:00 PM, Konrad Dybcio wrote:
>>>>> On 8/13/25 2:35 AM, Amirreza Zarrabi wrote:
>>>>>> Enable userspace to allocate shared memory with QTEE. Since
>>>>>> QTEE handles shared memory as object, a wrapper is implemented
>>>>>> to represent tee_shm as an object. The shared memory identifier,
>>>>>> obtained through TEE_IOC_SHM_ALLOC, is transferred to the driver using
>>>>>> TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT/OUTPUT.
>>>>>>
>>>>>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>>>> Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>>>>> Tested-by: Harshal Dev <quic_hdev@quicinc.com>
>>>>>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>>>>>> ---
>>>>>
>>>>> [...]
>>>>>
>>>>>> +/* Mapping information format as expected by QTEE. */
>>>>>> +struct qcomtee_mapping_info {
>>>>>> +	u64 paddr;
>>>>>> +	u64 len;
>>>>>> +	u32 perms;
>>>>>> +} __packed;
>>>>>
>>>>> Please use types with explicit endianness, e.g. __le32. I'm assuming
>>>>> TZ will always be little-endian, regardless of the host OS
>>>>>
>>>>
>>>> I'm not entirely sure how this point is relevant. As I understand it,
>>>> the core that populates this struct is the same one that accesses it in TZ.
>>>> Your argument would absolutely make sense if the host and TZ were operating
>>>> on different cores with distinct architectures -- such as one being
>>>> little-endian and the other big-endian, which is not the case.
>>>
>>> CONFIG_CPU_BIG_ENDIAN=y exists on arm64
>>>
>>
>> Or, you are saying we may have a configuration where host is big-endian
>> but TZ is little-endian?
> 
> I was indeed about to say that.. I believe our tz is always little-endian
> but you can run the HLOS of either endianness
> 

Okay, I’ve thought about this point and also discussed it internally.
I can add an entry to Kconfig to ensure the driver is unavailable when
CONFIG_CPU_BIG_ENDIAN is selected -- for now. However, without a clear
usecase, adding all the le32_to_cpu/cpu_to_le32 conversions just makes
the driver messy.

Regards,
Amir

> Konrad


