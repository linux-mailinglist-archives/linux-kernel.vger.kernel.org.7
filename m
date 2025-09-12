Return-Path: <linux-kernel+bounces-814361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5667B552EA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 17:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE4A3A8921
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABD132A832;
	Fri, 12 Sep 2025 15:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WubJAJkO"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5EF32A80A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757689866; cv=none; b=UXPzKuo0b4f+Hv4iXvH/G5fqWnGWMvoPBW1jDjaDXO364DncOHi3lCp8ChBLjtnQWZQ27aDBmjU+eb0SNrzj/KmzHaLI3UEookFSCtLgC18/5pzjc2J2HR5ExKTugExNAdxxQhMBb3o1f+al3/6JeD5wvDLEc7j6wCtjdd6cxwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757689866; c=relaxed/simple;
	bh=olisOB+5za+t4P5vR3SQezv1tTe26b/8LyNxmfx828U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vt+gDUcTVMzaim/aMQ5MQtTuccGqqRdsJB0bW3L8zFGn3woZ7HrPBdoBYYcY6yJX42YEXFnQrIWrVQesHZBlYXeeY6niQ4FI9WdMeZjXG4JGzmgAgoA99Qv+yGAlXjbFanb4Ja4+533mKnOdW9K7Dz6J1dmMg7hef1bsXb4VT7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WubJAJkO; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d603acc23so13748837b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757689863; x=1758294663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNgnuqtXCBxfx2G2dXAsaT/aGFlSDDhwnEcansq3QOI=;
        b=WubJAJkOJQnIMhnn6IzLIe0buPcWdYUddOlJ0l5R+p78Ifc8WWmzsO15i1RxkBwBhQ
         laZtmtcDDz0WUY+8wiov2UGfhMzKbXO8p8d346MZWentphqz1ZsQYIf72mOU5fNwZOxO
         bbk1kgDbV8O8p2gtoNwBtE7jnLpjB+FUbyo227s1MuK2cRTJqrMH/4NbfkWVGqpn/DOZ
         hr3Vid4R+QGNOhaWsc9UQs1d1rRutUuW/r+eEqEXCfufJRmuemjyIxF9Yuj9R08nV3Iw
         rduH/KgjoXP7SdYERbohUuJ6XqAW/vNJqWH5XEDBN6xBen5UNeYDHvh4nznAcpNNo5xW
         64Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757689863; x=1758294663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNgnuqtXCBxfx2G2dXAsaT/aGFlSDDhwnEcansq3QOI=;
        b=ox4mcojWe/gRrApiwC3DMCG+b8/Oj2y+c8ZXxM6QSK44hqn6SzJc2KdxCYE4lgouZx
         BcaThYQOzD5S3+kQ5U1yC2rSL0ZzAw62M/Z3k4kDbgQIHfOphT/DQZSqYBIIBa+cYtb2
         CLNQS0/1FrSoxJGzoaU3y3RZxU8aops8W0OKAEH6Li1w4zLg4rGRaJdne889WnOjZ/Tp
         OcmGXQb8NWnwjksyoBB5iPmfffN6CTLKH+SvDtxyi4p7rJJ1oBh7P9HV9QMyXWurNS7t
         q29yXTFoxm1nc8EgTxAXwaA+hNtAu00nbpw/NTEakcVQAusNemeIW9w6pPd/49IyjGdv
         C+FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVehsrFT9VSOpO/YAOIPlq90QEpDW5+y/ZJLPQdGbpxrfxj+QxgdBQ/zLAnqYAVu7/xgKouYIMPEOUSyqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy6CfUSEw//1wPR6V2iep8w7zq2EMfxZ+o9QCp9TmKx+a2psyL
	EDTvKl6rFQyuP9Y4/Gbb9WJo+x1qRsiBIg75T/z071DdYmm23rza6gqWZcH/NzvxzKGbt4C5dqd
	WuyCbYQoALA==
X-Gm-Gg: ASbGncvtG3QRLNmjZqs+qnbNodPVFj18k2uQY243h5+9YUxJilFFb0F1ZyNYFmyfl9M
	F9WYVd9nHj/vg92fPMEivuu9pO9umJo+6Y+8LifDs8aGZ+mL27LTUATKTRGqo36u05ujFFAn6om
	IJmfa9BPY4klJPZIJiMJ17Idq7e/qVe5WTxJXIINS1B1VouHnQJ5PHkqpsEYt/SSywyN30PUJKl
	wCmm5PucctvRt/S6fTTXGFdj9Ghv50d3o3OmNjVtzaWcMAR3utWtEn3pLa8SxwHXm4PK98sArRk
	FzICXTZLMuNyNIXMNczFwTxA/G0qSuaSc4xxkgXJWkF1LOd4DSeDnqJOOJ59K8YKjQG5hbuWFBW
	5vZ+QSoxIHYGDZ/ivj7F04+HE5xigr1/C9w==
X-Google-Smtp-Source: AGHT+IEtne9c9aNxfz8OotnYXAiNsAB4JCtq87oaoJ7ML/Nd9NUoYp51pIa4pWBpc4rPSN6ehP6TAw==
X-Received: by 2002:a05:690c:9688:b0:721:1c48:a627 with SMTP id 00721157ae682-730627c990emr26695147b3.6.1757689862953;
        Fri, 12 Sep 2025 08:11:02 -0700 (PDT)
Received: from eugen-station.. ([145.224.119.89])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-624841586c1sm1302244d50.6.2025.09.12.08.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:11:02 -0700 (PDT)
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
Subject: [RFC][PATCH v3 14/16] kernel/vmcoreinfo: Register kmemdump core image information
Date: Fri, 12 Sep 2025 18:08:53 +0300
Message-ID: <20250912150855.2901211-15-eugen.hristev@linaro.org>
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

The coreimage generated by kmemdump requires some kernel information
in order to be successfully loaded by `crash` or gdb.
Register all this information through vmcoreinfo once vmcoreinfo is setup.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/vmcore_info.c | 141 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c
index 3e2e846ba9c8..1d83e95cf9be 100644
--- a/kernel/vmcore_info.c
+++ b/kernel/vmcore_info.c
@@ -15,6 +15,7 @@
 #include <linux/memblock.h>
 #include <linux/kmemleak.h>
 #include <linux/kmemdump.h>
+#include <linux/sched/stat.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -24,6 +25,17 @@
 #include "kallsyms_internal.h"
 #include "kexec_internal.h"
 
+void sched_get_runqueues_area(void **start, size_t *size);
+
+extern unsigned int nr_irqs;
+extern unsigned long tainted_mask;
+extern unsigned int nr_swapfiles;
+
+#ifdef CONFIG_IKCONFIG_PROC
+extern char kernel_config_data;
+extern char kernel_config_data_end;
+#endif
+
 /* vmcoreinfo stuff */
 unsigned char *vmcoreinfo_data;
 size_t vmcoreinfo_size;
@@ -121,8 +133,137 @@ EXPORT_SYMBOL(paddr_vmcoreinfo_note);
 
 static void vmcoreinfo_kmemdump(void)
 {
+	void *start;
+	size_t size;
+	int i;
+
 	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_VMCOREINFO,
 			     (void *)vmcoreinfo_data, vmcoreinfo_size);
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_linux_banner,
+			     (void *)&linux_banner, banner_len);
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_init_uts_ns,
+			     (void *)&init_uts_ns, sizeof(init_uts_ns));
+
+	sched_get_runqueues_area(&start, &size);
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_runqueues,
+			     (void *)start, size);
+
+#ifdef CONFIG_IKCONFIG_PROC
+	/* Register 8 bytes before and after, to catch the marker too */
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_CONFIG,
+			     (void *)&kernel_config_data - 8,
+			     &kernel_config_data_end - &kernel_config_data + 16);
+#endif
+
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE___cpu_possible_mask,
+			     (void *)&__cpu_possible_mask,
+			     sizeof(__cpu_possible_mask));
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE___cpu_active_mask,
+			     (void *)&__cpu_active_mask,
+			     sizeof(__cpu_active_mask));
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE___cpu_online_mask,
+			     (void *)&__cpu_online_mask,
+			     sizeof(__cpu_online_mask));
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE___cpu_present_mask,
+			     (void *)&__cpu_present_mask,
+			     sizeof(__cpu_present_mask));
+
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_nr_irqs,
+			     (void *)&nr_irqs, sizeof(nr_irqs));
+
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_tainted_mask,
+			     (void *)&tainted_mask, sizeof(tainted_mask));
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_taint_flags,
+			     (void *)&taint_flags, sizeof(taint_flags));
+
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_jiffies_64,
+			     (void *)&jiffies_64, sizeof(jiffies_64));
+
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_nr_threads,
+			     (void *)&nr_threads, sizeof(nr_threads));
+
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_node_states,
+			     (void *)&node_states, sizeof(node_states));
+
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_init_mm,
+			     (void *)&init_mm, sizeof(init_mm));
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_init_mm_pgd,
+			     (void *)&init_mm.pgd, sizeof(*init_mm.pgd));
+
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE__totalram_pages,
+			     (void *)&_totalram_pages, sizeof(_totalram_pages));
+
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_nr_swapfiles,
+			     (void *)&nr_swapfiles, sizeof(nr_swapfiles));
+
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE___per_cpu_offset,
+			     (void *)&__per_cpu_offset, sizeof(__per_cpu_offset));
+
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_high_memory,
+			     (void *)&high_memory, sizeof(high_memory));
+#ifdef CONFIG_NUMA
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_node_data,
+			     (void *)&node_data,
+			     MAX_NUMNODES * sizeof(struct pglist_data));
+
+	for (i = 0; i < MAX_NUMNODES; i++) {
+		if (!NODE_DATA(i))
+			continue;
+		kmemdump_register((void *)NODE_DATA(i),
+				  roundup(sizeof(pg_data_t), SMP_CACHE_BYTES));
+	}
+#endif
+
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_mem_section,
+			     (void *)&mem_section, sizeof(mem_section));
+	for (i = 0; i < NR_SECTION_ROOTS; i++) {
+		if (!mem_section[i])
+			continue;
+		kmemdump_register((void *)mem_section[i],
+				  SECTIONS_PER_ROOT * sizeof(struct mem_section));
+	}
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_MEMSECT,
+			     (void *)mem_section,
+			     sizeof(struct mem_section *) * NR_SECTION_ROOTS);
+
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_kallsyms_num_syms,
+			     (void *)&kallsyms_num_syms,
+			     sizeof(kallsyms_num_syms));
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_kallsyms_relative_base,
+			     (void *)&kallsyms_relative_base,
+			     sizeof(kallsyms_relative_base));
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_kallsyms_offsets,
+			     (void *)&kallsyms_offsets,
+			     sizeof(&kallsyms_offsets));
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_kallsyms_names,
+			     (void *)&kallsyms_names,
+			     sizeof(&kallsyms_names));
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_kallsyms_token_table,
+			     (void *)&kallsyms_token_table,
+			     sizeof(&kallsyms_token_table));
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_kallsyms_token_index,
+			     (void *)&kallsyms_token_index,
+			     sizeof(&kallsyms_token_index));
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_kallsyms_markers,
+			     (void *)&kallsyms_markers,
+			     sizeof(&kallsyms_markers));
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_kallsyms_seqs_of_names,
+			     (void *)&kallsyms_seqs_of_names,
+			     sizeof(&kallsyms_seqs_of_names));
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE__sinittext,
+			     (void *)&_sinittext, sizeof(&_sinittext));
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE__einittext,
+			     (void *)&_einittext, sizeof(&_einittext));
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE__end,
+			     (void *)&_end, sizeof(&_end));
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE__text,
+			     (void *)&_text, sizeof(&_text));
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE__stext,
+			     (void *)&_stext, sizeof(&_stext));
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE__etext,
+			     (void *)&_etext, sizeof(&_etext));
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_swapper_pg_dir,
+			     (void *)&swapper_pg_dir, sizeof(&swapper_pg_dir));
 }
 
 static int __init crash_save_vmcoreinfo_init(void)
-- 
2.43.0


