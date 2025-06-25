Return-Path: <linux-kernel+bounces-702992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 971B9AE8A45
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 18:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 493415A4BEC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 16:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86872DFA4B;
	Wed, 25 Jun 2025 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ADbsE3v2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB792DECC7
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750869763; cv=none; b=uhRc8ORW1iQHhz25pRUEx+yBnMt3Uu4CdYEPQDJH5+EVA9t/FBuoMiBNJYCx+8bzZ6kR7lVxNjiizqDeNbyfVYpRn0n9vuDEDHtkv5GLazi4gRHaRN6HD10rjZtexkHS+7pPaxm2RpQsoZ+YFJHN4H/FK+qPQ+fDuWfZXLozYhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750869763; c=relaxed/simple;
	bh=ThL+c4KRVYOJ4chfjquyjlUTkzyLflKNzPobS0UZxu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/+YXwYea5I77HykNK/+a2Jj9HOke/EtPfYw/Dk29oB3RxQbyZDmQU2mBtV/HkGu0GQdegqEMOAUSHaMb3rMwW5uHuEUiDsXSMXLJOwK+UjAxBOgNzW4i7KIXNTPLcfuvPKx3P1Y7I3NPeuwGVa1/hYYmTyHx8bmazHX9p36YpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ADbsE3v2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750869760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W8Ygr8J3FPj7uU3iVOA6bz3YJu/cWtKFNlp85sjx/fU=;
	b=ADbsE3v2fb/nJEwSJ1LqT8RoMUhnkkS80CrCEY01onrWM223WkSg5BxsiACkj28mYYLScs
	2I6nm7+8QlPTHKhwZ4aT+JGPLMJjYeCfylwF1KxmyfNUiIL7OXyBWGnHNnGTtWxKbB1d2s
	44zdDh+cL/dKRVNFYqFR5aUfOKtKBAQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-f57ctz1tN1u-NFqrHGR2vw-1; Wed,
 25 Jun 2025 12:42:36 -0400
X-MC-Unique: f57ctz1tN1u-NFqrHGR2vw-1
X-Mimecast-MFC-AGG-ID: f57ctz1tN1u-NFqrHGR2vw_1750869754
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DFB3D180028C;
	Wed, 25 Jun 2025 16:42:33 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 48C9019560A3;
	Wed, 25 Jun 2025 16:42:29 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.org>
Subject: [PATCH v2 02/16] netfs: Put double put of request
Date: Wed, 25 Jun 2025 17:41:57 +0100
Message-ID: <20250625164213.1408754-3-dhowells@redhat.com>
In-Reply-To: <20250625164213.1408754-1-dhowells@redhat.com>
References: <20250625164213.1408754-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

If a netfs request finishes during the pause loop, it will have the ref
that belongs to the IN_PROGRESS flag removed at that point - however, if it
then goes to the final wait loop, that will *also* put the ref because it
sees that the IN_PROGRESS flag is clear and incorrectly assumes that this
happened when it called the collector.

In fact, since IN_PROGRESS is clear, we shouldn't call the collector again
since it's done all the cleanup, such as calling ->ki_complete().

Fix this by making netfs_collect_in_app() just return, indicating that
we're done if IN_PROGRESS is removed.

Fixes: 2b1424cd131c ("netfs: Fix wait/wake to be consistent about the waitqueue used")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Paulo Alcantara <pc@manguebit.org>
cc: Steve French <sfrench@samba.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: linux-cifs@vger.kernel.org
---
 fs/netfs/misc.c              | 5 +++++
 include/trace/events/netfs.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 0a54b1203486..8cf73b237269 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -383,6 +383,11 @@ static int netfs_collect_in_app(struct netfs_io_request *rreq,
 {
 	bool need_collect = false, inactive = true, done = true;
 
+	if (!netfs_check_rreq_in_progress(rreq)) {
+		trace_netfs_rreq(rreq, netfs_rreq_trace_recollect);
+		return 1; /* Done */
+	}
+
 	for (int i = 0; i < NR_IO_STREAMS; i++) {
 		struct netfs_io_subrequest *subreq;
 		struct netfs_io_stream *stream = &rreq->io_streams[i];
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 333d2e38dd2c..ba35dc66e986 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -56,6 +56,7 @@
 	EM(netfs_rreq_trace_dirty,		"DIRTY  ")	\
 	EM(netfs_rreq_trace_done,		"DONE   ")	\
 	EM(netfs_rreq_trace_free,		"FREE   ")	\
+	EM(netfs_rreq_trace_recollect,		"RECLLCT")	\
 	EM(netfs_rreq_trace_redirty,		"REDIRTY")	\
 	EM(netfs_rreq_trace_resubmit,		"RESUBMT")	\
 	EM(netfs_rreq_trace_set_abandon,	"S-ABNDN")	\


