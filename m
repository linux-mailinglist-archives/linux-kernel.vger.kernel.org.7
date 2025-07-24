Return-Path: <linux-kernel+bounces-744086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2437B107D9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53C5D3BEE3D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8022B266F05;
	Thu, 24 Jul 2025 10:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="dQ2YJQUl"
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459E0218E91
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753353336; cv=none; b=EVM1ZZQ7t+B9Mb+NDGBsPy0oLw3iZcsFqv4vMMb/pRx6hvN8vKKjFq49XBv/r4Zsii7pDUjpFzxV3jyVsdInfrHsPvQWVtGup03KfKWIUZsU2U10ak9LwLJK3GD21zdxbEfVje4QHcm3Pk82cV9El5IWoEZWJib/xlJz/yqDJ2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753353336; c=relaxed/simple;
	bh=Q40UlhZPTMwNmL/dzpuVETQdSPe/FoRe8QSVbbzoph8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Nm+EYKJ7OHRaVpUy1lqSB00fJtJ8Qtcj6cG6rVShb0TWMqS4BWWBAUkJOZ2EDDbnYY0edzgPn3OR7Ijn+wQtVJ+H3VEQ/14hTmOvAkOhdetHHdCkbIIPZo1xS32RzMa33FPiZVSabOCtobWNQZpJcdML0SOlcseEhUyh3vaKM70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=dQ2YJQUl; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns2.iitb.ac.in (ldns2.iitb.ac.in [10.200.12.2])
	by smtp1.iitb.ac.in (Postfix) with SMTP id CB8B9104C1D9
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:05:18 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in CB8B9104C1D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1753353318; bh=Q40UlhZPTMwNmL/dzpuVETQdSPe/FoRe8QSVbbzoph8=;
	h=Date:From:To:Cc:Subject:From;
	b=dQ2YJQUlAcKlJGvCQ3Q9rAdISwymoTbO9oqqltsUM/PEBo7nkSimTgwdSjo1cppd/
	 IhMdc9U1kzhfy64tgZtgppe23T1lN2r0Rlr8AyzhNmQma+bqwvntdvAhfpLm8Ieqje
	 ivX8LWUoGLgNuEu0lQZXvl9TUOPTMutEKtN0cSDs=
Received: (qmail 20549 invoked by uid 510); 24 Jul 2025 16:05:18 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns2 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.100.0/26337} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 3.945138 secs; 24 Jul 2025 16:05:18 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns2.iitb.ac.in) (10.200.1.25)
  by ldns2.iitb.ac.in with SMTP; 24 Jul 2025 16:05:14 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns2.iitb.ac.in (Postfix) with ESMTP id 64B5C3414EF;
	Thu, 24 Jul 2025 16:05:14 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id 3D18D1E813C3;
	Thu, 24 Jul 2025 16:05:14 +0530 (IST)
Date: Thu, 24 Jul 2025 16:05:07 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: vkoul@kernel.org, kishon@kernel.org, akhilesh@ee.iitb.ac.in,
	a.hajda@samsung.com, aric.pzqi@ingenic.com
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	akhileshpatilvnit@gmail.com, skhan@linuxfoundation.org
Subject: [PATCH] phy: ingenic: use core driver model helper to handle probe
 errors
Message-ID: <aIIMW971BYsIk4As@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use core driver model helper dev_err_probe() defined at
drivers/base/core.c in driver probe path to propagate errors.
standardize and improve the code of deferred probe error handling
using this helper for ingenic usb phy driver.
Inspired by,
commit a787e5400a1ce ("driver core: add device probe log helper")

Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/phy/ingenic/phy-ingenic-usb.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/ingenic/phy-ingenic-usb.c b/drivers/phy/ingenic/phy-ingenic-usb.c
index eb2721f72a4c..7e62d46850fd 100644
--- a/drivers/phy/ingenic/phy-ingenic-usb.c
+++ b/drivers/phy/ingenic/phy-ingenic-usb.c
@@ -339,17 +339,13 @@ static int ingenic_usb_phy_probe(struct platform_device *pdev)
 	priv->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(priv->clk)) {
 		err = PTR_ERR(priv->clk);
-		if (err != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get clock\n");
-		return err;
+		return dev_err_probe(dev, err, "Failed to get clock\n");
 	}
 
 	priv->vcc_supply = devm_regulator_get(dev, "vcc");
 	if (IS_ERR(priv->vcc_supply)) {
 		err = PTR_ERR(priv->vcc_supply);
-		if (err != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get regulator\n");
-		return err;
+		return dev_err_probe(dev, err, "Failed to get regulator\n");
 	}
 
 	priv->phy = devm_phy_create(dev, NULL, &ingenic_usb_phy_ops);
-- 
2.34.1


