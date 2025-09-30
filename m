Return-Path: <linux-kernel+bounces-837006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814E7BAB14D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BFF31C6E75
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 02:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D88226D4D7;
	Tue, 30 Sep 2025 02:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtNTcY6n"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F4D26C3A4
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759200357; cv=none; b=LKuJ/yv/oTwSVz5gygH7Mah6ab4Q3dlcsbpLFbGSTbTfuhjSTui0m8i6iLV3tWc9Q8TS88zLbjywcExZ+avPJUbd4jJwofWbobEpcHAEttsDsgr38vzDt28s0kDAmJJWy99CBfIygw9z3Sd59XMYYdwQnxtr+zdh4bgKjS57TxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759200357; c=relaxed/simple;
	bh=WUmvecag/bRJ9LbEABvkcHBuLoUzQ3sY4/EKuJYpRQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pMlRu4dxHEZtqjEFWV8n1tMa6u4O1YoOpDbfc7bEJ1dPlDwWAmaeG6CPR95RhjepCAlvWvo20PZcbK2/HGbiXF7L9KgltnraklgJRWFm/0zMaaamBzcUuZwL0ihJzsrqiFU64exSUCq7vpHuBN9lAyXlsrqkLq4IoyqM3QZIgAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtNTcY6n; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-78127433a32so2409311b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 19:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759200355; x=1759805155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANupiyfNlS++I01zMHP5Qbsc6Wgfn8wZLgNnwRsiWjA=;
        b=UtNTcY6nEyOkr6nfhHubQfmLFjQMmbWG9I/TLRBH+IUtB1rWBZQ/E61TFCjA5f6BnG
         NEzWEYOXZuup0kUOIr9fqcxL9+C8dX3J7CSMwq7n0WuJhmHDHdCUSdIaeuVgNWmiyaNz
         LI1rT27GDNqsCt728MSjQ/5vKlRBRCumScPxNQehpSvpsXYYJDkzYLmRnEaED43NGerJ
         wS3hNXB4Kla0AVzFIbcavTLQ09PwgqQQtMWasLR8+l5pNND2I+XcFwnm3xK5qVuvFBPw
         jFINLsNyqvJbEdob8KKtg8tZSLEye/gLqTcDRG3m+prja+73T/tpATIXOZlBtsz3/nR6
         L/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759200355; x=1759805155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANupiyfNlS++I01zMHP5Qbsc6Wgfn8wZLgNnwRsiWjA=;
        b=GUa6m+qjYrX6YWOVNscFudkzj+EYs5gzeId+5+g9n4IpSB5Bscjsuv7pIlxrUG6bgo
         3K5IouHw1ACLabObV+8o8hOAhTGJti/QZSd/zMhWdFiO3GFcGfzKCn6/oAk2nZ1DZ1n+
         8cq6cJYZ4gg/3zKMs4AJSl2L/5MDPI0SxSLQav6QE4M6fLAsMD8qiMs36we/uNP/T+mN
         COEkEitoMze4yez74tQ+0k/vT0t+ntz0LpPUwsqItkm56z6NpCaXQrbHgx3j98HnU8lt
         U6I1BkD+4XSmQ7ylsIFeKPRbI5TxABat1tgggvpyQcWEVT2/4rDNw1lOfLnGacQQqpgV
         QDUg==
X-Forwarded-Encrypted: i=1; AJvYcCWMtcM8JSoYODIqZcsg8f9R3fey3Y4qfNtylKFhLIBo0tVckTbHk7UOkZRrYOoIxo4Vv8c0HWBJ8d3mG98=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuOIjuh9D77ayis83//axEDdGoXfUfuZNwoOCt6XnRsyDZE608
	Csj9CnziM6fP2VVftuL7YRQwjYuZ8tg8Qu4wJPyqgpcQHPIEywhmoRMK
X-Gm-Gg: ASbGncvM3AWe4AuFkh5Uhdo1Nn/WY0KiuzQHu1g4vqHdW/D+FFS91DGIXDy3jNJdUxE
	h7o7uOC50yejQ9oeDv4It64GHQmk6SDIBs3/5B47MoeQwrUX+aARhuQfro5oxrSjg11vpGbxA7j
	/FHX9NnXQZkcB9/+H0+G27SiM1/aTvFSq/xj933EthrD7AridZtUc1HbHRQFdDll00m+YZRFz9Q
	WPk1M7JS+hr9lSHrmiqKixCFwvW8i6Xm9115HVBBANVHu6W0bDQ4n0KfDPBwRz7fWV2qu29hI8a
	/6CN/5Cqo8BdDhVgr1m40rLU2m/x7BbVUC6sCwKP8KQcolu16tIYLL1SSL0o+u6GeOAwA4hvgMt
	O1NdKNmsywaipQfRCUspSjTBRe4UtKxwNBeD6grAG1GvhCssPCmSws7VRSUFSNClFV3YdRVqXef
	rC
X-Google-Smtp-Source: AGHT+IFgQx8Uh36EA0aXny7DSw1dXOgHQg+bo/K2OmzhGw1sKK8D6YsVYmNHfsV+5mgUHC/7blvjEg==
X-Received: by 2002:a05:6a00:3cd4:b0:781:261b:7524 with SMTP id d2e1a72fcca58-781261b762bmr11615416b3a.14.1759200354649;
        Mon, 29 Sep 2025 19:45:54 -0700 (PDT)
Received: from localhost ([45.142.167.196])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102b2ec47sm12565336b3a.50.2025.09.29.19.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 19:45:54 -0700 (PDT)
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
Subject: [PATCH v6 19/23] mm/ksw: add recursive depth test
Date: Tue, 30 Sep 2025 10:43:40 +0800
Message-ID: <20250930024402.1043776-20-wangjinchao600@gmail.com>
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


