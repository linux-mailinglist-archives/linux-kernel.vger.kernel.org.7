Return-Path: <linux-kernel+bounces-766669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF78CB249C6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 432451886285
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13BE17B402;
	Wed, 13 Aug 2025 12:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="Cu0wjHG7"
Received: from r3-21.sinamail.sina.com.cn (r3-21.sinamail.sina.com.cn [202.108.3.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92D1A920
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 12:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755089248; cv=none; b=hou8VO8E/qnnPHQUWVvHf9BI508w15i/u/QBh8iixyzQrmeO4z+9pDFGm9wx186NfWBzXtgM6uX+k7Qfp28G3jnIJgS4BIdUOsPVZkeDuLZZZceUiE29WSYbiR97rHw1qg6rQwbd7v8nUhz9telZ+D7CT3c2YOt3554UikxE7N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755089248; c=relaxed/simple;
	bh=gxFNJjWKMIlA5cUR/kbC5WO+DTe1n5nWuUk3O+fKVeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0RfkcIzSUFeQBO9FHCPJEvlZBlFC/2d0COkuhT3kf/pqVov5BwjLV6qV3MjVdmCvDT8EBSPNqoiSoxfwsyrYLbmPrGeTTwak84peYFHpS1Rh/gB92TS0EZNMrUWQFzhk6WNvwylHQo/7oJCq5AGROeoeSPh7CgVxUxofScdpOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=Cu0wjHG7; arc=none smtp.client-ip=202.108.3.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1755089243;
	bh=4TBeSdRnP0xo4kGVNaBP/HsmAAGKstmN/YkNLM/Zszc=;
	h=From:Subject:Date:Message-ID;
	b=Cu0wjHG7g/YxNQ5JtRSEIgm5joRfKw5qKNtftWbhzBan9DYoZcgm4qPLUE9wgzSLV
	 +IjATiZ6hbMV/jODqnoBTOU7W5Mhk5WD9rqOUn4i3OzCQIOGjK8ulbXT2S5n8RvFCn
	 n2XRx0+PJ7KWuMDLBT9u9JumMpoTcUAxVeQZWKA0=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 689C881200004CA7; Wed, 13 Aug 2025 20:41:56 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8667276685327
X-SMAIL-UIID: 70C8F54CF43043C4985A0A2826581A37-20250813-204156-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+b4d960daf7a3c7c2b7b1@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kvm?] [net?] [virt?] WARNING in virtio_transport_send_pkt_info
Date: Wed, 13 Aug 2025 20:41:44 +0800
Message-ID: <20250813124145.4469-1-hdanton@sina.com>
In-Reply-To: <689a3d92.050a0220.7f033.00ff.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Mon, 11 Aug 2025 11:59:30 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    37816488247d Merge tag 'net-6.17-rc1' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10b3b2f0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e143c1cd9dadd720
> dashboard link: https://syzkaller.appspot.com/bug?extid=b4d960daf7a3c7c2b7b1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f0f042580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14855434580000

#syz test

--- x/net/vmw_vsock/virtio_transport_common.c
+++ y/net/vmw_vsock/virtio_transport_common.c
@@ -258,9 +258,7 @@ static struct sk_buff *virtio_transport_
 	size_t skb_len;
 
 	skb_len = VIRTIO_VSOCK_SKB_HEADROOM;
-
-	if (!zcopy)
-		skb_len += payload_len;
+	skb_len += payload_len;
 
 	skb = virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
 	if (!skb)
--

