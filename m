Return-Path: <linux-kernel+bounces-858812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C62C2BEBEA6
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 00:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 223774E6DA2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 22:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4DE2D73B0;
	Fri, 17 Oct 2025 22:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f24F8Ork"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4110223710
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 22:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760739822; cv=none; b=Zz8n2CY3X3RPzFRuZNc92j8puhayqbspvuOBeWEqzt/FjwdifOIeNzH9Lf41WV+/GJs4jSk2oh6iHFRJhS5h5/iKrEwLXjfWEMl7yFNRIUoKmw5jsy2OUvFG0oPWQlB6NvHPHFCjB+Ge/8bCzkubjxC6TZO5BePefJ8WivkFmOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760739822; c=relaxed/simple;
	bh=jTj7xqNHkwK0XKRTevJnTx2StPgugAcwWUIPPT3GbPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MPkYSB7WtE8o6+N147L6vYdGg6oFz7i2mO+KhtXHxFBhnXj7Sik6etA9bPFs8MIbMWpR4bqsv6WQu7x6jnfqskuA2fd6iXOE6wzjnp/+cGtAu3ijKcv7N/duB1GaXuc8G+EVtfB3v3F5mW+fcOUrN4qju5t6J4x0pTsD9sRZSW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f24F8Ork; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760739819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=x+dVoUUzmBb0nQ+poBRDWT3Sih6gX5/+Nw8MS974GdY=;
	b=f24F8OrkdzqevNO/4AlmVC/vK/39SR3bOrYRYyZjXyqN3Z5+ZqeuD9VFW2mlfJGij6DPLD
	nOhM26lBkbmbzAFgcxufa+4R7nRugJENnyppgNF1WkkiX3xJ5+tLMbeQXF/1F2dB8K1R9z
	IYhCJ7iEx4qL9hwlod2yDCnhgztGVI4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-VIEIv65FPBaxtxV3RG0Odw-1; Fri, 17 Oct 2025 18:23:38 -0400
X-MC-Unique: VIEIv65FPBaxtxV3RG0Odw-1
X-Mimecast-MFC-AGG-ID: VIEIv65FPBaxtxV3RG0Odw_1760739817
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-471125c8bc1so28899905e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 15:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760739817; x=1761344617;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x+dVoUUzmBb0nQ+poBRDWT3Sih6gX5/+Nw8MS974GdY=;
        b=WXh4qUYSZABOzFTCQQ2LO08YMZIuRH0dPiA6IWURiGRmYOleDrbQNvO9wyci/76f4t
         K7fwho0WTp7ONkCRtfFCzMo+dViW9HAZw6ay103+0yQZtl2/D4Um/ufPzeNI/r0Qwzd4
         E4yZ7PpgLyqqtveS8Y65IGPYyf9x2lLzIqAB7kP2kG5IN1abgcryDkpn/bhcyy+QtKFa
         xqVCD4Y58fCkUgOcCgyxuH3lN5BLlpwt7LRHTdrGIvkNRYoWgUtG7CWlNIKu2sw3tA3h
         aHFL5BlLGwbsHn5OYdOlV/FuKhP4kIBuXxpz6MlptzI5wqAYlbSKRna7Ypcb8d28Onw/
         C0nA==
X-Forwarded-Encrypted: i=1; AJvYcCXY0DTiqfltTEVcwnoj8ildksVZKDN3E4vHy+P5ZOu74quxKf+TnLcgxIdYYeSunqmx3QqdY6ZHmaQDVKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHDV0gQrnjzKtapsEXsDjFXnE81VM4m/LrntotS4Gf+VX0NGtT
	wOQanKiZ/U/3/6RPG8X+7n1gmSz1rViVabNi/Bbf55f0EuO2oyetCXn19ORCIEoNBeBpPD7vnJV
	UZ3bF++V0Qh1RTj/jcZKdQVuLapFrzbZS502pc/279xKDlJVSPyG3mQCoc31gr96v3A==
X-Gm-Gg: ASbGnct4CJ/pLzFj9RoqyUNX5i4wd4d4SI4126BdEaNun5fpmJQBfki8NJB44PI1f7m
	ELUFyk3Mb6kCr8XtSjk9AYOHPAmkCL9QJDnjcnKzHlr/Hiidtn3C7XLlmlp2QJQDyzKZDGQAUBH
	baDlFgrnmLLpB1vZIFHPSa0R3IEZ4AXKPNug4qr5eR6ktfNutkEoxEYiCoycdVL3rcveSXn8pFu
	TdBHRIgAyTbsW1qXrV2KdW2j9F4ptZcJHE1dIbM27b5+xCFAZy7zV89r3VNgMS32Z5M5MGWMqEx
	l7t4me66cNPr/7s0wWm45kZiJAeHMcgPe15HDXty5YbQiPaRkkZPacWuAZRUBCVQiOtvitzA2ZF
	IsMVlpHn4L/7CZHnJ1bISN1/3MugxotLq4PRVpBwbzdNTKCTue/9Q1V6TgordnNZJdKPMdsOwrz
	C0l8HFNAAMI5DqoiJ42qrZE0wJ1gw=
X-Received: by 2002:a05:600c:4fc1:b0:471:b5d:2db7 with SMTP id 5b1f17b1804b1-4711790697amr33239545e9.24.1760739817110;
        Fri, 17 Oct 2025 15:23:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtlt0Ihr/Aaaf0M+Q3hhi1pZYNkt89VmRxQ2siQChpIBmDIjC60WiNcyPKF+UdUFpnxAaGqw==
X-Received: by 2002:a05:600c:4fc1:b0:471:b5d:2db7 with SMTP id 5b1f17b1804b1-4711790697amr33239455e9.24.1760739816699;
        Fri, 17 Oct 2025 15:23:36 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce? (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de. [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a976sm1525851f8f.32.2025.10.17.15.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 15:23:35 -0700 (PDT)
Message-ID: <844af749-374e-49b3-91f0-a72e951981c8@redhat.com>
Date: Sat, 18 Oct 2025 00:23:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ksm: use range-walk function to jump over holes in
 scan_get_next_rmap_item
To: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>, craftfever <craftfever@airmail.cc>,
 Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20251016012236.4189-1-pedrodemargomes@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251016012236.4189-1-pedrodemargomes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.10.25 03:22, Pedro Demarchi Gomes wrote:
> Currently, scan_get_next_rmap_item() walks every page address in a VMA
> to locate mergeable pages. This becomes highly inefficient when scanning
> large virtual memory areas that contain mostly unmapped regions.
> 
> This patch replaces the per-address lookup with a range walk using
> walk_page_range(). The range walker allows KSM to skip over entire
> unmapped holes in a VMA, avoiding unnecessary lookups.
> This problem was previously discussed in [1].
> 
> [1] https://lore.kernel.org/linux-mm/423de7a3-1c62-4e72-8e79-19a6413e420c@redhat.com/
> 
> ---

This patch does to much in a single patch which makes it
rather hard to review.

As a first step, we should focus on leaving most of
scan_get_next_rmap_item() alone and only focus on replacing
folio_walk by walk_page_range_vma().

Follow-up cleanups could try cleaning up scan_get_next_rmap_item()
-- and boy oh boy, does that function scream for quite some cleanups.

This is something minimal based on your v3. I applied plenty of more
cleanups and I wish we could further shrink the pmd_entry function,
but I have to give up for today (well, it's already tomorrow :) ).


Briefly tested with ksm selftests and my machine did not burn down my building.


 From d971b88056fe3fefe50e5d4fa5b359e8c8331b2c Mon Sep 17 00:00:00 2001
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Date: Wed, 15 Oct 2025 22:22:36 -0300
Subject: [PATCH] ksm: use range-walk function to jump over holes in
  scan_get_next_rmap_item

Currently, scan_get_next_rmap_item() walks every page address in a VMA
to locate mergeable pages. This becomes highly inefficient when scanning
large virtual memory areas that contain mostly unmapped regions.

This patch replaces the per-address lookup with a range walk using
walk_page_range_vma(). The range walker allows KSM to skip over entire
unmapped holes in a VMA, avoiding unnecessary lookups.
This problem was previously discussed in [1].

[1] https://lore.kernel.org/linux-mm/423de7a3-1c62-4e72-8e79-19a6413e420c@redhat.com/

Reported-by: craftfever <craftfever@airmail.cc>
Closes: https://lkml.kernel.org/r/020cf8de6e773bb78ba7614ef250129f11a63781@murena.io
Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Co-developed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
  mm/ksm.c | 116 ++++++++++++++++++++++++++++++++++++++++++++++++-------
  1 file changed, 103 insertions(+), 13 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 3aed0478fdcef..8bd2b78c4f869 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2455,6 +2455,94 @@ static bool should_skip_rmap_item(struct folio *folio,
  	return true;
  }
  
+struct ksm_next_page_arg {
+	struct folio *folio;
+	struct page *page;
+	unsigned long addr;
+};
+
+static int ksm_next_page_pmd_entry(pmd_t *pmdp, unsigned long addr, unsigned long end,
+		struct mm_walk *walk)
+{
+	struct ksm_next_page_arg *private = walk->private;
+	struct vm_area_struct *vma = walk->vma;
+	pte_t *start_ptep = NULL, *ptep, pte;
+	struct mm_struct *mm = walk->mm;
+	struct folio *folio;
+	struct page *page;
+	spinlock_t *ptl;
+	pmd_t pmd;
+
+	if (ksm_test_exit(mm))
+		return 0;
+	cond_resched();
+
+	pmd = pmdp_get_lockless(pmdp);
+	if (!pmd_present(pmd))
+		return 0;
+
+	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && pmd_leaf(pmd)) {
+		ptl = pmd_lock(mm, pmdp);
+		pmd = pmdp_get(pmdp);
+
+		if (!pmd_present(pmd)) {
+			goto not_found_unlock;
+		} else if (pmd_leaf(pmd)) {
+			page = vm_normal_page_pmd(vma, addr, pmd);
+			if (!page)
+				goto not_found_unlock;
+			folio = page_folio(page);
+
+			if (folio_is_zone_device(folio) || !folio_test_anon(folio))
+				goto not_found_unlock;
+
+			page += ((addr & (PMD_SIZE - 1)) >> PAGE_SHIFT);
+			goto found_unlock;
+		}
+		spin_unlock(ptl);
+	}
+
+	start_ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
+	if (!start_ptep)
+		return 0;
+
+	for (ptep = start_ptep; addr < end; ptep++, addr += PAGE_SIZE) {
+		pte = ptep_get(ptep);
+
+		if (!pte_present(pte))
+			continue;
+
+		page = vm_normal_page(vma, addr, pte);
+		if (!page)
+			continue;
+		folio = page_folio(page);
+
+		if (folio_is_zone_device(folio) || !folio_test_anon(folio))
+			continue;
+		goto found_unlock;
+	}
+
+not_found_unlock:
+	spin_unlock(ptl);
+	if (start_ptep)
+		pte_unmap(start_ptep);
+	return 0;
+found_unlock:
+	folio_get(folio);
+	spin_unlock(ptl);
+	if (start_ptep)
+		pte_unmap(start_ptep);
+	private->page = page;
+	private->folio = folio;
+	private->addr = addr;
+	return 1;
+}
+
+static struct mm_walk_ops ksm_next_page_ops = {
+	.pmd_entry = ksm_next_page_pmd_entry,
+	.walk_lock = PGWALK_RDLOCK,
+};
+
  static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
  {
  	struct mm_struct *mm;
@@ -2542,21 +2630,23 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
  			ksm_scan.address = vma->vm_end;
  
  		while (ksm_scan.address < vma->vm_end) {
+			struct ksm_next_page_arg ksm_next_page_arg;
  			struct page *tmp_page = NULL;
-			struct folio_walk fw;
  			struct folio *folio;
-
-			if (ksm_test_exit(mm))
-				break;
-
-			folio = folio_walk_start(&fw, vma, ksm_scan.address, 0);
-			if (folio) {
-				if (!folio_is_zone_device(folio) &&
-				     folio_test_anon(folio)) {
-					folio_get(folio);
-					tmp_page = fw.page;
-				}
-				folio_walk_end(&fw, vma);
+			int found;
+
+			found = walk_page_range_vma(vma, ksm_scan.address,
+						    vma->vm_end,
+						    &ksm_next_page_ops,
+						    &ksm_next_page_arg);
+
+			if (found > 0) {
+				folio = ksm_next_page_arg.folio;
+				tmp_page = ksm_next_page_arg.page;
+				ksm_scan.address = ksm_next_page_arg.addr;
+			} else {
+				VM_WARN_ON_ONCE(found < 0);
+				ksm_scan.address = vma->vm_end - PAGE_SIZE;
  			}
  
  			if (tmp_page) {
-- 
2.51.0


-- 
Cheers

David / dhildenb


