Return-Path: <linux-kernel+bounces-873211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D017C135F5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5671418991D9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FDA22156C;
	Tue, 28 Oct 2025 07:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="dr77eSz3"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A062786337
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 07:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761637890; cv=none; b=DXBm2VAlDy3bQOSzythsPVfHZWAuWuWDBxCredjgvPjVKQQ6g8gB5vivixMC2yTIeoiNIMubLxbJl1IWrCcsSmaTnDtsdNaWevwJUh2KBsdveIfapAv8lMVLVs23p/0VtoMyhOc8r7TlUrBU51GvbQPC68uatjJDyNXcmPVf3BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761637890; c=relaxed/simple;
	bh=RI4ZpPimzBkI/6LB5pWFFDa8aNPuJoYlq4bWlZwwhro=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=OVPHgjX2oaudLzv/pJL7VCs+iVcaSJ3ftIfAUb+0nHLejGQUSQN1Mtz6EsU/EY4uDi0J3j03I5BFcJ0IukaOoWWa/sY3Pze0q+IzPYA/Qzzeo8mIJM/1Q/6PohhJlg3I9VYPIdGRgSlY4YMNr9sOAJx+t78s1iq8g9b8PFe8jz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=dr77eSz3; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1761637883; bh=X8Z9S2Brzoz10agEppSjdDi0hv619u+UG/eNemPnETA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dr77eSz3uSGKuV9KgkHfZav6HbD934AFAUVJDrg0DOPbt13vqU6ebBhlLrZxpfRcJ
	 7UKean3hysbp1EOLwRKvoz3XQuDSaXSgdDhyiGQMOCHr4v69kNAHTC/Y9vS4k3EUmW
	 4sHK/0m2My8Pq18yZvuoZtshPP+9+bw/Qz9Dfqt8=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.201.7.117])
	by newxmesmtplogicsvrszb20-1.qq.com (NewEsmtp) with SMTP
	id B4D0847E; Tue, 28 Oct 2025 15:45:13 +0800
X-QQ-mid: xmsmtpt1761637513tqs4mngzu
Message-ID: <tencent_BB9F66963C1B37B6964036B64A0E75957709@qq.com>
X-QQ-XMAILINFO: MzNwb/pqyJTk+natQYQUvXOkiCiq7IY2rBRAR6DeiyaDLPj5daNT32VLWykvLt
	 5N0h6egi307nlEGBQBuGag5vBj/TBGe8b4gYUtjBrBehNeE5wtGOHOtsiZZH87ou5+Vk2GatQSnS
	 pSZ8qYJliE6shQh0rFOed2AJud6wt8/gwOzydXn0u7goAJgPkqMeSw3HVT0Ets4ATwSoGTMhqTSz
	 6I24dF2H+ICcNLtCh2uv/zK+SmY/pRSs1RMqXJ6xuCCcHqIwk3WEXPqp0b/gv6PTC7HJ7HPH6IMT
	 3O1AwlPzdsoykDpnAkVGeBMeNARpPc3JlVeAAw/DHedg0KYg/lRgq2UF3Bo+7wzASe96zUqRO0gd
	 X9uysJvkYP8Pi/Up7PfMCZjR1h8inP9oeUa6Lq83ycQnat8oBCq3Ts/ab5Q9aFUDaMHP1fVwjZwe
	 nNg91u2MYBjJ9vhYwNzgn/i1qzx0oS+gX0B3ArdK9TMAd3pNfIB1+A0DKeSMBL0FpVGuE8ILL7F0
	 D4Nl7IMMkVusRjOJMoVPNeojmiXQC6u0dSycGtvbq0SIUxldVZMO9byO1HyjediikN7w8yf0aB/6
	 cbQNQvgKcR9tP+tyJY//P9fKQtd0earBCeQgYHWpktIS4GxbI51HMlU/F5KzZls9g3lY1pWyfv1q
	 WnK9nJcdoHdVC7DoMOYPRgLKsJMGi7HPlD+TrM/LK0QV2A3n79NGurRHiK8E/QE64OE32Ilg4AWI
	 X1ov7r4pfOMGGJGVoGTxd7xriye6ZgvzZqafA1h4t0rQIswXJwX9spQsjGHNZ/ztW0cWyEOIjgqs
	 HYTIxSK9v9neF2gESDj0Ah3RrSj4gXRgTwdHP/1Xiw4axnV9fDhGPlIYz1c+5bs9793+7tBspQQ4
	 2k6UhBoYKAZOc9B9HWp0mck7k7JlmxuPMhSsWfPYy6uUfN3JMoMQCWSg/X7OdPFWRjHAk2sQiWAs
	 8pUGSlOgqyBMt7Y99ETCZhNCEVBe9cCVi6UhoQCuA=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+24d8b70f039151f65590@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [nilfs?] WARNING: ODEBUG bug in nilfs_detach_log_writer (2)
Date: Tue, 28 Oct 2025 15:45:13 +0800
X-OQ-MSGID: <20251028074512.2523502-2-eadavis@qq.com>
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
index f15ca6fc400d..9e95b0255bfe 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2671,7 +2671,7 @@ static int nilfs_segctor_thread(void *arg)
 		}
 
 		prepare_to_wait(&sci->sc_wait_daemon, &wait,
-				TASK_INTERRUPTIBLE);
+				TASK_UNINTERRUPTIBLE);
 		should_write = nilfs_log_write_required(sci, &mode);
 		if (!should_write)
 			schedule();
@@ -2808,6 +2808,10 @@ static void nilfs_segctor_destroy(struct nilfs_sc_info *sci)
 
 	down_write(&nilfs->ns_segctor_sem);
 
+	if (sci->sc_task) {
+		printk("!!! sci %p sctask %p %s\n", sci, sci->sc_task, __func__);
+		//timer_shutdown_sync(&sci->sc_timer);
+	}
 	kfree(sci);
 }
 


