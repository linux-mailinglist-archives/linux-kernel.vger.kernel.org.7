Return-Path: <linux-kernel+bounces-824530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA228B897EF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACA164E6264
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348DC207A20;
	Fri, 19 Sep 2025 12:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="QH5Vv8m3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KN44OSeh"
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A3F1F03C9
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 12:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758285647; cv=none; b=CnyBUpgFjZDv7fhoyEBwH/Do27wXlrJTovyOSBQW0Q9Xzk9EgZqVqqWmRkmFLq2CjR/kdHPM4hvZhbwv9Pw63p1/eXs7n7GO248EG1N00wXlGryxPafULrd59eb1FtYe+XRFaW1wdraR3Lh6N5BTl0Ptkb/ito0pazrERkj8Z/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758285647; c=relaxed/simple;
	bh=v8xY6aOVlVzdFLP8hH0KAIueqFYJ/DruWRfE46DtyJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=saFJ2d+SAm/6ww2WHAtrLx+aPAKs54AIsmIJ/qIAT6Lii4+JmJg3sLy6D7XkMELG3FYOOx4Fs7pZKQN1+YLM5wTLLNc5J44Hd5kGcaB+CsQAll09tWp8oJ46nvZO9hAOCJzXO0O7cp7IVypt+B1t9zanp2ZcKkJgJowexghvKAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=QH5Vv8m3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KN44OSeh; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id A0E78EC0312;
	Fri, 19 Sep 2025 08:40:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 19 Sep 2025 08:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1758285643; x=1758372043; bh=5ffMgn6FQ8
	q8wMzL0rsTpcxSZvUCmzDPBgGe/s15TYQ=; b=QH5Vv8m31EOxWboUzadoDGl0GW
	gz17AK5vWXvqWhErWMUsnW6EUNYVwtgU+5R8nU2I1/gi+oZkkpKeuva1gy3CbTQo
	x4ozQe97L5CikqvD7HYXi3nKoSTgHOtYfPfVzlFpsuvYr5+9NLiA5xRLyY+blEwc
	sNyIYpCEO203rfFjNId6eMjPu9xBr6+3srsGpfzmXuChAt2Hu+Wwh8IxOvw2V2Wt
	Ssz104yvqR7gl9lKk/RYw7r0Ggqgww2TjrCZ90bQE5PdJtv3Dc45LNmK3XSKunf6
	phcerSoZlkBSPN5sVOmHanHAh+YbTv5FQQazKcIdPBwbSSFzebXnRLIf2ESg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758285643; x=1758372043; bh=5ffMgn6FQ8q8wMzL0rsTpcxSZvUCmzDPBgG
	e/s15TYQ=; b=KN44OSehQvkxNLqtg0E1OFob8NKIhzpvw1RJpsBNDJEtKV3V8tx
	GvD4/WaclTmhewrdgYaRSgIqUGyhXQ4eYww9TzPtgnRL7jnG1Npdxc7z6txoayJi
	04Ivaz+LV92X1cBypkPxcBiL6DsqWo4RzUUnentes0JNA5Xw2DAvaa0vO+yDh/cW
	OsDaU52Ii/leuDHnVXniEtR1kWF7XUELZWv0ORVBIUpFSgGBMXEImAgDCg7hm9vh
	WSQxwHBmuyeyYIJP0U5eReaTrzoU76s4rNDxURo1f7vjfuElTuoLvR6uFXrVTFp+
	eutP/3MIFcQuPoD36GKGn2+coIekH4/UcVg==
X-ME-Sender: <xms:SU_NaH5vzBLDonSspRbyQGhQcl3hF-5tNFWmaV0Rm_K8lFUN6Ho-vA>
    <xme:SU_NaOZIQHw0WGXtEVTo3B1msq96Cgld_9qLO07XSKMLMynx0nhjaZeFeFSGFaqlu
    JbTrwIH0SMD-Ur8o38>
X-ME-Received: <xmr:SU_NaMGGi3M8IsgUSToVwguv8sFqQqyngGH3X_SY88Z2WHNZGQ0svH5k-l2W9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegledvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefmihhrhihlucfuhhhu
    thhsvghmrghuuceokhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrg
    htthgvrhhnpeetffduudehveejfedugeektddtvedthfehfeehteffleetieevhedvfeeg
    tdehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepudekpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnug
    grthhiohhnrdhorhhgpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrdgtohhmpdhr
    tghpthhtohephhhughhhugesghhoohhglhgvrdgtohhmpdhrtghpthhtohepfihilhhlhi
    esihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlohhrvghniihordhsthhorghk
    vghssehorhgrtghlvgdrtghomhdprhgtphhtthhopehlihgrmhdrhhhofihlvghtthesoh
    hrrggtlhgvrdgtohhmpdhrtghpthhtohepvhgsrggskhgrsehsuhhsvgdrtgiipdhrtghp
    thhtoheprhhpphhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhrvghnsgesgh
    hoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:SU_NaPl4JTKKNFiSytw23Ftl5LjnMJRiHJ2szK4DSKG8zTEq4fEQdg>
    <xmx:SU_NaLnTWBULLdvwxIQUL_wiTKEYleJZAv40Zcahc4iNTdCBrRYWbg>
    <xmx:SU_NaEV7NczE2rYtl0xLK5upqNyz_qYY7KH-4nWBvPDlyWJI4KIvXQ>
    <xmx:SU_NaJ8RPNtkhAILe1nYtpcmPc77xmQbvUkwxfOS1352TNgOE4gxmQ>
    <xmx:S0_NaDBIHz6JkTOxf4KonVMn_PB8Io-leM5eeoFdhkzs_bObbxq-CUBf>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 08:40:41 -0400 (EDT)
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
Subject: [PATCHv2 0/5] mm: Improve mlock tracking for large folios
Date: Fri, 19 Sep 2025 13:40:31 +0100
Message-ID: <20250919124036.455709-1-kirill@shutemov.name>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kiryl Shutsemau <kas@kernel.org>

The patchset includes several fixes and improvements related to mlock
tracking of large folios.

The main objective is to reduce the undercount of Mlocked memory in
/proc/meminfo and improve the accuracy of the statistics.

Patches 1-2:

These patches address a minor race condition in folio_referenced_one()
related to mlock_vma_folio().

Currently, mlock_vma_folio() is called on large folio without the page
table lock, which can result in a race condition with unmap (i.e.
MADV_DONTNEED). This can lead to partially mapped folios on the
unevictable LRU list.

While not a significant issue, I do not believe backporting is
necessary.

Patch 3:

This patch adds mlocking logic similar to folio_referenced_one() to
try_to_unmap_one(), allowing for mlocking of large folios where
possible.

Patch 4:

This patch modifies finish_fault() to fault in the entire folio when
possible, enabling efficient mlocking upon addition to the rmap.

Patch 5:

This patch ensures that rmap mlocks large folios if they are fully
mapped, addressing the primary source of mlock undercount for large
folios.

Kiryl Shutsemau (5):
  mm/page_vma_mapped: Track if the page is mapped across page table
    boundary
  mm/rmap: Fix a mlock race condition in folio_referenced_one()
  mm/rmap: mlock large folios in try_to_unmap_one()
  mm/fault: Try to map the entire file folio in finish_fault()
  mm/rmap: Improve mlock tracking for large folios

 include/linux/rmap.h |   5 +++
 mm/memory.c          |   9 +---
 mm/page_vma_mapped.c |   1 +
 mm/rmap.c            | 101 +++++++++++++++++++++++--------------------
 4 files changed, 61 insertions(+), 55 deletions(-)

-- 
2.50.1


