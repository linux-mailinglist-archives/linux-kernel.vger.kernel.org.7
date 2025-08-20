Return-Path: <linux-kernel+bounces-778192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7A4B2E26D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507B65C48F3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D1D2D9EE6;
	Wed, 20 Aug 2025 16:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDXtRT2O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E250C33436D;
	Wed, 20 Aug 2025 16:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755707701; cv=none; b=tKjsV/aWIET+9/Bus+PI80tPscQvf3EztDCY4xBHD/7D4taYUCsc5Wi1mcN3EDpSFnIdSTyaiGVGC6aXY2LlLVF2QjurS3y4vxUEcTHORHBMcivXFrOAgnhmcuZklt//nTpBf1glt25/tasJ/FiTpfUBjL/9WipyA6013gEDwZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755707701; c=relaxed/simple;
	bh=F2+S7JuA0+6UNOcZ/SoHAGIqOEtfGdSDYuVcjGpwJPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DdR760aeIQ5JXzXtJbDM1WD5mjs6OE7yoD7UN62AriOghfs8iwo/El8Vo9OPn0MTewPB57C5FlNCPgRPO4cgXAXl4A/phx8v+KSIfzxIlduaTpIibauNu0Hikkee1t8Cbn4KH9cneANVY6QWn5DRa26A11qTY+Fr+J4JdCVw2SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDXtRT2O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57187C113D0;
	Wed, 20 Aug 2025 16:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755707700;
	bh=F2+S7JuA0+6UNOcZ/SoHAGIqOEtfGdSDYuVcjGpwJPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jDXtRT2OQKg3JgaAy/D+tRMISzQlmj3Cbp2/q7gDazNXNmjH1hgDOgh6CvxONZIBS
	 3+c0s4HNQU910GitArYX3IWVqpSrdANf8+4EkYrbtDVNRRguQ16TMmLmzF1UHj0pkf
	 ZcJLXnvq5Tt/fC/zT4FE/51jiqPkU23jIkT9FXRdlPNEB22WjJZvSArPcSN50CUj+H
	 eSCb+pX6RcKNPokwTVqf+GWPoK+59BOZcSpeduYCxeX7BCt+XGlzdeqILDu1ujp7A1
	 9MVLHjCpS0lgFRhhVSBLWCBwOb2FUYSIIJDHupdmGWDafHc5aEu1VOBtYXFANRCTv7
	 Bs5J/8EEraPfA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Richard Leitner <richard.leitner@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: usb: usb251xb: support usage case without I2C control
Date: Thu, 21 Aug 2025 00:17:41 +0800
Message-ID: <20250820161743.23458-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250820161743.23458-1-jszhang@kernel.org>
References: <20250820161743.23458-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the usb251xb assumes i2c control, and the corresponding
dt node looks like the following:

i2c {
	usb-hub@2c {
		compatible = "microchip,usb2512b";
		reg = <0x2c>;
		reset-gpios = <&porta 8 GPIO_ACTIVE_LOW>;
	};
};

But from HW point of view, the hub supports usage case without any i2c
control, I.E we only want the gpio controls, for example the following
dt node:

usb-hub {
	compatible = "microchip,usb2512b";
	reset-gpios = <&porta 8 GPIO_ACTIVE_LOW>;
};

Modify the dt-binding of usb2512b to support this usage case, and add
usage example to the examples section.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 Documentation/devicetree/bindings/usb/usb251xb.yaml | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/usb251xb.yaml b/Documentation/devicetree/bindings/usb/usb251xb.yaml
index ac5b99710332..0329a6aaaa92 100644
--- a/Documentation/devicetree/bindings/usb/usb251xb.yaml
+++ b/Documentation/devicetree/bindings/usb/usb251xb.yaml
@@ -240,7 +240,6 @@ additionalProperties: false
 
 required:
   - compatible
-  - reg
 
 examples:
   - |
@@ -269,3 +268,11 @@ examples:
         swap-dx-lanes = <1 2>;
       };
     };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    usb-hub {
+      /* I2C is not connected */
+      compatible = "microchip,usb2512b";
+      reset-gpios = <&porta 8 GPIO_ACTIVE_LOW>;
+    };
-- 
2.50.0


