Return-Path: <linux-kernel+bounces-878003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F35C1F87E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7CCF2344108
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F593570AA;
	Thu, 30 Oct 2025 10:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ff3p6CqX"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAD03559EB;
	Thu, 30 Oct 2025 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761819985; cv=none; b=OxHW4kXdhFARKc3w9lwQq57+Oze9VhzU6v3riHafDCuCdDGHXEMkSnCJ4eBV9SeEgEerbu+aLnWHkQjZnX5lLwsfPn3Y9z9upVPozao7AKm4HNQbbZC2eJf6qxiDn11KkNN7iSx4UB+b5u+CmlVbLughfRyv/bSyDonbWpzQf9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761819985; c=relaxed/simple;
	bh=JCjlJekAh4Wl54nl2fNdsos6xlZi3Ti+2PaJybspVHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KyZUbKLK80LmhuwC8LVqqG4fzrM7ECHRh02UIxC9ZHvF8Czp9IJ/MP04W5Y29TKPldOl32KdqoTDFG+pMuT8+wN2Tn6p/AVk9h3Iq+pwEbivX/QuP7ZDKpFJLJqQJABo64o+onwTjySonOGqrj51o16rIjXPFheLyvTVg54Yg78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ff3p6CqX; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761819981;
	bh=JCjlJekAh4Wl54nl2fNdsos6xlZi3Ti+2PaJybspVHE=;
	h=From:Date:Subject:To:Cc:From;
	b=ff3p6CqXhg/E2ZGHMuLGnCLnmA6o/02JheqtBCBqkxrF4LfK+ezmX022fEN+Kimnw
	 3LG+2fcZRH/rly3oH4seH7AP4Vu8qJ+gQ4Eb6FoAIC5ED9tVrHkzrsvXlBfTlIZMD5
	 wUCCU6XuQ72bj19eLHe+Cbgiic2thbMMqFMTn76aHmLS4y6Xjci2hwhG0cjCbZSUtY
	 uLeHsAVmQA5/ZTT2IMdzcWgOn4pKYGxt+CSsklXvXiXQRMFuHHC+LD2tBMCH0rjElk
	 Y1K7lMv1iOerjiYC8TTkQaTDjiF8L3Wv1RClTemV1hWQ4Jz9K4D37u+ygTN2LBi33z
	 wgjy1BJT70eRw==
Received: from yukiji.home (amontpellier-657-1-116-247.w83-113.abo.wanadoo.fr [83.113.51.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BFDC017E1324;
	Thu, 30 Oct 2025 11:26:20 +0100 (CET)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Thu, 30 Oct 2025 11:26:10 +0100
Subject: [PATCH] dt-bindings: nvmem: mediatek: efuse: Add compatible for
 MT8189 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-mt8189-dt-bindings-efuse-v1-1-1148e474a9f5@collabora.com>
X-B4-Tracking: v=1; b=H4sIAEE9A2kC/yWNQQ6DIBBFr2Jm3UmAhipepXGhMNhZgC1gY2K8e
 0lZvp+8/07IlJgyjN0Jib6ceYsV5K0D+5rjSsiuMiihtBTKYCiDHAy6ggtHx3HNSH7PhFpK2wt
 vHr0WUPV3Is/H//o5NU702WuhtBGWuWp2C4HL2EU6CrbKXcB0XT8DKplWmwAAAA==
X-Change-ID: 20251029-mt8189-dt-bindings-efuse-511c70f96750
To: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>, 
 Lala Lin <lala.lin@mediatek.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761819980; l=1163;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=JCjlJekAh4Wl54nl2fNdsos6xlZi3Ti+2PaJybspVHE=;
 b=v5rnldqSZgYyHEVeUCdz6Z+hlMMe2Wac0DVshUTNWz0qfFdHi/XPksJZ40GguyKyR3S7YcmNm
 bSvbpvDu3KRAOcVWD1jst2/UdUR6KfYYjY7BWpZwm74z9ufwvOTdnbp
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Add compatible string for the eFuse layout on MT8189 SoC, that is
compatible with MT8186.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
index 4dc0d42df3e6c3bf066a7109bd72b577ff7220f1..577295fafb9b1fb91d175d085c0beb3918c35e4f 100644
--- a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
@@ -25,7 +25,9 @@ properties:
   compatible:
     oneOf:
       - items:
-          - const: mediatek,mt8188-efuse
+          - enum:
+              - mediatek,mt8188-efuse
+              - mediatek,mt8189-efuse
           - const: mediatek,mt8186-efuse
       - const: mediatek,mt8186-efuse
 

---
base-commit: d78b0fee454c25d292fb6343253eca06d7634fd9
change-id: 20251029-mt8189-dt-bindings-efuse-511c70f96750

Best regards,
-- 
Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>


