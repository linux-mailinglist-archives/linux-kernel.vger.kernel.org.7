Return-Path: <linux-kernel+bounces-778749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CBEB2EA27
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 03:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B93CB1BC6B16
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7911EDA26;
	Thu, 21 Aug 2025 01:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="thwDuOnS"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1841A9F9F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738596; cv=none; b=HyQOhCjs5Dcan615nM8n0mMD+JeF9E+VeRctoc8rVJF4mL51WdXdZpl/OrsGxi2MI5BaTxZHvhPYL2PHTqeEPRTbWgwEIdErhSOHG4r0pd8KG2zljml0qv3NsuNoNwob0P4bLp1TwNP61dQKNC3nRM8cXp3AW7FmNO6mN1unnzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738596; c=relaxed/simple;
	bh=NS3L7tpukwWlKOZXJFuJ1Ne5Bf/gTtM2S1i5c+3ugJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dayksMnaIi0caje8PJ7w7Hm9MFL9HrUvf+/ETkzZFs6lrcaOp2PCEj5BA4tDt1rfHuL419P8ggye1r4o1LdarulIN65g46JMGd6r/JGSxRk8VTB605GIGZuFl4ILauGIdhOlpyiXmFeGcu9CDXmH9Ark6EBdTdE7ZYK2FQ+vukE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=thwDuOnS; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755738589; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Ugai3oMT+pd1xA9AQN1G7wC+lJHlwcdm3P9RGa1xruM=;
	b=thwDuOnS/Qh7NfWIek1UpSVs0dgP+jXEIcwh0DfQ0/DxcIfU/IBgMkqF6P/+ScbToEgvi2dAFbJuoumWx4AFhWt9/yRZF6NzlV1GuyNkXo7Gjmi998IkSB5StXBqFVu0zBcpKmDKhe0RaWTGlnw58uZqgbY08spcWd7z/PsYqz0=
Received: from 30.74.144.114(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WmDtqcc_1755738588 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 21 Aug 2025 09:09:48 +0800
Message-ID: <d735a408-1bf8-4c43-94fc-6e3fa1068bab@linux.alibaba.com>
Date: Thu, 21 Aug 2025 09:09:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/11] mm: khugepaged: add khugepaged_max_ptes_none
 check in collapse_file()
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org, hughd@google.com,
 david@redhat.com, lorenzo.stoakes@oracle.com
Cc: ziy@nvidia.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, baohua@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1755677674.git.baolin.wang@linux.alibaba.com>
 <aa2db6af6bb2124ef59ad5665951e47806c00a6e.1755677674.git.baolin.wang@linux.alibaba.com>
 <9e816c30-8ce9-46dd-99c0-e747df445be9@arm.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <9e816c30-8ce9-46dd-99c0-e747df445be9@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/8/20 18:13, Dev Jain wrote:
> 
> On 20/08/25 2:37 pm, Baolin Wang wrote:
>> Similar to the anonymous folios collapse, we should also check the 
>> 'khugepaged_max_ptes_none'
>> when trying to collapse shmem/file folios.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/khugepaged.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 5a3386043f39..5d4493b77f3c 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -2125,6 +2125,13 @@ static int collapse_file(struct mm_struct *mm, 
>> unsigned long addr,
>>                       }
>>                   }
>>                   nr_none++;
>> +
>> +                if (cc->is_khugepaged && nr_none > 
>> khugepaged_max_ptes_none) {
>> +                    result = SCAN_EXCEED_NONE_PTE;
>> +                    count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
>> +                    goto xa_locked;
>> +                }
>> +
>>                   index++;
>>                   continue;
>>               }
> 
> Isn't this already being checked in collapse_scan_file(), in the block
> if (cc->is_khugepaged && present < HPAGE_PMD_NR - 
> khugepaged_max_ptes_none)?

Yes, as I said in the commit message, this follows the same behavior as 
for anonymous folios, by checking the folio’s present state again before 
isolating it, since the folio's present state could change after the 
check in collapse_scan_file().

In addition, and importantly, this prepares for the mTHP collapse check, 
see patch 4.

