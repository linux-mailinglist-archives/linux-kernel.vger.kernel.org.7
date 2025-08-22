Return-Path: <linux-kernel+bounces-782200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4A4B31C9B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EF84647768
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBE63112BD;
	Fri, 22 Aug 2025 14:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="h9VcjKIh"
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B623093C9
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 14:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755873684; cv=none; b=JptLhppg9tBgwA2Pj/NjHOxcYeoRjpLyMS5W08IAKziINN+MzcnNpX6567nPDZv7JLO6n/RiDExCmEwotKHU2z0C486rWLs2qP4Q4XYzIKvC0y652do1safkHym5/73JQWgunur6pTp5StqLO0/IMlhykBwd7yTwmiCKJLhLAGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755873684; c=relaxed/simple;
	bh=wrqna0sZ6RMPU8gTT3h+3xAxYsH60khbZNhU4KLyBMo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ndzg1oyh70U0P3eTNM5pm3mdQoRq81vhzAI2CJn0g7FGLbjK0nQJERBGrDfeYvppj4NIGriKSihavtH2KyUc46P0T4xaT8+TSJKw4XgHMIhPKW9yz93YWsAoQUIY/KpTnt9Wtb+LcswYPurDIbN4Myj5UAqWUPbfEu6zVF2PFAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=h9VcjKIh; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1755873674; bh=AXtNgOCqWlXjJdTGIg/SbLr8Fg0oT7SoDt9nlF0FA/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h9VcjKIhDFof0UpTm7x75ZEdJIeR7mshNt0X8MXdqtvddplu0c+DYhPhTte3B29Ju
	 S0Lhoc3MsYmjwBa1llqLJUptPmQMfM5299IdlueXLqH6G0mW/8UaJ9Kw9Y8jjwQuem
	 8QKcPk2RSLYZ0bsd06Qg57e9qwvAXDJtjDq1WPeM=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id A4812659; Fri, 22 Aug 2025 22:41:08 +0800
X-QQ-mid: xmsmtpt1755873668tq8zjx9lz
Message-ID: <tencent_074BFE748F778366103D0B36E0971837E809@qq.com>
X-QQ-XMAILINFO: NAuAIaytDrXpvt3VlSnxhCwwyEuILRU9s99sYUUY10cqaSBidHw7OgAT7VZ6/C
	 oIKGWH7S4O7gdFiqDoV90uTYbfsmJAEckQdyAhLNgb2itk3KsG+OaBgActIDxPMI3Bl36tMpoSbQ
	 enuNwb9nQf1+TrpT35vXKrkny3jytaWoXyFou32BIptza9kPKpuoqcsEQC9Xf4a2DSDphqnvshES
	 I85vJPLQvz6j3dVgeuf+UPk3dTaxB+y7tKRemfbfUhFm6kyEwWOLPL0hFl2bhdIVHibCBnoBmN8Y
	 /VvlSp1bfUP1J274u5+3E+lOj0V0ev4RQgrvWS10OSqgDAAFi76XzDy1pz3bqv0xI21w1JstMtv3
	 JqAXVSY1juTyuGS5eEXtEA2RN/yZsoBTxt0Tjv8BXAFgSJVdj0OMTOoChWa+9e5DHOOmUztPqOPt
	 Q52xerPK6lnQjbL4TtOvrtSP9SaLrOpGluV7lELEJttDxncc/pHaMn9F2N44C9yuapqCASDnsfHB
	 E6jw3nKRn/qh+X9wZdDVxwdW6K+liVeG5LilK7L49QUYlsVWkAIU9IT+q00MbgxOTAUMLviMyCdd
	 FIzsgZQT9y58XyUil2cFtUdcdnTw4Zi7UvD8N6N0B+TdNCl7TAxzBynJRG17gWjf8KHC6zItC7eJ
	 PUK5dj70UzEsv82nhsB2rlPqrFR1DdzcaayIpNEgSdiLPoEhpNOnd7bIA1ILNPbf62D6unjOwg/g
	 rG1eGzrK/gyu7TXBXn/1M2+JHEyjhRQAm8MQ2b4uhFKnnTl+QiI4UVM4lH75/K8LIaQnl4nONoDY
	 budczJgbtrmhsozpYh5towqS3UGhFQLkB8KjLkRMbs6eMLtvSk5nxmtFZQQO+Aa+tzrVF9StEgyj
	 JalrNoV4IUDHEqpw9iSx5Miknmbf6/5L1gty/7d2K17OADZM2ILHr+08XHD49CvrmDHIed1hukWH
	 1PZHEZx8gOiMzi/EnDQRX0amQcAcCMK7I25tT6hyhZLXnJxlaZZk9vzdwPVfqj
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+30c83da54e948f6e9436@syzkaller.appspotmail.com
Cc: asmadeus@codewreck.org,
	ericvh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux_oss@crudebyte.com,
	lucho@ionkov.net,
	syzkaller-bugs@googlegroups.com,
	v9fs@lists.linux.dev
Subject: [PATCH next] 9p: Correct the session info
Date: Fri, 22 Aug 2025 22:41:06 +0800
X-OQ-MSGID: <20250822144105.2424847-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <68a68b57.050a0220.3d78fd.0012.GAE@google.com>
References: <68a68b57.050a0220.3d78fd.0012.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syz report a shift-out-of-bounds in v9fs_get_tree.

This is because the maxdata value is 0, causing fls to return 32, meaning
the s_blocksize_bits value is 32, which causes an out of bounds error.
The root cause of this is incorrect session information obtained during
fill super. Since v9ses is stored in sb, it is used directly.

Fixes: 4d18c32a395d ("9p: convert to the new mount API")
Reported-by: syzbot+30c83da54e948f6e9436@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=30c83da54e948f6e9436
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/9p/vfs_super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index f6065b5e0e5d..cc2056dd0bef 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -50,7 +50,7 @@ static int v9fs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	int ret;
 	struct v9fs_context	*ctx = fc->fs_private;
-	struct v9fs_session_info *v9ses = &ctx->v9ses;
+	struct v9fs_session_info *v9ses = sb->s_fs_info;
 
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
 	sb->s_blocksize_bits = fls(v9ses->maxdata - 1);
-- 
2.43.0


