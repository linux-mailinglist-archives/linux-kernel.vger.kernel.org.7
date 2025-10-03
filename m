Return-Path: <linux-kernel+bounces-841382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6646BB7290
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 16:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42075486107
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 14:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDDB230BDB;
	Fri,  3 Oct 2025 14:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="h/MOC4mU"
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B58811CA9
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759501211; cv=none; b=lrWCew+ROCNzHd69FAGkALmvtAtY5yQeqrixLPLZxlyyUIG0+HNEh8Og6XG1CTfbHQhmLxDzoyCTgDbuxtTjwPMOP1JDtgw/QDwsgyZgDBxD0V7lpxZDj6x+NF7VInItEs1UP3uERthokdGV3NOrgmHDGHLgGMGj2j0R5yLNXRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759501211; c=relaxed/simple;
	bh=/JDh+wvlXTRz+SlFDMPZfNIRK1EZ9x/5Uko67P+rCQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ALNV/rMGmHQ48xLl8k3UFsXECofe4McuXPh8W2ILhFDBc2T1ohpVQLhyRvnnCXnA9wONLC76kuNb2pqKiCG/oJ1pJw+ageB8+gBL188bSrgqeRiazFF6IIDEiBknbREBytEtqzsW9VeBHPbUTRDaUNLcFN2qToDmO8c/of/IgGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=h/MOC4mU; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id E77E292E10;
	Fri, 03 Oct 2025 14:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1759501201;
	bh=3EHrOqxHMA/OJP3NNhvuJX0wv/GyYjMAhMppOzWpnfE=;
	h=Date:From:To:Cc:Subject;
	b=h/MOC4mU/LBiGmYndVUUIEI6qUURQx4JD6oTAeRqHmV60pbBj3RWyTPNsiGjpUeud
	 AjJRjynWyAjupScJG+Zfc3wDDPNc0VfBeXH5MJF1XUIbZp5j/JNCmI7GY0ohpeSZgI
	 7bnIgtb4+1xoMmm/a5b51seuc3m94HjC+jsvbCyY=
Date: Fri, 3 Oct 2025 14:19:55 +0000
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
Subject: [PATCH] mm: skip folio_activate() for mlocked folios
Message-ID: <aN_bix3wDpwYPoVp@shell.ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

__mlock_folio() should update stats, when lruvec_add_folio() is called,
but if folio_test_clear_lru() check failed, then __mlock_folio() gives
up early. From the other hand, folio_mark_accessed() calls
folio_activate() which also calls folio_test_clear_lru() down the line.
When folio_activate() successfully removed folio from LRU,
__mlock_folio() will not update any stats, which will lead to inaccurate
values in /proc/meminfo as well as cgroup memory.stat.

To prevent this case from happening also check for folio_test_mlocked()
in folio_mark_accessed(). If folio is not yet marked as unevictable, but
already marked as mlocked, then skip folio_activate() call to allow
__mlock_folio() to make all necessary updates.

To observe the problem mmap() and mlock() big file and check Unevictable
and Mlocked values from /proc/meminfo. On freshly booted system without
any other mlocked memory we expect them to match or be quite close.

See below for more detailed reproduction steps. Source code of stat.c
is available at [1].

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
---
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


