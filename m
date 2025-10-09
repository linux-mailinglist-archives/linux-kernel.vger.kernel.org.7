Return-Path: <linux-kernel+bounces-846658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F667BC8A95
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 13:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70DDA4F3760
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 11:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1E12EA496;
	Thu,  9 Oct 2025 10:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7UOdQI9"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135B92E1EE7
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 10:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760007494; cv=none; b=m16M2HfUrcgHMcGsqkhFk2YsEFdRhwO0Ne913hbQLTugBDSg86vY4lyQCoRLF5uv1NR2hlRhPQ+3DVzcSYKiBnz7kc1HI1rLDGS4YiMw1EnMu5yCHCZjwZ6U0oAhkzXTe4ExJLaRKcq2HnbqgpP5mkqKR2iFn2m+V4XcZGfrPcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760007494; c=relaxed/simple;
	bh=zgbvGJBSx4YBKNkqO/qzz/La9XfnZ3vAatfFaQMoL7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lduR0jiGUmhIcJrSSpu3gZcniOOKOgx3nSeW7S3/DrPALMTdOXuVZFozwKhlT2IhMZSrIe2Y03EVQSQAlldXLSFNdnT6HczszBEZPOHuU2piCnZFhuwoEeEX4GnaaVpeOKe5eqzWiZtV5Fu57rqizHXKp3McqsrnAuj6KAzHsTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7UOdQI9; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-267f0fe72a1so6095045ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 03:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760007491; x=1760612291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmaGbmiuxIsK0xKTEWJ/f7gfwC2bw8p0SOLh4b9Z4FY=;
        b=E7UOdQI9HCnZcw4uCetsJxxVnlzNoFrHiMsDTfSUoAXhW6aJCYrojh5o2cwPO+4iJR
         et14Ixf632iUBv9LvIqZnu2d9iQOwf6q0NrwMPKrS7K/bx+lySw0wTQWP+F5DjG6WVPL
         mxO8wb3CF78iEpYq8TmQTtdqCOrvTrUz1PCu4nPMEu6QBYt0CO/oDp7uh9siSqXyqxdb
         MlEqW0uunkBftyJ+7zRH7O7abltplnEWfErQ4Usdx4d1OphEYablLyAPRuthU7E2dT9Y
         z/hf5TTOC4meR8c6BqmNZy4l3MXqn583hylrwkECpYZd+/c+PSEc9pakAVxlDlm2NOKI
         u0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760007491; x=1760612291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UmaGbmiuxIsK0xKTEWJ/f7gfwC2bw8p0SOLh4b9Z4FY=;
        b=Okb2LdFdO24jBFHY8jZNw2bdQrJtS4mq/syXFmVvb/to41O8Ee5jk5cFKI1FpHevr1
         zrxCkChOTRkS1Yld19NWBD1nGj/Frdf/qrTDfEn23ekfsPjo0BGx0SLVi0ss8ZfmMl1V
         ct6Wgbx/r4cPJUayLVWlJw0K0s6PQz6vfAvEl5pPKdORPLon/aiFE6Wbs8lGxEfjie0/
         uAl56rxbVgf+X6Av6pglsin8H3GBn0vpF3dlMlit88CxKt9bneyTFB7soR3LQb/0rRXc
         0IHM30AqPL4KOldam4WMvkXCr2NhmmzmS9xKfEaIHJg817ZXsrsYM9R2bzNC++1fL2jq
         5V+A==
X-Forwarded-Encrypted: i=1; AJvYcCXdOSHFkOzLCenv6mHISuC4oxfacBIikOgVukPel9EelZDXpcafwIBn3mAiJ4zwznGxVyP9idUI7CeoS2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6kt3ewqJ475pFLyaYkmGgextRAj1wqQ2PNBkMUy4myVCkgtaB
	Ff5J3MNWLgNu2cM0+c98CpF73nrT8sEkXE9FPihVx2A19ASZdjzHMwr8
X-Gm-Gg: ASbGncvC2shDwHYOOMUWhbZ6y5vV1JGz5VfIoxvXjTjCYAV/5595wBI2q/3EzIihYi8
	ClNyp7ArssNd+8TA8FRaEy5nTUJm0cmW+Cx2H59L4zjfV4ks1apa+jEFkKTTGo/3D2W4XXV+j/9
	tH8DkvPptlqZ8zTAImYee3CB0Iv4w1nJNzbFZMFL/b0WgewTCFVVHYvYuGJX+RAKxH/lVIQMI3O
	bz88nBSEgu3Esi7PCy3Awr46nKbqE0wR1f0wNZTssNviQhoV1M+C3cvKi8gJNT+3nE5ZsbcrPeH
	8i1IMoXKPF+MuyiIuPrxLgR7vBvb7mdDRdnCEE/c1oOhWoHlMdd1hcbVNMoomMTNLtAIagckKiM
	5bNWBo7HygPUqa96CJyhZNL5qfCqSKfXPyrf4xAdpYLhxr2UMGbMTHWFLtr0w
X-Google-Smtp-Source: AGHT+IE5mYvqRuQZ+u7IQ0srPI8O6QG8ywmWS1iS+UAE48zG0ZozJL4ZlmLiRWALZX5JRbD2vynFcw==
X-Received: by 2002:a17:903:2f45:b0:27e:f1d1:74e0 with SMTP id d9443c01a7336-290272b2bd5mr92577745ad.17.1760007491218;
        Thu, 09 Oct 2025 03:58:11 -0700 (PDT)
Received: from localhost ([45.142.165.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f7ab4fsm20659266a12.44.2025.10.09.03.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 03:58:10 -0700 (PDT)
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
Subject: [PATCH v7 16/23] mm/ksw: add self-debug helpers
Date: Thu,  9 Oct 2025 18:55:52 +0800
Message-ID: <20251009105650.168917-17-wangjinchao600@gmail.com>
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

Provide two debug helpers:

- ksw_watch_show(): print the current watch target address and length.
- ksw_watch_fire(): intentionally trigger the watchpoint immediately
  by writing to the watched address, useful for testing HWBP behavior.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kstackwatch.h |  2 ++
 mm/kstackwatch/watch.c       | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
index 4045890e5652..528001534047 100644
--- a/mm/kstackwatch/kstackwatch.h
+++ b/mm/kstackwatch/kstackwatch.h
@@ -52,5 +52,7 @@ void ksw_watch_exit(void);
 int ksw_watch_get(struct ksw_watchpoint **out_wp);
 int ksw_watch_on(struct ksw_watchpoint *wp, ulong watch_addr, u16 watch_len);
 int ksw_watch_off(struct ksw_watchpoint *wp);
+void ksw_watch_show(void);
+void ksw_watch_fire(void);
 
 #endif /* _KSTACKWATCH_H */
diff --git a/mm/kstackwatch/watch.c b/mm/kstackwatch/watch.c
index f32b1e46168c..9837d6873d92 100644
--- a/mm/kstackwatch/watch.c
+++ b/mm/kstackwatch/watch.c
@@ -269,3 +269,37 @@ void ksw_watch_exit(void)
 {
 	ksw_watch_free();
 }
+
+/* self debug function */
+void ksw_watch_show(void)
+{
+	struct ksw_watchpoint *wp = current->ksw_ctx.wp;
+
+	if (!wp) {
+		pr_info("nothing to show\n");
+		return;
+	}
+
+	pr_info("watch target bp_addr: 0x%llx len:%llu\n", wp->attr.bp_addr,
+		wp->attr.bp_len);
+}
+EXPORT_SYMBOL_GPL(ksw_watch_show);
+
+/* self debug function */
+void ksw_watch_fire(void)
+{
+	struct ksw_watchpoint *wp;
+	char *ptr;
+
+	wp = current->ksw_ctx.wp;
+
+	if (!wp) {
+		pr_info("nothing to fire\n");
+		return;
+	}
+
+	ptr = (char *)wp->attr.bp_addr;
+	pr_warn("watch triggered immediately\n");
+	*ptr = 0x42; // This should trigger immediately for any bp_len
+}
+EXPORT_SYMBOL_GPL(ksw_watch_fire);
-- 
2.43.0


