Return-Path: <linux-kernel+bounces-830439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4DCB99AA0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FD0F3A85C4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDED3009E8;
	Wed, 24 Sep 2025 11:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUmmhrSR"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D1A275B05
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758714704; cv=none; b=eet/JU+4lCtJiq5/8i2GGWjH0uWII3EIfm5K9ESDilen2O1RKoLZT+rYR5riCFhrDFXFv1pgUoW2o6BVweTjU/AhMZJmOUBKSP6fETOAVJY/urZMsod5LARkt5mY+58ydwuz5+eirDHm4iWPwRgd4UzZfdgVB538Gbk+dEuevrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758714704; c=relaxed/simple;
	bh=ZEq5LCeeZxdZtY+a+kvZMIoWs2Mzj+sOmq7f1LtT1gE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZfSKE/HAj2BM9dU5putJToQwoOch5kLdxIzE8MqAgKGoeoKhIERM/ZXPCvbLoqntLrSnXth/P6OUuRH0wrhcl0YynR1b8/Zm+xaL27blSNSoF1iyvcRjoBVLbSgTvKof8jCuRxr8mwUkU6jBJA4Qlh4XPE3NgxPWJOnRh/82rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUmmhrSR; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-26a0a694ea8so46860495ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758714702; x=1759319502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bd/jIJYyk1G6SYf0mNQVLBMDX4oiGoErfqkyMXn4+LQ=;
        b=EUmmhrSRq53bJavSa3Tlj8zhdUBtY6aSahZbWXpX3Dhhmtu/PySBW64Gm6AKmIpesH
         +M9o/aTYfMreYRutgB1lgowh7+YxZwK1MPkO96+SXCQsOUXoaa+XqQyZY4VFPnUACSOu
         m2jWTlHcOst41vbek8l78BPGqYlh5+tjmx7Z3lDL9MRvzl277/wr4vXSniCdBynrM2T8
         V7Y2tkoFMktKlXkL31FTfb+HcG6QMdWS7OLVBuLYihrDKeUbQR1T8b/BQbNh5BBpLk1+
         92CwuO9f27sHSYaWUsNTo+OaSdPzfXb+/6pdFN+vqMeeU71j7FNimh7zyJ6awtjNENxc
         OtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758714702; x=1759319502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bd/jIJYyk1G6SYf0mNQVLBMDX4oiGoErfqkyMXn4+LQ=;
        b=QeSQmCwoFM91amVWlpM0FdJEdle16NJiFsSEDwi6ziLyg4YYHFmWQrsEp5B3mWhPQ+
         +w4xt1tZoXD43eYo7PE8GSto/yzdZCNj0b41/sxMIXC2Wx936xYh8jiFEorNRU4UbNyw
         2XfRx3HZkKuZkBm/vX5yua8ZnPSD/pshKwBsKS2+ude7QE3LZwXAkpGX39APBFcukDQA
         8Fm4Lc83WRrJVYzRkTLV0acWR7lF30Ho5epmmxAcE5sUfnkbz92i5YgNqPSRiatR/B7a
         2W5N+r8I/Fn1BCAdRZyzTFx51IhsXa4RVyv2pCvBKqDhBmNt/SfhQAAdWNrIHE0JypYO
         fNrA==
X-Forwarded-Encrypted: i=1; AJvYcCUavwrnH1lFUHgQkkpf1PdsUo3Ms5jf8t4E88br2FLr6ldgMRP0COXw6VGQtQbW/JU05ixoKH0YUwxPFXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKsXYha2gtWCzIESjBF6VKV+XQck73whvF1AsMVLMOKdLIcJ/m
	MVNT3z1C6hwVW3KU6wDsxIIUNj7mJoU9BwSzhulxvBD7LblXFJKok6JQ
X-Gm-Gg: ASbGnctdLzUvNr2AtCh64Xg02VMpmYt08DxJ7fyr9DPbniCsioEFvdzonjLtUuW23KW
	4XKGHb9lX48Tipi8wj6e5EkKjnSoe3CFuwbTWLP74AlMt9g9Si/e170qsmgruswyKsWdjpMs0X4
	P3pQ2OZ5J4gyOebABvyl1uO91Nt2qLnd0bXv9hCrPTJXdnZqcqwbjRXgqJXbsJ6Gv/jh5oXII9Z
	8futirm+jcqvb0SUyZu/uIaLCJKjOd2zexF+G7kmQk8wWuQ9SyWnAut3NO4TPlGssZC/Zh7Leik
	pxRUnHeQa0WzfToqG7PjlY2rESaXq+iklFmRUOsDYYCpInI8DmFOrw6D7XoqIfYwCrGblAWbgH8
	pbWG7y4Sv4TJNbzKvyCuTpUOxhg==
X-Google-Smtp-Source: AGHT+IFwE8SCr0I5b3n0uusVXZp7apxLs7ITr185XQMEgGTCAgaUjk1MsH1EiRo81SdJuGldEPeMeA==
X-Received: by 2002:a17:902:ca94:b0:276:b1ce:c094 with SMTP id d9443c01a7336-27cc543160bmr45804925ad.29.1758714701852;
        Wed, 24 Sep 2025 04:51:41 -0700 (PDT)
Received: from localhost ([23.142.224.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802df74asm189691615ad.94.2025.09.24.04.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 04:51:41 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
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
Subject: [PATCH v5 02/23] x86/hw_breakpoint: Add arch_reinstall_hw_breakpoint
Date: Wed, 24 Sep 2025 19:50:45 +0800
Message-ID: <20250924115124.194940-3-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924115124.194940-1-wangjinchao600@gmail.com>
References: <20250924115124.194940-1-wangjinchao600@gmail.com>
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


