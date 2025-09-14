Return-Path: <linux-kernel+bounces-815547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E28DB567FE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D32C4168D94
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 11:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3934D25EF97;
	Sun, 14 Sep 2025 11:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMmpQjw5"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D074B2580D7
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 11:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757850306; cv=none; b=WHuwjsS9yIjBCOAGIqVw2d/B2DLpwSW6M9F7yHMpXLfLLsrPpCVIrqRm75OoTTNrP0rx0VlpvOnwCCSi83v6KGwe3w+W+zs0EyxEl7SVEbdWRX0rrHsYxoQ0PW3U2ss9pov76vk4OkujzvCwNQ5FUU/QdBYfaVVpqMwW3U7olMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757850306; c=relaxed/simple;
	bh=nnxWlv+OJi30txzuvQA8yOIXIEYLUlnbIbZsAeav1ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZPsQUhOqM590mYqRJDnul0rp1Umxzf2h3/XJ1jfxsur7/XfUDgOIzsKjGjAAmnzdQC+OV0Xx63OqsvQkGXaZdXFRl4ZGcXA1JJkbMk1v8fdra1WJtX82Nwkd8OI581in+p58eslEXFNoh5f23nzLyanag2dCIRaz7ftWLI55WkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMmpQjw5; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3dce6eed889so2946740f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 04:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757850303; x=1758455103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1jxxIyK9Ih5zhWAbEfQ/SUSMwO68aineNys1TdCPOI=;
        b=DMmpQjw5WkJ/wPCKXgTmLTpmIyFSS2UnR/CPcQ7BqP9O7YSaT7fwfsAhWnKp6vVurF
         5xYg5QD7ObwVcrMVXzr+Jost8bI5drLBnISACaYGXvMyISOwJ5DXfO6zdolmbLhHsj4x
         2nz68HO3UNunq3ZSsiGFbhzxQ9jDNRlg/jsshfhsfute9UQhGuFa3HzJQh5Hgk240Cg+
         q1/Mtai3iXDc8UGgWpQq9BdxIYZ7bv8u1wcSVu0DCSIRM8CdImErvcrZC//GmdVhMZ60
         l8McpjVNp6/ymyn5AXmfVYONdMGezd8pDXNJx4JNYkEEb14BAujlg4NHKNgPJ3N719x3
         crzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757850303; x=1758455103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1jxxIyK9Ih5zhWAbEfQ/SUSMwO68aineNys1TdCPOI=;
        b=vVzQkTqyvAlIWoD8kj7W+ddvc7hukmOVjm6lBC+fkKvZRCeoZJHbE7ZZNJk+wUX2Co
         c5z3CcgN6MUO31NtRx4bz9WuU91u/uMNqoCnBnx7DkEcDXfhgDjBDZmO/IN9KJmQem96
         FY3a3c74UCj1T2PlsB3Y7vorzGr56cby6qRhfFXOMo2QuBRpo2AfQxKTAgzJAGwc6Wke
         6GfYFX1yPxOezocYsJBhcohTQ39LLDcqxIqyYDlhyqS2fyaRCUf8seY6EwqvBZ8q6aMm
         xnin9o0s2WWDEzFv3gwuAwDXCsNW7gjAlqYH2zAIKNb9SA1SMxSTAA+vCRki8npU8wi1
         YJyg==
X-Forwarded-Encrypted: i=1; AJvYcCUsr+yIZ8ZtDQ69b89lC8y4MeoiT+ceCh0f2drE6XXdp8k9VmKdiL93rh+c8EM6wZohN8yARd2+niL9EfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjM8lXTuzDVYX7auyAIvrNT5fcD3Gbd234fWh3JDtf5sKY19gA
	cAbFhg8PK2XS5bFl9GtHO9/BAw4d2HzFH7l7xu0z3k92xd20FYFwnCZR
X-Gm-Gg: ASbGncvGLGJcsiuOt3yxE8DZwCmuSbTGXBUFWeXzsUlRfUFODp21+yK4MIe+G2cwOvK
	8NTPCOuT67G0Souw8G4NiMWzB34k54S1wMSioqcYijmZXMv6ImoFvL/eIhKYHJMKgr7qEQenaRg
	EHEzcX12s9uLIZQzMjou5+U9Yfa19eiL+AQFVBFa7hvFo9keBsSL95jFWGK4VoqY3/GB3iVBntP
	omeDWK3VhJkd1gCEC/KY4YHHYcODIFypG5P0kTNrtu7tcBCEQf9ZWIjN8hyRj+cxtkxSB0oyT3m
	V9qspGqS8hv22sTx/c8nJt88m3/elkKrx8xMt/C25y1FUjPcYqrUmVYtUkqnWH2VufrhpM+f3bk
	5HSx0CZ4MjADY93wtbEzcKlwMqg0Rbj0q1u6a7ox55hYwrkF3cIk3LWnqso4ODW6KZ8WkQ2H9PT
	uHh4AQBR5I
X-Google-Smtp-Source: AGHT+IE1BqJhX9iGCNG9Rwq5f7XlNdOwfaGHziUaIwwwVkNizVz8cQGq1fatGEsUFHWt7rHYFPM5cw==
X-Received: by 2002:a05:6000:2281:b0:3e7:1f63:6e7d with SMTP id ffacd0b85a97d-3e7659ee4e1mr10069982f8f.45.1757850302860;
        Sun, 14 Sep 2025 04:45:02 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ea21a6e4basm1503252f8f.11.2025.09.14.04.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 04:45:02 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tomasz Figa <tomasz.figa@gmail.com>
Cc: linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] dt-bindings: pinctrl: samsung: add exynos8890 compatible
Date: Sun, 14 Sep 2025 14:44:55 +0300
Message-ID: <20250914114457.2610013-2-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250914114457.2610013-1-ivo.ivanov.ivanov1@gmail.com>
References: <20250914114457.2610013-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the pinctrl compatible for the exynos8890 SoC. Let the
driver handle our clocks for pinctrl as well.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 .../devicetree/bindings/pinctrl/samsung,pinctrl.yaml         | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
index de8460856..ffd3e2dd2 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
@@ -55,6 +55,7 @@ properties:
       - samsung,exynos7870-pinctrl
       - samsung,exynos7885-pinctrl
       - samsung,exynos850-pinctrl
+      - samsung,exynos8890-pinctrl
       - samsung,exynos8895-pinctrl
       - samsung,exynos9810-pinctrl
       - samsung,exynos990-pinctrl
@@ -136,7 +137,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: google,gs101-pinctrl
+            enum:
+              - google,gs101-pinctrl
+              - samsung,exynos8890-pinctrl
     then:
       required:
         - clocks
-- 
2.43.0


