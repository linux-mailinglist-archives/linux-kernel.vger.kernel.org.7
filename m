Return-Path: <linux-kernel+bounces-745521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09899B11B1E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237831CE0369
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08C4238C3A;
	Fri, 25 Jul 2025 09:46:43 +0000 (UTC)
Received: from out198-23.us.a.mail.aliyun.com (out198-23.us.a.mail.aliyun.com [47.90.198.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCBB242909;
	Fri, 25 Jul 2025 09:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753436803; cv=none; b=iUj9EJ5wy/4MckY98X5u9IYUZ8sPlYE04wB6yNqxxDMID4F5XeQEwZhIy0TOHcDO8yE7rWAGzagIMcEtTWDmHbAiDUF1AEMugSar28fihbqyrw5kYwKq/pJFIiICS7yhZGeu3Xzt7dKxFXbldb5L2yc8y+gajHn1NbRJL3IaHmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753436803; c=relaxed/simple;
	bh=4wnJjAo2Le0HqaN2yjtxk+3ltfijy3eh6GPwj2j0Ns4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b3Xmi0W3T7U6pdFO7hspASlo1d0sZps6HV+X/Gtgeop8weCIHE58FBrVhX1iFv5AgF+XZ3dIYOmu1eE0XL1q6clxUYH9/jRrrE/pnx2Yc5pYh0h9LqyobCyFDGJDnK0dnGTE0+JLw+TS9w+3tlaHlh0g7nyM5LQnuT22TRTpltY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; arc=none smtp.client-ip=47.90.198.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.dyCry-a_1753436764 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 25 Jul 2025 17:46:06 +0800
From: wangweidong.a@awinic.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	zhujun2@cmss.chinamobile.com,
	wangweidong.a@awinic.com,
	thorsten.blum@linux.dev,
	colin.i.king@gmail.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yijiangtao@awinic.com
Subject: [PATCH next v1] ASoC: codecs: Add acpi_match_table for aw88399 driver
Date: Fri, 25 Jul 2025 17:46:02 +0800
Message-ID: <20250725094602.10017-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weidong Wang <wangweidong.a@awinic.com>

Add acpi_match_table to the aw88399 driver so that
it can be used on more platforms.

Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 sound/soc/codecs/aw88399.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/aw88399.c b/sound/soc/codecs/aw88399.c
index bad3ad6b8c0e..c23e70d64d0c 100644
--- a/sound/soc/codecs/aw88399.c
+++ b/sound/soc/codecs/aw88399.c
@@ -2330,9 +2330,18 @@ static const struct i2c_device_id aw88399_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, aw88399_i2c_id);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id aw88399_acpi_match[] = {
+	{ "AWDZ8399", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, aw88399_acpi_match);
+#endif
+
 static struct i2c_driver aw88399_i2c_driver = {
 	.driver = {
 		.name = AW88399_I2C_NAME,
+		.acpi_match_table = ACPI_PTR(aw88399_acpi_match),
 	},
 	.probe = aw88399_i2c_probe,
 	.id_table = aw88399_i2c_id,

base-commit: d7af19298454ed155f5cf67201a70f5cf836c842
-- 
2.47.0


