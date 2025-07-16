Return-Path: <linux-kernel+bounces-733668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1ECCB0779C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CE4F584E39
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102C221C18D;
	Wed, 16 Jul 2025 14:07:48 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23731C54A9
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752674867; cv=none; b=NKK18nu1w/c34JGxpO4jl0/LCXrWrINy1qVXlP7nZ7pmwVrtsTs1A75Zqa5xZw11S0iGwvUagZVepPe6nJUHbjBrXNtagX7D8aAK/HGMyIIF1ffuYLcZbjAe8O8EO2aFeLPulQ1Wa4/TRthZ05D8rw1kD5Sc1LK5ZZaIPJ3t5t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752674867; c=relaxed/simple;
	bh=oQfYiacrS69ebBncUxb03TAOdjeChVxHp2r5O+gim0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L3J5NQSHX2qQj9riMJ3RRcky4udwJWqmPWYrOS7bRg5LxjyHodfSEQtPVhC4hWk4oZjs2uhRDyO517K6tU7TzZVCyf6jQCFLLg8deN6O9lxvNB4/iPNI0/deOrESS+3oMvG2gL3xrCFgJvEBmbkeAVr15lu4U9TFyRIGqeJ1zy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 56GE7OWg078114;
	Wed, 16 Jul 2025 23:07:24 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 56GE7IaE078088
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 16 Jul 2025 23:07:24 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c83f37f2-a0d5-4c3d-b311-a3bc8ae142c9@I-love.SAKURA.ne.jp>
Date: Wed, 16 Jul 2025 23:07:17 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] media: imon: make send_packet() more robust
To: Sean Young <sean@mess.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Hillf Danton <hdanton@sina.com>,
        syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com,
        LKML <linux-kernel@vger.kernel.org>
References: <40417f2a-e0d8-4f3c-9a37-a0068b6f268a@I-love.SAKURA.ne.jp>
 <0ad3effe-efed-4304-862f-4c8f901e79e9@I-love.SAKURA.ne.jp>
 <2ac5d313-c754-4fb9-acd3-21f3b948d653@I-love.SAKURA.ne.jp>
 <282345b9-9aff-43ed-b66d-76cf51cc0deb@I-love.SAKURA.ne.jp>
 <20250713081148.3880-1-hdanton@sina.com>
 <d6da6709-d799-4be3-a695-850bddd6eb24@rowland.harvard.edu>
 <aHa3xpKfGNqAocIO@gofer.mess.org>
 <c4e88c28-28ee-4e37-9822-8e2999d0f0ee@rowland.harvard.edu>
 <aHdzD7EowAKT4AhQ@gofer.mess.org>
 <a44d5568-48d6-44f7-af93-e1b966489a84@I-love.SAKURA.ne.jp>
 <aHefSptAPBoRG_20@gofer.mess.org>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <aHefSptAPBoRG_20@gofer.mess.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav405.rs.sakura.ne.jp

syzbot is reporting that imon has three problems which result in
hung tasks due to forever holding device lock [1].

First problem is that when usb_rx_callback_intf0() once got -EPROTO error
after ictx->dev_present_intf0 became true, usb_rx_callback_intf0()
resubmits urb after printk(), and resubmitted urb causes
usb_rx_callback_intf0() to again get -EPROTO error. This results in
printk() flooding (RCU stalls).

Alan Stern commented [2] that

  In theory it's okay to resubmit _if_ the driver has a robust
  error-recovery scheme (such as giving up after some fixed limit on the
  number of errors or after some fixed time has elapsed, perhaps with a
  time delay to prevent a flood of errors).  Most drivers don't bother to
  do this; they simply give up right away.  This makes them more
  vulnerable to short-term noise interference during USB transfers, but in
  reality such interference is quite rare.  There's nothing really wrong
  with giving up right away.

but imon has a poor error-recovery scheme which just retries forever;
this behavior should be fixed.

Since I'm not sure whether it is safe for imon users to give up upon any
error code, this patch takes care of only union of error codes chosen from
modules in drivers/media/rc/ directory which handle -EPROTO error (i.e.
ir_toy, mceusb and igorplugusb).

Second problem is that when usb_rx_callback_intf0() once got -EPROTO error
before ictx->dev_present_intf0 becomes true, usb_rx_callback_intf0() always
resubmits urb due to commit 8791d63af0cf ("[media] imon: don't wedge
hardware after early callbacks"). The ictx->dev_present_intf0 test was
introduced by commit 6f6b90c9231a ("[media] imon: don't parse scancodes
until intf configured"), but that commit did not call usb_unlink_urb()
when usb_rx_callback_intf0() got an error. Move the ictx->dev_present_intf0
test to immediately before imon_incoming_packet() so that we can call
usb_unlink_urb() as needed, or the first problem explained above happens
without printk() flooding (i.e. hung task).

Third problem is that when usb_rx_callback_intf0() is not called for some
reason (e.g. flaky hardware; the reproducer for this problem sometimes
prevents usb_rx_callback_intf0() from being called),
wait_for_completion_interruptible() in send_packet() never returns (i.e.
hung task). As a workaround for such situation, change send_packet() to
wait for completion with timeout of 10 seconds.

Also, move mutex_trylock() in imon_ir_change_protocol() to the beginning,
for memcpy() which modifies ictx->usb_tx_buf should be protected by
ictx->lock.

Also, verify at the beginning of send_packet() that ictx->lock is held
in case send_packet() is by error called from imon_ir_change_protocol()
when mutex_trylock() failed due to concurrent requests.

Link: https://syzkaller.appspot.com/bug?extid=592e2ab8775dbe0bf09a [1]
Link: https://lkml.kernel.org/r/d6da6709-d799-4be3-a695-850bddd6eb24@rowland.harvard.edu [2]
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Changes in v2:
  Updated patch description.

 drivers/media/rc/imon.c | 69 +++++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 27 deletions(-)

diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
index f5221b018808..3469a401a572 100644
--- a/drivers/media/rc/imon.c
+++ b/drivers/media/rc/imon.c
@@ -598,6 +598,8 @@ static int send_packet(struct imon_context *ictx)
 	int retval = 0;
 	struct usb_ctrlrequest *control_req = NULL;
 
+	lockdep_assert_held(&ictx->lock);
+
 	/* Check if we need to use control or interrupt urb */
 	if (!ictx->tx_control) {
 		pipe = usb_sndintpipe(ictx->usbdev_intf0,
@@ -645,12 +647,15 @@ static int send_packet(struct imon_context *ictx)
 		smp_rmb(); /* ensure later readers know we're not busy */
 		pr_err_ratelimited("error submitting urb(%d)\n", retval);
 	} else {
-		/* Wait for transmission to complete (or abort) */
-		retval = wait_for_completion_interruptible(
-				&ictx->tx.finished);
-		if (retval) {
+		/* Wait for transmission to complete (or abort or timeout) */
+		retval = wait_for_completion_interruptible_timeout(&ictx->tx.finished, 10 * HZ);
+		if (retval <= 0) {
 			usb_kill_urb(ictx->tx_urb);
 			pr_err_ratelimited("task interrupted\n");
+			if (retval < 0)
+				ictx->tx.status = retval;
+			else
+				ictx->tx.status = -ETIMEDOUT;
 		}
 
 		ictx->tx.busy = false;
@@ -1121,7 +1126,7 @@ static int imon_ir_change_protocol(struct rc_dev *rc, u64 *rc_proto)
 	int retval;
 	struct imon_context *ictx = rc->priv;
 	struct device *dev = ictx->dev;
-	bool unlock = false;
+	const bool unlock = mutex_trylock(&ictx->lock);
 	unsigned char ir_proto_packet[] = {
 		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x86 };
 
@@ -1148,8 +1153,6 @@ static int imon_ir_change_protocol(struct rc_dev *rc, u64 *rc_proto)
 
 	memcpy(ictx->usb_tx_buf, &ir_proto_packet, sizeof(ir_proto_packet));
 
-	unlock = mutex_trylock(&ictx->lock);
-
 	retval = send_packet(ictx);
 	if (retval)
 		goto out;
@@ -1745,14 +1748,6 @@ static void usb_rx_callback_intf0(struct urb *urb)
 	if (!ictx)
 		return;
 
-	/*
-	 * if we get a callback before we're done configuring the hardware, we
-	 * can't yet process the data, as there's nowhere to send it, but we
-	 * still need to submit a new rx URB to avoid wedging the hardware
-	 */
-	if (!ictx->dev_present_intf0)
-		goto out;
-
 	switch (urb->status) {
 	case -ENOENT:		/* usbcore unlink successful! */
 		return;
@@ -1761,16 +1756,30 @@ static void usb_rx_callback_intf0(struct urb *urb)
 		break;
 
 	case 0:
-		imon_incoming_packet(ictx, urb, intfnum);
+		/*
+		 * if we get a callback before we're done configuring the hardware, we
+		 * can't yet process the data, as there's nowhere to send it, but we
+		 * still need to submit a new rx URB to avoid wedging the hardware
+		 */
+		if (ictx->dev_present_intf0)
+			imon_incoming_packet(ictx, urb, intfnum);
 		break;
 
+	case -ECONNRESET:
+	case -EILSEQ:
+	case -EPROTO:
+	case -EPIPE:
+		dev_warn(ictx->dev, "imon %s: status(%d)\n",
+			 __func__, urb->status);
+		usb_unlink_urb(urb);
+		return;
+
 	default:
 		dev_warn(ictx->dev, "imon %s: status(%d): ignored\n",
 			 __func__, urb->status);
 		break;
 	}
 
-out:
 	usb_submit_urb(ictx->rx_urb_intf0, GFP_ATOMIC);
 }
 
@@ -1786,14 +1795,6 @@ static void usb_rx_callback_intf1(struct urb *urb)
 	if (!ictx)
 		return;
 
-	/*
-	 * if we get a callback before we're done configuring the hardware, we
-	 * can't yet process the data, as there's nowhere to send it, but we
-	 * still need to submit a new rx URB to avoid wedging the hardware
-	 */
-	if (!ictx->dev_present_intf1)
-		goto out;
-
 	switch (urb->status) {
 	case -ENOENT:		/* usbcore unlink successful! */
 		return;
@@ -1802,16 +1803,30 @@ static void usb_rx_callback_intf1(struct urb *urb)
 		break;
 
 	case 0:
-		imon_incoming_packet(ictx, urb, intfnum);
+		/*
+		 * if we get a callback before we're done configuring the hardware, we
+		 * can't yet process the data, as there's nowhere to send it, but we
+		 * still need to submit a new rx URB to avoid wedging the hardware
+		 */
+		if (ictx->dev_present_intf1)
+			imon_incoming_packet(ictx, urb, intfnum);
 		break;
 
+	case -ECONNRESET:
+	case -EILSEQ:
+	case -EPROTO:
+	case -EPIPE:
+		dev_warn(ictx->dev, "imon %s: status(%d)\n",
+			 __func__, urb->status);
+		usb_unlink_urb(urb);
+		return;
+
 	default:
 		dev_warn(ictx->dev, "imon %s: status(%d): ignored\n",
 			 __func__, urb->status);
 		break;
 	}
 
-out:
 	usb_submit_urb(ictx->rx_urb_intf1, GFP_ATOMIC);
 }
 
-- 
2.50.1



