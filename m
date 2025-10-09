Return-Path: <linux-kernel+bounces-846666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC05FBC8AEF
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 13:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E005423BD0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 11:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1252ECD0E;
	Thu,  9 Oct 2025 10:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neiksZ1z"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CDD2EC08A
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 10:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760007522; cv=none; b=RH1zxherWvEzh5h/ebNPUlGhI6VbfVbqQKJ/Rd/sTzbrQ/e//dc0VSNACTtt9Fxgi3FlWgkti7u3HrZuHytGhgf7eanhLdeX+DouRMxMC3/f6XX4LSxKoi6+KNUzzSVr60L5grHYXvwMnISW3C/Go5qXbXtk87JZ0BzUQI2a8yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760007522; c=relaxed/simple;
	bh=JE2O3gXCPzxmYnUAKlXgnSjWi6sqfl5NW64CDq3b/SU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TW+z2y/OPSnUaFhC1ldByOoQZ8En7meJMpAOIPXaiiUo2KeiYIAsHSwstK3KNA+D8SKupsURYEdiZxuOXS2E+LNnLtslqqyyLegUB4YfUWriYELy9GG7XoA50QUNBZ6kyXHBuyQHcLkPq4KBLYbIrUf2pSa392go3du1onKRD04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=neiksZ1z; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-794f11334adso721934b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 03:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760007520; x=1760612320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ApAR8xSadwKhwismNq+uPz91ksCPHZtzxjh6qDdbHI=;
        b=neiksZ1zocphckHCNdcqvCB0SEeovXjopGI6pfpT024hB9TvNjLbNBW2fKJWGPduwr
         GiSupT6G/yLKjBEtqqAeENNbRPdgnNYMqthN122C5+pJxCOkOQWV61nbV4w1No4FRyYT
         9g7DxBp3MRACp4vLb8XCW/2HHHgm5bx23ER9ozH7ZIeGtwfRIqwfncfD6BJPQ5NyKi1E
         Dzh9XGRvbkafQcDpkHjTfZE9vZOulFBQ/n2M24QNnDblwnATtnrubC6H9rY+1HNqoS+l
         PoUlGHQwpEkwR/1UpJLxl8LX14t+gP/LvsFdcPZctWanuRItuk1buoqPc1yuKN9qKZtL
         6DAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760007520; x=1760612320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ApAR8xSadwKhwismNq+uPz91ksCPHZtzxjh6qDdbHI=;
        b=DXdyGrnWX6abez0GdTARdnidyDWXEK+fT0luL0iPZRCFK+I0ybhJTKfbaOr/Cdq4La
         eP10pRy/1l0ct3ON+zcU8D7BCxmTZNLGQgncWn6VJ9/9IZJJqYE8C2iQjaH+r13H5xYY
         piWaOeONozIvP8wQYqZFBmXDNFZUbZwNCpfi9kDdJShB9MDjmDluygxCdhWaelQc1JZm
         OVWi8QkRrDrj7DUyH3fkxgv57xATzsKCjOW959I7vX7g8U43guGljEeaCLZxwhXNeXET
         hCQiJj5BpwVuzEiuWBsLRrKBl1agPINPEHrJNpoBvCSKqNU429jsFkL24elC4BOCfBHj
         Hpuw==
X-Forwarded-Encrypted: i=1; AJvYcCXKeJc4xJgvgQuDoiKUZLM0dY2RoaxCDEW/wXGgpKHuFT8q3lhaQZnvt/i7Cp4ourX+7Ecv+pK7kgqhgIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Fh71m3AtvIosFg/RfQLgqE+qc4IsgYUfEhAAPqiP4jRvVznz
	6qoxts1XD8TASbDceR3HXx7EBzrIqY+LmQi0J9tLMt1dAqQ6MvtCEBl2
X-Gm-Gg: ASbGncu76ESGX7yzmDfDdWk2rmIC8GbrwqX9YWPEYUwMRleJSggT3qIGhrQ+KWTBSxR
	OOTn+Q/j7VPKxuZgFVcVD5r3mQAskj36rvgQ6xt507qvbxlgmpxlp2XBfUEfNaq32gxeUTWJUhL
	0hg333yqWVkoe0VoXCJ8Tz3FpcAZ2yHJT6S8HcXMVZhYlhSa93Ke2xiWJsS4WEPo//GycA3XDHt
	I6GsYNF4IgNV78auSdSNl0U93KiQoYR/JqzaowPe+dT9OIspQfioGJ6W0zVMh3NJ+rnEDKDjaOY
	p9ty+/kRRw3QekLpEivJVSskVlJVY8T1oFzNyViZYnSnvpXhLwDiuhhfWYnIMMslIwPP17c5oQ3
	VEb/rKf7sz9cqMZxoEgDDDNlQBb5tNfMkt+ecQXKLp4+00kS+qaVg/n72+Hh7Ln3aGb2765U=
X-Google-Smtp-Source: AGHT+IFNGlIpEHO7TMNSv14SEeeL37qmV4fa31y9HfqA5Z8RmIIJBkgU1nSNu4enoYA+m8tb63ySAw==
X-Received: by 2002:a05:6a21:6d99:b0:262:1ae0:1994 with SMTP id adf61e73a8af0-32da845e6c6mr9710336637.42.1760007519707;
        Thu, 09 Oct 2025 03:58:39 -0700 (PDT)
Received: from localhost ([45.142.165.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099d4d324sm21591393a12.27.2025.10.09.03.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 03:58:39 -0700 (PDT)
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
Subject: [PATCH v7 23/23] MAINTAINERS: add entry for KStackWatch
Date: Thu,  9 Oct 2025 18:55:59 +0800
Message-ID: <20251009105650.168917-24-wangjinchao600@gmail.com>
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

Add a maintainer entry for Kernel Stack Watch.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a27901781c2..d5e3b984e709 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13596,6 +13596,14 @@ F:	Documentation/filesystems/smb/ksmbd.rst
 F:	fs/smb/common/
 F:	fs/smb/server/
 
+KERNEL STACK WATCH
+M:	Jinchao Wang <wangjinchao600@gmail.com>
+S:	Maintained
+F:	Documentation/dev-tools/kstackwatch.rst
+F:	include/linux/kstackwatch_types.h
+F:	mm/kstackwatch/
+F:	tools/kstackwatch/
+
 KERNEL UNIT TESTING FRAMEWORK (KUnit)
 M:	Brendan Higgins <brendan.higgins@linux.dev>
 M:	David Gow <davidgow@google.com>
-- 
2.43.0


