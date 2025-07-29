Return-Path: <linux-kernel+bounces-748806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7436FB14628
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 04:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45B91AA14D0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 02:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86E21FCFEE;
	Tue, 29 Jul 2025 02:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sNxNF3r+"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A343520C48A
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 02:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753756012; cv=none; b=bP26xkXG5tlyEuv1yNum3nobyN0OemLhlGc5eZkJHoAPcKurzUZMQtwNHrn81+M7eegTZYJ/5l4PaewgHw1zuoXAdS3YuiEeENhcpdt3V19jIprXdgBG/E0hesXO+NmDdcdeAnk0ioeT4LiM7BlxL6oP23U8lfe87KJD2KWtHMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753756012; c=relaxed/simple;
	bh=bpPKQzVvF2Y3jUpkSIAzRUU7htVMnv8MWQb3f1guygM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=D3FYGif7m2UX/jYWAcybD5M9rvblbcT5PEKHsM7ppGHOFJU9WXKA+g2DYr1BsyCpX005qrXRADxvwUGRfDRxaDfiYNx284zPw675xHIqudNkLx9bRrhUeMcnJc6xCDLy1TxLTTDEptxs46j9qu9hQErEWr6pPKjX8i1FEDfUS+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sNxNF3r+; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2369dd58602so52165935ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 19:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753756010; x=1754360810; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NPDuevloimGKVsWil7Slcd/Yj9vleIb69P9iimghSK4=;
        b=sNxNF3r+5VVjyrbiG1R8TKESohNemm/A6syHOxVpFiwYedSwnM1lIeV4GjuvB07F3v
         j4x3nmF3YQSfP98uJT/cQBi37gIc4J30k1Mv0GZGJaIqvmi1xQk0YiTpeVW05fteCMyz
         S6P/JUyVu5bkqHs6gfGhdgIxPCQPPa9J4qEpa0cj8CgFb0Kz9YJhJJImkXTlnOelslb3
         OU99M/O3epFnAjMqAvClXaXPvS2FbGS7JiU5iYGmJaM9VTlzuBK3O8FiYU33tzMQfZ0T
         DEQqeV38AiF2dUa7vkd4S31D390cA9pqdATadBP76pxmPLiuYW75vKhUHjAIq8XqUYsB
         5SeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753756010; x=1754360810;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NPDuevloimGKVsWil7Slcd/Yj9vleIb69P9iimghSK4=;
        b=KuyuJ4+8SJnswNq9HTDFXRTI/UCuM6iv98jsPpK1lUGi5YXBi6/9QYda81xWp2kyaB
         1SPUcACit+jvKgcwM4xxzVTa0KtAQ/+FbuHbHaVGjRCE98yzTqTDoghbewvh6PN9Y3kt
         rJlbMO//1/sNreROLF6iqKKZHLRm9i/FG/cfHnWTu+v9/EAgLlNtoYhwq2WjcpBGVldw
         zspgVjPXS0fbR4fBt+xKpgJWP2bOfXvMpewrGmgY75xJj1/vnknSr8Bq7M08w2/9iTbq
         RfGa7TA6oNQrwhjg4O+dd4ZZbwNKXjsPq2BNY1Ujj2rCcygnlzJ6fogP0W6EKZUaA/za
         Dvmw==
X-Forwarded-Encrypted: i=1; AJvYcCVEFJaSuIGFydbhH+qgUF2kdoTd6zA6eQmXTDbAE88y59rO9rK5PV1J/Gxs4gST0/i9xFhhcXpqoCxnbiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxDkwEIXGB2PC13y/GySfiC+2ymZhjjicxGCmxTLOogZ4gELPU
	vIcU5ZoG3lOR7lq8FqShfLsVdaMmNzUb0Zn3GGwiUgQIj77F12emk6rxezNkrleAxiJCgyHZrM0
	WI8WMLg==
X-Google-Smtp-Source: AGHT+IGyyM3fDnm9QBVau2QFKbJOjQeX2Y82KWdawzVLWv6ahiPgYmXl8LvmKTgkRHyMXJzIeDPEu2d5dAI=
X-Received: from pjbsn7.prod.google.com ([2002:a17:90b:2e87:b0:313:2d44:397b])
 (user=yuzhuo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:228e:b0:240:1f19:d35c
 with SMTP id d9443c01a7336-2401f19d5acmr92061085ad.39.1753756009846; Mon, 28
 Jul 2025 19:26:49 -0700 (PDT)
Date: Mon, 28 Jul 2025 19:26:36 -0700
In-Reply-To: <20250729022640.3134066-1-yuzhuo@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250729022640.3134066-1-yuzhuo@google.com>
X-Mailer: git-send-email 2.50.1.487.gc89ff58d15-goog
Message-ID: <20250729022640.3134066-4-yuzhuo@google.com>
Subject: [PATCH v1 3/7] tools: Partial import of prefetch.h
From: Yuzhuo Jing <yuzhuo@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Liang Kan <kan.liang@linux.intel.com>, Yuzhuo Jing <yzj@umich.edu>, 
	Yuzhuo Jing <yuzhuo@google.com>, Andrea Parri <parri.andrea@gmail.com>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Barret Rhoden <brho@google.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Guo Ren <guoren@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Import only prefetch and prefetchw but not page and range related
methods.

Signed-off-by: Yuzhuo Jing <yuzhuo@google.com>
---
 tools/include/linux/prefetch.h | 41 ++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 tools/include/linux/prefetch.h

diff --git a/tools/include/linux/prefetch.h b/tools/include/linux/prefetch.h
new file mode 100644
index 000000000000..1ed8678f4824
--- /dev/null
+++ b/tools/include/linux/prefetch.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Generic cache management functions. Everything is arch-specific,  
+ *  but this header exists to make sure the defines/functions can be
+ *  used in a generic way.
+ *
+ *  2000-11-13  Arjan van de Ven   <arjan@fenrus.demon.nl>
+ *
+ */
+
+#ifndef _LINUX_PREFETCH_H
+#define _LINUX_PREFETCH_H
+
+/*
+	prefetch(x) attempts to pre-emptively get the memory pointed to
+	by address "x" into the CPU L1 cache. 
+	prefetch(x) should not cause any kind of exception, prefetch(0) is
+	specifically ok.
+
+	prefetch() should be defined by the architecture, if not, the 
+	#define below provides a no-op define.	
+	
+	There are 2 prefetch() macros:
+	
+	prefetch(x)  	- prefetches the cacheline at "x" for read
+	prefetchw(x)	- prefetches the cacheline at "x" for write
+	
+	there is also PREFETCH_STRIDE which is the architecure-preferred 
+	"lookahead" size for prefetching streamed operations.
+	
+*/
+
+#ifndef ARCH_HAS_PREFETCH
+#define prefetch(x) __builtin_prefetch(x)
+#endif
+
+#ifndef ARCH_HAS_PREFETCHW
+#define prefetchw(x) __builtin_prefetch(x,1)
+#endif
+
+#endif
-- 
2.50.1.487.gc89ff58d15-goog


