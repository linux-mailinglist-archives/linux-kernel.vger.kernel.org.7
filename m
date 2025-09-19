Return-Path: <linux-kernel+bounces-824531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BE0B897EC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF3321C2889F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B1121507F;
	Fri, 19 Sep 2025 12:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="obLAWdcH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n8+eomSU"
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A922066DE
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 12:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758285648; cv=none; b=lXkqSGkAGsnFc6yMMvlrlYmOZVCkHBVoDBN7azG3a20c1fM+Wy+6VM61o7Fjc0Mq+Y7lAp7IutP6myWTjOEJuhNxD0ajKyRE6+ejxm+G+nTWV5geRm2SdoEgs6c5jJstcuCoy+9PJhbQHf+rubGXCJrRh0yL2gD8lVo0lH7seuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758285648; c=relaxed/simple;
	bh=k/heMrK8t0hzL7/yyTezvp5EK/48PVIsBkKMmC1F0SA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6EyPzgEw5J5L9RxUNOz71MfKVsCNk/CNJ9jw3Cq6bv8NZPJjdt2Vr5EJgOWIiOgRKpdmXFJ1Y3uuFpik8Es0xCbCmZzJK/kF2hA8ubiHeY3rL550BgvyVT1KYpoJRyJSrcBjhVfoB+/MyJ+kFmQA+kJe78exyirv94pa6UDlH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=obLAWdcH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n8+eomSU; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B76011400167;
	Fri, 19 Sep 2025 08:40:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 19 Sep 2025 08:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1758285645; x=
	1758372045; bh=wuvDNaiAvAvSGeMLUplFIMVyMw23wgCwW9wv1JnwK0k=; b=o
	bLAWdcHu6MBmN0v7b8k006MBalYYsTHkKHHEyNeUVIWS4zDmTG5RsWD8Eu4st2Ep
	x72rwYjx8/VZSKfPMntKi/yCB9kcpj2DA8YiSK9DEnlZNX63ZM71YCGeT0/Og8R9
	+dBNsiy+urY11QyDWDDGMJHKSjB01/d2dz0mBn8OJCE80Sg8svPjocsh+M2VkpNr
	JHcup192PXiAwE4DQLbKbqtKWrrg+RedH6NkchsiXZK1O4LeVZxf/ylDlyNsOdy6
	yqj3ASnHOfgO6Ifs2HU43VngeJ3qsVJkVxM8LyYQ+CeQIg5Sknwes9/9urg+U7XM
	CFoGvWUtYJC7I4nDwE07Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758285645; x=1758372045; bh=w
	uvDNaiAvAvSGeMLUplFIMVyMw23wgCwW9wv1JnwK0k=; b=n8+eomSUAJxKDuHxM
	4xsvKPdkstKitVeOM0yyacKzVbSCU0U4yq/NsCsqYSC8VhwTKAT/xnXpA2jt6igB
	+vPpQE41onWAX3881u4ytmZwOyfNoqQz6drMzZ7bag34xB5BT9vuf2iCknQElzUM
	GyTA9Up8PEukDhJU7Zp4WfDKgjSp/RRn7TEWReABsMXe0ck5ALgsTvhPti2cI4Wm
	i3Lg2mXCuiN5EjJO9kpGR9obr6tR0PLEvyw1IwcoPvUhkcPW3XGpQvav7TKui3Jw
	SO1pqm4NfW9FlkvyaRykShUN8NQYYybdqY+BhDpwm401EWRLrIp38DV5OAwqtEDt
	CJHvA==
X-ME-Sender: <xms:TU_NaKecyUMhU_G7m3PTi4NGOlJ9QR8Irqo4-_bnYbX8F_C_eAi1-Q>
    <xme:TU_NaFtZa_49KYfftmT3E94S-N87l87G7hd_sb5RmqtHgAB6ivTJQmL-FYkxUQWU3
    emsmUeR2FLzjvQapqc>
X-ME-Received: <xmr:TU_NaJKmhjL9XkundVcTR7t9rMD24Ygv_aqanCKUKZ7IMPGNqiNodhe1TlmVSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegledvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvqeenucggtf
    frrghtthgvrhhnpeegveehtdfgvdfhudegffeuuddvgeevjefhveevgefhvdevieevteei
    vdehjefhjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepudek
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouh
    hnuggrthhiohhnrdhorhhgpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrdgtohhm
    pdhrtghpthhtohephhhughhhugesghhoohhglhgvrdgtohhmpdhrtghpthhtohepfihilh
    hlhiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlohhrvghniihordhsthho
    rghkvghssehorhgrtghlvgdrtghomhdprhgtphhtthhopehlihgrmhdrhhhofihlvghtth
    esohhrrggtlhgvrdgtohhmpdhrtghpthhtohepvhgsrggskhgrsehsuhhsvgdrtgiipdhr
    tghpthhtoheprhhpphhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhrvghnsg
    esghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:TU_NaPbKU7RZoC7cDCDnQP7Aa4UmWzeppB1IS6hI2zuyl98CQvojIQ>
    <xmx:TU_NaHIK9xssbI0oQus0Y51XNXXFuwA_jfDMLmfcp-h1mbtbYVFw2Q>
    <xmx:TU_NaAr-SKP9MnWpYtY1lgRj1bS6V-XO27dPEztvBWZlDGSPzAQjjA>
    <xmx:TU_NaIC9o1nqKx-9tUZywA09o2h9mzJH-3rRrtOVF7PHs3NBJg9YCw>
    <xmx:TU_NaAlAKvWgzOC8tCHBVvY3T7_VBwtq9hVA_jSMlGHr7NppcWpW_a_W>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 08:40:44 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kiryl Shutsemau <kas@kernel.org>
Subject: [PATCHv2 1/5] mm/page_vma_mapped: Track if the page is mapped across page table boundary
Date: Fri, 19 Sep 2025 13:40:32 +0100
Message-ID: <20250919124036.455709-2-kirill@shutemov.name>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250919124036.455709-1-kirill@shutemov.name>
References: <20250919124036.455709-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kiryl Shutsemau <kas@kernel.org>

Add a PVMW_PGTABLE_CROSSSED flag that page_vma_mapped_walk() will set if
the page is mapped across page table boundary. Unlike other PVMW_*
flags, this one is result of page_vma_mapped_walk() and not set by the
caller.

folio_referenced_one() will use it detect if it safe to mlock the folio.

Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
---
 include/linux/rmap.h | 5 +++++
 mm/page_vma_mapped.c | 1 +
 2 files changed, 6 insertions(+)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 6cd020eea37a..04797cea3205 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -928,6 +928,11 @@ struct page *make_device_exclusive(struct mm_struct *mm, unsigned long addr,
 /* Look for migration entries rather than present PTEs */
 #define PVMW_MIGRATION		(1 << 1)
 
+/* Result flags */
+
+/* The page is mapped across page boundary */
+#define PVMW_PGTABLE_CROSSSED	(1 << 16)
+
 struct page_vma_mapped_walk {
 	unsigned long pfn;
 	unsigned long nr_pages;
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index e981a1a292d2..a184b88743c3 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -309,6 +309,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 				}
 				pte_unmap(pvmw->pte);
 				pvmw->pte = NULL;
+				pvmw->flags |= PVMW_PGTABLE_CROSSSED;
 				goto restart;
 			}
 			pvmw->pte++;
-- 
2.50.1


