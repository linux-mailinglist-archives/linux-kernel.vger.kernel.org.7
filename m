Return-Path: <linux-kernel+bounces-706757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31487AEBBA9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 17:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAC45645028
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 15:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB59A2E9732;
	Fri, 27 Jun 2025 15:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="J1zFNCVZ"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1402E8DFE
	for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 15:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751038030; cv=none; b=tW5Xpl3Xj4/48RPZw0QloOs/Q6phbbV03O/tgglo8uVzqHgocFJvzYswNPMlWkQYNCx6cQDvi8dR3dZ9DZ5RstKoHLhDjLu6nk1FvsD7Pw7A+bg1zgnGXA/ZfU9A2z8oKHAN9/WeRdmqOdHijAlxtxJOHLBFzHRDImW0sLNXBM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751038030; c=relaxed/simple;
	bh=otwMM5fWY0xgSp6WB5eVvdwJYcbIso6Z5/lU9k/++sI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SP6LTungquO09ZcUC6FZ3gTppZAoB/WANsE+nTmXCCuA61KUZ7mIWR4OUgq86ELea7sA4RNLdBBPXrTDtUzznxXlLdXnyE0CpCv79Md4BzxzJSygDv+U3ukrZFG8JnVwzKQ9Z+TB2wK9Gvip+qRCj3vaBqFzlOg+VvzfODK17H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=J1zFNCVZ; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1751038024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+4GMyTXjbEjmIMha8tHAOUDGLgmtdd/71eUMqcDFjFE=;
	b=J1zFNCVZ+DQhvJY+3WW4kvNr/Uk38c/t3zfr50qKgqSUFVDIz7YIcaFT5reJqyW/qOpwrz
	l/k5eBAZ8J7FmYK86B2ZsOqfSc0fvCTiKlcmSsLrJWnCIjvN1K+pufU/4/GlRVZ/ZZCp5w
	eYMiSvUQNhwxDeU802fyBkHG4dff5t3haPm20rxrLg85BWVUALrRKM5ycbiGtIkbkL9Pjg
	PYMXRr5h2bB/ihIeXzEHr1VUWCVWhzMX4b5WfI/m9D59choaXV/5ZOnTQLVXgYcF7z03RI
	YXvAxy2OlFecTGkg03vCe42m66rDQBmYAL38sm/9O7ET5rv+SYUf0ewLjV9dEw==
From: Diederik de Haas <didi.debian@cknow.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Dragan Simic <dsimic@manjaro.org>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Johan Jonker <jbx6244@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Diederik de Haas <didi.debian@cknow.org>
Subject: [PATCH 1/8] arm64: dts: rockchip: Refactor DSI nodes on px30 boards
Date: Fri, 27 Jun 2025 17:16:20 +0200
Message-ID: <20250627152645.740981-2-didi.debian@cknow.org>
In-Reply-To: <20250627152645.740981-1-didi.debian@cknow.org>
References: <20250627152645.740981-1-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The #address-cells and #size-cells properties are not useful on the DSI
controller node; they are only useful/required on ports and panel(s).
So remove them from the controller node and add them where actually
needed on the various px30 based boards, which includes rk3326.

This fixes the following DTB validation warnings:

  unnecessary #address-cells/#size-cells without "ranges",
  "dma-ranges" or child "reg" property

Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
---
 arch/arm64/boot/dts/rockchip/px30-cobra-ltk050h3146w-a2.dts  | 2 ++
 arch/arm64/boot/dts/rockchip/px30-cobra-ltk050h3146w.dts     | 2 ++
 arch/arm64/boot/dts/rockchip/px30-cobra-ltk050h3148w.dts     | 2 ++
 arch/arm64/boot/dts/rockchip/px30-cobra-ltk500hd1829.dts     | 2 ++
 arch/arm64/boot/dts/rockchip/px30-evb.dts                    | 2 ++
 arch/arm64/boot/dts/rockchip/px30-pp1516-ltk050h3146w-a2.dts | 2 ++
 arch/arm64/boot/dts/rockchip/px30-pp1516-ltk050h3148w.dts    | 2 ++
 arch/arm64/boot/dts/rockchip/px30.dtsi                       | 2 --
 arch/arm64/boot/dts/rockchip/rk3326-anbernic-rg351m.dtsi     | 2 ++
 arch/arm64/boot/dts/rockchip/rk3326-gameforce-chi.dts        | 2 ++
 arch/arm64/boot/dts/rockchip/rk3326-odroid-go.dtsi           | 2 ++
 11 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30-cobra-ltk050h3146w-a2.dts b/arch/arm64/boot/dts/rockchip/px30-cobra-ltk050h3146w-a2.dts
index 1d26164be7b8..a31c61c8f148 100644
--- a/arch/arm64/boot/dts/rockchip/px30-cobra-ltk050h3146w-a2.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-cobra-ltk050h3146w-a2.dts
@@ -12,6 +12,8 @@ / {
 };
 
 &dsi {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 
 	panel@0 {
diff --git a/arch/arm64/boot/dts/rockchip/px30-cobra-ltk050h3146w.dts b/arch/arm64/boot/dts/rockchip/px30-cobra-ltk050h3146w.dts
index 82c6acdb4fae..a3c6edfdb37c 100644
--- a/arch/arm64/boot/dts/rockchip/px30-cobra-ltk050h3146w.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-cobra-ltk050h3146w.dts
@@ -12,6 +12,8 @@ / {
 };
 
 &dsi {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 
 	panel@0 {
diff --git a/arch/arm64/boot/dts/rockchip/px30-cobra-ltk050h3148w.dts b/arch/arm64/boot/dts/rockchip/px30-cobra-ltk050h3148w.dts
index 94449132df38..9b5eff392dfa 100644
--- a/arch/arm64/boot/dts/rockchip/px30-cobra-ltk050h3148w.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-cobra-ltk050h3148w.dts
@@ -12,6 +12,8 @@ / {
 };
 
 &dsi {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 
 	panel@0 {
diff --git a/arch/arm64/boot/dts/rockchip/px30-cobra-ltk500hd1829.dts b/arch/arm64/boot/dts/rockchip/px30-cobra-ltk500hd1829.dts
index d7b639e7ccab..36b7cae49e31 100644
--- a/arch/arm64/boot/dts/rockchip/px30-cobra-ltk500hd1829.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-cobra-ltk500hd1829.dts
@@ -16,6 +16,8 @@ aliases {
 };
 
 &dsi {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 
 	panel@0 {
diff --git a/arch/arm64/boot/dts/rockchip/px30-evb.dts b/arch/arm64/boot/dts/rockchip/px30-evb.dts
index bfd724b73c9a..85d1642eb9be 100644
--- a/arch/arm64/boot/dts/rockchip/px30-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-evb.dts
@@ -124,6 +124,8 @@ &display_subsystem {
 };
 
 &dsi {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 
 	ports {
diff --git a/arch/arm64/boot/dts/rockchip/px30-pp1516-ltk050h3146w-a2.dts b/arch/arm64/boot/dts/rockchip/px30-pp1516-ltk050h3146w-a2.dts
index b71929bcb33e..932721ffd470 100644
--- a/arch/arm64/boot/dts/rockchip/px30-pp1516-ltk050h3146w-a2.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-pp1516-ltk050h3146w-a2.dts
@@ -12,6 +12,8 @@ / {
 };
 
 &dsi {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 
 	panel@0 {
diff --git a/arch/arm64/boot/dts/rockchip/px30-pp1516-ltk050h3148w.dts b/arch/arm64/boot/dts/rockchip/px30-pp1516-ltk050h3148w.dts
index a9bd5936c701..70adf091371c 100644
--- a/arch/arm64/boot/dts/rockchip/px30-pp1516-ltk050h3148w.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-pp1516-ltk050h3148w.dts
@@ -12,6 +12,8 @@ / {
 };
 
 &dsi {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 
 	panel@0 {
diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index 0cad83c5d5fe..5034ad8019a8 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -1137,8 +1137,6 @@ dsi: dsi@ff450000 {
 		resets = <&cru SRST_MIPIDSI_HOST_P>;
 		reset-names = "apb";
 		rockchip,grf = <&grf>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		status = "disabled";
 
 		ports {
diff --git a/arch/arm64/boot/dts/rockchip/rk3326-anbernic-rg351m.dtsi b/arch/arm64/boot/dts/rockchip/rk3326-anbernic-rg351m.dtsi
index 150fadcb0b3c..54395a40b087 100644
--- a/arch/arm64/boot/dts/rockchip/rk3326-anbernic-rg351m.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3326-anbernic-rg351m.dtsi
@@ -118,6 +118,8 @@ &display_subsystem {
 };
 
 &dsi {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 
 	ports {
diff --git a/arch/arm64/boot/dts/rockchip/rk3326-gameforce-chi.dts b/arch/arm64/boot/dts/rockchip/rk3326-gameforce-chi.dts
index 10e6ab724ac4..4d306085646c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3326-gameforce-chi.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3326-gameforce-chi.dts
@@ -322,6 +322,8 @@ &display_subsystem {
 };
 
 &dsi {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 
 	internal_display: panel@0 {
diff --git a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go.dtsi b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go.dtsi
index 446a1a6c12e7..bf4554eff47d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go.dtsi
@@ -220,6 +220,8 @@ &display_subsystem {
 };
 
 &dsi {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 
 	ports {
-- 
2.50.0


