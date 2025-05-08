Return-Path: <linux-kernel+bounces-640320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BACFAB033B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 20:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC04717D891
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 18:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C84288522;
	Thu,  8 May 2025 18:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eyu4duNB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845BB288526
	for <linux-kernel@vger.kernel.org>; Thu,  8 May 2025 18:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746730186; cv=none; b=hUqw8KNoCRzmQqmb1d8P4Zqga1X5WH9mgNkXiJrjYt9Ot0XLIuvtyUOwuNr00i1phucpPbDRxd9bPaZSLOckspIfv0GOP5iER+w0MF1O/C92x4eerv9RdsS6+9dcfSCEVPho/Az+oQnGu8iCKjgG1YIgGLQikWiU6TSGh3jm3qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746730186; c=relaxed/simple;
	bh=2z/dxejO94BxmJj7FeoGNO2eZMUhyKNlr+XjgI51RNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7Lk9QdjmbxH6hnkO+fdY/tCLmYDH4ZjRGx93Cw01aGaTG1r10P3apOtAuBX7peiQBccCl2kSZkqCDgzp4UOLWRYuHVRX3XwdiMMZ3l/cQQFJsLbQw4w3SEHTbfUqWCKSpZpRLd6B9nfImloeh3MbQQc2ZqbSWMPbN/gXknVVsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eyu4duNB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746730183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l6pMU7QkTWIW4OAQj6rirBqLPufuFwpOPXFuk1c/9tI=;
	b=Eyu4duNBSWw5aB05gu9E0RRwd/3Ow+juQuFBRWW6gi46gbZtZB+tymqjWj4wJ4g5+tnpZ8
	WFBaEpkUR6KuQ0v/vjcaKf9fxcsBo/jn4ku6mF/pqx888yvY/aVMed1vb4Hrcsjms3ZqBO
	z9KNl6Dwg70aRZfz5GDhrhzdu19LXcg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-f_o_LZ7oNpGdO3M23gL_3Q-1; Thu,
 08 May 2025 14:49:40 -0400
X-MC-Unique: f_o_LZ7oNpGdO3M23gL_3Q-1
X-Mimecast-MFC-AGG-ID: f_o_LZ7oNpGdO3M23gL_3Q_1746730179
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B089E19560AB;
	Thu,  8 May 2025 18:49:38 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.242])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C0A901800359;
	Thu,  8 May 2025 18:49:36 +0000 (UTC)
From: Joel Savitz <jsavitz@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Joel Savitz <jsavitz@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	cgroups@vger.kernel.org
Subject: [PATCH v2 2/2] include/cgroup: separate {get,put}_cgroup_ns no-op case
Date: Thu,  8 May 2025 14:49:30 -0400
Message-ID: <20250508184930.183040-3-jsavitz@redhat.com>
In-Reply-To: <20250508184930.183040-1-jsavitz@redhat.com>
References: <20250508184930.183040-1-jsavitz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

When CONFIG_CGROUPS is not selected, {get,put}_cgroup_ns become no-ops
and therefore it is not necessary to compile in the code for changing
the reference count.

When CONFIG_CGROUP is selected, there is no valid case where
either of {get,put}_cgroup_ns() will be called with a NULL argument.

Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 include/linux/cgroup.h | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index e7da3c3b098b..166d6de50dbf 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -785,6 +785,17 @@ struct cgroup_namespace *copy_cgroup_ns(unsigned long flags,
 int cgroup_path_ns(struct cgroup *cgrp, char *buf, size_t buflen,
 		   struct cgroup_namespace *ns);
 
+static inline void get_cgroup_ns(struct cgroup_namespace *ns)
+{
+	refcount_inc(&ns->ns.count);
+}
+
+static inline void put_cgroup_ns(struct cgroup_namespace *ns)
+{
+	if (refcount_dec_and_test(&ns->ns.count))
+		free_cgroup_ns(ns);
+}
+
 #else /* !CONFIG_CGROUPS */
 
 static inline void free_cgroup_ns(struct cgroup_namespace *ns) { }
@@ -795,19 +806,10 @@ copy_cgroup_ns(unsigned long flags, struct user_namespace *user_ns,
 	return old_ns;
 }
 
-#endif /* !CONFIG_CGROUPS */
+static inline void get_cgroup_ns(struct cgroup_namespace *ns) { }
+static inline void put_cgroup_ns(struct cgroup_namespace *ns) { }
 
-static inline void get_cgroup_ns(struct cgroup_namespace *ns)
-{
-	if (ns)
-		refcount_inc(&ns->ns.count);
-}
-
-static inline void put_cgroup_ns(struct cgroup_namespace *ns)
-{
-	if (ns && refcount_dec_and_test(&ns->ns.count))
-		free_cgroup_ns(ns);
-}
+#endif /* !CONFIG_CGROUPS */
 
 #ifdef CONFIG_CGROUPS
 
-- 
2.45.2


