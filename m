Return-Path: <linux-kernel+bounces-846633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB2CBC89BA
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 12:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2BB5A35201B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 10:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35EB2DFA3B;
	Thu,  9 Oct 2025 10:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2PyAJ3/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50DB2DE6F7;
	Thu,  9 Oct 2025 10:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760007261; cv=none; b=XXQuvrTK/poLNgPocM1khlfiAi7/xKwAbyHcHTdF1WVADjRz4QXqvQqnGp+yMPso6DNNsg33kwEEWivU2+X8beoGieKeXZ0EIBmb832tEwX7Bez9Pso6vq4/f+JEG0NflMzShZ0theo8eS9rTxasLK0HpeVxA8v96Z3p4vAjhzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760007261; c=relaxed/simple;
	bh=WJGC3xsX+N06n8UEa1fPxLlGi8484pc+qISN079PghU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jeBktW1zOb0VkAwlBJMWEf96D3GXEPfFMAO76An2sPV0vTpKkW9dr52or11CxLituptuDFeLsAavv0Mo/ra61AMgIB6I/4pSW2xVWibGGFq21r6EHwBmrgz0X2RNoBnXuhv0+0JQhMCN54lattO6zkjpKPuA10BZ7TgCdIZCXRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2PyAJ3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 912EAC4CEF9;
	Thu,  9 Oct 2025 10:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760007260;
	bh=WJGC3xsX+N06n8UEa1fPxLlGi8484pc+qISN079PghU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=N2PyAJ3/JjTkmUQhAP2yeKClFUn50o5SsrRw5rgaLTl3tyy/L86hN/jHSSWzPG5OF
	 YJSiInIFHsCEAlf+FdrYr+8cukCLzF14KAE95+qPgZ9LrkIelRhmMvOEY+I+nS73xl
	 LFXgpGoLz2l4FgmDmBgS2h60M8/Z37bz37Uh9oTYDyl+PvNUzKyBdexp2fK8KOrdx4
	 6r9O46XBYo884SBZMmqLz+eCL8v1yBiNqrwtVaEaWjIfOEg0cO9OiPCR/fo/cRnQab
	 G6/e2JHJOocTIF5lOeFQ5IsmRNssYKCBy61sVbhQHgbNb1hOzG5Fo0/CLKXddfvz8G
	 JE3ai31qc6RQQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8078ACCD187;
	Thu,  9 Oct 2025 10:54:20 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Thu, 09 Oct 2025 12:54:17 +0200
Subject: [PATCH 1/5] dt-bindings: arm: fsl: Add GOcontroll Moduline IV/Mini
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-mini_iv-v1-1-f3889c492457@gocontroll.com>
References: <20251009-mini_iv-v1-0-f3889c492457@gocontroll.com>
In-Reply-To: <20251009-mini_iv-v1-0-f3889c492457@gocontroll.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Maud Spierings <maudspierings@gocontroll.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760007259; l=1035;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=YdrnHfiDG3B0bwOljviUk0FaT/LUxjf/C85CSrfJE3s=;
 b=p6e/cI8s74gDArLUc9ZfZeMa2Z13mKMWv5y8MtX41NjmGh7J/JuTcLDgUI/X9PFKvIlKB8Y2n
 kvvhw9jZ+qDBkEt8tsFZ+NIOICP9simjsWcYWrIqM4lQEh2Ltvbc0Lx
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

Document the compatible strings for the Moduline IV and Mini.

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
2.51.0



