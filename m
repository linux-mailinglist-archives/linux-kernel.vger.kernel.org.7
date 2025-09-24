Return-Path: <linux-kernel+bounces-830746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 341A9B9A6C3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F17F1896767
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D3B30BB90;
	Wed, 24 Sep 2025 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FJyramqS"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3BB30AAC2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758726013; cv=none; b=hXFdsYHde+3+YMC87qtHRkQPp8pneLRY3I3iZANjl1OoCzJjr0nOMyqIPvCql+m0eTP0+xlFHyWwOjHegN0H22SkUP3YDAGXgScdQtx9aXalCl59Yt59yglM51Uo6S3iT/iCishVbWzvGIF+KCC+Jw6qtbVLkINKT35l3hyAyNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758726013; c=relaxed/simple;
	bh=Tf59i56w6rf3fyuV0YtKRnkamzqq05gjx3hewdkc3Eo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zi+G6LWmh6IL2d1JzyfTWSOL5X4+XuHV1PW54eL6TXbW63lQIqa+cRxU3bX9TmOSK9Ge5rh+kKWQRP/QG5BFgIFFTDGKUA48WjS8Hisdz2RnI1HGMPGvNEkS6/Bie2FB9mLfum+x5nKL2NWyYQqG7BsHoVmnfdNiRJP3W6wVuL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FJyramqS; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b2c76083936so389192966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758726009; x=1759330809; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5r90z2IR0Gemmlb3xWRzXWwMPPH2fiEvwZqfzBajcPU=;
        b=FJyramqSxigCS2oVgxj7qtudCJeiFOX9jhnTAxiugedDUZgUqLRi/COzQFNdljLrAB
         Y4mXOedqxnMdqqPMOJE/7AELv+59WkzSH/39bXJpZklteQdP9cIhsyHqJdi450/HQ1b6
         ZXumyrXDQqTaSwzZJbJrnEpxXZxNPrUHsY+9qYHXjk5AQlklwikWW+tLPSAmkOAL6Frl
         jOlNjPyjdOFBIAcCn/uZsFhl2vrU3N8HM3jp6p/HiELgrwHZhGi68Ce2E/KGICrMoAB2
         6d3S9oLOrQN8FByzrkhLuy3+s+GGn9Deod9quEnRuAKWL9hMI7ISTmZYdY+O3CAAAByB
         USmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758726009; x=1759330809;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5r90z2IR0Gemmlb3xWRzXWwMPPH2fiEvwZqfzBajcPU=;
        b=wusXfll5wUkFllLqVmz4x6BrJUHFe2VhzC0LqwFPxShIEsDcKKXHk+RnF0kSzWJ39s
         s8L2ObPVu1QsUIDZijaSGWIiIWgZpMP+NIr8RKe2Pv6t4BQpV3nbX9kGck/egep2BUu8
         lTNFOhjxeLcXbCG5eEiMy6etTmhJnjNUuOtLWjiovmOxavb3x6Ij9Fr29MCUl27qiWvg
         u/w8oNrGaPphYxw65pz4u6LwW/VWJylmzmY9b+99r228T4dgVmomW77GWvLXjwd5oYlx
         SraxCLA3xThnxlAAAU6ARasfswQBebrl3wwNxRgGZDicuKyQDO8YL1D0Bl06KOpYI9oD
         44ig==
X-Forwarded-Encrypted: i=1; AJvYcCUz+G9LSnlb9rQpoK8nYFi1clkaouyro+0gtBnB380CtSFNxrH7JHY71EgaYosJMnPpes7vcZtUgCObdIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLrzkndLjozJQ0ivqZ0UA9kU0AX2SyzCMiZc5xYcannwCmVDiM
	P9sqtw7Xfy42d3VbLv5BgF4BHSQLwW5euFNdlyWtRJE3GP/jwziOtL3HJLNKzuYsvpsD3HjRRgN
	mkJdd1kqV9uptcw==
X-Google-Smtp-Source: AGHT+IHX44fYosJyVsS9pPKUxPF4QsPRR2phTVeYFYZ8rkhn5hEuqP4aCDJC7cWbgd2p6O99Y3BBHqDWpl1tVg==
X-Received: from ejcti11.prod.google.com ([2002:a17:907:c20b:b0:b2c:9261:eb0f])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:86a6:b0:b28:6440:a85c with SMTP id a640c23a62f3a-b34bc9720a6mr11837866b.50.1758726009211;
 Wed, 24 Sep 2025 08:00:09 -0700 (PDT)
Date: Wed, 24 Sep 2025 14:59:37 +0000
In-Reply-To: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250924-b4-asi-page-alloc-v1-2-2d861768041f@google.com>
Subject: [PATCH 02/21] x86/mm/asi: add X86_FEATURE_ASI and asi=
From: Brendan Jackman <jackmanb@google.com>
To: jackmanb@google.com, Andy Lutomirski <luto@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>
Cc: peterz@infradead.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	mingo@redhat.com, tglx@linutronix.de, akpm@linux-foundation.org, 
	david@redhat.com, derkling@google.com, junaids@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, reijiw@google.com, 
	rientjes@google.com, rppt@kernel.org, vbabka@suse.cz, x86@kernel.org, 
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="utf-8"

Add a CPU feature to enable ASI, and a command-line flag to enable that
feature. At present, the feature doesn't do anything, but adding it
early helps to avoid unnecessary code churn later.

The cmdline arg will eventually need an "auto" behaviour, but since this
would be equivalent to "off", don't define it yet. Just define what's
necessary to be able to test the code.

Co-developed-by: Junaid Shahid <junaids@google.com>
Signed-off-by: Junaid Shahid <junaids@google.com>
Co-developed-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  8 +++++++
 arch/x86/include/asm/asi.h                      | 10 +++++++++
 arch/x86/include/asm/cpufeatures.h              |  1 +
 arch/x86/mm/Makefile                            |  1 +
 arch/x86/mm/asi.c                               | 28 +++++++++++++++++++++++++
 arch/x86/mm/init.c                              |  3 +++
 include/linux/asi.h                             |  5 +++++
 7 files changed, 56 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6c42061ca20e581b5192b66c6f25aba38d4f8ff8..9b8330fc1fe31721af39b08b58b729ced78ba803 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5324,6 +5324,14 @@
 
 			Not specifying this option is equivalent to pti=auto.
 
+	asi=		[X86-64] Control Address Space Isolation (ASI), a
+			technology for mitigating CPU vulnerabilities. ASI is
+			not yet ready to provide security guarantees but can be
+			enabled for evaluation.
+
+			on   - unconditionally enable
+			off  - unconditionally disable
+
 	pty.legacy_count=
 			[KNL] Number of legacy pty's. Overwrites compiled-in
 			default number.
diff --git a/arch/x86/include/asm/asi.h b/arch/x86/include/asm/asi.h
index 53acdf22fe33efc6ccedbae52b262a904868459a..32a4c04c4be0f6f425c7cbcff4c58f1827a4b4c4 100644
--- a/arch/x86/include/asm/asi.h
+++ b/arch/x86/include/asm/asi.h
@@ -2,4 +2,14 @@
 #ifndef _ASM_X86_ASI_H
 #define _ASM_X86_ASI_H
 
+#include <asm/cpufeature.h>
+
+void asi_check_boottime_disable(void);
+
+/* Helper for generic code. Arch code just uses cpu_feature_enabled(). */
+static inline bool asi_enabled_static(void)
+{
+	return cpu_feature_enabled(X86_FEATURE_ASI);
+}
+
 #endif /* _ASM_X86_ASI_H */
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 4091a776e37aaed67ca93b0a0cd23cc25dbc33d4..3eee24a4cabf3b2131c34596236d8bc8eec05b3b 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -499,6 +499,7 @@
 #define X86_FEATURE_IBPB_EXIT_TO_USER	(21*32+14) /* Use IBPB on exit-to-userspace, see VMSCAPE bug */
 #define X86_FEATURE_ABMC		(21*32+15) /* Assignable Bandwidth Monitoring Counters */
 #define X86_FEATURE_MSR_IMM		(21*32+16) /* MSR immediate form instructions */
+#define X86_FEATURE_ASI			(21*32+17) /* Kernel Address Space Isolation */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 5b9908f13dcfd092897f3778ee56ea4d45bdb868..5ecbff70964f61a903ac96cec3736a7cec1221fd 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_ACPI_NUMA)		+= srat.o
 obj-$(CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS)	+= pkeys.o
 obj-$(CONFIG_RANDOMIZE_MEMORY)			+= kaslr.o
 obj-$(CONFIG_MITIGATION_PAGE_TABLE_ISOLATION)	+= pti.o
+obj-$(CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION)	+= asi.o
 
 obj-$(CONFIG_X86_MEM_ENCRYPT)	+= mem_encrypt.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_amd.o
diff --git a/arch/x86/mm/asi.c b/arch/x86/mm/asi.c
new file mode 100644
index 0000000000000000000000000000000000000000..8c907f3c84f43f66e412ecbfa99e67390d31a66f
--- /dev/null
+++ b/arch/x86/mm/asi.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/asi.h>
+#include <linux/init.h>
+#include <linux/string.h>
+
+#include <asm/cmdline.h>
+#include <asm/cpufeature.h>
+
+void __init asi_check_boottime_disable(void)
+{
+	bool enabled = false;
+	char arg[4];
+	int ret;
+
+	ret = cmdline_find_option(boot_command_line, "asi", arg, sizeof(arg));
+	if (ret == 3 && !strncmp(arg, "off", 3)) {
+		enabled = false;
+		pr_info("ASI explicitly disabled by kernel cmdline.\n");
+	} else if (ret == 2 && !strncmp(arg, "on", 2)) {
+		enabled = true;
+		pr_info("ASI enabled.\n");
+	} else if (ret) {
+		pr_err("Unknown asi= flag '%s', try 'off' or 'on'\n", arg);
+	}
+
+	if (enabled)
+		setup_force_cpu_cap(X86_FEATURE_ASI);
+}
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 8bf6ad4b9400e7a04e9dc4e341e20a4a67ddb7ab..b877a41fc291284eb271ebe764a52730d51da3fc 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/asi.h>
 #include <linux/gfp.h>
 #include <linux/initrd.h>
 #include <linux/ioport.h>
@@ -761,6 +763,7 @@ void __init init_mem_mapping(void)
 	unsigned long end;
 
 	pti_check_boottime_disable();
+	asi_check_boottime_disable();
 	probe_page_size_mask();
 	setup_pcid();
 
diff --git a/include/linux/asi.h b/include/linux/asi.h
index ef640c8e79369a9ada2881067f0c1d78093293f7..1832feb1b14d63f05bbfa3f87dd07753338ed70b 100644
--- a/include/linux/asi.h
+++ b/include/linux/asi.h
@@ -6,5 +6,10 @@
 #include <asm/asi.h>
 #else
 
+#include <linux/types.h>
+
+static inline void asi_check_boottime_disable(void) { }
+static inline bool asi_enabled_static(void) { return false; }
+
 #endif /* CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION */
 #endif /* _INCLUDE_ASI_H */

-- 
2.50.1


