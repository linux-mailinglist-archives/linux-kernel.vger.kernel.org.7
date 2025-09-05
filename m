Return-Path: <linux-kernel+bounces-802691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F25DB45593
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 361531C82D02
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA29341AC1;
	Fri,  5 Sep 2025 11:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juszkiewicz.com.pl header.i=@juszkiewicz.com.pl header.b="0ZU9oZw3";
	dkim=pass (2048-bit key) header.d=juszkiewicz.com.pl header.i=@juszkiewicz.com.pl header.b="jdd8BC/n"
Received: from haruka.juszkiewicz.com.pl (haruka.juszkiewicz.com.pl [185.243.53.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F282B321422;
	Fri,  5 Sep 2025 11:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.243.53.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070164; cv=none; b=G5emlB2jZ059xGazrFvimoPAVzHbIaPTVlrzOysIToBgluBbu3QopTXUo4XRdiC0n7aNNXlySFn6AuEuPMBRdupg540iq7eeD3mnvty3MbLuiXYd8GxASd8tSI4/o8kYvMttmIQG/nv5go/oDoyzGAf3IiHhb5In2xsHCUrg5As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070164; c=relaxed/simple;
	bh=GDquDPQwE7myiK7wYOqpSjbnjrunWfiKQHBxJv7TDEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gUaxTR4uwSxLF7ZxaNYmvNXfTHlVfBiZ8DsiaHilhso6CAY2zhvSy3OhJymYbQNXwCpGW9AoSIHS7BPE1wy8LBvWYDKx+nhWSzzcg1cbPAyi6wu9oNX6WyFLCrTrk1FBg+2oV3HHw6l/6XloSeaVjFvgWjGjgYZd/xKmFJZKb3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juszkiewicz.com.pl; spf=pass smtp.mailfrom=juszkiewicz.com.pl; dkim=pass (2048-bit key) header.d=juszkiewicz.com.pl header.i=@juszkiewicz.com.pl header.b=0ZU9oZw3; dkim=pass (2048-bit key) header.d=juszkiewicz.com.pl header.i=@juszkiewicz.com.pl header.b=jdd8BC/n; arc=none smtp.client-ip=185.243.53.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juszkiewicz.com.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juszkiewicz.com.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=juszkiewicz.com.pl;
	s=mail; t=1757070160;
	bh=GDquDPQwE7myiK7wYOqpSjbnjrunWfiKQHBxJv7TDEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0ZU9oZw3bMvBmqIKXiHYHrJUEO+54FZXp8N1uujkk9hqW2PIKwEhsPxTLRMER/kz6
	 0Gmo0PZh3cSD4LccimY75W1FiYrGdjSt33z1MRtSLqgob9geTJLNHHNFjMAL/a+q/V
	 PdZCLH29Jl6o4jfTZjn/lFJtz1TQJ+CLImwZQIxMh9D0r0MY8liyYwX0LM+4rdWqaP
	 kaLTcsnuftOKqFhp0mzzrNO3+8E3nzIy6BnoadufFEx7lOfoSBVqA7i5itFzzC9BwH
	 sxb4SCGg8KnJMsEa6g137JbYNM7FqkqYWCIgxnwDOzaIc3T+d69om+T0l6U7bNaLPy
	 l+hzPxiBbRDFw==
Received: from utena.juszkiewicz.com.pl (utena.juszkiewicz.com.pl [158.101.208.177])
	by haruka.juszkiewicz.com.pl (Postfix) with ESMTPSA id 99A771FB80;
	Fri, 05 Sep 2025 13:02:40 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7D3B845400;
	Fri,  5 Sep 2025 13:02:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juszkiewicz.com.pl;
	s=mail; t=1757070159; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=bmM37TIebFwc91NhuXnorA0dNpqLiDvcznMp+hRuFu8=;
	b=jdd8BC/n1OesgTO6l/Axdof0r/fcOuuXchbuYEJZ6G8gLdq5lOl5JNxn4VFsSsKkxgkDLU
	6QWT/KGNCa4Zjf4jCmVzUX+J3zSwWL9bpar9VjRVhWifpHDfhIAMHJLLZdehDHhRrcvn9k
	hkMNeMKOarkADE8AXi23V8AcykB1YQsKWOgpwtOxpKrDxTyCmATsGpmsuRa+3PJY74Jt2V
	EgElnb1q152ttxn5nKHsQqwDAwlv/Eh8XzzyiICvAOPY+2LyQN0VYUdq/2kRuAGh79H4VH
	CgIeJ+lHoMCx9LFGVynJSePY++PykprfmM0GrHgK2sYrDweqYtzxFxWrctXbUg==
From: Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
Subject: [PATCH 1/1] arm64: dts: rockchip: enable HDMI Receiver on NanoPC T6
Date: Fri,  5 Sep 2025 13:02:30 +0200
Message-ID: <579370818ef3b70b57bc5b8846f3b330d091d9a4.1757068166.git.marcin@juszkiewicz.com.pl>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757068166.git.marcin@juszkiewicz.com.pl>
References: <cover.1757068166.git.marcin@juszkiewicz.com.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Let enable HDMI input port.

Signed-off-by: Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
---
 .../boot/dts/rockchip/rk3588-nanopc-t6.dtsi     | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
index e359d74f20885..6fe151d2cdb45 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
@@ -391,6 +391,17 @@ &hdmi1_sound {
 	status = "okay";
 };
 
+&hdmi_receiver_cma {
+	status = "okay";
+};
+
+&hdmi_receiver {
+	hpd-gpios = <&gpio1 RK_PD5 GPIO_ACTIVE_LOW>;
+	pinctrl-0 = <&hdmim1_rx_cec &hdmim1_rx_hpdin &hdmim1_rx_scl &hdmim1_rx_sda &hdmirx_hpd>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &hdptxphy0 {
 	status = "okay";
 };
@@ -629,6 +640,12 @@ usr_led_pin: usr-led-pin {
 		};
 	};
 
+	hdmirx {
+		hdmirx_hpd: hdmirx-5v-detection {
+			rockchip,pins = <1 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	headphone {
 		hp_det: hp-det {
 			rockchip,pins = <1 RK_PC4 RK_FUNC_GPIO &pcfg_pull_none>;
-- 
2.51.0


