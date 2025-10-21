Return-Path: <linux-kernel+bounces-861951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A2190BF41C3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 02:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D6944E739D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 00:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DFF1D799D;
	Tue, 21 Oct 2025 00:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="KYH69awI"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E98919F40B
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 00:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761005346; cv=none; b=lz0J9gNFRw+OhXwqYyAkOSljMM/ITXb8eiUoBkOubhZLg4H2qSEBqTuoOeQaPOxeWrvYIM5WDPDknMOu7cKm7bAEvsZhi4968TbCAxQGkJvJoF0x2aOTZK7dfyxGmpcyTvlRwF9s3ZKW48SGJi+pX+i//9fg6Olxx9H0jO1FYYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761005346; c=relaxed/simple;
	bh=LDHuftkfJUzPNUuh9kXo6Q3FBGbP3xrGn0Wol3ZW4js=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ekCjbGWMqZeMItqu4tYaEwT+XfgnByLOz6N8lJqRkE3LNLeinRPmXYfgZvwFvEjRXI8aSOyW6x+7tTfURm6ErooieW2UF/Tj0KTtIbsf3+zLuciJjVMjCSFp+S0uLqm8vUkMIljxBgiCSn0dvYd+B7F9uUpMxv2ypyc3YXTHeKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=KYH69awI; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-932dfe14b2eso749958241.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 17:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761005342; x=1761610142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wh0gNpXNnj8TcdXtVkip0MO+OiSr/N3ozqVkyEmZbiA=;
        b=KYH69awIcsEGRYA+OBfTsfkJ0DRI4p5B88h1ngPGp8Mxa0Uv7Mc3mD6L4F/lB3r/VN
         O2mPfkv+bPHAGxZ1Hjkid/CkZXR7U9jBX6h2th1NoPaUfu9HQkOJRChzSCCUcvnGQbH0
         Cc6XOOF0BKisxg5NGsIhhPuZPdAWmte3RmteuLddcUjtUZbP7RkNlJ+EhbwoL7eupS43
         gmM2nn2TWOY5HpmFE8OMQ8tsNY6bUXdByGPQ8Hq2hn6AneprAPN46iWktku9NG0IMSaz
         lpCVp7g4eojxuft+xiQbmtB5+v/PgqMCWYlZh/txZrzY+1YYUMSWY/DWlROlnlNLkobj
         xY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761005342; x=1761610142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wh0gNpXNnj8TcdXtVkip0MO+OiSr/N3ozqVkyEmZbiA=;
        b=UNPvvgTt7TOviXe1pjrxfDuSbLpZFJZUv90Afe1wXt1+Hfw+axrYXnHRwoSCviMqx2
         GQx2CNwjM4OLSYEvk9m9UyXGzuPOlsRm3xzdlyePgMChaEN0Nkvmvnn48wFkobsD5z25
         A6kiM2frhYB0lqHtQFu8rO5xLEFYtGuJI0sWXKcjZ9aBeh0eAt3uk/9goh0IO3PxmdUB
         +K97R5gXNMezn4wIovWA7Iv7T0EpXzyXFc4+6gK9Yt5Jeagk9GLPUW1XfhDBU3I9FD0u
         BoE2Kot5TjLlRvL8jTudQw2HD6ElHTJYTUvVrcKhwAslDKiw8XIBYAWx12TzCqEnPTlc
         SpQA==
X-Forwarded-Encrypted: i=1; AJvYcCX1G68KTE354vkd29KCZT14lLId4vXm0hXcAGU0yr1Rxx5a183zaHZ8Saxb4CmoGmuU7efAE1R6X0UjsoI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg9O6x3vYt0+V9FpuFMcnqnMhx/qFr/VCZlNrOqzNkOiRe1BRy
	U74i8XHjdMd/C3hm2LO18SueS4lt9safQpLGFnwse3I+YbYPHhKa2T+mt3jPWJfpGSw=
X-Gm-Gg: ASbGnctlTeWZyB/XsTLXTs8a+tBNjhLsfVn0V1VJnEq4ZyuCAFnmtC2BiKHxiU7YwiX
	EO1ntrhLAqa6WBoHgcvP5yw3QKentD6XiCtCsdi+2KliyxKeIVEWYH0JafJ9b6/OKnjCR4vFu9J
	Gc7EEF7dxBsY+6uvz4RvLLhLDVZkFqpXtinLPnm6mOs8s8+DlOdbE1nQX/8FXVRotRi3jnHAu+A
	MSX9FOyJLw8icbDEWxHdLUYE9HJ749Y4YO4iaSQVWRardSKgUKvM8GsjpF+TZCKtKGZV3K1wOfv
	4h20i5bFDcaMxlHoWoQMfpjHxYku/BEouJmIzv4+WU0tkajXha+xmPSfuewTxQdKAJODGRaMPrG
	DXkF7sp/PP/hmQeipLyHE6GKKT+c3251igeh2eJBEPbZri7EMDs9gbpv2/FHDCMCl9QR21zAXyL
	9eVcQsDDy5m0F88PF4j1BOE2SooGc91f4tanG/sSdT4NuPV5cZF/Qbw788G/g/oiJplVVr3Ei+s
	jxgwDGvQ8h5RRvJfFTVSw==
X-Google-Smtp-Source: AGHT+IG0ndYvX9zTAvm2KWn2q1XKGRimjxxOoCLwpUa9MT4euTBOB019JcZ829K5pfY69/fTaACVlg==
X-Received: by 2002:a05:6102:3e85:b0:59c:5e29:dd8d with SMTP id ada2fe7eead31-5d7dd6a3fe6mr5404303137.28.1761005342511;
        Mon, 20 Oct 2025 17:09:02 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55661f6e351sm2822882e0c.4.2025.10.20.17.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 17:09:01 -0700 (PDT)
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
	jasonmiu@google.com,
	dmatlack@google.com,
	skhawaja@google.com
Subject: [PATCH v3 3/3] liveupdate: kho: allocate metadata directly from the buddy allocator
Date: Mon, 20 Oct 2025 20:08:52 -0400
Message-ID: <20251021000852.2924827-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.869.ge66316f041-goog
In-Reply-To: <20251021000852.2924827-1-pasha.tatashin@soleen.com>
References: <20251021000852.2924827-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KHO allocates metadata for its preserved memory map using the slab
allocator via kzalloc(). This metadata is temporary and is used by the
next kernel during early boot to find preserved memory.

A problem arises when KFENCE is enabled. kzalloc() calls can be
randomly intercepted by kfence_alloc(), which services the allocation
from a dedicated KFENCE memory pool. This pool is allocated early in
boot via memblock.

When booting via KHO, the memblock allocator is restricted to a "scratch
area", forcing the KFENCE pool to be allocated within it. This creates a
conflict, as the scratch area is expected to be ephemeral and
overwriteable by a subsequent kexec. If KHO metadata is placed in this
KFENCE pool, it leads to memory corruption when the next kernel is
loaded.

To fix this, modify KHO to allocate its metadata directly from the buddy
allocator instead of slab.

Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation")
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
---
 include/linux/gfp.h     | 3 +++
 kernel/kexec_handover.c | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 0ceb4e09306c..623bee335383 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -7,6 +7,7 @@
 #include <linux/mmzone.h>
 #include <linux/topology.h>
 #include <linux/alloc_tag.h>
+#include <linux/cleanup.h>
 #include <linux/sched.h>
 
 struct vm_area_struct;
@@ -463,4 +464,6 @@ static inline struct folio *folio_alloc_gigantic_noprof(int order, gfp_t gfp,
 /* This should be paired with folio_put() rather than free_contig_range(). */
 #define folio_alloc_gigantic(...) alloc_hooks(folio_alloc_gigantic_noprof(__VA_ARGS__))
 
+DEFINE_FREE(free_page, void *, free_page((unsigned long)_T))
+
 #endif /* __LINUX_GFP_H */
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index e5b91761fbfe..de4466b47455 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -142,7 +142,7 @@ static void *xa_load_or_alloc(struct xarray *xa, unsigned long index)
 	if (res)
 		return res;
 
-	void *elm __free(kfree) = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	void *elm __free(free_page) = (void *)get_zeroed_page(GFP_KERNEL);
 
 	if (!elm)
 		return ERR_PTR(-ENOMEM);
@@ -348,9 +348,9 @@ static_assert(sizeof(struct khoser_mem_chunk) == PAGE_SIZE);
 static struct khoser_mem_chunk *new_chunk(struct khoser_mem_chunk *cur_chunk,
 					  unsigned long order)
 {
-	struct khoser_mem_chunk *chunk __free(kfree) = NULL;
+	struct khoser_mem_chunk *chunk __free(free_page) = NULL;
 
-	chunk = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	chunk = (void *)get_zeroed_page(GFP_KERNEL);
 	if (!chunk)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.51.0.869.ge66316f041-goog


