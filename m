Return-Path: <linux-kernel+bounces-722488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EBBAFDB3C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CDB33A59C0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F8425C80F;
	Tue,  8 Jul 2025 22:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dnqsVAvx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B69C195FE8
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 22:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752014378; cv=none; b=ewEXvA4lkTsqN479ISP/cD9oYpvH7bSeBstrVlAhQnPCLTzU9pW8RIQQD0L8W4BQ/gzMpMicq4x7w6Ym77UZbH5DbutcZpmCw/Z84fCzYC3JH72UKcCO0lZoxxI94INRCbvaY8JEjZBGqGjf8vS6pNcfGqKHLLRr5YVhT9nOX5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752014378; c=relaxed/simple;
	bh=F/fF3Rhxr5b1fiF0//GSOd76xUZw3GpIk4+dqXfKpiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ojg22fGiv78GMnPCE4ZLqjHtZP/7k0gbqFeFeuzN0aGFNZ52OqeWN9gSCe9ej2GZYbGnBVd1f107miw7Fs8hw4QjVmRRdjC0OCne+ZL+9egKdMOH0FAO24MntghotyTCfCKjGatVEexrvGMpVGDJs8NU8R5ajwuhQJhd7QR1+k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dnqsVAvx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568JpxaU031796
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 22:39:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7UtZUgVsdHbUgf+84soaO60Bc1Eoqdwl1tY6FaWRI/4=; b=dnqsVAvxsxfPNtV1
	90mlJtfHkz2WSDEH99XyoBC9SqqhH5DJP//4PFwKm9JAIXpl6CCP3ojFwZBsOYQz
	MWA3QkVFOkHNA9OcSN5s1GqSsdQEEYVskhD1Y1EJocx+7GLwo4GXuQwumtd70Rt9
	x+Rckx3Vcr77JgsFThIyG78ZT7vWg7wkB4D7nh2hL9Z52AZRabwUH0z9gd2dIPS6
	R3EDG7fD845L5tXMkEVKAN2fvcpyltd2FDmckYR9szdqG6urw9VfQtLSrVlJppFl
	aedLiPbPZLphg4C5xZUTNs5o6iCWJgMPiDXg0uv+76taWBcpi7V3q5XacXCMjhZK
	YQIl9Q==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pw7qsj5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 22:39:36 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7489ac848f3so7254762b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 15:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752014375; x=1752619175;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7UtZUgVsdHbUgf+84soaO60Bc1Eoqdwl1tY6FaWRI/4=;
        b=dOfk+fh66oRUJkDr1g695dkw5sMicyo3OPXrS/9Y0leRBaypKyH1lZxFg5nTFOcUAX
         Kz2CdtoekV9ble7dAsLVT00aIni6X2tj0WF7Xd103mpv7tJLStr6J7/JmGl5T8rffYUK
         MuPMIhSD9KGwbKoyn0bsxlPoDYDhkkX8Xj9ojIFvmuWdkGRH+Yxm4tQyQL/KEDOxL8rq
         bbkRzIBrGmCN3tonimAUZLo2jUzcmz8+4Z3DM4gUVo85gga2Pd+06wMS95/oSDr4QzRg
         iBQh/btvFxGc327S8u87jRTm6A/hUk5+upvNHgaC5kRLGtQo24GQmek6YVJ0/R1iTTDG
         KIVg==
X-Forwarded-Encrypted: i=1; AJvYcCU3EfreJWt2vB9a5WaYsNR9C6lI69lTOahIBLIFDU3YCwbG5BPcTez9r9umUJlNEcSM0ISR2661hBIJ13g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI9DLDtu9TjQwR8egqMFdQxWtgZ4Pr5tw8GisDDZ+9LxTbHfH8
	gTuV5twqoTNa0AMm8TYUmnR92o6IBclkZsWUG/oT1YchHlUx+qTfb7Psu0cfk5WgEN/Lg52SZgo
	somk545ePRghT4VJkfm45ugYvFWkkV2rPuPndtVnJCDsUJ99Z0lqSIk6jHDKKpqPp9os=
X-Gm-Gg: ASbGnctGiOMLVCTmBkJ8ukiWBskJw87ccW6wwDvR2t+RIZUcTToYXnCGet8alo4KP3Y
	41jkJRIJ9Ogw/YxjhuU+0kRiQFaQB56b61TMDzfAxRtMh2CzKHwqpR2D19/0SsD+Rryyo6SLgvx
	hvk6SgMQn4eNz2+rIkQdsRjnNRVUev4579WhKH5gVRJKlXJxSpBV4RXsod56/dC3Ps2XZS+gsYT
	P41q1Vh22VwJ5iVs157aU0ayiqJu28ulrC1mdFEWF7/E0SHDg24dHTSlJDVXdyiIn3ooDjSXm06
	ogHm9Yauhc88nAGyqDf19EPZPNQAXqlKm9mJ/3TDRTaZlsK+QOpP49+33NfaN/trAeDDPmxuXOj
	0T083E0WH
X-Received: by 2002:a05:6a00:2d9f:b0:740:9d7c:8f5c with SMTP id d2e1a72fcca58-74ea668cc20mr441743b3a.18.1752014375209;
        Tue, 08 Jul 2025 15:39:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBiN3xyeq7O/uV1TnSFOOrnKUZ/OhLBMhI3YNs4YPGljXRssP01Y/5JMu4DrrIP6a34HkNsQ==
X-Received: by 2002:a05:6a00:2d9f:b0:740:9d7c:8f5c with SMTP id d2e1a72fcca58-74ea668cc20mr441702b3a.18.1752014374744;
        Tue, 08 Jul 2025 15:39:34 -0700 (PDT)
Received: from [10.71.111.173] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce429f6c2sm12565653b3a.134.2025.07.08.15.39.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 15:39:34 -0700 (PDT)
Message-ID: <a6af609d-b9e1-4b63-85ab-41ab08968579@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 15:39:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] of: reserved_mem: Restructure call site for
 dma_contiguous_early_fixup()
To: Robin Murphy <robin.murphy@arm.com>, robh@kernel.org,
        m.szyprowski@samsung.com
Cc: saravanak@google.com, quic_obabatun@quicinc.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, william.zhang@broadcom.com,
        kernel@oss.qualcomm.com, will@kernel.org, djakov@kernel.org
References: <20250708165627.845295-1-oreoluwa.babatunde@oss.qualcomm.com>
 <ceedcc51-7a4e-4da0-bdcd-429e7c212d19@arm.com>
Content-Language: en-US
From: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
In-Reply-To: <ceedcc51-7a4e-4da0-bdcd-429e7c212d19@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE5MiBTYWx0ZWRfX9SJbCAWgVgRV
 w+bP6UUy3EponQUi3ATwRoc2Fc/4iU1vu06KceZbYauDMK+khUFLUnLdbvW0nKZ8JsRpo7ZG8dd
 pitaRsDLqL3JoKyl5KPxNL9YGRtpwVsj7oyDSy293w5MXZ1YwxtT2yGHlm0VDJbYCehwRQ+kVpk
 71h+lNwrhDKBkWlAUJxLpckVsnHb03W5aa+uNKogD2xTCVyFKKdeyYdmY4JS9r4JAej7inMwhkT
 IV6QO2pyiLp9+i2iLQ+usFN5JdgQbwbvMJrZC1jeNUcvM+DpWvIt3s+jcMUqTHBHneS/kJrdTUd
 xHMioDexu0sEp9wIJjwvHbeoYBvg/W6D73r1EBgzS4yAx134EkB1pIk3so3GCbCdDOZlW5Cj9ZN
 MeCoekTeh86tt1UV4lRCETYxOE+TgdOuCpdTMChOi8nTv1MsmOvl6gP0qT+hd2rYehG9gFmy
X-Proofpoint-GUID: JldXOzPYi0OCgiH_UPbbOdHMNqOiPVhD
X-Proofpoint-ORIG-GUID: JldXOzPYi0OCgiH_UPbbOdHMNqOiPVhD
X-Authority-Analysis: v=2.4 cv=SOBCVPvH c=1 sm=1 tr=0 ts=686d9e28 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=fQRGRuMEmedUXPIvGoAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_06,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=934 mlxscore=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507080192



On 7/8/2025 10:17 AM, Robin Murphy wrote:
> On 08/07/2025 5:56 pm, Oreoluwa Babatunde wrote:
>> Restructure the call site for dma_contiguous_early_fixup() to
>> where the reserved_mem nodes are being parsed from the DT so that
>> dma_mmu_remap[] is populated before dma_contiguous_remap() is called.
>>
>> Fixes: 8a6e02d0c00e ("of: reserved_mem: Restructure how the reserved memory regions are processed")
>> Signed-off-by: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
>> ---
>>   drivers/of/of_reserved_mem.c | 14 +++++++++++---
>>   kernel/dma/contiguous.c      |  2 --
>>   2 files changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
>> index 77016c0cc296..132d2c66cafc 100644
>> --- a/drivers/of/of_reserved_mem.c
>> +++ b/drivers/of/of_reserved_mem.c
>> @@ -25,6 +25,7 @@
>>   #include <linux/memblock.h>
>>   #include <linux/kmemleak.h>
>>   #include <linux/cma.h>
>> +#include <linux/dma-map-ops.h>
>>     #include "of_private.h"
>>   @@ -175,13 +176,17 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
>>           base = dt_mem_next_cell(dt_root_addr_cells, &prop);
>>           size = dt_mem_next_cell(dt_root_size_cells, &prop);
>>   -        if (size &&
>> -            early_init_dt_reserve_memory(base, size, nomap) == 0)
>> +        if (size && early_init_dt_reserve_memory(base, size, nomap) == 0) {
>> +            /* Architecture specific contiguous memory fixup. */
>> +            if (of_flat_dt_is_compatible(node, "shared-dma-pool"))
> 
> Surely this is now going to call the fixup for *all* "shared-dma-pool" reservations, rather than just the ones which are specifically CMA regions? That seems potentially bad in a number of ways.
> 
> Thanks,
> Robin.

Hi Robin,

Thanks for pointing that out. I believe if we add a check for
of_get_flat_dt_prop(node, "reusable", NULL) that should help
limit this to only the regions that are meant to be cma.

Please let me know if there's something else that I'm missing.

Thanks,
Oreoluwa

> 
>> +                dma_contiguous_early_fixup(base, size);
>> +
>>               pr_debug("Reserved memory: reserved region for node '%s': base %pa, size %lu MiB\n",
>>                   uname, &base, (unsigned long)(size / SZ_1M));
>> -        else
>> +        } else {
>>               pr_err("Reserved memory: failed to reserve memory for node '%s': base %pa, size %lu MiB\n",
>>                      uname, &base, (unsigned long)(size / SZ_1M));
>> +        }
>>             len -= t_len;
>>       }
>> @@ -472,6 +477,9 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
>>                  uname, (unsigned long)(size / SZ_1M));
>>           return -ENOMEM;
>>       }
>> +    /* Architecture specific contiguous memory fixup. */
>> +    if (of_flat_dt_is_compatible(node, "shared-dma-pool"))
>> +        dma_contiguous_early_fixup(base, size);
>>         /* Save region in the reserved_mem array */
>>       fdt_reserved_mem_save_node(node, uname, base, size);
>> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
>> index 8df0dfaaca18..9e5d63efe7c5 100644
>> --- a/kernel/dma/contiguous.c
>> +++ b/kernel/dma/contiguous.c
>> @@ -480,8 +480,6 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
>>           pr_err("Reserved memory: unable to setup CMA region\n");
>>           return err;
>>       }
>> -    /* Architecture specific contiguous memory fixup. */
>> -    dma_contiguous_early_fixup(rmem->base, rmem->size);
>>         if (default_cma)
>>           dma_contiguous_default_area = cma;


