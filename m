Return-Path: <linux-kernel+bounces-865839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A592ABFE244
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 22:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F1521A052B6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DD72F7462;
	Wed, 22 Oct 2025 20:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rootcommit.com header.i=@rootcommit.com header.b="Kf8y/zWb"
Received: from siberian.tulip.relay.mailchannels.net (siberian.tulip.relay.mailchannels.net [23.83.218.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CE62F9DAB;
	Wed, 22 Oct 2025 20:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761164333; cv=pass; b=ope1Ej9qU33ocY8Lt4By16Ap1aWDNnxFCRx9SOulcG+vT628ALMBiCEFpArHKCqC0t7BcLTiwQom5dMq01MgoNf6IANc/9XoLoTUaGrWOMBL9W1hJQ73HNrMkg3D4ERUMhlmPhDvlgZdVXd50CxSx1vgvCg5ebpN6DR49R73maI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761164333; c=relaxed/simple;
	bh=Ca/HvlnX/gZo5VVOMRxwoouA4WP1TNOv0ZBvSyO09Qk=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Date; b=ehhY/twCTi7qnJbNLsxwNgJOrvAkEwXM6TmDRuFTrgySe+F9kuw81X8Qu4ttpa9FCF6ZgeCPhqeA9A2stsEv9UWtGyh7F//84dSy/jA5exzKygBB1TPfmCmMQfnw9mVsBUGWGjvHCorOrpSEq3lM0wxTohzYBJwNaIAbcIdvWwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rootcommit.com; spf=pass smtp.mailfrom=rootcommit.com; dkim=pass (2048-bit key) header.d=rootcommit.com header.i=@rootcommit.com header.b=Kf8y/zWb; arc=pass smtp.client-ip=23.83.218.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rootcommit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 1DE54504741;
	Wed, 22 Oct 2025 20:18:44 +0000 (UTC)
Received: from de-fra-smtpout8.hostinger.io (trex-green-8.trex.outbound.svc.cluster.local [100.119.46.77])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 3128D504387;
	Wed, 22 Oct 2025 20:18:40 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1761164322; a=rsa-sha256;
	cv=none;
	b=fZRTbeimbofalQJevaIU6n7DSoH/UDeTEDkhUOdYfuK8SIv59HBf5y5aS/WfYK0I25gbGU
	kkP3pWrxSdx+gn9pQO6/dAI+9blO8oLpZPsjV5132YhCZIrSzf6w+KqR+2KaZpoqilWxQR
	ilYSnbnnVXo56x3KM4rdmzZ+qL+PfkbABTEJ+0I3h2WJX2wOXJIXj4VWyx6hUqexpbe6YN
	ms0aJLsuy9efsu1GIShTTAFSB0FjREuXKlBEiWWemN6RJWPxv8JAHKFSSYhO7fj0waZg/Q
	hhEkMt+eKwj2DpvME65UfVc6Nxjz5HSiqDipyFaJiIu+qW8qGRpGb8PbpJNBCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1761164322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=IayKEbkgWGAXICgQmVJqimgGp6s7RC6SqFcIxOt/Cow=;
	b=FnHvNLOMIlql2R11ue51TSmmidHa5h0ThuOZc/nywYolO9YNTZshsJ98M5hBnz8eacr7ZV
	hOIhg1h9uMsmIRI6emyNgy2dn6xHF1noDTrjc3vCbRvN/pIi/bqPZEm5hztWs8RJKOb5lS
	bdQKoyfhjJXHPKA7aaHZo+A32wvF7BzXty9TL+V3QE5+ATZ4AOeQM7H2b56weCE6ykYdM3
	Si9YnRNXfnZ6bRsjHsMIHhH44angePUbrRwrJYHCVLKET08B5VxE5+ARVSiCA/lG6W8mIJ
	syEONKthqkosSzxwb6FfwlPP6zmFH/S6QVWd+/mG5TbDKr0AkdVJqz5fTsLgLg==
ARC-Authentication-Results: i=1;
	rspamd-5b5956c7c7-6m7zr;
	auth=pass smtp.auth=hostingeremail
 smtp.mailfrom=michael.opdenacker@rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MC-Relay: Neutral
X-MailChannels-SenderId:
 hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MailChannels-Auth-Id: hostingeremail
X-Stupid-Glossy: 3697a34139ab00ff_1761164322787_986877117
X-MC-Loop-Signature: 1761164322787:3907238689
X-MC-Ingress-Time: 1761164322786
Received: from de-fra-smtpout8.hostinger.io (de-fra-smtpout8.hostinger.io
 [148.222.55.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.119.46.77 (trex/7.1.3);
	Wed, 22 Oct 2025 20:18:42 +0000
Received: from localhost.localdomain (unknown [IPv6:2001:861:4450:d360:df8b:aa61:9538:1b7a])
	(Authenticated sender: michael.opdenacker@rootcommit.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4csL8Z0V1Rz3wnP;
	Wed, 22 Oct 2025 20:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rootcommit.com;
	s=hostingermail-a; t=1761164318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IayKEbkgWGAXICgQmVJqimgGp6s7RC6SqFcIxOt/Cow=;
	b=Kf8y/zWb70UHVm7PhYkkqtKGBci4td1IQyy8rLRFk34n+tQQyzD1Y8Nk6O7aiU74+O5F8J
	jtI6jQb3H+IrnbcCvVZVm3eEuiggpIx+TVo1aIzc5VJRGPpGvfSXrW2T88eUs3Q7vLouQk
	ceh1/o5OWAksDOsyXKV3Z1vMAmmAdjZ7jPoz+l8EWFem92WLV53CvZqSU5WeCDy/UrLAKd
	wAvRVPF3sqTUx6xIssHMKT3N1ptmi8chCckceRPbHwCppca2sF5fZyKr/7n3lAQLeJcolF
	KYsepLzn/5F4zuxQtlYRnjLTr1qc2ipWFFefuy1wp+eECA0oFJasrMH4NiKZhQ==
From: michael.opdenacker@rootcommit.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yixun Lan <dlan@gentoo.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	Emil Renner Berthing <emil.renner.berthing@gmail.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] riscv: dts: spacemit: add Ethernet and PDMA to OrangePi RV2
Message-ID: <20251022201807.1474789-2-michael.opdenacker@rootcommit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022201807.1474789-1-michael.opdenacker@rootcommit.com>
References: <20251022201807.1474789-1-michael.opdenacker@rootcommit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Date: Wed, 22 Oct 2025 20:18:38 +0000 (UTC)
X-CM-Analysis: v=2.4 cv=ALriHGRn c=1 sm=1 tr=0 ts=68f93c1e a=XzW6OEp4kASjoDH3AA+DzQ==:617 a=xqWC_Br6kY4A:10 a=d70CFdQeAAAA:8 a=pGLkceISAAAA:8 a=7mOBRU54AAAA:8 a=1xgkj7NNNoY4BsVt7o0A:9 a=NcxpMcIZDGm-g932nG_k:22 a=wa9RWnbW_A1YIeRBVszw:22
X-CM-Envelope: MS4xfGgxslif6O+Km/CHVW7/ZxUgv9CSVGJfZLtGrXoovb8+BntLcTRR5LVAzRa44v9R1NEGR77x0lGcuIfonmZQtsNkKFw9pZ07aoQRDYYQ267P353g2Z3s essj0wyMJJAZWdkRt3XEPjzznD1CrjOjXd9xkbsPTDnlPIUJrp7qeQE2OuYbp+s0PAmkgXMus06bNhMTEI4rYrTtT1UD+gfDG4GLNsA/9HB+xAumA+zlBGnj 0pFfln1wo/xRRyOIxL4APgjx8bRWTzRubCp6TK10Nhe+IlANWXxnixY/1IGlopuOLz4iJIoIweJjY3l9cMjr/8b8O+3CnpP2ZQQHm4b6MugxCf2FzydNLk8y jiDJ2QpFYFctrrTIPU2DAHQgoQ19Di7viOHWWrOctnjhXOlvsS5QPAVG4CM9d6u3S+J13+V3aJwnk5KKXHWICKSnB2ORQ5oDEhwSH1OOYeisX19fEaMilM7O DeyNtv6D6cbBOFb4GDm0sdv3zsQM0FVFypLFCvH/5+pJaOupY1/LxkfzaTbyAEU/IheCqi6Nb9q98fcTHn9JJVw6Zm2be2fEkWvHdA4ElZaYuENFB2xEGzZu /APf52Ent9eSp58QX2Lbp7GaaOy0lh/WlGeEAOme7Y5shq0aXYed0o9FyvXXBAlUk0x/H8fRuug0A4zAy2lpw9pgE45mRaH1YDnTY0+/OuQMd/fw88jPTuAB taSEjj9l6xkYsJ8cO3fzl5PEu01W/8WoNsoyL2AAoVYoMbXtk9ocd4cejrq5Fgy+9sVfxvt1l3U=
X-AuthUser: michael.opdenacker@rootcommit.com

From: Michael Opdenacker <michael.opdenacker@rootcommit.com>

The OrangePi RV2 board ships two RGMII ethernet ports.
Each has an external Motorcomm YT8531C PHY attached, the PHY uses GPIO
for reset pin control.

Enable PDMA for the SpacemiT K1-based SoC in the OrangePi RV2 board.

Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
CC: Emil Renner Berthing <emil.renner.berthing@gmail.com>
CC: Yixun Lan <dlan@gentoo.org>
CC: Vivian Wang <wangruikang@iscas.ac.cn>
---
 .../boot/dts/spacemit/k1-orangepi-rv2.dts     | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
index 337240ebb7b7..41dc8e35e6eb 100644
--- a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
@@ -15,6 +15,8 @@ / {
 
 	aliases {
 		serial0 = &uart0;
+		ethernet0 = &eth0;
+		ethernet1 = &eth1;
 	};
 
 	chosen {
@@ -33,6 +35,56 @@ led1 {
 	};
 };
 
+&eth0 {
+	phy-handle = <&rgmii0>;
+	phy-mode = "rgmii-id";
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac0_cfg>;
+	rx-internal-delay-ps = <0>;
+	tx-internal-delay-ps = <0>;
+	status = "okay";
+
+	mdio-bus {
+		#address-cells = <0x1>;
+		#size-cells = <0x0>;
+
+		reset-gpios = <&gpio K1_GPIO(110) GPIO_ACTIVE_LOW>;
+		reset-delay-us = <10000>;
+		reset-post-delay-us = <100000>;
+
+		rgmii0: phy@1 {
+			reg = <0x1>;
+		};
+	};
+};
+
+&eth1 {
+	phy-handle = <&rgmii1>;
+	phy-mode = "rgmii-id";
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac1_cfg>;
+	rx-internal-delay-ps = <0>;
+	tx-internal-delay-ps = <250>;
+	status = "okay";
+
+	mdio-bus {
+		#address-cells = <0x1>;
+		#size-cells = <0x0>;
+
+		reset-gpios = <&gpio K1_GPIO(115) GPIO_ACTIVE_LOW>;
+		reset-delay-us = <10000>;
+		reset-post-delay-us = <100000>;
+
+		rgmii1: phy@1 {
+			reg = <0x1>;
+		};
+	};
+};
+
+&pdma {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_2_cfg>;

