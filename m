Return-Path: <linux-kernel+bounces-856908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8778BE566C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC75A5E5651
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2562DF3FD;
	Thu, 16 Oct 2025 20:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5pWjFNo"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B311A9F93
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760646500; cv=none; b=b6A8+NOMSkB6UidPO7xP56vA6PHowKQ55Q6BLvqVH/G6pBEeqBMLW6uq1hr6g2IRM1gqnDxvH7FS+9NMFzZC8AmNCSaoP9yD2snxcu9iub5YAt++xPWM0LqkxGqOq233HSuFzAAcaHMHfZ5Gr/PXmU1xx8TeKgxCg5NyJPVqMfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760646500; c=relaxed/simple;
	bh=st8CE9lSuHr+S9UOZSYikJT8QbGSDyWDzzQM1KcjVRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NcSj2h7H9cwmivtQcx//e3BDAPe7hNhFQ0i2z7+/VGDtjfnsvs7Vxi0jUTgNCfgrH9TFDrH/0P1Ci7s3AQ7Cr1W30xefIf0nGOycTe8UVd/cWEQYUsyER0yBMvRtjUMqET3MSyiVTY4wCs5s4Y2I7woYshfCLNCUEzqgrk2tWRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5pWjFNo; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-794e300e20dso2019554b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760646499; x=1761251299; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3jY39mXgVcMN9xXBrEeHr/JB2nDeThDXcp+1mm32IdM=;
        b=Y5pWjFNoMFuga+piOB20DKpQqJSOgtBUvga9OwP/+NdW1PyKmFNIE5b1ajws+2AVe1
         K6yFsKzxjO8OpiCoaYUSG6XCWrOGDkzIJGNH0Z5dyV5D4cDey1Eegc6Sos/RlztDOXLz
         M/x9ZvO67bjp+DXLtUN/R0I3YeYW/k9Xh6pLJgWyyam0qUYRBz+TkOLFqrLjCUVzBWih
         LgLtvg4qG2eSZtMpCJy2YzWkRvPTXV0wZKF7SsW5J+ZNw5Zynd6mNJP++i9DxwD7oemi
         /XZ9kSL6jy/B9ikPgaBlF0nLIWZcbg1wvYpjyuqAHsdlzuIlzLvWN+kKawIZKdyQdY9d
         OjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760646499; x=1761251299;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3jY39mXgVcMN9xXBrEeHr/JB2nDeThDXcp+1mm32IdM=;
        b=xR/g5wkMyVoy0xQx97n0cN6FfmANwcqyrDh9whWio42Mw609zLBcer9wF7dDqb4n+e
         PRilcdstM8hBytTUipmvbnWyNGDtEYcQSC/ytggSh7HEcATqODRNED1/Yld8uKMk/dA5
         NoFsP7ewUu9Uh6fSQO3adPDNYQY6LjRqCEBgCt7sXQ8zkkkizEWMg/CytY3WFxJwG2de
         ffTSSeV/TiXWKqhEQ3lHOccVvzMWUuCDieoLSWDx38mdh87mtpxqjHD2wjQ163mId3mN
         94sxo32JEJuEEI7sYnGRYNmh8rzB5DyViq0ck0U2HH7sDI3i8M30YJkU0GO5x+3Oqknu
         goEA==
X-Forwarded-Encrypted: i=1; AJvYcCUZ9HGO7Dr8+63ireEWXQTnSdPsFLl+C4UmfU/GBEjRqfSzzfs67AB0xJagtRjsGcQ37qXJ3G66ehCb8h8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlG4KzGViVFrJtGJWp/uQWE/ugxb0i4UpVr1xfw8iQvr9grxlH
	jDCIPHmlZaQ29YOsgtQXF/KSpyBX78mqpJ/hGB7r3jF0ZReJ2+HK2pkR
X-Gm-Gg: ASbGncvHrUEE04bHxv6PJbSHalHAnhSugKxC0NRgpxVwpq7bg0eAlzsQlcjFbPeYkT7
	/jo6StO1FbuHxPAlh6R778ztYBDWcFBFfMpOOOMPsiz7XhktVqdgfNMNuPxpUycwHO/Kr9B2vnh
	PEj+AElYTIIR828FVBI4TFnLezSZtnXQ77KkJSQWdLzvx0sfq8i+I8FQ1znqaCbTXlvYm2NJg7K
	V6hPIDI4ZvbA5b4tSM7OrpXkKR5ZTo3hMJ/njHmQ4VKtvKhfOhtPrCEvLHtUa/op9jjbZs+6YHb
	bWz559zzKS9820rBCtVMtwvAhB4A4zIt0PNd3bJvLEIEaBbvDIwF/PdrPZ+1KCwD2mDNBHwFs6I
	3M9hVVQRowCLLV1MBFGz7bYB1Dz3p5gmxyb7iK6prISaIDv4KYFVNS7Trnqo6m6r0EZmfvfjoTe
	Uqt4ZvXRRTZef3FxmsoJbRZmye+oRjcgN7db1A0BTwaJlx
X-Google-Smtp-Source: AGHT+IGWLWyH0AABkRz6alBvUVzPFctljtKTWRYOwESGtF7UJb7utW5OdfjqyV+JPgqFQydchn8xQQ==
X-Received: by 2002:a17:90b:3f0e:b0:327:c583:add with SMTP id 98e67ed59e1d1-33b9e0a4c2dmr5398538a91.6.1760646498534;
        Thu, 16 Oct 2025 13:28:18 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:6028:a61a:a132:9634? ([2620:10d:c090:500::5:e774])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bd79dda6fsm337108a91.10.2025.10.16.13.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 13:28:17 -0700 (PDT)
Message-ID: <b4418948-61ce-4cf1-a3d2-a4208e73d5b3@gmail.com>
Date: Thu, 16 Oct 2025 13:28:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] memcg: introduce kfuncs for fetching memcg stats
To: Song Liu <song@kernel.org>
Cc: shakeel.butt@linux.dev, andrii@kernel.org, ast@kernel.org,
 mkoutny@suse.com, yosryahmed@google.com, hannes@cmpxchg.org, tj@kernel.org,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
 kernel-team@meta.com
References: <20251015190813.80163-1-inwardvessel@gmail.com>
 <20251015190813.80163-2-inwardvessel@gmail.com>
 <CAHzjS_s3L7f=Rgux_Y3NQ7tz+Jmec5T8hLyQCxseLJ9-T-9xuQ@mail.gmail.com>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <CAHzjS_s3L7f=Rgux_Y3NQ7tz+Jmec5T8hLyQCxseLJ9-T-9xuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/15/25 4:12 PM, Song Liu wrote:
> On Wed, Oct 15, 2025 at 12:08 PM JP Kobryn <inwardvessel@gmail.com> wrote:
>>
> [...]
>> ---
>>   mm/memcontrol.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 67 insertions(+)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 4deda33625f4..6547c27d4430 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -871,6 +871,73 @@ unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
>>   }
>>   #endif
>>
>> +static inline struct mem_cgroup *memcg_from_cgroup(struct cgroup *cgrp)
>> +{
>> +       return cgrp ? mem_cgroup_from_css(cgrp->subsys[memory_cgrp_id]) : NULL;
>> +}
>> +
> 
> We should add __bpf_kfunc_start_defs() here, and __bpf_kfunc_end_defs()
> after all the kfuncs.

Good call.

> 
>> +__bpf_kfunc static void memcg_flush_stats(struct cgroup *cgrp)
> 
> We mostly do not make kfunc static, but it seems to also work.
> 
>> +{
>> +       struct mem_cgroup *memcg = memcg_from_cgroup(cgrp);
>> +
>> +       if (!memcg)
>> +               return;
> 
> Maybe we can let memcg_flush_stats return int, and return -EINVAL
> on memcg == NULL cases?

Sure, I'll do that in v3.

> 
>> +
>> +       mem_cgroup_flush_stats(memcg);
>> +}
>> +
> [...]


