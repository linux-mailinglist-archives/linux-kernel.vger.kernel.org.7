Return-Path: <linux-kernel+bounces-830254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7035B99350
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 144BD19C7777
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929FE2D8DD6;
	Wed, 24 Sep 2025 09:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="pBLRSqK4"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1696B2D63F6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758707067; cv=none; b=fCeersb2+NP9cmHKj6HdmnKoQSUl1Y7/2aFh/9ol46FdFAUmshGxHnYkmdmm3ifIjlsA2RRdVoEvMJJ46BtDZQA50qZtJCjVEXNJbxi33qH+CSxRQHSzEIuZbR9/IMG7v5v9ABYDEKHA0jJplaHveRqnc12DTG4+xFVYprBhiWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758707067; c=relaxed/simple;
	bh=92k1L2edZcDWosOqSNGTfTOm1oLUY+MtB5S2tTYdos8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=gXI7VCfEv3G3Ag54780r4wGUTcJrKZZPhhGoSJRzuV9a31SIdeqKTwZN2WTZ4jJ9Gq9T3FKSVUOh9HYflkSE1eiFGOn/JgjVrnCuR+xz4ga+knt7+OnuFDvcdZx6BDeEerPOi2kLJ3A8ddSzGYspTInXXQR4nmhTHnphW/3m828=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=pBLRSqK4; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1758707054; bh=8gGt5EM2THcxsI+3pWkD1D+N0TuG17RsOzX+e1z0ClA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pBLRSqK46P3cW5S5PPl8GAcEtba8uc0wkxqGqqQTFHJu+sFqcCNOxV5TgM/rBMnLE
	 rkzSXOdvcns68FMIPb4qSr/hkYH60RVmVm+FVUZCMJpolVFOijXIelFxcR+CJ0kzTz
	 QX5ryOVEhoOVAsZC3iB1P2953Xg9A++Dn88x3caM=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id B0C09607; Wed, 24 Sep 2025 17:44:12 +0800
X-QQ-mid: xmsmtpt1758707052ta0e2pbqh
Message-ID: <tencent_A1A361297E23A6644BD76A577B66DD336005@qq.com>
X-QQ-XMAILINFO: MMdeJhisZKgAJXYvZ+p8GfBPt9feHeLXU43aRTDgqLzyFKOv1pKr+Qw0yzgy7g
	 mzf0dW87Z2hiByFOMhiO2bXP1SFEm3w3hwUXhyGyupzzkpR6SjYtYouK0DvmWqOpOYvw7UTifu38
	 jjcD6cdG+Qw9jlsKwxZEScA3+C20iSZdD1UlzrbWL4Nmz81+Nf/1xHenLCTiOHkkVMbVQQ9bu6Dh
	 x3Sy3XhCZSiyQpxQE8d1jpi8nAXqG2yxsfYLCIXFUmedmkROhas2G91Dch0QZu9hYwsRhgKvM54h
	 LZyOas//0XLePybr4+EGulGT7oCVrMmFqrCS0A0krBDeVnZH/lUct5b80O/26UgjzmodiJFHLFsb
	 QOWzdgQIqvWqfnWXvjS5k6shGSvAj3y90IOthD/PCqqYlgT57XSFQKuUsIf30BM7uPqH7KNYA/SW
	 Z98emkffDd0wTar6TQ8qat3NmSOMHe9LfIB3AJufyqOSR0EnflDj82ZJA9agJ5ZLkleAfz4jtTov
	 X8GPHDFV+Dnc1/VtQLmrwDgUugzMq99WBciIj2GFXdODxJDXuFc5raObUiKnkWNY4Ku79A6c1GSl
	 aJyBhjPCUncxMlwJ56B93xmy1y41ojfjeUnnKRQPjSVIfJ1w35zwvOwuciYaRwjsg+FErkrkhB2e
	 R8HsDRCrhlyQb842IdAdXEe6Abx1Saq0mcFL4RhnVo834aITdj5KxEOpunX9oxrej0TX/nOb07cS
	 PMGLbLpX5nAB2IYZudphtk31IF4OxpDX/Xe4Hp1exQs5YlJlE68gxNyYvN70lNwI/ASysHe/W6FQ
	 7lo/BiX9BVJj7DNc1nhq04TH1eJZ/FjJKCiK1sSVZRYWN7D2ORZwv73LPf7Gx8NiNZm/eu4+VelB
	 nf6IIKpbfc4jdQKGrjaW0qf+oExfJT+I9aAdyTWoKs9/OuVcNRGIkKimMGVh8IAXSKf/NeoKs7j0
	 KmgcEiu36vTRzVNZiuj4NEVYnNNCzjzbElpT8qxj0=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] BUG: sleeping function called from invalid context in hook_sb_delete
Date: Wed, 24 Sep 2025 17:44:11 +0800
X-OQ-MSGID: <20250924094410.1452473-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <68d32659.a70a0220.4f78.0012.GAE@google.com>
References: <68d32659.a70a0220.4f78.0012.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 4ed997f4a663..a18d53507210 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1484,7 +1484,6 @@ static void hook_sb_delete(struct super_block *const sb)
 			 * previous loop walk, which is not needed anymore.
 			 */
 			iput(prev_inode);
-			cond_resched();
 			spin_lock(&sb->s_inode_list_lock);
 		}
 		prev_inode = inode;


