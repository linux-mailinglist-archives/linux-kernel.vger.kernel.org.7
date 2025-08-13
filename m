Return-Path: <linux-kernel+bounces-766703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80437B24A2E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8715A1BC5F45
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDFB2E62B0;
	Wed, 13 Aug 2025 13:07:23 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AAF2E612A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 13:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755090442; cv=none; b=I3RbeIY53vfXIryHYkRwExCucKmEDrhZ1nEOuDA1D98yL1dXR/QqiTpx8J7jLHB02OYHrDm/+n3dkQJ3kMhVcSHZvzBUrICQ9zaUUHoT/NpR96UDgEQXhEKeR+cPDvUQ1Iyf6uSWEjYQ3uYPwTdnkV2A8gaCsxDAv1/IoE8lZlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755090442; c=relaxed/simple;
	bh=HABmKtOhnt8GVLNByBQ/IS/82617YDraMxjzx2yP0i0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mp/dabR18Rr6utXKtoz/BsD2S1dUn1Dtf8NYNC+S72xYEzvABJSC7pll44nvX1cmTiidd269S4X3P5XnPmQ7V4sx6Wy0XSXCWgs4Bw8iS2ItQr0/dEHyMfdcI434+s4rMQONOkGkkwaWlDvLNCe2NvdHIKU6UapLThgF/WfZIik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBD4C4CEEB;
	Wed, 13 Aug 2025 13:07:20 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Marek Vasut <marex@denx.de>
Cc: linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] regmap: Remove superfluous check for !config in __regmap_init()
Date: Wed, 13 Aug 2025 15:07:18 +0200
Message-ID: <a154d9db0f290dda96b48bd817eb743773e846e1.1755090330.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first thing __regmap_init() do is check if config is non-NULL,
so there is no need to check for this again later.

Fixes: d77e745613680c54 ("regmap: Add bulk read/write callbacks into regmap_config")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/base/regmap/regmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 1f3f782a04ba23a9..6883e1a43fe5d7af 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -827,7 +827,7 @@ struct regmap *__regmap_init(struct device *dev,
 		map->read_flag_mask = bus->read_flag_mask;
 	}
 
-	if (config && config->read && config->write) {
+	if (config->read && config->write) {
 		map->reg_read  = _regmap_bus_read;
 		if (config->reg_update_bits)
 			map->reg_update_bits = config->reg_update_bits;
-- 
2.43.0


