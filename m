Return-Path: <linux-kernel+bounces-813576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EBFB547B2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8488564E35
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93C427E1B1;
	Fri, 12 Sep 2025 09:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="hBhoOIi0"
Received: from r3-20.sinamail.sina.com.cn (r3-20.sinamail.sina.com.cn [202.108.3.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065A427BF99
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757669467; cv=none; b=n5RTBG3Bf5eA1g6EoZQtDsFr4L8JIcV+xasqS3yJW5JoCLO/k0awROiLP9S6twXlk6T06Nl3PPXo2dbWxk2tiAkn7L0Ss3WSLYIp0shOAE7ZDlf+UAzdQG5Ecs3MNHHvPx69BoEEracUPhYXVva0dUyOhWMG2Z1q/fb957FsPIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757669467; c=relaxed/simple;
	bh=VLzRH5i0JLT74wmDUdGamn6Jxb9ovbHt31u7tOOVi30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T1RX3ndVg8LH2tvLlKFNmAN/kZOSiS/RqFgbh1ShMCt080C25Ziv0kYDgk37zjOAykcEC0bp5H0ELQijY6+A7G2+cNWZW+ECpO3S++YXLi1t/5Vs2sUFulW5ZG74PDyad81iD5UZ9eW8KDvmUHZ+hi3IEvr4WWLWx2WEqQRhc3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=hBhoOIi0; arc=none smtp.client-ip=202.108.3.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1757669462;
	bh=dC/FEgwzaJQpUN/2woeCURGorJIUHc+dhOmt5OhDmWc=;
	h=From:Subject:Date:Message-ID;
	b=hBhoOIi0DsI3OlMOdFJussCdhEtm9OIROtiSXCbisob6b19Ei8pLMzVBb2JopY65W
	 HGcIbd8xKlmKW2KJj5GKkqlTciaYQtq9mqJpqGIeAht9B2cpe61F1lEhewyCDSEmQ7
	 ZPu4bzZFN2owO2gDc8niAYQWR1F5Lv0mBKP7aIPI=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 68C3E84B0000185A; Fri, 12 Sep 2025 17:30:53 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 300374456618
X-SMAIL-UIID: FE4B7EBD75BE4438B085BBC002C532AE-20250912-173053-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+5a66db916cdde0dbcc1c@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] BUG: corrupted list in flow_block_cb_setup_simple
Date: Fri, 12 Sep 2025 17:30:40 +0800
Message-ID: <20250912093042.6843-1-hdanton@sina.com>
In-Reply-To: <68c3c675.050a0220.2ff435.0353.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Fri, 12 Sep 2025 00:06:29 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    e59a039119c3 Merge tag 's390-6.17-4' of git://git.kernel.o..
> git tree:       bpf
> console output: https://syzkaller.appspot.com/x/log.txt?x=1523e934580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4d8792ecb6308d0f
> dashboard link: https://syzkaller.appspot.com/bug?extid=5a66db916cdde0dbcc1c
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d4bd62580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d69642580000

#syz test upstream master

--- x/net/core/flow_offload.c
+++ y/net/core/flow_offload.c
@@ -334,6 +334,7 @@ bool flow_block_cb_is_busy(flow_setup_cb
 }
 EXPORT_SYMBOL(flow_block_cb_is_busy);
 
+static DEFINE_MUTEX(setup_lock);
 int flow_block_cb_setup_simple(struct flow_block_offload *f,
 			       struct list_head *driver_block_list,
 			       flow_setup_cb_t *cb,
@@ -348,27 +349,37 @@ int flow_block_cb_setup_simple(struct fl
 
 	f->driver_block_list = driver_block_list;
 
+	mutex_lock(&setup_lock);
 	switch (f->command) {
 	case FLOW_BLOCK_BIND:
-		if (flow_block_cb_is_busy(cb, cb_ident, driver_block_list))
+		if (flow_block_cb_is_busy(cb, cb_ident, driver_block_list)) {
+			mutex_unlock(&setup_lock);
 			return -EBUSY;
+		}
 
 		block_cb = flow_block_cb_alloc(cb, cb_ident, cb_priv, NULL);
-		if (IS_ERR(block_cb))
+		if (IS_ERR(block_cb)) {
+			mutex_unlock(&setup_lock);
 			return PTR_ERR(block_cb);
+		}
 
 		flow_block_cb_add(block_cb, f);
 		list_add_tail(&block_cb->driver_list, driver_block_list);
+		mutex_unlock(&setup_lock);
 		return 0;
 	case FLOW_BLOCK_UNBIND:
 		block_cb = flow_block_cb_lookup(f->block, cb, cb_ident);
-		if (!block_cb)
+		if (!block_cb) {
+			mutex_unlock(&setup_lock);
 			return -ENOENT;
+		}
 
 		flow_block_cb_remove(block_cb, f);
 		list_del(&block_cb->driver_list);
+		mutex_unlock(&setup_lock);
 		return 0;
 	default:
+		mutex_unlock(&setup_lock);
 		return -EOPNOTSUPP;
 	}
 }
--

