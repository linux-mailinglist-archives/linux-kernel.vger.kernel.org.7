Return-Path: <linux-kernel+bounces-830462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C69B99B9E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7015188C36D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C310A302177;
	Wed, 24 Sep 2025 12:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlGOT4ZH"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4E2302143
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758715231; cv=none; b=nnOJQM4Dz1zrJdcB6S64iCC2qZspRbuQi5YujOSuGoqwGDd3+VgQVKHWMoTvv7UTUnUo9pZ+/8wsHxKolUaaq+aUls8axiw6fqtL49xopzsEeqEtHRImZgmhQHkKPe49I6HvRrciXzybbyuBpce53q1jRqA64kaNstUXj3eyOd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758715231; c=relaxed/simple;
	bh=R6xp125ow1bKW1JfsIkJbRriGQJoDt/1TV3EwU0sun4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PemrmqkRdZYeyNeTx6S9fh+Bx/YljI/UvMipapWhd+8IiP1SLK4m0xLL+ZKlLlxuLK+U/mrKARhKHh64N2KkcaAc1QoTYUT79MUp91drryj9gs/wM+9yNUcIFYkkz0PEL8xIQv6O0IZzmo1FVJF+VgIlpPKXzHpXopA54yah7ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlGOT4ZH; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77e87003967so2714869b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758715229; x=1759320029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQq22tqtHC6AWIlA5VH2udrw6r/hyqmcjV7oYivMnv0=;
        b=GlGOT4ZHoVnE+Y83TwVZIQYUOLvjpr6dD6M9u0bNDFXp9xN1I4Evfc1G5wftMK3LuK
         d0J3QqNZZbFdymIQuNrpndPXP+dv1hhjKgtrQTXXtzGwHjYwzKDQUao1nykb+mZSgL9e
         aShh9BWRDOaAJXR7QxH3qEXCyFFtW7Xb9DtN36JAR8B8idu0z8m6P+PfOnQ29N5Sm6/z
         BhRLm/NQeytMUK88zIXvdRHXHRoYb4BXoCE3c0QtQWin8QUx5+GuaJ1Fax5fXK/NFTrr
         MhQ09Lwca56BDkPxnV9EGr7Xk+nD/Gy+KZpug4OEpxiDAF3b+6WxNdOm1W7brVh+1X6O
         qGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758715229; x=1759320029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQq22tqtHC6AWIlA5VH2udrw6r/hyqmcjV7oYivMnv0=;
        b=jZXNMXqXFKWoAQhXcl0HQp+o2rsByBZk9nj/HYjJkKUjAm0J5ei+RM3oA/kPrRltZP
         q6cFSnyQ1mMEoFwEno3uPEkwNRXuPQ8z2Q5zb6vL0T+0VJdg5bIldeHuNulqaGQcN+xA
         k+9PINEkxmscCyw4VpKt6D/HNhQ+cBdAK/ZSgPXqr4QWuKuDLAzeKPMiHa85WW3J67X4
         3/bXOXFN1l5Q1TV6WhHVH4QRF+UEhUDR2qZtTdlxe5ZJGdYQVJ7+lbV3lK20X1XVrIo2
         tL9fNk42FPVfhF47hNhzAPgmP3DMgWUMkTJa7WWAyqJKVf3Yuew75iJU7QFWbrPMmiSi
         UQdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZdODdEihGHgoqch2ccmB1letxbxNJXy1UTv/4NA5ifyHuhfRqPAYV3lnFnYjyxXMzaQa+H3XSqnjfbVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdCfpmGWWotMJJ/kthfpEJ0+j7ZiBXT/XtXBqiHBH5nwnhPnzd
	CEIV/lcosyx1JJxfIoKRrxYggBmdH1jdz7N5uesAHpEIMRkUsYRo+evs
X-Gm-Gg: ASbGncs8rCVh2JVH8+yQQf8A1Vp2mjsOcOERG6B8SG9l0LPpBIqiGydpJV5rZYzdIF+
	0xY4JpS2YryVn9/oKEZnESyCB+La3U5SgOOmroVF4ANu3CnaRJ7WD68+lzdf9KfxccTsL4cxS9S
	jIWDRSocmyDnBbaTEDY7q/McNbE+Z5UM0Y0GMbdMqM/tPNsjf2wqi3Wc5Y6rUfBan0rszKsIboa
	o8xZmVgvDH2nT+4/oYYNPe+3AFER6Dz8GAqezkNSk9OJ6j8D8DCaa4HOWOkFvPn128GWPcp8vFt
	2eZ/akBmfp7nqVK3XOIqiYvSAzlXsfw5I7d0PPdKwX8PIPHudlpykA+MLTDkpP9A0SX9fsNQkKY
	A5Kqtmv26jAci9Jaz7vHEjjsG58TUVFuF+w==
X-Google-Smtp-Source: AGHT+IER+rSrafrjBOU/UPseufgUtgk4gzgFmMfLFbtCFl+/VmATfZlwQN/yKimg3zCqXqji+7ttQw==
X-Received: by 2002:a05:6a21:338a:b0:2b1:c9dc:6dab with SMTP id adf61e73a8af0-2cfef7df0b2mr8342943637.48.1758715228483;
        Wed, 24 Sep 2025 05:00:28 -0700 (PDT)
Received: from localhost ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f2fdfbffesm9620110b3a.73.2025.09.24.05.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 05:00:27 -0700 (PDT)
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
Subject: [PATCH v5 18/23] mm/ksw: add stack overflow test
Date: Wed, 24 Sep 2025 19:59:24 +0800
Message-ID: <20250924115931.197077-3-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924115931.197077-1-wangjinchao600@gmail.com>
References: <20250924115124.194940-1-wangjinchao600@gmail.com>
 <20250924115931.197077-1-wangjinchao600@gmail.com>
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
index 1ed98931cc51..740e3c11b3ef 100644
--- a/mm/kstackwatch/test.c
+++ b/mm/kstackwatch/test.c
@@ -43,6 +43,20 @@ static void test_watch_fire(void)
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
 
 static ssize_t test_proc_write(struct file *file, const char __user *buffer,
 			       size_t count, loff_t *pos)
@@ -66,6 +80,9 @@ static ssize_t test_proc_write(struct file *file, const char __user *buffer,
 		case 0:
 			test_watch_fire();
 			break;
+		case 1:
+			test_canary_overflow();
+			break;
 		default:
 			pr_err("Unknown test number %d\n", test_num);
 			return -EINVAL;
@@ -85,7 +102,8 @@ static ssize_t test_proc_read(struct file *file, char __user *buffer,
 				    "============ usage ==============\n"
 				    "Usage:\n"
 				    "echo test{i} > /proc/kstackwatch_test\n"
-				    " test0 - test watch fire\n";
+				    " test0 - test watch fire\n"
+				    " test1 - test canary overflow\n";
 
 	return simple_read_from_buffer(buffer, count, pos, usage,
 				       strlen(usage));
-- 
2.43.0


