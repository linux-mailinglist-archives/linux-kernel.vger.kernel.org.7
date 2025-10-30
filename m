Return-Path: <linux-kernel+bounces-877614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E991C1E95B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F87F3B58BF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E7032D438;
	Thu, 30 Oct 2025 06:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtEIMIPP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663032F99B0;
	Thu, 30 Oct 2025 06:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761806142; cv=none; b=bEJ4F4W6y6E+k2+cYjTMMyWa+kjva2WNo/pNeN4ZkmNpB+1TMJx8R8U26h6cUQdhdfjUbBXgkyhUm/Zm4sz4picYll5RnEF2hyBqcX061L+4fp3qhWn3gRGsCURKTFBtAisxCEhixvGeRdzKSIseJRSjjpUdReHsWKEvpIsIV70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761806142; c=relaxed/simple;
	bh=xxL8kTS9N9rQw2fjzBJgC6K2U2mkflgT2ueV+BN2vxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gxz8YBlFGEdfd2QmNln6iR14+Curdv9wL7i45eHhCaFZxFLv1e1ZVg8gHmRwoJ6nMcQQv2b9BGsvBP/IkMVZUiVfu+5xvFgBCCXpLdAqfFlBTLq+9yvFqcV7n17JItXr87uveCEMkz2zm6jfCBin4FoestVvTBfUV+4bCkHNhus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtEIMIPP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFE08C4CEFB;
	Thu, 30 Oct 2025 06:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761806142;
	bh=xxL8kTS9N9rQw2fjzBJgC6K2U2mkflgT2ueV+BN2vxI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KtEIMIPP/4FgFVEJc/dCJB2DXyAVlGZ7OnUBYL72WPToTklrqFv1Z9aSM+1ZBXvl2
	 vr8PyrNb3FZv0bs3omOZmW0rxkaNIdLD8feSZkhhFafOdvVTwrMLw1bEfDl/1Uye2I
	 FcykgKcI89pDF6ibbqeS4JarLuYvG/YqaiO3MWJz0QF3egm1SOPi0OErzjJrVNL3Vg
	 lIyavQyz4uyukBGD9vrgHaxU66D4lzxpVJixSipoyNslMV88awqWMY5cBujgz5EXDT
	 sg3AysQ7cDQ+ziTvp03FTggewLvwYDlcG59M9PlFPaz31z9K0LrjG+vk+b3EkoTRMG
	 H6SSKnQ6pm//w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84E0CCF9F6;
	Thu, 30 Oct 2025 06:35:41 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Thu, 30 Oct 2025 07:35:38 +0100
Subject: [PATCH v3 2/6] regulator: bd718x7: Fix voltages scaled by resistor
 divider
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-mini_iv-v3-2-ef56c4d9f219@gocontroll.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761806140; l=1067;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=tuKfLXiuKVJmrScuYv67N/GxQOk6XTz9dS5/tFi0lBM=;
 b=+LGPkSfwqhDloJj9Elfn+cdPBbg26FW8C9k93ZFY/maawtjxrITscXXTDy/sYrW8WQEidINh6
 og24Myhv3XcBXsfy2nYWUcViUf3olUdKJT++KiSSb2QQfevkFwSju0E
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

The .min_sel and .max_sel fields remained uninitialized in the new
linear_range, causing an error further down the line. Copy the old
values of these fields to the new one as they represent the range of
register values, which does not change.

Fixes: d2ad981151b3a ("regulator: bd718x7: Support external connection to scale voltages")
Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
 drivers/regulator/bd718x7-regulator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index 022d98f3c32a2..ea9c4058ee6a5 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -1613,6 +1613,8 @@ static int setup_feedback_loop(struct device *dev, struct device_node *np,
 				step /= r1;
 
 				new[j].min = min;
+				new[j].min_sel = desc->linear_ranges[j].min_sel;
+				new[j].max_sel = desc->linear_ranges[j].max_sel;
 				new[j].step = step;
 
 				dev_dbg(dev, "%s: old range min %d, step %d\n",

-- 
2.51.2



