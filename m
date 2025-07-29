Return-Path: <linux-kernel+bounces-749224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A2AB14BA3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 545BB1AA4319
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F832882DF;
	Tue, 29 Jul 2025 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gATBzKCw"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8942882D6
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 09:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753782676; cv=none; b=jNom55neLiZESKgAEOhx4vlLNkMrgMW2xX0Vx2deSH3umzWn/gwpX2cqYuv0EEnCoMD3UyT9BnsBH+CJ/Wk9jMAgCgbVAvK4IvGeBpAuSuYZhrMUkU3QKfWOIwDLQVFYqkWHPGQmFcWNQUqbmZBw/FrT4p6kqLBKtfGvTG0Vu5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753782676; c=relaxed/simple;
	bh=sdFdGbS5gLA+vMM1vrOjHwHosaU5xUtrqAL2i6Ske+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VIQIpInxSMokQsLSuG6nf0IyqZ9/aeSV3c4ajYAxIqd5I9XG0nMPnmZZOmmhzubyKKFYwnN6kgqvykkYRU/tr477aewaOMQnKIME7jWx26QbFE2PYHJ0gN1vfhw5hpSRjoTC91OMp7n9xveWp3eRZdZ3Tcqj3+7lEgub5EKf+Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gATBzKCw; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E6C7D1F68D;
	Tue, 29 Jul 2025 09:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753782666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OaebMuHGN4QNSGhtVE0q76FxHuoKKdH8nbCEv3uupBU=;
	b=gATBzKCwmByv0mtv8xVeC8kMF4zrbmEaZhEu3e3/zQWShck6DGLkzTrnfr188sIFGpr0QQ
	zYJYP7twJPBCzDCyGty+ECpqov8D6haYh9JIqJp31dKzFRO97ibLYluzArJ+buLT+BvqZy
	kioGdu3CEB4tEW9ES9pnqPwiQlkRX1N4aLiR0FMf6yMH86frc28MWMpCSL/h/EmKFtJleh
	ptThBDeVJ2Cej9bWh7kzBRhD5t64xav55aWrm/o9smvHGQ4C06OjdmvhYGIz5T5DYwkxmm
	zvTeQT78cX/S8WlN3+oVnYSAR1WEz6HHfcUAKzToS/7f2Jc7npJg7WnZ+EGodg==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Tue, 29 Jul 2025 11:50:57 +0200
Subject: [PATCH] regulator: core: correct convergence check in
 regulator_set_voltage()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-b4-regulator-stepping-fix-v1-1-3f7b8c55d7d7@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAICZiGgC/x2MSwqEMBAFryK9tiHGH3oVceGMz9ggMXRUBsS7T
 3BZBVU3RaggUp/dpLgkyu4TFHlG33XyDixzYrLG1qa1HX8qVrhzm45dOR4IQbzjRX7cwJYLTIm
 uqCj1QZH0+x7G5/kDc3V3WmsAAAA=
X-Change-ID: 20250729-b4-regulator-stepping-fix-6e23fe03e914
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>, 
 Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelgeejgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpeftohhmrghinhcuifgrnhhtohhishcuoehrohhmrghinhdrghgrnhhtohhishessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepfeekudeihffhfeeiffdvtdduhfegudehiedvgfeuveekgeekjeduvdeljeduteeinecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrudefngdpmhgrihhlfhhrohhmpehrohhmrghinhdrghgrnhhtohhishessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepiedprhgtphhtthhopehjohhnrghthhgrnhhhsehnvhhiughirgdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehrohhmrghinhdrghgrnhhtohhishessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlghhirhgufihoohgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnv
 ghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: romain.gantois@bootlin.com

The logic in regulator_set_voltage() which checks for a non-convergence
condition on a stepped regulator is flawed.

regulator_set_voltage() checks if the error in target voltage has increased
or decreased, and returns -EWOULDBLOCK if the error has not decreased
enough. The correct non-convergence condition is:

new_delta - delta > -rdev->constraints->max_uV_step

or equivalently:

delta - new_delta < rdev->constraints->max_uV_step

But the currently used condition is:

new_delta - delta > rdev->constraints->max_uV_step

Which may cause an infinite loop if the voltage error doesn't converge.

Fix this by correcting the convergence condition.

Suggested-by: Jon Hunter <jonathanh@nvidia.com>
Fixes: d511206dc7443 ("regulator: core: repeat voltage setting request for stepped regulators")
Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/regulator/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 8ed9b96518cf5186c0db147a6895a92bc59fae4e..554d83c4af0c1c98edb43b60dbfacb8844d5e1eb 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3884,7 +3884,7 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 			new_delta = ret;
 
 			/* check that voltage is converging quickly enough */
-			if (new_delta - delta > rdev->constraints->max_uV_step) {
+			if (delta - new_delta < rdev->constraints->max_uV_step) {
 				ret = -EWOULDBLOCK;
 				goto out;
 			}

---
base-commit: 0bd042ae771d61ef7ccd5882f7aeca59a25f71d9
change-id: 20250729-b4-regulator-stepping-fix-6e23fe03e914

Best regards,
-- 
Romain Gantois <romain.gantois@bootlin.com>


