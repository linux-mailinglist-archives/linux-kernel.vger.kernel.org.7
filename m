Return-Path: <linux-kernel+bounces-808986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31606B50729
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADDAB3ADEA7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B82B35E4E0;
	Tue,  9 Sep 2025 20:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7tEzaih"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A9A2FD1B6;
	Tue,  9 Sep 2025 20:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757450050; cv=none; b=qlepq4yFrv3u+OTjCn/bq6alKectUu9Ie6BoyY+RbXHog72+DXs9yT0sMF2706bVBmKL8MIFwjEVODSpOL7LE/tmBNNVFJUlzYNHe2CdDDNuckvLzeI7d3ssjVRZFnq3ZXc2mJ2lhWud/F1Qob/ap067/Iu0Tc/qe4qgntV3hsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757450050; c=relaxed/simple;
	bh=oXUngVSXwtqWUoFqNHj98nN7zNafzIiNipH7sJ0NKww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m2UfTrvjanjNmfe0gefbGK36lPmssTNMowz+lH2BCBSG9SxFuFsNBUQrtsQ3Q6Hk3wZLAZOds8fy7cDMzRiZ5symOGfMAAg6EjxCwTJhnN0ROE9lg8LbKqhFSFoOcm26Kk0b6WJxNcXZwnFkEZgJn9U9E/n2doEJEH2AefrdqDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7tEzaih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3F4C4CEF5;
	Tue,  9 Sep 2025 20:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757450050;
	bh=oXUngVSXwtqWUoFqNHj98nN7zNafzIiNipH7sJ0NKww=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=d7tEzaihs2X+8mMtdObtk21raqXsD8mbi9U2crL6bqScy59U90QtJCQSQXWDpSUjL
	 Zk4aMtSBGqxA8pERQjgVx0itr97f/rrjP6cUD1qVBcH7aX4NxPq7ktESruSnyuw7Um
	 lOk84Zkq8LCXtkRxul1GdKw8Jfi1rJoYHY93MZyjT3vQigsSkNw+P/T8YySGo9OjjI
	 iEx2FF3gKfo/iGrW4olOYxocUjJ9OS01vZ4Tr2QWp2DLNWkDb5ryJBhHKMJs00g+bS
	 DE8Ejgg7EubvYTwZLFuSupcmh5UISGBjj9EMzoslEsQnC9YbMzuOhLTRdnZcZis7WH
	 y6FTBLDfR886A==
From: Andreas Kemnade <akemnade@kernel.org>
Date: Tue, 09 Sep 2025 22:33:02 +0200
Subject: [PATCH v2 1/3] dt-bindings: mfd: sy7636a: Add missing gpio pins
 and supply
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-sy7636-rsrc-v2-1-cfd9f44fd259@kernel.org>
References: <20250909-sy7636-rsrc-v2-0-cfd9f44fd259@kernel.org>
In-Reply-To: <20250909-sy7636-rsrc-v2-0-cfd9f44fd259@kernel.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alistair Francis <alistair@alistair23.me>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Andreas Kemnade <akemnade@kernel.org>
X-Mailer: b4 0.15-dev-50721
X-Developer-Signature: v=1; a=openpgp-sha256; l=1411; i=akemnade@kernel.org;
 h=from:subject:message-id; bh=oXUngVSXwtqWUoFqNHj98nN7zNafzIiNipH7sJ0NKww=;
 b=owGbwMvMwCEm/rzkS6lq2x3G02pJDBkH+rXL8/ZxyXNGmQXn9sbYnHjFxPZ338VH04s9bvPMP
 HUszTOio5SFQYyDQVZMkeWXtYLbJ5VnucFTI+xh5rAygQxh4OIUgIk4OTAyzHbKX7e941PEb8Nf
 xopN9d+Od7DPmKm7IoNXR5axymanKCPD1vNtM7qu6ypNj5WxElvy2vHWV7v9N3WPCRe6uMbYsLi
 xAQA=
X-Developer-Key: i=akemnade@kernel.org; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

To be able to fully describe how the SY7636A is connected to the system,
add properties for the EN and VCOM_EN pins. To squeeze out every bit
of unused current, in many devices it is possible to power off the
complete chip. Add an input regulator to allow that.

Signed-off-by: Andreas Kemnade <akemnade@kernel.org>
---
 .../devicetree/bindings/mfd/silergy,sy7636a.yaml         | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml b/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
index ee0be32ac0204..054b97dd0c5c7 100644
--- a/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
+++ b/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
@@ -32,6 +32,22 @@ properties:
       Specifying the power good GPIOs.
     maxItems: 1
 
+  enable-gpios:
+    description:
+      If EN pin is not hardwired, specify it here to have it set up.
+    maxItems: 1
+
+  vcom-en-gpios:
+    description:
+      If VCOM_EN pin is not hardwired, specify it here to have it set up.
+    maxItems: 1
+
+  vin-supply:
+    description:
+      Supply for the chip. Some vendor kernels and devicetrees declare this
+      as a GPIO named "pwrall" which does not exist in the datasheet,
+      disabling it makes the chip disappear on the bus.
+
   regulators:
     type: object
 

-- 
2.39.5


