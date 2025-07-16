Return-Path: <linux-kernel+bounces-733135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 048EFB070B0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62873188749D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA31A2EE97A;
	Wed, 16 Jul 2025 08:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="kw8DYr/s"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14D34A11
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752654858; cv=none; b=fO6hi6OujpCIAfOHxqHLsBt554hrwYi4gH2557n0ixgSyHYtFeqIVXLnOCoIKuQhWqbSyCGTAvWUjnqvhgmTKEY8UahT9x/TNiOc1BRpc4ziz2MBdVed+5knqHlLu0aVCFEgMmtpOBm0RHODTUI09tvzkqaG3dhhjKUMUBM2fY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752654858; c=relaxed/simple;
	bh=ydOKoqOKw48ncDCsXKz/D/L7szBR62IeOqgtQXpK0a4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CTYAycTHFl4iGQhZj45BKy7YuLVF2Nblufm4aFuzBu+kOsr90okT3Lk4beZv6GQ8mbovV1ZYaNY2+9L66V5B+Ccry6Yok3wr+3zbyeVdBvhjeT+9d9asM4rNupmXueo3cUtoFCGybK9mAaaaFcrIg+PEJRO7ztjCy5M1kiR+aco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=kw8DYr/s; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1752654842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=S8/W6hICoFcDRQTv0VXVXPyibPJUZoDyo7YncpLNyV8=;
	b=kw8DYr/sutCa5fwfr6RBJuRaN41yB1dumvTFOuKWQbwfa+vZLP1kHi/Yw98H0V/KPPKjWI
	VGk4tZGFrnwvKC+9z/or9CX1k7C9KLok60tEV1p2jaXj442qKUwgwShGgTBmyWsOe0Q6Ur
	OmdB889BCa9O7qG07r9Jhg0RB3hSdhOOnS5HvmYKYI2d/baPI6iqoev4tCgMj/d24HsKXD
	piGKGzmy3L7avBwIf6jeLjMuiMAnt4jRI5N9D46DrBL4Motlt28K4xMuJ1Ws38MDyvx9Sf
	a+Wcm/rIPrAQSfVWxz4klgccZUdFjGhOE+3UKe8idfrkr5q7y21MO+YiW5lEFg==
From: Diederik de Haas <didi.debian@cknow.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Dragan Simic <dsimic@manjaro.org>,
	Johan Jonker <jbx6244@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Diederik de Haas <didi.debian@cknow.org>
Subject: [PATCH] arm64: dts: rockchip: Add maskrom button to R5S + R5C
Date: Wed, 16 Jul 2025 10:33:35 +0200
Message-ID: <20250716083355.327451-1-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Both the R5S and R5C have a MASKROM button connected via saradc.
For both the R5S as the R5C it's described on page 9 of their
respective schematic, identified as 'Recovery'.

Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
---
 .../arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi
index f4d042bdd328..e3f44ea4eabe 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi
@@ -25,6 +25,20 @@ chosen: chosen {
 		stdout-path = "serial2:1500000n8";
 	};
 
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 0>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1800000>;
+		poll-interval = <100>;
+
+		button-maskrom {
+			label = "MASKROM";
+			linux,code = <KEY_SETUP>;
+			press-threshold-microvolt = <0>;
+		};
+	};
+
 	hdmi-con {
 		compatible = "hdmi-connector";
 		type = "a";
-- 
2.50.0


