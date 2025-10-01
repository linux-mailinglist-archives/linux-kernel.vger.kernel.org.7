Return-Path: <linux-kernel+bounces-838315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDD1BAEF1C
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 03:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F6B94E1F9D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 01:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1793243374;
	Wed,  1 Oct 2025 01:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UYkd7BTC"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E3923E32D
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 01:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759281593; cv=none; b=SX8rZ3PrD5uyb1eLwfCpvZ90Fz24BYKpmSiG/9vYhCpDEwdeIvzhTdZNIj089IPpAr8fLdLssOMQheOOiWZof9DEDL027BJXBlLu6UEvFg5RS4hQYeFuX0W6KU5bhcpywD8YVOFt/UESgO6poKLz3XPs478xLF3J0I5yyJFw08U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759281593; c=relaxed/simple;
	bh=eyhAqvClZGxGAi9GqsE4GIrUwtn7ku8Q5iIwLCXU1qA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=LxRdbH+gu/r1hOG7hPU60TIB7NLj9fB+mW9KbYSFuxImwC2rhG0cIljL7AC+PXxEz5ItXitq5DEtMA1dASvE6ctlPq6ABSmbBaF60JqlSQsdDySOAfta/ISXuk7fFwHovb20p3WLZ13RIMdigJW3h7g7Bv2nwEacyUJO9JqE3hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jasonmiu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UYkd7BTC; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jasonmiu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b5a013bc46dso3060687a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 18:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759281592; x=1759886392; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x4HnKiiE09rl43LC3UECv7NDLXowg9VsBNh2ns+1RXE=;
        b=UYkd7BTC/AQ7MYOEdsmZFWTed/etj2OPxazuEjG8L1XWV7Kr4BJH1wB4JQVFdcU83n
         243fKjRxHK/00/+WzvOTditg7x2VGd2AcrRpxFMIP2Y+SP85XetCZtbp/ou/ouvUuIJ8
         EG5E25yceLv0tbsDGt62jXPPw+bW9ZzWhanAI4++Wr1mmDAX/xAU4vCVfZxZGJBlkjgM
         D08jJP9FZjzHhAF/EgTAcI78qnuvkQMvl9grLLf588ufCewoxBIwzEYDisj/wT7Sxfw7
         x22cEg8qXG9jq1GFvuUU7Aep3E9aixnBq4FXq443RgCXbK45OsMYJMlMHQ1ieWz9PVKH
         A+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759281592; x=1759886392;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x4HnKiiE09rl43LC3UECv7NDLXowg9VsBNh2ns+1RXE=;
        b=dFNKiZdM5dg1SCInnouNzgl+FBABtMpBciSZXSskmbJnOYm87FiUTzXgySbKEJ+1t0
         zCidkKB6HSzLEtSlp1E5qyQK6HWZkanEpJwUJLoPNDjbtUDzy3GdRhHcjhNKR3qcvYyD
         ebhgwnblx/lmtHUH8RPfW66opOgXbzMNCtg/2UxYty7+P4xq2L28EORMLxdAQPAEejjh
         zg6liMbJp/NZc7ZiRcSMSwtiE4FUEWrjvkfHSom3SMJRlAdLf3oQmMfnjtltZij0EDVL
         YywQskAwcOtqcgKecqnxjvuu4M+BCp0hXnQtAvkN8+YyrDLzg77Y88/tqE69bWOhKLb9
         XIZA==
X-Forwarded-Encrypted: i=1; AJvYcCURZZe1RTCXTgV4vK9mGMFAxllYXaawiiWN9fo7xsfItC0y11LYEJgh4udnAYydXYP2UFJkot8uU/dzRZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu1tiOY07vvLeyBVQM/fzizNvzi+u2HqJW80FkdKThPRuPFcYo
	KIDMpYrrEE2OjnE7YMvuIYL+dG2aVejPxgEZH4DE5r6SwP76gHOA5ymakz6InQyDKMxwUvakZBc
	bwh4ZABzzFR9FnA==
X-Google-Smtp-Source: AGHT+IEBtmTt/de8ZAH/Gty67fG7K6wz+DH/TLooGqCBdKidWKsNfouEipgjC7MTQ3Jd+/633JnpD2gkYNbqjw==
X-Received: from plbml5.prod.google.com ([2002:a17:903:34c5:b0:24b:1657:c088])
 (user=jasonmiu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f642:b0:266:ddd:772f with SMTP id d9443c01a7336-28e7f276df7mr19249665ad.9.1759281591707;
 Tue, 30 Sep 2025 18:19:51 -0700 (PDT)
Date: Tue, 30 Sep 2025 18:19:41 -0700
In-Reply-To: <20251001011941.1513050-1-jasonmiu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251001011941.1513050-1-jasonmiu@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251001011941.1513050-4-jasonmiu@google.com>
Subject: [PATCH v1 3/3] kho: Remove notifier system infrastructure
From: Jason Miu <jasonmiu@google.com>
To: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Miu <jasonmiu@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Eliminate the core KHO notifier API
functions (`register_kho_notifier`, `unregister_kho_notifier`), the
`kho_event` enum, and the notifier chain head from KHO internal
structures.

This infrastructure was used to support the now-removed finalize and
abort states and is no longer required. Client subsystems now interact
with KHO through direct API calls.

Signed-off-by: Jason Miu <jasonmiu@google.com>
---
 include/linux/kexec_handover.h | 22 ----------------------
 kernel/kexec_handover.c        | 15 ---------------
 2 files changed, 37 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 9566c90a3501..09e8f0b0fcab 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -10,16 +10,7 @@ struct kho_scratch {
 	phys_addr_t size;
 };
 
-/* KHO Notifier index */
-enum kho_event {
-	KEXEC_KHO_FINALIZE = 0,
-	KEXEC_KHO_ABORT = 1,
-};
-
 struct folio;
-struct notifier_block;
-
-struct kho_serialization;
 
 #ifdef CONFIG_KEXEC_HANDOVER
 bool kho_is_enabled(void);
@@ -30,9 +21,6 @@ struct folio *kho_restore_folio(phys_addr_t phys);
 int kho_add_subtree(const char *name, void *fdt);
 int kho_retrieve_subtree(const char *name, phys_addr_t *phys);
 
-int register_kho_notifier(struct notifier_block *nb);
-int unregister_kho_notifier(struct notifier_block *nb);
-
 void kho_memory_init(void);
 
 void kho_populate(phys_addr_t fdt_phys, u64 fdt_len, phys_addr_t scratch_phys,
@@ -68,16 +56,6 @@ static inline int kho_retrieve_subtree(const char *name, phys_addr_t *phys)
 	return -EOPNOTSUPP;
 }
 
-static inline int register_kho_notifier(struct notifier_block *nb)
-{
-	return -EOPNOTSUPP;
-}
-
-static inline int unregister_kho_notifier(struct notifier_block *nb)
-{
-	return -EOPNOTSUPP;
-}
-
 static inline void kho_memory_init(void)
 {
 }
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index ee4f430dfae0..fc290226e58b 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -16,7 +16,6 @@
 #include <linux/libfdt.h>
 #include <linux/list.h>
 #include <linux/memblock.h>
-#include <linux/notifier.h>
 #include <linux/page-isolation.h>
 #include <linux/rwsem.h>
 
@@ -641,13 +640,11 @@ static int kho_debugfs_fdt_add(struct list_head *list, struct dentry *dir,
 }
 
 struct kho_out {
-	struct blocking_notifier_head chain_head;
 	struct dentry *dir;
 	struct kho_serialization ser;
 };
 
 static struct kho_out kho_out = {
-	.chain_head = BLOCKING_NOTIFIER_INIT(kho_out.chain_head),
 	.ser = {
 		.fdt_list = LIST_HEAD_INIT(kho_out.ser.fdt_list),
 	},
@@ -697,18 +694,6 @@ int kho_add_subtree(const char *name, void *fdt)
 }
 EXPORT_SYMBOL_GPL(kho_add_subtree);
 
-int register_kho_notifier(struct notifier_block *nb)
-{
-	return blocking_notifier_chain_register(&kho_out.chain_head, nb);
-}
-EXPORT_SYMBOL_GPL(register_kho_notifier);
-
-int unregister_kho_notifier(struct notifier_block *nb)
-{
-	return blocking_notifier_chain_unregister(&kho_out.chain_head, nb);
-}
-EXPORT_SYMBOL_GPL(unregister_kho_notifier);
-
 /**
  * kho_preserve_folio - preserve a folio across kexec.
  * @folio: folio to preserve.
-- 
2.51.0.618.g983fd99d29-goog


