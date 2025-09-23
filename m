Return-Path: <linux-kernel+bounces-828819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AA5B958F1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86F7C2E63C9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D298321F48;
	Tue, 23 Sep 2025 11:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="fxIDwv6N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I//iNIR+"
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FAE3218AE
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625405; cv=none; b=s/umUGnaIIAOKqdUcukfWs/3ZgDAI5Hwjh6BeqtDB1zDGynZXQr1Mn4y63UHvcZps5k1SrH6fMkcqjCicjqOwgu+tE+bDF91m6e7ugkS13H1f0JB98YFNXdQB90TSAYmJ+51zUl5Nq1bjIa+K8wj3cK5VRIcxZGQgm7V52gSyww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625405; c=relaxed/simple;
	bh=YdfniaI8JtjbmRmFL2P1+yzqvWlKFWQCM5NeBuYYjgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e0Diy1aydnO40aw7LYZJVCLl4axgMjwETklWFiDXv81710HfvDLObx0zulUX+M3YH2YC6xarTsr/SBo9fwOE7ejtzZ1wuJhkIsjC5xJffsg94t/wegvbH6k+dTJ2hMnThMyL+1uVFS+MIrhRzduZqYYWfRMLIL/aSdJmEwJVSiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=fxIDwv6N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I//iNIR+; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A4A551400065;
	Tue, 23 Sep 2025 07:03:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 23 Sep 2025 07:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1758625402; x=
	1758711802; bh=l+30FsNxlli8PpC3TpepLFbX1IePGlSZR2KUwpff5IU=; b=f
	xIDwv6Nw4l1i4iTtFMICkXa78Jm5zksgps7DQdUgDIPo5eTMQqU9njEZ9XF6Bg4m
	FM/TGuKU8UQdvip7vxG43or1wsjsA1SubWgf33EyJBU6CK8XAfDfsi8jjJvx0eeP
	joIojexJ0zE7/K/5ZHLuh+XNYA/yFxsG6X/r9ppf7OHdl2gAWRVPcngV4xgg+/RW
	D2ypxesd6iMcTTtihjMZy/mOIr8pCn2GKKM/2mlR7Q3FUr4KPNTODNqcR6gBhO6A
	XRoc1mbLXIHqFeOhHBcQu2QgA55sTIdgcPxqR4PdiCB208tKzfK34ofjXj3FXq46
	/AcOJ632kvY7wI40P1nMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758625402; x=1758711802; bh=l
	+30FsNxlli8PpC3TpepLFbX1IePGlSZR2KUwpff5IU=; b=I//iNIR+jivZO6pAj
	7qpoyTpnVPMx0lJKVOtzBIMdyHPNoyaW/LnJxPgtCFlZfszbAnmybSLIyWkrWi5l
	L3w//lhrF7bf7mQ7yV9gM4cp7BQwzzjotYKrFRCMlPLBivtykk3V47f82kPv34+1
	iaYXjOb6rOxV+uZZo/bqBgwGq/7g7ZlcVc8W+vfDavEnPsdu4vutcA0v8Pw/cjys
	UtFmFHwRO/z9zhF0LjwIxY3oxmd/kQDvZmqm2pm6DuWahTEbmSfwvPXD5ELugbW0
	ddtgnSLFDuVkNiwpgrJZY48U2QNHrpLKc+JX/1WF8ETiLiqW0EQBQP1fAb8ofC/g
	EhaaQ==
X-ME-Sender: <xms:en7SaP0FTkp-jKXIe6kT-5MyVDr56eJOMoYeM-VpXTJ_8v4Fl_6KpQ>
    <xme:en7SaKCZGvE7wknVZD4vjgQDq1GZJr5KVJLxb_R4w93xEDhU-xbANBvrM9vdzncGb
    XA5uuGClSkdBVSML5uWZYAeiLthVbNxUeanVaSldNcQCUA6W_Kx6pI>
X-ME-Received: <xmr:en7SaGDFurBr04QEb1BbdEfwmyoOAJV8GJdHwT10WqUFSJfQSDL2G9COnL84fw>
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
X-ME-Proxy: <xmx:en7SaLMiAGSv_ZuZVagUgM8NjQf2LLTJTYtj6Tq8FCmC3JjTxv33fw>
    <xmx:en7SaANL__ZE6lXNAVhwCTTerOtRMvjEFkkDTwzK8pDdhvSRxoid4g>
    <xmx:en7SaPs9BObgs5sLKfzIhvDIOIlqWTy96RPzcrj_Xc6TkE9LqecB_Q>
    <xmx:en7SaF8FgdeDyjw32BsXuGDaK9BgRY11BOo8IZGosg7Z208qdgr3Bg>
    <xmx:en7SaF4okFz25XVvchBB88jptyraGH9IIwrQL4DBAzPdSNZ8ZlR1Aq8o>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 07:03:22 -0400 (EDT)
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
Subject: [PATCHv3 3/5] mm/fault: Try to map the entire file folio in finish_fault()
Date: Tue, 23 Sep 2025 12:03:08 +0100
Message-ID: <20250923110310.689126-4-kirill@shutemov.name>
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

The finish_fault() function uses per-page fault for file folios. This
only occurs for file folios smaller than PMD_SIZE.

The comment suggests that this approach prevents RSS inflation.
However, it only prevents RSS accounting. The folio is still mapped to
the process, and the fact that it is mapped by a single PTE does not
affect memory pressure. Additionally, the kernel's ability to map
large folios as PMD if they are large enough does not support this
argument.

When possible, map large folios in one shot. This reduces the number of
minor page faults and allows for TLB coalescing.

Mapping large folios at once will allow the rmap code to mlock it on
add, as it will recognize that it is fully mapped and mlocking is safe.

Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/memory.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 0ba4f6b71847..812a7d9f6531 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5386,13 +5386,8 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 
 	nr_pages = folio_nr_pages(folio);
 
-	/*
-	 * Using per-page fault to maintain the uffd semantics, and same
-	 * approach also applies to non shmem/tmpfs faults to avoid
-	 * inflating the RSS of the process.
-	 */
-	if (!vma_is_shmem(vma) || unlikely(userfaultfd_armed(vma)) ||
-	    unlikely(needs_fallback)) {
+	/* Using per-page fault to maintain the uffd semantics */
+	if (unlikely(userfaultfd_armed(vma)) || unlikely(needs_fallback)) {
 		nr_pages = 1;
 	} else if (nr_pages > 1) {
 		pgoff_t idx = folio_page_idx(folio, page);
-- 
2.50.1


