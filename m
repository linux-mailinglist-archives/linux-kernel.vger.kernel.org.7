Return-Path: <linux-kernel+bounces-828824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60575B95903
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4114518A759C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AB731D389;
	Tue, 23 Sep 2025 11:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="bnuNYp3z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MOVq3Vcg"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCE0182B4
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625640; cv=none; b=Q1p0Zi+wN7EifBrog2ZaRofcLZapcj6EXGpTCixXNVFpUHOcMbF69tj3HdZqeSnvyJXLyZlT+cFKHPQvedaVl0Oyq7LLfKgG8U3lCobi4PyMlYGnxbt3fgkJnaWi/EC1uczfbkpO6p2BUdub0zqVk0vlbUsVyAuMO73gjZsK3w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625640; c=relaxed/simple;
	bh=WUyDAB4Yxde/aOTMdWuVuyxpTn6gvsi1HWQUSppt2HE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M+IC5VVu4wYuMSw1TNtkIj/ISGLYBCnF44HAYk8gMfmwNmUCpYjOrHj2+zV5rQoC1xq0Sbw6BvgDvG411zCXf6tJy/MMeqAwNEHjdeHgz/xbLuu4RNvI0KrvtPeressuYR/PmjJY9wEMXsMG3tKkgQZh1f0SrEp2hhoGGuy3gGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=bnuNYp3z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MOVq3Vcg; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id A810AEC0090;
	Tue, 23 Sep 2025 07:07:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 23 Sep 2025 07:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1758625637; x=1758712037; bh=wF9XK8/W3b
	9Sjw1kBR6CJPdbErNROqE/otknq3MpBo0=; b=bnuNYp3ze7ElSDvbaKGWKAuErF
	8OxgqAw2Z/kCMlbDfthEu13h+toRVOKGfnpOTAdaIKb1+y29K6MSyLOvFb6uMRLS
	bhEnshhoc1wJSem1tlfdCNqpFgbZ5mboHdXxNPYwNjLOZ9R7CutOEKHmlZYkjkoG
	kLXhajidW25W9AdV6fQYKStbNi3jNAEijYM3ATWnRwYsBI354s+T0mkkftFSlXOz
	NVxNCtbXjJHOaA/Vd5i5KCaVWH50wmb9Ux8L1HRC86Lh8gjumkcj4bLTYWkENyiW
	BCrROUIgTplguvEY++ZYbMG/Z0ZZYW8mRQgB3qy+mz6Z2Ngxvvc/1SIkJaSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758625637; x=1758712037; bh=wF9XK8/W3b9Sjw1kBR6CJPdbErNROqE/otk
	nq3MpBo0=; b=MOVq3VcgcZJYV+x+HzB/YzA2V7uJHuXV2M6/iwUA7SfCfBrldoQ
	j9+XO30OsqujuSYBfV3pa9sQcpyA5lyxCkYAGGadC+gG9jpNk7rLgr+YXyTmvY/x
	yqun7HbAw338+qJCkqOrUQCsu5Th6jMlz6a2JGrCkCdyz9ekPZUSDfyta6hRpEtx
	vVf0Y/V72bFX014CEwTgTB3gt9pnpfk90zhE/b2Xov3mDTVfhhGgh7C3sMily15r
	XoWXzL0y7AcUOTl9HlFm8U/La0ibcNa2w8XCzfzZ1CRW4fYZTP01bpevUNPa4k8D
	DGpKqGZ+t6zsRlipF5v/aHj5iLl3R7jMaog==
X-ME-Sender: <xms:ZX_SaD-jWDt9kHAdIB69kTTSm9VMA6hz3Y509f3D5WqGjPHu-gM0Bg>
    <xme:ZX_SaLrawFAxeEp-OqxQf2Xa2z-pS-ZcWHMQhDQG7IyMc-MOmylyFMFYd9RUVoMAw
    hSDLgz29XN1OvTF7n6pxCYFlajSE-ARlyxWp_vON0TatZ97lkpg6A>
X-ME-Received: <xmr:ZX_SaHLZ-ViYDVbAYctjyBZH3qcFj21dGWZfqynzXxgVD9pgaFi3ckbmHNPF7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdehjecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:ZX_SaF3ae89IQfljzisBLoPa6ddqv35V8N3DH5j-DtLfm08CymMSAw>
    <xmx:ZX_SaGU6Z55yhj_KOWZrZelxAJeEuEyoEWcc0qKK4BuMpxBUtkmP_A>
    <xmx:ZX_SaLU2rzh_h0ixl7EV1pvsgPC_IFwBo77FFYfq8VQB7F0inam5ug>
    <xmx:ZX_SaJEIPD0AZY72ycv3FN-e6Qrt0SoOxmbzqL0IX8P6uwhC9Rz6cQ>
    <xmx:ZX_SaJebJeGZSK2KcXa98vtabQGLUxjNOUoTvfzvNIx5tIdxzVWEC8U2>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 07:07:16 -0400 (EDT)
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
Subject: [PATCHv3 0/6] mm: Improve mlock tracking for large folios
Date: Tue, 23 Sep 2025 12:07:05 +0100
Message-ID: <20250923110711.690639-1-kirill@shutemov.name>
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

Patch 4-5:

These patches modifies finish_fault() and faultaround to map in the
entire folio when possible, enabling efficient mlocking upon addition to
the rmap.

Patch 6:

This patch makes rmap mlock large folios if they are fully mapped,
addressing the primary source of mlock undercount for large folios.

v3:
 - Map entire folios on faultaround where possible;
 - Fix comments and commit messages;
 - Apply tags;

Kiryl Shutsemau (6):
  mm/page_vma_mapped: Track if the page is mapped across page table
    boundary
  mm/rmap: Fix a mlock race condition in folio_referenced_one()
  mm/rmap: mlock large folios in try_to_unmap_one()
  mm/fault: Try to map the entire file folio in finish_fault()
  mm/filemap: Map entire large folio faultaround
  mm/rmap: Improve mlock tracking for large folios

 include/linux/rmap.h |   5 ++
 mm/filemap.c         |  15 ++++++
 mm/memory.c          |   9 +---
 mm/page_vma_mapped.c |   1 +
 mm/rmap.c            | 109 ++++++++++++++++++++++++-------------------
 5 files changed, 84 insertions(+), 55 deletions(-)

-- 
2.50.1


