Return-Path: <linux-kernel+bounces-813671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A12B54924
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1086D4816A4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CB82F0C60;
	Fri, 12 Sep 2025 10:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Db3HAijE"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E482F0C40
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672001; cv=none; b=ERFDvNDfnvAY6JPFKXh81JkaXQL57ViiPHEEwqKqoNlswjSlHTshtnPR/2YMOEDlacb0ZhFHKbT9XV1JHkDH918cb4LBxkDlOj/ldfB8gi9+Jd4AfVOSw/3SWdc+7G287/TCjyYUQNTJJ7wypSci/EEPPLm9O4/pSRvibzo7ZwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672001; c=relaxed/simple;
	bh=0pYLSOeA0PAf1TeSGJQVGULqR9LKSdf8J0mO6JXy6uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPpEcMrmXq6W4otyvqnDYcGGVk/CDN0bEJfw988DYou77stMfH2CFiFme7K7239X0jlHy4TH8LJG42P58xFdUmdipXcIElKr+EbxRvqEUCsJYw9ErXTgurAThEQV/GYRJ2GiVtbQUrSsQW2N2X7OSZxCJpVjGJqE9GYf9xfYeoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Db3HAijE; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7723cf6e4b6so1466598b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757671998; x=1758276798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6BBsZfnmfgl1Jgn+pU00vd6g5c1DTmTteWqGp/Sk64=;
        b=Db3HAijEZOAxxCS4azI+v3897g+Px4fNXXX8O1J57b5GaVlBDxGdpcMW/NK0oxC1Hy
         AKBZdwFXD5RI0k3g1X5Bfm08BtJSpjbZaoolfuK/xgPDTaJFTaC5lT+EsN44WYulgcDT
         IqJIbHCL5SSWb8q04xRt917RijNp4uyDzvxLhNHfRFEeBqkViPBjVsQdLA/i27Ihqjob
         roogCkLcI1JphxyRD5NCgMQyvGy/eWVkyVB0ImXaKoJaNa58cWmIGxJvPfi1k8SEdR2c
         bEX3rP1mEkvfaZkzQoTHkYLy8pZhZDLUkhjYyumlvg4kspuTDl9j/kF5qzM8Iw0zcCxF
         nQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757671998; x=1758276798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6BBsZfnmfgl1Jgn+pU00vd6g5c1DTmTteWqGp/Sk64=;
        b=TaRMmXDVohRMnle+o3+F/C24Q59nJeG8oIg/t39JZfx9mqFk/ZylFYxHvtFE3cTuNG
         bdWYeq+hk1bAx6wWv7FDwYRkEcwHFNME/ZupispPFe8Ir3ox6/2/DcqSGx5R4CFKr0Lm
         SxdJah6S+gl22Xu8gh/IvQNUpW93Hk0ZTbFykP87xAG/PBIgzr53GegSD6gEErHwf6oj
         H7L0TvDJMH6H6uBvcOWQRl/cK+4ZUj3mzTIX7ew1Zt6d3GVk4EQPa5QQ4LG2AYr5s2cM
         nmbg9MCEQ5q0w7FBUDZedWEihcvK4p2apDX9aMsjpu48CAWCSMmfwA0peIfysOrgczB4
         Wp5g==
X-Forwarded-Encrypted: i=1; AJvYcCUkZ1i1+Hy1i8InQQyAiIblPL00BOVSuR1illY06+yFcUd7ejy/WMEqT0jNrWTCz45agIZP+98zvr1JgtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwRfGHKeOvaSjEvW+WzO16eJ02Fn1QjKxrr8nXl3VbUHSwSqcI
	1mh5zgW6+Fe/DAw2PKh3qlvt5Aght7C7mnk2zUNEw035ZxP4psKlDc8C
X-Gm-Gg: ASbGncuUefx16kz/6uohexIPZ343Ezl/OKqZ1JvPcLFNQxoW1YPmBMzpMKHk5JzihDi
	SviTbGsEsjltgUuB7HELhcdMWtLB6T1B6+t9kPD/hoTrPc4DN6B4gGG7ylxMWn6UkBtZiZx7LtC
	Zu81GAE6CM9rdWava2LA2LSWlvVwQvCZW043BonuQZzTPLjt2DFEVqgfYi9+aAe7Ars92o0DTBt
	/GJSHYfHmXDsuHL+4YYtz5vx59QxTdz7i62CunlESWXXSvjgSBFBusk8ur7fG50S2N+YXSVWv/c
	pTkBxeow7SUEBWm4JTei92FkR9AbGk8cqzFeJOcF3ZE8BswSfS/MAJDQAZWAwbWIBj0dqCrcth9
	ewVxrlajmlMBJ3t0JvKF147HAjl9wtBV/2AyKiknKJKDshA==
X-Google-Smtp-Source: AGHT+IFP0Z697TA4h3v44yo8u1mt3XK26j9kYKC9Oe9buFWhspRDiIMhNWMUBIxM8GwcPJ0/MCOUpw==
X-Received: by 2002:a05:6a21:33a6:b0:246:3a6:3e41 with SMTP id adf61e73a8af0-2602a5937a8mr3020791637.6.1757671998049;
        Fri, 12 Sep 2025 03:13:18 -0700 (PDT)
Received: from localhost ([185.49.34.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd98b43a7sm5206301a91.13.2025.09.12.03.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:13:17 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
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
Subject: [PATCH v4 16/21] mm/ksw: add stack overflow test
Date: Fri, 12 Sep 2025 18:11:26 +0800
Message-ID: <20250912101145.465708-17-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912101145.465708-1-wangjinchao600@gmail.com>
References: <20250912101145.465708-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the test module with a new test case (test1) that intentionally
overflows a local u64 buffer to corrupt the stack canary. This helps
validate detection of stack corruption under overflow conditions.

The proc interface is updated to document the new test:

 - test1: stack canary overflow test

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/test.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/mm/kstackwatch/test.c b/mm/kstackwatch/test.c
index 76dbfb042067..ab1a3f92b5e8 100644
--- a/mm/kstackwatch/test.c
+++ b/mm/kstackwatch/test.c
@@ -40,6 +40,27 @@ static void canary_test_write(void)
 	pr_info("canary write test completed\n");
 }
 
+/*
+ * Test Case 1: Stack Overflow (Canary Test)
+ * This function uses a u64 buffer 64-bit write
+ * to corrupt the stack canary with a single operation
+ */
+static void canary_test_overflow(void)
+{
+	u64 buffer[BUFFER_SIZE];
+
+	pr_info("starting %s\n", __func__);
+	pr_info("buffer 0x%lx\n", (unsigned long)buffer);
+
+	/* intentionally overflow the u64 buffer. */
+	((u64 *)buffer + BUFFER_SIZE)[0] = 0xdeadbeefdeadbeef;
+
+	/* make sure the compiler do not drop assign action */
+	barrier_data(buffer);
+
+	pr_info("canary overflow test completed\n");
+}
+
 static ssize_t test_proc_write(struct file *file, const char __user *buffer,
 			       size_t count, loff_t *pos)
 {
@@ -63,6 +84,10 @@ static ssize_t test_proc_write(struct file *file, const char __user *buffer,
 			pr_info("triggering canary write test\n");
 			canary_test_write();
 			break;
+		case 1:
+			pr_info("triggering canary overflow test\n");
+			canary_test_overflow();
+			break;
 		default:
 			pr_err("Unknown test number %d\n", test_num);
 			return -EINVAL;
@@ -82,7 +107,8 @@ static ssize_t test_proc_read(struct file *file, char __user *buffer,
 		"KStackWatch Simplified Test Module\n"
 		"==================================\n"
 		"Usage:\n"
-		"  echo 'test0' > /proc/kstackwatch_test  - Canary write test\n";
+		"  echo 'test0' > /proc/kstackwatch_test  - Canary write test\n"
+		"  echo 'test1' > /proc/kstackwatch_test  - Canary overflow test\n";
 
 	return simple_read_from_buffer(buffer, count, pos, usage,
 				       strlen(usage));
-- 
2.43.0


