Return-Path: <linux-kernel+bounces-779312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D24B2F26D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3501AA485C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE972C11E2;
	Thu, 21 Aug 2025 08:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cRKn9U+t"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A6B2BE632
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755765159; cv=none; b=Cqne1whHv12d3wGAKyhgbOBdJxGpBM7uPCG/js1gLfrsrvpZiUWWJp9W/4xmagKBAR9kJDN3XVVgnkQzRCvP2TY7vaWE0IqZjRxz4c936Lzudsb5vWXfgn6ZwfoCOv5/oJLodEgL+v1H/wEotaaHyCRsO9ZTmGzeKO5Dv1YJly4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755765159; c=relaxed/simple;
	bh=aiOPgCva8kudkEPl+V/XfNEIoC3r9JUXD0el5mRjFUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qPVWxbmX88OUNqKnmfaVFtW2sl8mIdBEr8shZ+XkjYBlaKR/b3MxxKy4p5ssCBxDs/jAdRtJkcmqL5eBaG/+SKmO6H6AazT4oYgZT4jQo7iX32O2pfjfWT+70CjyC50bLHHYZ0ILW9snbYfecxR46yygdik0agswzhtePpH2Vr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cRKn9U+t; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb731ca55so8526866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755765154; x=1756369954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2tpMok2B6oSFp46bPm9JfIyRCEx8l+K6LCpsnmOC61A=;
        b=cRKn9U+tm20Cldh9/5ac1FLmv5qTvB7XX8b/OlPgwgkcHMXchpk4foQR903V8sdeaf
         9uTkrTfFgJmexqWimkFZWq3tvfegECj4Fegrw1U8SqjdofQ4AwbTIYX5Bfy8uuryGnbA
         xBi1K4Sd8xSBv6PdeEA8l4+cJ93lq97+l5WfLAl9AoQJ6aDq6hwRHTXQtwLtroJOpUvp
         S8/y2LotpM78x6t86AOOnzgFhcabYZZLhodFFZLs2TSWQIMgsspeW2PqPkcgbACrv/M+
         4AbGhbJB2gITvxVuHMG6UUw6earSl8Xwd+Ff1H/Ac+4HZtZkjM6Sf2eia9DU4vHcStUW
         Ye+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755765154; x=1756369954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2tpMok2B6oSFp46bPm9JfIyRCEx8l+K6LCpsnmOC61A=;
        b=QWdPzZq/8wManbwBDAKBzZZsqKCuG0VQXTismWO8Fy/xWIxQfxzHuGDImClZJ9MBAQ
         WQdYjSxdxGRYj+ow3KZKqgF44PgxpQL1k8Um2eUxCWNbb1LAzMD5bKx1zYZDzr1bEV96
         4aF7irddJjEtkgLIfs3xhYchc79K1E8nDVquAh9iE+kfUqoiNIS32bBWMxWbMj24i3iR
         j94t4yWIXdGtULWW2vRJJzyuv6Z2dvdxYdfA7PebKx1PXnmmWXUcXgxbXq4t8NECuYFx
         sACAz7aGUd+jbKowVsMn8hhn49SLnoxc6Y0Y+YI3STSinko+iJiSoAlYy44R2Bb9XcQW
         ktFg==
X-Forwarded-Encrypted: i=1; AJvYcCUMNjdNYBtZ+LZ9CfT1cd1rYJmvZ81yLdONVKuQRSwysP2bM07Je6DG2mMb1KD8YM/ZYAL2mV5fvOzOGoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLKV++jTIEe2Qpnin6tuZib/BTMVRife9cKUjf+9y20R5zj3cj
	eQh0zcUUv71bry/Sv5i7fIoGO7NBnHfIk1AsLbW2HTRIzlfLKqk7/PsSwZofgzlgCVc=
X-Gm-Gg: ASbGncsmllLc6cjjneob/ylSYHSnOUOmyrDkjVmf2lQUPnUgfaAb7ym8tkYzB2ZiUNS
	IpbHQxWtILE+FMa7Xoh4/K/9ROYwxXt0okA3zgkzcP18VGZAwEfGjKGVfd3J/QeThbRwB77muO7
	meFOhJ7+uYElFj227TPn/2xl83ZW02TFEySGAJelk0x8mBKuqJoMd2sRdUn8K1z1dqVDs+EwNPU
	d17V5oXCG8tjbQTaw8Uo+0MSbUAN8fonwko67037GcZjyitbqRdZb8Iah5SXGnLsK02RUi6QY1L
	lPTInbUG+cmiqzMbAq8iOBzew/r/AWWf813BgLBnOyz/C3Tf28LOGmfKxwacae6K9RzPpYBq++S
	cx+fiYROl+FnIKl7uFOkBTPo00dX8tqgLRg==
X-Google-Smtp-Source: AGHT+IGrKLDvcNhMPRRUz5yZ/0B+UqV3cuCDD78GAK5IX9VMQFlpjMOiQBg7/gspXEwR8WFrVNM3Ow==
X-Received: by 2002:a17:907:94ce:b0:ae4:1093:d41d with SMTP id a640c23a62f3a-afe07618e48mr78991366b.0.1755765153518;
        Thu, 21 Aug 2025 01:32:33 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded478bfesm341676166b.60.2025.08.21.01.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 01:32:33 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yixun Lan <dlan@gentoo.org>,
	Lukas Wunner <lukas@wunner.de>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: gpio: Minor whitespace cleanup in example
Date: Thu, 21 Aug 2025 10:32:14 +0200
Message-ID: <20250821083213.46642-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1764; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=aiOPgCva8kudkEPl+V/XfNEIoC3r9JUXD0el5mRjFUo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoptmNfZQGc9s1xwN7F1mVlmTvdanxSxY0HauHI
 HP4rAniXDCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKbZjQAKCRDBN2bmhouD
 13frD/9kUAvsG4k8pJHW7pM/M1lFmN1E9aryLzVWQdCoRNM+oMCJXweuixV9wDUQtiguoG73Da0
 HrY+SLZZ35XqDk/J10NgDL8vSKBSl/QH6wD4qhZpDxcRB+gNfBk+XtwDnwULbdNhsxf6Jo4PXrx
 HJribt3Qh+TFuMQJP85Q8wEVZNRdE1iki2kV6LWQVLDW5Y7akzcYz4gdMKjYfWNdQxlrimLk9Ob
 VFKndIUkSaEHo1izt8KnxGxdoCKhxRMDtSEi2BJ7ixlugZ2z29M3ykbYCCsidPnEs9hJt+J3+QM
 i+V5+WO4l5x2LEpUZ1+Qyq7+XUq7JkBBCTFq04DZ9l/S1QMLyBRo4XXShVB7MmvVrumAhy74KSo
 PB6aI4D7fk+4WexLlIOwKHk0GXVDiXSnmSqBfKX6RQqv9V1TG+FliEIex4cmGMilpT5oBPURibT
 19arh2P8kq4samhnaK6kFAHQ+iVo/MuT8UiFAjtWw97nSfRkrWVeEwl04yGd8YMludhYjju1V3R
 uamX9C1mdkuzSJFM0C4YBAV3a7irZZMDfED+dejWUfzPZQPvzJfLz/ZWaIhC1Z9OWIVrhv1xLL4
 NTO8viJCzgJ7dFii5xPMpRjF4ecUEoz8FVpiDWuebjdIRRf3rHRlE+KiFc9nl7cTXLERfDHgNcg ZfzyrRVol9a3U9g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The DTS code coding style expects exactly one space around '='
character.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/gpio/maxim,max31910.yaml  | 6 +++---
 .../devicetree/bindings/gpio/spacemit,k1-gpio.yaml          | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/maxim,max31910.yaml b/Documentation/devicetree/bindings/gpio/maxim,max31910.yaml
index 82a190a715f9..4d200f9dffd5 100644
--- a/Documentation/devicetree/bindings/gpio/maxim,max31910.yaml
+++ b/Documentation/devicetree/bindings/gpio/maxim,max31910.yaml
@@ -95,9 +95,9 @@ examples:
             #gpio-cells = <2>;
 
             maxim,modesel-gpios = <&gpio2 23>;
-            maxim,fault-gpios   = <&gpio2 24 GPIO_ACTIVE_LOW>;
-            maxim,db0-gpios     = <&gpio2 25>;
-            maxim,db1-gpios     = <&gpio2 26>;
+            maxim,fault-gpios = <&gpio2 24 GPIO_ACTIVE_LOW>;
+            maxim,db0-gpios = <&gpio2 25>;
+            maxim,db1-gpios = <&gpio2 26>;
 
             spi-max-frequency = <25000000>;
         };
diff --git a/Documentation/devicetree/bindings/gpio/spacemit,k1-gpio.yaml b/Documentation/devicetree/bindings/gpio/spacemit,k1-gpio.yaml
index ec0232e72c71..83e0b2d14c9f 100644
--- a/Documentation/devicetree/bindings/gpio/spacemit,k1-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/spacemit,k1-gpio.yaml
@@ -80,7 +80,7 @@ examples:
     gpio@d4019000 {
       compatible = "spacemit,k1-gpio";
       reg = <0xd4019000 0x800>;
-      clocks =<&ccu 9>, <&ccu 61>;
+      clocks = <&ccu 9>, <&ccu 61>;
       clock-names = "core", "bus";
       gpio-controller;
       #gpio-cells = <3>;
-- 
2.48.1


