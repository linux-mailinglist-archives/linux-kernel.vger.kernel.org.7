Return-Path: <linux-kernel+bounces-821098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 053F7B8060A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFA341C20E5B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2C4330D4E;
	Wed, 17 Sep 2025 14:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="tpVPymNk"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AB932E73E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121124; cv=none; b=UgBRu+XavM+LrayKNEVUB+FV42ff0+R5uaDTSd1rVRHx7CJVz5lKGhfJixpjgp1aTH/TsO7znHWFOyKXgI1kZtvKzoLAgb4PPc3pAMS4SLdSTKWluROYLYRmK77WllXCMX0htg3HE/JHEpOsIMqGUXf9xW5j2nWwRCsw+hQRjLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121124; c=relaxed/simple;
	bh=FglG9D0JTchfrqAucV53w19QJIXah4mHaUUvI4VYhxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oYVWf1083IHDHKgP6aVfPo0g0PoOB7wWMRjUVG3F0aNgaKuCY8Pm+6+9pCTXb+dOZAfd6X5f/Ca0k+WzI4yrbF6usnOYKwmtU8PdMXm/T9rLF98cEL+W7Tj6nPeAcaLG44HMIHCStIzJ1MKhCF/dnNuJTz+tdF8m6ggAgaPydk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=tpVPymNk; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=tpVPymNkz6FOV2wwS1Tj664d6hXQ5MR2T88OGVpOKDgccqboMMSuh/04zhTt8veHrryhmYtCcYaNyv5P4hBm2p4vyk5AvoT5yM3elnNmqCgwNE+IRMgIUUXkIikJ/U/6Rm6LDt7ifyIUNU7mSg1FrpXlkR657X6YeykihMkx8BC/C892u39VqkVJgNypMpPjqGaaKDgeav8hkoYgzgBaD1W7a9nzKScu9FL4XlLz6vAcAn0D+FPwMPdJwG+n78JjeqTED/QG1wKOu7kPS/EtmVoOqLTWLOlydNV3SQPcbKt9eYkjNVDFGXwWgGEbW+y5at33uysL69iFGhtG5TknVQ==; s=purelymail1; d=purelymail.com; v=1; bh=FglG9D0JTchfrqAucV53w19QJIXah4mHaUUvI4VYhxI=; h=Feedback-ID:Received:From:Date:Subject:To;
Feedback-ID: 68247:10037:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 465524449;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 17 Sep 2025 14:58:31 +0000 (UTC)
From: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Date: Wed, 17 Sep 2025 16:58:28 +0200
Subject: [PATCH] regulator: Fix MAX77838 selection
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-maxreg-kconfig-fix-v1-1-1369f88d6272@mentallysanemainliners.org>
X-B4-Tracking: v=1; b=H4sIAJPMymgC/x2MWwqAIBAArxL73ULaQ+wq0YfWakukoRBBdPekz
 xmYeSBTYsowVg8kujhzDAVEXcGymeAJeS0MspF9o4XCw9yJPO5LDI49Or6x1cYqq9ahkw5KeCY
 q+p9O8/t+ndAa+2QAAAA=
X-Change-ID: 20250917-maxreg-kconfig-fix-39ab7b7d642f
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758121111; l=1088;
 i=igor.belwon@mentallysanemainliners.org; s=20250908;
 h=from:subject:message-id; bh=FglG9D0JTchfrqAucV53w19QJIXah4mHaUUvI4VYhxI=;
 b=RF9Ebs1EZih336rLgSI/xkH1wxVAzkm90R248aqEWUdU++c3csXbkmdl4Gw6PMALt1Pzxj5/z
 ztj92P5FGlECF83wRiSy+PlbiqFvwBlQ15AWxDkM9yU9yJoNBc35lzq
X-Developer-Key: i=igor.belwon@mentallysanemainliners.org; a=ed25519;
 pk=t9Kz6B3jEwJD7YAKcp8XftfEz7SUSlGbrsfFlbrrFwA=

The current entry for the MAX77838 regulator is unselectable (as it
depended on a non-user-selectable config - REGMAP_I2C). Fix this by
making it select the config, and not depending on it.

Signed-off-by: Igor Belwon <igor.belwon@mentallysanemainliners.org>
---
 drivers/regulator/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 5e451be51392ce4edd31057ba5fefd90dfeef272..e252bb11ae6615dc9154908bc237905b97e739e5 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -779,7 +779,8 @@ config REGULATOR_MAX77826
 
 config REGULATOR_MAX77838
 	tristate "Maxim 77838 regulator"
-	depends on REGMAP_I2C
+	depends on I2C
+	select REGMAP_I2C
 	help
 	  This driver controls a Maxim 77838 regulator via I2C bus.
 	  The regulator include 4 LDOs and a BUCK regulator. It's

---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250917-maxreg-kconfig-fix-39ab7b7d642f

Best regards,
-- 
Igor Belwon <igor.belwon@mentallysanemainliners.org>


