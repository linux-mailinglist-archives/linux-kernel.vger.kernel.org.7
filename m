Return-Path: <linux-kernel+bounces-801331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33484B443CA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEADC16EC53
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FBF2FB624;
	Thu,  4 Sep 2025 16:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T3ol7o3g"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867AF2F3C0C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 16:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757005173; cv=none; b=QmO/hHko9RQGcCtaRZarTjL4jJEISfRBA0ypUYlGaBm6uaxtK2a29GE1RnlF2wtgAjT/bzsjnceD6b2VlZgN8wD3f3QEIOmfOPkbPhFwrk0i0zwVblsNFZZoCSSAeDB2p0dNvld9NRgdu5dcYlYWClQ4lXKq5Dc+XWmG+KvOcrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757005173; c=relaxed/simple;
	bh=GwGa1VVBJOYX6Cuh5Z3rjCzdVbbjZ7uaala3loTkIO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VYUJuDZFVYERzba8LrHvGJHsgDxnEuG8RHYhTXbDOKnfO4EHczwkohMxCMCQ0o1w5SH2+4tUsUGzCTlc0JGg/c+2PolZyT+GhdtOGllRZcfiPY8Ij94sytRZKosP2PclnzfH+udG9n47ump4h+/E3QXVjYURrQ943cX5f5y9V8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T3ol7o3g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757005170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lXvCrt+DTTQMf7tnGktkXK8dIlODkW2gH3Cn4in8KJk=;
	b=T3ol7o3gOXL2sIYsEmR/Ac7jd5KpJ1nmeH5zBy5fV2sDp5cmEmYhPmT/LYvrngrkUQdYmF
	58cjZgrGp8eXisxs+7biBdT0OaM9BeVYS2T795t72mJW9Ti/tSJeubOho027CQ6JFF8n+A
	52VzHzTllCgSDtzCigF544sq4JtboMA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-157-qktPnUO2N3aKwQ0BmKt3UA-1; Thu,
 04 Sep 2025 12:59:27 -0400
X-MC-Unique: qktPnUO2N3aKwQ0BmKt3UA-1
X-Mimecast-MFC-AGG-ID: qktPnUO2N3aKwQ0BmKt3UA_1757005166
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0BBB018002C1;
	Thu,  4 Sep 2025 16:59:26 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.42])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9005B3002D27;
	Thu,  4 Sep 2025 16:59:23 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: [PATCH v1] audit: merge loops in __audit_inode_child()
Date: Thu,  4 Sep 2025 13:59:19 -0300
Message-ID: <20250904165919.3362000-1-rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Whenever there's audit context, __audit_inode_child() gets called
numerous times, which can lead to high latency in scenarios that
create too many sysfs/debugfs entries at once, for instance, upon
device_add_disk() invocation.

   # uname -r
   6.17.0-rc3+

   # auditctl -a always,exit -F path=/tmp -k foo
   # time insmod loop max_loop=1000
   real 0m42.753s
   user 0m0.000s
   sys  0m42.494s

   # perf record -a insmod loop max_loop=1000
   # perf report --stdio |grep __audit_inode_child
   37.95%  insmod  [kernel.kallsyms]  [k] __audit_inode_child

__audit_inode_child() searches for both the parent and the child
in two different loops that iterate over the same list. This
process can be optimized by merging these into a single loop,
without changing the function behavior or affecting the code's
readability.

This patch merges the two loops that walk through the list
context->names_list into a single loop. This optimization resulted
in around 54% performance enhancement for the benchmark.

   # uname -r
   6.17.0-rc3+-enhanced

   # auditctl -a always,exit -F path=/tmp -k foo
   # time insmod loop max_loop=1000
   real 0m19.388s
   user 0m0.000s
   sys  0m19.149s

Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 kernel/auditsc.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index eb98cd6fe91f..7abfb68687fb 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2437,44 +2437,40 @@ void __audit_inode_child(struct inode *parent,
 	if (inode)
 		handle_one(inode);
 
-	/* look for a parent entry first */
 	list_for_each_entry(n, &context->names_list, list) {
-		if (!n->name ||
-		    (n->type != AUDIT_TYPE_PARENT &&
-		     n->type != AUDIT_TYPE_UNKNOWN))
+		/* can only match entries that have a name */
+		if (!n->name)
 			continue;
 
-		if (n->ino == parent->i_ino && n->dev == parent->i_sb->s_dev &&
-		    !audit_compare_dname_path(dname,
-					      n->name->name, n->name_len)) {
+		/* look for a parent entry first */
+		if (!found_parent &&
+		    (n->type == AUDIT_TYPE_PARENT || n->type == AUDIT_TYPE_UNKNOWN) &&
+		    (n->ino == parent->i_ino && n->dev == parent->i_sb->s_dev &&
+		     !audit_compare_dname_path(dname, n->name->name, n->name_len))) {
 			if (n->type == AUDIT_TYPE_UNKNOWN)
 				n->type = AUDIT_TYPE_PARENT;
 			found_parent = n;
-			break;
 		}
-	}
 
-	cond_resched();
-
-	/* is there a matching child entry? */
-	list_for_each_entry(n, &context->names_list, list) {
-		/* can only match entries that have a name */
-		if (!n->name ||
-		    (n->type != type && n->type != AUDIT_TYPE_UNKNOWN))
-			continue;
-
-		if (!strcmp(dname->name, n->name->name) ||
-		    !audit_compare_dname_path(dname, n->name->name,
+		/* is there a matching child entry? */
+		if (!found_child &&
+		    (n->type == type || n->type == AUDIT_TYPE_UNKNOWN) &&
+		    (!strcmp(dname->name, n->name->name) ||
+		     !audit_compare_dname_path(dname, n->name->name,
 						found_parent ?
 						found_parent->name_len :
-						AUDIT_NAME_FULL)) {
+						AUDIT_NAME_FULL))) {
 			if (n->type == AUDIT_TYPE_UNKNOWN)
 				n->type = type;
 			found_child = n;
-			break;
 		}
+
+		if (found_parent && found_child)
+			break;
 	}
 
+	cond_resched();
+
 	if (!found_parent) {
 		/* create a new, "anonymous" parent record */
 		n = audit_alloc_name(context, AUDIT_TYPE_PARENT);
-- 
2.51.0


