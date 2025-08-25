Return-Path: <linux-kernel+bounces-784687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D55D4B33F9C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 819073BB280
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4827835965;
	Mon, 25 Aug 2025 12:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="enf21uWI"
Received: from r3-24.sinamail.sina.com.cn (r3-24.sinamail.sina.com.cn [202.108.3.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571971EA80
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 12:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756125340; cv=none; b=HfAaXLZ7wbEA5Al6QFDLHF1Uu+YQRaGW5amSEfF40IpRvmckqZPA6Q+1EMxwCzgPUynxSKOzhVMWn12qrX+tZyTseSs148Ya9T9CiMl+eQ+uMjdHhRIF00+NQKwpjpGTgViSsjaJbXm/7yfuusKwEHI3GUf0yzDtNEobHE7jPC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756125340; c=relaxed/simple;
	bh=ITQIjn2Yw+l1/afePS2CmSmBhu03aNZLEK5VdG+qsZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MksQW5jZ2535mY7BGth1n0uYfNKkT7I9G5eO/9RtP2OfVLzu0SZ+A7YQmHsSHdTRuTVGcWGXXNTWg4Yp9xZInYLdIDEG0IsAou7Tz77iXX4uUM9ngNpUQDFAF7BPhAefZ/uifigzdsncXv3DE1e7ZW950pXO3N7bQj/tSqQi8zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=enf21uWI; arc=none smtp.client-ip=202.108.3.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1756125335;
	bh=eY70Lk7gK5gRejIbmPUDNgaPbYbIPUN2+F83ciQTUjM=;
	h=From:Subject:Date:Message-ID;
	b=enf21uWIZRNaIpK7iaSi2/OmW5HUpEdhXYK9iKtHXYtXD1NO2se7V0nNoHo+HPN2x
	 xCUHAyxapAkWcpvNHxHD6Y6VSdB2nIFacy8xPrHSUks6yrBhB8Z7rtvmnt2B8ysGFV
	 JA1FU5NTNYQqhDY4+/HGksno9vyUV7hvrdbA9bQc=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 68AC58910000496B; Mon, 25 Aug 2025 20:35:31 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8739666816109
X-SMAIL-UIID: 26599C5A88DC4BD8AF9D365A29D14898-20250825-203531-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] unregister_netdevice: waiting for DEV to become free (8)
Date: Mon, 25 Aug 2025 20:35:18 +0800
Message-ID: <20250825123519.5453-1-hdanton@sina.com>
In-Reply-To: <00000000000051197705fdbc7e54@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Fri, 09 Jun 2023 18:34:58 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    67faabbde36b selftests/bpf: Add missing prototypes for sev..
> git tree:       bpf-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1381363b280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5335204dcdecfda
> dashboard link: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=132faf93280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10532add280000

#syz test upstream master

--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -59,6 +59,7 @@ struct j1939_priv {
 	/* segments need a lock to protect the above list */
 	rwlock_t lock;
 
+	int unregistered;
 	struct net_device *ndev;
 
 	/* list of 256 ecu ptrs, that cache the claimed addresses.
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -157,13 +157,15 @@ static void __j1939_priv_release(struct
 	struct j1939_priv *priv = container_of(kref, struct j1939_priv, kref);
 	struct net_device *ndev = priv->ndev;
 
-	netdev_dbg(priv->ndev, "%s: 0x%p\n", __func__, priv);
+	if (!priv->unregistered)
+		netdev_dbg(priv->ndev, "%s: 0x%p\n", __func__, priv);
 
 	WARN_ON_ONCE(!list_empty(&priv->active_session_list));
 	WARN_ON_ONCE(!list_empty(&priv->ecus));
 	WARN_ON_ONCE(!list_empty(&priv->j1939_socks));
 
-	dev_put(ndev);
+	if (!priv->unregistered)
+		dev_put(ndev);
 	kfree(priv);
 }
 
@@ -377,6 +379,10 @@ static int j1939_netdev_notify(struct no
 		j1939_sk_netdev_event_netdown(priv);
 		j1939_ecu_unmap_all(priv);
 		break;
+	case NETDEV_UNREGISTER:
+		priv->unregistered++;
+		dev_put(priv->ndev);
+		break;
 	}
 
 	j1939_priv_put(priv);
--

