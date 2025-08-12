Return-Path: <linux-kernel+bounces-764802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A888B2276B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 702F07B5A62
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5DB26D4C1;
	Tue, 12 Aug 2025 12:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQPzvJNh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4817C268C73
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 12:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003085; cv=none; b=cUCFZad4XPDm4fqFnxEux39STe1QzlAXmisl9+7b2a/FakFhZDJKHPf0F7TlG/xO1zCxafBGQXZlZwERUEESO+/xdESMp/O8gcJECkhyvM6ooYiuz6dkGKVhJJw0F09hs8WDQlOGPAm+y6cJnYFbGJMYQ5WppetSRjVkaTQFha0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003085; c=relaxed/simple;
	bh=a6yXnqPO/FQuG+PWl4dLH8XXmB6lxQT2qQpDAHyZpAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=KK1SIqT9tkPoaGqViF6SAIw6YyXH58reYf5XNXSqTy1yAPW8PNf4uKciMV8Z3W86uyXGYdOF90Da6B3nrNLB+MBsa6Z3X1lWYMu7xs1oBKE0rixJh3ZE+ftppwxzYcH1dJt4jaGfCOHWjkpyT3SU0kyk/hkS9GFn9NDcX0woUqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dQPzvJNh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755003083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UNvwjh3bkLYd7LcWTIY96phbAPIdD7DxmW/f2AxTNdM=;
	b=dQPzvJNhtCuYVtDztPmnUYhtLcVAk7rDAMTiSwzVPZPtt04jdjvGDs72EPAJnHPbP/0pGA
	kHGVbNcPuQsgHj2DNxXXZrUbwJ6K9uD31r4uH4GutNG4To7blOrO7dzO1Gxw657beBvZqK
	je7JZkr6n5rXIqWw1QinyfkawOMxO4o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-BarAkwZZPNi3t3OI2JjPPg-1; Tue,
 12 Aug 2025 08:51:17 -0400
X-MC-Unique: BarAkwZZPNi3t3OI2JjPPg-1
X-Mimecast-MFC-AGG-ID: BarAkwZZPNi3t3OI2JjPPg_1755003075
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A2E81800352;
	Tue, 12 Aug 2025 12:51:15 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.156])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8EAE530001A1;
	Tue, 12 Aug 2025 12:51:08 +0000 (UTC)
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
	sj@kernel.org,
	lorenzo.stoakes@oracle.com,
	elver@google.com,
	snovitoll@gmail.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 11/12] arch/um: don't initialize kasan if it's disabled
Date: Tue, 12 Aug 2025 20:49:40 +0800
Message-ID: <20250812124941.69508-12-bhe@redhat.com>
In-Reply-To: <20250812124941.69508-1-bhe@redhat.com>
References: <20250812124941.69508-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

And also add code to enable kasan_flag_enabled, this is for later
usage. Since kasan_init() is called before main(), enabling
kasan_flag_enabled is done in arch_mm_preinit() which is after
jump_label_init() invocation.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/um/kernel/mem.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 76bec7de81b5..392a23d4ef96 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -26,6 +26,9 @@
 int kasan_um_is_ready;
 void kasan_init(void)
 {
+
+	if (kasan_arg_disabled)
+		return;
 	/*
 	 * kasan_map_memory will map all of the required address space and
 	 * the host machine will allocate physical memory as necessary.
@@ -58,6 +61,9 @@ static unsigned long brk_end;
 
 void __init arch_mm_preinit(void)
 {
+	/* Safe to call after jump_label_init(). Enables KASAN. */
+	static_branch_enable(&kasan_flag_enabled);
+
 	/* clear the zero-page */
 	memset(empty_zero_page, 0, PAGE_SIZE);
 
-- 
2.41.0


