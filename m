Return-Path: <linux-kernel+bounces-826084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FD7B8D7B7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 10:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A99347B2DF5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 08:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CD82475C7;
	Sun, 21 Sep 2025 08:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="UfF29hF1"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76717245005;
	Sun, 21 Sep 2025 08:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758443853; cv=pass; b=kFwdhSgnxbA3JUUCq/0Tm65cqKAyv45p91buIIl0S/7UTMXt7LG/tZfnyR484rqqKOWmnoqLvqxWb7znsROI/91kmUr66utJfL3FUpCCvb8MzyuP9vuOCttprZhE3fsB8IE5ruDzHX2S4/ZZgS4gWjR/RzT+4WuBtgFtY0ddHGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758443853; c=relaxed/simple;
	bh=8fGGb5vMfRTqsz37MGb+srjgn0HOdqThDS/upQGPYKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DVAk6YqQIuSccBgLv2Kv04b/1KmRvn5muOaat2Iez/qC2q07AY9wnA59n01zWn68Pr50B/pR01yPurE4xXZaYAyTUOZMtMNjz1/vb61FwxMQtqQf1XWd/2Rm4/YXJadzhdG27pq7XL05M0ksBXsjILyIFsAK79YDDtjuaizm8+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=UfF29hF1; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1758443816; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nxXNMqI2qg6zufy0Xd4Y514jhC0IROp7AKcI+Aanga4iNtC53S+f5SZL28kR7zqaLaKqnEOeEdfFgZZaSSjYIl0mPPFMAT0Cfj+G3lVh2nZNyrNxZVjiKR3/GoZHdaVYCpz3JnsLttwE6Cp1y1to0+RcxHJ1/L0hbdOyCc5ma+8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758443816; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=codWgtTq6Zb64pUUOo3Dzr6/p0mx/o9YUriH+67Le3Y=; 
	b=OZWl27m87tvRQ788UMUql8HK10J3MIqNzlvXMwQJ6vcMokzda0xrsNi1mptshA5/cIUt62X0XQwyo2Kwce7HsF9ciMa7SNzzEdzCZ3gWW6yMssgRly90DoLOJlLjfMz8uHa4eOqQI/gTI5BvQ4YI2x/0TvuxOnixhzNoEKr24fc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758443816;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=codWgtTq6Zb64pUUOo3Dzr6/p0mx/o9YUriH+67Le3Y=;
	b=UfF29hF1PQmU2MZ1Ge9X15w6oi2ao/rzoft/tWrDjnjk2+okrjGjfXRQI0xCNBub
	UVPT3Tu9DJNDAtKt2eW1Ew/fDjDHd3TkCa2aPYSrXtqQTjU56WEdmdLjKlQhqFARjHl
	9Kv/R6793q+gkpEcZc/12JSK9MGbqJyzG4soMAFYY7MuMUulyjY2dnOdw1Sb/XuJPnu
	0+L3lyKvwsuruJcQQU36oQFC1hRIcKxeOtkaDoWCgrPH5134OWdtyuud08tftrbvXo7
	tdUzRqiYaUOkkC9VjOPVYWn3caGMCW2Yy8ltlL9OjUuFbLZJWH4k+QyFquq4NOfjZ00
	vQCziCay2g==
Received: by mx.zohomail.com with SMTPS id 1758443814250482.2030454290558;
	Sun, 21 Sep 2025 01:36:54 -0700 (PDT)
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
Subject: [PATCH v2 7/8] riscv: dts: thead: lichee-pi-4a: enable HDMI
Date: Sun, 21 Sep 2025 16:34:45 +0800
Message-ID: <20250921083446.790374-8-uwu@icenowy.me>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250921083446.790374-1-uwu@icenowy.me>
References: <20250921083446.790374-1-uwu@icenowy.me>
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
No changes in v2.

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
2.51.0


