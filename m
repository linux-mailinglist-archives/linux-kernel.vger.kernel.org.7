Return-Path: <linux-kernel+bounces-824228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85240B88728
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B775524C7D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 08:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968C6304BD7;
	Fri, 19 Sep 2025 08:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmxBHDyy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E222BD01B;
	Fri, 19 Sep 2025 08:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758271132; cv=none; b=V6y071vWy9BrLPKJPbACMpzh8TB4CtKJRgzbZDW0X1IY/aIkHyWOTfbsm+K3wQKkfXoj2jTSQJrBvf5ljCattQ30kmxnr/0GwiOEJLbKZtcaSODhRndis4LSfE2xp0lk3HqIseERLPWgMBmQFxgJIKuYlr+YAwrUNLXecFvThT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758271132; c=relaxed/simple;
	bh=rXD9mJPOGbd6zOlzFCkbifz9W7UxmCVdWguW9J4jTD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lHwYHTsC2d5ihXnAutsdQFtNbG5U2M5Ne3Yu9N7MnWHgVmNAqBa7YXVwx8npICEaD+LPmNCEEXDoMIEKzfCoU693fmcbem8KlBw6GZlEpphao+m0jB+aq75s94mLNBLw+RuGqohmdf+NILhtov4doxF7DmrleT8FDEmgX3A6tAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmxBHDyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B344C4CEF7;
	Fri, 19 Sep 2025 08:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758271131;
	bh=rXD9mJPOGbd6zOlzFCkbifz9W7UxmCVdWguW9J4jTD8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=HmxBHDyyZ1U2lhspRMkTaXJj8CN09QMhLzKwNnXNixni6jgSM8WE6NhPgcHRc/wsn
	 kTyT0KHTmkby56j2mJ0BO9bwhDIHqM+lQQO5bamZmYuM/PShnvJ8/Tzgy8qT4H0T1E
	 RJY2/3fjORVr4ErGaGMUj3DzRwbsqKsWt+yQeBjzog6nFG6cBxT5rTsr7a1Ayf2EAi
	 amMn1XK33CFPMzagYjeVJZqgadQT20GRmfQzMARXQJhnHwlUKi5k3oFGVLYkllr7ph
	 mva6LclAsohKIamzBOlixLloUn6JeZ1Ur9w4DsywE7aGp6ZOu6vTl2DdmCHoatF6gh
	 seLILxK8t0LEQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5667ECAC5A5;
	Fri, 19 Sep 2025 08:38:51 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Date: Fri, 19 Sep 2025 16:38:49 +0800
Subject: [PATCH] hwmon: (gpd-fan) Fix range check for pwm input
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-hwmon-v1-1-2b69c8b9c062@uniontech.com>
X-B4-Tracking: v=1; b=H4sIAJgWzWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDS0NL3Yzy3Pw8XUtzA+NE45REQ0vTRCWg2oKi1LTMCrA50bG1tQAG7sl
 gVwAAAA==
X-Change-ID: 20250919-hwmon-9703a3da195a
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 niecheng1@uniontech.com, zhanjun@uniontech.com, 
 Chenx Dust <chenx_dust@outlook.com>, 
 Cryolitia PukNgae <cryolitia@uniontech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758271130; l=1169;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=afIndOhFyRIpJBSDKmekESS308i/EUBmxUVarGxW7lY=;
 b=UU9NK+el/HvToO6JeXG6lF9yDJmp4kowqe6RJJadveUBwOdNADYAxD1khU+xxXv4hM3W4QeOh
 IpqArxawtJUDtaQ3kP05C6UCZf8qYy9M7ViixdgkK9JDo53JpeXoTNU
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

From: Cryolitia PukNgae <cryolitia@uniontech.com>

Fixed the maximum value in the PWM input range check, allowing the
input to be set to 255.

Fixes: 0ab88e239439 ("hwmon: add GPD devices sensor driver")
Reported-by: Chenx Dust <chenx_dust@outlook.com>
Link: https://github.com/Cryolitia/gpd-fan-driver/pull/18
Co-developed-by: Chenx Dust <chenx_dust@outlook.com>
Signed-off-by: Chenx Dust <chenx_dust@outlook.com>
Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
 drivers/hwmon/gpd-fan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/gpd-fan.c b/drivers/hwmon/gpd-fan.c
index e0b3b46e1bf12a10097600f857c627a766f61a27..644dc3ca9df7da0174e513c47a820a6ff39eb0ef 100644
--- a/drivers/hwmon/gpd-fan.c
+++ b/drivers/hwmon/gpd-fan.c
@@ -571,7 +571,7 @@ static int gpd_fan_hwmon_write(__always_unused struct device *dev,
 			ret = 0;
 			goto OUT;
 		case hwmon_pwm_input:
-			if (!in_range(val, 0, 255)) {
+			if (!in_range(val, 0, 256)) {
 				ret = -ERANGE;
 				goto OUT;
 			}

---
base-commit: 80038a758b7fc0cdb6987532cbbf3f75b13e0826
change-id: 20250919-hwmon-9703a3da195a

Best regards,
-- 
Cryolitia PukNgae <cryolitia@uniontech.com>



