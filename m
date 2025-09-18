Return-Path: <linux-kernel+bounces-823084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C7AB857C7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7431891FA3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DB2224B09;
	Thu, 18 Sep 2025 15:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="VuKWD2f6"
Received: from ksmg01.maxima.ru (ksmg01.mt-integration.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F6E145B16
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208093; cv=none; b=poccwwBeMdqdpLPZuXDdyYPbRCiL3/HZ/sriv7DwhjsEq2DXM2ssW7tE7LvhJTmP3wtL+AK4hKYgg5d6PZEWgQKLQM7lN+YxFQWn4DC4Kbbgp2ta0md6KK3fLIcPHXe1Xufh3GUVh8V+4f9TXYLjvp58cUEJqE6momIyyyF7G0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208093; c=relaxed/simple;
	bh=aY6zIkcSoLUNMyWW0Tq5V/QQB++7y3QpnAamZq2yOis=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wd17Lf0l/zjAGzdpA0s7elBI/ZiPAQEdJ955VTeRs43MEYK8DTAFv/Kw7dGnTf3wVuNWiaDQkuqaJ4ewmdt6GHOkAkgBCoNF8ImArFJfEG1sgkYhRN3ZU86FehuCDBDyQa3kfhNBLBRlymCXNLf/domkU52pZzaXMcaXtOZ/OPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=VuKWD2f6; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id 566C4C004B;
	Thu, 18 Sep 2025 18:07:58 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru 566C4C004B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1758208078; bh=zkYI2j6MoOOBH+AZctoahOHwRP79UMOw4c4nlVg8TN0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=VuKWD2f6L0IriUGD+DWuNLrQ6bnCUGoRcZ+CzY6Z5Fw99vX1D+hdgnT8RsU03nlba
	 Iza9QMvTEiiAdV2W6w2DEmvKqPQ6fRzYcbmiwiKg2LFc6itfPHNy743JZKRetbV56Z
	 UAkSkCIGvhdiy1CzNUEuJUxDFzMbWGleOeAVYITqKXoAS9i2K97Nhia22TVUVrnaN3
	 IngIJptYjfU7qPwPjLdnCJL5MLf4f+0x8lMOxzfrVOwr/+Pvkm1xvoLCzPxlQJdicE
	 pZehFfXOmK6Y/Fc/W/FrVNnQJ6euAg73hl9ZqvyIZx8vnHoEHo1Ojtqb8oKFS4j/Vw
	 H912SM64GhmOQ==
Received: from ksmg01.maxima.ru (mail.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Thu, 18 Sep 2025 18:07:58 +0300 (MSK)
Received: from ub24-1-zabelin-t-22-tests.mti-lab.com (172.25.20.198) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 18 Sep 2025 18:07:56 +0300
From: Zabelin Nikita <n.zabelin@mt-integration.ru>
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
CC: Zabelin Nikita <n.zabelin@mt-integration.ru>, David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Dave Airlie
	<airlied@redhat.com>, Alan Cox <alan@linux.intel.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] drm/gma500: Fix null dereference in hdmi teardown
Date: Thu, 18 Sep 2025 18:06:59 +0300
Message-ID: <20250918150703.2562604-1-n.zabelin@mt-integration.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mmail-p-exch02.mt.ru (81.200.124.62) To
 mmail-p-exch01.mt.ru (81.200.124.61)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: n.zabelin@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 67 0.3.67 f6b3a124585516de4e61e2bf9df040d8947a2fd5, {rep_avail}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;ksmg01.maxima.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;mt-integration.ru:7.1.1;81.200.124.61:7.1.2, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 196408 [Sep 18 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/09/18 13:01:00 #27830703
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

pci_set_drvdata sets the value of pdev->driver_data to NULL,
after which the driver_data obtained from the same dev is 
dereferenced in oaktrail_hdmi_i2c_exit, and the i2c_dev is 
extracted from it. To prevent this, swap these calls.

Fixes: 1b082cc ("gma500: Add Oaktrail support")

Found by Linux Verification Center (linuxtesting.org) with Svacer.

Signed-off-by: Zabelin Nikita <n.zabelin@mt-integration.ru>
---
 drivers/gpu/drm/gma500/oaktrail_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gma500/oaktrail_hdmi.c b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
index 95b7cb099e63..9c7d9584aac7 100644
--- a/drivers/gpu/drm/gma500/oaktrail_hdmi.c
+++ b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
@@ -724,8 +724,8 @@ void oaktrail_hdmi_teardown(struct drm_device *dev)
 
 	if (hdmi_dev) {
 		pdev = hdmi_dev->dev;
-		pci_set_drvdata(pdev, NULL);
 		oaktrail_hdmi_i2c_exit(pdev);
+		pci_set_drvdata(pdev, NULL);
 		iounmap(hdmi_dev->regs);
 		kfree(hdmi_dev);
 		pci_dev_put(pdev);
-- 
2.43.0


