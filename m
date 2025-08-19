Return-Path: <linux-kernel+bounces-775873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BB7B2C5FA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98772521A0C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5766433CE88;
	Tue, 19 Aug 2025 13:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="cva4UsLS"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FEC23AE9A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755610881; cv=none; b=iZsdC024LEdxxKh+4wcp7LphjTyAAF3nKeNdaGI7NktQ4U9MLbIRQM2o0XZ0KmLcZBNglNk98ZOymKrWRXjohppL4xU/MI4SZoSWnFpAsWaEntiDhvrpdY+twSbaP1HcV/7WHSMVIpMpQtQyAqhkaoqs0bxRHAdLQAaKdJlMR2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755610881; c=relaxed/simple;
	bh=QyzjF/0AaOroCSH9RzV1rO0zR6QeIeCkyR33hpWQa4c=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ttcv3CUlsGrhq8yRLNuqxn5FM+kpzxX5wVIfyktSdqvMthRwng5VzjzSUQgcrZz1+453ALuGMws5rruxd3MDBwM/44BKBrw9lZ61XVEC6fLiFFiL+a4R1mvQaKfifv+5RVAVPDGTbItOZj8147NWVyUyBQk7E7X51NUWoMoSj9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=cva4UsLS; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1755610868; bh=vz/aLcAyIdl0LH4vvwbsWgUHYbgEUH4l4+X75EZNmNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cva4UsLS1UmSzEZ+RBsA56/eePd+hXp4YIoVsC7td7jXIPn1zgO9Y0p1mJ4Mun9u4
	 ZJMpgUfSWofIl0uezV3pArLQHUi8Wb9yYrs6Xe9t6do2jLj6FTrpRAYi6D+aRQjVGn
	 SuqGLDpNVD06tknueVVo5jXUSBKtVOKVOm2SxaVA=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id 83037A32; Tue, 19 Aug 2025 21:32:48 +0800
X-QQ-mid: xmsmtpt1755610368tgabz2ymh
Message-ID: <tencent_5E787A6C242FE96CC89454E856EC52CEC40A@qq.com>
X-QQ-XMAILINFO: MIAHdi1iQo+zIrDfBBjifQF3t9+JGdjLtdlyu1RdcFzik61Q3xQsm7gkw07w0x
	 M43FICJTS7Z4NJENS/AP3tnUP0c5pNwO+p6K7JiGKwm+Gg71++H7ErGKGCSQ97Kd8ljJ+Ybr+dCi
	 GQq2UOpeVzzGMpuf9FaafqefcDWr3LXrDZW/Q4CRqdHrrnsgXOkzQJ/rJmZGqMSn4wBO9Wl9rc/x
	 YvxWbd9SxOJWpi5tUewNJnHilZb70p8Z4wqe8bZYkyTK10Rp7swrOscDlKrVetwo9TeUkYyPlGts
	 X0KZyq78OonSD3KKOKMj3UeBoo3Qo//4KI13BrtJPXvYf5RS3onuI6HltbuMUcHVMAaVIUPL6Fyo
	 7V8g1vbQCektp6gB/06xGqJKiDoleEvyIpYLaqKeYxSzqx1SE3m+Mpl7wxSyQLkCqOOD5GCMw7dd
	 CXwX5I13P4TgtjOkbMJC3snmRaSjFWPnDY6+172xyc0QsSQWrigwF56XFL8h4+LgdQ7XPD2K/I4/
	 yZDyDcaroOIaAXcC4l3cK+nIXON1B7+VU8iUjjtFztHoR3bT8rTSEZBsSfCB6B6ULRYcX+f+h9Ef
	 Rg3PglsNuiwhzIlv48i2zNC3vzaCfQ8GbYxCggleCiOVfPOIPCo7xKzSrYRnmoHEGGueoLut99aP
	 1HQDQoHJorY6U1omofNBvQwIsKlmsBMDWKsEhK6MTcSooKeGWkJm7wRpm9Q5Fe1T+1/pA4xEL/Ew
	 SIQZ+1EL2K7nLIK1s0Ls2iIXg3xXtRDKAzlnRqQDKVf2v2pR6GaGcrWjZBD8Q+YcJqYooifcfD88
	 4sn7do+jtPoRNRo3xqWtrmT849+b+BpLJdImTFntRq0yHuKu/1OvIx78CTpfTsajn4nuuygiSzr7
	 t3rnB1klUqiCnVfX8nBh2+NGr8+/5fq+rQ48IqCpbBa36cXUJy0sfIXQC5NXQxvOYYWhjnpevvBs
	 jspE95jvnrXWOYm6ZPKNFnQ5hBWSbKUEWnF9/EwLAul17bc7Aa7A==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+47d8cb2f2cc1517e515a@syzkaller.appspotmail.com
Cc: jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	mark@fasheh.com,
	ocfs2-devel@lists.linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] ocfs2: prevent release journal inode after journal shutdown
Date: Tue, 19 Aug 2025 21:32:48 +0800
X-OQ-MSGID: <20250819133247.1261704-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <68a46146.050a0220.e29e5.00c2.GAE@google.com>
References: <68a46146.050a0220.e29e5.00c2.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before calling ocfs2_delete_osb(), ocfs2_journal_shutdown() has already
been executed in ocfs2_dismount_volume(), so osb->journal must be NULL.
Therefore, the following calltrace will inevitably fail when it reaches
jbd2_journal_release_jbd_inode().

ocfs2_dismount_volume()->
  ocfs2_delete_osb()->
    ocfs2_free_slot_info()->
      __ocfs2_free_slot_info()->
        evict()->
          ocfs2_evict_inode()->
            ocfs2_clear_inode()->
	      jbd2_journal_release_jbd_inode(osb->journal->j_journal,

Adding osb->journal checks will prevent UAF during the above execution path.

Reported-by: syzbot+47d8cb2f2cc1517e515a@syzkaller.appspotmail.com
Closest: https://syzkaller.appspot.com/bug?extid=47d8cb2f2cc1517e515a
Tested-by: syzbot+47d8cb2f2cc1517e515a@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/ocfs2/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 14bf440ea4df..6c4f78f473fb 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1281,6 +1281,9 @@ static void ocfs2_clear_inode(struct inode *inode)
 	 * the journal is flushed before journal shutdown. Thus it is safe to
 	 * have inodes get cleaned up after journal shutdown.
 	 */
+	if (!osb->journal)
+		return;
+
 	jbd2_journal_release_jbd_inode(osb->journal->j_journal,
 				       &oi->ip_jinode);
 }
-- 
2.43.0


