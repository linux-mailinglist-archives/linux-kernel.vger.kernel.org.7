Return-Path: <linux-kernel+bounces-736966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9FDB0A5E4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D9D7189E860
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FF12248A5;
	Fri, 18 Jul 2025 14:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ggcELmm4"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A045414F9D6
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752847908; cv=none; b=fH5NWCYNcd8HppaJ/YFYYpmNiok3ZJq01PrC/KSi/PBerXYsxDxkZXdPNEVbGXzKp1iwRKM4kCN4Hpj51+sKQQEa76hrzqws7mboybGf8++DZNqGwdbCj0Mi/cLuHYEJ2wO4ufnJcRol4/Ow3gYcR+vGwIyTPWgPCqxG64jDRks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752847908; c=relaxed/simple;
	bh=zZ9mXmVdECw64awav1nucDoLXi3Yps28PrrgGWyJoAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=W78mHfyhcql/EO8qXcmwpFgHpzVP6BnmC90Wl4VA3t9Sf93TlB2Ajb2S0sVzLngrX5mWWC6rXtvtYmWMG3W5VR/ETC5J9dvgfdR0OYhNAiRJx7Hv5I4HV1SRZxQber26+OnxOCvMim61Rl1zMLAOTvqN2kw6ESemZY+wIZPAymc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ggcELmm4; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 918D341C7C;
	Fri, 18 Jul 2025 14:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752847904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zn2pQNPeeXR6OUDPtKeWRnpx4O5RYxIkZexIwUhRIPI=;
	b=ggcELmm4vMPb6OdHDgfQx3Tc6mVX5cK/NNKO8Fdt1ER+veEoe5SAWulz5Jpo0gZWZsqDEg
	9g+1RveUspAfHVDPk2GiuhMh12VR1hXsBlnw7wwaB58PDuv04hxshsQMNzTEZkkq3Hjx8b
	CKY1fm1mSy96iTaTK5ojJ/9Tkzr3f4Db7WFyE55XPI7tq8AzJjNXYvb462uwBBa7VgzpW1
	dPB3TWVIX5b68S6tl/ZtsYXhTi+IUmxe9E0BbvNZSPijuipJcg9l68zCX4Dov2Gjc/XSkP
	V5wkxyg05GGYiGH+Hxy9mjk0zhugOe3BaAz1R9oDj7dnrWyad/GZR2woOPKbgQ==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Fri, 18 Jul 2025 16:11:36 +0200
Subject: [PATCH v2] regulator: core: repeat voltage setting request for
 stepped regulators
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-regulator-stepping-v2-1-e28c9ac5d54a@bootlin.com>
X-B4-Tracking: v=1; b=H4sIABhWemgC/23MsQ7CIBCA4VdpbhYDxFLr5HsYB0qP9pIWyIGNS
 dN3l7i4OH7D/++QkQkz3JodGDfKFEOFPjXgZhsmFDRWg5a6lZ26CsbptdgSWeSCKVGYhJPKmt6
 Mg/UOapgYPb2/08ez2nNcRZkZ7W/VavNvtSmhBA5td5GmHzvp70OMZaFwdnGF4/gAO+sjULAAA
 AA=
X-Change-ID: 20250718-regulator-stepping-c01a696dbafc
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeifeeiiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpeftohhmrghinhcuifgrnhhtohhishcuoehrohhmrghinhdrghgrnhhtohhishessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepfeekudeihffhfeeiffdvtdduhfegudehiedvgfeuveekgeekjeduvdeljeduteeinecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrudefngdpmhgrihhlfhhrohhmpehrohhmrghinhdrghgrnhhtohhishessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohephedprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohhmrghinhdrghgrnhhtohhishessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlghhirhguf
 ihoohgusehgmhgrihhlrdgtohhm
X-GND-Sasl: romain.gantois@bootlin.com

The regulator_set_voltage() function may exhibit unexpected behavior if the
target regulator has a maximum voltage step constraint. With such a
constraint, the regulator core may clamp the requested voltage to a lesser
value, to ensure that the voltage delta stays under the specified limit.

This means that the resulting regulator voltage depends on the current
voltage, as well as the requested range, which invalidates the assumption
that a repeated request for a specific voltage range will amount to a noop.

Considering the case of a regulator with a maximum voltage step constraint
of 1V:

initial voltage: 2.5V

consumer requests 4V
expected result: 3.5V
resulting voltage: 3.5V

consumer requests 4V again
expected result: 4V
actual result: 3.5V

Correct this by repeating attempts to balance the regulator voltage until
the result converges.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/regulator/core.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index cbd6d53ebfb5ef21b5dfc8b0f1f1f033772a886c..8ed9b96518cf5186c0db147a6895a92bc59fae4e 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3797,6 +3797,16 @@ static int _regulator_do_set_suspend_voltage(struct regulator_dev *rdev,
 	return 0;
 }
 
+static int regulator_get_voltage_delta(struct regulator_dev *rdev, int uV)
+{
+	int current_uV = regulator_get_voltage_rdev(rdev);
+
+	if (current_uV < 0)
+		return current_uV;
+
+	return abs(current_uV - uV);
+}
+
 static int regulator_set_voltage_unlocked(struct regulator *regulator,
 					  int min_uV, int max_uV,
 					  suspend_state_t state)
@@ -3804,8 +3814,8 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 	struct regulator_dev *rdev = regulator->rdev;
 	struct regulator_voltage *voltage = &regulator->voltage[state];
 	int ret = 0;
+	int current_uV, delta, new_delta;
 	int old_min_uV, old_max_uV;
-	int current_uV;
 
 	/* If we're setting the same range as last time the change
 	 * should be a noop (some cpufreq implementations use the same
@@ -3852,6 +3862,37 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 		voltage->max_uV = old_max_uV;
 	}
 
+	if (rdev->constraints->max_uV_step > 0) {
+		/* For regulators with a maximum voltage step, reaching the desired
+		 * voltage might take a few retries.
+		 */
+		ret = regulator_get_voltage_delta(rdev, min_uV);
+		if (ret < 0)
+			goto out;
+
+		delta = ret;
+
+		while (delta > 0) {
+			ret = regulator_balance_voltage(rdev, state);
+			if (ret < 0)
+				goto out;
+
+			ret = regulator_get_voltage_delta(rdev, min_uV);
+			if (ret < 0)
+				goto out;
+
+			new_delta = ret;
+
+			/* check that voltage is converging quickly enough */
+			if (new_delta - delta > rdev->constraints->max_uV_step) {
+				ret = -EWOULDBLOCK;
+				goto out;
+			}
+
+			delta = new_delta;
+		}
+	}
+
 out:
 	return ret;
 }

---
base-commit: ef616b9763e374454957a8785a068479fa5665a6
change-id: 20250718-regulator-stepping-c01a696dbafc

Best regards,
-- 
Romain Gantois <romain.gantois@bootlin.com>


