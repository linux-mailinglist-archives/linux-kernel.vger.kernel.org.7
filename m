Return-Path: <linux-kernel+bounces-844798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CEDBC2CCD
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 23:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E3511350062
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 21:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459F12561D9;
	Tue,  7 Oct 2025 21:52:29 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402BA246BB7
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 21:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759873948; cv=none; b=qyNA7s4TFJdt0ZUfwyradOVy3lxozcsr1yYeKM494humi7hRDoHYJLljTVJKUQuMhqhRExz+T9sEDDvLNoLNS+QASa9FpnBqOlWM9SzTIr4rRJV64qarr1WRsmSyXjDb3KYsLxuiuUEjKQkrg8Pfr6D4dReiTz3/vEwqULA4UJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759873948; c=relaxed/simple;
	bh=Rf/Q1Iv6JMPmtv6eqR6d3PLk/+uH64F/ZMLm0Ku/lfI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bXOJPly7aG9WFFuhZG/9D5bk6jmVSmblLTXJkCz2vemupSyIBxyK2utXxV+0ZIoq2/2XLCRMD3/jqspEul735Ncp37YpL60h+bBQfNI69IiTtTgmexZOO/iaKt1jw8c23OgZuO480aOUrf01Q0t99JWVljWkRThQr0EFCgi/sSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-91b3cc5aa6aso1602729339f.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 14:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759873946; x=1760478746;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rr525ggriPbti9RSgts0y1f0Wmcz7fRKptJXoPmGDnk=;
        b=iG1c7rLMoTaMCpIb0YAJZIArww8XYi4ZKKWc1QQwmSdSdMvEA4LbSfUiH5vY9d9519
         TLzohAArOje7l59QrefujZKDB9XUzvy20no89zah/Ga4aZJw7lj+C8Y8qRZHDZSsqvjT
         q+pfVAlVZKIvV+dmb7FjEwgd0kp4pJWwk3fm6bXY2RQmiqcVnAefOqJ7xOHwtRNgblu5
         JkZxx04qB4Yro5INJJuJXtgar7WUZjjQmfhn2S21a8hQxtvIt0R1F8rQ9Ov4ISfyvzgm
         4G+0BgUN3BsZ3g6lAScBXJYglxcTiX/4NQ/67UkIQaQ9XbUTWD1SfgyCEg11oB8SMPKs
         /7vA==
X-Gm-Message-State: AOJu0YxmIG6cHQz3cflwURYkt9N9uoNX31dYYV+fy6Ias2f75cyK7M3c
	1aYGfKfO65HfUDJWQmtVKR+1dDrvPWRWmqCDbSBtRXULoucgju8CxqpB3XLRhNZXC3Omwl7oDTZ
	U7qZU6ygU+dnSUVGi87qmT1+bGJtBe0sUKiRSaI+/WLemRH7UkvZryzrf5ig=
X-Google-Smtp-Source: AGHT+IHFVNodcufQDyW7chzPvwMkn+Qyshs/Unn2TkYUYRDlU2YicbMB35nWylSfks2hDv7F6i0EgAk10zmvDxmjq6ky4pI1U+2j
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:48c:b0:929:11b1:9bd9 with SMTP id
 ca18e2360f4ac-93bd1970ea3mr94500339f.10.1759873946385; Tue, 07 Oct 2025
 14:52:26 -0700 (PDT)
Date: Tue, 07 Oct 2025 14:52:26 -0700
In-Reply-To: <68e2ff91.050a0220.2c17c1.003a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e58b9a.050a0220.256323.0027.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+3a1878433bc1cb97b42a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: jkoolstra@xs4all.nl

#syz test


 fs/ntfs3/index.c | 10 +++++-----
 fs/ntfs3/ntfs.h  |  5 ++++-
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 6d1bf890929d..2e512abc7000 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1808,7 +1808,7 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 	CLST new_vbn;
 	__le64 t_vbn, *sub_vbn;
 	u16 sp_size;
-	void *hdr1_saved = NULL;
+	void *blk1_saved = NULL;
 
 	/* Try the most easy case. */
 	e = fnd->level - 1 == level ? fnd->de[level] : NULL;
@@ -1842,8 +1842,8 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 	memcpy(up_e, sp, sp_size);
 
 	used1 = le32_to_cpu(hdr1->used);
-	hdr1_saved = kmemdup(hdr1, used1, GFP_NOFS);
-	if (!hdr1_saved) {
+	blk1_saved = kmemdup(&n1->index->blk, used1, GFP_NOFS);
+	if (!blk1_saved) {
 		err = -ENOMEM;
 		goto out;
 	}
@@ -1924,13 +1924,13 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 		 * Undo critical operations.
 		 */
 		indx_mark_free(indx, ni, new_vbn >> indx->idx2vbn_bits);
-		memcpy(hdr1, hdr1_saved, used1);
+		memcpy(&n1->index->blk, blk1_saved, used1);
 		indx_write(indx, ni, n1, 0);
 	}
 
 out:
 	kfree(up_e);
-	kfree(hdr1_saved);
+	kfree(blk1_saved);
 
 	return err;
 }
diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index 552b97905813..d5e2b22eacd7 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -754,7 +754,10 @@ static inline bool hdr_has_subnode(const struct INDEX_HDR *hdr)
 struct INDEX_BUFFER {
 	struct NTFS_RECORD_HEADER rhdr; // 'INDX'
 	__le64 vbn; // 0x10: vcn if index >= cluster or vsn id index < cluster
-	struct INDEX_HDR ihdr; // 0x18:
+	struct_group(blk,
+		struct INDEX_HDR ihdr; // 0x18:
+	        u8 data[]; // NTFS_DE entries
+	);
 };
 
 static_assert(sizeof(struct INDEX_BUFFER) == 0x28);
-- 
2.51.0

