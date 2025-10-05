Return-Path: <linux-kernel+bounces-842259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A92BB95AA
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 13:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99C083B3209
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 11:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D1226E16F;
	Sun,  5 Oct 2025 11:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="ws79ttq/"
Received: from smtp153-170.sina.com.cn (smtp153-170.sina.com.cn [61.135.153.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C0B146585
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 11:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759662215; cv=none; b=hEGa7caRFNe8+VRjze7SjMTOhmBe70Krria8N0hD+gi9hiWzQp//FzHIFknT/skU/jb6+RObsC9oihx9QoPk61JdXyp92tS+lCmBIuGeW/Q6SyHodR9wMARdhJKDHGpEqmdNcryaFLHjxlr4/jgnxxkB9Xle7D4CcRxtrnMnBps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759662215; c=relaxed/simple;
	bh=7xqBLSP+hbUOR6BAMPgrO2ISzVsAjb3HlZhVWRfeEnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iW3nrFEnJfUyIZIlGv3B+kiCT9lt+D/T4AghmwfuVtzMABJEeiJc8E8Sfmvj7bYWvrE6uLlv96FmWPxnzhHa435q2tZYQZ28RKqcdnRi947yxjWhumS2JMXzKCH0/B3eU0J3IbO/e5gxat+XSnyGU0Kaw8RS+ejuL9Du6aghA2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=ws79ttq/; arc=none smtp.client-ip=61.135.153.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1759662207;
	bh=fuI4NuHV9y4KUyk0URMks2F9PrZ2xm+GkuYmGJ8BdSk=;
	h=From:Subject:Date:Message-ID;
	b=ws79ttq/Cl+dK0U9G1lZlYv2JkanBZy20+o8JCyzkBNVKq0s5AMjc4GQoHLUfHtDt
	 f/68mmt9iq8MxEX7BgmmVaIzPYoiPQd+RYjiCokgrZYxeFwwa9yb4x1UZS34/22Uvt
	 ic/It4FEwgFt9jxBC/4kUEE1JHWcPqiOTUDms4sE=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 68E2507200000B48; Sun, 5 Oct 2025 19:03:16 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8665916291843
X-SMAIL-UIID: F2921B22C3634D9CB69DB2476A0165DC-20251005-190316-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+ae8ad52680705c162471@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [afs?] KASAN: slab-use-after-free Read in afs_dynroot_readdir (2)
Date: Sun,  5 Oct 2025 19:02:29 +0800
Message-ID: <20251005110307.8140-1-hdanton@sina.com>
In-Reply-To: <68e0b0f4.050a0220.396d9c.066c.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Fri, 03 Oct 2025 22:30:28 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    9b0d551bcc05 Merge tag 'pull-misc' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=144e8304580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3affc19c35df22d7
> dashboard link: https://syzkaller.appspot.com/bug?extid=ae8ad52680705c162471
> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17856a7c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15a05214580000

#syz test

--- x/fs/afs/dynroot.c
+++ y/fs/afs/dynroot.c
@@ -290,15 +290,21 @@ static int afs_dynroot_readdir_cells(str
 	for (;;) {
 		unsigned int ix = ctx->pos >> 1;
 
+		rcu_read_lock();
 		cell = idr_get_next(&net->cells_dyn_ino, &ix);
-		if (!cell)
+		if (!cell) {
+			rcu_read_unlock();
 			return 0;
+		}
 		if (READ_ONCE(cell->state) == AFS_CELL_REMOVING ||
-		    READ_ONCE(cell->state) == AFS_CELL_DEAD) {
+		    READ_ONCE(cell->state) == AFS_CELL_DEAD ||
+		    !refcount_inc_not_zero(&cell->ref)) {
+			rcu_read_unlock();
 			ctx->pos += 2;
 			ctx->pos &= ~1;
 			continue;
 		}
+		rcu_read_unlock();
 
 		newpos = ix << 1;
 		if (newpos > ctx->pos)
@@ -308,16 +314,21 @@ static int afs_dynroot_readdir_cells(str
 
 		if ((ctx->pos & 1) == 0) {
 			if (!dir_emit(ctx, cell->name, cell->name_len,
-				      cell->dynroot_ino, DT_DIR))
+				      cell->dynroot_ino, DT_DIR)) {
+				afs_put_cell(cell, afs_cell_trace_put_atcell);
 				return 0;
+			}
 			ctx->pos++;
 		}
 		if ((ctx->pos & 1) == 1) {
 			if (!dir_emit(ctx, cell->name - 1, cell->name_len + 1,
-				      cell->dynroot_ino + 1, DT_DIR))
+				      cell->dynroot_ino + 1, DT_DIR)) {
+				afs_put_cell(cell, afs_cell_trace_put_atcell);
 				return 0;
+			}
 			ctx->pos++;
 		}
+		afs_put_cell(cell, afs_cell_trace_put_atcell);
 	}
 	return 0;
 }
--- x/fs/afs/cell.c
+++ y/fs/afs/cell.c
@@ -520,7 +520,6 @@ static void afs_cell_destroy(struct rcu_
 	afs_put_vlserverlist(net, rcu_access_pointer(cell->vl_servers));
 	afs_unuse_cell(cell->alias_of, afs_cell_trace_unuse_alias);
 	key_put(cell->anonymous_key);
-	idr_remove(&net->cells_dyn_ino, cell->dynroot_ino);
 	kfree(cell->name - 1);
 	kfree(cell);
 
@@ -565,6 +564,9 @@ void afs_put_cell(struct afs_cell *cell,
 		zero = __refcount_dec_and_test(&cell->ref, &r);
 		trace_afs_cell(debug_id, r - 1, a, reason);
 		if (zero) {
+			struct afs_net *net = cell->net;
+
+			idr_remove(&net->cells_dyn_ino, cell->dynroot_ino);
 			a = atomic_read(&cell->active);
 			WARN(a != 0, "Cell active count %u > 0\n", a);
 			WARN_ON(!queue_work(afs_wq, &cell->destroyer));
@@ -615,8 +617,12 @@ void afs_unuse_cell(struct afs_cell *cel
 
 	zero = __refcount_dec_and_test(&cell->ref, &r);
 	trace_afs_cell(debug_id, r - 1, a, reason);
-	if (zero)
+	if (zero) {
+		struct afs_net *net = cell->net;
+
+		idr_remove(&net->cells_dyn_ino, cell->dynroot_ino);
 		WARN_ON(!queue_work(afs_wq, &cell->destroyer));
+	}
 }
 
 /*
--

