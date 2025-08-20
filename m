Return-Path: <linux-kernel+bounces-776973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62380B2D3AC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51BF117CAA8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 05:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239532BD01B;
	Wed, 20 Aug 2025 05:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gPdTm5lz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4952BDC33
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 05:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755668203; cv=none; b=afyGGW5rrieSGUsDvYD8lUVT9NLMW76b7EMW/Z9BtITFikF+hwqSHA5Xe8zVNdTRFnhBNr5yPoUl4vIPoaSxJuZIyYNgXBs8FiJh2GQUpnAfjG1TY7b9DtzqFy9UWz/YK7bUZlQRUES20Y2NYpKBLJ/EiChbcRMWQ47o1x35kVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755668203; c=relaxed/simple;
	bh=x7/e/H3t3Nz+bdN9Mynvya1xVS6El/mgPHYB1LdAHec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=QvqQIfL83+YD1sLHPsH7123h+8vOasv5O/0glEPZ69EIvY6rBudGfPQXOHmfspbI2B9FQcnhVYGsWuBaH5mIyFFtRGQmYUUI4Gtvqx2wxBFxRuK4wP+rFKuYU5oD0DIqEs8HyXq+rfipek28nAfIv+MdaKhaaxuRlGxu/Q5gDfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gPdTm5lz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755668199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iAEMFQ7UJQsp/YRWJnDzAESQXUNpKqSpnHshmUmLX+c=;
	b=gPdTm5lzBAQ5uEAk45iYhvkef2Z1amasqGVDVuPASqY1lveeNxSjIyvlQ8XMqdpsZA4m7G
	ZzThMf3YkWO9J4kVx4HX4B21qJor4l6K/9nfUVwwYBz8Yqo9XyxSSCUJ/x/LYH/hz+mtUf
	mA8rO9Bf9CsAhs7KfxNzkjOqLZjbmik=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-ua7zccu4OLWU2rQ3gWmgQw-1; Wed,
 20 Aug 2025 01:36:36 -0400
X-MC-Unique: ua7zccu4OLWU2rQ3gWmgQw-1
X-Mimecast-MFC-AGG-ID: ua7zccu4OLWU2rQ3gWmgQw_1755668194
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E7C12180034B;
	Wed, 20 Aug 2025 05:36:33 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.99])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 712EF19560B0;
	Wed, 20 Aug 2025 05:36:25 +0000 (UTC)
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
	Baoquan He <bhe@redhat.com>,
	x86@kernel.org
Subject: [PATCH v3 09/12] arch/x86: don't initialize kasan if it's disabled
Date: Wed, 20 Aug 2025 13:34:56 +0800
Message-ID: <20250820053459.164825-10-bhe@redhat.com>
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

And also add code to enable kasan_flag_enabled, this is for later
usage.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: x86@kernel.org
---
 arch/x86/mm/kasan_init_64.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index 0539efd0d216..0f2f9311e9df 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -343,6 +343,9 @@ void __init kasan_init(void)
 	unsigned long shadow_cea_begin, shadow_cea_per_cpu_begin, shadow_cea_end;
 	int i;
 
+	if (kasan_arg_disabled)
+		return;
+
 	memcpy(early_top_pgt, init_top_pgt, sizeof(early_top_pgt));
 
 	/*
@@ -450,6 +453,9 @@ void __init kasan_init(void)
 	/* Flush TLBs again to be sure that write protection applied. */
 	__flush_tlb_all();
 
+	/* KASAN is now initialized, enable it. */
+	static_branch_enable(&kasan_flag_enabled);
+
 	init_task.kasan_depth = 0;
 	pr_info("KernelAddressSanitizer initialized\n");
 }
-- 
2.41.0


