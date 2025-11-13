Return-Path: <linux-kernel+bounces-899411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F92C57D73
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 313CA5025B1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD643351FDA;
	Thu, 13 Nov 2025 13:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3RX1R0K"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E875351FAB
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 13:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763040295; cv=none; b=bfaISAgu3U4t5U88/3iGU/H/1zJ7xktnqy9+d+D9xt6Zz/gO4tOl5C5sFYettVJfuLOuvHuM6KLOEa2fNjUea8gcc1Y1/stpSkJ7P4Xou6QBI+BmYDfKKwK9dVnW0qO77GX+EJZ1rmtGpbVbXZr7k1VMX6aoY3BLaGskhVIUHao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763040295; c=relaxed/simple;
	bh=/G842q39ITL2+dv0er/oi50XuXabVeCFAWGwYX/iW3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pjvaEzn+bMMP2WIatjiyzqyakxdmMFLIfQYqUTKxvYr6k1dPMa4ZS/+P6CFwWlfmI/WMh5Oj3O/p/M0jGvop19Tt0NNyKji7oCpAmffSA5/Ao1yI4eURr6tSd9NuAcHhE2sAyOvCR6KmBznPNdpqjy7Y853mnnFt1pacx8V3nMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3RX1R0K; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4775c4197e1so254695e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 05:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763040292; x=1763645092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B7jIez1MXpJkQUncD4sP1e3Goi5dMHittA/PGNqTbAk=;
        b=B3RX1R0Ko9YGiykQ1vt5+/uglnGDG6EdEaKTRSXM+jGYa5fJBwX/XXcAVotT/i7GNI
         AYzOHmGF6uYt2DuZr9gbtC1P32U6gfi7ec7iyB4oN/+BbpqXOVKeVucPnkR6yvMYQcxi
         dale05ozLsdkYUz9TMPEcd5ZRvhcqzjOUYRD0J1SQpjS/Ksxvl3BtjRDTAQNbYbfOnln
         pYO9eZXQLJwV9029cmfm0lQM5RWbzeQ3tZB45M8OCSbiPVp1C/rQ5wLu3H/dvzFP2XGG
         Fz/zFwtCB10uEW0v1CDkMiQg1HNz6T1oUISdJC6iLDZODDomqYD40KuNZPgnGdk0HeK1
         9oLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763040292; x=1763645092;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B7jIez1MXpJkQUncD4sP1e3Goi5dMHittA/PGNqTbAk=;
        b=a3auBRaXZwNvdPW/tVihvPZeuvVfIC15PMQ5L2007D/kpABwIioRRP43dlg9ibOkQ2
         d46+3/pGMLvQ7bn0mH0pc+Z6IpSXRiXuP+eXyAqGK+9Ele/bil0/BHxJrKgfE12YQz+5
         L6XGRcZYdNJGasZYYf8Na6f5OJrwmClgVG45W0bv/dF1RNS4SpbjRYhXcCn9n35krV0P
         VmyVZDLj5aex0bq3SJNaTejCIfRvejOVkZH6bzzW2w4JG7fxqlZSHDAhSzkvdq9V0uut
         zSoufPGkxr4G3QjXKSNgbNFxYSB5ZY8UWQ03hvLw1sDEIIkePUi2r3dbCQYukRf2Fcd8
         96xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjXHHWpMykBi0cRtk+WrZShqJmAx7iNszxKhTssp69JW6TttHcdkkRg8rTRkqghCYuZu5H27KsPe/OwVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwenmIATp3sS33PvyRxndqKe0fN07VM/nEa/V2lm1RWDbxrjpF9
	eid2HS3kESpFsR+HCCU7zG6DMIGTaA4VxKiC84zgh70huMIpFmV3kqCo
X-Gm-Gg: ASbGnct1K/QgKlJzLf1u0ISt49UQk/dYpCobkZEvRjM+1RLTsg9VkGPxEZsGe3AZCPt
	FIYXTdeqDR43rkHExxGiQr2LCZd3yYtVSNJ4ZX0WQaLmeOvMGjQa+I/0HMbG+hQaNW8e7bEDSzg
	rFRFWwHSaZr3eaUvx6nDDpctFR0o33QTAp7jJ1mlmryprUYYOAi9PpF2jDJ2otO48ziIIywXtNL
	VQtZy7wqdM0uttfuqF4ofmH4HlJEnVIJTnyyUOkybsluJ1hwprCILTQcc3Fyf+DOP9lc6Txf1jW
	HU0M9bi67+opZUcDLN7oNQEe50pU6NXFmBUE/EtR+i31hhmUUPPiBudjqEb/ApXQwUa9GytfEoh
	tHE2kPkAbSvHf+jlkHkgNtq+tSEOJ5pyrPNpVdqoyvx6m9nH0XWbd9BkJkUdhJq8KpXI7QQWpak
	tEfgeSOY6v37RxXPMEzVUuSQ==
X-Google-Smtp-Source: AGHT+IEoYTRrkk4/MsqCg1hhWamxmkk6fIEwfucpjkEgmd6ISTBSqIjpMm6wzZyTSudgBXaqmBB8Xg==
X-Received: by 2002:a05:600c:3b0a:b0:477:555b:3411 with SMTP id 5b1f17b1804b1-477870482f7mr32516245e9.1.1763040291609;
        Thu, 13 Nov 2025 05:24:51 -0800 (PST)
Received: from [192.168.1.105] ([196.239.132.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787ea3b56sm88868715e9.16.2025.11.13.05.24.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 05:24:51 -0800 (PST)
Message-ID: <2f26b1a4-4dfc-4a8f-bebe-5be77107e4f4@gmail.com>
Date: Thu, 13 Nov 2025 15:24:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm/uffd: remove static address usage in
 shmem_allocate_area()
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, peterx@redhat.com, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 surenb@google.com, mhocko@suse.com, shuah@kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com, khalid@kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20251111205739.420009-1-mehdi.benhadjkhelifa@gmail.com>
 <aRXDbk9ajOhH7ReX@kernel.org>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <aRXDbk9ajOhH7ReX@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/25 12:39 PM, Mike Rapoport wrote:
> On Tue, Nov 11, 2025 at 09:54:27PM +0100, Mehdi Ben Hadj Khelifa wrote:
>> The current shmem_allocate_area() implementation uses a hardcoded virtual
>> base address(BASE_PMD_ADDR) as a hint for mmap() when creating shmem-backed
>> test areas. This approach is fragile and may fail on systems with ASLR or
>> different virtual memory layouts, where the chosen address is unavailable.
>>
>> Replace the static base address with a dynamically reserved address range
>> obtained via mmap(NULL, ..., PROT_NONE). The memfd-backed areas and their
>> alias are then mapped into that reserved region using MAP_FIXED, preserving
>> the original layout and aliasing semantics while avoiding collisions with
>> unrelated mappings.
>>
>> This change improves robustness and portability of the test suite without
>> altering its behavior or coverage.
>>
>> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
>> ---
>> Testing:
>> A diff between running the mm selftests on 6.18-rc5 from before and after
>> the change show no regression on x86_64 architecture with 32GB DDR5 RAM.
>>   tools/testing/selftests/mm/uffd-common.c | 25 +++++++++++++++---------
>>   1 file changed, 16 insertions(+), 9 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
>> index 994fe8c03923..492b21c960bb 100644
>> --- a/tools/testing/selftests/mm/uffd-common.c
>> +++ b/tools/testing/selftests/mm/uffd-common.c
>> @@ -6,11 +6,11 @@
>>    */
>>   
>>   #include "uffd-common.h"
>> +#include "asm-generic/mman-common.h"
> 
> Please drop this.
> There's already include <sys/mman.h> via uffd-common.h/vm_util.h.
> 
>>   
>>   uffd_test_ops_t *uffd_test_ops;
>>   uffd_test_case_ops_t *uffd_test_case_ops;
>>   
>> -#define BASE_PMD_ADDR ((void *)(1UL << 30))
>>   
>>   /* pthread_mutex_t starts at page offset 0 */
>>   pthread_mutex_t *area_mutex(char *area, unsigned long nr, uffd_global_test_opts_t *gopts)
>> @@ -142,30 +142,37 @@ static int shmem_allocate_area(uffd_global_test_opts_t *gopts, void **alloc_area
>>   	unsigned long offset = is_src ? 0 : bytes;
>>   	char *p = NULL, *p_alias = NULL;
>>   	int mem_fd = uffd_mem_fd_create(bytes * 2, false);
>> +	size_t region_size = bytes * 2 + hpage_size;
>>   
>> -	/* TODO: clean this up.  Use a static addr is ugly */
>> -	p = BASE_PMD_ADDR;
>> -	if (!is_src)
>> -		/* src map + alias + interleaved hpages */
>> -		p += 2 * (bytes + hpage_size);
>> +	void *reserve = mmap(NULL, region_size, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS,
>> +			-1, 0);
>> +	if (reserve == MAP_FAILED) {
>> +		close(mem_fd);
>> +		return -errno;
>> +	}
>> +
>> +	p = (char *)reserve;
> 
> No need for casting here.
> 
>>   	p_alias = p;
>>   	p_alias += bytes;
>>   	p_alias += hpage_size;  /* Prevent src/dst VMA merge */
>>   
>> -	*alloc_area = mmap(p, bytes, PROT_READ | PROT_WRITE, MAP_SHARED,
>> +	*alloc_area = mmap(p, bytes, PROT_READ | PROT_WRITE, MAP_FIXED | MAP_SHARED,
>>   			   mem_fd, offset);
>>   	if (*alloc_area == MAP_FAILED) {
>> +		munmap(reserve, region_size);
> 
> I think it'll be more readable to put munmap() after setting *alloc_area to
> NULL.
> 
>>   		*alloc_area = NULL;
>> +		close(mem_fd);
>>   		return -errno;
>>   	}
>>   	if (*alloc_area != p)
>>   		err("mmap of memfd failed at %p", p);
>>   
>> -	area_alias = mmap(p_alias, bytes, PROT_READ | PROT_WRITE, MAP_SHARED,
>> +	area_alias = mmap(p_alias, bytes, PROT_READ | PROT_WRITE, MAP_FIXED | MAP_SHARED,
>>   			  mem_fd, offset);
>>   	if (area_alias == MAP_FAILED) {
>> -		munmap(*alloc_area, bytes);
>> +		munmap(reserve, region_size);
> 
> Here as well.
> 
>>   		*alloc_area = NULL;
>> +		close(mem_fd);
>>   		return -errno;
>>   	}
>>   	if (area_alias != p_alias)
Thank you for your suggestions, A v2 has already been sent out with your 
suggestions.
Best Regards,
Mehdi Ben Hadj Khelifa>> --
>> 2.51.2
>>
> 


