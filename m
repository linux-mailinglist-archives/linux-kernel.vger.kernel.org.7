Return-Path: <linux-kernel+bounces-878237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E697DC20161
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE0054075EA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A59434217C;
	Thu, 30 Oct 2025 12:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="QyjeVmB5"
Received: from mx-relay50-hz3.antispameurope.com (mx-relay50-hz3.antispameurope.com [94.100.134.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4700554918
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.134.239
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761828621; cv=pass; b=SWI3e6AsvSnEjalat49VQrqiarpZHXMeLfKgYq/fdy5MQzwcnnD/Lv01gSXX71SFCrzUxWB7qBUCyjFjiOsNbTOxT5lwbOcwTju2dWWK1/JHCofr8jGeXhq+mfKqQNvKFQNQM/NsFpQgBtEwFamZ3r7jKF+z0wmPOnqVZCXeehk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761828621; c=relaxed/simple;
	bh=gsntOPMD2rPmRjXq5D6VPWvyhyUwrWd5WBIPPuLLrjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7pUhK08KhglBKnKwbFT0HVvtCqH+Yx+fQS+HmVPLAlm/IuQVy2del4ROjGPP+tRuxZ/sN2j5/ZJjyh6PsRIFkTGL4uJ1xTrNRnmf93i0akhmfCIvZOIidX6KkHKJ4DJiSGBdfjieqIT0Z22hu89UwTh/aYk6id2LO3UwBUN4XM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=QyjeVmB5; arc=pass smtp.client-ip=94.100.134.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate50-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=k7CHMivira0x/FyH+Ow1E9d8fqnubbrxUxidvJeHW7o=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1761828609;
 b=rPxHHd86xb7oNJ/GZ/mQ9wNig8zttIYWf7zzkHCDlXrPB88WwbM+PblllGytSHwKvp13tw2N
 jMVhqeNq0j54Z0h10HYMiI2aTGsdPLw0oRtyaRdASNgHuQtSVOh++abg3V6E3TcApVyvOH0FfNy
 oPAq6XDExL01/roiD2q7F57cI3Nhnq1cpl9d2GcOTVUTS+rLNP99p0punCt/Fb0D6pokW303OoW
 NcDNchhQsDI4qCNQ5eAIyafb4aaQs8cONUmgzRP18Cq+Zdgfdhx8joSBqv8n2WVlxxxlrQk/sQu
 8MORjwbqUD65mJdtgL8f0E+cpR8cI/VSxGvJWLBVHSivQ==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1761828609;
 b=jyRFV6VlcAmmKvjfyRNfkrtQ2JYhOuSetV0hWJBxkYTSNc9j7A9pqZGphL8Qv5cgALRcXya3
 0LNYISdqujzSYGtyrEyeiDR2MT893gOxQtynhyJ2Md9q011Ty5WSpfn1n3F/Yp9khE+xwDNeodm
 6rmh0eCiDv38mpjT/rkSRS6AeM8pf/jMeJIE0s2S/J5mBcnTp8enA1HvY4GJgGdHzDI4G0DBGI6
 NWjTihkUqSetnvAJwn3aZpM87VcTvHa7y+RkBdxrj3CwGN8ZqizDiMzfUws0gZbxqgygYW4OJ+c
 FGFo4Q+qB64bRgSq8LE4DME/BjnIPt3f1YdK0r7bRZUdQ==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay50-hz3.antispameurope.com;
 Thu, 30 Oct 2025 13:50:09 +0100
Received: from steina-w.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 6035B220CC1;
	Thu, 30 Oct 2025 13:49:51 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/19] arm64: dts: imx95-tqma9596sa: fix TPM5 pinctrl node name
Date: Thu, 30 Oct 2025 13:49:08 +0100
Message-ID: <20251030124936.1408152-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030124936.1408152-1-alexander.stein@ew.tq-group.com>
References: <20251030124936.1408152-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:alexander.stein@ew.tq-group.com
X-cloud-security-recipient:linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: alexander.stein@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay50-hz3.antispameurope.com with 4cy3q40Wp6z2nHFG
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:c734b9e42def97ec10e90bed4c62542d
X-cloud-security:scantime:1.998
DKIM-Signature: a=rsa-sha256;
 bh=k7CHMivira0x/FyH+Ow1E9d8fqnubbrxUxidvJeHW7o=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1761828608; v=1;
 b=QyjeVmB5sKNt74gSfFYgYowXmP7826ZGrT6C++T6qhEyYBZTQk9a2fapW2B+xq4YdQNuhw3G
 MXWcG7gC0hYYTYCTtDhBcNbbRGZUVBR+8EqnHoQ9L9gKec90aGEiTfQKeQNiO0M9wi+o8QS8VeU
 MaYeEMR4SjSkAI6XyHuHxr27LtRRwz+sE/4duIWHnhR5FeMjL4GDPlKAxjEfEqWDeSgANpS9iGz
 7C8mZ7yT6KFBMBMVB2+x9NnBUrIu6JZEjtnqGYKUAfFgjVCc44QlfMTzp5/GpBQoOrdQufe56kA
 vjx0UITCFrC8pnKcANyrbDDK1SXM4Ikk/cehpKSXx3gfw==

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

tpm4grp will be overwritten. Fix node name

Fixes: d2c4d71b6cde ("arm64: dt: imx95: Add TQMa95xxSA")
Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
index 180124cc5bce1..c3bb61ea67961 100644
--- a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
@@ -617,7 +617,7 @@ pinctrl_tpm4: tpm4grp {
 		fsl,pins = <IMX95_PAD_GPIO_IO05__TPM4_CH0			0x51e>;
 	};
 
-	pinctrl_tpm5: tpm4grp {
+	pinctrl_tpm5: tpm5grp {
 		fsl,pins = <IMX95_PAD_GPIO_IO06__TPM5_CH0			0x51e>;
 	};
 
-- 
2.43.0


