Return-Path: <linux-kernel+bounces-788722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA89B38940
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 20:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 289C47ADF21
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 18:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED08927A103;
	Wed, 27 Aug 2025 18:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcY0WyrJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEE213E41A;
	Wed, 27 Aug 2025 18:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756317882; cv=none; b=rC0jBR8QTmvPsiBm+AZ56wy/KJ9NC+JwPmBCKy0y4UhVKt1L1pU9Opc8wbiXX8zQXQgjgcUpwYJkxiPwWjgZ4+shZe0/4bZG3e+tHX/Tymmiq0cqC5d2O/ASCl8ivZ9fqZ6MTa/O+a4SQ+6Y3OsIUxmXkuG/OKYzzmBGN4eJZ+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756317882; c=relaxed/simple;
	bh=Vs26hTuajQyntpw9lB7Y2tIkK0FXXY749vyjkm3YR74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tX3cO6akt704Ag9i+iHJlJ/pgUZV5ofqXuWM/9qMdmmD4CafipVp4k9MEbjNtEf3GG5W8JAqHTbR2/xv4//z91NTgbIFJkI4JUu1ytzYyKP3sKuIWsJgOLVDttx4d6ReNrAJIQZ0x8lUDpi/ox8uC1eMHYFKJpU+yt+hU3To4tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcY0WyrJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B2FC4CEEB;
	Wed, 27 Aug 2025 18:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756317881;
	bh=Vs26hTuajQyntpw9lB7Y2tIkK0FXXY749vyjkm3YR74=;
	h=From:To:Cc:Subject:Date:From;
	b=TcY0WyrJ8fA48+CGmQa/NR5odU3p+WRJJffmUBeKiJFMIe7KoIYd25pPC3x91fGdb
	 6619/ALEoF6w3TSKemVAwXVstDzSoqKDpvkYuO69BspDEvs4B9ur/kY0Hv/5kzZGWK
	 Q+bMYfMcn0z5OqUUQfmSsMve9UiuRFf4h9dd+XntOJuKJ6U1s9xFsuNI8hdxRw4+DX
	 crjH+gixk9jC1GL0HdVFXwc2uq53lv4hRgkJ1h8XtapBx7UWqTI+GRRepM7781KR/S
	 bhKcj/Cm1Kf24KCaN52lBWWX6wE1lWNCN7Vkko8oGYY5SPAhqxThRVMM1rTZLi7aF+
	 vPP1LIawgmwKw==
From: Conor Dooley <conor@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Ben Zong-You Xie <ben717@andestech.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] dt-bindings: cache: ax45mp: add 2048 as a supported cache-sets value
Date: Wed, 27 Aug 2025 19:03:44 +0100
Message-ID: <20250827-negligee-kinship-7832ba58deba@spud>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1537; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=ZEJpTfPRiyhRaQLfioVvvFhLpXaostCxUboujWZTiy8=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDBnrPRr+M6Rfn7l6CV9RU/xTxvZfV84Vhwgp/g5xWfxei vH6mdr6jlIWBjEuBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEzkCRsjQ4vnlJ4DK3eu5Mk6 dH09+8pifbfA7yfEXx8Rv5qwueqr/2lGhhNTYhqn9uv5NF5ceMxKXyTT/taBgFyd+49mFzH5v1w 8ixsA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

The QiLai implementation of this cache controller uses a cache-sets of
2048, and mandates it in an if/else block - but the definition of the
property only permits 1024. Add 2048 as an option, and deny its use
outside of the QiLai.

Fixes: 51b081cdb9237 ("dt-bindings: cache: add QiLai compatible to ax45mp")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
CC: Conor Dooley <conor@kernel.org>
CC: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: Ben Zong-You Xie <ben717@andestech.com>
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 .../devicetree/bindings/cache/andestech,ax45mp-cache.yaml   | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml b/Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
index 4de5bb2e5f246..b135ffa4ab6b8 100644
--- a/Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
+++ b/Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
@@ -47,7 +47,7 @@ properties:
     const: 2
 
   cache-sets:
-    const: 1024
+    enum: [1024, 2048]
 
   cache-size:
     enum: [131072, 262144, 524288, 1048576, 2097152]
@@ -81,6 +81,10 @@ allOf:
           const: 2048
         cache-size:
           const: 2097152
+    else:
+      properties:
+        cache-sets:
+          const: 1024
 
 examples:
   - |
-- 
2.47.2


