Return-Path: <linux-kernel+bounces-735361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A0AB08E41
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 867B33B70A8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5C62E5410;
	Thu, 17 Jul 2025 13:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPjHjKvS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BED62B2D7;
	Thu, 17 Jul 2025 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752759050; cv=none; b=OXZbkLrn9JZEI8SkK7QKr6kbyNB88Zq6VUQjiQYVYCr8fAYvHPHwMd5j5EiBwm4ShXL23+sgjS+jUWDxr3TPKSCIP9FYL1BaoKf3mGn5vMn7V6/PtMxIwHgDozwHrtLHZXwTDphHMcNQUXIaLK5va76yWo0Tna0nqdmasVsAm5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752759050; c=relaxed/simple;
	bh=skd8Hwq5hJyWeNiDY4xNdLu7o7yA+AoV/CyygsK8K/0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Txg+7chxPrUyeHdmN2PqM31fI0RK4LbZ+lQbcp63BdcTNmHq5x6kKYykXXTaO0xiRpafbp8R9driUaSFj/bSbJ/VeUlm7XEwrbsgWnJ93ivhD6zUFkOep0kUuieHLoys+sLOM2rAOhjTEZImsYWuzJZxV5WSPe4OpfSyL/+Etxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPjHjKvS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B515C4CEE3;
	Thu, 17 Jul 2025 13:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752759050;
	bh=skd8Hwq5hJyWeNiDY4xNdLu7o7yA+AoV/CyygsK8K/0=;
	h=From:To:Cc:Subject:Date:From;
	b=dPjHjKvSiFMkKb7REQFSsDUUPBfGp1JCV5UZwjNWHcsJRDUMeBeoxjsgTZpmR6zyT
	 KqqMp5GA3u5Oyw1zJicrVjMxlRPDHLfn3Qh1z0YYMu/gyIZhCZ/Dtqnp4JsiEd1eC/
	 UV7WfxEbtkEKIbAFaWMUlREkp1TXOxMXaYMhvbxlzCFQT+YFhfgNsN0RVCYdk1Zixy
	 t8zhiDNYIqS41BxSZV44ViFa6sA5Oj71ZezOBwU7h0bDvA4LOQJFZAzCdTKVI2DYVU
	 kwtXCUAWzoeTWHm0G0Dy8lZ07m2ZvxHUuJQ7f5T4N1Dfk2+GmPqlNgNxzJjRnKcGC0
	 1Ewf9qkayFkag==
From: Arnd Bergmann <arnd@kernel.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Pavan Holla <pholla@chromium.org>,
	=?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>,
	Yue Haibing <yuehaibing@huawei.com>,
	Pengyu Luo <mitltlatltl@gmail.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: typec: ucsi: yoga-c630: add DRM dependency
Date: Thu, 17 Jul 2025 15:30:41 +0200
Message-Id: <20250717133045.991254-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Selecting DRM_AUX_HPD_BRIDGE is not possible from a built-in driver when
CONFIG_DRM=m:

WARNING: unmet direct dependencies detected for DRM_AUX_HPD_BRIDGE
  Depends on [m]: HAS_IOMEM [=y] && DRM [=m] && DRM_BRIDGE [=y] && OF [=y]
  Selected by [y]:
  - UCSI_LENOVO_YOGA_C630 [=y] && USB_SUPPORT [=y] && TYPEC [=y] && TYPEC_UCSI [=y] && EC_LENOVO_YOGA_C630 [=y] && DRM_BRIDGE [=y] && OF [=y]
arm-linux-gnueabi-ld: drivers/gpu/drm/bridge/aux-hpd-bridge.o: in function `drm_aux_hpd_bridge_notify':
aux-hpd-bridge.c:(.text.drm_aux_hpd_bridge_notify+0x28): undefined reference to `drm_bridge_hpd_notify'
arm-linux-gnueabi-ld: drivers/gpu/drm/bridge/aux-hpd-bridge.o: in function `drm_aux_hpd_bridge_probe':
aux-hpd-bridge.c:(.text.drm_aux_hpd_bridge_probe+0x20): undefined reference to `__devm_drm_bridge_alloc'

Add a dependency to force UCSI_LENOVO_YOGA_C630 to be a loadable module as
well in this configuration.

Fixes: eb90d36bfa06 ("usb: typec: ucsi: yoga-c630: register DRM HPD bridge")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/typec/ucsi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/ucsi/Kconfig b/drivers/usb/typec/ucsi/Kconfig
index 52b53bb6dfed..7fcb1e1de5d6 100644
--- a/drivers/usb/typec/ucsi/Kconfig
+++ b/drivers/usb/typec/ucsi/Kconfig
@@ -85,6 +85,7 @@ config CROS_EC_UCSI
 config UCSI_LENOVO_YOGA_C630
 	tristate "UCSI Interface Driver for Lenovo Yoga C630"
 	depends on EC_LENOVO_YOGA_C630
+	depends on DRM || !DRM
 	select DRM_AUX_HPD_BRIDGE if DRM_BRIDGE && OF
 	help
 	  This driver enables UCSI support on the Lenovo Yoga C630 laptop.
-- 
2.39.5


