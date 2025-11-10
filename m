Return-Path: <linux-kernel+bounces-893739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF8CC4839E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD7A4421324
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101A528314E;
	Mon, 10 Nov 2025 16:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7Xym/2h"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E926727FD43
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762793951; cv=none; b=c3KOEp2y2KkI81ZKtAR/nrYHOZuGMUGTPzp/mKzv3VXqxZ4b/U82MJ7fQuaTajZxhZ4heAk5NGHVy3ZSqXTh4ejzX8UG7ZbUqnUBkTw4Ak3Q/it57PJfjePMJgNuXKco7qKZ35E7aYdfiAOP3f80VdIjKsN4YQ5frzjMMtMkFSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762793951; c=relaxed/simple;
	bh=LYbjQEMZCCtkEu/DlDOm6lolA/HDUDt5lHXbIgawNAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mGZ8bwD806MqCLnyzKzFNbrJhF+M5TOPbkz6uS+TGBDNXHvW0H5lcogGBldHEVmYkQrZJz3mN+fhB2Yh8UiFt6nRTSMKcm1Urq2iwphq4GPlzyBzTk7UxAkqITKBGrJejgkkaJ/uBrdz77SP9fVx3VsyPffbgMMvTQ4ScXb4JCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7Xym/2h; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6419e6dab7fso1452331a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762793947; x=1763398747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6E8F8bYQt96owYWb+j7C22xaikBLl8OvGV7Z+ov47cs=;
        b=a7Xym/2hUspby0lnzO9y/i5EVgs7s8Q/AN0fkm9y7Fet66uCaOKaOxPNWOxhuOmfiG
         WOwECjuUbpSKMDA2/UBgoZIY2fSBdRo8RHvB3Rdt9ZZgv/ATaIxokc1ejO99yYkGL69I
         /UwvDWMcZCnb9LjL/Xz5sJRLji9ACCkESjyLQ3znR71d3AtqnERRSqc0VGaNOtaz+fQw
         eip4JiHsMtiWElrtwP1oDmZbc9Fu638A6dfOIG0JydEUuIJ9cpPkJ8kSs3kPZVIRoNC8
         /ROhad0ozbYMs04YI3eARP4pNV+1PySAvO84mC1mtNtg6d8kfcDRqVUD5NhuItwkGNW0
         dejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762793947; x=1763398747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6E8F8bYQt96owYWb+j7C22xaikBLl8OvGV7Z+ov47cs=;
        b=Q8/n0cZjTFwudsSUe1O9FXxsoY08HiGlB9DsdVhg+0LR71U5WlZQ9SyShDADAUC7n5
         PcGIibx2wK9fRVO70zHfm1PI4Uk3ZyrTHbmeJdOHKFYK3O8C1n463QyrbsBwMi1OOGt8
         diTxT4S8Hf2C9ZLkOVMuNJEqE9hdKlEJos81i2rU0GqBuDf8CCdjfrPoehmkWvpmLTmg
         m17o7EAAvwSgENatyAmqtQfNTyrf73nDY4f0kMUlCFolpWAMPaumAj8qMXvizVOIURcY
         MiOl9q5vmQnGcbFQ/jNKTadSelgTiE3PqF/Kuem0U/8yvoKc9pKArYUhBRX4qdAEkQ5h
         CVcA==
X-Forwarded-Encrypted: i=1; AJvYcCW0WxjN7Q/3rMSWw54Hw8JoHx26pglHTvsdOIJxkHrk5yxt/mFELLGphiKhbctBiFLkkd8/SvTIO0RNgBI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe0s+n5kIs0FEmL71AYZsb1u2Idi2ZEtiFIXoZ4jRf1KOz2DMC
	KwScRj3Jz5oOYTLs0DMdnsLizrQ4kyA669qrhj/0F1upB6I7TfWgaGxE
X-Gm-Gg: ASbGncvEN733ygw0kPlQvmQ0Au7p7Lz/Gd+UtaELXHUaO5iyGZf/SJV/Ii4NQ+CazNb
	OUHi6sUxxbsLHd5P2g6zjWNhf/6JayLzX3bv3wNM4Lo2vWi+eVXKgfi8VvQaiSjrxQIP5vZohEQ
	1PPCWqT1StN/S/sSYtVCx1b+HzR4ZLTGiA6zo/ZydD7pOc3JYDsmT3x42y6H7IvXnwSyM6Yk26x
	mC9DutSLB5LeLY0raTtgsERkFej6sXufv41hbIZ2ZSs1p892dFh/oIWV6f4xZNzDGauq5Mq7GgW
	hZGbXc7uwUbgS7VBiJ9M92QhAoYWCf2c8UOuz4E4EaMui1+7bi7ox5XzYqtbC5A3yDkVnqPTNz3
	xfLOfuR9WZ91cYFdtiJUqX/OYwX7zQrw3QcFej9FyTzpf0Sj2IiyAUu8ty8S+o2h4FVLQ1Gxhu9
	WDyYfw4TBQkFdl58F4+x1sp70h3tBXRJvqstRMv50slQ9i/xe9
X-Google-Smtp-Source: AGHT+IH9HXzouFHF6eIXCeLRTXtlUoXhQtjoFHj+QNHModjG38wGnKmb7jL9MvhrQdpTz+2QkN+Buw==
X-Received: by 2002:a05:6402:51ce:b0:641:72a8:c91b with SMTP id 4fb4d7f45d1cf-64172a8d095mr5839822a12.34.1762793947130;
        Mon, 10 Nov 2025 08:59:07 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f86e0cesm11894917a12.33.2025.11.10.08.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:59:06 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v4] fs: add predicts based on nd->depth
Date: Mon, 10 Nov 2025 17:59:01 +0100
Message-ID: <20251110165901.1491476-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stats from nd->depth usage during the venerable kernel build collected like so:
bpftrace -e 'kprobe:terminate_walk,kprobe:walk_component,kprobe:legitimize_links
{ @[probe] = lhist(((struct nameidata *)arg0)->depth, 0, 8, 1); }'

@[kprobe:legitimize_links]:
[0, 1)           6554906 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[1, 2)              3534 |                                                    |

@[kprobe:terminate_walk]:
[0, 1)          12153664 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

@[kprobe:walk_component]:
[0, 1)          53075749 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[1, 2)            971421 |                                                    |
[2, 3)             84946 |                                                    |

Given these results:
1. terminate_walk() is called towards the end of the lookup. I failed
   run into a case where it has any depth to clean up. For now predict
   it does not.
2. legitimize_links() is also called towards the end of lookup and most
   of the time there s 0 depth. Patch consumers to avoid calling into it
   in that case.
3. walk_component() is typically called with WALK_MORE and zero depth,
   checked in that order. Check depth first and predict it is 0.
4. link_path_walk() predicts not dealing with a symlink, but the other
   part of symlink handling fails to make the same predict. Add it.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

v4:
- fix backwards predict in link_path_walk

v3:
- more predicts

This obsoletes the previous patch which only took care of
legitimize_links().

 fs/namei.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 2a112b2c0951..11295fcf877c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -785,7 +785,8 @@ static void leave_rcu(struct nameidata *nd)
 
 static void terminate_walk(struct nameidata *nd)
 {
-	drop_links(nd);
+	if (unlikely(nd->depth))
+		drop_links(nd);
 	if (!(nd->flags & LOOKUP_RCU)) {
 		int i;
 		path_put(&nd->path);
@@ -882,7 +883,7 @@ static bool try_to_unlazy(struct nameidata *nd)
 
 	BUG_ON(!(nd->flags & LOOKUP_RCU));
 
-	if (unlikely(!legitimize_links(nd)))
+	if (unlikely(nd->depth && !legitimize_links(nd)))
 		goto out1;
 	if (unlikely(!legitimize_path(nd, &nd->path, nd->seq)))
 		goto out;
@@ -917,7 +918,7 @@ static bool try_to_unlazy_next(struct nameidata *nd, struct dentry *dentry)
 	int res;
 	BUG_ON(!(nd->flags & LOOKUP_RCU));
 
-	if (unlikely(!legitimize_links(nd)))
+	if (unlikely(nd->depth && !legitimize_links(nd)))
 		goto out2;
 	res = __legitimize_mnt(nd->path.mnt, nd->m_seq);
 	if (unlikely(res)) {
@@ -2179,7 +2180,7 @@ static const char *walk_component(struct nameidata *nd, int flags)
 	 * parent relationships.
 	 */
 	if (unlikely(nd->last_type != LAST_NORM)) {
-		if (!(flags & WALK_MORE) && nd->depth)
+		if (unlikely(nd->depth) && !(flags & WALK_MORE))
 			put_link(nd);
 		return handle_dots(nd, nd->last_type);
 	}
@@ -2191,7 +2192,7 @@ static const char *walk_component(struct nameidata *nd, int flags)
 		if (IS_ERR(dentry))
 			return ERR_CAST(dentry);
 	}
-	if (!(flags & WALK_MORE) && nd->depth)
+	if (unlikely(nd->depth) && !(flags & WALK_MORE))
 		put_link(nd);
 	return step_into(nd, flags, dentry);
 }
@@ -2544,7 +2545,7 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 		if (unlikely(!*name)) {
 OK:
 			/* pathname or trailing symlink, done */
-			if (!depth) {
+			if (likely(!depth)) {
 				nd->dir_vfsuid = i_uid_into_vfsuid(idmap, nd->inode);
 				nd->dir_mode = nd->inode->i_mode;
 				nd->flags &= ~LOOKUP_PARENT;
-- 
2.48.1


