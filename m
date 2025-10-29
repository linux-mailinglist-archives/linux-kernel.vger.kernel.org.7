Return-Path: <linux-kernel+bounces-875081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E518BC182C5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 04:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFD1A3A2B88
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 03:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5562DC780;
	Wed, 29 Oct 2025 03:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="DQ+AlmO1"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F82619E98D
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761708443; cv=none; b=tMUTDgs5eZHwPXowhY7aSRXl+8Tw7twUwILKqX2zR6iT4KCuIy1tU7DneZJ+jxb8b9V1DEQrHb4SulPyZWsAWIwbdBdOKxaqlUG2uOF+xoUiSaiBb2ekiJ8VulIo0/J/vbH2J09m4MWIGDi5azyym+DZlXes9J/E1FEN84ZntoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761708443; c=relaxed/simple;
	bh=FDG1GzlUqKmUnzVRu4SRW0NZFy5rTrCpjvGYMvvIxWg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=YWObVb8UD5D9RWr5oeJ48I7Tl5aFZVzDcFx46uXJdxGUXGbDI9MEe5lQ1+DWRtNR/e7gi5i1O3UDaJT25pq1z08bR53uJt0uSgGb9XkrD8Rbl/KpJAIx7z/DgPhuFUF0Pnb9325ES/LuIU5DcNt1J55K1Ag+aDfJWI2uBD6jCfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=DQ+AlmO1; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1761708430; bh=G1elsihGq75bveu/PzGM/B9KKNPiF9oxkVyUBO8vMiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DQ+AlmO1f1StBZ2p2gWEWK71XYu3QA10kSieGs/tf7fLsUsejRTkSGj7vecD45l1m
	 QVFlt9Ifdeuiy/Fhv0vkei1SIHP/NsMhwCJK5fCjwtZ1YE2RCa6Y8pd5ALnaJP5dOm
	 HtvDwRWfu16AJiqGcOMIgmJeWuZ34V1ItzJSum7Y=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.201.7.117])
	by newxmesmtplogicsvrsza56-0.qq.com (NewEsmtp) with SMTP
	id 1A719293; Wed, 29 Oct 2025 11:06:39 +0800
X-QQ-mid: xmsmtpt1761707199tq974ujl9
Message-ID: <tencent_EFA7FBC6CC92D88645C98F6EEB2EC04C8706@qq.com>
X-QQ-XMAILINFO: OPDQNGCUQ3qLCGAvu5k4nwsitaPGmA3FxVswUPMpyTt2Ve1WBeDyKGxUK9T6Pj
	 g/sbwMbL2ONjYqQGEtLiEKos/80BuY3G2QXoR2fpxyzekJsqb4A6A4Y6IqH9Jh+qMXBAjvoP5ufj
	 mkL89FUnD0oltFprNtyW46wBYqGfqMDXLpuCKDnp0p9ekPlHnzw8t1LWhcz9dJcD+r5wGbLvwNQQ
	 kHKr3093UkhlBxcwVwQbvslPrn4ky0OlzBwgakbpDTEo9vpPg/BLexMQ2nX5hnHGePUhFsQaC8UG
	 sZmeincKlS5rZqDVAF7pHu9czCW3iQEOyyqrpYBsnxQsk1IVa0JjTFU49IlFMR0X8PQieu2X+5b3
	 /DPbIxusjcySqGWNhqjuyQHdIR8MSTtbl3j3ZiR+LtdYwTfkuPNOSCiKPUE/IP1LinMYj7K/dO2A
	 Ycit3L0kU+t3RPAs35yPNsLvJYo4ZNJvcoMOOplfiSnKIG3boNHCi047S0Qv7sJgxB+fL5KI97ED
	 8/AB+6wRmfG6aY7jgFzLXX2h2v4DUMX8JMN+Llga1y6+e4ptXNU/7Qfw5Cp6I53vjut48s9L0JOP
	 Ch/OfVeJjNGNoHQLCPieAWgna3rsag3qItjw8/PRTKBcL4+dnlYiVWokxhy6SUA95mxKj/GQESzv
	 C3wlODqj7Wz4wvT9/ZXDVX0zagJAur7Xct23DGgumC28ORTSfB+92d6f3aa+LupM2Ld2qLsnxTde
	 GB5+VfKEMBYwjxopla9kG75UO3AuFA4xlHlhZF+MULppzBfTKMoPN/l5IZWnR0LLoH6YBOPF9/Tx
	 cus/b0sVyI3jTVoEg01X+MKnmls/UOi8JfeT/Kdm75WMLjqbQej+l70VTNaOZ2HXLd0GliFaAn7z
	 LRcFEB2RBMnn8neUxMXIC+S6lC1YDx7kTiPiHyJn42SfqfX5tNIUhS8JgaYvmwwXiTKQkwNMnavE
	 4u2mWlcdVLCd0ilc9YLw==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+24d8b70f039151f65590@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [nilfs?] WARNING: ODEBUG bug in nilfs_detach_log_writer (2)
Date: Wed, 29 Oct 2025 11:06:40 +0800
X-OQ-MSGID: <20251029030639.3199108-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <68ffe1a8.050a0220.3344a1.03a1.GAE@google.com>
References: <68ffe1a8.050a0220.3344a1.03a1.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index f15ca6fc400d..deee16bc9d4e 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2768,7 +2768,12 @@ static void nilfs_segctor_destroy(struct nilfs_sc_info *sci)
 
 	if (sci->sc_task) {
 		wake_up(&sci->sc_wait_daemon);
-		kthread_stop(sci->sc_task);
+		if (kthread_stop(sci->sc_task)) {
+			spin_lock(&sci->sc_state_lock);
+			sci->sc_task = NULL;
+			timer_shutdown_sync(&sci->sc_timer);
+			spin_unlock(&sci->sc_state_lock);
+		}
 	}
 
 	spin_lock(&sci->sc_state_lock);


