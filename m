Return-Path: <linux-kernel+bounces-786753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6F6B367E1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8991A1C282B8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7199352FCC;
	Tue, 26 Aug 2025 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bcc.bai.ne.jp header.i=@bcc.bai.ne.jp header.b="LmixlWzC"
Received: from rmx-c.mailgw.jp (smx-c.mailgw.jp [210.171.6.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2541E7C08;
	Tue, 26 Aug 2025 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.6.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216713; cv=none; b=JmnC56n4uDgZsNdtunjXBCR3ss/Wi6WtmEcN+skZBxlgSIIJwyCBNMHTSJ3yrchcF3CEOWvQJWygDWsTmRP3LweljckBXpLaCC629uIYEL4lqF1IrsVbtfG/JWPC3fFt0Qc/W6mzvntfh43vus3CuK8QvnhO93DTiDtQtw3B+h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216713; c=relaxed/simple;
	bh=HfAyxLmtvudUzpYt25poT0KRL89hapJ69x3yWpzOYIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZjWMadjjYXR0tUmNgfc0CE81aSgpA+8Md3l+8GRL3Vu4a55ZkuEWsIVEyDX4FIuDQmklT77rG51/OFLkY36iqFRJ/g/+hC2ekqh+KFajmGHNkY22Sfh4qzKrEa4lxH+yhLFhS8jw5N1d2jrfpCQqDf7vRBcpNyp1TFaZwMY0nf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bcc.bai.ne.jp; spf=pass smtp.mailfrom=bcc.bai.ne.jp; dkim=pass (2048-bit key) header.d=bcc.bai.ne.jp header.i=@bcc.bai.ne.jp header.b=LmixlWzC; arc=none smtp.client-ip=210.171.6.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bcc.bai.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bcc.bai.ne.jp
Received: from bccml.bai.ne.jp (bccml-a.bai.ne.jp [210.171.3.161])
	by rmx-c.mailgw.jp  with ESMTP id 57QDlnMh024478-57QDlnMi024478;
	Tue, 26 Aug 2025 22:47:49 +0900
Received: from subuntu-desktop.bai.ne.jp (bai859bcd79.bai.ne.jp [133.155.205.121])
	by bccml.bai.ne.jp (Postfix) with ESMTPA id 758818177B;
	Tue, 26 Aug 2025 22:47:48 +0900 (JST)
From: Hide Hako <opi5plus@bcc.bai.ne.jp>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Hide Hako <opi5plus@bcc.bai.ne.jp>
Subject: [PATCH v2] arm64: dts: rockchip: Enables sound output from the audio jack on OrangePI5 Plus
Date: Tue, 26 Aug 2025 22:44:57 +0900
Message-ID: <20250826134456.9636-2-opi5plus@bcc.bai.ne.jp>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FE-Last-Public-Client-IP: 210.171.3.161
X-FE-Envelope-From: opi5plus@bcc.bai.ne.jp
X-FE-Policy-ID: 3:1:23:SYSTEM, 3:1:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=bcc.bai.ne.jp; s=20240516; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=suYwX1lPYNA6J6Ueqpvg+LFYiHTraJArpH2l0vR/ubY=;
 b=LmixlWzCVDA81Kf9yqqXQ7bEBimnLAJZxN/07d1we8P282n2P7cgUGDqJIw1ikGE9YeiynriSRxK
	fXARS9Yxmor5LScCKSbvQbL69nIm50edBH530vFGUVbRwbAXOT8DZ4J/P7lyDr0putmCdmZqAV+z
	pSSsG9rquMDXuxTgshitDl3NTum3P5ghimnObeZVySAHLbzDEfXFk5B5U2U5Kt9vlIksxSGWNEzs
	/Yzmg8DICkkgE5mhQ2ileCjOuMkKqaF7C+PNOQhKczgNSkq1gAxkq1AbZmwvGTSM/4kya16mbzMI
	BKnpAbuIuQmbGYlxZOwGY40rDWWRDavFgNWAog==

Currently, analog sound is not output from the audio jack.
This patch allows you to select analog headphones in alsamixer.
Works with kernel 6.16.1, but not 6.17-rc1.

Points of concern:
6.16.1 kernel with ubuntu 25.04 Setting -> Sound -> Output Device
 I select Speakers Built-in Audio, the sound will be output from the audio jack.

Changes since v1:
- As pointed out by Jimmy, the file to be modified has been changed
  from rk3588-orangepi-5.dtsi to rk3588-orangepi-5-plus.dts.

Signed-off-by: Hide Hako <opi5plus@bcc.bai.ne.jp>
---
 arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
index 121e4d1c3..44bb15951 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
@@ -78,6 +78,7 @@ &analog_sound {
 	pinctrl-0 = <&hp_detect>;
 	simple-audio-card,aux-devs = <&speaker_amp>, <&headphone_amp>;
 	simple-audio-card,hp-det-gpios = <&gpio1 RK_PD3 GPIO_ACTIVE_LOW>;
+	simple-audio-card,pin-switches = "Speaker", "Headphones";
 	simple-audio-card,widgets =
 		"Microphone", "Onboard Microphone",
 		"Microphone", "Microphone Jack",
-- 
2.48.1


