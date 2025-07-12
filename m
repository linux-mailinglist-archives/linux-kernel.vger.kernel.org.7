Return-Path: <linux-kernel+bounces-728742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B91B02C69
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 20:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F7361AA40C2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 18:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6E7290BD3;
	Sat, 12 Jul 2025 18:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQMCYL1O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF9E28FAB7
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 18:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752344391; cv=none; b=NbVGU9lyfyWfkYeNvmVyqSFHKo2NvO7JChpIXEYVyQ8khbwtHvjEdo1oLiaJW9TmSbQ4aV67oEIa8qybhwC5pxGULrpFW/vitYZ5pZg6EUf2gp8vLe2zktBqC8S9FPoZ/sQnODTOUm/wFdSHTMJNXMK/VaS7ln3SAozgpHc4o40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752344391; c=relaxed/simple;
	bh=A/iOY+gJ+thN/iDL6WIQnWt1mWlgKRDfbSb2Mb+mlpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQ5fExtvTe04yKxOaYCobD7aYdzvXaLnV3X8haCJ1KJe6Y+N5vaR/kLjtlEreVIugDAjRPqdEB7nqqj+i7BHuQywpsOo4YoYLEPscbVUHys6V0Xp5iyxhZ6CLkpjkQpVmFRYKl/8C+6otZKA6Mi8DPBec/GAmif/CQeiTanjbfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQMCYL1O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02DC0C4CEF1;
	Sat, 12 Jul 2025 18:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752344390;
	bh=A/iOY+gJ+thN/iDL6WIQnWt1mWlgKRDfbSb2Mb+mlpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XQMCYL1OLe43UIm6dBue3A/hdDbBDnrf73PIzJb1LuNcleODRfXdtaGe9Y7KSw/uQ
	 tzcnx0MrOeAf3Bdzqbm6l1HsgyOF6070anGQH2eaOcPlRRz/QZvIknjlDZqK0pQPVH
	 EJTWY1QMtuTT8v9kn318eBbZP1Uw8vA0gOJChUTmqr0duD69EG+746fOH7eocm/3h+
	 nl05kL0Ov5VoJRZMn2Ot6lyzQMCDxbUY0kLeEFxus8vsroW2BCFL9ffmLkweM0uAkq
	 w82xmmvrI8NA2h3YbfA+NXdPI/F99QJQUEv5x6O1RMyl5V5ULs6/MKd6/jc1+YaDLp
	 IB/4ZoGoHoWJA==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Chen-Yu Tsai <wenst@chromium.org>,
	Johnson Wang <johnson.wang@mediatek.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 7/8] dt-bindings: nvmem: mediatek: efuse: split MT8186/MT8188 from base version
Date: Sat, 12 Jul 2025 19:19:03 +0100
Message-ID: <20250712181905.6738-8-srini@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250712181905.6738-1-srini@kernel.org>
References: <20250712181905.6738-1-srini@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wenst@chromium.org>

On MT8186 and MT8188 one of the NVMEM cells contains the GPU speed bin
value. In combination with the GPU OPP bindings, on these two platforms
there is an implied scheme of converting the cell value to what the GPU
OPP "opp-supported-hw" property matches. This does not apply to the base
mediatek,efuse hardware, nor does it apply to any of the other platforms
that do not have the GPU speed bin cell. The platform maintainer argues
that this makes the compatibles incompatible with the base
"mediatek,efuse" compatible, as shown in the link given.

Deprecate the MT8186/MT8188 + "mediatek,efuse" combination, and add
new entries with MT8186 being the base model and MT8188 falling back
to MT8186.

Link: https://lore.kernel.org/all/11028242-afe4-474a-9d76-cd1bd9208987@collabora.com/
Fixes: ff1df1886f43 ("dt-bindings: nvmem: mediatek: efuse: Add support for MT8188")
Cc: Johnson Wang <johnson.wang@mediatek.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 .../bindings/nvmem/mediatek,efuse.yaml          | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
index 32b8c1eb4e80..4dc0d42df3e6 100644
--- a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
@@ -24,6 +24,21 @@ properties:
 
   compatible:
     oneOf:
+      - items:
+          - const: mediatek,mt8188-efuse
+          - const: mediatek,mt8186-efuse
+      - const: mediatek,mt8186-efuse
+
+      - items:
+          - enum:
+              - mediatek,mt8186-efuse
+              - mediatek,mt8188-efuse
+          - const: mediatek,efuse
+        deprecated: true
+        description: Some compatibles also imply a decoding scheme for the
+          "gpu-speedbin" cell, and thus are not backward compatible to the
+          generic "mediatek,efuse" compatible.
+
       - items:
           - enum:
               - mediatek,mt7622-efuse
@@ -33,8 +48,6 @@ properties:
               - mediatek,mt7988-efuse
               - mediatek,mt8173-efuse
               - mediatek,mt8183-efuse
-              - mediatek,mt8186-efuse
-              - mediatek,mt8188-efuse
               - mediatek,mt8192-efuse
               - mediatek,mt8195-efuse
               - mediatek,mt8516-efuse
-- 
2.43.0


