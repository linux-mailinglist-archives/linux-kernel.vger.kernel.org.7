Return-Path: <linux-kernel+bounces-730207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF527B0415A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD54B16429F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FD525A2AA;
	Mon, 14 Jul 2025 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="MDRIbgDo"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AE7257451;
	Mon, 14 Jul 2025 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752502823; cv=none; b=ktGrOs3Lwm2KPBlmF3oHw54kkd4GQ3lqH5UxeX01tz3Uhpcm+RRnhavaBvLtjr0UnfAYXbBBd/xOyXCsLIevkt6SsQcqsiRER7WlTnA27PhgXYYfiPJnvxlx69KnF5MB2x2zmHToY7gLZMBIPl2C5zgq+a8s3RBsgZSJXY4IO1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752502823; c=relaxed/simple;
	bh=KgBKY/iiwodqc2vY6ciYl30jJbKeXIMGAbZR9uWYk4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWerVH64ChM7+KwyqdCdtHnmzrU2xypACg6wXXnzukbFHKjTK3zoBxRjNIAjWIGweICQZGlYGeGBlNjT0HrCWXVsi0EATT2CCHFKFmx8NXHulAmAiJWrXhFr0UsBK7YVFd1kaMTMDJOXUBXJVJHuwXr2urOKlm/Ygu8HRlR4nLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=MDRIbgDo; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 51936C7540;
	Mon, 14 Jul 2025 16:20:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1752502819; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=PqCgdIXnolt8Hj+M/Rl5lA7jVTUYjukkdEEU4Hoad3o=;
	b=MDRIbgDoFShISqNquPaYVdV1sGz4UgwFtQPFjZbRn3ViAmy6hjPXHQqIEha9PwNfx5iOzD
	HMuUUBaxpOOvkLjOP/JErUleE7RqDOOvCr6h46ufMm46/1AM6DM1vfjlcelnsfg+hHMJco
	iJlSePid4D0voOTmmcwZpD+xZgsIPlzQpq7pRtLm5a3BCifunuTBUJmLjVZbjGe5AfI52k
	GNVC18qP2+6mZMB33jsMDKETeLLf+zWU8Fo+Hbp285hcu934XqRMx9h3tISXPE2La0LMJJ
	um3JrBsHlSIQqBMM/4hAZ1SNiMCN6MCuXfCtdRyGZ8WnQjjh0Kj4MKHnrQHHMA==
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
Cc: Oualid Derouiche <oualid.derouiche@kontron.de>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH 04/12] arm64: dts: imx8mm-kontron: Add Sitronix touch controller in DL devicetree
Date: Mon, 14 Jul 2025 16:17:30 +0200
Message-ID: <20250714141852.116455-5-frieder@fris.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250714141852.116455-1-frieder@fris.de>
References: <20250714141852.116455-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Oualid Derouiche <oualid.derouiche@kontron.de>

Some new panels have the Sitronix touch instead of Goodix. Support them
by adding a node for the new controller. The bootloader needs to detect
the correct controller and enable/disable the nodes accordingly.

Signed-off-by: Oualid Derouiche <oualid.derouiche@kontron.de>
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso b/arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso
index 1db27731b581c..5682ea9c5c7f7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso
@@ -117,6 +117,17 @@ touchscreen@5d {
 		reset-gpios = <&gpio3 23 0>;
 		irq-gpios = <&gpio3 22 0>;
 	};
+
+	st1633@55 {
+		compatible = "sitronix,st1633";
+		reg = <0x55>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_touch>;
+		interrupts = <22 8>;
+		interrupt-parent = <&gpio3>;
+		gpios = <&gpio3 22 0>;
+		status = "disabled";
+	};
 };
 
 &lvds {
-- 
2.50.1


