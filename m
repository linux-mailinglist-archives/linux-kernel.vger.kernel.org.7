Return-Path: <linux-kernel+bounces-878239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C665C20167
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 28F8934E8AF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C723354AC7;
	Thu, 30 Oct 2025 12:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="lVflvyhq"
Received: from mx-relay32-hz1.antispameurope.com (mx-relay32-hz1.antispameurope.com [94.100.133.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFB934028F
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.133.208
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761828666; cv=pass; b=kKKfdq2tyl8Gq+nc8Mu1pPj9QvTNgN622Yg9yeh1MToWf7lFMS3OVA7jW3xhiEZwC9obRA2UA/9M0YSZo1Zt16dGyXTR9dzPwqFhQ+Xf/o+8YzDlrJxqCuUguQbxC8JyhTr1N9CX4DmcmrC0JOVuCKR6wVtSB9L3wF+W+aBzVf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761828666; c=relaxed/simple;
	bh=8R70P4kEEcIbFjodXfQBxXqAq+lQZtKZ+MdM85RNf64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnLtQIOgr90RaSo+MrWchnsyOtCQpc0ckAJav3bJnKSfhkZ8iukz+j2u3+uUwkzKgjIzRnZy1VBU+YprKvDTPI74dQnAliClOW8RxRpb5P9yiXkmP13K81P09c1D8s7YXk4XRbjuoP+ewGVy6JpMLWhwdwhKwO38/YWA7b+2hpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=lVflvyhq; arc=pass smtp.client-ip=94.100.133.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate32-hz1.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=orpjfmaMqp/ep6TopDZ6qss0KQr8oMJ5sbynNFItMqc=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1761828619;
 b=RAWKsq/pM29F20MO5Dch37HP8eH9bRtaA0F5W2kGCZ2LPDqaaVNCP9T3mBLgf9pJbmB7zkcr
 G9LmI1rFNjW5PGX+JvYi66X0uEzNsU6rNYrBelZNxPCY/LZxKt0iqNi3jskzwxT2NhxA3PjRfF0
 uF31eNT14YMspXjHz/AniJqaZpO/BDMumWViUwMbl8AkrQnvsn9sWcBnY272Hre4jz6UmxaDIDI
 1TH8at4sIvxR9dnatLRPsCSigWcOnauQVnukUjsHfCTgVX3Ot3jqqJ2Gl2Wsn9Ndk7wTE/Q5oxA
 MJZOqJSglX9A8afsoGdKEzVIbzSPCJL2gSISm23RuCB+g==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1761828619;
 b=pYPt7FAXiYyHnLZVKD3AY2Mju6oQT6p1/tDwy4rETyA/rHj7RZn/428fVaOG1kOUHKB8t0rO
 jpsgyzsS7ifu2K36Rv/6dScXEy+GOVuzNUjmYHxF2kvosoW/3kzAh0mYAOcM9AglxNSDEoW6Bn0
 JAyz5zZEbA2nZsP8/CU0Ir6BPX6K6mbR/LOpnkNIgtrBl8xVySBvCgpOtFzC/7W+tKzzl4A2eqR
 JOqaBV2Y+nwEcphfimNgtfdzM3gYq53ZePdffPy3A6re5/7t19un/hkqQS0cZsuWksCXvGVTTJe
 hjJua4bARf01f3rmT4nlBItGsPI8bsUIqi0Ou6shtlU4Q==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay32-hz1.antispameurope.com;
 Thu, 30 Oct 2025 13:50:19 +0100
Received: from steina-w.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id CFE28220C62;
	Thu, 30 Oct 2025 13:50:02 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/19] arm64: dts: imx95-tqma9596sa: remove superfluous pinmux for flexspi
Date: Thu, 30 Oct 2025 13:49:17 +0100
Message-ID: <20251030124936.1408152-11-alexander.stein@ew.tq-group.com>
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
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay32-hz1.antispameurope.com with 4cy3qH419Jz8stG
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:201a609ca4cd8de84ce042f2b20575b7
X-cloud-security:scantime:1.813
DKIM-Signature: a=rsa-sha256;
 bh=orpjfmaMqp/ep6TopDZ6qss0KQr8oMJ5sbynNFItMqc=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1761828619; v=1;
 b=lVflvyhqCM+ETOxTrU6fZuA6ct7eglLqj1yKwtn4luWYzHLo+m+XP3cFKjufLy+77AB2mFu6
 SajO8x6gV65D6B/syuslxjHaCq/qOWNR6v0Oh1XQ0gvuwWqXb7CiAlRKaXFQlnTazSrW9q54kbE
 uLvW681HER1KwNLbY/OWQkXNO+40mNwhS5ORwFYVK57nfv8eCZd2dYj3Q4lhtyMokkLCQjcUSm0
 pZl6pepKxPFSYQQozW0AhhsUPJwa16GER66AMlA17LxYpGuj/GRkAVjBraVAImtFyZNwQAVUqiY
 ubgBP/vmpbMFOEp8ZmgvxDpJbsh6UR5Drc1xunlNvEotg==

A sleep pin mux is not useful if it is the same as the normal pin mux.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
index 36da8ff8d1835..b7136982700a9 100644
--- a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
@@ -117,9 +117,8 @@ &flexcan3 {
 };
 
 &flexspi1 {
-	pinctrl-names = "default", "sleep";
+	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_flexspi1>;
-	pinctrl-1 = <&pinctrl_flexspi1>;
 	status = "okay";
 
 	flash0: flash@0 {
-- 
2.43.0


