Return-Path: <linux-kernel+bounces-733143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0B9B070C5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F8561750B6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6493D2EE962;
	Wed, 16 Jul 2025 08:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ct2BPYgm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5382EE977
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752655213; cv=none; b=GMhQpZx8t94ebmNhaXyxNNeclYjNXYP9zdNnW++yW/3YZDwdo2rTLhQnHsj3ttrPNdIgUib/YLfZCvNNrWpawbJFbGkNiUEQuAFuR//gOSbTC8eKL4lp0HKWk+fK57JZBIIymnCetADtAlsFK3C6G5SYS0J5n5uBF/fxkBDXyGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752655213; c=relaxed/simple;
	bh=slQfR28JoNWigYK22ze4io5g54wwXTHt2HfUh+9eru8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DfKdcU9oEqFTCL2aM7umIs/PkzOzKOZC0fyacryvn03odAGTiOn1VvCpeCDlghtQgi3dJMplp1+IzDmB0rt3pzk0PKt3mht+/DL5Q+ZnhdxVCwApdj3lcqN+Iq/GK2+8ZnCIWmKa2CtHYIydroF/Tf/bWsvqwNh4K+DZxzQVWjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ct2BPYgm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752655210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OSzSTiWWx3Mgn+kOlT8G5aG3zaow2wrPSmv/FVAPdmQ=;
	b=ct2BPYgm7GhDOve4q+QVccxn8sLMuy+wgXsUOIIvv9fG1KBdRvl634skgM6oyW8VCVGtPe
	x519SqppU1n+CqWrFFmzQaFrw7j0r4fW5XJlgZF8mupd3UPhlSp/tGsQUiOozY2XVw6jAv
	b8X5UXQC3LOkDwwv/Zt9np/vjSGJ7FA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-I-wMn4_dMX6dxKjnENNzaw-1; Wed, 16 Jul 2025 04:40:09 -0400
X-MC-Unique: I-wMn4_dMX6dxKjnENNzaw-1
X-Mimecast-MFC-AGG-ID: I-wMn4_dMX6dxKjnENNzaw_1752655208
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a50816ccc6so3882404f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 01:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752655208; x=1753260008;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OSzSTiWWx3Mgn+kOlT8G5aG3zaow2wrPSmv/FVAPdmQ=;
        b=lSM+yjsmwObhdToLZrxr71qGI9b3dJ0UMiBI6ZwBNu+TWdJuVurt/Qowe5bqXA+iKu
         5TRdIDHxRHHXX7G9AwOAYi8q20retr1ep71MU2UJ8aMv7tb3xkdlFECHI/nTzySYD0xe
         9MuSaNsVHxF+HhEBsnwT8PZKXcY9QgCmjiywfs2naLKAkGqOPEDTuHgJvlFGr26sSUy1
         HQGNdeSJC4AhOX8eUTAwEcUFQVntdU5dv1cEbkqkXRBv42jhG6L5Rqw3O0zrw8YKYq+q
         99/boywF3xCtaOT95KMhfbYObZDfnVmKi9skSr7KPxmelyqUThC5kp2soscT/MvjGd8E
         gk+Q==
X-Gm-Message-State: AOJu0YytQ+EntZrao9BKwgknY6RaE/B+8+Yz+i2DuNGJir+r3Y05pd7k
	UhIZ+rSJSnIFqHA32vLU6CfU3gJeQzYuBPc3AeIPqpjDNvXrAZRisNFpz4PKsOaupGlVqpGVqh+
	uRIURdTNw+ivtqO0pJHV6JWL6Cl3ffj0VEWeDvDjvoG9oHzxDwn4l/K6ocphnRWHD/fPzzOOjT2
	m4ErzLNfAeQysNBYuod7WTg07QG2lkvAHjhqcwplslGvqBow==
X-Gm-Gg: ASbGncvqf9kfsLbpZOzFjqGBR5EBYF5glApXOjH9SS8IYoi+tW8wdKDMEIS7xhbimfG
	ceOXDW0S233CcW4msDdnTw4RKAqBvVuhYFPMtX7TmLE9uPZLs1VCk+SkBAomDbnMm8JCVtm21HI
	akYT7SiYYrC05AcmOMsSBC5Rm2EOasOr5KbCxsy53eum+KbTnGRhSznUGytlo/70frT7f96L/Eo
	xz/UPAMdLa08CjHoiWe6lA2fC0l3fcpKozhOCoZeHoe47Z44tx+ZVzK1MfiIpsFg2NoItyq42hb
	qJU6AxVond/oAVtd6Bi/fN3aWoFTik/rsMrPdn/lDyXcNuguAOdSLRcKKnIP9kdg7BxZVPhsiLM
	nqwEJqkZqI1fKe3dR0pKkwLBQHDvnEDAkbcGkOxnfP/Y85CMpXDaikXzvMZR6+IkQKe0=
X-Received: by 2002:a05:6000:22c6:b0:3a3:652d:1640 with SMTP id ffacd0b85a97d-3b60e4c9551mr1177343f8f.2.1752655207875;
        Wed, 16 Jul 2025 01:40:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrz7aA1Q5DJ0qrWg414nemqw3+E5uTkk/vafPidGzJJcoZYuxj+80SlJoZCzlNz1Q/6bN5bQ==
X-Received: by 2002:a05:6000:22c6:b0:3a3:652d:1640 with SMTP id ffacd0b85a97d-3b60e4c9551mr1177269f8f.2.1752655207170;
        Wed, 16 Jul 2025 01:40:07 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1d:ed00:1769:dd7c:7208:eb33? (p200300d82f1ded001769dd7c7208eb33.dip0.t-ipconnect.de. [2003:d8:2f1d:ed00:1769:dd7c:7208:eb33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e83c9edsm13968115e9.34.2025.07.16.01.40.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 01:40:06 -0700 (PDT)
Message-ID: <e92b75d4-999b-4b0f-b62f-9edca09834c4@redhat.com>
Date: Wed, 16 Jul 2025 10:40:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/9] mm/memory: convert print_bad_pte() to
 print_bad_page_map()
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, xen-devel@lists.xenproject.org,
 linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox
 <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Hugh Dickins <hughd@google.com>, Oscar Salvador <osalvador@suse.de>,
 Lance Yang <lance.yang@linux.dev>, Russell King <linux@armlinux.org.uk>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250715132350.2448901-1-david@redhat.com>
 <20250715132350.2448901-7-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <20250715132350.2448901-7-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.07.25 15:23, David Hildenbrand wrote:
> print_bad_pte() looks like something that should actually be a WARN
> or similar, but historically it apparently has proven to be useful to
> detect corruption of page tables even on production systems -- report
> the issue and keep the system running to make it easier to actually detect
> what is going wrong (e.g., multiple such messages might shed a light).
> 
> As we want to unify vm_normal_page_*() handling for PTE/PMD/PUD, we'll have
> to take care of print_bad_pte() as well.
> 
> Let's prepare for using print_bad_pte() also for non-PTEs by adjusting the
> implementation and renaming the function -- we'll rename it to what
> we actually print: bad (page) mappings. Maybe it should be called
> "print_bad_table_entry()"? We'll just call it "print_bad_page_map()"
> because the assumption is that we are dealing with some (previously)
> present page table entry that got corrupted in weird ways.
> 
> Whether it is a PTE or something else will usually become obvious from the
> page table dump or from the dumped stack. If ever required in the future,
> we could pass the entry level type similar to "enum rmap_level". For now,
> let's keep it simple.
> 
> To make the function a bit more readable, factor out the ratelimit check
> into is_bad_page_map_ratelimited() and place the dumping of page
> table content into __dump_bad_page_map_pgtable(). We'll now dump
> information from each level in a single line, and just stop the table
> walk once we hit something that is not a present page table.
> 
> Use print_bad_page_map() in vm_normal_page_pmd() similar to how we do it
> for vm_normal_page(), now that we have a function that can handle it.
> 
> The report will now look something like (dumping pgd to pmd values):
> 
> [   77.943408] BUG: Bad page map in process XXX  entry:80000001233f5867
> [   77.944077] addr:00007fd84bb1c000 vm_flags:08100071 anon_vma: ...
> [   77.945186] pgd:10a89f067 p4d:10a89f067 pud:10e5a2067 pmd:105327067
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   mm/memory.c | 120 ++++++++++++++++++++++++++++++++++++++++------------
>   1 file changed, 94 insertions(+), 26 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index a4f62923b961c..00ee0df020503 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -479,22 +479,8 @@ static inline void add_mm_rss_vec(struct mm_struct *mm, int *rss)
>   			add_mm_counter(mm, i, rss[i]);
>   }
>   
> -/*
> - * This function is called to print an error when a bad pte
> - * is found. For example, we might have a PFN-mapped pte in
> - * a region that doesn't allow it.
> - *
> - * The calling function must still handle the error.
> - */
> -static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
> -			  pte_t pte, struct page *page)
> +static bool is_bad_page_map_ratelimited(void)
>   {
> -	pgd_t *pgd = pgd_offset(vma->vm_mm, addr);
> -	p4d_t *p4d = p4d_offset(pgd, addr);
> -	pud_t *pud = pud_offset(p4d, addr);
> -	pmd_t *pmd = pmd_offset(pud, addr);
> -	struct address_space *mapping;
> -	pgoff_t index;
>   	static unsigned long resume;
>   	static unsigned long nr_shown;
>   	static unsigned long nr_unshown;
> @@ -506,7 +492,7 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
>   	if (nr_shown == 60) {
>   		if (time_before(jiffies, resume)) {
>   			nr_unshown++;
> -			return;
> +			return true;
>   		}
>   		if (nr_unshown) {
>   			pr_alert("BUG: Bad page map: %lu messages suppressed\n",
> @@ -517,15 +503,87 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
>   	}
>   	if (nr_shown++ == 0)
>   		resume = jiffies + 60 * HZ;
> +	return false;
> +}
> +
> +static void __dump_bad_page_map_pgtable(struct mm_struct *mm, unsigned long addr)
> +{
> +	unsigned long long pgdv, p4dv, pudv, pmdv;
> +	pgd_t pgd, *pgdp;
> +	p4d_t p4d, *p4dp;
> +	pud_t pud, *pudp;
> +	pmd_t *pmdp;
> +
> +	/*
> +	 * This looks like a fully lockless walk, however, the caller is
> +	 * expected to hold the leaf page table lock in addition to other
> +	 * rmap/mm/vma locks. So this is just a re-walk to dump page table
> +	 * content while any concurrent modifications should be completely
> +	 * prevented.
> +	 */
> +	pgdp = pgd_offset(mm, addr);
> +	pgd = pgdp_get(pgdp);
> +	pgdv = pgd_val(pgd);

Apparently there is something weird here on arm-bcm2835_defconfig:

All errors (new ones prefixed by >>):

 >> mm/memory.c:525:6: error: array type 'pgd_t' (aka 'unsigned int[2]') 
is not assignable
      525 |         pgd = pgdp_get(pgdp);
          |         ~~~ ^
    1 error generated.

... apparently because we have this questionable ...

arch/arm/include/asm/pgtable-2level-types.h:typedef pmdval_t pgd_t[2];

I mean, the whole concept of pgdp_get() doesn't make too much sense if 
it wants to return an array.

I don't quite understand the "#undef STRICT_MM_TYPECHECKS #ifdef 
STRICT_MM_TYPECHECKS" stuff.

Why do we want to make it easier on the compiler while doing something 
fairly weird?

CCing arm maintainers: what's going on here? :)

An easy fix would be to not dump the pgd value, but having a 
non-functional pgdp_get() really is weird.

-- 
Cheers,

David / dhildenb


