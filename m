Return-Path: <linux-kernel+bounces-764373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDBEB22209
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D4574E1177
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7972E7632;
	Tue, 12 Aug 2025 08:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="V4R976l1"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5CD2E62CD
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754988926; cv=none; b=JpZxYd9rlfEQGurl0cnXSHNGCbcVPqz5Uw1EKURHT8pvs1jWy5MyzWO/w1nYku4ZZuGZdbrW0ATGc775xdURrartey7kyycxCts9HCya1EZFi6qGkPJs9+fzn0wqTqLKXON+hS53jm+YSb+TTWP/FLkdo8uT8YkBEfsyfdl0208=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754988926; c=relaxed/simple;
	bh=BmFq1an3RgdsN6QyfYhMjonXJsuEtb76Qp1AMFfLWu8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p2rdDLjSZjrxT9563YY2+faPK6eKtD5Z7il7Z1PVKH1euxzCcCFNx8X6telLu745tzHoKDteF/hkf4nXe5ejRvpl6rvGjOMzNRO3EPGjfxgpqrO4NWP70JhMiwnDTCcfsPbbhsUo7L0+ki5pF13nxefYl9IkwIqzt1GN9MzW/cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=V4R976l1; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=MhHZW6hthHOTqU5AnSY9eoFzl6RVNxZgiD/4xqHXVpw=; b=V4R976l1wwKKMirfxSg0Mc4Pyd
	otyYTmHGz3rGhVvNMOBE5COmPZ1UcFpa740mnlWxWuTM89cox0QhocY4SQJnRNlTuAi696BJOSztZ
	zY3gtRiEVKSbeGGQIjc5+qVNsBU3+jWgzDMPt+9LfYujk9rWLuTT/8joVSt9vaEqakVj/Lu+AL9+F
	vt+cXoKuDt5N/0BHVDKfmQdvFFXGr4BtzQaR9uAtE6GYfz0breOB4kLUwM5pmu55RQiPO4hxKWblg
	F5Hatcd4p2PNzjoJYR/qd8A3T63iFZCeN6SbQmXTvey8hOdk2ZE3TWY2kYIEB3qYx58acClhwx8rQ
	Nl9DQRVg==;
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ulkmw-000228-6W; Tue, 12 Aug 2025 10:55:22 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@cherry.de,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 1/2] arm64: dts: rockchip: enable NPU on rk3588-tiger
Date: Tue, 12 Aug 2025 10:52:12 +0200
Message-ID: <20250812085213.1071106-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
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
 .../arm64/boot/dts/rockchip/rk3588-tiger.dtsi | 35 ++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
index f4bebd25e938..9859f31d2894 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
@@ -194,7 +194,6 @@ vdd_npu_s0: regulator@42 {
 		reg = <0x42>;
 		fcs,suspend-voltage-selector = <1>;
 		regulator-name = "vdd_npu_s0";
-		regulator-always-on;
 		regulator-boot-on;
 		regulator-min-microvolt = <550000>;
 		regulator-max-microvolt = <950000>;
@@ -337,6 +336,10 @@ &pd_gpu {
 	domain-supply = <&vdd_gpu_s0>;
 };
 
+&pd_npu {
+	domain-supply = <&vdd_npu_s0>;
+};
+
 &pinctrl {
 	emmc {
 		emmc_reset: emmc-reset {
@@ -375,6 +378,36 @@ &pwm0 {
 	pinctrl-names = "default";
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


