Return-Path: <linux-kernel+bounces-744606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F75B10F1B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA96F545BF9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5BA2EB5A6;
	Thu, 24 Jul 2025 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lh8NZZbv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421012EAB6B
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753372125; cv=none; b=mPFxaI7wzWxzKRmn/wt1P6hjeL+1GUzNMMkoWjNDWdXJSS7rvR7Q9R4juM1TADjPMWo2FdMhWfnJePCI8jFRuEhoubyI3RceBQJDVYTrtumj2Qa9KDwQ1dniZWmZ8p+c7u4Um5atQGkEzqzXgm7DhEgKiCCR5ozEMOB4uCJu3Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753372125; c=relaxed/simple;
	bh=J6IGtn8Fc/KM2mNRmZhCLjiAF/zyIMOes9oro7xnN4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t2MNbeV/0h1u4HGfSBFSiyO9/wUbokxMooqRSDzPvZKoVzQrrgTJnuMKG1KT+KTc70YYV7xo1gNhyY28WECwpUHzIHIYDw35mZUmZRvKl/4iAbnJXxltu+eSbYUSB7nAdUl78GLq0zs3Bcq3AmxHio/igvlH4Ag+SQ9512rEo4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lh8NZZbv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4DF7C16AAE;
	Thu, 24 Jul 2025 15:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753372124;
	bh=J6IGtn8Fc/KM2mNRmZhCLjiAF/zyIMOes9oro7xnN4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lh8NZZbvSMUtdRFKC6IsYBTX5dWy5M6jCdw3UbJi9wBx5/toS3N1iGIHdez8P/8zL
	 bdjSQ66H2f5t1AaO8ANrCqMs40Xbm05Ca3RMdCAZYahR8fMUJ88I1YpWkpwnGetFrN
	 4bkcZ7mg/Qr9LUmQzzyVAV+wXspO+EmyH/R3dcI5fhLXq+H+F5qViR1rvYTb1eBuEo
	 I/ypmP5Gv56LUFy/msGPlCFQBfsQqR5NewdVeFjePWB71GQ4GukFQcNrezP1ik/DA0
	 MKX5qZZrYZ8UazNbWgDXlpu+lsQfKbHEcWJE27DLRomruI0Y7wlj74uza4p+A7mF1x
	 85aPoqIKAn7iA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1ueyBU-000000004B9-36Lk;
	Thu, 24 Jul 2025 17:48:40 +0200
From: Johan Hovold <johan@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	Justin Chen <justin.chen@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 06/11] phy: samsung: exynos5-usbdrd: drop unused module alias
Date: Thu, 24 Jul 2025 17:48:18 +0200
Message-ID: <20250724154823.15998-7-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250724154823.15998-1-johan@kernel.org>
References: <20250724154823.15998-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver has never supported anything but OF probe so drop the unused
platform module alias.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index 917a76d584f0..804539d26cc7 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -2385,4 +2385,3 @@ module_platform_driver(exynos5_usb3drd_phy);
 MODULE_DESCRIPTION("Samsung Exynos5 SoCs USB 3.0 DRD controller PHY driver");
 MODULE_AUTHOR("Vivek Gautam <gautam.vivek@samsung.com>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:exynos5_usb3drd_phy");
-- 
2.49.1


