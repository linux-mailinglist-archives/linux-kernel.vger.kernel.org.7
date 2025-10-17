Return-Path: <linux-kernel+bounces-857780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B947BE7ED5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B349C427E0A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD0C2E3B0D;
	Fri, 17 Oct 2025 10:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rootcommit.com header.i=@rootcommit.com header.b="QNWw0WEw"
Received: from panther.cherry.relay.mailchannels.net (panther.cherry.relay.mailchannels.net [23.83.223.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82B62D595F;
	Fri, 17 Oct 2025 10:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695347; cv=pass; b=GHuWVbCaxLt0MebbOkuTILBJ/h6oFK3Hg/l9ZYuoIb7wFpBe893TY8YJ9yLeA5ZjEOmo0qxWAso8y7fPrY3uPmo1x5frGQQqlnRJ8jsyAxsIwHq7UooAGHYUKi6TwhHzkYaGwqy5+7FdZJpo2a1rWLvl3OfOTB3Orab3/cMulKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695347; c=relaxed/simple;
	bh=J7SrZqE2MykqZKqYKMNEjc0AnW3AyYTuOcub7/OESJA=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Date; b=QMXeFU9O4jcjBcE0ZtHPGsY7cJAqxbID0BOBlrqgznHkBmoq522rE2ijc+IXvAbIfcPiNFD7HmJEbS0ZBICdZ/s4qvBCxVVDhOlmTcLAwDo+HI7M+W4E2TA2BkK4+izqYNGDIaq2x5Kg/yWMspGv7I/CRT3FP1asxR1zASFjsVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rootcommit.com; spf=pass smtp.mailfrom=rootcommit.com; dkim=pass (2048-bit key) header.d=rootcommit.com header.i=@rootcommit.com header.b=QNWw0WEw; arc=pass smtp.client-ip=23.83.223.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rootcommit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 09A642E1B91;
	Fri, 17 Oct 2025 10:02:18 +0000 (UTC)
Received: from fr-int-smtpout18.hostinger.io (100-116-176-114.trex-nlb.outbound.svc.cluster.local [100.116.176.114])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id BB4902E1D15;
	Fri, 17 Oct 2025 10:02:15 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1760695337; a=rsa-sha256;
	cv=none;
	b=yWtJxqws8ep8csveUYJdwSVv/4mIBkEMlAgHFQ9aHtSt3I+5yAacKouqTef2S+mqO3qSdF
	c5LjLt28I3w7I/W03cLskQQeozcEZz3KJxkBcCne7NNLnxzM+Z2sdfUC98R/nyK0O89OM9
	ZwhsPrrdyHydFvPD4WefEKJGQ4dw6M9Pa74jrGu4w+75j8MHcFOEFxJ61RTTVA8jh0VyLt
	vpOKGAglwHtlN9hvPUIWM8mPxuurma28CSxuyWGDdwFJBbihNsg4kI/Ku2Y+g4FVy1iCpV
	5cKk5EDyc9VCizHFQ1nUq/bITYZOudYonrDdMIbMjKGkJZKvPr1H4G6ptFIBtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1760695337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=e+L4LtthuzsbMVQgg7aAgZxuB88Q7T3LvO1UekWdj/I=;
	b=r1r0moGr6fzm2AxrQhptbsn2ka8vZgl/CEf2Qso7DxcLy+3fnrwcvfzs4Fn4Op34c3Oaxh
	U9dujecgpPQHotvNaNBCEo2r1g8PKQn9wfl5gI4+jUZOdNUkVCzvV3i/PVnjshilFgrdco
	nZqj6CJral2EemWrBH496I3grPO3ajlwPc8u/ZJ79zuo5zy/JGJKTb8GqrluqPFSDqWxs9
	pgVDXF5dwcPrKDX6DYwr7ZNqxGZun2TueHNZK4HZJUv0238a4lAp8BI36eqZega1s2wxto
	RhxCoCAVbDn60ep3VNa8g6Unnb5CHZzo7rDrB6cZ2+Vd0Ie3j1Y8IeaSYx477w==
ARC-Authentication-Results: i=1;
	rspamd-645b74df65-m6ztf;
	auth=pass smtp.auth=hostingeremail
 smtp.mailfrom=michael.opdenacker@rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MC-Relay: Neutral
X-MailChannels-SenderId:
 hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MailChannels-Auth-Id: hostingeremail
X-Print-Lyrical: 75b15046794db809_1760695337884_3215376560
X-MC-Loop-Signature: 1760695337884:1846653184
X-MC-Ingress-Time: 1760695337884
Received: from fr-int-smtpout18.hostinger.io (fr-int-smtpout18.hostinger.io
 [148.222.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.116.176.114 (trex/7.1.3);
	Fri, 17 Oct 2025 10:02:17 +0000
Received: from localhost.localdomain (unknown [IPv6:2001:861:4450:d360:2f55:e31:2877:ead4])
	(Authenticated sender: michael.opdenacker@rootcommit.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4cp0jZ4lPsz1yVn;
	Fri, 17 Oct 2025 10:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rootcommit.com;
	s=hostingermail-a; t=1760695331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e+L4LtthuzsbMVQgg7aAgZxuB88Q7T3LvO1UekWdj/I=;
	b=QNWw0WEw74xVcQ7ZAyjUeNOt2xccBDUkZ0E3xP8XS6RYlc6chIOsnkecW415ykuz9dLe/+
	zx8pExi19d/GT0Kqg/yXv/BQfIMNIPzPPdTwPGFRZQsL2JxfCtBKFk815lkgSRjvmXWkrl
	xmAV9hA5nDDrw5tQR7w+h1BvlLt0gLg09r0KfJH/60TuspBfqJuJHCksJ68WBCNea39NQ9
	QQF0HZP1qjZ7SKLIsr4SpivlnIGrRwjuMgMP3YTFCB4CUFYSy7+h5yME1KiV9SjZSNAOcl
	Bq/a5CukvjAPQ/iYKQjD7POvzoKbN2IyW/cDZ5X5DfF66ljDLBHmKMokD89mrQ==
From: michael.opdenacker@rootcommit.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@gentoo.org>
Cc: Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] riscv: dts: spacemit: add Ethernet and PDMA to OrangePi RV2
Message-ID: <20251017100106.3180482-2-michael.opdenacker@rootcommit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017100106.3180482-1-michael.opdenacker@rootcommit.com>
References: <20251017100106.3180482-1-michael.opdenacker@rootcommit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Date: Fri, 17 Oct 2025 10:02:10 +0000 (UTC)
X-CM-Envelope: MS4xfNEWRm0UNZiN0SV5T6PbToMN20Bt3SC8JFQBUchInAmHgfHddIKs54lWKqEDgPC2Th/egqXIONX72UzV1GR0qFz99D3P5f/YcFFA+0kNyqN59zDPVLFC soOO5sXVNo//pgaEt/S6AYJg+gm2GhGG9CHFgYNMctc1SwRL4DiDip5Xbz6pfojVJxu9hJBU8tYm+UE84zQ+j28XeohS63tTXI7DYXc2+5zjaSnkWJs7X4BG as/H52XpQAw49cRnpaY1vyT6LPw1nBFec3pSdeLPZvaKr8v22oIOGgAmPKVtfKk1bPDpkregEPQI7mkyPalf4L7f2Q3N4bZBYJmLLyaU/NSHKIhLT32o6sL0 7eAnR4h4WQk/1aZz5geGzZojIKD1YO5t61Pu+aLNjBPNwnZpag3nCjro64gT1IiFgtIZ8b3fYXxm3VVTUAfXGYdC2P2dnNLoPj1qrh2CvTT1RINLn3mBrMwq t/nWgj4w+9koqP4esIp7hYwijjuU/nlZqtzvGjcq5Tv6TIgKU7rq0/U3/WooMV74oEMNrnDCNf6s4O+WoEN0QuCJo2ZC5rIxr9/wPEqbyzP35YYeaFxEbY9V sehDDUB3Ccurx6ZFtBPkmfq7+22jS4FTILuLq4ggEIXwiH2o0mg///nCOOpqMknKN+9zm4KpGf9uR130tbD92/3XwLPgHa9/BEJoLIPd+1WcgQ==
X-CM-Analysis: v=2.4 cv=GbNFnhXL c=1 sm=1 tr=0 ts=68f21423 a=/5xBaVTRis1tCxhfvtIJdg==:617 a=xqWC_Br6kY4A:10 a=d70CFdQeAAAA:8 a=zpIi79OUSNkBXquUYVgA:9 a=NcxpMcIZDGm-g932nG_k:22
X-AuthUser: michael.opdenacker@rootcommit.com

From: Michael Opdenacker <michael.opdenacker@rootcommit.com>

Aligning with k1-bananapi-f3.dts

Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
---
 .../boot/dts/spacemit/k1-orangepi-rv2.dts     | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
index 337240ebb7b7..2a75ca93b499 100644
--- a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
@@ -33,6 +33,56 @@ led1 {
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

