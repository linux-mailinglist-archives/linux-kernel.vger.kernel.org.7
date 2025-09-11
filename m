Return-Path: <linux-kernel+bounces-812071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B09B53299
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A2554847F7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2BC322C63;
	Thu, 11 Sep 2025 12:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XM1A9Ec6"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7E632276F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757594633; cv=none; b=LZarcV6/qMfr+fj7DVPIUG+XTHww5AHsJpSoTYOf63TjJYeexxu4bnFvtUxG/OoyVtu5hE7zx8/zsDdp1OjZxfAk9vbdkn8eGYNvgak5lu+oMnzoCPbadn6TzM6NHJZhULnTZFj7e1e8+G50i0jNzUam4yeztPFu1Q5LzmmmPcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757594633; c=relaxed/simple;
	bh=a+1IafQzMkRqd9Hy7+2ryDB7W6wFRG7cDp4dZjBJvkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a7og/GWH5VVb2EOWINSlFZGDxnoVo8a5RmeZijoHKBcvnVxQhaM6Jfu7oYxetLZ6UMyfG+fKVpL24h3Ke9Sp3HJcpplOCpDXxYbXoB5sKJHMBsSIFElkDXjoO6ASikx5WmR/c7LHiXA3NqJhS8R5U0y261yRYMbcFVA3RIc0GoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XM1A9Ec6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45ed646b656so804445e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 05:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757594630; x=1758199430; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hoN8KhslkXmRFB53xJxTZys7BqlERNC+NzX0ipuiFjA=;
        b=XM1A9Ec63PIL6dD/4D84TuFrAs1yt7BbgsD9kQGQpLf9tve9uBlsTcOOhMiyufDtkC
         +SCZCAYRbQunKnm8I92kPkmlZ/3aaDTE4QomeQw32b+XCy2U0tGL6kIv+JHS+K/hFM3X
         TEQ64ZP4yo/NZuIrGAYtt8PZ/FgnTaQR50j3h21oFITAwMhTmKr03QOV6lh8Lw2rbVx4
         MBkURDx6eT6LuyWCL+9UYJXFFXTMgpii/hsiz3Asss8BT+L14KcQeFsQqk9Xkl8FS5+y
         MlYI63r/k9TLP+zWw+HG7RKxRVHmf+lUrWmaulbSPyRaxuRi2o/tAAH1k0XfMdYR5V2W
         ULMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757594630; x=1758199430;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hoN8KhslkXmRFB53xJxTZys7BqlERNC+NzX0ipuiFjA=;
        b=VCEarQocez2Uj8MqH+SXvWP92isDO9HsxbkASIvVfUnuTq43UHHWquhAF6tgUCxY9+
         mZHi0qodZA/dtQaC2dJicKm9IqG6bNB4XPo6wNjyofePd5eRfQq2tScC0oqey1qH6zgx
         AHGFIIjBs5fhys3ysedU5qPWqah8U+2FqGpMAOiF/rEolElLxt08sr0Zkns5XIdq1N55
         DaMxYNSTRotKwXboQs4S3h/PzcjOe+RdbtDsCB3B0D9k/jjkCW0M/tkEUlkhxRlr9iCu
         A+amdBJWinXZf/1Q+dBYpF0lzQohptq9mTGFXEeP5FAgTu3iybUJ83R/tGXm2shDuKp8
         tT3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFjytIyGsqtRayfBoGtXPEZ8q5rLEnxATH0Mr1/9Dygb9C3R5QU9JJqitXPuENLwzzbpNHiDXP669sgAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTU5kEaMU5Gph2d8e9FQqigWp7HShxRqYuvLd6ED2G0P65zQ0Z
	63A+yu8nB21M5OhvCTYFjBdyCGwYpLniI/m0yX/eOx+BPv9EoWRNqEcC
X-Gm-Gg: ASbGnctv5Pp5hj5IKGSQgv0xCbWnXd3Ff/XH0ynQ2j0iYw2q1INkR4OgAJolPhtgKCr
	XincWy7gQ4SQTVl6vbuNT+sIJK5gJtQxXct1qHsSdjw5tus8ES0F3jneMXM7qVPduVhgdIw/MTS
	OXzjCmMKQFXYfejjUzHwUQFxfAC0AsB1H0hkBQ6tRXvuFvgUUGngTVfxK/UI5zu1JlNTimwVyc+
	A2X/+fZv6Mxv4vXKGJClkJuUsptpIPK3TSKTeDYszLoW8P5aloYvHLQ4CApk3ukbu1306wPYZJc
	/CwGHveUidxMH9Tw5iSOskZnvsK3je99dXCy//4FpGh4g3xKOIn1OlT1fRu2rXs4EvKapMLJVZo
	D9VKvLH16rw+X73NAkqboKoa3BLwcabN0IN1HygkMmt0W8GnY0Jr8Y7OqiybsiaLlbjR2AETGbw
	BY
X-Google-Smtp-Source: AGHT+IGe1XpReT0Pizyuk+QKSriouplCWFhyveLmKS0j9Z8nPLjbNJUdn7tPUVc9o8qqTN1eAfqofQ==
X-Received: by 2002:a05:600c:3b1a:b0:45b:9291:320d with SMTP id 5b1f17b1804b1-45ddded3454mr190632425e9.31.1757594629743;
        Thu, 11 Sep 2025 05:43:49 -0700 (PDT)
Received: from Radijator.localdomain (93-143-13-188.adsl.net.t-com.hr. [93.143.13.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e03729c76sm22591495e9.6.2025.09.11.05.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 05:43:49 -0700 (PDT)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <dujemihanovic32@gmail.com>
Date: Thu, 11 Sep 2025 14:43:44 +0200
Subject: [PATCH v4 1/3] dt-bindings: mfd: 88pm886: Add #io-channel-cells
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250911-88pm886-gpadc-v4-1-60452710d3a0@dujemihanovic.xyz>
References: <20250911-88pm886-gpadc-v4-0-60452710d3a0@dujemihanovic.xyz>
In-Reply-To: <20250911-88pm886-gpadc-v4-0-60452710d3a0@dujemihanovic.xyz>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Karel Balej <balejk@matfyz.cz>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: David Wronek <david@mainlining.org>, phone-devel@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1291;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=8lO4nr828tWQwLxmjjV752k5xLRe27/oDan4m5yXVVA=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBmHjjA+mxQe8XOnYVTbmVm3Gx2atTRdJabx75wyq3Zf6
 aVbtmzzOkpZGMS4GGTFFFly/zte4/0ssnV79jIDmDmsTCBDGLg4BWAiB00YGd48eV8Wb/rMZhvX
 7OxNz3zvl31c9OLnza+ZZaYe2tIWLd8YGT5wprVvncL8rHe6ZNFE1fLQGbG54esFlARtBF83uCz
 ZzwgA
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

From: Duje Mihanović <duje@dujemihanovic.xyz>

Add an #io-channel-cells property to the Marvell 88PM886 PMIC binding to
allow referencing the IO channels exposed by its GPADC.

Acked-by: Karel Balej <balejk@matfyz.cz> # for the PMIC
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
v3:
- Update trailers

v2:
- New patch
---
 Documentation/devicetree/bindings/mfd/marvell,88pm886-a1.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/marvell,88pm886-a1.yaml b/Documentation/devicetree/bindings/mfd/marvell,88pm886-a1.yaml
index d6a71c912b76f7d24787d346d4b4cd51919b1cf6..92a72a99fd790805e775727e39d457608fa1795d 100644
--- a/Documentation/devicetree/bindings/mfd/marvell,88pm886-a1.yaml
+++ b/Documentation/devicetree/bindings/mfd/marvell,88pm886-a1.yaml
@@ -35,6 +35,9 @@ properties:
         description: LDO or buck regulator.
         unevaluatedProperties: false
 
+  '#io-channel-cells':
+    const: 1
+
 required:
   - compatible
   - reg
@@ -53,6 +56,7 @@ examples:
         reg = <0x30>;
         interrupts = <0 4 IRQ_TYPE_LEVEL_HIGH>;
         interrupt-parent = <&gic>;
+        #io-channel-cells = <1>;
         wakeup-source;
 
         regulators {

-- 
2.51.0


