Return-Path: <linux-kernel+bounces-772363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C0AB291C3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 08:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB772201FB9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 06:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A578202963;
	Sun, 17 Aug 2025 06:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="Z/X7hl5v"
Received: from smtp153-170.sina.com.cn (smtp153-170.sina.com.cn [61.135.153.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DBA1A23AC
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 06:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755410883; cv=none; b=Dfx0Or8O5w99chesyqPvIOKpyXLn7Pb7ILLNJPvCt/76wf+85lZQK/035XL1grF0/9b1F7Q6LCqY5vCSB9vxQpsGJXsQL5W7ab6VFb5mShdBQOiiwywyV2ncB398XQuzsZTI2knAm0vHZXrCkG4j2zK012GPHjQLhRJKWDTGi8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755410883; c=relaxed/simple;
	bh=/pKa2tcuDzPRYxGGDkCULjqqZUOqBeD6NpUz5htdxOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=msPTrcLCBwjC6ZRnAVnCBQt30Ys82wLF44ORBIOkUQN8yGF5Jl98p0yldYJN7UUNgaYQGhZETEk45dCdPtZdLXkFUvXAQl+B7+2NfHxMwuKjqKosq8K1iXNUrdHZOWy34RPqeAIgnlNyywiShzUyO3K+Pk2TKE0Wlu16AppS3JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=Z/X7hl5v; arc=none smtp.client-ip=61.135.153.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1755410875;
	bh=0h7jPbRo9EJP5dkrr+/jiE4pNuHi5PfdP0bNWYSmDtI=;
	h=From:Subject:Date:Message-ID;
	b=Z/X7hl5vziajxqClV0xi0g/+48qlep0sdsnENxwiQxYgPsMNbO2LmFokiseX1Rb02
	 woy0Qo78pATNmgNvhT/ElcOp/ixW13QrEuurnMR8O90R9kSZZiD8xw82HgT9mmJYct
	 SmJxZJbqTgDQQ7WlMRYp1d3sqP7jqexy4zhOV/sc=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 68A171B500006035; Sun, 17 Aug 2025 14:07:50 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7402906292018
X-SMAIL-UIID: D7452AB1BFAC48C1B864500DE7C2AEB2-20250817-140750-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+abbfd103085885cf16a2@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] KASAN: slab-out-of-bounds Read in usbtmc_interrupt
Date: Sun, 17 Aug 2025 14:07:38 +0800
Message-ID: <20250817060739.4907-1-hdanton@sina.com>
In-Reply-To: <689ff5f6.050a0220.e29e5.0032.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Fri, 15 Aug 2025 20:07:34 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    931e46dcbc7e Add linux-next specific files for 20250814
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=11ef65a2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bb7fbecfa2364d1c
> dashboard link: https://syzkaller.appspot.com/bug?extid=abbfd103085885cf16a2
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a99842580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17108da2580000

#syz test

--- x/fs/smb/server/transport_rdma.h
+++ y/fs/smb/server/transport_rdma.h
@@ -61,7 +61,7 @@ void init_smbd_max_io_size(unsigned int
 unsigned int get_smbd_max_read_write_size(void);
 #else
 static inline int ksmbd_rdma_init(void) { return 0; }
-static inline void ksmbd_rdma_stop_listening(void) { return };
+static inline void ksmbd_rdma_stop_listening(void) { }
 static inline void ksmbd_rdma_destroy(void) { return; }
 static inline bool ksmbd_rdma_capable_netdev(struct net_device *netdev) { return false; }
 static inline void init_smbd_max_io_size(unsigned int sz) { }
--- x/drivers/usb/class/usbtmc.c
+++ y/drivers/usb/class/usbtmc.c
@@ -2453,7 +2453,7 @@ static int usbtmc_probe(struct usb_inter
 		kref_get(&data->kref);
 
 		/* allocate buffer for interrupt in */
-		data->iin_buffer = kmalloc(data->iin_wMaxPacketSize,
+		data->iin_buffer = kzalloc(max(256, data->iin_wMaxPacketSize),
 					GFP_KERNEL);
 		if (!data->iin_buffer) {
 			retcode = -ENOMEM;
--

