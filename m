Return-Path: <linux-kernel+bounces-874363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B388EC1622C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B63B3A4291
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C96346E59;
	Tue, 28 Oct 2025 17:25:23 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56C81F4161
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761672323; cv=none; b=rKq6GjivqRjVOh4YZF/WfytzbAk+iEnLBFYLeQApWNy0JTvmO5pH7kX8ji0/nzni+XTSDAeSeGcqWppl+TVw/CQI/Qn7UVMG0f989MlcVDPJThe8qtfQHzy4hdCx479H9rRrZOAkSpkE5w0plMgOuj/czmUvwFibOfoiyNwG8G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761672323; c=relaxed/simple;
	bh=XMUIzmFee5AQlK8f+XE7kOtIDDnEmPmbBO+SF7kzNv0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RaP77xmPg4QPq/7jRsi0UbnQegbVS5AfB4VntNDwRWEtJ4ijwBbPbH3Lz8dkoSXDC+iwUo54gj4nfSgjM9fAi4O/OdWQ59QZojg98jkbrYIrCNRbLT1b9EpulBHHN18nSsoPZP9RXE64flJiPfINEyh/UqDxdaMS6QxHAjqT/cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430d7ace0ddso81473675ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761672321; x=1762277121;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Zj+WEd/ez5hZUJb2ZSgrZAj5Y3u1/GyTuoOo83gZJg=;
        b=Qa/WCFi/OB+d74uYM2cc0i6+gONgQjwitPoo0jfnh+DHaKBvSPm7Gf+KSWKtfpnk2x
         JYmtpSJJtyERnsN8lkLZEv563lin3L+APjaPPeJoqnyOL2B3Xc94WQQ5oFI6Pms/sLhR
         HEpGzRANX17U1BQkAqjPD9PFhHwIku1nxfyHb+AnwzupuGa9zvewbb8SOBDsHwDb+TVY
         QkaGLTbkf3XfFHWj10DhseKFtgPRjd6KuFuQtkqJZpvXsFkRvIz5uut4+CCoBHWwZds9
         e4eM/8VXFP4QdXfE2ec5FgL7R70XqKVNbj8602zYcfBU5t886RxwVac7JQaykqvDWFXr
         EXYg==
X-Gm-Message-State: AOJu0YxGAv1PLJjfGoFbYSBRsYSVnXWAl54VxgSPCyFLO4XZCqVNHl41
	kJf7+1+q6NE7Zzr6OarBLsiWeZvgp/kTJsiYrE0QGkYTF8rOQwfglCqIyNtErw+OxniGT1bfF/O
	Zt4JpZ4lfAdrKRf46D+xnkebekDFo4ryq1HVby73eF73uGPlxs63V2TSGgHM=
X-Google-Smtp-Source: AGHT+IG+6rFLuSpsmQSF40gI6kH3aRpMPSNNOyvLHbyrXlZP3/ZonTSIts1TW2vAvPlkhKGKhnixbv9MipViorF1igJVf4JeYv4Q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:178a:b0:431:d3c9:66a2 with SMTP id
 e9e14a558f8ab-4320f7a6417mr58759865ab.2.1761672320850; Tue, 28 Oct 2025
 10:25:20 -0700 (PDT)
Date: Tue, 28 Oct 2025 10:25:20 -0700
In-Reply-To: <68fc0765.a00a0220.9662e.000d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6900fc80.050a0220.17b81f.0037.GAE@google.com>
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

