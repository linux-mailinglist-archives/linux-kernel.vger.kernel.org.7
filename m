Return-Path: <linux-kernel+bounces-653861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C763ABBFC6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 15:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DACFB3B8786
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 13:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62F2283147;
	Mon, 19 May 2025 13:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YYfPT49T"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8151726B0BC
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 13:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747662531; cv=none; b=f4pnxuSZ3Gu15IIuZ39e5B6wv0d7p9HRV8Jg9H9vTk3rExiRW+eTPTEa4g3aFgtb68wTbcMwegA8fg7o/PbivVbnNA741xMIW6bgslU2ifhSGpVQ63+Iwju2gGUeZBRFy1A9QdniIv2o0z3aC8NQSSRo0uvVcGei1uzNTmLHdUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747662531; c=relaxed/simple;
	bh=FzodCAdzyX3Ltcdqmlv2R2MvlBaqgIvZK/oawyALlLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JPzs/aSrwl6sKUlvNpGj2wfYywSpQkor5UURW2Yl9QiANLLUBRtyPvVzfY18Ki1uK2Z6uftpdNcZxRXX8wM4/ca9jk7LmIzW78cpSNuA+/YV8CGv/F/cxBxKGYAoIb4q1O9E3K8YLcr0fRDoCqKt1VazU8TuvtKVRq4yzHqoX6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YYfPT49T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747662528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZVY3b+iTFZv9hiRNhlHukuJN9/bwZfLrFOeboaM4TSg=;
	b=YYfPT49TxDzAxHxwPNg21mAIEwrWA62/etD9ewyGgKapc2/DvBkML1XwvNaSOrA/bJ3HxD
	ayz5RzUirHy2RyLI40POR+uvpbig/2VubpAD7dDzIa+U+dGM9z1q2VRMsntZSGDvNn/MQA
	9S7Ps/O2GiwJcDLWNciX6n4VxTTveRc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-HQ3NKlFrP3qdhkSxhL0sHA-1; Mon,
 19 May 2025 09:48:45 -0400
X-MC-Unique: HQ3NKlFrP3qdhkSxhL0sHA-1
X-Mimecast-MFC-AGG-ID: HQ3NKlFrP3qdhkSxhL0sHA_1747662523
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53E7B19560BC;
	Mon, 19 May 2025 13:48:43 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.188])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2E50619560AA;
	Mon, 19 May 2025 13:48:39 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] fs/netfs: remove unused source NETFS_INVALID_WRITE
Date: Mon, 19 May 2025 14:47:59 +0100
Message-ID: <20250519134813.2975312-4-dhowells@redhat.com>
In-Reply-To: <20250519134813.2975312-1-dhowells@redhat.com>
References: <20250519134813.2975312-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Max Kellermann <max.kellermann@ionos.com>

This enum choice was added by commit 16af134ca4b7 ("netfs: Extend the
netfs_io_*request structs to handle writes") and its only user was
later removed by commit c245868524cc ("netfs: Remove the old writeback
code").

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.com>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/write_collect.c     | 2 --
 include/linux/netfs.h        | 1 -
 include/trace/events/netfs.h | 3 +--
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 3fca59e6475d..17f4e4bcc789 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -495,8 +495,6 @@ void netfs_write_subrequest_terminated(void *_op, ssize_t transferred_or_error,
 	case NETFS_WRITE_TO_CACHE:
 		netfs_stat(&netfs_n_wh_write_done);
 		break;
-	case NETFS_INVALID_WRITE:
-		break;
 	default:
 		BUG();
 	}
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index d315d86d0ad4..5a76bea51d24 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -48,7 +48,6 @@ enum netfs_io_source {
 	NETFS_INVALID_READ,
 	NETFS_UPLOAD_TO_SERVER,
 	NETFS_WRITE_TO_CACHE,
-	NETFS_INVALID_WRITE,
 } __mode(byte);
 
 typedef void (*netfs_io_terminated_t)(void *priv, ssize_t transferred_or_error,
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index f880835f7695..59ecae3ad0fb 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -77,8 +77,7 @@
 	EM(NETFS_READ_FROM_CACHE,		"READ")		\
 	EM(NETFS_INVALID_READ,			"INVL")		\
 	EM(NETFS_UPLOAD_TO_SERVER,		"UPLD")		\
-	EM(NETFS_WRITE_TO_CACHE,		"WRIT")		\
-	E_(NETFS_INVALID_WRITE,			"INVL")
+	E_(NETFS_WRITE_TO_CACHE,		"WRIT")
 
 #define netfs_sreq_traces					\
 	EM(netfs_sreq_trace_add_donations,	"+DON ")	\


