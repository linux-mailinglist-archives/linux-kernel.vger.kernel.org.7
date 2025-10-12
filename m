Return-Path: <linux-kernel+bounces-849736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 557B5BD0C40
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 22:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95538189230D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 20:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB21239E7D;
	Sun, 12 Oct 2025 20:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+6ty8NE"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19B82AEE4
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 20:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760302752; cv=none; b=ZOr0BZHVdTaTsNgAYcewBivFrQapGOXiCUT9vUuociJFJRTQnwDKQ+q8+DtjPWucqWR0A2zOgSzDSNSWduT3MRVtirrH7tcCrEcghRcYfsEc0ygxFJB82uWj4Iv0Pqc8QU5JDCPGrV93Rza9V52pdyKIb9+LFzoDWhio5WOr7jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760302752; c=relaxed/simple;
	bh=6sa4dBlIVtXXSWxWD+PhcdWd6PIrRysSNnN6dDj8eWM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wpo0qKiusFRvVQ6AE/2jxuNPEYmjbrASXDgK9m/SA05r4qncECtdwzZnqbCvgJsQd2UYCUyibPeWsL9g7ff4PU5kaqjqCiHR/rCnnosg3Oo/HvR9D75qstbIQgyRfUcMq9CwnfUpOeJ8sYJXvP/iHYgBH9f8Ql5fHtvWFB2SjXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+6ty8NE; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ee12a63af1so2065421f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 13:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760302749; x=1760907549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FV+6yoKv/P9OgvlWPQKcQD99p3mLWnHYMK2iXPsZM3o=;
        b=d+6ty8NEJ9SIn8PG2grgbLKg8UgW2mfoRDM7bEePjYVwOqD+wMQMakeMDC+b43zlRQ
         4zdWQDSU+p2ryzkr/3kHXfX04kS4So5mBIgx9E4gSQg9wK//27EjnOkr79Zud6JUKOXs
         Lp//2gpP+V7F5/KiHC3GvpTZekiWy8wlO/V58YETmnWmXRmziaHY6sUDaMqNmV/DTQxs
         yI8wSRqckSuRTtIJdldJTDBB7YTbnFELPzUIr6ZjxvXVJj8VaOx+wHJ8Ip0qte7UxWuq
         TXLTVKAPx93hzkqsJ2xdtOta9FFMzw2oFhy1hFK3UrT2KyF7oLJhkPhIvIJtSFciycTK
         5QTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760302749; x=1760907549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FV+6yoKv/P9OgvlWPQKcQD99p3mLWnHYMK2iXPsZM3o=;
        b=atC+50rBLuKh+Ligfrsan4R5cp42TlypwJlAmXgCxH26wU33vWChlIQPFuI5rdXa28
         d6pyK+eED2pUtMSV3lEBUIaeHpt5VMolsIS4trgyO0AsTRdhKTblGMJG9FivtStWUxr0
         zXtbCk+xqbL7M8yeL+aXWGHk0Ya2Yc3m1z5R9adJ4ofPVvxKJzMN0JQKtZWtJ3C1Q7eC
         lsOjyBEZl83dduMzQA9pOdsC+FrjK7RDYRLysJz7DuApiIgGnKrQ6sPAszOuP+xBS3W8
         dxV/y+swpvglehjXwwpDobGJm2pu9lO4gPuvaEU1mLCcCi1ra5Qdoo6coeF8yWp0CYVx
         gU/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7KM23AALmby69qkuFFAIXLKBLR9Bi5Jff8v6xLb9s1IBY/FK/ZZl7m6GLfsXnuwyMoE58+3ILcA2736Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEmwJEnzEyIkhpsUntL6Y8NnJpMZUjVtxVXnIvnmnDsOoBd5jT
	fNqQIlgZKBhDe8OVclnttTtmPfFLCLUrq/DssM5Ve0Vb2aSR66NdkGxi
X-Gm-Gg: ASbGnctMKo//Wpbk0atFWNqZypmsiEVvPFKE8ruYAx5uFnljbeMP5JJgSkp7ldV/JG0
	cY7d18xOxxV+cDgKOEj0yqyvbwgUkS/k+OugvqXBu+uzgRy08cbnrzo0303UoeiMBAsSTZtmurE
	YQbxLcYk9H32GGMCcUX0BfQOFsg6fF/1THL9oIbSiiN7dm+swrJ+iHQaAoW7h0LSiI1yKJ7Cx+j
	yVp3rmtzdzJzlZtmFGPw2tL3cGxM8xH4JJYPUY8SjHFAG9Y8EjBeMxvaUayD9Nw2cUffAcsjZkx
	396lJb/TGXBGANPbw6f0U9WhW2OM2MuT84b85sUxt0u7af9PCuQdE5Srq1usL4e2tBX8EHjGCF7
	0e43sGxlTkzusisUvz6Sn0mnky+rJ3WiJCtwMpgoBXvABbPpjk5U1Y4OJTbpaUUvBzA2zJLYG35
	vBft2sQfvz
X-Google-Smtp-Source: AGHT+IHtY+2+uH13hhyazhLdneYWQO5n0wlug1GAYN01XwbK9r5lScGjBtdQeUGHDHf1GNUaqgMf6Q==
X-Received: by 2002:a05:6000:3111:b0:40e:31a2:7efe with SMTP id ffacd0b85a97d-42667177d9fmr12401174f8f.14.1760302749069;
        Sun, 12 Oct 2025 13:59:09 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-92-177.ip49.fastwebnet.it. [93.34.92.177])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-46fb489197dsm156506505e9.10.2025.10.12.13.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 13:59:08 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com
Subject: [PATCH v5 1/5] ARM: dts: mediatek: drop wrong syscon hifsys compatible for MT2701/7623
Date: Sun, 12 Oct 2025 22:56:55 +0200
Message-ID: <20251012205900.5948-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251012205900.5948-1-ansuelsmth@gmail.com>
References: <20251012205900.5948-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The syscon compatible for the hifsys node for Mediatek MT2701/MT7623 SoC
was wrongly added following the pattern of other clock node but it's
actually not needed as the register are not used by other device on the
SoC.

On top of this it's against the schema for hifsys YAML and causes a
dtbs_check warning.

Drop the "syscon" compatible to mute the warning and reflect the
compatible property described in the mediatek,mt2701-hifsys.yaml schema.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/mediatek/mt2701.dtsi | 2 +-
 arch/arm/boot/dts/mediatek/mt7623.dtsi | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/mediatek/mt2701.dtsi b/arch/arm/boot/dts/mediatek/mt2701.dtsi
index ce6a4015fed5..128b87229f3d 100644
--- a/arch/arm/boot/dts/mediatek/mt2701.dtsi
+++ b/arch/arm/boot/dts/mediatek/mt2701.dtsi
@@ -597,7 +597,7 @@ larb1: larb@16010000 {
 	};
 
 	hifsys: syscon@1a000000 {
-		compatible = "mediatek,mt2701-hifsys", "syscon";
+		compatible = "mediatek,mt2701-hifsys";
 		reg = <0 0x1a000000 0 0x1000>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
diff --git a/arch/arm/boot/dts/mediatek/mt7623.dtsi b/arch/arm/boot/dts/mediatek/mt7623.dtsi
index fd7a89cc337d..4b1685b93989 100644
--- a/arch/arm/boot/dts/mediatek/mt7623.dtsi
+++ b/arch/arm/boot/dts/mediatek/mt7623.dtsi
@@ -744,8 +744,7 @@ vdecsys: syscon@16000000 {
 
 	hifsys: syscon@1a000000 {
 		compatible = "mediatek,mt7623-hifsys",
-			     "mediatek,mt2701-hifsys",
-			     "syscon";
+			     "mediatek,mt2701-hifsys";
 		reg = <0 0x1a000000 0 0x1000>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
-- 
2.51.0


