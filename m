Return-Path: <linux-kernel+bounces-861305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE96BF253B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D03984F3A99
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6518E283682;
	Mon, 20 Oct 2025 16:12:25 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AF52750FA
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976745; cv=none; b=RjJiWsNa3msJGVeoml40JKjfjUPjslrNMIypvI+KLs5BJ3g/Eh7xXrX8/QJU2hLGO9PaWTgogxff3R4Q/zNDcCKbzvcABrZO02q8EE3CTpi0U6t1fPaZ/5O7n5YXxWcokYVnLQOAonCeo624ZTBWJ+UhaKwMwm70rm2AnTER5tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976745; c=relaxed/simple;
	bh=YL6pWMTxuOhL0Za25boMmN/MGmjceImVuHHWTXZT8eI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nS2V8jbrVR4bAnkAaZd56i7ce+eIWCdC5ZkS9wXW4ihjbPKiQSzD35BW7OZ/AFpleJIASNGCPrtIGwXogWEXiQ4jvbwZjE52yZlL45LHuAcGlaIQJPRVoC/Nk9LFd8hZ9vyAOi2dDOlonvvuB5/Cdib4wQy96rNWKFt4lDf0sOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 20 Oct
 2025 19:12:17 +0300
Received: from localhost (10.0.253.101) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 20 Oct
 2025 19:12:17 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Ian Abbott <abbotti@mev.co.uk>, H Hartley Sweeten
	<hsweeten@visionengravers.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>, Hillf Danton
	<hdanton@sina.com>, <lvc-project@linuxtesting.org>
Subject: [PATCH] comedi: pcl818: fix null-ptr-deref in pcl818_ai_cancel()
Date: Mon, 20 Oct 2025 19:12:06 +0300
Message-ID: <20251020161208.4151618-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

Syzbot identified an issue [1] in pcl818_ai_cancel(), which stems from
the fact that in case of early device detach via pcl818_detach(),
subdevice dev->read_subdev may not have initialized its pointer to
&struct comedi_async as intended. Thus, any such dereferencing of
&s->async->cmd will lead to general protection fault and kernel crash.

Mitigate this problem by checking in advance whether async struct is
properly present.

Original idea for this patch belongs to Hillf Danton
<hdanton@sina.com>.

Note: as suggested by Ian in [2], there may be a different solution to
improving the way ISRs are set up (and possibly, this flaw as well).
However, until that idea (based on reference counters and completion
structs) comes to fruition, it makes sense to fix this now, if only
to stop kernel crashing so often during syzkaller runs.

[1] Syzbot crash:
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
CPU: 1 UID: 0 PID: 6050 Comm: syz.0.18 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:pcl818_ai_cancel+0x69/0x3f0 drivers/comedi/drivers/pcl818.c:762
...
Call Trace:
 <TASK>
 pcl818_detach+0x66/0xd0 drivers/comedi/drivers/pcl818.c:1115
 comedi_device_detach_locked+0x178/0x750 drivers/comedi/drivers.c:207
 do_devconfig_ioctl drivers/comedi/comedi_fops.c:848 [inline]
 comedi_unlocked_ioctl+0xcde/0x1020 drivers/comedi/comedi_fops.c:2178
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
...

[2] Ian's suggestion on how to fix interrupt handlers in comedi drivers:
Link: https://lore.kernel.org/all/9c92913c-c04b-4784-9cdc-5d75b10d2ed9@mev.co.uk/

Reported-by: syzbot+fce5d9d5bd067d6fbe9b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fce5d9d5bd067d6fbe9b
Suggested-by: Hillf Danton <hdanton@sina.com>
Fixes: 00aba6e7b565 ("staging: comedi: pcl818: remove 'neverending_ai' from private data")
Cc: stable@vger.kernel.org
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
P.S. Tested with syzkaller reproducers as well as by doing a trial
syzkaller run w/wo the patch.

 drivers/comedi/drivers/pcl818.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/comedi/drivers/pcl818.c b/drivers/comedi/drivers/pcl818.c
index 4127adcfb229..3c6cfb212492 100644
--- a/drivers/comedi/drivers/pcl818.c
+++ b/drivers/comedi/drivers/pcl818.c
@@ -759,12 +759,15 @@ static int pcl818_ai_cancel(struct comedi_device *dev,
 {
 	struct pcl818_private *devpriv = dev->private;
 	struct comedi_isadma *dma = devpriv->dma;
-	struct comedi_cmd *cmd = &s->async->cmd;
+	struct comedi_cmd *cmd;
 
 	if (!devpriv->ai_cmd_running)
 		return 0;
 
 	if (dma) {
+		if (!s || !s->async)
+			return 0;
+		cmd = &s->async->cmd;
 		if (cmd->stop_src == TRIG_NONE ||
 		    (cmd->stop_src == TRIG_COUNT &&
 		     s->async->scans_done < cmd->stop_arg)) {

