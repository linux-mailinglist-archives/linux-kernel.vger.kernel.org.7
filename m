Return-Path: <linux-kernel+bounces-727447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAD7B01A56
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E02005431D3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 11:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A74288C89;
	Fri, 11 Jul 2025 11:10:16 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9185A920
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 11:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752232215; cv=none; b=WwA0Jpd1K1ol0+bHBVlmKqTqtFMFVnmqthKugiVJovkmkoOMbezJzWPynDOS2Fp9CfZMkX6IdzMVzcG0um42epTQu3zDodC9Hg9rGCH2Ky1/f9GvAfSgn9bADC1+QPdzUwRLfj2AyC4NemCXSUdPuA7mBSx7umXxlQ/ruWCRGJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752232215; c=relaxed/simple;
	bh=PXBx0zcXAPKqcvWWV+yceIkGUP+KL0smdVFc0VFLUjI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=I9RbXxpqSVhB7PB25IRIum2UcKtTPx5g5cNoqkLM/yqYWwG1JpPJEwCKSTLzZsKydOphE37OqSt43CCXJ0t8K0CB8Z2A42fJOY8X+AEdHIgBmhqfqA/hLwH09SJe3+ZkwpTMVWLYMncypT17e7+wfLyJG44fw9AYfTo5arSIIXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 56BBA1j8050339;
	Fri, 11 Jul 2025 20:10:01 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 56BBA1ua050330
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 11 Jul 2025 20:10:01 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <53c07aa0-9f83-4c83-8ab5-6d8663f51b91@I-love.SAKURA.ne.jp>
Date: Fri, 11 Jul 2025 20:09:59 +0900
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
Content-Language: en-US
In-Reply-To: <924bf5c7-9466-49dc-ad26-53939ca49825@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav304.rs.sakura.ne.jp

#syz test

diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
index f5221b018808..423e04328b86 100644
--- a/drivers/media/rc/imon.c
+++ b/drivers/media/rc/imon.c
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


