Return-Path: <linux-kernel+bounces-862309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEC5BF4F89
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5E2F4278F8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0BF280A58;
	Tue, 21 Oct 2025 07:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RwX6o/WW"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DDB78F4A;
	Tue, 21 Oct 2025 07:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761031911; cv=none; b=LENpWY0tjxOirbJWd+RxNOdxp8G2huOqQczBwwf0aWDzpHLY1ks/3TZ8L3/SF4OL9/60Fp2ME0kThJsBsqVAHuqpY00SQaNuGB7K0h+jE8kZ3A2jWwm+DP+HEccaAjfhWJrkRyuIk2O/LyWNTtujOI5orvP/OCl938ANQCKXCDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761031911; c=relaxed/simple;
	bh=bjLpM2W3sTbWopeGWLyYiV//AjiRsTV/ewj7yfjNBrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EN3zSlKLgZJ/Nu51EJRrrW0jw1xJbhHxwUIPK/wuBEnZO24dQt4DMF32FbQKQnf4diHcUZL/XjrfwP5RmUgGK2NtVYNRrQYhsR+u48wYtpdEFUOObNTFBdgP9VloS5lsMa4/hsyRquNjEeEWzjOB5uI6xQitt0o8HiS3dmcyVr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RwX6o/WW; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761031906;
	bh=bjLpM2W3sTbWopeGWLyYiV//AjiRsTV/ewj7yfjNBrM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RwX6o/WWdSdPSpu2/HisgEyMoJji5k3aDmofw9ZGxGk96NsPmibSMruKhynlrD8GF
	 AWjsghxqNSysqj5MTV07u/F8VHmapT0zU4hVo8Bua2vodIPpTt3PWuysDz5QTg+CM+
	 TIDZnxajRnKpDDoLGZVjf+K7+GPVEOD5VU1JFc/aDY2JLxm9p5hdUnkxCJfnwvCbxY
	 AhNwlbxMLLi5wOIwKnVJv1nFXaNrXL8CjVsM3JQApDDq4koqu1NhDBXzpvXPNR8pFE
	 E+9syuCWr5PJ1SEjxitkdgJbqqzHCjYQX6DR1AxiTcjPbtmucOoqsr6guubGrc5X/2
	 R5BH+fsFgiWiQ==
Received: from yukiji.home (amontpellier-657-1-116-247.w83-113.abo.wanadoo.fr [83.113.51.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 12F3217E02B0;
	Tue, 21 Oct 2025 09:31:46 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Tue, 21 Oct 2025 09:30:51 +0200
Subject: [PATCH v2 1/3] dt-bindings: gpu: mali-bifrost: Add compatible for
 MT8365 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-mt8365-enable-gpu-v2-1-17e05cff2c86@collabora.com>
References: <20251021-mt8365-enable-gpu-v2-0-17e05cff2c86@collabora.com>
In-Reply-To: <20251021-mt8365-enable-gpu-v2-0-17e05cff2c86@collabora.com>
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
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761031905; l=1138;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=bjLpM2W3sTbWopeGWLyYiV//AjiRsTV/ewj7yfjNBrM=;
 b=qh7dnF8RA3htMtb2+A8RKYeQOThCkDf1QWvsJ06DDoW/sFl/x83o6uGfQLpoTzN5imoU+xGdq
 XF0ULFINFWlCVD2vo6U/beUlt89s5VcHZyxaeTJbTv+r6UlC2nVBQk5
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Add a compatible for the MediaTek MT8365 SoC, that has an integrated
ARM Mali G52 MC1 GPU and compatible with arm,mali-bifrost.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
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
2.51.0


