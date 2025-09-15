Return-Path: <linux-kernel+bounces-817877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FE4B587FA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 01:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68F5D1B25BCD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 23:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6E82C0F64;
	Mon, 15 Sep 2025 23:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A3ybSg7m"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFD718DF9D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 23:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757977350; cv=none; b=fJ/LT/uFxjBHQHDz1O57aYGjwzagprV1P6yN3PGiXXpeebVkGzq44JBmm6XO7GwanGDiyeSGGtLR7M1DQS4tdNpmyWw3XYw0RK0pdlTHWnod++BMPqQ4bIszTRqx75XN3jY9okDVKo5X5WRcXtg8BYMgS0rFJyV7qPyj/3KlI2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757977350; c=relaxed/simple;
	bh=0h1MhiAoEq6oiAjtXd5qmd4TxH9y0nxcz5v8YR4u0wc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YGS3rfp+xcnBWE+3Z4zwUsfxzjk3Ac0vjd6lcY0uV2sQjIkVEBqsQp+/EB1bemlMevK7C847ffzQ59fxuk9ay/jBh1gFOja2WFoN0gWdbxTc6OeNawBrHK6+PNiAiywxKWMlHyHc/7dMVzwudJKyiC8jR5hLruTqDEIyUlZmaEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A3ybSg7m; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-26076dd11d1so28082445ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757977348; x=1758582148; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jlHw7peG2S0Qi11j14sbZpDivsG7e2/czsSbkXojmRs=;
        b=A3ybSg7mOBxIZzg6CyjWTj6+Ox26w9mAQmLhPmTvKE2iez6z4OHIftlNiWSz7WJxVo
         EN6WdDq4YOybWALom2LjSGhpuI9x2xPm3OrABBN1WdRCcGBB4U5EFbu7WIrVq48hZLiJ
         0IzFmmqKTUw1DLHsSIEkhZoNEBqcXCjA7B4IXvg8dmvA3ApAuYHQUucQnzYW/Gv3BPCr
         V+x3DOZ34Y8M2yi9nd/z64HEhDa8Z6rxAypkzqSMLQXrbrcIl3ZQDwSh2i/DmbBKo4k4
         ZlmFqQoA7Q099egqkujo1IdV1tERTLBl7d6t7rtdIuGsZvitVb23WRVRbKYHbAASC+90
         k7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757977348; x=1758582148;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jlHw7peG2S0Qi11j14sbZpDivsG7e2/czsSbkXojmRs=;
        b=qK6lmNseIdCMy5InK3a+ugKCEEG8nvfRsRZN15DvM5JmDpVstvyhVADIHZD+600ZR2
         yfejvilEubK1AbKbOP1Kn03jz5D8wNks0WvCW28O47m6RnmkMiXLcNhv6+1DolBQsWvR
         Is2SZzTfql7XSP2tsj+n74o/X8ZPxNfU2Tc4ELpNCDzBnjsHpzO7j3lf+JMwY4skxRjV
         xHBWF8DMkX4AoDgefWaLg0Rn2uAOvtqgcvm9qrXoTFELyorMVmYgL5SYEo83C+P6RI9A
         ghE3aryYLq3c5KRD8RW49fTkaso/R12zdC2pljy0GV9wJus2VmxQbh+hU3JK6uJCbxUR
         hQKw==
X-Forwarded-Encrypted: i=1; AJvYcCUVrlGUMbtFO5ydVuq+pA20LgIOT4z6CyJuQ2W2Ed6qxO8+f8p2ITjXctOdRWDake99kd8V3DMVatiAb6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyeENdRun15zV0t5jvQ4hYRqK6H09y57WJsDH4+vbu3d+EloXD
	oftiAyu8q5PPHz8G3nQdwoBH8RDu/vo4eq5HlbUaRvW4++0nyB2TkgX8SuDAteNAyyl5HXz8WUc
	eKcKbDQ==
X-Google-Smtp-Source: AGHT+IEa1X3jMZjRLKCtcr+A3H7RIfpidT0aOh+QBF0f2k8RzePHSyK+dGRZKFa2h4fT/nJO233GwItZfIQ=
X-Received: from plii18.prod.google.com ([2002:a17:902:eb52:b0:25d:510:6240])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f0f:b0:24b:1589:5054
 with SMTP id d9443c01a7336-25d250961b0mr172831595ad.23.1757977348111; Mon, 15
 Sep 2025 16:02:28 -0700 (PDT)
Date: Mon, 15 Sep 2025 16:02:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250915230224.4115531-1-surenb@google.com>
Subject: [PATCH v2 1/1] alloc_tag: mark inaccurate allocation counters in
 /proc/allocinfo output
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, vbabka@suse.cz, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, rientjes@google.com, roman.gushchin@linux.dev, 
	harry.yoo@oracle.com, shakeel.butt@linux.dev, 00107082@163.com, 
	pyyjason@gmail.com, pasha.tatashin@soleen.com, souravpanda@google.com, 
	surenb@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

While rare, memory allocation profiling can contain inaccurate counters
if slab object extension vector allocation fails. That allocation might
succeed later but prior to that, slab allocations that would have used
that object extension vector will not be accounted for. To indicate
incorrect counters, "accurate:no" marker is appended to the call site
line in the /proc/allocinfo output.
Bump up /proc/allocinfo version to reflect the change in the file format
and update documentation.

Example output with invalid counters:
allocinfo - version: 2.0
           0        0 arch/x86/kernel/kdebugfs.c:105 func:create_setup_data_nodes
           0        0 arch/x86/kernel/alternative.c:2090 func:alternatives_smp_module_add
           0        0 arch/x86/kernel/alternative.c:127 func:__its_alloc accurate:no
           0        0 arch/x86/kernel/fpu/regset.c:160 func:xstateregs_set
           0        0 arch/x86/kernel/fpu/xstate.c:1590 func:fpstate_realloc
           0        0 arch/x86/kernel/cpu/aperfmperf.c:379 func:arch_enable_hybrid_capacity_scale
           0        0 arch/x86/kernel/cpu/amd_cache_disable.c:258 func:init_amd_l3_attrs
       49152       48 arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_create accurate:no
       32768        1 arch/x86/kernel/cpu/mce/genpool.c:132 func:mce_gen_pool_create
           0        0 arch/x86/kernel/cpu/mce/amd.c:1341 func:mce_threshold_create_device

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Usama Arif <usamaarif642@gmail.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
Changes since v1[1]:
- Changed the marker from asterisk to accurate:no pair, per Andrew Morton
- Documented /proc/allocinfo v2 format
- Update the changelog
- Added Acked-by from v2 since the functionality is the same,
per Shakeel Butt, Usama Arif and Johannes Weiner

[1] https://lore.kernel.org/all/20250909234942.1104356-1-surenb@google.com/

 Documentation/filesystems/proc.rst |  4 ++++
 include/linux/alloc_tag.h          | 12 ++++++++++++
 include/linux/codetag.h            |  5 ++++-
 lib/alloc_tag.c                    |  4 +++-
 mm/slub.c                          |  2 ++
 5 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 915a3e44bc12..1776a06571c2 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -1009,6 +1009,10 @@ number, module (if originates from a loadable module) and the function calling
 the allocation. The number of bytes allocated and number of calls at each
 location are reported. The first line indicates the version of the file, the
 second line is the header listing fields in the file.
+If file version is 2.0 or higher then each line may contain additional
+<key>:<value> pairs representing extra information about the call site.
+For example if the counters are not accurate, the line will be appended with
+"accurate:no" pair.
 
 Example output.
 
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
index 79891528e7b6..12ff80bbbd22 100644
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
 
@@ -92,6 +92,8 @@ static void alloc_tag_to_text(struct seq_buf *out, struct codetag *ct)
 
 	seq_buf_printf(out, "%12lli %8llu ", bytes, counter.calls);
 	codetag_to_text(out, ct);
+	if (unlikely(alloc_tag_is_inaccurate(tag)))
+		seq_buf_printf(out, " accurate:no");
 	seq_buf_putc(out, ' ');
 	seq_buf_putc(out, '\n');
 }
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
-- 
2.51.0.384.g4c02a37b29-goog


