Return-Path: <linux-kernel+bounces-786693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FD4B36358
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C71D18A8360
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00991B85F8;
	Tue, 26 Aug 2025 13:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A6kMSEGd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5119B34A338
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 13:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214394; cv=none; b=nR614WDZzEeg6T7K6AcOBdpIpMpzRnSqgZ0L4Tztou7wGwTn36TNxzB+VSRW/ehamcSgH2GaexVAXMVmQk1Ji76RYrUZEjPMcwiF3CzKSlBpMZRPGKZDhT3WmZzhvBI/KXYwMsOCmZ2zuIRPJsbLD5ZEiE9C4Cs7aEDklS8Qyr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214394; c=relaxed/simple;
	bh=HriMhgFHgEpe5D010ilYmf/t/8LFPwgw9B37hR+SSyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r3D/KjaKhsP8igAQ9ibC9FyKp/NNDkYhXhV6+RadMCw9kJzCF937EqiU4+6gNZHdHSiRR8sUYnxfjF9f34Z66A+BNLPG+ZbjwTSuMWn/zlzzDh3Ly5o9Tci0hC1GDti33VhI1rw2iRys4mNu9Obcx+WID6bO+Gq6BdAS6iKWVWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A6kMSEGd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756214392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aPowumH6CIgAEb32W0OiP+IgD461ps67S25u5+aVKZo=;
	b=A6kMSEGdHByXal27XWSUX0S3YVAkUVyphRw25+qWVcSE53nnLuo0g4If1r2lIY+e7X67rm
	+zo2v9nElKuQ1pXoQ16s+kO6CFUJaNwpwzi0BdNRhMpTQQ+5GDDr6E2c7wgcO4LI3upJB2
	JC8gAbpXdiUYez9No6EEqJmLj8jfqO8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-bPEyenbgOVS3vkMFAXtjkQ-1; Tue, 26 Aug 2025 09:19:50 -0400
X-MC-Unique: bPEyenbgOVS3vkMFAXtjkQ-1
X-Mimecast-MFC-AGG-ID: bPEyenbgOVS3vkMFAXtjkQ_1756214389
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3cbe70a7861so264691f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:19:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756214389; x=1756819189;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aPowumH6CIgAEb32W0OiP+IgD461ps67S25u5+aVKZo=;
        b=sr/ksarBHxZReOrLzS4JFDVGbaNriVSZdEOBg51aPKczF6kVZfBRm9G5EU/XAe8q7U
         s0OXkXGHv4uehIHHl0txON2LNFwOzcbMPvtzvczJsaOo1tL8bzPKH4SyLOSZwf/9MQyv
         YrS0PeHBK2eSoBu4ctTO6YsMLvLFQEFB1Na3bHWmL0eHtGiiT2fmTAp0FEsHowQPDKmi
         vWUe85bp/dE2n9sWs7CBBmX1BHKqOHJUx69gC31puXwPBLVOjZi6AAdYKy6hU4QW4+SW
         u8zqv3wMkXZz/aFueG0HsUHrvLmMV5EnaUSCFJqwiEK+N/oSz/OV3NCQZFGSyDItgoJ3
         Dfmg==
X-Forwarded-Encrypted: i=1; AJvYcCWEPIanly1I+fevs3Ez9QjZyjdJwAuz+undY7ReAHWxlJXpmeF6TENzFODda+HTEAT42OE11ke4t/AVe5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjpjAc8fc1X2RQj7lzUfBfYpwBEraPJxGCl+4Lixdp+spkMFTN
	s76JbHBwOjuegMcrEfXPsaBhbxqPXUIFGiK/9bMJoqSz1i131REauwrjOLe0dZXaHUTXlAY8lU5
	qfcjMX8jv3jyujd0uRMeS2K2PPw2HypnPgs8EOP+9HaXpcMI4ABExYER6R9Lfv4A1zQ==
X-Gm-Gg: ASbGncsaWRQSQQ9bzWfHwHmQz9/jPN5hVzjlUEr8nGBsSwbwH9wgVTQBqAcdwYfxA9H
	ZXGIStDmjwlNqLqpLexQThCAp82L2KjraWXTjuhIqC5flP9+jYQic4EDayk/beiW3XWg0wDI/qd
	PgLKC1awcElch0hfpvaQilAxcQ400yHOMjvdkJsqNWeC6tUEhFoQBwR+DakWR+SY8S/DjwrePWf
	yIEDuKMxYo7nfy8iqqnQd4wjzz+hHMmXSw3lfOty5FzOYXCitkiz3UB5g31K+3Ifh++TvBLEPbT
	ZzOsj7VJcWLAE5EMhzByi+305AMqaz8NykZRcHcbHL2UgAGbFaZD+d7mO0jWVlfjWLvcuba3kg=
	=
X-Received: by 2002:adf:fa4d:0:b0:3cb:cc6f:730e with SMTP id ffacd0b85a97d-3cbcc6f78d6mr1064932f8f.38.1756214389338;
        Tue, 26 Aug 2025 06:19:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFx5h/zeyxS5P6pZqmfC84eQEOjAOEyZe2tYdaN0UkX+GJOpZnY2NgSKE9TejxvTElAs6YgVQ==
X-Received: by 2002:adf:fa4d:0:b0:3cb:cc6f:730e with SMTP id ffacd0b85a97d-3cbcc6f78d6mr1064910f8f.38.1756214388861;
        Tue, 26 Aug 2025 06:19:48 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b574e607bsm148692805e9.0.2025.08.26.06.19.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 06:19:48 -0700 (PDT)
Message-ID: <59fef25c-6559-4fb3-8810-c2a7dd36b95a@redhat.com>
Date: Tue, 26 Aug 2025 15:19:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/ksm: Reset KSM counters in mm_struct during fork
To: Donet Tom <donettom@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Wei Yang <richard.weiyang@gmail.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <2e662107e01417bf9af23bc7f52863cd538419be.1756211338.git.donettom@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <2e662107e01417bf9af23bc7f52863cd538419be.1756211338.git.donettom@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.08.25 14:49, Donet Tom wrote:
> Currently, the KSM-related counters in `mm_struct` such as
> `ksm_merging_pages`, `ksm_rmap_items`, and `ksm_zero_pages` are
> inherited by the child process during fork. This results in
> incorrect accounting, since the child has not performed any
> KSM page merging.

So, the situation is that our child process maps these pages, but it 
does not have any stable rmap items corresponding to these pages.

rmap_walk_ksm() spells that case out.

Can you clarify that in the description here, and how both stats 
correspond to rmap items?

What is the effective result of this misacounting? I assume only a 
higher number than expected.

> 
> To fix this, reset these counters to 0 in the newly created
> `mm_struct` during fork. This ensures that KSM statistics
> remain accurate and only reflect the activity of each process.
> 

Fixes? CC stable?

> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> ---
>   include/linux/ksm.h | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/ksm.h b/include/linux/ksm.h
> index 22e67ca7cba3..61b8892c632b 100644
> --- a/include/linux/ksm.h
> +++ b/include/linux/ksm.h
> @@ -56,8 +56,12 @@ static inline long mm_ksm_zero_pages(struct mm_struct *mm)
>   static inline void ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
>   {
>   	/* Adding mm to ksm is best effort on fork. */
> -	if (mm_flags_test(MMF_VM_MERGEABLE, oldmm))
> +	if (mm_flags_test(MMF_VM_MERGEABLE, oldmm)) {
> +		mm->ksm_merging_pages = 0;
> +		mm->ksm_rmap_items = 0;
> +		atomic_long_set(&mm->ksm_zero_pages, 0);
>   		__ksm_enter(mm);
> +	}
>   }
>   
>   static inline int ksm_execve(struct mm_struct *mm)


-- 
Cheers

David / dhildenb


