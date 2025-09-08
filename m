Return-Path: <linux-kernel+bounces-805963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13171B49008
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 134DD7AD40F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E432630C627;
	Mon,  8 Sep 2025 13:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BY8EM177"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE2330BBB8
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 13:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757339121; cv=none; b=YBmbcPUY8/KrCkLYTZ6OLzRMRBF0hj7KvoZVNA1H2N/Q1ykm6sxgbQF6oUuDZvZtCiNQeAE204LqqZVvJtJQYU2v04gxZd0py4xlvNqUzGW5hoDEf7XMw1IOmcc384g8TNNE/FOFUYW7p+nmiiLwqJoyrENJ/3C1+9CvNgZtzHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757339121; c=relaxed/simple;
	bh=JZmaN1GxhrpXNrBLLCLRQ6TokZ5xt3IzZv7KrbPkprg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MwEH0tiUcyLpNZUP7n8Jf9CxgP8tDsWwQSC4Az005KcyOjMvM1HHyKUIQsogx83iT9lTDjLMXY6J3zVXZIvUEPmCgjy1dpUES/kynVmvqhFv17swIMXUHssAVCLEieCRh3UyrTSeqpWrDdoDE4GCRG6o3urNL0aT8rq7bmnvWzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BY8EM177; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757339117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qLmwvDeh3uTocNuEY2RTW0+ExLFf6n+kGxhdcdtUOtY=;
	b=BY8EM177P9rh86BQspn+LPmIYm9BpaHc0v3AbBTsnUsGoTGB0Dp36eDtPca9MO2A7nr+nc
	el6xbR/JXnd7SyZNXKgImoOG469Am58iuEbVxfpqsv7DmzPPsEZg7pBtus1LR+yDCDAgl5
	/l1rXWjeCt4aEdURRUjuHdJsPs+Cvrc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-KPQWTJcrMsGJql5S4OuopA-1; Mon, 08 Sep 2025 09:45:16 -0400
X-MC-Unique: KPQWTJcrMsGJql5S4OuopA-1
X-Mimecast-MFC-AGG-ID: KPQWTJcrMsGJql5S4OuopA_1757339115
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45ceeae0513so24858705e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 06:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757339115; x=1757943915;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qLmwvDeh3uTocNuEY2RTW0+ExLFf6n+kGxhdcdtUOtY=;
        b=nag8QwL2BR1zrk2gVELVCN/4/FTTq/6ZyVxrE1lSSoJnQSpCfQ6IWYKOWSTC+4s1+B
         iFrirXJ6nm1Ebb/gUnDRqkXSW5jb1pDanb3wiPfu75L9VzD5CZfHm987oKVY6dVKz2aC
         c4lxip2OGcu1xnV1LN0syVtRhHB6Ak9WFWlNi9rmhRLqDh3wOKoqTjesvgjNKrh+tzie
         xqyft8EfIz5l4jul3rCWtVBM0421eMK467V03jBpfWE3fZz0IR+AWbIJzgf62x7U6L+v
         96KRp3FnhAJmRaOBoRQIksktCPMUGjIAq+sJJRmoyVX3RrtgAVsrxjHmWW9KciU8PNBC
         PEFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/fbICT320uC2dgUHnG2oyjdG4/G2EQ8z/irMYKcAZT8820tMory0YmAa8b/rCjyW6jaA5bUQzlZDUVkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFb6u9f0JkpqNoEBgtlrHR/hwknPK5y0+nTl0dC9+gWnJnsYps
	Dbb9WdfuZHz5gXDX+9AuFOyHLAx2uhGDf8wxrdCcOj7OLW263ovtLDUGZeQznEJHn+VEq7jPNV7
	lLqkR3YwcV1UsnqxOII7HcpTcg85mx0sHLG9nGynFqP6GUGfQ3Epe7YPcS17iPd00xw==
X-Gm-Gg: ASbGncv1mWJY8YyakFxFhpR4vb9Az/Av+U4i4FiG0ynMfQDUxYh9SsAoVUV1KS34X8Z
	D65uVyVzTnRqtZVS5RniJ4pAcmFC/dOSBVYREh0gAqjz7XuP9O8m4x+E53Xg71R8iJZvqgH0mTl
	Jcm+XoY14QRlGItHbz7pWTbabMjZzb92ZfSKhT+TBHPcUsyyi3gacq3Yyhh4Nnu+vi4Z2c7cVWV
	W0VqMk9MYEPFsPimvZc+YANnWITee49udj5VFJpn+bLFEnMzBfpfwmZr0FDFc5gSPca/HBEFP9T
	VY5jAKAUafp2JTumm/8TBauMMoC2wuUKvkzumzMa9WDS7zUih/DoXRhE+DigU/bLmHv9X88M0De
	YiYSv4RkO4HsqhcC2avFIoNm5svxffKLY+Kaqy7ZSoe7Ig4Hjt7xQgAx9alAp5KzR
X-Received: by 2002:a05:6000:2f87:b0:3e3:921b:659f with SMTP id ffacd0b85a97d-3e641d46423mr5873101f8f.2.1757339114578;
        Mon, 08 Sep 2025 06:45:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBBGiwyzzjCzHwLoe0afie78c2i5NLd9se8NpB6lEvYgLnJlyiOeCh7rskc1RvoSZRj+HaIQ==
X-Received: by 2002:a05:6000:2f87:b0:3e3:921b:659f with SMTP id ffacd0b85a97d-3e641d46423mr5873074f8f.2.1757339114038;
        Mon, 08 Sep 2025 06:45:14 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:700:d846:15f3:6ca0:8029? (p200300d82f250700d84615f36ca08029.dip0.t-ipconnect.de. [2003:d8:2f25:700:d846:15f3:6ca0:8029])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e552618813sm9859106f8f.41.2025.09.08.06.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 06:45:13 -0700 (PDT)
Message-ID: <4e0847db-0503-406b-95b4-02ee7e8f9604@redhat.com>
Date: Mon, 8 Sep 2025 15:45:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/15] mm, swap: use the swap table for the swap cache
 and switch API
To: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
 Chris Li <chrisl@kernel.org>, Barry Song <baohua@kernel.org>,
 Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 linux-kernel@vger.kernel.org
References: <20250905191357.78298-1-ryncsn@gmail.com>
 <20250905191357.78298-12-ryncsn@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250905191357.78298-12-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> +static inline struct swap_cluster_info *swap_cluster_lock(
> +	struct swap_info_struct *si, pgoff_t offset, bool irq)
> +{
> +	return NULL;
> +}
> +
> +static inline struct swap_cluster_info *swap_cluster_lock_by_folio(
> +		struct folio *folio)

I would probably call that "swap_cluster_get_and_lock" or sth like that ...

> +{
> +	return NULL;
> +}
> +
> +static inline struct swap_cluster_info *swap_cluster_lock_by_folio_irq(
> +		struct folio *folio)
> +{

... then this would become "swap_cluster_get_and_lock_irq"


Alterantively, separate the lookup from the locking of the cluster.

swap_cluster_from_folio() / folio_get_swap_cluster()
swap_cluster_lock()
swap_cluster_lock_irq()

Which might look cleaner in the end.

[...]

> -struct address_space *swapper_spaces[MAX_SWAPFILES] __read_mostly;
> -static unsigned int nr_swapper_spaces[MAX_SWAPFILES] __read_mostly;
> +struct address_space swap_space __read_mostly = {
> +	.a_ops = &swap_aops,
> +};
> +
>   static bool enable_vma_readahead __read_mostly = true;
>   
>   #define SWAP_RA_ORDER_CEILING	5
> @@ -83,11 +86,21 @@ void show_swap_cache_info(void)
>    */
>   struct folio *swap_cache_get_folio(swp_entry_t entry)
>   {
> -	struct folio *folio = filemap_get_folio(swap_address_space(entry),
> -						swap_cache_index(entry));
> -	if (IS_ERR(folio))
> -		return NULL;
> -	return folio;
> +

^ superfluous empty line.

[...]

>   
> @@ -420,6 +421,34 @@ static inline unsigned int cluster_offset(struct swap_info_struct *si,
>   	return cluster_index(si, ci) * SWAPFILE_CLUSTER;
>   }
>   
> +static int swap_table_alloc_table(struct swap_cluster_info *ci)

swap_cluster_alloc_table ?

> +{
> +	WARN_ON(ci->table);
> +	ci->table = kzalloc(sizeof(unsigned long) * SWAPFILE_CLUSTER, GFP_KERNEL);
> +	if (!ci->table)
> +		return -ENOMEM;
> +	return 0;
> +}
> +
> +static void swap_cluster_free_table(struct swap_cluster_info *ci)
> +{
> +	unsigned int ci_off;
> +	unsigned long swp_tb;
> +
> +	if (!ci->table)
> +		return;
> +
> +	for (ci_off = 0; ci_off < SWAPFILE_CLUSTER; ci_off++) {
> +		swp_tb = __swap_table_get(ci, ci_off);
> +		if (!swp_tb_is_null(swp_tb))
> +			pr_err_once("swap: unclean swap space on swapoff: 0x%lx",
> +				    swp_tb);
> +	}
> +
> +	kfree(ci->table);
> +	ci->table = NULL;
> +}
> +
>   static void move_cluster(struct swap_info_struct *si,
>   			 struct swap_cluster_info *ci, struct list_head *list,
>   			 enum swap_cluster_flags new_flags)
> @@ -702,6 +731,26 @@ static bool cluster_scan_range(struct swap_info_struct *si,
>   	return true;
>   }
>   
> +/*
> + * Currently, the swap table is not used for count tracking, just
> + * do a sanity check here to ensure nothing leaked, so the swap
> + * table should be empty upon freeing.
> + */
> +static void cluster_table_check(struct swap_cluster_info *ci,
> +				unsigned int start, unsigned int nr)

"swap_cluster_assert_table_empty()"

or sth like that that makes it clearer what you are checking for.

-- 
Cheers

David / dhildenb


