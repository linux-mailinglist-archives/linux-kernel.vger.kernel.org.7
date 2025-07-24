Return-Path: <linux-kernel+bounces-744609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B13B10F21
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3621A1894CA0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7192D193C;
	Thu, 24 Jul 2025 15:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXQx+e0t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7354BEACD
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753372125; cv=none; b=bvwSTHhTJL6zWexl6AFH5Aje+gD5xQVaKhtaI5CxMjT8KDfq1Go8f1SzM/OZ9YRuQqutygfubUwOJYkd2/9dasvlIFICiFqOJDSiN4hVDv6MECh9mjzEB8v3CnE1FihvUrZsRp5xR3KW8p3DBDwzlk+W7yYVJB51YyVUvdFfGx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753372125; c=relaxed/simple;
	bh=xAB1FNxF2XyT59XNGYq9PeZA6YZnFTj1VUlXmpbMHqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MhQJ/C9wagQm+o7YaLxIlCcf9OZnScqqm+jJbG2ntyP17Sg5AXW+jQwFQo2+YV1gQfRvlN4vp68bIDrBshq4880aFRCc5rL59I8t+C0XP/vBHZOU6wjmQ7T0GgJKj2kJ/utdS7Pw34WrEJQOZoSx/21edUdiOvQR3xl4ROVaPzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXQx+e0t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F92C4CEF6;
	Thu, 24 Jul 2025 15:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753372125;
	bh=xAB1FNxF2XyT59XNGYq9PeZA6YZnFTj1VUlXmpbMHqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VXQx+e0t6GjXvWcd/njVTfj6hJ1vIYWdjMsX0J5cyx6GwAHSwwDB7LTuH8r/T4vw0
	 ETjXy0zqtPqqIUz6+zXRMb15pnVYoBkMjn4iFQvYEoHwkoXFp1I+xwiGI721vBurnK
	 1ooVjaK11oN/l/dQWvLJ+uWbeenRnGaKOmhsivifxXsuc6tKybd7x6sR/C1kd81vqD
	 IsMjnX3NimeYhploi/bSWL3q2I4TKvsn3Th+mMRvJlJFmfLGgKdsz50ZiFQRJbeuMf
	 kRZOJ7wqv/Hf3Q1GMH7o+IgchrlFIrUpu/XPl073co8dKzbLUTaUXQshjRhOPujgiB
	 w/Zu8pYsPHsRg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1ueyBU-000000004BC-3WFb;
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
Subject: [PATCH 07/11] phy: samsung: usb2: drop unused module alias
Date: Thu, 24 Jul 2025 17:48:19 +0200
Message-ID: <20250724154823.15998-8-johan@kernel.org>
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
 drivers/phy/samsung/phy-samsung-usb2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/phy/samsung/phy-samsung-usb2.c b/drivers/phy/samsung/phy-samsung-usb2.c
index 9de744cd6f39..d2749b67cf8f 100644
--- a/drivers/phy/samsung/phy-samsung-usb2.c
+++ b/drivers/phy/samsung/phy-samsung-usb2.c
@@ -258,4 +258,3 @@ module_platform_driver(samsung_usb2_phy_driver);
 MODULE_DESCRIPTION("Samsung S5P/Exynos SoC USB PHY driver");
 MODULE_AUTHOR("Kamil Debski <k.debski@samsung.com>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:samsung-usb2-phy");
-- 
2.49.1


