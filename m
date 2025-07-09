Return-Path: <linux-kernel+bounces-722791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FE8AFDED4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 06:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39E254A629B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 04:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35B9267B15;
	Wed,  9 Jul 2025 04:39:39 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A76513A3F2
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 04:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752035979; cv=none; b=dqBbUiktvfl2OteM47hsprQgbA6LCaG0I2kEVE33J9udhb+ryrwDrPxz3qslRxYAQA/x2sK4NrhNqWe8NmtePZFpjIf2/Gin6IJ97Zy+PmOp553z+opqMRk3mxRrqKTZ81/w7ohPlaTCse3Zg2e0ObAMVjcO8or51JeiaHxf+s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752035979; c=relaxed/simple;
	bh=QyISevGJF7qL6bqExbIafOfOkR6VvDXNEtBZZ0bl7fA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QrfudUoT1z4vGXn60Y4P42fV0fJkNPK7DGtS7D9gycGDsdeqnsw3CtQL3BcEmsm16v8eVTyaX30s0sa9Yzko7k4cdw48PK9DaClxQNdwhGxDtWXNJ0VHEcWqCqB5wWgVpOgWW1vmDMcsPZcc/2PnWOSBskTAKmRQ/TDV7wFIdiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5694dP7x099619;
	Wed, 9 Jul 2025 13:39:25 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5694dKsb099581
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 9 Jul 2025 13:39:25 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c2b2b02d-2571-451c-bb1c-7dde18b45d4f@I-love.SAKURA.ne.jp>
Date: Wed, 9 Jul 2025 13:39:18 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [usb?] INFO: task hung in uevent_show (2)
To: syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com,
        LKML <linux-kernel@vger.kernel.org>
References: <672f73a6.050a0220.138bd5.0041.GAE@google.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <672f73a6.050a0220.138bd5.0041.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav102.rs.sakura.ne.jp
X-Virus-Status: clean

#syz test

diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
index f5221b018808..10124a26ffde 100644
--- a/drivers/media/rc/imon.c
+++ b/drivers/media/rc/imon.c
@@ -1765,7 +1765,7 @@ static void usb_rx_callback_intf0(struct urb *urb)
 		break;
 
 	default:
-		dev_warn(ictx->dev, "imon %s: status(%d): ignored\n",
+		dev_warn_ratelimited(ictx->dev, "imon %s: status(%d): ignored\n",
 			 __func__, urb->status);
 		break;
 	}
@@ -1806,7 +1806,7 @@ static void usb_rx_callback_intf1(struct urb *urb)
 		break;
 
 	default:
-		dev_warn(ictx->dev, "imon %s: status(%d): ignored\n",
+		dev_warn_ratelimited(ictx->dev, "imon %s: status(%d): ignored\n",
 			 __func__, urb->status);
 		break;
 	}
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 92c752f5446f..baf536c56c21 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1985,6 +1985,9 @@ void usb_sg_wait(struct usb_sg_request *io);
 static inline unsigned int __create_pipe(struct usb_device *dev,
 		unsigned int endpoint)
 {
+	BUG_ON(dev->devnum < 0);
+	BUG_ON(dev->devnum > 0x7F);
+	BUG_ON(endpoint > 0xF);
 	return (dev->devnum << 8) | (endpoint << 15);
 }
 


