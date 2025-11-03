Return-Path: <linux-kernel+bounces-883781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8ACC2E66D
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 00:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F2A03B8DD3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 23:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CCA3002DD;
	Mon,  3 Nov 2025 23:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="N8yOZ+gE"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DF82C11CB
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 23:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762212599; cv=none; b=EWhXRNoDCo1xXeSUOpkNim7lMVUKlA9MEYB84RXgey/DrA9i9gno81cSVb+Jr0nuO+D/Ziu6mwpg69bpzQpXTaW1VG9hGDAxVVXaEhhkVwe4WvC94oG55cl4k/ildKk8kyb2XHZw3lIYtL+X/R4bkTtvxcMXeXFA+McOTTGRJbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762212599; c=relaxed/simple;
	bh=7e8bhWKRVDtf8aKVV0+AAUPqW42KeeIQqV6I3K53e8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGhbL6ycpn4RV63tvQyhu6YMbDCzFUk1TU/mQrYOQjoMlQmeD7iYkMIDjlK8fMnQp1MApyfb1Dkof2YfEFdbgjVEpI5cDRONpfpzs0MMksDG2OW5GEsF4BGQyWw0puTiJz7FfbK2fLyZJYR//FgwYGBf5701lAkQOJywKk6araA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=N8yOZ+gE; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=FXGH735qWrvmiJLs+utyhLgjj/KKbRgYW73cH1TeOdo=; b=N8yOZ+gEf7cJJZR0XT8ItYqhqZ
	GGmifbmfrUBIDXEzpF1QxYFRcJCYmsClkJf2dOwptR/n2HG0Ank36miWFj5dePaUVedpCHcDpLgay
	gjtpS6ZSOuTN4DmGACPifmcFYG1aAJKV2Q8VGx55L5tn/4Ofe3GNVHPV9Tlm6eT0b4sC69+3dDpZM
	xtSevcVsl0knc1XGNT3dYD0ZE9wwAJP/Os3km2Tt1prfqFmlB4D+WLescGIkAfnhT5UZZJc5YuRbf
	09sDdw+BkD1bmKiOCpGZI7XJmXpxVtTmDj9KoJy9CG757zr7cpuTTUEsOVFpRYYsNsOa5FWwC+Wmb
	jnW2pbdA==;
Received: from i53875a3a.versanet.de ([83.135.90.58] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vG3zh-0007mj-KX; Tue, 04 Nov 2025 00:29:49 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: lee@kernel.org,
	srini@kernel.org
Cc: heiko@sntech.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] mfd: qnap-mcu: Hook up the eeprom sub-device
Date: Tue,  4 Nov 2025 00:29:42 +0100
Message-ID: <20251103232942.410386-3-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251103232942.410386-1-heiko@sntech.de>
References: <20251103232942.410386-1-heiko@sntech.de>
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


