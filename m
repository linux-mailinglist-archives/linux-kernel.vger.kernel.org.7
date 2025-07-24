Return-Path: <linux-kernel+bounces-744607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FECB10F1D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20A61189A20E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048AC2EB5B4;
	Thu, 24 Jul 2025 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POlIE0Bn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622A82EAB91
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753372125; cv=none; b=JRNWwfrIkqkkdReNHa8lzlH93/Vm1VRcTDAc5166LtzDEhSeyhgiCyLGX3ClJSJwE+k/aEFeO7IllcMFGxO8rgR0EGyXRdy19LUDctkMbzJN5SHO0RjgMnsJHawaRTrjxil9OSjiZ4DUu8VLDj4pIddZPtaG2qr0ljYvwvoJeT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753372125; c=relaxed/simple;
	bh=9Q+iZVtWBfA2bYZ+f4emA/nzcDWJtC1QHC9/liytT0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=abFLgTPAM9N0jdiFDoaHd+w3q3Al/9ff3pnsNxN7JOOopsevUXn3k78BEso6iLAsh/oSfc0NDNp8783qYn9lwfIaAwE9cAmp0uUn9D/ApSR+NyGbTsWNC/83mR2xvkvO5zLE3DUdlJMUm83OfEk2KrXipCusJBjj8BCMDji+qCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POlIE0Bn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E97AC19421;
	Thu, 24 Jul 2025 15:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753372125;
	bh=9Q+iZVtWBfA2bYZ+f4emA/nzcDWJtC1QHC9/liytT0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=POlIE0BnBzLsFNGB07J4mjstFnAd6d0LngUzh2BgqCNnXU9L3GcWMcyeFfk2fpknI
	 O+Z7m2DJ1KLj76NJuiBLF+HoEc3twNDtdYoBAY5A3Qy/DrT0qc8geA6vvYCWEYzL0w
	 gtZJLNwXadQNa9p79tZ/WZflFhpBL2l0xGO7E4L8fORJr1Wsw2zvaSla137vy5NhaL
	 Oc2FcxzEy4SdPqFtsu2LWQSaUAMzsbaWLDS7diX4Dhk9lT62wqnea/Lxee7cQoP7f7
	 ZKGDXygbIEQjZOo3Yk/K7bBVEzSjgXzSsYTU9Q363jMaky2yrfPG/el7LlaiiN0FK1
	 BgoHMR7EtA4bg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1ueyBV-000000004BI-02kz;
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
Subject: [PATCH 09/11] phy: ti: ti-pipe3: drop unused module alias
Date: Thu, 24 Jul 2025 17:48:21 +0200
Message-ID: <20250724154823.15998-10-johan@kernel.org>
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

Since commit 918ee0d21ba4 ("usb: phy: omap-usb3: Don't use
omap_get_control_dev()") the driver only supports OF probe so drop the
unused platform module alias.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/phy/ti/phy-ti-pipe3.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/phy/ti/phy-ti-pipe3.c b/drivers/phy/ti/phy-ti-pipe3.c
index ae764d6524c9..b5543b5c674c 100644
--- a/drivers/phy/ti/phy-ti-pipe3.c
+++ b/drivers/phy/ti/phy-ti-pipe3.c
@@ -942,7 +942,6 @@ static struct platform_driver ti_pipe3_driver = {
 
 module_platform_driver(ti_pipe3_driver);
 
-MODULE_ALIAS("platform:ti_pipe3");
 MODULE_AUTHOR("Texas Instruments Inc.");
 MODULE_DESCRIPTION("TI PIPE3 phy driver");
 MODULE_LICENSE("GPL v2");
-- 
2.49.1


