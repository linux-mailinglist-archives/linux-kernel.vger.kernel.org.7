Return-Path: <linux-kernel+bounces-820854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CCBB7F829
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B59B1C27A41
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBEC3233EA;
	Wed, 17 Sep 2025 13:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eu/qiQMo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1536F1DE4C4
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116330; cv=none; b=RBPaiw6MmEG0sfMUksLt/3dVn4Mcm8aqs4Z+IN5Ac6i6odDcrdxlXsYcX/FDHh6NLSR4G8DTK7omjH3MIFM4L1BcRqguATFhCwtrGAe+3nI9RKI+CIsG/0lazwE/P81QsJtBLVeJJm/SdOpfKzWlffgr3ofZMpNtCXQgWpYCWAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116330; c=relaxed/simple;
	bh=t8l8bweHMpKGkJbfDFmvZ2Oxn3S78vXdaZqhk49KQPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bh/Nx1C/GYYlutAuP4HFObYTPg/wcijIO5HwA0hmx9KROUua++IHzFd+GTWVV3S1moClLyJ+bkfE3szIV4rJyWvPHxhkVeSh0ejdnY6n+DjyhH9LsPXBIIOURfWtBFk9wS9jwXBeRz8Xe2pD3DERsjvkDa/DtNngkOIn88L+ecI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eu/qiQMo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758116328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rWpRpLIJcUNQ4TuuTh6GHYHjJ2Lxl5zf8mNwE4ByCqA=;
	b=Eu/qiQMofemVLK9jluhgCLusPq5jGrgfDXAvHwPNGcalDcciy0jzMQSnUOzFUpxHMQh1Qy
	H0S23Ve53Ugcchgyq4JWD35p9zd7v0F2cahW9i5T9Lr+quFkSy145CeH13VtcXodY9Q3Gn
	e2QKmJiWYVBz4UPlGJPhAFef1r0D96w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-9YOoYzC9MliNR5wWYgBCew-1; Wed, 17 Sep 2025 09:38:42 -0400
X-MC-Unique: 9YOoYzC9MliNR5wWYgBCew-1
X-Mimecast-MFC-AGG-ID: 9YOoYzC9MliNR5wWYgBCew_1758116320
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45f28552927so20337365e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758116320; x=1758721120;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rWpRpLIJcUNQ4TuuTh6GHYHjJ2Lxl5zf8mNwE4ByCqA=;
        b=ZQpnoURjIO009g6arkcTXnKfAgyaDdhE3eAs26HF7g/4g1m768BPlFbMczKRhxwT8A
         YznDWvsJkuY2ITh57od0SVCchEktksq0l2ZNKOaSN7y6LN+jkV+S4pyYGSG/mN/GMELt
         rntqkKBfv7FpuyhD9h3b7jx7JExzQTVEiDpqXo02m69JklHZ+Yoo4muEKVrt33HR8310
         ip7QLWsBLZUFlcfHrODzNrBrod2rp4/mg7wHeUQSH1jHy3OrBy9MCgC+IO46XYz/qCLv
         x6KfDNYVbJgijY+CN93ds6CQe/eCoBDSgiRpRsqlrF1H0r9G1lZlvDNoj3U09pEHuMpB
         Mvvg==
X-Forwarded-Encrypted: i=1; AJvYcCXrW6JwPO2AnG4ilrICTqTfCrHRF4nb21SGQ3femEPFjhuq7GBX/ZoUdk4NClTwhNKRsN3V3DNayFEIVPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCcEKJk2let7CNWOQMV/K4cOBvd9huUcMFYyvNd8tMuXJOFwlG
	4UNsDCoYF7kxfp+2vXqF3E42ThG5SQPv5ey3XJ1WoZAGI4Le3QDC63fWV6H7nJaNjn7tgYU67YM
	RrGPLXUzq4BaN10gSHVTZqg3OPswWtHNQsNL6TXhQKnfecYe9iYdtGrq/YoWh5CF1GA==
X-Gm-Gg: ASbGnctmDF4ej98LMx1PZqvrjtF5mLT33Gjs8z6mOJlzTrE3QnY9LWyUQiWR6Mkg1WU
	jKc6P5hgjqGDOXenXa9nmZyB9DtQ4WNw+/ztbn34Sw+WM6VdIYEKG0a9vv/dNpA+LDKatt8x+76
	Y/pLc3skdw2IVf1ZiYLD+6kH/ipiMJAvrGNu/DKqmmGPrneyZbsj5wyz0zeyE6z19jr/6Is7aD/
	4Veis4d5iMaOFOH7xOED3tV49iSOyZ4Ejw5HkD5moSFHE6UPvOzouFaVacudmBWne3XpnL/T+Fp
	H4A5CNSyBu5McZHlikK/URaALmovx0zxO3mN60Kz9yK8+yUVlDWtx4+r8KzX3/R/TqoUt0G2h3l
	dDoDYN+NZIzYdq9yMqgpagAZcjY8kazzYWa88Qek5y/JeiYct7FcoDldOYyICXolv
X-Received: by 2002:a05:600c:4fcf:b0:45f:2805:e269 with SMTP id 5b1f17b1804b1-461fcb3c0d2mr22688585e9.0.1758116319599;
        Wed, 17 Sep 2025 06:38:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuvYWydvbyPpvj1AaR8P/P81WlSFuc3j+9G9hsVgOCA31SDwOQXwQpZgSSgyzLhp1LrsumRQ==
X-Received: by 2002:a05:600c:4fcf:b0:45f:2805:e269 with SMTP id 5b1f17b1804b1-461fcb3c0d2mr22687815e9.0.1758116319039;
        Wed, 17 Sep 2025 06:38:39 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f27:6d00:7b96:afc9:83d0:5bd? (p200300d82f276d007b96afc983d005bd.dip0.t-ipconnect.de. [2003:d8:2f27:6d00:7b96:afc9:83d0:5bd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46139122cb5sm36519695e9.8.2025.09.17.06.38.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 06:38:38 -0700 (PDT)
Message-ID: <c6eacb69-86f5-4bdb-9c6b-04e3f7ef7c29@redhat.com>
Date: Wed, 17 Sep 2025 15:38:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] mm: introduce vma_count_remaining()
To: Kalesh Singh <kaleshsingh@google.com>, akpm@linux-foundation.org,
 minchan@kernel.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 rppt@kernel.org, pfalcato@suse.de
Cc: kernel-team@android.com, android-mm@google.com,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915163838.631445-4-kaleshsingh@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250915163838.631445-4-kaleshsingh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.09.25 18:36, Kalesh Singh wrote:
> The checks against sysctl_max_map_count are open-coded in multiple
> places. While simple checks are manageable, the logic in places like
> mremap.c involves arithmetic with magic numbers that can be difficult
> to reason about. e.g. ... >= sysctl_max_map_count - 3
> 
> To improve readability and centralize the logic, introduce a new helper,
> vma_count_remaining(). This function returns the VMA count headroom
> available for a givine process.

s/givine/given/

s/process/mm/

> 
> The most common case of checking for a single new VMA can be done with
> the convenience helper has_vma_count_remaining():
> 
>      if (!vma_count_remaining(mm))
> 
> And the complex checks in mremap.c become clearer by expressing the
> required capacity directly:
> 
>      if (vma_count_remaining(mm) <  4)
> 
> While a capacity-based function could be misused (e.g., with an
> incorrect '<' vs '<=' comparison), the improved readability at the call
> sites makes such errors less likely than with the previous open-coded
> arithmetic.
> 
> As part of this change, sysctl_max_map_count is made static to
> mm/mmap.c to improve encapsulation.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---

[...]

>   	/*
> @@ -1504,6 +1504,25 @@ struct vm_area_struct *_install_special_mapping(
>   int sysctl_legacy_va_layout;
>   #endif
>   
> +static int sysctl_max_map_count __read_mostly = DEFAULT_MAX_MAP_COUNT;
> +
> +/**
> + * vma_count_remaining - Determine available VMA slots
> + * @mm: The memory descriptor for the process.
> + *
> + * Check how many more VMAs can be created for the given @mm
> + * before hitting the sysctl_max_map_count limit.
> + *
> + * Return: The number of new VMAs the process can accommodate.
> + */
> +int vma_count_remaining(const struct mm_struct *mm)
> +{
> +	const int map_count = mm->map_count;
> +	const int max_count = sysctl_max_map_count;

If we worry about rare races (sysctl_max_map_count changing?) we should 
probably force a single read through READ_ONCE()?

Otherwise one might trick vma_count_remaining() into returning a 
negative number I assume.

> +
> +	return (max_count > map_count) ? (max_count - map_count) : 0;
> +}

Nothing else jumped at me.

Not sure what the buildbot complains about but I'm sure you'll figure it 
out :)

-- 
Cheers

David / dhildenb


