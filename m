Return-Path: <linux-kernel+bounces-846661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6266BBC8AAA
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 13:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45531188B896
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 11:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F152EAB70;
	Thu,  9 Oct 2025 10:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdyPi9xM"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575D22EAD1B
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 10:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760007506; cv=none; b=NUwG036jIEENp3F2qOoIZ8d4oBQvxlDSEzXnr37lFTmcUqIulm88C10ZnmsQ2tF6Y6mU9xRTIarDoqtgc1LufG3FmbHlj8arr6N7qzKTLNwj5lNytMyeC+f0UJUPxDTnSIKw4PanjHIBFuaN1HuFsq0wGB1SdxKumdv5pz5K+Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760007506; c=relaxed/simple;
	bh=WUmvecag/bRJ9LbEABvkcHBuLoUzQ3sY4/EKuJYpRQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRgWUmzB92NiitULhgOGEMF+F65SFu4uZQtm5bS3tqT2I3LI/4Xcu2VEmzPxpYzBFeKATE6HyR+isapR11PQBeQ4+6/RoSOFI+Mu6DsPs13IX/+EfHkLwD/G9zI69NGS1eUb08nocuy/1IgJ5ySaGhlgx3Ftj5PiW9ZzIGDy5hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdyPi9xM; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77f1f29a551so1122050b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 03:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760007502; x=1760612302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANupiyfNlS++I01zMHP5Qbsc6Wgfn8wZLgNnwRsiWjA=;
        b=LdyPi9xMf0sABMXQbkJkxOyOHY1pmx92/10n9G7R2kH8tbO5DWwG5Viwdzo+5YUEtp
         npdE+fGvIdaHiTgyEA7wsK16gCtyIZHxj/qHN/nFIb69mbwr8vPV7VC4K0cLmLBFPKFf
         slVJxE+cRafJLgXAU//jcRlxGvvmsEYlzto4Iup6JtkTb8WQ3s3TYSLpzDWXbVqnbyVm
         mfILpsPXKyHGtD3C1OSqkzV7Fypd82SNCILp6RrJY/VjbrS0tc6VNj6qyewTRRr52wCw
         Kh42cNJd37U9CpHK7+XnpwDKIy+ANb53c4EF2t9/B8BTakyTNOQNKWyRcY0zmf2xwD59
         3qPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760007502; x=1760612302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANupiyfNlS++I01zMHP5Qbsc6Wgfn8wZLgNnwRsiWjA=;
        b=NqfKusGDz6wKnP0ULqJ/ERycKpYDVIzXv3hRaqAlFnCqSQ1z0Z6E2+ez5LVJF2KdGK
         OdqmK3J4IhxCcb9z9XtjZRtFFGU4y8AQDo7SROIrRlHnm1W3M2Z6qFTgxoLIfkwCRxWb
         5vMlCXpQ4kUzJ2ERZFqNjCrUcyv2A6atyNN29AmA7awCKj2muqBp31mkcrY/qTowHj0n
         XSUi97AFSCgYNjcqo8Xc1YYyO2ltmseB3SMqBD4vd4Wbt2Ss8muS2PxRz5w/a+zWpUjp
         gV8UMgPwlGFnggGXYn0GxSMyEHVQc+cljXa3ZEPzZ6xvvGOv5VmAfvb8LQQnC3wPZim8
         GiQw==
X-Forwarded-Encrypted: i=1; AJvYcCVmrCtOJl8cClpLuasI9izk5LbGqwXEF13RhxVKimyOrRhAcJCXNgmSNvsjkEp7Q+apBxGeEX8F/PGP7Dg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6GPKceXYt3bTwHh0FD0JuiN77jMpQtQCD0eCyFAmRGtjvQJl1
	4TrOwLAFT7esqEk3YRIl1PjqYKFvNS1xSIJJ8E1eMAhAsgGYKUfHK/DQ
X-Gm-Gg: ASbGncs6CQudg8KazlD2/w+c/Nacdp6aFoR4W+jtwG2WSHtpynKVwmPBtslIUU8tmX6
	+zbEHxUFofkJHsxsE9LcejkTA/QQ8iXYGrDOjONEPvdzMdbrfKEkZfOnZO2s6T3X2Ffb1L/DhvA
	3uYTgxm+SxxZGkKexeNxYw4420meGxvYebB3kWxucZWZuKJYqhHawML+pf19UH7daPOpJhH34Bg
	346cfwCFSP3wlJuCmFOr+EGVGEeAGRt6jXxh9XppXQJTtLF24asEhmQc/9URKvQHH/kCJb/573O
	xYLhxbr/JJ7sgskw9doKBAgTXa2GM+Jz2NLyR2RrjHp5AsLBdbws1dmUULJW/K70+snr7WAXeJT
	gl1inaIEFAlLgXYIR5J0LSiO1v1KrL6JA4PFBmkE193AFgzcaBIYQYWH7NrcJBnDaDihiXJI=
X-Google-Smtp-Source: AGHT+IGL1hfkw824Dhg5abUxp0YVqhv+dnuC2o95edaELXUy1UgmRHSa3+FhXmUlSur2PmpUVijsqA==
X-Received: by 2002:a05:6a00:2d96:b0:77f:1d7a:b97f with SMTP id d2e1a72fcca58-7938782ac68mr8582957b3a.28.1760007502437;
        Thu, 09 Oct 2025 03:58:22 -0700 (PDT)
Received: from localhost ([45.142.165.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-794e33f0cb3sm2487606b3a.78.2025.10.09.03.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 03:58:21 -0700 (PDT)
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
Subject: [PATCH v7 19/23] mm/ksw: add recursive depth test
Date: Thu,  9 Oct 2025 18:55:55 +0800
Message-ID: <20251009105650.168917-20-wangjinchao600@gmail.com>
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

Introduce a test that performs stack writes in recursive calls to exercise
stack watch at a specific recursion depth.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/test.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/mm/kstackwatch/test.c b/mm/kstackwatch/test.c
index 012692c97a50..203fff4bec92 100644
--- a/mm/kstackwatch/test.c
+++ b/mm/kstackwatch/test.c
@@ -18,6 +18,7 @@
 static struct dentry *test_file;
 
 #define BUFFER_SIZE 32
+#define MAX_DEPTH 6
 
 static void test_watch_fire(void)
 {
@@ -46,6 +47,21 @@ static void test_canary_overflow(void)
 	pr_info("exit of %s\n", __func__);
 }
 
+static void test_recursive_depth(int depth)
+{
+	u64 buffer[BUFFER_SIZE];
+
+	pr_info("entry of %s depth:%d\n", __func__, depth);
+
+	if (depth < MAX_DEPTH)
+		test_recursive_depth(depth + 1);
+
+	buffer[0] = depth;
+	barrier_data(buffer);
+
+	pr_info("exit of %s depth:%d\n", __func__, depth);
+}
+
 static ssize_t test_dbgfs_write(struct file *file, const char __user *buffer,
 				size_t count, loff_t *pos)
 {
@@ -71,6 +87,9 @@ static ssize_t test_dbgfs_write(struct file *file, const char __user *buffer,
 		case 1:
 			test_canary_overflow();
 			break;
+		case 2:
+			test_recursive_depth(0);
+			break;
 		default:
 			pr_err("Unknown test number %d\n", test_num);
 			return -EINVAL;
@@ -92,7 +111,8 @@ static ssize_t test_dbgfs_read(struct file *file, char __user *buffer,
 		"Usage:\n"
 		"echo test{i} > /sys/kernel/debug/kstackwatch/test\n"
 		" test0 - test watch fire\n"
-		" test1 - test canary overflow\n";
+		" test1 - test canary overflow\n"
+		" test2 - test recursive func\n";
 
 	return simple_read_from_buffer(buffer, count, ppos, usage,
 				       strlen(usage));
-- 
2.43.0


