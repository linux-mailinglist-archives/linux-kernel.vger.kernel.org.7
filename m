Return-Path: <linux-kernel+bounces-837005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40624BAB147
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C32A9192493A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 02:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D776A22256F;
	Tue, 30 Sep 2025 02:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="At/mkakS"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B3C26A0D5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759200352; cv=none; b=iZa6SK1rNJ9Rv+UuXk6ICqcMYni179cBjC1U93rGvlTt53oceWfF2yc0nDEhv8bk56zyfa2LrTuRGW/Feg65mgXHGtPgYMe6Y5IiNh8C9sP+G+kAqou5hQpeMFbKXQJgk14WE2Ahtymg1mbKy8lpJxrLHNqol/7POvF/HvHYeHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759200352; c=relaxed/simple;
	bh=4AK69KqpFrfryQfFlxiqdszD58BNzBtZp9+AZ2x2szQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPlRHfL776yy+VNVWt5ARXcLdQnotHr7p7mtdV+xhXMoX1bO038I3RfXXh3pjzxVEvkqN/NyCDWJV2py2EMv1YkVth+SFnXU7O2HFq1F7tvqCWPAPJy5Z2VIqBV/w24C5P9LBh2DZZpHuu4kcoJVzSES9oQzRg33s1uPhNueSgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=At/mkakS; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b57f361a8fdso2437729a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 19:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759200349; x=1759805149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OyJZmUduTn6h/ct8/Xe3ui1NubLI+U0SzVd7OlZC6q4=;
        b=At/mkakSsbThjvq1VCdPXFxgc5mr2Fvd+66tFTKnKNWJ940mtDYTlaR+Xkaj/EmdK9
         wi8rNAwLTesILnSwinZ8hdOi5TzLATKpCnj2ZCaF1g5zcK4q6ZX5bXHXKc68S50U+VKs
         Box3x07QzH5mFRrR8nlbzIdKwCm64mWNMVQBIwX7hOBqSoESCxF5tj3+2OtiM2J/noaJ
         vG5rU87/uZ3RvtXT+9oxBnRYBG7tZRX07LPRingoyf0LuWZi0V6pasUfk+G1GM/edq9t
         a7YdVaO+64eySonZirz74eqyJx9WUlHl7kFcj4ddaL9PysIOy/dnGY2pga6shHm3h15Y
         nEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759200349; x=1759805149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OyJZmUduTn6h/ct8/Xe3ui1NubLI+U0SzVd7OlZC6q4=;
        b=vWndss2vODK+UnTCMlFZf4OlXdnI/CxUSLjyjmmqXQwfTHdCWve6UZCkon/a0C23E0
         Q5VodcoBG/Q5HQkl3gzif71aUJP/RKoH/ZseUjuycdv6Y3idcTZKrFyMxMe/jlXiO9eq
         4MSV6G7mWT/O5WO34/jDb679td23gKGBy1T0C9Kyt4tAKC3Hf//jqqLOIzkBnRaRdqwn
         Gd8IFiga/tBRcmmOujTd1W/sNjFFq+OuKIusd/ZWtJI28ajIHPxE8JYZdsJGUQ21sUFj
         flr826R36N14NSlJ8ZH5GUUULjdb+hkW1osMr8+Y5B8GbPtvhy9U04uvRkGUwpQj+Ikq
         6pcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCmh+/aW4R/h3uxEwFYoci/OlySwQmmDD4D3Wh2AJezAx4dj9UtImcRakz8B4iqPLEzuq2Vp3bskFDGVM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1QNXFOe5E9N3qDkVhKwjp4xZU+pn8l8o73PQuUgOCuKXY+g+I
	e9jsdF0TgWVr9qTmWD27nj1SSu3aDWkvPO14LAoz6/pJiNp/HAbGGQBL
X-Gm-Gg: ASbGncsSWW8dCD7VPcM3qf231b+Aa/DerXWB3SDLE38YNNkgcDYfraZCf/Ie2wS6dyd
	Rtj//upyJ28MZUvD4ijhhstSSQe+JREyD4uLKncxJIwa3N2L1TvDeedWjmxAGBlYE/3ZkMJu3b/
	XQwFM7U9eHdY8pI51qVe/FvRtJCa164Aq5lW4I5uGkkYIMPTShByy1Y5TZ3KILvNZenQfmIPkwg
	fgdATOl9v0CuqugIwAIEwkIdkfIVwV3p1jcGADESuTJwTsHi3fav1rzAeR2zVtZ95cLuFL+Dh4U
	n3EHY6R+pRf7gTxAdyXsIaLIhMNIPdpMDu7B4VgqFg7LczJXsg7yKAwsjCn3fuTIcORbpoaK1jP
	9A516J33US6k4JRv7tuIKIPh6B2YnfhVAzFqUoNC938oMD2fphl2E9rg5FKd/i0+w4G9GHEGly+
	sS
X-Google-Smtp-Source: AGHT+IEG0ThZV7fyWTs1y7QMeQlbcUpJL85C4JXPKzErGd8yhJciSmW04rCMUIpToCmcRIvMPIF8Hg==
X-Received: by 2002:a17:903:2352:b0:249:44b5:d5b6 with SMTP id d9443c01a7336-27ed4a920b9mr200539425ad.40.1759200349322;
        Mon, 29 Sep 2025 19:45:49 -0700 (PDT)
Received: from localhost ([45.142.167.196])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6886c9csm145811695ad.88.2025.09.29.19.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 19:45:48 -0700 (PDT)
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
Subject: [PATCH v6 18/23] mm/ksw: add stack overflow test
Date: Tue, 30 Sep 2025 10:43:39 +0800
Message-ID: <20250930024402.1043776-19-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250930024402.1043776-1-wangjinchao600@gmail.com>
References: <20250930024402.1043776-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the test module with a new test case (test1) that intentionally
overflows a local u64 buffer to corrupt the stack canary.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/test.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/mm/kstackwatch/test.c b/mm/kstackwatch/test.c
index 80fec9cf3243..012692c97a50 100644
--- a/mm/kstackwatch/test.c
+++ b/mm/kstackwatch/test.c
@@ -32,6 +32,20 @@ static void test_watch_fire(void)
 	pr_info("exit of %s\n", __func__);
 }
 
+static void test_canary_overflow(void)
+{
+	u64 buffer[BUFFER_SIZE];
+
+	pr_info("entry of %s\n", __func__);
+
+	/* intentionally overflow */
+	for (int i = BUFFER_SIZE; i < BUFFER_SIZE + 10; i++)
+		buffer[i] = 0xdeadbeefdeadbeef;
+	barrier_data(buffer);
+
+	pr_info("exit of %s\n", __func__);
+}
+
 static ssize_t test_dbgfs_write(struct file *file, const char __user *buffer,
 				size_t count, loff_t *pos)
 {
@@ -54,6 +68,9 @@ static ssize_t test_dbgfs_write(struct file *file, const char __user *buffer,
 		case 0:
 			test_watch_fire();
 			break;
+		case 1:
+			test_canary_overflow();
+			break;
 		default:
 			pr_err("Unknown test number %d\n", test_num);
 			return -EINVAL;
@@ -74,7 +91,8 @@ static ssize_t test_dbgfs_read(struct file *file, char __user *buffer,
 		"============ usage ===============\n"
 		"Usage:\n"
 		"echo test{i} > /sys/kernel/debug/kstackwatch/test\n"
-		" test0 - test watch fire\n";
+		" test0 - test watch fire\n"
+		" test1 - test canary overflow\n";
 
 	return simple_read_from_buffer(buffer, count, ppos, usage,
 				       strlen(usage));
-- 
2.43.0


