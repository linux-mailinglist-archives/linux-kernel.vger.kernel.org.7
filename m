Return-Path: <linux-kernel+bounces-776968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7691AB2D39C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 128FB1C280C3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 05:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40FF29E105;
	Wed, 20 Aug 2025 05:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQpyXpXI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46C4280312
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 05:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755668168; cv=none; b=WTwFjYY2gzY7DhSH+4UWSHiGfPNNazPza1GQbTOnGnxuCPdJesGJK1/jkWl0fa26nQgXEhvSDi1yeE5cq/K/ik1qjed+ozdOAgDN0itnSZ5mmIkiLDlrSXl4DhgjL0YrTOWgqTMC9/Zp5i24A2THrqvpc1gkLbdci4o9uiccNM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755668168; c=relaxed/simple;
	bh=Ha4cG8e+lmVLPwK0pubt1aRx8Xy2hVzAOdLAnVjJZs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=j1hJ4Tc7NcxJcdiHllpdyaGY+KI3JOleG+HSu1zWOcnHgsjWOdMqkqp2JlXKC7NjwfvBOkBEsNjpfZhLSsykSFuOqq88HLwaASNjBdCMfBjsMmMxYQMY2bHg+YvCwT5fleHr5Z7kMO7EFnHhaPMkfkbP4wxRW9Qt/pNQb3AvBWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NQpyXpXI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755668166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oS87V1n70KnlvoMP4fCQ/ERdyh1R0fC3CtG4IQhVRyE=;
	b=NQpyXpXIuo4gb+nLrA2gyx7cMKaPDfOW1K5Q3Bj+aVUXS7VwtZufAU3y512QD6/A9vYpoV
	Ike1vEw5Gyw9orKdqwbywFiYUQLMwLClCg6nUHqBYHqf2IgWkdVcbvzyT0YOZF5anmNQrf
	PGsa+yP5M6okFdJdyrVmBkG0YK/i2tY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-NwZMdlajPhyC9_mbi6VafA-1; Wed,
 20 Aug 2025 01:36:00 -0400
X-MC-Unique: NwZMdlajPhyC9_mbi6VafA-1
X-Mimecast-MFC-AGG-ID: NwZMdlajPhyC9_mbi6VafA_1755668158
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84A5019775AF;
	Wed, 20 Aug 2025 05:35:58 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.99])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2B42719560B2;
	Wed, 20 Aug 2025 05:35:49 +0000 (UTC)
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
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 05/12] arch/arm64: don't initialize kasan if it's disabled
Date: Wed, 20 Aug 2025 13:34:52 +0800
Message-ID: <20250820053459.164825-6-bhe@redhat.com>
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

And also need skip kasan_populate_early_vm_area_shadow() if kasan
is disabled.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/mm/kasan_init.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index d541ce45daeb..0e4ffe3f5d0e 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -384,6 +384,9 @@ void __init kasan_populate_early_vm_area_shadow(void *start, unsigned long size)
 {
 	unsigned long shadow_start, shadow_end;
 
+	if (!kasan_enabled())
+		return;
+
 	if (!is_vmalloc_or_module_addr(start))
 		return;
 
@@ -397,6 +400,9 @@ void __init kasan_populate_early_vm_area_shadow(void *start, unsigned long size)
 
 void __init kasan_init(void)
 {
+	if (kasan_arg_disabled)
+		return;
+
 	kasan_init_shadow();
 	kasan_init_depth();
 #if defined(CONFIG_KASAN_GENERIC)
@@ -405,6 +411,7 @@ void __init kasan_init(void)
 	 * Software and Hardware Tag-Based modes still require
 	 * kasan_init_sw_tags() and kasan_init_hw_tags() correspondingly.
 	 */
+	static_branch_enable(&kasan_flag_enabled);
 	pr_info("KernelAddressSanitizer initialized (generic)\n");
 #endif
 }
-- 
2.41.0


