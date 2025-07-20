Return-Path: <linux-kernel+bounces-738229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36183B0B61E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 14:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE302189B848
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 12:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382861F4E59;
	Sun, 20 Jul 2025 12:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmAsXNHG"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B4C2F41
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753014581; cv=none; b=Hlxv/cWb26vg6SjPMLsyzo721Q/mUKTkztgYhGZVDjSQRtdPzTkrL8pGB/MBrBRPgpE6QvZhMHpTRKSJKSePoD+ZmENZo1EEwYKIFIvcfxXiWfs4fbOLQQ4Y4/2ja6C4+5E2yrsn9WTwC/8IOyCJYcST+D5mciRmeDg4/RyHX/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753014581; c=relaxed/simple;
	bh=G7UAIJ2INfFcC+bmW5eMgzW7c4+mUgdNKprOnCrXONU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tERb/1RAHMmZ83nIlA8WSNO17RFqZ7lZNy1AMXFHdyLswfbmDmgTRjDya6XjSvomKfJM5tISe3Xea0oOym6nTYyuhbfPEiAME2mnIyYLG8WUlzL9ksd8ckMEb1tcjUeAL/lTZ0K4ITpV30FIa72wovMm/SvTd8TMtZBtIYh9BOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmAsXNHG; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a57c8e247cso3225080f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 05:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753014578; x=1753619378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8YyRKB49KECbV96SeTe/YVTPsmnLn5hgHKKXODz95NE=;
        b=cmAsXNHGevONB8F0WF98O9qndOOph7G/TdJ5TQ3i25+tQMB6rG9TDm92dxMs0XwyKk
         41QSRQd+5UfIHscYNO5tgSkkUX2ZtCpwRhLivmq2DZ/oV7dIZEO0ULaYMkBjJotOyFnS
         8ZBNo2SgFJrwSaS2K5iNfLnZhXDd+ulkag9oReGsWm/Mqq42FLv5LuxK1jrqmvm1tw1U
         xZeQG1Rj8W7+gZYdj0YAL+glYBAMdtpoZH8F/BfQ2st18t2/6lu6apsVLoqX2bKMelFv
         nhYUZtUBrEdCf5OgajdD0hWhXm0419CLebyhW3XBWOLHLeJpHaLCyra8pvakP+jXRD0c
         aGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753014578; x=1753619378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8YyRKB49KECbV96SeTe/YVTPsmnLn5hgHKKXODz95NE=;
        b=FQBey7ZAmRIZKKTYIsqFKkFnSZ7XfwDz3LYqr2QsW+BDIFvH1EbtNSETAi0Be/RWxo
         /upy5d9bBO/gKeMWETZsFmDrrWdNSledapi5haL9+0gipDZaa8zoTl10M3Wywg36ScEo
         xPOJcCG8nPGHZR1J8x/M6otljvWopwCqABXK7/MZION2dZSNgAR082bEwR1k2LxYvScW
         Pp9BcCI3V6Qg+RltjJrooG1yp1bgmnXqcqkGWAc/r+n53E0sLlZyJ4WsAl1EILiC2dHh
         lNqgN9GUcqyEbhaSDPjOMP7rX+uvu4SVn/VanZxYFaGeSnkTydO5GJZE62qcZyES/afP
         au3A==
X-Gm-Message-State: AOJu0YzvXe9SrIs292zgrXh+n8B15BD9aShFgW/19ohHnm0tr5Z4vVup
	o86iLCCcWNyMpeKXvD3k3tSGx9brwEIS/sQ0qoaa/5O0TcaFoy+irc9s+LA7Z0TzwTw=
X-Gm-Gg: ASbGncvRfPIYTm/VyNh6TNt0/v0iatf+i/R2jp2jmyz5YaJcN5km9LAmTITtC3fn4QQ
	lZcgIIBIcBtmMUJ8cHWI+NvJ5Bpkdc0wZHu7TYn26q2yatxCr60gjhRUjAJ76gNggNx66RX511j
	SjD6sFBime0EZ9oZiyNYnpac+7IOKn/BS9k8Go8vD6IUL4D2ZUDWdPIL2h4sEZ+WJEg/LXAoCXU
	x+6nREP0zfJbYUQk5ZHkdfGba/NSmByjIzdButiDaU8BTqLOgiEqlBkwB7zqrl5pNq844SkaJtG
	vR54II3CuBcOadJ6NujzgJsC1ktgKFrh9CxRnyorxmhqCw31ic/NdoZ2V5JzgPvKPGz+Rr/VJJ8
	joxQrishCFAECsUx3FNnARdzizFPjFY2O7yQkXw==
X-Google-Smtp-Source: AGHT+IFJcVEHvVJedlkCx1BdhB08z1haoEdmldeZpgdZLpYqYk5v9JO6rnTiblYKMRmQz8z4zK3M4Q==
X-Received: by 2002:a05:6000:20ca:b0:3b6:162a:8e1c with SMTP id ffacd0b85a97d-3b6162a941amr6158784f8f.54.1753014577778;
        Sun, 20 Jul 2025 05:29:37 -0700 (PDT)
Received: from localhost.localdomain ([78.210.47.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2553esm7238702f8f.13.2025.07.20.05.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 05:29:37 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: 
Cc: linux-kernel@vger.kernel.org,
	apokusinski01@gmail.com,
	syzkaller-bugs@googlegroups.com,
	syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com
Subject: 
Date: Sun, 20 Jul 2025 14:29:04 +0200
Message-Id: <20250720122904.131650-1-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subject: [PATCH] hpfs: add checks for ea addresses

The addresses of the extended attributes are computed using the
fnode_ea() and next_ea() functions which refer to the fields residing in
a given fnode. There are no sanity checks for the returned values, so in
the case of corrupted data in the fnode, the ea addresses are invalid.

Fix the bug by adding ea_valid_addr() function which checks if a given
extended attribute resides within the range of the ea array of a given
fnode.

Reported-by: syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com
Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
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


