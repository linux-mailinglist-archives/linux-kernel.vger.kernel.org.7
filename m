Return-Path: <linux-kernel+bounces-782150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E252EB31BC5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A1C91C84901
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369E830F53E;
	Fri, 22 Aug 2025 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fu3ZL2rL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BA730E836
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 14:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872549; cv=none; b=Qei0iky/uqKFc/CAOXXdF7DlbwWKwYSKWbJRQ+SBkqHvgeF3YTdm1Zn3kste4PBSwj7dxRyd8tYQPWqn7413C2VpZM9J3RWSh6pvfO0Lk2BxU//QX8C8eB56/U7BfYbhLkKfUhpbWAW5c353pi67zX8cq1vaWocBzfEmrv6QlI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872549; c=relaxed/simple;
	bh=ya+/2lywL7BGnBwGQ3T3zHs8dEkBfIpHOA+EH0QGW14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJ9f3p7gZoENVWSpmb4fpDk1ya8JYoTze8eQaU/wBD7bEzVCsROJ4mCQcLZ/ryCgrPukvtTafykBNEbBEe8qKK7Y+YpnoZRsUcbotR1YILqeD4k9FO0zFxoLhUW40HcJL9RqEEJgrc7j8fv6YtNkn7XxSHf4X31iBhcUZUO0aRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fu3ZL2rL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755872546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7vplKdO7OueluSFmo2pcySTxoa/ZLQ49kKhsm4ft+S8=;
	b=Fu3ZL2rLbxQZnVft3xBOwGWQFcdU/nUuYGYpJmcj+LNa/WQGyTfwiAL6dZluhXzc+iZV/a
	Xh3T301T2+cghAl0kGPZKq+Gqd/JWe/Z9ELRmx66iSMnPGYE6VrMasmQ0bOu6qZK9V5xfY
	G3bkEfQPkqJyNPmKbzvPTFJtVa4Y6AU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-25iV1S9KPaidp76cQknsiA-1; Fri,
 22 Aug 2025 10:22:23 -0400
X-MC-Unique: 25iV1S9KPaidp76cQknsiA-1
X-Mimecast-MFC-AGG-ID: 25iV1S9KPaidp76cQknsiA_1755872542
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 764CD1800366;
	Fri, 22 Aug 2025 14:22:22 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.132])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 392F61800447;
	Fri, 22 Aug 2025 14:22:21 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] lib: Fix a couple of potential signed oveflows
Date: Fri, 22 Aug 2025 15:22:08 +0100
Message-ID: <20250822142215.2475014-2-dhowells@redhat.com>
In-Reply-To: <20250822142215.2475014-1-dhowells@redhat.com>
References: <20250822142215.2475014-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Fix keyctl_read_alloc() to check for a potential unsigned overflow when we
allocate a buffer with an extra byte added on the end for a NUL.

Fix keyctl_dh_compute_alloc() for the same thing.

Signed-off-by: David Howells <dhowells@redhat.com>
---
 keyutils.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/keyutils.c b/keyutils.c
index 37b6cc3..fd02cda 100644
--- a/keyutils.c
+++ b/keyutils.c
@@ -18,6 +18,7 @@
 #include <dlfcn.h>
 #include <sys/uio.h>
 #include <errno.h>
+#include <limits.h>
 #include <asm/unistd.h>
 #include "keyutils.h"
 
@@ -442,6 +443,8 @@ int keyctl_read_alloc(key_serial_t id, void **_buffer)
 		return -1;
 
 	for (;;) {
+		if (ret == LONG_MAX)
+			return -EFBIG; /* Don't let buflen+1 overflow. */
 		buflen = ret;
 		buf = malloc(buflen + 1);
 		if (!buf)
@@ -515,6 +518,8 @@ int keyctl_dh_compute_alloc(key_serial_t priv, key_serial_t prime,
 	if (ret < 0)
 		return -1;
 
+	if (ret == LONG_MAX)
+		return -EFBIG; /* Don't let buflen+1 overflow. */
 	buflen = ret;
 	buf = malloc(buflen + 1);
 	if (!buf)


