Return-Path: <linux-kernel+bounces-786392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13062B35927
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 036C41B66DF0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BD8319840;
	Tue, 26 Aug 2025 09:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nrMAKG99"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3540F2FF166
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756201011; cv=none; b=b7WJ3MCLwyBcQHsJBXOhpvpYLNg8AeK+WCoLr2YguLd2fdlNpRta8lKE5n8tX8yM9cnybmul+uu3wFz3RmIGJYnUckyTo0HfdcsaoMKY7le0ckGf7rjaNlrTGkv+w/gSJ4+nnektvxvsQvKjkee2tm1KmFHkM9o3Lif8BzhoVEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756201011; c=relaxed/simple;
	bh=6PC2ADtCtDFGuzWL+uXESXtAjU5jlj8ep21lm6FPKfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OkmHVMfBw3C+Z7bUifQIwBlkoRwWcaey+hQMtSEaNxenEchK5plBHmsDLo9aw6N4scZ1VirJfh8m4ETsx047NclL7jpTbUT5qgwGeaOn4XZ4xhvd0DuIHI5MIDmonV1QUsIZaGaVP2o4hOeNqVUr3nkufB3S10kLt56BJA5ma1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nrMAKG99; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756201000; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=tJ3nbOWerhjrpDMiqY4o+NaxmH89+vOJFKoUh/ymCog=;
	b=nrMAKG99yhnEBmwKymQiMPFE4T6O4l4EhRnkL9Zhlh0NgmwNbH15sTdark8ChQf78N/tIRgrKsbXb8f1bQTVjGaJEjXgiZqDz9xpJIGNW3RqDcwtJIZeZkAg0cvzcqPUOvt18eBWDES4bcFl5Z1uI3NtLDgtdKAsw9Bb9pTZX2E=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WmeSenJ_1756200998 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 26 Aug 2025 17:36:39 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mm: shmem: drop the unnecessary folio_nr_pages()
Date: Tue, 26 Aug 2025 17:35:55 +0800
Message-ID: <67c80182ebd949e3894908e01e224697c143aabb.1756200587.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <a2d39608d99cba1130cacd9cffbafc6949193c08.1756200587.git.baolin.wang@linux.alibaba.com>
References: <a2d39608d99cba1130cacd9cffbafc6949193c08.1756200587.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We've got the number of pages in the folio earlier, thus remove the redundant
folio_nr_pages() function.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index b3c6de84dd27..f45292bac32d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2430,7 +2430,6 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 		goto failed;
 	}
 	folio_wait_writeback(folio);
-	nr_pages = folio_nr_pages(folio);
 
 	/*
 	 * Some architectures may have to restore extra metadata to the
-- 
2.43.5


