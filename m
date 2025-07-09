Return-Path: <linux-kernel+bounces-723695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 661DBAFEA09
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A20EE3B22BD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C736728DF27;
	Wed,  9 Jul 2025 13:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="lKsKQ2q4"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D782D3EFF
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 13:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752067419; cv=none; b=KSP50LDRz05fpmNNOcBicqHTnOMPCWoHG1P7fHZsE/lIRR3mEkmlB8HruAzjHPx2dwPWMeYZ+H7HDnBs15EhkVnsOcphSGzy2kRtWhYbkweCXSuMDKtlTPB9a9OJSIDMJ+DfbxT82YSwgi505WDgwidNHpxWug1Xo90CfBwyE5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752067419; c=relaxed/simple;
	bh=8fQU+lbwAFjO5bDAI2x9qjzTgELMCGW2B1AKMzaqDkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fkymiUAdgR9fFSHqKTaHei+PQ6iw7Kf/MGcosJH0V5kyRoDMwoVHo7zzZrF2EXr35O7iN8ZrTe9DsHfpzIIG5DfD7rHtTP0iku5hu82vrp2gDkZvt24UfyXcfxcz6cEYTghkP7x4Hk7c9lBbWmkCYBokcGqTUq9nBn2beA/r710=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=lKsKQ2q4; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1752067415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CGiINAVxrmdGU1PCrP23FZvlTFaK01obSa4XqumrYhM=;
	b=lKsKQ2q4ZBk/za6pTF38bYIbjhaJTuEUqYP6d+q0rAxowzY/zJDyxEt2L5TdKnHcMaXE7/
	jiVohHfPVk7niMVYyXZWc4bo+oUS7tv5khIaTeA8q+Bwjrqwu8H4NsbFmy+p/TN6Zia3OW
	6KD7KrEoXrwNZA7mBXNMc/dH51UOZI9QRLNDJ4fNcdz9AeAT7c1vIP0/fhW1YAQbEv30o0
	QFrmDWPX4QK6jsQJNltcFyUdbh4F1EfQy6xS8B+bz/ONJE9BK1nXqiRDdj9XC0NMbNGUDW
	mXRp+Svipuu3SGgsN+752Q2p3XLlA//r2kT/L4fDosTa6qKG8b+/nlRJFZ0ghg==
From: Diederik de Haas <didi.debian@cknow.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Dragan Simic <dsimic@manjaro.org>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Johan Jonker <jbx6244@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Diederik de Haas <didi.debian@cknow.org>
Subject: [PATCH v4 03/10] dt-bindings: display: rockchip,dw-mipi-dsi: Drop address/size cells
Date: Wed,  9 Jul 2025 15:15:16 +0200
Message-ID: <20250709132323.128757-4-didi.debian@cknow.org>
In-Reply-To: <20250709132323.128757-1-didi.debian@cknow.org>
References: <20250709132323.128757-1-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The "rockchip,dw-mipi-dsi" binding has allOf "snps,dw-mipi-dsi.yaml"
which has allOf "dsi-controller.yaml", which already has #address-cells
and #size-cells defined as '1' and '0' respectively.
So drop this re-definition.

Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
---
 .../bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml     | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml
index ccd71c5324af..0881e82deb11 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml
@@ -58,12 +58,6 @@ properties:
   power-domains:
     maxItems: 1
 
-  "#address-cells":
-    const: 1
-
-  "#size-cells":
-    const: 0
-
 required:
   - compatible
   - clocks
-- 
2.50.0


