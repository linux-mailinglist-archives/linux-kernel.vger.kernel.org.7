Return-Path: <linux-kernel+bounces-834530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBB3BA4E0A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB17328067
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE59F30DEB5;
	Fri, 26 Sep 2025 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8RvxJGN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4B52F60CC;
	Fri, 26 Sep 2025 18:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758910789; cv=none; b=FtQzqfO9L7gDbkEyjKsrjEsaoIaeHBnPFP8N1uWhbpXaw4IqCY+OuIJScgFgcCoX4IGylSwHmK0324AI6BF1CeVM6ApYRKnrjKfs8uYbNfL20huKNKlTq/pj26OLcGxYsRv6obn2hq+p1+lr75dZWZgHzyO35xVGIdx0WpuTpbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758910789; c=relaxed/simple;
	bh=lYVqTM5HGwA9Xf9f5r70Ei4he25vltCACwgM1SXxA1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CGmPmvcwjqmd98ZtCnjlfacNgjqGdEMMfMZvNcaoudl9BwklAJV5QwcM6A8+e8wh4lCogJ1X2GI57WgZCm17RTNOLl3Y3bRCkrNe3XxWOSG2RhmQDHgMbu+XZrA4J8CoGPVomxxow2eh929QO7bOGTutRisW0xxioCP9jFcAyh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8RvxJGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F05DC4CEF7;
	Fri, 26 Sep 2025 18:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758910788;
	bh=lYVqTM5HGwA9Xf9f5r70Ei4he25vltCACwgM1SXxA1Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=D8RvxJGN2EJb8fp2WswI1IxOP/pZOwR9SpLXITBjUXoKPP0zF7zYV7w/EFCmj09P7
	 SQo6pIc6LRr7CVALcT2z9Wzp6XC17QPLKSQoTdfPeHnPXhx7wtu81Lck0p2H1AwoKF
	 bDeE/ho2zKA4IyvMvLwgIuKeBG5CnpgCpQGOcHPPQuiFZ1PyOWWgUyfd2BPi5Q6iJe
	 aHJe7bon7UjqbdCNcM8vH0V6jTZGWjbbqtHGz0sBOzmJq/7vk4hlZcpowEPTQEl93O
	 ukg9iyFr0pEUQs1m/hKVC1iWpjZFLj3RXpKsIG0d5hJcSJQhsZMGDjVxiNFMjMhCXZ
	 8ujOt5mgX6rxA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C188CAC5BE;
	Fri, 26 Sep 2025 18:19:48 +0000 (UTC)
From: Frank Li via B4 Relay <devnull+Frank.Li.nxp.com@kernel.org>
Date: Fri, 26 Sep 2025 14:19:42 -0400
Subject: [PATCH v4 3/4] usb: dwc3: dwc3-generic-plat: Add layerscape dwc3
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-ls_dma_coherence-v4-3-21e9c6bdb5cb@nxp.com>
References: <20250926-ls_dma_coherence-v4-0-21e9c6bdb5cb@nxp.com>
In-Reply-To: <20250926-ls_dma_coherence-v4-0-21e9c6bdb5cb@nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 bjorn.andersson@oss.qualcomm.com, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>, Ze Huang <huang.ze@linux.dev>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758910787; l=2222;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=x/YV7GviRuKrxoFTMOltiDCmXq8scFHKV8v3SyDackg=;
 b=zZv6x5+g8lfoX1KRaaggYbBkew2o/+XvY0hrd96Jjw8UPPJxQY0NRQWt4cPlSUCLsW32ifK71
 nSDr3kZJ75IA3vYcn4qGZcMwlwp0IBo4XbvweePGgD892OhcCvN/iaI
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-Endpoint-Received: by B4 Relay for Frank.Li@nxp.com/20240130 with
 auth_id=121
X-Original-From: Frank Li <Frank.Li@nxp.com>
Reply-To: Frank.Li@nxp.com

From: Frank Li <Frank.Li@nxp.com>

Add layerscape dwc3 support by using flatten dwc3 core library. Layerscape
dwc3 need set gsbuscfg0-reqinfo as 0x2222 when dma-coherence set.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
chagne in v4
- rename gsbuscfg0 to gsbuscfg0_reqinfo
- use flatten core's properties.

change in v3 (skipped)
---
 drivers/usb/dwc3/dwc3-generic-plat.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-generic-plat.c b/drivers/usb/dwc3/dwc3-generic-plat.c
index af95a527dcc27a7a14d38dcc887f74a888ed91e6..cfcefeffd7ad6c0a21ccc9aaa4483b9acb9dc4e0 100644
--- a/drivers/usb/dwc3/dwc3-generic-plat.c
+++ b/drivers/usb/dwc3/dwc3-generic-plat.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include "glue.h"
@@ -29,6 +30,7 @@ static void dwc3_generic_reset_control_assert(void *data)
 
 static int dwc3_generic_probe(struct platform_device *pdev)
 {
+	const struct dwc3_properties *properties;
 	struct dwc3_probe_data probe_data = {};
 	struct device *dev = &pdev->dev;
 	struct dwc3_generic *dwc3g;
@@ -75,7 +77,13 @@ static int dwc3_generic_probe(struct platform_device *pdev)
 	probe_data.dwc = &dwc3g->dwc;
 	probe_data.res = res;
 	probe_data.ignore_clocks_and_resets = true;
-	probe_data.properties = DWC3_DEFAULT_PROPERTIES;
+
+	properties = of_device_get_match_data(dev);
+	if (of_dma_is_coherent(pdev->dev.of_node) && properties)
+		probe_data.properties = *properties;
+	else
+		probe_data.properties = DWC3_DEFAULT_PROPERTIES;
+
 	ret = dwc3_core_probe(&probe_data);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to register DWC3 Core\n");
@@ -146,8 +154,13 @@ static const struct dev_pm_ops dwc3_generic_dev_pm_ops = {
 		       dwc3_generic_runtime_idle)
 };
 
+static const struct dwc3_properties fsl_ls1028_dwc3 = {
+	.gsbuscfg0_reqinfo = 0x2222,
+};
+
 static const struct of_device_id dwc3_generic_of_match[] = {
 	{ .compatible = "spacemit,k1-dwc3", },
+	{ .compatible = "fsl,ls1028a-dwc3", &fsl_ls1028_dwc3},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, dwc3_generic_of_match);

-- 
2.34.1



