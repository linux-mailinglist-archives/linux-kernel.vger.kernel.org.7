Return-Path: <linux-kernel+bounces-830465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 347C3B99BAA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E44731B24913
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B18B30149A;
	Wed, 24 Sep 2025 12:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMK6c+X0"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BAA30506A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758715251; cv=none; b=FSyQmUNTnX5axDry5kH2HcKvnuvpObWLWKi2yUw5b8c5evBPumh6xVgkrkc7eFrQ2hpHRNCkaaxyjuNjWeuf8wBk29p4k1anou8GD1+rpDOE+Gkme3z8JQ9JnZf/9hwGyRn7+qk2H9Hz9vKtlsQbRDeONR27j+e1hGgQjcl2Dz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758715251; c=relaxed/simple;
	bh=ceqMPO/CCLxptz7Kcmz7UHHum+IA7F5szQ405xxeOe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCjt4UqRFlC9kfwlXsr3Ln9FqNDP/jhUvooCsFeGLMqS/1oWHSRSnR0IDsqXTXRXH3IFLGJ6MCaiRftskQ8yAu/7ORcyrQrdCk3901r8LKQ+OWYAm6WknksKuWfWGOifvkXqDB0mAPAabdydLOSIuA65AjMDR98gzieLH6Xc/UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMK6c+X0; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso5592699b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758715248; x=1759320048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3XGYZ1mTVo1cX+yb2z67UYPJCwM1YcVlAKDPd0GQ2Q=;
        b=mMK6c+X0TOD2/Kz5n4yFXoa5kkTOYqEhREejrcY+07hXLZCU0BFXc4GSKlowPnOV64
         jDjnVerSJtIyfiGHAb4V/uzAQ+k2k7qndGTk0uPA1H6cirwjxYTwVd+gJFahtr3f4s9P
         DO68o62wDOnvbCkGBfPoTbq292nXZDDHQAHUwiPbcBjDa7wUekymMoq+rpkRH/DLaLrm
         e5mC/8dCFX7LI8bAPLZawbxmq5JkZQrDqD7V0cK26sm4SGrBaPAr8T8NEZPvWYRgbjlI
         XP4LjMfkghHeuEqWg9mLqCk91Cv85LeBHjl5lS7jmg/WD+Da9sxf/qng9t2RuwvxhKqh
         x8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758715248; x=1759320048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3XGYZ1mTVo1cX+yb2z67UYPJCwM1YcVlAKDPd0GQ2Q=;
        b=gbxDzeq3Y/3L6vtf9A+2Ksnu7S+fbpXQrJFrVEW5940M/PvWbGPfmOrBBqlnK2hhxm
         Xa0DKgCHXo7VHyxq0evMtKch/k4g2Jhka3aGBG9Ed+INYS+gJb1C514zFyEqx88Rs2tO
         ffacirHCkjJ6KUNIJs4glCBvmL2EiG1LkPUFQBK6rQ/wjNNVQg+HU3KbOSxfXHGYlUMN
         B93i40D6TTGgYNVcF/Wb8vdXz9ZtHuZ+HWSQz32FQ++vMxrWJTQAqGtv3+Eqobhqtx60
         U0cZkxD/+2KjyYvFkdE4/GfYxxTC8kl61V8TwzUl3VKsg3lkGi/kaZpoZ23NfoB8HWz/
         6AIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5gs9UUXhZBs1LVVGdD0C/5Qs9if4xhGlKsCXY8/0wMjGlWCABspJ1UgbMeS5FmjXfxvWINiLPKeB0gH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaOXGYK5gSdhIFns3jO/9LFb8O9A1uGkEMy/KvoA2OvAkH6ItK
	U5/1gN6o3mlmS3zrmQlA5eR5U37pbmpoAFgkl3aBO6Y0xBNTAUm5w/5f
X-Gm-Gg: ASbGncukfLg6zL1PXEBGl4KLAwlm7nJmSfGm7DtKlfrD2VkoER4jar5bcUJ6dhk2BS4
	O+9xwchzcXsfxJIZzdqXQVJofPnGoTVHZsWhx4xg8jja8noZuabq/m+DiuCeVQly8MYBNqblvhY
	b7BMZcL6LVFuDqonSXCNMmB0u9XdLRhhsnk3s+UQS/1RxZ5llrjZcDs6SVSUgTkd23QomI5nJt3
	MZBttnVDs9ok/B2pj+oz2MUOMXCxCkk2Ww6tI0KbT04mEisjYpjiR+F/mZcQRgdq4U8TswkziQQ
	64UKASTcPBuDgg+ntbh2496uNeiZVlJrH2eSiQR/OnPIYVwHVlbvh1yKhj4EM/hamaZYtGyhWI5
	AEvSYbNa83D18OHQP4MR9hpg=
X-Google-Smtp-Source: AGHT+IFjwxI+PhtV7jgjoa1gOIc2i5iuKeq4ASvkc/Bz/cNSIoBtm/vDSyxk5EpYVIU5WEV3bOsalQ==
X-Received: by 2002:a17:902:d113:b0:269:82a5:f9e9 with SMTP id d9443c01a7336-27cc79cb20bmr41740315ad.29.1758715248144;
        Wed, 24 Sep 2025 05:00:48 -0700 (PDT)
Received: from localhost ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ec0d14344sm19610475ad.126.2025.09.24.05.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 05:00:47 -0700 (PDT)
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
Subject: [PATCH v5 21/23] tools/ksw: add test script
Date: Wed, 24 Sep 2025 19:59:27 +0800
Message-ID: <20250924115931.197077-6-wangjinchao600@gmail.com>
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

Provide a shell script to trigger test cases.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 tools/kstackwatch/kstackwatch_test.sh | 52 +++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100755 tools/kstackwatch/kstackwatch_test.sh

diff --git a/tools/kstackwatch/kstackwatch_test.sh b/tools/kstackwatch/kstackwatch_test.sh
new file mode 100755
index 000000000000..aede35dcb8b6
--- /dev/null
+++ b/tools/kstackwatch/kstackwatch_test.sh
@@ -0,0 +1,52 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+echo "IMPORTANT: Before running, make sure you have updated the config values!"
+
+usage() {
+	echo "Usage: $0 [0-5]"
+	echo "  0  - test watch fire"
+	echo "  1  - test canary overflow"
+	echo "  2  - test recursive depth"
+	echo "  3  - test silent corruption"
+	echo "  4  - test multi-threaded silent corruption"
+	echo "  5  - test multi-threaded overflow"
+}
+
+run_test() {
+	local test_num=$1
+	case "$test_num" in
+	0) echo fn=test_watch_fire fo=0x29 wl=8 >/proc/kstackwatch
+	   echo test0 > /proc/kstackwatch_test
+	   ;;
+	1) echo fn=test_canary_overflow fo=0x14 >/proc/kstackwatch
+	   echo test1 >/proc/kstackwatch_test
+	   ;;
+	2) echo fn=test_recursive_depth fo=0x2f dp=3 wl=8 so=0 >/proc/kstackwatch
+	   echo test2 >/proc/kstackwatch_test
+	   ;;
+	3) echo fn=test_mthread_victim fo=0x4c so=64 wl=8 >/proc/kstackwatch
+	   echo test3 >/proc/kstackwatch_test
+	   ;;
+	4) echo fn=test_mthread_victim fo=0x4c so=64 wl=8 >/proc/kstackwatch
+	   echo test4 >/proc/kstackwatch_test
+	   ;;
+	5) echo fn=test_mthread_buggy fo=0x16 so=0x100 wl=8 >/proc/kstackwatch
+	   echo test5 >/proc/kstackwatch_test
+	   ;;
+	*) usage
+	   exit 1 ;;
+	esac
+	# Reset watch after test
+	echo >/proc/kstackwatch
+}
+
+# Check root and module
+[ "$EUID" -ne 0 ] && echo "Run as root" && exit 1
+for f in /proc/kstackwatch /proc/kstackwatch_test; do
+	[ ! -f "$f" ] && echo "$f not found" && exit 1
+done
+
+# Run
+[ -z "$1" ] && { usage; exit 0; }
+run_test "$1"
-- 
2.43.0


