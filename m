Return-Path: <linux-kernel+bounces-744612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1883B10F1E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 930137BCB89
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981872ECEAB;
	Thu, 24 Jul 2025 15:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTfOYXzX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57A52EBB9C
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753372126; cv=none; b=b86MFaw2UMkjP1jdCnK+SuOEOcVYHYLwOUuODZ60StWxGiKtx0pMp2CluuvHcwzWgER+DpC+OhOkcveyRKU8/S9xjzkgndu+EYEwm6SgLXEl3c8yx4ZFa1/A2NteErL+CVOyZTfnOXHED2Zk+NvtrXmoYsUrJ4yMVqcjhgknS14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753372126; c=relaxed/simple;
	bh=EwsPyx7dz7vSpeeYkSkzX73MFwyn2UY9p6ctVWyUVJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SIO0hJlbRiwHzEPgvK6M5wFcTLNs8ph8T2g2ZBql9pTUsV9VDGYNCs2WBjHt6eMwKFy7ekNBZw34RO63EXJxNyepBfvM5lJ8wGKFCUIsRH8z1gV/Am87KarqGucLqi0iMKPdXWDJdYEwDbbSvG+WPXnRgDBVrt2C8iNZQ5ZO7X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTfOYXzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA4DC4CEED;
	Thu, 24 Jul 2025 15:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753372125;
	bh=EwsPyx7dz7vSpeeYkSkzX73MFwyn2UY9p6ctVWyUVJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TTfOYXzXn83LMaoSCKQ7FQTrldOsvDJkszbaNyRHLH19Ep//UAGcACCxg6d28dQbl
	 JiNup8Yo6ASaCMf4rgh50vlQig0v/xcBEo97rJw8Eg0pKhk4N/H6ycoz8d43UJVLzM
	 stTH4MqniaNaJMooZs179P1HggFZsG045HVKWc1PYwnlR0nqhbMRBD/zOTvpqraTwS
	 CuB9CBr7RI0jk0gFLZjyMtw3+QeIpQV2meqUk7ej+5Wm3ccjSKrfBKF1vVOvW4GYxU
	 a177XwHZdDmrrKu+T/BALViZ6fK1CxZTi4BCfP8+DBI9eZAFJ5Ya8dtsQZ8Pm7ZI3A
	 tVXX5TcqG2HPg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1ueyBV-000000004BL-0MEm;
	Thu, 24 Jul 2025 17:48:41 +0200
From: Johan Hovold <johan@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	Justin Chen <justin.chen@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 10/11] phy: ti: dm816x-usb: drop unused module alias
Date: Thu, 24 Jul 2025 17:48:22 +0200
Message-ID: <20250724154823.15998-11-johan@kernel.org>
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
 drivers/phy/ti/phy-dm816x-usb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/phy/ti/phy-dm816x-usb.c b/drivers/phy/ti/phy-dm816x-usb.c
index e8f842d4e841..d274831b731c 100644
--- a/drivers/phy/ti/phy-dm816x-usb.c
+++ b/drivers/phy/ti/phy-dm816x-usb.c
@@ -269,7 +269,6 @@ static struct platform_driver dm816x_usb_phy_driver = {
 
 module_platform_driver(dm816x_usb_phy_driver);
 
-MODULE_ALIAS("platform:dm816x_usb");
 MODULE_AUTHOR("Tony Lindgren <tony@atomide.com>");
 MODULE_DESCRIPTION("dm816x usb phy driver");
 MODULE_LICENSE("GPL v2");
-- 
2.49.1


