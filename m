Return-Path: <linux-kernel+bounces-825323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF38B8B8D8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99FD33ADA0A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA262DAFBA;
	Fri, 19 Sep 2025 22:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjfsW0CY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BED2D77E6;
	Fri, 19 Sep 2025 22:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758321286; cv=none; b=tLFq+lGROISQ1a7cVzg5ZK216YSC0uEAp4TdKw7VJWts1Y0rydyCpeT53H5K9aYMHUQn0vXoHLeDVs+Bt1gYJ2zezVXbGxd9jexdw68YUmEZ04xAl0IvYACXm8bHOwpeXRCd5+5mQfoa6tfT62WkHZk9y3xmbL+qbgfYjcf0WM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758321286; c=relaxed/simple;
	bh=563htESlYeVLr71p16XCYivqzbd2/aC0PNcnMx65i/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fb+mYrJyPXrCyZP4r8jMI0gjpOhHR4jsnl69vQmOyLjoJgmakeK4hjWQ2YBDwSedrrVa2vzaJr0CUJcpRe9Wg8fVATRXH4U31sU1ISi6RByVtCr6ZD8St5X/CBz5G4rZeDECBy4q7smMyh8a0C7x9qCcaZ0VWKygPOUoJNGNOxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjfsW0CY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F82CC4CEF0;
	Fri, 19 Sep 2025 22:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758321285;
	bh=563htESlYeVLr71p16XCYivqzbd2/aC0PNcnMx65i/U=;
	h=From:To:Cc:Subject:Date:From;
	b=fjfsW0CYjGee80NwP2Zv50OZvoV5hcYnHWmdQmWVja5Ee2b9TbB5uIIsEwYrEySAU
	 /eKTy6BpHz9epWDMnuA2ziwcqJumka23lJE/VclN12i787MV5gjET7C6/yWGocABYU
	 wRTzg/x/mnfaQyKyRcjFkueE6LdBbdBMvcDVDhTraHWyuZq21bmDBgEkjwXqIJjBvK
	 jQuDcb9lkUACYdwUeWWBBXTQGW6x5WW5I0iRymMLFY4FA8VovXafbdKGFfcqaJ/hj2
	 KkeNHl8daZPo4DbbmhkOnOkob2Ne1wx3j5SqtGTIIFXRcqME+lMLqtdGuVgtMFxeK1
	 d7bL+rnFOwjiw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mathias Nyman <mathias.nyman@intel.com>
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: usb: xhci: Allow "iommus" and "dr_mode" properties
Date: Fri, 19 Sep 2025 17:34:31 -0500
Message-ID: <20250919223433.2399927-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow "iommus" property as it's reasonable for any XHCI controller to be
behind an IOMMU. Allow "dr_mode" as an XHCI controller can be part of a
dual-role controller.

In particular, the Marvell Armada 8K XHCI controller uses both of these
properties.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/usb/generic-xhci.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/generic-xhci.yaml b/Documentation/devicetree/bindings/usb/generic-xhci.yaml
index a2b94a138999..8875911b43cc 100644
--- a/Documentation/devicetree/bindings/usb/generic-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-xhci.yaml
@@ -53,6 +53,14 @@ properties:
 
   dma-coherent: true
 
+  dr_mode:
+    enum:
+      - host
+      - otg
+
+  iommus:
+    maxItems: 1
+
   power-domains:
     maxItems: 1
 
-- 
2.51.0


