Return-Path: <linux-kernel+bounces-877612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17774C1E955
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD803B461D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3CA32D0EE;
	Thu, 30 Oct 2025 06:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/5ZLdAl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429612F7ADD;
	Thu, 30 Oct 2025 06:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761806142; cv=none; b=Rjw8L1sc0Be4osoxvHOnOAhiBGjEs2eRcFe3Iu/USIhWOMCm5RRFFsIOr+qzQ/D5lagQkdHsc7f5KA/oOzUuYTysC5+o5L8EidjdTnb5slWIZR8fbT1aPdpB49weZtUK4RBflrUUn4QmS2NDcrRB7cD97jLTgkU9GtKTMk6KCRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761806142; c=relaxed/simple;
	bh=MRjyLFhNnmEThxQJhty+Y9T1BGODxHrx6VqoEsVDfyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K7zKUekavyGehMnwGH01OrUVll6HQYDZViNkucGzIWnKIEDkKer7pL41B308bYFKwK0C9iTu596gMMhgkdlo25jx4RstUUPfh3ILItqaeupUhNCt9Y7irIfB37c5pcPD7sjY/t0ZNsyGiZOX9JHWvmQuJwWhgCMguRQ0Kx1A1TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/5ZLdAl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9D88C4CEFF;
	Thu, 30 Oct 2025 06:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761806141;
	bh=MRjyLFhNnmEThxQJhty+Y9T1BGODxHrx6VqoEsVDfyc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=X/5ZLdAlSi/9aROkQFC9207CW5LMM90r2nxtIML00dXbp2AvrAxNXb33rDOAG7qdf
	 fDVPs9ZrbKl+AFOXwB2OS0It+8Ia/2OcZng01hRPkH4KrVBuczY5NAMwg3L95YnHoe
	 LrvpaXKH9zkax67A1Jcv6raJSypu4kviFuMmjS2J4dCvNcmfhFw/+hFG//c9Lzb7Lk
	 IwWji7ssZ9nPPwJ6meH8+ndugP/TWO+2awxt9JdHQvjKmPvoO4zpy6sAMyhyrJLUfG
	 UjmQNEgfFqyybAxeD/bPU5VT5POnx8JFLcCsUGXkBMAs8cP5AB3zgR03uKQZ7CLht4
	 S0jcOdb+QNp4A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0C7CCF9F8;
	Thu, 30 Oct 2025 06:35:41 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Thu, 30 Oct 2025 07:35:37 +0100
Subject: [PATCH v3 1/6] dt-bindings: arm: fsl: Add GOcontroll Moduline
 IV/Mini
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-mini_iv-v3-1-ef56c4d9f219@gocontroll.com>
References: <20251030-mini_iv-v3-0-ef56c4d9f219@gocontroll.com>
In-Reply-To: <20251030-mini_iv-v3-0-ef56c4d9f219@gocontroll.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Maud Spierings <maudspierings@gocontroll.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761806140; l=1113;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=tfRcDJr6DCYSghqJPzeKfdQ0Q36PL56RBp+svwUFt0w=;
 b=Yps2XiXddeMSZx2xMsLbImHLDdANDBLh9a3Cl+dJi6cKPgjGoVdbMepP+uba8tcXTxoRy0YLj
 J8fm8gjsy0LBM2hZgq+hi5/VAghkvDbiAeg5sAc26b9UlSF0jtT8/41
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

Document the compatible strings for the Moduline IV and Mini.
Also add a compatible for the Ka-Ro Electronics TX8M-1610

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 00cdf490b0620..15000923b648a 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -996,6 +996,14 @@ properties:
           - const: engicam,icore-mx8mm             # i.MX8MM Engicam i.Core MX8M Mini SoM
           - const: fsl,imx8mm
 
+      - description: Ka-Ro Electronics TX8M-1610 based boards
+        items:
+          - enum:
+              - gocontroll,moduline-iv-306-d
+              - gocontroll,moduline-mini-111
+          - const: karo,imx8mm-tx8m-1610
+          - const: fsl,imx8mm
+
       - description: Kontron BL i.MX8MM (N801X S) Board
         items:
           - const: kontron,imx8mm-bl

-- 
2.51.2



