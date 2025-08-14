Return-Path: <linux-kernel+bounces-769316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FFDB26CDE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B381CC6070
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698B02FE061;
	Thu, 14 Aug 2025 16:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="T0kpRHZk"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319002FCBE2;
	Thu, 14 Aug 2025 16:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755189808; cv=pass; b=DtJnGTI76w9B9KSnjoRjrDzH78uZxGOU+mAiGaQiYRVVSpPfkOqOkTLWcZwkmWhCDVqZ/77pMVdGdLH8ndv544T9a63fDWRPjsAQ3hHLnra9j/mrK0IV+omDwcJ+Xs1x1iyKeWhSoYtEQSNSCy11iKz7Jlf16lz4f042G0q5Mac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755189808; c=relaxed/simple;
	bh=ENZ1+7/+j3nr0/o+GMakKlIvX6sDyZFbBmuIFOc/l/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVXSYXNkEUznFClSQi2P0gGfJZ3qc9GrJEDlZOTeIPRe9KrwOhP8nadkJSGKMbWpTi0aoMORvY+ZiLjzlYeyTLkCdLZYHnY+YlKpqj/SAYieF+DO1uBlSLPJVIq2vzuagSBDnGk4+lS47juhEE+aOY0l2gicXSJFhXwiM71nKRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=T0kpRHZk; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755189777; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jfj0+VWHCsZnl/l4c3a1pQTfXoieDJV0XOVyg3FD16n4duOOyFGHrPkl9SXnfpdu5POIXlDfb7/dKQxlFhcqGy40pFT2NMy7JC43rNxP0Vv2R+bZZN+gwAvrVzc+lZPTE6D0FC95tPXH45w0OHPHCgJ+/SxdxNl8/7kqVRS8RNs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755189777; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Hwz9vc0DqxjUR0hsEGwe0fb6hBhA6TWrtV1S0jJoekA=; 
	b=TSXYZW8SmhQfoadpYqJ7l+gJfTsSfAejhY9919qwXVCyfwdEiL1jctfkx6ugiKtZIs8aMtIhO0drwo+c3aeFECJZa/rP1WYg4r3rwKRbXEFKuv3c/Kp9OvzqIGH0JVcL0KQeD2oE1FvS4ypV58aLLNrqI3imkJRg8fvnGZP3+ig=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755189776;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Hwz9vc0DqxjUR0hsEGwe0fb6hBhA6TWrtV1S0jJoekA=;
	b=T0kpRHZkG8e2If1kjhEHml/HZ5Kpeo0jMLMXQ3EcZggrEY6fe9oL8aoRSmEUAHxb
	4nYrjIxAxucFIirguTAHtwvoAABwOw76s72C//qizlqlG3m4yGcvkZjtIslnQCzIO8V
	yGE+hX/cjDmP0mzClXNeSCAYzGF4dBr4Qk6IcXiDTG763mlGmfkBz7IBziCK8O1h9hD
	L6n5cwJNM7rMxxl1qMEeoDLgtiV+EQ5ZuS+F4CNc4Ugo1tSWpbgQTvQbdt/wQVc8Dpb
	B5sdNknkoNPHfqFINb4YdSFjt35LYeXXGdQMNMbMyf/K2DPiroHnQ3NT2OhUWJXcOSN
	NBSZpP5JKg==
Received: by mx.zohomail.com with SMTPS id 1755189774001869.1159628547316;
	Thu, 14 Aug 2025 09:42:54 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Han Gao <rabenda.cn@gmail.com>,
	Yao Zi <ziyao@disroot.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [RFC PATCH 7/8] riscv: dts: thead: lichee-pi-4a: enable HDMI
Date: Fri, 15 Aug 2025 00:40:47 +0800
Message-ID: <20250814164048.2336043-8-uwu@icenowy.me>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814164048.2336043-1-uwu@icenowy.me>
References: <20250814164048.2336043-1-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Lichee Pi 4A board features a HDMI Type-A connector connected to the
HDMI TX controller of TH1520 SoC.

Add a device tree node describing the connector, connect it to the HDMI
controller, and enable everything on this display pipeline.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 .../boot/dts/thead/th1520-lichee-pi-4a.dts    | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
index 4020c727f09e8..3e99f905dc316 100644
--- a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
+++ b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
@@ -28,6 +28,17 @@ aliases {
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
 };
 
 &padctrl0_apsys {
@@ -54,6 +65,20 @@ rx-pins {
 	};
 };
 
+&dpu {
+	status = "okay";
+};
+
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_out_port {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins>;
-- 
2.50.1


