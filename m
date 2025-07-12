Return-Path: <linux-kernel+bounces-728484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0517B028D1
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 03:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 202D34A34A5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 01:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D22C14885D;
	Sat, 12 Jul 2025 01:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="FVquCKDt"
Received: from mail3-165.sinamail.sina.com.cn (mail3-165.sinamail.sina.com.cn [202.108.3.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFF24A1A
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 01:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752283160; cv=none; b=p88rA/F9KYGDb1otvVkWeXl1acZbLWA/x8J2Qg8Ub2kxO0OcSHREq+WVS/W5imRDsJLgKUxXQThmXPbaTsFELZEGZ8JPINmbNF3lmaZNKDhm72VN8F0MkwtxgGY1C9u61VrCnQxUzSQ3knIBbF2CZHrEQwKK/rLDc0Mth4qFNN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752283160; c=relaxed/simple;
	bh=8oz+C4fcRTeeuWVdSvnIB4IF8+u4wyEgMWi22xbVojM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NuvY8Y+YGvkMztBAolGWdrlqmjN2T9B5LArh85Jn7FsftApN/Kmj+D/eIogvtWNI5wZ0kEmoxokj0txfPuiiO8SglbqQKvSmD05tKM32VBh+2paxJCeg+TtFezMctDYEjpxDFDhByEvG4iZdESjz3Z3ymDfpv4YOsVNYZaGn8vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=FVquCKDt; arc=none smtp.client-ip=202.108.3.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752283155;
	bh=3wwDztNdeU5RDe9SiY9YOcv5+D7OMF06ElF6qq9xT+A=;
	h=From:Subject:Date:Message-ID;
	b=FVquCKDt3vU4H36riSZ9RP3tepZeHMMCrwshIAGi9sE8ALr/jb+kCTF9R5cjpsL2t
	 AWejY/W0oespsXbIdHXSSqPvpyPa1oEwaqSjIIxMyfUeDKUNJuiFQR4wFuLNL3kyAE
	 cqXcA1nuEouRSXek9ABhz5BYgHawWEl3pA8NyTAc=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 6871B809000035F8; Sat, 12 Jul 2025 09:19:06 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8923836685233
X-SMAIL-UIID: 3E24870DCA30487EA6F2C69E2B452290-20250712-091906-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+97bf275720e06ad75f63@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in rt_set_nexthop
Date: Sat, 12 Jul 2025 09:18:55 +0800
Message-ID: <20250712011856.3599-1-hdanton@sina.com>
In-Reply-To: <6871b125.a00a0220.26a83e.0066.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Fri, 11 Jul 2025 17:49:41 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    d7b8f8e20813 Linux 6.16-rc5
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=107f9582580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f6cfc97245100778
> dashboard link: https://syzkaller.appspot.com/bug?extid=97bf275720e06ad75f63
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17b6728c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12aac28c580000

#syz test upstream  master

--- x/net/rxrpc/call_accept.c
+++ y/net/rxrpc/call_accept.c
@@ -348,7 +348,7 @@ bool rxrpc_new_incoming_call(struct rxrp
 	if (sp->hdr.type != RXRPC_PACKET_TYPE_DATA)
 		return rxrpc_protocol_error(skb, rxrpc_eproto_no_service_call);
 
-	read_lock_irq(&local->services_lock);
+	read_lock_bh(&local->services_lock);
 
 	/* Weed out packets to services we're not offering.  Packets that would
 	 * begin a call are explicitly rejected and the rest are just
@@ -405,7 +405,7 @@ bool rxrpc_new_incoming_call(struct rxrp
 	spin_unlock(&conn->state_lock);
 
 	spin_unlock(&rx->incoming_lock);
-	read_unlock_irq(&local->services_lock);
+	read_unlock_bh(&local->services_lock);
 
 	if (hlist_unhashed(&call->error_link)) {
 		spin_lock_irq(&call->peer->lock);
@@ -419,20 +419,20 @@ bool rxrpc_new_incoming_call(struct rxrp
 	return true;
 
 unsupported_service:
-	read_unlock_irq(&local->services_lock);
+	read_unlock_bh(&local->services_lock);
 	return rxrpc_direct_abort(skb, rxrpc_abort_service_not_offered,
 				  RX_INVALID_OPERATION, -EOPNOTSUPP);
 unsupported_security:
-	read_unlock_irq(&local->services_lock);
+	read_unlock_bh(&local->services_lock);
 	return rxrpc_direct_abort(skb, rxrpc_abort_service_not_offered,
 				  RX_INVALID_OPERATION, -EKEYREJECTED);
 no_call:
 	spin_unlock(&rx->incoming_lock);
-	read_unlock_irq(&local->services_lock);
+	read_unlock_bh(&local->services_lock);
 	_leave(" = f [%u]", skb->mark);
 	return false;
 discard:
-	read_unlock_irq(&local->services_lock);
+	read_unlock_bh(&local->services_lock);
 	return true;
 }
 
--

