Return-Path: <linux-kernel+bounces-872747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A27C11EEC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 00:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25ED3188B611
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E179931DDBD;
	Mon, 27 Oct 2025 23:06:48 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAB82F5473
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 23:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761606408; cv=none; b=LtLiqo46g1gkuOC0mn7Y3jKeVC21wL7JhNx+xSFKL66B3wS4z4NyuddHSfbdwQLXn2+2XxZKVi96+7upOPgrhsjWCyvex9bizmmjnLzQraCIPwpLRwgNNHxEvstb1ODCfx9GBtsMzFtY27F4uuBJJwse0I+4iUypVAkptkKxcvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761606408; c=relaxed/simple;
	bh=QTJ7f5m2ekYi/AWHPNQT7HNZF2gYmc0r/URlVjyLC4A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AfUtXwKTCK4cghP4yG/Neh/axQ3l0F3lVn0gpr5hw6i5tOA5No4M3d3qTzpRHQRFah6XB2ONOtFeXOoREDaP+BN5ud8w6B40NOAL1aeF+nZDdjXsq8s7EiwA3Bkqus5q/p8Qbry/fvnxTaTIVo/ftDCvaVPhktIQRjUooLASMmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430d082fc3dso172190035ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:06:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761606406; x=1762211206;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjxEBdiXfpj07bCZPBkDCsitqh0lr+P3soRCaxGaOg8=;
        b=jiBHhEpauA2BFzvr1mkd00dlEVQRcXI1++Y40g2x0pAtxx+RKmf37Oetk3pFMGd/zy
         eXNTnW0eHAlxjN/9qxlkOvAV3eBXzQVrtoE/+ZbapfdBwHvoX57INV+8FDluYt67JR2c
         dUT1x3tdoJME39ikiWTfLFGImo3nxyZQ0IIND98T4yM5HMBm8gbi7/m+36NuuZUMAbsc
         iHFMFagBcoTJKMTASiYsQhV1U2i3L5VbgzTpBIkKx+kfLrW2L0C12aCWmBNi1FJJRcX2
         ZB/W9IFhO2vrucX4JAD07HZqUzY7SepJWeSAhOm1pdS40M8XEvzmJiVdez7hM12h3I+r
         fBnQ==
X-Gm-Message-State: AOJu0Yzq1ruBiM5JgKYlR7QCKoo3doJNQvesWn85wYaMvtfM2Xy+WRpQ
	oDyPozA7s8eddV5LJ0/+5PCM8T2VOj/Q/I+0Iq4T1zBg0rWbhXkhbgcwzKV9juIWydd0Nvh0+w2
	3nKxFFJPt9hs8FIgj43drNsDF8VHa6uUxEpKCxvH+P7YGE60vAGRAINc9pJg=
X-Google-Smtp-Source: AGHT+IF6zMrAaBYO6I7/7hfAybIBuTxPoUqrdT+RCt6gl734OppjqbHFxuoXVirVvCJAjXfORux1O4bfoSLxLsMUHdtxdr0v7gzA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b02:b0:430:b6a3:53b4 with SMTP id
 e9e14a558f8ab-4320f6a76b8mr30644615ab.3.1761606405737; Mon, 27 Oct 2025
 16:06:45 -0700 (PDT)
Date: Mon, 27 Oct 2025 16:06:45 -0700
In-Reply-To: <68fc0765.a00a0220.9662e.000d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fffb05.050a0220.32483.00b2.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+cd7590567cc388f064f3@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: 
Author: jkoolstra@xs4all.nl

#syz test

diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index 0ab83bb7bbdf..07dd01c79ca2 100644
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
@@ -3627,7 +3628,7 @@ static void dtGetKey(dtpage_t * p, int i,	/* entry index */
  *
  * return: entry slot index
  */
-static void dtInsertEntry(dtpage_t * p, int index, struct component_name * key,
+static int dtInsertEntry(dtpage_t * p, int index, struct component_name * key,
 			  ddata_t * data, struct dt_lock ** dtlock)
 {
 	struct dtslot *h, *t;
@@ -3649,6 +3650,10 @@ static void dtInsertEntry(dtpage_t * p, int index, struct component_name * key,
 
 	/* allocate a free slot */
 	hsi = fsi = p->header.freelist;
+	if (fsi >= p->header.maxslot) {
+		jfs_err("Encountered corrupted dtpage before insert");
+		return -EIO;
+	}
 	h = &p->slot[fsi];
 	p->header.freelist = h->next;
 	--p->header.freecnt;
@@ -3697,6 +3702,10 @@ static void dtInsertEntry(dtpage_t * p, int index, struct component_name * key,
 	while (klen) {
 		/* get free slot */
 		fsi = p->header.freelist;
+		if (fsi >= p->header.maxslot) {
+			jfs_err("Encountered corrupted dtpage before insert");
+			return -EIO;
+		}
 		t = &p->slot[fsi];
 		p->header.freelist = t->next;
 		--p->header.freecnt;
@@ -3774,6 +3783,8 @@ static void dtInsertEntry(dtpage_t * p, int index, struct component_name * key,
 
 	/* advance next available entry index of stbl */
 	++p->header.nextindex;
+
+	return 0;
 }

