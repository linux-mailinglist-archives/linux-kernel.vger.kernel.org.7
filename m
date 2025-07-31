Return-Path: <linux-kernel+bounces-752031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25978B170A4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 549573BEC2E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E9E2C15AC;
	Thu, 31 Jul 2025 11:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TAypsaFf"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A332C08C1
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 11:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753962712; cv=none; b=p6B0PX9qOHCzW/QNK/MHzzeFbPMy2nRpMi8RzjoWDfmllY1KbhJj9D7NidPJlv0EJgpHDrhZ73UGjLPyc+Hfe//henT0wxfFl6N5vUBOOH1IZnwCBi8/jtoyTwYipdE+wwQRe1G23yzSILEcAu+1EH05DqGJWGGLT0wjGXoWce8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753962712; c=relaxed/simple;
	bh=C0sm9IXEXO6Tm8UTYt3LMTFM7Ou7qy/wmj90Uarc8XQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Uhf15jVZFHUfOG/6E63zSpKtpLoVOhK6yFpshkNTryBCvi6RmOnhZ9h2de6gbSP4Gmgp0ijE3DbkP9Yg8gXarRkd1vkKKnUi7wwuw423DlXAdh2+NM6wXgPru27VyTDbkLEqOPTU7tzakSEF3WWaf9SKeqtCUooX9jjPg2/UiKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--glider.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TAypsaFf; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4561611dc2aso8318145e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 04:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753962709; x=1754567509; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CQvXhi+JRNfdVXUC3A+PGrkf/DlYZ6BztZDrEED0HWA=;
        b=TAypsaFf36NGxh8qzfpDtyArDpTrIZHugnO3zOVdEjQ48upLkEwOG6kRbxndMmoNVM
         9Q48msfCuLKr43esYly5zoG+sZjOX4N5jqcAmfnG2PPICTUF0T2XTC1JEwrAMChMl2vp
         1S7vlp8Af279IrtVoiiJ+J5yYMG/CxXIpNiktgIdXOuTGo4CcX30DBzPaBCCr6JSHrK3
         M5Nsrob9gwbtX/AOaDEBl4sPLMVVIMoUuaWSxHayZOQUBG4OOjdzZSc1zQ2f+J+9x9zv
         S0RZF5GB7/n4VE9PyL3tieRG9CZa6m7WTY1Az8Uv96WJSKln4X/N65l2V47ddFUrPoj0
         69Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753962709; x=1754567509;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CQvXhi+JRNfdVXUC3A+PGrkf/DlYZ6BztZDrEED0HWA=;
        b=mDvCcnTmHV1Ng+XiPPhpAq5RPs5oKiP+5vK6jAcjgkq20A8BUZUxI1YzZNB9j+tbRf
         A4kk+jb3rTLrmPuLwI5Gt1wqFvxkWX9E10jXo8lUNSTQ45sNjDzJ95ggs/6w0r9iNMsY
         jcAfGQvDDOV2LeI2rPDQP2aAHXJsFSHZoqcCKsgGmuTjFwsHs+UQZUs4YFRggg+LoRhY
         +Qj1ydkS4WLMbnWGIKUPxiGSjfJ85T+fULvLkEf4UDz0Litp/6hfDPKbgA4oQ45gM22C
         0hyVmdFLsb4Ln4ciVfv3Syerles+NfIqZfDwp1mQPCd1xXvqJYJD16HXCcatSBvv0ank
         cMsQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1YNNl/8TJG73w7d+wsjzNGkZ9eiphl67/wqwjrfXBzb2iCHT5R8nQstqL3Fq3+ieEtmpGpkzclRuOYGw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc5Fl4XaPMy3qClEqZNvJz7YjQLMML+bKazTFbQdGtSE96mawY
	p9DWyXlOynKhlapSYcrAZKj8iz6Lv66bxIYf3A2dk0rjPZFfkFbtgpV4TY/SsGOpq/bs+mYxLFp
	wC/8aew==
X-Google-Smtp-Source: AGHT+IF3aDST1Gm4tiVNl+bsKkQtjhouu0IeNJsrxrczaDXlohR9f6qhG5KcqvqJsrj+SFS6mHGvh5BmEqg=
X-Received: from wmsp27.prod.google.com ([2002:a05:600c:1d9b:b0:456:1ba0:c8ac])
 (user=glider job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1388:b0:456:25e7:bed
 with SMTP id 5b1f17b1804b1-4589af5ba2fmr58419925e9.14.1753962709498; Thu, 31
 Jul 2025 04:51:49 -0700 (PDT)
Date: Thu, 31 Jul 2025 13:51:31 +0200
In-Reply-To: <20250731115139.3035888-1-glider@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250731115139.3035888-1-glider@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250731115139.3035888-3-glider@google.com>
Subject: [PATCH v4 02/10] kcov: elaborate on using the shared buffer
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
2.50.1.552.g942d659e1b-goog


