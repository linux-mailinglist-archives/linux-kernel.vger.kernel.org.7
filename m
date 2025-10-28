Return-Path: <linux-kernel+bounces-873444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DC0C13F11
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C662188B038
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1E93019DE;
	Tue, 28 Oct 2025 09:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lF2BBvbz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B4D303A23;
	Tue, 28 Oct 2025 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761645156; cv=none; b=lzWJ1QDB4/sT0d+LdBxPP136HYBnnKz6jyiwJbGDi0OX3nZLNBJzXHE8JKO4lgRyAaniOTmEU34s8BQZ87Via0N1gPqVbBXgdKfdlVBYQ5Lg4jWzNU05ffPH9GKh1vGfMMRMSPgkZIH2X1t39NCNyrPBrNxyPG1ownCEl0V1Fzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761645156; c=relaxed/simple;
	bh=cqU+XTI3Ndty3aUBGJIBF2UDdBqJf3bOi+0Mrt4qwlg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T5tixBq5EkA4CHJzJpuQmG5toM5YvtpWxn5CAstgMWLJ4MNUbcpKH+D1KLXzUQa/Pjd+jkdv7l6nNnrGjIgbptklmD5xVbFleNnN8psIklbL1h5Ilmc1ZnloGOS4zyA21uygFVs+PBiV8Vs8+jEGuCeGF912J76EdY9EROPTkCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lF2BBvbz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B087BC19425;
	Tue, 28 Oct 2025 09:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761645155;
	bh=cqU+XTI3Ndty3aUBGJIBF2UDdBqJf3bOi+0Mrt4qwlg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lF2BBvbzMqylrxnrL9MWsz4XhkiSUt+1c8QHfcvh00cRlRDBfZkq4zsPUGyhIPjw3
	 gEofrz52i6xHJapZ1r8eRA4AlMPRsBdqcn4dgs8cAmG/OhAXFT2x0qkl0zmTMlWqF3
	 OzDja2lKWJZKumVavPZoHFoq7iD6FVQASTI5NtOIXng85GrV8G9oL792MEYEFJMN4/
	 QzTYkKHUCjXyBTUq8hn6OgbGxtM2KTqqswgcEJEI23kH2Iv3b00NZLeW2oYs1gFDD4
	 oaVXmKdO6pI7A4DbFmOHyiwwqjJSpe58Fn05pi3yf8CxgjV1k11oeMdqoXzXZdJ0rt
	 PMzjjBNbQk14g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5034CCD1BF;
	Tue, 28 Oct 2025 09:52:35 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Tue, 28 Oct 2025 17:52:32 +0800
Subject: [PATCH v4 6/8] arm64: dts: amlogic: A5: Add scmi-clk node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-a5-clk-v4-6-e62ca0aae243@amlogic.com>
References: <20251028-a5-clk-v4-0-e62ca0aae243@amlogic.com>
In-Reply-To: <20251028-a5-clk-v4-0-e62ca0aae243@amlogic.com>
To: Chuan Liu <chuan.liu@amlogic.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761645153; l=1430;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=/Yr112v7w9bKoVucDd0LbqAxSPlWQH4QEG5NVVuwlK8=;
 b=DthrWwzWNgN0aSbFCcCr3xN6xvgvMKdfIOCGZQbM9bzguyli+VJVQvXkxhUIqQi2VoL39tkDq
 WXz5pkrokz+DgPHImRiEy9gQxlyCxzZHkDQuw+RE2K7wTSPTPQZvEPH
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

Add scmi-clk device node information for the Amlogic A5 SoC family.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi | 30 +++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi
index 2b12d8284594..a6625508893d 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi
@@ -7,6 +7,8 @@
 #include "amlogic-a5-reset.h"
 #include <dt-bindings/pinctrl/amlogic,pinctrl.h>
 #include <dt-bindings/power/amlogic,a5-pwrc.h>
+#include <dt-bindings/clock/amlogic,a5-scmi-clkc.h>
+
 / {
 	cpus {
 		#address-cells = <2>;
@@ -49,6 +51,34 @@ pwrc: power-controller {
 			#power-domain-cells = <1>;
 		};
 	};
+
+	sram0: sram@f702a000 {
+		compatible = "mmio-sram";
+		reg = <0x0 0xf702a000 0x0 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x0 0xf702a000 0x100>;
+
+		scmi_buf0: scmi-sram-section@0 {
+			compatible = "arm,scmi-shmem";
+			reg = <0x0 0x100>;
+		};
+	};
+
+	firmware {
+		scmi {
+			compatible = "arm,scmi-smc";
+			arm,smc-id = <0x820000C1>;
+			shmem = <&scmi_buf0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			scmi_clk: protocol@14 {
+				reg = <0x14>;
+				#clock-cells = <1>;
+			};
+		};
+	};
 };
 
 &apb {

-- 
2.42.0



