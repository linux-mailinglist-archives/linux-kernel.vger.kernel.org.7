Return-Path: <linux-kernel+bounces-745593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8E4B11BFF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766233AA27B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78212E040C;
	Fri, 25 Jul 2025 10:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ErFCgoW+"
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDEE2D4B57;
	Fri, 25 Jul 2025 10:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438286; cv=none; b=N9F4Gkta7oAZ4/VTGMWTyjcA8JeaA1j4enbqDHn3o1hwroJeGt86zs3U4hTQxtTxn63X6YPiXqZI5sYqvPVd/m/4fWPnK5dzMbkMkYddxh7jxVS1R/EAkibJD86jid7dtThLc4xEXdXm7qC6f4P3rLC3kXLe6SbKOsGe0DyR9m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438286; c=relaxed/simple;
	bh=Y0NGzviS//zgPCetOZDyVSnAQYlAnfiWPQZqqEoQwaA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d49FtzWQ7NQTS9OUarued2ueDMAnc87+HO99PNNvnVqqaGd2RhdBW+Ef4F/nTmSePhUsglKCzxGgW4WcNrSILL74w1IqqUCQJhYYsqTY/TygmdMe+fSm5FSVzUunDcMM2pToHSij2XuYyvi8P2KmVsl8bfRw0GNz3UYrWPK/ksM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ErFCgoW+; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56PAB6MV02155828, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1753438266; bh=u32WEzkrMgsZujZ4agV5ma6Y2EJblAQoh+w0amwLue4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=ErFCgoW+UYR2GTlQSeBsi8PEW1XC7+Y2enAVtCEfqmtebakEI2K81gpCPlleF7yIJ
	 CQhDCtaOXDkFrzip21eaVcUJsuhGW45KjhqZGdIeBXiC2+W8t4z6QVKkuX/9Y9IuLB
	 uvpSwGJj2d5oBKYocw/vWvrgSzfJU6Uf4wgJEkozJtFe0SqX3xIbarF3mj4/8HyM9L
	 sxZ9kbYmvAm+khQJXLRebAHfB7kxIJPO6bglXaLEyD+nBBmM2vcrP0KDPrheBzGwBe
	 iWHIe3Sy8VApkhdCy+tl2xEwI5ypB8awKfi7MnF0lfe1lHQawawmZ1bid7N20Iiz+d
	 p1182CYAXXb6w==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56PAB6MV02155828
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 18:11:06 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 25 Jul 2025 18:11:07 +0800
Received: from sw-server.localdomain (172.22.102.1) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 25 Jul 2025 18:11:06 +0800
From: <shumingf@realtek.com>
To: <vkoul@kernel.org>, <vinod.koul@linaro.org>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <flove@realtek.com>, <oder_chiou@realtek.com>, <jack.yu@realtek.com>,
        <derek.fang@realtek.com>, Shuming Fan <shumingf@realtek.com>
Subject: [PATCH] soundwire: debugfs: add SCP_SDCA_IntStatX and SCP_SDCA_IntMaskX registers
Date: Fri, 25 Jul 2025 18:11:00 +0800
Message-ID: <20250725101100.1106673-1-shumingf@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS01.realtek.com.tw (172.21.6.94)
X-KSE-ServerInfo: RTEXMBS01.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Shuming Fan <shumingf@realtek.com>

This patch added SCP_SDCA_IntStatX and SCP_SDCA_IntMaskX registers.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
---
 drivers/soundwire/debugfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soundwire/debugfs.c b/drivers/soundwire/debugfs.c
index 3099ea074f10..b07f4127e464 100644
--- a/drivers/soundwire/debugfs.c
+++ b/drivers/soundwire/debugfs.c
@@ -91,6 +91,8 @@ static int sdw_slave_reg_show(struct seq_file *s_file, void *data)
 		ret += sdw_sprintf(slave, buf, ret, i);
 	for (i = SDW_SCP_DEVID_0; i <= SDW_SCP_DEVID_5; i++)
 		ret += sdw_sprintf(slave, buf, ret, i);
+	for (i = SDW_SCP_SDCA_INT1; i <= SDW_SCP_SDCA_INTMASK4; i++)
+		ret += sdw_sprintf(slave, buf, ret, i);
 	for (i = SDW_SCP_FRAMECTRL_B0; i <= SDW_SCP_BUSCLOCK_SCALE_B0; i++)
 		ret += sdw_sprintf(slave, buf, ret, i);
 	for (i = SDW_SCP_FRAMECTRL_B1; i <= SDW_SCP_BUSCLOCK_SCALE_B1; i++)
-- 
2.34.1


