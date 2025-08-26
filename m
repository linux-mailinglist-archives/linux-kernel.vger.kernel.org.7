Return-Path: <linux-kernel+bounces-785801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 638C3B3513D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 03:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ADD23B15EE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 01:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACBB1EEA5D;
	Tue, 26 Aug 2025 01:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="Wx4sDnee"
Received: from mail3-166.sinamail.sina.com.cn (mail3-166.sinamail.sina.com.cn [202.108.3.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3A41DA55
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 01:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756173056; cv=none; b=RWPJc+teaipJdx2XZEdc+Ldcbd1J5vK7U0+kKGX6mWc32+V+F0GTFFOZNIsq/FyH4BCW9GlL9zhcRYOKOqE7cSGOdgKipc1dpVrgrJu9ha5R0JEroiSQ33dSyMfFCceVmgJyteSSh72UzGW+JaDmrI9gTy+JP/Z99K/Yg6j0D78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756173056; c=relaxed/simple;
	bh=JRsLsQleFv8urQVCbK8k8tTidJSbZVWnEwPIPP1rXUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQpYtV1IUqMZDSBm1Vt6pbcYaRwGQlChxi7rhcDl1sy8+CCpYYo2axIKELMqPoNnSZKCAGQ/USgYqjhnFv4JJ5ujSlkDFLk7qgpPplci13l05NdURH466j1z/2TOz4nNWOcqdK7IytuXEX9h1TyMNZP8bA6B9JJCYV/7EmBSLuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=Wx4sDnee; arc=none smtp.client-ip=202.108.3.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1756173050;
	bh=NWOrzp9GwbOy+3dlhsuri343j4nnHPOE/k440Ysqs9w=;
	h=From:Subject:Date:Message-ID;
	b=Wx4sDnee1wCOKrirHxuaVCaiWlpP/+3YmXIZGu7BtW1I+pCDq6I+A+6CMhADGqlnt
	 cqZ6gDW7dGupMhKyd+25aODBgldNWnqUI5VcxMfdfzE2FYJ0uIO3yNXqomCDmoSLbk
	 /5HpN9rfFdP39aYxRykVHiDIL9usnNeaSRNnbAR0=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 68AD12F5000005A0; Tue, 26 Aug 2025 09:50:47 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5704166816587
X-SMAIL-UIID: EEB4F71653A749819ED130A65C0AC9AD-20250826-095047-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] unregister_netdevice: waiting for DEV to become free (8)
Date: Tue, 26 Aug 2025 09:50:35 +0800
Message-ID: <20250826015036.5513-1-hdanton@sina.com>
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
 
@@ -197,7 +199,8 @@ static void j1939_can_rx_unregister(stru
 {
 	struct net_device *ndev = priv->ndev;
 
-	can_rx_unregister(dev_net(ndev), ndev, J1939_CAN_ID, J1939_CAN_MASK,
+	if (!priv->unregistered)
+		can_rx_unregister(dev_net(ndev), ndev, J1939_CAN_ID, J1939_CAN_MASK,
 			  j1939_can_recv, priv);
 
 	/* The last reference of priv is dropped by the RCU deferred
@@ -377,6 +380,10 @@ static int j1939_netdev_notify(struct no
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

