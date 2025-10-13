Return-Path: <linux-kernel+bounces-850539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D29FBD321E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E5B0234BEEF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AECD2E6CA5;
	Mon, 13 Oct 2025 13:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JzZ12+v7"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E455270ED7
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760360716; cv=none; b=XMFdaSF/wkYUBcrhtaPqcV5B9ERnKqVnZ13fXszAIxNrsnNMRCiMhOK84umvOjsgo8K9/hoV580XnGM8fJjyjxtZq4qylyYFPAL+JdqFyInnPujByH582SGeZDE8+o6lPVTFjBKG3hYNL1653oeCE/occaPiqm6eOSVb7SDTSF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760360716; c=relaxed/simple;
	bh=OfBZdKCXLdXnDq8fdQ6ytW1UWFw/HC1A/Mu91/7QWi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Y+5vyf97fP8KrTa99Sa1PotDoGOfZccdE1yOxLgEa9qvGp2FN5ENc57Z84LNK2mPLNtL3aTkQo1UaV4wGHFZ4vcaKkIqkIND5omspDxiqP3+K33TC8izwc0LfonNUnanQh6XeQ+M0DD7x5kk3ryPCbglqb3IdNSwZpmakQwF6pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JzZ12+v7; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B0F081A132F;
	Mon, 13 Oct 2025 13:05:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 79D57606C6;
	Mon, 13 Oct 2025 13:05:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DA468102F224D;
	Mon, 13 Oct 2025 15:04:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760360707; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=qxp3SOl/8cQ2/Ve+mDrdRsUEubzjiO7EQKOltPp8XlU=;
	b=JzZ12+v7YOgnrn50SuxLuwOqkPODiUsStbxKYfCO95ARPi/hikoWycKWNFk4FqCtK+w/wS
	dTxdxT5iqiGEmELiQJtPWAmXj9utndOVshnWHtJG7ybaVSsgqxBIhiahSELWrbjqPOO1F8
	1hJnRdGVthjB/FEXBUfQJUIo1S51zeJOtm0xSfBHaM6Xrk4vP6yaz0PE+p+Hx3kEYhbOSY
	AYnWWUt4Hy9mKmESSktAtOblcBdm4DPEkRCsxw68G1UzAw/PHT4/XHLrbZsXe+7OVcqL5O
	YznbQCvKoHRMJKd5nTYQK+8g1pJI/881OZbjHxzX1SdXV1JAzBhObPZoJH1GnQ==
From: "Thomas Richard (TI.com)" <thomas.richard@bootlin.com>
Date: Mon, 13 Oct 2025 15:04:44 +0200
Subject: [PATCH v5] mux: mmio: Add suspend and resume support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-mux-mmio-resume-support-v5-1-de9467ceb2b2@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAOv47GgC/43OQW7DIBAF0KtErDsVhgHbWfUeVRZAxjVSMRbYV
 qLIdy9EqqoqitrlH2be58YyJU+ZHQ83lmjz2cepBPVyYG400weBP5fMBBfIdSMhrBcIwUdIlNd
 AkNd5jmkBHKQVRqKRwrBybU0msMlMbqz3WSSoo/o0Jxr85V76fip59HmJ6Xr/w9bU6d91WwMcU
 AllB6XLsnmzMS6ffnp1MbCqbuKfkoAGqMNe8763XOKjJL8lxZG3zyVZJGe7zljH8WzbRwl/pFL
 3XMIilQUt2nbQmtNvad/3LydlRJW5AQAA
X-Change-ID: 20240613-mux-mmio-resume-support-4f3b2a34a32a
To: gregkh@linuxfoundation.org
Cc: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org, 
 gregory.clement@bootlin.com, richard.genoud@bootlin.com, u-kumar1@ti.com, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Andrew Davis <afd@ti.com>, 
 "Thomas Richard (TI.com)" <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

The status of each mux is read during suspend and stored in the private
memory of the mux_chip.
Then the state is restored during the resume.

Reviewed-by: Andrew Davis <afd@ti.com>
Signed-off-by: Thomas Richard (TI.com) <thomas.richard@bootlin.com>
---
A fifth version of the series. Nothing fancy, I just rebased the series on
v6.18-rc1 and updated my identity.
---
Changes in v5:
- updated my identity to credit TI
- rebased on v6.18-rc1
- Link to v4: https://lore.kernel.org/r/20250609-mux-mmio-resume-support-v4-1-6096277f660e@bootlin.com

Changes in v4:
- rebased on v6.16-rc1
- Link to v3: https://lore.kernel.org/r/20250407-mux-mmio-resume-support-v3-1-cb88abc04db7@bootlin.com

Changes in v3:
- rebased on v6.14-rc1.
- Take Reviewed-by: Andrew Davis.
- Link to v2: https://lore.kernel.org/r/20240613-mux-mmio-resume-support-v2-1-e8496099b034@bootlin.com

Changes in v2:
- Remove all modifications done in the mux subsystem
- Add a mux_mmio_set()
- Read the status of muxes during suspend and store in the private memory
  of the mux_chip.
- Use this status to restore muxes during resume.
- Link to v1: https://lore.kernel.org/r/20240613-mux-mmio-resume-support-v1-0-4525bf56024a@bootlin.com
---
 drivers/mux/mmio.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 73 insertions(+), 9 deletions(-)

diff --git a/drivers/mux/mmio.c b/drivers/mux/mmio.c
index 9993ce38a818de12237cd700e4c19359ea7f4c29..e4ddb1e619237dbb307677a20564eb08f62d11ab 100644
--- a/drivers/mux/mmio.c
+++ b/drivers/mux/mmio.c
@@ -15,11 +15,25 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
 
+struct mux_mmio {
+	struct regmap_field **fields;
+	unsigned int *hardware_states;
+};
+
+static int mux_mmio_get(struct mux_control *mux, int *state)
+{
+	struct mux_mmio *mux_mmio = mux_chip_priv(mux->chip);
+	unsigned int index = mux_control_get_index(mux);
+
+	return regmap_field_read(mux_mmio->fields[index], state);
+}
+
 static int mux_mmio_set(struct mux_control *mux, int state)
 {
-	struct regmap_field **fields = mux_chip_priv(mux->chip);
+	struct mux_mmio *mux_mmio = mux_chip_priv(mux->chip);
+	unsigned int index = mux_control_get_index(mux);
 
-	return regmap_field_write(fields[mux_control_get_index(mux)], state);
+	return regmap_field_write(mux_mmio->fields[index], state);
 }
 
 static const struct mux_control_ops mux_mmio_ops = {
@@ -43,8 +57,8 @@ static int mux_mmio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	struct regmap_field **fields;
 	struct mux_chip *mux_chip;
+	struct mux_mmio *mux_mmio;
 	struct regmap *regmap;
 	void __iomem *base;
 	int num_fields;
@@ -80,12 +94,20 @@ static int mux_mmio_probe(struct platform_device *pdev)
 	}
 	num_fields = ret / 2;
 
-	mux_chip = devm_mux_chip_alloc(dev, num_fields, num_fields *
-				       sizeof(*fields));
+	mux_chip = devm_mux_chip_alloc(dev, num_fields, sizeof(struct mux_mmio));
 	if (IS_ERR(mux_chip))
 		return PTR_ERR(mux_chip);
 
-	fields = mux_chip_priv(mux_chip);
+	mux_mmio = mux_chip_priv(mux_chip);
+
+	mux_mmio->fields = devm_kmalloc(dev, num_fields * sizeof(*mux_mmio->fields), GFP_KERNEL);
+	if (IS_ERR(mux_mmio->fields))
+		return PTR_ERR(mux_mmio->fields);
+
+	mux_mmio->hardware_states = devm_kmalloc(dev, num_fields *
+						 sizeof(*mux_mmio->hardware_states), GFP_KERNEL);
+	if (IS_ERR(mux_mmio->hardware_states))
+		return PTR_ERR(mux_mmio->hardware_states);
 
 	for (i = 0; i < num_fields; i++) {
 		struct mux_control *mux = &mux_chip->mux[i];
@@ -115,9 +137,9 @@ static int mux_mmio_probe(struct platform_device *pdev)
 			return -EINVAL;
 		}
 
-		fields[i] = devm_regmap_field_alloc(dev, regmap, field);
-		if (IS_ERR(fields[i])) {
-			ret = PTR_ERR(fields[i]);
+		mux_mmio->fields[i] = devm_regmap_field_alloc(dev, regmap, field);
+		if (IS_ERR(mux_mmio->fields[i])) {
+			ret = PTR_ERR(mux_mmio->fields[i]);
 			dev_err(dev, "bitfield %d: failed to allocate: %d\n",
 				i, ret);
 			return ret;
@@ -141,13 +163,55 @@ static int mux_mmio_probe(struct platform_device *pdev)
 
 	mux_chip->ops = &mux_mmio_ops;
 
+	dev_set_drvdata(dev, mux_chip);
+
 	return devm_mux_chip_register(dev, mux_chip);
 }
 
+static int mux_mmio_suspend_noirq(struct device *dev)
+{
+	struct mux_chip *mux_chip = dev_get_drvdata(dev);
+	struct mux_mmio *mux_mmio = mux_chip_priv(mux_chip);
+	unsigned int state;
+	int ret, i;
+
+	for (i = 0; i < mux_chip->controllers; i++) {
+		ret = mux_mmio_get(&mux_chip->mux[i], &state);
+		if (ret) {
+			dev_err(dev, "control %u: error saving mux: %d\n", i, ret);
+			return ret;
+		}
+
+		mux_mmio->hardware_states[i] = state;
+	}
+
+	return 0;
+}
+
+static int mux_mmio_resume_noirq(struct device *dev)
+{
+	struct mux_chip *mux_chip = dev_get_drvdata(dev);
+	struct mux_mmio *mux_mmio = mux_chip_priv(mux_chip);
+	int ret, i;
+
+	for (i = 0; i < mux_chip->controllers; i++) {
+		ret = mux_mmio_set(&mux_chip->mux[i], mux_mmio->hardware_states[i]);
+		if (ret) {
+			dev_err(dev, "control %u: error restoring mux: %d\n", i, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static DEFINE_NOIRQ_DEV_PM_OPS(mux_mmio_pm_ops, mux_mmio_suspend_noirq, mux_mmio_resume_noirq);
+
 static struct platform_driver mux_mmio_driver = {
 	.driver = {
 		.name = "mmio-mux",
 		.of_match_table	= mux_mmio_dt_ids,
+		.pm = pm_sleep_ptr(&mux_mmio_pm_ops),
 	},
 	.probe = mux_mmio_probe,
 };

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20240613-mux-mmio-resume-support-4f3b2a34a32a

Best regards,
-- 
Thomas Richard (TI.com) <thomas.richard@bootlin.com>


