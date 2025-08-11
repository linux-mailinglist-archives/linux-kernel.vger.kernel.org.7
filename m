Return-Path: <linux-kernel+bounces-762783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53402B20ADE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC4143AA151
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0EA224B0C;
	Mon, 11 Aug 2025 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gDlPurdN"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6022320F070
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920459; cv=none; b=SScDIo9NVM3m2Bt+bRnQVDv6ZL3Ml1mP9UCUCz75ECLkbKEQDLF6sbCxF6bC/JFAY8rLfiLLBydLzuazNgpaAa0OYyea80lziHi8RNXsiFlYMykbQYlAMymtRpQUNs6iXAOQyudtrARv7/AGymzmVWdDUTyocyeAbNMYvgnf6o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920459; c=relaxed/simple;
	bh=TwhL9kHuNMw1ekpCMBDV2BMjjP7HjIb5JBPWSmFWyGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yd9xhupGbOI2r8+e+BYC2qg7rA8TjJFjUIZrLrnkDYtnMEK1UF+WIbpzEzt72PKstbWwJ9e2/gjgXQfi9c+BxUGHSokFtQSynLB5QzyvE0PQbYs9EGyMEXvGdB7/J4HFVaPvRCNQ3vhHHUe55sJdLjdzNWbY0Qzg7r84JNKoxBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gDlPurdN; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-af946c07c84so60671466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754920455; x=1755525255; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oqhbJGyWXO0pDEnjUQmQZz1y0G16+abJkAfpIFUeykg=;
        b=gDlPurdNgV+ShMjUJIzjWDW7Un0Ite+W8OKQMgZlXeNon2eBJbcJFUT9dNY5PCPrLr
         hSdmx6RzOaRyTRhH8RqSQkL6wMaJVaHAH0rXbeIp16HAHL4etxY25/A0mH4rKKdCnMla
         zNYzMkv4YcAU8v3kqGprnaDZ1G5IgLIqzsfuzmP1HGbYjXBmwphjuairxnb7oN6r0nab
         Nx6NCGMnZCrDBIeHeW0yKzy8p9ERTDZRf4xNfBLN5FqcC0GK4jks57llMWR637VEK377
         4JcuKZxh25rSbnISZtXU/b34IgXATa9hdQ+0/TPy41dpJYo4OIlGMvciGoBG56F4yUlp
         y/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920455; x=1755525255;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oqhbJGyWXO0pDEnjUQmQZz1y0G16+abJkAfpIFUeykg=;
        b=NnLHpea2XImcTA0T6Bvh4wTHJ6owWggx6ne2aH4ZImzRnpAKqNObfkFOCoqg6KdGyI
         SCAWG7w+6255BC7KkAQw16dQQc3sQsxlykahBR3RkzTEZPm+VpVB6aUCk3wzlQW0iCH0
         oJ3LOY1IGAzngmKhb3y354ol2g65V0Lp+aykjIhVvO9EsrJUvuPQ2I+S1aYldEwFdnNg
         85lbCNzXTkSzFMzgdVIxEC1qov4BL+CD46CGFhFwtXZ20jI7pVQe1QSWYYkWE+sGlGpi
         ADlNCPQlNMAt+M6/kgUYGfsJxewZEh3lcXvo4y4TG94gpCIfYBPKjyqjmIneCq/PXJIg
         sMoA==
X-Forwarded-Encrypted: i=1; AJvYcCVCxwJu1rhl0eGaDy5sROwqU26l3QS6IErDPof2VU9BHa0d+JxZuj/8RKzMpUd3R2kkHnAU0ZA2l57M+F0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUgSIBv6xNLmF2a6/6VCB+suKhYK2h7RVt7r2UIzlEHdQY21IX
	lpfKXqvQiMk91WZh/5hYqhfSz5CDSAV80NhTlkn/hZ9VJPbMxcVvxcnNCWojGkZiFWo=
X-Gm-Gg: ASbGncuGUo/YqMC8NBKt2Wjh2coIv9/4GPS0vtbMzAwTLt0Rz127rRcagcSHST20v0M
	+ilO1cr2/JF7R4S+oW9cyOCJzVfRrIknfA+qWdHc6wQVBVYUxT5NHcf40NPVNqGD8peSG0yQzju
	URfgJrqP9pRK3+0bsP1UKTPXTIzJ2Nh5uxMbttYz93kBRkUslIJl5aDArvC59keWwIauTRpRoBC
	RVTzZ9NGU8JF8rzsGA3ng5RnBIHpMq+0A+4JfBVU41UaVZuCpRShUFja9wtQyz6tyCIAdihg/MN
	1rW7h4TsJ+zh85F9MSUpj466yJHME+valI3Mu26YZ0TCfd+wxcdZyUc2V3IBV1Liq8QDAXn7HEw
	Js/520aMGHsA4HNGjFIRmRpqL5rzQ+i0cXV1nYG4=
X-Google-Smtp-Source: AGHT+IE/1LgQrqO5eCCRUgilyifCk6jF84Qp9fDrZOql9XlTeOhTTbm9h/YyeGwJTKKvwOp71PXCZA==
X-Received: by 2002:a17:907:2d93:b0:ad8:a2b3:66fb with SMTP id a640c23a62f3a-af9deaaef27mr385687866b.3.1754920454644;
        Mon, 11 Aug 2025 06:54:14 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af986a477c4sm1179029866b.56.2025.08.11.06.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:54:14 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 11 Aug 2025 15:54:03 +0200
Subject: [PATCH RESEND 1/2] dt-bindings: leds: issi,is31fl319x: Drop 'db'
 suffix duplicating dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-dt-bindings-db-v1-1-457301523bb5@linaro.org>
References: <20250811-dt-bindings-db-v1-0-457301523bb5@linaro.org>
In-Reply-To: <20250811-dt-bindings-db-v1-0-457301523bb5@linaro.org>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Vincent Knecht <vincent.knecht@mailoo.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Li Jun <jun.li@nxp.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1148;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=TwhL9kHuNMw1ekpCMBDV2BMjjP7HjIb5JBPWSmFWyGU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBomfYBFR4XrobLEhq7B1bbNoPCguuPOvtUYVs7T
 QoK2ACsJb2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaJn2AQAKCRDBN2bmhouD
 1wX9D/0fgTSAEgjcithvcnihEli0+dhJu1IjNs8D4hs34omPoQQtm7fLqC0xRc+ZgX+vvRs/uD2
 WJrb3kblxWU4xiiT2m000ekQdnlQJaQdGA7JPSgu1YHHgsZdPxdPCzmKkJnxWRBqmcpbAybQ5Yy
 aBb+UA7EY96reCOw9mokeqAoqnZ2UldILGg9i7xKZsJLQbKGeofk6QjjMnA1H/o5IKGB5xBG2X+
 g5TmwluhQkVyB3TSat40bnb5Xx97fS1rLdBvp1o895jugOym4riUHY1DdvdxmqbvimR8uLxq6B5
 pdpTg1Qys0jqZAewiH/s/zRgAARR7toakmq2G0iwAmekvGXDKwpcDQdpnKH8azu0whlaUXlL2Dt
 b8PKF3JNOH8d1FteVKbm2Lb0ODRIPukQlCgDCpJ36p5G5qLjsqKAuEFUVlUYo8u+MVwdsYSPtu+
 P+whAhlYtCLDufA9vaHELAT5beRGjxzHJzxGv5kIDu7kXC/gK8kzjkN8GCFzRdAh3zrGqFldfAf
 vauniUM6e8Ta4Kd9uO//LDT+PZ6m4psOUj6cgsQUekspxFkVGOpYhfSExqaC3LrPWJgclAsVIMI
 FwPf7TcgRnrUAZVrOwLY14f5bD/yb01z9NYzpvW9iorDod4J2OjqkHSpwJPkzp1ILLvEX/V1530
 QU/fB9vh8kGxMXw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

A common property unit suffix '-db' was added to dtschema, thus
in-kernel bindings should not reference the type.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

RFC because this depends on dtschema changes and should be accepted
after new dtschema is released with this merged:
https://github.com/devicetree-org/dt-schema/pull/166
---
 Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml b/Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml
index 3c0431c51159e549920b17cf2ddfd1b85ecde810..906735acfbaf94fa08244f771139df207dd6e4da 100644
--- a/Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml
+++ b/Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml
@@ -42,7 +42,6 @@ properties:
     description: GPIO attached to the SDB pin.
 
   audio-gain-db:
-    $ref: /schemas/types.yaml#/definitions/uint32
     default: 0
     description: Audio gain selection for external analog modulation input.
     enum: [0, 3, 6, 9, 12, 15, 18, 21]

-- 
2.48.1


