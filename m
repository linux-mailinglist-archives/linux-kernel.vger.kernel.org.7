Return-Path: <linux-kernel+bounces-722050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FFFAFD3F4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8745D168D43
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B66F2E541E;
	Tue,  8 Jul 2025 16:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fGXCVzqi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1FC2DCC03
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 16:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993963; cv=none; b=kLT+GKSgUmZZGefdbwC0pSDUlN9Cl0UFJerxTc5Bp5sLmpLNKE8SQj2yGbfbaa5kL4To15IgG+cCujFlDsYZPJd6o159Xfweg9n4WY+KNaIR7ppy5XkC9K3E4Z5SQjkvM8Rncwodt/PNSxdl0KidU/7okqW4YzRG4G467UbSbvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993963; c=relaxed/simple;
	bh=IpE0JErguYpROYzQkLoMA+WtZB+qR1oUR5rCsrXv1/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dj9PJq/+D/iWOhlipjHBOFnGOdeMzisA0E3TYb7QgIZMOIGwKnuLPp2OT7uU9Uz0g8KwVsyppfn9DnGbk/Rts+e4fSMM0xeIh3d56HTW507EZMRRbRJMyumgDZ6SNfarUYUVAWi24SHMo/zW5RpD61TWdLMOzQX27OjGWM02sKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fGXCVzqi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751993960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wybB/fUy6mCrhP5jGn1a9ArjMgUrKLPn8Q0MHxBm0RE=;
	b=fGXCVzqiiDUjrIElxsCgLwZuFWgnFFJO7oCVEyX9QTba52zwThNTFd0GpEY/1s/Re5/dbc
	hofqu0PXY2fy2p7nMzzY8xtpwpUXHsmnv0v8fi1e19HgmQ1BeVx1g3g9nKToAltaVaVzs0
	p38rVVJgJzYpmPOnUNxwU4WS8A74WGw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-hZNpLqB4MpqCQ8Q7dFfV7A-1; Tue, 08 Jul 2025 12:59:19 -0400
X-MC-Unique: hZNpLqB4MpqCQ8Q7dFfV7A-1
X-Mimecast-MFC-AGG-ID: hZNpLqB4MpqCQ8Q7dFfV7A_1751993959
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fb1be925fbso73090796d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 09:59:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751993959; x=1752598759;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wybB/fUy6mCrhP5jGn1a9ArjMgUrKLPn8Q0MHxBm0RE=;
        b=ncd1PVrvN0yg57sZ+K9benbALN5aIEPb8KXTCxxifZS77zrkkW/0JZyXrgc9AvKQUK
         ZKtRl7sNLW7YteX1h6q9XWl0pleVFGa6UD1TTNGLEth6Q9tbV0JNuM7c9bRqVV32SJZh
         7gRRoAJwLIeW4VY5pMDMiy1felxcxHFJqorfH2hfpSLpZzMThMBC+dXrXsrLYBQG5RPS
         UgXP5c/X1fPezygSxP8I/NzTKTPi4UhXCrftUHScnl5TjLgR7GlrE19Fk8zupgmZwNlH
         fJlpEjGceOgUuZDAApqBoXkYFLf/UCa4KaklJVIlrGd2/P3vT17KxaoOVm7G8++fXqo0
         g8sQ==
X-Gm-Message-State: AOJu0YwX1DRXT0I6sU8SAAjyEhRuNew8X7yjZMMSyGiAZil0lbPf+Z9X
	P8gjPQATL3adK3q2gTJi7/y4MRGS4s+3almOizkyOLixy0klikiQ2tlNMBDYUHlXcuZ60EWhs3i
	EFPEoq1bbMvWxeJjWmrQ58sCmqIl0oI+DcKiLGhaSV/D0hIn2jJ/hYc1ikFV/0nowEQ==
X-Gm-Gg: ASbGnctnRvQUqJQmzHEj2SZ6FgYRU02PBhE/gfdmQaoy8ThRthMDxdlWZGANd4qTy3A
	5MH3OI2PC9veJkzt9GWaqRGyr3gE2EJqWQMvBzygSDRbNi/PoT3E5P2xykJJsXew7Der6z65k1J
	rWQAbFSL1AJimPFo5+tmPDFES/NFp/VLsIYeyHjSbZBM6MGDDGKxEsAQkvxIH3msqcYPAdxcTRh
	MicfWaXWVCyxk1j1FnS2vCZXnArGOcFTa0DhVyYYiVh29zSsSxTaHJsjW05B69QG3lguI1hVajs
	sLRh3kTeNzb3t5PWdGLYY5Y=
X-Received: by 2002:a0c:f113:0:b0:702:cea8:c598 with SMTP id 6a1803df08f44-702cea8c5cdmr200595536d6.3.1751993958681;
        Tue, 08 Jul 2025 09:59:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXoR4uA6XBxL64aujeWrjmoayZW9DBpgTBBcSQum2HYEQkMOMEGFDRn0uDb4RXtMzn8yq9kw==
X-Received: by 2002:a0c:f113:0:b0:702:cea8:c598 with SMTP id 6a1803df08f44-702cea8c5cdmr200595046d6.3.1751993958068;
        Tue, 08 Jul 2025 09:59:18 -0700 (PDT)
Received: from [192.168.2.110] ([70.29.229.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4d51040sm79052486d6.63.2025.07.08.09.59.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 09:59:17 -0700 (PDT)
Message-ID: <60a1a526-52dd-478a-9ed4-79e6428743ac@redhat.com>
Date: Tue, 8 Jul 2025 12:59:07 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] mm/util: introduce snapshot_page()
To: Shivank Garg <shivankg@amd.com>, david@redhat.com, willy@infradead.org,
 akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, sj@kernel.org
References: <cover.1751914235.git.luizcap@redhat.com>
 <88d956248f7528b7998ef00ca8742061839d1036.1751914235.git.luizcap@redhat.com>
 <3942336d-20e6-457d-8b53-e198eed5d9d9@amd.com>
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <3942336d-20e6-457d-8b53-e198eed5d9d9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-07-08 01:49, Shivank Garg wrote:
> 
> 
> On 7/8/2025 12:20 AM, Luiz Capitulino wrote:
>> This commit refactors __dump_page() into snapshot_page().
>>
>> snapshot_page() tries to take a faithful snapshot of a page and its
>> folio representation. The snapshot is returned in the struct
>> page_snapshot parameter along with additional flags that are best
>> retrieved at snapshot creation time to reduce race windows.
>>
>> This function is intended to be used by callers that need a stable
>> representation of a struct page and struct folio so that pointers
>> or page information doesn't change while working on a page.
>>
>> The idea and original implementation of snapshot_page() comes from
>> Matthew Wilcox with suggestions for improvements from David Hildenbrand.
>> All bugs and misconceptions are mine.
>>
>> Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
>> ---
>>   include/linux/mm.h | 19 ++++++++++++
>>   mm/debug.c         | 42 +++----------------------
>>   mm/util.c          | 77 ++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 100 insertions(+), 38 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 0ef2ba0c667a..090968c6eebb 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -4184,4 +4184,23 @@ static inline bool page_pool_page_is_pp(struct page *page)
>>   }
>>   #endif
>>   
>> +#define PAGE_SNAPSHOT_FAITHFUL     (1 << 0)
>> +#define PAGE_SNAPSHOT_PG_FREE      (1 << 1)
>> +#define PAGE_SNAPSHOT_PG_IDLE      (1 << 2)
>> +
>> +struct page_snapshot {
>> +	struct folio folio_snapshot;
>> +	struct page page_snapshot;
>> +	unsigned long pfn;
>> +	unsigned long idx;
>> +	unsigned long flags;
>> +};
>> +
>> +static inline bool snapshot_page_is_faithful(const struct page_snapshot *ps)
>> +{
>> +	return ps->flags & PAGE_SNAPSHOT_FAITHFUL;
>> +}
>> +
>> +void snapshot_page(struct page_snapshot *ps, const struct page *page);
>> +
>>   #endif /* _LINUX_MM_H */
>> diff --git a/mm/debug.c b/mm/debug.c
>> index 907382257062..7349330ea506 100644
>> --- a/mm/debug.c
>> +++ b/mm/debug.c
>> @@ -129,47 +129,13 @@ static void __dump_folio(struct folio *folio, struct page *page,
>>   
>>   static void __dump_page(const struct page *page)
>>   {
>> -	struct folio *foliop, folio;
>> -	struct page precise;
>> -	unsigned long head;
>> -	unsigned long pfn = page_to_pfn(page);
>> -	unsigned long idx, nr_pages = 1;
>> -	int loops = 5;
>> -
>> -again:
>> -	memcpy(&precise, page, sizeof(*page));
>> -	head = precise.compound_head;
>> -	if ((head & 1) == 0) {
>> -		foliop = (struct folio *)&precise;
>> -		idx = 0;
>> -		if (!folio_test_large(foliop))
>> -			goto dump;
>> -		foliop = (struct folio *)page;
>> -	} else {
>> -		foliop = (struct folio *)(head - 1);
>> -		idx = folio_page_idx(foliop, page);
>> -	}
>> +	struct page_snapshot ps;
>>   
>> -	if (idx < MAX_FOLIO_NR_PAGES) {
>> -		memcpy(&folio, foliop, 2 * sizeof(struct page));
>> -		nr_pages = folio_nr_pages(&folio);
>> -		if (nr_pages > 1)
>> -			memcpy(&folio.__page_2, &foliop->__page_2,
>> -			       sizeof(struct page));
>> -		foliop = &folio;
>> -	}
>> -
>> -	if (idx > nr_pages) {
>> -		if (loops-- > 0)
>> -			goto again;
>> +	snapshot_page(&ps, page);
>> +	if (!snapshot_page_is_faithful(&ps))
>>   		pr_warn("page does not match folio\n");
>> -		precise.compound_head &= ~1UL;
>> -		foliop = (struct folio *)&precise;
>> -		idx = 0;
>> -	}
>>   
>> -dump:
>> -	__dump_folio(foliop, &precise, pfn, idx);
>> +	__dump_folio(&ps.folio_snapshot, &ps.page_snapshot, ps.pfn, ps.idx);
>>   }
>>   
>>   void dump_page(const struct page *page, const char *reason)
>> diff --git a/mm/util.c b/mm/util.c
>> index 0b270c43d7d1..c38d213be83f 100644
>> --- a/mm/util.c
>> +++ b/mm/util.c
>> @@ -25,6 +25,7 @@
>>   #include <linux/sizes.h>
>>   #include <linux/compat.h>
>>   #include <linux/fsnotify.h>
>> +#include <linux/page_idle.h>
>>   
>>   #include <linux/uaccess.h>
>>   
>> @@ -1171,3 +1172,79 @@ int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma)
>>   	return 0;
>>   }
>>   EXPORT_SYMBOL(compat_vma_mmap_prepare);
>> +
>> +static void set_flags(struct page_snapshot *ps, const struct folio *folio,
>> +		      const struct page *page)
>> +{
>> +	/*
>> +	 * Caveats on high order pages: PG_buddy and PG_slab will only be set
>> +	 * on the head page.
>> +	 */
>> +	if (PageBuddy(page))
>> +		ps->flags |= PAGE_SNAPSHOT_PG_FREE;
>> +	else if (page_count(page) == 0 && is_free_buddy_page(page))
>> +		ps->flags |= PAGE_SNAPSHOT_PG_FREE;
>> +
>> +	if (folio_test_idle(folio))
>> +		ps->flags |= PAGE_SNAPSHOT_PG_IDLE;
>> +}
>> +
>> +/*
>> + * Create a snapshot of a page and store its struct page and struct folio
>> + * representations in a struct page_snapshot.
>> + *
>> + * @ps: struct page_snapshot to store the page snapshot
>> + * @page: the page we want to snapshot
>> + *
>> + * Note that creating a faithful snapshot of a page may fail if the page
>> + * compound keeps changing (eg. due to folio split). In this case we set
>> + * ps->faithful to false and the snapshot will assume that @page refers
>> + * to a single page.
>> + */
>> +void snapshot_page(struct page_snapshot *ps, const struct page *page)
>> +{
>> +	unsigned long head, nr_pages = 1;
>> +	struct folio *foliop, folio;
>> +	int loops = 5;
>> +
>> +	ps->pfn = page_to_pfn(page);
>> +	ps->flags = PAGE_SNAPSHOT_FAITHFUL;
>> +
>> +again:
>> +	memcpy(&ps->page_snapshot, page, sizeof(*page));
>> +	head = ps->page_snapshot.compound_head;
>> +	if ((head & 1) == 0) {
>> +		foliop = (struct folio *)&ps->page_snapshot;
>> +		ps->idx = 0;
>> +		if (!folio_test_large(foliop)) {
>> +			set_flags(ps, page_folio(page), page);
>> +			goto out;
>> +		}
>> +		foliop = (struct folio *)page;
>> +	} else {
>> +		foliop = (struct folio *)(page->compound_head - 1);
> 					  ^^^^
> should we use ps->page_snapshot here?
> IIUC, page may change due to race.

You're right the race exists, but we can't make foliop point to the
snapshot because we do pointer arithmetic and other operations that need
the real page memory address to work properly.

>> +		ps->idx = folio_page_idx(foliop, page);
>> +	}
>> +
>> +	if (ps->idx < MAX_FOLIO_NR_PAGES) {
>> +		memcpy(&folio, foliop, 2 * sizeof(struct page));
>> +		nr_pages = folio_nr_pages(&folio);
>> +		if (nr_pages > 1)
>> +			memcpy(&folio.__page_2, &foliop->__page_2,
>> +			       sizeof(struct page));
>> +		set_flags(ps, foliop, page);
>> +		foliop = &folio;
>> +	}
>> +
>> +	if (ps->idx > nr_pages) {
>> +		if (loops-- > 0)
>> +			goto again;
>> +		ps->page_snapshot.compound_head &= ~1UL;
> 
> Should we use clear_compound_head() for clarity?

Yes, we can do that.

Andrew, since you applied this series already, can you squash the change
below into this patch? If not, I can send v3.

diff --git a/mm/util.c b/mm/util.c
index c38d213be83f..ce4200529772 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1239,7 +1239,7 @@ void snapshot_page(struct page_snapshot *ps, const struct page *page)
  	if (ps->idx > nr_pages) {
  		if (loops-- > 0)
  			goto again;
-		ps->page_snapshot.compound_head &= ~1UL;
+		clear_compound_head(&ps->page_snapshot);
  		foliop = (struct folio *)&ps->page_snapshot;
  		ps->flags = 0;
  		ps->idx = 0;


