Return-Path: <linux-kernel+bounces-759554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 377F2B1DF0A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 23:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E596B18C0866
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 21:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FBE25C827;
	Thu,  7 Aug 2025 21:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiamnT9N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5152264D5;
	Thu,  7 Aug 2025 21:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754603111; cv=none; b=PTfS+EkuZxHIOUFJ+j3uQyfTDsto1RobihzV0AEomVGgMxzHoT7r90HZsTmlQtePUQGVs5a3qZZuhYDICLjgHCS+juMcGRXdfHPlZ80AzsZEb7GHJ3ykGdyEl/2Um6c/VzIjveEUr+DOoZF6wdgoRScdMorQHkDsIA/S8BzAOtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754603111; c=relaxed/simple;
	bh=BcqwRlgnCAKwxdgorrU4/Y1BN3OUrz4kEzJGkFYmBKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uf6uQ+3UxCPZso1HjlBUf6CcMBKwagWFmvGP+tLxfIX9Vw6TfZOKQX8Yxq8t8pK8Vx6zHcaXT0DneAJzgbeoVOZGcuIqfEcqor1GVg7D/I5Ml2vFeh0IXRY4VgljZZYoY0CI4TysUBfTcq8fXgH0ogZozCW32437BL2A1/tVs4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiamnT9N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA070C4CEEB;
	Thu,  7 Aug 2025 21:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754603111;
	bh=BcqwRlgnCAKwxdgorrU4/Y1BN3OUrz4kEzJGkFYmBKw=;
	h=From:To:Cc:Subject:Date:From;
	b=QiamnT9Nk2fIzBq0gXPcoNsROoJ53xe9Bz9pCijPj95dtnUKvgmXAbsiYE904EH0Y
	 QTQsjX2D78GdHjBvUwjQ07iUwc7JqVUJopSJxpMhUQVCxr2lNyN/Lk75Fv/2KWmOOm
	 mJNSi7rJ4Z7XnUQiAqGLBjUkxvi/9FOmuF6sgI9Ov9zIiEe608lQT2Hovp0SP56LHg
	 Jk15vkx/3XKQaNdh4UtpXEtHbdahfpUfb05qWyAXTtRf1pfoXARVuB7UjStkybPLzv
	 NrnwDpyhKQgAimwTOi+W024DLo+80uf7qYKwygt5FWxX8XJdsptZ1D4ujnAfG0t1nz
	 6jZXhhPQl3nVg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: display: Drop duplicate ti,opa362 binding
Date: Thu,  7 Aug 2025 16:45:07 -0500
Message-ID: <20250807214508.4174167-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "ti,opa362" binding is already supported in simple-bridge.yaml, so
remove the old binding doc.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/display/ti/ti,opa362.txt         | 38 -------------------
 1 file changed, 38 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/ti/ti,opa362.txt

diff --git a/Documentation/devicetree/bindings/display/ti/ti,opa362.txt b/Documentation/devicetree/bindings/display/ti/ti,opa362.txt
deleted file mode 100644
index f96083c0bd17..000000000000
--- a/Documentation/devicetree/bindings/display/ti/ti,opa362.txt
+++ /dev/null
@@ -1,38 +0,0 @@
-OPA362 analog video amplifier
-
-Required properties:
-- compatible: "ti,opa362"
-- enable-gpios: enable/disable output gpio
-
-Required node:
-- Video port 0 for opa362 input
-- Video port 1 for opa362 output
-
-Example:
-
-tv_amp: opa362 {
-	compatible = "ti,opa362";
-	enable-gpios = <&gpio1 23 0>;  /* GPIO to enable video out amplifier */
-
-	ports {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		port@0 {
-			reg = <0>;
-			opa_in: endpoint@0 {
-				remote-endpoint = <&venc_out>;
-			};
-		};
-
-		port@1 {
-			reg = <1>;
-			opa_out: endpoint@0 {
-				remote-endpoint = <&tv_connector_in>;
-			};
-		};
-	};
-};
-
-
-
-- 
2.47.2


