Return-Path: <linux-kernel+bounces-641339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F399AB1044
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 12:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567C91C2536E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 10:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB5D28ECF9;
	Fri,  9 May 2025 10:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nMT5GQ0h"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF7928DF5C;
	Fri,  9 May 2025 10:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746785673; cv=none; b=M1JFHRe7p/9Ih2piv9HDgVKPLEojZM4FvpRu6xWMboImES2wALFZeAdz28rHisoF0UxcfCpajMYhYqFOEtXp8gj2SFjMDW1ekSJRP3PhqYUyVd78dPg6FEwDFCpS+ri2/GN3rfM+Eqd3xRThAxqFmJgecvB40MTHbOqCqd8bUhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746785673; c=relaxed/simple;
	bh=tC3yerrzg8rWelNEn6xwDuErAgY2oEHyEk9X9qlwnaA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pENLFkrkJHiDgTAKUMugoAYBxiOq2+c4gGOdOjHjKtVW9NRbLCBWP0Qm5FuakMNc7cUlg6QUnnol+r/92c+Em9N5un+2pKKPlmIXOHDmvIxSsxmIaoblMY4TpEA/1fyHiPG0w5QmNLI/hfsNZ8RTXEuOMR+Pkls8vk6R9fFUdFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nMT5GQ0h; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1746785669;
	bh=tC3yerrzg8rWelNEn6xwDuErAgY2oEHyEk9X9qlwnaA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nMT5GQ0h5zoIckKo02quXQRW07wwO9O4bAqPovy04mWZsKKVBh18dIr03I0G16P8z
	 xUSNTbWP/JOQk7G0z/qUgAgm+eXTRQvyGmNThHsCzppuqHhe+uFw0bUsTsOsP8tTY9
	 XtvPqqkBA7OvW/NHxJOLcYIbH5id58dOboiUYrMgpSk22Lp5dxV+1l/sh1EZVbDJMH
	 2+Hz8v8HchkjdVlKVJoVjOO5m1LAwazY2llYdnIVm5n0/f28ldlbvqm17w3BrTVOVn
	 yPme61YfEEzNu71hPAGJZVBhgrL33pIqIoiz0SUdOEePgM7lHjQMFPkMfaW5acemn3
	 Hq7g9JiPshkjQ==
Received: from yukiji.home (amontpellier-657-1-116-247.w83-113.abo.wanadoo.fr [83.113.51.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5E1A417E05A6;
	Fri,  9 May 2025 12:14:28 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Fri, 09 May 2025 12:12:47 +0200
Subject: [PATCH v6 1/5] dt-bindings: gpu: mali-bifrost: Add compatible for
 MT8370 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-mt8370-enable-gpu-v6-1-2833888cb1d3@collabora.com>
References: <20250509-mt8370-enable-gpu-v6-0-2833888cb1d3@collabora.com>
In-Reply-To: <20250509-mt8370-enable-gpu-v6-0-2833888cb1d3@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746785666; l=1599;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=tC3yerrzg8rWelNEn6xwDuErAgY2oEHyEk9X9qlwnaA=;
 b=SUudfoxKoIM1mIWdH3VYBxGXNrCkLcyx4HTJkoy72azrPYoyGg9GUVAiccsh/5z+E1hMTi3Dg
 CYZ/mD8RwEEBdTdsbet60itRzyJ4bdk+N8iEgxENE9LwjJoZ8OH+DwA
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Add a compatible for the MediaTek MT8370 SoC, with an
integrated ARM Mali G57 MC2 GPU (Valhall-JM, dual core).
None of the already existing SoC specific compatibles is usable as
fallback, as those either do not match the number of cores (and number
of power domains), or are for a different GPU architecture.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
index 019bd28a29f19bb4f7a9c32434b208b6d04db221..5726b79fd0f9de8914f724929f462409e088ec31 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
@@ -40,6 +40,7 @@ properties:
           - enum:
               - mediatek,mt8188-mali
               - mediatek,mt8192-mali
+              - mediatek,mt8370-mali
           - const: arm,mali-valhall-jm # Mali Valhall GPU model/revision is fully discoverable
 
   reg:
@@ -221,7 +222,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: mediatek,mt8186-mali
+            enum:
+              - mediatek,mt8186-mali
+              - mediatek,mt8370-mali
     then:
       properties:
         power-domains:

-- 
2.49.0


