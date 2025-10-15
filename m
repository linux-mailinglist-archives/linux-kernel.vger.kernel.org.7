Return-Path: <linux-kernel+bounces-854130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42980BDD9C5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 598FD5460D9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CFE30B525;
	Wed, 15 Oct 2025 09:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MS0g5JOc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1EA3090F7
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760519311; cv=none; b=AiPldtvdSHartdTJmcjqhEJh7qHd7NAhGyxtTXqt02CAgD35vgEQtNl0SGH3HeTPljB2fJVrL5AFLazRMTXd31SWnFJp/cz0EDLKN51xd0e5ZlMGxCypCaa+ppDTfAk0GKaYsdsONq3F8ZNcF+lSkRr/3CSq5mgmmH3DtsAetvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760519311; c=relaxed/simple;
	bh=ymYYeOdl7vG2uQXGD7Z8t0AFlMx5IwYyJAUvD80KpeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QEa4Vnsb9hizLvOGQwRMRhSvpO1F7t3iMUujBKy4lRqcvX38CifVb6pD9sVTEPZpgY5090GAZ7Sbp3NowyLC2oQ7dECeNAY1bx7IKFNWxHiW8UF205yf/I8nt5rBF3A2YtjJRrRfm6GLbevcVt65ZFqZedQ06TZxI7daKUP9yjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MS0g5JOc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760519308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4/qnPEWEdYt8yXr6RF4YLK70UvTplvNuCrjSISCrx+k=;
	b=MS0g5JOcvztZC3SkhpyFVZidlf8IfcZzJkXhNgjfKzX+NvKHYJ4sVVQebUqnz9VzdQ4yux
	VFkKD1GX6CBiP+kaErpAdVR9AW02ZSFA/J9ZmVwW221U0qFx2WfItQev9SgXB+o8WwGJi0
	D5JX5BwnsWGKT4GE9jS9N9hYfTkcSN0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-ex0GSh4kOeuO6tcKZrXVzw-1; Wed, 15 Oct 2025 05:08:25 -0400
X-MC-Unique: ex0GSh4kOeuO6tcKZrXVzw-1
X-Mimecast-MFC-AGG-ID: ex0GSh4kOeuO6tcKZrXVzw_1760519304
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e3d9bf9e1so43318625e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 02:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760519304; x=1761124104;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4/qnPEWEdYt8yXr6RF4YLK70UvTplvNuCrjSISCrx+k=;
        b=ie4XYhH0MbYTDf29CiZbs5cxHuQXtmFmqUTTAtFDKSsP+Z8RQAQPChWx5EOR7DIqa1
         YvZTsFZZsAiOBcgfrPq1j4ti22s6i7m7Y/v4bb/q7DrCrs/qBIxuTgoacY5v1IIVpFIL
         tVKDnpKHyJJshKZNd5Cp+LoltAboMXouy79dyIX0HITw31MilHjoN69jRDYHGGX+gtz6
         b16owGjAYvRW/Y5+DtDI8i2lDo0+44lXXVF0zfZhnWf89A8Qu3qFGC1SjACU78GbDCPN
         cw/yVBFWHetxq6W9U4AxI0U0apfP/lGnb/nBJAXVCG0XZQjCeVLY4apTGpQaWffMl+NK
         s1bA==
X-Forwarded-Encrypted: i=1; AJvYcCX2Dm5ek7yqCChbqLusNYIirafh6TgjOhfNqJDn2pXQrukRIj6JGBZgCfJau4dadcBeH8/qJllhNI7yr0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWQF5q+Lfu4l9BtnD0NF8xlK0g8YSbl0Va1lgnLDNtx2HMQxKk
	fKurcRR7mfLiIDizGbJgYoHoOlJ8FyggcY1FBPaWPW2APz84YUuOP+qDLAExOe5jrEAXnIPLhf0
	bu2em1plG7t1TAs72pOe/C4szXYBhCRx1d8rc4mfh/uAiuzwC5dKsIS60AjKE81EKiw==
X-Gm-Gg: ASbGncuIXmEMenREvW6jg43J4/eXsqcOp9w/VDCJBXbtO++qfe/hLNpjLt7+QF9gIo1
	vyNfrxr43Fj8Sni1xf+YsFepIgVv8lYNoO/iC4Jxqp4qGhFYBddV92i5qhXbVCgglV7HwjNlhNV
	y0rHr4r9EAGBqTHyLW2zShMM/+lggQeQY0ba6Y1vH6kJK8z6rMfTHGcTb7kQgcDtXhcv11K1/CV
	jc2okFubgpu8nhSJOSe0qNCkeLI1tHjg5Z/0mdW25smdk0tB3o4u8/2klFZbWD6jIm3RdgLc07G
	/0ZwFpWqgH9VYtqDjZPIHKxdcSXlS/V5SO5wdU4EjjvSq3RpSWGV4QmbZy0XPT0=
X-Received: by 2002:a05:600c:c083:b0:46f:b43a:aef0 with SMTP id 5b1f17b1804b1-46fb43aaf30mr104797715e9.41.1760519303754;
        Wed, 15 Oct 2025 02:08:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHborQb2H9lSN0eaTHrwL4MBFGg6wIu0HbZh/Za6m+vHkY97y/h3fvEJDNWqng4iT1IYdIJpg==
X-Received: by 2002:a05:600c:c083:b0:46f:b43a:aef0 with SMTP id 5b1f17b1804b1-46fb43aaf30mr104797395e9.41.1760519303343;
        Wed, 15 Oct 2025 02:08:23 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb489accbsm333754525e9.14.2025.10.15.02.08.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 02:08:22 -0700 (PDT)
Message-ID: <a72ebcaa-2cea-47c1-bd57-f88c8eb417f6@redhat.com>
Date: Wed, 15 Oct 2025 11:08:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/khugepaged: fix comment for default scan sleep
 duration
To: wang lian <lianux.mm@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Andrea Arcangeli <aarcange@redhat.com>, Rik van Riel <riel@redhat.com>,
 Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20251015064333.31274-1-lianux.mm@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251015064333.31274-1-lianux.mm@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.10.25 08:43, wang lian wrote:
> The comment for khugepaged_scan_sleep_millisecs incorrectly states
> the default scan period is 30 seconds. The actual default value in the
> code is 10000ms (10 seconds).
> 
> This patch corrects the comment to match the code, preventing potential
> confusion. The incorrect comment has existed since the feature was
> first introduced.
> 
> Fixes: ba76149f47d8 ("thp: khugepaged")
> Signed-off-by: wang lian <lianux.mm@gmail.com>
> ---
>   mm/khugepaged.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index e947b96e1443..449f983b8891 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -67,7 +67,7 @@ enum scan_result {
>   static struct task_struct *khugepaged_thread __read_mostly;
>   static DEFINE_MUTEX(khugepaged_mutex);
>   
> -/* default scan 8*512 pte (or vmas) every 30 second */
> +/* default scan 8*512 pte (or vmas) every 10 second */

We should improve the 512 part while at it (e.g., on arm64 with 64k page 
size it's 2048, on s390x it's 256).

And s/pte/ptes/.

/* default scan 8*HPAGE_PMD_NR ptes (or vmas) every 10 second */

-- 
Cheers

David / dhildenb


