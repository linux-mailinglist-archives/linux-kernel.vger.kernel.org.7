Return-Path: <linux-kernel+bounces-888292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C79C3A62F
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 11:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 591721A46902
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81007224244;
	Thu,  6 Nov 2025 10:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTOQ3frv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB45F2EB5BD;
	Thu,  6 Nov 2025 10:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762426422; cv=none; b=XiwR+aHi9H0sKjmUNWWm/+zzNpBAecHwqpUn53hWxN6BXT0d3+l2L4+nlDJx1Q9GHiJ40+hxbeTKR+CAnm7Zq6x5uQgUIubaJtNy2gWKZvlfliqlt6U08Q2deSXEpI5ebveJwGeqCX2cX0kB8xl9lpvlX9sipN9aVxSos28H8lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762426422; c=relaxed/simple;
	bh=Epp5YO2QE/d3UMrboGIdGCaW2vlY+8wmDJGCJi4/2V8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aeg1Ny75Q9tZUgKahy+zEAcwGJRh6EHsAZD6WZCkihQB72CgSBDvRClcNpfiwu3waM8f54PJwCrI0BfNFGCGSDt31z6zPLSZewA6r+IT0XjeseJaRROF/QOxtyI/iZ8eNTz4D+NmRUkzm0FHTHMvbPmHkCEMZb874zjobcwffD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTOQ3frv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A290C113D0;
	Thu,  6 Nov 2025 10:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762426422;
	bh=Epp5YO2QE/d3UMrboGIdGCaW2vlY+8wmDJGCJi4/2V8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=CTOQ3frvprYP22eUAb6vYVcbfZSWhBScQElSnxVOgQGlV4vEJ/t4j6NG/n84eB6uO
	 0Gsuds4CTx14Z0PSz5FCo8prtDFTXAJgOP8KOftWaUZXJSUtMQ33tzBM2TlVYAxHB5
	 A13owtU/tKk2zZHJOWFsEDv9D9At8IrGGzCT2nc9Dh24p2spxepRh9aT7HkxSfER7x
	 TVWj710ZqRF0YTC4N+aQ+LddaHYbG+JQtYz/9aj9A+egOBHIiPqKSluwSN+QEyXZOY
	 vzyPm7XbfPCsOkrn/NVMgDNdsxgEo7Exih3s+XGuTovllrN8zWJcTkZw+oz+nX6zMI
	 sVvrmBgV0Walw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B334CCFA03;
	Thu,  6 Nov 2025 10:53:42 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Thu, 06 Nov 2025 11:53:40 +0100
Subject: [PATCH v2] dt-bindings: panel: s6e3fc2x01: Sort and remove
 unnecessary properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-dt-s6e3fc2x01-v2-1-deb87727152e@ixit.cz>
X-B4-Tracking: v=1; b=H4sIADN+DGkC/3XMQQ6CMBCF4auQWTumUwSUlfcwLKCdymzAtKSpk
 t7dyt7l/5L37RDYCwfoqx08RwmyLiX0qQIzj8uTUWxp0Eo3RKpFu2FouXZGJ0Vou7GzdcsTTQb
 K5+XZSTq8x1B6lrCt/n3wkX7rPykSEqpLd3PaXqemdndJsp3NB4ac8xdv7k+jqAAAAA==
X-Change-ID: 20251106-dt-s6e3fc2x01-d7a7d36eb1bc
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2065; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=pgClw84QtPBlwZV86TtKjb3RNNcrtweHBH9CMqAbjKE=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBpDH41wJI/LnkhayCRRmgDzx03QNQa6cdxF8slQ
 dKBnyNcL7uJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaQx+NQAKCRBgAj/E00kg
 ci3IEAC6oNsRTnliM3ysSAzlOLeGie3TdehlTDk9zxe8oXnRlWr3K1iggTxVxBtAS1nt3qnPVCp
 HscEX8BlvYYfiazFqGECPsaIEJ4twkzjTwaE9o70IYj1psxeQV+pRe64oTrbIAt9UWBzdwMvkfK
 9kZCuX8QfPRCyLGNRd98IiALZhC7FCmc6f8v6esKbVPc+n3lQoQhcXUZC8voUpigfZGRkVo3xHH
 5E2UDfBfjXUBEQ5B5jOKMmmxajCc7yb6YOvjQaiHcQHuOqJjOQ0+HbxN3v5phSQe288HUGYPxFC
 ggJv8ZrNcGbf7BjuimnoDDIMAbRgpAEQ8qbHcSyf+e5OCDblIE4ioLs654uD8dSV0RWpIJpxjVj
 QOjYMxTiaLazF/W3F7AllbJiTpFzXf80w0bOmfN5iVGZ+cZ6qC+oEtPiO4fRVEVZS8a0IcIuTWO
 xVHbGcd+C2MgJkEnKKwMIl2dJMlumNCQAimB7DGDV3x67WXroXBGWJg3JxrvaGLXA77+FQq5Bsd
 IsiEzwfaFV1TXNZN5flIYkd8jt//XdENYG4+HcPRPHNHJmlrDmXvq9z2JXtlnF/boh0jQnOoTb8
 /ajqXY9QfOmfcuDl6CdUA+Y8eYZ/UY+AtAC6QzBnfDF5BnoR+pSsGCK0EI5v8fsU39KRt+d7Syz
 jUH+8WIQia5VODw==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

Properties are now sorted, reset-gpio and port property dropped because
they are already accepted here as part of panel-common and usage of
unevaluatedProperties.

Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://lore.kernel.org/r/20251106-dt-s6e3fc2x01-v1-1-0479f2d8b53f@ixit.cz
---
 .../bindings/display/panel/samsung,s6e3fc2x01.yaml   | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e3fc2x01.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6e3fc2x01.yaml
index d48354fb52ea0..fd4388f5fb118 100644
--- a/Documentation/devicetree/bindings/display/panel/samsung,s6e3fc2x01.yaml
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e3fc2x01.yaml
@@ -6,11 +6,11 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Samsung S6E3FC2X01 AMOLED DDIC
 
-description: The S6E3FC2X01 is display driver IC with connected panel.
-
 maintainers:
   - David Heidelberg <david@ixit.cz>
 
+description: The S6E3FC2X01 is display driver IC with connected panel.
+
 allOf:
   - $ref: panel-common.yaml#
 
@@ -25,25 +25,21 @@ properties:
   reg:
     maxItems: 1
 
-  reset-gpios: true
-
-  port: true
-
-  vddio-supply:
-    description: VDD regulator
+  poc-supply:
+    description: POC regulator
 
   vci-supply:
     description: VCI regulator
 
-  poc-supply:
-    description: POC regulator
+  vddio-supply:
+    description: VDD regulator
 
 required:
   - compatible
   - reset-gpios
-  - vddio-supply
-  - vci-supply
   - poc-supply
+  - vci-supply
+  - vddio-supply
 
 unevaluatedProperties: false
 

---
base-commit: df5d79720b152e7ff058f11ed7e88d5b5c8d2a0c
change-id: 20251106-dt-s6e3fc2x01-d7a7d36eb1bc

Best regards,
-- 
David Heidelberg <david@ixit.cz>



