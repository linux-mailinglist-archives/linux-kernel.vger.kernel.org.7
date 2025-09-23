Return-Path: <linux-kernel+bounces-828825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9FEB95906
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FB064A3BCD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A74832144A;
	Tue, 23 Sep 2025 11:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="SchjqWK+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f9y5kwR3"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23902302147
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625641; cv=none; b=sSmNLLW5WugKlQy+7F/yErDSiql/b9zAnxoOn7Yd9TTQ5SH4DzRG2atRhM4+WnG460xpcxn931u6O5ZZc8oROGvOIcsoMYEUhP9CZWM9Agp2MZo5vUkAODVmqNItZzLzV+W7p5MpP1fYBkYIsH7A7npRORfrLsXuHzuWvjIPRfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625641; c=relaxed/simple;
	bh=dBXptdRKA9KW6Ngd9rPNHSX/FgTaV8W/XBdmVDj1b9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtdXaD/hZ3+ySWI06QURIHueyhyEoIwxlC0M4RrFuv7PE86yh+JcSqurQ8lEwKpvTlINCaJbudFGgl4doUB8nQ9BU+jIP/hMKdMnuvzXjQP94M+LRK4sUiUChVEpU5Gb/xnwDbUSol7yUF7eTj7v+MwxZ+xh7C0+Y19Z2ii3NUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=SchjqWK+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f9y5kwR3; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 5B2D9EC00A5;
	Tue, 23 Sep 2025 07:07:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 23 Sep 2025 07:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1758625639; x=
	1758712039; bh=Wor6PRx1QN3N2Jn0DTyxYTrVkZQE63Z4seZ89Q90skw=; b=S
	chjqWK+1KSkK9UwLFDRfV4UbDhPO9X3BD2D5KPkGafBjqAFI3/xKJz/aTk4Pydj0
	NA8tel/EghrYm5dSgvT4O8VYL98C2aVZP4nSPIKfEX+udHzUml4EDIbCgLTnWRfG
	kgd3z3zU5SkOvC4xsCtaFh5J7CxQU0j6DWPuT6pU9S2xyysxzJrqVDtS6T1hqJqW
	Q/Z5fDWiT9O8kt0GiCbpqkcCihNVedORTQgSkXi0W9RaYhBCH+IPpmC24thrUnL0
	H7BwERL31sHxzsSeiDYI+JCtvW4o07Tvm/V6kNoseh9adNXhBDtt3ys5ymlacEG0
	GaSlwg9frLJ0SI3u2yS+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758625639; x=1758712039; bh=W
	or6PRx1QN3N2Jn0DTyxYTrVkZQE63Z4seZ89Q90skw=; b=f9y5kwR3kWPrmyRjd
	d4xfoymuXHvtf2tqUXImyPDrXKjSEkuYb5HAaBwpT4NKDTD/ludYfoHrkkFYQ/wt
	xeRacKpLSeUonOfZNe5F9Eb47xu3DfrldItqemNchQr5CEGRlM6GZ6vfwhDkykOb
	SJgLfWPz1u3Ilz+Q5jCcrecOHYZvQNKuBLvgSl6/IlYkO7jmMh0CyHDk4a01U6rj
	5KzLRh78MAEcRFBsycWQBdyTZDY1qGKOioTBSexhg0Yw8M/E/GrCDWEljjRnCoEY
	9Uw1BxPcYFrq+fPHb/ojeKyFxHsxGKMSoSrL5AfUzTj/ObUF5XO1XRed/XZAX19J
	MtKmA==
X-ME-Sender: <xms:Z3_SaOlKdvzVL4X0EDxaF8Q0Lpon_jwpNPheSjkeLUcgLBwsSRU7FQ>
    <xme:Z3_SaBz6uytnZ8UWVs0VYfCZN9dM1wmy0lEEZxDmuN55CH5tlzz_gVbgyi9hEQlRQ
    tPeDbZxKUHvOHKCIWdzV-jWp6zlmYxnqusHG_pWZ5G83mkRSjvTKQ>
X-ME-Received: <xmr:Z3_SaCxCcB6BoV4a0n-PqYb_houS5o1C8a_noTg5P5Is-piHGLAfKl2aN2-boQ>
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
X-ME-Proxy: <xmx:Z3_SaI-NdRy-dfd4AMhKZRHPS6KsrOgSVcUR1sqwxHukRVRqNjYAag>
    <xmx:Z3_SaK9yz0kwLuyU1j2O-sPY6F3iZV4NWRtJj7p_wDu5xE5vwLqrGQ>
    <xmx:Z3_SaDeq2eaijQrcGMH1zgOATx-69piBg-o1LIxi3CyJfX5Xri4ehw>
    <xmx:Z3_SaOsC7sDcM_9Ew1lSyyhiBJJdu1kJ15xm0wfxviAM3xcXYyAozw>
    <xmx:Z3_SaG560wPYGfp947wcmhwyj1NyQojdEWhdpMlIGqxx_SL4ak993rSb>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 07:07:18 -0400 (EDT)
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
Subject: [PATCHv3 1/6] mm/page_vma_mapped: Track if the page is mapped across page table boundary
Date: Tue, 23 Sep 2025 12:07:06 +0100
Message-ID: <20250923110711.690639-2-kirill@shutemov.name>
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

Add a PVMW_PGTABLE_CROSSSED flag that page_vma_mapped_walk() will set if
the page is mapped across page table boundary. Unlike other PVMW_*
flags, this one is result of page_vma_mapped_walk() and not set by the
caller.

folio_referenced_one() will use it to detect if it safe to mlock the
folio.

Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/rmap.h | 5 +++++
 mm/page_vma_mapped.c | 1 +
 2 files changed, 6 insertions(+)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 6cd020eea37a..4f4659c0fc93 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -928,6 +928,11 @@ struct page *make_device_exclusive(struct mm_struct *mm, unsigned long addr,
 /* Look for migration entries rather than present PTEs */
 #define PVMW_MIGRATION		(1 << 1)
 
+/* Result flags */
+
+/* The page is mapped across page table boundary */
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


