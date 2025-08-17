Return-Path: <linux-kernel+bounces-772345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F3EB2919B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 07:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6595F442684
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 05:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948201369B4;
	Sun, 17 Aug 2025 05:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="EBAxQ4XY"
Received: from r3-17.sinamail.sina.com.cn (r3-17.sinamail.sina.com.cn [202.108.3.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8831FDD
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 05:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755406881; cv=none; b=OYMCYhJE8Q6ttTnQNnLLG755l9soqHwMhSAeWYma+0lbXL0sJjQP8FaIKe+oIk6akU/kJJpDR4sEGPpgY2P2U6rAHRXhY0BGLny1dbZ9Z3eKmMWCpvH6k/zMtM/UCb2ggE/xWSqEFp6l9XGwPhxxfD0lPvN1yh0rYiBdbrfghTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755406881; c=relaxed/simple;
	bh=rrIpgW4C7mZO6EBJiMZ6E8ixPH3IeDdXtTRI50pmTMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYhu202Ij4MY4dGE4U+dL5BCdJ8aGpCVjZcCFwh9isk33Y2Z6m8ZhBpZFV3Ih5K7mS/Oo6DQg7u6iRIo7nzqIt+tUZVpb/ETazmWG7mVBwsOfz1+FdLUbsqtPT1wJY1UllP1TLPUCOcJe1+POZSJELOa8efFpnEHyHB5UBtkXNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=EBAxQ4XY; arc=none smtp.client-ip=202.108.3.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1755406876;
	bh=IQQL0v4vRfbHMh6qW8aNkQcZKTSaw2U1qc/SaxLCEEM=;
	h=From:Subject:Date:Message-ID;
	b=EBAxQ4XYZme+MioVD9OvckvFEt12fecGotfkELatTrkVOPz8OlntIBPYkx0p0UfBH
	 hR5m/mI1ewAKCiU6SoFxBdqsW3Lno3wQynOvfpbA6i+cAOJWd+CrLC82oES+B4Yanh
	 CneIq4dYWIQZlJEPCBoJw0h3rzg8P8pCKwmf3ULk=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 68A16212000055FB; Sun, 17 Aug 2025 13:01:07 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8539656291922
X-SMAIL-UIID: 00B832E2411346328319F4E6DE87ACBD-20250817-130107-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+abbfd103085885cf16a2@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] KASAN: slab-out-of-bounds Read in usbtmc_interrupt
Date: Sun, 17 Aug 2025 13:00:55 +0800
Message-ID: <20250817050056.4876-1-hdanton@sina.com>
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
@@ -2555,10 +2568,14 @@ static int usbtmc_resume(struct usb_inte
 	struct usbtmc_device_data *data = usb_get_intfdata(intf);
 	int retcode = 0;
 
-	if (data->iin_ep_present && data->iin_urb)
+	if (data->iin_ep_present && data->iin_urb) {
+		atomic_inc(&data->inflight);
 		retcode = usb_submit_urb(data->iin_urb, GFP_KERNEL);
-	if (retcode)
-		dev_err(&intf->dev, "Failed to submit iin_urb\n");
+		if (retcode) {
+			atomic_dec(&data->inflight);
+			dev_err(&intf->dev, "Failed to submit iin_urb\n");
+		}
+	}
 
 	return retcode;
 }
--

