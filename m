Return-Path: <linux-kernel+bounces-727808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2E2B02005
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F7BA188FAFC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B8F2EA157;
	Fri, 11 Jul 2025 15:01:54 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDBB2D3A68
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 15:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752246114; cv=none; b=pJlXFXVgOGeskkd6X1oIYzRu7VVeqR3KoMf0q6eWkuP5Ee2UxmTVjVATnBPXjN2xXCOndq+sCGUkvTFldwQ2gBbI8P0Tnz9XZMDrqw+lQWu4wcsw6osxeuQzCN1wTYnCCOutC7PxtARPo9cI7UPdClZgOYThBloHzm1lWtafbpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752246114; c=relaxed/simple;
	bh=n81+f2NEJ+XZZIqM7gKg0slOEFsoHuKrqfdMcrK+vTA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=opjC33foUFP1BScGAHzPNU7zP8AoW53zE4+9wjNt2dFWKKRB0834gcPwCWWjZXg2GrnLEhkAY7EgHXEbDMLasw2V3hwg7hLxOoCqBMA4YtMdnCehOUXCTaxTjtOUENg/efqaa/DrUDxYpdYDuADJDBkrRYkJwInCjMLxdKrC8Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 56BF1lAO010642;
	Sat, 12 Jul 2025 00:01:47 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 56BF1kXV010639
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 12 Jul 2025 00:01:47 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <0ad3effe-efed-4304-862f-4c8f901e79e9@I-love.SAKURA.ne.jp>
Date: Sat, 12 Jul 2025 00:01:42 +0900
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
 <40417f2a-e0d8-4f3c-9a37-a0068b6f268a@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <40417f2a-e0d8-4f3c-9a37-a0068b6f268a@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav103.rs.sakura.ne.jp

#syz test

diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
index f5221b018808..ea702e3a83dc 100644
--- a/drivers/media/rc/imon.c
+++ b/drivers/media/rc/imon.c
@@ -645,12 +645,16 @@ static int send_packet(struct imon_context *ictx)
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
+			dump_stack();
+			if (retval < 0)
+				ictx->tx.status = retval;
+			else
+				ictx->tx.status = -ETIMEDOUT;
 		}
 
 		ictx->tx.busy = false;
@@ -1125,6 +1129,11 @@ static int imon_ir_change_protocol(struct rc_dev *rc, u64 *rc_proto)
 	unsigned char ir_proto_packet[] = {
 		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x86 };
 
+	if (mutex_get_owner(&ictx->lock) != (unsigned long) current) {
+		unlock = true;
+		mutex_lock(&ictx->lock);
+	}
+
 	if (*rc_proto && !(*rc_proto & rc->allowed_protocols))
 		dev_warn(dev, "Looks like you're trying to use an IR protocol this device does not support\n");
 
@@ -1148,8 +1157,6 @@ static int imon_ir_change_protocol(struct rc_dev *rc, u64 *rc_proto)
 
 	memcpy(ictx->usb_tx_buf, &ir_proto_packet, sizeof(ir_proto_packet));
 
-	unlock = mutex_trylock(&ictx->lock);
-
 	retval = send_packet(ictx);
 	if (retval)
 		goto out;
@@ -1764,6 +1771,15 @@ static void usb_rx_callback_intf0(struct urb *urb)
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
@@ -1805,6 +1821,15 @@ static void usb_rx_callback_intf1(struct urb *urb)
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


