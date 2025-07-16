Return-Path: <linux-kernel+bounces-733951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECC7B07B26
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 18:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 336901AA0EA5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C992F546D;
	Wed, 16 Jul 2025 16:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TgFvHLY0"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D302F5334
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 16:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752683131; cv=none; b=BOUlKSd4SVnwdE0fOI4ELs9pTXy9odEyg0nsyYkfqPzERPsEOMc6m8B4WgGL+OzquAX9K3BW7WDC2558ZidWlOocKbWqS8gsGadj9fDSjxwVK7PfCf1Kc13PltWPGRP2QTLkjKpKciHbD8BOkHYwwvo/tjoBqtdoKmb+03XIreM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752683131; c=relaxed/simple;
	bh=ifqUWykIKw09YdHBlJDHosbFjVKt99R4kYjqL+6vHWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rvfz3zToduVxtVoVwjvlQbvMa5NO5uKtsY4gX72qFP1N1uW3HIlv18KhK9+tiigopKBPJUKNfKhfbImRf1OZp1SN6p6atBVdqGLa0pSgxXJYWEggYNQJGQ9CQSQzZUVkbtyfimZeviQzCuK6iZ6waXFQwTqITgPUIbxc76dD40I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TgFvHLY0; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6075ca6d617so68a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752683128; x=1753287928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8/KQk61yWGru3067l4BZnwmmevrhJMrhlMNVPC+Oez4=;
        b=TgFvHLY0hT2kvT+89RA0h1KTMJj0eS3UjAiEtPoFdOHkht004sItk8gNtXxZEbDDa/
         k1XAzWu2nXB/zbvAxikyIDBHu0qQ9/R1vYNgdENohI5p4CS+ywpeQzJbfptyvswAXjE0
         S29qHm3KveI8Xd7HvdxVl83KTxeqfd1E0kiflN+YbJzYSFl54mgzbUciMmeG6o8h6gEr
         szm4aFomJvbcr6kDhSzSXjSNuNyVWT1ciKzP1FNKuu0EnXqbMONa5Gpggf5YMNCT41RP
         bQ9BkIIN0BjClQf3x3oLbQ5ersqdTzBOFUTxH59Ei6meRpMxF3nVsJjSVNVkNJKjA1a8
         0uFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752683128; x=1753287928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8/KQk61yWGru3067l4BZnwmmevrhJMrhlMNVPC+Oez4=;
        b=BLD1xK21V6Sor6UFW49Bsq3YxAXBaUHX04ksl1TvpMIG1qBBgM0QVVYYm4ssQwiMY9
         M7nSYwzqQwh9PIEC4++LmkHhIzIO/pVQKPqHLpF2Slh0badSZcQQltTdPnpejiiChIlh
         +WCJv1kK260PfKIQaT9t7M57YPKZgOs+lgVCh2p82f70QeOE2ebUdhGZWEuhN8OsoSvU
         6w7X79se/PCLHSUH0l+0b6xl4OWiR7h+MNPzmSDqrnphf80hFdU4t9y7k6vlwToF/0G9
         Yzv5vj+XSAZFk9ba7G/l03bs0ozQ1SY0J+g0+2cwQA5iBKQWLKIC/yNGCO4V+4ulxaiR
         eKCw==
X-Forwarded-Encrypted: i=1; AJvYcCWnL/I+Q4MmScASuL4sGju8862OU6L1UO+gIqzTWzSRSma3fortvpEpdKr68vTtTJEx1SqRMyX/6OZKWjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYhgLCB+XFLtBzVaCWo0mHkAj/CyDRO8ZoHQD0zNbvJ6Jxfg02
	bnFrttxpvopBeHFKbGydh7fL1odi1KrwBaFM+bmKm8ALoyuq9OWHCiRQMo2nx+4FPyM=
X-Gm-Gg: ASbGncvvWlmjRWea8GQlGJSDa+ZZRgKtekliLIAkG3yQ+XhywuUEOccU8ePLkLgdztM
	jZnSWWT/2U3DhRyMHE5YcGn/aZNfUT/lqLn2/8dDLtWww7lYbhqnycsTq3kd9NVp6TmSv0Y0FQv
	ZE1exu3CAzTeQuU1VLwFobQ6dofvR4BQpZgT/Jrs96/SE2q7zMP7a4KHs1r2u+zN6UnG5Ws8U28
	MLddF5T3LnYpkKXHni9FGy+0S6K6WlV1vtiIh+5Kp1qFriPQOR7GNPBAmunIlADOkceEM7QAWJ2
	3oJQYOijNNLSBXbcuaT1PPsz2b9C/U6wgDok9f7RP9cT7v+g4i1Rw3YdpKubX4LySrsHN9uN8DO
	kajDk/7uSH0Xr5cBqIFOGbJIz88T73lGD/YGmus6KalY=
X-Google-Smtp-Source: AGHT+IHRu+EpPehRmNDaTTHsMBmUFIds4t5TwV6Vf+9vzMbgwhOgIMxO5v+ZllAYRRDC1jm7qh/cMA==
X-Received: by 2002:a05:6402:4028:b0:608:c372:5447 with SMTP id 4fb4d7f45d1cf-612821b8884mr1317142a12.7.1752683127739;
        Wed, 16 Jul 2025 09:25:27 -0700 (PDT)
Received: from kuoka.. ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c9734069sm8988916a12.48.2025.07.16.09.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 09:25:27 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH] dt-bindings: arm: qcom-soc: Document new Milos and Glymur SoCs
Date: Wed, 16 Jul 2025 18:24:13 +0200
Message-ID: <20250716162412.27471-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1754; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=ifqUWykIKw09YdHBlJDHosbFjVKt99R4kYjqL+6vHWw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBod9Is3IFQpmE9WS7TDElgYejbb/uM1v/3EGYMv
 Agge+urKBqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaHfSLAAKCRDBN2bmhouD
 16fLD/9RESlWBHNQRw7pktE1Q3UfMJmi+6TEMqrY6r6WOOWjn1p9FeqH0xbgdPaYd3wXwVxVD33
 32KLsTZ088I6iY2fhWn0fvUXgxwqHF1Sxl0VYwvARr40dle3fLOyzb5LzqOn3OKtNcveP5nGy8G
 /RVEiAbdY0PdfcM91S9UK0iuS7OBx/2KqPu58fpdayc45XvrjYV4w1SrhuRbT2fQjiwdLIqE2dC
 NCRM6j25GRbx/G1bWueA02YHzwcXuDMyPw6TX52axGqLIfCAxNgksGXld8U28df0MOLKGTzCVl3
 LgSxP5yA6ZF9LrOBYiww4moFnyo9fWngH7mmc/fP414FxKs/p4UTo0rbJZ1jhE+aUReo02/NkoB
 e85ZsxSwOIOZFDRas0q0GcOmUurrxnINRtkIYHXhbxBZRtZm5aQEv5ndRLpVe7IaY7+6gmpahEs
 1w8BhHwJqi2onCjE5OsmdQVhmFFzZHlvlaj2rpjm6Y8O04Ya3k6dAF+4QGpUiLLhGM+xKltXnCF
 Jx+iXCfabJw7HaKy45gArgWOlonV3gXy4o5mxogPRudr+7u+1uTIeW7Apz0Dvgn98gwT5VVqHb0
 gkptjumSRB3ry8mLk4IBx2jubvlclphYpwEj2W4PYP9wrictwWr/2tTWQoKvyqwH+YRVardiF9m bH+ugEsQq2aiQlQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Extend the schema enforcing correct SoC-block naming to cover Milos
(compatibles already accepted by some maintainers for next release) and
Glymur (posted on mailing lists [1]) SoCs.

Link: https://lore.kernel.org/linux-devicetree/20250716152017.4070029-1-pankaj.patil@oss.qualcomm.com/ [1]
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

I asked for documenting the Milos name at v2 of Milos patchset... it did
not happen and patches are already being accepted.

Cc: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/arm/qcom-soc.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom-soc.yaml b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
index a77d68dcad4e..27261039d56f 100644
--- a/Documentation/devicetree/bindings/arm/qcom-soc.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
@@ -23,7 +23,9 @@ description: |
 select:
   properties:
     compatible:
-      pattern: "^qcom,.*(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sar|sc|sd[amx]|sm|x1[ep])[0-9]+.*$"
+      oneOf:
+        - pattern: "^qcom,.*(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sar|sc|sd[amx]|sm|x1[ep])[0-9]+.*$"
+        - pattern: "^qcom,.*(glymur|milos).*$"
   required:
     - compatible
 
@@ -34,6 +36,7 @@ properties:
       - pattern: "^qcom,(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm|x1[ep])[0-9]+(pro)?-.*$"
       - pattern: "^qcom,sar[0-9]+[a-z]?-.*$"
       - pattern: "^qcom,(sa|sc)8[0-9]+[a-z][a-z]?-.*$"
+      - pattern: "^qcom,(glymur|milos)-.*$"
 
       # Legacy namings - variations of existing patterns/compatibles are OK,
       # but do not add completely new entries to these:
-- 
2.48.1


