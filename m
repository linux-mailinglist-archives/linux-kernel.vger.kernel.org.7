Return-Path: <linux-kernel+bounces-825655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF359B8C700
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 13:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5C717A2562
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 11:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960C22FD7DA;
	Sat, 20 Sep 2025 11:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="GYhmUWOU"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7384E2FD1DD;
	Sat, 20 Sep 2025 11:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758368625; cv=none; b=tv7B498aJm2ePl7o+UbFcpF1iGKWi4W3AfgKUncOzaVFuUkuaTb6iMhJxSGdi+6f6g3yvH9UxSN/oMenqxSlqdySkP/WZSstdZlCbs6roq8gv9Veo5KXK+1cRl2GTAp3v2Qqh47YsowtXImtaAdyj4hXWrCpCryGZKPYoZTZf4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758368625; c=relaxed/simple;
	bh=yZ4to0AKC6fUeJOP+USaK0CFrVLA/53lQ0swxJD/fho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nYn1Faafj/QmOcVUq1e5y9FKBCJ+1ElnIeTh/TJhlF+IufNIXyqjK2MRBvkgtZbgfWiWoOZZpu/6ZtaDi4E3aC068yY1YvtDSSL0svGk/9PTqCaOpO3/30rggyF9jrk4corBKoVlWKy9cFQ6jFSt9gQLbkRvIttJBaCyRcVWj88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=GYhmUWOU; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=4sxnO0B6ocFGQQxRWnkBDTywNlDIFE81QnFn8NSU4H8=; b=GYhmUWOUDMA63HqkoJhcS+keWs
	x0FsscByeHtiR/QQoap9IQmbePA7eN+j294SQ1RMgpaejm9t0swuADOJNXwl9gm7b33BGq7lT7rae
	uRGzzwHPzk/67oUG6D+gJkIaD+Cs3xyqQEqRbwTMGUh9Vv1Q4AE5P4eZ0ow/17rlxZ/tWWU4iATYW
	nWPu3iWX2k/OZQoo0CdVlM6S/2MTMXTRpdfkssiIuJAA7U2n2ktosj9ZL/Zd0mAJzjIz1L6LyaGA4
	8p7JOW52/YkYXbHI0H7i/jIMBGxMMEQR6qMNKIoFkAC+fNwUjrw3RMJJBKcUYgRZPhw2PHFEik201
	LjsdvOZw==;
From: Andreas Kemnade <andreas@kemnade.info>
To: jdelvare@suse.com,
	linux@roeck-us.net,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alistair Francis <alistair@alistair23.me>
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH RFC 1/2] hwmon: (sy7636a) fix races during probe of mfd subdevices
Date: Sat, 20 Sep 2025 13:43:10 +0200
Message-ID: <20250920114311.291450-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250920114311.291450-1-andreas@kemnade.info>
References: <20250920114311.291450-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If regulator subdevice is not ready early enough, devm_regulator_get will
get a dummy regulator device, not the real one needed from the regulator
subdevice, so defer probe in such case.
devm_regulator_get_optional returns an error in that case.

That fixes things, but looks odd, therefore RFC.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/hwmon/sy7636a-hwmon.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/sy7636a-hwmon.c b/drivers/hwmon/sy7636a-hwmon.c
index ed110884786b..e83d0e50c735 100644
--- a/drivers/hwmon/sy7636a-hwmon.c
+++ b/drivers/hwmon/sy7636a-hwmon.c
@@ -73,9 +73,9 @@ static int sy7636a_sensor_probe(struct platform_device *pdev)
 	if (!regmap)
 		return -EPROBE_DEFER;
 
-	regulator = devm_regulator_get(&pdev->dev, "vcom");
-	if (IS_ERR(regulator))
-		return PTR_ERR(regulator);
+	regulator = devm_regulator_get_optional(&pdev->dev, "vcom");
+	if (IS_ERR_OR_NULL(regulator))
+		return -EPROBE_DEFER;
 
 	err = regulator_enable(regulator);
 	if (err)
-- 
2.47.3


