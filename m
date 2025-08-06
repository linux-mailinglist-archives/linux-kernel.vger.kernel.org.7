Return-Path: <linux-kernel+bounces-757598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE448B1C410
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F77962163B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA1228A3ED;
	Wed,  6 Aug 2025 10:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ctjYqBdl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4303CEAF9
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 10:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754475102; cv=none; b=p4epHtX5g5DUAytLwy5Vp7cwL53WKJFoq4cKPaC6UAQYLAPIu2r6nR6ga8ThKIEmMjsp1kxQupkTDmITGNMBc32D4D0WYv3x3vREcL68uirWeHKWsW3a5bW6FdKsn0FoepS9Yx4X+xLSZXGPwGv8w0veSoAzXH2olh2V7IZ0mW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754475102; c=relaxed/simple;
	bh=l11TF+ySmIl18nuaLtjqgfIk0K+bdyCZBbmzgwxPz6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JlJrdA9AT9MMvkJrhLnd5w/bYK3QcvqyB7rb/a8Ckln4eOvHh5iFjrESJDoVf94omHIrte0bwvvk5lsRwCFODKgS50wfGkPlcJCFuxk6wh46ml1zP0X6FKYgoT3a0va+n/7MtBRKYkc7oj0azidd1QiF+sWt5hoybXY3MNyaetc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ctjYqBdl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754475099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qh2edeS0ZaNzvwBPknu4B1s/vixn92FnvJSgkjVQa5Q=;
	b=ctjYqBdlsY4Suv9th8QI8wRibkVHahxyio8I8cICxD9ThXqBBossLkStKS5P4+e7bCyojR
	lRp670cba5gXfTBhpFkIo58YWKOJOQKtNFkDKJXjBqyhgBsH4F2SZAv0V5ZC710brfs77G
	7FTjZu8ZYo5Wv3spWN6XVCq+Rw8YVcA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-WuoJoPi_NF6z-CFBrpIlpQ-1; Wed, 06 Aug 2025 06:11:38 -0400
X-MC-Unique: WuoJoPi_NF6z-CFBrpIlpQ-1
X-Mimecast-MFC-AGG-ID: WuoJoPi_NF6z-CFBrpIlpQ_1754475097
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45526e19f43so17293445e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 03:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754475097; x=1755079897;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qh2edeS0ZaNzvwBPknu4B1s/vixn92FnvJSgkjVQa5Q=;
        b=P1W/LRSOpY5Uka1NfmcB3GjzcKzs7tE5OWT/Dc9W5MzU1r6ej8N9Z3kiobG9ITuiSa
         65daxAEXG3Y+LRVrfp9yFfSc1AdEN6ROtz9P2nWgTH13ubSJaEScLHjvgAkYyA11qXST
         w763oqvd0ZDUUmchfKxXtSTsGV0UwlVVrh2gvlZjw50cWuOPsEBrud5BnmJ/RAOAY0Q6
         rrElsFef3b4QUC1u7I9u2ygqnci+Idinna1dGvbv+IgrEq3cw4wKMbBQFGR1XKO8Kk73
         OfYo9/TMrNtlx/2sKc4iqIUYm4D+5TNZaObpdQ6Ke4pg66b0EeCsjrZdl7d4rp0ROqaD
         yF+g==
X-Forwarded-Encrypted: i=1; AJvYcCUHHxtAgmhRDJj2dSpKzDU3zOdJZnLzcJNeZSXIJ1DEyvTuJOSkQVSIFQHtSQjXgU1QJ3EZ1N7wxELeTR4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf/4/QDzTIdgSElHJRDaietw8Vi09wh2LhHDNEhi98LUM5ETcu
	70GMT136gmzXb1EZsCFox/sxeU3lHN0dDpD1aU3gvjUy5Aw1+YO9zKe/LOgr4JlbR6zjgIkr1+n
	bFuD+YjNhbC7qTUkROho+w57EajV/x7pbSY99/BoCvU5A5p7caRUFse2TFZHf7HoK9Q==
X-Gm-Gg: ASbGncstpGIGpjHL+FN7JmEUCTUpu64I53OX/iPFHxypUH6odeYkiEFu2+zK2dTKUxD
	kA6ssSfU/5YcuUvU13mMCHuOdQP4QV0p15ewxGfKbtQjQv3WeYPnKEp74s2oGIAN4rj0I28Klmv
	hOMNHOOGiQaPnaelp+T8a/Le7JeR66Ip7U9jEqyeZ+VJAmK1zpvToxXyUCO3bxnBtGRr66863to
	PHaTRYYB6vKwdMwoO7Y5/wHRvo+DZ8o1d+BfHT4dTz0ja9sT7zWt7MDZoSiFnrLjDz4Hp/vieEd
	dHba9RaOzupUxMitgpddBXAtmogeNf+TZWJ9DRvpjpG3UDWTajMKgXJk3kACnT+QYKuMKC9pyfb
	X7VmEE85SBEoyNKDR/4f/IbSgxMP0gXFw8c3UZBSI6jW/U9Puqb0XXOICnt3dvBc/z3c=
X-Received: by 2002:a05:600c:4ecd:b0:458:a850:f857 with SMTP id 5b1f17b1804b1-459e711e5f5mr22019315e9.31.1754475096621;
        Wed, 06 Aug 2025 03:11:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECB8a+B/TWDtQecrYAbY89V39jfBkap9mCeJXvk++JnuEAN8c3eY64Hf3618Dec9c0Z5BLKw==
X-Received: by 2002:a05:600c:4ecd:b0:458:a850:f857 with SMTP id 5b1f17b1804b1-459e711e5f5mr22018795e9.31.1754475096051;
        Wed, 06 Aug 2025 03:11:36 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f35:8a00:42f7:2657:34cc:a51f? (p200300d82f358a0042f7265734cca51f.dip0.t-ipconnect.de. [2003:d8:2f35:8a00:42f7:2657:34cc:a51f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4a2187sm23345507f8f.70.2025.08.06.03.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 03:11:35 -0700 (PDT)
Message-ID: <e3d13396-8408-49c0-9ec9-1b02790959aa@redhat.com>
Date: Wed, 6 Aug 2025 12:11:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] mm: Optimize mprotect() by PTE batching
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com, willy@infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
 will@kernel.org, Liam.Howlett@oracle.com, vbabka@suse.cz, jannh@google.com,
 anshuman.khandual@arm.com, peterx@redhat.com, joey.gouly@arm.com,
 ioworker0@gmail.com, baohua@kernel.org, kevin.brodsky@arm.com,
 quic_zhenhuah@quicinc.com, christophe.leroy@csgroup.eu,
 yangyicong@hisilicon.com, linux-arm-kernel@lists.infradead.org,
 hughd@google.com, yang@os.amperecomputing.com, ziy@nvidia.com
References: <20250718090244.21092-1-dev.jain@arm.com>
 <20250718090244.21092-7-dev.jain@arm.com>
 <7567c594-7588-49e0-8b09-2a591181b24d@redhat.com>
 <9552ddff-d778-4934-9349-37c7237cbb78@lucifer.local>
 <54ee1971-d91a-4fe6-90b8-16212c8568d1@redhat.com>
 <0d52d680-f3d3-454f-8c12-602f650469ab@arm.com>
 <9cbe9c6a-0013-4239-9347-bf5d43021fe3@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <9cbe9c6a-0013-4239-9347-bf5d43021fe3@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06.08.25 11:50, Lorenzo Stoakes wrote:
> On Wed, Aug 06, 2025 at 03:07:49PM +0530, Dev Jain wrote:
>>>>
>>>> You mean in _this_ PTE of the batch right? As we're invoking these
>>>> on each part
>>>> of the PTE table.
>>>>
>>>> I mean I guess we can simply do:
>>>>
>>>>      struct page *first_page = pte_page(ptent);
>>>>
>>>> Right?
>>>
>>> Yes, but we should forward the result from vm_normal_page(), which does
>>> exactly that for you, and increment the page accordingly as required,
>>> just like with the pte we are processing.
>>
>> Makes sense, so I guess I will have to change the signature of
>> prot_numa_skip()
>>
>> to pass a double ptr to a page instead of folio and derive the folio in the
>> caller,
>>
>> and pass down both the folio and the page to
>> set_write_prot_commit_flush_ptes.
> 
> I already don't love how we psas the folio back from there for very dubious
> benefit. I really hate the idea of having a struct **page parameter...
> 
> I wonder if we should just have a quick fixup for hotfix, and refine this more
> later?

This is not an issue in any released kernel, so we can do this properly.

We should just remove that nested vm_normal_folio().

Untested, but should give an idea what we can do.


diff --git a/mm/mprotect.c b/mm/mprotect.c
index 78bded7acf795..4e0a22f7db495 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -120,7 +120,7 @@ static int mprotect_folio_pte_batch(struct folio *folio, pte_t *ptep,
  
  static bool prot_numa_skip(struct vm_area_struct *vma, unsigned long addr,
  			   pte_t oldpte, pte_t *pte, int target_node,
-			   struct folio **foliop)
+			   struct folio *folio)
  {
  	struct folio *folio = NULL;
  	bool ret = true;
@@ -131,7 +131,6 @@ static bool prot_numa_skip(struct vm_area_struct *vma, unsigned long addr,
  	if (pte_protnone(oldpte))
  		goto skip;
  
-	folio = vm_normal_folio(vma, addr, oldpte);
  	if (!folio)
  		goto skip;
  
@@ -172,8 +171,6 @@ static bool prot_numa_skip(struct vm_area_struct *vma, unsigned long addr,
  	if (folio_use_access_time(folio))
  		folio_xchg_access_time(folio, jiffies_to_msecs(jiffies));
  
-skip:
-	*foliop = folio;
  	return ret;
  }
  
@@ -231,10 +228,9 @@ static int page_anon_exclusive_sub_batch(int start_idx, int max_len,
   * retrieve sub-batches.
   */
  static void commit_anon_folio_batch(struct vm_area_struct *vma,
-		struct folio *folio, unsigned long addr, pte_t *ptep,
+		struct folio *folio, struct page *first_page, unsigned long addr, pte_t *ptep,
  		pte_t oldpte, pte_t ptent, int nr_ptes, struct mmu_gather *tlb)
  {
-	struct page *first_page = folio_page(folio, 0);
  	bool expected_anon_exclusive;
  	int sub_batch_idx = 0;
  	int len;
@@ -243,7 +239,7 @@ static void commit_anon_folio_batch(struct vm_area_struct *vma,
  		expected_anon_exclusive = PageAnonExclusive(first_page + sub_batch_idx);
  		len = page_anon_exclusive_sub_batch(sub_batch_idx, nr_ptes,
  					first_page, expected_anon_exclusive);
-		prot_commit_flush_ptes(vma, addr, ptep, oldpte, ptent, len,
+		prot_commit_flush_ptes(vma, addr, ptep, page, oldpte, ptent, len,
  				       sub_batch_idx, expected_anon_exclusive, tlb);
  		sub_batch_idx += len;
  		nr_ptes -= len;
@@ -251,7 +247,7 @@ static void commit_anon_folio_batch(struct vm_area_struct *vma,
  }
  
  static void set_write_prot_commit_flush_ptes(struct vm_area_struct *vma,
-		struct folio *folio, unsigned long addr, pte_t *ptep,
+		struct folio *folio, struct page *page, unsigned long addr, pte_t *ptep,
  		pte_t oldpte, pte_t ptent, int nr_ptes, struct mmu_gather *tlb)
  {
  	bool set_write;
@@ -270,7 +266,7 @@ static void set_write_prot_commit_flush_ptes(struct vm_area_struct *vma,
  				       /* idx = */ 0, set_write, tlb);
  		return;
  	}
-	commit_anon_folio_batch(vma, folio, addr, ptep, oldpte, ptent, nr_ptes, tlb);
+	commit_anon_folio_batch(vma, folio, page, addr, ptep, oldpte, ptent, nr_ptes, tlb);
  }
  
  static long change_pte_range(struct mmu_gather *tlb,
@@ -305,15 +301,20 @@ static long change_pte_range(struct mmu_gather *tlb,
  			const fpb_t flags = FPB_RESPECT_SOFT_DIRTY | FPB_RESPECT_WRITE;
  			int max_nr_ptes = (end - addr) >> PAGE_SHIFT;
  			struct folio *folio = NULL;
+			struct page *page;
  			pte_t ptent;
  
+			page = vm_normal_folio(vma, addr, oldpte);
+			if (page)
+				folio = page_folio(page);
+
  			/*
  			 * Avoid trapping faults against the zero or KSM
  			 * pages. See similar comment in change_huge_pmd.
  			 */
  			if (prot_numa) {
  				int ret = prot_numa_skip(vma, addr, oldpte, pte,
-							 target_node, &folio);
+							 target_node, folio);
  				if (ret) {
  
  					/* determine batch to skip */
@@ -323,9 +324,6 @@ static long change_pte_range(struct mmu_gather *tlb,
  				}
  			}
  
-			if (!folio)
-				folio = vm_normal_folio(vma, addr, oldpte);
-
  			nr_ptes = mprotect_folio_pte_batch(folio, pte, oldpte, max_nr_ptes, flags);
  
  			oldpte = modify_prot_start_ptes(vma, addr, pte, nr_ptes);
@@ -351,7 +349,7 @@ static long change_pte_range(struct mmu_gather *tlb,
  			 */
  			if ((cp_flags & MM_CP_TRY_CHANGE_WRITABLE) &&
  			     !pte_write(ptent))
-				set_write_prot_commit_flush_ptes(vma, folio,
+				set_write_prot_commit_flush_ptes(vma, folio, page,
  				addr, pte, oldpte, ptent, nr_ptes, tlb);
  			else
  				prot_commit_flush_ptes(vma, addr, pte, oldpte, ptent,
-- 
2.50.1


-- 
Cheers,

David / dhildenb


