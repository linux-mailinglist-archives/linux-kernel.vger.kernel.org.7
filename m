Return-Path: <linux-kernel+bounces-873052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B80C12ED9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 06:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C49B63ABDB3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 05:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13A0279327;
	Tue, 28 Oct 2025 05:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="gru9qQ7/"
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCD71EDA02
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 05:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761628818; cv=none; b=Ar4jtKMEqPE5P/Pal9Q65zf9ZutVDrlGavSmGHgjQtZc21uAYokVUjkjbNxSdNuzLcmQDWQXyPrsXmcJah79O2BCeWWacr1GoGo5XNihXt+ChzeuNL6QFotfw+7xB8WeBnGX7xuIL5l0VCvFLePLJMK6LMxelEWCsEDKVq+tjQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761628818; c=relaxed/simple;
	bh=oh8Tz9m/1rKLhD2FYlWXqDx2y8PLCzETicXbEjPRWFE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=h7yvksrOcE7C4W1Z/lalyUefGuEIIGHzykfAJ2kA0Ow2F8UBIDJ+mxR8ksn/6XoEFigEQfrh+A39sKRv1sx+HAggi0SJfyH8zlRYYgosrZI8TnERUcCLLULWZKyfsZ/UCml1H2PUzZKGHu7oUZFQe34UtREJvU7w8pkJD0idTEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=gru9qQ7/; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1761628804; bh=pF3tdoljRmoOmiYiRoqG9ogq3aUNZ6hKAKa9QDu+g1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gru9qQ7/5hRWnjj3GaNCMb/w8kuU3l87R4vBL7J0CzSI0lLDjhjOO3T9ShHzeozGN
	 dYjfQolJV/xYivZhMCvUc750y7BekNc37zVH+geaVH+ivPIOtMmHfLZDjb4M7IvTfO
	 +qfq2PwLo+07uWpA+yMDgM73ZxFtAj8N2L0z7QBg=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.201.7.117])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 41034880; Tue, 28 Oct 2025 13:16:16 +0800
X-QQ-mid: xmsmtpt1761628576t399n4h87
Message-ID: <tencent_1D087BFE6C682D456CDC95E8E8EEECF6CD0A@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoemJsVEB6ryQkk4CIVD4ZtLUPJ2NlIAsuGIayLfcmTn+vLXvN4iu
	 aJxNMQ9yKcH+qil7ERT/XbEDmjmI98gqo4JORZi75S8G3dWFp4Q91eof82J5sdiDz59/cSP+8AYh
	 /ba5NvxWimYY8mW5VL7ETkR+t2+yfDdaCxCL/fXq7bkamrDJD2432WP4SpIMEiS5Vf/rQkz0/z3N
	 G0XCoFm9XOuh4tA+EDDCkdWAUzBAtu1WlEJupt5xHSHSoBMEbhSu7LnIir/F2awH+chnbHafJiX9
	 xmiJ1SBInlqaFmakDm5gGdHJZ7gKP5pqTEj7VskG3yMvvrPTuOYaTlAfweF6eVBkOQ2008BRo+Vz
	 6fAbGAVrUkw58XtdbEKaJb/jo/2MFPs6MoVVw5o9TZBXe5K14j1uUQXxi3Zn9fCPL57So5n7/XCi
	 hCoCgq7pae1uJ9SrX8uExl53/lBavD7Rz6Xp79hEoNcEmGyM9yoirKP9j1UL5uusGH0Az67G9rTg
	 JLPBkIMw3yHVCVmrB3E+vOPPCCjaBZYa4M6MwPBTH9kwrIAyJgYCx4K3uYKxzWhExFkSezTF/HG7
	 6hQHyUWQTizFkB3omccGE5Rp/Qb9shrlVtu9BhC60wMW9AK9KN6asUx9UiCIB8zfyfGSk3NMI5Cu
	 E7AEHMs7fH/njDdQgAaRtzWBxSgY/C3A8f8x9xP4ypkjtweWg+nZLtu5Zgkg+XKOw9RRFGnsIJ2X
	 RSBgPM66+3f2qQec+Itv8QxCzvmkwz8IPV68S6KKMKxl3u4eYKU60CBCFwCrWlDAojed7VTOrsx1
	 vVYhK6g79oP/EV2EfpazCx9tpQH97tjh5vA9nMKurWpe8+NA7Q1BSzi4UXbzGmnbdyHNIbUXKURF
	 TFzwBXcCy+vewQeofLvwpoSh/uaYL4VvvwGdeU6BrgdCZVzmcS1XN/mWgrETkvXBKWLh0som23Hq
	 8mJY3aYQD7dnB4wUpBQ4+mVKlrbBrA6Fmz3mG0aEU=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+24d8b70f039151f65590@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [nilfs?] WARNING: ODEBUG bug in nilfs_detach_log_writer (2)
Date: Tue, 28 Oct 2025 13:16:17 +0800
X-OQ-MSGID: <20251028051616.2382229-2-eadavis@qq.com>
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
index f15ca6fc400d..8a17ae49bc41 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2768,7 +2768,9 @@ static void nilfs_segctor_destroy(struct nilfs_sc_info *sci)
 
 	if (sci->sc_task) {
 		wake_up(&sci->sc_wait_daemon);
-		kthread_stop(sci->sc_task);
+		printk("kthread start to stop (sci %p)sctask %p, %s\n", sci, sci->sc_task, __func__);
+		int ret = kthread_stop(sci->sc_task);
+		printk("kthread stopped (sci %p)sctask %p thread return %d, %s\n", sci, sci->sc_task, ret, __func__);
 	}
 
 	spin_lock(&sci->sc_state_lock);
@@ -2808,6 +2810,10 @@ static void nilfs_segctor_destroy(struct nilfs_sc_info *sci)
 
 	down_write(&nilfs->ns_segctor_sem);
 
+	if (sci->sc_task) {
+		printk("sci %p sctask %p %s\n", sci, sci->sc_task, __func__);
+		//timer_shutdown_sync(&sci->sc_timer);
+	}
 	kfree(sci);
 }
 


