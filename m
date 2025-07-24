Return-Path: <linux-kernel+bounces-744608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0DAB10F1F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32FCF7AE434
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7962EA482;
	Thu, 24 Jul 2025 15:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AD2GMLMX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630182EAB92
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753372125; cv=none; b=h6JstZMHfrRljxm+T6ojry2isrxwGZ697A6Wu6xoRAHuZ94HfjeZHgIrdNnJuf0JQAsIv/FVhXoh5hQYvAyUmNq2ZjC80sxh65pfS2sfhVp30ISmzD6hreqjKwSEb4HfiPGCE8hctiCfVzVYROD6gb4I+QVjyeNY10fL7rpbMNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753372125; c=relaxed/simple;
	bh=lH1XSXqQUGAtq8HOW5s68WiNc/pAyr9wB95TqUTEN/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bCi4cr3WmldU4g8ABgjK2JAkalCGBXn17MJvkR8NHSlxrbQnyLRZsghpyF4nQwhGa19A3olKIx9sTb95dQ7qYXvJcEeCGWLjBgga3S2ViA3qo0M4ixzJ2LRhFShHtW4g2faaJmc/vF4OYbicBr8RoNqQHjvCy9tu1uwijWYLkz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AD2GMLMX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86C2C4CEF9;
	Thu, 24 Jul 2025 15:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753372124;
	bh=lH1XSXqQUGAtq8HOW5s68WiNc/pAyr9wB95TqUTEN/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AD2GMLMX6lnHDFEIAFLLklPm6wbgXcxaPLx/FrFtHAG4+0aJYPPeWANfhiThSbLVx
	 pZWbfFfmt+8mxuWHg3TAphxKkw6PQBjJysJB2xKTvbOv1/LIN7K+e5X4Ip9QcASAM/
	 3/8rUh83+qjT6DZ9k+zFn8xziRyxVJBm0hkh5i4rgvzd9WwOeVPYfWUu1Kp9MLjm44
	 iIYmrzIFkCdJ262p4BQvGpdSox0V/8yDaZdLjdX1+BHODxmNgNcylHdR8I09kVuJaL
	 qwkk6IrahFbeLXn1H58No7AKi+P1VI3r2RC5LDsArzFiQ9P0JK1/EujFj7ePSNeGRU
	 Gddh+HhYragLw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1ueyBU-000000004B6-2gxo;
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
Subject: [PATCH 05/11] phy: qualcomm: ipq806x-usb: drop unused module alias
Date: Thu, 24 Jul 2025 17:48:17 +0200
Message-ID: <20250724154823.15998-6-johan@kernel.org>
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
 drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c b/drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c
index 06392ed7c91b..f22c0000479f 100644
--- a/drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c
@@ -559,7 +559,6 @@ static struct platform_driver qcom_ipq806x_usb_phy_driver = {
 
 module_platform_driver(qcom_ipq806x_usb_phy_driver);
 
-MODULE_ALIAS("platform:phy-qcom-ipq806x-usb");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Andy Gross <agross@codeaurora.org>");
 MODULE_AUTHOR("Ivan T. Ivanov <iivanov@mm-sol.com>");
-- 
2.49.1


