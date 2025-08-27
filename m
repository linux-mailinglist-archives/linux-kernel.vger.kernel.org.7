Return-Path: <linux-kernel+bounces-787522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EC1B37772
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 03:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36C151893EB6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 01:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6E11E25E3;
	Wed, 27 Aug 2025 01:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ETjfHBI8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B5D1E25F9
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756259730; cv=none; b=gHXLrCUxxPYqhgkEckHEP/DeK5LVLckprK+Dh+/VyfAkbF4VPhebJ2pIHJjNqnpu8NITJ3xcAtQ/e0CSG6t0LuLLn/qHMnnDvb2N1p8L+2qTX5VAO54H5DId55qILlaKjcqEEmn4XPizUnola1QLeDWGgLp5JxU6zC9w5IBbLqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756259730; c=relaxed/simple;
	bh=EG/uyqg10U+IFfisvso0bEBlysgxBsgMwVPEVZCea5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HCwBvwyU1JnClGN5faLP5uxw0QNLiAiYyxvLng4p8GcN0m/0xVZMR51QTIqb+ZiwHVDblgEF611f58aEg9UfKF0jmvedmB3z71pKQhYj6PFouAGyE1d61nm2HXSVZUobkXM+cz3RtFe0YTG3u4VoF/qVMN8hwkyfjb8ODTF0vDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ETjfHBI8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QG72MO018862
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:55:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wyZ5iLGjMEfr8zWA8TqBNrggJ/o46idkE8iV1Fg6GHU=; b=ETjfHBI8Qn8OTsO+
	LquT8vZTyxHCAsBfmtP94C9F/AqUCa05eBfEf3bXw2cuz5pCbYF3u/FfQ/yKzzEM
	eGRRPlEZLmwx0urzVzGaZGuWwiCPUmzhwT2lvc2fCqy0YJvQEkiALgJBw2bkbE1J
	wCB14okLSEbLNgEc7frsGu4wgEsKKcjoFJ9w0Irb8/TBZKt68mPkTuA/KghCTw+j
	OyIINNc2/gFbNiOb5/rsGBc2qQ4RhQlPgHoJP8+n1wZYv6tvlQANCeW4IfMVgEtf
	aVmPs/eplCykldzk7tjAQYPqqjPQ1jrnebTK+MTPG6gtHed/VI6AtvYYbEvOR4bi
	rac9+w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5xpu5a9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:55:28 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24896af06a9so5530175ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 18:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756259728; x=1756864528;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wyZ5iLGjMEfr8zWA8TqBNrggJ/o46idkE8iV1Fg6GHU=;
        b=we3l66vN78RN1xK0aPP1hrWgynFQofvM3u4zoJF3PDMtALyjraBmNPq8D2zXsxHM/Q
         HZ/3yoL3cIry0v6NevBS0nGPzCOkOyxS+nQjtNeCgDuxOyjg7NVnYHu9WfH8gRoSglf2
         oH4SnG12LYuO2WE1xEdK5tYfEdR8I3xo25/YgQn1iUrGtWQnfVUjfNnQQ6lxj6fL/geF
         ifrJOi4NJE9JXwJPa4HNCZRDvQfiNKP4UoGJ9WU04y41ZqBmPAvksIE2zpt4pdqK4+lD
         xZQG80Jz5ayaQuisLXlwxPJBOUrDf9x7P+8cpEYTB+bIgILuOOarVlmFH+6A4YSVN5jc
         buKw==
X-Forwarded-Encrypted: i=1; AJvYcCVFofaQkFhnrcVM64WCCodm5yw58V/5FtM78TMDmOK3trxr83/8VmLoPM1wu8vfjoOB/JeNRrl4C9vat34=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkRcNwGMo5bu7olfhCV8YYWsfF1pUtouEmFlyv/2qVA2tot9ft
	OoS72qGbi1rUIBxACmV++OPXNIpcfoy5wI537k+ibNmspVtr8bZw7Vc5ZLiQN/xp1qOrBYGFOK+
	9cu2qsavLipMzX7GB5xx+G9Zk+NTqkMdVM6XL1jMU/JlC7lM1d3QgwBqjWqnNir5GuH0=
X-Gm-Gg: ASbGncuuorQjo24doXkqP7mHI8RPqZRdN3EeI/8szbtw5nSYxu48gpU8Db4bj6YQFkr
	OZr8NO7TR/i8CH8e7scKeDYku6DwmaSzEPwUMbB+1miSi8gx/eRO506ajZ5IX/yN2hIWptLnphB
	zjZp5gZu1BKbzZ7gD0DcG/nSpwKnoVuRgztBT912GB9d3QU27SnplUg4gaS5Z+Z69txrOpt27r5
	Yh9yVXCTZv7P/vMw0wtZ//dwNpuOvpl/xDPMphRjYbAm4I29uKGew87whkByNGf+4YKSAfrSQy3
	b/lsSL2xzBva0E6U6xtT5mo60wrpc4jGaSH+IzxdbajNJ/vfLSxJylF2I3+Pgn/2Prk+8veqhpV
	C1uHjTR8TgG/PiLoCXVEpEMf2KFiaYf7CY8hqgw==
X-Received: by 2002:a17:903:2f44:b0:240:a222:2312 with SMTP id d9443c01a7336-2462eeeca94mr229747285ad.44.1756259727682;
        Tue, 26 Aug 2025 18:55:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2i5XtdpRUbO/urKMakMgXLRO2eBfmK/dMCP7CKXewUgYFm/OlcVeTpLpdrPdXjPdZowBzJw==
X-Received: by 2002:a17:903:2f44:b0:240:a222:2312 with SMTP id d9443c01a7336-2462eeeca94mr229747085ad.44.1756259727126;
        Tue, 26 Aug 2025 18:55:27 -0700 (PDT)
Received: from [10.133.33.184] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687b521bsm108143455ad.60.2025.08.26.18.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 18:55:26 -0700 (PDT)
Message-ID: <b679c1ec-be21-458e-a650-1aa14e2366a1@oss.qualcomm.com>
Date: Wed, 27 Aug 2025 09:55:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: is dma_mapping_error() check necessary for
 dma_alloc_noncoherent()?
To: Marek Szyprowski <m.szyprowski@samsung.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: iommu@lists.linux.dev,
        "linux-kernel@vger.kernel.org >> linux-kernel"
 <linux-kernel@vger.kernel.org>,
        "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
References: <CGME20250826094453eucas1p178ff4a39db0c655f3505128a5cfb0a6a@eucas1p1.samsung.com>
 <ff6c1fe6-820f-4e58-8395-df06aa91706c@oss.qualcomm.com>
 <89954593-8236-464e-8848-e7cdcf639c0a@samsung.com>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <89954593-8236-464e-8848-e7cdcf639c0a@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KOlaDEFo c=1 sm=1 tr=0 ts=68ae6590 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=v1NiFcvVahR_jOWWQrIA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: OJGP6yCd7DRsPUlKHgLwgXOQmNucdcaz
X-Proofpoint-ORIG-GUID: OJGP6yCd7DRsPUlKHgLwgXOQmNucdcaz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX4s7+FEXoamf5
 1YPD1mPEoJvPf9GhNEl73uKNMVzcS3s52XnACYlPtVKr97ErWropCoP0exEc/vps8b5+oHst5dm
 WqvZ3xFtoAWWIeZ8qt6UPOm+MQEDIJnr0eLLH3apng872/VgdX8WLTMrrgKibrcvpVtXEjoNwmZ
 6OlmYLp+o7/t+MX65A4DwVU6Lgw94c6nBrxIqfZRs24qmSNls07ElwSNJ7BfnN1XZgoCeYu1GSP
 mQidlgcDeQpipvttAkwXTqO3XZD8H3HZCyF4aFTey+hkw6uEnGqc7eH9wTA8p3jzyeVTDUEHSrT
 sXuAez+UV2mzlN4UFiCs5ABPw/uRhBV2ebytDxdl1LsISWv4wrwcCJiqrXmnhZ2YjtbvUu9AjzS
 UoSCnbp6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033



On 8/26/2025 10:09 PM, Marek Szyprowski wrote:
> On 26.08.2025 11:44, Baochen Qiang wrote:
>> Hi guys,
>>
>> I have a driver which allocate noncoherent DMA buffer and get the returned CPU addr tested:
>>
>> 	vaddr_unaligned = dma_alloc_noncoherent(ab->dev, rx_tid->unaligned_size, &paddr,
>> 						DMA_BIDIRECTIONAL, GFP_ATOMIC);
>> 	if (!vaddr_unaligned) {
>> 		spin_unlock_bh(&ab->base_lock);
>> 		return -ENOMEM;
>> 	}
>>
>> while free the buffer
>>
>> 	dma_free_noncoherent(ab->dev, rx_tid->unaligned_size,
>> 			     rx_tid->vaddr_unaligned,
>> 			     rx_tid->paddr_unaligned, DMA_BIDIRECTIONAL);
>>
>> I get below warnings:
>>
>>   DMA-API: ath11k_pci 0000:03:00.0: device driver failed to check map error[device
>> address=0x00000000f3ad7000] [size=639 bytes] [mapped as single]
>>   WARNING: CPU: 15 PID: 64303 at kernel/dma/debug.c:1036 check_unmap+0x7e2/0x950
>>   RIP: 0010:check_unmap+0x7e2/0x950
>>   Call Trace:
>>    <TASK>
>>    ? free_to_partial_list+0x9d/0x350
>>    debug_dma_unmap_page+0xac/0xc0
>>    ? debug_smp_processor_id+0x17/0x20
>>    ? rcu_is_watching+0x13/0x70
>>    dma_free_pages+0x56/0x180
>>    [...]
>>    </TASK>
>>   ---[ end trace 0000000000000000 ]---
>>   DMA-API: Mapped at:
>>    debug_dma_map_page+0x7c/0x140
>>    dma_alloc_pages+0x74/0x220
>>    [...]
>>
>> Checking code gives me the impression that I should do dma_mapping_error() check as well.
>> And indeed with below diff the warning is gone:
>>
>> +       dma_mapping_error(ab->dev, paddr);
>>
>> However this does not make sense to me since IMO testing the CPU address is good enough, I
>> can not imagine a valid case where DMA alloc/map fails while returning a valid CPU
>> address, no?
>>
>> If I was right, should we remove invocation to debug_dma_map_page() in dma_alloc_pages()?
> 
> Simply replace "if (!vaddr_unaligned)" with "if 
> dma_mapping_error(ab->dev, paddr)" and the debug code will be happy.

Thanks, much better!

But I am wondering if the debug code is worrying too much? isn't the CPU addr test already
good enough?

> 
> Best regards


