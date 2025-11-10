Return-Path: <linux-kernel+bounces-894310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 864BEC49BA6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 32B3434B7B4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B67C2FF672;
	Mon, 10 Nov 2025 23:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="DaJYgJ1j"
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F823019C4
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762816851; cv=none; b=XLdEoO2de9UN/GcpkvM6UOabzpVubllCjkYO+HYfwC3G+mD9rqFds0bonXmj19f+AH93YV6jSjS6uf6L7GbdmXzPkyPjINgTD61dkGjmgHmU1fG+HAD1+FZRwpp7cNqJDQp6WEvkPfWJCoPlOhE/uOTEW5w+bbEEyofe3ik4f6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762816851; c=relaxed/simple;
	bh=DRPVTiEbF8rDOUsldWwR5CrUjbBRZ9f1ZOlWtgf0tjE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=j/u+iVq792VM0CbmCiKXAfs9EiS4VR0130i48hLjTDab6OvMFisDZ5/CMCNn40ONRPXxvhYn1M0cdJUj9s9p4mIBTVVqsAz0oFS1TF1oHQ55lHZEOJJdsjuDqnWvpy34BEeSy4wt9IADQLkw+s0MIczYA9Ny2SS7lAWzI+Cna1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=DaJYgJ1j; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1762816845; bh=G1r8siuDyGrxBMK9ojSHRX8Jmr7CvZa8fAJu6Nj23JE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DaJYgJ1j3f/xNkbaPpspV8LQGpAae7XTXkK/niJ0LV87FC8mbtiOl0RvRiOms+I6s
	 gAAeeCamSiKu5hmcC5Tyff6YtOd2VxZcqu494MHKVQ5VzT/4LmRFaoA1ulG2onakWQ
	 ZgIP7JxVaKgFV9JgQscosb3qlKQ80veJ1a4OlFys=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.201.7.117])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id 52BBA672; Tue, 11 Nov 2025 07:20:43 +0800
X-QQ-mid: xmsmtpt1762816843t2x9djp3y
Message-ID: <tencent_D9EC2EDB4C9167E306CDD2F1C64A49B2AE06@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJVWewuF83wv+7TxGxVC1bmmRN8ZjR3VrF7RtFg0L0HaQraRrfyy
	 RSn5HDLKuObaN/m5+l1RuMNYx2dEan2foy7pXBJERGJIktjIQbjciqMEMwi8KHDDtKTt7Q6xWu4y
	 WiE82incLc4tVKFOqHuow8TYLnRr/IERGPt/rCubJso6L8WzC4+ntvpLlDz5KIPJNQJElYhF9HqM
	 IHHs1BxAtW73yTuLohCIBrnc7d52Z5PTBJqAnR5TPP4P2+C5IPYNEggXPLiVjvIDkYsDnUIH3hFJ
	 ryetsLiy7RVHptC5x/QRkVNaikMZHpk0qyIAhoR89/CVyXxD2XQJf42jKxfhRajF40dRhE4OAOaQ
	 cVCQ2r7sIgC1q0luIEkjaenacJT0bX2i7vMSO3/eqH0dbTioWpNNro+q077g2garOp839U4jsu8i
	 FNp8MsHRmloSw6t4TkpUPAEdk3xjlv6VwNSsR1VZMlVBPH4wvjz4Cvgc1DH3WnU1OBznwwPjxflq
	 DyMyOlzbdfauu2mT+FIzNxnMWfCAOl44YW3yfwMSspxB7LLIdFBCmeTUxuD81tvhQilAEI0us7IH
	 XXftuQxLmas2wREzbDd/02tV2n9EtqhKFgHPnbBz2QK7gof+6a+Wdgfi6TCtO2uth6Ba/279fU1R
	 OgaBt/bSuYHdjEnMEyQLAEGmwwZd/NrUj5LXnVMYKqmgKqMTiZrBPyYutC4L6cS1gx84ec6/5NEm
	 iiyPppSFD5bAij58jfJ08xNZVP/+zvt62URXxDXGH+/I2WBsonGvz8EGJCzPWuO3hC8G9gS4984+
	 CpR1ON+6rGyo5/8mD12UaYkmWIgsBLFqj8YvZoc/yl0tqFi4EsMlap4e7vIMY0nBd/7Y1WFFEaSK
	 nqYWVOKycDWrjuqXqhMR7nJ2GFHmuRn+vjA2EO1X1IN1Jr+M1qcsoTKnvwrnuhijtvCbDgI5ONYu
	 uBF8DTjUXO2GRWXN8k5F8JrqIpuWvA+OJRhHxg9K0fo3wrqS91yg==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+08df3e4c9b304b37cb04@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] general protection fault in rtlock_slowlock_locked
Date: Tue, 11 Nov 2025 07:20:44 +0800
X-OQ-MSGID: <20251110232043.1602331-2-eadavis@qq.com>
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


diff --git a/fs/jfs/jfs_lock.h b/fs/jfs/jfs_lock.h
index feb37dd9debf..ab798de87202 100644
--- a/fs/jfs/jfs_lock.h
+++ b/fs/jfs/jfs_lock.h
@@ -29,7 +29,7 @@ do {							\
 		if (cond)				\
 			break;				\
 		unlock_cmd;				\
-		io_schedule();				\
+		io_schedule_timeout(HZ);		\
 		lock_cmd;				\
 	}						\
 	__set_current_state(TASK_RUNNING);			\
diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index b343c5ea1159..ee6e9ed5e3af 100644
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


