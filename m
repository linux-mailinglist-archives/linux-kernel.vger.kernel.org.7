Return-Path: <linux-kernel+bounces-748233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6454CB13E45
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BD6017FE28
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE116273808;
	Mon, 28 Jul 2025 15:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gQPkzr0L"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC66273D8C
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753716366; cv=none; b=C20GOQOCgZKS+YEXyvdllz1WhZUbzjDpYiCVkrGGPNIZh8MpCmPAgFO2K3LFoUrXWPCZ/rFPtv4m7IIH1oxjLu9dxeqgVXmSuDewwhVjWmkQwRW4yYDwF45e+gCAPw5RJJ7wAakju1V3rDU4m7+G/Lh93KtOctjr31xCijBkAAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753716366; c=relaxed/simple;
	bh=B2+rh0rOGraQ7q8XhKBNzeZFAeXpJupBpVJeEQFtmt4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lj1NYBl+oVoiIZlhtfEreaFriGOiMe8aiTpto8aPoheG7Y9Womy/pWffOOcxd+RP4/WJthv5OIn22LXN/fSw8+IzXCGoltCsaQrh37B2pgaZ+dHgm0hKPLrpkPLbHZn+oB+6ksJKPuCofuGpX+v2PCu2tQNYNBE+5CR8O2cFoeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--glider.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gQPkzr0L; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45626532e27so25518095e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753716362; x=1754321162; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=85Dq+0aWzQbqxgpA60NbQvRp1U2h0O13hIt4+o13Fas=;
        b=gQPkzr0Lpm/ejv0M8aSx1wm3/0s7+EaHVIozE9tD9unsy0yzmqqrZYfw1oBEomPMdQ
         59CJiaNqsSy50go2PXBvRQVaTZo13Ydbe6j8dBHeYN5P6+HtGUkbnp8y5sGGHHRVOaxB
         t30voSe2TY7fuNJlHgrPdCd/kLtleG/liyBWq6dnYmrLT+jLZnJFJ7Kb4ZdiS4itRBZ6
         /WfWcQeJG1w3fhJhRggTVWRmCVC7ySOwzhg5g+CDhOvYZFzVDVCnMnsVhDtGYLHZ0dBZ
         aT82Qw2hviXspFRdPAyXxlDGyeodNLFlWmNUSMk6UqeG3BAy9g8tUAx5FZVrlrTxoJZd
         ze9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753716363; x=1754321163;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=85Dq+0aWzQbqxgpA60NbQvRp1U2h0O13hIt4+o13Fas=;
        b=b0JUZ3DFr0RgA9pRmmvCWYU3sf4phDTaMfKf1p9g0A+HF8rFVavYdhh3w5qXXsHJOv
         4S3XAucgOFTtLqtAetdMr8tTXb2PsRsMoU6zRccb3ie2hk4cyJmDOtR8NEj21U8cZa4/
         O9BY3j8lRtLJsNYNic8U2OXdRxLX0r74bbbg2uaRcqL/IT65mvzU+lEIB6O0LAP3usld
         fdYaUssZN5m5c3QYT27pEl+KBSSYTwfdGwMUgOAnYqaeE3urB+LvTrG3imVF3akqnCYH
         gvSFus7u/w8Zpvzgh++DVlCKP3sgvG55kIaEQBxwFDc2Tw5P8lCeOtluDgeY9tUPTSH/
         5dyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcYo4i9dBBSsGAscamhzBHTyOTpQKt9RArfUW/MeZCyJeXrBLHIQqC+tU3p+nm71YcEjMrMUaeovUEcrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCGg4Dh+5InBDNoGc5dTmv7wBaUAQpURRv6WwgozCpBmis1ZKM
	lYTflF7lQnfIWf2GS6NWV+y6iWeCC/lPUl62gWImim5+PyXx5KJrDVgH7VtrupYVGrN09VggN+M
	Igd8e9Q==
X-Google-Smtp-Source: AGHT+IF7iuHEqTYX6R6hFk+4Mr2nordQpQph6sAYq6uxKRUPLUn4yemzwfL/jq5aN++p+IChmzkvToBdX1o=
X-Received: from wrbeh10.prod.google.com ([2002:a05:6000:410a:b0:3b7:76ea:26cd])
 (user=glider job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:4009:b0:3b7:8d47:6f82
 with SMTP id ffacd0b85a97d-3b78d476ff0mr666355f8f.57.1753716362501; Mon, 28
 Jul 2025 08:26:02 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:25:40 +0200
In-Reply-To: <20250728152548.3969143-1-glider@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250728152548.3969143-1-glider@google.com>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250728152548.3969143-3-glider@google.com>
Subject: [PATCH v3 02/10] kcov: elaborate on using the shared buffer
From: Alexander Potapenko <glider@google.com>
To: glider@google.com
Cc: quic_jiangenj@quicinc.com, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Aleksandr Nogikh <nogikh@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Marco Elver <elver@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Add a paragraph about the shared buffer usage to kcov.rst.

Signed-off-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
---
v3:
 - add Reviewed-by: Dmitry Vyukov

Change-Id: Ia47ef7c3fcc74789fe57a6e1d93e29a42dbc0a97
---
 Documentation/dev-tools/kcov.rst | 55 ++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/Documentation/dev-tools/kcov.rst b/Documentation/dev-tools/kcov.rst
index 6611434e2dd24..abf3ad2e784e8 100644
--- a/Documentation/dev-tools/kcov.rst
+++ b/Documentation/dev-tools/kcov.rst
@@ -137,6 +137,61 @@ mmaps coverage buffer, and then forks child processes in a loop. The child
 processes only need to enable coverage (it gets disabled automatically when
 a thread exits).
 
+Shared buffer for coverage collection
+-------------------------------------
+KCOV employs a shared memory buffer as a central mechanism for efficient and
+direct transfer of code coverage information between the kernel and userspace
+applications.
+
+Calling ``ioctl(fd, KCOV_INIT_TRACE, size)`` initializes coverage collection for
+the current thread associated with the file descriptor ``fd``. The buffer
+allocated will hold ``size`` unsigned long values, as interpreted by the kernel.
+Notably, even in a 32-bit userspace program on a 64-bit kernel, each entry will
+occupy 64 bits.
+
+Following initialization, the actual shared memory buffer is created using::
+
+    mmap(NULL, size * sizeof(unsigned long), PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0)
+
+The size of this memory mapping, calculated as ``size * sizeof(unsigned long)``,
+must be a multiple of ``PAGE_SIZE``.
+
+This buffer is then shared between the kernel and the userspace. The first
+element of the buffer contains the number of PCs stored in it.
+Both the userspace and the kernel may write to the shared buffer, so to avoid
+race conditions each userspace thread should only update its own buffer.
+
+Normally the shared buffer is used as follows::
+
+              Userspace                                         Kernel
+    -----------------------------------------+-------------------------------------------
+    ioctl(fd, KCOV_INIT_TRACE, size)         |
+                                             |    Initialize coverage for current thread
+    mmap(..., MAP_SHARED, fd, 0)             |
+                                             |    Allocate the buffer, initialize it
+                                             |    with zeroes
+    ioctl(fd, KCOV_ENABLE, KCOV_TRACE_PC)    |
+                                             |    Enable PC collection for current thread
+                                             |    starting at buffer[1] (KCOV_ENABLE will
+                                             |    already write some coverage)
+    Atomically write 0 to buffer[0] to       |
+    reset the coverage                       |
+                                             |
+    Execute some syscall(s)                  |
+                                             |    Write new coverage starting at
+                                             |    buffer[1]
+    Atomically read buffer[0] to get the     |
+    total coverage size at this point in     |
+    time                                     |
+                                             |
+    ioctl(fd, KCOV_DISABLE, 0)               |
+                                             |    Write some more coverage for ioctl(),
+                                             |    then disable PC collection for current
+                                             |    thread
+    Safely read and process the coverage     |
+    up to the buffer[0] value saved above    |
+
+
 Comparison operands collection
 ------------------------------
 
-- 
2.50.1.470.g6ba607880d-goog


