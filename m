Return-Path: <linux-kernel+bounces-825778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7E8B8CCDB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 18:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F063A471D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 16:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3E430648E;
	Sat, 20 Sep 2025 16:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJH5cx9o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CA02FD7B3;
	Sat, 20 Sep 2025 16:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758385493; cv=none; b=fsY3xYJGP2+eqF+0AORRFc4434FRC69aRqjxLg4GRKtFz2Cwuf620zslbIBefmb/nCFDNzEySEN9LRE4bKDY40wB59rnVQHA5aHGaYuqpYsBQIWmPfEBu+kDbbvhQWpv4RLa1pWUif9BCPDcxuhLchOQps3Fj6Z1VoWMEHwQYEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758385493; c=relaxed/simple;
	bh=fCvgbj0xU9RJREVTvTFFOFxmYdZe1E50yvmeZHSzE7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A7wJZyTCpvKF5JNtaExZL1yPBWB3WFkNfTvQ9aSJ2d9rkIz+0BXmJoA9BoO7DXYK7NSCz+oXndInig2Fbjuo2dvZyhF7FZi95Dna/ZGDZrI8qdcEFl5qLVbegPNLyqaRly8k0cIzLfVCcuOTwwCnqBnOosgI9nHNlgbnIK1Tyc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJH5cx9o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80F29C4CEFE;
	Sat, 20 Sep 2025 16:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758385493;
	bh=fCvgbj0xU9RJREVTvTFFOFxmYdZe1E50yvmeZHSzE7E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sJH5cx9otbubyxaneivZevHNZ4sZj6eFeSInJoplaAZn3ZFLQV4wT9cGlth18H4oY
	 rH6Fp2JSWiJpxjWLGk2OiEkIUtxwX1QQvF+BhExY5dZNNV7HFQul1H7+mwfeDb/zZ6
	 iyPrLkDfiZNWZ+yOysDPSbPPioIh61jRV63869+btRi+Olh8pKZbjXZqdYL51BpLMQ
	 L8GDioJt9gcFdRxrHF/aPTOkxOO+DILUODuPww7nWJ1QwoUpjrwwsP0wKewznxvuCi
	 anIODcxJezJg8jNmAq0OH3uqn3RJdIAQiHuOwSvQh+25UGLqZDxPjAkW1or3ibJ9yq
	 qcMsLp+qeq26Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797EACAC5A5;
	Sat, 20 Sep 2025 16:24:53 +0000 (UTC)
From: Cristian Cozzolino via B4 Relay <devnull+cristian_ci.protonmail.com@kernel.org>
Date: Sat, 20 Sep 2025 20:23:33 +0200
Subject: [PATCH 08/10] ARM: dts: mediatek: mt6582: add enable-method
 property to cpus
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250920-mt6582-v1-8-b887720f577d@protonmail.com>
References: <20250920-mt6582-v1-0-b887720f577d@protonmail.com>
In-Reply-To: <20250920-mt6582-v1-0-b887720f577d@protonmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@mediatek.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 phone-devel@vger.kernel.org, 
 Cristian Cozzolino <cristian_ci@protonmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758392693; l=648;
 i=cristian_ci@protonmail.com; s=20250620; h=from:subject:message-id;
 bh=1pkXsToukeBtOjKTSGrlOrfz/vD1cenGodZl+YEjRIg=;
 b=z8G1Vkbhc61fkJqS5KiuPXS7HZ+UuQuceW7BHFe45IGZoQV7xXDPyf6dSKwRq66glu1joNL+D
 /ifwN9UQ/65CiUM/A038MER63r8hCTnzshmjl56uPBozEqeSy64GDfc
X-Developer-Key: i=cristian_ci@protonmail.com; a=ed25519;
 pk=xH5IvIPUNHV1Q8R0/pq2CfuVFR/wTiAyuyi6IwedjZY=
X-Endpoint-Received: by B4 Relay for cristian_ci@protonmail.com/20250620
 with auth_id=438
X-Original-From: Cristian Cozzolino <cristian_ci@protonmail.com>
Reply-To: cristian_ci@protonmail.com

From: Cristian Cozzolino <cristian_ci@protonmail.com>

Add missing property for SMP.

Signed-off-by: Cristian Cozzolino <cristian_ci@protonmail.com>
---
 arch/arm/boot/dts/mediatek/mt6582.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/mediatek/mt6582.dtsi b/arch/arm/boot/dts/mediatek/mt6582.dtsi
index 82564c740c2182448f8f88bbc2b22c4fef1fdeef..f941ea44898a9f26d9742f31f4a667adcc77dfc8 100644
--- a/arch/arm/boot/dts/mediatek/mt6582.dtsi
+++ b/arch/arm/boot/dts/mediatek/mt6582.dtsi
@@ -14,6 +14,7 @@ / {
 	cpus {
 		#size-cells = <0>;
 		#address-cells = <1>;
+		enable-method = "mediatek,mt6589-smp";
 
 		cpu@0 {
 			device_type = "cpu";

-- 
2.49.0



