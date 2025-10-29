Return-Path: <linux-kernel+bounces-876607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3C8C1BFC3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B35A75A1C0E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F973358D4;
	Wed, 29 Oct 2025 15:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJkeJoF/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8622CEAF9;
	Wed, 29 Oct 2025 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753383; cv=none; b=rboc6HbPAZI5KdnuRPDFnZs/gtPkue9oVaWZTcEzsFtWC4KiR5Z1q4ACijf/FTvwGUzQpDjzsugievL0S1jkL0eKb4pe9z1A3gqkMrvsWedZQ4lPkD6SGe7rKjOa1PLNNpo7CwYQJczkDvRGc6k5sTDuJKp1M+1TZLdFrX680Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753383; c=relaxed/simple;
	bh=45hzUricmZcE/m3PSKmMJCOrd0GfzpFZMPu02fao4eA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MZorMmQAEVolBkIp9CNISt1bJaBgmBsjtKh8Yu10u+EkjW1RFRuuLIB2OzlGXhgvdN4AnoXzLRBlhFV3xp83xUIjKO4pLqnI9dH+U6vw+FpA7gI/iMvGJ/556UNj5VQjPbz6QQ5LF0apVGEfT70r/uP7GiwhdWO/awlNe+qv4U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJkeJoF/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41A6C4CEF7;
	Wed, 29 Oct 2025 15:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761753383;
	bh=45hzUricmZcE/m3PSKmMJCOrd0GfzpFZMPu02fao4eA=;
	h=From:To:Cc:Subject:Date:From;
	b=ZJkeJoF/41dpRB3s4d1tCl4hh3H0Ns0as8MgvaqEm2g2B9aQU8gBi5mVeT7jN43WP
	 nGD0JtFNGuf6tftz+Mi5Hz99Vq6oWPLuz59Eth7INbtxtWPt0ikTJIp18SbWeoX35v
	 nkHxty5SbUpf5RVKfiTMjF/YBaieyIb7EXESnPKBgrfgAU+XfywJVPUKHw7mgreiFX
	 Lp1omNrggPstJ8CutLKSPu5KiAIgVxrjyeY7nCUl0GShY7g0Y+tPV3Hg8/NIm6bMKl
	 P+INkvMLtaEEy+gv98UhjluT2A5oCN3/3wZ+va0xx+JUOeu6UqtP3S7avidxAZFwgY
	 cErj99ubLe/Hw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: clock: sprd,sc9860-clk: Allow "reg" for gate clocks
Date: Wed, 29 Oct 2025 10:56:13 -0500
Message-ID: <20251029155615.1167903-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The gate bindings have an artificial split between a "syscon" and clock
provider node. Allow "reg" properties so this split can be removed.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/clock/sprd,sc9860-clk.yaml       | 26 -------------------
 1 file changed, 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/sprd,sc9860-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,sc9860-clk.yaml
index 502cd723511f..b131390207d6 100644
--- a/Documentation/devicetree/bindings/clock/sprd,sc9860-clk.yaml
+++ b/Documentation/devicetree/bindings/clock/sprd,sc9860-clk.yaml
@@ -114,25 +114,6 @@ allOf:
         - reg
       properties:
         sprd,syscon: false
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - sprd,sc9860-agcp-gate
-              - sprd,sc9860-aon-gate
-              - sprd,sc9860-apahb-gate
-              - sprd,sc9860-apapb-gate
-              - sprd,sc9860-cam-gate
-              - sprd,sc9860-disp-gate
-              - sprd,sc9860-pll
-              - sprd,sc9860-pmu-gate
-              - sprd,sc9860-vsp-gate
-    then:
-      required:
-        - sprd,syscon
-      properties:
-        reg: false
 
 additionalProperties: false
 
@@ -142,13 +123,6 @@ examples:
       #address-cells = <2>;
       #size-cells = <2>;
 
-      pmu-gate {
-        compatible = "sprd,sc9860-pmu-gate";
-        clocks = <&ext_26m>;
-        #clock-cells = <1>;
-        sprd,syscon = <&pmu_regs>;
-      };
-
       clock-controller@20000000 {
         compatible = "sprd,sc9860-ap-clk";
         reg = <0 0x20000000 0 0x400>;
-- 
2.51.0


