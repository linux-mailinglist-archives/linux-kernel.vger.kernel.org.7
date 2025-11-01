Return-Path: <linux-kernel+bounces-881347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1E6C280E4
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 15:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 065434017E7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 14:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AF02F9DB8;
	Sat,  1 Nov 2025 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="b+JMHsP1"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DD72F8BFF
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762007023; cv=none; b=pXggljc8PHRl2/p6MFm3WmDiaI5mXXH4Hg8LzId52jmci5W/M8tZz6xik6bkGhxiugtg4P+Zip032WZMK95mu9o94bmy2qu20XjIeslyWOCxmp0fqrIV1q5vxmo2FsBdrkBvJnTWzbdP3nvMgtf2zjpwgrtDoGWHrLGW/IdmlF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762007023; c=relaxed/simple;
	bh=jB2u78ATcqK9LLqZZ+Q3rTKqdWaeTrOa+pQpqVZpFJA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YfVb2QuWF2S9UHk8XD8aBvdHGFQEQfYTQyA3mjwMgl5HhIN7nUK3ZJxjyZOAecNlLmSxvkNaoLEr4Ra6/OTV7w19pGk1JIxqzbocuHF6oacSZ0ds63GB7GZydf5bZYU/DJWzj9zUBDGAYjInKg29aeGCljbHf2Az47adsqLXLZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=b+JMHsP1; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-89018ea5625so1504116241.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 07:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762007019; x=1762611819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1DCkHyYopvb0wF2qt5OuiBAkk+v7Kgo7WmWoUc1PDLE=;
        b=b+JMHsP1GZLHHDMivTmJN6GNkVuAnG9CRYQROZhNZqaryMcvcAobPVP9x11mJ3FPsm
         v2bjyOnroQUtxY5OXPbIMgEOsIPNP62TzinYe0uOhtVF3uHRWp6ZdoXV2e8H4A64YK/Y
         TEdH2py8+CeFXSrUM3mHD4xr6j/EAezkblxkCTf1Io9KS+0CiSRRl7HdrYNxerpAGDYC
         DEPiAYD2ZPTnaY2W0eCqxSvFyWMdrnojwUmw/WEdb+kK9BM9+npYdt28iRoySKi/x7se
         oSHrQq6rN0k1Q1EiIvf9icIZ8itvzoNRI93xhV7GCFE6ujPiv/bep7Vbp2/sq3MZGE7n
         8OZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762007019; x=1762611819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1DCkHyYopvb0wF2qt5OuiBAkk+v7Kgo7WmWoUc1PDLE=;
        b=JtXYmhttBhffXlNGnUeyRqcqFaZe5HegHYjPMHgtNVCVGKmpJS1Pc8MouE4zNggSF6
         aK/EKQbpcqp4yBfKgJvdIihJd20Mc1pw8Zz72ENBkdGQJJeibn5SJixC8qBcqKmynwaZ
         xJkQgonHkEHILUp/0yeUskFtqvK3VQTUP+mrYfzZo+XbVL8AoYVI9OtzFMVkPxMzSVzn
         /iGqCKVnBccwIJ629gQHErWfYA7idCv+sw18AsUCPmLsYAN2S25jUSrbRHADEEHihbYJ
         J9c31zr6V0Z57nFbnPyfCZhITQnmZONjL0V/xaBGaxOmnkSzmpXeErVJC1X1YAhoVS61
         CJRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWXk1Z5GYeGd8L5gW1wveZfjYzOVSLWoFJfUR1ZO8Ciu9CiSd02jeVTzzzn2wRnnc+/VIIBUsjV0PT1rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEIToowGYUZj/Pw7OksUPPPEtixDZFeADmsTssIIuYZ03DCCDR
	BKH6yOOLXoN70VLmzfcG5RZxfYWJHucSx0W8Xfl3CpMXMscWGVLnUMXiwcIhMpiSg9A=
X-Gm-Gg: ASbGnct71WSIHO3iBQ+wUeEg2uBew+YYqd5SktU3/oUArKu8MG/qftOePvmx/V4ljr6
	wW2oqmBXj8XauRLjkrtMul7qqEQZVVJa2qrapkEgkJriFQay14yWo89HrwdupGcpyY5/OMZ1fVQ
	85bgiAeLFsRASC5m9O2a0utG/4cwTTYuvhOscPvWIt5LI6QEXQ6dMrxhLmDt4AdxZNRYbe0d7Hh
	DvyxwKrTZEKfblU+kMLFY8ewUkmTGPKqu2DXJFRxviy/DY0vu3yMHMJniAH8WFelgcPdY2j88dn
	UGFJx9AIV6I6Y1pVRQfWF+F+bHCkhtIDnFNgTatdeaU+2Fq268Ea8Pk1MwuCS6SNcuSIUKF17yj
	1eBrb5MxYrkeZ2kkGA2LlULZbCtwEeZtANxbntow9m+mTYfL6gt2CwdjsUlmNz+I4jm307xHigF
	Jev2r0HX8WQevdQh/o88iNKcLrLoeeFR17nVx2PNtETk7H2j3VPqwAK7LfUjRcbOG+cBCpLVE=
X-Google-Smtp-Source: AGHT+IGR/VzDF7AB+sIC/+cJHCH4X5S7Mi8sJ3f5dCfpSYmCmX5nmYDVJr+NLnssvgjti7LClYe3OA==
X-Received: by 2002:a05:6122:21a8:b0:54a:23dd:5a9e with SMTP id 71dfb90a1353d-5593e270143mr2102007e0c.3.1762007019132;
        Sat, 01 Nov 2025 07:23:39 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-559449647e0sm1776242e0c.3.2025.11.01.07.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 07:23:38 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	brauner@kernel.org,
	corbet@lwn.net,
	graf@amazon.com,
	jgg@ziepe.ca,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	masahiroy@kernel.org,
	ojeda@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	rppt@kernel.org,
	tj@kernel.org,
	yanjun.zhu@linux.dev
Subject: [PATCH v9 4/9] memblock: Unpreserve memory in case of error
Date: Sat,  1 Nov 2025 10:23:20 -0400
Message-ID: <20251101142325.1326536-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
In-Reply-To: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
References: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If there is an error half way through KHO memory preservation, we should
rollback and unpreserve everything that is partially preserved.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Suggested-by: Pratyush Yadav <pratyush@kernel.org>
---
 mm/memblock.c | 73 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 58 insertions(+), 15 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index e3bef9b35d63..f527ad1ca682 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2445,29 +2445,60 @@ int reserve_mem_release_by_name(const char *name)
 #define MEMBLOCK_KHO_NODE_COMPATIBLE "memblock-v1"
 #define RESERVE_MEM_KHO_NODE_COMPATIBLE "reserve-mem-v1"
 
+static int __init reserved_mem_preserve(void)
+{
+	unsigned int nr_preserved = 0;
+	int err;
+
+	for (unsigned int i = 0; i < reserved_mem_count; i++, nr_preserved++) {
+		struct reserve_mem_table *map = &reserved_mem_table[i];
+		struct page *page = phys_to_page(map->start);
+		unsigned int nr_pages = map->size >> PAGE_SHIFT;
+
+		err = kho_preserve_pages(page, nr_pages);
+		if (err)
+			goto err_unpreserve;
+	}
+
+	return 0;
+
+err_unpreserve:
+	for (unsigned int i = 0; i < nr_preserved; i++) {
+		struct reserve_mem_table *map = &reserved_mem_table[i];
+		struct page *page = phys_to_page(map->start);
+		unsigned int nr_pages = map->size >> PAGE_SHIFT;
+
+		kho_unpreserve_pages(page, nr_pages);
+	}
+
+	return err;
+}
+
 static int __init prepare_kho_fdt(void)
 {
-	int err = 0, i;
 	struct page *fdt_page;
 	void *fdt;
+	int err;
 
 	fdt_page = alloc_page(GFP_KERNEL);
-	if (!fdt_page)
-		return -ENOMEM;
+	if (!fdt_page) {
+		err = -ENOMEM;
+		goto err_no_fdt_page;
+	}
 
 	fdt = page_to_virt(fdt_page);
+	err = kho_preserve_pages(fdt_page, 1);
+	if (err)
+		goto err_free_fdt;
 
 	err |= fdt_create(fdt, PAGE_SIZE);
 	err |= fdt_finish_reservemap(fdt);
-
 	err |= fdt_begin_node(fdt, "");
 	err |= fdt_property_string(fdt, "compatible", MEMBLOCK_KHO_NODE_COMPATIBLE);
-	for (i = 0; i < reserved_mem_count; i++) {
+
+	for (unsigned int i = 0; !err && i < reserved_mem_count; i++) {
 		struct reserve_mem_table *map = &reserved_mem_table[i];
-		struct page *page = phys_to_page(map->start);
-		unsigned int nr_pages = map->size >> PAGE_SHIFT;
 
-		err |= kho_preserve_pages(page, nr_pages);
 		err |= fdt_begin_node(fdt, map->name);
 		err |= fdt_property_string(fdt, "compatible", RESERVE_MEM_KHO_NODE_COMPATIBLE);
 		err |= fdt_property(fdt, "start", &map->start, sizeof(map->start));
@@ -2477,15 +2508,27 @@ static int __init prepare_kho_fdt(void)
 	err |= fdt_end_node(fdt);
 	err |= fdt_finish(fdt);
 
-	err |= kho_preserve_folio(page_folio(fdt_page));
+	if (err)
+		goto err_unpreserve_fdt;
 
-	if (!err)
-		err = kho_add_subtree(MEMBLOCK_KHO_FDT, fdt);
+	err = kho_add_subtree(MEMBLOCK_KHO_FDT, fdt);
+	if (err)
+		goto err_unpreserve_fdt;
 
-	if (err) {
-		pr_err("failed to prepare memblock FDT for KHO: %d\n", err);
-		put_page(fdt_page);
-	}
+	err = reserved_mem_preserve();
+	if (err)
+		goto err_remove_subtree;
+
+	return 0;
+
+err_remove_subtree:
+	kho_remove_subtree(fdt);
+err_unpreserve_fdt:
+	kho_unpreserve_pages(fdt_page, 1);
+err_free_fdt:
+	put_page(fdt_page);
+err_no_fdt_page:
+	pr_err("failed to prepare memblock FDT for KHO: %d\n", err);
 
 	return err;
 }
-- 
2.51.1.930.gacf6e81ea2-goog


