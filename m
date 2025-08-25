Return-Path: <linux-kernel+bounces-785709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9DFB34FE4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 02:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A4C017F489
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 00:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0567D39FD9;
	Tue, 26 Aug 2025 00:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFQlXYte"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A037262E;
	Tue, 26 Aug 2025 00:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756166550; cv=none; b=gl9k466zBizS0ZQoTCFYrH34xzwdOb5NLHdw0B/iaXlqeNIOzySGzJ2T27Ln3DmLcANDMwNdeGSTI8RpO427LPXmY1Z2yZyEsQL/2vO1fUiA3yLTHmOQpaYzRNqDq8rzIZIbGtP9Eoa+p4hpxM/vSEhK7Q0RO4pdDcMmOY3uBV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756166550; c=relaxed/simple;
	bh=6wpLT61gIiqUq3ZvBcjcj+NeMJ4khUVS2TRpHGP+2lE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g1DnMFkH1RUZY9ZgRNFUgty7+OZRUZdJ3FWNXbfPAkCLr6ibveHMdzcgBcMt2uQcHxCgLbdniyzqGhf8RYdA/OgSdu9sikU02EbKTOQH5qp+KkT9RwZPWxayAB5pmNC8zXS3TAYgioMIVloo42hRDDsg32YFWWP5oqSxcP+Gxks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFQlXYte; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE51C116B1;
	Tue, 26 Aug 2025 00:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756166549;
	bh=6wpLT61gIiqUq3ZvBcjcj+NeMJ4khUVS2TRpHGP+2lE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HFQlXYteHdhd6lDz0GobrCZG5yoPAj0jr74d3AGC3y6M5FOEVSSGpeovfU+Wm9g8U
	 Bnqk4g2G/3p7v1t+mggicQ/JEQ2eHNNfMb104iqeLE92IgCLGNJD8Ap3H6mEto+C+2
	 1yzn/ciCiRkKlIMK9NmNv5AKvhziJnpMwkqC5X1jfo04A54fHXZsDJzSOwCDas6ywi
	 q+CXR5zsmPHS1wqPNzPhtuauBXCF2mzf0gQyL+518syWqrcdUy79eI0TMqgNe8CkX3
	 rLl9lRetCKRC9cxcLAgUCOUJgBoASH2RCSPI9lSmDdiKGUwNJT1cTzkxNIvFPq2zr+
	 oqfjGM4YoijUw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Richard Leitner <richard.leitner@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/3] dt-bindings: usb: usb251xb: support usage case without I2C control
Date: Tue, 26 Aug 2025 07:45:07 +0800
Message-ID: <20250825234509.1041-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250825234509.1041-1-jszhang@kernel.org>
References: <20250825234509.1041-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the usb251xb assumes i2c control, but from HW point of
view, the hub supports usage case without any i2c control, I.E we
only want the gpio controls, for example the following dt node:

usb-hub {
	compatible = "microchip,usb2512b";
	reset-gpios = <&porta 8 GPIO_ACTIVE_LOW>;
};

Modify the dt-binding of usb2512b to support this usage case, and add
the usage example to the examples section.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


