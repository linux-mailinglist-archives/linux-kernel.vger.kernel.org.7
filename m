Return-Path: <linux-kernel+bounces-795982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91508B3FA4F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0A4A188C276
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F712E9EC1;
	Tue,  2 Sep 2025 09:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CHRii3RU"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50C5246778
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756805295; cv=none; b=Cs1+wbL+JFCBnSQ0uX6RX2KRxaWoVCoLVtq5110UfkVqX8pJ2vsrVtHbef4YYRwQMLysYCBAd4TzOeso5C/pshRa8KWVhAKAHPMiqcizIyOVBNu2oJ80ML+De/0EFmCQtsEJpdhxwHuo8152yK+9LwwPzqcQBV8WvY4R5ALootw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756805295; c=relaxed/simple;
	bh=kX99daaTmRjZZgK7NDFvXocEUTsxLb0HWG3/u7rNoOQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fp7FFhyB9CC972sy2Er7lbXBkO2trI65TXB8R6Y4S9PmU1pWd2kubdsOzLeuXuAssC5n17RxJvvpK+thhqFzAa8p8McXtdrvSlWBEyubnnCZAVa7eyqcMFeaXhNZ8iv4gv6CMLYH/eEDqbVl54pmEE974Dr3ZXNVL88qZL4IIYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CHRii3RU; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756805286;
	bh=kX99daaTmRjZZgK7NDFvXocEUTsxLb0HWG3/u7rNoOQ=;
	h=From:Subject:Date:To:Cc:From;
	b=CHRii3RUTvt67o2uyq3VloVbOygGmlL+ddS1PuriwQWfeAIyTPZlfq3zweQJ2itTL
	 qjNUWhdH3E4FsFVFqfdkCKRr0FfCQmuNe0i6bMBHF1uONrRCMKypfFTMo2LylPtFHp
	 1oh4N7dOdmPtEDmL/HzH/z715AxV2/LiETaHAS2UID8E27Blw9ZctXuU/H4EIHLYMv
	 KwQlHvNPjA657acqbePIapKEo2OmtDv3tM1RLE5mqo5BeWY+1GQkMHv9tuPTIy4hIi
	 fpfb3jye3VcvfHsE+3ot69+5m64gcVv3MESMnVJYeq0zq788GOpmHQLFlbqPfZYsVc
	 XN7+VILWcxaOw==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 3225917E0676;
	Tue,  2 Sep 2025 11:28:06 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH 0/2] Introduce BACKGROUND_COLOR DRM CRTC property
Date: Tue, 02 Sep 2025 12:27:55 +0300
Message-Id: <20250902-rk3588-bgcolor-v1-0-fd97df91d89f@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJu4tmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCyNL3aJsY1MLC92k9OT8nPwi3WTDRPMky0RTA/OkZCWgpoKi1LTMCrC
 B0bG1tQBLBZTeYAAAAA==
X-Change-ID: 20250829-rk3588-bgcolor-c1a7b9a507bc
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, Matt Roper <matthew.d.roper@intel.com>
X-Mailer: b4 0.14.2

Some display controllers can be hardware-configured to present non-black
colors for pixels which are not covered by any plane (or are exposed
through transparent regions of higher planes).

The first patch of the series introduces the BACKGROUND_COLOR DRM
property that can be attached to a CRTC via a dedicated helper function.
A 64-bit ARGB color value format is also defined and can be manipulated
with the help of a few utility macros.

Note this is a reworked version of the patch [1] submitted (many) years
ago by Matt Roper.  The main changes are:

* Dropped drm_arg() in favor of drm_argb64() to get rid of the bpc
  parameter and the related shifting for more flexibility in operation,
  e.g. when user-space cannot make use of the helper and/or when it
  doesn't now the actual precision supported by the HW.  This also
  simplifies the property verification/validation testing (see below).
  It works by extracting the specified number of least-significant bits
  from each color component.
* Renamed DRM_ARGB_*() to DRM_ARGB64_*_LSB() while providing convenience
  wrappers to extract all 16 bits of a specific color via DRM_ARGB64_*()
* Replaced GENMASK_ULL(63, 0) with U64_MAX when calling
  drm_property_create_range() to create the BACKGROUND_COLOR property
* Moved crtc_state->bgcolor initialization from
  __drm_atomic_helper_crtc_reset() to
  __drm_atomic_helper_crtc_state_reset()
* Replaced '*bgcolor*' occurrences to '*background_color*' for
  consistency with the actual property name in both storage field and
  helper functions names

The second patch adds background color support to the VOP2 display
controller used in the RK3568, RK3576, and RK3588 Rockchip SoC families.

For the moment this has been validated using a modetest wrapper script
[2], which is able to execute several tests - see an example of a
generated report at the end.  Proper support in Weston is currently in
development, and I will provide a reference once it becomes available.

The tests were performed on the Radxa boards listed below.  Please note
that as of next-20250901, there are a few known regressions; for each
case, I mentioned the actual problem and its related fix/workaround
accordingly:

* ROCK 3A (RK3568)
 - issue: broken networking
 - fix: revert commit da114122b831 ("net: ethernet: stmmac: dwmac-rk: Make
   the clk_phy could be used for external phy")

* ROCK 4D (RK3576)
 - issue: random freezes right after booting
 - fix: add regulator_ignore_unused to kernel cmdline

* ROCK 5B (RK3588)
 - issue: broken networking
 - fix: apply patch [3]

[1] https://lore.kernel.org/all/20190930224707.14904-2-matthew.d.roper@intel.com/
[2] https://gitlab.collabora.com/cristicc/linux-next/-/commits/drm-vop2-bgcolor-test
[3] https://lore.kernel.org/all/20250827230943.17829-1-inochiama@gmail.com/

Validation report on ROCK 5B
============================

$ tools/testing/rk-bgcol-test.sh

---------------------------------------------------------------
 Available Rockchip display connectors
---------------------------------------------------------------
id	type	status	crtc_id	plane_id
85	11	2	0	34
88	11	1	83	40

Selected connector: id=88 crtc=83 plane=40

---------------------------------------------------------------
 Check initial state
---------------------------------------------------------------
Read BACKGROUND_COLOR prop (ARGB64): 0xffff000000000000
    Connector: HDMI-A-2
	background color (10bpc): r=0 g=0 b=0

---------------------------------------------------------------
 Set/get DRM property
---------------------------------------------------------------
Changing prop value to: 0xffff00000000ffff
opened device `RockChip Soc DRM` on driver `rockchip` (version 1.0.0 at 0)
Read BACKGROUND_COLOR prop (ARGB64): 0xffff00000000ffff
    Connector: HDMI-A-2
	background color (10bpc): r=0 g=0 b=ffff

---------------------------------------------------------------
 Plane display test 40@83:960x540+480+270
---------------------------------------------------------------

Changing prop value to 0xffffffff00000000
Press ENTER to continue..
opened device `RockChip Soc DRM` on driver `rockchip` (version 1.0.0 at 0)
testing 960x540@XR24 overlay plane 40

Read BACKGROUND_COLOR prop (ARGB64): 0xffffffff00000000
    Connector: HDMI-A-2
	background color (10bpc): r=ffff g=0 b=0

Changing prop value to 0xffff0000ffff0000
Press ENTER to continue..
opened device `RockChip Soc DRM` on driver `rockchip` (version 1.0.0 at 0)
testing 960x540@XR24 overlay plane 40

Read BACKGROUND_COLOR prop (ARGB64): 0xffff0000ffff0000
    Connector: HDMI-A-2
	background color (10bpc): r=0 g=ffff b=0

Changing prop value to 0xffff00000000ffff
Press ENTER to continue..
opened device `RockChip Soc DRM` on driver `rockchip` (version 1.0.0 at 0)
testing 960x540@XR24 overlay plane 40

Read BACKGROUND_COLOR prop (ARGB64): 0xffff00000000ffff
    Connector: HDMI-A-2
	background color (10bpc): r=0 g=0 b=ffff

---------------------------------------------------------------
 Restoring state
---------------------------------------------------------------
Changing prop value to: 0xffff000000000000
opened device `RockChip Soc DRM` on driver `rockchip` (version 1.0.0 at 0)
Read BACKGROUND_COLOR prop (ARGB64): 0xffff000000000000
    Connector: HDMI-A-2
	background color (10bpc): r=0 g=0 b=0

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Cristian Ciocaltea (2):
      drm: Add CRTC background color property
      drm/rockchip: vop2: Support setting custom background color

 drivers/gpu/drm/drm_atomic_state_helper.c    |  1 +
 drivers/gpu/drm/drm_atomic_uapi.c            |  4 +++
 drivers/gpu/drm/drm_blend.c                  | 37 +++++++++++++++++++++++++---
 drivers/gpu/drm/drm_mode_config.c            |  6 +++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 13 +++++++++-
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h |  4 +++
 include/drm/drm_blend.h                      |  4 ++-
 include/drm/drm_crtc.h                       | 12 +++++++++
 include/drm/drm_mode_config.h                |  5 ++++
 include/uapi/drm/drm_mode.h                  | 30 ++++++++++++++++++++++
 10 files changed, 110 insertions(+), 6 deletions(-)
---
base-commit: d0630b758e593506126e8eda6c3d56097d1847c5
change-id: 20250829-rk3588-bgcolor-c1a7b9a507bc


