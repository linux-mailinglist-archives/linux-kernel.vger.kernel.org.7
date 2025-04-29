Return-Path: <linux-kernel+bounces-624919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82724AA099B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 13:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EDE5841AD3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 11:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7E32C1E3E;
	Tue, 29 Apr 2025 11:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="eRiVfhHs"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA69E2C17A5;
	Tue, 29 Apr 2025 11:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745926300; cv=none; b=OPbI0tmwtA0RjzO5P0ANzfWiDlqQk5wIoYEWo+pYYsIoUYd4d7kQL0+XbffXY9q+OtLlk9WbRzfT6EOpBRtE2TcoY9QE68wNb4tj0Qu0qCTivG4KCJ/DtSVB/5UxEpezUPMkLpO98jpdlgA9urBkMk24nJDS0yisn0JHmexUmjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745926300; c=relaxed/simple;
	bh=FC4RyjuUdRs/wygmUCQvl5aBB2J8vSf6dxzZN78EcNY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b5XXbk8qgzJ7yqt0FkTeH3+CiJMw2i0o6NLNFhDOT47eSIZaPeAdrnj6pDVO+aovMxBpOLN39OCZnbeUT3p3nymOU3XGPXFQUVXr84cyV8D6Ooh79ROgnJXQMID/cScdwVPnjckYugs5hTeAd36GMmNJB1r0JrzjVjMGx7I8jx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=eRiVfhHs; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 9F8ED1F9F1;
	Tue, 29 Apr 2025 13:31:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1745926291;
	bh=XBbGVyieOghmZLlg7Pw4NSfP9F5vBz10sBznCLal1ig=; h=From:To:Subject;
	b=eRiVfhHs2QSe53VlR58VXQG0In7uHtNC4kvqKmMYJJoFycv/mOzcXiXtJ7PzPPPER
	 /CCXNlpTWsrs/B4eIUvTJvc0Of43IR99watzPwa9WgocXjueMpDELcVeyA/7EHT9rQ
	 CmL6aadE0tdQAEynNUIERY5N4GptwZKzjCNkTKouxnzbmLpJ3I0R+Xg1+/bylelg8n
	 cNacLatDRla5aGSABTPW9VDOClPGEt9ZSSTWaihEpOEPPBb7+g7aYBtaRE/CTcf8rB
	 ZsGLyf/sI5CTDHsLZD3t+OyG2gTT7nMFUrRpBIR+P8SdX0nHNlnmycR6mK8lIjzpDA
	 1HafBEpafOMww==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/4] arm64: defconfig: Add Toradex Embedded Controller config
Date: Tue, 29 Apr 2025 13:31:19 +0200
Message-Id: <20250429113119.124427-5-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429113119.124427-1-francesco@dolcini.it>
References: <20250429113119.124427-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Enable config for Toradex SMARC Embedded Controller, this is required
for proper reset and power-off functionalities on Toradex SMARC iMX8M
Plus.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a92c4122a8b9..d4f1230250fa 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -680,6 +680,7 @@ CONFIG_GPIO_SL28CPLD=m
 CONFIG_GPIO_AGGREGATOR=m
 CONFIG_POWER_RESET_MSM=y
 CONFIG_POWER_RESET_QCOM_PON=m
+CONFIG_POWER_RESET_TORADEX_EC=m
 CONFIG_POWER_RESET_XGENE=y
 CONFIG_POWER_RESET_SYSCON=y
 CONFIG_POWER_RESET_SYSCON_POWEROFF=y
-- 
2.39.5


