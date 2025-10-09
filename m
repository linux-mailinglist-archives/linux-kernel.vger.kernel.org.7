Return-Path: <linux-kernel+bounces-846663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB309BC8AB3
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 13:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D91D54F3D23
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 11:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6710D2EBB93;
	Thu,  9 Oct 2025 10:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVrE5aoE"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA6A2EB87A
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 10:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760007513; cv=none; b=o9Uw8x7G6ZWuESXToKbQwdXvlZsM69Tq10H8lvc9DgXIM1viSNVPoC0f/ZKahfnP7cSL4URBDxmGE1W+8FyMQ6iE9DLFDXJhNCPjbtzrM9VpTQ1UJiAlT0A6EZgbM2egqfvYeN35qjzAJiBg0MZlwRaYdsQ3YPq02ZdjdpWZxas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760007513; c=relaxed/simple;
	bh=fx5MM9mgeadn4AlECL2EeIytilVmfLOb03DEtE9qwqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GcBcugoU+tUKZg4ruZVFenAQ9jDAQRaLOd7hoZSLNXc6iTC9Cp3NwkCP0PTr+idy55kvRz4VyNVtb/YgVX7zYTyuym8+QKLiYoKpYK1ZyjzJ4WxtFcVaEdOdTfliYWeHEGu+ONiHI3+qpY1h1BnHI0MOMAK6hooBMaLcFY8oGUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVrE5aoE; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b554bb615dcso514601a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 03:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760007511; x=1760612311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PODRMG2Z8bUUhx/yC1VRhywhZMIHoJSOmQZCJHqYhJ8=;
        b=dVrE5aoEdZsYXcOjxGhjUNgawOdKAWBER3woXuYsd89/wbhM5DNyxVexkJKjqI2WHr
         HZ6OcnWgRByyo4XsY+8I8M3C9yz9TVrlbAFyWIk2JtsuEJkbv2ID8XkPU3s2/aS3JptB
         DJpn+ugFpJz2+4pr/1SImJc+1WDb5TSmpeWqewOpnLCkJWig9ik78orFdzNZLMlpQkSk
         V41jC4vX0e+ThvhH8C1hZ61m5vdVluJImwkDaHutmlgNsA/Zs+XVOopbkRXQNJohikCV
         C64b0gW+A69Shv+1jdrg9ueijDKhLU4eOQMOH6r9c1JrBoJWtO7l1LTPDGQKtCjmCAjt
         XC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760007511; x=1760612311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PODRMG2Z8bUUhx/yC1VRhywhZMIHoJSOmQZCJHqYhJ8=;
        b=K1VCfihExsxwSLQbeQGPAeVVHmCIEH7TZbxL8R6hjK/81EdZUCsSRRDtX+780QngOe
         g8ONRV6HV5U8+QXGTgTrkoZg9FZ2u7iuqy7kKd/kyj8yKwQKf0fjhYOizWnwOc6z/TiX
         gs+SRK1IQpKszMjsl7ez/IPCjjYK9MwsusEax1hBH4ivP2kMfA3fuffL4FzafueyTX+F
         COtHh1H0YwU0ZWMrygNWpzW0LDdPHRjFivKvoervJj4YxLNenIHVbAJUBoYG0zP97fpK
         1SM3raDGcR1hu1MGnA/p1x3CkzKLBV2inoL50Qnis+FYi5tShzVHuQ6ZWZan/GRw/n+8
         17cw==
X-Forwarded-Encrypted: i=1; AJvYcCW1hnuzrk+7K8va9DytTPgLcIWTWw87ucKK+ZyKHrxgTzgMoNz7OWDb3Iz9DbQtseedhf1tri6f5ET0x/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWb6vW59GdMa2d4WBQWbnh46Zcp6nd1m8H/5DdHzYwxfvuXBsX
	azhcp5EtMtlAoLYh4yMmwDiqDaWGaJMhnh15V7d83Y/wtjw6wNVn/pJg
X-Gm-Gg: ASbGncu+Jsm5wiNDE6hpTXRjNc+Ur8v6KzC+m3ozoM6E5L1KJkkamZ187INUwyOs5+5
	VJl5mDiCCZZtwq6EY3NAowD//Jl8FDtdQ4Ub/IIwe6j25BJ4F/stpSr9wFD7oegEI4J/ELcop+r
	K7OydVABJO7YhEgMOsDZrGlL0GsZ24wkafqa+D5uepgOFtYxlgh5Nk7o6obcvF4YNF1BNKBALQg
	uhM4R3sXpe6iNc0PqvXDQar2/hmWuP5LChZxG9HxtfT9PzSHwkhFGwO2A53MaGEcWLGff1kPRnQ
	eMkW7/LjtwMLwfiG9ZWV9Hjd45lN7UVWweEcc0QCrOnMmuvOi/BF9YuDAqmDjg9EUfQ7640ECUg
	e2ZsuoN/39bP6tiWYltTdd4AiZbAkkrxen3uTxIoW7UAA7ufTg19z5dr+y/+4
X-Google-Smtp-Source: AGHT+IF84UQdi8SdjzjP27Uzxv11ATZ55/94M/TwFF9mJGTJWLkmx5AoAZTRAV1cVi0ppq51LJs5Aw==
X-Received: by 2002:a17:90b:38cc:b0:329:e2b1:def3 with SMTP id 98e67ed59e1d1-33b51168d95mr9160007a91.10.1760007510612;
        Thu, 09 Oct 2025 03:58:30 -0700 (PDT)
Received: from localhost ([45.142.165.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b510e91d4sm6644930a91.1.2025.10.09.03.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 03:58:30 -0700 (PDT)
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
Subject: [PATCH v7 21/23] tools/ksw: add test script
Date: Thu,  9 Oct 2025 18:55:57 +0800
Message-ID: <20251009105650.168917-22-wangjinchao600@gmail.com>
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

Provide a shell script to trigger test cases.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 tools/kstackwatch/kstackwatch_test.sh | 52 +++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100755 tools/kstackwatch/kstackwatch_test.sh

diff --git a/tools/kstackwatch/kstackwatch_test.sh b/tools/kstackwatch/kstackwatch_test.sh
new file mode 100755
index 000000000000..35cad036ecee
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
+	0) echo fn=test_watch_fire fo=0x29 wl=8 >/sys/kernel/debug/kstackwatch/config
+	   echo test0 > /sys/kernel/debug/kstackwatch/test
+	   ;;
+	1) echo fn=test_canary_overflow fo=0x14 >/sys/kernel/debug/kstackwatch/config
+	   echo test1 >/sys/kernel/debug/kstackwatch/test
+	   ;;
+	2) echo fn=test_recursive_depth fo=0x2f dp=3 wl=8 so=0 >/sys/kernel/debug/kstackwatch/config
+	   echo test2 >/sys/kernel/debug/kstackwatch/test
+	   ;;
+	3) echo fn=test_mthread_victim fo=0x4c so=64 wl=8 >/sys/kernel/debug/kstackwatch/config
+	   echo test3 >/sys/kernel/debug/kstackwatch/test
+	   ;;
+	4) echo fn=test_mthread_victim fo=0x4c so=64 wl=8 >/sys/kernel/debug/kstackwatch/config
+	   echo test4 >/sys/kernel/debug/kstackwatch/test
+	   ;;
+	5) echo fn=test_mthread_buggy fo=0x16 so=0x100 wl=8 >/sys/kernel/debug/kstackwatch/config
+	   echo test5 >/sys/kernel/debug/kstackwatch/test
+	   ;;
+	*) usage
+	   exit 1 ;;
+	esac
+	# Reset watch after test
+	echo >/sys/kernel/debug/kstackwatch/config
+}
+
+# Check root and module
+[ "$EUID" -ne 0 ] && echo "Run as root" && exit 1
+for f in /sys/kernel/debug/kstackwatch/config /sys/kernel/debug/kstackwatch/test; do
+	[ ! -f "$f" ] && echo "$f not found" && exit 1
+done
+
+# Run
+[ -z "$1" ] && { usage; exit 0; }
+run_test "$1"
-- 
2.43.0


