Return-Path: <linux-kernel+bounces-813677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6271FB5493C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16B6C1713C6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37CA2F6165;
	Fri, 12 Sep 2025 10:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqB0A8Nr"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00092F5462
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672026; cv=none; b=HJH9pQpJQUgWp2NqDzLysSUbtsS/ueU27ss6yy2wPwU40qGw0z+FD/bU8FoHZC82ctha/I7P6qVUnFNbIAXwuHzldacZ5M2gZBTTPwFi/mFup8ui9tVxfcrjZwaOfiAzzpn0BNJBxoyLEnV8f9u6TlNLgkjz8XRrM7+fnzs7VV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672026; c=relaxed/simple;
	bh=Y4IVRGt4gY6CeNENuQfFMwDoOjrFFT/8PJdPjuvJ4cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pdHTtXk6L70W8PSrD+XAjsr+Yi/iK+IDdmwo0wmjI9rLV0hUBujLmE+OKpUJ+siDcjEtzhmYm6PlC0iASAw+v2su67o5Mwb8rORxw8TWek9wCBb5Esg404R9l3qoQEZVO914M3xugyMjwVgZwU6xSIQgUoD15x3OMfHRC/GHMfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqB0A8Nr; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77251d7cca6so1708202b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757672024; x=1758276824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I55bZq7ZFzzpD1DxoyTRdsSYeFKQhRWPVd7TpHbtt7w=;
        b=BqB0A8NraNWmI/g9eWEjwuUs03vZr+6jF1scr8Z0C0j3tZlufwEalQgqxouGTUTUAx
         QFn4nayB0gwNYyI1P4qat2hjPKoMHGUf/0NWH/FCW5n4DcaVVb54106BIZv1l9kY4Pzu
         Kpsc7UO3nd0yzNxIqBApWfFYgrykwBKdJX98Ukx06IPIpzg+dLuvL0rEvXWwY7LzEUvV
         GSZfrHOPVyo+RXZmH+nyxRU7GHns5QWPhUKbioZUjK/IW8qkYT7HQa6+FnlFh0P9KG1R
         bkzpf6rb23CJoWsTu7iXTKyu7eEiRKcPnJxbzIJJhN7JYodBIMgK+t5f5nErohzICzXL
         hlYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757672024; x=1758276824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I55bZq7ZFzzpD1DxoyTRdsSYeFKQhRWPVd7TpHbtt7w=;
        b=HH9H/9qtGGW4j0OP+LEqxBa9I3WtGxMUlcSBba9f9OkmVN6NP6vvM9Absi2JI1D7U5
         QqudXJiPUVRAghMO4kOlNX7rLqiy/utCFEMB1OCwSZytuDGgrkeo1Rhi9084oFbocZMB
         yAQVPpVGi4Ude2s1etYnTj8FsKVXIeLDgDLmWTdCJQ0rFhoYRy+SXdO6OHovUYfflurk
         TLlcFgE5ewvS6y0MnXo/wzMOsTA3q0gxxtvnl6lL0R41petJeNX0P8VovA/oMax8q+T9
         BmvruevM4ZpHKHLnKZLgCR0Mm01q12yUkNZxqZ20vU8IudyOx4MLRThzQn7gOgeUy4qt
         CLLw==
X-Forwarded-Encrypted: i=1; AJvYcCUxtyCounVuFN6a1UseKQ0ZmgSD2SyIgO0YMmKH8LY8vWdsh1WpdSEK8NROw7fnXmQQuF6i6tl2X9H4UaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3SCgdi3HQWJcrQEWDzrzAcqG9UuvarqTZgJlzy5gkbIqNyW2W
	M/GKit2jahpOWe6Ep+GxXsgTyrFgHYiYn5+Pjiqp9xPEJhpmVPfoszms
X-Gm-Gg: ASbGncseM0uvUf+Ae1DgvphmL9io0xwKcWg/7nKw0TQZlYqn1VTpsX+uJSQBinue19x
	bZlxucu++1ap/F/NV1Nczt5gSJomdj6CEQgHQBOD/aA/7HuQiIBVKG8Ltqje4Uw02E0s+gdSeR5
	ZX9cBcCvDw81zybEDc76nUwbDHMBcI75Ec4J+6Gl+Pa7ZpTsat6t6hx2FBdye0ux9ZbqBkSrJXv
	KZfihmb46Nj7uNF1CZUg9CwCqpHHZdUKkDMYTI50SP2n5I23+Mi5eU4ZbITWBJNhjSj0iixOsFh
	K4ddKi6urUBUGEcyozdDSmaaex6Nwj95gsvclCeMrt2pt6HQkAMZw1q3janLIKoAVoFWxm3VZfC
	SQ9T/H0urzMZZVONj2OsQ5CcCueL3P6N847BP6hoMh08crQ==
X-Google-Smtp-Source: AGHT+IEmU8/7QYE28ulPnmQWl8v4TOjFN/LND+vjp/ORoshKulgXE7ro2NJTOczUKB1xsXbgHPgJeg==
X-Received: by 2002:a05:6a20:734d:b0:24f:53e8:cca2 with SMTP id adf61e73a8af0-2602cf104d0mr2912224637.60.1757672023846;
        Fri, 12 Sep 2025 03:13:43 -0700 (PDT)
Received: from localhost ([185.49.34.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a3aa0f8asm4307035a12.48.2025.09.12.03.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:13:43 -0700 (PDT)
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
Subject: [PATCH v4 21/21] MAINTAINERS: add entry for KStackWatch
Date: Fri, 12 Sep 2025 18:11:31 +0800
Message-ID: <20250912101145.465708-22-wangjinchao600@gmail.com>
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

Add a maintainer entry for Kernel Stack Watch.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd7ff55b5d32..1baa989abf2d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13355,6 +13355,14 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
 F:	Documentation/dev-tools/kselftest*
 F:	tools/testing/selftests/
 
+KERNEL STACK WATCH
+M:	Jinchao Wang <wangjinchao600@gmail.com>
+S:	Maintained
+F:	Documentation/dev-tools/kstackwatch.rst
+F:	include/linux/kstackwatch_types.h
+F:	mm/kstackwatch/
+F:	tools/kstackwatch/
+
 KERNEL SMB3 SERVER (KSMBD)
 M:	Namjae Jeon <linkinjeon@kernel.org>
 M:	Namjae Jeon <linkinjeon@samba.org>
-- 
2.43.0


