Return-Path: <linux-kernel+bounces-755970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE0DB1AE33
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 08:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B808189D560
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 06:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CF921C188;
	Tue,  5 Aug 2025 06:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OcbWbscA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2E521ADB7
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 06:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754375043; cv=none; b=JAJPXJBfipuxYy6OE051K0X+A5uZwFEbufdm8ovuBKrJLAQDwNsB/r/YQghe9bWj8h5beZJbCFrrieH+wR2g3PyRQBiZcKBPD4SlU+IYfm9t2oGV/JzUYkCyJ1Fimy4WNRuUrmA4kS0pGfGELHxEPqVmS3RKJ7z9miUuAGOVGdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754375043; c=relaxed/simple;
	bh=W3R07hzTWZPfShNu2KVLMnA1R6pxahOpnR6skXTPLck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=f9+G0q04V9TTe63r31oqpRseQY9H1KJ6k25Rwb/cuBtEcI1829RrEBKbrbGqyj2sEXmOB1LukTLxvAOcwbf8jY5kslFqvPMBotQCVUAWFfERc6fn0AK/oQ2ot4iQh3EjLUJu/BBaeM1r4pnrnzSogwJ8q1/HsNNirEWtSCA0qV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OcbWbscA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754375040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gZBsPQV9kOkkozOpLxZBEzL8oHtewXXrqpcjTZWsiRU=;
	b=OcbWbscA+tClOSpRJy3gTFFu/oP/XOPYUuUygY4G0Y13kSYD6RaovQviD6ZeBJYDlpOMti
	27viEuPaaEMsvzhGoON/BvNZTj3Hcmacd+nGPeQO+/xhMQgs6vClYDOL/NcDne8Aiiuzj0
	so4A5XtGGKWvW8KHaKn5jPZgmyQKwY4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-TZy3PSbmM6WgBfqMCjg2Sg-1; Tue,
 05 Aug 2025 02:23:57 -0400
X-MC-Unique: TZy3PSbmM6WgBfqMCjg2Sg-1
X-Mimecast-MFC-AGG-ID: TZy3PSbmM6WgBfqMCjg2Sg_1754375035
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E55E180036D;
	Tue,  5 Aug 2025 06:23:55 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.136])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C857B1956094;
	Tue,  5 Aug 2025 06:23:49 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-mm@kvack.org
Cc: ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	akpm@linux-foundation.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH 2/4] mm/kasan: move kasan= code to common place
Date: Tue,  5 Aug 2025 14:23:31 +0800
Message-ID: <20250805062333.121553-3-bhe@redhat.com>
In-Reply-To: <20250805062333.121553-1-bhe@redhat.com>
References: <20250805062333.121553-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This allows generic and sw_tags to be set in kernel cmdline too.

When at it, rename 'kasan_arg' to 'kasan_arg_disabled' as a bool
variable. And expose 'kasan_flag_enabled' to kasan common place
too.

This is prepared for later adding kernel parameter kasan=on|off for
all kasan modes.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 include/linux/kasan-enabled.h |  4 +++-
 mm/kasan/common.c             | 27 +++++++++++++++++++++++++++
 mm/kasan/hw_tags.c            | 35 ++---------------------------------
 3 files changed, 32 insertions(+), 34 deletions(-)

diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
index 6f612d69ea0c..32f2d19f599f 100644
--- a/include/linux/kasan-enabled.h
+++ b/include/linux/kasan-enabled.h
@@ -4,10 +4,12 @@
 
 #include <linux/static_key.h>
 
-#ifdef CONFIG_KASAN_HW_TAGS
+extern bool kasan_arg_disabled;
 
 DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
 
+#ifdef CONFIG_KASAN_HW_TAGS
+
 static __always_inline bool kasan_enabled(void)
 {
 	return static_branch_likely(&kasan_flag_enabled);
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index ed4873e18c75..fe6937654203 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -32,6 +32,33 @@
 #include "kasan.h"
 #include "../slab.h"
 
+/*
+ * Whether KASAN is enabled at all.
+ * The value remains false until KASAN is initialized.
+ */
+DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
+EXPORT_SYMBOL(kasan_flag_enabled);
+
+bool kasan_arg_disabled;
+/* kasan=off/on */
+static int __init early_kasan_flag(char *arg)
+{
+	if (!arg)
+		return -EINVAL;
+
+	if (!strcmp(arg, "off"))
+		kasan_arg_disabled = true;
+	else if (!strcmp(arg, "on"))
+		kasan_arg_disabled = false;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+early_param("kasan", early_kasan_flag);
+
+
+
 struct slab *kasan_addr_to_slab(const void *addr)
 {
 	if (virt_addr_valid(addr))
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 9a6927394b54..377e9c285a74 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -22,12 +22,6 @@
 
 #include "kasan.h"
 
-enum kasan_arg {
-	KASAN_ARG_DEFAULT,
-	KASAN_ARG_OFF,
-	KASAN_ARG_ON,
-};
-
 enum kasan_arg_mode {
 	KASAN_ARG_MODE_DEFAULT,
 	KASAN_ARG_MODE_SYNC,
@@ -41,17 +35,9 @@ enum kasan_arg_vmalloc {
 	KASAN_ARG_VMALLOC_ON,
 };
 
-static enum kasan_arg kasan_arg __ro_after_init;
 static enum kasan_arg_mode kasan_arg_mode __ro_after_init;
 static enum kasan_arg_vmalloc kasan_arg_vmalloc __initdata;
 
-/*
- * Whether KASAN is enabled at all.
- * The value remains false until KASAN is initialized by kasan_init_hw_tags().
- */
-DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
-EXPORT_SYMBOL(kasan_flag_enabled);
-
 /*
  * Whether the selected mode is synchronous, asynchronous, or asymmetric.
  * Defaults to KASAN_MODE_SYNC.
@@ -85,23 +71,6 @@ unsigned int kasan_page_alloc_sample_order = PAGE_ALLOC_SAMPLE_ORDER_DEFAULT;
 
 DEFINE_PER_CPU(long, kasan_page_alloc_skip);
 
-/* kasan=off/on */
-static int __init early_kasan_flag(char *arg)
-{
-	if (!arg)
-		return -EINVAL;
-
-	if (!strcmp(arg, "off"))
-		kasan_arg = KASAN_ARG_OFF;
-	else if (!strcmp(arg, "on"))
-		kasan_arg = KASAN_ARG_ON;
-	else
-		return -EINVAL;
-
-	return 0;
-}
-early_param("kasan", early_kasan_flag);
-
 /* kasan.mode=sync/async/asymm */
 static int __init early_kasan_mode(char *arg)
 {
@@ -209,7 +178,7 @@ void kasan_init_hw_tags_cpu(void)
 	 * When this function is called, kasan_flag_enabled is not yet
 	 * set by kasan_init_hw_tags(). Thus, check kasan_arg instead.
 	 */
-	if (kasan_arg == KASAN_ARG_OFF)
+	if (kasan_arg_disabled)
 		return;
 
 	/*
@@ -227,7 +196,7 @@ void __init kasan_init_hw_tags(void)
 		return;
 
 	/* If KASAN is disabled via command line, don't initialize it. */
-	if (kasan_arg == KASAN_ARG_OFF)
+	if (kasan_arg_disabled)
 		return;
 
 	switch (kasan_arg_mode) {
-- 
2.41.0


