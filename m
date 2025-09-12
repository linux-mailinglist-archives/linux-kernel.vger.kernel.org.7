Return-Path: <linux-kernel+bounces-814089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F12EDB54F0B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 907473BC4AB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E2C3101C7;
	Fri, 12 Sep 2025 13:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RG8Q2ps8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FCF30FF37
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757682862; cv=none; b=FtbjjfgmErMQIG0nTnXFX4HlrygfAk11xzX+L5OxO1OAELa64PQAx7q6/yN1P/OKEZfmy3od/v+30RYCuLbswKesTpt38QP5BKWToALKjIhCESAyHWcm25O9W1adU2bIh6UQ0hxErLbRS24kLsJb9kNFZc3x44qx4BUgjHj0zkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757682862; c=relaxed/simple;
	bh=sMRpYWfL2QXkyxeUkmqjU+F4i4TUrlhjQ0pljHjIbto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ee9hyRBamXcS3zC4CQWRGd0BD3FOU/DHDxYZKN+IFIJ+c56TJRc1HQsJuFv+aeCR75fCyy+RS1bsDmrksSB1HQq8Zf0VZjxyGjtdlWPJIyFPmcM6ZYl7FZuyAYhI4nDGjbbPb3suUbyUgjXxOOOk+TifqNW3oIDk6ApwEOwrIX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RG8Q2ps8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CACB3C4CEF4;
	Fri, 12 Sep 2025 13:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757682861;
	bh=sMRpYWfL2QXkyxeUkmqjU+F4i4TUrlhjQ0pljHjIbto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RG8Q2ps8m5l+jmHpCj2pwjEKjkw3pA/gj8dK3aTvtr3N+AI/Usby5OSzX1q+2jLfn
	 i8fIvuuwOcVX/AbeVPgAcAMrlhJ9anN3ubzrtlx30LQriLPJO7EovC6Wcs0em3X4Mq
	 0DPZQbgr6TbzFOLT9/PGxorAN8AnRnZaDGNadUNWrI5N79HRf6GXleAM5UgWKDeeWp
	 WOHzImqjStXNkMPr4YtZtCznsd/iXsHZf2jnkaXUZ11slCvvJu2yAYPKtZVTfxeTj0
	 zxLPKrc3lEZ9MOvr6ZoNdgrSh+HxfbaqLGsAiYVfBgts1ouRQf93iZhQpfBxvPcxy6
	 ZuHYcBCtB8Zqg==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Ciprian Costea <ciprianmarian.costea@nxp.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 1/5] dt-bindings: nvmem: Add the nxp,s32g-ocotp yaml file
Date: Fri, 12 Sep 2025 14:14:11 +0100
Message-ID: <20250912131415.303407-2-srini@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250912131415.303407-1-srini@kernel.org>
References: <20250912131415.303407-1-srini@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ciprian Costea <ciprianmarian.costea@nxp.com>

Add bindings to expose the On Chip One-Time Programmable Controller
(OCOTP) for the NXP s32g chipset.  There are three versions of this
chip but they're compatible so we can fall back to the nxp,s32g2-ocotp
compatible.

Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 .../bindings/nvmem/nxp,s32g-ocotp-nvmem.yaml  | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/nxp,s32g-ocotp-nvmem.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/nxp,s32g-ocotp-nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nxp,s32g-ocotp-nvmem.yaml
new file mode 100644
index 000000000000..8d46e7d28da6
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/nxp,s32g-ocotp-nvmem.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/nxp,s32g-ocotp-nvmem.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP S32G OCOTP NVMEM driver
+
+maintainers:
+  - Ciprian Costea <ciprianmarian.costea@nxp.com>
+
+description:
+  The drivers provides an interface to access One Time
+  Programmable memory pages, such as TMU fuse values.
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - nxp,s32g2-ocotp
+      - items:
+          - enum:
+              - nxp,s32g3-ocotp
+              - nxp,s32r45-ocotp
+          - const: nxp,s32g2-ocotp
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+allOf:
+  - $ref: nvmem.yaml#
+
+examples:
+  - |
+    nvmem@400a4000 {
+      compatible = "nxp,s32g2-ocotp";
+      reg = <0x400a4000 0x400>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+    };
-- 
2.50.0


