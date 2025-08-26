Return-Path: <linux-kernel+bounces-786683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F235B36281
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8D2E464D45
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CC2221704;
	Tue, 26 Aug 2025 13:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hyUJefTw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780E034320F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 13:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213943; cv=none; b=tEBS4J4xxU0s31eYMYidYKpj3v4bd5jbusciMOrYWKiv1EQ+BljlOd4mr9ZHdzLwkiArzxzziw9d7mpLRtd6F48TuAOZjWiP+5SSy2uzEckYhR/UXF4JkxCSGAKGJuaGGJCFSOSPy/CXYfeVdtZBvacEZ5sFnm9I3SXT1QP03XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213943; c=relaxed/simple;
	bh=40QzJLXcV+Rtp4PL9exLUl1txV+EBlDfzHIGkrzY5Ho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YYYpdOGsIr4A2Aeg/nOxK+Mr2MqepD2EKhviIG3rdOYrNYqjPcZq0Nh0SpT9uH4rVfaDcH7nKFX/BI9H1+UXGM6jtfbCN8/4XPFFb0LDJpRbJ95VIb1InIYS6ivtxg53wVbqZpc3XDTuNcwWRepaleQDOy1Lvk1RvrhrKksN644=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hyUJefTw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756213940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4rHjziWKPYkVa/nL99Zp8lslj9SamBEgj2hG79NTy7E=;
	b=hyUJefTwSRuFO7KbVnghI8MX1wSZqp1sp3GDGba2Jimfleef7B9wGcevGeRFlBcH3GQCK4
	t3e2Wrx3TMSIkFd8YEJODPKgZIOmXL6vFc28xqKDaf3x9KVNv9M9Y6gKFHomGz/dPg2sC9
	qoW3FBe7nnbUELgM246uszsuLsPu/zU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-Gpw2PWHyN-iNEzhJU75gww-1; Tue, 26 Aug 2025 09:12:14 -0400
X-MC-Unique: Gpw2PWHyN-iNEzhJU75gww-1
X-Mimecast-MFC-AGG-ID: Gpw2PWHyN-iNEzhJU75gww_1756213933
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3cbd6cd78efso303090f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756213933; x=1756818733;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4rHjziWKPYkVa/nL99Zp8lslj9SamBEgj2hG79NTy7E=;
        b=DT/LTw+EkHgUgn2lexyvuqsCZ3qP/ENHfMFqqADhe2IpOATfWlr5E/RHuRSntQD3a5
         NlgR3zpzRW3knoxPVmJ159TyaKuez3jECqnB/81DhuEKmG+6oMDSpmEHuLtfI0cuv9rF
         H7RVWDrmw+DPOnFTG2rHTNU9+BLEkyx4sX/qFzcLBbdG0r+yKkpa8uD0bzE1K/L6unvw
         N7+bCvV3GozFp2LJjKPh8Ta/WgouvNnSBPCfNTqrL91j5gtQGTDWQcboV5S+AErXHy2y
         TgUAAwd5roSzL01sv3Xk/Rqx/MgAkOn5Oo8+jNHgtMUV1wC/ePXGMw6odi8Q/LJFtkrd
         eDiA==
X-Forwarded-Encrypted: i=1; AJvYcCUs663SQmo/V0/4iq1tVTDXK6NM15N8uYzPQ9wEA8k+P/VvGz6mKCnGEjP9lV7I04jwgheOiShyz8e5pQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaMvrT8NGW+wcN7KmI719EHQGNfYLbvNuwvLnrrhj8CzV/YgA3
	hkHhPO8dJ6/z8GxQsKbZeSFJl2DxVdnNqGoJkYSpfzs8SugUICt/5/d9jWR4//rlTr3fdO7p3jh
	UvRPIhJMJxAeUKo9Rc9zM1fICpvib/kzjnvh0LZAMq/v/UBDFD5WdyJoADDaUUhyR6g==
X-Gm-Gg: ASbGncsdwMhkZKHfJuO3SzgJb41vMz2Ude5S55BD5lH5DiNsYSGqKJAoL6AHo+JEFkv
	75k7Ioy/lu+rg5JZsOcGx1nsbfBSzvJv8xDyCrsiFTC8dwzjsYv00Wm8uezSKT4Su1JyYz0d2lN
	2tQQ8dNzF5XE4K8dwiek3zMtzGgB4e6/KFOu/v9ykO/Kz1yvb1gRDxzh4aj7ibX+VGb5kLe6tpm
	6xv1ubD38VZhA5eJZ63IlAuywSrcnUye3EVoLaQ9SGhQtbfSD5YUppeNAEbsgreo23SNyTxkNWz
	vA/LyoR+aodzUFbhhqt9mlusBweWHXEWPA7XH55k3QANlMNnqHAHaDJeahF1+0brfRWBHH+28w=
	=
X-Received: by 2002:a05:6000:248a:b0:3c4:bc55:65e1 with SMTP id ffacd0b85a97d-3c5daefc4bcmr12578684f8f.24.1756213932545;
        Tue, 26 Aug 2025 06:12:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh8gAAYqvqZjTfr+OgLA4sqKw/Hb4eb8ARiS4jjSjxrCyW2eLFUtFZa5rL+EHMB8mMqDNPzA==
X-Received: by 2002:a05:6000:248a:b0:3c4:bc55:65e1 with SMTP id ffacd0b85a97d-3c5daefc4bcmr12578596f8f.24.1756213931748;
        Tue, 26 Aug 2025 06:12:11 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b5753ac36sm157325205e9.6.2025.08.26.06.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 06:12:11 -0700 (PDT)
Message-ID: <73a39f45-e10c-42f8-819b-7289733eae03@redhat.com>
Date: Tue, 26 Aug 2025 15:12:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] mm: update fork mm->flags initialisation to use
 bitmap
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S . Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 David Rientjes <rientjes@google.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Matthew Wilcox <willy@infradead.org>,
 Mateusz Guzik <mjguzik@gmail.com>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
 <9fb8954a7a0f0184f012a8e66f8565bcbab014ba.1755012943.git.lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <9fb8954a7a0f0184f012a8e66f8565bcbab014ba.1755012943.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.08.25 17:44, Lorenzo Stoakes wrote:
> We now need to account for flag initialisation on fork. We retain the
> existing logic as much as we can, but dub the existing flag mask legacy.
> 
> These flags are therefore required to fit in the first 32-bits of the flags
> field.
> 
> However, further flag propagation upon fork can be implemented in mm_init()
> on a per-flag basis.
> 
> We ensure we clear the entire bitmap prior to setting it, and use
> __mm_flags_get_word() and __mm_flags_set_word() to manipulate these legacy
> fields efficiently.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>   include/linux/mm_types.h | 13 ++++++++++---
>   kernel/fork.c            |  7 +++++--
>   2 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 38b3fa927997..25577ab39094 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1820,16 +1820,23 @@ enum {
>   #define MMF_TOPDOWN		31	/* mm searches top down by default */
>   #define MMF_TOPDOWN_MASK	_BITUL(MMF_TOPDOWN)
>   
> -#define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
> +#define MMF_INIT_LEGACY_MASK	(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
>   				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK |\
>   				 MMF_VM_MERGE_ANY_MASK | MMF_TOPDOWN_MASK)
>   
> -static inline unsigned long mmf_init_flags(unsigned long flags)
> +/* Legacy flags must fit within 32 bits. */
> +static_assert((u64)MMF_INIT_LEGACY_MASK <= (u64)UINT_MAX);

Why not use the magic number 32 you are mentioning in the comment? :)

static_assert((u32)MMF_INIT_LEGACY_MASK != MMF_INIT_LEGACY_MASK);

> +
> +/*
> + * Initialise legacy flags according to masks, propagating selected flags on
> + * fork. Further flag manipulation can be performed by the caller.

It's weird not reading "initialize", but I am afraid the kernel is 
already tainted :P

t14s: ~/git/linux nth_page $ git grep "initialise" | wc -l
1778
t14s: ~/git/linux nth_page $ git grep "initialize" | wc -l
22043

Besides the assert simplification

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


