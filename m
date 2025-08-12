Return-Path: <linux-kernel+bounces-764792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF6FB22763
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 450BD50777A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814A125DCE0;
	Tue, 12 Aug 2025 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R1OCAqUD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B85B2586DA
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 12:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003025; cv=none; b=Wv8nk8mD1S+UHF6eLjLiplU5F9KnJ1bQaQwbBND/dOjNf3zzFI2g45QNEhYw0VGXbgwdyb1PH5R+HI73IcGsx/rTDg9brFXjjtO7sgLLW1IxwLpuoYNrE1FP7wUfL/NfSNvPMmIyPzxTikaTnFbC4TP72+Ynv29XSsotFcG4tBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003025; c=relaxed/simple;
	bh=YgopKzfR0IJfsyEXF1E1nafRos8bsFb6WfDl5GYGKuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=YB4gpjrZou3LRHOWfGS4ZxqqaF9In0XL1N9ss7u+rRKSZ4cRJqgWAPEi+Nc7Z0411vWQ/wmGSPXJoMNGiENICOLbP2XU3/7WiqOsAUqFCqIGr4p8Gdvvyzy44sd7iwzqfPaDgEF88r+wSYCWtGTAyGhf7+OD05nqxLTEgNVPUq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R1OCAqUD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755003022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lC7gxKLfCffY1/zE+RJo3yBumyZwu5V9Ft7avRiVVTY=;
	b=R1OCAqUDAX6ChlH1eY+OJRAcKmDOPB0v3Pk9JfuBuNd9wwkze4EV6KaP6Rct8xPxlOVBVj
	Q775aumDc3M+s6ohCeetcAACs40Kd95kap6kx4ZBHSHAyV1VGAZH8cns82QTT9O3GrPtpP
	zMMz6XYShHUCHAFrj3j8WlJeTid174Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-Ahe-8VyWPdGdPbA0pY0ufQ-1; Tue,
 12 Aug 2025 08:50:17 -0400
X-MC-Unique: Ahe-8VyWPdGdPbA0pY0ufQ-1
X-Mimecast-MFC-AGG-ID: Ahe-8VyWPdGdPbA0pY0ufQ_1755003015
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F3E78195608E;
	Tue, 12 Aug 2025 12:50:14 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.156])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 173963001458;
	Tue, 12 Aug 2025 12:50:07 +0000 (UTC)
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
Subject: [PATCH v2 03/12] mm/kasan/sw_tags: don't initialize kasan if it's disabled
Date: Tue, 12 Aug 2025 20:49:32 +0800
Message-ID: <20250812124941.69508-4-bhe@redhat.com>
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
usage.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/kasan/sw_tags.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
index 01f19bc4a326..dd963ba4d143 100644
--- a/mm/kasan/sw_tags.c
+++ b/mm/kasan/sw_tags.c
@@ -40,11 +40,17 @@ void __init kasan_init_sw_tags(void)
 {
 	int cpu;
 
+	if (kasan_arg_disabled)
+		return;
+
 	for_each_possible_cpu(cpu)
 		per_cpu(prng_state, cpu) = (u32)get_cycles();
 
 	kasan_init_tags();
 
+	/* KASAN is now initialized, enable it. */
+	static_branch_enable(&kasan_flag_enabled);
+
 	pr_info("KernelAddressSanitizer initialized (sw-tags, stacktrace=%s)\n",
 		str_on_off(kasan_stack_collection_enabled()));
 }
-- 
2.41.0


