Return-Path: <linux-kernel+bounces-773081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C43B29B3C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F356D3B8EBA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 07:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B96286D49;
	Mon, 18 Aug 2025 07:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jz27f/BX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327FD1D61AA
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755503378; cv=none; b=W37edmxy2N1hIKKuAXBN0FlbsJUULxM1zEmIY4AIVWAzY4e/BkDWK1IuuIXlwNqnIFyCV4Iq7Z4YSZ02EeMo+ENzIfoQfV/w0uFXeTrd/kavGhH1z83RUpDhJgP5MDE3DOmo3WLvFOMwMvhqz8XDVQfWoiSa8MXPgLRZNNeVclA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755503378; c=relaxed/simple;
	bh=6996Xkme/svbIVv2Pa0E5WniIv8pv/8ScsaAB7vtzsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PngiQiW105yqO/GDdhelX8uSQ72S8gZ8BVMQeT7EDVUl47TFJ/iHT9nSrvixk6xEtnKcJLRdMcPUwNSvsFQwCH9P3WdYa5has/Ivm6mjLtDAdGXWBsmAf8EurmNsgwkgN/o03bx0Bai0bsFka5yBTNWBQibh+FVaGnfSM2R+YW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jz27f/BX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755503376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JvG7aFZ8aE0+JNevCZ82bDuwuz+Fa5f4Y7h7OdT1St0=;
	b=Jz27f/BXvSmjwQoo6THFnupfSOUkjJm0pngpmKNuer6V//97hYpzZRD3b7Moa2bO6g2DTc
	E/uGnd5D2DsmMwWyZcldF9wUePs1ubF8ohouJzBKzLy41PgcJyf49MBtWWV1N1LcWUjKb0
	ZHKvjPklvIPr8eUx4iD+QJx/B0tuUik=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-hULDL8WJNcWmIsucIhNMXQ-1; Mon, 18 Aug 2025 03:49:35 -0400
X-MC-Unique: hULDL8WJNcWmIsucIhNMXQ-1
X-Mimecast-MFC-AGG-ID: hULDL8WJNcWmIsucIhNMXQ_1755503374
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b05d251so20683045e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 00:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755503374; x=1756108174;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JvG7aFZ8aE0+JNevCZ82bDuwuz+Fa5f4Y7h7OdT1St0=;
        b=knHPGiK2Ibl5C82vXWBEotK8NVyqvhIZHxSdWdJO8z4maVo7UCO5yDR2EVJHY+0gt6
         /6GAr7G27x8yRKrcxE4ONgevUaGjGdTcXQgUU5iRKMOlGMVg1PJa0FNBM+YgBJ59u2rK
         JdBe+ngrNOpMgkpKfHUe6W0qjP9sqQBAos3OnNZQRLnwb8mQ8h8lBzhtMtTTBYI9IVov
         giBVzRxqDWWw1iiiwmPHacKuZZ6bnak+89FaYB8rguKPMojI3x3KDHtTT9wNjgy3uLLi
         oD+tcp8CrnnJXkQJ9K54SqB2FeXewc1Gb9GW0OQ5wemP1RgNLXZu9JOzK0NnsMhvMM+v
         nEMQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6M8j06NNU2J2bSUGOfLp4YgD+/1jDgKkFYcu5KDLQ0BnutD6l9QKvrj5odXhEdLqRl5OaIrNRmERTQRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHP85UfjX49oAGObckchwP3UNyk4QWyhnN+G08UroZ7315GONh
	u1tQ203sc1Ui4l83yxQ5JMC88JWQh04BCQDwTKLxnihAUCZvs+pjlFm0Uciy+aY60yQVh9nXUt/
	TjASJG85VGgPQmE668fKtnZ62gRlqyzK/dKQiMEOb+uvIEVkIvoLeIqMJkElef3rphA==
X-Gm-Gg: ASbGncugCgwIsCaZpbnTeIn1q3CV3YQZzf/MNCKDhq1yWdl8wW0oe/R1Jf95COYwhTH
	ImOQ6tAtxAZV3s8o+QfXB+T/pXRQkUGiSYEahygv/cz2ajtMh8a7Ti00yCmmu4CTfac52y+AF52
	/J9E4PDNCjlWwF1F2p8CYbwwdWE+nSf84zpFvI4i154Bo3UWr8tcrSKPN6wmwloeu6YqlfYVrlI
	2Jgt4hK2wuBIvoF7yhsKRVP5NSmSMvqgWEJnm6a1vIzTC9/QvqXJSHZ4CsLI77O7HMG9vQHtlOp
	C15ba9r1/hkdPvTOluGsSziO39Q3AvdMZwgPDFMEVQAFGRgAQV7R/sXNvYjRcPCcCZhTg8Qal3K
	kKRP3keEqnNmI6ET0JexAy2iZLlN3OuxuaU45yJlhgnvI5l6VJDjW/S6nuzsAjGN+
X-Received: by 2002:a05:600c:1c11:b0:43d:42b:e186 with SMTP id 5b1f17b1804b1-45a217f38cbmr64475595e9.8.1755503373752;
        Mon, 18 Aug 2025 00:49:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+R4BTN5wtqMrjV8DaHS5wNTE3hiVZhoPxXGSX+s7SlPH9szHPb2D+pX9sfU+sf8LvxTrSKg==
X-Received: by 2002:a05:600c:1c11:b0:43d:42b:e186 with SMTP id 5b1f17b1804b1-45a217f38cbmr64475205e9.8.1755503373303;
        Mon, 18 Aug 2025 00:49:33 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f22:600:53c7:df43:7dc3:ae39? (p200300d82f22060053c7df437dc3ae39.dip0.t-ipconnect.de. [2003:d8:2f22:600:53c7:df43:7dc3:ae39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb680798fasm11870486f8f.52.2025.08.18.00.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 00:49:32 -0700 (PDT)
Message-ID: <61cd1dfd-f51c-4f47-84d2-1f8b134105e4@redhat.com>
Date: Mon, 18 Aug 2025 09:49:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 mm-hotfixes 3/3] x86/mm/64: define
 ARCH_PAGE_TABLE_SYNC_MASK and arch_sync_kernel_mappings()
To: Harry Yoo <harry.yoo@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 "H . Peter Anvin" <hpa@zyccr.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@gentwo.org>, Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Juergen Gross
 <jgross@suse.de>, Kevin Brodsky <kevin.brodsky@arm.com>,
 Oscar Salvador <osalvador@suse.de>, Joao Martins
 <joao.m.martins@oracle.com>, Lorenzo Sccakes <lorenzo.stoakes@oracle.com>,
 Jane Chu <jane.chu@oracle.com>, Alistair Popple <apopple@nvidia.com>,
 Mike Rapoport <rppt@kernel.org>, Gwan-gyeong Mun
 <gwan-gyeong.mun@intel.com>, "Aneesh Kumar K . V"
 <aneesh.kumar@linux.ibm.com>, Uladzislau Rezki <urezki@gmail.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Ard Biesheuvel <ardb@kernel.org>, Thomas Huth <thuth@redhat.com>,
 John Hubbard <jhubbard@nvidia.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Peter Xu <peterx@redhat.com>, Dev Jain <dev.jain@arm.com>,
 Bibo Mao <maobibo@loongson.cn>, Anshuman Khandual
 <anshuman.khandual@arm.com>, Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org, Kiryl Shutsemau <kas@kernel.org>
References: <20250818020206.4517-1-harry.yoo@oracle.com>
 <20250818020206.4517-4-harry.yoo@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250818020206.4517-4-harry.yoo@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.08.25 04:02, Harry Yoo wrote:
> Define ARCH_PAGE_TABLE_SYNC_MASK and arch_sync_kernel_mappings() to ensure
> page tables are properly synchronized when calling
> p*d_populate_kernel().
> 
> For 5-level paging, synchronization is performed via
> pgd_populate_kernel(). In 4-level paging, pgd_populate() is a no-op,
> so synchronization is instead performed at the P4D level via
> p4d_populate_kernel().
> 
> This fixes intermittent boot failures on systems using 4-level paging
> and a large amount of persistent memory:
> 
>    BUG: unable to handle page fault for address: ffffe70000000034
>    #PF: supervisor write access in kernel mode
>    #PF: error_code(0x0002) - not-present page
>    PGD 0 P4D 0
>    Oops: 0002 [#1] SMP NOPTI
>    RIP: 0010:__init_single_page+0x9/0x6d
>    Call Trace:
>     <TASK>
>     __init_zone_device_page+0x17/0x5d
>     memmap_init_zone_device+0x154/0x1bb
>     pagemap_range+0x2e0/0x40f
>     memremap_pages+0x10b/0x2f0
>     devm_memremap_pages+0x1e/0x60
>     dev_dax_probe+0xce/0x2ec [device_dax]
>     dax_bus_probe+0x6d/0xc9
>     [... snip ...]
>     </TASK>
> 
> It also fixes a crash in vmemmap_set_pmd() caused by accessing vmemmap
> before sync_global_pgds() [1]:
> 
>    BUG: unable to handle page fault for address: ffffeb3ff1200000
>    #PF: supervisor write access in kernel mode
>    #PF: error_code(0x0002) - not-present page
>    PGD 0 P4D 0
>    Oops: Oops: 0002 [#1] PREEMPT SMP NOPTI
>    Tainted: [W]=WARN
>    RIP: 0010:vmemmap_set_pmd+0xff/0x230
>     <TASK>
>     vmemmap_populate_hugepages+0x176/0x180
>     vmemmap_populate+0x34/0x80
>     __populate_section_memmap+0x41/0x90
>     sparse_add_section+0x121/0x3e0
>     __add_pages+0xba/0x150
>     add_pages+0x1d/0x70
>     memremap_pages+0x3dc/0x810
>     devm_memremap_pages+0x1c/0x60
>     xe_devm_add+0x8b/0x100 [xe]
>     xe_tile_init_noalloc+0x6a/0x70 [xe]
>     xe_device_probe+0x48c/0x740 [xe]
>     [... snip ...]
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 8d400913c231 ("x86/vmemmap: handle unpopulated sub-pmd ranges")
> Closes: https://lore.kernel.org/linux-mm/20250311114420.240341-1-gwan-gyeong.mun@intel.com [1]
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Acked-by: Kiryl Shutsemau <kas@kernel.org>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


