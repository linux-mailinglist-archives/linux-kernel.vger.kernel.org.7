Return-Path: <linux-kernel+bounces-828815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF32B958DF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD6652E641C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28395311945;
	Tue, 23 Sep 2025 11:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="fgAra4gg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NcfKpGk4"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D61528032D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625400; cv=none; b=lszXS25V4l/zq+rCiTkqLzWUyzP+4LWJYhk1bDq3L8XFPv7LIo0yuJlhtH/1yX1djphf2QFtHYLlVGUWwCIiynsI9qFsk5UdpESAHDEb4fvbg2chfc+zMV4bfYkJj/2lDl35O56CtN8mAPqV/NUXpYp+dpQlniq2NSVN5jmWnSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625400; c=relaxed/simple;
	bh=RfBfpRKE/7ZMl8ykFEwP7BTiNT+16hYOqmKTOknndMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ExGdVZTEdxPGt8dyh7FE9G6Eg+AEmaFe4qW3njMZXESGw5slSFr2qK3HWHkykDzfNkrWE+fLBQMv1c3jHl9Bl042ERUc6CI8TLOkBkQ3Ngv6oYCn1F7uX/aRnOIPOZl0xMzckZSlqoQ++m7hoMVCpXa6w/H/POvoJnKR0366ZiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=fgAra4gg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NcfKpGk4; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 7DEBFEC0084;
	Tue, 23 Sep 2025 07:03:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 23 Sep 2025 07:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1758625396; x=1758711796; bh=v0Iv997UV6
	fMyfR2AD4bwzcf2iZuLe+1+UK+1BwCASs=; b=fgAra4gg2KoWwsNTu4d4nbdT+b
	+jCGJMm/fQRT9LT9eb65wq+PwizXsr5WB8wQgiFIe4x5Y0n471IwVE0UTPKhbGN/
	341SJhS0Yx9eStfEMaAqIDlOK3/4n/14WOG0VA+cIn69pb22VMfvp+lffq6BSa0b
	Z5unjyVg3onwA+qd0xu/d6RN7aK+iXv2TVlOj5BkmgdCGYXXzsdm0NZwzWEHD+LG
	dxXh3pHzjC8gmL2DGu0amWnN/4rINNO3iFSUsUuQfUzhl1CUafNyyFtiVCFmNv7n
	iZFf6WYXCRr7QqmLsoHQuHlxf2VaguXzO6QlTJ0pSfU2ILSQ9aplAtyxoNtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758625396; x=1758711796; bh=v0Iv997UV6fMyfR2AD4bwzcf2iZuLe+1+UK
	+1BwCASs=; b=NcfKpGk4ZgpwLCBkfJkXM/VA1m4shVyguCG9Nl76jfRigMPSdY2
	Cd4TfM+5/bEbg8O/9VtMkjMWKiHfBQUcrfxrW1ac+nKfwIGIMauyKGAhXQm5UCLr
	bxVCsW/H48yU3AXW97Ndc61jRjWSHn/Ogpf0jIJJlPcoUy96My96YUYcgwIZIqAQ
	tHpG9j941tqAVSO6YUuBdnO9E+/NxqfRrCsHmg4sVxv8lN6IfrMVBlx0HEfgbbEo
	4lpbvI4hPaxgO+DZtbU04XQDtmo4RC2ieBQblv+tF4r/zdW/iiDOZ8cXV35dzqGL
	L2dsdQrIHekKp04LV2xD8ISuJ3igSZbcU8A==
X-ME-Sender: <xms:cn7SaMGSdI08bEYpEzBg_SvLz-cWwgaI8dzA0-KcAkkRo6I9nSQm_Q>
    <xme:cn7SaBShrOfa6qKWJZnbOEDb0BWfaMhJM3qmyMDVf-2KOsozUH2XgsobPLSmMjP3Z
    abrUqUmJSiJll9VEFLLJM-fkO-b9QTaihGj9pNCmyFLK2FHdpyGuEA>
X-ME-Received: <xmr:cn7SaMQpilZtF127zMbjMcKq5O-z6J7cWVwCVTzwpycWQe_I18unNnYXtlK8FQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdehiecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:cn7SaEe5r5WHRDSR68JoxWB4haNtAduHKyEGQYl90rnZPeWoAlAX7A>
    <xmx:cn7SaAdgewjJ1ZxEoNxkJ8yTmuWYkL-4QRHpv-BpBU8JUaVIZigV1w>
    <xmx:cn7SaK_IaqrwPiCoC9HY_Drgk9oy-Cd4i2EX__9reo1Jv2wTpo6JKA>
    <xmx:cn7SaAPMt43Vpjl4Fic3wHtn8noiVWqE-s1M_25uk-6v8418F0ow-Q>
    <xmx:dH7SaOaXb4iVhWti3Xbm-GHEMwARJY5XamyJ9Tfq2CT2SBLEURHh7iU4>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 07:03:14 -0400 (EDT)
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
Subject: [PATCHv3 0/5] mm: Improve mlock tracking for large folios
Date: Tue, 23 Sep 2025 12:03:05 +0100
Message-ID: <20250923110310.689126-1-kirill@shutemov.name>
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

Kiryl Shutsemau (5):
  mm/rmap: Fix a mlock race condition in folio_referenced_one()
  mm/rmap: mlock large folios in try_to_unmap_one()
  mm/fault: Try to map the entire file folio in finish_fault()
  mm/filemap: Map entire large folio faultaround
  mm/rmap: Improve mlock tracking for large folios

 mm/filemap.c |  15 +++++++
 mm/memory.c  |   9 +----
 mm/rmap.c    | 109 ++++++++++++++++++++++++++++-----------------------
 3 files changed, 78 insertions(+), 55 deletions(-)

-- 
2.50.1


