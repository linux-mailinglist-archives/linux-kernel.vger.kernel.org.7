Return-Path: <linux-kernel+bounces-761609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CAAB1FC73
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 23:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2078D1895BCC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 21:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCCD230268;
	Sun, 10 Aug 2025 21:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lfsd4V2S"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1200214AD2D
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 21:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754862508; cv=none; b=pfFKE8BGg9qKP5OQcfmlfY5+bUaFDrBmpOa18wf739M1vnkCF9ozExIoa1wbznUMnV1pMc/dTmle0DpNiCDLjYCa69tXIoJvqqqFGCuAAcoy0U1JaWlg1BVeicdUF2vOAavBoO/w0lN0FkuyrbMM+jrHaEWrLGsZyMjoCMhr7yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754862508; c=relaxed/simple;
	bh=mBae3Rc6k6l+x8iE0UTP9m2+PZQsZp/Zr3NDvf9q5Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CrrZAksThP0LRjEFLy03uN8OrWvfBukGKk1rnMO6CFPOWFqA9u+ReZ6IYUSW7iAfv6Ve3B6rkdaSfFSJG8dNNlg+NS8jAu/Esj2tHbjpDlgVHzyIP0QVcZeiSbz4OCdukdq/1G5t6VisbneGzWEL35CYNf1L5daldj6Oe7bx9a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lfsd4V2S; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754862504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DsRVIjvDJuLJuwcP7K5TKBV9TNHb6qj3xLt5+6zs3GM=;
	b=lfsd4V2SOoMxEgiM0wJIKj0X+EcFtGa0V6VxZQV0ByYt9LYlK7rK7pgLUviBqrIMP/4JV7
	78QxrhLiu2Ue059XakSSOWpwlmELJ4VJge6d/5OF9z8JQx8wSrLgTGQ+RlcqkSmFvO0lHQ
	iR2VCimTkLCY5s8TeK0sRwcmHUghw8s=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/hugetlb: Use max() to simplify hugetlb_vmemmap_optimizable_size()
Date: Sun, 10 Aug 2025 23:47:45 +0200
Message-ID: <20250810214745.2368-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use max() to simplify hugetlb_vmemmap_optimizable_size() and improve its
readability.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 mm/hugetlb_vmemmap.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 18b490825215..4da44b1e8e1a 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -11,6 +11,7 @@
 #include <linux/hugetlb.h>
 #include <linux/io.h>
 #include <linux/memblock.h>
+#include <linux/minmax.h>
 
 /*
  * Reserve one vmemmap page, all vmemmap addresses are mapped to it. See
@@ -44,11 +45,10 @@ static inline unsigned int hugetlb_vmemmap_size(const struct hstate *h)
  */
 static inline unsigned int hugetlb_vmemmap_optimizable_size(const struct hstate *h)
 {
-	int size = hugetlb_vmemmap_size(h) - HUGETLB_VMEMMAP_RESERVE_SIZE;
-
 	if (!is_power_of_2(sizeof(struct page)))
 		return 0;
-	return size > 0 ? size : 0;
+
+	return max(0, hugetlb_vmemmap_size(h) - HUGETLB_VMEMMAP_RESERVE_SIZE);
 }
 #else
 static inline int hugetlb_vmemmap_restore_folio(const struct hstate *h, struct folio *folio)
-- 
2.50.1


