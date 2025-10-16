Return-Path: <linux-kernel+bounces-856955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E884BBE58A6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 23:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A883358546B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F452DCBF1;
	Thu, 16 Oct 2025 21:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CxzRby6n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5D42E7645
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 21:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760649031; cv=none; b=quGO5ecB3MsDRUXPlRm7jZbEpEPbNFcQevF6HShvHOVcxcDc79d7PPqDdaCHUR9Aslt3InuDhuS55Hf8Hm5DAV7vzeXekKWW/nkislcv6+JfYQot3m3iVtNrfYdMxZvkk5iaadZRUDEg9SFRXptt3DmbN420Xl0Q3rQ3ll8HnOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760649031; c=relaxed/simple;
	bh=3L52Vq1iLqHbjgsO/NhnIj7sU2nxQd4cZTfZjVNqjG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCOHt0iSJdf35/z+qm4FMIwH+2X7rJDeYxT54wg+M9FONZghPlKaertI7s/G7gm96dKxv23CfCELghuZRiatrrDr06wivvJWQ7Xj8+0WfcphR7mmxHOMTJdOGQYkMunpMkFTGCoyk+5sOLmu63cq/E1z7brtqqzeL0GCkfMT5wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CxzRby6n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760649028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1OPvje+l85zHY7KuuBRlHbuleAtdJZ9o1r8DGxmRPSc=;
	b=CxzRby6nj1WSGM+J+Id6FS5M3Nd99GfUSbvKXYpIt/J5dv/VFX86Yr4+1pketM7nSVq0vD
	3LvvCfqvMo5tYpPQwKOPGPqpYoDVIgBsJuU+guf5YFHy97mozYH7lVM/sFvBhGPPAecXZs
	UnJW7sC5hBUBpmmc3hqmKCH4mtdKRVk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-MveZkLtgMZ6WAJSxzNXypQ-1; Thu,
 16 Oct 2025 17:10:24 -0400
X-MC-Unique: MveZkLtgMZ6WAJSxzNXypQ-1
X-Mimecast-MFC-AGG-ID: MveZkLtgMZ6WAJSxzNXypQ_1760649022
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4A4F18001E7;
	Thu, 16 Oct 2025 21:10:21 +0000 (UTC)
Received: from chopper.lan (unknown [10.22.80.252])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 70194300019F;
	Thu, 16 Oct 2025 21:10:18 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Alice Ryhl <aliceryhl@google.com>
Cc: Asahi Lina <lina@asahilina.net>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Asahi Lina <lina+kernel@asahilina.net>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Krishna Ketan Rai <prafulrai522@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-media@vger.kernel.org (open list:DMA BUFFER SHARING FRAMEWORK:Keyword:\bdma_(?:buf|fence|resv)\b),
	linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING FRAMEWORK:Keyword:\bdma_(?:buf|fence|resv)\b)
Subject: [PATCH v4 3/9] rust: helpers: Add bindings/wrappers for dma_resv_lock
Date: Thu, 16 Oct 2025 17:08:16 -0400
Message-ID: <20251016210955.2813186-4-lyude@redhat.com>
In-Reply-To: <20251016210955.2813186-1-lyude@redhat.com>
References: <20251016210955.2813186-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Asahi Lina <lina@asahilina.net>

This is just for basic usage in the DRM shmem abstractions for implied
locking, not intended as a full DMA Reservation abstraction yet.

Signed-off-by: Asahi Lina <lina@asahilina.net>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers/dma-resv.c         | 13 +++++++++++++
 rust/helpers/helpers.c          |  1 +
 3 files changed, 15 insertions(+)
 create mode 100644 rust/helpers/dma-resv.c

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 2e43c66635a2c..07f79e125c329 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -48,6 +48,7 @@
 #include <linux/cpumask.h>
 #include <linux/cred.h>
 #include <linux/debugfs.h>
+#include <linux/dma-resv.h>
 #include <linux/device/faux.h>
 #include <linux/dma-direction.h>
 #include <linux/dma-mapping.h>
diff --git a/rust/helpers/dma-resv.c b/rust/helpers/dma-resv.c
new file mode 100644
index 0000000000000..05501cb814513
--- /dev/null
+++ b/rust/helpers/dma-resv.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/dma-resv.h>
+
+int rust_helper_dma_resv_lock(struct dma_resv *obj, struct ww_acquire_ctx *ctx)
+{
+	return dma_resv_lock(obj, ctx);
+}
+
+void rust_helper_dma_resv_unlock(struct dma_resv *obj)
+{
+	dma_resv_unlock(obj);
+}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 551da6c9b5064..36d40f911345c 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -25,6 +25,7 @@
 #include "cred.c"
 #include "device.c"
 #include "dma.c"
+#include "dma-resv.c"
 #include "drm.c"
 #include "err.c"
 #include "irq.c"
-- 
2.51.0


