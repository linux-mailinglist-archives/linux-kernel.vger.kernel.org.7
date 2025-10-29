Return-Path: <linux-kernel+bounces-876433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 361D2C1BAF8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EDA86623FB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572382FDC27;
	Wed, 29 Oct 2025 14:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bq8thsgs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D162ED154
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749204; cv=none; b=ceYn1WaWUJ9FIjKSN6WRDQGXACPVZW6LI6QY9OlJI/vmFYfSsGQHmvvaHb7VOlqZs7Hvpsuj0xX6vATEhm7kCiOiRmh1g+r2CAWsSyaKTP0ZIUylFVTlrNCYQCs72b4qEz/6OZ3We3H0LddP88ALBPAvPhVhHwJITU/3KVdWrU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749204; c=relaxed/simple;
	bh=DD+sZiouvTID3392fr16RJVprknX/BYaWrmFASy9p2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QtSi1xKtOWYUiWDdRrC3nRBj6LDefIPNpYwyrzRIzAcBbb3oTucSYe6cDZTAejeg/R3FW1x1Gz1fvbZ45q40FeN5fIUizwkeN4qkVEsU0IHn84Bi9Hp/iBZ9AR1VbZJalEANPO3K0POEIZHeFz1yWuFosryfnmGcg6uMOIoWDss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bq8thsgs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761749201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0UMaue7ZWsmO4c8GIY3dOOqsOMrx53MQtm1wLx6Olz8=;
	b=bq8thsgsmnu4XRurAabf5cT94c+I7o6ez6do5Z5uLDGIh3Dn5H8nKjedtbf1Oc+mlGGPXH
	+3diZLamTpIc5GnreI+/Buqckql1Dt7EPQihhvgK4dNfXOlHF+YEXrSCzaHvV6zOwAFGEY
	yKVZfMrXZAu5Orf7n+VjWP1qzE757rE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-KnfxETGGPhG2U2h4bDyOLg-1; Wed, 29 Oct 2025 10:46:39 -0400
X-MC-Unique: KnfxETGGPhG2U2h4bDyOLg-1
X-Mimecast-MFC-AGG-ID: KnfxETGGPhG2U2h4bDyOLg_1761749198
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-471001b980eso47069075e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761749198; x=1762353998;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0UMaue7ZWsmO4c8GIY3dOOqsOMrx53MQtm1wLx6Olz8=;
        b=qtm0aY4/fedyyhvHYXSY6semOfs2P1X72BHAD2dTm9BNNwYqr7ui+5IYHw14hAJwzT
         p3eq5uRAMBsh+pbR1vO42ku+/yzbxrVe1Ngut35bETeTWFGOn/wryY4SGh78cpA+IVUC
         5/ad3mqsFnclXWwoVoSzHpoyNlStr4Z0vxLCYbAoZnoWiMcuPsbdWqfut6FOolh6tS3I
         eexxrTmYBIVE/bUeExpBBee7GZP+KY2BaD4afmXqRXZXw7uj8E00e3PbDXvv5y/8lwSP
         H2ioSuuNt/SvyiIeI/6mncCHj8qlKgPgvFHM6pufxlYZN7hXG9EI5STT93DWjrFQ5EKl
         ZdMA==
X-Forwarded-Encrypted: i=1; AJvYcCXJCPv/hKPU8hvQw06M12YoUYlO5jgLl7j+rreQi/QKamyVqDQyTT3rs1q1JJVUiA90je8lL1WOFX8dReE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYi4WF2BpLsTjL2H/nGF5Xuwo7t/eJcuimZnNIdPlj2CBp86bz
	EMXLEoGhyVsvp4mECatMl3wrJmV2BUzy6VR+/aX+/Ol9nKP329iiLsNGep76pCLClilEIzlxLlJ
	OieBPm2FofEJfFCs0992dG/SucwF1F5IdimHFWZTEi+Mp3e0Buqap7sKgoInXU4CPfA==
X-Gm-Gg: ASbGncu4B1z8pMfM/47KTGR5gM3kRBs3meNRP8DTHxJHCq9KnFRFHhV0i5KzWNSTCIg
	5jqt3qPe2NlbHo0mvSs3jR7nUV9QGe0+AaLwh5Qs6lwbZ0WkmQyPja1/zb+aqlz2PutEPqTOUSJ
	plty0hXvxDHTejkzBLN19Rlpw11pkFadxRTLe/3ewKkGOjbjO4JwSDzg+6bePj4nKXX/8RKLs5N
	wUvJOOvcEN/LDpx22d2Eg+ZPCEX7N4LfRb1O+g/4VK/62iJEKMaR1XwPrXOaJy5GlW0IBllY36X
	Fmqm92VDP8Lm+zDax0CQswJvDfY/IiQ1tMGiefxzzwALYlvk7Po84nUajh1hYbblb1rZX80sYLt
	+R5CJ1ox8ff8PsSpbNpilvA==
X-Received: by 2002:a05:600c:310f:b0:475:daba:d03c with SMTP id 5b1f17b1804b1-4771e3339c3mr25597095e9.13.1761749197884;
        Wed, 29 Oct 2025 07:46:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHC/uqBFlcpoKMKVxXecJEcdSWvlKWsvzAMYUZrCn2DWBPHz0hPHUqc+lQGAFumQQDc8STQhQ==
X-Received: by 2002:a05:600c:310f:b0:475:daba:d03c with SMTP id 5b1f17b1804b1-4771e3339c3mr25596875e9.13.1761749197361;
        Wed, 29 Oct 2025 07:46:37 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e12cb2asm52407195e9.0.2025.10.29.07.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 07:46:36 -0700 (PDT)
Message-ID: <bf832253-0052-4ab2-b664-33bec3837c23@redhat.com>
Date: Wed, 29 Oct 2025 15:46:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ksm: replace function unmerge_ksm_pages with
 break_ksm
To: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251028131945.26445-1-pedrodemargomes@gmail.com>
 <20251028131945.26445-4-pedrodemargomes@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251028131945.26445-4-pedrodemargomes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.10.25 14:19, Pedro Demarchi Gomes wrote:
> Function unmerge_ksm_pages() is unnecessary since now break_ksm() walks
> an address range. So replace it with break_ksm().
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
> ---
>   mm/ksm.c | 39 ++++++++++++++++-----------------------
>   1 file changed, 16 insertions(+), 23 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 1d1ef0554c7c..18c9e3bda285 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -669,6 +669,18 @@ static const struct mm_walk_ops break_ksm_lock_vma_ops = {
>   };
>   
>   /*
> + * Though it's very tempting to unmerge rmap_items from stable tree rather
> + * than check every pte of a given vma, the locking doesn't quite work for
> + * that - an rmap_item is assigned to the stable tree after inserting ksm
> + * page and upping mmap_lock.  Nor does it fit with the way we skip dup'ing
> + * rmap_items from parent to child at fork time (so as not to waste time
> + * if exit comes before the next scan reaches it).
> + *
> + * Similarly, although we'd like to remove rmap_items (so updating counts
> + * and freeing memory) when unmerging an area, it's easier to leave that
> + * to the next pass of ksmd - consider, for example, how ksmd might be
> + * in cmp_and_merge_page on one of the rmap_items we would be removing.
> + *
>    * We use break_ksm to break COW on a ksm page by triggering unsharing,
>    * such that the ksm page will get replaced by an exclusive anonymous page.
>    *
> @@ -1077,25 +1089,6 @@ static void remove_trailing_rmap_items(struct ksm_rmap_item **rmap_list)
>   	}
>   }
>   
> -/*
> - * Though it's very tempting to unmerge rmap_items from stable tree rather
> - * than check every pte of a given vma, the locking doesn't quite work for
> - * that - an rmap_item is assigned to the stable tree after inserting ksm
> - * page and upping mmap_lock.  Nor does it fit with the way we skip dup'ing
> - * rmap_items from parent to child at fork time (so as not to waste time
> - * if exit comes before the next scan reaches it).
> - *
> - * Similarly, although we'd like to remove rmap_items (so updating counts
> - * and freeing memory) when unmerging an area, it's easier to leave that
> - * to the next pass of ksmd - consider, for example, how ksmd might be
> - * in cmp_and_merge_page on one of the rmap_items we would be removing.
> - */
> -static int unmerge_ksm_pages(struct vm_area_struct *vma,
> -			     unsigned long start, unsigned long end, bool lock_vma)
> -{
> -	return break_ksm(vma, start, end, lock_vma);
> -}
> -
>   static inline
>   struct ksm_stable_node *folio_stable_node(const struct folio *folio)
>   {
> @@ -1233,7 +1226,7 @@ static int unmerge_and_remove_all_rmap_items(void)
>   		for_each_vma(vmi, vma) {
>   			if (!(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
>   				continue;
> -			err = unmerge_ksm_pages(vma,
> +			err = break_ksm(vma,
>   						vma->vm_start, vma->vm_end, false);

Move that all into a single line.


With that

Acked-by: David Hildenbrand <david@redhat.com>

Thanks for tackling this!

-- 
Cheers

David / dhildenb


