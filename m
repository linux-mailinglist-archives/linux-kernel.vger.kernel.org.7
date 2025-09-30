Return-Path: <linux-kernel+bounces-837621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D9CBACC6F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 597DF1927611
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6546A2F9DAF;
	Tue, 30 Sep 2025 12:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="A1hBI1x8"
Received: from mx12.kaspersky-labs.com (mx12.kaspersky-labs.com [91.103.66.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B88257849
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.103.66.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759234151; cv=none; b=dp/RW+ZkG/ipCti2TGtdDDGj7/cEMDDrrllgnmaW+bMbzOY7co25tBeC0u1H5bdAZMukCv5s0Yp1jjoQWMQXmgact5+E2F3nFqtU7aF2MwZOiK+B3VT5Yb33MtKVtkuE1wQhmp+pc0KHNWoRHk3b4YB2JS7RT49WRXCfu3GzEU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759234151; c=relaxed/simple;
	bh=/ZCPtrxpHwurwKrKTcXULQymMpkDsQzM+hB11gAT9Kw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TByaxX19okY4GXaWLaVMbxqCxz2WIPY5H/+vbk9y3n36ZSPU7DTbdZT54F7gSt5zBQIlDlm3P+ok+aaIf0rUViYPxI2tBxoQyiICv/wxTmXdskjR+8Qb3lh63lREFkOCjRjTQ7mrAorLrtOGkmuvf4nUxEaXmURa9h98FZC8boY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com; spf=pass smtp.mailfrom=kaspersky.com; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=A1hBI1x8; arc=none smtp.client-ip=91.103.66.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaspersky.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1759234141;
	bh=E/ymyFAhoXDT38ivAgqCCbFrpdwUReIE/Raa9MY4iHQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=A1hBI1x8eETbEXWIQMn4khJnGdlcR8D5GGLT6bfxXGif+WGiWjssrRUFIeOutw6Lg
	 ajH/RRoiDOp5Ld9VZX6Of0kaMA+A9/gx11ux5T78sbbGdYA+Jn18FWuFsqNlthqhP8
	 UIMf2yyF7M1egCHS1VVQKvghqYlKwvovSSpcPLylnTyDxNyad+Pk8C11XSSt971VX6
	 cTxI4r3nv8P7Qa9oAi4Ggy64cOhMot8cIpwc6XFy/uwZ1spi2zoqDAPvs9U0t5kSJF
	 J8i741MiVG5ANIC+izf18kIcBiBgRgbTRwR795BTh0JUcFfQrqCgdJzRSCs4bowqyR
	 8Z7U6P+9J96cg==
Received: from relay12.kaspersky-labs.com (localhost [127.0.0.1])
	by relay12.kaspersky-labs.com (Postfix) with ESMTP id 666465A18CB;
	Tue, 30 Sep 2025 15:09:01 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail-hq2.kaspersky.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub12.kaspersky-labs.com (Postfix) with ESMTPS id C37665A1A50;
	Tue, 30 Sep 2025 15:08:59 +0300 (MSK)
Received: from zhigulin-p.avp.ru (10.16.104.190) by HQMAILSRV2.avp.ru
 (10.64.57.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Tue, 30 Sep
 2025 15:08:59 +0300
From: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
To: Xinliang Liu <xinliang.liu@linaro.org>
CC: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>, Tian Tao
	<tiantao6@hisilicon.com>, Xinwei Kong <kong.kongxinwei@hisilicon.com>, Sumit
 Semwal <sumit.semwal@linaro.org>, Yongqin Liu <yongqin.liu@linaro.org>, John
 Stultz <jstultz@google.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Anusha Srivatsa <asrivats@redhat.com>, Andy
 Green <andy.green@linaro.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] gpu: fix potential division by zero in DesignWare controller driver
Date: Tue, 30 Sep 2025 15:08:55 +0300
Message-ID: <20250930120858.251255-1-Pavel.Zhigulin@kaspersky.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HQMAILSRV5.avp.ru (10.64.57.55) To HQMAILSRV2.avp.ru
 (10.64.57.52)
X-KSE-ServerInfo: HQMAILSRV2.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 09/30/2025 11:56:43
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 196699 [Sep 30 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: Pavel.Zhigulin@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 67 0.3.67
 f6b3a124585516de4e61e2bf9df040d8947a2fd5
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: kaspersky.com:5.0.1,7.1.1;zhigulin-p.avp.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/30/2025 11:58:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 9/30/2025 10:40:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/09/30 11:37:00 #27867828
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52

A division by zero may occur in the dsi_get_phy_params function if
phy_req_kHz is in the range [1000000, 1500000]. In this case,
dsi_calc_phy_rate can return a value greater than 1000000, which sets
the 'ui' variable to zero. The variable is then used as the denominator
in the ROUND macro.

This patch adds an additional check of phy_rate_kHz to prevent 'ui'
from being zero.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: f819b0d4a913 ("drm/hisilicon: Add designware dsi encoder driver")
Signed-off-by: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
---
 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
index e80debdc4176..7502a9ddbbf5 100644
--- a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
+++ b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
@@ -251,7 +251,7 @@ static void dsi_get_phy_params(u32 phy_req_kHz,
 	memset(phy, 0, sizeof(*phy));

 	phy_rate_kHz = dsi_calc_phy_rate(phy_req_kHz, phy);
-	if (!phy_rate_kHz)
+	if (!phy_rate_kHz || phy_rate_kHz > 1000000)
 		return;

 	ui = 1000000 / phy_rate_kHz;
--
2.43.0


