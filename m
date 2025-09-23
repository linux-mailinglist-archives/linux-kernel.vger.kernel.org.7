Return-Path: <linux-kernel+bounces-828086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E8AB93E8A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4CEA18A4295
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 01:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD2D26D4CE;
	Tue, 23 Sep 2025 01:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="NRpkpxmo"
Received: from mail3-165.sinamail.sina.com.cn (mail3-165.sinamail.sina.com.cn [202.108.3.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A11526E717
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758592255; cv=none; b=icP2fFJAtEcQT/gdrG1zvBAlJuDkY4Gcbo98PyvOvxP+i/KAVWDAqFJJ0WqFyDm1CJ8OSVbExYF//ZShYRsTshlMotoLZ4knGjrzIwkF6irgYzuU7RMyQarInlT26UDnRP1KFQj9Gq+VSMFFLDkJb3Rq1E3MJUcl6ryHID5i+PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758592255; c=relaxed/simple;
	bh=qFbXdYqT/W9bCrTUTL6I/oX4JN2vs4G4Mvq32kUs0bU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rp9TVrHXI3Ex1O4hvnbXKN9HEXbCMJgCZH3OSPgJwi8rhsVsnai+HmyMDSqJFJzWe92s4vUQ598TzOibtU5w4JMqVmRWNureeQZCnH8wLePWvOCqdXTos/Jj5BSKeANdnVp8Twyk0+Lm6JhAnb8jUDkr0IHZDYacNgQSLPN0Aq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=NRpkpxmo; arc=none smtp.client-ip=202.108.3.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1758592249;
	bh=EKuxRKBt9t+pPx6sY+B+LVWV7vggWpt4FNbzTZuuSYo=;
	h=From:Subject:Date:Message-ID;
	b=NRpkpxmoXXePTpatzW4ZGzf9fnVWtJGAfIquwjylgeSFdK3PxlzlRGAeRaYXb/jpH
	 QWr7S+NB6opExZKCspPNA4vurql3QrWCb6fAxcKG8+nrYm5eACPm2ubYbLUtV100fk
	 /zoyow/O0f7sqp7qyHlRYF5xDd5K7CgOkGiqdwaM=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 68D1FC63000001BD; Tue, 23 Sep 2025 09:48:21 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2762746685190
X-SMAIL-UIID: D0D6EE95DD86424096F9F7BCA767E5B9-20250923-094821-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+5c5d41e80248d610221f@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] general protection fault in blk_mq_free_tags_callback
Date: Tue, 23 Sep 2025 09:48:08 +0800
Message-ID: <20250923014809.7447-1-hdanton@sina.com>
In-Reply-To: <68d1b079.a70a0220.1b52b.0000.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Mon, 22 Sep 2025 13:24:25 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    846bd2225ec3 Add linux-next specific files for 20250919
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13c238e2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=135377594f35b576
> dashboard link: https://syzkaller.appspot.com/bug?extid=5c5d41e80248d610221f
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155e427c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17bb8142580000

#syz test linux-next  master

--- x/block/blk-mq-tag.c
+++ y/block/blk-mq-tag.c
@@ -565,6 +565,7 @@ struct blk_mq_tags *blk_mq_init_tags(uns
 	if (!tags)
 		return NULL;
 
+	INIT_LIST_HEAD(&tags->page_list);
 	tags->nr_tags = total_tags;
 	tags->nr_reserved_tags = reserved_tags;
 	spin_lock_init(&tags->lock);
--- x/arch/x86/kvm/emulate.c
+++ y/arch/x86/kvm/emulate.c
@@ -3991,6 +3991,7 @@ static int check_perm_out(struct x86_emu
 #define MD(_f, _m) { .flags = ((_f) | ModeDual), .u.mdual = (_m) }
 #define E(_f, _e) { .flags = ((_f) | Escape | ModRM), .u.esc = (_e) }
 #define I(_f, _e) { .flags = (_f), .u.execute = (_e) }
+#define F(_f, _e) { .flags = (_f) | Fastop, .u.fastop = (_e) }
 #define II(_f, _e, _i) \
 	{ .flags = (_f)|Intercept, .u.execute = (_e), .intercept = x86_intercept_##_i }
 #define IIP(_f, _e, _i, _p) \
--

