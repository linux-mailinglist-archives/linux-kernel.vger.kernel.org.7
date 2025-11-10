Return-Path: <linux-kernel+bounces-893675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4004C482A8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E4C4A1D71
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A1E31CA50;
	Mon, 10 Nov 2025 16:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akYXr6hT"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B80031B839
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792675; cv=none; b=WkGsrIxkoobbdDmiMHOs6Vfci/PCbOzpMoZVO1oX01B8K4qdnObgUV6k7pEo4loCvljGMKct+6mjMas5GPSCh5+IHxl8MZh+6iaAZFndMGRpA+0jn2MoWjLTXOqBGoIwFJWA/FOTU8ynBMmUHDgtc+Z1PnWbO8qLn+oSmnTpWKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792675; c=relaxed/simple;
	bh=wQ1McUxBvOQybWZtkihRRIOMW2MyuqP74EGicbjl+yY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/ybs9snnIJN3kVh1XbR4nPeXsjK9JiQC4mfAgwz9XMEE4ezzg9RAcmC/AQfg0wi/BCRHldU5gGGej2elHKP9JlPuNEdcLU3V/yuQmmImTBW+H4lE8rajVq8Hu/HYEpH6dLxpTOFaO5Gabxyow00N0ChRYghr3fOhgH9GJqf7r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akYXr6hT; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3436a97f092so2885552a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762792673; x=1763397473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z475VFvVTEIt4JwZ3YGODDVB/J4Mi7oiMRjRIDfUacs=;
        b=akYXr6hTTmKYO6bD/KyxeV16JXOYZWQ8DwCYDA0t0jVp3SHPE27q3tvfZErkdMW+lP
         2RSaYGsAM7BXt3NSMeS5cAQRjuQpwMA1lYXTG8f3TGbIxwGNhq9vEREUVVFEbCM5/x2m
         jE+91qFsxS+7OvZ2hTW0lIbLdO1VAcYE0ZVtpQTqaHlTLykJpl/uu5XWg/0LVEeSXk2+
         X7l3snS2OX6ralC067tjX44SbtnYJ77M2S5ykFuDV4JPGuxZ7YXw+WH+AbMxw6YSuoN0
         O5NWHDIWyPS2lY5FBZ+Wy1RAEhJBG69v0RXKnAHaaSLBwzfwkMXLuJFtazFI5aE/WXfR
         wuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792673; x=1763397473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z475VFvVTEIt4JwZ3YGODDVB/J4Mi7oiMRjRIDfUacs=;
        b=uILUCt6SUXBtGl3ujFtGQA8ivK2sEJNLSuwOJINcD1mZHb44qimxspe8huzG3/eLWL
         Swe4sQM4wzoNazAm5A1fpaxSLFCgPELRavoYexIlSlSMa6O6yt5ld+356nyBNnLuQqDz
         DBOjywmfejaobh1wN7AeEeLcqaCeIMTKqku0lIuVZ3RnanrZ6qHuOGmtWEP1bu9ngXF3
         vOlYLVHqy7qYZVyJ/zE+V8Obj3ZMTc0tKRt2IwH0M0pX/Xb5xbwOTpReiVESYfn46QFr
         HiaB3Zn8L01tmkQS44ZL+EC2a8mpq3VilXKRnL1xfaIZHjERGV1RyFCKX/Sn+fd7y5mr
         8LhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJR91Ob+O7dWfaceyalSyBII5axPl1ATO2CaKDh4P0fuefnkK2Z2/G7Ndo8nYIYYMWkPJ2MqCg11erMMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhYrTZYn1wEohDwRZCzZWUaijshn9Qprn1/AVG+eq0OP4w+wQI
	cVM80pcM2CCsBOGgfFNW/8Tx7AeZyCrULkp7hl8hfYjJFFKzHiHQpukF
X-Gm-Gg: ASbGnct93oFiT3D3zQ585v0Txwpc3LHA3XhkspQ7MNhkCBLP+XJf6adQRh8YuuhyDM4
	vSaV3V3fC+OXG2VUXHWbv20q44pARJF7M8PAjF2M5w8/jl/kyXX9vFUdo1e3vO+NraPC2GOXaVP
	90PGiArEKi82XyTLnECLf5RLM+zBtc08U4c5neAi7qD4t6Oq2eSNF2uNSM5QRj+TC7NLIO6xKMm
	aYcWU6+v4c5gdwc8UUL+yCvUqM584GXV/7RhTwCFHpsdmpTHmoZB3b/ps4ScCQ35kXLojMxEqGt
	m5UJJ8xU8zym4HjmcNU4A0bePxCb4uGubIkmNbrRl1+urTdZSmxNkw6duAPb8Kuhhxrl2a0jsv3
	b0lRlOSeal1nXzNSBGlr8Tfh5DUNfoQ5pQ9ibxCYH1sV5WQoox+WA8IvsbDHpWMMjDRz35GPh4w
	uQR2v2vIkZeio=
X-Google-Smtp-Source: AGHT+IFMkp6mzspl/QeVRsUZzdmIZ1SaB55q2G1mEh95QyGe2qx8u+PVoYkCuCMgJ33eu6H6IlXxoQ==
X-Received: by 2002:a17:90b:2d0d:b0:341:d326:7354 with SMTP id 98e67ed59e1d1-3436cbda0e8mr11097915a91.37.1762792672604;
        Mon, 10 Nov 2025 08:37:52 -0800 (PST)
Received: from localhost ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68ad143sm18023453a91.3.2025.11.10.08.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:37:51 -0800 (PST)
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
Subject: [PATCH v8 16/27] mm/ksw: manage probe and HWBP lifecycle via procfs
Date: Tue, 11 Nov 2025 00:36:11 +0800
Message-ID: <20251110163634.3686676-17-wangjinchao600@gmail.com>
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

Allow dynamic enabling/disabling of KStackWatch through user input of proc.
With this patch, the entire system becomes functional.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kernel.c | 60 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 2 deletions(-)

diff --git a/mm/kstackwatch/kernel.c b/mm/kstackwatch/kernel.c
index 87fef139f494..a0e676e60692 100644
--- a/mm/kstackwatch/kernel.c
+++ b/mm/kstackwatch/kernel.c
@@ -14,6 +14,43 @@ static struct ksw_config *ksw_config;
 static struct dentry *dbgfs_config;
 static struct dentry *dbgfs_dir;
 
+static bool watching_active;
+
+static int ksw_start_watching(void)
+{
+	int ret;
+
+	/*
+	 * Watch init will preallocate the HWBP,
+	 * so it must happen before stack init
+	 */
+	ret = ksw_watch_init();
+	if (ret) {
+		pr_err("ksw_watch_init ret: %d\n", ret);
+		return ret;
+	}
+
+	ret = ksw_stack_init();
+	if (ret) {
+		pr_err("ksw_stack_init ret: %d\n", ret);
+		ksw_watch_exit();
+		return ret;
+	}
+	watching_active = true;
+
+	pr_info("start watching: %s\n", ksw_config->user_input);
+	return 0;
+}
+
+static void ksw_stop_watching(void)
+{
+	ksw_stack_exit();
+	ksw_watch_exit();
+	watching_active = false;
+
+	pr_info("stop watching: %s\n", ksw_config->user_input);
+}
+
 struct param_map {
 	const char *name;       /* long name */
 	const char *short_name; /* short name (2 letters) */
@@ -119,8 +156,18 @@ static int ksw_parse_config(char *buf, struct ksw_config *config)
 static ssize_t ksw_dbgfs_read(struct file *file, char __user *buf, size_t count,
 			      loff_t *ppos)
 {
-	return simple_read_from_buffer(buf, count, ppos, ksw_config->user_input,
-		ksw_config->user_input ? strlen(ksw_config->user_input) : 0);
+	const char *out;
+	size_t len;
+
+	if (watching_active && ksw_config->user_input) {
+		out = ksw_config->user_input;
+		len = strlen(out);
+	} else {
+		out = "not watching\n";
+		len = strlen(out);
+	}
+
+	return simple_read_from_buffer(buf, count, ppos, out, len);
 }
 
 static ssize_t ksw_dbgfs_write(struct file *file, const char __user *buffer,
@@ -135,6 +182,9 @@ static ssize_t ksw_dbgfs_write(struct file *file, const char __user *buffer,
 	if (copy_from_user(input, buffer, count))
 		return -EFAULT;
 
+	if (watching_active)
+		ksw_stop_watching();
+
 	input[count] = '\0';
 	strim(input);
 
@@ -149,6 +199,12 @@ static ssize_t ksw_dbgfs_write(struct file *file, const char __user *buffer,
 		return ret;
 	}
 
+	ret = ksw_start_watching();
+	if (ret) {
+		pr_err("Failed to start watching with %d\n", ret);
+		return ret;
+	}
+
 	return count;
 }
 
-- 
2.43.0


