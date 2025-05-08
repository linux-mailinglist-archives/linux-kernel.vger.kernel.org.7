Return-Path: <linux-kernel+bounces-640319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCEDAB0339
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 20:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF1164E09B9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 18:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86A62882AC;
	Thu,  8 May 2025 18:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RseYxYIN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E67F279330
	for <linux-kernel@vger.kernel.org>; Thu,  8 May 2025 18:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746730182; cv=none; b=nKuX1lPRJz/03aVl07puTH4yL27UpqUttiOYCHqdBAm0Z3jqCa8+6SQ+ejKmxoA/8lhTAshAG08ozzJlu6BBmMvQ4Up7Tv9WveKGZIhBlw93idLDsReplLBsxD/EvsqSCVVzzsGRvHF54Ojurqvx/a22gXdvEEPqBHLS8Mxvus4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746730182; c=relaxed/simple;
	bh=EtAlIztMCJMKEhEt9QVGu3WJmhvR9BRPlatOT3QW0Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gj2ncEDj4q+Ta/o/7pdda+kuDWUR94fElmJzc1fZHMyeZbbQZ5NkTf9JTB7nEA6rPsHFBvll/elHBGrO2VCtQVYB2MpVCIW5hSq2yFSq2DKsgMHTA3hSGLdlYoNYHynel3PYwqgyf4L+Pik6fy38TAdSZ4Ikq+UWFwBZqr413vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RseYxYIN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746730179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5lMNNiVMCGTW+5fQgycNws60/oO7fHAtilEDqG5nWlU=;
	b=RseYxYINvpCyHZBm2SlrGBfQXjmAYEMGXC9z4uxFDUDwQJFGUmvzBrx/PNvxtx41jfQIta
	S2MyXTxM0Mex1yc7ps1HkRwb6e5orGJSgeV+7dvtLNYNwE9cKUcY+6hiHM9iqBeo8qQ1mJ
	if00OyNupZUbDEonK80QMIKZ3pnMpY4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-41-GeY56FcKMVGU58ugZPQ1Tw-1; Thu,
 08 May 2025 14:49:37 -0400
X-MC-Unique: GeY56FcKMVGU58ugZPQ1Tw-1
X-Mimecast-MFC-AGG-ID: GeY56FcKMVGU58ugZPQ1Tw_1746730176
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 796F31800875;
	Thu,  8 May 2025 18:49:36 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.242])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BC544180087A;
	Thu,  8 May 2025 18:49:34 +0000 (UTC)
From: Joel Savitz <jsavitz@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Joel Savitz <jsavitz@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	cgroups@vger.kernel.org
Subject: [PATCH v2 1/2] kernel/nsproxy: remove unnecessary guards
Date: Thu,  8 May 2025 14:49:29 -0400
Message-ID: <20250508184930.183040-2-jsavitz@redhat.com>
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

In free_nsproxy() and the error path of create_new_namesapces() the
put_*_ns() calls are guarded by unnecessary NULL checks.

put_pid_ns(), put_ipc_ns(), put_uts_ns(), and put_time_ns() will never
receive a NULL argument unless their namespace type is disabled, and in
this case all four become no-ops at compile time anyway. put_mnt_ns()
will never receive a null argument at any time.

This unguarded usage is in line with other call sites of put_*_ns().

Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 kernel/nsproxy.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index c9d97ed20122..5f31fdff8a38 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -128,17 +128,13 @@ static struct nsproxy *create_new_namespaces(unsigned long flags,
 out_net:
 	put_cgroup_ns(new_nsp->cgroup_ns);
 out_cgroup:
-	if (new_nsp->pid_ns_for_children)
-		put_pid_ns(new_nsp->pid_ns_for_children);
+	put_pid_ns(new_nsp->pid_ns_for_children);
 out_pid:
-	if (new_nsp->ipc_ns)
-		put_ipc_ns(new_nsp->ipc_ns);
+	put_ipc_ns(new_nsp->ipc_ns);
 out_ipc:
-	if (new_nsp->uts_ns)
-		put_uts_ns(new_nsp->uts_ns);
+	put_uts_ns(new_nsp->uts_ns);
 out_uts:
-	if (new_nsp->mnt_ns)
-		put_mnt_ns(new_nsp->mnt_ns);
+	put_mnt_ns(new_nsp->mnt_ns);
 out_ns:
 	kmem_cache_free(nsproxy_cachep, new_nsp);
 	return ERR_PTR(err);
@@ -189,18 +185,12 @@ int copy_namespaces(unsigned long flags, struct task_struct *tsk)
 
 void free_nsproxy(struct nsproxy *ns)
 {
-	if (ns->mnt_ns)
-		put_mnt_ns(ns->mnt_ns);
-	if (ns->uts_ns)
-		put_uts_ns(ns->uts_ns);
-	if (ns->ipc_ns)
-		put_ipc_ns(ns->ipc_ns);
-	if (ns->pid_ns_for_children)
-		put_pid_ns(ns->pid_ns_for_children);
-	if (ns->time_ns)
-		put_time_ns(ns->time_ns);
-	if (ns->time_ns_for_children)
-		put_time_ns(ns->time_ns_for_children);
+	put_mnt_ns(ns->mnt_ns);
+	put_uts_ns(ns->uts_ns);
+	put_ipc_ns(ns->ipc_ns);
+	put_pid_ns(ns->pid_ns_for_children);
+	put_time_ns(ns->time_ns);
+	put_time_ns(ns->time_ns_for_children);
 	put_cgroup_ns(ns->cgroup_ns);
 	put_net(ns->net_ns);
 	kmem_cache_free(nsproxy_cachep, ns);
-- 
2.45.2


