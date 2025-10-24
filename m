Return-Path: <linux-kernel+bounces-869175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB53C07372
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 365E54057C4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FB13375A0;
	Fri, 24 Oct 2025 16:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="YgvlBGaa"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD8A338916
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322216; cv=none; b=ICU+khZ+tuO8tf4IIjUKNYYddquDue5dph7eitvtvBWTil+HGjVZ0CzE+pf50HLnf2Xf6pBglLYltOUjJGtUV/qwoPG3/LIlnAIqYSJL/JH89I4qpUNK2pSNAC/MUfZwFUavftptF5s8JR8IiR3gcyD7JnLbcEjwI+7vcz1z5MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322216; c=relaxed/simple;
	bh=LXACdztAUdRgfPn95Jp9ukzR3cpsHm6JsrVc+niAfW4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ou9JcAUivu3VKkwes4tD8dg93BiK560kPGoJWk7J5iNBtUmVTWwVm1VLKQD6/RQ/NIvXoLBr3C4/73gNK6Uf9j4Nu6eSJM34kCH8wWqqYU8O/6OBLigbyzEoWQJaG8Y2XBiuxWTSLCeMkMGnHUhOiIuvNl1Px6VAyK7ycTnWZy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=YgvlBGaa; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-784a5f53e60so27118157b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761322213; x=1761927013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kPI1gxitoc4b140sD8ZnWvGi4JoP4wU7snq/qHJbNDE=;
        b=YgvlBGaav8ky/8tj46mlpNM1ACIe1mAWkJSjMtNM6UP3fsMy1d5ptLjRtdgQ3dfjqd
         gH7b8bFzWr87JicBtJjvemkZ9BFg76p/uEBaE919cyaMK+QW7Eh5NbkH4rjZlfxHG/Wh
         MgPvm2xBI3+sKhj4XsDLa063NldWv/ThYsuQH+hdx3MhlJmHi1EC9uj0yTPxZtfMr9ty
         m3CKM8RDBYGIcNM+tZznrnwu5QQnBlQmN1khp5tgXhU2VE5gLKiYBXhvbeTHT/twQ/T5
         2GO/08+HYokfYjqC+s/n5LMB24KK9/0yGvS4Go7a/tJSbTmQ4WWzuYACl5ud9kHlS2H+
         PYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761322213; x=1761927013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kPI1gxitoc4b140sD8ZnWvGi4JoP4wU7snq/qHJbNDE=;
        b=aonE0RWu3/2M85hcLGqqB59oWdr4sZL98xGQkN7pPzWTjJtFvA14yKhXT7yvl9Osjn
         pOOhyK4A1nfDCotjW7prHE/W8n2cN9aPc3ru+F7sIR6RwP+tf0Ey7Fnwprd4DzHDY2nn
         qU/YBUpsL/u4cjY8k4x/SlnRny7Gje51y3BcQ4PQrpwb3c9aZ1gYr+3DEOkoKD0W2YtD
         xYit/XqW+oj60vVynVY98W1ZkR585oR9C1fs7Mdc6UX5d2sabMAd8fgsGyjEP03n3WY0
         9dfzYhMR3V9KA/VA9QSNeWPsYoGeudCibmJDl66s1txVzEB7a1eIb9xwjnnPKNc/FYHF
         fmug==
X-Forwarded-Encrypted: i=1; AJvYcCXiKaZFGOGm5cdOw1Tkh/2ArXpa5QPqT3zQ0b4qsVtqryemXpEOLgtvTCr6jl2yPoOCyQHN27CqvLfWHJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YysKq550PwqGodX8KwM051XUhj/KarFkTy6hYQZ5W5rJe6pc36k
	oE83foOOFp6BNfHJlgCR+kHgDXfFqP2zeJxxIMo+vHDLCOotYgG+0FoqgdPmylHF7eU=
X-Gm-Gg: ASbGncuTdqQBi1cBjGLRYtc5i3i5A2WVRakpzWMasjOtcqD2BJ29MPMYYWJ/8HMlgOm
	NMSdvy/2eungV1Dn3OMiDLjI1p8mgek0Xzw8BvW3oJK6xoubeXP6qJi7sqWvWhUr3oL9Bv5XLdR
	SmtC/AnbknjJA3ZlbJk0axlrCP70qOKbNqgxDyNNrTzAIIbXFQcDUKkSKWhHf9r7RwTFTx246xT
	WtU1In1O3Nky+YpxwgZ5JWSrWSx3YJvFzZuGTiipmRBqgYlGumZWTc2QuahQrQLOUCyOG6rih30
	P0L6lqSGlHxWBeoB+Dr5DixRvkRAsKg5nVRH8KGmcxa+Rl0wVmjhDMT+BGJZU3Gvm1Obr2bPVeX
	AvbOd37j2LQz+GDDqG7CArrrp2WosqFAIFqqQKtv8nKSjvzML3KUsEYocABSUK7JSpJpYJK5YdE
	xacICgmxV2BSeg6oGEWbCO/bRxXwQA8BCJzfUrXbsfD83twMIMPS1uORHdSqTbNf9P3gsxCeAt1
	cCO9TV14LfDdWbZ/5Ah++yj/0Lu1EJs4A==
X-Google-Smtp-Source: AGHT+IHNLH1g3W3lGanu9RY51vSAbD6c3rZHsTMEnjrgcijU+Yq4oR9AGojuFoR3I5TlxNSrGCNhOw==
X-Received: by 2002:a05:690c:253:b0:781:64f:312c with SMTP id 00721157ae682-7836dd58f3emr189766937b3.58.1761322213053;
        Fri, 24 Oct 2025 09:10:13 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785cd6edd87sm14099197b3.51.2025.10.24.09.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 09:10:12 -0700 (PDT)
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
	tj@kernel.org
Subject: [PATCH v8 8/8] memblock: Unpreserve memory in case of error
Date: Fri, 24 Oct 2025 12:10:02 -0400
Message-ID: <20251024161002.747372-9-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
In-Reply-To: <20251024161002.747372-1-pasha.tatashin@soleen.com>
References: <20251024161002.747372-1-pasha.tatashin@soleen.com>
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
 mm/memblock.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index e3bef9b35d63..5ceaa02af7d6 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2447,6 +2447,7 @@ int reserve_mem_release_by_name(const char *name)
 
 static int __init prepare_kho_fdt(void)
 {
+	bool fdt_folio_preserved = false;
 	int err = 0, i;
 	struct page *fdt_page;
 	void *fdt;
@@ -2462,12 +2463,14 @@ static int __init prepare_kho_fdt(void)
 
 	err |= fdt_begin_node(fdt, "");
 	err |= fdt_property_string(fdt, "compatible", MEMBLOCK_KHO_NODE_COMPATIBLE);
-	for (i = 0; i < reserved_mem_count; i++) {
+	for (i = 0; !err && i < reserved_mem_count; i++) {
 		struct reserve_mem_table *map = &reserved_mem_table[i];
 		struct page *page = phys_to_page(map->start);
 		unsigned int nr_pages = map->size >> PAGE_SHIFT;
 
-		err |= kho_preserve_pages(page, nr_pages);
+		err = kho_preserve_pages(page, nr_pages);
+		if (err)
+			break;
 		err |= fdt_begin_node(fdt, map->name);
 		err |= fdt_property_string(fdt, "compatible", RESERVE_MEM_KHO_NODE_COMPATIBLE);
 		err |= fdt_property(fdt, "start", &map->start, sizeof(map->start));
@@ -2477,12 +2480,27 @@ static int __init prepare_kho_fdt(void)
 	err |= fdt_end_node(fdt);
 	err |= fdt_finish(fdt);
 
-	err |= kho_preserve_folio(page_folio(fdt_page));
-
 	if (!err)
+		err = kho_preserve_folio(page_folio(fdt_page));
+
+	if (!err) {
+		fdt_folio_preserved = true;
 		err = kho_add_subtree(MEMBLOCK_KHO_FDT, fdt);
+	}
 
 	if (err) {
+		int nr_reserve_map_preserved = i;
+
+		for (i = 0; i < nr_reserve_map_preserved; i++) {
+			struct reserve_mem_table *map = &reserved_mem_table[i];
+			struct page *page = phys_to_page(map->start);
+			unsigned int nr_pages = map->size >> PAGE_SHIFT;
+
+			kho_unpreserve_pages(page, nr_pages);
+		}
+		if (fdt_folio_preserved)
+			kho_unpreserve_folio(page_folio(fdt_page));
+
 		pr_err("failed to prepare memblock FDT for KHO: %d\n", err);
 		put_page(fdt_page);
 	}
-- 
2.51.1.821.gb6fe4d2222-goog


