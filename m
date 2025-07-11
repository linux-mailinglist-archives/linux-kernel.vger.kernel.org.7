Return-Path: <linux-kernel+bounces-727670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EDEB01DC4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31A421CC0816
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993C22E7639;
	Fri, 11 Jul 2025 13:34:33 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD4E2E613A
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752240873; cv=none; b=aSOp3w4tpjav4w8zMv1QPQiax8dxqwXZw9FKYKJdNNynvA9O706qKqt6El2PxqxmWrLhsBwtp1XAWdjeKJHyYdqRT0iLNNCPV3xzVmPquolrlXnkfzqxU9skpN7O4pPG4gG4HX9CfiCAEzZJzK8YFz3iYQfujj4QJU7WIoDE+rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752240873; c=relaxed/simple;
	bh=OrcwzAjGfuJMSyyQYKyZBzoGr54arbQwXt/m3TK9DRY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=H0gSt5vROM0mGR6YckO00xwU/z2Qlq9C/RwLwptuuIEFWxsvOUQbUtnlPc2x21rJTHR5HqzCWvT/4/12C9hcFxdiCJbcb/JTwVsTTw3DMFycspzLpcesXmC8+Ui/JQIK5KPtTLRAUUJMJIeExwKr3t57wrSoAICnkWW4YFMY7UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 56BDYPmr091488;
	Fri, 11 Jul 2025 22:34:25 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 56BDYP1J091483
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 11 Jul 2025 22:34:25 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <40417f2a-e0d8-4f3c-9a37-a0068b6f268a@I-love.SAKURA.ne.jp>
Date: Fri, 11 Jul 2025 22:34:21 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [usb?] INFO: task hung in uevent_show (2)
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com,
        LKML <linux-kernel@vger.kernel.org>
References: <672f73a6.050a0220.138bd5.0041.GAE@google.com>
 <c2b2b02d-2571-451c-bb1c-7dde18b45d4f@I-love.SAKURA.ne.jp>
 <924bf5c7-9466-49dc-ad26-53939ca49825@I-love.SAKURA.ne.jp>
 <53c07aa0-9f83-4c83-8ab5-6d8663f51b91@I-love.SAKURA.ne.jp>
 <8be733a4-2232-4bb9-942d-f13f8766a6de@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <8be733a4-2232-4bb9-942d-f13f8766a6de@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav201.rs.sakura.ne.jp

#syz test

diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
index f5221b018808..e130dc9db1b4 100644
--- a/drivers/media/rc/imon.c
+++ b/drivers/media/rc/imon.c
@@ -645,16 +645,16 @@ static int send_packet(struct imon_context *ictx)
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
 		}
 
 		ictx->tx.busy = false;
-		retval = ictx->tx.status;
+		if (retval > 0)
+			retval = ictx->tx.status;
 		if (retval)
 			pr_err_ratelimited("packet tx failed (%d)\n", retval);
 	}
@@ -1764,6 +1764,15 @@ static void usb_rx_callback_intf0(struct urb *urb)
 		imon_incoming_packet(ictx, urb, intfnum);
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
@@ -1805,6 +1814,15 @@ static void usb_rx_callback_intf1(struct urb *urb)
 		imon_incoming_packet(ictx, urb, intfnum);
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


