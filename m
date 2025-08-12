Return-Path: <linux-kernel+bounces-764868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E72EB22833
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01F001BC4D87
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0F627932F;
	Tue, 12 Aug 2025 13:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AjFMu9mM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7542525949A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755004227; cv=none; b=pUZS4dnGZxVvGfTKOYUhIYgN2e4vUE4JjB5gxSmqyR2poKOZctj74YhEXcyI+YKSSJffporbDkxmVIYGu44De6iCazWNotv2wgAkYkyOzMA6Lg+edsBYFIkBgFVujR68yqJ2v7ByXDkeVA7iYN/FEU3TPc5Uw6cBSRViHRhO2DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755004227; c=relaxed/simple;
	bh=mj4z688+H5GrvzYFvgAeKyyxjw6x0byA0uWwcSgZ7QA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=N47kjS9v8polpbvPHtPOL5jxGezfoibB/lrpScHBKX+fAE9xV12Kl0eG2ARwSzIs/5x7ajGeElTTOh6N+NiU/meUscovPZpQe3pP0CC4TGgOBZNZFB2FCAnON+eX4KDL9XLDg2nuLxUg/tbiQW56G/38XXeorAiz10Z/Od28O+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AjFMu9mM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755004224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Shp71aTpcjkRwp8fdFozCS7DFDAA9ma8z9v4/SjxSDw=;
	b=AjFMu9mMHj/koIN2a/83vdrCIASVbbwJyQBeOBV+cv4llwtnAv7jsZ8kd40zFsySRK3TfH
	3QFfQDzMCyfbpioEFUJxJwS90D7z/kEel+cDycBMfcRTnlNTk49cIIYoa0QU3jd4Hb03C3
	UQbNo/vOySqsNwS1elZSW+AOYFm4Vgo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-DibAMnFxNhOH8o8J4OV6gw-1; Tue,
 12 Aug 2025 09:10:21 -0400
X-MC-Unique: DibAMnFxNhOH8o8J4OV6gw-1
X-Mimecast-MFC-AGG-ID: DibAMnFxNhOH8o8J4OV6gw_1755004218
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD2F4195608A;
	Tue, 12 Aug 2025 13:10:17 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.156])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D4E08195608F;
	Tue, 12 Aug 2025 13:10:07 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-mm@kvack.org
Cc: snovitoll@gmail.com,
	ryabinin.a.a@gmail.com,
	christophe.leroy@csgroup.eu,
	hca@linux.ibm.com,
	andreyknvl@gmail.com,
	akpm@linux-foundation.org,
	chenhuacai@loongson.cn,
	davidgow@google.com,
	glider@google.com,
	dvyukov@google.com,
	alexghiti@rivosinc.com,
	kasan-dev@googlegroups.com,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	agordeev@linux.ibm.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH 3/4] arch/um: remove kasan_arch_is_ready()
Date: Tue, 12 Aug 2025 21:09:32 +0800
Message-ID: <20250812130933.71593-4-bhe@redhat.com>
In-Reply-To: <20250812130933.71593-1-bhe@redhat.com>
References: <20250812130933.71593-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>

With the help of static key kasan_flag_enabled, kasan_arch_is_ready()
is not needed any more. So reomve the unneeded kasan_arch_is_ready() and
the relevant codes.

And also error out if both CONFIG_STATIC_LINK and CONFIG_KASAN_INLINE
are set at the same time as UML supports each of them but done's support
both at the same time.

And also add code comment to explain why static key kasan_flag_enabled
need be deferred to arch_mm_preinit().

Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/um/include/asm/kasan.h | 5 ++---
 arch/um/kernel/mem.c        | 6 +++++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/um/include/asm/kasan.h b/arch/um/include/asm/kasan.h
index f97bb1f7b851..b54a4e937fd1 100644
--- a/arch/um/include/asm/kasan.h
+++ b/arch/um/include/asm/kasan.h
@@ -24,10 +24,9 @@
 
 #ifdef CONFIG_KASAN
 void kasan_init(void);
-extern int kasan_um_is_ready;
 
-#ifdef CONFIG_STATIC_LINK
-#define kasan_arch_is_ready() (kasan_um_is_ready)
+#if defined(CONFIG_STATIC_LINK) && defined(CONFIG_KASAN_INLINE)
+#error UML does not work in KASAN_INLINE mode with STATIC_LINK enabled!
 #endif
 #else
 static inline void kasan_init(void) { }
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 392a23d4ef96..d62f494e0808 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -35,7 +35,11 @@ void kasan_init(void)
 	 */
 	kasan_map_memory((void *)KASAN_SHADOW_START, KASAN_SHADOW_SIZE);
 	init_task.kasan_depth = 0;
-	kasan_um_is_ready = true;
+	/*
+	 * Since kasan_init() is called before main(),
+	 * KASAN is initialized but the enablement is deferred after
+	 * jump_label_init(). See arch_mm_preinit().
+	 */
 }
 
 static void (*kasan_init_ptr)(void)
-- 
2.41.0


