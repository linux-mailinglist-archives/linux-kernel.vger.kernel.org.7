Return-Path: <linux-kernel+bounces-842178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B22C8BB928E
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 00:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 35268344D16
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 22:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F5022FE18;
	Sat,  4 Oct 2025 22:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="GpantFcj"
Received: from smtp153-163.sina.com.cn (smtp153-163.sina.com.cn [61.135.153.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2866F21638D
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 22:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759618404; cv=none; b=CxM+TtkBRRhd7maZTiQCBPjSyZD/uLSmj+5yIX34hCtyZ6H2pW/UrV75yWbh+4sE3wnZWHcU4XvdMlx5ht1trvH+TZ/dKelO9z9qHGBDJMCiYDrdeNjJIB4BERz6NdrHs1MVYzsh7Ydjxo4s8NAoyeI8DAIqwTgMO3W8iOZy2RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759618404; c=relaxed/simple;
	bh=zbr0YOn69vjdMcpOPt1aH/4nX38FY7qmYKacgXkoWzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N55CBEMcvdCtQGkGDenVsEvihs8FcFsHfdTFFf6iEBXtMzTydEWImGe1be/7bHSYTfYCMnFfedEsiiXvGgjf/eaxCQSnb823/izC7f6kX0rlHtoP7lZ2ABZVPjicvGUli6QUIYMaJ16OGOmJ2a8dmLFu4msUhHY3Ufx0ayAH1Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=GpantFcj; arc=none smtp.client-ip=61.135.153.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1759618396;
	bh=WHbjCHjWNsWqrqhO7WMq/PYe5xmO6aQuPRPzug8DmiM=;
	h=From:Subject:Date:Message-ID;
	b=GpantFcjQRAajLK7SMMEztYnKPgGRstnZdvpy1VBa92u5l47bH1q3mSmqqrRa7X04
	 V1Vq3buLuEnjfkzVlzPPbDZQRCisJ5eNIHNnOKbxhhaENfXTGkzQEfZjL5AOjh1Ecf
	 DKIw3xOLJq3FPwXbs+ZDWYR1YR9rj+YJ2PKSPaeA=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 68E1A54F0000331E; Sat, 5 Oct 2025 06:53:06 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6253434456756
X-SMAIL-UIID: AC868A3814AE47A19B29B4AFA13DD6CA-20251005-065306-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+ae8ad52680705c162471@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [afs?] KASAN: slab-use-after-free Read in afs_dynroot_readdir (2)
Date: Sun,  5 Oct 2025 06:52:55 +0800
Message-ID: <20251004225256.8119-1-hdanton@sina.com>
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
--

