Return-Path: <linux-kernel+bounces-813669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20645B5491C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 454A518967AA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B452E7F0E;
	Fri, 12 Sep 2025 10:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDPSCdZU"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA6C2ECD2C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671990; cv=none; b=dj6IkORUnq0+0Itmgi7u6k9YMVb4s+Kcgm16Dj9k5awCxd+px3+Ln9JFapO+qbCmpuMT/OWRe/R0tdg65aD2qtIAywNOVzxyIZjNXlLE6aKcogNVBK7CNhlrgFmddhaMFnqf2zX3PuOkeshyvXyS/GDO6PUop3BvcWfBh9wLNIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671990; c=relaxed/simple;
	bh=ljHubFdo4RbY9sPZZpmIGXXQZrdiNxFcVGyARbY49GM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJ8Vg3ZTvg5LMVeY1gw1Qf2VjucZ/ccQSb05CW0ydVNXPtLz8CCirw/HSfL0GnXeDMNakYBkIui3uZ/J8hJd5cBJZQab5Prl5yczRIsRpR/lmFhIFQ4tM8mE5mvivj93j6ngPNdiImC+vgZI0r+O+sZ8AxzOJTcnSzzN5zO7mOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDPSCdZU; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so1514619b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757671987; x=1758276787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clh29CJb8P7VxnXXw4h/9gdA7sU+C9WtN5xBt8cm/X4=;
        b=IDPSCdZUUpOtAF1g097xo+JllyTdTsE6JXJrlMnaWPvAcFm+Byxx8HkfwMK2Ay7qhg
         yBS9gbB0W31nUnKN6faZ91ABd77++7zOZLhbMRZgm/rlORu4DnKMRkZh7El4jkaNwRlU
         tZdQpoQLvNTx9UGq7GCegQB0tUBgb8ggjiQIroUh2uVAxkqX7WVIqy961kqGuGasz/Vf
         I0I+Ps2IciMECyInMUAH1SXckZetPLXGkUtE0mSUlcPL7+lLZegw7xcYudczi23IUdMd
         98fgrBf9hBhJ7tTapx+kiRhcgejl4+jOdRZze0dk69A6uydoEI/9rj5W6Gjqsr31VR0K
         WKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757671987; x=1758276787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clh29CJb8P7VxnXXw4h/9gdA7sU+C9WtN5xBt8cm/X4=;
        b=WNGdZ/wBiPop0RzmljcBv4hMFiH2KK9CWGVmqvS+DMmfbs0AJGQzTcwXm7bKEsmg5U
         GTDdv/eKLtt3aEf6R3b/F0S8gwAABzuiuWml77OBpbZhNHjbKxyUY1pCL0IGh6NGiCIM
         IfAda/fxEUEVBMJO7SDyZZ0xujJLg97/cczFtXntZ6GtVsHb0jc7JS+8JgrnAqNO+6l/
         1uhU67OFiMqe6uJcCuZXNumjxiMjYRAJxPlrBxq4djNGCwvI/KkB+caflAtfDkPTZ7AS
         gNp4ykvZQjNsqunQsF2oBqVZ6DYlk96YBJRMcGwDy2xOs4T/VRBTPG/SHhEBTHiXXu0V
         eT6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV25z+NcDhk6n6xhZ2RT0NSDjeh0BTFPPyFt7CRmtSP8IyH6zSD3td3TSXjtMdN6kYDtOruGrgpveqbHN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy11/RyKVCwgHdu3KvZ170R0eBp15P9HDyDqYN7+zHdEbJLgg9s
	2/Qvnrt2lHoDCsOHlYy97/44GWcXRiljgZzBJd919qY7AaILgeQlrUi+
X-Gm-Gg: ASbGnctK49BGx/9dNQQQUO12fxzj4APNW/EAaVZnlK+FilcFtxs1hqYqwH8Km+D2qOT
	ORic/fzANzrXq+wMBvv9R1gO22aq3Bm2/Ure+C1GGsW0r8q7sd0vXl6raLGQlcpbKYdZcZSV2YK
	nZz+D5cSHsf2qUKQ+KXM+FqJ/1BVefld00G3MoLrm/q7RYo0Jlo+h9NcJ1QcDzi501F5NMOpSHS
	yiCnJwsxhL6pZ9eJzuxmQRlvz/TayZsRLwT3Q9sXerLtP64rVfCzTQiFYwx6HWtxYkMmWVhmGAb
	WPXRbh/RZhxwTBN1wi/dhYsFwuBqiGsCWcK+yvlPmaoFkZ+V53RkQ05PTDozUp7nN5l6voLb0Hc
	IXTVfMNjkaWiIMcPHqTPu3hj5bJJsIvppzvQ=
X-Google-Smtp-Source: AGHT+IHaEUea7hRsSpqZl85bTv6q0KsvHQdzV/MeRfkpCvkL2MgkVHPyR0dQHBXbAqMEfqsEXUoPVA==
X-Received: by 2002:a05:6a00:982:b0:76b:d869:43fd with SMTP id d2e1a72fcca58-7761216815amr3249434b3a.18.1757671987091;
        Fri, 12 Sep 2025 03:13:07 -0700 (PDT)
Received: from localhost ([185.49.34.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760793b6b1sm4934804b3a.20.2025.09.12.03.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:13:06 -0700 (PDT)
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
Subject: [PATCH v4 14/21] mm/ksw: add self-debug helpers
Date: Fri, 12 Sep 2025 18:11:24 +0800
Message-ID: <20250912101145.465708-15-wangjinchao600@gmail.com>
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

Provide two debug helpers:

- ksw_watch_show(): print the current watch target address and length.
- ksw_watch_fire(): intentionally trigger the watchpoint immediately
  by writing to the watched address, useful for testing HWBP behavior.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kstackwatch.h |  2 ++
 mm/kstackwatch/watch.c       | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
index 5ea2db76cdfb..9a4900df8ff8 100644
--- a/mm/kstackwatch/kstackwatch.h
+++ b/mm/kstackwatch/kstackwatch.h
@@ -47,5 +47,7 @@ int ksw_watch_init(void);
 void ksw_watch_exit(void);
 int ksw_watch_on(ulong watch_addr, u16 watch_len);
 int ksw_watch_off(ulong watch_addr, u16 watch_len);
+void ksw_watch_show(void);
+void ksw_watch_fire(void);
 
 #endif /* _KSTACKWATCH_H */
diff --git a/mm/kstackwatch/watch.c b/mm/kstackwatch/watch.c
index 795e779792da..2e9294595bf3 100644
--- a/mm/kstackwatch/watch.c
+++ b/mm/kstackwatch/watch.c
@@ -161,3 +161,21 @@ void ksw_watch_exit(void)
 	unregister_wide_hw_breakpoint(watch_events);
 	watch_events = NULL;
 }
+
+/* self debug function */
+void ksw_watch_show(void)
+{
+	pr_info("watch target bp_addr: 0x%llx len:%llu\n", watch_attr.bp_addr,
+		watch_attr.bp_len);
+}
+EXPORT_SYMBOL_GPL(ksw_watch_show);
+
+/* self debug function */
+void ksw_watch_fire(void)
+{
+	char *ptr = (char *)watch_attr.bp_addr;
+
+	pr_warn("watch triggered immediately\n");
+	*ptr = 0x42; // This should trigger immediately for any bp_len
+}
+EXPORT_SYMBOL_GPL(ksw_watch_fire);
-- 
2.43.0


