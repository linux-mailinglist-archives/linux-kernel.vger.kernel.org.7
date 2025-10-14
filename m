Return-Path: <linux-kernel+bounces-852114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F65CBD833B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A393619204E7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BF630F922;
	Tue, 14 Oct 2025 08:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zIBBSoBj"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E4629ACD1
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760430939; cv=none; b=a7qG9h69zT1qoM/cQxX6deKg/2YSEP62AbBu3aeQGyxs7IvmZXrwzgzPWMrPzbFaA/yKalUwFLWFl+U04xEk9M+Lwhqtdwr4o02NDwHGhBKOgxfxM7nWG9wQYlDOl13nRs0gVtmQ68IkuondLfqrlWynNYlEIR/hIpV+Hqvpt0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760430939; c=relaxed/simple;
	bh=iw1p+SqR6z5jGWmeQEKMSq89hjZJ38vNsMWIPYEonh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tp/cCqWqFuhkwsqAHLupW5ZENhuOw1Iykl55gP+n/9tt11sAjNh5f9BuR5ghqWu/2vlYWXHiLhth4r9YPxDoo7GOIgTmXO3TfTMubZyi8Ii21pakTV5ZZ7Vg4LDGMXXMQ9U7ZA/2kN3aGsCy/GqLgbcNIn7yaJSXw6+EIF+/Uqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zIBBSoBj; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id ACA07C09F84;
	Tue, 14 Oct 2025 08:35:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AC137606EC;
	Tue, 14 Oct 2025 08:35:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D15DB102F224B;
	Tue, 14 Oct 2025 10:35:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760430931; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=yJRi0HibOeKtbgfq4iDcVBuMVTWuMio4cjtfayeTuVk=;
	b=zIBBSoBj/QJlk2scYqbB71RnzLWlY5113OOtGVaFYxyk4bdGnYR1o668Xdlf3xvEx9gQyF
	bNGmo82EZuCtSHe5PYbvTX9GiQvU/bgoOgrn+DeciQq7AthyT9XDl4F8SaWUHBUXX6z5E9
	P79Q0oai2nwpPvtI4nRQIvaI/f55wy/OF2Gr4EcfE1y4KmxBTi5CLKZK0HfNHMUiHjYLIz
	mbxyPiNDJmlcocGXIjVrlaS/XC6RaDO1n13oj6lQVIQ2nu72++EBXvNrEYU+jgAki57v5C
	z6BEUDpXkHYTMiWnQ+zeypTatRqw060jLixGeJoHQ3wHyjflGuXL0E5z4mRurQ==
From: "Thomas Richard (TI.com)" <thomas.richard@bootlin.com>
Date: Tue, 14 Oct 2025 10:35:23 +0200
Subject: [PATCH] firmware: ti_sci: replace ifdeffery by pm_sleep_ptr()
 macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-ti-sci-pm-ops-cleanup-v1-1-70b50b73ac85@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAEoL7mgC/x3MSwqAMAwA0atI1gasHwSvIi5sTDWgtTQqgnh3i
 8u3mHlAOQordNkDkS9R2X2CyTOgZfQzo0zJUBZlYwpT4yGoJBg23IMirTz6M6CxLbvK1RVZgtS
 GyE7u/9sP7/sB4QCI1mcAAAA=
X-Change-ID: 20251014-ti-sci-pm-ops-cleanup-1b7ef3f43cbc
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, Udit Kumar <u-kumar1@ti.com>, 
 Prasanth Mantena <p-mantena@ti.com>, Abhash Kumar <a-kumar2@ti.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 "Thomas Richard (TI.com)" <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Using pm_sleep_ptr() macro allows to remove ifdeffery and '__maybe_unused'
annotations.

Signed-off-by: Thomas Richard (TI.com) <thomas.richard@bootlin.com>
---
 drivers/firmware/ti_sci.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 49fd2ae01055d0f425062147422471f0fd49e4bd..99a2e0e2960f463918950fef8829409ec365ce70 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -3706,7 +3706,7 @@ static int ti_sci_prepare_system_suspend(struct ti_sci_info *info)
 	}
 }
 
-static int __maybe_unused ti_sci_suspend(struct device *dev)
+static int ti_sci_suspend(struct device *dev)
 {
 	struct ti_sci_info *info = dev_get_drvdata(dev);
 	struct device *cpu_dev, *cpu_dev_max = NULL;
@@ -3746,7 +3746,7 @@ static int __maybe_unused ti_sci_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused ti_sci_suspend_noirq(struct device *dev)
+static int ti_sci_suspend_noirq(struct device *dev)
 {
 	struct ti_sci_info *info = dev_get_drvdata(dev);
 	int ret = 0;
@@ -3758,7 +3758,7 @@ static int __maybe_unused ti_sci_suspend_noirq(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused ti_sci_resume_noirq(struct device *dev)
+static int ti_sci_resume_noirq(struct device *dev)
 {
 	struct ti_sci_info *info = dev_get_drvdata(dev);
 	int ret = 0;
@@ -3780,7 +3780,7 @@ static int __maybe_unused ti_sci_resume_noirq(struct device *dev)
 	return 0;
 }
 
-static void __maybe_unused ti_sci_pm_complete(struct device *dev)
+static void ti_sci_pm_complete(struct device *dev)
 {
 	struct ti_sci_info *info = dev_get_drvdata(dev);
 
@@ -3791,12 +3791,10 @@ static void __maybe_unused ti_sci_pm_complete(struct device *dev)
 }
 
 static const struct dev_pm_ops ti_sci_pm_ops = {
-#ifdef CONFIG_PM_SLEEP
-	.suspend = ti_sci_suspend,
-	.suspend_noirq = ti_sci_suspend_noirq,
-	.resume_noirq = ti_sci_resume_noirq,
-	.complete = ti_sci_pm_complete,
-#endif
+	.suspend = pm_sleep_ptr(ti_sci_suspend),
+	.suspend_noirq = pm_sleep_ptr(ti_sci_suspend_noirq),
+	.resume_noirq = pm_sleep_ptr(ti_sci_resume_noirq),
+	.complete = pm_sleep_ptr(ti_sci_pm_complete),
 };
 
 /* Description for K2G */

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251014-ti-sci-pm-ops-cleanup-1b7ef3f43cbc

Best regards,
-- 
Thomas Richard (TI.com) <thomas.richard@bootlin.com>


