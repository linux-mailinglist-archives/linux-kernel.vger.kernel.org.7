Return-Path: <linux-kernel+bounces-773883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8B1B2ABCB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1C161BA7469
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438CA1E8836;
	Mon, 18 Aug 2025 14:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="qKal9UKa"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF95635A2B2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755528301; cv=none; b=fNBNwbbHfTNbepPcN3vOJvMqGXArQjj886zMYM6RloOQXIE1JpSZZGrGSo+CvBKyx58e8ZCiikgtRW7+PsPgXytmG9RrdbVuut9df4+nd+YEoCYWDPjw6J9NXhbX2sbfbfKo2JQp4qPxfCNdxlQtydbBIfWG2vNYGH8r7Ov9yfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755528301; c=relaxed/simple;
	bh=7w9RInTYAzbNcsrQPptuJXaRVRPQLncyuDK9SXdi+7o=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Nr2w1M5aV6ZKeCI7nVcr6PVso27XK+n8RYukr4tisSNbVWLBACr1apPVqBFbxmrRqhBE79XqdaB/ljwB1S0xDc8227K5+xAtU+Rrog/lSxGVT0q+Ic99oOgADmIUwjHsuwDdZtIUEjOnqkRlgtayV4uDBmpKgIrey0mVKPuRl3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=qKal9UKa; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1755528293;
	bh=LqLLtWOIbYpdhN63Gaju063UjZzQBe2vxmRPt7noPkE=;
	h=From:To:Cc:Subject:Date;
	b=qKal9UKarchSzBRxDlW1HHBtUuXNdEQ01lcekjvaaD6GvtO1jMIVtIUY8kXpj56Y6
	 RLGBl6m+BBXIwV7tH1TPw+XpMe3ujaqPMZHX64RsuGA4LuP8c6o4auA4ddx8NixVK7
	 pBZuTYI4EIkN4LKevPYQEpeTEPQwHiV2fZPHxYlw=
Received: from zm.. ([2408:8340:a29:3fc0:20c:29ff:fe69:94c7])
	by newxmesmtplogicsvrszc13-1.qq.com (NewEsmtp) with SMTP
	id B342E2AA; Mon, 18 Aug 2025 22:44:52 +0800
X-QQ-mid: xmsmtpt1755528292t3poiqlkz
Message-ID: <tencent_9DE7CC9367096503F6ADD2BD960079267406@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85NoO6R2+tnWRSxYDLXxmAumKWjcvwRqDFOCrv/NAyfoCuQd4F2iHb
	 VxwxcL1rzpoUU6kdYpyoTETQp4HDz7sTSNu0bVZSIdwj5gqxUz5fWNBUAb7FMaixdXIyr1ue775U
	 G1TlcHOGBQaQvKMtwDgjJJ5HCvbnwhKURj1MMsnVFO7t88vhfWFQ77ol/Od7Lz6zomn6ZX2uuZ0p
	 gGNd5QwysTO4i85wVhJvhK9RbcbJ1fdVQZI1VNyGTDn4szqvueUDBSZYSzBxkgoWOR3x+FVcSi3y
	 YxjoRpYap08L0v6dTdmHg3cuk1ZvoqEVij7A1DewvPQpS9daNlVoLKi5FIEjtPIKhYxfB4kX31YF
	 3FxGEe7Eb/GndPzwgtpszdUy2ppvnE69Nt/CophKxwkAS8QMb8IKeblc/gPBihkiMy9mununshxz
	 Yu2bIwv7YZQ3j/VkJ1Bz6RDQhvWeZ/OmuYPSxp6jJQVQxphv+P8wpEJq9wzA2cTbcKuGk7CIqZIV
	 GSG3JeQ/zGYObL5wJUVu+gQwqFThOhuayMLgyCJEGb4WSTof6Xb5VyHBncXgjgQgMC0XfoYydJs0
	 T7pgo7EE7OVRFQano8MO2Zx7Z+UAG1BkZOh/Q/2w0HQdLVcUxPxulUoiEMiyc0s/jQzGSncb1BA9
	 QQ40DlXeZRIrnPi5jj7JX64OrKV+30RW0Avxu8fg+cAy6IiRxyIZy6slz8y3WrMxrH3itBCBQU7z
	 pAGINAu7Zcs3KAchhbdrZWh+qiW4Fyj6bGwNlNDW0gIhEPEHI0TDrHzciDL+MJMfJ8S//eVi3LRD
	 eyrwftqEjx3eOP3gs0VJoCTvbSaXfwhKfb2AdpmeeLhmRJ/bN0IUyBlCBi4o5tE12qRTjhvGOms4
	 3DNaAEA1ZJbBmi0Ri7fN/pn1fKZs2G2Ds6yynbfQmLL4GlJ3u4lA7q3G5w90ErUt8j8jvXvAtyuo
	 Djm8OEeU8aW+lT6q8q6zKF5f7rZEohEj3plAzxKiGnzJZA9fVDQv+MX9FsCfIenNu0SKEmhhY/42
	 oDDk4B/Yr0otRfU4qCIvOiVdoZMqFsYSi+tyStJAsGyKny4bPsuj1mZLjuL8+xfFi5p9d4eFbYoj
	 2BOy0o
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: zhoumin <teczm@foxmail.com>
To: hirofumi@mail.parknet.co.jp
Cc: linux-kernel@vger.kernel.org,
	zhoumin <teczm@foxmail.com>
Subject: [PATCH] vfat:remove unused variable
Date: Mon, 18 Aug 2025 22:44:49 +0800
X-OQ-MSGID: <20250818144449.1143692-1-teczm@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused variable definition and related function definition
and redundant variable assignments within functions.

Signed-off-by: zhoumin <teczm@foxmail.com>
---
 fs/fat/dir.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index acbec5bdd521..92b091783966 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -1209,7 +1209,7 @@ EXPORT_SYMBOL_GPL(fat_alloc_new_dir);
 
 static int fat_add_new_entries(struct inode *dir, void *slots, int nr_slots,
 			       int *nr_cluster, struct msdos_dir_entry **de,
-			       struct buffer_head **bh, loff_t *i_pos)
+			       struct buffer_head **bh)
 {
 	struct super_block *sb = dir->i_sb;
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
@@ -1269,7 +1269,6 @@ static int fat_add_new_entries(struct inode *dir, void *slots, int nr_slots,
 	get_bh(bhs[n]);
 	*bh = bhs[n];
 	*de = (struct msdos_dir_entry *)((*bh)->b_data + offset);
-	*i_pos = fat_make_i_pos(sb, *bh, *de);
 
 	/* Second stage: clear the rest of cluster, and write outs */
 	err = fat_zeroed_cluster(dir, start_blknr, ++n, bhs, MAX_BUF_PER_PAGE);
@@ -1298,7 +1297,7 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
 	struct buffer_head *bh, *prev, *bhs[3]; /* 32*slots (672bytes) */
 	struct msdos_dir_entry *de;
 	int err, free_slots, i, nr_bhs;
-	loff_t pos, i_pos;
+	loff_t pos;
 
 	sinfo->nr_slots = nr_slots;
 
@@ -1386,7 +1385,7 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
 		 * add the cluster to dir.
 		 */
 		cluster = fat_add_new_entries(dir, slots, nr_slots, &nr_cluster,
-					      &de, &bh, &i_pos);
+					      &de, &bh);
 		if (cluster < 0) {
 			err = cluster;
 			goto error_remove;
-- 
2.43.0


