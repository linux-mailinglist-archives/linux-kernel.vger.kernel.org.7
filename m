Return-Path: <linux-kernel+bounces-721567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E33E2AFCB02
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98622560E06
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987172DCF4F;
	Tue,  8 Jul 2025 12:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="kDD3+HrY"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1042C17A8;
	Tue,  8 Jul 2025 12:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751979169; cv=none; b=RjEKlgsXXlXISluUsNxdwbBYBtSQ1r6wqz4b/wUJJPwhQkTrHaiSvdvuRgyyfNp6XeOMMA0jtbXDmsYu3I9ubE1rSoLgkRkqi156xO8OLzYrO5mC6UV4xI7BfujXfInBCwIJNBfVgqeKYQ7mC0sLq2K1K1wy8oEIVzninKdINl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751979169; c=relaxed/simple;
	bh=CiA1jrG9LwkeJYSaa/v+CECdJD+KXsEAYeCH/S3jCC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyKttRWKEve3oBO8oxLMplfalSN5w5/sTmM10QIr15kKF/Ljt0fB91qWjUJ9Ax1gpBA82Hfvdc3JVi3kIeHYHsLiXXBuR7fLP3X497ZUSGby6VhKWiFtpY8cSIbzfk7mobLbbeQOStclIs3LwS7yJspfFHTezmcO48JqNkMbM60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=kDD3+HrY; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C329BC74CA;
	Tue,  8 Jul 2025 14:52:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1751979165; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=ROBugoCgtg8KTg0qSPqwqigBv5vvES5FsJmkjJRkVMo=;
	b=kDD3+HrYHWGZygMBWqUAUb6qKiNytx5CbulCNjt99ED3r+vQShaIoYR7r6g5sa9gPdTVwX
	sN0HMeT3xmK4MK1yDErxen7E3QRFo4FxrbOY0wn7iBu0eCaLI5qKfJnKjnrZDT3Z5qa+M6
	zgv51ymH+LJ+WIEpKOczqzpA7vCmJ+YfLRyYaymirjvzdLz+3byj4S2Wb9DRVmo7b+ssUf
	5kZee/N6ReqHjXriOaDIQHZJ3uFC6wtm7v3+/7Y3u7PwGWOUdCSDmsLrCiv81IsS17ePAl
	2VBX5n8+FUmtGmvzx1FX2GzItTgfLfkd4Rs3DDgiv4W4yiQSdgjHf5k5p950lA==
From: Frieder Schrempf <frieder@fris.de>
To: linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Eberhard Stoll <eberhard.stoll@kontron.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH 2/2] ARM: dts: imx6ul-kontron-sl-common: Fix QSPI NAND node name
Date: Tue,  8 Jul 2025 14:52:17 +0200
Message-ID: <20250708125219.63813-2-frieder@fris.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708125219.63813-1-frieder@fris.de>
References: <20250708125219.63813-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Rename QSPI NAND node to 'flash@0' in order to fix the following
dt-schema warning:

spi-flash@0 (spi-nand): $nodename:0: 'spi-flash@0' does not match '^(flash|.*sram|nand)(@.*)?$'

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/arm/boot/dts/nxp/imx/imx6ul-kontron-sl-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-sl-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-sl-common.dtsi
index ab149c40a9cc1..793c95d44c7d0 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-sl-common.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-sl-common.dtsi
@@ -82,7 +82,7 @@ &qspi {
 	pinctrl-0 = <&pinctrl_qspi>;
 	status = "okay";
 
-	spi-flash@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-nand";
-- 
2.50.0


