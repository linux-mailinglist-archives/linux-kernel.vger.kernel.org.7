Return-Path: <linux-kernel+bounces-741822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F79B0E956
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 05:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C65A13A89CE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 03:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CFD204C36;
	Wed, 23 Jul 2025 03:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="B242VoxD"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95EA1E04AD
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753242653; cv=none; b=ZYt/O/tK5K5sgVVkKhxSViGaNK2n8cEE+lnomhJnykcv1m7Gc/fc/FrhL8ZGYFAgtqrPgrxDUgkVGS8slvAfbFQ7/rep/KGw2w7rab7oHB4MxsuIrDrKgX1dqKIOXZfrn6wR9zNfSPB1qVVkFj8oMYWcd7Sh9N0oo2zioPmr/i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753242653; c=relaxed/simple;
	bh=/EkgRCH1lmOGpZDhdZo18xGRs+rbqJS/hYulrOTHdh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XWJF7cGAf33RagQpypy/QHkv7AhbGuh0+B8y9oVMwlg+W+p/SlrNsyytU01TbkBK0MsvL6iomsVB7oCT2aA2KXpvmvHv/QY/VCULJ7Zhd8DoDSRBwmmjUcxV2Ejdlf+/ijogFqr3Cvup8TAWhVI3mA+Nu1ItAsSQb16/w/glhCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=B242VoxD; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-235e1d710d8so67869195ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 20:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1753242651; x=1753847451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+/Pfkit5PFVN0tLEWVs8x9+kRNuxE006f52H9Fa07w=;
        b=B242VoxDCqJh1NKYpxj46Zj1eqG20rZ3yWDO5u7SNH1pUm0ds+lyNHAzbqmn8NLtIo
         IATRttutO2Xyg2e8seSFVM0e1EEMEXgypLyiL/bfuQWnldytffebYNIEAXgBtKyqgm77
         ws4SFVZMMyYsPvF//atPZvgc5ipCxjuN+UmaPsJIVE6WaqFcnt3cwr6LM5astpItDj5n
         Nip5xX0AqObkCHAx1od+ahTaJ3M+rbUYdZABKoIQZgvSSrJUkmPT7Qj/Ig35h+z27FNB
         WZrql90cSxu1z+CXf2m3a1lIsqWHYftmqmuoRaos13Wv5WCcjvj8qwdCMAA8XJ4ho60A
         2m/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753242651; x=1753847451;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t+/Pfkit5PFVN0tLEWVs8x9+kRNuxE006f52H9Fa07w=;
        b=wJ6StREljU9wCiQXkRvlhaAed9/PlrJAHTF//L+Nbligx4Y9maIIcvUE/mxzh33Dsy
         MWXJGjAzDE0IDVCj9dDBwz3ekkabsawigvOfQxtJDUbxSCErLrPbwKzwy4sJgtzUSgCG
         6yk9IE/fkSDvYDuFuQMOg91iM8448tXXwjTr9zIUWkrqIbpsZDMyUvuCNRE/eiT/f+1o
         8813RiwYb134XQ/6Z9oZQMI9xk/nVYjCiyiHx5j26pq5SlgF/OBvz8s6vvXnAbqkVIHg
         c1RyeUd8wuFUV2Tn2P7D6SZtnCecrbdBZ7Y9fvMHt+w1Xr++HtvhtbtiIQw85y9DtJHC
         ZJAg==
X-Forwarded-Encrypted: i=1; AJvYcCUVf0t5mznYLNOEa44gFdK3l92E1mptmu1in8AW2Uqw1afqfJtYpmSpLJPXQ+TsIPf2VDu0CMQlONQSwWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB20RUTnuWFtdoeQuEGduLaOSLH2s8LLli//3yPDVCf4llQPMF
	Ew0wfTP5pdtDqO6AFc5hEn+RUjoAxN1N0FSDnf8xtgEsdTCkd56ZZYEJohgNgAubFIE=
X-Gm-Gg: ASbGncui3/sHm6iaY72VS/0GlvRjLYZHquEUJ/HvmH0HZAVKdmSI3h1sLbuOGwnJMDf
	wgp02FBF2TzpWE7AhHRsnMGg795/770J2lmPIHXQXB2c8hsEMP6zd+FKEwQQROm+q6/tRbEBOBx
	WuzI36jmLGdMJLPfL0zeadGrD3Hz4CxmmnLzgq6fMN8RuOPlRaIbqvcPbE170BCJjPHGRJQxBuS
	kvA3AoWljnx8b/y7dQX7cUFcxafsAZ3aMKH7k1HgaPUYMwxgvUXokYjFLNGHkU77XFtVYW0bdlF
	tqF0Coqh7WQn27guRLmkSB35RpiK3Xuy5NwPtlwac6wrxzyrGgXN/aWsY0Zes+asBddlGIaBuqJ
	xu1TzgrhAnTb0EfreT+flMtWL6UBs0ESN9TFyDsF52nAu32TURg==
X-Google-Smtp-Source: AGHT+IGG5xeTiPp46N1+ubIJYLYiw4X+bPRHHusEDQs77QPZ7xG+Gmpi3gyEPNcDXHORzHZYckNp5A==
X-Received: by 2002:a17:903:f84:b0:234:c5c1:9b84 with SMTP id d9443c01a7336-23f981b4011mr19536245ad.37.1753242651119;
        Tue, 22 Jul 2025 20:50:51 -0700 (PDT)
Received: from [10.254.226.168] ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b70868csm86297515ad.229.2025.07.22.20.50.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 20:50:50 -0700 (PDT)
Message-ID: <6a292069-708e-4f6b-8b0e-95398a9f729c@bytedance.com>
Date: Wed, 23 Jul 2025 11:50:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add missing mm_slot.h file THP section
To: Nico Pache <npache@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>
References: <20250722171904.142306-1-lorenzo.stoakes@oracle.com>
 <CAA1CXcBY4rFLkNqJM2Dj-EajPw9TMTHNcYapw9P=U0bo=QNqkw@mail.gmail.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CAA1CXcBY4rFLkNqJM2Dj-EajPw9TMTHNcYapw9P=U0bo=QNqkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/23/25 1:43 AM, Nico Pache wrote:
> On Tue, Jul 22, 2025 at 11:19 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
>>
>> This seems to be the most appropriate place for this file.
>>
>> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> ---
>>   MAINTAINERS | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 837bc5cd6166..3f83fb317f51 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -15966,6 +15966,7 @@ F:      include/linux/khugepaged.h
>>   F:     include/trace/events/huge_memory.h
>>   F:     mm/huge_memory.c
>>   F:     mm/khugepaged.c
>> +F:     mm/mm_slot.h
>>   F:     tools/testing/selftests/mm/khugepaged.c
>>   F:     tools/testing/selftests/mm/split_huge_page_test.c
>>   F:     tools/testing/selftests/mm/transhuge-stress.c
>> --
>> 2.50.1
> It might also be worth adding it to the KSM section since both of them
> utilize it.
> 

Agree, mm_slot is originally a common part extracted from THP and KSM,
and it is hoped that it can be reused by other modules in the future.

Acked-by: Qi Zheng <zhengqi.arch@bytedance.com>

Thanks.

> 


