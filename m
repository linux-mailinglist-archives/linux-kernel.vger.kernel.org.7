Return-Path: <linux-kernel+bounces-800678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 691DEB43A64
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23C5F563007
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDC52F1FF4;
	Thu,  4 Sep 2025 11:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RAXXm/pt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A1F1F542E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 11:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756986049; cv=none; b=t44fyarD3q5d0P+FZNCqqQ02TsYuSSdIdYXjpDhGj6s12mHDP1YQTnPVOE5nmb4GHrFgAmbYbiwo5TB+ctnLwxY8TCqfUPzunuDJRrDaRT4rxV6Zj/lMUFQuVYkwSYxB3OeIkUkZK3QXljg4Z+oUOpdmcfsY9a6cxUlMD4uY7YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756986049; c=relaxed/simple;
	bh=y4uU4DStFdyRet9AcYiazndrVi6RmdR0kimclhECy6o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CeQMNqaGeAKuUjoSJhxMgvqcJNQDop8VCE8qyKf57geeVXU9AVqf13O1u6Yz0nqpIOeGS7DEjsnlt+XO0cWdP3Gp4fOt6Po957H6hLzk6nZg3In2crc3WVKp9cA5eMEXhZa1GvPuTCJcJybXXdrDpVTWsOdgQjt2lC0ykNU4D2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RAXXm/pt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849X7Ng031741
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 11:40:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1z7m0o38hbU9AqKGZ4FuuaCFFD5bgtOtsvABF1Bvah8=; b=RAXXm/ptWnxJyvcX
	v1eBBSbyN/JTB0EL5QKFWzGqGItY7pmBvsDlLg+iuYeTUuUOvttWODcbwJAH7VV8
	vICORRep524tmcvJ38tE07nTLbhTEG+y45DG1b2YKPFIivx2qp8uhGG3MwBycPDK
	BoUJZV1EelCu8Hkf9L2XXyBqzdAtgwv6ax5hQpFrNiv8Ps3hUehg1PYSniO+6UtC
	Rmyt2Qjlh2RcrOApnmeMBXYkHVcMq8MH733QDU8TAdYs+B6z+NJGiT2U6JM7m6ig
	EFszQO1+lKdlqwlfdT1MgU7/0we9d98qxfLhQ4PztgdqEjfPoa09muQa07GvpQVD
	zbgDEA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urw07bxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 11:40:46 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3234811cab3so1085843a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 04:40:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756986045; x=1757590845;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1z7m0o38hbU9AqKGZ4FuuaCFFD5bgtOtsvABF1Bvah8=;
        b=fCKfjN3g06B/kwPg5zGjTf8QMJA2EobBuFQUuDAz4Ed08914mxN3gpqVrE8Pd5FOEA
         uIbdOmlZCKnqL8YsjPSKk45fvOEA7+x4mYUWqDP0/+W+dXR+ZBBd0Ni4OSj3XC52gCxC
         EErGZoO5s6jc/S7IGAa1tPVCWSpSpePLqz2CdElpmoqiqzGMoCOoEBFqH061dGAvmI0h
         Drz0XM/Mt1QQld2dLrfHpsqN0uhBL30TpxyKLBzNEaAQU4dgVt08s2yIO0L/WF7KgdnD
         EdLuMR2zxJc8QBMjpxAPUW5Yav42qK4nJMglC4jT1sVVj6dvF0xqYArTLt9hR6mPFwuq
         Y58A==
X-Forwarded-Encrypted: i=1; AJvYcCUg8dZTH53i9JIXhOURngz/LcrI/mc1r+Fli2A9OLQBhvMO7u8ozKaHJvaUyqqD+GuMlWe/pJxbEgGdK/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YztBMFlb2vzEvrvbBVb3JEI6MzPgud96/TUZX74DScvGfj1p435
	ZyrHZqD8DdCPI4U7w8Ml0HHQr6tXUezL4iHwFa5Ggoxj1LTgq5c7ORS5CfF/+3uzGYKV7Vkqluo
	gL3ZBcqsohnFZpHdnjWy0uZO5JMUUw+XnbB7o0O9L3GHFgC/sHhFyr2ymJeVHek/uYnY=
X-Gm-Gg: ASbGncuvA2lj3pD9F7uVTiWUCpxVvZ1DY83hHH4RScuQTZ1vYhRe5dHTzSwDDi/hDsU
	+uqt4YeWcmTMmBGKeHMLrzppVWFrrDwG53X1Y9h65l7hqn7d/XP3DPHep+JTXmja9eQP1Ygs4Z8
	Qdn+YQyHRNpPdBmOKSx5uttQ9IqpDY9QVTrAyHoyK6NRG9etxQT9DKiFOPnWjTMQnTxEgTlLD05
	zdVr1adNWLvZJendRrmUO2ON3bdnGujMkZrlWZyDPe/HYXBBanpJLCD7WsPzCz/Q2IyjZqvsTpA
	t4ugK4BepHDBI151Y/6zNfd3nl5nzvil3wBpVEPSLIp8pMLeqMCBcTI7RhOcKNFjxH3F3H0LUw6
	u9L4xYS4=
X-Received: by 2002:a17:90b:39cd:b0:32b:b26e:1576 with SMTP id 98e67ed59e1d1-32bb26e2980mr285564a91.37.1756986045394;
        Thu, 04 Sep 2025 04:40:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMFNOMLLYtgWEqcqOq6EVf91r655xof1zYJbYaf62p1HLzxciYIZxP4GW3srcr5KRaLqcL0Q==
X-Received: by 2002:a17:90b:39cd:b0:32b:b26e:1576 with SMTP id 98e67ed59e1d1-32bb26e2980mr285519a91.37.1756986044844;
        Thu, 04 Sep 2025 04:40:44 -0700 (PDT)
Received: from [192.168.215.112] ([152.57.118.202])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4fa7484ec5sm4065312a12.49.2025.09.04.04.40.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 04:40:44 -0700 (PDT)
Message-ID: <7276d39b-a514-4265-a125-7e08f364f979@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 17:10:33 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] watchdog: Add driver for Gunyah Watchdog
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck
 <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250903-gunyah_watchdog-v1-0-3ae690530e4b@oss.qualcomm.com>
 <20250903-gunyah_watchdog-v1-2-3ae690530e4b@oss.qualcomm.com>
 <mfvuoslj27mbayypzr3wuagrq3p5wzelklgveedhwrxiaavwxy@7ipv2tup6oou>
Content-Language: en-US
In-Reply-To: <mfvuoslj27mbayypzr3wuagrq3p5wzelklgveedhwrxiaavwxy@7ipv2tup6oou>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: OqpuYrqy87IzO6s4DevPfEpK2cgQYdsU
X-Proofpoint-ORIG-GUID: OqpuYrqy87IzO6s4DevPfEpK2cgQYdsU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfXzRC7FZhqvX7G
 Z149eSA/XWyCdAFKqyjGx+nU6nGmu6XLSdmlnnYHQXbvjh/S4w3XQAvJo9kcanhKc9pvdSthLj2
 7fAK6FIKBKuGTt3Vlclum8QmT1QtreYxE56hZsKvlvaapA6U5rK+YytAhAJImjn3E98IEfDdj5D
 3z/l3Y0Dm7G675Cj8zWJwCAQOx0tAEex5zptIse7L92DTmDTAO9lWJzfvEnrBpBG6W7h0VEk4QK
 9kdOE1X5CGc4BQiIBBsxvvp1f9GGUkG3GFLHpFYBY9TuUl23K8cZElMbm5NPH7SqK4iEddVxAL6
 y57hQoG/5nZ8O1AHatnEkIUGxa9R4sNnCLP8a4Gkc3jUEBYtTsGPLWdMzzfw5HAMtJpPeEdzQCT
 4w9zevg5
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b97abe cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=EtPCCmwehmAcwtUnapKH4g==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=Y2IgW4ZSIErcYl4phlAA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027


On 9/4/2025 1:43 AM, Bjorn Andersson wrote:
> On Wed, Sep 03, 2025 at 07:34:00PM +0000, Hrishabh Rajput via B4 Relay wrote:
>> From: Hrishabh Rajput<hrishabh.rajput@oss.qualcomm.com>
>>
>> Add driver to support the SMC-based watchdog timer provided by the
>> Gunyah Hypervisor.
>>
> Start the commit message with a problem description, end with a
> technical description of the solution. I.e. move this paragraph down.


Thanks, that would make more sense. Will rearrange this.

>> On Qualcomm SoCs running under the Gunyah hypervisor, access to watchdog
>> through MMIO is not available. Depending on the hypervisor
>> configuration, the watchdog is either fully emulated or exposed via
>> ARM's SMC Calling Conventions (SMCCC) through the Vendor Specific
>> Hypervisor Service Calls space.
>>
>> When the SMC-based interface is enabled, a device tree overlay is used
>> to provide the pretimeout interrupt configuration.
>>
>> Signed-off-by: Hrishabh Rajput<hrishabh.rajput@oss.qualcomm.com>
> [..]
>> diff --git a/drivers/watchdog/gunyah_wdt.c b/drivers/watchdog/gunyah_wdt.c
> [..]
>> +#define GUNYAH_WDT_SMCCC_CALL_VAL(func_id) \
>> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32,\
>> +			   ARM_SMCCC_OWNER_VENDOR_HYP, func_id)
>> +
>> +/* SMCCC function IDs for watchdog operations */
>> +#define GUNYAH_WDT_CONTROL   GUNYAH_WDT_SMCCC_CALL_VAL(0x0005)
>> +#define GUNYAH_WDT_STATUS    GUNYAH_WDT_SMCCC_CALL_VAL(0x0006)
>> +#define GUNYAH_WDT_PING       GUNYAH_WDT_SMCCC_CALL_VAL(0x0007)
> Uneven indentation.


This crept in somehow. Will fix it. Thanks.

>> +#define GUNYAH_WDT_SET_TIME  GUNYAH_WDT_SMCCC_CALL_VAL(0x0008)
>> +
>> +/*
>> + * Control values for GUNYAH_WDT_CONTROL.
>> + * Bit 0 is used to enable or disable the watchdog. If this bit is set,
>> + * then the watchdog is enabled and vice versa.
>> + * Bit 1 should always be set to 1 as this bit is reserved in Gunyah and
>> + * it's expected to be 1.
>> + */
>> +#define WDT_CTRL_ENABLE  (BIT(1) | BIT(0))
>> +#define WDT_CTRL_DISABLE BIT(1)
>> +
>> +struct gunyah_wdt {
>> +	unsigned int pretimeout_irq;
> This is only used momentarily in gunyah_wdt_probe(), make it a local
> variable.
>> +	struct watchdog_device wdd;
> Which means that gunyah_wdt is just watchdog_device, so you can drop
> gunyah_wdt completely, and put wdd directly in drvdata.


That would definitely be a better way to do it. Thanks.

>> +};
>> +
> [..]
>> +static int __init gunyah_wdt_init(void)
>> +{
>> +	return platform_driver_register(&gunyah_wdt_driver);
>> +}
>> +
>> +module_init(gunyah_wdt_init);
> module_platform_driver(gunyah_wdt_driver);


This is intentional. I intend to keep this module persistent. No 
module_exit(gunyah_wdt_exit).

>> +
>> +MODULE_DESCRIPTION("Gunyah Watchdog Driver");
>> +MODULE_LICENSE("GPL");
>> diff --git a/include/linux/gunyah_errno.h b/include/linux/gunyah_errno.h
>> new file mode 100644
>> index 000000000000..518228e333bd
>> --- /dev/null
>> +++ b/include/linux/gunyah_errno.h
>> @@ -0,0 +1,77 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
> Isn't this content solely used from within gunyah_wdt.c? Why is it a
> separate header file? Just move it into the c-file.
> Regards,
> Bjorn


This header file is partially taken from [1] and I have only renamed it 
to gh_errno.h.

The error codes are not specific to watchdog and we have other drivers 
in the patch series [2] (which [1] is a part of) that would be using this.

[1] 
https://lore.kernel.org/all/20240222-gunyah-v17-3-1e9da6763d38@quicinc.com/

[2] 
https://lore.kernel.org/all/20240222-gunyah-v17-0-1e9da6763d38@quicinc.com/

Thanks,

Hrishabh

>> +
>> +#ifndef _LINUX_GUNYAH_ERRNO_H
>> +#define _LINUX_GUNYAH_ERRNO_H
>> +
>> +#include <linux/errno.h>
>> +
>> +enum gunyah_error {
>> +	GUNYAH_ERROR_OK				= 0,
>> +	GUNYAH_ERROR_UNIMPLEMENTED		= -1,
>> +	GUNYAH_ERROR_RETRY			= -2,
>> +
>> +	GUNYAH_ERROR_ARG_INVAL			= 1,
>> +	GUNYAH_ERROR_ARG_SIZE			= 2,
>> +	GUNYAH_ERROR_ARG_ALIGN			= 3,
>> +
>> +	GUNYAH_ERROR_NOMEM			= 10,
>> +
>> +	GUNYAH_ERROR_ADDR_OVFL			= 20,
>> +	GUNYAH_ERROR_ADDR_UNFL			= 21,
>> +	GUNYAH_ERROR_ADDR_INVAL			= 22,
>> +
>> +	GUNYAH_ERROR_DENIED			= 30,
>> +	GUNYAH_ERROR_BUSY			= 31,
>> +	GUNYAH_ERROR_IDLE			= 32,
>> +
>> +	GUNYAH_ERROR_IRQ_BOUND			= 40,
>> +	GUNYAH_ERROR_IRQ_UNBOUND		= 41,
>> +
>> +	GUNYAH_ERROR_CSPACE_CAP_NULL		= 50,
>> +	GUNYAH_ERROR_CSPACE_CAP_REVOKED		= 51,
>> +	GUNYAH_ERROR_CSPACE_WRONG_OBJ_TYPE	= 52,
>> +	GUNYAH_ERROR_CSPACE_INSUF_RIGHTS	= 53,
>> +	GUNYAH_ERROR_CSPACE_FULL		= 54,
>> +
>> +	GUNYAH_ERROR_MSGQUEUE_EMPTY		= 60,
>> +	GUNYAH_ERROR_MSGQUEUE_FULL		= 61,
>> +};
>> +
>> +/**
>> + * gunyah_error_remap() - Remap Gunyah hypervisor errors into a Linux error code
>> + * @gunyah_error: Gunyah hypercall return value
>> + */
>> +static inline int gunyah_error_remap(enum gunyah_error gunyah_error)
>> +{
>> +	switch (gunyah_error) {
>> +	case GUNYAH_ERROR_OK:
>> +		return 0;
>> +	case GUNYAH_ERROR_NOMEM:
>> +		return -ENOMEM;
>> +	case GUNYAH_ERROR_DENIED:
>> +	case GUNYAH_ERROR_CSPACE_CAP_NULL:
>> +	case GUNYAH_ERROR_CSPACE_CAP_REVOKED:
>> +	case GUNYAH_ERROR_CSPACE_WRONG_OBJ_TYPE:
>> +	case GUNYAH_ERROR_CSPACE_INSUF_RIGHTS:
>> +	case GUNYAH_ERROR_CSPACE_FULL:
>> +		return -EACCES;
>> +	case GUNYAH_ERROR_BUSY:
>> +	case GUNYAH_ERROR_IDLE:
>> +		return -EBUSY;
>> +	case GUNYAH_ERROR_IRQ_BOUND:
>> +	case GUNYAH_ERROR_IRQ_UNBOUND:
>> +	case GUNYAH_ERROR_MSGQUEUE_FULL:
>> +	case GUNYAH_ERROR_MSGQUEUE_EMPTY:
>> +		return -EIO;
>> +	case GUNYAH_ERROR_UNIMPLEMENTED:
>> +	case GUNYAH_ERROR_RETRY:
>> +		return -EOPNOTSUPP;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +#endif
>>
>> -- 
>> 2.43.0
>>
>>

