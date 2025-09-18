Return-Path: <linux-kernel+bounces-814349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFC2B552BE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 17:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 523CA1899356
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F883074B2;
	Fri, 12 Sep 2025 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cQumRqng"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0EB301031
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757689807; cv=none; b=TckncIpEPsCA2WSPeCXdAESQgphqcyiJ0gzDMpZsRhf0S5g8nZv+pWhGi8dt4UOXV5bNOr591GEkoug5BePe+sJPy3KsjgcdfcJtz3h5qcmvvhrugTHitNnZ1svhj8bNl2V+Mw9xENAvTrL5TJV40gk00thGobvLa7ehDJShJ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757689807; c=relaxed/simple;
	bh=dv2O9w9agbngektKvmDxu7BDFlmtFAERpT9g4V25J2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0MZ/UWRtETVmao9OKFYzdG5KD4iG4AOUf7BVWWIRzC3ygGlmHZa5I6X++SP8jSPeqoIpY0B86Je7xKpKtBQtZBiTWyaJr9FlbjfpUN6vl4U+6O+w8YSOGTzBJ1gzlIUyuunPY0AmNNEsSgr1FLZXkaT6vuloif8yj0gvyAc+iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cQumRqng; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-723ad237d1eso18638637b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757689804; x=1758294604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ltLVlonCLmXqCMj5NKS1dwyzuNto475BJCWDW4VinA=;
        b=cQumRqngHyWg2L2ov4j2fDuDSEWLXvXVngMhj04E5NCwNc8DmpwSFVdXuabJS9QVrQ
         1DK0mVq0F22aFjH48rztT+1bsmNIMORm339OPrQ/VvN9EB2JqARttvrH1oo/qLofHg1G
         NOj47PgOBOYmBxs7GmxzvzZtRenO/mPaher+OrpbQ5zB40GyE/THKgkZzyvQYN3CTVzW
         Jx3Wxh3NOFU4pD55N0L2jZ13rrMICc5aKxJLIGEjYeRsG4BowKjQWM7kn4oUCM/oWrE7
         nieAimDHWnhl4oIdhV45Y7LQ9rBtR/hzshi5YS3rlHpgs7LUqYpwgjaznHRzmeBSMjc2
         HYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757689804; x=1758294604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ltLVlonCLmXqCMj5NKS1dwyzuNto475BJCWDW4VinA=;
        b=BopQZZqVhyYJ6gjmHFt6K8p+80+sc/p8yF6VdcRqg00eJpGewoAp56ctXau65c7s98
         oYYnHHnuQarS8yuuRWPo86O95WD2SQ6mQc9nsGxuoNKUwhYi6TlEU74y4G/9ggEhl2dQ
         /17P4QlmIfaRthxn+NkDoDENTun9aj2soXjl1uzuZdqJU3zjTKPet94Flgf5vgDVrDYT
         o5/Cu8Lv+CsYY4qiZAYGifGp88p0fVG+kZe9x0iKs7f9ffVpRezJSqmmdNyLs8gs+uzq
         Cgzpmx38+RiJNhGlddeSWyk6o5+S8AaecGUJgvs/iTLafETgP6iavE7DsGRndSRppsXD
         pCFg==
X-Forwarded-Encrypted: i=1; AJvYcCVoXcSaQeUTvNwNDUmGQkss06GmRD8CvpS9xYauzUJk7eueEj0gNq9WhAvecZa/eD9aAlGQBcXxkT5ERCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiZYYRrRvKoHi80CFVREKRQkMzkGfSrlxvDMvXOy3q8hB3piew
	yTCz6m9caVRjdGKQr2SJrkd88pR5ZCuYuKs0bJujvxkFn9psCzHMRqzgyBHbYamBlOw=
X-Gm-Gg: ASbGncvYjuBa73ihd7rm9TSPed9/MbDG2d4h1FoC8OlDnHReRoL+bfdsnTctc6dggC7
	2n/JIxgTEIsL54mEaWo6OmIUIRO+1+ytB4dq4sRZ8QGQwNeBa7g8qtqU+dlji/LK+XJhgBLSIZb
	LpMv1xfAlnw2EjVPVw/Gn4UnpPFxcOvnvz+latfxaFsyUIkgo4D6MdBPsnFWD+c22UB5AFWWUmY
	60l9a3FfIdj59W50m4BSfK8HhDSnl63jfBAk/4Dejmw3fbtmWzXU70TKo0Bd1BmcFDX4nrDMpuP
	3Dz7639iXlIu5v9V/iCS6hbak1LkIHbJeVgKmZ/arscjwHY1B2OSxgZN0bYu9M08P9iXjyetZPr
	JnahJarxRtR9K5PP5nfANjspN40kGNIec2eWsDyob8uWS
X-Google-Smtp-Source: AGHT+IErKNSDF6fGSUxu7uTin3OwoIqA+uAqwoNBYvN/bvRQQvIrBcXKk9r6zS33h/brxBiiTlCCzQ==
X-Received: by 2002:a05:690c:7442:b0:725:74c3:75eb with SMTP id 00721157ae682-73065da8ef0mr33696617b3.54.1757689804212;
        Fri, 12 Sep 2025 08:10:04 -0700 (PDT)
Received: from eugen-station.. ([145.224.119.89])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-624841586c1sm1302244d50.6.2025.09.12.08.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:10:03 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com,
	rdunlap@infradead.org,
	corbet@lwn.net,
	david@redhat.com,
	mhocko@suse.com
Cc: tudor.ambarus@linaro.org,
	mukesh.ojha@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	jonechou@google.com,
	rostedt@goodmis.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [RFC][PATCH v3 03/16] kmemdump: Add coreimage ELF layer
Date: Fri, 12 Sep 2025 18:08:42 +0300
Message-ID: <20250912150855.2901211-4-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912150855.2901211-1-eugen.hristev@linaro.org>
References: <20250912150855.2901211-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement kmemdumping into an ELF coreimage.
With this feature enabled, kmemdump will assemble all the regions
into a coreimage, by having an initial first region with an ELF header,
a second region with vmcoreinfo data, and then register vital kernel
information in the subsequent regions.
This image can then be dumped, assembled into a single file and loaded
into debugging tools like crash/gdb.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 MAINTAINERS                      |   1 +
 include/linux/kmemdump.h         |  67 ++++++++++
 mm/kmemdump/Kconfig.debug        |  18 ++-
 mm/kmemdump/Makefile             |   1 +
 mm/kmemdump/kmemdump.c           |  32 +++++
 mm/kmemdump/kmemdump_coreimage.c | 222 +++++++++++++++++++++++++++++++
 6 files changed, 339 insertions(+), 2 deletions(-)
 create mode 100644 mm/kmemdump/kmemdump_coreimage.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 974f43c3902b..fc8cd34cf190 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13816,6 +13816,7 @@ S:	Maintained
 F:	Documentation/dev-tools/kmemdump.rst
 F:	include/linux/kmemdump.h
 F:	mm/kmemdump/kmemdump.c
+F:	mm/kmemdump/kmemdump_coreimage.c
 
 KMEMLEAK
 M:	Catalin Marinas <catalin.marinas@arm.com>
diff --git a/include/linux/kmemdump.h b/include/linux/kmemdump.h
index 8e764bb2d8ac..ac2eb1b4ba06 100644
--- a/include/linux/kmemdump.h
+++ b/include/linux/kmemdump.h
@@ -4,6 +4,52 @@
 
 enum kmemdump_uid {
 	KMEMDUMP_ID_START = 0,
+	KMEMDUMP_ID_COREIMAGE_ELF,
+	KMEMDUMP_ID_COREIMAGE_VMCOREINFO,
+	KMEMDUMP_ID_COREIMAGE_CONFIG,
+	KMEMDUMP_ID_COREIMAGE_MEMSECT,
+	KMEMDUMP_ID_COREIMAGE__totalram_pages,
+	KMEMDUMP_ID_COREIMAGE___cpu_possible_mask,
+	KMEMDUMP_ID_COREIMAGE___cpu_present_mask,
+	KMEMDUMP_ID_COREIMAGE___cpu_online_mask,
+	KMEMDUMP_ID_COREIMAGE___cpu_active_mask,
+	KMEMDUMP_ID_COREIMAGE_jiffies_64,
+	KMEMDUMP_ID_COREIMAGE_linux_banner,
+	KMEMDUMP_ID_COREIMAGE_nr_threads,
+	KMEMDUMP_ID_COREIMAGE_nr_irqs,
+	KMEMDUMP_ID_COREIMAGE_tainted_mask,
+	KMEMDUMP_ID_COREIMAGE_taint_flags,
+	KMEMDUMP_ID_COREIMAGE_mem_section,
+	KMEMDUMP_ID_COREIMAGE_node_data,
+	KMEMDUMP_ID_COREIMAGE_node_states,
+	KMEMDUMP_ID_COREIMAGE___per_cpu_offset,
+	KMEMDUMP_ID_COREIMAGE_nr_swapfiles,
+	KMEMDUMP_ID_COREIMAGE_init_uts_ns,
+	KMEMDUMP_ID_COREIMAGE_printk_rb_static,
+	KMEMDUMP_ID_COREIMAGE_printk_rb_dynamic,
+	KMEMDUMP_ID_COREIMAGE_prb,
+	KMEMDUMP_ID_COREIMAGE_prb_descs,
+	KMEMDUMP_ID_COREIMAGE_prb_infos,
+	KMEMDUMP_ID_COREIMAGE_prb_data,
+	KMEMDUMP_ID_COREIMAGE_runqueues,
+	KMEMDUMP_ID_COREIMAGE_high_memory,
+	KMEMDUMP_ID_COREIMAGE_init_mm,
+	KMEMDUMP_ID_COREIMAGE_init_mm_pgd,
+	KMEMDUMP_ID_COREIMAGE__sinittext,
+	KMEMDUMP_ID_COREIMAGE__einittext,
+	KMEMDUMP_ID_COREIMAGE__end,
+	KMEMDUMP_ID_COREIMAGE__text,
+	KMEMDUMP_ID_COREIMAGE__stext,
+	KMEMDUMP_ID_COREIMAGE__etext,
+	KMEMDUMP_ID_COREIMAGE_kallsyms_num_syms,
+	KMEMDUMP_ID_COREIMAGE_kallsyms_relative_base,
+	KMEMDUMP_ID_COREIMAGE_kallsyms_offsets,
+	KMEMDUMP_ID_COREIMAGE_kallsyms_names,
+	KMEMDUMP_ID_COREIMAGE_kallsyms_token_table,
+	KMEMDUMP_ID_COREIMAGE_kallsyms_token_index,
+	KMEMDUMP_ID_COREIMAGE_kallsyms_markers,
+	KMEMDUMP_ID_COREIMAGE_kallsyms_seqs_of_names,
+	KMEMDUMP_ID_COREIMAGE_swapper_pg_dir,
 	KMEMDUMP_ID_USER_START,
 	KMEMDUMP_ID_USER_END,
 	KMEMDUMP_ID_NO_ID,
@@ -60,4 +106,25 @@ static inline void kmemdump_unregister(enum kmemdump_uid id)
 }
 #endif
 
+#ifdef CONFIG_KMEMDUMP
+#ifdef CONFIG_KMEMDUMP_COREIMAGE
+int init_elfheader(void);
+void update_elfheader(const struct kmemdump_zone *z);
+int clear_elfheader(const struct kmemdump_zone *z);
+#else
+static inline int init_elfheader(void)
+{
+	return 0;
+}
+
+static inline void update_elfheader(const struct kmemdump_zone *z)
+{
+}
+
+static inline int clear_elfheader(const struct kmemdump_zone *z)
+{
+	return 0;
+}
+#endif
+#endif
 #endif
diff --git a/mm/kmemdump/Kconfig.debug b/mm/kmemdump/Kconfig.debug
index 5654180141c0..f62bde50a81b 100644
--- a/mm/kmemdump/Kconfig.debug
+++ b/mm/kmemdump/Kconfig.debug
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
-config KMEMDUMP
-	bool "KMEMDUMP: Allow the kernel to register memory regions for dumping purpose"
+menuconfig KMEMDUMP
+	bool "KMEMDUMP: Register memory regions for dumping purpose"
 	help
 	  Kmemdump mechanism allows any driver to mark a specific memory area
 	  for later dumping/debugging purpose, depending on the functionality
@@ -12,3 +12,17 @@ config KMEMDUMP
 
 	  Note that modules using this feature must be rebuilt if option
 	  changes.
+
+config KMEMDUMP_COREIMAGE
+	depends on KMEMDUMP
+	select VMCORE_INFO
+	bool "Assemble memory regions into a coredump readable with debuggers"
+	help
+	  Enabling this will assemble all the memory regions into a
+	  core ELF file. The first region will include program headers for
+	  all the regions. The second region is the vmcoreinfo and specific
+	  coredump structures.
+	  All the other regions follow. Specific kernel variables required
+	  for debug tools are being registered.
+	  The coredump file can then be loaded into GDB or crash  tool and
+	  further inspected.
diff --git a/mm/kmemdump/Makefile b/mm/kmemdump/Makefile
index f5b917a6ef5e..eed67f15a8d0 100644
--- a/mm/kmemdump/Makefile
+++ b/mm/kmemdump/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-y += kmemdump.o
+obj-$(CONFIG_KMEMDUMP_COREIMAGE) += kmemdump_coreimage.o
diff --git a/mm/kmemdump/kmemdump.c b/mm/kmemdump/kmemdump.c
index c016457620a4..3827b0597cac 100644
--- a/mm/kmemdump/kmemdump.c
+++ b/mm/kmemdump/kmemdump.c
@@ -28,6 +28,32 @@ static const struct kmemdump_backend kmemdump_default_backend = {
 static const struct kmemdump_backend *backend = &kmemdump_default_backend;
 static DEFINE_MUTEX(kmemdump_lock);
 static struct kmemdump_zone kmemdump_zones[MAX_ZONES];
+static bool kmemdump_initialized;
+
+static int __init init_kmemdump(void)
+{
+	enum kmemdump_uid uid;
+
+	init_elfheader();
+
+	mutex_lock(&kmemdump_lock);
+	/*
+	 * Some regions may have been registered very early.
+	 * Update the elf header for all existing regions,
+	 * except for KMEMDUMP_ID_COREIMAGE_ELF and
+	 * KMEMDUMP_ID_COREIMAGE_VMCOREINFO, those are included in the
+	 * ELF header upon its creation.
+	 */
+	for (uid = KMEMDUMP_ID_COREIMAGE_CONFIG; uid < MAX_ZONES; uid++)
+		if (kmemdump_zones[uid].id)
+			update_elfheader(&kmemdump_zones[uid]);
+
+	kmemdump_initialized = true;
+	mutex_unlock(&kmemdump_lock);
+
+	return 0;
+}
+late_initcall(init_kmemdump);
 
 /**
  * kmemdump_register_id() - Register region into kmemdump with given ID.
@@ -83,6 +109,9 @@ int kmemdump_register_id(enum kmemdump_uid req_id, void *zone, size_t size)
 	z->size = size;
 	z->id = uid;
 
+	if (kmemdump_initialized)
+		update_elfheader(z);
+
 	mutex_unlock(&kmemdump_lock);
 
 	return uid;
@@ -110,6 +139,9 @@ void kmemdump_unregister(enum kmemdump_uid id)
 
 	backend->unregister_region(backend, z->id);
 
+	if (kmemdump_initialized)
+		clear_elfheader(z);
+
 	memset(z, 0, sizeof(*z));
 
 	mutex_unlock(&kmemdump_lock);
diff --git a/mm/kmemdump/kmemdump_coreimage.c b/mm/kmemdump/kmemdump_coreimage.c
new file mode 100644
index 000000000000..a7b51a171d8e
--- /dev/null
+++ b/mm/kmemdump/kmemdump_coreimage.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/io.h>
+#include <linux/elfcore.h>
+#include <linux/kmemdump.h>
+#include <linux/vmcore_info.h>
+
+#define CORE_STR "CORE"
+
+#define MAX_NUM_ENTRIES	201
+
+static struct elfhdr *ehdr;
+static size_t elf_offset;
+
+static void append_kcore_note(char *notes, size_t *i, const char *name,
+			      unsigned int type, const void *desc,
+			      size_t descsz)
+{
+	struct elf_note *note = (struct elf_note *)&notes[*i];
+
+	note->n_namesz = strlen(name) + 1;
+	note->n_descsz = descsz;
+	note->n_type = type;
+	*i += sizeof(*note);
+	memcpy(&notes[*i], name, note->n_namesz);
+	*i = ALIGN(*i + note->n_namesz, 4);
+	memcpy(&notes[*i], desc, descsz);
+	*i = ALIGN(*i + descsz, 4);
+}
+
+static void append_kcore_note_nodesc(char *notes, size_t *i, const char *name,
+				     unsigned int type, size_t descsz)
+{
+	struct elf_note *note = (struct elf_note *)&notes[*i];
+
+	note->n_namesz = strlen(name) + 1;
+	note->n_descsz = descsz;
+	note->n_type = type;
+	*i += sizeof(*note);
+	memcpy(&notes[*i], name, note->n_namesz);
+	*i = ALIGN(*i + note->n_namesz, 4);
+}
+
+static struct elf_phdr *elf_phdr_entry_addr(struct elfhdr *ehdr, int idx)
+{
+	struct elf_phdr *ephdr = (struct elf_phdr *)((size_t)ehdr + ehdr->e_phoff);
+
+	return &ephdr[idx];
+}
+
+/**
+ * clear_elfheader() - Remove the program header for a specific memory zone
+ * @z: pointer to the kmemdump zone
+ *
+ * Return: On success, it returns 0, errno otherwise
+ */
+int clear_elfheader(const struct kmemdump_zone *z)
+{
+	struct elf_phdr *phdr;
+	struct elf_phdr *tmp_phdr;
+	unsigned int phidx;
+	unsigned int i;
+
+	for (i = 0; i < ehdr->e_phnum; i++) {
+		phdr = elf_phdr_entry_addr(ehdr, i);
+		if (phdr->p_paddr == virt_to_phys(z->zone) &&
+		    phdr->p_memsz == ALIGN(z->size, 4))
+			break;
+	}
+
+	if (i == ehdr->e_phnum) {
+		pr_debug("Cannot find program header entry in elf\n");
+		return -EINVAL;
+	}
+
+	phidx = i;
+
+	/* Clear program header */
+	tmp_phdr = elf_phdr_entry_addr(ehdr, phidx);
+	for (i = phidx; i < ehdr->e_phnum - 1; i++) {
+		tmp_phdr = elf_phdr_entry_addr(ehdr, i + 1);
+		phdr = elf_phdr_entry_addr(ehdr, i);
+		memcpy(phdr, tmp_phdr, sizeof(*phdr));
+		phdr->p_offset = phdr->p_offset - ALIGN(z->size, 4);
+	}
+	memset(tmp_phdr, 0, sizeof(*tmp_phdr));
+	ehdr->e_phnum--;
+
+	elf_offset -= ALIGN(z->size, 4);
+
+	return 0;
+}
+
+/**
+ * update_elfheader() - Add the program header for a specific memory zone
+ * @z: pointer to the kmemdump zone
+ *
+ * Return: None
+ */
+void update_elfheader(const struct kmemdump_zone *z)
+{
+	struct elf_phdr *phdr;
+
+	phdr = elf_phdr_entry_addr(ehdr, ehdr->e_phnum++);
+
+	phdr->p_type = PT_LOAD;
+	phdr->p_offset = elf_offset;
+	phdr->p_vaddr = (elf_addr_t)z->zone;
+	phdr->p_paddr = (elf_addr_t)virt_to_phys(z->zone);
+	phdr->p_filesz = phdr->p_memsz = ALIGN(z->size, 4);
+	phdr->p_flags = PF_R | PF_W;
+
+	elf_offset += ALIGN(z->size, 4);
+}
+
+/**
+ * init_elfheader() - Prepare coreinfo elf header
+ *		This function prepares the elf header for the coredump image.
+ *		Initially there is a single program header for the elf NOTE.
+ *		The note contains the usual core dump information, and the
+ *		vmcoreinfo.
+ *
+ * Return: 0 on success, errno otherwise
+ */
+int init_elfheader(void)
+{
+	struct elf_phdr *phdr;
+	void *notes;
+	unsigned int elfh_size;
+	unsigned int phdr_off;
+	size_t note_len, i = 0;
+
+	struct elf_prstatus prstatus = {};
+	struct elf_prpsinfo prpsinfo = {
+		.pr_sname = 'R',
+		.pr_fname = "vmlinux",
+	};
+
+	/*
+	 * Header buffer contains:
+	 * ELF header, Note entry with PR status, PR ps info, and vmcoreinfo
+	 * MAX_NUM_ENTRIES Program headers,
+	 */
+	elfh_size = sizeof(*ehdr);
+	elfh_size += sizeof(struct elf_prstatus);
+	elfh_size += sizeof(struct elf_prpsinfo);
+	elfh_size += sizeof(VMCOREINFO_NOTE_NAME);
+	elfh_size += ALIGN(vmcoreinfo_size, 4);
+	elfh_size += (sizeof(*phdr)) * (MAX_NUM_ENTRIES);
+
+	elfh_size = ALIGN(elfh_size, 4);
+
+	/* Never freed */
+	ehdr = kzalloc(elfh_size, GFP_KERNEL);
+	if (!ehdr)
+		return -ENOMEM;
+
+	/* Assign Program headers offset, it's right after the elf header. */
+	phdr = (struct elf_phdr *)(ehdr + 1);
+	phdr_off = sizeof(*ehdr);
+
+	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
+	ehdr->e_ident[EI_CLASS] = ELF_CLASS;
+	ehdr->e_ident[EI_DATA] = ELF_DATA;
+	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
+	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
+	ehdr->e_type = ET_CORE;
+	ehdr->e_machine  = ELF_ARCH;
+	ehdr->e_version = EV_CURRENT;
+	ehdr->e_ehsize = sizeof(*ehdr);
+	ehdr->e_phentsize = sizeof(*phdr);
+
+	elf_offset = elfh_size;
+
+	notes = (void *)(((char *)ehdr) + elf_offset);
+
+	/* we have a single program header now */
+	ehdr->e_phnum = 1;
+
+	/* Length of the note is made of :
+	 * 3 elf notes structs (prstatus, prpsinfo, vmcoreinfo)
+	 * 3 notes names (2 core strings, 1 vmcoreinfo name)
+	 * sizeof each note
+	 */
+	note_len = (3 * sizeof(struct elf_note) +
+		    2 * ALIGN(sizeof(CORE_STR), 4) +
+		    VMCOREINFO_NOTE_NAME_BYTES +
+		    ALIGN(sizeof(struct elf_prstatus), 4) +
+		    ALIGN(sizeof(struct elf_prpsinfo), 4) +
+		    ALIGN(vmcoreinfo_size, 4));
+
+	phdr->p_type = PT_NOTE;
+	phdr->p_offset = elf_offset;
+	phdr->p_filesz = note_len;
+
+	/* advance elf offset */
+	elf_offset += note_len;
+
+	strscpy(prpsinfo.pr_psargs, saved_command_line,
+		sizeof(prpsinfo.pr_psargs));
+
+	append_kcore_note(notes, &i, CORE_STR, NT_PRSTATUS, &prstatus,
+			  sizeof(prstatus));
+	append_kcore_note(notes, &i, CORE_STR, NT_PRPSINFO, &prpsinfo,
+			  sizeof(prpsinfo));
+	append_kcore_note_nodesc(notes, &i, VMCOREINFO_NOTE_NAME, 0,
+				 ALIGN(vmcoreinfo_size, 4));
+
+	ehdr->e_phoff = phdr_off;
+
+	/* This is the first kmemdump region, the ELF header */
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_ELF, ehdr,
+			     elfh_size + note_len - ALIGN(vmcoreinfo_size, 4));
+
+	/*
+	 * The second region is the vmcoreinfo, which goes right after.
+	 * It's being registered through vmcoreinfo.
+	 */
+
+	return 0;
+}
+
-- 
2.43.0


