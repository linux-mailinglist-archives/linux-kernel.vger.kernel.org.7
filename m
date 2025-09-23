Return-Path: <linux-kernel+bounces-828990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BF4B95FDA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75A8D19C381C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61D8326D76;
	Tue, 23 Sep 2025 13:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="WIjRcKzn"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95F9318141
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 13:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758633522; cv=none; b=sJQs/BvOHU1tVKRFtf6r36LJMNAsBn8y6LhyKjFYo8cJA9lYSWOIiRAAPVxXZA7X5Rcx2JdFyra1th5GxUqwuRsgnnsVf7Nqe02zJWzG4VenLaR+YjXDjcVU1MGtLQKELwBOULTsb/eu9jfTNqeAiIzmFpsYqFmM9eLlT3hLIFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758633522; c=relaxed/simple;
	bh=7e8bhWKRVDtf8aKVV0+AAUPqW42KeeIQqV6I3K53e8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWCaJM0dRNM1/k35okvg5FKVF8CwYjHBjmNzBhvQnGS+fFxKWRe19nY65f04Dw3LUetCHqPH+o8uEZvoxQj7z7an1uyz3Lp+cU2q6xx+1tvO9gZC038VK1lcSp4Ypv4OyKB1ZOI+ZR/M6Drjz3dD2Q/p8vIDwhTZaaNTCfwNi8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=WIjRcKzn; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=FXGH735qWrvmiJLs+utyhLgjj/KKbRgYW73cH1TeOdo=; b=WIjRcKzn43mkDOXPxw5qPAvqoO
	f56GnwgxgTynW+2ULQK4zMByFzOyp6Gda1ec0gavlS6jQf+Q4nEyLD1VYwprFa/cMgg/BFBygc2SH
	w+LVMeBeaaIss6FF8EY8cxNNM8/VxK8nKOIimdwkTFHKFueqE+ohbOtvY6K7m13pd6hW+Zkwj+fGP
	Ol89ObEcWmLnZQ1ymNR6f9Yh6akQUnGeT4puJMDyS7t5QXRAjURSqPk3pY+IGI8sl7Zj2E5PWxSFT
	amxjYxPdvM5zJl2gQOQ53e6UARuyP8jtqnQWwn1xodBo2NEsdZSJWwMv/hknYH5jP2XPoGxiu4KCD
	4XQakMWg==;
Received: from i53875a1e.versanet.de ([83.135.90.30] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1v12ud-0003yq-3g; Tue, 23 Sep 2025 15:18:31 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: lee@kernel.org,
	srini@kernel.org
Cc: linux-kernel@vger.kernel.org,
	heiko@sntech.de
Subject: [PATCH v2 2/2] mfd: qnap-mcu: Hook up the eeprom sub-device
Date: Tue, 23 Sep 2025 15:18:15 +0200
Message-ID: <20250923131815.1898332-3-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250923131815.1898332-1-heiko@sntech.de>
References: <20250923131815.1898332-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the qnap-mcu-eeprom platform-driver as sub-device for the MCU.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/mfd/qnap-mcu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/qnap-mcu.c b/drivers/mfd/qnap-mcu.c
index 4ec1f4cf902f..2be429a50611 100644
--- a/drivers/mfd/qnap-mcu.c
+++ b/drivers/mfd/qnap-mcu.c
@@ -264,6 +264,7 @@ static const struct qnap_mcu_variant qnap_ts433_mcu = {
 };
 
 static struct mfd_cell qnap_mcu_cells[] = {
+	{ .name = "qnap-mcu-eeprom", },
 	{ .name = "qnap-mcu-input", },
 	{ .name = "qnap-mcu-leds", },
 	{ .name = "qnap-mcu-hwmon", }
-- 
2.47.2


