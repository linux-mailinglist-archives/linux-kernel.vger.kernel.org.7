Return-Path: <linux-kernel+bounces-804440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F780B476F3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 22:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 665664E0301
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 20:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE1D28468C;
	Sat,  6 Sep 2025 20:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzqp8I9i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DEF1F0E50;
	Sat,  6 Sep 2025 20:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757189834; cv=none; b=Q3rMIpCqNQAibjWa3J8wGh2nWeQSc5ior8Bq65lBKW05ecYjKjst/4LtIzzO0K5ZDzCCcDsrPbkPsvtBFK7gMO2cMIo70FB5ZivcPeM5Xzr/Cc6DObxp69wN0oWy4r9mBJe86RfrwMI+dSfnn8a/qU+GxXZMh9rgCX6WWzFx4Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757189834; c=relaxed/simple;
	bh=Hi8Uf97ociTZBCvVJuSSZJnZFchp84XKT4cetmjVOzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dIzH7G2wF5/WXCfsIOWCKhiU1z7UtQ5GzFoHM28Wv4pr6U5QbSdB/EBkrofpaYbNMrxecoOY1t4tHIxWgxH4Hve52i+ZW3M435ss1oaTjd35MaHPfOmHf5YX2W6uKrx02G53mSeqnoYYGmmD/kqyQC7LOW1sLpDveov7S3t2Jdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzqp8I9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF05C4CEE7;
	Sat,  6 Sep 2025 20:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757189833;
	bh=Hi8Uf97ociTZBCvVJuSSZJnZFchp84XKT4cetmjVOzQ=;
	h=From:To:Cc:Subject:Date:From;
	b=dzqp8I9in09rvsB5YUwEQh58RW2e6mGeuZ7JLBEMSkVkzg93ve9Mzf4D7yN7lJPuM
	 TnspyBoziwr5Pxigmz5QPh4jE1eTYlsy+GNqbmk8nFB5No72fOzN+1QmLUTiTwOlEe
	 s+dPaOV2o5yGg+0DLxN6LSYmw07sW0sI3ocmGmuU5d2OK+u3Gp4o/fam23trWONwrs
	 77r8Hy8/Pcy3PNgKrNbBp97dDE7VRnpY+ow274vBUaw48RKzrFTrTPSpbU2n8Pn3Hq
	 9T/GzHwapPomgIGnhWhG6nU0fWuHIf00AMpHZnqDIoFYk7DOw9JfN/ypzutSzjkWSI
	 M5wtz/aJI9oSw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Michal Simek <michal.simek@amd.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mike Looijmans <mike.looijmans@topic.nl>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: clock: silabs,si5341: Add missing properties
Date: Sat,  6 Sep 2025 15:16:56 -0500
Message-ID: <20250906201657.1734462-1-robh@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add "clock-output-names" which is a standard property for clock
providers.

Add the "always-on" boolean property which was undocumented, but
already in use for some time. The flag prevents a clock output from
being disabled.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/clock/silabs,si5341.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/silabs,si5341.yaml b/Documentation/devicetree/bindings/clock/silabs,si5341.yaml
index b4f7efdf0b7b..d6416bded3d5 100644
--- a/Documentation/devicetree/bindings/clock/silabs,si5341.yaml
+++ b/Documentation/devicetree/bindings/clock/silabs,si5341.yaml
@@ -73,6 +73,8 @@ properties:
       - const: in1
       - const: in2
 
+  clock-output-names: true
+
   interrupts:
     maxItems: 1
     description: Interrupt for INTRb pin
@@ -130,6 +132,10 @@ patternProperties:
         description: Number of clock output
         maximum: 9
 
+      always-on:
+        description: Set to keep the clock output always running
+        type: boolean
+
       silabs,format:
         description: Output format
         $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.50.1


