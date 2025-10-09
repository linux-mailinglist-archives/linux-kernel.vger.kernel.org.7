Return-Path: <linux-kernel+bounces-846642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 75823BC89FD
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 12:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C35CB3525C6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 10:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D2F2DF120;
	Thu,  9 Oct 2025 10:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4Pp6a8s"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15062E03EC
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 10:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760007438; cv=none; b=CRoAtZi8nXHVg4LmjaR/D1Ak4vMYsVzLN7PDGmEje1sF7ZK8onULqWFRQqWMjMY8ZsmwmwOZQ8hSplKt5etjoSbHZQxMtPUhZFlM+gxPFqQHFhr5KCqvykvNWBj6gNjAmqPowFdv+qkrvJyeAAEHpQLZU6o7RNcemFRZbieQECg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760007438; c=relaxed/simple;
	bh=ZEq5LCeeZxdZtY+a+kvZMIoWs2Mzj+sOmq7f1LtT1gE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qL4smqxRQZX64vHgG8+2AsH1xoY8NukI2H5V5hr6rSJ/6uqrPgsgnDBigVnH42KEHXKTksDAYV1bIJQRJsTlaRAFwaGtEfRq6i7aIS+u2ekaHYYzYWbONJlv8WubBTfkeOBGM8s/N7WpFlHfyzMFaHkmdZ2q6616WdUnpIPC1FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4Pp6a8s; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b49c1c130c9so496117a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 03:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760007435; x=1760612235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bd/jIJYyk1G6SYf0mNQVLBMDX4oiGoErfqkyMXn4+LQ=;
        b=b4Pp6a8sJa2n2qbeytpIz5f3NA41jueaqkOCK4dO/3SkRa/mkKIrszTCewtb9m1VLb
         nQ1TaaSOh9Ur23oJyv8NPwu2GvohB63qYmrD/tBwJDqKPNTURSvtPigdYglPHpchnuXR
         ggVIquQ78qxY6UziF6il6ugvescs6JyhxQFGS+xktMD1GSOksGVSpNntyv8YLNfgdT0h
         7idHSXMxt+oTelQbZbnOGwt5BH4Qdn+PDksw1YDErDcZlJiuIUbuM7hNRU7L/QkmTovZ
         ZnV38Aiatc12psZ0egrAHK54zUtPOfExPWXeKE7rZnuoWpWFp3kZXXEdD69UhOY1C5Ic
         9BCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760007435; x=1760612235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bd/jIJYyk1G6SYf0mNQVLBMDX4oiGoErfqkyMXn4+LQ=;
        b=gPUzBIX+nfAs+YAbeP7Q7FVvIzV2Rzymvw1ohwGEL6rXrwz+zl0z7G76tqjc7LlEQm
         zBlqEHGmeK3Vv+SKeh31cgRCWjMdUpYUCJ4djuGQJojtlmT28F0pRVsGv/KSYnPv9ZGj
         JjIhE+KCcHPUU56q0xlLd3wbACb/I4Ssw8AlomdHZOH2gn3a6EDsJjCD1Y07pMlE6/4h
         kV5S3bejyOHM/f9c/3K1etYqgiehx5NYJl+GHlfSlEmGl+ZW1PA3qNtCqPzV5p+Ab3tA
         gfx8Q+wUyHS3QRQu7yCf3IRss74qXDY7DfOajmZ9INk1v6ISyeZu/e+henBC0SfSlVfl
         HJXA==
X-Forwarded-Encrypted: i=1; AJvYcCWSLx3dQBBlJE1LStuKdqzuA1jN4slSkeIFUxmSebz+xL1TfOhlzsYbSxiQlnibxWkc+l4jKmzwfRlEHNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE3/ckGz0hGkw42ayMoocoxGhxJALqMN/NxMgE6m5rMoNyWdtH
	82LA8+BpMwYzTiWBUFTIbL28Oo2ONP1kQRtGTjWdFtDoaMOp3TSR/xc1
X-Gm-Gg: ASbGnctH/zRiTTriYQxGlaMHdvefYpuKmlzhZgWlb3lBJn/I9fJZbDmc7CPQrjxgxSF
	5+9H1tuk5Fi+q7hI+fCLF8GXb9gchGZ6T/TkEDX3290OZ/nKY7380Pwq3EpWR9k71xZrAkYxU4O
	S3EXz1XeHa9LLJdQpfk2y0XgKTyP8tojyMP95Nj/kHgehBqne1QkN6fnLYP9AcV7Ih1/kcBTqym
	nMc4ZrcJTNErwl+o957ekHq24DpT4Tp+huxSQSXJ6Z/MiXXhHvVzu1xkYFghEOOQAp71S7tY+qh
	8RwWQ000Y7edlKNMMtjlhxYnm5bLfNB/2Z98SKmkmJy1akG5PmUteUiifC3+7rbD1JgmhG7QcO+
	7wGoI1jtov8rJUMsQTUPIL/Z/RQy0XlcTg+jD6yLJlW22GcZBiHrfXqgqToYA
X-Google-Smtp-Source: AGHT+IEE3niJRONXV0Bm+xhadUZIixrOrMgOG5awbVzvEtTxP46vMAiWCgHmPSj8i4UN21ZLnxO2Nw==
X-Received: by 2002:a17:903:2c06:b0:27e:dc53:d239 with SMTP id d9443c01a7336-290272b547bmr83465905ad.35.1760007434817;
        Thu, 09 Oct 2025 03:57:14 -0700 (PDT)
Received: from localhost ([45.142.165.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de9febsm25266445ad.7.2025.10.09.03.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 03:57:14 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Marco Elver <elver@google.com>,
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
Subject: [PATCH v7 02/23] x86/hw_breakpoint: Add arch_reinstall_hw_breakpoint
Date: Thu,  9 Oct 2025 18:55:38 +0800
Message-ID: <20251009105650.168917-3-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009105650.168917-1-wangjinchao600@gmail.com>
References: <20251009105650.168917-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new arch_reinstall_hw_breakpoint() function can be used in an
atomic context, unlike the more expensive free and re-allocation path.
This allows callers to efficiently re-establish an existing breakpoint.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/x86/include/asm/hw_breakpoint.h | 2 ++
 arch/x86/kernel/hw_breakpoint.c      | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
index aa6adac6c3a2..c22cc4e87fc5 100644
--- a/arch/x86/include/asm/hw_breakpoint.h
+++ b/arch/x86/include/asm/hw_breakpoint.h
@@ -21,6 +21,7 @@ struct arch_hw_breakpoint {
 
 enum bp_slot_action {
 	BP_SLOT_ACTION_INSTALL,
+	BP_SLOT_ACTION_REINSTALL,
 	BP_SLOT_ACTION_UNINSTALL,
 };
 
@@ -65,6 +66,7 @@ extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 
 
 int arch_install_hw_breakpoint(struct perf_event *bp);
+int arch_reinstall_hw_breakpoint(struct perf_event *bp);
 void arch_uninstall_hw_breakpoint(struct perf_event *bp);
 void hw_breakpoint_pmu_read(struct perf_event *bp);
 void hw_breakpoint_pmu_unthrottle(struct perf_event *bp);
diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index 3658ace4bd8d..29c9369264d4 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -99,6 +99,10 @@ static int manage_bp_slot(struct perf_event *bp, enum bp_slot_action action)
 		old_bp = NULL;
 		new_bp = bp;
 		break;
+	case BP_SLOT_ACTION_REINSTALL:
+		old_bp = bp;
+		new_bp = bp;
+		break;
 	case BP_SLOT_ACTION_UNINSTALL:
 		old_bp = bp;
 		new_bp = NULL;
@@ -187,6 +191,11 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 	return arch_manage_bp(bp, BP_SLOT_ACTION_INSTALL);
 }
 
+int arch_reinstall_hw_breakpoint(struct perf_event *bp)
+{
+	return arch_manage_bp(bp, BP_SLOT_ACTION_REINSTALL);
+}
+
 void arch_uninstall_hw_breakpoint(struct perf_event *bp)
 {
 	arch_manage_bp(bp, BP_SLOT_ACTION_UNINSTALL);
-- 
2.43.0


