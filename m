Return-Path: <linux-kernel+bounces-758790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F400B1D3D8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC0D723623
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981C425C81E;
	Thu,  7 Aug 2025 07:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfPTS2E/"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B665D23C512
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 07:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754553502; cv=none; b=ssf9BneaXGOWHETPCz6fX2V3Vkr4jY0oAuL3Sk8523dJvzDCChCH8Yn0evmIHTV0gtQV49b67zTjI8F+nM1+CpkxuaPAGKAplZ7bA4mP+ly5Oy0F8+6r5Us5s40aIsyHhwstkEh/MfIJWLVEPUk3d0vQ+WZcdias9R/pmSchshg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754553502; c=relaxed/simple;
	bh=EnCnhUOU3ozD2hOZtAn17B7WhM+7c4v3MBW0V/DSNh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NxZLyWy6fRudk4RVnVcCzH6pMgOFt2vm3m1Wy+OBN+uTqLpdAELxsf3y2ktpf//9z9gvYsaPOvu0G+Q5hLLBt307WGFqARu449jogQN431R1lf8XVnNtfa9mx3EUr02QdVMYd5+qsYWV+gy+Bke6jADZMWmIP10ljytYNP1opeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfPTS2E/; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-555024588b1so808551e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 00:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754553499; x=1755158299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PB2hdcyBc78jv+lWchIG70ZsML6HrtP/MWqUFpv15TI=;
        b=VfPTS2E/FkgnANaQCWxGD1EJfZr8PnptztmzsGakn/TpZNkqsMF2y+CrcmAQ2vkWNU
         WwMkrDaZv9OqcMPcufyIq6712VOxZjU1bo0Tx8bL3TPnu2K4HM/plJoR/Hl4HYUK7sQq
         rM5jH8wRhs3WS1EgeLlzOv6yJ1WUqmrpRzEZLzwGXjzMdPaL2pxxVchXjQlgWzttyT4d
         kM7mq1etrGPG84+jq//mvSCoFKwT/ewpUCm4U9I4j75vXqvkg7u0xFsFh0JiTtKzXsA8
         HX3vZVYKQGQlAvNvGIMU6Xh9GRKpY1XKTNQf7lzTrNS3nB7y3NjgbyNF6mI5xSZYQhpu
         y6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754553499; x=1755158299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PB2hdcyBc78jv+lWchIG70ZsML6HrtP/MWqUFpv15TI=;
        b=sP+6/H3vxGTnMb1qVNSyFDR9UyhfdcAwTL4sCM2JfIbVm1dfzmeUmbWRbt/g3TNxHY
         CItPlE57GRT4bowooCgo53PchKT9OaPUmHoppZwWSyGtDIwebGwAz98UnrxfHJgiPN+V
         wJi3mzJ4bbwsHjlH28wb6O0y5ho7e/GBt/0qjk+MtMvRMSHNUa5nDW+RTk968RjDCIQb
         ivWv/aRCWemat2WiW1cS81Uyq0p2McK5mzvVPPXMxm249bPL24v7EnLbZrZS9Fc0QlbK
         TQUeiwfeSaGOLJl/ilioXsbsbG8u5MGCMi7jIYXWeIW0OkXoLeMLMMXXgManMhjgjZ4L
         ZZXg==
X-Forwarded-Encrypted: i=1; AJvYcCXV2pkb8MdK6wCJL96Yh0EWXVBffYSwi4bEZ4QCLnj96tvT/VRggXDcWw/OBFXkSRazmxjYPv8aHmp08Pk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwlHGRVE3sq0ChL58La47+LJdb8DLqn5ZgJZHrGi/qxfkgsqNd
	8QtV9mEiHjG8WCNR06ByAULtAJE3Y7h3ScPYaUFABUV8UzokovLmjpMk
X-Gm-Gg: ASbGncvBuWfUicA4tHS9mwt9gJVNnJOYdSB9YAPqf2GYaZuLcFDz18iGoUXL3UlS4N6
	M+4H4J5mQrhHjCGnud6rHMScjRhqGWSZ9GqSr0NgQYUBS19VoX97hnFf58b5J5Prj08FVSmjA6q
	9AkNNi+d1MF2QNOO3OyVnYojG3VPqDqO1BjZ7rg6NqT+DapAxXHB8Au2NrmGvSuKlTOrrUhYuoS
	6buaGyZr8UW7JRnphbzk6jDLsK7FDUGnSLMVhBr9NsC2jmv3jACu877eLPFy8O+eQCeQEzedvMT
	YpMXKkWTEBqLgVtRqOMLtTG6cwJUAmsKTso9mGfhnaq41xrUdFnXvYlalfbwpf/Ws8k6jS9SQUn
	BG+4oM9aiWaHrK9iV4Q==
X-Google-Smtp-Source: AGHT+IH7eNza3QdzdJI0nkjydHqHWK39WdUxuso+aZG54nOcbhurwJGo0pLdj+Omq2eD29gZqs9iEQ==
X-Received: by 2002:a05:6512:3b07:b0:55b:872f:d732 with SMTP id 2adb3069b0e04-55caf5f3bc2mr1863131e87.26.1754553498550;
        Thu, 07 Aug 2025 00:58:18 -0700 (PDT)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c9b1fesm2501995e87.96.2025.08.07.00.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 00:58:18 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH 7/8] mm/vmalloc: Support non-blocking GFP flags in __vmalloc_area_node()
Date: Thu,  7 Aug 2025 09:58:09 +0200
Message-Id: <20250807075810.358714-8-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250807075810.358714-1-urezki@gmail.com>
References: <20250807075810.358714-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch makes __vmalloc_area_node() to correctly handle non-blocking
allocation requests, such as GFP_ATOMIC and GFP_NOWAIT. Main changes:

- Add a __GFP_HIGHMEM to gfp_mask only for blocking requests
  if there are no DMA constraints.

- vmap_page_range() is wrapped by memalloc_noreclaim_save/restore()
  to avoid memory reclaim related operations that could sleep during
  page table setup or mapping pages.

This is particularly important for page table allocations that
internally use GFP_PGTABLE_KERNEL, which may sleep unless such
scope restrictions are applied. For example:

<snip>
__pte_alloc_kernel()
    pte_alloc_one_kernel(&init_mm);
        pagetable_alloc_noprof(GFP_PGTABLE_KERNEL & ~__GFP_HIGHMEM, 0);
<snip>

Note: in most cases, PTE entries are established only up to the level
required by current vmap space usage, meaning the page tables are typically
fully populated during the mapping process.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 2424f80d524a..8a7eab810561 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3721,12 +3721,20 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	unsigned int nr_small_pages = size >> PAGE_SHIFT;
 	unsigned int page_order;
 	unsigned int flags;
+	bool noblock;
 	int ret;
 
 	array_size = (unsigned long)nr_small_pages * sizeof(struct page *);
+	noblock = !gfpflags_allow_blocking(gfp_mask);
 
-	if (!(gfp_mask & (GFP_DMA | GFP_DMA32)))
-		gfp_mask |= __GFP_HIGHMEM;
+	if (noblock) {
+		/* __GFP_NOFAIL and "noblock" flags are mutually exclusive. */
+		nofail = false;
+	} else {
+		/* Allow highmem allocations if there are no DMA constraints. */
+		if (!(gfp_mask & (GFP_DMA | GFP_DMA32)))
+			gfp_mask |= __GFP_HIGHMEM;
+	}
 
 	/* Please note that the recursion is strictly bounded. */
 	if (array_size > PAGE_SIZE) {
@@ -3790,7 +3798,9 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	 * page tables allocations ignore external gfp mask, enforce it
 	 * by the scope API
 	 */
-	if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
+	if (noblock)
+		flags = memalloc_noreclaim_save();
+	else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
 		flags = memalloc_nofs_save();
 	else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
 		flags = memalloc_noio_save();
@@ -3802,7 +3812,9 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 			schedule_timeout_uninterruptible(1);
 	} while (nofail && (ret < 0));
 
-	if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
+	if (noblock)
+		memalloc_noreclaim_restore(flags);
+	else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
 		memalloc_nofs_restore(flags);
 	else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
 		memalloc_noio_restore(flags);
-- 
2.39.5


