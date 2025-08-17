Return-Path: <linux-kernel+bounces-772334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EAAB2917E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 06:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 724061B23DD9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 04:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598E31F0E34;
	Sun, 17 Aug 2025 04:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="Iq/WITMp"
Received: from mail3-163.sinamail.sina.com.cn (mail3-163.sinamail.sina.com.cn [202.108.3.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3521F14B950
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 04:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755403949; cv=none; b=ceJyASsrP99h3Z+jxlTUnZ0BwJoBmFsmzHip2/SKo/EpXuCHzYUdrRSa/gviWySnN6+rB06HsIK1N3YzvpKsex0MLhxOzkg3AhDzj3lrUKFZWQujhYjIC+AiUJBETsUJb/57FwR8kGN1OLw72/kkGX6L1bBJLUryKovzL0FZA0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755403949; c=relaxed/simple;
	bh=K8R+0dpCvkSVuolR4Ql5b5jghQI4nyElLQ9LWlhYMRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkpuDYlhFkMAzdIcLROEDEl9DPwKcZtLZwTHTEStCp9jcjo09OpZIFWS4TDGS6D9kPbPEI/w0Y8SIygYXkZLtBruwXOtUtzgICqgKNyLo/5LZQi/rMlMMZsQBEsoH7Y92PtcgVtdFPOSU0Or2JGWoijj+f+xJElokOP+5R3GG1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=Iq/WITMp; arc=none smtp.client-ip=202.108.3.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1755403944;
	bh=CCnsY5CPrLXD7dFDvA4RbttNuAU/xdEOke0b+NXHcNs=;
	h=From:Subject:Date:Message-ID;
	b=Iq/WITMpKtcHSc3/O6cp0WrnwpTW2p3R37jhB9p16BncNaCut7Sqcggvt40lSzqjT
	 kkLS4nG6IugJSOK4xHN6xf38oV9YJznwZRBErSbo52JtrdxujiK2Ms/U6sc+HxFmE9
	 O2XfcpH1tLXh9YmVbY/0qrrGKyTGSHh2OK/n00S4=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 68A1569C0000481B; Sun, 17 Aug 2025 12:12:13 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8456996291939
X-SMAIL-UIID: 499D276095E2449B8DA615FA06B1F0E2-20250817-121213-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+abbfd103085885cf16a2@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] KASAN: slab-out-of-bounds Read in usbtmc_interrupt
Date: Sun, 17 Aug 2025 12:11:51 +0800
Message-ID: <20250817041202.4853-1-hdanton@sina.com>
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
@@ -107,6 +107,7 @@ struct usbtmc_device_data {
 	struct usbtmc_dev_capabilities	capabilities;
 	struct kref kref;
 	struct mutex io_mutex;	/* only one i/o function running at a time */
+	atomic_t inflight, deinit;
 	wait_queue_head_t waitq;
 	struct fasync_struct *fasync;
 	spinlock_t dev_lock; /* lock for file_list */
@@ -2352,19 +2353,29 @@ static void usbtmc_interrupt(struct urb
 	default:
 		/* urb terminated, clean up */
 		dev_dbg(dev, "urb terminated, status: %d\n", status);
+		atomic_dec(&data->inflight);
 		return;
 	}
 exit:
+	if (atomic_read(&data->deinit)) {
+		atomic_dec(&data->inflight);
+		return;
+	}
 	rv = usb_submit_urb(urb, GFP_ATOMIC);
-	if (rv)
+	if (rv) {
+		atomic_dec(&data->inflight);
 		dev_err(dev, "usb_submit_urb failed: %d\n", rv);
+	}
 }
 
 static void usbtmc_free_int(struct usbtmc_device_data *data)
 {
 	if (!data->iin_ep_present || !data->iin_urb)
 		return;
+	atomic_inc(&data->deinit);
 	usb_kill_urb(data->iin_urb);
+	while (atomic_read(&data->inflight))
+		schedule_timeout_idle(1);
 	kfree(data->iin_buffer);
 	data->iin_buffer = NULL;
 	usb_free_urb(data->iin_urb);
@@ -2467,8 +2478,10 @@ static int usbtmc_probe(struct usb_inter
 				usbtmc_interrupt,
 				data, data->iin_interval);
 
+		atomic_inc(&data->inflight);
 		retcode = usb_submit_urb(data->iin_urb, GFP_KERNEL);
 		if (retcode) {
+			atomic_dec(&data->inflight);
 			dev_err(&intf->dev, "Failed to submit iin_urb\n");
 			goto error_register;
 		}
--

