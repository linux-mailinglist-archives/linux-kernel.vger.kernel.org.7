Return-Path: <linux-kernel+bounces-776966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E85B2D38F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4F566282A9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 05:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CBF29C327;
	Wed, 20 Aug 2025 05:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bjW5uPIB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8DD29ACFC
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 05:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755668150; cv=none; b=nUXNB3UqMlPmJLlKyO6Kw/iDk9u1rYyIylmtNcJwwtWk+7auXjKU1UFsbQIYpzRmftZOa5Bf30dxtMRoDBrztuqnAe6vJOLf+8t9gMUqa56Lwq7QRERvlqtn5CH61HfWRtpzNRZjbh8q8D4/GRGJXvY91Xhjevqyl99U2Cf3nvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755668150; c=relaxed/simple;
	bh=YgopKzfR0IJfsyEXF1E1nafRos8bsFb6WfDl5GYGKuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=PI4G89sSOhBhYaR+XExpkCiInirjvrO7mMaaRGLU9FOYVy7/kV26sY2LVQrWlN1GHMjOEIcJ6P05Imx+y6jD9sOtLeFDN/3h5ROtmpFqZCDctVUKm+2SIRxXsGIlfo8EZS635Qkc/Ji/vOk9rVjv3VtMECaqJn+4WKlRPs5botM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bjW5uPIB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755668147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lC7gxKLfCffY1/zE+RJo3yBumyZwu5V9Ft7avRiVVTY=;
	b=bjW5uPIBiR4bX9pUlJOHPjh899t6QWLhLkO5+zw1cw/qucaeVegZSV6kAl1+8pK/0TJCcz
	Jr0QZXScOkJLvdQfiQu+MqXCtATPRfJolw1HdeaJn2D6ioY5M5kIv5qGtcgXXHvVDw3pst
	ZGJ6loTk8YWJ/SoMlejhRx0UzHXX66g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-6LzTzuBZPxSmLJLuVYPWIw-1; Wed,
 20 Aug 2025 01:35:41 -0400
X-MC-Unique: 6LzTzuBZPxSmLJLuVYPWIw-1
X-Mimecast-MFC-AGG-ID: 6LzTzuBZPxSmLJLuVYPWIw_1755668139
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4AE39195422A;
	Wed, 20 Aug 2025 05:35:39 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.99])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9FD9E19560B0;
	Wed, 20 Aug 2025 05:35:29 +0000 (UTC)
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
Subject: [PATCH v3 03/12] mm/kasan/sw_tags: don't initialize kasan if it's disabled
Date: Wed, 20 Aug 2025 13:34:50 +0800
Message-ID: <20250820053459.164825-4-bhe@redhat.com>
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


