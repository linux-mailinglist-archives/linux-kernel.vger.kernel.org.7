Return-Path: <linux-kernel+bounces-809157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A90B5095C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 01:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F46F7A7A37
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 23:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E342C28C01E;
	Tue,  9 Sep 2025 23:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cQvUgYjW"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55E6263C69
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 23:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757461787; cv=none; b=G8awaWXxoDGicMMXwPYrxUimgCYV30ZOsxIcZUabaCl0ouOWrri30OcOhW7Qfqu6MM2a50Bz36mU+ptporjAPk7JHpyiKTDQb2zTC5Cr57EX8BiJvCD+KLgpK3pMwuFYvau8Qoo9TV+Q4P/6o0s/89C7Cjh0Rk2y5iA3Cjp7Qeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757461787; c=relaxed/simple;
	bh=WG+Qkz0NRBNib+wV/riixLKeIqDw2AB9Qc+YUbwsnkM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bzuR4H82S9q3NIcigwGyJ/Wn6cq0wYUaes9HDLE4Y7D7JQr/aNILd6oVqYNYORD6PXrkoM+ALM4mpUIGwkedC66g6IZHSsFlyVCK9pH7QvioeWDcaOPbMBcmgouNv5CD42jAhozq6Vq2x02+OFvXY4tF1a/H/AqwB6djOphBPLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cQvUgYjW; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32bbacf6512so8905453a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 16:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757461785; x=1758066585; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nWhDazcpSKC+AMTc7oUhp0RNtPqVbOFG7KBfwJ/eX+U=;
        b=cQvUgYjWJYsAd+EgkEftlsoRQg5y98VCmswBuLKHeSmP6+hzQSyQ7455y2YXgG26O1
         3jRRdfYrZ6vV+jahTkFSlCfPjc5zGyJD5sU4fYAh8IzkuPAlC3yeZWVLGWhyN2Pgzg15
         7fwB+e3aKh/97+TIdSinHGGSChmJxaW2Af7hXWonxJddmZ5zSO2ljSAoBNtYpoCTjOrU
         hlgMhv+625hzFkpOAUzixySu3jDQzDApJtj1regQA0G8oxBmfjq+jx+CSYafNV6qNa7l
         kYofH2cb5EK2b4Ry5SglSVl2gL+RBaRVTQBiqyO1NVpsiFQ+I8y8150Sk2St71DCi213
         Y07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757461785; x=1758066585;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nWhDazcpSKC+AMTc7oUhp0RNtPqVbOFG7KBfwJ/eX+U=;
        b=dS7dC+wwxXDNo3kkxRa8sU0w731Qk9VVbWVLGX5vf1fSUTOPzEdxW8u97ODwqpT+UG
         0t8x0nlRaSQ6vovqib/9lKN4l20tFYj8l2vNIhUcQl2ThZ412e1f7g3uoZSUiIBgfbNJ
         fJ5QYSIV4yFdF+CD/YGL64ra9JqPiWPwAoizC4eEHjpzRatHeN3EEEit+kVqI2R879LM
         O214OsJLv6PUIekZ6dxhheLCSlc3kIrPnjnOFDA6jmC6yJRQJwNkUaxnh6J14qA9i3Ne
         knKAgJ8pePONRWEfjEHrGuqFDj0Xg6i6WLw+LZcaJgC1iNXEewy1ue+0H/ZtoadFAAnO
         omIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc8zRDdByKY2RsqJswL3aNy6vwZLO3KSFdBIx73u702rOgWScHWWuMlMu187OXNJumVtiMM3GlbqW9qmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzZRNmJet4gDvP0AShzN2ThnlrHu6YJ+knnAlk7j0MalUQ4kNF
	IQfHYaBy7pbnw0OTpTMETkWT4iL0Oly5a/dd2TQUlk6bYIbQujl5YeFmTURGhXHNK0xOgTBbXsd
	GbFftHg==
X-Google-Smtp-Source: AGHT+IF72iXNiE/M7Su4ZVf/nk/3OYPozXy/wJrW2w9tdXbFUYfFNYOP8Pyxkf2InrNA9TDyU0OW+E1pXRc=
X-Received: from pjbph12.prod.google.com ([2002:a17:90b:3bcc:b0:329:ccdd:e725])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d4f:b0:32b:dbf1:319e
 with SMTP id 98e67ed59e1d1-32d43f8fa03mr19354008a91.23.1757461784993; Tue, 09
 Sep 2025 16:49:44 -0700 (PDT)
Date: Tue,  9 Sep 2025 16:49:42 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250909234942.1104356-1-surenb@google.com>
Subject: [PATCH 1/1] alloc_tag: mark inaccurate allocation counters in
 /proc/allocinfo output
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, vbabka@suse.cz, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, rientjes@google.com, roman.gushchin@linux.dev, 
	harry.yoo@oracle.com, shakeel.butt@linux.dev, 00107082@163.com, 
	pasha.tatashin@soleen.com, souravpanda@google.com, surenb@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

While rare, memory allocation profiling can contain inaccurate counters
if slab object extension vector allocation fails. That allocation might
succeed later but prior to that, slab allocations that would have used
that object extension vector will not be accounted for. To indicate
incorrect counters, mark them with an asterisk in the /proc/allocinfo
output.
Bump up /proc/allocinfo version to reflect change in the file format.

Example output with invalid counters:
allocinfo - version: 2.0
           0        0 arch/x86/kernel/kdebugfs.c:105 func:create_setup_data_nodes
           0        0 arch/x86/kernel/alternative.c:2090 func:alternatives_smp_module_add
          0*       0* arch/x86/kernel/alternative.c:127 func:__its_alloc
           0        0 arch/x86/kernel/fpu/regset.c:160 func:xstateregs_set
           0        0 arch/x86/kernel/fpu/xstate.c:1590 func:fpstate_realloc
           0        0 arch/x86/kernel/cpu/aperfmperf.c:379 func:arch_enable_hybrid_capacity_scale
           0        0 arch/x86/kernel/cpu/amd_cache_disable.c:258 func:init_amd_l3_attrs
      49152*      48* arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_create
       32768        1 arch/x86/kernel/cpu/mce/genpool.c:132 func:mce_gen_pool_create
           0        0 arch/x86/kernel/cpu/mce/amd.c:1341 func:mce_threshold_create_device

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
Patch is based on mm-new.

 include/linux/alloc_tag.h | 12 ++++++++++++
 include/linux/codetag.h   |  5 ++++-
 lib/alloc_tag.c           |  7 +++++--
 mm/slub.c                 |  2 ++
 4 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 9ef2633e2c08..d40ac39bfbe8 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -221,6 +221,16 @@ static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes)
 	ref->ct = NULL;
 }
 
+static inline void alloc_tag_set_inaccurate(struct alloc_tag *tag)
+{
+	tag->ct.flags |= CODETAG_FLAG_INACCURATE;
+}
+
+static inline bool alloc_tag_is_inaccurate(struct alloc_tag *tag)
+{
+	return !!(tag->ct.flags & CODETAG_FLAG_INACCURATE);
+}
+
 #define alloc_tag_record(p)	((p) = current->alloc_tag)
 
 #else /* CONFIG_MEM_ALLOC_PROFILING */
@@ -230,6 +240,8 @@ static inline bool mem_alloc_profiling_enabled(void) { return false; }
 static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_tag *tag,
 				 size_t bytes) {}
 static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes) {}
+static inline void alloc_tag_set_inaccurate(struct alloc_tag *tag) {}
+static inline bool alloc_tag_is_inaccurate(struct alloc_tag *tag) { return false; }
 #define alloc_tag_record(p)	do {} while (0)
 
 #endif /* CONFIG_MEM_ALLOC_PROFILING */
diff --git a/include/linux/codetag.h b/include/linux/codetag.h
index 457ed8fd3214..8ea2a5f7c98a 100644
--- a/include/linux/codetag.h
+++ b/include/linux/codetag.h
@@ -16,13 +16,16 @@ struct module;
 #define CODETAG_SECTION_START_PREFIX	"__start_"
 #define CODETAG_SECTION_STOP_PREFIX	"__stop_"
 
+/* codetag flags */
+#define CODETAG_FLAG_INACCURATE	(1 << 0)
+
 /*
  * An instance of this structure is created in a special ELF section at every
  * code location being tagged.  At runtime, the special section is treated as
  * an array of these.
  */
 struct codetag {
-	unsigned int flags; /* used in later patches */
+	unsigned int flags;
 	unsigned int lineno;
 	const char *modname;
 	const char *function;
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index e9b33848700a..a7f15117c759 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -80,7 +80,7 @@ static void allocinfo_stop(struct seq_file *m, void *arg)
 static void print_allocinfo_header(struct seq_buf *buf)
 {
 	/* Output format version, so we can change it. */
-	seq_buf_printf(buf, "allocinfo - version: 1.0\n");
+	seq_buf_printf(buf, "allocinfo - version: 2.0\n");
 	seq_buf_printf(buf, "#     <size>  <calls> <tag info>\n");
 }
 
@@ -90,7 +90,10 @@ static void alloc_tag_to_text(struct seq_buf *out, struct codetag *ct)
 	struct alloc_tag_counters counter = alloc_tag_read(tag);
 	s64 bytes = counter.bytes;
 
-	seq_buf_printf(out, "%12lli %8llu ", bytes, counter.calls);
+	if (unlikely(alloc_tag_is_inaccurate(tag)))
+		seq_buf_printf(out, "%11lli* %7llu* ", bytes, counter.calls);
+	else
+		seq_buf_printf(out, "%12lli %8llu ", bytes, counter.calls);
 	codetag_to_text(out, ct);
 	seq_buf_putc(out, ' ');
 	seq_buf_putc(out, '\n');
diff --git a/mm/slub.c b/mm/slub.c
index af343ca570b5..9c04f29ee8de 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2143,6 +2143,8 @@ __alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
 	 */
 	if (likely(obj_exts))
 		alloc_tag_add(&obj_exts->ref, current->alloc_tag, s->size);
+	else
+		alloc_tag_set_inaccurate(current->alloc_tag);
 }
 
 static inline void

base-commit: f4e8f46973fe0c0f579944a37e96ba9efbe00cca
-- 
2.51.0.384.g4c02a37b29-goog


