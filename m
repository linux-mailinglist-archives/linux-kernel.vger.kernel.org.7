Return-Path: <linux-kernel+bounces-867015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40067C01570
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E20133AE155
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE67E314B82;
	Thu, 23 Oct 2025 13:22:17 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E4E2C11FD
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225737; cv=none; b=Ri/zSd+6QM32qc5E34k89lQZq+BfWJ/pl5JCeNBV0eK5KCo/e9DbTXRwrVrgji+1er0F1cvNjMxeVYXdqgr608eCXKoT4halPdx+C3e3H9+/KLfonsd3VoI+4O9lkd7HO9dxXpgxGxjJ1xV8PiFRx8LGbHFWbr3D1dHK25GGj40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225737; c=relaxed/simple;
	bh=VJXaDrjkMGh/dMVSj2sAOJD102QFtYZDfKflSFQy6tU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bIb5QMlUBM2LwnEOF8J1sohO61J8bmxfRX7lUGkKWNC41uV9abyvJr+U8+y/NFGkvqpl+UVulMjvyNxEHkXe19s/VTyvHOMF2Kj7mfPjUu36g+PCvvtNcnuxDM+m7kjyTVEf/SwveTZK/MK2H8uJhdHwHS+J4pMRaO/JZD2cqKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 23 Oct
 2025 16:22:10 +0300
Received: from localhost (10.0.253.101) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 23 Oct
 2025 16:22:10 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Ian Abbott <abbotti@mev.co.uk>, H Hartley Sweeten
	<hsweeten@visionengravers.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>,
	<syzbot+7811bb68a317954a0347@syzkaller.appspotmail.com>
Subject: [PATCH v3] comedi: multiq3: sanitize config options in multiq3_attach()
Date: Thu, 23 Oct 2025 16:22:04 +0300
Message-ID: <20251023132205.395753-1-n.zhandarovich@fintech.ru>
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

Syzbot identified an issue [1] in multiq3_attach() that induces a
task timeout due to open() or COMEDI_DEVCONFIG ioctl operations,
specifically, in the case of multiq3 driver.

This problem arose when syzkaller managed to craft weird configuration
options used to specify the number of channels in encoder subdevice.
If a particularly great number is passed to s->n_chan in
multiq3_attach() via it->options[2], then multiple calls to
multiq3_encoder_reset() at the end of driver-specific attach() method
will be running for minutes, thus blocking tasks and affected devices
as well.

While this issue is most likely not too dangerous for real-life
devices, it still makes sense to sanitize configuration inputs. Enable
a sensible limit on the number of encoder chips (4 chips max, each
with 2 channels) to stop this behaviour from manifesting.

[1] Syzbot crash:
INFO: task syz.2.19:6067 blocked for more than 143 seconds.
...
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5254 [inline]
 __schedule+0x17c4/0x4d60 kernel/sched/core.c:6862
 __schedule_loop kernel/sched/core.c:6944 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6959
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7016
 __mutex_lock_common kernel/locking/mutex.c:676 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:760
 comedi_open+0xc0/0x590 drivers/comedi/comedi_fops.c:2868
 chrdev_open+0x4cc/0x5e0 fs/char_dev.c:414
 do_dentry_open+0x953/0x13f0 fs/open.c:965
 vfs_open+0x3b/0x340 fs/open.c:1097
...

Reported-by: syzbot+7811bb68a317954a0347@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7811bb68a317954a0347
Fixes: 77e01cdbad51 ("Staging: comedi: add multiq3 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
v1 -> v2: Lower limit to 8 channels instead of 16 per Ian Abbott's
<abbotti@mev.co.uk> suggestion.

v2 -> v3: Switch to less confusing macro name MULTIQ3_MAX_ENC_CHANS,
adjust comments accordingly, as well as commit description itself.

 drivers/comedi/drivers/multiq3.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/comedi/drivers/multiq3.c b/drivers/comedi/drivers/multiq3.c
index 07ff5383da99..ac369e9a262d 100644
--- a/drivers/comedi/drivers/multiq3.c
+++ b/drivers/comedi/drivers/multiq3.c
@@ -67,6 +67,11 @@
 #define MULTIQ3_TRSFRCNTR_OL		0x10	/* xfer CNTR to OL (x and y) */
 #define MULTIQ3_EFLAG_RESET		0x06	/* reset E bit of flag reg */
 
+/*
+ * Limit on the number of optional encoder channels
+ */
+#define MULTIQ3_MAX_ENC_CHANS		8
+
 static void multiq3_set_ctrl(struct comedi_device *dev, unsigned int bits)
 {
 	/*
@@ -312,6 +317,10 @@ static int multiq3_attach(struct comedi_device *dev,
 	s->insn_read	= multiq3_encoder_insn_read;
 	s->insn_config	= multiq3_encoder_insn_config;
 
+	/* sanity check for number of encoder channels */
+	if (s->n_chan > MULTIQ3_MAX_ENC_CHANS)
+		s->n_chan = MULTIQ3_MAX_ENC_CHANS;
+
 	for (i = 0; i < s->n_chan; i++)
 		multiq3_encoder_reset(dev, i);
 

