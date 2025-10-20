Return-Path: <linux-kernel+bounces-861480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E2489BF2D5B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E20134E8894
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67118331A79;
	Mon, 20 Oct 2025 17:59:24 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C5F2638BF
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 17:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760983164; cv=none; b=azx7kVtbJ2i+0SHi+dNh8bvuvyz7mDTpOL0V6KX7hKi2eNBboEV+xuPyQmoubIPnKDK9HgtI2djccdkrcvaMUn7GpFb2cON23EwLz+ChhlQ7plmS3ewbKaAQGbfMXMDr3RsreQ8qzMEDOHdxQv0k7rs0GQF02qHfnVqZ1ZVqmkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760983164; c=relaxed/simple;
	bh=ZBCCiAL9e9Nv1qmCATVQwC8qU+K3qeCXY37oKHfjtlM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xe4krde7kLSo6nLs+YZ7Axq7SqabyaXtIBr3r8MPIHhq3R75JuovQhHpWXlm9u4TgkaeOH9w0WIkD54zsKjp44Gqgk8AZTzDAzrJSBABw4Q58hOjSMRtD27vSwa+8MTwYD8WCkvP1oaE8a4ibW3XmgzKbcDl4XP3mYAhRdK9ZiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 20 Oct
 2025 20:59:19 +0300
Received: from localhost (10.0.253.101) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 20 Oct
 2025 20:59:18 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: <syzbot+7811bb68a317954a0347@syzkaller.appspotmail.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	<syzkaller-bugs@googlegroups.com>, <linux-kernel@vger.kernel.org>
Subject: [syzbot] [comedi?] INFO: task hung in comedi_open
Date: Mon, 20 Oct 2025 20:59:10 +0300
Message-ID: <20251020175911.150815-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6890e4d5.050a0220.7f033.000d.GAE@google.com>
References:
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

#syz test

---
 drivers/comedi/drivers/multiq3.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/comedi/drivers/multiq3.c b/drivers/comedi/drivers/multiq3.c
index 467587b0b250..dc27651e0ace 100644
--- a/drivers/comedi/drivers/multiq3.c
+++ b/drivers/comedi/drivers/multiq3.c
@@ -67,6 +67,11 @@
 #define MULTIQ3_TRSFRCNTR_OL		0x10	/* xfer CNTR to OL (x and y) */
 #define MULTIQ3_EFLAG_RESET		0x06	/* reset E bit of flag reg */
 
+/*
+ * Semi-arbitrary limit on the number of optional encoder chips
+ */
+#define MULTIQ3_MAX_ENC_CHIPS		16
+
 static void multiq3_set_ctrl(struct comedi_device *dev, unsigned int bits)
 {
 	/*
@@ -314,6 +319,11 @@ static int multiq3_attach(struct comedi_device *dev,
 
 	/* Encoder (Counter) subdevice */
 	s = &dev->subdevices[4];
+
+	/* sanity check for number of optional encoders */
+	if (it->options[2] > MULTIQ3_MAX_ENC_CHIPS)
+		it->options[2] = MULTIQ3_MAX_ENC_CHIPS;
+
 	s->type		= COMEDI_SUBD_COUNTER;
 	s->subdev_flags	= SDF_READABLE | SDF_LSAMPL;
 	s->n_chan	= it->options[2] * 2;

