Return-Path: <linux-kernel+bounces-811129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B570AB524C1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 01:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73635461818
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 23:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A5030E0D4;
	Wed, 10 Sep 2025 23:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJOzZAzO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797D6199931;
	Wed, 10 Sep 2025 23:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757547555; cv=none; b=WdbNnKXU1pXNkS5a/FgBkJJUMq/J7c9hEuzGQTRfa4DITTi9b7ShsFkllPXDld/5WJ43VAufbwRjyES6On6rFbHGtXtaHTKVxGbNycHJuHXeeuS+ZVqJpKZJs9bOXsAVqchU1C3ozWvC2aQBdGkFuZf6d4o6oWPTzia3+UeWHyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757547555; c=relaxed/simple;
	bh=oThnhjwHOCRp+Pu8CYFW0dQq+PXlgMWB686UxQw7yiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OB1az3FhlkzNCmyHcYVn4I7Ty753h6oUnVnJzwd7UA+fRXpBlIHNnzG+4Rt63spLdnngCwa2oJcquTwx5rVKOZKzHCs5ZaolMiXmP/+gmHM4MAaEeAPFJW4gXAV3wlRcQAwip4iibpviLo0ZTSsWqvuzCS1zFjgrmGTTrlcQ2F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJOzZAzO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2EFC4CEEB;
	Wed, 10 Sep 2025 23:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757547554;
	bh=oThnhjwHOCRp+Pu8CYFW0dQq+PXlgMWB686UxQw7yiE=;
	h=From:To:Cc:Subject:Date:From;
	b=kJOzZAzOFl6orh8RdBkKXLCmaP9bF0y65JlF+R5NAQbn+gJh+0xFO1CV6UM6v/b/z
	 62DrC2q/asOfJMPLA2AHVENID0Xj0gH3JjmtHelwh6f8yCJ+4TclVEgTNsQipgNCxP
	 iQ8b0Q/VAuIzrYxhf9cNdjFTlssX1zRIMb4RmIOZEcmawrrIpJvDXwghlJDSHdfyuj
	 ZXPXA6PzFfmaUVym2vjDkBbH+GATgjn6mvDIDLtvV5Bq8JJz8Zunf73q4cJtiOTPpE
	 eKSlpha903l3v3k3aZslw+9+J0soOTzVRFRwvMFmt3qnGHu/aL/pHSzrGnZs09FGS9
	 x1gc5TtGjI1Jw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: soc@kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: socionext: Drop "linux,spdif-dit" port node unit-address
Date: Wed, 10 Sep 2025 18:37:40 -0500
Message-ID: <20250910233740.777077-2-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A single graph port node without an address (i.e. "reg") should not have
a unit-address, drop it from the "linux,spdif-dit" port node.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
Arnd, Please apply directly.

 arch/arm/boot/dts/socionext/uniphier-pxs2-vodka.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/socionext/uniphier-pxs2-vodka.dts b/arch/arm/boot/dts/socionext/uniphier-pxs2-vodka.dts
index 7e08a459f7d8..ab910e1b5e6a 100644
--- a/arch/arm/boot/dts/socionext/uniphier-pxs2-vodka.dts
+++ b/arch/arm/boot/dts/socionext/uniphier-pxs2-vodka.dts
@@ -43,7 +43,7 @@ spdif-out {
 		compatible = "linux,spdif-dit";
 		#sound-dai-cells = <0>;
 
-		port@0 {
+		port {
 			spdif_tx: endpoint {
 				remote-endpoint = <&spdif_hiecout1>;
 			};
@@ -54,7 +54,7 @@ comp-spdif-out {
 		compatible = "linux,spdif-dit";
 		#sound-dai-cells = <0>;
 
-		port@0 {
+		port {
 			comp_spdif_tx: endpoint {
 				remote-endpoint = <&comp_spdif_hiecout1>;
 			};
-- 
2.51.0


