Return-Path: <linux-kernel+bounces-830468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4CBB99BB9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F50918932C7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DDB306499;
	Wed, 24 Sep 2025 12:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAZMVh/2"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B9A30596B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758715264; cv=none; b=Zm3H2MTAMcnwDgjx/v8B4EooI0Pwux/tdSHjvuTjNLN+4dgK0jb4HAOKdRkhey2fKFw67bpeAUQ+eIFmzchiSPNb5aDcIX4mQp2cHR0MLcwHOHR9P1Dflb+HqGueYQTKYssqbSa3HkGum0qYJwle/EYLj4ullYvdLVZRcEgVs54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758715264; c=relaxed/simple;
	bh=1x1tZkclSlUAFkeAbCTbg9ur9vKYhrQAjAn0c+iWPHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jFoD6AXaxILXNKLZJIysr5vEezWxDWDi+L/37IatC6/YXGmpYs9yqt3QpuaAlm1nOyXdQTqMvg9psqjdS6w4oxm8PAcGlJDU1Q/3jbqH81mVyhHGn2pX2xOG3QjGWAd5D21UFkgqZU2rqb4n/WFXAMCWUfPKEN5il+zC4aoLIPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAZMVh/2; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2445806e03cso88048895ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758715262; x=1759320062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dXdR7Vr7GvNxroOAYy+aBhMqtIGh2YpUvjEzBf0MIg=;
        b=HAZMVh/2JYtZudMoe4XXzvbN8cfJTp+1ewB3T/14JMdxAMmQUdV1sAPK4EhX5456pA
         IJbDNXECjuz/otNjpvs39d1j3CcW3fWdwS76EkMnVuFa2VpJvSTbr/RsqnyuQxdSTxtj
         dhy4qdtGkSJXzSTsgKrItD4dIzVmPmhcmXlHLcmQJwdad08oBW/pwZb9cj4ySnrJrQ3Y
         EGyi0PL6oDC9i++W3JJ8HBzXDll0vzf0iyZuzMzN7QHw69E9EpzSm0FAmi2tpOvhGgCH
         hBR4czKYJO+nVjr22x9NKy445yHJFosrRrF/jYzNWRXvyaL560zJFYv0dKiKUTMyUV3I
         umvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758715262; x=1759320062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6dXdR7Vr7GvNxroOAYy+aBhMqtIGh2YpUvjEzBf0MIg=;
        b=CWfDVDWCMroWdhViflIzXVrT6WNu01jMBdYuaahmfhr2z8Ir0n31GFMq1vFIu6EDto
         U6omTNJCJ2qG69CjBq4R4CR97llLSLPBTzBI/LBNgJ6bKZgcYbYngQpJM9hOsVwbOMdk
         Za8aktWwGY4ZMQ7ND/lHo71wzs707/BzQqlEs387//8HtAK9V6wAVshIpMR4KSuAIftF
         GVArjgD+6ykc75orZX5MUCHgTYf3ZeGGJj2Hn3K0Ql8IR33rBdZ5gL+vll2OznGz0imM
         lMpt0Xolupuz1E3/drXRudtrH2WyEmfAWoOX/qTBUv6NW7z8JNEg5MUdEYyEGIZ6NXTB
         pJ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKV+lYdNDoaiy3MQ1tSXn/TW9Qr1ZtAq7s63roi0fhTGYwzx26QbW+9iLS5E0u0niJXeTOMA/hi1GAvSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWN7sEb5+UljQn2csU5ekirvUiL4iqVHLe6Hgixk9OQYTwHEau
	xDEi6QoC3a6lJfXe5LEFTsKs5+rihjnkO1dzQLrSs0aqMg7wWklpD4tE
X-Gm-Gg: ASbGncuVIM1a34J3UjLJfNjAAJnOazcLj4MF6I27y5b2Q+Er5l/xtgiuZvd6jaC9zIe
	B88YsoFcxmD83DSJzi8hATEYlfgF9HCERxCvL0A52rzOkhfSOY4wCQCByYgZ0HYSKTI5EsoWWBA
	JbvTPEp3hyvMO9VSY7/lrw0mhMQmA630XVAjaqD+F8QJ+bMFrslSTzZMZWLMOZ06FPXLeOjD+lB
	vGdTwYx8YXHPQ+oqOGPdXz7rzAvQAggkBElMLWeX9pqCXNEK5dSXJAsAysNtgmzAL+m8E+2B6/q
	YI2a1/IqhWsk5vrTH847LtWlWBzdlYj4FNPktNaf2ji4WGGXcWHLzffNjQ6dWPrr5YhU4sNmAqp
	o9v2V9kQ5IePjtnCU9h11zxs=
X-Google-Smtp-Source: AGHT+IGVP919XNHolLvfLc++BjiI5XDU3e+i/BPRLdij8Ir9EMWggkhD6kjR2mYU+aqH5NAU4i53wQ==
X-Received: by 2002:a17:903:2450:b0:268:f83a:835a with SMTP id d9443c01a7336-27cc9a91248mr60333305ad.60.1758715261649;
        Wed, 24 Sep 2025 05:01:01 -0700 (PDT)
Received: from localhost ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053d25sm191276975ad.12.2025.09.24.05.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 05:01:01 -0700 (PDT)
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
Subject: [PATCH v5 23/23] MAINTAINERS: add entry for KStackWatch
Date: Wed, 24 Sep 2025 19:59:29 +0800
Message-ID: <20250924115931.197077-8-wangjinchao600@gmail.com>
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


