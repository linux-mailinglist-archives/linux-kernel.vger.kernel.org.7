Return-Path: <linux-kernel+bounces-770713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18065B27E1C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EA6A563EDB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8246F2FA0F9;
	Fri, 15 Aug 2025 10:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtxIvXeC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE8427FB2A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 10:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755253153; cv=none; b=IiGG/99Kbi/L72ErT7aXV2V2FThuL+Vi2EU39/6yt9vNFeWYwfGsd0/+E3kX+HVVlZpnrnfBCHdZGwGfLk9RcyDZYNzRdFMX3IJhcmyTJeOv595YsylVvh7QuapCY2f31PeywB4heRfZdXTFEKzw79wQsMyWPXK9dgH8NLPiKD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755253153; c=relaxed/simple;
	bh=um+JeXiZbrAs0/YN/fvbnO33vFoCowSQ1SJJFzC5/qo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rY7jiPDXsBcxr+d9fzMgb7fe7IHOluciUwTQIxIrdIpNskfFT7+YFiNEDY/oLzZF5rvusFG/U4408iOZPFia9zxNveoi8tLhaqsJbdGnLwi95s8X0j/8t/qbsyUbMXVai9FffOm5SPaTnr8RNmTnzkoPNMEWj5F261ugYa69LF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtxIvXeC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4861EC4CEEB;
	Fri, 15 Aug 2025 10:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755253152;
	bh=um+JeXiZbrAs0/YN/fvbnO33vFoCowSQ1SJJFzC5/qo=;
	h=From:To:Cc:Subject:Date:From;
	b=OtxIvXeCj42F86SZKir9Tr2WK2MBFJze8EBy/vHSEXNB0UR2+JDommuakQfusGN8s
	 qih8UDAmVimta/fKQ8HsEIVdFcWobatv/uPiHscoKKEyiHw3HkhHvAdTD9kO/eXPai
	 xauVlchIodchaVuLtIg/1+intag6AQzKlmNZKIs5LWfc+KYn7SxEt+q+0Rqvw7bCtC
	 UiZoRjOvVKsbl24/progW3Qeo6Io7nOPlMnInYtpo0RugKk8ejeELcVdbvGVMsYQGr
	 uXIbZaTZnHPHdjLxsazKu3oWWW0S/vef5QreUEFgnl+/I2mghzqNK4VggNQrFQqEug
	 nFVN31brDAMVQ==
From: Will Deacon <will@kernel.org>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Keir Fraser <keirf@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	David Hildenbrand <david@redhat.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Frederick Mayle <fmayle@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH] mm/gup: Drain batched mlock folio processing before attempting migration
Date: Fri, 15 Aug 2025 11:18:58 +0100
Message-Id: <20250815101858.24352-1-will@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When taking a longterm GUP pin via pin_user_pages(),
__gup_longterm_locked() tries to migrate target folios that should not
be longterm pinned, for example because they reside in a CMA region or
movable zone. This is done by first pinning all of the target folios
anyway, collecting all of the longterm-unpinnable target folios into a
list, dropping the pins that were just taken and finally handing the
list off to migrate_pages() for the actual migration.

It is critically important that no unexpected references are held on the
folios being migrated, otherwise the migration will fail and
pin_user_pages() will return -ENOMEM to its caller. Unfortunately, it is
relatively easy to observe migration failures when running pKVM (which
uses pin_user_pages() on crosvm's virtual address space to resolve
stage-2 page faults from the guest) on a 6.15-based Pixel 6 device and
this results in the VM terminating prematurely.

In the failure case, 'crosvm' has called mlock(MLOCK_ONFAULT) on its
mapping of guest memory prior to the pinning. Subsequently, when
pin_user_pages() walks the page-table, the relevant 'pte' is not
present and so the faulting logic allocates a new folio, mlocks it
with mlock_folio() and maps it in the page-table.

Since commit 2fbb0c10d1e8 ("mm/munlock: mlock_page() munlock_page()
batch by pagevec"), mlock/munlock operations on a folio (formerly page),
are deferred. For example, mlock_folio() takes an additional reference
on the target folio before placing it into a per-cpu 'folio_batch' for
later processing by mlock_folio_batch(), which drops the refcount once
the operation is complete. Processing of the batches is coupled with
the LRU batch logic and can be forcefully drained with
lru_add_drain_all() but as long as a folio remains unprocessed on the
batch, its refcount will be elevated.

This deferred batching therefore interacts poorly with the pKVM pinning
scenario as we can find ourselves in a situation where the migration
code fails to migrate a folio due to the elevated refcount from the
pending mlock operation.

Extend the existing LRU draining logic in
collect_longterm_unpinnable_folios() so that unpinnable mlocked folios
on the LRU also trigger a drain.

Cc: Hugh Dickins <hughd@google.com>
Cc: Keir Fraser <keirf@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: David Hildenbrand <david@redhat.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Frederick Mayle <fmayle@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>
Fixes: 2fbb0c10d1e8 ("mm/munlock: mlock_page() munlock_page() batch by pagevec")
Signed-off-by: Will Deacon <will@kernel.org>
---

This has been quite unpleasant to debug and, as I'm not intimately
familiar with the mm internals, I've tried to include all the relevant
details in the commit message in case there's a preferred alternative
way of solving the problem or there's a flaw in my logic.

 mm/gup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index adffe663594d..656835890f05 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2307,7 +2307,8 @@ static unsigned long collect_longterm_unpinnable_folios(
 			continue;
 		}
 
-		if (!folio_test_lru(folio) && drain_allow) {
+		if (drain_allow &&
+		   (!folio_test_lru(folio) || folio_test_mlocked(folio))) {
 			lru_add_drain_all();
 			drain_allow = false;
 		}
-- 
2.51.0.rc1.167.g924127e9c0-goog


