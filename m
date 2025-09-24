Return-Path: <linux-kernel+bounces-830463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E01B99BA4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82BF84C6419
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EA13043B9;
	Wed, 24 Sep 2025 12:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnbiblAy"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FE0303C8F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758715235; cv=none; b=X9ios/PdWIGzYGq6q4xx0AzoKhFKx+Tu243UCwFkx20Qw+h7cQArOPjk+TBC6NsIU6OjL+Lc2E6W2xKxxVQozogE00dXSYztQhQr8dkYlcA17T21S8IMCZ6mBIfRXoDB+kFdMU0aYIHfiZQQngkXOmjPfPSE6qex/r8oX1zvZXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758715235; c=relaxed/simple;
	bh=zf1JTLa2lHlWHJGslx4oSS8c+FpP61ZIVHBr6hXJkpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CvkW2dLpOVhrlk0rrnqvxZpzy0b+Bq7ALXUJjU66i6ELHZNvTmnTwOveJ29r2+5P/7ZaTAFaCfpHoBUQUsBmnDvTIonsxvtiA5+zWfI56DYXyocTuf0cFq0WI6gP5VXYckyxZSp/DnQ53KVBo9KZO7yMstJQCYaYCIYCUmi0FKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnbiblAy; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-26983b5411aso47987975ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758715233; x=1759320033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UG3CF7kwzv6QR3Bvbfu+t4H41didNmIt1FZDrUojazQ=;
        b=MnbiblAyhaSJRHM7LGVu/bOyHN+rqlStXuJnY/rBlpVnw0Dd/XeP5ngi8CkHrGz997
         IKgXJIr59eNsItx+TXsuFxSUzU5+6OJrBwpEapXbcxC3WwhXCWyHoKtGvehtLV1R4ufX
         c8jug9hvCRENHTc+He4HNBia702h5t1arXeE4RakvC2km19pcio9TYhPrYIzUJWYNHKw
         XAFXy/dRFeVyFjj00jWCqbIm8eLzgduO2uz73a+lUu143p1W8JWEW5dgzZ9CbEC1fPbV
         mE6rpkmWd6ODOibiuHaAvSG1d1vhF+iZBtu9MMi8gKx+JtQbQSDYB4HlY0tguOX4jAJL
         +J2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758715233; x=1759320033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UG3CF7kwzv6QR3Bvbfu+t4H41didNmIt1FZDrUojazQ=;
        b=jKrLhUcYpajf3lkqPRChDBEtJWTZjLZSxgP1IvBKhQBcgjg1iItOuwO4kyn7zCLDXP
         w6e/c26C88sh8NNeKfQP01FFyS9yivVDfYMhYRAOZYnzzSHfrxECP4VEdswBrVCShkm+
         Y0AZ5Ablbg6Trj8f6F6nVZ8ZEwWS3LBCHQAGTlZOhaa8s4cuz68DiKBy9ZdD+zVay8nm
         57htSvvt3yngSFz0SWxR0gB0TL/dm/FuL/zVPTrqO3GflO8QgtWnX3UAwk9kDQ+NOBP1
         eEWsxX18i7ds0fMoGM8lohcdgFSPMrx7D78ERV/1RU6GFsECTILlC2zhzilVObp06ahj
         u1aA==
X-Forwarded-Encrypted: i=1; AJvYcCXFIj7tfRyfhoEC4U3ZfsAP15bi3+olUQYzQRtwv/amyXzJT8GLZn94oSIs3aMvDU0QivAZo5gOaPC8hJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYSFnD5JI92/4rdhSn/V4wbifcrkfVpYiy5WFDxDL+C0MpGSeJ
	wfcFDGBMMRWLr2Aa7xi+3CA6I8Bn1IA7PqCeCfnga9s3WRI+MMYLBSlP
X-Gm-Gg: ASbGncvfw621EDcT5MD3q0SKvqYmi2hcQ7VU71tyfaowUPqKg2hPchZNdAP92tTu9nO
	oL1q7PeqsL5BsrFhOwMqGIM1oLRASothCp1EhzyjfGIvSXCPhstcROLP8eoLN77BtTQKCIcVi8J
	djfT6uIzQZCtkRj/XoftGs9iqyAxeU9NbWK0pz+V6vj/illpW3Wk5GNwR9iBG1orODWu2vowUax
	X69XAk49bXEUf49kreJ4q4nlRFUknulCqGNDCMc4XmpkGINUxDOdNSPSZXvH1+dVsIh9hndRyo4
	RyvY12qhywYcXAutk4EFNPyHIb6Q5cW85odcierkTfPITc/gvQr91RSMD7/p6wuNWEoiSttchwP
	kSiyg/YP4TuXct/FaAFvjginPsnsjbVgB5Q==
X-Google-Smtp-Source: AGHT+IF6XISRPA3i1YO2WYyo3MXp7Cd4Mk+kPP9SRfGztdCTTVjypRXE5hBz8PjgkCcvzgR6cUkWDg==
X-Received: by 2002:a17:902:f609:b0:26d:e984:8157 with SMTP id d9443c01a7336-27cc13808fcmr63875775ad.8.1758715233064;
        Wed, 24 Sep 2025 05:00:33 -0700 (PDT)
Received: from localhost ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802df57asm190476695ad.67.2025.09.24.05.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 05:00:32 -0700 (PDT)
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
Subject: [PATCH v5 19/23] mm/ksw: add recursive depth test
Date: Wed, 24 Sep 2025 19:59:25 +0800
Message-ID: <20250924115931.197077-4-wangjinchao600@gmail.com>
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

Introduce a test that performs stack writes in recursive calls to exercise
stack watch at a specific recursion depth.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/test.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/mm/kstackwatch/test.c b/mm/kstackwatch/test.c
index 740e3c11b3ef..08e3d37c4c04 100644
--- a/mm/kstackwatch/test.c
+++ b/mm/kstackwatch/test.c
@@ -57,6 +57,20 @@ static void test_canary_overflow(void)
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
 
 static ssize_t test_proc_write(struct file *file, const char __user *buffer,
 			       size_t count, loff_t *pos)
@@ -83,6 +97,9 @@ static ssize_t test_proc_write(struct file *file, const char __user *buffer,
 		case 1:
 			test_canary_overflow();
 			break;
+		case 2:
+			test_recursive_depth(0);
+			break;
 		default:
 			pr_err("Unknown test number %d\n", test_num);
 			return -EINVAL;
@@ -103,7 +120,8 @@ static ssize_t test_proc_read(struct file *file, char __user *buffer,
 				    "Usage:\n"
 				    "echo test{i} > /proc/kstackwatch_test\n"
 				    " test0 - test watch fire\n"
-				    " test1 - test canary overflow\n";
+				    " test1 - test canary overflow\n"
+				    " test2 - test recursive func\n";
 
 	return simple_read_from_buffer(buffer, count, pos, usage,
 				       strlen(usage));
-- 
2.43.0


