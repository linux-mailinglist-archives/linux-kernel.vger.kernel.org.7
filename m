Return-Path: <linux-kernel+bounces-762505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C40B207FC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 008343A38AB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9B12D3A72;
	Mon, 11 Aug 2025 11:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BDdGv38F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153292D3758
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754911607; cv=none; b=LmW/10Eqe+Ecpp0m0ONbt8JudlRkF+NxxZOtbbioKmCoyC7ajreTr0Suc5VYhhwwi7q2uhXyKqpPaVxS76gDGO6bCENPmtXMPR+ev1eR/mVOABUPadDLG+RiWqX+A+6trtHPRYmaCBhygJVmqYNU2C4sbVgTT7Q8zvtbEeSyaFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754911607; c=relaxed/simple;
	bh=Two6z2c+eu7eJRnlv4eH9xLpdr8pvhEq/q43/f0xNIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okUG2qA1joHgHCHN25+UtD557dMCgDWMC/Eov4c791Vx/hjzx7uCt0pPPFqv+SGlGcPVVewY++im4g5GSgtZ2320TZlp49E8w6DTP36bCpeqIcVVnyRwL/SRNtKmJu5Q63MrDfIvUnLiY+hMe+AKj1Yj59ErqAy4spu7xaldeEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BDdGv38F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754911605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OPzS7A0H2JYY/4bVoDqq5vs7hjaSrgBmC9jJDJzHOMU=;
	b=BDdGv38FTCsR9k3HgS7qRI7ZDmn886QC5waZeV/bXVibiuPFFqJ4hvI5rF+s7iXQFml/dO
	7ZJXWh+4SO3TgrF78QQYfuV9JZJiSWCepaD8rBFgIcf+gpKUKAL346jmjupQNqRE94oYX2
	pQXC+ms/MxiAsh+EuHX5DcsCWAje4Yg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-i9FkOdCNM7-ZDYs2HqKAcQ-1; Mon, 11 Aug 2025 07:26:43 -0400
X-MC-Unique: i9FkOdCNM7-ZDYs2HqKAcQ-1
X-Mimecast-MFC-AGG-ID: i9FkOdCNM7-ZDYs2HqKAcQ_1754911603
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-458f710f364so28484925e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 04:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754911602; x=1755516402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OPzS7A0H2JYY/4bVoDqq5vs7hjaSrgBmC9jJDJzHOMU=;
        b=lcNwUpFGwJwQwpW1BoOgg9zouMr3k7ESZtkAJ9Wb8wLk6SFGybtuTdkAQyVisIrCkD
         ooiFa+7qRLkW3FTCB9L80AgHmQy6Au6dkHA0FuEEazRVTGB1J4bQqTejSxnQcSi/H2cZ
         Iyq9QBX+I219qKi4uc9UobzHL2D8U0EHZEOB58poVn56ovrCK7NfffIDJf/Lo0mFxa+4
         xtCcGR3n8DLdsFwGTwyi66fjjBGCoy9D/UMn/79aR32TFllWyh3hC594U/8ZQG+Odmgh
         Dioj23tGYFneSiPuLPTvN2yxjMD0i99/I0S0T1a8LAB2VunwbMx7dzWnRuJPY8I3/Mh0
         UkHQ==
X-Gm-Message-State: AOJu0YxR+PWJR0nE9tV423g9UYPEDHufSKcriccXi2JwXlsizfGmeBy0
	EGVU4MnvDzHxhtgoofz5SvZlb7dkrOCuBS0BgbypPawrso3OVbmdbKSfU5MiC4HbGo/Cogih9Gu
	uTLg8UW+eUZCTOMxW05/ifV7t/C+7fzZD0hU3H/T5McDuAJwCCtW5ydOdhO/dNIGUIxCuMXVs6P
	sCyC5MLc+AeGe5ZUVU3oqE/eSSrQWOvAVkyXGAKO6Qxn0Z9A==
X-Gm-Gg: ASbGncvgSeRKcCoDJ5gIvlAQ79wOGZxn85v5fiRPg+in7oBpvkY7N3FpMexjJh6jhF/
	0cp21tE5vLYcZ3fqj1l4xLIvKlP8ABFtKDDcRMpNiiI9kEwW9I8pei/9kiOjo9eAjRwTsKj6x19
	0EsYJUGdBYDiRVMLRbGbC7DUMlJdyk/H1ntRNPPvtSGIoGrmnbr0lhKDZdf1L4qngaXsx5IVm42
	yu7Jd5Ts1kuA4pPLd5aUxWW0xnWI246fwdPrQqZPknNJ8cLc+lAHS92Wmi9YfPCEoAJ9f2N+mn4
	e7DTPRo1FWNHCEU9EiEbq578DH/jgrwxypKHBtABz9jZ3kEyspAcB5K0UuPGEeIFP5OR8w/K7f/
	3MqD+Wc/4ouV+cYjI822QMBld
X-Received: by 2002:a05:600c:4ec7:b0:459:e398:ed89 with SMTP id 5b1f17b1804b1-459f4ea2167mr89525865e9.1.1754911602569;
        Mon, 11 Aug 2025 04:26:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2VXT8eja0G/6oYjAzMox3Wj/YsLa0WXg9I30LI+rqq9mj5h9Avu9edvonRgK7PI+OIDYPVA==
X-Received: by 2002:a05:600c:4ec7:b0:459:e398:ed89 with SMTP id 5b1f17b1804b1-459f4ea2167mr89525255e9.1.1754911602063;
        Mon, 11 Aug 2025 04:26:42 -0700 (PDT)
Received: from localhost (p200300d82f06a600a397de1d2f8bb66f.dip0.t-ipconnect.de. [2003:d8:2f06:a600:a397:de1d:2f8b:b66f])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-459e6dcdbbbsm122068765e9.7.2025.08.11.04.26.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 04:26:41 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Hugh Dickins <hughd@google.com>,
	Oscar Salvador <osalvador@suse.de>,
	Lance Yang <lance.yang@linux.dev>,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v3 03/11] mm/huge_memory: support huge zero folio in vmf_insert_folio_pmd()
Date: Mon, 11 Aug 2025 13:26:23 +0200
Message-ID: <20250811112631.759341-4-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811112631.759341-1-david@redhat.com>
References: <20250811112631.759341-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just like we do for vmf_insert_page_mkwrite() -> ... ->
insert_page_into_pte_locked() with the shared zeropage, support the
huge zero folio in vmf_insert_folio_pmd().

When (un)mapping the huge zero folio in page tables, we neither
adjust the refcount nor the mapcount, just like for the shared zeropage.

For now, the huge zero folio is not marked as special yet, although
vm_normal_page_pmd() really wants to treat it as special. We'll change
that next.

Reviewed-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 7933791b75f4d..ec89e0607424e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1418,9 +1418,11 @@ static vm_fault_t insert_pmd(struct vm_area_struct *vma, unsigned long addr,
 	if (fop.is_folio) {
 		entry = folio_mk_pmd(fop.folio, vma->vm_page_prot);
 
-		folio_get(fop.folio);
-		folio_add_file_rmap_pmd(fop.folio, &fop.folio->page, vma);
-		add_mm_counter(mm, mm_counter_file(fop.folio), HPAGE_PMD_NR);
+		if (!is_huge_zero_folio(fop.folio)) {
+			folio_get(fop.folio);
+			folio_add_file_rmap_pmd(fop.folio, &fop.folio->page, vma);
+			add_mm_counter(mm, mm_counter_file(fop.folio), HPAGE_PMD_NR);
+		}
 	} else {
 		entry = pmd_mkhuge(pfn_pmd(fop.pfn, prot));
 		entry = pmd_mkspecial(entry);
-- 
2.50.1


