Return-Path: <linux-kernel+bounces-743901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 577B0B10525
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0816172545
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69F926158B;
	Thu, 24 Jul 2025 08:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BeV3Itep"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC94F2F30
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753347566; cv=none; b=nyaOdZ/r+v8XoLfNlXtiU0MGsK+Ob8nUPRhz6DSvAxzR/YRVAKpCE7QPa5FcHi3rph7h4F9BK1PQl3KXJxCe9gh8GNszsSE0p6MBJJDaUEIJ9qPBw/xhm4bcmg9+rDJlGdLTPEFqS/jc8twM+onuFYIbSOOIawh8x6V2sfsz/ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753347566; c=relaxed/simple;
	bh=S0AN7MOXHovsrn4d1TKyBPde2GjKNxCwOLdL3+XFFV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=M7ogecixCSn1nyBudWFejNH7oPT23WzdaKRBeo4JqUnOgGoxDRbrFvC70OQXcg7q8lCBuh+qeUtlOoHr1BwB/EA1nuc4X3ajs1MavNLOQ9/Wq+7rwkBJEAr/IIsDY0WB8gJ7cOGLaQ+SHXRZjbGQ07WaYDrJNwqyTrxG8A8DzOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BeV3Itep; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753347563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KbAjULp57DFaxZp4EhQSXlWNY4PHov8q7LM6Z5vJA/c=;
	b=BeV3ItepQKjMqK9WmJZU0Ywm/c/lwdm2FtV3SRYpeIxlSQxypiYdAj0X9D9c9Oipu7oaBM
	Dr6NhkbnXdbEIy/Hi6KROvtRsf880EJ+4FxIRFpM0vfICguGGHgA06gAcf2zDb50Y7WxXZ
	Nb/YQvHWjbAbvyM3G2s5n4wbk8bTYgk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-JVyiX-49MMOzWh4kmQmaow-1; Thu, 24 Jul 2025 04:59:22 -0400
X-MC-Unique: JVyiX-49MMOzWh4kmQmaow-1
X-Mimecast-MFC-AGG-ID: JVyiX-49MMOzWh4kmQmaow_1753347561
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-458709feac7so2698175e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 01:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753347561; x=1753952361;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KbAjULp57DFaxZp4EhQSXlWNY4PHov8q7LM6Z5vJA/c=;
        b=CeB9buqzf70qM3KuPDHNlX8oGN5/iyWWhQ3bK9q52bkpj3jO0hOg3Lw1NoiFsDIaFM
         YM9ml/xrLERMCScpD131YYknWWyZcdaVcG1WMd8U97yhc5CD39o65DY88qgmF8bPRfj7
         Z5jm5Gxj3OVv18FIDacAOnxP+I0OHmaOnNYG5q20W06eWi1ELpr516oUCjssMCcktc7H
         mceC3co80/c6nxXb5zMyRYz5h/ioEGhUY62FEv9s1hw/IO8axUpLBEyjlREuq9npUL7V
         6AQzTn8C1Idf2QRePI/4Y9pooTkrm4M5OQ9LV1wL3J7qSoSogqsoakapoBUkjxZzNxvA
         pRvw==
X-Forwarded-Encrypted: i=1; AJvYcCUsTBcxgJylCz1nflnBuVpUCYvWb1Qh0mOQPp0jDIDoQ2wVzqx5xUZ3kNnQ+SVo0AeMoSIkyZy5u9Lz9Dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUMWgeKc3ZiTDpOtpcd8zA651W4MLxxTqzLpv8ysLltc8bJwzG
	xaHtJE4yH6aCi1x+qXWS7Jq6eZr3nrXRMATGQe6DhPGIQBnGgvJ4g76ZDqaf5V8+9Wj9gm4t3Nl
	c3hMbDXFaZHBMDbVNIvoaLL3HS4dNsybkfPm6f/WNC4jLsJBTGdbuRW6FCOkZIb7xCQ==
X-Gm-Gg: ASbGncsUs3oq2D8pk3aukvJsTOyzzkVmVzJlvMcxRtZIVbJC0+9W92Xtd5LX2MWvs45
	ShgKCmnlpUvRsMxj9I47KyqrZsHNRdjH5/nCYTbHD4Ul0jhzzvxkoS5rSedPNiTQffepA6y4oeb
	zNrhhgrzsT6xOQoqmIOfUw/Iscd8iHRz2FtSAhTuK5vwHxmNPb9aG4lqG4Svajmq9MY7eQES1r1
	5TG5GXxYNDuCv0RPusR8W1PykEU/kMibd9G4rsdQ5JQXNElT6qwTxhX2Osk6jMQ/vSteykZ+2iw
	IDQgcKVqnqoA111oDI1lGJ1JtDHZo1FZy1TxOiSpl3rCdBOns9oguURNJVaQxRhIo3NcIfm7RYp
	g+u4m8U2ypnfp4zhAnb1GfCmHT7YT6gA89B488BwIr3C5NN6HdCV6GbeFJ+UPaydM
X-Received: by 2002:a05:600c:34c8:b0:456:2a9:f815 with SMTP id 5b1f17b1804b1-4586e529e4bmr24857985e9.4.1753347560648;
        Thu, 24 Jul 2025 01:59:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFi5+e8h65j8G/90Yb5xypCSe09/IV+5bnm/weBgPN3KMsU7GCZlI1Y32G5GAm3Vnqmz43nw==
X-Received: by 2002:a05:600c:34c8:b0:456:2a9:f815 with SMTP id 5b1f17b1804b1-4586e529e4bmr24857545e9.4.1753347560062;
        Thu, 24 Jul 2025 01:59:20 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:5e00:c941:d6fb:3e30:b42? (p200300d82f1f5e00c941d6fb3e300b42.dip0.t-ipconnect.de. [2003:d8:2f1f:5e00:c941:d6fb:3e30:b42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705684a8sm11879845e9.26.2025.07.24.01.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 01:59:19 -0700 (PDT)
Message-ID: <86516155-f2d9-4e8d-9d27-bdcb59e2d129@redhat.com>
Date: Thu, 24 Jul 2025 10:59:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/9] introduce PGTY_mgt_entry page_type
To: Huan Yang <link@vivo.com>, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Rik van Riel
 <riel@surriel.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Christian Brauner <brauner@kernel.org>, Usama Arif <usamaarif642@gmail.com>,
 Yu Zhao <yuzhao@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250724084441.380404-1-link@vivo.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250724084441.380404-1-link@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24.07.25 10:44, Huan Yang wrote:
> Summary
> ==
> This patchset reuses page_type to store migrate entry count during the
> period from migrate entry setup to removal, enabling accelerated VMA
> traversal when removing migrate entries, following a similar principle to
> early termination when folio is unmapped in try_to_migrate.

I absolutely detest (ab)using page types for that, so no from my side 
unless I am missing something important.

> 
> In my self-constructed test scenario, the migration time can be reduced

How relevant is that in practice?

> from over 150+ms to around 30+ms, achieving nearly a 70% performance
> improvement. Additionally, the flame graph shows that the proportion of
> remove_migration_ptes can be reduced from 80%+ to 60%+.
> 
> Notice: migrate entry specifically refers to migrate PTE entry, as large
> folio are not supported page type and 0 mapcount reuse.
> 
> Principle
> ==
> When a page removes all PTEs in try_to_migrate and sets up a migrate PTE
> entry, we can determine whether the traversal of remaining VMAs can be
> terminated early by checking if mapcount is zero. This optimization
> helps improve performance during migration.
> 
> However, when removing migrate PTE entries and setting up PTEs for the
> destination folio in remove_migration_ptes, there is no such information
> available to assist in deciding whether the traversal of remaining VMAs
> can be ended early. Therefore, it is necessary to traversal all VMAs
> associated with this folio.

Yes, we don't know how many migration entries are still pointing at the 
page.

> 
> In reality, when a folio is fully unmapped and before all migrate PTE
> entries are removed, the mapcount will always be zero. Since page_type
> and mapcount share a union, and referring to folio_mapcount, we can
> reuse page_type to record the number of migrate PTE entries of the
> current folio in the system as long as it's not a large folio. This
> reuse does not affect calls to folio_mapcount, which will always return
> zero.
 > > Therefore, we can set the folio's page_type to PGTY_mgt_entry when
> try_to_migrate completes, the folio is already unmapped, and it's not a
> large folio. The remaining 24 bits can then be used to record the number
> of migrate PTE entries generated by try_to_migrate.

In the future the page type will no longer overlay the mapcount and, 
consequently, be sticky.

> 
> Then, in remove_migration_ptes, when the nr_mgt_entry count drops to
> zero, we can terminate the VMA traversal early.
> 
> It's important to note that we need to initialize the folio's page_type
> to PGTY_mgt_entry and set the migrate entry count only while holding the
> rmap walk lock.This is because during the lock period, we can prevent
> new VMA fork (which would increase migrate entries) and VMA unmap
> (which would decrease migrate entries).

The more I read about PGTY_mgt_entry, the more I hate it.

> 
> However, I doubt there is actually an additional critical section here, for
> example anon:
> 
> Process Parent                          fork
> try_to_migrate
>                                          anon_vma_clone
>                                              write_lock
>                                                  avc_inster_tree tail
>                                          ....
>      folio_lock_anon_vma_read             copy_pte_range
>          vma_iter                            pte_lock
>                  ....                           pte_present copy
>                                              ...
>                  pte_lock
>                      new forked pte clean
> ....
> remove_migration_ptes
>      rmap_walk_anon_lock
> 
> If my understanding is correct and such a critical section exists, it
> shouldn't cause any issues—newly added PTEs can still be properly
> removed and converted into migrate entries.
> 
> But in this:
> 
> Process Parent                          fork
> try_to_migrate
>                                          anon_vma_clone
>                                              write_lock
>                                                  avc_inster_tree
>                                          ....
>      folio_lock_anon_vma_read             copy_pte_range
>          vma_iter
>                  pte_lock
>                      migrate entry set
>                  ....                        pte_lock
>                                                  pte_nonpresent copy
>                                              ....
> ....
> remove_migration_ptes
>      rmap_walk_anon_lock

Just a note: migration entries also apply to non-anon folios.

-- 
Cheers,

David / dhildenb


