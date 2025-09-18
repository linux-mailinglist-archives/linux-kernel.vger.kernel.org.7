Return-Path: <linux-kernel+bounces-822123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0ABB83115
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EDD9461F9D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 06:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85DC2D94B5;
	Thu, 18 Sep 2025 06:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OEQLV4AZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2088B2D94AA
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758175221; cv=none; b=qbQKGYyKuSyHiNWxCOqhT8aFipIMcthM04uKcs+/Xdx9WM6tfl91qj4n2lbFqFrWiWEI9egw8n6/yF8Qnz/pKfvhWnvSEbjHLf+5Np/yujOxATrnh/IIY0GOdbLo0R5OM6U6JEuf+yyhXD7fcQhex6pYva5SjFutYCBdMJhNiP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758175221; c=relaxed/simple;
	bh=rEmfRlOQozGVdj6yZy0yv5UqzEh8KtQEnjDDQOJ5NAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bpp8dOCdAKQdxFxIwI0AMXg8twv+GR2EEPkRdEqF7ko/yeqprlZ5sChrHPLOmopGJsTk9AgHbUFI5C1tFBE4/LZ13X5ZkR2HFVaut93H6QDmA6XE0K7wQ2Mo0Rfsl5DADcvE7/3IJZs5eOFp3ayoZ9AcTdMyTC2ImzcyVaQDuEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OEQLV4AZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758175218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Egs9MORsMvaYVbs9QUFPAzXFwITcR+mUkRUBRDXNcgc=;
	b=OEQLV4AZHpVyx/5KMlOnUy58FNs2i93TP9/6zbOMkWuBZ4NLyW2RpxoeuBxBtzZp6wumE8
	GXJlZspfSK6CANtiwGxUFEOgMDtrQMw8kCXZGb6bHVrz02VuG0glrdtzd86tc16zNyKyF4
	E71yQGODi3FKfESXOEPQ/6VPvBL/riA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-n8Xe-Bz2MoWQkbaAqTzL4A-1; Thu, 18 Sep 2025 02:00:16 -0400
X-MC-Unique: n8Xe-Bz2MoWQkbaAqTzL4A-1
X-Mimecast-MFC-AGG-ID: n8Xe-Bz2MoWQkbaAqTzL4A_1758175215
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4612d068c47so2913505e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 23:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758175215; x=1758780015;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Egs9MORsMvaYVbs9QUFPAzXFwITcR+mUkRUBRDXNcgc=;
        b=YbQmn3HS6CP9iQxU3KohWVVy565CpDhDKEub6j/mf60QNF7Z3FTRMuIWC28WlnCsQm
         H3zUl+f/3ReswJCrRyu9ZGMqR0ydRfgVCYdKWZZ+NBcN6kWyM4M6M53aEoyxZ1yTB1gf
         l2uygnYtd46Gg8FlaAmPbYJJksI7WVJHTRb8XkSh5v0A9YFQ6UJekYXJSScJu9esNckH
         K6zq2tEXzBR75U76jRTZi/ep5Df10veULoAPllVaJl81IPrnAayn4T2pYF+SnwARoIQJ
         Gx6xRmwR/PFG8yuezZbqs2maTNICFFDx6xvXFw9GY8JLzbAFmmzqYm/Fjm4JQdHinJd7
         EYFw==
X-Forwarded-Encrypted: i=1; AJvYcCWBO0dc1kDzYXRcUhqkB1ZDAR+V/ujaZ0Ica3CuWV5TIu8yjYmibvxxEdO6p/TuU4P4xnjVDZPhvXHnlwU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7bmHWq0sLwc6Cih0K6wAA25DZ0tTe1mtLBReoiPAaSXfjpzUO
	jy2kJ8Aru91mpNS4K13YI3B20TVi6YJhaOYl4UaNakRlrbzmDetGaCpQjMmEzjtvyVS7o095Y5k
	Viw4GwQ9wR2kTGT9fmEpbqNifJ2zmmEYC+BFQPMYTKaDtSGvRNGTvEb5Fv8z9whxNdQ==
X-Gm-Gg: ASbGncuYPGC4dEuZ0Ht9WdRP3KBPggPgvn7+1HhrB56/v0Pb0dZA5j4p6wByeXLMDbN
	I7DoTrEa7s5GC3c14eLSIBzJ9QQASJVdOZ5toO1tkFuJzJT9WTj7yqSfDkgMdhL6RwMi7OvX8KE
	woMm1rz3vajGEueGveniA9dRusdsNh5vkFkkJJlP7k0no4rPCFLinTE+3285Q4CC/1jLRbP8Nh2
	9fhfaUWuZ8+d/4mdZkH0dwFjn84wD51GPKCpHuhEe92R0vr2N+1FzdiR4/R+E5zMvJMK9+Pg1ZH
	ZVvroprExT4BD1FXwaLHJlMcgXssfAvrJH8JAoDiIhmiy4AlS4c8CnFXF+xMKgVHLgtledVMOw5
	ZVk8wj/6RG+T4cUudNSc9MBqAy06gG+e+mTQvrW0MPXl2CZ7o7T/Zt/YvvoWILMz6woff
X-Received: by 2002:a05:600c:1d0c:b0:458:c059:7db1 with SMTP id 5b1f17b1804b1-46207d632c5mr43159085e9.30.1758175213587;
        Wed, 17 Sep 2025 23:00:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBPDGFO1ZJKbSLPlQU6hrKmvukZl3bWN2+07Z4T7xEVSYJLDlgI5/VEDLbR+swq1LiPRI1Nw==
X-Received: by 2002:a05:600c:1d0c:b0:458:c059:7db1 with SMTP id 5b1f17b1804b1-46207d632c5mr43158595e9.30.1758175212983;
        Wed, 17 Sep 2025 23:00:12 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f07:dd00:ca9c:199e:d2b6:9099? (p200300d82f07dd00ca9c199ed2b69099.dip0.t-ipconnect.de. [2003:d8:2f07:dd00:ca9c:199e:d2b6:9099])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464eadd7e11sm26175745e9.0.2025.09.17.23.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 23:00:12 -0700 (PDT)
Message-ID: <17d1b293-e393-4989-a357-7eea74b3c805@redhat.com>
Date: Thu, 18 Sep 2025 08:00:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm: vmscan: remove folio_test_private() check in
 pageout()
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hannes@cmpxchg.org
Cc: mhocko@kernel.org, zhengqi.arch@bytedance.com, shakeel.butt@linux.dev,
 lorenzo.stoakes@oracle.com, hughd@google.com, willy@infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1758166683.git.baolin.wang@linux.alibaba.com>
 <9ef0e560dc83650bc538eb5dcd1594e112c1369f.1758166683.git.baolin.wang@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <9ef0e560dc83650bc538eb5dcd1594e112c1369f.1758166683.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.09.25 05:46, Baolin Wang wrote:
> The folio_test_private() check in pageout() was introduced by commit
> ce91b575332b ("orphaned pagecache memleak fix") in 2005 (checked from
> a history tree[1]). As the commit message mentioned, it was to address
> the issue where reiserfs pagecache may be truncated while still pinned.
> To further explain, the truncation removes the page->mapping, but the
> page is still listed in the VM queues because it still has buffers.
> 
> In 2008, commit a2b345642f530 ("Fix dirty page accounting leak with ext3
> data=journal") seems to be dealing with a similar issue, where the page
> becomes dirty after truncation, and it provides a very useful call stack:
> truncate_complete_page()
>        cancel_dirty_page() // PG_dirty cleared, decr. dirty pages
>        do_invalidatepage()
>          ext3_invalidatepage()
>            journal_invalidatepage()
>              journal_unmap_buffer()
>                __dispose_buffer()
>                  __journal_unfile_buffer()
>                    __journal_temp_unlink_buffer()
>                      mark_buffer_dirty(); // PG_dirty set, incr. dirty pages
> 
> In this commit a2b345642f530, we forcefully clear the page's dirty flag
> during truncation (in truncate_complete_page()).
> 
> Now it seems this was just a peculiar usage specific to reiserfs. Maybe
> reiserfs had some extra refcount on these pages, which caused them to pass
> the is_page_cache_freeable() check. With the fix provided by commit a2b345642f530
> and reiserfs being removed in 2024 by commit fb6f20ecb121 ("reiserfs: The
> last commit"), such a case is unlikely to occur again. So let's remove the
> redundant folio_test_private() checks and related buffer_head release logic,
> and just leave a warning here to catch such a bug.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   mm/vmscan.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index f1fc36729ddd..930add6d90ab 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -701,16 +701,10 @@ static pageout_t pageout(struct folio *folio, struct address_space *mapping,
>   		return PAGE_KEEP;
>   	if (!mapping) {
>   		/*
> -		 * Some data journaling orphaned folios can have
> -		 * folio->mapping == NULL while being dirty with clean buffers.
> +		 * Is it still possible to have a dirty folio with
> +		 * a NULL mapping? I think not.
>   		 */

I would rephrase slightly (removing the "I think not"):

/*
  * We should no longer have dirty folios with clean buffers and a NULL
  * mapping. However, let's be careful for now.
  */

> -		if (folio_test_private(folio)) {
> -			if (try_to_free_buffers(folio)) {
> -				folio_clear_dirty(folio);
> -				pr_info("%s: orphaned folio\n", __func__);
> -				return PAGE_CLEAN;
> -			}
> -		}
> +		VM_WARN_ON_FOLIO(true, folio);
>   		return PAGE_KEEP;
>   	}
>   


-- 
Cheers

David / dhildenb


