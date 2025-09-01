Return-Path: <linux-kernel+bounces-794916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14658B3EAC7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 672BB1897A9B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E5635206B;
	Mon,  1 Sep 2025 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IOdMtfVN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC8032F775
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756739701; cv=none; b=NGYy05Hg7WFHWV6UYWLDx6Q7Nvr7lmTh3u7KPTcYdLOpd9//J9U8UB7pY4rerB4tfD02PY4yAKBFBXu5cl01Xh9wn9S7atOCT2DX9Irrjv2zeG9RtTcCVWC6GUJ9GJdnmNsNh/8QMxgh1ojtdzvxkn5tV9iMpE9k51QtDj/HCkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756739701; c=relaxed/simple;
	bh=d9ZsWkV9weZU5EgWpzqcvnFADsgoVlKQdwsP0siCujs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=orLQGlPYh3CbzJzu30eTi2XXZ0ARlsIcLhxxai1guzDef3qizHH/locYh3X2Z5kgywQw7+2yUKAgghsJ+XI3Bc7Y0COQBVxVXpWqxlpgqcljWS0NFmk+yiwNGm2dxRimY2jhbIu1M3/wryUb5v7asfWCuumDi80tn4Pe8EKUr8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IOdMtfVN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756739698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0urIMojorRra0z+jtQP3egYMiZwvjHHk7h/DnJcG8EQ=;
	b=IOdMtfVNDFCsmlyzHnudF/uMnHBhGJIsHFdTB+XvWq3Ki6BM+2jW4s92k0Z+Ty3gR/sLX4
	3/TT9tCZLxkMCRejpPWeuC+RYz9GpvCW7Z1QAW0xvviprLsXzplEVskY2DRdED79e07Mw3
	OOR7nic7PCGx8ubI5jVImsuyZDlf4wk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-LrLMPlq4OKOPOdQhFxXWbA-1; Mon, 01 Sep 2025 11:14:57 -0400
X-MC-Unique: LrLMPlq4OKOPOdQhFxXWbA-1
X-Mimecast-MFC-AGG-ID: LrLMPlq4OKOPOdQhFxXWbA_1756739697
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b2f9e8dca6so99949041cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 08:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756739697; x=1757344497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0urIMojorRra0z+jtQP3egYMiZwvjHHk7h/DnJcG8EQ=;
        b=i5WhNkWWgCqNRyaON9+YkmxPWc374+4dsP0u8eeMXcqWrjnCLJZ88vi7CCEJ+29c65
         QkAPQAbB1dwWdVkU5aJ8UOWlTmEiTicb44yzGQ/hyzbxr25OQzX4U2c1UdvRcNpZxrW6
         cKPDQi2z1ysk18prcZIz+AIGjSaoVuX6FMhtOwDkZK1QSQSqJinapdVKUjnyvIWNhY+q
         Qcssx36QXNpSq8vTMZqt6RpvXgIEBxE6mncPhrgHpMs7ut7Mkr6NqHiZRuSVb2uKd+YY
         5AGpzFNuf8Nn9LbR+LS6doUb6V+dchO5yEliaHryNVjdaV5jS8MOAEcD9/WbR5d49d+8
         ikvQ==
X-Gm-Message-State: AOJu0YzpURwTFVOw7ieemcVu42Ogt+SqIRLUfuMSbMo3jr9pT9/Rtz/q
	uEmg8tsobsJ6JQCUkkmHNVF0paFbi2y5GL1FFTSfnf3r4G26+nRkel9g1LMCTno4enG5UAr2p1i
	LY3dSHWHm8r4Wl8nMiqCm+/2gqsjDA+VRH0uKkmFv3IhEziIBZWzhYriKwAdxyO6Oy+56ML1jln
	nL
X-Gm-Gg: ASbGncv6wPfm+d6DiMkT834Wuy7EtdPMhmh7MEB+M9BoSKOC5y0shW+N7jSodYjw3uJ
	kCy4uRH14iRQZhnoMY8zbzuILJfUPudCy10VQUx8lOn9Btkzz65mG3YIhrT87m/7dmUOcT4lhFX
	9kXhsyD+encMHOGpTAW1lXo3f1I0wZeXL91TllpnUQaJlQY4fOEK18DLqkG6gecY/p5NKjmTic3
	vosD9BGPRK7peRZ4tUZFQNU9/s5UJ6xly3nUCPlMiBG9BydhtXVIV5w0ETQaCKEnEl4nKeSfZ31
	m2QPoL9KTzJJHKUTCg4nFDUKPQ3ekvJoNV+hgk3b0kJ0Qn4Ta3Y6EBet7ohUmNTX2oRb4UtjKA=
	=
X-Received: by 2002:a05:622a:1c15:b0:4b0:6aa5:be8f with SMTP id d75a77b69052e-4b31d888517mr85860111cf.25.1756739697079;
        Mon, 01 Sep 2025 08:14:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVnsjxpmb+OfsU9Oir/PMVU6TwlJKtOxrJdOJ9/JyaiwIcoUIkmvWobBUSFXBl6iDN+VVIbg==
X-Received: by 2002:a05:622a:1c15:b0:4b0:6aa5:be8f with SMTP id d75a77b69052e-4b31d888517mr85859601cf.25.1756739696458;
        Mon, 01 Sep 2025 08:14:56 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b30b67894bsm64286011cf.33.2025.09.01.08.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 08:14:56 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Slava.Dubeyko@ibm.com,
	idryomov@gmail.com,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH 2/2] ceph/inode: drop extra reference from ceph_get_reply_dir() in ceph_fill_trace()
Date: Mon,  1 Sep 2025 15:14:48 +0000
Message-Id: <20250901151448.726098-2-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250901151448.726098-1-amarkuze@redhat.com>
References: <20250901151448.726098-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ceph_get_reply_dir() may return a different, referenced inode when r_parent is stale and the parent directory lock is not held.
ceph_fill_trace() used that inode but failed to drop the reference when it differed from req->r_parent, leaking an inode reference.

Keep the directory inode in a local and iput() it at function end if it does not match req->r_parent.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/inode.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 470ee595ecf2..439c08ece283 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1585,6 +1585,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(sb);
 	struct ceph_client *cl = fsc->client;
 	int err = 0;
+	struct inode *dir = NULL;
 
 	doutc(cl, "%p is_dentry %d is_target %d\n", req,
 	      rinfo->head->is_dentry, rinfo->head->is_target);
@@ -1601,7 +1602,11 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 		 * r_parent may be stale, in cases when R_PARENT_LOCKED is not set,
 		 * so we need to get the correct inode
 		 */
-		struct inode *dir = ceph_get_reply_dir(sb, req->r_parent, rinfo);
+		dir = ceph_get_reply_dir(sb, req->r_parent, rinfo);
+		if (IS_ERR(dir)) {
+			err = PTR_ERR(dir);
+			goto done;
+		}
 		if (dir) {
 			err = ceph_fill_inode(dir, NULL, &rinfo->diri,
 					      rinfo->dirfrag, session, -1,
@@ -1869,6 +1874,9 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 					    &dvino, ptvino);
 	}
 done:
+	/* Drop extra ref from ceph_get_reply_dir() if it returned a new inode */
+	if (!IS_ERR(dir) && dir && dir != req->r_parent)
+		iput(dir);
 	doutc(cl, "done err=%d\n", err);
 	return err;
 }
-- 
2.34.1


