Return-Path: <linux-kernel+bounces-876178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAD1C1AE90
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3EF7627605
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8066829AB00;
	Wed, 29 Oct 2025 13:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TUPCO2I/"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4890299AB1;
	Wed, 29 Oct 2025 13:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744377; cv=none; b=iTj3Y2/ehpQnD47YJVc8YZTp0ts26pQeWlBvARgBTRV/EzsLmX1BZeC1N/GTh6oTaWcNiM9gijMaHA/nglw5IrH6rPaTrK6tkJsC/Hs5e5iL+2laBi5dAR8eeaGGSFElBW6v+7HVPqWQ1wz6Z0SrCbWf4zhtaF/nlCEJOBIOSfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744377; c=relaxed/simple;
	bh=CKjKWDSuFg61Q3UumaNfQrY9nYh58Mn1xSRT4RFKlfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ToaowA3u7h/5SkbxW4rA5j7l5T8oRlCL21se38p1gOBvTR+Y049G2n4vL9u+JY8LXzQhVsHyuDQZRTk2cjWcB/ELuOfUt1rKFupeDKM22f1qCQgHptEMLKSv/Q4rxqWdP4oQIqXYR18kDxm7V0Uoac1XugwxzDho6gf5O/Okf2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TUPCO2I/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761744373;
	bh=CKjKWDSuFg61Q3UumaNfQrY9nYh58Mn1xSRT4RFKlfA=;
	h=From:Date:Subject:To:Cc:From;
	b=TUPCO2I/RFRnEZZh/BwABQNzIDTNAUn3iwfxUR2lpw5jKamLKdHYzJScfCsCcY0WI
	 rN1VZGXNXPAfQ7AoYpAxFcXLO9Ss3nM8JNXwKwTOPIPYmFx6f/1wSod+wmw+xndtLs
	 PC2elcimt/evu+6MNZPGuUmBp/brN8efDNZW5M964naogHwbH5pdtVUQr7qjeT9Hmt
	 KJPF20zTzkhSS/OOM2oUOJMcLVYn6uf2GQZ+G2dYL4ylZyeLhMjSwP2HfQ3Lyc0vCs
	 v0bkzsUo3f4Pi3mXwnoXnCn/TT1sS9VYpulbofCtj4tEXi1O6irFpJbAhHk0icnPd6
	 tbofaAJGYvfiA==
Received: from yukiji.home (amontpellier-657-1-116-247.w83-113.abo.wanadoo.fr [83.113.51.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5B47717E1315;
	Wed, 29 Oct 2025 14:26:13 +0100 (CET)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Wed, 29 Oct 2025 14:25:57 +0100
Subject: [PATCH] dt-bindings: soc: mediatek: pwrap: Add compatible for
 MT8189 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-mt8189-dt-bindings-pwrap-v1-1-d52b1aa5f5a4@collabora.com>
X-B4-Tracking: v=1; b=H4sIAOQVAmkC/zWNQQ7CIBBFr0Jm7SRANZZexXRBYayzgCKgNml6d
 4mNy/eT/94GhTJTgUFskOnNhZfYQJ0EuIeNMyH7xqClviipDYbaq96grzhx9BzngumTbcLOWXO
 dzt530kK7p0x3Xn/q23hwpuerFeoxwmQLoVtC4DqISGvFfwXGff8CmCRP3ZsAAAA=
X-Change-ID: 20251029-mt8189-dt-bindings-pwrap-3ca97b4dd30a
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Flora Fu <flora.fu@mediatek.com>, Alexandre Mergnat <amergnat@baylibre.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761744373; l=1112;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=CKjKWDSuFg61Q3UumaNfQrY9nYh58Mn1xSRT4RFKlfA=;
 b=PtEPwukhbAFkJ1aMh8EEF3ugB3jaEJ4wWeZDUZrrokc4K8A1lDjWI7mN8u+mjQOC4B7Yp0IOO
 kKwUOLl9c1qBKgycdo89Rk988sOGKJJ7Ikrs7b4OvBInzxKh2jnGWvl
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Add compatible string for the PWRAP block on MT8189 SoC, which is
compatible with the one used on MT8195.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
index 54c0cd64d3094648844fa7b9fff44649a72ec021..e7c4a3984c601f36858908c1d974e7d5f3587838 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
+++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
@@ -52,6 +52,7 @@ properties:
       - items:
           - enum:
               - mediatek,mt8188-pwrap
+              - mediatek,mt8189-pwrap
           - const: mediatek,mt8195-pwrap
           - const: syscon
 

---
base-commit: c9a389ffad27e7847c69f4d2b67ba56b77190209
change-id: 20251029-mt8189-dt-bindings-pwrap-3ca97b4dd30a

Best regards,
-- 
Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>


