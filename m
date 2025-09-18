Return-Path: <linux-kernel+bounces-794915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC82B3EA57
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C6A57A00F6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7095F23D7C5;
	Mon,  1 Sep 2025 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QP1aiEL0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A28132F770
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 15:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756739700; cv=none; b=evuGRPhWf0ALHzCU5UbDmMMmv7EOEQKPMdnqs+9R0yz/SHKreng+ahT1vT9SmR625aTM7FuoSJWm+jHl+mlcUgdlVDO9C6ho2DAoq+lUn+2skGRE+erHOWEUDar8ROlHKUn+g53EGetEbHLHXrRx+rV4M0Yd/hojW8HwVWtd4rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756739700; c=relaxed/simple;
	bh=6qMh0KDCJNwTdqjfkdAMug2wJ6BOezze1tS85Zw9uMo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gOMjRdvOASyPUPRzObZHM+vEcXQ5plYMcSjJT/7N6iFkgQApUoqjpSHJGKl/x6LskAw/6K8tq+oeRgJhxIumy3BypF4kBmeZXNqeGRC8hIHiKNsnrWL/Nl878mebzXcHQ5usScX6ZFuygIkTbap7SOflcodAp4nKICl9J93coWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QP1aiEL0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756739696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ym5UK/Mx15ICfCms4UjVMy/cz1F+8Lwq03O7rLyNqnk=;
	b=QP1aiEL0aUOJP6a5910dCbncuAKyfA5XrOkSLYHMuzQT+2Fe4LSnYfGW1aoO5SaviwrCdh
	005rAOIPS/ONZuOf2z5tsFTYzCjmFdFIxYpD9sgsGbei+Gp34kyO3k4pGyEQt6cO7z7PQK
	cbUFmF13KNCuT5gD/4b4vmwtpS35krY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-Fb-r1GJTM_mh1EljF8fClg-1; Mon, 01 Sep 2025 11:14:55 -0400
X-MC-Unique: Fb-r1GJTM_mh1EljF8fClg-1
X-Mimecast-MFC-AGG-ID: Fb-r1GJTM_mh1EljF8fClg_1756739695
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b311db2c76so9799891cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 08:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756739695; x=1757344495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ym5UK/Mx15ICfCms4UjVMy/cz1F+8Lwq03O7rLyNqnk=;
        b=Nd330RHOfWsSSPPYnCmHg5aZ1pyLC9OjPqs3DiuKL0XPtT4/799kPvGs338PJXNDhT
         rHdHt+Wa7kjqXup27/r04jBnf3uR6dh1m6kBL+4hgLvSr4plI4/Bnj8khngS8TeMZyo+
         UzvfNOJ7Rk8wKz/FCY1JqBbSbUTGV6hPAG+LRq+uDl6uLSsOtoGlzZ+7LGlo446td2F+
         Z2iE3pWVI4rmCn7k2ezrGcnIzwAxYiaZwVoJIt48GZRXGNoK9LxSDQJUVH/dbX4EnLyP
         cVS0e7gRvgsPFxoIDNBs/6nyY5jhoEKq8xd/tHyKtsarEBJFsS32QAmr1GFM3cpyEYuR
         0Taw==
X-Gm-Message-State: AOJu0YweQEvlLuG8aPaxu16Hn/iy8O6XS5P9LWwPGcPALyBoPkUqZuH7
	FCUcz3R83PSujHqD3gCEUMGFBLXvt/4RNvKUU6coy/5o3T6DNvi0LstEwco64Zo/kbFEG6NNyos
	oZJrYvyWHgE/SW8Fdiktg8nlPXug5AMdfbNooEXxaBvVhEWbdUTgWlxyx+8iiMjsfYpi/Pkysu5
	Ox
X-Gm-Gg: ASbGncs5PbcgMoAJKuTfq3LwuCLJU0EJa+Rp1XHKSaUPvSMf3gHck5beRcD1AiqiZAQ
	JIKrIRZ8GQiQ3rskB2CC/s/6CLqZhQSnTKEdsgYAcucWymOoYrJrE1jh1tFeobkBxtpb96QVxh0
	A9fsznWSwNuluBM9FAQP2pBnMklO9IN4+s34MES/yuT+FOjyHf3EgyP1OVf+Fw2on2EfhjKY9nc
	uOPK+bGInYQLusuuC1vZp/j+A4O6lSShfGa2E8RqS9gQpHbS3xlZU4CWYrbT19qQlmwDE4iahIv
	2KC3XFxilNqIcmyG595d+QDzihs2I79HKjguU5rhqZWPuewK9ygosccBuikinOgaEJyvpyREYQ=
	=
X-Received: by 2002:a05:622a:259b:b0:4b2:f2b0:32f4 with SMTP id d75a77b69052e-4b31dcc27camr87769571cf.82.1756739694449;
        Mon, 01 Sep 2025 08:14:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoSuUWq8d1895qWYOM3TzW432SYmyk5JdQIz0QDRVbZIJavWFSwqVy3xw01uX0V5tPr4oIyA==
X-Received: by 2002:a05:622a:259b:b0:4b2:f2b0:32f4 with SMTP id d75a77b69052e-4b31dcc27camr87769091cf.82.1756739693926;
        Mon, 01 Sep 2025 08:14:53 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b30b67894bsm64286011cf.33.2025.09.01.08.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 08:14:53 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Slava.Dubeyko@ibm.com,
	idryomov@gmail.com,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH 1/2] ceph/mds_client: transfer CEPH_CAP_PIN when updating r_parent on mismatch
Date: Mon,  1 Sep 2025 15:14:47 +0000
Message-Id: <20250901151448.726098-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the parent directory lock is not held, req->r_parent can become stale between dentry lookup and request encoding.
The client updates r_parent to the correct inode based on the encoded path, but previously did not adjust CEPH_CAP_PIN references.

Release the pin from the old parent and acquire it for the new parent when switching r_parent, ensuring reference accounting stays balanced and avoiding leaks or underflows later in ceph_mdsc_release_request().

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/mds_client.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index ce0c129f4651..4e5926f36e8d 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3053,12 +3053,19 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 	 */
 	if (!parent_locked && req->r_parent && path_info1.vino.ino &&
 	    ceph_ino(req->r_parent) != path_info1.vino.ino) {
+		struct inode *old_parent = req->r_parent;
 		struct inode *correct_dir = ceph_get_inode(mdsc->fsc->sb, path_info1.vino, NULL);
 		if (!IS_ERR(correct_dir)) {
 			WARN_ONCE(1, "ceph: r_parent mismatch (had %llx wanted %llx) - updating\n",
-				  ceph_ino(req->r_parent), path_info1.vino.ino);
-			iput(req->r_parent);
+			          ceph_ino(old_parent), path_info1.vino.ino);
+			/*
+			 * Transfer CEPH_CAP_PIN from the old parent to the new one.
+			 * The pin was taken earlier in ceph_mdsc_submit_request().
+			 */
+			ceph_put_cap_refs(ceph_inode(old_parent), CEPH_CAP_PIN);
+			iput(old_parent);
 			req->r_parent = correct_dir;
+			ceph_get_cap_refs(ceph_inode(req->r_parent), CEPH_CAP_PIN);
 		}
 	}
 
-- 
2.34.1


