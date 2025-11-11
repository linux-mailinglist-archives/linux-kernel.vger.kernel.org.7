Return-Path: <linux-kernel+bounces-895259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 109D1C4D622
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 131BA4EF4CC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5CB355800;
	Tue, 11 Nov 2025 11:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="LF4QjV/W"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0E734DCF4
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762859955; cv=none; b=JaSvoy/2fTZ5hBa/tFWwpIebBFsH+cLyyfifadYwjseqMpH4DlmG6l+trnpS9EMPVkmgrhVD+igu/r/TzLw5GxftV5BnsAzyVGR15SCI5jGXIumzfhAYAzkZ8uANvT3dHCWgsMQRjE5lzUwNb143tw1GRxSH0hBR44grXcU7m9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762859955; c=relaxed/simple;
	bh=qUPdyWreFV1lPbWkZi9HrJb9CBDP9RMP7SqB5J9u/7A=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ARHZLIdj+lJ+hWSsxUTGHGKSeYtQ/w5TroV24xl/jc2/EP/6QorG/Q6IrsERyLCbcmLl9uVo/uts6tkwGRxMPM2JeS1mlEkqbz21Q5NKJ8Rkqk1o9jHpPeouwkCtNSOXVER9vYyarDZ86Y+JN0VRBG5tlCgRvaExdfrmj/jXx+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=LF4QjV/W; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1762859638; bh=taXUVma0NRozkDssCapELyL8AA0H9E6fe9k8SGAz+xg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LF4QjV/Wobh+LSW4Z4vWUpO/kvBnq00TpokSJoSwTLJus9LGcZ/19jjF2S8kiu0Hr
	 Rtj7PuJKL8yNFTCmsLfDi4nnAfnrxmMHZnSXPvZwNjeXmhNkDp0HrdEStfrY+XzaGu
	 +dMleC5iwyJ17QnWK1BYuxp4t8g/dPH93iXTT1CE=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.201.7.117])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id 377862D6; Tue, 11 Nov 2025 19:13:55 +0800
X-QQ-mid: xmsmtpt1762859635tobyr8oqy
Message-ID: <tencent_046B83AAE44C976C976926C9936903604905@qq.com>
X-QQ-XMAILINFO: NZSml8PQdeKATZu7Oi29OrL6p4nZCwdAumMuUoAO7ogqU4gDANGJwIkk9PT+nH
	 34QYt+uV4WPwAUjbKcaEBNQmZMmajqhzGDLDRCZz9fJ6xHuLgRheVuhFNco2AniZGs4N/vGBqh6y
	 h+/tM9CED4wVNFr5B+q45ObLgSK3nEjrLPvt9myXYfbHzBKZeFLVohXeTVNqyGCT410pnpx55rWm
	 JDvgDyHbR/BBmdlCk0lYaHehqg8NRAgujIBP9khYm39NbaXfWzsTokdjGoTNjxsCmXFkmXv7JIrq
	 cfSui55ICmUHbfKaUkjsF3JhbZdgZkjI2pgQmwCytRvXW2RhqlK9CMWwj2S0EtUX27mzN1wmZC64
	 tazlskO+j9CGhwwVTzx4iuQPN183+tDyHNa78PqGAgM/PGNQBhtdYl6KMWAEFsHkZbTjE0GPU9nY
	 g1GZ3+2sfeKFRyLoYN4jXwQeZHuLY4FD1+iOpAy/ZqMxbUn8Pfr/WDm783bG6ooY1vjPd8PlBmo1
	 tO+L7560hPZ/E9NANQXkvyImSNGKDBqYy3d2+N+x4ooV3FMVSp8jdNG/t93/AVrWzKgqZe4X9lzY
	 9xzp/TX51Bbo+YWNGqsHQa1mmnnECya8mVE5okUVN0J6Ol0ge8qdaF8yIi96gSRSBcrHTn+w6EGG
	 0FbhQtWXIFIPRdap2YkwdohFrAm+Z075jFEjc5wjk0sWiMNZduagNWmrlxvWfQispPVYRCPJiVwQ
	 YL0vxtDIe4kIJJIagkpNgHkD1a4XUFJ3rspfl3XeDoQcK17FX3F5hkIq6KwAWVHSg3F9sIPjeYuZ
	 GO0IVaMK54CyRZ8knyiPnLmX+avd6mUEq7gjwbn6aWK/dJuJn727u2E5DIkxjk4CDOEisjikKCtB
	 pWG7OsYOnIipfOr4GZwqXpVKG5p+uLHVUCKrMFC2YY71831MyWBGYyUhwDKZuwI8/DJMIARPaRl7
	 XxzHYNbG02N3A1AZfqtKCY0DbpjTS1GrPVDgn3e+4z/yTzD4jNsNd41/oNJOrlpr/lF/Lv5jyfeq
	 Odq9/dsA==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+3932ccb896e06f7414c9@syzkaller.appspotmail.com
Cc: almaz.alexandrovich@paragon-software.com,
	linux-kernel@vger.kernel.org,
	ntfs3@lists.linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH 2/2] fs/ntfs3: out1 also needs to put mi
Date: Tue, 11 Nov 2025 19:13:56 +0800
X-OQ-MSGID: <20251111111355.2274848-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <69122a96.a70a0220.22f260.00fe.GAE@google.com>
References: <69122a96.a70a0220.22f260.00fe.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After ntfs_look_free_mft() executes successfully, all subsequent code
that fails to execute must put mi.

Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/ntfs3/frecord.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index b6cbc1fc3455..e5a005d216f3 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -1017,9 +1017,9 @@ static int ni_ins_attr_ext(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le,
 
 out2:
 	ni_remove_mi(ni, mi);
-	mi_put(mi);
 
 out1:
+	mi_put(mi);
 	ntfs_mark_rec_free(sbi, rno, is_mft);
 
 out:
-- 
2.43.0


