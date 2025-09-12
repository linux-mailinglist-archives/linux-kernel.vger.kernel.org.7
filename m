Return-Path: <linux-kernel+bounces-813656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5460B548EF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36C21AA530D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9C42E62B3;
	Fri, 12 Sep 2025 10:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5bMFO1G"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE422E0B6D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671935; cv=none; b=O0xFPQZMspfzq5blRJfE5bLtfyKVC3r1OZHfE2YqjHQPOZ7Gyd2MzJtMQjAJaMDz8TMem0mDqEispNR0BlacR72aacz2Bm5BH8SmK+ireCyvwh2DwdlR45VbnViLdXXJ+1ZACg4O1SYQg0vLUlDWFy12kH5ollNecqzv1ix6VDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671935; c=relaxed/simple;
	bh=sULEjvL2pp1aXQje+Pg+BRBhTFd7HU/YOc2Kd4lZUiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OHwapX8GJFlsiL1WPA+1wVxwUQPFF/60qHxQZX5uHRdBvmZ4q13tTzSLNN/HPeh3sSHjJ/R2i4ueTuKYUMnu1/sgJm7bQM/OK+XvbaS7zG6w5T2MSEhYYvndPvmjWtNv23WyNHeK6PdPelphCEmHbkyAprbkNI4KQDiQgMsJCiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5bMFO1G; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24c784130e6so19679675ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757671933; x=1758276733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAwazreHf5k9GgDRW54pld4eDw+UAZx9M09yt/sAPVs=;
        b=k5bMFO1GSjf5QIxD8S2eqMkg0oRrt5mdIvTtrORTBbOgtyc26KVNR0RErjozCFfg+I
         PMdvXJVFQ29Qcfu+FDe5NI/k7ExnsudLXrO0AvVbTgoehCOwykQO6NngM03TsmiT6/a2
         9gnFk2ENKSOk3BMsGQdmwqpdrKA2V/3V4VeQmPSjMp/DQVL/tRiV94waFEK9Akes/K3p
         Ta5Z30RNPL6z4xmQvEoLf+5nxJJRV6N4jV9u/NPDTu4Q5LWp92sYnC048UIRJAQg0mQI
         mPlFA8I7qtIEczixafmo/NZCaWMtBstWl1jLmaGJZBl/8DzwvpCmqjZSnski48K25Veq
         PuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757671933; x=1758276733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAwazreHf5k9GgDRW54pld4eDw+UAZx9M09yt/sAPVs=;
        b=o2m8lhw8VLUZFia9kOKnx8S/2id+1dMfpbANsNF3hc3QnBTPKCfTzWNREGTGkmusO0
         KIfqZnutCbVuqVkjccX6TBy3ABqJPyr9YWPn/uNFZrmUzKA/GJBJMxOSGrKN3LhwLROH
         C5FgraPLsvKq/+wA/udDKYgConclgDjLBfG7Wsq4tcVqdXwYj0b83/fAD5uiDs78rpFs
         zfNdw3P/tP8aavAS3yLffY5wih7q5Pko+i/Hiw9gZsKRcfqi6jG7Qq7XxLD5D/wtXwyf
         NKrJw0n3nz5GLGJje+K2eeo700B+NkPkOl5mnKlcL2H9Lyof51SNsxsGgfryXjrtePDm
         ezNg==
X-Forwarded-Encrypted: i=1; AJvYcCVgH5RjnV1sEzxgxbtxODALTzV22kxO5tyR4M64VaIcXJdmqaooPqRRtQHDl2NSnwh2FUH9VA/C2lrJLwI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+JE1XCQDMomf3VvMyj7ZjXBcwybt7QgbAPpCD8dJf/4kjzTWG
	HGpFkrnxN8NIPjreHP2qeS3hVc0IGOYQA/XNQrL2EO6Fi1Eyg/Wuegau
X-Gm-Gg: ASbGncuuz+mUUStftZLzw/Jh09uDI8LIIBzfVQc+6NrcqfXtRIGagmstbA3SE/Q+I8r
	X6HxOMprEJshMqYz2Z9CZumRvDOk3SEKdE3ATV8sQTXHokbjHHeBejaKHxAocU7t8MXkfF5SFjM
	2cD/VuLCC053zPKo8Xqz0cI2xtRYsOQReNMza3t9By9UOyhmatYqtP8EyYoHiX1SJ9ddWW9IyJZ
	WGKQuZRXppL/OiDYdLwB+tmEVDzWG5OkKyi7tEU20E+Brc5qA/G6hM9VUix9bAdeVaQx54ox0s6
	JlN3X/CNZUt4VTl//BnpLUW0rj4gS9dsizw3e8Rp+FVGWW/XrVr1xp++Htdkc1dXlskvWXDWq1H
	5toNpFUjsZsxk2PRlh2oETknyzFNYrmQXAY+QTPPTFXC/Uo+SIA==
X-Google-Smtp-Source: AGHT+IE3riCCDjjOveSMsaG7I15WY9EHwk+eFKMgkgFo5ZyPShTClEykZoqvnQPNL3j1pPP9iEE3Tw==
X-Received: by 2002:a17:903:41ca:b0:24c:e6a6:9e59 with SMTP id d9443c01a7336-25d245dd6f8mr31272915ad.6.1757671932903;
        Fri, 12 Sep 2025 03:12:12 -0700 (PDT)
Received: from localhost ([185.49.34.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25e8ed36759sm6102435ad.142.2025.09.12.03.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:12:12 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <kees@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Rong Xu <xur@google.com>,
	Naveen N Rao <naveen@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Nam Cao <namcao@linutronix.de>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com,
	"David S. Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v4 03/21] HWBP: Add modify_wide_hw_breakpoint_local() API
Date: Fri, 12 Sep 2025 18:11:13 +0800
Message-ID: <20250912101145.465708-4-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912101145.465708-1-wangjinchao600@gmail.com>
References: <20250912101145.465708-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

Add modify_wide_hw_breakpoint_local() arch-wide interface which allows
hwbp users to update watch address on-line. This is available if the
arch supports CONFIG_HAVE_REINSTALL_HW_BREAKPOINT.
Note that this allows to change the type only for compatible types,
because it does not release and reserve the hwbp slot based on type.
For instance, you can not change HW_BREAKPOINT_W to HW_BREAKPOINT_X.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/Kconfig                  | 10 ++++++++++
 arch/x86/Kconfig              |  1 +
 include/linux/hw_breakpoint.h |  6 ++++++
 kernel/events/hw_breakpoint.c | 36 +++++++++++++++++++++++++++++++++++
 4 files changed, 53 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index d1b4ffd6e085..e4787fc814df 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -418,6 +418,16 @@ config HAVE_MIXED_BREAKPOINTS_REGS
 	  Select this option if your arch implements breakpoints under the
 	  latter fashion.
 
+config HAVE_REINSTALL_HW_BREAKPOINT
+	bool
+	depends on HAVE_HW_BREAKPOINT
+	help
+	  Depending on the arch implementation of hardware breakpoints,
+	  some of them are able to update the breakpoint configuration
+	  without release and reserve the hardware breakpoint register.
+	  What configuration is able to update depends on hardware and
+	  software implementation.
+
 config HAVE_USER_RETURN_NOTIFIER
 	bool
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58d890fe2100..49d4ce2af94c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -247,6 +247,7 @@ config X86
 	select HAVE_FUNCTION_TRACER
 	select HAVE_GCC_PLUGINS
 	select HAVE_HW_BREAKPOINT
+	select HAVE_REINSTALL_HW_BREAKPOINT
 	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK	if X86_64
 	select HAVE_IRQ_TIME_ACCOUNTING
diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
index db199d653dd1..ea373f2587f8 100644
--- a/include/linux/hw_breakpoint.h
+++ b/include/linux/hw_breakpoint.h
@@ -81,6 +81,9 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
 			    perf_overflow_handler_t triggered,
 			    void *context);
 
+extern int modify_wide_hw_breakpoint_local(struct perf_event *bp,
+					   struct perf_event_attr *attr);
+
 extern int register_perf_hw_breakpoint(struct perf_event *bp);
 extern void unregister_hw_breakpoint(struct perf_event *bp);
 extern void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events);
@@ -124,6 +127,9 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
 			    perf_overflow_handler_t triggered,
 			    void *context)		{ return NULL; }
 static inline int
+modify_wide_hw_breakpoint_local(struct perf_event *bp,
+				struct perf_event_attr *attr) { return -ENOSYS; }
+static inline int
 register_perf_hw_breakpoint(struct perf_event *bp)	{ return -ENOSYS; }
 static inline void unregister_hw_breakpoint(struct perf_event *bp)	{ }
 static inline void
diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 8ec2cb688903..ef9bab968b2c 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -887,6 +887,42 @@ void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events)
 }
 EXPORT_SYMBOL_GPL(unregister_wide_hw_breakpoint);
 
+/**
+ * modify_wide_hw_breakpoint_local - update breakpoint config for local cpu
+ * @bp: the hwbp perf event for this cpu
+ * @attr: the new attribute for @bp
+ *
+ * This does not release and reserve the slot of HWBP, just reuse the current
+ * slot on local CPU. So the users must update the other CPUs by themselves.
+ * Also, since this does not release/reserve the slot, this can not change the
+ * type to incompatible type of the HWBP.
+ * Return err if attr is invalid or the cpu fails to update debug register
+ * for new @attr.
+ */
+#ifdef CONFIG_HAVE_REINSTALL_HW_BREAKPOINT
+int modify_wide_hw_breakpoint_local(struct perf_event *bp,
+				    struct perf_event_attr *attr)
+{
+	int ret;
+
+	if (find_slot_idx(bp->attr.bp_type) != find_slot_idx(attr->bp_type))
+		return -EINVAL;
+
+	ret = hw_breakpoint_arch_parse(bp, attr, counter_arch_bp(bp));
+	if (ret)
+		return ret;
+
+	return arch_reinstall_hw_breakpoint(bp);
+}
+#else
+int modify_wide_hw_breakpoint_local(struct perf_event *bp,
+				    struct perf_event_attr *attr)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+EXPORT_SYMBOL_GPL(modify_wide_hw_breakpoint_local);
+
 /**
  * hw_breakpoint_is_used - check if breakpoints are currently used
  *
-- 
2.43.0


