Return-Path: <linux-kernel+bounces-860549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BC7BF05F6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B72364ED825
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02F72F6563;
	Mon, 20 Oct 2025 10:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r7Z9CO4C"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848C52F617C
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760954598; cv=none; b=G3dYeo/1va0NrY0+/jDvcQXOYvi5tJ65ga0AkgHi/sV3U0UkXlrDDElNHPPXQ8TWPRSwO7z+Vd/RNcuP1uavEOlO5ou99Sp+ZggzhQPuzh76ivx05/fCnC+BRN4cKeMXAFpldil4jfwkRb0T7kopz2UMu4fLMtnWBqpjmeoIwYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760954598; c=relaxed/simple;
	bh=MQMJoT3KyEZpuYrADtpfJclikSuTuZ3cKoeRK6KI5WQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=XzBZjAwjrg5J8Vx1w3y6uqN/uiSsrWfPrImtTjtWRVA5XTpiqMRFsJYR2V4dUK3ljeGCmwG/FRtApmrBcK+b2mA7qSccLTH/RmTfjEsZuS5OSPNQv6ywMiXYFxqAzBi2N8zv4qxzQTSilwwM7+9A4V8u2Myif8ydLg3HIN78SFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jasonmiu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r7Z9CO4C; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jasonmiu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2909e6471a9so30282485ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760954596; x=1761559396; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l/xrVZHpXvHRMhRkGHJU8i3nfYQNiwJDcAoOnm63ckE=;
        b=r7Z9CO4CPmGUFDOuu1UzFVbW34VcEJkO06FQ5J53rySz1lostX0DpcdQVpvBucxbc7
         FqkTFrCgfyfCq/n/dku6bT6ua0C3Gv91rdwXcuva+a6pfechv+P6c2buImBII4onH4qy
         uqHOmB5xooLFA9EcUXBwWnBU4TdE7OBZ1TqlcC3Jh0wXyaETxrVaot7ZAUzNSoJJ6T/x
         MSVmZ0fOpTqeZdEy7qsG6F36gVY+qlsC8mkON562E5tGmK04f2JeZOFlzTsbq1w/pDvO
         jmbfSxOPGG5nQVKnpGflzKdcm93/L880FuJhy3Knf4tZQsKDlSy9pfGjKuQpTq7S38Up
         nkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760954596; x=1761559396;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l/xrVZHpXvHRMhRkGHJU8i3nfYQNiwJDcAoOnm63ckE=;
        b=JzrbSqyNNwfRbiKr4joCJd6mdRSjUpNxuA/WFmWKeM5Ck+LzvyBQBpIavGoHF0sf0F
         fo8MYY8FtW3GVWOTYnHwd+K2WtAAwMff11rJkm0Oun7QXN8LHen/KTPcs6iCuNIVhHJo
         nwpzZfmh/H+KKXkGWzNWGiNHbsJ6XcIvKSN2XlVP9NTKloewUQ2dEwW1JSDdw5AtxPPy
         z/vwh15dX0l4cUtlH5b9oIEEgueHgv1mV0p/GeIugTu+q99PZ9dl4GhUpj2XH/rdDzIx
         OgkuxXXDrl06kURiyP4OCNo4z10eQgitw1L9kRLntiOk9kbEaPJRUjKSaoXswub84M9j
         fj1w==
X-Forwarded-Encrypted: i=1; AJvYcCXQYCchjirAefayfno+5ZQHEc7zu4nfdNRwbvs8ZMuHlX1g+UtqAWO/SG4bsRKeWZ2BRwN7lNsPQS2jU9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrM3ZHZ/xwPUY3a56jhlh4UGwuxDErXVRkSGtn4oxFqjikHlbM
	6VyzQVv3PqgGTc6m6tJ1WQN0dnp3bSiX+xIa6uDFW0g5FYwHR7z9dB70m3nU9TnOXBSPwnrNR8L
	SChspEL0EwqOvLA==
X-Google-Smtp-Source: AGHT+IEzFK4LZayLd5iN1w0uFbIESnuBTugytBDsMRryC9YXYqChyResDflUkGa6F21iVpOozbAUdMrrBXy9VA==
X-Received: from plcr12.prod.google.com ([2002:a17:903:14c:b0:290:4eeb:bc7a])
 (user=jasonmiu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d60d:b0:270:e595:a440 with SMTP id d9443c01a7336-290c9cd4b48mr146517415ad.25.1760954595745;
 Mon, 20 Oct 2025 03:03:15 -0700 (PDT)
Date: Mon, 20 Oct 2025 03:03:06 -0700
In-Reply-To: <20251020100306.2709352-1-jasonmiu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251020100306.2709352-1-jasonmiu@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251020100306.2709352-4-jasonmiu@google.com>
Subject: [PATCH v2 3/3] kho: Remove notifier system infrastructure
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
index 1f2ca09519a1..d345f301c57b 100644
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
@@ -31,9 +22,6 @@ int kho_add_subtree(const char *name, void *fdt);
 int kho_remove_subtree(const char *name);
 int kho_retrieve_subtree(const char *name, phys_addr_t *phys);
 
-int register_kho_notifier(struct notifier_block *nb);
-int unregister_kho_notifier(struct notifier_block *nb);
-
 void kho_memory_init(void);
 
 void kho_populate(phys_addr_t fdt_phys, u64 fdt_len, phys_addr_t scratch_phys,
@@ -74,16 +62,6 @@ static inline int kho_remove_subtree(const char *name)
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
index 1138b16fa546..325b83a609fc 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -17,7 +17,6 @@
 #include <linux/list.h>
 #include <linux/log2.h>
 #include <linux/memblock.h>
-#include <linux/notifier.h>
 #include <linux/page-isolation.h>
 #include <linux/rwsem.h>
 #include <linux/live_update/abi/kexec_handover.h>
@@ -674,13 +673,11 @@ static int kho_debugfs_fdt_remove(struct list_head *list, const char *name)
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
@@ -787,18 +784,6 @@ int kho_remove_subtree(const char *name)
 }
 EXPORT_SYMBOL_GPL(kho_remove_subtree);
 
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
2.51.0.858.gf9c4a03a3a-goog


