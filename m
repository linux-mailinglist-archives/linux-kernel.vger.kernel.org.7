Return-Path: <linux-kernel+bounces-800482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF4DB4384C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C644E3B695E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EFB30147D;
	Thu,  4 Sep 2025 10:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sk+vC29x"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BEC301000
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 10:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756980701; cv=none; b=Yss+4DUY95lZjwv6dVxMqjhpZaJRRq76Bk/tNWQ8Atd1d01sSuna5BlEMTZd9fMgedV6Y/O9xHLfNYmigFmPL5o4Ud9Gb0EAwTxtJIIR0Dd/WkGVlFSKnzEn9P/ERm0t2ka1uCBM/E08HKlIeKzMVd65Ad0i3m+zSn4mOfu8ml8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756980701; c=relaxed/simple;
	bh=n+QGcGzoBiJgZToYbMEXGvMAS6ROjQPgsKc23+B2XY4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JLWLXHb2iXQ6uprDvHt9S6MLW13GD57px5vAkUwgzG2Z4OFoK5yKhzpuYdkaJTqJRKJ4NF1ijZyUnxzB8wrtsM1QPz+QT59rpXIYmxpYxkBxmfQFNf/FTjKroH50RD/s7uNPfuINAk1XwpU05Qh3uNNb1bOYD0ReMG/EuqnWoFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sk+vC29x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756980698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dTuny/fJgLeScyncMXmVM+uPwGn8xgCwGJTov4rkZVE=;
	b=Sk+vC29xiEWhW0YxTYz0mSyZo9lX869LlOnpVEabf9NzbMvJ4g3WQ3BlcZxISZTIYcoMI4
	FZbtCJX7dgrxtHQyIkIq/8/G/SQFBwAnLK+H4pm4mzzaB+a+m/BIQwgOvOILhVyioilQsm
	p+ZSIZVhmAMDJGzl5UGestrqbTnGfR8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-Ra0xBziBMluxzQhriLd4ig-1; Thu, 04 Sep 2025 06:11:37 -0400
X-MC-Unique: Ra0xBziBMluxzQhriLd4ig-1
X-Mimecast-MFC-AGG-ID: Ra0xBziBMluxzQhriLd4ig_1756980697
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-721094e78e5so8293606d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 03:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756980697; x=1757585497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dTuny/fJgLeScyncMXmVM+uPwGn8xgCwGJTov4rkZVE=;
        b=wMYzLffpWQf0mpFaa3MUZ97ZpvddX+dNEgTttddLU0G4j7QwW+xr9+DaC/RNcTjgja
         kPwyGwDPyWuOblGW05YsV6b5QV9PQZAbigYuF5oDuQL9Y9KZevcTAJspEuBb8WLDo2LI
         JNTUwYuJ9Ojl7r4C42blzzyx1jvjuLX3fDW33uNjj/VEQ6PdU+sXg/b58Yp7bmIbNRci
         5toaeLMWJqbFroJCBYYRb77ftsjHiYI8ykk2S7Dl8fREbt+Cvq+cByQTktUKvNjE5olY
         OMuDENTokTUC1wd/3UEVI9qeb0Z7T0Wkw0I8ZUFLTP1x36xjMDA1Mmfdoxd8IQJzP7RV
         T0iA==
X-Gm-Message-State: AOJu0YyZWhFmc64gNoJPy0ViINW0S5kKU4uqLaZaQh2TutmrkbU9oczq
	BXZZOpmV0Z7WsTkBomgkwvfcNHGkMmH0ckWXV0xNEJMHAiF76DatcCw5Vh3GFGIpxngdBM3QjAq
	ikZdLjLAGvfHneMOYZcy+m5gLdJdyhbsTxGZC09+75LE1rv3y9Eusk52Qvdepl5T6+g==
X-Gm-Gg: ASbGncvWEGVVNlEO+nvTuFJHaxqOOBAZI6EcH6avPisMosMJD3/4Je7TNfVZaKi8vdY
	DT6UjCqH0AxDbJtQR1VbBpr4cE+CfqoCJDPEU7AYmE5zrwPFY/XfbBvWyK/sBoKPsnLEF7iMlfb
	tVOJetuhUlAqsTZ/RJho2WPhoDrkQc4t7fk58RLzW/+ER5CPaOYixxB0ObOoh+SkqP746OLJIsd
	dt7EKOO3w1drMVvUMl0r5ZuHPN2Dk659tuleXXtcDcu+pEQTUycwgay6ET06w64whIYksPP4gkm
	D6yEQ0LYIS4qIrOZMBUKoeA3kvE+rcRGS6+zgWIMiBC1xTJ1hKEGSeqROQaG//3piTpky285Tg=
	=
X-Received: by 2002:a05:6214:2aad:b0:728:4af1:e4f2 with SMTP id 6a1803df08f44-7284af1ee6cmr24816306d6.1.1756980696783;
        Thu, 04 Sep 2025 03:11:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfRbfza5Si0J+blacYdsGGMX0Q3pPy9+XsQjds1RVc77U866tJIM9i75eMIudFk0VLe06B5w==
X-Received: by 2002:a05:6214:2aad:b0:728:4af1:e4f2 with SMTP id 6a1803df08f44-7284af1ee6cmr24816036d6.1.1756980696212;
        Thu, 04 Sep 2025 03:11:36 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ad2c9f5esm45683216d6.22.2025.09.04.03.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 03:11:35 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Slava.Dubeyko@ibm.com,
	idryomov@gmail.com,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH v2 1/2] ceph/mdsc: Move CEPH_CAP_PIN reference when r_parent is updated
Date: Thu,  4 Sep 2025 10:11:31 +0000
Message-Id: <20250904101131.1258532-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the parent directory lock is not held, req->r_parent can become stale and is updated to point to the correct inode.
However, the associated CEPH_CAP_PIN reference was not being adjusted.
The CEPH_CAP_PIN is a reference on an inode that is tracked for accounting purposes.
Moving this pin is important to keep the accounting balanced. When the pin was not moved from the old parent to the new one, it created two problems:
The reference on the old, stale parent was never released, causing a reference leak.
A reference for the new parent was never acquired, creating the risk of a reference underflow later in ceph_mdsc_release_request().
This patch corrects the logic by releasing the pin from the old parent and acquiring it for the new parent when r_parent is switched.
This ensures reference accounting stays balanced.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
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


