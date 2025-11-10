Return-Path: <linux-kernel+bounces-893216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 578EAC46D0D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C41E44EBC55
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7B21E2307;
	Mon, 10 Nov 2025 13:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="a7nwLVS+"
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DB3310627
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762780521; cv=none; b=Lj2Ztb5fO5QOtOrg0SkDfkc+HzQIQ/sF+1JkY8Ii9nKgqupQIYEUTuO0bbrG/CRY6Y6zWUyXPpNQPkleuwsDnQmDIMO6mAQdk4fnkqp/5lxCa02nXhxnPoJHLotD1Z1nDh5/d1DRRQIgzX/0XngtMvMcU/atEcTIlCDZFjzJS4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762780521; c=relaxed/simple;
	bh=MMX6JjH2FcQzgzNjZIQf72/HWLfGFrZKQoGLfNH5+8U=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=CKIr7MCm3G6aDK/pfQBte+sHnoKTAtfuHJyqwBhj989eAQrVq7Biuvsw3mFtqji4rqvIar3evtxiLjEvbhFVswymQRqylMkkEIXuX5VaXRzyLE9Gb0GXld9xe41Ucvipif9eLfr3YT3LOE43fyXAfoR97+f6Vwrqd4uxhiRBGng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=a7nwLVS+; arc=none smtp.client-ip=203.205.221.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1762780511; bh=E4FxbJ1djU4q4lMX2R0GWGHuNjSOTcIVpiO3jD1D7KQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a7nwLVS+z/Ecw6u11TdckWuOmjWA6v7xJv/z4sy6a2saVkczFKH5rsjuxVUNz1aRx
	 fF06O4TMDn9vJyStbKs2jdf5x+x7iAdHoVEEZRcfGMnQouYrrCkV83MzZjnH3QHI5J
	 TotZ7+oVMyISKD3A02ie5FOgm439CY6MxWpdCbnQ=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.201.7.117])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 2443F63B; Mon, 10 Nov 2025 21:09:04 +0800
X-QQ-mid: xmsmtpt1762780144tew8ug45i
Message-ID: <tencent_86ACA44F17673776A6C75364C3720966E305@qq.com>
X-QQ-XMAILINFO: MrpsZD+cb6L8CT2N7OvocfZv9z2jDkfUaZzrAuvbN8+DLx2SDwYbQZNi6aBl/c
	 WaIKxOep3LrY6eUgBhBGwngKIn3S+MadjwRry8aOeuZamaX8WXX+7n+7/DGHItZf+hNEAfNPg9E5
	 YAZqGpu35hjQRspgMBgrHA/mHzVem+KtRUjQJS+z/Cuk37bxfMEIv6wSEMbczyFXOCF4Y7x7lIsV
	 A5B3lwoN5i2f7+L8czdqT0tKc9ckdqmO5pjgLK+Tc8DAreyD28h27Lp3JXI9sfNDpBEEsyGr7ylG
	 uVO6xwyT9twJMtAAsV7M1FZtzIi1E+AXP3WN+PADFhne+9U0S/UYV4cabdX6ghkSKy7ExK2xcisH
	 fKQuuQZSIzdG2DssAFiBfK/XHpbinYUiZ6LG2WCLZ4zpha0cgMSzHKoSrtOOrxO5BAXNUCpSWrpC
	 m1GSImaVn+DjPHUl4/KJ1GgRpkY0G3KQTqVDCgHyTENHTqGvfuvHRro8rmzz7SHXE2gcacH23C9i
	 JYYGAKN4fyzFtCKgusTOBQo/pvmFkke9Cz+eaFrd2CGbQZ+K4WoY11zuyRRXTiUVKTouT2wh8Enb
	 IVwujKjD2qc0A/MvRNF+00dxsRVWw1510W9vXgPeO5/kaXWB88lTkcknui2KHV4rgEWRtm1tBWF2
	 7vNhUK7abkBAtHWinUdH2PEVyme/dxDEEawylFHFreAcKlf6dptivwBmTJrL+gYPxIuHBHI91FLu
	 9fl+bXPl+v++BgsfVmT7M31YQjoAfEhayMwUzqxju93bh5tsOyXT/Bos5NzHQGa7GahU4oo2Whmz
	 3q5H/7dyavCSxDWa8iRcHiQ5DnPMbekupOTh1nSs419lxYkxed2a0ul/zuNxtG40D0DjODP5GNmb
	 JXLbJ5kdDfG1KHxWlo6Owys6qbHnTwEKIEJDufXNxap53fQBNzzCJeSwOvxqFJuHMTtwSmm2lFTx
	 Fi61aI6pp3dWJwknlYMAgeSQg9P3qf4EO832XUaPgLCwDd42VZnYPHm07pa0gc
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+08df3e4c9b304b37cb04@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] general protection fault in rtlock_slowlock_locked
Date: Mon, 10 Nov 2025 21:08:59 +0800
X-OQ-MSGID: <20251110130859.1491400-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <690ec096.a70a0220.22f260.0070.GAE@google.com>
References: <690ec096.a70a0220.22f260.0070.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index b343c5ea1159..e61a7f02b14d 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -1860,6 +1860,7 @@ static void lbmLogShutdown(struct jfs_log * log)
 	lbuf = log->lbuf_free;
 	while (lbuf) {
 		struct lbuf *next = lbuf->l_freelist;
+		lbmIOWait(lbuf, 0);
 		__free_page(lbuf->l_page);
 		kfree(lbuf);
 		lbuf = next;
@@ -2146,10 +2147,9 @@ static int lbmIOWait(struct lbuf * bp, int flag)
 
 	jfs_info("lbmIOWait1: bp:0x%p flag:0x%x:0x%x", bp, bp->l_flag, flag);
 
-	LCACHE_LOCK(flags);		/* disable+lock */
-
 	LCACHE_SLEEP_COND(bp->l_ioevent, (bp->l_flag & lbmDONE), flags);
 
+	LCACHE_LOCK(flags);		/* disable+lock */
 	rc = (bp->l_flag & lbmERROR) ? -EIO : 0;
 
 	if (flag & lbmFREE)


