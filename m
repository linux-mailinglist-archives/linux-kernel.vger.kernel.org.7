Return-Path: <linux-kernel+bounces-742259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C31F7B0EF4A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD93718848FC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A19028A73F;
	Wed, 23 Jul 2025 10:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="tlyHAGcU"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64B327FD45
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753265140; cv=none; b=h376qAUFQp6dP8IThVMSz9FBJqzecEd0oSeZvWQ3FFZL5uGOAwzCAP2NgjixGDpMb5YAcounbuW2Kwb9ElSw3udmGA0nF8ZfYLHICun8UAqgR7vwj0wFreHMBGntr8NMzHuIKqgMPB2yDmFoXGhFq9pIueGS3T+o2mxcBKXVej0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753265140; c=relaxed/simple;
	bh=B/V0GYOcAzL6vFMAfDHXfosHSzQrBzvrlkN4WeibsYI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bu2sNemDyqsVXsvVLY+PU7NExlCRS0gIU8zcHMAxG18zGxsMfOc1aYsJ3XStvFQCE+B0kuCqQihP1k75vxo1S5ptLrWsrIUP7jvSMwljjS/0BrYClXjI8DrAkCj/ce0GcNdE7C9U2ovX8xPv/bNlGOeLLogSiYWEhxvnRTeOl8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=tlyHAGcU; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 21FCDEA0;
	Wed, 23 Jul 2025 12:04:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1753265098;
	bh=B/V0GYOcAzL6vFMAfDHXfosHSzQrBzvrlkN4WeibsYI=;
	h=From:Subject:Date:To:Cc:From;
	b=tlyHAGcUlJiDG5ahUyQIZL7Nk7z0TncxqJ8f1FX8Ltfoo446uQ4/cvorfugOKYv+n
	 BYdkGhhJc8d/vdR4ycIqQRBJKbxJbQ2kx7zPSG8h33pH8s4Nf9+YUHh1Yh2g9m6N+r
	 Yn8hwb7cgcHNV+O0U2JWNaFdsUYPUklen0obNfXk=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v5 00/15] drm/bridge: cdns-dsi: Make it work a bit better
Date: Wed, 23 Jul 2025 13:05:06 +0300
Message-Id: <20250723-cdns-dsi-impro-v5-0-e61cc06074c2@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANOzgGgC/3XNQW7DIBCF4atErEsFwxBoV7lHlQVmxg2LmBQSq
 1HkuxenC1dyvfyfNN88ROWSuIr33UMUHlNNeWhhX3YinsLwyTJRawEKrDKgZKShSqpJpvOlZGn
 I9x05j560aEeXwn36foIfx98u/HVr7nUZT6lec7k/n456Xjf9UUslHVhwLtoeTXdIxKHmocuh0
 GvMZzGLIywKKlgp0BQM6s1wCJbBbSjmj6JxpZhZYQvWasJebSm4KHvtVwo2xe8hetTUsYJ/lGm
 afgDmd5IRmgEAAA==
X-Change-ID: 20250320-cdns-dsi-impro-3d8fbd7848d1
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jayesh Choudhary <j-choudhary@ti.com>, Dmitry Baryshkov <lumag@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, Francesco Dolcini <francesco@dolcini.it>, 
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4601;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=B/V0GYOcAzL6vFMAfDHXfosHSzQrBzvrlkN4WeibsYI=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBogLPo7IyCtyZpAZ3tfUnypqp+RNxnlzTEvdvHJ
 EhBwbAwIq6JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaICz6AAKCRD6PaqMvJYe
 9T3QEACqDSm5uW1rTCS0cbGuU14U0tos8wXkXaNAR4GmbmBAan7SrD+hwF9ZlC3YCLxr4D8Mpdp
 sD2Y/lK6FhcJoGM6QG/gE2yfPG8aSD+Oih12dRzKw+1muVhuujPpixxE4kReittu13B6CiUgcRz
 vvMMeeipTgRTf9yWWE7Bs6s+dR2m1W+3YRprL6jPJGPA02M+NRndYd8nA+9r1x3xtnIaswMn5BM
 eWPYVHD/mbmj4svosZKG6EwSAtTg+piD0CqWRnmq+U5DCahwZDtOZpBgWPYsOMuh+qJy3BumK2r
 31nBOc+YryDMW4m0rzJHDQ7wtR+OUiVxT5gpStgcAql64akCAy8N8bTHHrqtAhUtF/d+tVrUdqv
 2Mw+/4iSfVkctNQJ2yyBvt06hDTwiIpe3LDkjd+iCC5JBYW+/uNUa0pTLdizNSJAmR+ottfBTnr
 kMrmUp+kZE9KKXolvZXjy/n485m9pqnjU/nNaKTu6nvb/5vmAZbSM3UDVWorgvCC7jimc/S5zd9
 8+lKZu+WtjVlXY/byoxzTKdyqzIbn6NY8BYGCa4J+pkLphyNFGnlVBweAU7amw2s8dyLiIPn5qd
 Ga0s4/ZgvUhWXM3cmNxjilBredE1ftrwUgTS3XValnM+ZpgFlm39PF1SItgbYFy1Y7F75nkcmw0
 y+aM15XI678giAg==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

While trying to get the cdns-dsi to work on Toradex's AM69 Aquila
platform, I hit multiple issues in the driver. Basicaly nothing worked
for with the board.

This series fixes those issues. While I itch to make much larger changes
to the cdns-dsi driver, I opted to keep this series relatively simple to
make the fixes more clear and possibly help with backporting.

The series also touches tidss, but those changes are not strictly
needed, and can be merged separately. And the series also touches
cdns-dphy, and those changes are needed.

This has been tested on Toradex AM69 Aquila (upstream) and AM62P Verdin
(Toradex's BSP), with:
- HDMI output using lontium lt8912b
- LVDS panel (sn65dsi84 + panel-lvds)

 Tomi

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Changes in v5:
- Added Tested-by and Reviewed-by tags
- Dropped cdns-dphy patches, which are now in a separate series
- Link to v4: https://lore.kernel.org/r/20250618-cdns-dsi-impro-v4-0-862c841dbe02@ideasonboard.com

Changes in v4:
- Rebased on top of drm-misc-next, which has most of the dependencies
  merged
- Moved one dependency, "drm/bridge: cdns-dsi: Fix the _atomic_check()"
  into this series
- Dropped "drm/tidss: Adjust the pclk based on the HW capabilities".
  This causes a regression with OLDI outputs, and is not strictly
  required. Fixing this needs restructuring tidss clock handling.
- Link to v3: https://lore.kernel.org/r/20250414-cdns-dsi-impro-v3-0-4e52551d4f07@ideasonboard.com

Changes in v3:
- Add Aradhya's "drm/bridge: cdns-dsi: Fix the _atomic_check()" to the
  dependencies
- The above patch from Aradhya allowed adding "drm/bridge: cdns-dsi:
  Drop crtc_* code", which resulted in quite large changes in the
  commits, even if the end result doesn't really differ.
- Reordered commits to decrease back-and-forth (e.g. fixing something in
  a a code that will be removed in the next commits)
- The reordering caused quite big changes in the commits (even if the
  final end result is more or less the same), so I chose not to add
  tested-by tags.
- Rename 'cdns_get_dphy_pll_cfg' to 'cdns_dphy_get_pll_cfg'
- Use div_u64() instead of div64_u64()
- Drop "Fail if HS rate changed when validating PHY config". This was
  too strict, as clock rounding (especially with DRM's 1kHz
  resolution...) leads to clock rates that do not match exactly.
  However, the rate mismatch should be fine as the commits adjust the
  pixel clock, and the resulting differences should be so small that we
  can't even improve the timings match by adjusting the DSI HFP, as the
  adjustment rounds to 0.
- Link to v2: https://lore.kernel.org/r/20250402-cdns-dsi-impro-v2-0-4a093eaa5e27@ideasonboard.com

Changes in v2:
- Change the tidss clock adjustment from mode_fixup() to atomic_check()
- Link to v1: https://lore.kernel.org/r/20250320-cdns-dsi-impro-v1-0-725277c5f43b@ideasonboard.com

---
Aradhya Bhatia (1):
      drm/bridge: cdns-dsi: Fix the _atomic_check()

Tomi Valkeinen (14):
      drm/tidss: Fix missing includes and struct decls
      drm/tidss: Use the crtc_* timings when programming the HW
      drm/bridge: cdns-dsi: Remove extra line at the end of the file
      drm/bridge: cdns-dsi: Drop crtc_* code
      drm/bridge: cdns-dsi: Remove broken fifo emptying check
      drm/bridge: cdns-dsi: Drop checks that shouldn't be in .mode_valid()
      drm/bridge: cdns-dsi: Update htotal in cdns_dsi_mode2cfg()
      drm/bridge: cdns-dsi: Drop cdns_dsi_adjust_phy_config()
      drm/bridge: cdns-dsi: Adjust mode to negative syncs
      drm/bridge: cdns-dsi: Fix REG_WAKEUP_TIME value
      drm/bridge: cdns-dsi: Use video mode and clean up cdns_dsi_mode2cfg()
      drm/bridge: cdns-dsi: Fix event mode
      drm/bridge: cdns-dsi: Tune adjusted_mode->clock according to dsi needs
      drm/bridge: cdns-dsi: Don't fail on MIPI_DSI_MODE_VIDEO_BURST

 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 211 +++++++++++--------------
 drivers/gpu/drm/tidss/tidss_crtc.c             |   2 +-
 drivers/gpu/drm/tidss/tidss_dispc.c            |  16 +-
 drivers/gpu/drm/tidss/tidss_dispc.h            |   3 +
 drivers/gpu/drm/tidss/tidss_drv.h              |   2 +
 drivers/gpu/drm/tidss/tidss_plane.h            |   2 +
 drivers/gpu/drm/tidss/tidss_scale_coefs.h      |   2 +
 7 files changed, 106 insertions(+), 132 deletions(-)
---
base-commit: ea6f8ed2dd2cea602911fa76c0bc2938ec67db88
change-id: 20250320-cdns-dsi-impro-3d8fbd7848d1

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>


