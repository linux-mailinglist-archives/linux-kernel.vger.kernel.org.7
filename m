Return-Path: <linux-kernel+bounces-875670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5165C19901
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3EB34037E2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AD52DEA7D;
	Wed, 29 Oct 2025 10:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LeS+GpQo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA10B2D876F
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761732207; cv=none; b=S/z/OZv5NwJ7PRkOkT555xH3rwvwLpoM+nE4xynPJG9I7OFsvSScNNsTBiO8a+bJhEVpUkq3aMDhNa2HP+PJ715Fq8f9kJIO4tG7/GIolLiXBkoKNLLvvBslGsWmZ34RNMdnpxbVOQMgzoVE+B+nsHcYNwO5m33zZsfB7anXvIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761732207; c=relaxed/simple;
	bh=aNI4Q5ZW/abRhSnDZb4svhcnT03dJkbRYwV210Vr3L0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z1Z37vOfboOWyaZMwBpxymR5v5FLfZ8XEPuuBz1F9Aiv3L3p61G98HXe8nVPHeydfPbybHMQCwZ2hn5Xr7IQfxPS7UFMfrPBqOFpgdwD79d882rJcjOOSdz9mu60FsnaPumSivjjQGcutaxH4VK/6N9z/waqUSTKwUR5Oy76iJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LeS+GpQo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761732203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=y/FcJHpggx8mhqHuRDKjQ5iwsuQXd8X9W9pn2zrK9qs=;
	b=LeS+GpQozp4hBQwePWRYw1enw4D+tqkAsx6M9OcBZi805+qyHiaOJpERwp5h/UJjhgT4qs
	ncL9IpLgJe/nEJtkwnjVsvaQW7fde1R/6nON7GTvfD/yYELEJls1OscAmXtMrZ8Rn0vDT7
	crl5iR8pcZ3ZTZsS5oEA8DXu4+/VefE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-dketHJvHPG-wRRt--n-VNA-1; Wed, 29 Oct 2025 06:03:22 -0400
X-MC-Unique: dketHJvHPG-wRRt--n-VNA-1
X-Mimecast-MFC-AGG-ID: dketHJvHPG-wRRt--n-VNA_1761732201
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-427015f62a7so3302569f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761732201; x=1762337001;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y/FcJHpggx8mhqHuRDKjQ5iwsuQXd8X9W9pn2zrK9qs=;
        b=FPaeRh9QacpuRn6PkIaswcjV9KgFUkYYi6YmSVzljPlJIx/K3C5bfQ2IIOEHJ4aN0O
         Ap9xQJb63pjBSgSnd9J//MCywBlLPxgHQnrLiRkyJZMCkYAKpRVY2jIiX1KepUAyNYTH
         aeuM89YrPoMD1muhMHQ4GWw3fzUi+LmiyWOyub6RzcccXRGjjJ0e6iH+N6Hzt9QviMEn
         Dos0bbuVmsnIMMKUrVKt+5x4UdXqus5cblrq+yiAJU/1IoBtzbn2is7Vp25DiAXjhOv1
         HbCUCYDHYoHi/9vg7uu9niNCP1j7gJNEC56na7RQUD6T+OGp9tzl7t8RvAn7gTlJn1PZ
         8ZXA==
X-Forwarded-Encrypted: i=1; AJvYcCVANew8N5MEMq8uPtoyb+Hpa9xLapAjxnWak/o3ybLQcNlq2BKF8fHAJBytjRcAoC5JbN28fpkNb/JpJJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrN3jlP0O7edTD/l1k1YDiKSYv3NmKCNaSoRPC3egBrqI2b5Ul
	yIXqMUfCFHhzfgh60oFaU6x0tlZBUd6I50KFCnVVnspy40Ss8ERZQmbsoF4sMpr4NPOa+VAWt3w
	T7D1nm2Qo79vLEQaF5y7/m8uPhP6LLWj+eiKj3xUrBdcl8YXmIKCdn0YU3avpwI4ltA==
X-Gm-Gg: ASbGncufMZ0o/kzuhAzyKX509pMpzm5QD4jtMHxLsio52OdOp7bkrMC/dogvzqstYca
	E0D++cpP+I/+4KpwixviHdMS7FMf1iHxHMBPxq0KOjFoZVknOqAPmDyNAl+FugEr0Rup2gxs/GN
	BwDzpPbRADZpeVphvFWxcQuScMcHAjElBP7Ci0JLpofrqvO6TqRQS9qsDAgGXQmQaTeNe+N51xS
	DJBCc3Vlxp+FT21MwTn3XZxeK/0rAThyuJu7ip0fjAcJq8H2GyH8oISVqHQimD/SOdqXHcwpR3M
	0ZQbpXjUxPyn9aVyNFNH+zsHGLUuGWc98SjkwspzkpgRdbDPMkDVI1NCoWPQ+IGLRBJjQGDtdDQ
	ri6FQ+jdG9uWGZX28ebTpKQ==
X-Received: by 2002:a05:6000:401e:b0:429:66bf:1463 with SMTP id ffacd0b85a97d-429aefcf5a7mr1864158f8f.44.1761732201079;
        Wed, 29 Oct 2025 03:03:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhljWIvbjQXrTT0ZcTSN+ZEGtAmVQa0mTp2gcq9/yltWmwcEjiu9nE5kn8XdaFT0qYfkxXUw==
X-Received: by 2002:a05:6000:401e:b0:429:66bf:1463 with SMTP id ffacd0b85a97d-429aefcf5a7mr1864123f8f.44.1761732200603;
        Wed, 29 Oct 2025 03:03:20 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952db964sm25517336f8f.33.2025.10.29.03.03.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 03:03:20 -0700 (PDT)
Message-ID: <dcceca48-bbdc-4318-8c07-94bb7c2f75ff@redhat.com>
Date: Wed, 29 Oct 2025 11:03:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/mm_init: Fix hash table order logging in
 alloc_large_system_hash()
To: "Isaac J. Manjarres" <isaacmanjarres@google.com>,
 Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: stable@vger.kernel.org, kernel-team@android.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20251028191020.413002-1-isaacmanjarres@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251028191020.413002-1-isaacmanjarres@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.10.25 20:10, Isaac J. Manjarres wrote:
> When emitting the order of the allocation for a hash table,
> alloc_large_system_hash() unconditionally subtracts PAGE_SHIFT from
> log base 2 of the allocation size. This is not correct if the
> allocation size is smaller than a page, and yields a negative value
> for the order as seen below:
> 
> TCP established hash table entries: 32 (order: -4, 256 bytes, linear)
> TCP bind hash table entries: 32 (order: -2, 1024 bytes, linear)
> 
> Use get_order() to compute the order when emitting the hash table
> information to correctly handle cases where the allocation size is
> smaller than a page:
> 
> TCP established hash table entries: 32 (order: 0, 256 bytes, linear)
> TCP bind hash table entries: 32 (order: 0, 1024 bytes, linear)
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org # v5.4+

This is a pr_info(), why do you think this is stable material? Just 
curious, intuitively I'd have said that it's not that critical.

> Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> ---
>   mm/mm_init.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 3db2dea7db4c..7712d887b696 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -2469,7 +2469,7 @@ void *__init alloc_large_system_hash(const char *tablename,
>   		panic("Failed to allocate %s hash table\n", tablename);
>   
>   	pr_info("%s hash table entries: %ld (order: %d, %lu bytes, %s)\n",
> -		tablename, 1UL << log2qty, ilog2(size) - PAGE_SHIFT, size,
> +		tablename, 1UL << log2qty, get_order(size), size,

So in case it's smaller than a page we now correctly return "0".

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


