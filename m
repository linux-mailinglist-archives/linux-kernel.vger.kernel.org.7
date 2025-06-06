Return-Path: <linux-kernel+bounces-675582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AA0AD000F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 12:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9466016CE5B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 10:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B2A286883;
	Fri,  6 Jun 2025 10:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="efUhyBqQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D620281724
	for <linux-kernel@vger.kernel.org>; Fri,  6 Jun 2025 10:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749204535; cv=none; b=nv4PYp1GgKCtvWfTtY2os5QWe9fX9VrB89cwn8zxe3MIV1OBLmyQMQJ0/kIUzT2LGBMjZXWiBAowRt3UNF6X4g6n3x3XwCSeOsIR5kxD/1iQN9qN5+y728U90X87NhvpeVQthUK+ar3TBjbEueQnb/iapX9D0oaOs72/1vOS6js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749204535; c=relaxed/simple;
	bh=HpVL8Yd+Dmblvp5wZsu8Vt28y80Yk8bxFEyE6m2HD8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MuRvih51X43/lRdeDK9MxBQZpZWyMIYnTSrBuwwCbBr+KOnpjjk+G23ve9F8gDjwDyi3zCkyk+H9XZpD+sUERIaJRe+xSff3PwRh7fhPWXNqn/eid+YHssHaOPZQ0LTzYV9ZCJyX93CbtbUsJ6FeTXX47vkpfgmD8y59629SehQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=efUhyBqQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749204532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LqWL6kmiGthUPf56Vxhpep2m/EM/PHy4Ey78DgkqyIU=;
	b=efUhyBqQgF3Cfiy2uMeHgju/9eG+De9kKO0RTbx1NisQi+ZvWNquCKsXl23f/+Y+yoiIR+
	maYtwknB5kYoccRZeIKA7b09qkRGop+ZFboHDcZcNZ7u9B+eVss56XDx4VvCn9NdVtp6hP
	p6AkKWK4ngffhSraDsH5X69bgX5K4Ws=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-lCjM-MCxOPyUEcQ13hYvPQ-1; Fri, 06 Jun 2025 06:08:51 -0400
X-MC-Unique: lCjM-MCxOPyUEcQ13hYvPQ-1
X-Mimecast-MFC-AGG-ID: lCjM-MCxOPyUEcQ13hYvPQ_1749204530
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-450cb8f8b1bso5386905e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jun 2025 03:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749204530; x=1749809330;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LqWL6kmiGthUPf56Vxhpep2m/EM/PHy4Ey78DgkqyIU=;
        b=Kqwvc/jEwVdyVwwbQjGoxOF320sBSTF3xi6Y0oRUZoXMGmaoMGMEnI8nVx9QXVnl6e
         D4yfgTBx/G7z/ZeAlo4vMwqI0SK6iYX4w6IrbutiIiVv9OFtZN8lI0GuepwnFdDRYj86
         Af4AQQGvNhce6fGXmSkK6TPhIa0DcmfW/0OCMHKBfnTXCoeVBPLhoS7zZjTNH+JOh8jj
         GcdsNZg3iNhSlK4eLMId6djaoEz0vaU8v8X4lWMX2oLhq+ldJ0226X2qT0cb8m7JrT3v
         rl1klcbBx5UG6A3kiWkZIRT6KfLCy+DSd1hDSbboXMKZCvxNDPyelGKlmIn66yUfiDNH
         OoXQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7DYuDRfru0uGZMtn2lSl3mOiz9WOpaUpPMpACj0d5kuUNssDGfKjRdVQIqOwpLpy8KwP6aKTcH8pO6cI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkKA6I6qOCvpF1MVLlmbu93gtLFbgQ7owL7SNXJvQYphnhb8aO
	xuhbYBlQifhtf2GMSLnh5OPTgb+spHuVfrSc9ak1zMvU71XOdeOIDvLqxq54Flf3iTxgSWWIsXX
	uLA69IUcyh5oRXmxmuBjqYE2hiLPzm7gWAawbCxQ0nbcKAanC3ThbkzRdE0Q8W8WPnA==
X-Gm-Gg: ASbGncuS02LcjbA2yPuAYdidm/jGO1ZZg4FvF9lWIMAoqE8Mm3rB2VvntY4KJygfrSh
	kxeVsJkafNCL2Iw2zfaRojTwK71nqUqYA7fcsfwl6lAK6kRKi48HNdS+nIdrsLHYpL9s+xYpRLL
	YC/LJYs+6Qsjs77E2Wp+PHs2+2o6zPxQpqp9Dp8c6D0LvhTAHbA6olkmtPL+e64RgoQjy8bWP5b
	ScFnJ5CW5CXq0dwFpcMBz4cTb0AhEdtpBKV5ePeilwLUPxEHyWEe59uWPnPqh/D3E9MJK9H2GRr
	NGx+8LJAxaqzqpGa872MU5LxTHsDVQtoFefy1Sf2YFDYOtPAWwM944MrJXs8Qkq3u/5C2LNLVb3
	qkI/VCir9MnJ+4zjDub7C3KO4UkEONs+EGRPeAyw2/w==
X-Received: by 2002:a05:600c:8b11:b0:43d:77c5:9c1a with SMTP id 5b1f17b1804b1-4520137401bmr29283125e9.4.1749204529755;
        Fri, 06 Jun 2025 03:08:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPp5BZyf10iS7zveknOd4qj8+XlDxUekpiGQZEgOcw1eiN9sle9w8iR0ThEwJZwS/k9kEuiQ==
X-Received: by 2002:a05:600c:8b11:b0:43d:77c5:9c1a with SMTP id 5b1f17b1804b1-4520137401bmr29282795e9.4.1749204529310;
        Fri, 06 Jun 2025 03:08:49 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f19:9c00:568:7df7:e1:293d? (p200300d82f199c0005687df700e1293d.dip0.t-ipconnect.de. [2003:d8:2f19:9c00:568:7df7:e1:293d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452730b9b3esm15826005e9.25.2025.06.06.03.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jun 2025 03:08:48 -0700 (PDT)
Message-ID: <63145e68-76f7-44a1-b3fb-1213eaa959d0@redhat.com>
Date: Fri, 6 Jun 2025 12:08:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/ksm: add ksm_pages_sharing for each process to
 calculate profit more accurately
To: Longlong Xia <xialonglong@kylinos.cn>, akpm@linux-foundation.org,
 xu.xin16@zte.com.cn
Cc: chengming.zhou@linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Stefan Roesch <shr@devkernel.io>
References: <20250606070314.3028593-1-xialonglong@kylinos.cn>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250606070314.3028593-1-xialonglong@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.06.25 09:03, Longlong Xia wrote:

CCing Stefan.

> The general_profit_show() function only considers ksm_pages_sharing,
> while ksm_process_profit() includes both ksm_pages_sharing and
> ksm_pages_shared for each process. This leads to a mismatch between
> the total profits from ksm_process_profit() and general_profit_show().
> 
> Based on my tests, the sum of ksm_process_profit() for all processes
> can be up to 20% higher than general_profit_show(), depending on
> the size of page_shared. For individual processes, the ratio of
> ksm_pages_sharing to ksm_merging_pages is usually not equal to 1.
> 
> To resolve this, we suggest introducing ksm_pages_sharing for each
> process to accurately calculate its pages_sharing, ensuring
> ksm_process_profit() reflects shared memory benefits more accurately.
> 
> Add a new proc file named as ksm_pages_sharing both under /proc/<pid>/

It's an entry in the file, not a new file.

> and /proc/self/ksm_stat/ to indicate the saved pages of this process.
> (not including ksm_zero_pages)

Curious, why is updating ksm_process_profit() insufficient and we also 
have to expose ksm_pages_sharing?

> 
> Suggested-by: Xu Xin <xu.xin16@zte.com.cn>
> Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
> ---
>   Documentation/admin-guide/mm/ksm.rst |  5 +++--
>   Documentation/filesystems/proc.rst   |  8 ++++++++
>   fs/proc/base.c                       | 18 ++++++++++++++++++
>   include/linux/mm_types.h             |  5 +++++
>   mm/ksm.c                             | 12 ++++++++----
>   5 files changed, 42 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
> index ad8e7a41f3b5..0b33ef98930f 100644
> --- a/Documentation/admin-guide/mm/ksm.rst
> +++ b/Documentation/admin-guide/mm/ksm.rst
> @@ -256,9 +256,10 @@ several times, which are unprofitable memory consumed.
>   	process_profit =~ ksm_saved_pages * sizeof(page) -
>   			  ksm_rmap_items * sizeof(rmap_item).
>   
> -   where ksm_saved_pages equals to the sum of ``ksm_merging_pages`` and
> +   where ksm_saved_pages equals to the sum of ``ksm_pages_sharing`` and
>      ``ksm_zero_pages``, both of which are shown under the directory
> -   ``/proc/<pid>/ksm_stat``, and ksm_rmap_items is also shown in
> +   ``/proc/<pid>/ksm_stat``, ksm_merging_pages and ksm_rmap_items are
> +   also shown in
>      ``/proc/<pid>/ksm_stat``. The process profit is also shown in
>      ``/proc/<pid>/ksm_stat`` as ksm_process_profit.
>   
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 2a17865dfe39..e14ea8389500 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -2290,6 +2290,7 @@ Example
>       / # cat /proc/self/ksm_stat
>       ksm_rmap_items 0
>       ksm_zero_pages 0
> +    ksm_pages_sharing 0
>       ksm_merging_pages 0
>       ksm_process_profit 0
>       ksm_merge_any: no
> @@ -2312,6 +2313,13 @@ ksm_zero_pages
>   When /sys/kernel/mm/ksm/use_zero_pages is enabled, it represent how many
>   empty pages are merged with kernel zero pages by KSM.
>   
> +ksm_pages_sharing
> +^^^^^^^^^^^^^^^^^
> +
> +It represents how many pages saved of this process.
> +(not including ksm_zero_pages). It is the same with what
> +/proc/<pid>/ksm_pages_sharing shows.
 > +>   ksm_merging_pages
>   ^^^^^^^^^^^^^^^^^
>   
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index c667702dc69b..327bf82acf54 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -3262,6 +3262,21 @@ static int proc_pid_ksm_merging_pages(struct seq_file *m, struct pid_namespace *
>   
>   	return 0;
>   }
> +
> +static int proc_pid_ksm_pages_sharing(struct seq_file *m, struct pid_namespace *ns,
> +				struct pid *pid, struct task_struct *task)
> +{
> +	struct mm_struct *mm;
> +
> +	mm = get_task_mm(task);
> +	if (mm) {
> +		seq_printf(m, "%lu\n", mm->ksm_pages_sharing);
> +		mmput(mm);
> +	}
> +
> +	return 0;
> +}
> +
>   static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
>   				struct pid *pid, struct task_struct *task)
>   {
> @@ -3272,6 +3287,7 @@ static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
>   	if (mm) {
>   		seq_printf(m, "ksm_rmap_items %lu\n", mm->ksm_rmap_items);
>   		seq_printf(m, "ksm_zero_pages %ld\n", mm_ksm_zero_pages(mm));
> +		seq_printf(m, "ksm_pages_sharing %lu\n", mm->ksm_pages_sharing);
>   		seq_printf(m, "ksm_merging_pages %lu\n", mm->ksm_merging_pages);
>   		seq_printf(m, "ksm_process_profit %ld\n", ksm_process_profit(mm));
>   		seq_printf(m, "ksm_merge_any: %s\n",
> @@ -3421,6 +3437,7 @@ static const struct pid_entry tgid_base_stuff[] = {
>   	ONE("seccomp_cache", S_IRUSR, proc_pid_seccomp_cache),
>   #endif
>   #ifdef CONFIG_KSM
> +	ONE("ksm_pages_sharing",  S_IRUSR, proc_pid_ksm_pages_sharing),
>   	ONE("ksm_merging_pages",  S_IRUSR, proc_pid_ksm_merging_pages),
>   	ONE("ksm_stat",  S_IRUSR, proc_pid_ksm_stat),
>   #endif
> @@ -3758,6 +3775,7 @@ static const struct pid_entry tid_base_stuff[] = {
>   	ONE("seccomp_cache", S_IRUSR, proc_pid_seccomp_cache),
>   #endif
>   #ifdef CONFIG_KSM
> +	ONE("ksm_pages_sharing",  S_IRUSR, proc_pid_ksm_pages_sharing),
>   	ONE("ksm_merging_pages",  S_IRUSR, proc_pid_ksm_merging_pages),
>   	ONE("ksm_stat",  S_IRUSR, proc_pid_ksm_stat),
>   #endif
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index d6b91e8a66d6..d260cb09c10a 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1176,6 +1176,11 @@ struct mm_struct {
>   		 * merging (not including ksm_zero_pages).
>   		 */
>   		unsigned long ksm_merging_pages;
> +		/*
> +		 * Represents how many pages saved of this process.
> +		 * (not including ksm_zero_pages).
> +		 */
> +		unsigned long ksm_pages_sharing;
>   		/*
>   		 * Represent how many pages are checked for ksm merging
>   		 * including merged and not merged.
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 8583fb91ef13..c2d85ea07b1c 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -824,6 +824,7 @@ static void remove_node_from_stable_tree(struct ksm_stable_node *stable_node)
>   	hlist_for_each_entry(rmap_item, &stable_node->hlist, hlist) {
>   		if (rmap_item->hlist.next) {
>   			ksm_pages_sharing--;
> +			rmap_item->mm->ksm_pages_sharing--;
>   			trace_ksm_remove_rmap_item(stable_node->kpfn, rmap_item, rmap_item->mm);
>   		} else {
>   			ksm_pages_shared--;
> @@ -976,8 +977,10 @@ static void remove_rmap_item_from_tree(struct ksm_rmap_item *rmap_item)
>   		folio_unlock(folio);
>   		folio_put(folio);
>   
> -		if (!hlist_empty(&stable_node->hlist))
> +		if (!hlist_empty(&stable_node->hlist)) {
>   			ksm_pages_sharing--;
> +			rmap_item->mm->ksm_pages_sharing--;
> +		}


Hm, I am wondering if that works. Stable nodes are not per MM, so can't 
we create an accounting imbalance for one MM somehow?

(did not look into all the details, just something that came to mind)

-- 
Cheers,

David / dhildenb


