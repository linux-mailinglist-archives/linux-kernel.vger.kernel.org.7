Return-Path: <linux-kernel+bounces-741651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D98C2B0E74A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 01:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6BF83AFE50
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 23:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1373528C2C3;
	Tue, 22 Jul 2025 23:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XBkXtInU"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1004B28C2A3
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 23:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753227914; cv=none; b=S9isGLQq435gvr4qLcPKdN5T19rk4RLXwjQDy/LoKyp6ifEfF+CdIL6BaoQjbpCGAaH3hs8Yo7hJL8yU8Ds7MZmD9Oj9H9AZq6qZiRiSITF6hehVvfaeNbUt+7owhflGz9JpYaffhWUt2hgwV5gJVGp+oNLwGmus/+/YIomYjGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753227914; c=relaxed/simple;
	bh=iR/ZFHDpx0HlMe6VYcX3WRXKOTGGqNHYMiXkNaaepLA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nO0RL13TFDjSkx/HnLnKH6FnLZ1ghiRbQ/y2jO9sjfdzog853opJKQYJdEDmohFZV0/xoNdh8cMFzqS7RSHf6FctphCh6W195cU9hHJmxZzzn5gVhRnwVfJWcdlvAz/6/DqnR6M9oguPpkQAMb0KEs0piOm7gGDjPcjH3lzS6bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XBkXtInU; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74ad608d60aso5013303b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 16:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753227912; x=1753832712; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bzB90mjYhl9cVeG8WmHQFXv2htyBjKdEHyc4UVAP4Ek=;
        b=XBkXtInU/Ux1jcL4QihVMyqe/r/bsu5LkR43HjUwRZ1DSG7qvArbmIEyk6mmYnYbnh
         Wio9bOnJ5GiYX5dN4hrki8gjV5Z3qzvhCpDClBIG4R0EWn95ZlrSJiQu7KbCYx6GllSP
         tS5ajJW4zbMU9fBFoW1g/BnDO/MiB73CKU1O/Ro8pibJ7C/EYy6754WnnQrvYVTNtpmQ
         jE6gfr6Ak/gnWz9cfH6gtdoDQ91lQk3IvZIC8fNnPjfNwD0VJZ2m8ZdAK7ECl6EsU18L
         ftpuAeWhRUxozr6U8A/8tit93NqepgXZZi8jrtWu65Ts6A+CUE9JF7HhG59uTUpxWbfQ
         uEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753227912; x=1753832712;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bzB90mjYhl9cVeG8WmHQFXv2htyBjKdEHyc4UVAP4Ek=;
        b=R+oV2v2LVflwRboJK+32XBV8ai0nzn2PqcMt5PAogQLIljqGWKF1lWgnuy3a/P0ddp
         Y8WkS1PEM1w/lnvD9LAivLOLD8BgcWtGAuHomRZJ3K+07lhiiWq9wp6VBZxHX6x/FD3b
         nLxy2zl9tnAGDA1WQGpUH92p+DOf1ET42rbq2kQbMLNipH29uZKNObXMrLlk2gTB9fdR
         8q7cVt+1dxAa+Ph+w3vqTKomt6ACOQrOrxuwOSnLJgv76SeBx8zR+t0HegFuqjgCg3iO
         pm5HjUe8ii60aKF5vsCgorlXNIK1fbTNr9N2ioYRFX3iNWgL3w63bYo0KO/3vWMzGNYD
         nTYA==
X-Gm-Message-State: AOJu0YzTviNlhRWVCOnugU1938AXmUapEP5LEnlGYIujh7DFU4xsANw6
	h7S2MBqOH+GC3DQRUDXjd8sLsmTq+2393vV5m+UeDVeMaPdPb+9nYYVTQD5DMRxhT9Gk6MQ5gVc
	MFr6qNdN2VadWGzn1HhlaJoUiQ/KsyjEuaJcjxov2ko8dEn+VAEtZBjmCEXWbAOrJ/57CpMy72W
	xbhhpHql8b9WVjO4Cvop2Q9sNxIe6vQLVNgcj9Z6lb7tJi2r9gJg==
X-Google-Smtp-Source: AGHT+IFfQxoWz0Fx1mfiwT12DdcIjNjYDEhezz3S0TsdPyGeMl/ALE7N6gjqiDWmebB61JqAUdwnDVB1zCDt
X-Received: from pfbct19.prod.google.com ([2002:a05:6a00:f93:b0:73c:26eb:39b0])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d0c:b0:749:456:4082
 with SMTP id d2e1a72fcca58-76033a13dd9mr1325216b3a.1.1753227912111; Tue, 22
 Jul 2025 16:45:12 -0700 (PDT)
Date: Tue, 22 Jul 2025 16:45:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722234508.232228-1-ynaffit@google.com>
Subject: [PATCH v2 1/2] binder: Add copyright notice to new kunit files
From: Tiffany Yang <ynaffit@google.com>
To: linux-kernel@vger.kernel.org
Cc: Carlos Llamas <cmllamas@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, kernel-team@android.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Christian Brauner <brauner@kernel.org>, Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"

Clean up for the binder_alloc kunit test series. Add a copyright notice
to new files, as suggested by Carlos [1].

[1] https://lore.kernel.org/all/CAFuZdDLD=3CBOLSWw3VxCf7Nkf884SSNmt1wresQgxgBwED=eQ@mail.gmail.com/

Fixes: 5e024582f494 ("binder: Scaffolding for binder_alloc KUnit tests")
Suggested-by: Carlos Llamas <cmllamas@google.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Tiffany Yang <ynaffit@google.com>
---
This patch is based on top of char-misc-next.
---
 drivers/android/tests/.kunitconfig         | 4 ++++
 drivers/android/tests/Makefile             | 3 +++
 drivers/android/tests/binder_alloc_kunit.c | 5 ++++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/android/tests/.kunitconfig b/drivers/android/tests/.kunitconfig
index a73601231049..39b76bab9d9a 100644
--- a/drivers/android/tests/.kunitconfig
+++ b/drivers/android/tests/.kunitconfig
@@ -1,3 +1,7 @@
+#
+# Copyright 2025 Google LLC.
+#
+
 CONFIG_KUNIT=y
 CONFIG_ANDROID_BINDER_IPC=y
 CONFIG_ANDROID_BINDER_ALLOC_KUNIT_TEST=y
diff --git a/drivers/android/tests/Makefile b/drivers/android/tests/Makefile
index 6780967e573b..27268418eb03 100644
--- a/drivers/android/tests/Makefile
+++ b/drivers/android/tests/Makefile
@@ -1,3 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright 2025 Google LLC.
+#
 
 obj-$(CONFIG_ANDROID_BINDER_ALLOC_KUNIT_TEST)	+= binder_alloc_kunit.o
diff --git a/drivers/android/tests/binder_alloc_kunit.c b/drivers/android/tests/binder_alloc_kunit.c
index 02aa4a135eb5..f8c05bf15c2d 100644
--- a/drivers/android/tests/binder_alloc_kunit.c
+++ b/drivers/android/tests/binder_alloc_kunit.c
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Test cases for binder allocator code
+ * Test cases for binder allocator code.
+ *
+ * Copyright 2025 Google LLC.
+ * Author: Tiffany Yang <ynaffit@google.com>
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-- 
2.50.0.727.gbf7dc18ff4-goog


