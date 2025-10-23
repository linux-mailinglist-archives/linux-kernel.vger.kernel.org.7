Return-Path: <linux-kernel+bounces-867074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A29F1C01852
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2023AA0A1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAD31C6FE5;
	Thu, 23 Oct 2025 13:46:27 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFD01D2F42
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227186; cv=none; b=B+IrzxEOf7esf6bNlakh3ihAi6DquL+Qohspl0gKznjqoRkyxKo1lQK64OEf2y/g5BOYURCqrJG9oigK+zOUPCUXuU6hIB4tCfVrYH/vnVUyPD0xM4w/Y1Tn+vp0b3IUvP8k6OK8PAtPJOkYMbcsBIJJzSGnNuiHc1tiw42KWME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227186; c=relaxed/simple;
	bh=3n1MCb1jHEe0UbHSzU6tyatyvvYLechbwovqMV7IPtc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sYft6TJ8Mg4Kbn+c7vPVag0VrWji2Tf80sDrerWS0SaRYH8gKeJkORm/GveR3AYSd2dJvBpMcE1FKq9x2gTDsJ2iBXLZh7ePrzdw/geFYC/sNH2WvHZaHls5CkXAd8149m8X+jukguVa5lsYecn1iblca58wtlO+H57HR1RS19w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 23 Oct
 2025 16:46:20 +0300
Received: from localhost (10.0.253.101) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 23 Oct
 2025 16:46:20 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: <syzbot+fce5d9d5bd067d6fbe9b@syzkaller.appspotmail.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	<syzkaller-bugs@googlegroups.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [syzbot] [kernel?] general protection fault in pcl818_ai_cancel
Date: Thu, 23 Oct 2025 16:46:11 +0300
Message-ID: <20251023134612.396121-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <68690156.a00a0220.c7b3.0036.GAE@google.com>
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
 drivers/comedi/drivers/pcl818.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/comedi/drivers/pcl818.c b/drivers/comedi/drivers/pcl818.c
index 4127adcfb229..06fe06396f23 100644
--- a/drivers/comedi/drivers/pcl818.c
+++ b/drivers/comedi/drivers/pcl818.c
@@ -1111,10 +1111,9 @@ static void pcl818_detach(struct comedi_device *dev)
 {
 	struct pcl818_private *devpriv = dev->private;
 
-	if (devpriv) {
-		pcl818_ai_cancel(dev, dev->read_subdev);
+	if (devpriv)
 		pcl818_reset(dev);
-	}
+
 	pcl818_free_dma(dev);
 	comedi_legacy_detach(dev);
 }

