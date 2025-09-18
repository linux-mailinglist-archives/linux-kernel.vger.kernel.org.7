Return-Path: <linux-kernel+bounces-754957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F06DDB19F27
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 12:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 271DA165298
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 10:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461471FBCA7;
	Mon,  4 Aug 2025 10:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RVzJ+qqg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BCB2475CF
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 09:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754301600; cv=none; b=rIqYs68m8Ys96XkP6C23mt1ss7hJrJKJxfQSEhVmw8lReu2zkwqB1Lvl1SrLl/j5s+qJmQ7foHUj5wXOnyO6Fg6ALEKnVtIV5ZDCAL+XXH8rejBc/gBi9km8ng4JZYI9FTDrM9bzWBz0H6rwTzj27OPZC1a1r+t9ppZQid5prhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754301600; c=relaxed/simple;
	bh=3ksWP6pfixZY81YtiYC+chRXxSOGQDzyt8L7OQfG2v0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GSiszHDNhEzH2++HsbpDbZ01J7iUTYJmIZmrbfrFT6b0GcbpUhZz1ZwIwYj8SNMLGj5A707y93YAvbwGjLaK6Ks9WRzygek5C7tYD98wZm4jf3V1NG00inemDKn+A4TfPIDCjnWefuRcNPbu0Hj+jjvYS4EAr+I0sw7zGTphk4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RVzJ+qqg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754301597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4uotoFYubX4ZtXqSpgKHCX/SSQDrgaT9v955ZDKGWl4=;
	b=RVzJ+qqgQ/vpYBVlq2hS3vrbiTmSo6RAQVMRAFeGZoXQzQa52guqomvk78+ezRZN/gbmJK
	4/aOm9HF6I34VjNKMV5fTLL+ix51olXkJYe95oMXahnCh9kA8X2/u0KOr5M3YUtZkE6OzZ
	bVLBLMmx+b7dw4nS9kn02JH+U1BdYyU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-KCeLmYdMNvyDMZuwBVwAsg-1; Mon, 04 Aug 2025 05:59:55 -0400
X-MC-Unique: KCeLmYdMNvyDMZuwBVwAsg-1
X-Mimecast-MFC-AGG-ID: KCeLmYdMNvyDMZuwBVwAsg_1754301594
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ade6db50b9cso349768366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 02:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754301593; x=1754906393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4uotoFYubX4ZtXqSpgKHCX/SSQDrgaT9v955ZDKGWl4=;
        b=qT+L/VX5ymEpSoTJdOxYStMcwtXuGbDzpyas7GBBMVRFW0MhmgzLgUUPTqWYR6f4GY
         qlVy1n/J43SYsuVRd/CU/xVulTZEO5a/VsDw7ktOT1Iw4f6IXLs8WNV5GUvJ+2MEGI3s
         meDFKPXtYzCJxfQtpUXi+O9ewrGwg0UlVC86Ij4KFcMgd0IzEh9/EXYZi5lqFC2I1KLY
         g0GbJo2jH5/hgdWY1QyPfGfWc5t+aSAGZTMyWIAmfABlZUbexVqsmxQc+DXxuNLfI4ec
         KFPnvV3mLEaXeafof6hXUE2fAAYiejRCatMGZsEG1ibT8hcAJ3HohXePqUGvnVcrToJs
         ni7A==
X-Gm-Message-State: AOJu0Yyp++wOQNMvc4b3wEEQ9fIjJy5pKc4pIHHbQB4nsh5p0gV/5xVi
	4QLr++tU8oKgiTHrl3LKceW0XpgSJ/91PJyVX2ROFtW77hHWGozax/4XV2PSA57anqqPRiECZ/o
	CA/ianJjWDFXNSDsbeUvkxq/L3W8IW30bAK0lX9gManl5Za/l6AnK8YGX2AzM0NZXKBWSS4Xghp
	kz
X-Gm-Gg: ASbGncuniPZRG214faxyJPOkhOdaSXra7pZK+nLKU3Wrt5MwRP6ni2q9MvqZITMP/K2
	x5zDfOI0/8KwxDXL8irRKRl8555g5VHjeWyWq4gONcqF4Httojuqo6OfggyoTXTdrRr6CP3Y40z
	azyzxMU9G7A8S5j+BKtdlsqVY5DJBiGm6C2eQDpk5vt/k++VE3ce0NbkoViGr8GQLr6e+nKjlNj
	ofwp16d61zxdezs0KFhcMZuKQZHQvqgaLkZ1dtK9SwTpHgkOOiagIUSjUMcpG8JuNEJZp6TkPcE
	TNskkqsY1BER/eeuZmlYvIWS867HABSxXZkctfDhi7b9KoG47sLh9PKZpm1QCxBKoGB94k7+IQ=
	=
X-Received: by 2002:a17:907:3fa2:b0:ae0:ad5c:4185 with SMTP id a640c23a62f3a-af94024f22emr924327366b.57.1754301593483;
        Mon, 04 Aug 2025 02:59:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+nnHYbeFkYXBWGzroGgRCReKRjMsUUhkQES2+aUsPNuNZysvQn/YuZujog/jnwUM/EWJm9A==
X-Received: by 2002:a17:907:3fa2:b0:ae0:ad5c:4185 with SMTP id a640c23a62f3a-af94024f22emr924324866b.57.1754301593017;
        Mon, 04 Aug 2025 02:59:53 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a078bcbsm715458766b.13.2025.08.04.02.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 02:59:52 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Slava.Dubeyko@ibm.com,
	idryomov@gmail.com,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH v2 2/2] ceph: fix client race condition where r_parent becomes stale before sending message
Date: Mon,  4 Aug 2025 09:59:42 +0000
Message-Id: <20250804095942.2167541-3-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804095942.2167541-1-amarkuze@redhat.com>
References: <20250804095942.2167541-1-amarkuze@redhat.com>
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
index 814f9e9656a0..7da648b5e901 100644
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


