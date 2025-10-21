Return-Path: <linux-kernel+bounces-863335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B596BF7940
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A8973BCDC3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E81345CD2;
	Tue, 21 Oct 2025 16:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vm2bICuG"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2203F3451AB
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062776; cv=none; b=OWvh0dH/j378M24upJuHNh2u6YBdYcF0o3ZTM6QhQAxjufyPIL3dqMYJwXz7OpJ+vl9yDx3X6kGb1loUs8Auha9FQbH4yR9yJ+/CAlhSJW0lo9WLgJ+9F3hDEqV1yvzU4X2y/U7kZxQD25b1W91p+ZeoYq8ku6xhVHwzEBqd+Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062776; c=relaxed/simple;
	bh=uk7aoZWw/Pmc3N7zSyYQt2iO1kp7lxeZJc8qrKXCzcs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fpAm4mDT0rAAC5lR40lIGjAPVL97OnufNU7WRFqx8uQxUPOBA3+8JbVqt3BLBIdQPot7xFTDikzTx/jyPOrr7Bx9XYDDxxZjId4s/EWYKtHkuuAbh90zeRh+z4l0vzXTL6Z27YBkuJ0mLpQeXrvRhXb8klhwwgm09+uVUOeaLII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vm2bICuG; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-471075c0a18so60862815e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761062773; x=1761667573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I+ODemdtelodNngZ+cnMjkBp0uDC6f3Gz3zokiA/WGA=;
        b=Vm2bICuGtbAFEpjj0K6dZmoQp3l5Jkkqms6D5FMGWx3FjuKJCCUyVyhiGzMHn9275p
         2QdGkdRPCh0qaXF6+WvqNARHerb34VeB1ZqIet3dQLuE0tYaDyDRYlSkhOuWihjBOB35
         2M356mxHwmC/SQBMWD9roi+WeoNiwraEg7kq7mgJTyFyS0MJNoW9qJ5cZTmiMrkjmbVn
         DRRR+yrVdQnHdxvZa0kPvAdxoSXpyv+ceAvL4qZIEvyMVmzmlednSF8OaQX1HG97Tmzo
         XB/mh3MuoVGLb7BrHzr6fgQWdYWNE+trHX+sOu8T3OPkMcn/cHSjE97kZ1PyRGkzFIHN
         leXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761062773; x=1761667573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I+ODemdtelodNngZ+cnMjkBp0uDC6f3Gz3zokiA/WGA=;
        b=JBXFpNkS71cOjjE/z7XMzmMwnRRcj+8r5OfOQAh4DOZRq02UwDSZ2Zctjdzq+qow8B
         4IOENprD7ELuCeO5LMeQOCQQ7XR93yU3fKkpJG2RMlvZx2ggB1TvwTp+ZH7qtwWhEc+S
         yN/4l6uSI1pi6e5NGyRtHqHAHyjDTWkFO9QFqDO0At9HatquUgOYvBzxcHbCujLK9j7O
         X2klcRIUWBwgGAEmx8bBsCf7i11noMRPLZcafLzHz6W9QbZPDcqe0LnMnxSat0R0HgyF
         CvGUSPVkuR3Hq4bY0bs8rYot010C2FJkTR6HfiQQBYTnAxJyBlPKHhnwQKwji2eQeUZM
         8rgg==
X-Forwarded-Encrypted: i=1; AJvYcCXjHsL4W3wyikbLtAZfrcdVkEjQJDiHG2LXKLS3H73p/UIAV1bYNaw5KtUf1aP+mVm2ndg045grUaPuiak=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPLsVenA+vAginfq2dktGg2WXEvZew+s2bF1DZl2JiETxDIePd
	CV4OjAWeydIEPsvLsgALfTMr60vbgKan7s7O+jVjx0hzSKxiPUUchwT2
X-Gm-Gg: ASbGnct+gXwaKrgTH7MV5QNdzq9r5UTX2+5xgGwB2Ifmi95SUs+X5K5hPh8oinNcmka
	2j7LB4FPxJeCRJJOPUfFKDWTVuBG3cd0O9635mfN3hOi3XZXH+7BgbwZ9SRaGvY5B/IGv5JgDY7
	sx+JcYPKS5LZYAkfJcFvnvx1z21X9zIMfG5uon6VIlw+bKgjlni3aCi15HWY0i8mEJi93oP5Gdo
	Pa1YskIQB7GjBgydCN81E5jTuERvf3pSRIPAp+ty5vO3ei3EiB9lv9PZQWbRNrDFpMwToHhChVi
	0MMpcjXH6oLM6nbdmeHammd5lWDXKG3a83yXCBabBb5jPEdEu3Es3CermOkK7B5m5OhwjhO2AZP
	GP/9qBzcKwqQkspcQW7SNNNk2pYu/+lELU1bHdzjJPINBJU3pFeeWlNFqrja4gopHBKeIDFAewN
	6B+SFR
X-Google-Smtp-Source: AGHT+IFJFL2AbUhadEu3zoiSmflGJqqKLGGnSqi38T2TvHgGSGw3DXC14Yf1ANAfxEsqrqF6d4xXtg==
X-Received: by 2002:a05:600c:450c:b0:46e:38cc:d3e2 with SMTP id 5b1f17b1804b1-47117906a23mr136429645e9.22.1761062773077;
        Tue, 21 Oct 2025 09:06:13 -0700 (PDT)
Received: from debian.. ([193.42.96.237])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496d26affsm18543965e9.12.2025.10.21.09.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 09:06:12 -0700 (PDT)
From: David Petry <petry103@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Damon Ding <damon.ding@rock-chips.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	David Petry <petry103@gmail.com>,
	=?UTF-8?q?Valentin=20H=C4=83loiu?= <valentin.haloiu@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: rockchip: Enable second HDMI output on CM3588
Date: Tue, 21 Oct 2025 18:06:02 +0200
Message-ID: <20251021160603.96934-1-petry103@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the second HDMI output port found on FriendlyElec CM3588 and CM3588 Plus

Signed-off-by: David Petry <petry103@gmail.com>
---
Changes in v2:
 - Fixed commit message according to feedback from Heiko Stuebner
---
 .../rk3588-friendlyelec-cm3588-nas.dts        | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.dts b/arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.dts
index 5fbbeb6f5a935..10a7d3691a26f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.dts
@@ -101,6 +101,17 @@ hdmi0_con_in: endpoint {
 		};
 	};
 
+	hdmi1-con {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi1_con_in: endpoint {
+				remote-endpoint = <&hdmi1_out_con>;
+			};
+		};
+	};
+
 	ir-receiver {
 		compatible = "gpio-ir-receiver";
 		gpios = <&gpio0 RK_PD4 GPIO_ACTIVE_LOW>;
@@ -335,6 +346,22 @@ hdmi0_out_con: endpoint {
 	};
 };
 
+&hdmi1 {
+	status = "okay";
+};
+
+&hdmi1_in {
+	hdmi1_in_vp1: endpoint {
+		remote-endpoint = <&vp1_out_hdmi1>;
+	};
+};
+
+&hdmi1_out {
+	hdmi1_out_con: endpoint {
+		remote-endpoint = <&hdmi1_con_in>;
+	};
+};
+
 &hdmi_receiver_cma {
 	status = "okay";
 };
@@ -350,6 +377,10 @@ &hdptxphy0 {
 	status = "okay";
 };
 
+&hdptxphy1 {
+	status = "okay";
+};
+
 /* Connected to MIPI-DSI0 */
 &i2c5 {
 	pinctrl-names = "default";
@@ -840,3 +871,10 @@ vp0_out_hdmi0: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
 		remote-endpoint = <&hdmi0_in_vp0>;
 	};
 };
+
+&vp1 {
+	vp1_out_hdmi1: endpoint@ROCKCHIP_VOP2_EP_HDMI1 {
+		reg = <ROCKCHIP_VOP2_EP_HDMI1>;
+		remote-endpoint = <&hdmi1_in_vp1>;
+	};
+};
-- 
2.47.3


