Return-Path: <linux-kernel+bounces-830501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 265E8B99DA9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A9341B22512
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0972FC874;
	Wed, 24 Sep 2025 12:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Da6g8gOF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB872E54CC
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758717127; cv=none; b=eJ7+kj1Em/Jkc1VAwgtfRi2eEp1sb708KKjxlrHuDSeGNgC4NmyoNRDNOqeomrCDPmp3E7vHBJ7TwSx0BdBmoEBDIgbwRELWek3fC8NAbzUIHXyacm2u8CsRl9HH/48oWXrqAdvyBNK1DnY5drCcOEYyKCrrQ1L0TdaRJUXbKFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758717127; c=relaxed/simple;
	bh=js2sHpYVDrr0Y+XC6UmB3w4YeX8YuwGvBqk7QBsgQk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AC7slGaru82Y6JlbKs/H3FP7KJ716FwDbbpUpqj1h+HB3TPUwFHyX/HMWuBcDQWhsPUrUYBd2fmmiGVBpaWatQjniv8Fj1D5ceSz40LfD15nQ0m3ti3S5S22uc27P6unAYvIZG2qz2zISWbSebD2j48W0opvF7wFdDHMLW3a1E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Da6g8gOF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758717125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nxDPC3N2WqjlWNs99FhY5LFBBOFWE7WmpuWkOT+s240=;
	b=Da6g8gOFnqX/R4XO+GtOrZIn/EesdX0L/tTuX4kF7bVN3IPjMbGaAdbyrEXbIFjoJF6ff9
	dT3ZfeMSCLq+ObokUxfryrsiESmE+fiCBqLZNPBFfLVgdINYdlC/WSG2jYt6lS8aE/sgPO
	F2D8kc+wziXYfFKdCwBPPtH2mdGlP4g=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-m6Bp6i2OOEKnx4afo4Iz0w-1; Wed, 24 Sep 2025 08:32:03 -0400
X-MC-Unique: m6Bp6i2OOEKnx4afo4Iz0w-1
X-Mimecast-MFC-AGG-ID: m6Bp6i2OOEKnx4afo4Iz0w_1758717123
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8544316ef6aso464490685a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758717123; x=1759321923;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nxDPC3N2WqjlWNs99FhY5LFBBOFWE7WmpuWkOT+s240=;
        b=Ceh/6HXo1MfbW71MBefKrD2Ba2sHQnUkH8CuGFI3KtV2Ktf0Ew8SFDsAz2zna7GQS0
         /QP5I1/aLyxwlghPS7Y6vbI9mzyfz4XWhSJhhdnOxTlRZZF2WceBOEF2TU4lGQS9oFoW
         jhBUpmaVblAWa/phUBZj6aP55lPvJctAf6Hsi4xaSly/cGubsvNGPr/C93m1gHQGgEGf
         CK2XoMvGQrwvdBQsanUt0+b40meDus0uyUbCb7YyS7kb91tevzD0uxpMbYpNGjqMriDb
         5yeyOFjnJvE/CLAfdS8creVsksX4sYYXDkLUXqAGf38mRoj7WtAwCyOdB78/EvnovuQ4
         CqAw==
X-Forwarded-Encrypted: i=1; AJvYcCXBk2seu847N4aOLdmQiJPgCAOzicuQySId+frmpXQ4xc9VdvaGCf5cCPYlA83jhGtIYWtTu90Qnk64pyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAytQsrf17az+PEJ1v14mL9GHZq1M73VckjywlZQ1y0V7Umvrf
	T9P3bcAsYIGetkBJH6UfqmXPZTCo0KKofXQ8y51QJzkVDutAj/xvxCVt1FrttRwmpl2AkicL9Jw
	jAN1uCMV3GoNXqMSPuUNUTKo/8Bbt+TpSdkm7Y0463n6CWTHLYJG1rkjTghOTUWe7yA==
X-Gm-Gg: ASbGncvJJcjbjB1OItzKe62C3TL4UsUxNE8tF/8BzpWt/G4vKrR5wVCRpa3k35+UKmi
	FvGfgm8leLtq7NoRuYyv/hk7cyMt4qzsM1fUHStu13l6GDaP7WLN1lzSTZUqU5XM6VH7A2Xnx5l
	Tr6n3ysFA4Nra2DjKayxAATe+tbd4T9tapVZKRv+iB4Z0JSRy/YYfOW1XfDxN19fmrTe+HfQWfn
	UVQvS5CQbKTFXP5Ap+zuJcm019GNaJ6bufDOXQfha1y/7OhRVDh0xzaFRC3orKzpf1tD8nsva5c
	WBJum4IFcNR7LYt3HpsSpthRVVyrvaZ0mI8pEAE0ZRmpil/BNwISAnSihmoj26XN8SOTtYdXz4J
	QD/zsvIGRMjZhsqY4/b4PyiZ+viCV7BUUKC8FXBPVxZQhzDAs6emlaCdiIvz1UGSGTQ==
X-Received: by 2002:a05:620a:319b:b0:84a:568:b7d3 with SMTP id af79cd13be357-8517370024bmr640303585a.74.1758717122870;
        Wed, 24 Sep 2025 05:32:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGU15mmr+4FrFEuvbHzmbfHN1dEwcBROdLoWHPYj5RplChD/U2Nd74SiOjXAk6SjarpxJnJ8Q==
X-Received: by 2002:a05:620a:319b:b0:84a:568:b7d3 with SMTP id af79cd13be357-8517370024bmr640299285a.74.1758717122380;
        Wed, 24 Sep 2025 05:32:02 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f14:2400:afc:9797:137c:a25b? (p200300d82f1424000afc9797137ca25b.dip0.t-ipconnect.de. [2003:d8:2f14:2400:afc:9797:137c:a25b])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4cc0b7734d8sm45780151cf.53.2025.09.24.05.31.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 05:32:01 -0700 (PDT)
Message-ID: <3ffda308-1210-4760-bac0-ba5b019c0e2a@redhat.com>
Date: Wed, 24 Sep 2025 14:31:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] mm: thp: use folio_batch to handle THP splitting
 in deferred_split_scan()
To: Qi Zheng <zhengqi.arch@bytedance.com>, hannes@cmpxchg.org,
 hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, lorenzo.stoakes@oracle.com,
 ziy@nvidia.com, harry.yoo@oracle.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
 akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>
References: <cover.1758618527.git.zhengqi.arch@bytedance.com>
 <782da2d3eca63d9bf152c58c6733c4e16b06b740.1758618527.git.zhengqi.arch@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <782da2d3eca63d9bf152c58c6733c4e16b06b740.1758618527.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.09.25 11:16, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> The maintenance of the folio->_deferred_list is intricate because it's
> reused in a local list.
> 
> Here are some peculiarities:
> 
>     1) When a folio is removed from its split queue and added to a local
>        on-stack list in deferred_split_scan(), the ->split_queue_len isn't
>        updated, leading to an inconsistency between it and the actual
>        number of folios in the split queue.
> 
>     2) When the folio is split via split_folio() later, it's removed from
>        the local list while holding the split queue lock. At this time,
>        this lock protects the local list, not the split queue.
> 
>     3) To handle the race condition with a third-party freeing or migrating
>        the preceding folio, we must ensure there's always one safe (with
>        raised refcount) folio before by delaying its folio_put(). More
>        details can be found in commit e66f3185fa04 ("mm/thp: fix deferred
>        split queue not partially_mapped"). It's rather tricky.
> 
> We can use the folio_batch infrastructure to handle this clearly. In this
> case, ->split_queue_len will be consistent with the real number of folios
> in the split queue. If list_empty(&folio->_deferred_list) returns false,
> it's clear the folio must be in its split queue (not in a local list
> anymore).
> 
> In the future, we will reparent LRU folios during memcg offline to
> eliminate dying memory cgroups, which requires reparenting the split queue
> to its parent first. So this patch prepares for using
> folio_split_queue_lock_irqsave() as the memcg may change then.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---

Nothing jumped at me

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


