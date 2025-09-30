Return-Path: <linux-kernel+bounces-837010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A835BAB16E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68F043C4D04
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 02:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF0027280B;
	Tue, 30 Sep 2025 02:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GD+28C8I"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BC3270553
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759200372; cv=none; b=sgdCCRIjhAMSs6CF/p/LFDVyuF0wn110uQEv3WvfG3VANRN3x2P6zrU2SkoPg6/Hj2Jql51Q0+w2uDR2W9z22ixFSyqzjJHUBrCmdxAX5fzsQUb0h5UQhVsF/bqM1WKQjjnGI0MLucCgv3298hDaVBw3XThRdmAQuPWmIt8N+SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759200372; c=relaxed/simple;
	bh=1x1tZkclSlUAFkeAbCTbg9ur9vKYhrQAjAn0c+iWPHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hvHO6j9Ubu6fLCvhDULQMONFkLsMJqe3IK7c4giUz1iyJ8G4qe/WNQAsg80p1TXZoLujf9Pbecou/iO5FCBHvbq5GG69u+0fA6vSx9pzsgLo/EG+2pYDIBT9vm7uQTH6CiaNdQbjYkdQgIdO5P/w/UWtr2W8TVaoJ/AgQ1hGpdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GD+28C8I; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b550eff972eso3586196a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 19:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759200370; x=1759805170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dXdR7Vr7GvNxroOAYy+aBhMqtIGh2YpUvjEzBf0MIg=;
        b=GD+28C8IUPvPybTav2nSS/vfj11laS+g6x4FMtRKDrg3QGJgVIb6VedaPqMxB3SpB0
         3gTNvyiTrJIg6YqhoHZgmnXsd1WHyDJrUrPuAjVQLkuAHt5Ez8sZ2gbP1Q/Y0+8fkpnE
         w6rHB1gdgfhM5iJfg+xpCr3uT+K2D7kVhWikJum0aAbMyVnQClxJJDuIpPQUy2bEUeUb
         3c/LPOFfuLI3+gzDMRGqmPn5AfOY0N9A2uDReaMBYHslN1Tp/vHVAwso7qTYFkFZd9ao
         8fQKAYcL+5FuME8Ha8G1FwAgZ3TeTKWIbMg6nT8+BZGTJmos1M/W0pwoJ8rHf54otuNH
         xmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759200370; x=1759805170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6dXdR7Vr7GvNxroOAYy+aBhMqtIGh2YpUvjEzBf0MIg=;
        b=PHecaEJCE3fvfFpe+wMnf8L4Jnp/534oHblvGFoPDWszqGNeUuAaVHCynyEzH3QUnj
         ZiOlsI/jdvqQL22qtcLsy34ST2jd9zmQhDc7Iu1hGHJbIo8yCl2QMdB9WRaIRbPwfq1x
         oTdCvXT52RG0UNiR7nGo4GlQuoe3jJVCQ4dkIrcAc3R5pSOBbdj9FA1TG0GfzXbJ9TLb
         I5+XcoY8ZvAmQ17V9ryStY4W2LoKk+rzWarE3ApBpp41vF6li9nHcpmqT3MIZn4EivZx
         fB3mbo6l03RTAWHYFNoJ8exB0NP4out7kfWm6Nhy+ByFm8WRiY64mUcSHcTMD6zuhagj
         yY8w==
X-Forwarded-Encrypted: i=1; AJvYcCVhAL6bRbNYa9rUbYziDe+0wytrWqHCzebN2dtXY+V/HYnwnJ8GG1h+z6JnoUFVA1xHdpf4Kkcjrb1ezsU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw298AaIHmxRvDiR/8Q9tGA7Jut11mUQAgI9hDLIXrF93eAcj3w
	N0AHgyp5GomHZFUid55dwmK3EjGo/kvJR1eOMWg1irhIdlTP7eZoj2CR
X-Gm-Gg: ASbGncvJCrCsD/kMmLsl/3+QAlCdvwZfH4XwILtQo/m8id4YMncywKTj7fh5c1x25Yp
	uqNUaE4VqVTdJlKzIRLX2DEzUZ3sySNSOq0UmMl3Ihbvu9ZGH6jYOCMtxEBKj5vBBnXpAYDX6qV
	sP0BnBhRAR06WqNNjf0v0URIBmYYU1mqNakrwIvWkgepBYxYX9NZjy7zKdUb7QLpMpfTjM1539m
	CFIJ0PM8rvSLvOyZWfuGAOMYclQJyC8vkj2FnJ5QJ8r8HA023FRvlTRFQDBeex9e1yR4S9IOQIh
	CTE53EgZ7IOAjDGa29j5TEHDnE+rkGQgWqn+c0GgNVEIied9qx9Jl3Qsd/rC3DLYQ3iiccoGVxt
	npcT+DgonMTp/xSu12UF7ItsinFh0musSy/xLXGOFOayCnoXTWzLXunuJtkaXK6MTwg==
X-Google-Smtp-Source: AGHT+IEoEe43JjNKdWndUwta+OzzU/8noer3nQDRA4tPEoZN9FB7in6q7dddTrTKlJfmrNdEMUXFZw==
X-Received: by 2002:a17:902:f9c6:b0:275:2aac:fef8 with SMTP id d9443c01a7336-27ed4a78d81mr138634555ad.38.1759200370200;
        Mon, 29 Sep 2025 19:46:10 -0700 (PDT)
Received: from localhost ([45.142.167.196])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6715f0esm144277015ad.52.2025.09.29.19.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 19:46:09 -0700 (PDT)
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
Subject: [PATCH v6 23/23] MAINTAINERS: add entry for KStackWatch
Date: Tue, 30 Sep 2025 10:43:44 +0800
Message-ID: <20250930024402.1043776-24-wangjinchao600@gmail.com>
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

Add a maintainer entry for Kernel Stack Watch.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 520fb4e379a3..3d4811ff3631 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13362,6 +13362,14 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
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


