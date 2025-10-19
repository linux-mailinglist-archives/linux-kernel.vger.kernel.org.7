Return-Path: <linux-kernel+bounces-859542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59830BEDEE9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 08:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 860F43E3544
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 06:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473271369B4;
	Sun, 19 Oct 2025 06:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTs5NCmG"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D403F221FA4
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 06:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760854617; cv=none; b=rgrpqxcWPkDr7uhiZo4RKnhzyoPEPp2vvEWKO2a9fGxZgh8KaG2SA9PTvZFeGKyvWBgpJGRzgCgLKIRSuyoS3nVIB+e5guOJVsRLsYxLqJsUn75zcHESvkLPAJlpeYRrJJ/XNGldxYCJ2nr9rwPlellUMikRDiU2mqUGBx1WyoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760854617; c=relaxed/simple;
	bh=/fZ+pcXFI/bLxQ2mFY1Xp+wMUpBp0gh4E6urJggyENw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eb1JJsQwGJmwt76NnP1x4q9FOZSp7mY+za/xq7NBu6LgmBwmnBCie6r4D1vJSxWLJxMGY8wjujGi+8qL6BtcJ/TE2YDm4+iOnNbv/9XCvDS3hgHDdm57snbMQaT/7ERtGmzJzYopqj4AP3b/JID1ZWyV+r2O0yyydg3iD8k5thk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTs5NCmG; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7a23208a0c2so647172b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 23:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760854615; x=1761459415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIeDgxZ048HUq/QptiVsvTSq/SH6NNfnJz16wRbfAOg=;
        b=NTs5NCmGn/IyX2LDox8xLC6vQnJCuIsjHZL4i3woSESB9nSG+632KfcZqu3aPZ/Fpc
         zo1FC8Bzye2tsL+GCQgCkr3WR/JuR27gCBz9ehGwq1QLcmvQXagivAmqgZo/CSy5FrDq
         ps8/8HddKDFx6nVkpEcJm7V91EFYCNGjh9m2k1BRYIiJJjAXzO0avQf6Ew3ZD+/37hiu
         PxGCpUhC2IYnUQrnoTLTQgkbabnAiJ0U6yHqNIugZU5XIjbLX24nh+cG3gmvPo2S1j0L
         t6jUDhlkKBXRL3pu5oeRIE/BIgvGEEmO/b85/lB05x78bnU0DkQ66HYspqrMK1rHA/C1
         q4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760854615; x=1761459415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIeDgxZ048HUq/QptiVsvTSq/SH6NNfnJz16wRbfAOg=;
        b=qUEXPuDmarR6AMJcWKAx7nlitd7nhhoLlLeX++EkmBCL1tmv256wVqtMTgtFsbKrp7
         4XgkWqG8Aaen0JsaypIXFQKySF/nopSiBYZe6IzvuSm2COQCTkQH0bGNYFXvwHXTl2Zg
         4Kb4+NYJBzrRzY5qwhIBDdodQKRpqnoaa7eCpupvblxUCq81F9PCTF/rHsc3JfLMJe5u
         QhrwwKPNgKVTrSpzFlu1YMufiabGk3WQXy2/50rrfTfrQRku2DHWWtAG5VrP2OMhF1h2
         gIuDAiaeC3H+qPF37403zBHCi4ZUF4ypW0rBGjiPz181Z6TWlUVrf1NXZD/ySE9vfYPI
         BWDQ==
X-Gm-Message-State: AOJu0YzLCncR0iJh6pdsroZ9ZWB3UX1asT/gZDFeo5kJTqOr5eTyiMSF
	nMo/OCQjLRktFDAI/6PLZgQ9bf8PjnHPlo+09T89f7JvBLgETBbANeyWJr0JtQ==
X-Gm-Gg: ASbGncueeQZ4Pu5kopmQ+/bfxz9+Je7ezsECaXPVNASbHNF8G0cMy2nlVdn57ezvqLN
	kX30Fn5zPiDEHKccG1esUhUwFxgRkH61H1cIFx2r3TC7GjocOpfFVxXciCyhZfhmxOSfzNur2PD
	WQVR5jQCXXrJzkwQjhvdAgleWeZV30x3+LWf+KA0Gtkp+1QV0NCrsvXODqI+PFD554UA8/S9WfJ
	JW6nTWMtkpZq3faduOQz+0d5bkoAkoifbbwVOeu1V9WmyTALC87q8q6RxW9djHpZm7t4ImZhnMe
	ZNRMpgtAQexbSSHjgUBLG/rErN5AgFZlRFgkZIIKXm+lWezYLYDKQogD9M+pHEeh2tNg14+xAlA
	KO9ieQdGafB1LgbISFe35hmzJFWkbgP9BeFtAHdw4M0gE4i6Mh8loHQEnB0oN19yFzch0vBEUTD
	HjKE/gc0oI5qP5eWk=
X-Google-Smtp-Source: AGHT+IG0OBW7fmiA2YniV8ymtG2+sPiHKCxBMdY5eWEb2qkoBgohPShQvQn2sQ3XNKwAIyFsb9Df0A==
X-Received: by 2002:a05:6300:4cc:20b0:334:b4ad:154b with SMTP id adf61e73a8af0-334b4ad168fmr5911026637.27.1760854614800;
        Sat, 18 Oct 2025 23:16:54 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:bc87:d8fe:3e55:7ffb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b6f302sm4332032a12.38.2025.10.18.23.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 23:16:54 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: jiri@resnulli.us,
	stefanha@redhat.com,
	multikernel@lists.linux.dev,
	pasha.tatashin@soleen.com,
	Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [RFC Patch v2 03/16] multikernel: Introduce basic multikernel subsystem infrastructure
Date: Sat, 18 Oct 2025 23:16:17 -0700
Message-Id: <20251019061631.2235405-4-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019061631.2235405-1-xiyou.wangcong@gmail.com>
References: <20251019061631.2235405-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cwang@multikernel.io>

This commit introduces:

* Configuration infrastructure (kernel/multikernel/Kconfig) that adds
  CONFIG_MULTIKERNEL option depending on KEXEC_CORE, it will provide kernfs
  interface for multikernel instance management, device tree based
  resource management, physical memory pool allocation, and kexec integration.

* Core initialization module (kernel/multikernel/core.c) that provides
  basic subsystem initialization using subsys_initcall() to ensure
  multikernel support is initialized after core kernel subsystems.

This foundational commit establishes the basic framework that subsequent
patches will build upon to implement the full multikernel functionality.

Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 kernel/Kconfig.kexec        |  2 ++
 kernel/Makefile             |  1 +
 kernel/multikernel/Kconfig  | 20 ++++++++++++++++++++
 kernel/multikernel/Makefile |  6 ++++++
 kernel/multikernel/core.c   | 17 +++++++++++++++++
 5 files changed, 46 insertions(+)
 create mode 100644 kernel/multikernel/Kconfig
 create mode 100644 kernel/multikernel/Makefile
 create mode 100644 kernel/multikernel/core.c

diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 422270d64820..e0fbd7e9af43 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -194,4 +194,6 @@ config CRASH_MAX_MEMORY_RANGES
 	  the computation behind the value provided through the
 	  /sys/kernel/crash_elfcorehdr_size attribute.
 
+source "kernel/multikernel/Kconfig"
+
 endmenu
diff --git a/kernel/Makefile b/kernel/Makefile
index df3dd8291bb6..017ed567f86a 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -56,6 +56,7 @@ obj-y += dma/
 obj-y += entry/
 obj-y += unwind/
 obj-$(CONFIG_MODULES) += module/
+obj-$(CONFIG_MULTIKERNEL) += multikernel/
 
 obj-$(CONFIG_KCMP) += kcmp.o
 obj-$(CONFIG_FREEZER) += freezer.o
diff --git a/kernel/multikernel/Kconfig b/kernel/multikernel/Kconfig
new file mode 100644
index 000000000000..0e61fd2e505a
--- /dev/null
+++ b/kernel/multikernel/Kconfig
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Multikernel configuration
+#
+
+config MULTIKERNEL
+	bool "Multikernel support"
+	depends on KEXEC_CORE
+	help
+	  Enable multikernel support, which allows running multiple kernel
+	  instances simultaneously with resource isolation and inter-kernel
+	  communication capabilities.
+
+	  This feature provides:
+	  - Sysfs interface for multikernel instance management
+	  - Device tree based resource specification
+	  - Memory pool management for kernel instances
+	  - Integration with kexec for kernel loading
+
+	  If unsure, say N.
diff --git a/kernel/multikernel/Makefile b/kernel/multikernel/Makefile
new file mode 100644
index 000000000000..950bace927a0
--- /dev/null
+++ b/kernel/multikernel/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for multikernel support
+#
+
+obj-y += core.o
diff --git a/kernel/multikernel/core.c b/kernel/multikernel/core.c
new file mode 100644
index 000000000000..218424d59cc3
--- /dev/null
+++ b/kernel/multikernel/core.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Multikernel Technologies, Inc. All rights reserved
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/multikernel.h>
+
+static int __init multikernel_init(void)
+{
+	pr_info("Multikernel support initialized\n");
+	return 0;
+}
+
+/* Initialize multikernel after core kernel subsystems are ready */
+subsys_initcall(multikernel_init);
-- 
2.34.1


