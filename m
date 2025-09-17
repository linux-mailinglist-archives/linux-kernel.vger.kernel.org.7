Return-Path: <linux-kernel+bounces-820889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C6DB7FB54
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0B49B62C2A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACF731960D;
	Wed, 17 Sep 2025 13:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="chavE6w2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BD23161AA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116675; cv=none; b=JKMPZ8ad+/ZriqnxN01WP/9CX3wYWbJi/Wq9etuYxA4KNykSAtbMXFz2HnKZgJIEJJl6ju5QOiOO7bUmlZJDZHt9tyScvRceRw6Xp3wv5O2C3vY3fcun6oqIJznd12Q3N6MgYBPZJf/1UkPTqCWXDYza8DMW2Q6JmGrWWaY3jm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116675; c=relaxed/simple;
	bh=tVeaLOUcscUXh8ELuJYxqekBt4O2EaJZNoBmTkBToIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oBXINmYtRfq7IRrymkbK5FRIeJkulbTn7HTwzzjtwpZYgnFra1EZH8jkWoqzORQ9agmfCcXy0MAFF1CDAL/ofYjYK5P+R1MNdEYMFkK7T0++ysEqBexng6blB5fBA2xkEjEKDSmoGS4PDOk4TwDKKECAjzetv0ah1UevaEvZwE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=chavE6w2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758116673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=liGb+1uk63kwOPhDFfASvfeBl4VQTUkO45gHzPQGBUU=;
	b=chavE6w2I6v3beCi6eOJ0woUJMyErGFvcIZUFOC0hzx9moYAjmQp/5vd3lalMH7HZzm6jX
	IK6CGmxBPvgi+6oTLYOdxmcLQropVTOo0yAsJJnIRzURuV2b4dPSQMnqWMePnMNmUcnobe
	YLM5vBrDc/+7Ai8xflwS1Z3Zk7mYLBU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-9kSoreLWNvS9uYhxbW7vOg-1; Wed, 17 Sep 2025 09:44:31 -0400
X-MC-Unique: 9kSoreLWNvS9uYhxbW7vOg-1
X-Mimecast-MFC-AGG-ID: 9kSoreLWNvS9uYhxbW7vOg_1758116670
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45f2f15003aso21862425e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:44:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758116670; x=1758721470;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=liGb+1uk63kwOPhDFfASvfeBl4VQTUkO45gHzPQGBUU=;
        b=JHP6iCrNVE6tPkvvEIZ6rZzAqGWiZvwsvIPiXeA9SfIMGCxSbGi0hXY+MwDt/s65Nh
         VifqCINJTwg9obeJbDn/81K93Sk5wRhrj4HBNTyuyrA4zaIxAQwNGhndAxhaaNTMYNWv
         yKExj0WxIu+80XonVU1/1kG0t/w5XEljEzkykk4ZQE1fNXP38UKvBo3Vu5dBYrQmn2Vh
         HDNftDVlnWyLf1CM4Xs4//mQkcdkBD6VK/0up2aJIyit+oGLnG6zQK1jOSHVZMEUhulh
         VaKUTUfSiSHARd/n3YXGo6QBdNtpsHDwI6zNKgSoliXDfERKoOQz0yOqdDcJeuWkr4yU
         gpGg==
X-Forwarded-Encrypted: i=1; AJvYcCXI0mEo8YnR7dI+YNt+XqNgQ4EcLjiPCOvJ51YtNHKMDI8sFl0ishmcIODtPUaFS8nfe0clJFsHfmhXT3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd7ShtfllsE9hgk2OHy1M5eQefNGtjV9DfDKN90PyY7dMfwTZX
	ropVTEKCVULsHVd09eJXekOKZrRCiuWkdkOQqaf4zOwfVbzu7XlA+Jxh/RXXM3sn17OIrPw1Hyk
	2kGmb9HenhbmrfDrT+8f4ErvH6TH4+bJncoyRffoRjMMcGWC+JXe2EDmNqmwvBFjtGQ==
X-Gm-Gg: ASbGncvjM2eg6ccWaCfktQ35sJ6y6CI6JtfAaW1Mgyi5kymgseT+G+AVzXBg7Abmuck
	rNIhjWn4swLKKckcerPE/xMvKNepjt3+S3odb2Fye5rgeGwgxxOkABsPfYJoRzXSP9r6rENFAN1
	2n+SJkJ4qKRWg0mzu++6iN/go9ha4olCcE3HLB746CBI5Vd15RlB2UyHDA/sNniRQ8yGWp9fArP
	xdSUGD2LJ8Nck26dCmbqXJXfjenLvCHckdO9nBV7b9wwhSdag0QxyPDyjWhT9GxWqsqwaHupqeL
	1XmuR6jX2Jd04xB9Cz0M8KLmuy14CCOGBck/9ZmFfV0nm5zr4ho2mCrn9V2v0T7v+vVWGGcqEgF
	cvzx2Az8e29tPCUcpemy6jOoWuQwUAaD6xarUTrrUCqeBFyp3UCj3uwZ4P3/nly3k
X-Received: by 2002:a05:600c:4ec8:b0:45f:2843:e76d with SMTP id 5b1f17b1804b1-46201f8a9f5mr21886325e9.4.1758116670357;
        Wed, 17 Sep 2025 06:44:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw1RIyEIK4TW5AJcprHmluKxUYcV6LPPbUme37h+GXCQZ40f8U9IBbOvKE8vFxsWYa4at8pA==
X-Received: by 2002:a05:600c:4ec8:b0:45f:2843:e76d with SMTP id 5b1f17b1804b1-46201f8a9f5mr21885945e9.4.1758116669885;
        Wed, 17 Sep 2025 06:44:29 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f27:6d00:7b96:afc9:83d0:5bd? (p200300d82f276d007b96afc983d005bd.dip0.t-ipconnect.de. [2003:d8:2f27:6d00:7b96:afc9:83d0:5bd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46139122cb5sm36693815e9.8.2025.09.17.06.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 06:44:29 -0700 (PDT)
Message-ID: <eb7820ed-3351-4cb5-8341-d6a48ed7746f@redhat.com>
Date: Wed, 17 Sep 2025 15:44:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] mm: add assertion for VMA count limit
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
 <20250915163838.631445-7-kaleshsingh@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250915163838.631445-7-kaleshsingh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.09.25 18:36, Kalesh Singh wrote:
> Building on the vma_count helpers, add a VM_WARN_ON_ONCE() to detect
> cases where the VMA count exceeds the sysctl_max_map_count limit.
> 
> This check will help catch future bugs or regressions where
> the VMAs are allocated exceeding the limit.
> 
> The warning is placed in the main vma_count_*() helpers, while the
> internal *_nocheck variants bypass it. _nocheck helpers are used to
> ensure that the assertion does not trigger a false positive in
> the legitimate case of a temporary VMA increase past the limit
> by a VMA split in munmap().
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
> 
> Changes in v2:
>    - Add assertions if exceeding max_vma_count limit, per Pedro
> 
>   include/linux/mm.h               | 12 ++++++--
>   mm/internal.h                    |  1 -
>   mm/vma.c                         | 49 +++++++++++++++++++++++++-------
>   tools/testing/vma/vma_internal.h |  7 ++++-
>   4 files changed, 55 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 8bad1454984c..3a3749d7015c 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4219,19 +4219,27 @@ static inline bool snapshot_page_is_faithful(const struct page_snapshot *ps)
>   
>   void snapshot_page(struct page_snapshot *ps, const struct page *page);
>   
> +int vma_count_remaining(const struct mm_struct *mm);
> +
>   static inline void vma_count_init(struct mm_struct *mm)
>   {
>   	ACCESS_PRIVATE(mm, __vma_count) = 0;
>   }
>   
> -static inline void vma_count_add(struct mm_struct *mm, int nr_vmas)
> +static inline void __vma_count_add_nocheck(struct mm_struct *mm, int nr_vmas)
>   {
>   	ACCESS_PRIVATE(mm, __vma_count) += nr_vmas;
>   }
>   
> +static inline void vma_count_add(struct mm_struct *mm, int nr_vmas)
> +{
> +	VM_WARN_ON_ONCE(!vma_count_remaining(mm));

Can't that fire when changing the max count from user space at just the 
wrong time?

I assume we'll have to tolerated that and might just want to drop this 
patch from the series.

-- 
Cheers

David / dhildenb


