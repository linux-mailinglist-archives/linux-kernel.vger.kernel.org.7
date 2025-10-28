Return-Path: <linux-kernel+bounces-874674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 15668C16D37
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F368E4EE056
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB3134B408;
	Tue, 28 Oct 2025 20:53:24 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABB7305E02
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 20:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761684804; cv=none; b=pq6FAKKVsZ/2laVZ2z3DY3S+UDT+n0Idsh4kMSS4GnauextVIwhDXYA7zXuQ42ar75lrywmuAIEiIJpgWRu8/4JgXY9RavqhvQqjuleUakGNjXS6BEdx7JAvCXxBPRNHs0j4ULkHk2p630w3sCPE7DTaS9NZmbxBiTp1pz8FN30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761684804; c=relaxed/simple;
	bh=qy5DR22/2TkRmqDfLxLhRbat3hCdawthKRYvkTR2sk8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JvZIjeGP2FRMUrULo3lYryoAcXihFZslbrwJBAkklf81t8xXJnG3pNJ00p8GUtw/dedm+G98gIze2QnJ62oZb9HAZS174Y0fCIrVY3+qI64RRGmBjrsLcpKzd/7x/OhwRULwZ9MEIOY59w4BumkkkE0/B50RUN6uycpRvflf7kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-945a07d5fa2so359001839f.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761684802; x=1762289602;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b7h85lJ5JK3rJ4Avl2ksJFYpt9YqejPUlLpo2xfb3Cs=;
        b=tQosMAJj+I13/JUy2gL5IMbRYMsfYjCjeK4BVL+u53TPgqeYA/2KcmeaxzEaXDid16
         ST3VZuVg9yVX9Ny5HbUgv+wPQEd/NkA+tn2SEr0w8rBTy6YESV1WogNs3olxa2aiQkU9
         0gD1RS5z4lSFabjHtAnlEJlbDjh3zGe29QUxXQkhTzl/XMzPt08Yf+jb5px5NVdt1UsM
         HOo5fU58e49GqwqF6FRRm5zDJyjON8PAOkPl3B6U6FJvo5RP9z06xFmm/JVPBFFx2Y+l
         +kQL6Gwe46FSUhaE7kRV+znMwqEJOZ9ZF/H5D4Y8m6Fz957xfTeWWjwI3TZNRwRh6Wye
         t7Ow==
X-Gm-Message-State: AOJu0Yw/jJUXpDksYKFn6KInkng1CwipZbV5AmAPtMX4rW6alR2tV6hQ
	CnvMtLvPGcF0q0lId5HCszrurI8f/ovgVzIwxiHefiWizXE17oH1fi6rIa7fXr2LrJrua6gikHt
	rqCCMv3nXYTzUfpxbYXLI4OUVJJx8Y/n7Gb1xElvKfwgIZ01Ok9kA6o6CZ9c=
X-Google-Smtp-Source: AGHT+IFR6vvnpdmvk0yereN8Jfxa2n3TSsX6uvVU7z7ANbvFnt4s5s1ytAd4/anJW2QzY/i2ehIuW8HuVG4UtBJo+egmzqAwh4nw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa1:b0:431:d95c:83d6 with SMTP id
 e9e14a558f8ab-432f8fbf58dmr8962375ab.11.1761684802030; Tue, 28 Oct 2025
 13:53:22 -0700 (PDT)
Date: Tue, 28 Oct 2025 13:53:22 -0700
In-Reply-To: <68fc0765.a00a0220.9662e.000d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69012d42.050a0220.3344a1.03ec.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+cd7590567cc388f064f3@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: jkoolstra@xs4all.nl

#syz test

---
 fs/jfs/jfs_dtree.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index 0ab83bb7bbdf..e919de01c42a 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -170,8 +170,8 @@ static void dtGetKey(dtpage_t * p, int i, struct component_name * key,
 static int ciGetLeafPrefixKey(dtpage_t * lp, int li, dtpage_t * rp,
 			      int ri, struct component_name * key, int flag);
 
-static void dtInsertEntry(dtpage_t * p, int index, struct component_name * key,
-			  ddata_t * data, struct dt_lock **);
+static int dtInsertEntry(dtpage_t * p, int index, struct component_name * key,
+			 ddata_t * data, struct dt_lock **);
 
 static void dtMoveEntry(dtpage_t * sp, int si, dtpage_t * dp,
 			struct dt_lock ** sdtlock, struct dt_lock ** ddtlock,
@@ -891,7 +891,8 @@ int dtInsert(tid_t tid, struct inode *ip,
 	lv->length = 1;
 	dtlck->index++;
 
-	dtInsertEntry(p, index, name, &data, &dtlck);
+	if (!(rc = dtInsertEntry(p, index, name, &data, &dtlck)))
+		return rc;
 
 	/* linelock stbl of non-root leaf page */
 	if (!(p->header.flag & BT_ROOT)) {
@@ -3625,9 +3626,10 @@ static void dtGetKey(dtpage_t * p, int i,	/* entry index */
  * function: allocate free slot(s) and
  *	     write a leaf/internal entry
  *
- * return: entry slot index
+ * * return: 0 - success;
+ *	   errno - failure;
  */
-static void dtInsertEntry(dtpage_t * p, int index, struct component_name * key,
+static int dtInsertEntry(dtpage_t * p, int index, struct component_name * key,
 			  ddata_t * data, struct dt_lock ** dtlock)
 {
 	struct dtslot *h, *t;
@@ -3649,6 +3651,10 @@ static void dtInsertEntry(dtpage_t * p, int index, struct component_name * key,
 
 	/* allocate a free slot */
 	hsi = fsi = p->header.freelist;
+	if (fsi >= ((p->header.flag & BT_ROOT) ? DTROOTMAXSLOT : p->header.maxslot)) {
+		jfs_err("Encountered corrupted dtpage before insert");
+		return -EIO;
+	}
 	h = &p->slot[fsi];
 	p->header.freelist = h->next;
 	--p->header.freecnt;
@@ -3697,6 +3703,10 @@ static void dtInsertEntry(dtpage_t * p, int index, struct component_name * key,
 	while (klen) {
 		/* get free slot */
 		fsi = p->header.freelist;
+		if (fsi >= ((p->header.flag & BT_ROOT) ? DTROOTMAXSLOT : p->header.maxslot)) {
+			jfs_err("Encountered corrupted dtpage before insert");
+			return -EIO;
+		}
 		t = &p->slot[fsi];
 		p->header.freelist = t->next;
 		--p->header.freecnt;
@@ -3774,6 +3784,8 @@ static void dtInsertEntry(dtpage_t * p, int index, struct component_name * key,
 
 	/* advance next available entry index of stbl */
 	++p->header.nextindex;
+
+	return 0;
 }
 
 
-- 
2.51.1.dirty

