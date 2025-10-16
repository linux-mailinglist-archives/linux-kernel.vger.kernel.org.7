Return-Path: <linux-kernel+bounces-856121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2256BBE3281
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46388586EA2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4573164C5;
	Thu, 16 Oct 2025 11:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="TrTwhDv7";
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="MXzMS8dV"
Received: from honk.sigxcpu.org (honk.sigxcpu.org [24.134.29.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2741DF987;
	Thu, 16 Oct 2025 11:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=24.134.29.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760615295; cv=none; b=RPEjM0sVGKS4z1DwnsrYmem8HfH2Vcol4DLGijhYWCxLoI7mzVCPCUqRkngxslilBGoDeEFkg9/GCpSZUQCztBLIDlAqwDJdijJW99OqjoVKWSTEKvGw7yYQfU0vhgujZ9CeaISEheRU8HixIu9RXUlHLxtUuT3BXD0MECpu4K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760615295; c=relaxed/simple;
	bh=1uX+iCoWbbjlWd3wtxJLMpV1DvJ1ymMC5djhMKb2x6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=h7olg3rkfK9W8tRiIiOPL1stw2QDpfF90SYUlHujrh5odS3VPADLSJ4ZrzaQq9wkv+aGVwdWYdhlztw+1GaE+RSZThqRRsaJL0Y6pRu6NwFvfPuJxG9Zvpfd39Oji3bzInansmw80QjAUyLTn2jNet8nPUtLfjd3lxkAmLhFBXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigxcpu.org; spf=pass smtp.mailfrom=sigxcpu.org; dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b=TrTwhDv7; dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b=MXzMS8dV; arc=none smtp.client-ip=24.134.29.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigxcpu.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
	t=1760614899; bh=1uX+iCoWbbjlWd3wtxJLMpV1DvJ1ymMC5djhMKb2x6E=;
	h=From:Date:Subject:To:Cc:From;
	b=TrTwhDv78JXvTmxNwLMfnDGUHA/a5yzZEf+bJZSOTUHLK7yPotLP5LfpmGfEsl1HZ
	 nOlKhqzond9NkKwzgqPyW4vKG6bG50EwMMKWKva7CyfdUuBHOM/QD0//IHNcJnAjvv
	 vRJZS4yLvaWtUZppr2swIJxkooH9LGOXkVsLhbtr2gNbS2H3T7mACpEqxR2QeMiCRN
	 w1UnTWCEa/sXN0pNV3ETfqstt/Ir0dTFZLzQCJEICRzal4D5vEqsgebOU33tVHMbRC
	 5F4QmloXPZkIcRIXy34bOFsaewSC21nBdZC4/HVkGcpNxCJHGSWRoTASAqPXCv17dF
	 qxm0bUBXHyeww==
Received: from localhost (localhost [127.0.0.1])
	by honk.sigxcpu.org (Postfix) with ESMTP id 93C3AFB03;
	Thu, 16 Oct 2025 13:41:39 +0200 (CEST)
Received: from honk.sigxcpu.org ([127.0.0.1])
	by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GcYD6Z5qO_cK; Thu, 16 Oct 2025 13:41:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
	t=1760614898; bh=1uX+iCoWbbjlWd3wtxJLMpV1DvJ1ymMC5djhMKb2x6E=;
	h=From:Date:Subject:To:Cc:From;
	b=MXzMS8dVauLGdGvUsUigJj68Cz8vYmupGJRgCs6Z8gRXOecJXjyQtYtPcUFtDwXjO
	 9U5s5cj4X90twHD3TXJfbalF153QTLQhkPzgoadokJ7w+s7VCgjfXsKAuUqC8wW1Ng
	 rf9+3Usz47mnQePEpcIhAFTOz71awud5yLSHOkPNRCCBnnPp8V++Nj4lxxGavW/KlV
	 66QvSd9Sdj+QCZk+d7bXDbpwIWmFq5cioLhwO0cj6/pAWu6m8cZkF5SVCRxxLgBYho
	 ZqrgzmzR3KAY+1PsG9h7XIv2NpQYlHR4YBxB8NXagWEHT1YpxWXL6iMqG1+zJlsrk5
	 qDiAZtoVsCjMw==
From: =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Date: Thu, 16 Oct 2025 13:41:27 +0200
Subject: [PATCH] drm/panel: visionox-rm69299: Depend on
 BACKLIGHT_CLASS_DEVICE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251016-visionox-rm69299-bl-v1-1-d3b817ae5a26@sigxcpu.org>
X-B4-Tracking: v=1; b=H4sIAObZ8GgC/yWMSQqAMAwAvyI5G2gjRupXxEPVqAE3WhBB/LtFj
 wMzc0OUoBKhzm4IcmrUfUtg8wz62W+ToA6JgQyV1ljGX9kvDCs7cg67BSthT1IYJh4glUeQUa/
 v2rTP8wLUphi0ZQAAAA==
X-Change-ID: 20251016-visionox-rm69299-bl-7e6a2e30626d
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 phone-devel <phone-devel@vger.kernel.org>, 
 Gustavo Padovan <gus@collabora.com>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=886; i=agx@sigxcpu.org;
 h=from:subject:message-id; bh=1uX+iCoWbbjlWd3wtxJLMpV1DvJ1ymMC5djhMKb2x6E=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FJQVNXL2hsSksvT
 UhqQWNzbVlnQm84Tm5yM3JGaG9MeERnQVVuZVlkenlsaHNYZ2R6CjUrQVNjKzVJMUg3SnhwNnZK
 ZEdKQWpNRUFBRUlBQjBXSVFSajlzemZsaUtkQ1NocktzTWx2NFpTU3Z6QjR3VUMKYVBEWjZ3QUt
 DUkFsdjRaU1N2ekI0MGdWRUFDcmMzSjdyNHZuQmxxWUJxbndiMEh0dHJDZ3VXbUhUVnRDc0Z0Tg
 o3S1dBZWlpaytnS09SMk1DTlJFTUMvdXJmdE5xODFoOVlMTC9KRUNKY0ZyRktUM0VRN3B6TUdzR
 Vc0Q2NpSkIwCmlIMC82UW4zNG5oUGxJdzBlam5YeDRYN3hqYlEwUDAxZS9mejNTdXk1RXQvUnBq
 SFE5c0ZJaC9OWjdCSmxIdm0KZitsUDZ0N09LSFBCWXlqdGlSV1VQc00wRHJIU2xmRUwyTnFKVkR
 uZXhMOGIrUkdoT3Zrem1VUGhBSkVvcGtZbAoyczVGN0VZYk9GNlZIbGl5emJDQjJockhVNFJ2Ym
 1qakU0dmt2MUR5aHRRditEM0FYSldTdWNLQWF2SHcrTUFWCnVodWE3TXBIVjAwaXQ5VHE3SDZWZ
 UN3NHRwYzRiY0RMRDRNQW9qN0ZuV3JZWUdUcGFManVCV1BFbTBITW5KcVgKYnJrZG4wSytXTG1G
 bHd4WkNsU3J3V0FLTkxhelZZU2MzZGFEMnVveXlhUEh0MjNHUTlIanJTRTBLL0lIMHlUSgpJUjB
 xMjY5dGsrSXVnanE4YnB0MzRqRy9HVFp1b01icGxKRnBkWHNvK3RFU3B6VzdwdXVVQmtvcXFwTk
 Mra1NRCngxRXA4ZWFJL0JBZGFocWhwZ0RmNHAwRlMyTXJNTzA5MEcrM21WTldzbjF0RHdISGF2a
 GtVTkM5VFc5cFRZZ04KSlJDUm9rVFg2cWdiV0F6UElCcTY2TW1oaDVuMTB6ZzlyVk9KRUszTHEw
 NXFYdUIxdHpzUVZpYkR6SmxiQ2owbApzRlZtTVhUZFBZV1lsM2EwbTF3bTM2ZU1GWncvZE5hbmp
 Gc1RvUVRnTzlHcGF6Yk4xYzgzU0lBRGlOa2FHTmFCCjFIYlc0Zz09Cj1xM1FwCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=agx@sigxcpu.org; a=openpgp;
 fpr=0DB3932762F78E592F6522AFBB5A2C77584122D3

We handle backlight so need that dependency.

Fixes: 49802972d116 ("drm/panel: visionox-rm69299: Add backlight support")
Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/gpu/drm/panel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 407c5f6a268b..59f5a31f3381 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -1112,6 +1112,7 @@ config DRM_PANEL_VISIONOX_RM69299
 	tristate "Visionox RM69299"
 	depends on OF
 	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
 	help
 	  Say Y here if you want to enable support for Visionox
 	  RM69299  DSI Video Mode panel.

---
base-commit: 7ea30958b3054f5e488fa0b33c352723f7ab3a2a
change-id: 20251016-visionox-rm69299-bl-7e6a2e30626d

Best regards,
-- 
Guido Günther <agx@sigxcpu.org>


