Return-Path: <linux-kernel+bounces-762326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEEDB204F0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D33E218A01D7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF4E231832;
	Mon, 11 Aug 2025 10:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B5Po39gp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB191E3775
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754907013; cv=none; b=YUG+3tNNZAqKm83uRrL6PHkOiJPvikooAYM0fNg3zlYsWS+u5J4jl9H5zgS2vjUM5unh/o6OvTyWlymPki1kyfs42x5IDgYah2a+dLR6qmjL1WkVNBy26D8ELCA+gV7UQHFFGjOTl4VRa0APNabVXRox1PhoKdgQd+QeWwcpJlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754907013; c=relaxed/simple;
	bh=iqhYFYTxQa/K2nVowETY6ZlfzDTcoa5uKhkMJRu1DNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OiDL9e+EXwvC4ow4TIeyIURAdxJZc4HpI5AxqaH75sq3ySpgrm//1TxyxM2DjxmpQ6dqR7y6TW6ze5CV6HhH1/nD/LYq02KU9FndMZ2D8JJhhJQA2OoYuY5rh3if2i1XDhRI/BuV4UNwIZPlPOPFi+qZ52l7OgOKg3T+gfz0zeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B5Po39gp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754907011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ADXa+JUacIlGyQHrCfYdOEZrY+dSv3yGk/IhF4XPHU=;
	b=B5Po39gp5Rr1z2IUD93ogbiyqmSStu9KLCgoGLWsyeDwcgsZ6DzUKfJ3U8CkRbOsO7iQeM
	d40JMqskYmZnDz0FfGnpCOqUJHT86zFJ/rwmf2K4oz+trcz0nm5vgmVI/yaWYehKyk6Y96
	inXHYNul6F5FTeVS5t6NbgNobgW9Njw=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-tyTeSkbGPu2RS20oAHwmwg-1; Mon, 11 Aug 2025 06:10:10 -0400
X-MC-Unique: tyTeSkbGPu2RS20oAHwmwg-1
X-Mimecast-MFC-AGG-ID: tyTeSkbGPu2RS20oAHwmwg_1754907009
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-741aca25590so3614466a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754907009; x=1755511809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ADXa+JUacIlGyQHrCfYdOEZrY+dSv3yGk/IhF4XPHU=;
        b=ae1dL1Fd4u434HPm9ogezJX8YnyRg3dMWK8m02tqMTy8/wC2JQNcJ5fSLiaRUaLh7+
         ys4+uNz04ClHcLmB4spE/kbefPMn1qmoisZmlq1H2PdlqCTcQIldqUEgHDCeWmMia78g
         oupVU4cHbUfkYMQZsqy6cfe7gd8TaXVBrdn8pIrDy1oeTfJFNZAfpCeeY3PCXo/bGTuW
         uGdNc87SUB6gv58oHDC4xprJmoc3XqJuRAMkVfEX3djCubDHUhQQ8aCtChjJLHj6vNHq
         +iYfwuLXAF3f/N3lu8cfHQsw60OFiuD/kJLwtE4NV84UpzBdREdUr0MpRdL4OKUZ2Usb
         0ikQ==
X-Gm-Message-State: AOJu0YxAR7lMdvIr+S+wsnGoLJ9/jnWqxLiLKeHgEp3A9uHsUlGsyK02
	sTcCNcJUlZXcl2ALlmP8yl7YVTt0C2DxAzkZ4NH0s2e9laYjjOolx1h1jr71u49g7RLEUCQDnwc
	o2dkXSPNpD243HihSAZojdIQzgCK1/Wk4GDBWshSwFFt0KkAAjGii085Fsi/12tVKR6dhwH+gaq
	FY
X-Gm-Gg: ASbGncuPxN4ok2F+jRA/kWBJ1Zc+CZOki11uCvO7PL9wzvzFlN+1rhNhvZQfFOVZv6F
	pWj7yJbpg3+grE/QwmqPwXB9BctjzDxr6x3LbxdTEXUf18r4U/ciC4IPR8gBRGtDMyN4j1Mh2BP
	dtqafSCl7S+Mv/XGpy1DRrr7GYVBMegYI94JTmn/aOUOa1XICj7RFOeinTJoiWlh1ZO3oS/3ZLO
	/479JXzYEC/b4jUw2hCZifQkJvRr1cSyWoSPDWMP5Dcj9d6Aitaey32NZxQsHmu7Mam1teMknWG
	A6jXUmXqECDd8AWnP/zuJnVczUSo9Mx6Io0udtsgwj0xGzIWDcD4j5yeygVg0X88viQIafDyNw=
	=
X-Received: by 2002:a05:6830:91e:b0:742:f82b:4f35 with SMTP id 46e09a7af769-7432c6fef53mr5163249a34.7.1754907009056;
        Mon, 11 Aug 2025 03:10:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGDV61T6bvbfrGKdhItBqh9I5e/MeC98JhftfpIquS5ORyE/FnDauZZJrP6yCeLaeggPjNhA==
X-Received: by 2002:a05:6830:91e:b0:742:f82b:4f35 with SMTP id 46e09a7af769-7432c6fef53mr5163237a34.7.1754907008721;
        Mon, 11 Aug 2025 03:10:08 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-61b84cb7630sm849522eaf.19.2025.08.11.03.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:10:08 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Slava.Dubeyko@ibm.com,
	idryomov@gmail.com,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH v3 2/2] ceph: fix client race condition where r_parent becomes stale before sending message
Date: Mon, 11 Aug 2025 10:09:53 +0000
Message-Id: <20250811100953.3103970-3-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811100953.3103970-1-amarkuze@redhat.com>
References: <20250811100953.3103970-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When the parent directory's i_rwsem is not locked, req->r_parent may become
stale due to concurrent operations (e.g. rename) between dentry lookup and
message creation. Validate that r_parent matches the encoded parent inode
and update to the correct inode if a mismatch is detected.
---
 fs/ceph/inode.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 58da0f6419f7..c6f7fd9a25f3 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -56,6 +56,51 @@ static int ceph_set_ino_cb(struct inode *inode, void *data)
 	return 0;
 }
 
+/*
+ * Check if the parent inode matches the vino from directory reply info
+ */
+static inline bool ceph_vino_matches_parent(struct inode *parent, struct ceph_vino vino)
+{
+	return ceph_ino(parent) == vino.ino && ceph_snap(parent) == vino.snap;
+}
+
+/*
+ * Validate that the directory inode referenced by @req->r_parent matches the
+ * inode number and snapshot id contained in the reply's directory record.  If
+ * they do not match – which can theoretically happen if the parent dentry was
+ * moved between the time the request was issued and the reply arrived – fall
+ * back to looking up the correct inode in the inode cache.
+ *
+ * A reference is *always* returned.  Callers that receive a different inode
+ * than the original @parent are responsible for dropping the extra reference
+ * once the reply has been processed.
+ */
+static struct inode *ceph_get_reply_dir(struct super_block *sb,
+                                       struct inode *parent,
+                                       struct ceph_mds_reply_info_parsed *rinfo)
+{
+    struct ceph_vino vino;
+
+    if (unlikely(!rinfo->diri.in))
+        return parent; /* nothing to compare against */
+
+    /* If we didn't have a cached parent inode to begin with, just bail out. */
+    if (!parent)
+        return NULL;
+
+    vino.ino  = le64_to_cpu(rinfo->diri.in->ino);
+    vino.snap = le64_to_cpu(rinfo->diri.in->snapid);
+
+    if (likely(ceph_vino_matches_parent(parent, vino)))
+        return parent; /* matches – use the original reference */
+
+    /* Mismatch – this should be rare.  Emit a WARN and obtain the correct inode. */
+    WARN(1, "ceph: reply dir mismatch (parent valid %llx.%llx reply %llx.%llx)\n",
+         ceph_ino(parent), ceph_snap(parent), vino.ino, vino.snap);
+
+    return ceph_get_inode(sb, vino, NULL);
+}
+
 /**
  * ceph_new_inode - allocate a new inode in advance of an expected create
  * @dir: parent directory for new inode
@@ -1548,8 +1593,11 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 	}
 
 	if (rinfo->head->is_dentry) {
-		struct inode *dir = req->r_parent;
-
+		/*
+		 * r_parent may be stale, in cases when R_PARENT_LOCKED is not set,
+		 * so we need to get the correct inode
+		 */
+		struct inode *dir = ceph_get_reply_dir(sb, req->r_parent, rinfo);
 		if (dir) {
 			err = ceph_fill_inode(dir, NULL, &rinfo->diri,
 					      rinfo->dirfrag, session, -1,
-- 
2.34.1


