Return-Path: <linux-kernel+bounces-702763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 667F6AE86F8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 16:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 061C63B3E02
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 14:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FF61C84BD;
	Wed, 25 Jun 2025 14:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bA1/udyN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930661B0F23
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 14:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750862814; cv=none; b=tR+9RSUiwFopYvWkd7Z+nm83cqsFaIMZTfkeV1kM7Qq7G15uFi1CNLdQdDiuxO/CHF2SZ6sgbFh8vuaOoRdGTQ3tlnExG8RSnRPwUlfvnxK+JAJMNSivGhe7Lm4rOeoZioC7e5nIXfFjAx10R7iEX7Pckbq9SEVZ9ScxdEdROJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750862814; c=relaxed/simple;
	bh=9FUYabknNcurofwj4UCGhEeyGm1AsejGZaSQt7H1/es=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=dgSf8aDyb/bvo9lXrtGR0Qfu00gt+dU2iXIXlLDazjrMGBCe0CiO72IhyvvGiwGkNw+MQ6lf7bn8XPm3dvCn/6eBrbWeGE6Pzy3KMmNsJFCiAZX9TBzVuJEnuUFzwQaXlmREo5bgHO6E8h0edI+yEzk0mNZ9SlHpyRNEgzBfMhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bA1/udyN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750862810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uPXp9ejXM0towCU3Aodofw9cLB8p+LJAxhRXRbwRUFk=;
	b=bA1/udyN1X/qSj10DrN2MSsB3YaH++grzQ6bCRoIaZANP2dbN29QKWctk7vuEw/qujo2Gg
	f15ZPx7BjZvp8uRazBne8nY958Jt52m52h3pTNfbV4W1/EyeIihhRAxflzURe4yu1SSGkw
	jx6FJtCIdmKqz3ysxchSnkrpgDPowH0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-tYk38OYFNWi0LQFBpUAHSA-1; Wed,
 25 Jun 2025 10:46:46 -0400
X-MC-Unique: tYk38OYFNWi0LQFBpUAHSA-1
X-Mimecast-MFC-AGG-ID: tYk38OYFNWi0LQFBpUAHSA_1750862805
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3709F180034E;
	Wed, 25 Jun 2025 14:46:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.81])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2790E30001A1;
	Wed, 25 Jun 2025 14:46:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1372501.1750858644@warthog.procyon.org.uk>
References: <1372501.1750858644@warthog.procyon.org.uk>
To: Stefan Metzmacher <metze@samba.org>,
    Steve French <stfrench@microsoft.com>
Cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.com>,
    linux-cifs@vger.kernel.org, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] cifs: Fix the smbd_request and smbd_reponse slabs to allow usercopy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1382991.1750862802.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Jun 2025 15:46:42 +0100
Message-ID: <1382992.1750862802@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

    =

The handling of received data in the smbdirect client code involves using
copy_to_iter() to copy data from the smbd_reponse struct's packet trailer
to a folioq buffer provided by netfslib that encapsulates a chunk of
pagecache.

If, however, CONFIG_HARDENED_USERCOPY=3Dy, this will result in the checks
then performed in copy_to_iter() oopsing with something like the following=
:

 CIFS: Attempting to mount //172.31.9.1/test
 CIFS: VFS: RDMA transport established
 usercopy: Kernel memory exposure attempt detected from SLUB object 'smbd_=
response_0000000091e24ea1' (offset 81, size 63)!
 ------------[ cut here ]------------
 kernel BUG at mm/usercopy.c:102!
 ...
 RIP: 0010:usercopy_abort+0x6c/0x80
 ...
 Call Trace:
  <TASK>
  __check_heap_object+0xe3/0x120
  __check_object_size+0x4dc/0x6d0
  smbd_recv+0x77f/0xfe0 [cifs]
  cifs_readv_from_socket+0x276/0x8f0 [cifs]
  cifs_read_from_socket+0xcd/0x120 [cifs]
  cifs_demultiplex_thread+0x7e9/0x2d50 [cifs]
  kthread+0x396/0x830
  ret_from_fork+0x2b8/0x3b0
  ret_from_fork_asm+0x1a/0x30

The problem is that the smbd_response slab's packet field isn't marked as
being permitted for usercopy.

Fix this by passing parameters to kmem_slab_create() to indicate that
copy_to_iter() is permitted from the packet region of the smbd_response
slab objects, less the header space.

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Reported-by: Stefan Metzmacher <metze@samba.org>
Link: https://lore.kernel.org/r/acb7f612-df26-4e2a-a35d-7cd040f513e1@samba=
.org/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <stfrench@microsoft.com>
cc: Paulo Alcantara <pc@manguebit.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/smbdirect.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index ef6bf8d6808d..f9773cc0d562 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -1475,6 +1475,9 @@ static int allocate_caches_and_workqueue(struct smbd=
_connection *info)
 	char name[MAX_NAME_LEN];
 	int rc;
 =

+	if (WARN_ON_ONCE(sp->max_recv_size < sizeof(struct smbdirect_data_transf=
er)))
+		return -ENOMEM;
+
 	scnprintf(name, MAX_NAME_LEN, "smbd_request_%p", info);
 	info->request_cache =3D
 		kmem_cache_create(
@@ -1492,12 +1495,17 @@ static int allocate_caches_and_workqueue(struct sm=
bd_connection *info)
 		goto out1;
 =

 	scnprintf(name, MAX_NAME_LEN, "smbd_response_%p", info);
+
+	struct kmem_cache_args response_args =3D {
+		.align		=3D __alignof__(struct smbd_response),
+		.useroffset	=3D (offsetof(struct smbd_response, packet) +
+				   sizeof(struct smbdirect_data_transfer)),
+		.usersize	=3D sp->max_recv_size - sizeof(struct smbdirect_data_transfer=
),
+	};
 	info->response_cache =3D
-		kmem_cache_create(
-			name,
-			sizeof(struct smbd_response) +
-				sp->max_recv_size,
-			0, SLAB_HWCACHE_ALIGN, NULL);
+		kmem_cache_create(name,
+				  sizeof(struct smbd_response) + sp->max_recv_size,
+				  &response_args, SLAB_HWCACHE_ALIGN);
 	if (!info->response_cache)
 		goto out2;
 =


