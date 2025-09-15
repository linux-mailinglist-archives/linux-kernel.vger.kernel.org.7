Return-Path: <linux-kernel+bounces-817256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C13CB57FE6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F321A27692
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD05227586;
	Mon, 15 Sep 2025 15:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jV43ZEqs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA21F340DB3
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948429; cv=none; b=ejSAf7ljQ/V/iWIZeGB4s+hIZ3YQyjM/u90aGGsbo198853nlBe8raeYgBkZz7jnpnpOLWmeeJHwIeMC4NARVCRpiHldBFlZfiKvOoo+YdLpw6IJVdFUAxIx5re+17F5gXmF63iT7Vs7FlZr/kL8bFsjlgxlNUi7rWu1UXlCGVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948429; c=relaxed/simple;
	bh=DAEJnz1PYrrsRnE2T7/7GUldQyKxaAsfp+XTjj5m3Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g0lX/QSBJ2Rfjxarvbtfy0HGay2dM3IKMqSEJR0I27phuQmEJhhcouX4cDArLqwivaY4NVHWb7OjqqxiQ4/p8aXD89pDCOQLtw3GoWYXSr29QeLRn1pPVsQSykNoRdqxtj65NOf8LKo48pQPmOIJQviLmnQfiJLOLHiQAcm/ZH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jV43ZEqs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757948426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Glcz1Zqa3Xm+SpxWCco2Yz++SUVZfeI6p0+BeU5K0tE=;
	b=jV43ZEqs1iSkpg8GYAzoHduaC1GEKoS49iVd3Sih1bBs2tenxFrAYkyVdW8RVTsxoWs+j/
	wei2vl+7XyAazpNdv+1T7iWSdFUY0lpM1w/djOyw6cFEkWb39hMXwjBrW+MrjPpiO7ytEa
	HCCxMxgFAa3r93p1yVd5Aa6OIAjOkt4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-dHz9H-g8MKik48a7PXRIbQ-1; Mon,
 15 Sep 2025 11:00:24 -0400
X-MC-Unique: dHz9H-g8MKik48a7PXRIbQ-1
X-Mimecast-MFC-AGG-ID: dHz9H-g8MKik48a7PXRIbQ_1757948423
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E70AF180057E;
	Mon, 15 Sep 2025 15:00:22 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.63])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5EEF1180044F;
	Mon, 15 Sep 2025 15:00:20 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v12 8/9] cpumask: Add initialiser CPUMASK_NULL to use cleanup helpers
Date: Mon, 15 Sep 2025 16:59:29 +0200
Message-ID: <20250915145920.140180-19-gmonaco@redhat.com>
In-Reply-To: <20250915145920.140180-11-gmonaco@redhat.com>
References: <20250915145920.140180-11-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The cleanup helper __free(free_cpumask_var) works only if the function
returns after alloc_cpumask_var, this can complicate the code in case
there are multiple cpumasks using the cleanup helper.

Define a cpumask initialiser that is NULL if the cpumask is a pointer
and {} if it's on stack. This allows users of the cleanup helper to use
it freely on initialised cpumasks as the actual free will be called only
if the mask is not NULL (and of course if it's a pointer).

This solution was first used in [1], dropped as eventually a single mask
was sufficient.

[1] - https://lore.kernel.org/lkml/20240120025053.684838-8-yury.norov@gmail.com

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/linux/cpumask.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index ff8f41ab7ce6..5fb9c3fe4256 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -1005,6 +1005,7 @@ static __always_inline unsigned int cpumask_size(void)
 
 #define this_cpu_cpumask_var_ptr(x)	this_cpu_read(x)
 #define __cpumask_var_read_mostly	__read_mostly
+#define CPUMASK_NULL			NULL
 
 bool alloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags, int node);
 
@@ -1051,6 +1052,7 @@ static __always_inline bool cpumask_available(cpumask_var_t mask)
 
 #define this_cpu_cpumask_var_ptr(x) this_cpu_ptr(x)
 #define __cpumask_var_read_mostly
+#define CPUMASK_NULL {}
 
 static __always_inline bool alloc_cpumask_var(cpumask_var_t *mask, gfp_t flags)
 {
-- 
2.51.0


