Return-Path: <linux-kernel+bounces-893660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9628BC480CD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE20A4EFB5D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493262882AF;
	Mon, 10 Nov 2025 16:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRabdu46"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852AD28727E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792614; cv=none; b=OFp8C+OsUO+ISRCcx8EhRYGqPvQUuEl2+kpCicq6yWYd1MjMJSEzasEOaKrWiVBrTNBcrX7gDrjJaM846zo7zzuQcU7EgArrgPnCGe67v6gcYiM9QmI3CI7gU6dyMn9r5l4JPSWX2Z0w0w40I7GNZxTTHTTQ6mZOlXryalI1v4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792614; c=relaxed/simple;
	bh=ZEq5LCeeZxdZtY+a+kvZMIoWs2Mzj+sOmq7f1LtT1gE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YhpPwrW0J4xrnSRZfXico9lZiY/fhqrP+MLM5+cbcPCD7ElxWSW3buawTG/wpPp/vSQ+Zoy5HnkEl7/+qsoy1yZGmomCZu9TxQ5zZDnjK5i3CnEqk8q0Zvmq00YnDRgcBOFi2IC/t8A0PjYlDq8v7sPONUntRX83agMFH3wvKAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRabdu46; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-295247a814bso41646505ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762792610; x=1763397410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bd/jIJYyk1G6SYf0mNQVLBMDX4oiGoErfqkyMXn4+LQ=;
        b=jRabdu46VsVuOHR63vEIRW4bFJWrUyUPWRGPfiFdsRr56n1/hyTUrG+utaSuwDnNSg
         dh8h3wgEkVWPMh82JArPRV9IvCttNB7kRZBpzMV2PdugyV/V6dipUVX1gjBuYk/Ehskx
         GJvmuwlqS0+G5X1krRIgPjL9F5ksQm+BwQEsVL8p/G8GFnO3s9K+xBMLg6UfzhNBpNym
         eNednzosnU7icEqs6IJhLw111u/Vnwe13TwOm5jbP01keq8CL4muYrVp1NNo8Wn3k1Q6
         2zn4b6FDMVmhayhu9RwNoNLkHQ4BdO8w55/KHEVA+xFAnCcg9JkgIwnnp2nIkQAQNF7K
         frIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792610; x=1763397410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bd/jIJYyk1G6SYf0mNQVLBMDX4oiGoErfqkyMXn4+LQ=;
        b=CSbHzGdyPPhrOORegwVKINZIDLkkkOmhbwVaSDbUleTelH66YlcMsKq6qu+lv1FV6H
         OkmbrtDVHaRUFPi2KE/pqa/lxCtlGLYVAa6RS90KWWDJqebpZ/s4n5yM8xdtOb03BhOE
         HLz38ev68lmqg5VtycsJeoWUx9grPkGn33kS8PinGKsPLrH9AFsxvkIF6E8pxP5aVWGY
         UV7lBKyXR6qkxlhG5TIUUZRosYx2jIoImZna39JnEz9Y82GLZT249wWrqPZpd5UWVsQg
         D3+RFdfyKXQqiY3b+ExhqVFxTm/CQpYfucNPfE5eVLxUG5mlVqd9GaJIn6bnnXlopW5q
         kGJg==
X-Forwarded-Encrypted: i=1; AJvYcCVWgZWTYwYru5ZWLxuPNGrLmrGSIjAVUg9+R6hgkr5xzXtfQMHTPUetrbGsYHfPmBV2HlGtmLuThoxWrUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUNDHkC5fwkXhN45lB4PdzAYMWX8Aw4v+TRpr0mm+BHRcavPZ3
	xPwxaQtS+vbRPZadstSITwBJq+Nn39DHSmilfRPsIBdiqL52osqIng5Q
X-Gm-Gg: ASbGncuqx//y2KX0DHi22q5l5X5C2pQ60XB29lSNT3z+g+4pkonESKVHOmrDT0KVpae
	cGUcoLwLOr3tEgGWkKc5IRSJKAFELD3kTd1I1W9fkj91tXh2If8A0qOFS74a9at8Q2tfYrJbAAV
	rfh32QYCwXwLQ1mTuGpfPvRBXxIRCJheNWl7k92Q0Uf3MUTxg7MD6rfNvv+O0DgXR8C3ep7oAev
	CkXArX/ZDsVvfM/ub7WsUoFOeDtNJTa+4h3osznxdUbRiY7bJwCOnJBPY+Pr+k19/cMracKawCO
	ThTz3Q/JXtlV3d+VsA0okCtxXsN4LM7s3K0m9acPYl24Rns85fZw8gLfR7gR5/NTUlC+RYFNx5I
	UCzDSc9TQBgHA7hjyqNM+BQGFQpCa1PXc49V4OAs+FPWz4x4wKn0bmD79Z2lDfHCl89jR5oJDjE
	ZyU6EUnIK42LjI5q7hIs192g==
X-Google-Smtp-Source: AGHT+IHC7aPoZ6nrAIOpkNf/Po8HO2SSr/NWVgq/h5VzJS+qKaFGcmt1davBTXDotW4c33fFW6QGWA==
X-Received: by 2002:a17:903:2f86:b0:295:1626:6be5 with SMTP id d9443c01a7336-297e57090dcmr104835365ad.44.1762792609610;
        Mon, 10 Nov 2025 08:36:49 -0800 (PST)
Received: from localhost ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5d0c1sm150508695ad.27.2025.11.10.08.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:36:49 -0800 (PST)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Marco Elver <elver@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ben Segall <bsegall@google.com>,
	Bill Wendling <morbo@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	David Kaplan <david.kaplan@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	Justin Stitt <justinstitt@google.com>,
	kasan-dev@googlegroups.com,
	Kees Cook <kees@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"Liang Kan" <kan.liang@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mel Gorman <mgorman@suse.de>,
	Michal Hocko <mhocko@suse.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Namhyung Kim <namhyung@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Rong Xu <xur@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Will Deacon <will@kernel.org>,
	workflows@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v8 02/27] x86/hw_breakpoint: Add arch_reinstall_hw_breakpoint
Date: Tue, 11 Nov 2025 00:35:57 +0800
Message-ID: <20251110163634.3686676-3-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110163634.3686676-1-wangjinchao600@gmail.com>
References: <20251110163634.3686676-1-wangjinchao600@gmail.com>
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


