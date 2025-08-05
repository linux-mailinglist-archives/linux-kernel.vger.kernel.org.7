Return-Path: <linux-kernel+bounces-755972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 440CEB1AE36
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 08:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C556A188A98A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 06:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635DA21B9F0;
	Tue,  5 Aug 2025 06:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fzNTvYIT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5232521CA0E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 06:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754375054; cv=none; b=b+XHdLncBnNo6iaU4yAgfjuvdJ94Rx5YOJAi5/oz7okFkl6ULaRVW6i3OPmu9xAAYtWdlJ/rrnBQnS+mb/gghMNnXbRCpwyKrDFfgYDrPKt87tLvFu+h3WS5h/NCft4Q4d/dPw6J38yEeeYnbr4P6KV4/Sp2rKGCdzGsgxFZ6AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754375054; c=relaxed/simple;
	bh=RDZ+lfeK7bnVLFbpItWQCYl5cJqk0fDJcJjg/NnHjco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=G4CpgsN6y4kH8FZffD+syBoBWD8w1/CFFG9fzwXFagTpGIB2s2fMYtBhRJwiFONYGuOCqkEqQ2zSUUDYFaytHIusvfUH9aI+ccmPWGTnY02N756sDXZ2zPjCojw6sw10J+va57s/Cc3tWzrVLtRwR4Tx5oMFQzfOuSRsXbBU1o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fzNTvYIT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754375052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kJO5yIBXXOgt25+uyQhOeCpPCqEaTDSwq6fQ38qy9Bc=;
	b=fzNTvYIT93IdC/zd0RW/xFuuxw76MJL6/RnQv73vwe5B7LrnDXrQqH1Lh6Z5vmmy+Wso2b
	3L5uds0a3+MbEuKbak4c42ONdWBPztfu1SNGbEFR0fHTlnWqIxIAQ+flMRs7RhG2aIeGoa
	iHalYMlAXBza8v8+fIu/CUPw9XZoOlQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-178-AR-aqPXUOv6YUb-9IY0KQw-1; Tue,
 05 Aug 2025 02:24:09 -0400
X-MC-Unique: AR-aqPXUOv6YUb-9IY0KQw-1
X-Mimecast-MFC-AGG-ID: AR-aqPXUOv6YUb-9IY0KQw_1754375048
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0AF61800876;
	Tue,  5 Aug 2025 06:24:07 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.136])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6C6CF1956094;
	Tue,  5 Aug 2025 06:24:01 +0000 (UTC)
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
Subject: [PATCH 4/4] mm/kasan: make kasan=on|off take effect for all three modes
Date: Tue,  5 Aug 2025 14:23:33 +0800
Message-ID: <20250805062333.121553-5-bhe@redhat.com>
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

Now everything is ready, set kasan=off can disable kasan for all
three modes.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 include/linux/kasan-enabled.h | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
index 32f2d19f599f..b5857e15ef14 100644
--- a/include/linux/kasan-enabled.h
+++ b/include/linux/kasan-enabled.h
@@ -8,30 +8,21 @@ extern bool kasan_arg_disabled;
 
 DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
 
-#ifdef CONFIG_KASAN_HW_TAGS
-
 static __always_inline bool kasan_enabled(void)
 {
 	return static_branch_likely(&kasan_flag_enabled);
 }
 
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


