Return-Path: <linux-kernel+bounces-832013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC1FB9E243
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0A8D7A6A6B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70917278157;
	Thu, 25 Sep 2025 08:54:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F328488
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758790490; cv=none; b=XN7JVsC7DfCZEABVgi3s3CBukbbYMl5iUfM/RAKzQqXVV86/7FdsQILCPZ6tWShd/+g7OO0o/seQMOAkl2TWRfhTVgqyiLaMgeRZZ3Gf9wznc4EYXqryQwvTOWJbguHIYkUNlOsg+MIp+MFOiwZRUxbGh8gaU6XTw/q9wINsdZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758790490; c=relaxed/simple;
	bh=CGHYvEkLrDEw2ae/LBAUXfxzvYypg76WBr1rpL3qGGI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V/RKS111e8XA50aeiWgbNyCxLmhaGALh2x/0T3RKFlcguc5aCzeSGYhQoiOz01ZWL5VXn0MDYfZTbKeYNbWwGh04sfh1pywfbzgfkO0z5VXbyq6HH3L5xvqRlCtSP460dT2dbJn31OBNYU5aKLlBnoI1+gZAqevS/6O64bFekX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 147321692;
	Thu, 25 Sep 2025 01:54:33 -0700 (PDT)
Received: from MacBook-Pro.blr.arm.com (MacBook-Pro.blr.arm.com [10.164.18.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 19A693F5A1;
	Thu, 25 Sep 2025 01:54:37 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	david@redhat.com
Cc: lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH] mm: move rmap of mTHP upon CoW reuse
Date: Thu, 25 Sep 2025 14:24:29 +0530
Message-Id: <20250925085429.41607-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At wp-fault time, when we find that a folio is exclusively mapped, we move
folio->mapping to the faulting VMA's anon_vma, so that rmap overhead
reduces. This is currently done for small folios (base pages) and
PMD-mapped THPs. Do this for mTHP too.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
mm-selftests pass.

 mm/memory.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 7e32eb79ba99..ec04d2cec6b1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4014,6 +4014,11 @@ static bool __wp_can_reuse_large_anon_folio(struct folio *folio,
 	 * an additional folio reference and never ended up here.
 	 */
 	exclusive = true;
+
+	if (folio_trylock(folio)) {
+		folio_move_anon_rmap(folio, vma);
+		folio_unlock(folio);
+	}
 unlock:
 	folio_unlock_large_mapcount(folio);
 	return exclusive;
-- 
2.30.2


