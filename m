Return-Path: <linux-kernel+bounces-728940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B7AB02F42
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 09:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 894C6189D6F2
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 07:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46A61DE8A0;
	Sun, 13 Jul 2025 07:50:30 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C325E29CE1
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 07:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752393030; cv=none; b=ezRw+HwSarvAErvNBghHIzr0941fFo4gaX8Yyj4Nu+222Cr2qeyh+B8txy9nVWxd9ZGZmfshkpHyPxPOcAg9h43V6/t2nhidmgtms4CwBOK3dEc1rvTxsDfF1O8WFWwucc+ICXcjYdcjFVuMdusOXLheN5lDx9n07Z1442rjndU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752393030; c=relaxed/simple;
	bh=hjgncInhN3oYD2QVdlS8Q7p18T6sRNd13MLVrSI5n4Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=jQwCLbJwRFTD3DfPj7jpZF+PHdWsYSa/xDxW6STjzE49TTtakgPj0ui5Hj5CjENcNKLfyRWLMgTRFY7lN6X5ay6HXmBvxo1mH0hxDTwUwYMdOQC9igTAcH3EhHw1sSjdZyIpG5Ze0Xn9sDcWQChRhFa59Cz+VUvfyH2j29dLf4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 56D7oAex030884;
	Sun, 13 Jul 2025 16:50:10 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 56D7oAmR030881
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 13 Jul 2025 16:50:10 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e3dd81d7-16fe-4d04-99fa-ac81fb4b4289@I-love.SAKURA.ne.jp>
Date: Sun, 13 Jul 2025 16:50:08 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] media: imon: make send_packet() more robust
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com,
        LKML <linux-kernel@vger.kernel.org>, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <672f73a6.050a0220.138bd5.0041.GAE@google.com>
 <c2b2b02d-2571-451c-bb1c-7dde18b45d4f@I-love.SAKURA.ne.jp>
 <924bf5c7-9466-49dc-ad26-53939ca49825@I-love.SAKURA.ne.jp>
 <53c07aa0-9f83-4c83-8ab5-6d8663f51b91@I-love.SAKURA.ne.jp>
 <8be733a4-2232-4bb9-942d-f13f8766a6de@I-love.SAKURA.ne.jp>
 <40417f2a-e0d8-4f3c-9a37-a0068b6f268a@I-love.SAKURA.ne.jp>
 <0ad3effe-efed-4304-862f-4c8f901e79e9@I-love.SAKURA.ne.jp>
 <2ac5d313-c754-4fb9-acd3-21f3b948d653@I-love.SAKURA.ne.jp>
 <282345b9-9aff-43ed-b66d-76cf51cc0deb@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <282345b9-9aff-43ed-b66d-76cf51cc0deb@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav102.rs.sakura.ne.jp
X-Virus-Status: clean

syzbot is reporting that imon has three problems which result in hung tasks
due to forever holding device lock.

First problem is that when usb_rx_callback_intf0() once got -EPROTO error
after ictx->dev_present_intf0 became true, usb_rx_callback_intf0()
resubmits urb after printk(), and resubmitted urb causes
usb_rx_callback_intf0() to again get -EPROTO error. This results in
printk() flooding (RCU stalls).

Commit 92f461517d22 ("media: ir_toy: do not resubmit broken urb") changed
ir_toy module not to resubmit when irtoy_in_callback() got -EPROTO error.
We should do similar thing for imon.

Basically, I think that imon should refrain from resubmitting urb when
callback function got an error. But since I don't know which error codes
should retry resubmitting urb, this patch handles only union of error codes
chosen from modules in drivers/media/rc/ directory which handles -EPROTO
error (i.e. ir_toy, mceusb and igorplugusb).

We need to decide whether to call usb_unlink_urb() when we got -EPROTO
error. ir_toy and mceusb call usb_unlink_urb() but igorplugusb does not
due to commit 5e4029056263 ("media: igorplugusb: remove superfluous
usb_unlink_urb()"). This patch calls usb_unlink_urb() because description
of usb_unlink_urb() suggests that it is OK to call.

Second problem is that when usb_rx_callback_intf0() once got -EPROTO error
before ictx->dev_present_intf0 becomes true, usb_rx_callback_intf0() always
resubmits urb due to commit 8791d63af0cf ("[media] imon: don't wedge
hardware after early callbacks"). If some errors should stop resubmitting
urb regardless of whether configuring the hardware has completed or not,
what that commit is doing is wrong. The ictx->dev_present_intf0 test was
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
wait for completion with 10 seconds of timeout.

Also, move mutex_trylock() in imon_ir_change_protocol() to the beginning,
for memcpy() which modifies ictx->usb_tx_buf should be protected by
ictx->lock.

Also, verify at the beginning of send_packet() that ictx->lock is held
in case send_packet() is by error called from imon_ir_change_protocol()
when mutex_trylock() failed due to concurrent requests.

Link: https://syzkaller.appspot.com/bug?extid=592e2ab8775dbe0bf09a
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
#syz test

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



