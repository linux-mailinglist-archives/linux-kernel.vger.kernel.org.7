Return-Path: <linux-kernel+bounces-871877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FF9C0EB05
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 692E0460B57
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE33630AD0B;
	Mon, 27 Oct 2025 14:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WSWxiXtI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BE82C235A
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576548; cv=none; b=W/fUTbEXSahJSh0OEwcQikr1FyFXvfLkfUjOJHtUjdTb5MnSBeXmZIMJ898AbD5OJqZX7BaQLIFNQDG3fxpipkHgzwoncB6Tq0ESUJ9XhUcwUT7EBlqIZwRw2NRKpbUJ22QZJuwbvsNd1HuxM016VcYEM1+BdzB71xx75mlAgUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576548; c=relaxed/simple;
	bh=E4UmDRrfK427SBmAu3QgG9274GYyOCRnkLTnbkQSZ48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKVgvVA7dQfG4qa09ls9FchsL4bGdA4IEVYlgyURDp3fmCwHn+mzJYXC+KkdFIwhwajK2pHghKlKUm8sxFx7Ck3KbY4NJiycbXh+MyDgvEO85C1zDt2vKg91szkf0KiLdSaN/obxukKvITa/iNqQv0N2jdyG3tKFqCr0quVY0Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WSWxiXtI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761576545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z8kAhx3O+cWF32TZgKmRfF3DYFNfvgUR9bkHyjA8PvA=;
	b=WSWxiXtI9AXZ75wNw4HzsLZS/e1ykYkwH4HtJOl8zGLPnVlZTkBhfI41IInjsmPfc7QzLK
	w8xEchsx5ay1N75gyilFHseL3iEhihpVed7S5RcYkLmB8lysZ5GlLBnXGLu/ngrqYrNPcf
	94uE03K2eqXfEohcquGRduKQHm1jsC0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-6oaRRRBXNY-BuMGr1MHJvw-1; Mon,
 27 Oct 2025 10:49:02 -0400
X-MC-Unique: 6oaRRRBXNY-BuMGr1MHJvw-1
X-Mimecast-MFC-AGG-ID: 6oaRRRBXNY-BuMGr1MHJvw_1761576541
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ECA791954102;
	Mon, 27 Oct 2025 14:49:00 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CFA0F1955F1B;
	Mon, 27 Oct 2025 14:48:57 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v2 6/7] Documentation/rtla: Rename sample/ to example/
Date: Mon, 27 Oct 2025 15:48:18 +0100
Message-ID: <20251027144819.1034041-7-tglozar@redhat.com>
In-Reply-To: <20251027144819.1034041-1-tglozar@redhat.com>
References: <20251027144819.1034041-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The sample/ directory in tools/tracing/rtla was renamed to example/ in
an earlier commit.

Rename it also in the documentation.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 Documentation/tools/rtla/common_timerlat_options.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/tools/rtla/common_timerlat_options.rst b/Documentation/tools/rtla/common_timerlat_options.rst
index 1f5d024b53aa..c6046fcf52dc 100644
--- a/Documentation/tools/rtla/common_timerlat_options.rst
+++ b/Documentation/tools/rtla/common_timerlat_options.rst
@@ -64,4 +64,4 @@
 
         Set timerlat to run without workload, waiting for the user to dispatch a per-cpu
         task that waits for a new period on the tracing/osnoise/per_cpu/cpu$ID/timerlat_fd.
-        See linux/tools/rtla/sample/timerlat_load.py for an example of user-load code.
+        See linux/tools/rtla/example/timerlat_load.py for an example of user-load code.
-- 
2.51.0


