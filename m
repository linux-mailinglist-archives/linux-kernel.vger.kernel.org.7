Return-Path: <linux-kernel+bounces-819903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4688EB7D090
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 788722A7F29
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 02:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BDC2F39CF;
	Wed, 17 Sep 2025 02:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IEh5rxuT"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7981B2F6574
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758077452; cv=none; b=nJtsZO6awINFqTHmH0TkPcBG37xsHhoIzkt9IZFeaJ1yXwFPETRQAUuIPWBdY0BsAs0XJrsYXPmj+vde5hCStHXVayOVVP8TqJGDrpMywk2uClA51w6ix0ginsp+ASOSHdi+8Fr/zxPa4I3QoQXRYd0zyqorIQ8pcZJFxU+qUvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758077452; c=relaxed/simple;
	bh=GskX7HywQRThAUfOJqR0ccdZH+mTXepYX+Yt7+guEf4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=cNZiBbT9mrG6/xes83oX0SYpZZUvcMZfrxJAWS9A1KFY1pKv1nmZ/O9TSvi1GLSB8f5/UeLIo+W81aemDSzHPS9a2kMJGcK3kp2KluLFJLByItrHi+54CH8INt8ktfbZOUWPdBf6hWxS7seBpPmKFXSM2QurA4BS5IgXH79Iv3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jasonmiu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IEh5rxuT; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jasonmiu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24458345f5dso74983845ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 19:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758077450; x=1758682250; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B0DvEATy1boxO8jY+p5CHjM48FocEtwboNagjTq4rGo=;
        b=IEh5rxuTbRwRf/2fAfKPB3I7Hb3RONKTe5ba88/a6wmUCp2QFInJR6Z38FAY5HjTba
         3/LA77wD003dk8yYPzzB1Z2dLm8SaJRBw0ap3SYewR5rlZFR6PAUeKgO4qiKo6UnNORb
         qL9vrXjwfGvpRC+vQmCs3y6Bxi3NptK71MrxjpWlPLufYtCqqpqiNj0jLx4NtCKLYQth
         I+kh4viPiPgUC+CJ9kkn/sdL0LYIH/3rPkWN/R4j3X4x5q81VtlIWNXwaLofSgibZ9M2
         glKkHQ8DIqlhdGTqyk7o7xSERuZsBIZi4M5cSH2K/7PN/B2R0oTkY+cFG41vW3SMq/g4
         RL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758077450; x=1758682250;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B0DvEATy1boxO8jY+p5CHjM48FocEtwboNagjTq4rGo=;
        b=g2v1yVwgnxELKM0+UslzGFnanME5a/DbP6U5zZRCAK5A5ejtXuLDwLnHn+zHtG6yRQ
         +4SzweWH6lQUzWsL1un8UBCD77NTSDUaj5n15Z/+uexXEfPCBPbg4CRqP+BLuOfGf/Jx
         69wjITcxsGyhagr7+JS8qO0OTumWoNUwithm9DqrnLY3VYposhKiRn/emrO1OXBhWVoN
         d9GMUupC3frLOBPdTNSoWSn9HY4RXvXIdyFBQHX51GVBCXd2c5WFojABH7Xz3e+lB4sh
         x4EIdTFtmDpN55l7U0lyBDEcel2q7F/slzlItJvxUPtiG1WtX9S8Rqy1frSzMEPYECag
         XQTQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3QF5AXFbAZDKgdd1OT3ACyLQZKDeNW79oY2YawW7sCx3rn8HSlXam2xDRQxwZ7uHjaiddl978WOrA9gA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfiPWd/KZKhwozxQscqfkqHTyEUHoj+Fc7QzWqQfoMsN8iZeBF
	R1jkSsJeXECZxHmdXJ7TDrNlGYBn62zuZnqvVstmMrLGN7m3Pq6Irk5TCDV8/egWKic6DPrcmO6
	qYtvZaVO+/rpFXA==
X-Google-Smtp-Source: AGHT+IERUNLZmWljnHVW/VI2Iz32N7whxhHeQqNofUwRKCrC4MDBM1MGWQZdKx/R1kYbmKHfIml8z0yP7qtaZA==
X-Received: from pjk5.prod.google.com ([2002:a17:90b:5585:b0:32e:3646:77d6])
 (user=jasonmiu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:db02:b0:267:cdb8:c683 with SMTP id d9443c01a7336-268123806c5mr6135285ad.27.1758077449502;
 Tue, 16 Sep 2025 19:50:49 -0700 (PDT)
Date: Tue, 16 Sep 2025 19:50:19 -0700
In-Reply-To: <20250917025019.1585041-1-jasonmiu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250917025019.1585041-1-jasonmiu@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917025019.1585041-5-jasonmiu@google.com>
Subject: [RFC v1 4/4] kho: Remove notifier system infrastructure
From: Jason Miu <jasonmiu@google.com>
To: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Miu <jasonmiu@google.com>, 
	Joel Granados <joel.granados@kernel.org>, Marcos Paulo de Souza <mpdesouza@suse.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Petr Mladek <pmladek@suse.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Steven Chen <chenste@linux.microsoft.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Remove the KHO notifier system.

Eliminate the core KHO notifier API
functions (`register_kho_notifier`, `unregister_kho_notifier`), the
`kho_event` enum, and the notifier chain head from KHO internal
structures.

This infrastructure was used to support the now-removed finalize and
abort states and is no longer required. Client subsystems now interact
with KHO through direct API calls.

Signed-off-by: Jason Miu <jasonmiu@google.com>
---
 include/linux/kexec_handover.h | 20 --------------------
 kernel/kexec_handover.c        | 15 ---------------
 2 files changed, 35 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index e29dcf53de7e..09e8f0b0fcab 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -10,14 +10,7 @@ struct kho_scratch {
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
 
 #ifdef CONFIG_KEXEC_HANDOVER
 bool kho_is_enabled(void);
@@ -28,9 +21,6 @@ struct folio *kho_restore_folio(phys_addr_t phys);
 int kho_add_subtree(const char *name, void *fdt);
 int kho_retrieve_subtree(const char *name, phys_addr_t *phys);
 
-int register_kho_notifier(struct notifier_block *nb);
-int unregister_kho_notifier(struct notifier_block *nb);
-
 void kho_memory_init(void);
 
 void kho_populate(phys_addr_t fdt_phys, u64 fdt_len, phys_addr_t scratch_phys,
@@ -66,16 +56,6 @@ static inline int kho_retrieve_subtree(const char *name, phys_addr_t *phys)
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
index f7933b434364..62f654b08c74 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -16,7 +16,6 @@
 #include <linux/libfdt.h>
 #include <linux/list.h>
 #include <linux/memblock.h>
-#include <linux/notifier.h>
 #include <linux/page-isolation.h>
 
 #include <asm/early_ioremap.h>
@@ -683,13 +682,11 @@ static int kho_debugfs_fdt_add(struct list_head *list, struct dentry *dir,
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
@@ -727,18 +724,6 @@ int kho_add_subtree(const char *name, void *fdt)
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
2.51.0.384.g4c02a37b29-goog


