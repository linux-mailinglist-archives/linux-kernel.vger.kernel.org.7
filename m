Return-Path: <linux-kernel+bounces-771752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84389B28B2A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 08:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93F51AC0FD9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 06:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305E421C194;
	Sat, 16 Aug 2025 06:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGgjWgsZ"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADDF2036ED
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 06:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755326579; cv=none; b=rjE3m5ZmR2QBCwoF22wDG+hmnryrBetGBdK8R5xOo/8OlrMbUyk3PkzyUrNM9g+yNQjVkpkqud7DqjSauC7RmAWn0vP9h4deqdrbdNk3kH+fXrZw3pUZiaFJxBjA59Cq11UMcAZCAYH6E7pVivyep5hTYSCHRe2N9WUQ7fiRT1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755326579; c=relaxed/simple;
	bh=yrA+fB/fz1WYLdE6YzCwMFtP/UuAww3nOh+Blt8dBxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YBWVsfDmHjQR4IV8UP+WKiAl+LPZu0T1KPNcFrC80sSpzuzYuaI3u5DN0h7gd0FImfkwtPDqWD5mnvuiJ24gA3wgqKokyF8iJ0nS1rTsJpjAR3aH0crBLSycr/H8Lj1e6JK7/SPUw0gpoWFon/wyD/Kr4dDLMH0dAU/NTv66CCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGgjWgsZ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b9e410dbe2so277504f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 23:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755326574; x=1755931374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JeEKBRdhTjoLFfwRtZLV9M5Ry2UMrcAVp6PSuF7j5+0=;
        b=lGgjWgsZlA//aks6J29YncrCsnyEgM99gPjPeo4bCRaKRHrtpZtEGpD8AEml0TuJk/
         eXumviiSIj2Zz7tGIvD7Cj89Esk5WStZBZBGYGzTj9sRFmZosPyNx8QYYkCGQpYDwbVs
         MUtX5sN5hRMmrfeqxcQDYGBLamFvUHipqd0XMGW7gq7fC9tZJHAdNzhc8FY8KuY8r0R0
         4Tyxb89R4495POWe0o5hU0bVsN4etleY2tIaCl7ZmZbTzQVW5kk/xb29Dmq56l4byU8w
         SHcXHEpKXiA2MKCqFsLFRynynGp5p1qDvNDRW3Jvoy58xH2jB4dDRWFEQ6Kvgt0/N7Z5
         et/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755326574; x=1755931374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JeEKBRdhTjoLFfwRtZLV9M5Ry2UMrcAVp6PSuF7j5+0=;
        b=I0tiQwdmW+kOt4QT/mFWHor7Yx0eJrUSkBnEW56nkHNs1bz5sawBRvriZJRW+2ry8S
         LfYFvCIcnQ8e1EQyeqdKdymzn++JazEN0AdTR397ey2psOygPS1fQSCu75kIeoERrOh/
         UEtr7h2cYpy711eIv2rDaGDeaVx1lvpggADGHcojO9MvZK/Nc8LCh+prS65rV/NGOjoa
         lC5FvPXKm8QYcFCvcLUptFZfi3KAP5rlzQ+et9OTRECkBYQenU81PqfHuSOZZTKBpcLR
         wKeBJo3MUJz7ES/Q6GF3IJCXr+Oe7ZWJWfnLqtSMWH4n8o8VqZPl8PmEAm5hxjvpU5IH
         pYtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZgA02Nwa8FIp0zf5yR6R7losXRfs/OiCHmwlvoyWvCTJWM7XnWOgmVOJbqbe/WaC4njPOnTfnIrj+Bpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmUMmGC20IZ5ImdmSvPQIhmn2uZBeqA0dY8wbSbGJJluPOm9iH
	sQl2wWABJo0WjBdPg7G/e3Ml9HTdtDPfBGboKgAjQ3HJIfSy/kNbaxyo
X-Gm-Gg: ASbGnctGRbZ+Py53sRbYrsCqX61OmIu+B7G8mSnUTYgElf9HIojAWAMdAq5tPIUUteD
	+o+iiU6EuEYQgr0Fgczbke4CqFtJg+A4UuI5iiV2qe1pZRFsKGCFHTVjrD8Xjdripe/wxeEJVWS
	J2rCZdHLbKh4WoHXjTJIUmXIZUTxJY+FjHFsXi+/jsaLIUOZofVMDZlA6OKeOkwYNkAahE7wmAz
	9q0IFVvLqH9ETbhNcU6vUkvQdiOewMiTxHcQgNOaCCx7YgF63XWidvCPKL0H3eNIv5ekgTTYXC1
	i4xFENOw1D0Fi9y/SMuQ2UR7nZHep2/UGClR2AS5KdZhql6zOHSF0GNbaZg2FAx2IrH6murHsnD
	jHXDLXwfSVreLc/JpUd0OHYUKPcj0Mf9RJ0SLcEVGbp+C4HNeCSeR
X-Google-Smtp-Source: AGHT+IFwBGKlpiM2gncW9DMNhxgxGnhxg0FqOQuyyKtVBQjC5y8R5nUYtXdYLoaCw5QbLrRt6oMYVQ==
X-Received: by 2002:a05:600c:608c:b0:459:da89:ae8 with SMTP id 5b1f17b1804b1-45a2395a19emr15848035e9.2.1755326573887;
        Fri, 15 Aug 2025 23:42:53 -0700 (PDT)
Received: from [192.168.100.4] ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c78b410sm88598235e9.24.2025.08.15.23.42.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 23:42:53 -0700 (PDT)
Message-ID: <9be479a1-ab93-4ec7-b1aa-68acd94f15ea@gmail.com>
Date: Sat, 16 Aug 2025 10:42:50 +0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/cma: print total and used pages in cma_alloc()
To: David Hildenbrand <david@redhat.com>, Xiang Gao <gxxa03070307@gmail.com>,
 akpm@linux-foundation.org
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, gaoxiang17 <gaoxiang17@xiaomi.com>
References: <20250816042842.3959315-1-gxxa03070307@gmail.com>
 <ee29262a-911b-4a97-b619-0dea3b657252@redhat.com>
Content-Language: en-US
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
In-Reply-To: <ee29262a-911b-4a97-b619-0dea3b657252@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

What about using tracepoints?
Add a trace_cma_alloc() event that only runs when tracing is enabled. No 
lock unless someone is actively monitoring

On 8/16/2025 10:27 AM, David Hildenbrand wrote:
> On 16.08.25 06:28, Xiang Gao wrote:
>> From: gaoxiang17 <gaoxiang17@xiaomi.com>
>>
>> This makes cma info more intuitive during debugging.
>>
>> before:
>> [   24.407814] cma: cma_alloc(cma (____ptrval____), name: reserved, 
>> count 1, align 0)
>> [   24.413397] cma: cma_alloc(cma (____ptrval____), name: reserved, 
>> count 1, align 0)
>> [   24.415886] cma: cma_alloc(cma (____ptrval____), name: reserved, 
>> count 1, align 0)
>>
>> after:
>> [   24.069738] cma: cma_alloc(cma (____ptrval____), name: reserved, 
>> total pages: 16384, used pages: 64, request pages: 1, align 0)
>> [   24.075317] cma: cma_alloc(cma (____ptrval____), name: reserved, 
>> total pages: 16384, used pages: 65, request pages: 1, align 0)
>> [   24.078455] cma: cma_alloc(cma (____ptrval____), name: reserved, 
>> total pages: 16384, used pages: 66, request pages: 1, align 0)
>>
>> Signed-off-by: gaoxiang17 <gaoxiang17@xiaomi.com>
>> ---
>>   mm/cma.c | 15 +++++++++++++--
>>   1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/cma.c b/mm/cma.c
>> index 2ffa4befb99a..46cc98e7f587 100644
>> --- a/mm/cma.c
>> +++ b/mm/cma.c
>> @@ -776,6 +776,17 @@ static void cma_debug_show_areas(struct cma *cma)
>>       spin_unlock_irq(&cma->lock);
>>   }
>> +static unsigned long cma_get_used_pages(struct cma *cma)
>> +{
>> +    unsigned long used;
>> +
>> +    spin_lock_irq(&cma->lock);
>> +    used = bitmap_weight(cma->bitmap, (int)cma_bitmap_maxno(cma));
>> +    spin_unlock_irq(&cma->lock);
>> +
>> +    return used << cma->order_per_bit;
>> +}
>> +
>>   static int cma_range_alloc(struct cma *cma, struct cma_memrange *cmr,
>>                   unsigned long count, unsigned int align,
>>                   struct page **pagep, gfp_t gfp)
>> @@ -858,8 +869,8 @@ static struct page *__cma_alloc(struct cma *cma, 
>> unsigned long count,
>>       if (!cma || !cma->count)
>>           return page;
>> -    pr_debug("%s(cma %p, name: %s, count %lu, align %d)\n", __func__,
>> -        (void *)cma, cma->name, count, align);
>> +    pr_debug("%s(cma %p, name: %s, total pages: %lu, used pages: %lu, 
>> request pages: %lu, align %d)\n",
>> +        __func__, (void *)cma, cma->name, cma->count, 
>> cma_get_used_pages(cma), count, align);
> 
>          ^ one space missing for proper indentation.
> 
> But doing another spinlock cycle just for debugging purposes? That does 
> not feel right, sorry.
> 


