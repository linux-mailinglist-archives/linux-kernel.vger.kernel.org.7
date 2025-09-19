Return-Path: <linux-kernel+bounces-823787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0FBB8770A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BFE47C5EDD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 00:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1103D6F;
	Fri, 19 Sep 2025 00:01:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78E733F6;
	Fri, 19 Sep 2025 00:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758240083; cv=none; b=H5zb5wCciq/jL15jUvNIsMBmh7CDpXOV1LCMwBaghzu2s/YlzACHTKMrgfXq6M0nYFy2naqTEICJsG3HODLoo1JZ8sJoRvYUjmwhurD+bVVDV2HceABJyYqt6KvpdNwYD4yrKRRw/fGPo2cRAV0PBdy36vCrGNapAwP8piVhllQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758240083; c=relaxed/simple;
	bh=w1JZP16dHFAp2HzwYCVCO5AvFOMNfcErG9cWpNaZHRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lsEYbJlipY/qTMoFYrWuYQtsNcoUD0OfTwUzRi/f17IOSnQbsxMv5ZJA2dpbE194IB2QUjzUxYRwqqcDHWAFK93utnWZfYx9GeG9z3I3Qj9BxpuqrbPPg4ZPxFi/Jhdaoj5nW7TMdIlDrWFtiKYiRVYCeQAseO4gleQZqb54R5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF0FD1764;
	Thu, 18 Sep 2025 17:01:11 -0700 (PDT)
Received: from minigeek.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2AD83F673;
	Thu, 18 Sep 2025 17:01:17 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Lee Jones <lee@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mikhail Kalashnikov <iuncuim@gmail.com>
Subject: [RFC PATCH 1/5] dt-bindings: mfd: x-powers,axp152: Add polyphased property
Date: Fri, 19 Sep 2025 01:00:16 +0100
Message-ID: <20250919000020.16969-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.4
In-Reply-To: <20250919000020.16969-1-andre.przywara@arm.com>
References: <20250919000020.16969-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some X-Powers AXP PMICs can combine some of their DC/DC buck converter
outputs in a multi-phase fashion, to achieve higher currents and
decrease the output ripple. The datasheets call this poly-phase. This is
programmable in the PMIC, although often set up as the PMIC's reset
default.

Add the "x-powers,polyphased" property to the binding, to describe those
pairs or tuples of regulators that should work together. In the lead
regulator node, the property lists the phandles of the connected
regulators. Just an empty property means no poly-phasing.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../devicetree/bindings/mfd/x-powers,axp152.yaml   | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
index 45f015d63df16..260c4c0afc475 100644
--- a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
+++ b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
@@ -304,6 +304,15 @@ properties:
               noise. This probably makes sense for HiFi audio related
               applications that aren't battery constrained.
 
+          x-powers,polyphased:
+            $ref: /schemas/types.yaml#/definitions/phandle-array
+            description:
+              A list of phandles pointing to other regulators that should be
+              polyphased with this regulator. The linked regulators will be
+              synchronised with this regulator, within the PMIC, but only if
+              supported by the PMIC. An empty list means this regulator
+              should be configured in a single-phase setup.
+
     additionalProperties: false
 
 required:
@@ -377,6 +386,7 @@ examples:
                     regulator-min-microvolt = <1000000>;
                     regulator-max-microvolt = <1450000>;
                     regulator-name = "vdd-cpu";
+                    x-powers,polyphased = <&reg_dcdc4>;
                 };
 
                 reg_dcdc3: dcdc3 {
@@ -386,6 +396,10 @@ examples:
                     regulator-name = "vdd-int-dll";
                 };
 
+                reg_dcdc4: dcdc4 {
+                    /* dual-phased with DCDC2 */
+                };
+
                 reg_ldo1: ldo1 {
                     /* LDO1 is a fixed output regulator */
                     regulator-always-on;
-- 
2.46.4


