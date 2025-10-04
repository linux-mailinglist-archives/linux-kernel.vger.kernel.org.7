Return-Path: <linux-kernel+bounces-842015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D36BB8C65
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 12:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 62EBC4E40DD
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 10:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90531E98E6;
	Sat,  4 Oct 2025 10:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="OIvYICQP"
Received: from mail3-167.sinamail.sina.com.cn (mail3-167.sinamail.sina.com.cn [202.108.3.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA79D33E1
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 10:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759572959; cv=none; b=qXb3He0pzQKcvYL5sDRjz+ZsCNXAstCymjd+gEuPl/fN88npopQat2gCYtOdhUSbJuC0h49g75wIXgNB9M5MYjwx4YMQWZ1jpNcm313FwBNtBV1nt2B5Q13YxrYR2m36aRBjkx15arbZiL9GLGJMO2EJdJ6VB3siHREHMJqG99g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759572959; c=relaxed/simple;
	bh=+8SJLkzLybn8/9Xix/bciaZucUYFhm426mP1cr1DzmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GH6a2169LJV816udjJRHhD8Bk9912YoWcQyNgHDAgZZSZIcse0zmYhf6fXl0h1hJghDB3mGYcQ6ebksslokUMCrW5VKeCF7d01bD661eQRqksVMCLSw3V40PIPqiAq5J/ZOfn86yn9Wu7L2JuAwVuCkOEMFqDaTU/pxyehklOVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=OIvYICQP; arc=none smtp.client-ip=202.108.3.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1759572955;
	bh=FuVUH6FkIPP/j4PHc880wdi7LiKev6OvJLuly4i+80s=;
	h=From:Subject:Date:Message-ID;
	b=OIvYICQPCrfx6WlLvKNqIDwUMsUkUnn7zXHEn5elpY6GgJDezui/vU4HDVnXhUra+
	 MZ8tTr+QZlTP9Umavsrcg/2Izud2fx+7t7AjnI3F2Fu2RQ/YrEl+NxCbI0DIj2SbAO
	 VJO8lxlowbr+OJE+3tXSuLG8LAGZFyierxKXVHso=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 68E0F194000029DD; Sat, 4 Oct 2025 18:06:14 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1416746685347
X-SMAIL-UIID: 025E74C24876413494575D585060B52D-20251004-180614-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+ae8ad52680705c162471@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [afs?] KASAN: slab-use-after-free Read in afs_dynroot_readdir (2)
Date: Sat,  4 Oct 2025 18:06:02 +0800
Message-ID: <20251004100604.8082-1-hdanton@sina.com>
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
--

