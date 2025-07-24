Return-Path: <linux-kernel+bounces-744602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B755BB10F1A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F3497BBF1D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970A92EACF5;
	Thu, 24 Jul 2025 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpRX8Mit"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F226B2EA486
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753372125; cv=none; b=XJxBt4GQUFxb5haQA1OOFZx539jDL6rwWNcPUGI2vPztPYIJA9pJYtIYZOdWbNoqaEZsCZPpF42wDPQrDP5glBMCpjnby6peFt/ay61/NPQw/b52Ex/c3qW68n/ymP4Hc8rfD6VhFS4waRbv8n52MylcTQOXlXsTB63gFegrO+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753372125; c=relaxed/simple;
	bh=xwKOnbt7YW5Ir1KO5Nxt6zrjbbfYH8EjC1wgMuKrnEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dO7BQqW6aCFF2odeVGI8HLzNpAOSjoyR7velY96MZje83VUJkkngeREZ9+/zyCXIRGz9zfTFZiNeLREiaYqoN8x8OeRkmSKMC97C8xtR3ZA7GqAT73BZOzoOT6IVADqk9ElUNkD48BQcStLtbIuNfrZdy6HNBInh9orfZE8sP+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpRX8Mit; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8508C4CEF1;
	Thu, 24 Jul 2025 15:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753372124;
	bh=xwKOnbt7YW5Ir1KO5Nxt6zrjbbfYH8EjC1wgMuKrnEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GpRX8MitHGQbUMZk+cP0r0NT/wyzfWHHwiprW+wM0aMYwGLxeefP7P8CgT8zj0COp
	 p2k3PLQSVxbJA5AGaTLowmv/fn7Odea1YbZUrLb7t+HjcTGsQk7mF72rfKdcHiznXc
	 OZGOLTR3/u/qasipnYSILLULjVNqdtth0Xez9Y2Kaz1REHF8DzdGwiX9A5y1MhfXjj
	 6bPSSL7PBbd7HeFMP/UGcogYheWmOY67+R4Cz5q8TL1mqGWrAdgwUYWMSzNBKD9D0f
	 RdZVDuHmGt9q+4waedmON2GaYT/28e6qHj/pS8UmeTZ0FMpo7QTVNIAALH3bhXgY4e
	 YLIXP2egXX3Wg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1ueyBU-000000004B0-20kB;
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
Subject: [PATCH 03/11] phy: cadence: Sierra: drop unused module alias
Date: Thu, 24 Jul 2025 17:48:15 +0200
Message-ID: <20250724154823.15998-4-johan@kernel.org>
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
 drivers/phy/cadence/phy-cadence-sierra.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 45a5c00843bf..424a9ebd0d39 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -2739,7 +2739,6 @@ static struct platform_driver cdns_sierra_driver = {
 };
 module_platform_driver(cdns_sierra_driver);
 
-MODULE_ALIAS("platform:cdns_sierra");
 MODULE_AUTHOR("Cadence Design Systems");
 MODULE_DESCRIPTION("CDNS sierra phy driver");
 MODULE_LICENSE("GPL v2");
-- 
2.49.1


