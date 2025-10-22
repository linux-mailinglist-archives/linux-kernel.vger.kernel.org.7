Return-Path: <linux-kernel+bounces-864320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB1DBFA849
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 095F4402F0E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22ADB2F7AA7;
	Wed, 22 Oct 2025 07:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHNTd8Dn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529AD2F60CD;
	Wed, 22 Oct 2025 07:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761117765; cv=none; b=Pfzkg1K88Fgh/coDjl5UVFjqQgHNrw4kylZie2CQC8Ey5eI/Y5edKUJYwo4rkac1nhc6B16zOzNLadnf5HhzjweXakwRWfSDEgLrp55S+WMQa7s6n+Qf/Dro1zdnpTf6rOZmoYuPxh8w8GrKa/rSUBeTLxE3jsyqPnAg1KT56q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761117765; c=relaxed/simple;
	bh=E8/kihkhTiu168XMirf3dOLHmK8izSyrje/VlWah0zs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j6VA5piV5em5Kkb2rfXR759PSE+5la19gAEdQ7Q6TTFofRVGsaq1QrB2w/sZtEaQXYy1T5MrYlONTUfi20cQpVcYWB0AHThw7Otj8FXXCOKtAPJmaNEOWrzsivDVBgb9myNjC4mQFgp/3JKpYMdVe+2uwcaktyhMgwrn8iNKtBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHNTd8Dn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB065C4CEF5;
	Wed, 22 Oct 2025 07:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761117765;
	bh=E8/kihkhTiu168XMirf3dOLHmK8izSyrje/VlWah0zs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=vHNTd8Dnh6AOFAzLShHOGLutF/C2YYTJyRKnwdMBT1CQKASjadSocrqA/5aUmfQ5s
	 jjQeTaiktHe7E87KeUAQ2MNzPtsDnGmn1WavFG5M1x6xlh9eTJ7KgZgjc+HuS3QhZq
	 DxiyVdcprdUc/xCUg92Q1rApL2rTM1buGoyGzqwijJaHHiCFQe5tPG1687Iq58DyRs
	 SBvLU26pV2HDKM3qiNLTNWjzRYEXpZmaYk9+ff+vCpTBeGHd4reXq8MbzwrB3kIoaF
	 XXg49JKhRrGBlqKbsV8DJCKqpD0VTt00++xAIDPUxM3Z7LQHNq1tUsuH93AE0CndD8
	 cRqI9sf36q4nw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBCBCCD1AB;
	Wed, 22 Oct 2025 07:22:44 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Wed, 22 Oct 2025 09:22:37 +0200
Subject: [PATCH v2 1/5] dt-bindings: arm: fsl: Add GOcontroll Moduline
 IV/Mini
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-mini_iv-v2-1-20af8f9aac14@gocontroll.com>
References: <20251022-mini_iv-v2-0-20af8f9aac14@gocontroll.com>
In-Reply-To: <20251022-mini_iv-v2-0-20af8f9aac14@gocontroll.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Maud Spierings <maudspierings@gocontroll.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761117763; l=1088;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=xk1QHN6fEYu7dupAJB/GRXJerfPV6Gc/qAkprGWhb0I=;
 b=DF9KIyEso7Uhu/qgM5d8/mlZde9Vl+UPpGZJREQwlvEpGDdmgps97PtJZm0tPpZFYXmO9GqIe
 RarkcCwKj3jDYPSfSneQdEwvbojtCS+jh1Wogpfc2P/OgXKc0WDSY5t
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

Document the compatible strings for the Moduline IV and Mini.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 00cdf490b0620..41eb19e3530da 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -963,6 +963,8 @@ properties:
               - fsl,imx8mm-evkb           # i.MX8MM EVKB Board
               - gateworks,imx8mm-gw75xx-0x # i.MX8MM Gateworks Board
               - gateworks,imx8mm-gw7904
+              - gocontroll,moduline-iv
+              - gocontroll,moduline-mini
               - gw,imx8mm-gw71xx-0x       # i.MX8MM Gateworks Development Kit
               - gw,imx8mm-gw72xx-0x       # i.MX8MM Gateworks Development Kit
               - gw,imx8mm-gw73xx-0x       # i.MX8MM Gateworks Development Kit

-- 
2.51.1



