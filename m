Return-Path: <linux-kernel+bounces-798672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 440D4B4212E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 139AF688165
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2274302CDC;
	Wed,  3 Sep 2025 13:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="OJXBnqr/"
Received: from forward205a.mail.yandex.net (forward205a.mail.yandex.net [178.154.239.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B2B302CB6;
	Wed,  3 Sep 2025 13:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756905583; cv=none; b=J3SVkSHzljPLsGw/Pah2LaVLNfSbY1WBcK5A5QW52zYEEmGFwX22CdhFBcqeyMO94c70+S1tsPb81AazUYlbCnJosIC8XlElA1vJ+ECQWw+btmya/kXJCd6B2FyLOWgOUEc7wQHf8b2smHsNrIfPLS2TG1dMIDN4aGtwWWFZlpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756905583; c=relaxed/simple;
	bh=pyzxwGx7+PSkmBG1WocWAcb5j3Uj2h0oOnLjIjc2jd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e+kOQCYpucq01K5g5gC4mK+mDXADxPs55vkscKOEDKcMLoBJ0g+g1ZwLss+izksu2zPhVKE4Y1kZ0sWNiHTBMbmAOuuTuGiczwjXzN/IwOALynZORdaZ2hFqmBjyzIYrdaeHrAM8hqGtowWLcMPfPT5s791Q48jHEyAXqYbCuSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=OJXBnqr/; arc=none smtp.client-ip=178.154.239.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d102])
	by forward205a.mail.yandex.net (Yandex) with ESMTPS id E24BBC751F;
	Wed, 03 Sep 2025 16:13:43 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:3e17:0:640:f9aa:0])
	by forward102a.mail.yandex.net (Yandex) with ESMTPS id 554AEC0054;
	Wed, 03 Sep 2025 16:13:36 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id GDgKkBDMquQ0-trGI2GpZ;
	Wed, 03 Sep 2025 16:13:35 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1756905215;
	bh=PCoOmkaZAX9QwwZz2KVS30/FrEGaOVtw0GvyVsUp+oI=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=OJXBnqr/Oacta5ihlRRrx8ApyLEHfYwx18VHIj1ELZMYIQ3Ght4iKAHALyKslPGLB
	 GXkISFehVsSnD/ndhqg5dajGgDVr77FcAUhtzlls3j3Bd3PYtglDg8zlDNp+wBdcGj
	 7YoAed1ZUJr23hNcU11On2A562GOdiH80iz/zRMw=
Authentication-Results: mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	lossin@kernel.org,
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
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v6 1/7] rust: add C wrappers for ww_mutex inline functions
Date: Wed,  3 Sep 2025 16:13:07 +0300
Message-ID: <20250903131313.4365-2-work@onurozkan.dev>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250903131313.4365-1-work@onurozkan.dev>
References: <20250903131313.4365-1-work@onurozkan.dev>
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
 rust/helpers/helpers.c  |  1 +
 rust/helpers/ww_mutex.c | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 rust/helpers/ww_mutex.c

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 7cf7fe95e41d..4c789c5537b1 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -50,4 +50,5 @@
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
2.50.0


