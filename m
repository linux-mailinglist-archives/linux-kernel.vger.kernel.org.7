Return-Path: <linux-kernel+bounces-881399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E25EFC28231
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 17:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4E0B4EA19B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 16:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A66C28CF7C;
	Sat,  1 Nov 2025 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="TZuAQ2Nc"
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [178.154.239.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCBC25D536;
	Sat,  1 Nov 2025 16:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762013477; cv=none; b=E5kvDmHyagIZ8YGIHvMZ+1dKDEdaHY7Wbk4aO52mPPtCA0SYX2OMBTQAy0V15U7eZC0dQ7MLvT9qDNGbczi4Io4m+y6m8NCSptYtJqXkCrH7NhF6akcZsUFcYExkAv4f2g3N21IwITpUKcuHWXJDVOwhhp/Mk8l8OmJ6Z1+DrYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762013477; c=relaxed/simple;
	bh=vG9lfhUCRakuAGuT3dA0QBxjkAp8v6T2Rb+b5FMFZgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hq0dxi0VJ2hOphIiW9+XBW0xb/AFB+FtU3BVGlh5nHneYne3POEer9Hc9a3vfRwZZWZbZrTiY4X3fj2KWTz2DcZ0AhGY6/EhcDkirLS6QI0C3ZgwJDnhuwrdeZmwkS6Na7NlS5xZgp/093NkrgzSaiSsIG4aGlq14kJOx/HQVu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=TZuAQ2Nc; arc=none smtp.client-ip=178.154.239.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:d7c6:0:640:5e67:0])
	by forward101d.mail.yandex.net (Yandex) with ESMTPS id C0F39C0041;
	Sat, 01 Nov 2025 19:11:08 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id wAkixRhLDOs0-FPxOZO3o;
	Sat, 01 Nov 2025 19:11:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1762013467;
	bh=KtbJ7gwd1xqf54f0xvnpxlmrj7mnWdH6IdsdCodutvg=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=TZuAQ2NcRlTqhLImf2pTVru6k5a1BLPT9UmuuiTPpQ+DAEkbMwRTA3aH2kJZ6kVN1
	 IBLslnvd7QAbqDxannDTfXTqT5hhYpWOwWZlM7FI3P9IPOWBqS0rarMLDcmxlvVoJR
	 d/48RCrLvty4Q1e3Nod5+c509xv0C8RbWy1IdkjE=
Authentication-Results: mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: rust-for-linux@vger.kernel.org
Cc: lossin@kernel.org,
	lyude@redhat.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	longman@redhat.com,
	felipe_life@live.com,
	daniel@sedlak.dev,
	bjorn3_gh@protonmail.com,
	daniel.almeida@collabora.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v7 1/6] rust: add C wrappers for ww_mutex inline functions
Date: Sat,  1 Nov 2025 19:10:51 +0300
Message-ID: <20251101161056.22408-2-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251101161056.22408-1-work@onurozkan.dev>
References: <20251101161056.22408-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some of the kernel's `ww_mutex` functions are implemented as
`static inline`, so they are inaccessible from Rust as bindgen
can't generate code on them. This patch provides C function wrappers
around these inline implementations, so bindgen can see them and generate
the corresponding Rust code.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 MAINTAINERS             |  1 +
 rust/helpers/helpers.c  |  1 +
 rust/helpers/ww_mutex.c | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)
 create mode 100644 rust/helpers/ww_mutex.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 545a4776795e..03dca09d189a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14527,6 +14527,7 @@ F:	kernel/locking/
 F:	lib/locking*.[ch]
 F:	rust/helpers/mutex.c
 F:	rust/helpers/spinlock.c
+F:	rust/helpers/ww_mutex.c
 F:	rust/kernel/sync/lock.rs
 F:	rust/kernel/sync/lock/
 F:	rust/kernel/sync/locked_by.rs
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 551da6c9b506..58cf14d74516 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -59,4 +59,5 @@
 #include "vmalloc.c"
 #include "wait.c"
 #include "workqueue.c"
+#include "ww_mutex.c"
 #include "xarray.c"
diff --git a/rust/helpers/ww_mutex.c b/rust/helpers/ww_mutex.c
new file mode 100644
index 000000000000..61a487653394
--- /dev/null
+++ b/rust/helpers/ww_mutex.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/ww_mutex.h>
+
+void rust_helper_ww_mutex_init(struct ww_mutex *lock, struct ww_class *ww_class)
+{
+	ww_mutex_init(lock, ww_class);
+}
+
+void rust_helper_ww_acquire_init(struct ww_acquire_ctx *ctx, struct ww_class *ww_class)
+{
+	ww_acquire_init(ctx, ww_class);
+}
+
+void rust_helper_ww_acquire_done(struct ww_acquire_ctx *ctx)
+{
+	ww_acquire_done(ctx);
+}
+
+void rust_helper_ww_acquire_fini(struct ww_acquire_ctx *ctx)
+{
+	ww_acquire_fini(ctx);
+}
+
+void rust_helper_ww_mutex_lock_slow(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
+{
+	ww_mutex_lock_slow(lock, ctx);
+}
+
+int rust_helper_ww_mutex_lock_slow_interruptible(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
+{
+	return ww_mutex_lock_slow_interruptible(lock, ctx);
+}
+
+bool rust_helper_ww_mutex_is_locked(struct ww_mutex *lock)
+{
+	return ww_mutex_is_locked(lock);
+}
+
-- 
2.51.2


