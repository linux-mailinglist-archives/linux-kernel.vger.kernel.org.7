Return-Path: <linux-kernel+bounces-893330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE61DC4716A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14B314E24FD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14A0311C21;
	Mon, 10 Nov 2025 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AkTPAeGa"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37B01F8908
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762783500; cv=none; b=TYXVgS3p2XmMSV1R+9+iFWK8msj6KQf5ZcRqEgIVwt+SDn4uEEeskl1loseQbYk5mWSF5WVkY9tXjEmxqxN1Cwsgd6HrNPRTpEmKzHViItS0FN/FhNbTOXTZk3WZ7bCGN4sPqoVcrfPQWQ3dp+Ln2itJKvzkufgW7uORI/F8eb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762783500; c=relaxed/simple;
	bh=u6e/nUpz6PfZOKB4Rg+Ouj31sMXyzm9REqLLda3bRWQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lEGyriK3bLseVNtK66dkDX3eGcIioqsCHzmEPoRYBryBMulSXO3adACYSoSlnL7f0uZxqNJ9hoU8oJei1aM9q4Lf5L/hJNTIDyhKLiZu6Z5IvzHg51YGrb4IE9Y299udT16rv/4z20IzER2c7xcFrtTdnYJzksW8hmBjVe+rd6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AkTPAeGa; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id CA32F1A19A7;
	Mon, 10 Nov 2025 14:04:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 96FCF606F5;
	Mon, 10 Nov 2025 14:04:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3C6771037190D;
	Mon, 10 Nov 2025 15:04:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762783493; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=aXdArrEv7P8qjQLi/yEInj1C2PVSeCo3HZ1LFRj2r+Y=;
	b=AkTPAeGard5vsWGDDnr8h8SIpX/bbi1oAVovVGIlOzoQvCvmiQUVITervwEk4d9849Siae
	t4g5gFgE8iDBu3mqOWJuUeA2BmU0Ek7u8ZWQHHEEa2BVXDU2z6ljqPECfvXRcIkliseea4
	O5O4Vxn10O/IH2WpeQIBqnF+7BqwW0gX9I5Z/T9sPB+k637GnNxqgBhjZMFgYDgUX6VWsp
	RVzVUlhUgx7aSISafiSrSzSumsNhcgnsZ2fldz6bTqHlnUYOvtrvnG6yH18blNW8NySVg5
	vPfSckxA17VbRXeXIjQ/Zx7J+HnM0IfPSAktSRsZEp2Rf2vLjrbrJfL62+HJlQ==
From: "Thomas Richard (TI.com)" <thomas.richard@bootlin.com>
Date: Mon, 10 Nov 2025 15:04:33 +0100
Subject: [PATCH] phy: ti: phy-j721e-wiz: restore mux selection during
 resume
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-phy-ti-phy-j721e-wiz-resume-restore-mux-sel-v1-1-b1cbde0b8367@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAPDwEWkC/x2NSw6CQBAFr0J6bSczA8TEqxgXfB7ShF+6QVHC3
 R1ZVWpTtZNBBUa3ZCfFS0ymMYq/JFS1xfgESx2dggu5997x3H54kRPdNXjwW76ssHXAH8uk4GH
 d2NBzlqeNS4uyQlZTLM6KRrbzdn8cxw8849iUfQAAAA==
X-Change-ID: 20251110-phy-ti-phy-j721e-wiz-resume-restore-mux-sel-453f03abce4d
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, Udit Kumar <u-kumar1@ti.com>, 
 Prasanth Mantena <p-mantena@ti.com>, Abhash Kumar <a-kumar2@ti.com>, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 "Thomas Richard (TI.com)" <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

While suspend and resume mux selection was getting lost. So save and
restore these values in suspend and resume operations.

Signed-off-by: Thomas Richard (TI.com) <thomas.richard@bootlin.com>
---
 drivers/phy/ti/phy-j721e-wiz.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index a8b440c6c46b..ba31b0a1f7f7 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -393,6 +393,7 @@ struct wiz {
 	struct clk		*output_clks[WIZ_MAX_OUTPUT_CLOCKS];
 	struct clk_onecell_data	clk_data;
 	const struct wiz_data	*data;
+	int			mux_sel_status[WIZ_MUX_NUM_CLOCKS];
 };
 
 static int wiz_reset(struct wiz *wiz)
@@ -1654,11 +1655,25 @@ static void wiz_remove(struct platform_device *pdev)
 	pm_runtime_disable(dev);
 }
 
+static int wiz_suspend_noirq(struct device *dev)
+{
+	struct wiz *wiz = dev_get_drvdata(dev);
+	int i;
+
+	for (i = 0; i < WIZ_MUX_NUM_CLOCKS; i++)
+		regmap_field_read(wiz->mux_sel_field[i], &wiz->mux_sel_status[i]);
+
+	return 0;
+}
+
 static int wiz_resume_noirq(struct device *dev)
 {
 	struct device_node *node = dev->of_node;
 	struct wiz *wiz = dev_get_drvdata(dev);
-	int ret;
+	int ret, i;
+
+	for (i = 0; i < WIZ_MUX_NUM_CLOCKS; i++)
+		regmap_field_write(wiz->mux_sel_field[i], wiz->mux_sel_status[i]);
 
 	/* Enable supplemental Control override if available */
 	if (wiz->sup_legacy_clk_override)
@@ -1680,7 +1695,7 @@ static int wiz_resume_noirq(struct device *dev)
 	return ret;
 }
 
-static DEFINE_NOIRQ_DEV_PM_OPS(wiz_pm_ops, NULL, wiz_resume_noirq);
+static DEFINE_NOIRQ_DEV_PM_OPS(wiz_pm_ops, wiz_suspend_noirq, wiz_resume_noirq);
 
 static struct platform_driver wiz_driver = {
 	.probe		= wiz_probe,

---
base-commit: a22c168bc6e1295fd878c87684a84db9e79c574f
change-id: 20251110-phy-ti-phy-j721e-wiz-resume-restore-mux-sel-453f03abce4d

Best regards,
-- 
Thomas Richard (TI.com) <thomas.richard@bootlin.com>


