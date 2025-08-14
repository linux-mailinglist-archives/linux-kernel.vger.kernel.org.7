Return-Path: <linux-kernel+bounces-768708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E784B26469
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE981C84F12
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56262F998C;
	Thu, 14 Aug 2025 11:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="GbdnvxO0"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B3E2BE020
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 11:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755171337; cv=none; b=V5I02cFsRnTlkrjVPgmT8zti9ejH6NH9CT+0tyeIgsEo8bTmqmT47sAfe5Y6dWdq5kGxggMUFU1nkTXWi7Y27Wa3usC/FjJsz0ojPXzKWDKCmSsDWmqnc1VBJZ+tslIs5hHMpe9c0pGBlIzdMWjzamn45FA+ntBKJsejXmcyjBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755171337; c=relaxed/simple;
	bh=99GH0a+mDXdTcc15ZoX4EWLpxTVCVMUcN1gG1gD85Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oaoWqI551lkZ7cnhWru+qcJSdD2GhYL0Y+OBSeGingNUbDMXkogCiDXt0up3pAljeFsrW1DqgTKN6EdbY8Kb9097Y8b3maLBMjniuZNCNNjtgwI9jblmAA7SAHDEwJLn0u+ggoL9AWM7FeCP77kpH7mEaK9hLJpIlDl7sMuGn1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=GbdnvxO0; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=rY14a9yxr74FB40Vw1Xff3ggg57AOflGxQdWJpiKAyY=; b=GbdnvxO08omcS58zsZHNsk1UjZ
	lTxFF7gdWMXqUVGdOtDTYQ+JX0wE2839OKs2Jxyai+lwc66cJZWw74XR3OWf3OBiPxLdbDqVZp2Rt
	LEYd9l5g0Eh/9nNpqnVm4MmaNzY2ibBBLwCJKUl6Z290vqvFsUAeNB4+52bFhMU4l53R8cc208ua1
	IIEaLfo8Ee3sxO6PL6qFy+E18nJq6Whiwo+VG0n+PUnLBBvxZ/1eDayPKJFgvMsGd1+HuUB/RRwgh
	mNS4BO/IPC7XME5edAeeAXPEboqXq6dkYrjiSKczIYWeEnrFBcNu23Y6vuBhNXeQvazKBPPOFjroY
	wv9ukb5A==;
Received: from i53875b38.versanet.de ([83.135.91.56] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1umWEz-0003Km-JV; Thu, 14 Aug 2025 13:35:29 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: tomeu@tomeuvizoso.net
Cc: ogabbay@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	heiko@sntech.de
Subject: [PATCH 2/2] accel/rocket: Depend on DRM_ACCEL not just DRM
Date: Thu, 14 Aug 2025 13:35:19 +0200
Message-ID: <20250814113519.1551855-3-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250814113519.1551855-1-heiko@sntech.de>
References: <20250814113519.1551855-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the current dependency on only DRM, a config of

CONFIG_DRM_ACCEL_ROCKET=y

is possible, but of course wrong, because without DRM_ACCEL the build-
system will never even enter drivers/accel/* .

So depend on DRM_ACCEL instead of just DRM.

Fixes: ed98261b4168 ("accel/rocket: Add a new driver for Rockchip's NPU")
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/accel/rocket/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/rocket/Kconfig b/drivers/accel/rocket/Kconfig
index af6cda273892..16465abe0660 100644
--- a/drivers/accel/rocket/Kconfig
+++ b/drivers/accel/rocket/Kconfig
@@ -2,7 +2,7 @@
 
 config DRM_ACCEL_ROCKET
 	tristate "Rocket (support for Rockchip NPUs)"
-	depends on DRM
+	depends on DRM_ACCEL
 	depends on (ARCH_ROCKCHIP && ARM64) || COMPILE_TEST
 	depends on ROCKCHIP_IOMMU || COMPILE_TEST
 	depends on MMU
-- 
2.47.2


