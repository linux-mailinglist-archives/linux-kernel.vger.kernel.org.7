Return-Path: <linux-kernel+bounces-858804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02938BEBE2C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 00:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E21AD627E8B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 22:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7763F2C0F9C;
	Fri, 17 Oct 2025 22:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QWxmnxob"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF4D2BEC5E
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 22:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760739015; cv=none; b=tj0cK+WqPJQwwf+DX7JSjBoM7Ds+5SPKRkBBEzd4EhdG/AMgg3SaYVzWehtJeijK5RbRGo58rIwm2yZkQaSmlKzT0xqCbY55Upmly0Tu7Y58C+5oGB5xcqdFuYxOFQPdsTuDfV8Uob4mHSQeAlMBQg3DJ+cwM4X45PjTCbEroB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760739015; c=relaxed/simple;
	bh=ST6hl0pijhCKMa3ZETzc2qzBu3nJRljUWoe1xFU6RGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qCZGBsBLoVkrwZ12YI42f02Ya57Df07QGlBrwCFp9l9c130G38tMMIfpGXBBLWriQPva5cv/ij062q8C79yAOdKZ5k0gp/T9oMLLtzka5x069q+bRYSNYsgG79qAFixn+7udOIt+mN5/PkIEgbYZpllVeaFt3dUEvexBXzUB83Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QWxmnxob; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760738999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LYJooa3CPyiL/YqvqFJbpYPNVK38FpDeFlhZ7s1lavw=;
	b=QWxmnxob+fxd6kyXR2Yyd0g0hFnFRzfunZcrA+AKQkwUTkBDME5O8A/pj0nE4ZsRt27jKM
	DP8XgrreoLrKjZRe/qPI99FtJ4fCZcCA+gxdKH6t7Uinqykmb2uBcwX5DjLbUelJLvNZgv
	o7Avg4oA0CpZsrCge2SOt7JJ91SHbjM=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH RESEND wireless-next] wifi: mt76: connac: Replace memcpy + hard-coded size with strscpy
Date: Sat, 18 Oct 2025 00:09:14 +0200
Message-ID: <20251017220913.167923-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use strscpy() to copy the string into the fixed-size buffer 'req.data'
instead of hardcoding the number of bytes to copy. This improves
maintainability and ensures the buffer is always NUL-terminated.

No functional changes.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index fc3e6728fcfb..8fc3ecfc27a0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2020 MediaTek Inc. */
 
 #include <linux/firmware.h>
+#include <linux/string.h>
 #include "mt76_connac2_mac.h"
 #include "mt76_connac_mcu.h"
 
@@ -1974,7 +1975,7 @@ int mt76_connac_mcu_chip_config(struct mt76_dev *dev)
 		.resp_type = 0,
 	};
 
-	memcpy(req.data, "assert", 7);
+	strscpy(req.data, "assert");
 
 	return mt76_mcu_send_msg(dev, MCU_CE_CMD(CHIP_CONFIG),
 				 &req, sizeof(req), false);
-- 
2.51.0


