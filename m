Return-Path: <linux-kernel+bounces-813674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C638B54933
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23F243A521A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130E32F290B;
	Fri, 12 Sep 2025 10:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Phu1ClwF"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14552F3637
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672015; cv=none; b=p+PnTxzMRbgxnlRTq4S9IoSNVP28ZMNqr1ITYGJh1jXRvhoG8nhdfcZdGMim9t3U6JtPVaALOKqxrQzc11Ie8iTNEyHiMZ8DXBWWi91cuiVu2jyuNdu9akfLnKMRatZpv6OxJVPkGncJSzD/+GdWezTiTh4EjMiU7adF/YjT/sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672015; c=relaxed/simple;
	bh=CEdClddGjVYx6HjPNGBFPBiAS3jsMfpyA1eRZqyA0js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KRM0yrGFmOwczVsZtbe0Ma25Nsw1tdgygzIao/nhfuw9Ass2rrY9dWbOnGtDm3IO/KSl9FYVW7BYh8aCf0WTSIM3XcVwaS6iueJc34rbjWEd2JBmpo6EVLkFF0qXd3mL0+Wg0cqIB/3gXeWK9Xdr31xwmVJK8+gB2ZfNGdSZSYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Phu1ClwF; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7726c7ff7e5so1636127b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757672013; x=1758276813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqWZ4PXPvcwGUSVpTO1OvKWC6TpQO7QLp3apqR6W4A4=;
        b=Phu1ClwF/WaPaErJMaPhPDE6D9pREb2vKlFKCLG5/QTZ5EdiId+kOCcrawUXVD8G5V
         Pqqmk5rFdMAPtDfGRKFTiKiak4JjE+aqt4sg0bTSJqBnr8RV3L5xuG83kAtC94UpfP+n
         85uQ/GHXtIx0dXdxFQvzbKVNKIoBgBXmr3jAQrlCBtpz25JZf1gA0UAPXwbi0kan6cNQ
         YBwVyySuufVCMJYdzT04jsSuShSH2IqpDjs24IJrY0Jxs5EZkMKphHYKfJhhLzdJNEVL
         TQFy49G2jYxADX+XY2xkM5tK5UO6JYKAL0AEiEVzPr8dJNk6v7iQjw85MFvB6oG5vJ/e
         cElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757672013; x=1758276813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqWZ4PXPvcwGUSVpTO1OvKWC6TpQO7QLp3apqR6W4A4=;
        b=H7/IO1KD2FZj/Kw6OAak8B2gAovTSMkhv2tvOr5GVLmlizFR6kU409kecBidjDzqkS
         wB/LWUQPdHMlvPSi0IWtc86pUH//QcnCkPR/DshTOx4lSVWwjQFM2sJCNxgRsEO1TORL
         01zbBkJLdMZAL+m/P8m0DzoZQZwCWNg5CrdSlHKP0spyLI1BUo6uVCyqHXOwOWoUa3XR
         jgTGmVpQenGHIJZbX6qJKSrCu8qOobMrdh3lXmt7bw2jPbOdjGtyvvscdWIxsu/ZaglX
         1GEyVBvyrlACvYntrxrZ+5Q1bO3PHMu2u4oxJG7uSF1S+JzZLMMn0Pm1nX7TRRCIILSS
         becg==
X-Forwarded-Encrypted: i=1; AJvYcCUaZ5pkTLhb8cvtDM7oiLt9xmKxifzXHRdG/H4XQ3KANo2C7JqYXtUVRbd4LnTxk/3jGT9pXi5jrK3gzHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwisJtBDw1A3Wo8uRYYqQJCwGVAzKzHXwJw17olzBumSR4Sev7y
	p9QCAmmbuaaNxwW7Rq5WjA6PiErQV1qIX5okzLaHY3HDlfw+QJTAiw3W
X-Gm-Gg: ASbGncv+4fqgIf9ktRlQoKEompZ2qvWrB39nJ7Jo8TRGlRymI65tHqUH7V4RC/nA1WK
	v/1wLpEAolWUFLrHC8QcfWPo0SGoGhijNU4ysjqFOcvVQ6EGPkEB1mVQH8IU3jktmeokphgTb6d
	6unPYIxkIHxU+4eauxHw+avjAbTl6VTgEC7+/ekv5iOi/yp98MA1nuiviO+hc+vj5yIgfU6fdb9
	WhmuTVcmiNlVa1YJHR9upjEk7nlCrVxp43CceOkWhGnhLZ8QOye0OvUfED2GHQxQodVaw/Sfenz
	Q/t1lrYZbwlu1AX9c7lbE4pUMzOe/vJOpE2pFmdtJ8FQZdRVjaPgNyhjUaGmeRjz7Be/RQo4uR5
	Pz18y0GFfE90urkJaJJuCd/kcEMhHVEahGBk=
X-Google-Smtp-Source: AGHT+IGdi0rU6u6yk/5j3je0obUk9yox4MEj0mpe+W9QIz9sLwr6j5n+alC3GBSeGbtzXzFiSEwqsw==
X-Received: by 2002:a17:903:37c4:b0:248:811e:f86c with SMTP id d9443c01a7336-25d26663209mr26113005ad.34.1757672012838;
        Fri, 12 Sep 2025 03:13:32 -0700 (PDT)
Received: from localhost ([185.49.34.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3ad33e1esm44309995ad.105.2025.09.12.03.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:13:32 -0700 (PDT)
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
Subject: [PATCH v4 19/21] tools/ksw: add test script
Date: Fri, 12 Sep 2025 18:11:29 +0800
Message-ID: <20250912101145.465708-20-wangjinchao600@gmail.com>
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

Provide a shell script to trigger test cases.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 tools/kstackwatch/kstackwatch_test.sh | 40 +++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100755 tools/kstackwatch/kstackwatch_test.sh

diff --git a/tools/kstackwatch/kstackwatch_test.sh b/tools/kstackwatch/kstackwatch_test.sh
new file mode 100755
index 000000000000..61e171439ab6
--- /dev/null
+++ b/tools/kstackwatch/kstackwatch_test.sh
@@ -0,0 +1,40 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+echo "IMPORTANT: Before running, make sure you have updated the offset values!"
+
+usage() {
+	echo "Usage: $0 [0-3]"
+	echo "  0  - Canary Write Test"
+	echo "  1  - Canary Overflow Test"
+	echo "  2  - Silent Corruption Test"
+	echo "  3  - Recursive Corruption Test"
+}
+
+run_test() {
+	local test_num=$1
+	case "$test_num" in
+	0) echo "canary_test_write+0x19" >/proc/kstackwatch
+	   echo "test0" >/proc/kstackwatch_test ;;
+	1) echo "canary_test_overflow+0x1a" >/proc/kstackwatch
+	   echo "test1" >/proc/kstackwatch_test ;;
+	2) echo "silent_corruption_victim+0x32 0:8" >/proc/kstackwatch
+	   echo "test2" >/proc/kstackwatch_test ;;
+	3) echo "recursive_corruption_test+0x21+3 0:8" >/proc/kstackwatch
+	   echo "test3" >/proc/kstackwatch_test ;;
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


