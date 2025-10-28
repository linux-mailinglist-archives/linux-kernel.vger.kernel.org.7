Return-Path: <linux-kernel+bounces-873017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B38A6C12D6C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 05:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78A6B4E60E0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 04:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D022882AF;
	Tue, 28 Oct 2025 04:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ZHtnQMm2"
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37FC23506A
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 04:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761624535; cv=none; b=Vstqfrc86S+S4tiJQTnxzZf7UKnOdVvBn/inN22Mbin8Y9bAkuRXuNMxhtmuan9i7gRY5Z69c1XiOnPK+4LMkRYnnQOkFBPuR+aXclVIV7o5rm6DhwLyEXLGBKIht28BIDRAYb81JVNbqQiaZJAquz/e8xE3aE0q3NPqusGOMZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761624535; c=relaxed/simple;
	bh=HaR9pRqEZ0h/PFm6A0Jqaf2ohnXwq3MZsbhMYGH8Uvc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=hLOsiXSsD9zEYyEqTNcqpc2jhj1JYPbVWPmt27jxGbLJfsZ6APrkMfOJNeR+2s1Nt7HiCSXhOgtBE62gYc73lOrqox57yzQK6ALwX1yuOqJS4Yr+LA0hbhCslkEJO6r71G5u+8j0diuh+iwob3WlAgtIFspeydZH1kF+HzUJnY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ZHtnQMm2; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1761624525; bh=gyh8ISA9gEr432VntVPXJ6flt6e2ZREbQTB+O4k2QqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZHtnQMm2fukoNxoa39EjkBFLCBKaDl73mfMsNXFJb7vAK6+x4wLGJSmD+vqdhf6Lw
	 Z59CNQvz53/dClf5XqMVMZ1Y6k36yHSLKXQyCpEm0Z2TM7c3lqAPRO1a3Mnxw5GnnC
	 7Mp4882o1rN8Q/AXHj9d1JQu3nf2Yu8Yhq0ISDxc=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.201.7.117])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 6B997EDC; Tue, 28 Oct 2025 11:26:57 +0800
X-QQ-mid: xmsmtpt1761622017trqozedvc
Message-ID: <tencent_7F051BEF4BA91BCE253CBAA7BB7133FD9E08@qq.com>
X-QQ-XMAILINFO: OATpkVjS499umwbUbosFTV/VMx14ASpe/d+Tg3MBarD7ZRmkdIbvUJji6oiE9u
	 v2iSZDdJG6sPC/JNI7nLudt1CPAD1HY8uNxWw8UwBnR9YwuvaxcyehkdnFNoFOEjiBrKL1Hngsah
	 bvIIPbB8/xqg/UCEzetf8z1UGfxcJcJPsvRhLifyis+2nK03MAIOddhVA+ruk++NGr5plg2VXAF8
	 KadHke7gPw8vW/xh/xVXd9PHqNC2q27nb2vRq6SwJzc33X0tf+bA2+LF1HEfOB+5Dg9kSItdEsgg
	 uhcYQEW739lBBNVL4JIFhgyVz4Nycn+oguxlTBg0ynGBZ9TgboyTiWIUYbwanS1VziVOf5IUeRM9
	 +8+y4lojFM0u8J/WArFEI6YfbWU6NG7ZLkDqH/OSsAi3ZyzLaOqQSDGqdhgOSm8y8ERAJqp0qhc3
	 blwu/vCUpWsmhrshDQLYqbaOwOmkv4BH4q5cb9WIlGk5m5Zpxhbigg9mIpBnbifsLr3p6eOQGdzW
	 bb7y31qdB74w6Hb5ek+rSkCeaO1gGc1F2UbqjQDxNap+QVdVa8LjUW8vNxmCR8iuWxMJkbX5Eads
	 ayCXbxh3ZlENQM8iFmTwIggwj4iw8u1UU4zWgAUwv2hhgYrZb88q0GT5u8xKWEOXQfibF8mzdLPJ
	 QTCheJmX9x9ahLrwRnC4NBQzwuqxPiaK3CUIl3prss2NGQnwWjVrAXqLr1zXuLmQrH97z2twJlf4
	 pGdG+aDNYE0/rBh+oaDr+tSoytMa8smeyJBilfquC3yDe8QQgN+TT5ZIU8j8lsy9tRdUUiAe8PWa
	 K//Qj7njXcT7MYUFznD13BMr1ASBaX13COBL2F1KdoH/47c997wxkvv8DtXs93oMbUWf960gKTwY
	 Jx+U5GdDjB2GCOe6htGcteUnt/12PNg8uB3f80Bh8nXhGt6iIDfmKPBxNDkxnFhpXIlfYBskOyCw
	 0b4/KuLVuI+oLpFVJAItB51aHQJlbV
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+24d8b70f039151f65590@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [nilfs?] WARNING: ODEBUG bug in nilfs_detach_log_writer (2)
Date: Tue, 28 Oct 2025 11:26:58 +0800
X-OQ-MSGID: <20251028032657.2278041-2-eadavis@qq.com>
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
index f15ca6fc400d..0e8733bedfcb 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2808,6 +2808,10 @@ static void nilfs_segctor_destroy(struct nilfs_sc_info *sci)
 
 	down_write(&nilfs->ns_segctor_sem);
 
+	if (sci->sc_task) {
+		printk("sci %p sctask %p %s\n", sci, sci->sc_task, __func__);
+		timer_shutdown_sync(&sci->sc_timer);
+	}
 	kfree(sci);
 }
 


