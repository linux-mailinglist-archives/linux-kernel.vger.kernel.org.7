Return-Path: <linux-kernel+bounces-781989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BB6B31994
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DFF64E4B05
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A26302747;
	Fri, 22 Aug 2025 13:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g68YPzzb"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284CE2FFDF3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869485; cv=none; b=b8IRPnGOW8bxwTzKQMWwoPzgwm9dTM/QvhI9eOkM/FEEVrsOd6Xs3Ivgi3KCdjGBUJcqbLcN0xFe+UVURerrl8oY91DJeN4XxPJsmv7TPsOqMcySrcwqPaSlyJIvOHDLaPtlMU9mj1VbSj3NkKQ5izSL5VYpCE0YY+WQVbXvtUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869485; c=relaxed/simple;
	bh=8E6nImJ8N1opGmR7K7GVvgClRbKq2rqRED8a2qwcAxQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XHb2vLS7uh03o7ERRwu21qXR5mXiyJxQy7KhZx8Bl2iub90yABOcRaAVnFzUUlgwSjZ/U7tPJ7VzMWsYtqwJD6XstX8Mew4KwnBVFyGuLBGgyaawRq4mpYqqUf0OVqbf1MOI3X5u92UYvvJwFItxAp2h8USsTmQfmmSJM7/vyV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g68YPzzb; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afe0a80f3fcso33473366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755869482; x=1756474282; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sXR/Mce4wnzCN/euqWV2Ip2YQgL/Gld/DHXWnsUXf5U=;
        b=g68YPzzbJRS2U9PH35DIeU5HYurh8sNlD0paypuoV9e5CIyQywxza/fI/zFFkbLn7c
         UPGWEWEi3CExsb7AVVqflhshHhijyJzW5QhsrirUo8FCMlLEc5ixGmyal+KAmahQqvwK
         RA98bm+9L8dZRwmC2ooBJn8Iu9oQCPEdHnh6ow2Tp3RiFbg8VVwXybBqRwZCOuYXVIWi
         wov7CoFmrPT2xiGjdLmPH7bHPnpsB25duhBXBKhVDGHBVkQm583CSMORJ6jsfzgyFJBu
         P0zsPbaU+NR1aOR7yh1t0nGGnCwFh9fBJZmWlCCjyyc4Mgr2u9PYTJB7IruqD106Y2bs
         4Sbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755869482; x=1756474282;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sXR/Mce4wnzCN/euqWV2Ip2YQgL/Gld/DHXWnsUXf5U=;
        b=nF6mlAgrFWjsiXd4jeTyY7OI2xdRWtB3lWqaKRRW1N5LWdWl7pIhBDBXI+w7Nx11Q+
         XtsisKhonetv7z50OsMwLOuaNsFGsYkPtKaoIsy6WeSKyqyefnyXfWXdZWyQ5TgXj3RX
         Pur5O11LKel1KON3x+bpsTzRfgnZXdZr447fe3Yfgn74bPEiit7dli4YEBQ2KAtNbpxA
         gNdy+Sr4YUwI7bnv4smuTvAfIjkMfTytIvdGIkgWzrv2JGXlGweQSnT//Vk+XmSB1Q1k
         GzKEI0vnw/GBA74MN5ACfVXdXpYcgLjtDQ5QVScC5urTzfP04LJg7aDpvQY/7EhSubr2
         Jxng==
X-Forwarded-Encrypted: i=1; AJvYcCXzyZgHQJwgYILqpiPR55aBQ3LI9Lnb82v/nash63xjZ9uyNXV7VlBfIhfj5+NEuoOkCVlB1k3KnR2MKdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHlJHpefrPMc1/VWImb3SDyqaTqIP/qbcqeNhfbmzOWlXP0Mz2
	v/mBO8J245YXr1dyExfVWBcq5Cf/YvvzjTLfNdcWGcFw8+i/mwLhwFXDFAWOmVZ1udk=
X-Gm-Gg: ASbGncsCdIeaC7VMTgK/gxEh8NOAdqwv7hPticqbJyNwhZ7trs79MCacZuHTaX8EZPe
	pZ7Zczox5hgWhd/9wEY+2jXk2FBJsP+zuYXbP/gygX8aAGHEzALEap98bmoar54VRydkdhwslU9
	LYE0VDLTNhzjg2oOp89pQIN9gkn/dieNJZUQqQRjUFKwHFK5aUoRKfogjhWojtxoN1CBo9lrdZg
	kXaRVwqPFc6YTEs+LEn7DyYDLX5/7ybCU8iBlhdQVaXqAJrt3Ik4GzDz8GSOCVxULSsqj7rSk9i
	6tErz70Sb/f7kZPDEv3NzHT/96Xz1Okw+l12xljQQEvXmAKMrhClWf5KN5jv6KjyWKesQfwOb2d
	R2gD42DgrT72OXOFuazurshgUtITdEh8Jy5OL/VPv4XttkQA6/Q==
X-Google-Smtp-Source: AGHT+IE1SyS7rdAiTfqSibtZfokao085p20ry5c6FKV9TDDo0DnlnMgSkdOJ4Z1Iyt5EsBmYWbKM5g==
X-Received: by 2002:a17:907:6e92:b0:af9:6666:4acb with SMTP id a640c23a62f3a-afe295279f9mr138617666b.10.1755869482347;
        Fri, 22 Aug 2025 06:31:22 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afdf24bc40dsm554863066b.109.2025.08.22.06.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:31:21 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 00/10] arm64: dts: freescale/nxp/imx: Minor GIC
 interrupt-map cleanups
Date: Fri, 22 Aug 2025 15:31:09 +0200
Message-Id: <20250822-b4-dts-interrupt-address-cells-imx-v1-0-f1b479da9340@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB1xqGgC/x2NQQqDQAwAvyI5N+CmiuJXSg+riTWgW0m2RRD/3
 qXHmcPMCS6m4jBUJ5h81fWdCoRbBdMS00tQuTBQTW3dE+HYIGdHTVnMPnvGyGzijpOsa/HbgU0
 bA/XzeO8CQwntJrMe/8njeV0/GPNdgnQAAAA=
X-Change-ID: 20250822-b4-dts-interrupt-address-cells-imx-45a128fb371d
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1713;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=8E6nImJ8N1opGmR7K7GVvgClRbKq2rqRED8a2qwcAxQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoqHEfkFR5SYp6LIxDwIDpcspsTQNZOP6eApiR0
 nS5WmK7QLOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKhxHwAKCRDBN2bmhouD
 10JzEACXW7APJRig+9Zh6eycLANivQsTEwANrpmd+3ax0sbYfgY6QZmkaTbajHW0mqLqGx5qT09
 Wl+6pVSZ5648eRy/NFIhmrw2R/qYgWb43mbRqx9FyOOoNLn5HRjv+vOhDX+QjADkgW+ar7USaBK
 XsdAcnQe9chvXnwPD4Wta63I7uqczB56/wmt94B1pfVyPwUJMgeNqt70+PGCvCn4qoo0T3q7Sur
 Q1m/qVsJIX3dBFk2/xElUddPPiCiPX+eb4RkvxrJSm6f/WlbG9aMORnoxMw2m8GktzxLNxic/ra
 R36wXN0kGTkIynY/jm7n63paNMnF+xixTE8ZAimjMWRjutg9xf8pYRRgg9guBvT5xc+F3H1w8i6
 tK49RrcKVoY+6GowWiNp5jsoycJ80jCV+jxRlHHQvUSz92Ui0peThrbEC6hS6AdAZ1iPb+DN4QY
 rlD1zs2ap2SxjISRpxBM/xjoTfeigfgpWkOogXtgkHCXGkhykAYKnK1We0H8wlDmyFnNX8b9dZD
 f5o5CgjqGSLyUm+nGKDRKBAku9xJ72jHmtgQBfv/+qyWOiDZmMQuLbXnG/oPD/QACNrSa4JAr1A
 01BVWhlM+Guez6MGZbrRfxYk3Osvcqvi8OVQhP0pa9CWgR4hLUoVmoHEsTZ8O5+KmdO7C76iJN+
 XDPt04+eMv0SsGA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

One W=1 warning cleanup for Freescale.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (10):
      arm64: dts: fsl-ls1012a: Add default GIC address cells
      arm64: dts: fsl-ls1043a: Add default GIC address cells
      arm64: dts: fsl-ls1046a: Add default GIC address cells
      arm64: dts: imx8dxl: Add default GIC address cells
      arm64: dts: imx8mm: Add default GIC address cells
      arm64: dts: imx8mp: Add default GIC address cells
      arm64: dts: imx8mq: Add default GIC address cells
      arm64: dts: imx8qm: Add default GIC address cells
      arm64: dts: imx8qxp: Add default GIC address cells
      arm64: dts: imx8: Use GIC_SPI for interrupt-map for readability

 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     |  1 +
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |  1 +
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |  1 +
 arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi    |  8 ++++----
 arch/arm64/boot/dts/freescale/imx8dxl-ss-hsio.dtsi |  8 ++++----
 arch/arm64/boot/dts/freescale/imx8dxl.dtsi         |  1 +
 arch/arm64/boot/dts/freescale/imx8mm.dtsi          |  1 +
 arch/arm64/boot/dts/freescale/imx8mp.dtsi          |  1 +
 arch/arm64/boot/dts/freescale/imx8mq.dtsi          |  1 +
 arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi  | 16 ++++++++--------
 arch/arm64/boot/dts/freescale/imx8qm.dtsi          |  1 +
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi         |  1 +
 12 files changed, 25 insertions(+), 16 deletions(-)
---
base-commit: 812efb8b495f2ca50795062b77415b0e8d9d7e53
change-id: 20250822-b4-dts-interrupt-address-cells-imx-45a128fb371d

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


