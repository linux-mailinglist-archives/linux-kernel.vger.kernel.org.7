Return-Path: <linux-kernel+bounces-857572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3085EBE72A6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8DA7F4FCB0F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7727F285CA4;
	Fri, 17 Oct 2025 08:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="JOed2Jl5";
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="MJdawN3Z"
Received: from honk.sigxcpu.org (honk.sigxcpu.org [24.134.29.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEFA1D554;
	Fri, 17 Oct 2025 08:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=24.134.29.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760689698; cv=none; b=f7/u3ShGZajfmgCuhw94sIY6oAgsPWMX9UTYuOu3zK+7flIBZxgJivj/ZHPJS1HvDZd8Yc261gRGG8ECEAXNVtWTKixZroHlVZ5twJ+nLYd47dGZI2ZSS6hDBSCq0K1NoI5mjYLR2iarj/W6pfeqlBftr+mv/H4v/cMAqKmiNcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760689698; c=relaxed/simple;
	bh=bv0MFcUJUgE4Ccd0jdtsICdcdAGTrf3WNaZSSKtj3Xg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Cgqvi9aSl2W9VH6be4cLaAvpw82GUhSwVG3JBMo4UbpXdW+BUM1K6DDqPqxpa03bWNh9GF/OXzRvKjZn20bl9LvlfmHwjarqmTkU5tXGr3MNZjvXkdFDeauzkyIbMTONfL3aYAaZNQdVSp2W2aT0sgs0Y/zCQYPTRdbRyAJ8YEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigxcpu.org; spf=pass smtp.mailfrom=sigxcpu.org; dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b=JOed2Jl5; dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b=MJdawN3Z; arc=none smtp.client-ip=24.134.29.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigxcpu.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
	t=1760689692; bh=bv0MFcUJUgE4Ccd0jdtsICdcdAGTrf3WNaZSSKtj3Xg=;
	h=From:Date:Subject:To:Cc:From;
	b=JOed2Jl5w5O8oKrfp80pNCtAPHaBwlEkxiw6BDuC6S+oS4UggBAH64MAr5AzaWoi7
	 IbWdKSGwklfUBtCy5cGV2xMrPC5qjCLJjTjdZurqVk8gcSDvies2+MD321lLDvpGeI
	 0oXT++vpnSZ9K8MpoAulQfStJkvIn4OfoxXI83BXU0DQ6PBEdNyFAnMZLG9qVH+zC2
	 vlu9c8lm8XFa3MwY9gjJgsZeXQGfLzD0iaFjA+8CLaAcZ95nF60uXZq+K13Ft1Q0Ny
	 bC1+Qd1zwYW9iyfvsMxdS+AVxEpf0NhJxw7NuVBOhRT7Lk2qRj8NUojdH5CRT7ecuG
	 yQUS6niz5Zlpg==
Received: from localhost (localhost [127.0.0.1])
	by honk.sigxcpu.org (Postfix) with ESMTP id 1FE08FB03;
	Fri, 17 Oct 2025 10:28:12 +0200 (CEST)
Received: from honk.sigxcpu.org ([127.0.0.1])
	by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DVy3VHxS0P9I; Fri, 17 Oct 2025 10:28:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
	t=1760689690; bh=bv0MFcUJUgE4Ccd0jdtsICdcdAGTrf3WNaZSSKtj3Xg=;
	h=From:Date:Subject:To:Cc:From;
	b=MJdawN3ZhI76o167EpanWP/eB65PwH5DtEhCqgvQrlawmNNovbYjzl7uxXssu+vqU
	 OeCS9xEKn7tf+lbVm/dcAKBLDG+BpQxqMKC++9R4SRUnsYoye6ExvyQlAawj/KR5zV
	 HtHhnVdBDVckOvvWUjXExVow9LUEF4Z8vbAsYy9ABKSQhgpjgjMjVK34jzzSIrR7Gb
	 4Ocr195uBDlaNtTpfJlEDI+Bddxr5MUKteRMNE2UV2eXy30K/szswo34n3JpIUc6l7
	 P85hYHN664qpND0JB/91EnRJujZdp7sV+iGOxBONGMZ0RtvF50GJ7kv08vnevBhPf5
	 ImuZ4DSLS7YKQ==
From: =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Date: Fri, 17 Oct 2025 10:27:59 +0200
Subject: [PATCH v2] drm/panel: visionox-rm69299: Depend on
 BACKLIGHT_CLASS_DEVICE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251017-visionox-rm69299-bl-v2-1-9dfa06606754@sigxcpu.org>
X-B4-Tracking: v=1; b=H4sIAA7+8WgC/32NwQ6CMBBEf4Xs2TV0CcV68j8MhwIrbKKUtEpqS
 P/dinePbzLzZoPAXjjAudjA8ypB3JyBDgX0k51HRhkyA5VUq1Jp/FVcRP/QhozB7o4Na0tclZr
 0AHm5eL5J3K3XNvMk4en8ez9Z1Tf971sVKhyq7qQay7UlfQkyxn55HZ0foU0pfQDJlfSFuAAAA
 A==
X-Change-ID: 20251016-visionox-rm69299-bl-7e6a2e30626d
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 phone-devel <phone-devel@vger.kernel.org>, 
 Gustavo Padovan <gus@collabora.com>, "kernelci.org bot" <bot@kernelci.org>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1113; i=agx@sigxcpu.org;
 h=from:subject:message-id; bh=bv0MFcUJUgE4Ccd0jdtsICdcdAGTrf3WNaZSSKtj3Xg=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FJQVNXL2hsSksvT
 UhqQWNzbVlnQm84ZjRUY3JuRHc0RnArbEY2RTNvMEcyaDd3SWlYCjJ0TzRZRmFOcWp3R0dtK01T
 YTJKQWpNRUFBRUlBQjBXSVFSajlzemZsaUtkQ1NocktzTWx2NFpTU3Z6QjR3VUMKYVBIK0V3QUt
 DUkFsdjRaU1N2ekI0L3YxRUFDV2Y2R2p5YTlLMkJ4MUJLSU1BL21McTVIcm0zOERuVE9aY3l3Qw
 pKWnRibkJUdVBpQkRQdmlxaG9uODRzbG1GVzRZZUlISGdhTkRBdEp4MjdrZE1iSmhQbDhwZXhnb
 0xxc3JJWFJ2CkhSdjBOZ096cVN5Vkx3b25mbjBkQTUwdmRXZWdadVZ5bjFKczJMOW03cis3NkpP
 dndGTXUwSitKMHp5U1FXV00KbmZ0ZTROSWRaZlB0eTRiNHl4QWRZZVdkbWE4V2dmR2pnMzUrRzR
 6RjRmUE9Rb3ZTRUNLdWo1dDlrbEM4TUdVbApoK0FNWUVuR0JOazdPeHY5SVphVFI3YVhqbnc3NH
 lrWWRDSWJOSC9FbVNGQU1UU3lpWkVkcEtNN3JFT08wbU9XCnZ6NHU3ams4d3hpaWtKcTBHUjA4e
 lBBRm1XU3k4c1VTTmtTM29SbVg2K1p3ajBtZFUzYmUwZWFuMFc3V3pPSk8KZEdDRTZ2a01Na0pl
 dE0remduWFlvenJOVUc3VzQ1WkZhNHRnamNuREN6bFplUy8vazlSQmFWSjNDOTIraFJCUwp4QU4
 wZDA3WjZkelFZN3NSMFZUeVRDQWZrZ3hYcyszRDBHWXFDRjJJSGNsZnU2Y2hxbkllVEFEODBFR3
 htenJNCnN5Ty9qbi80cFpuYzFzazdMTDN0d0Zydi81VEZNQjZ6VTZ4VlhxOGlROWszU1lGUFdyY
 TFtdzVvbzVKOUp6SlYKS3NqQ3VqcXRVVDBINEU3RXRmMXVnUnRLNkhGNURCQ0s3bXpJQ0F1aWNU
 OHMzSEpUWDBmWkZ2RlNJeDF5UFFOdwphRitiNVBFRDhKV0VBQmVaUGpwRUNQZTUxOTZOSWpYbDF
 BVlNEWk9xS1FuRG9UWkV3bFJ3VFd2ckpubGhBTHlGCmd1aWo2QT09Cj1vcUhqCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=agx@sigxcpu.org; a=openpgp;
 fpr=0DB3932762F78E592F6522AFBB5A2C77584122D3

We handle backlight so need that dependency.

Fixes: 49802972d116 ("drm/panel: visionox-rm69299: Add backlight support")
Reported-by: kernelci.org bot <bot@kernelci.org>
Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
Changes in v2:
- Add Reported-by: kernelci.org bot <bot@kernelci.org>
- Link to v1: https://lore.kernel.org/r/20251016-visionox-rm69299-bl-v1-1-d3b817ae5a26@sigxcpu.org
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


