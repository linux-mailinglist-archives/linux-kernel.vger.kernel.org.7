Return-Path: <linux-kernel+bounces-862881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE91BF673C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C250425F6F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A5431A050;
	Tue, 21 Oct 2025 12:24:55 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A903732E74E
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049495; cv=none; b=F4TyI7hhF/eEbB+RQqHe8EwZjIyoaZTQkb+QlzGwEzJXmHSRxS3Tg+8QdCS3lB14at2cPFGIo/P2u3BHJaGPI3eoWoz4kJcB+wq9puFsbDKL+DF+fh2eqmPAwtDEUk2O93cB5UIbFFD+IGcv6K5A+JRTqDDZI/pXgkZU6bWjbq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049495; c=relaxed/simple;
	bh=GtLwWsXIQYNlQxQ9lw4arkeL0wHl6aJaY0GIJBVZ9Mw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GTeuN/2/1vlTOqirjKLWmWEmRH98ZXd3IVIRJKK6DoWgA1cREtr8QpYYqooV8+Eqlvf3ahKFRetKbmBjtpp2BMvSQ5aZTgv4erz5QNq4+lnh8kOvIJDyJsQ9zZ0VIEHorGN50YM2ExPPredrKzu27eLBBRt0WpVvCuViPDRx1bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 21 Oct
 2025 15:24:44 +0300
Received: from localhost (10.0.253.101) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 21 Oct
 2025 15:24:44 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: <syzbot+7811bb68a317954a0347@syzkaller.appspotmail.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	<syzkaller-bugs@googlegroups.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [syzbot] [comedi?] INFO: task hung in comedi_open
Date: Tue, 21 Oct 2025 15:24:34 +0300
Message-ID: <20251021122436.160398-1-n.zhandarovich@fintech.ru>
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
 drivers/comedi/drivers/multiq3.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/comedi/drivers/multiq3.c b/drivers/comedi/drivers/multiq3.c
index 07ff5383da99..0248321e3bfa 100644
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
@@ -312,6 +317,10 @@ static int multiq3_attach(struct comedi_device *dev,
 	s->insn_read	= multiq3_encoder_insn_read;
 	s->insn_config	= multiq3_encoder_insn_config;
 
+	/* sanity check for number of optional encoders */
+	if (s->n_chan > MULTIQ3_MAX_ENC_CHIPS)
+		s->n_chan = MULTIQ3_MAX_ENC_CHIPS;
+
 	for (i = 0; i < s->n_chan; i++)
 		multiq3_encoder_reset(dev, i);
 

