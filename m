Return-Path: <linux-kernel+bounces-766345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C42B24571
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE7137BC045
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CAE2F2905;
	Wed, 13 Aug 2025 09:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="k22fezY0"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2312ECEB1;
	Wed, 13 Aug 2025 09:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755077217; cv=none; b=gjmNmAz5r6K1e9FUsAPEca1cG//tZqhMAiyIYiuXivNBtcCUsct1SV1ZrHcI+acpVmfidSwAGcKhW7glteLAy1rEYergQipj7l703Yv2Fxod86cmNdnKM6u2hOBbE1yM8CUP4hvFjVRlC536Ytg6m6t3FuU+TYsoQM5hlncu7Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755077217; c=relaxed/simple;
	bh=11w7t7zhO72bKApbRTzhV3WgYHOscMthRkOh7Z5hAOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cRdoZpuyblM77f2UK27EbgMH0ytNSHGY591fjIpB5rZXw/fFFvKu1K3pE9wEw07l9ZxGhZr57TA6M+HOW0o3ArZC2Zsut2zi6CchxXvLLAJmGVmoxV7t+mW0Lcg5X8QbqufIHNLN9X1AWR3vNU2ImGWjAa+q1KvULIV5y5Au33U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=k22fezY0; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755077212;
	bh=11w7t7zhO72bKApbRTzhV3WgYHOscMthRkOh7Z5hAOQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=k22fezY0h0tYbdC3RUleVKUUK5k3424TlpCjs3dSo5LtiNeTMvi3px5zHoMpXv4wS
	 t0UBRhUMRrr3mZ9MAhXfjOBN2dpJMmx90Uvy18CJiSi6lAzpOS17Kw2x3eJS8/uvdy
	 mWY+dSNuCgASbUpFYeYRg21bJyz0Rm9OfGzgv+mMynDQoHGj86w6ul1zyCamlmx5vN
	 vxaqzGkPe9DQYHzMKRUx7Y8Jp9p8XhDogpd3HzwfsyZQW7ZCM3XYguuMnRmso8DW2R
	 7cULRu9mUyYBZ5HyP8bb5yYivMtSVKhLvEhGG5oJTQOQn2Y1hv4baW8Er+iafsEe8l
	 MaRbDejGJJGAA==
Received: from yukiji.home (amontpellier-657-1-116-247.w83-113.abo.wanadoo.fr [83.113.51.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 192B917E00AC;
	Wed, 13 Aug 2025 11:26:52 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Wed, 13 Aug 2025 11:25:42 +0200
Subject: [PATCH 1/3] dt-bindings: gpu: mali-bifrost: Add compatible for
 MT8365 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-mt8365-enable-gpu-v1-1-46c44c6c1566@collabora.com>
References: <20250813-mt8365-enable-gpu-v1-0-46c44c6c1566@collabora.com>
In-Reply-To: <20250813-mt8365-enable-gpu-v1-0-46c44c6c1566@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755077211; l=1002;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=11w7t7zhO72bKApbRTzhV3WgYHOscMthRkOh7Z5hAOQ=;
 b=O8QMM7cimLtdue9wMkMVhb5ZMnZRNXW+HVuPEJvDa7lncx1u0aXiG0bbv4kczItPKVMefCCcj
 TTaqh9IfTuaDECcn9ug8KcN56f7sDvCOSwVNj0D2QJi34oXW8DK/Xhf
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Add a compatible for the MediaTek MT8365 SoC, that has an integrated
ARM Mali G52 MC1 GPU and compatible with arm,mali-bifrost.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
index be198182dbfe0dba61176f7205b08be131f4845c..db49b8ff8c74864afb25fdde40174d521c72c6e7 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
@@ -22,6 +22,7 @@ properties:
               - mediatek,mt8183-mali
               - mediatek,mt8183b-mali
               - mediatek,mt8186-mali
+              - mediatek,mt8365-mali
               - realtek,rtd1619-mali
               - renesas,r9a07g044-mali
               - renesas,r9a07g054-mali

-- 
2.50.1


