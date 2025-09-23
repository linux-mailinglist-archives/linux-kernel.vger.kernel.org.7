Return-Path: <linux-kernel+bounces-828829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 251F0B95912
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6FA918A7989
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9D032252A;
	Tue, 23 Sep 2025 11:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="Eze+Ws0a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZTi2hcEK"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A9A321F4C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625649; cv=none; b=AdFu0YiLcrx5jNFWhM2UuQ0b71vWVWRkix6QLy1UI5Sv1juiwbAvlb/A0ShVJqKLmxdWN0LkbmVhDieBoSdl6IaOMI6HOnetFWqkW4LP18ZweMqAK7x+iuRdonX6iJlJ/TKP/XwB7PNFPYYGOocnAs6ytr/vK7WsHzodGyavvwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625649; c=relaxed/simple;
	bh=lafj3u5MfFxC2O+ZOStOOH0oQz92l1iYxy2O9Q0JtL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WE6ajZ5XGwuWT/zEK4mC9oGp5KKEU3ojCDDPdP7z42LdhZbC+KdL4LaRYmANfXaYsrNZpsxNOaLXFgb7UnyzZTbqcfZ70qZIr5FvO8Tv6nYu4U491olAT/a/j3HRH6fEXK7RHLHjE/S9xbAm0+TZ8Y7Qg7Vorh+1qIYHKG1DBDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=Eze+Ws0a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZTi2hcEK; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 0127AEC00DA;
	Tue, 23 Sep 2025 07:07:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 23 Sep 2025 07:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1758625646; x=
	1758712046; bh=jFlzJ6561wUPMtQD7f6sb4ugc+4wKUHkJSRo02E7hiw=; b=E
	ze+Ws0aoQB5hiu7xli1pwslSt17+MJcyNGgvrBHKLt47m4/Md6BjcySKTgOB++nC
	xA3ZbtSTPwFhnMLkMrT06I69isCgR8NWfWZz30qZOnB8xO0bFI8myTXExeXKyfGH
	m8sjTajuOZ2x/5irzu/Nwy8evqicCQRMNbvvq0qAha2Ls9OaawCHlCK8MUSPc6sn
	S3XblAcUsfnXoD3FtVJc3r1rckEfeu4PejzaKaeL+GK9YvAqWa4NHvmi1J/EXdRD
	dVVPFj/omcTcqlGjzMVhy/STMkwzNZzIapZfawd/KrWzV6o2zkUdaXW0UXanTyoj
	6k150cvLysz/gzATxgkCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758625646; x=1758712046; bh=j
	FlzJ6561wUPMtQD7f6sb4ugc+4wKUHkJSRo02E7hiw=; b=ZTi2hcEK11wqhlduw
	qtK9TkufynYkoGXDdG37857a57gfcuUX3y/iEibPSryT5Aq1Hjsa+HOzcBLj31qg
	i9NohoVPqio9QBMrjxupABty1nZl1Wk8BB1rNTHkaIKg6pHhEAy1cxq27bP9XdX5
	mqdDpc+Kjr7xV5/FBi1tqs8z/uTMk9HJZgBpd5uiKss8JIw/Iuf3MKAt7jaI3jh7
	2Wtd4x2f41kpxwiJPvX6rRJoRHLA0hp2oDBt+pyys0v1mhGpkrVbPQConU0GNIes
	x6Kf04NyeBIuAu+KQBq8r2Cn3YZTVBGsNYgG0AZYYmISEwE8HXbnO9ObcxEuW1po
	vjCRA==
X-ME-Sender: <xms:bn_SaGoWzQg_xC10MPIN1r4H7jbofypKHNCZ_eoTBIV0STgbl1491w>
    <xme:bn_SaAmGcuBLz5ZabpfodygdJubIbpoecMcUr7SXC-uXtRauPsAgviKk1Mk-eaklm
    DOSHmZ5pKy0M2tyrUHtFFFxydYjaX_H3eA5HM9R3mgb4ZAw1Kn49Q>
X-ME-Received: <xmr:bn_SaBXEXJaj92SA0cGWGkO85d-1HCopvf_Q9bboahZ4GQF4bA9oV7lps3pqbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdehjecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:bn_SaMQzrHnjNS1zKsNTmHms900OAmbJZ-9yx7NIeBWsUtUG4DiHiw>
    <xmx:bn_SaEDVQ0Is5RrOJyGTjbyE5z1m704ybpkiAlUrx2sUD_6xXl_5Mg>
    <xmx:bn_SaPTnodyBeMz9lxJ20uS_3eYVEIo4pW8HUvfvFqCKJtphAX6Q8w>
    <xmx:bn_SaGQa5B4upTTaqepxXXn9SEIPy36qgGGfEox5aUX_fUOWyF1RNA>
    <xmx:bn_SaDvM95TaG7c2RYzNlENi3tl6IRhBTVM9EBj85A6Gars9Y_qs9vrz>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 07:07:26 -0400 (EDT)
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
Subject: [PATCHv3 5/6] mm/filemap: Map entire large folio faultaround
Date: Tue, 23 Sep 2025 12:07:10 +0100
Message-ID: <20250923110711.690639-6-kirill@shutemov.name>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250923110711.690639-1-kirill@shutemov.name>
References: <20250923110711.690639-1-kirill@shutemov.name>
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


