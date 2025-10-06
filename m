Return-Path: <linux-kernel+bounces-843003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 096E2BBE2CE
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 15:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD163A9F60
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 13:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB3F2C325F;
	Mon,  6 Oct 2025 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="kcncp2vt"
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59F5286412
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759757134; cv=none; b=sURFkmVYoaKCZ4udNruqSUpmC8nZEgza88T9O5nklx3949kgPxVw4JoC2EV9BkOxoJ9H2a2Honp9IpLXIQxVg8vsf1Q4dZMNLC3K8Q49zP2BggctJbJkrzwpYEtL/AjxzyiqowDDMqcyfz5ifcRTKMlZakvNmmUPbUUiYwLuGBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759757134; c=relaxed/simple;
	bh=A0/lI9TkE2rvHUIYfh4GfU0APJ19X1E+MWlJ2rRqVns=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JBuJAcWYiYDL3f4Mv881HQDJz51FrUMGec2s7k5qgnuM3f29a0uiB6iVFjXcKAC3KTETshZVQwfm/m53s+pxkhrY+A1tcQocpjeKEdTgzQ8l/9RNh0A8bDUdy/RNtcrYEBL5lcAwLYBga3TTFMU5L3+kxUoy0t/jYS4q66iXZ+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=kcncp2vt; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id DDDB192F0A;
	Mon, 06 Oct 2025 13:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1759757131;
	bh=rN5PCrh7w5JveL97Y+GSyC7b8859L6HqEd7z3OmyMK8=;
	h=Date:From:To:Cc:Subject;
	b=kcncp2vtH8IDwM8TCGkT2vXT5kgQCTkoz2DnDLQBil1IB9AhHY5KN8DXNv0X39cG3
	 TWRy1et5J7ePsr0WFR1pmQquvpXVLmxv4ROOOzHgCTXO890uD9E+hgqgqrXQss5qbn
	 079Sp4zBN0ZASjaJMdV4UwCeJwyBiXW7ZiUUXeXU=
Date: Mon, 6 Oct 2025 13:25:26 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>,
	Chris Li <chrisl@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>
Cc: Kiryl Shutsemau <kas@kernel.org>, Usama Arif <usamaarif642@gmail.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2] mm: skip folio_activate() for mlocked folios
Message-ID: <aOPDRmk2Zd20qxfk@shell.ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

__mlock_folio() does not move folio to unevicable LRU, when
folio_activate() removes folio from LRU.

To prevent this case also check for folio_test_mlocked() in
folio_mark_accessed(). If folio is not yet marked as unevictable, but
already marked as mlocked, then skip folio_activate() call to allow
__mlock_folio() to make all necessary updates. It should be safe to skip
folio_activate() here, because mlocked folio should end up in
unevictable LRU eventually anyway.

To observe the problem mmap() and mlock() big file and check Unevictable
and Mlocked values from /proc/meminfo. On freshly booted system without
any other mlocked memory we expect them to match or be quite close.

See below for more detailed reproduction steps. Source code of stat.c is
available at [1].

  $ head -c 8G < /dev/urandom > /tmp/random.bin

  $ cc -pedantic -Wall -std=c99 stat.c -O3 -o /tmp/stat
  $ /tmp/stat
  Unevictable:     8389668 kB
  Mlocked:         8389700 kB

  Need to run binary twice. Problem does not reproduce on the first run,
  but always reproduces on the second run.

  $ /tmp/stat
  Unevictable:     5374676 kB
  Mlocked:         8389332 kB

[1]: https://gist.github.com/ilvokhin/e50c3d2ff5d9f70dcbb378c6695386dd

Co-developed-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
Acked-by: Usama Arif <usamaarif642@gmail.com>
---
Changes in v2:
  - Rephrase commit message: frame it in terms of unevicable LRU, not stat
    accounting.

 mm/swap.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/swap.c b/mm/swap.c
index 2260dcd2775e..f682f070160b 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -469,6 +469,16 @@ void folio_mark_accessed(struct folio *folio)
 		 * this list is never rotated or maintained, so marking an
 		 * unevictable page accessed has no effect.
 		 */
+	} else if (folio_test_mlocked(folio)) {
+		/*
+		 * Pages that are mlocked, but not yet on unevictable LRU.
+		 * They might be still in mlock_fbatch waiting to be processed
+		 * and activating it here might interfere with
+		 * mlock_folio_batch(). __mlock_folio() will fail
+		 * folio_test_clear_lru() check and give up. It happens because
+		 * __folio_batch_add_and_move() clears LRU flag, when adding
+		 * folio to activate batch.
+		 */
 	} else if (!folio_test_active(folio)) {
 		/*
 		 * If the folio is on the LRU, queue it for activation via
-- 
2.47.3


