Return-Path: <linux-kernel+bounces-738234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9E5B0B62A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 14:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDDBD189C5BB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 12:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3ECA1F4CBD;
	Sun, 20 Jul 2025 12:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMbN+Ps3"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C4014883F
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753014939; cv=none; b=AoImz0St20SPnku2zGW9+bZS+V7bzYd5DBvexJ/kU604v/qQi7AIfVjek2dPygIM0ehKvKpOPu2DdnErMkqBDe3EeODS2fhoO+W+n/XY4lhT7IvU86ZUAzxLs8JxrZyX//Y2qbalLyHZUDIBDwD3Sc01SFByQ+I2JVxxmjz26a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753014939; c=relaxed/simple;
	bh=ketLqKFFTY5sKz4Uj1TPwYnZfPbvTgiKpE9+OUNJL50=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rAZMQ8S5G3MNWO0ZL23DZzgJKfTDKisLvSseDGpV8hwQrpRhhVVH5eA8VOqTltZFw4MiFhzkOkQCALMlIWD6LOXg933Fzg5i4TuRNcn9JBGwRleA+uRefRtKzvMqDxQDIruuwfuIPOFXVKJGYqjMJvQ5Ga+RRwBGw2hn7Ph79lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMbN+Ps3; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a53359dea5so1585406f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 05:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753014935; x=1753619735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FzKU43pjr3/mF7CrvVumKQL3i8Jq66WLkKzFxaNI6/U=;
        b=TMbN+Ps3pl8Pk7KPohphdjLIegR4QjKLK2YYSRED+goxINAaHmYU1nR9SYqipEFG/a
         0yJgaJgjDeerszv4isyeXm71R5LMUHv2LRQ4Fr5ZzZhTaPKz2/JMwWRW3/W66XoIpMMa
         sT5MdfsKwLnusjZTVJQUbvWl8Zv7uxoIhhmOsmbDe6N1CBO6EqFYOw/vGj6d3wVowu91
         Zhcco9qwR4bytcLQeo1MuJTKqn+NmschmMeCmyTYYQ+pn91mtRbfPlaxRozSFvUyEgpn
         K0dIazHQBMIrIKzirYqv0OYuIeamFpBSq22/fneTkPYie+Ao8iU3aKMWmRc76JjDJu80
         mEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753014935; x=1753619735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FzKU43pjr3/mF7CrvVumKQL3i8Jq66WLkKzFxaNI6/U=;
        b=bLKSqtXpPDdglrkJZuJkNgSP1iHzAqJ6NBU2QIv9TZTueptka7CpY+Hysu6Otg2Ntv
         3vZ6DR/TgyJwaY+8FaNOMovR7tKxgMg4lMbEfWjSpmLWFZeynyvp5zUsZbdXvSlDjhyo
         7yeQKE2QctHcJ997LUBpLdkwV+a6fHDFTQYOFTpfHW81wRolVZasFFuHL76Bqnq/Fi6r
         t8FY/ps3fAVu5AhY2WyM7iuBIj48jrJLj3IyYF53STfjnh8dT0ct33yW8h98sc4qT9M+
         3F0f1nKi3SGw/FdhD3zg9A7lrh0hgofb2bqbHMXVZRz3Fkfsw4Pw5PSL/y7TiSlVRnD+
         beTg==
X-Gm-Message-State: AOJu0YxZiwzahHyDKfGsySR7Po6mZzSdByv8LlShhrk7EoMkX/tm79kj
	MIBaPY0W/yeBlGcMib0b4njPwogtpYIKTgOHK3fNtduqw03nbs+yT+bdadNQ/V+Jz3U=
X-Gm-Gg: ASbGncub/u7DPTsFr5K0hZEUiCRVFyur+tBGIVyOvNxIjhVRitwlAwDC23VxeNEZd3h
	ywTQzJQzWI1nTPfoNC5POb9LbcGfNzWbWShSRO4fHKxRFgEZUHuBNcjF6ZwPfqtntVuMr6elZHU
	kaXcY+QGvnoaCRJCRso9ZCgw3JJjrH0IrXXKTZDENfoJ4atop/4SU6La1SD/FO6/LjAdUJX32l/
	IMq+E9Pu8wuSGgKVjmoobxr5sflE+7xIaBkJ/C3I1uzkyYAmQ8/vxcZW7jn/ZPKv1r3EkGoYmP8
	8s5J92Bl96nLl16wglnKw5NhNbtWxdh1ab4ZhwSjm1WLXpp54zJjUz5a+5ui9cIdAiqt4pbF67Y
	c1heqOzlrg0Zsc3K/thVM3AIedH2jZ3WDjIF8PA==
X-Google-Smtp-Source: AGHT+IHZ4lgneia1CzRiBOkKcikdLAnN8KkL+znJ3UsrdKutEnfeG78YVB2OT4K34EaydkYzdEQ+Og==
X-Received: by 2002:a5d:5c06:0:b0:3a4:ec23:dba7 with SMTP id ffacd0b85a97d-3b60e523dd1mr13968408f8f.31.1753014934484;
        Sun, 20 Jul 2025 05:35:34 -0700 (PDT)
Received: from localhost.localdomain ([78.210.47.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2bf4bsm7384532f8f.31.2025.07.20.05.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 05:35:34 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: 
Cc: linux-kernel@vger.kernel.org,
	apokusinski01@gmail.com,
	syzkaller-bugs@googlegroups.com,
	syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com
Subject: [PATCH] hpfs: add checks for ea addresses
Date: Sun, 20 Jul 2025 14:34:27 +0200
Message-Id: <20250720123426.132651-1-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The addresses of the extended attributes are computed using the
fnode_ea() and next_ea() functions which refer to the fields residing in
a given fnode. There are no sanity checks for the returned values, so in
the case of corrupted data in the fnode, the ea addresses are invalid.

Fix the bug by adding ea_valid_addr() function which checks if a given
extended attribute resides within the range of the ea array of a given
fnode.

Reported-by: syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com
Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>

#syz test
---
 fs/hpfs/anode.c   | 2 +-
 fs/hpfs/ea.c      | 6 +++---
 fs/hpfs/hpfs_fn.h | 5 +++++
 fs/hpfs/map.c     | 2 +-
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/hpfs/anode.c b/fs/hpfs/anode.c
index c14c9a035ee0..f347cdd94a5c 100644
--- a/fs/hpfs/anode.c
+++ b/fs/hpfs/anode.c
@@ -488,7 +488,7 @@ void hpfs_remove_fnode(struct super_block *s, fnode_secno fno)
 	if (!fnode_is_dir(fnode)) hpfs_remove_btree(s, &fnode->btree);
 	else hpfs_remove_dtree(s, le32_to_cpu(fnode->u.external[0].disk_secno));
 	ea_end = fnode_end_ea(fnode);
-	for (ea = fnode_ea(fnode); ea < ea_end; ea = next_ea(ea))
+	for (ea = fnode_ea(fnode); ea < ea_end && ea_valid_addr(fnode, ea); ea = next_ea(ea))
 		if (ea_indirect(ea))
 			hpfs_ea_remove(s, ea_sec(ea), ea_in_anode(ea), ea_len(ea));
 	hpfs_ea_ext_remove(s, le32_to_cpu(fnode->ea_secno), fnode_in_anode(fnode), le32_to_cpu(fnode->ea_size_l));
diff --git a/fs/hpfs/ea.c b/fs/hpfs/ea.c
index 102ba18e561f..d7ada7f5a7ae 100644
--- a/fs/hpfs/ea.c
+++ b/fs/hpfs/ea.c
@@ -80,7 +80,7 @@ int hpfs_read_ea(struct super_block *s, struct fnode *fnode, char *key,
 	char ex[4 + 255 + 1 + 8];
 	struct extended_attribute *ea;
 	struct extended_attribute *ea_end = fnode_end_ea(fnode);
-	for (ea = fnode_ea(fnode); ea < ea_end; ea = next_ea(ea))
+	for (ea = fnode_ea(fnode); ea < ea_end  && ea_valid_addr(fnode, ea); ea = next_ea(ea))
 		if (!strcmp(ea->name, key)) {
 			if (ea_indirect(ea))
 				goto indirect;
@@ -135,7 +135,7 @@ char *hpfs_get_ea(struct super_block *s, struct fnode *fnode, char *key, int *si
 	secno a;
 	struct extended_attribute *ea;
 	struct extended_attribute *ea_end = fnode_end_ea(fnode);
-	for (ea = fnode_ea(fnode); ea < ea_end; ea = next_ea(ea))
+	for (ea = fnode_ea(fnode); ea < ea_end && ea_valid_addr(fnode, ea); ea = next_ea(ea))
 		if (!strcmp(ea->name, key)) {
 			if (ea_indirect(ea))
 				return get_indirect_ea(s, ea_in_anode(ea), ea_sec(ea), *size = ea_len(ea));
@@ -198,7 +198,7 @@ void hpfs_set_ea(struct inode *inode, struct fnode *fnode, const char *key,
 	unsigned char h[4];
 	struct extended_attribute *ea;
 	struct extended_attribute *ea_end = fnode_end_ea(fnode);
-	for (ea = fnode_ea(fnode); ea < ea_end; ea = next_ea(ea))
+	for (ea = fnode_ea(fnode); ea < ea_end && ea_valid_addr(fnode, ea); ea = next_ea(ea))
 		if (!strcmp(ea->name, key)) {
 			if (ea_indirect(ea)) {
 				if (ea_len(ea) == size)
diff --git a/fs/hpfs/hpfs_fn.h b/fs/hpfs/hpfs_fn.h
index 237c1c23e855..c65ce60d7d9a 100644
--- a/fs/hpfs/hpfs_fn.h
+++ b/fs/hpfs/hpfs_fn.h
@@ -152,6 +152,11 @@ static inline struct extended_attribute *next_ea(struct extended_attribute *ea)
 	return (struct extended_attribute *)((char *)ea + 5 + ea->namelen + ea_valuelen(ea));
 }
 
+static inline bool ea_valid_addr(struct fnode *fnode, struct extended_attribute *ea)
+{
+	return ((char *)ea >= (char *)&fnode->ea) && ((char *)ea < (char *)&fnode->ea + sizeof(fnode->ea));
+}
+
 static inline secno ea_sec(struct extended_attribute *ea)
 {
 	return le32_to_cpu(get_unaligned((__le32 *)((char *)ea + 9 + ea->namelen)));
diff --git a/fs/hpfs/map.c b/fs/hpfs/map.c
index ecd9fccd1663..0016dcbf1b1f 100644
--- a/fs/hpfs/map.c
+++ b/fs/hpfs/map.c
@@ -202,7 +202,7 @@ struct fnode *hpfs_map_fnode(struct super_block *s, ino_t ino, struct buffer_hea
 			}
 			ea = fnode_ea(fnode);
 			ea_end = fnode_end_ea(fnode);
-			while (ea != ea_end) {
+			while (ea != ea_end && ea_valid_addr(fnode, ea)) {
 				if (ea > ea_end) {
 					hpfs_error(s, "bad EA in fnode %08lx",
 						(unsigned long)ino);
-- 
2.25.1


