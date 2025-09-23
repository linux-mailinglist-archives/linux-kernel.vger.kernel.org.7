Return-Path: <linux-kernel+bounces-828820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FF8B958F4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 785E54A3F39
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E33D3218CB;
	Tue, 23 Sep 2025 11:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="g2S6l6L3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y/X2fY6S"
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC106321F35
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625407; cv=none; b=iN7xsjjiRP9KzucdJz5Q/08KueXDCh+NQ36gOZ2HlzJ5EBCgbgnKZudHbdN+VggrVMYTVSnR4JJD02r9KOQv9sqWpeYa/cxU8ijS7YJEF51Ra+kf012hpwaVBnmu11F4MiQYtnr2LLtIcBPSTKgZHS6vtm2sZmsuHpWhyP4bfLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625407; c=relaxed/simple;
	bh=lafj3u5MfFxC2O+ZOStOOH0oQz92l1iYxy2O9Q0JtL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l/DxkVdYwJvkxUMRHCdRc0UWSq9RB8MgkdHbJwb9Df8XlXa2ETaNZY2tytCGJOkY55G8hkTLUcLYaoJMvK3FZ3xdF8EslgTP2B4LlRpwDe0vtcGYHL1+Qm0KvWiwIxCvFVyRlW+jZLl1e6mmyCagQcmLw1uHoAYEgP4KbjPQhCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=g2S6l6L3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y/X2fY6S; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EED3E1400062;
	Tue, 23 Sep 2025 07:03:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 23 Sep 2025 07:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1758625404; x=
	1758711804; bh=jFlzJ6561wUPMtQD7f6sb4ugc+4wKUHkJSRo02E7hiw=; b=g
	2S6l6L3MiMKNrVVk78Zc42IA/qVS5hU2W8/SmfolFj6PmyajazMKSkaPdK2jcjyZ
	usnOBTZQbkHfJCtyI/PliNUHMJnR5hZg5trr2AWDnCqIglt1AR55qHhnFPWUvFbQ
	dSRQ55n08Chzf/Tq1y1PnH1f4dx+PK4KRYOk+C7Rd/491iIIt0JxlVSEJQKH1f1B
	KO6tKHNVXXOIOVB06LKo9hZ8UcWU7yQdSYjNkl0hqmOv3eypaRwkYBQLCPjbDmM9
	Y4vDPril2mcwcPg6iU8x7qFVwujTznEjp1C8tTlSVRltrxw4cAM7zkdsUp2g69su
	Bt64h3faz0B1DWzo9r2Rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758625404; x=1758711804; bh=j
	FlzJ6561wUPMtQD7f6sb4ugc+4wKUHkJSRo02E7hiw=; b=Y/X2fY6SixOFXq11V
	ZjqoBW7hM6wonlm2NFcIwz8Xn8bf7NEmxX1w3YOt0Q2FcP4y57fFgc1Ngh5OjOYb
	f6YQaS41vTRwyDzwi4H5uOM4UWeLRhcRrTWq3kNOs4BA2yyO4fg1F+VsiCMuIP2v
	VooPr3YPERizes8Mh0aPKt231ZLTAz8LfyPTOrP+EyhHOEU5Go/7i/2drxRb+Myb
	2/W0i8uWuAhEUYAiqk1ZsomTEWeu/w8KPLMb+pilZgBkyFmHlncIXyVGeXEz1Phf
	lMNBcro7voHeT7Z0m0/GVh21R+GzzewTFl3S7GtcDyzWV6c1VPmMGW2fGnyb/pIX
	zgmvA==
X-ME-Sender: <xms:fH7SaKHIMfLrnPtKye16LSHklt2fYlVPZEg4NfLJfU9m5WeLYw7jDQ>
    <xme:fH7SaHTRI7WZY_32Ab4Im7Jrz9dLpcIUTbwmYMMXBqu9kJfp0I1s8sG1DKYNXGWTX
    dvH76o75kA-wIMvFadwL_Keba1bCQi5vQpOu7w769paoI6DApZGP40>
X-ME-Received: <xmr:fH7SaKQCQMCMX9gyOywilbbmpk8KyD7N-AsG9_WfC4bFNELd6TH_hbJkI7N8Dw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdehiecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:fH7SaKdQdie_-tnQsz8s2hh7eaHLb6aAEstkUi7EAhDkYfHOsNWCOQ>
    <xmx:fH7SaOcTilKhPP7o8DyTOetli2aJzcjap9kkqN7k_d5BB6at3000Lw>
    <xmx:fH7SaA-fyHqMt_fYdit-FKs0aIwXUux6u82i-_Bu7ebeHW7iLAuAGw>
    <xmx:fH7SaONSxnRORZyPyqhtBcM1-JtuHeTSs2U3eL6WKL9NzzgbX2sLDg>
    <xmx:fH7SaMK19ysvTWymXHmPF4TZpQTs8SJiLjGJf0-CR8F8r2gUx2RzG10H>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 07:03:23 -0400 (EDT)
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
Subject: [PATCHv3 4/5] mm/filemap: Map entire large folio faultaround
Date: Tue, 23 Sep 2025 12:03:09 +0100
Message-ID: <20250923110310.689126-5-kirill@shutemov.name>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250923110310.689126-1-kirill@shutemov.name>
References: <20250923110310.689126-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kiryl Shutsemau <kas@kernel.org>

Currently, kernel only maps part of large folio that fits into
start_pgoff/end_pgoff range.

Map entire folio where possible. It will match finish_fault() behaviour
that user hits on cold page cache.

Mapping large folios at once will allow the rmap code to mlock it on
add, as it will recognize that it is fully mapped and mlocking is safe.

Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
---
 mm/filemap.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 751838ef05e5..26cae577ba23 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3643,6 +3643,21 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 	struct page *page = folio_page(folio, start);
 	unsigned int count = 0;
 	pte_t *old_ptep = vmf->pte;
+	unsigned long addr0;
+
+	/*
+	 * Map the large folio fully where possible.
+	 *
+	 * The folio must not cross VMA or page table boundary.
+	 */
+	addr0 = addr - start * PAGE_SIZE;
+	if (folio_within_vma(folio, vmf->vma) &&
+	    (addr0 & PMD_MASK) == ((addr0 + folio_size(folio) - 1) & PMD_MASK)) {
+		vmf->pte -= start;
+		page -= start;
+		addr = addr0;
+		nr_pages = folio_nr_pages(folio);
+	}
 
 	do {
 		if (PageHWPoison(page + count))
-- 
2.50.1


