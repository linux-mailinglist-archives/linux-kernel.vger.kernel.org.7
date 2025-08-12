Return-Path: <linux-kernel+bounces-764372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3526DB22227
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 063361889B95
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605E42E62CF;
	Tue, 12 Aug 2025 08:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="DuApqncV"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D402E6104
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754988925; cv=none; b=aM1PQHqVsyVBFKKInFcd5x+4sxtcAKJ42iaooYmMYc/sYaFYwHHEb5eTcDKJScfj7qcbOlkmuFP1lyArDPU8rL+LaZ06aVRmdcBsG632koryMpDAtPJmOpLe9PkwZ/vab3HNlImvC7V4vJY8uldXdXWqmejvr6fh2wQSgty6Kz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754988925; c=relaxed/simple;
	bh=HJL4Wk0dbCDGKi90maV0LLnT+CdJuzGRZoxo/1kQb0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fl2ltGUpBxf71XG+aR2621A5Uczul/V9u1VbMwq2r75U8Xwy557AHmDG54yOefz00DZVitKQAZkfMwg47dPnH6UCburjnYw+U+CFGmVbVrF0B3zhZgnEfIh0FAlF/ibO2Sg+Pc+dy9RN0zQcbIhJ59DsifmVPg0aCjLLgV1q1L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=DuApqncV; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=3mniuYZ7bBHdBuajGekijW6bAhy+sCr+Xt0s66tPT/I=; b=DuApqncV5Cb7vwaFa2ud3fC3JT
	iCQsRKDndDbvKFIOqdllVHzvnPxHpjfQl6jVj10CBqAt2IlF/NcBheags6e1IHVeTOKBj+PP0SClj
	OMRmKsOC7RARj/wnBxGcoLf9SdHbY2lcIhOOds/WT9dCpAmZmWWwN5eMSZtKInRpPkcv7OjVlZspO
	nP41LuxrvKunN0MV/ZwdCxmqGF2Ud+FbO6nE4csIhO4TrbTCoQFn48S2XtwbmyzbuojBHgQO1d3yo
	dqgatnzkiSOOb5Eq7sVxED/jdqZyPPdL5MQWP3qNt7nc61vnHz1LKPvEV2yhEh88w2d+ApFa+e+DL
	zebyHemA==;
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ulkmw-000228-D3; Tue, 12 Aug 2025 10:55:22 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@cherry.de,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 2/2] arm64: dts: rockchip: enable NPU on rk3588-jaguar
Date: Tue, 12 Aug 2025 10:52:13 +0200
Message-ID: <20250812085213.1071106-2-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250812085213.1071106-1-heiko@sntech.de>
References: <20250812085213.1071106-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

Enable the NPU cores and their mmus and wire up the supply-regulator.
The regulator itself was already defined, but it does not need to be
always on - the npu can control it.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 .../arm64/boot/dts/rockchip/rk3588-jaguar.dts | 35 ++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
index bcd15c1c930b..6de2ffe7fb87 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
@@ -428,7 +428,6 @@ vdd_npu_s0: regulator@42 {
 		reg = <0x42>;
 		fcs,suspend-voltage-selector = <1>;
 		regulator-name = "vdd_npu_s0";
-		regulator-always-on;
 		regulator-boot-on;
 		regulator-min-microvolt = <550000>;
 		regulator-max-microvolt = <950000>;
@@ -607,6 +606,10 @@ &pd_gpu {
 	domain-supply = <&vdd_gpu_s0>;
 };
 
+&pd_npu {
+	domain-supply = <&vdd_npu_s0>;
+};
+
 &pinctrl {
 	emmc {
 		emmc_reset: emmc-reset {
@@ -661,6 +664,36 @@ typec1_sbu_dc_pins: typec1-sbu-dc-pins {
 	};
 };
 
+&rknn_core_0 {
+	npu-supply = <&vdd_npu_s0>;
+	sram-supply = <&vdd_npu_s0>;
+	status = "okay";
+};
+
+&rknn_core_1 {
+	npu-supply = <&vdd_npu_s0>;
+	sram-supply = <&vdd_npu_s0>;
+	status = "okay";
+};
+
+&rknn_core_2 {
+	npu-supply = <&vdd_npu_s0>;
+	sram-supply = <&vdd_npu_s0>;
+	status = "okay";
+};
+
+&rknn_mmu_0 {
+	status = "okay";
+};
+
+&rknn_mmu_1 {
+	status = "okay";
+};
+
+&rknn_mmu_2 {
+	status = "okay";
+};
+
 &saradc {
 	vref-supply = <&vcc_1v8_s0>;
 	status = "okay";
-- 
2.47.2


