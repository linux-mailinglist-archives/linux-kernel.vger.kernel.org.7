Return-Path: <linux-kernel+bounces-830082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86348B98B09
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8008A189D085
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 07:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A69728136B;
	Wed, 24 Sep 2025 07:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCr3NSbc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B36A95E;
	Wed, 24 Sep 2025 07:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758700121; cv=none; b=KtzsAeFdATcQVp8D2NxqCvIENVfCML/1NeYmjZLgGV1ZKX00BU10sAI+noi9VeAeq7jPHfDJW62zG3LnvY4tHNpaN1aHsdbrm4LoNjoVohgdAlSXaHGYEuqiHBx02YBcRqKGBglPd0PZsBPxlIiuaKMTeFKiYD/q0C+/L2xYdx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758700121; c=relaxed/simple;
	bh=4RgNQXDUKmVNhLMTLsj3YfRs+pGxjlg5HCCvZTce2GA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FNTy8jryTdcs109O47CNLU0Oo/oNQEkAMeaeZRLYqCW0EfHldjWA2bw1cxQfyo2+WouBhmo3hqkLDf7rzhjdIuePHxOFoBHQ9uBu1iyqke5RHHaC93aqSxp3a0ms+ZWJo1AV/jI0zS6uPJagSg0/5zKq7cq9kRh1PXngZfLd/rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCr3NSbc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58C09C4CEE7;
	Wed, 24 Sep 2025 07:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758700120;
	bh=4RgNQXDUKmVNhLMTLsj3YfRs+pGxjlg5HCCvZTce2GA=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=sCr3NSbcSb1uLk7QduudamVD1x5e6TMN0daYJcTTOrRNTXC4T+a67ZMZMgfdSNY5w
	 lj2KcBdD9lJZJRbf6sA8YjzDJwp9Y7R1tHmzuHeyVZyZn8bkpk3NC1jzIiKzaBJwDk
	 21rTcF+hngy5MqPhM5RtnmqC9HmJuUDI5u1nfYQxy5M532YpITBm/gUxH0kpZgo/7Q
	 GdEwIzAxbuVhBpG5pVE/O79mGZw9VAxokxw8oJNkx+parovRGOrom+kTfccZT/IDE9
	 39CaFCJnUY78WHWDTELu2OhWD6mq++Rdxdudeayuk31nSe5iATAK9UCSToymeyBVr/
	 sdrX2Zdi5uxRw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA73CAC5A7;
	Wed, 24 Sep 2025 07:48:40 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Date: Wed, 24 Sep 2025 15:48:38 +0800
Subject: [PATCH] hwmon: (gpd-fan) complete Kconfig dependencies
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-hwmon2-v1-1-fc529865a325@uniontech.com>
X-B4-Tracking: v=1; b=H4sIAFWi02gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSyMT3Yzy3Pw8I92U5BSjREuTRHNzAxMloOKCotS0zAqwQdGxtbUA+Of
 MX1gAAAA=
X-Change-ID: 20250924-hwmon2-dcd2a94a7704
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 zhanjun@uniontech.com, niecheng1@uniontech.com, 
 kernel test robot <lkp@intel.com>, 
 Cryolitia PukNgae <cryolitia@uniontech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758700119; l=963;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=k4QkTC6YnHu5jzG67ZnVwUnYYgbwugDDSWlzXKmtp8c=;
 b=GE4DQ6Ez6OxCbnPuQZfoUP/YDOxmTdAdoEtsjcBlReQwni8cVkg1F4QXlpq8qKhLNX2KJ2j8k
 ehsMT3oZuZ7AW4hNM6cefixG+2G7/AALVKyj0GLj1jC3Oael1gIYR/9
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

From: Cryolitia PukNgae <cryolitia@uniontech.com>

DMI and HAS_IOPORT is also needed

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202509200214.i2QX7iwD-lkp@intel.com/
Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
 drivers/hwmon/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index d6769288a76e81f79d2fdf4e6a9943db1466fa54..d61014d7968a4ab77c055a744837b106ae112aa3 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -771,7 +771,7 @@ config SENSORS_GL520SM
 
 config SENSORS_GPD
 	tristate "GPD handhelds"
-	depends on X86
+	depends on X86 && DMI && HAS_IOPORT
 	help
 	  If you say yes here you get support for fan readings and
 	  control over GPD handheld devices.

---
base-commit: 80038a758b7fc0cdb6987532cbbf3f75b13e0826
change-id: 20250924-hwmon2-dcd2a94a7704

Best regards,
-- 
Cryolitia PukNgae <cryolitia@uniontech.com>



