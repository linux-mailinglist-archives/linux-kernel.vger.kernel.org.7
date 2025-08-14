Return-Path: <linux-kernel+bounces-768414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D19BFB260D8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5685417A7BA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BB92EA466;
	Thu, 14 Aug 2025 09:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PsKs6Tyf"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1535D25DD0C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163517; cv=none; b=A2zSPtEl2vlh0y66OIEyPl7HRg0XjGxoI1VXNuFvJ3Hm8GVDQq6TUKyjKg0JifLWi9292WFTpmWMYRy13oFUJT4ek5x7SuqmDJmoRHK756iwu9gfgWBRfxA0u1j799S92IuqSjdWWyMylMUtyaWw2mHzFWuMwbJhxOVMW9S9iy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163517; c=relaxed/simple;
	bh=HsynHpb83ZhD6GViMz9Q1kfIxKLg8QLma2UUN9gxsmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VQF53Bzg2i56hvlITur2YnhZe53Rxfvm0ZVO6YQx7ukrl4yNdS22SqTiUevJiXVVoK25ZUpn+2qYxPq5poZGBCLmaYXeUk9dkaEev7BXRvvlsu+jN5uneujbFymcW9pcI1jvFw9KieP0YLheIqn8NttBVZwhHPf/ux2woMztQfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PsKs6Tyf; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b47173a7e50so542232a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755163515; x=1755768315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=enM03Y+SofNC9f2L6BJ7C/DVoLrJlmtDheNAd8lIknI=;
        b=PsKs6TyfzqpwHWagwykfeT02NhXAi2y+o+VxQdS0346QjJLsYpZXV8Jv4MEiTI2oQa
         cOjO6svpsdXuV2BBppwVArmRh/bXslM20pSeTE9Hvx9to8OZUQPN9IhhHveNIuTUwLEG
         TkbhQAaLLRIHm6b9vwOl58VTVvyn6P9LlYdck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755163515; x=1755768315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=enM03Y+SofNC9f2L6BJ7C/DVoLrJlmtDheNAd8lIknI=;
        b=WcZcR5a5HbLaygMNbj5lzn4jxuIaEP1t3r1AnhcG6fwXiPfNiaUPcua7qwsMnvr/jw
         eatqcJNVcvL2EJNpUH8FcQYvoGY6qd0Wz4nDtT3xL/Dwc8Cdxp5Q3uPig159y+QeOthv
         +rkPk0k+OOHGYhFSLADknDvKw5cyrmG+kiR5Cb9dnm5GwCS26EyRndCBhRdo/ozLj3mi
         eTMziJWhnJBdiCSi2ZVX44iF9D8uwLnWv8fJ+S81/Fp9YNpj00fLHi5w/1BVot6JdWbn
         KXEJB1e3RYPU4Gvd9h0hpeRrUAg/EVFCijAyHqCoKONCcOzLPfFWmp2UulWnFsoY6rXJ
         ZPvg==
X-Forwarded-Encrypted: i=1; AJvYcCWGHpe5CSdVLj47JgVmBQPziaSN9RbfIojRNRPbFWPYNimS2loHxy6VImzx3El4mrFsDnBAKr6HY85Dlyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOzVu434rlMMldLSPIWfRNVb4fmaZpHy++/oxTPIamz7ne4HyL
	l84dtPJhoC/gvqlfmunSXWc1bIhxDlzsNxJHZc1zXGQtCpnlVhtNhWfgaB/IRFqENw==
X-Gm-Gg: ASbGncvTwNaGLrWcc5YoJ7hFYEctAjv+xnKphCfFxLDLFhZOxn328uEAQBGfnc3JQL4
	Bh1v3OjR4o/okaTPeoDBl2FNKCnBGXhiqp3yVsjOe1F0W/FmMXKfVPwpKEnQ3hyfZHnLQ0mbn3Q
	GVWyDiQJbezAQeNOtuWsT+gxO7tjEKZQsoBORvFkZ0Eyak4t867cZIUUz/QxF2Ck0L8hrlpRHl9
	XzZcCVxT9tbaDmzhfcHTIEfQdrJlI6Mq8Jt9S/i7YM7+raPh5ymsEviEkYmT266EbQtkUrU1/+0
	HDMemsb3j/hUHgSfjfBFx/3hjHKWvi+IvXyMKQi4zOFj9fh4FwTLVKgq7AoQJCxpMvW0Y/cPpPD
	KLRwyYzbF5Zaj1iW+mVbdQcHGOPIxs1jGgydvYCAV
X-Google-Smtp-Source: AGHT+IEGaNwQwUsuoFyhAT0RG891ff1UB5Uya2JxWtJ1QeDXdtqAdYENXV7IRVwIlXojpGbzegP6Lg==
X-Received: by 2002:a17:902:e84b:b0:240:3dbb:7603 with SMTP id d9443c01a7336-244584dc1d4mr36979635ad.19.1755163515364;
        Thu, 14 Aug 2025 02:25:15 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:c44f:5805:6bc2:66d4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976d13sm346186645ad.109.2025.08.14.02.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 02:25:14 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fei Shao <fshao@chromium.org>
Subject: [PATCH v2] arm64: dts: mediatek: mt8188-geralt: Enable first SCP core
Date: Thu, 14 Aug 2025 17:25:08 +0800
Message-ID: <20250814092510.211672-1-wenst@chromium.org>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first SCP core is used to drive the video decoder and encoders.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v1:
- Added SCP vreq pin
---
 .../boot/dts/mediatek/mt8188-geralt.dtsi      | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi b/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
index c5254ae0bb99..7fedbacdac44 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
@@ -164,6 +164,12 @@ reserved_memory: reserved-memory {
 		#size-cells = <2>;
 		ranges;
 
+		scp_mem_reserved: memory@50000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x50000000 0 0x800000>;
+			no-map;
+		};
+
 		apu_mem: memory@55000000 {
 			compatible = "shared-dma-pool";
 			reg = <0 0x55000000 0 0x1400000>;
@@ -1077,6 +1083,13 @@ pins-bus {
 		};
 	};
 
+	scp_pins: scp-pins {
+		pins-scp-vreq {
+			pinmux = <PINMUX_GPIO98__FUNC_O_SCP_VREQ_VAO>;
+			bias-disable;
+		};
+	};
+
 	spi0_pins: spi0-pins {
 		pins-bus {
 			pinmux = <PINMUX_GPIO69__FUNC_O_SPIM0_CSB>,
@@ -1146,6 +1159,18 @@ &postmask0_out {
 	remote-endpoint = <&dither0_in>;
 };
 
+&scp_cluster {
+	status = "okay";
+};
+
+&scp_c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&scp_pins>;
+	firmware-name = "mediatek/mt8188/scp.img";
+	memory-region = <&scp_mem_reserved>;
+	status = "okay";
+};
+
 &sound {
 	pinctrl-names = "aud_etdm_hp_on", "aud_etdm_hp_off",
 			"aud_etdm_spk_on", "aud_etdm_spk_off",
-- 
2.51.0.rc1.163.g2494970778-goog


