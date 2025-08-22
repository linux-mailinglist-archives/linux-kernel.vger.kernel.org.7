Return-Path: <linux-kernel+bounces-782792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 830BEB3256D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 01:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AA98B061C4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 23:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8556A288C20;
	Fri, 22 Aug 2025 23:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="W19qO7kK"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E44C19E7E2
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 23:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755905633; cv=none; b=T+UmscDxPnxnlEUY00u2QWnX11HHeWYbJe1Qia5V8FQHmX3NTo1m3rpI/ZPGDUtU7zv4fk6V7KE5QkRPPtdeDLFGvnZ9l/k2yPVs5hUQfCynwBTmRRGM+zxdOu9Zoer2+2U0WEKzn9MLyik6/kxhvHhuQZ+gHGu/e6COylNCLEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755905633; c=relaxed/simple;
	bh=ii86TnDCd+ZIV87XXjkVSoBMDUfbe4FTWbWEPqLXqqA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=rG0mpg+QNAL2JrjtobxS4ePhXZM6ARvz072Z685pSRrnrBfTSTWh0G2LWONsNJ1+/rS+dJlhOx5NhE5G5GiXiA4AaJ0iCEZ82edDKKOXCAsl8wOMkx0akzWrKqG4OQciReacSDXu4Q1TtX1lYAMZ1rvUjGEEY0d5cKWiY7nd2U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=W19qO7kK; arc=none smtp.client-ip=43.163.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1755905321; bh=+ddHY+2CoVEakzQVjnb8qjEqZkiCxH+nSriB8oJuLz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W19qO7kKzzSLNvkIln75fwrqO53kX3Q3SZOl+5lKDuCT77orcCFBvRHQd3REj1KVv
	 FM9ciNbcJeqSFF35y2Yz2X8b9wwIYmqmmD09iFGkc/RPT/+x7KyM9sRn2AZP+J2bal
	 AaZKd+qvVY3e65PSwlCKBkdRqVfoMoYigbEVw0Bs=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 593A2482; Sat, 23 Aug 2025 07:22:19 +0800
X-QQ-mid: xmsmtpt1755904939t5beu3wyr
Message-ID: <tencent_85467F89852EDEEEF58C8F67D446F592F106@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb5p2BLjS1xnyNkr7ag8qcgO4mgCZswWjeIqfXOzCa7OD4+Pk0qFt
	 kejpobgY8pVY++whmLMVc3orbwG580/HJaI0oRB95vWm2/klre+hBAvL2e6KmL53d6eWbhbHpVHr
	 Wr9TNUABC4oO3PXSieF1vKmA07SHPyPvGOI1C+mOQDt6CE+LODE9e4sFHBBAfGayQ+C9D3WXMLwW
	 M+7j0VzZBC4Nz0hTMqTxCfcZ7vAnHzM0uSnz47j2fVuZsE2O8qWNotExr6zjP1JW/zXGMiNTWT4H
	 Vcf1Ewge4Ru84eEnQgQeayFS3WYIEusOtqMoRsjOfbo16+GIZs5XkWOBJhmlHGLFoKzqLeMF9zQc
	 ic7GXYq2KOcROkpeLNS4wSjW76amJa7yiyY5xlpzXsBA6UqM/wTHfHfgz+K/G6Pye29gexLdE1qX
	 FWcYSC4MIv2YI/Wh9c44DalsJeOX5W037W9oApZu8vddTY8xXfy6KaUCct4UWJHztBW5p9mtuvnB
	 qEG/iebhu0AXHlRdLerpPNeLFLspbS4Msvl66wFUNXXvH4KyKLAKX3tAm8E6lAT054geA2xwzmIV
	 cBYIaofArQp0hhcXzxH8BGgtshfaaH93L4R2O3TttyIgk2Dg6GwZq3DE+KwSgZQ5rqnWU7fdjV7c
	 B6OfrGJlJdFgFMULtRHmr1PL2tYuY28bHcNAKu4xmvT95ozFanO8+R0P39/O95pP5thpxlk7eKXS
	 MUxVY2TP/ldM21xacKI/V6hKgIWYPwpWgdr4XweedvcxftE1ezosrOuejAXenXC7ads3kGWk+MWz
	 tboU7ssEd5cTKw2ImJl4B4zEvEG4obzY1qxkSwhCpqPV+0fC3On0fduxrZYbFW25hStb8JFHhjlE
	 DhBNA49YGJPBRdAYDdwiBWYLcz2bKtf40QAgtCunQstjNA+//KkCO8c+Xi6th7gSH2Db9B1OBPUj
	 GD8QHEhYD++pJNsc1dH9XpHfmSW43BI3Q498i0RUi/8YyoDrDqDqKTMopOIXmvSsCprK8zgwqK9Q
	 b6ET6da++ArkUcCEd9xxNi1fI2ZUodNghT2wKjBw==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: eadavis@qq.com
Cc: asmadeus@codewreck.org,
	ericvh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux_oss@crudebyte.com,
	lucho@ionkov.net,
	syzbot+30c83da54e948f6e9436@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	v9fs@lists.linux.dev
Subject: [PATCH next V2] 9p: Correct the session info
Date: Sat, 23 Aug 2025 07:22:13 +0800
X-OQ-MSGID: <20250822232212.2513676-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <tencent_074BFE748F778366103D0B36E0971837E809@qq.com>
References: <tencent_074BFE748F778366103D0B36E0971837E809@qq.com>
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
V1 -> V2: remove the unused ctx

 fs/9p/vfs_super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index f6065b5e0e5d..bcb6ebdb8037 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -49,8 +49,7 @@ static int v9fs_set_super(struct super_block *s, struct fs_context *fc)
 static int v9fs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	int ret;
-	struct v9fs_context	*ctx = fc->fs_private;
-	struct v9fs_session_info *v9ses = &ctx->v9ses;
+	struct v9fs_session_info *v9ses = sb->s_fs_info;
 
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
 	sb->s_blocksize_bits = fls(v9ses->maxdata - 1);
-- 
2.43.0


