Return-Path: <linux-kernel+bounces-776977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F39B2D3AA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E63401C43F31
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 05:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6032C11D4;
	Wed, 20 Aug 2025 05:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sm5nir1T"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FCF2BEFEE
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 05:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755668231; cv=none; b=ZBiMei1YUBR/qeUTZILdBJnwOGERo5jGSMXhrlD35X21qeVqReEeQu31+S/eSxtE2nZDFvdlOx2Z70I3wX7+oLcfT3OOFw6QxRuZGk/mVLzvJHVmseZ3WcaqPkk6YCTEWDWfllLmyNbkGCnBx7oNMkdQs880qqn6ID+x49AuPI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755668231; c=relaxed/simple;
	bh=OUjX53EAHeKwXVNw4pKhXoSWyP1sGMgjRDiEs64lYtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=YZ7Z3jaj6RsCDq4c1qDJCYR/bDmpEsjJIPyuTuCN6NOUlryCRKcSsx9BUMr8XqxdaiKYGRazMXgdjj1TZWApzwDXd0vk9q6/rr5rmVuAQJhFZb0Pr3TYtMZa5ay4uhS5vKVK7lg4ZPZj/qXA3PSUqEG68w3pzU38FXRZv6K4Vxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sm5nir1T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755668228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n2YWNQ1R3q2yuyqJw9ejU5xCE0/f1sakMXwMmNRUMe4=;
	b=Sm5nir1T/ujZc6uuPgEtOtk9Ch6R7WrsZ/CMjDacOb5FMpRVRx90L8raCa/9sXKYAB3RKK
	a3ZDze1AD3VkgxaovQPZYmCXHAMP86NESheytU6dw6INm/gsUcAB4k7NvkdxE+cmTIarv1
	Of6CWJWl32KTppDTmUCtEURAGUPuJYA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-SD3MvwL6PoWLgsvGYJ6o_w-1; Wed,
 20 Aug 2025 01:37:05 -0400
X-MC-Unique: SD3MvwL6PoWLgsvGYJ6o_w-1
X-Mimecast-MFC-AGG-ID: SD3MvwL6PoWLgsvGYJ6o_w_1755668223
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 54F0C1956079;
	Wed, 20 Aug 2025 05:37:03 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.99])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2ED4819560B0;
	Wed, 20 Aug 2025 05:36:54 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-mm@kvack.org
Cc: ryabinin.a.a@gmail.com,
	andreyknvl@gmail.com,
	glider@google.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	akpm@linux-foundation.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	sj@kernel.org,
	lorenzo.stoakes@oracle.com,
	elver@google.com,
	snovitoll@gmail.com,
	christophe.leroy@csgroup.eu,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 12/12] mm/kasan: make kasan=on|off take effect for all three modes
Date: Wed, 20 Aug 2025 13:34:59 +0800
Message-ID: <20250820053459.164825-13-bhe@redhat.com>
In-Reply-To: <20250820053459.164825-1-bhe@redhat.com>
References: <20250820053459.164825-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Now everything is ready, set kasan=off can disable kasan for all
three modes.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 include/linux/kasan-enabled.h | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
index 32f2d19f599f..21b6233f829c 100644
--- a/include/linux/kasan-enabled.h
+++ b/include/linux/kasan-enabled.h
@@ -4,34 +4,32 @@
 
 #include <linux/static_key.h>
 
+#ifdef CONFIG_KASAN
 extern bool kasan_arg_disabled;
 
 DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
 
-#ifdef CONFIG_KASAN_HW_TAGS
-
 static __always_inline bool kasan_enabled(void)
 {
 	return static_branch_likely(&kasan_flag_enabled);
 }
+#else /* CONFIG_KASAN */
+static inline bool kasan_enabled(void)
+{
+	return false;
+}
+#endif
 
+#ifdef CONFIG_KASAN_HW_TAGS
 static inline bool kasan_hw_tags_enabled(void)
 {
 	return kasan_enabled();
 }
-
 #else /* CONFIG_KASAN_HW_TAGS */
-
-static inline bool kasan_enabled(void)
-{
-	return IS_ENABLED(CONFIG_KASAN);
-}
-
 static inline bool kasan_hw_tags_enabled(void)
 {
 	return false;
 }
-
 #endif /* CONFIG_KASAN_HW_TAGS */
 
 #endif /* LINUX_KASAN_ENABLED_H */
-- 
2.41.0


