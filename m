Return-Path: <linux-kernel+bounces-725306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E61BAFFD5A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61A465A597F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D20B28DB7E;
	Thu, 10 Jul 2025 08:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ab6/0p0c"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF3828EA4B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137908; cv=none; b=fqVMJ5JxEvAc4WnbIFyD/HFXRFjKCk5WXcoGsdDxhrcfRt9hFTz9K7e3IipNzcj9TlfakOS+S8A/7Fbx+CsId8RmyIgcLV1+12WC914a8Xu6sgG+jABMBv+fAp+kVkSWEABn6OO2cyRi1+W3fh2lh/9W2ZX/4DxyYgNkJF1HJr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137908; c=relaxed/simple;
	bh=rbhhgm0mzzYRhk7iKypZV4vkGP7IKSBeOXegRqSG3Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cgvPyQrN1itGIc9PqvSufs5nZ819PunUsISw0RWbQ9cEAAxBLDmv8pWg2luujSbHByBqLQwRWFZlHACLDEiECTxjUXpB/FLVaQZKJ/FMDNO97F910GpQfgMKA0FPxcq8sWr9ObvpAxjcbDbdSGDl5w76cjrUp5B1mv3sjuqMfN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ab6/0p0c; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a4eed70f24so113075f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 01:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752137905; x=1752742705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AFGcDq9X9d1S3/rYRs3p2USqJvjKS3vZk8Rfjbj4Ks4=;
        b=Ab6/0p0cZ/ZYcvJIDWUkBAuEYvZFaatoCsQhfjpkjHeXlrDRSM7Xjski19w/Oj+BqT
         dmhlM8APqugw+XH5ziY2QjNsND9l4JjZACzik8yzsquW2PSn9I9rbPpEcjk1E9FtZWIA
         SlVIpvaqPtxrSksPdj0kFE+17R72SC7rMVL02SuFZUaBa5/RyUgWFKeNS8PAE4IozCqV
         vUbbqTs1g4ULWXAG0Qdcpv9OfdTugjQRvrq8DKcmP7ULJbR+5P3+fW2eRoQ4PEgWMuyY
         ZkOo7bGYDSqqqJ389UQUPqxXWK/fybyKwfddsJ68ihBO3fBLi3n4d2A6Feon8QFuoXQf
         24HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752137905; x=1752742705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AFGcDq9X9d1S3/rYRs3p2USqJvjKS3vZk8Rfjbj4Ks4=;
        b=i/UvPnnG3vc/5B/AGvh/hVjoR4WmytG1Htq29zAO7Z+XTHupuWfvFRm7eLFbt6Uo2O
         pCKfFrb1rb49uYIAcHoEygbFwmwBRzro/ne3pBN/qf0Sv+hQJZVGMdxNr1yB5Vq98qtb
         HILeoEHQJCiUOQ58JQaV7TneCNYsB4s9SyAmxAxSYNQ3+Wy3/A6XUjv0qC5nJ5uPpZuf
         mCUKOYMDwpxZjTQ5refmehT0ifjM9I9KIP4pl+dc5hMMl0xGCkv1HGrFJto6lJWsBjZL
         RcZ37/b1pOYmxKDW0DD/vRZ/aQVlQhF9kSqC/DfMJjblCO5tpSF/P+h+XABvDGZpIyl/
         M7zg==
X-Forwarded-Encrypted: i=1; AJvYcCXDF1YgLEM/XFWTm36FtEn666ulZcWSXuzrmBFOLNWYklsqkMXvptr4lJvHbPt1/yqMW3Fee4kqqeTlsbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu/kkFvz7AGpR/2d0galJfmJOgsCbw25Vze4j7AK7mHVgamyPK
	+yokwZFySOQE7Re5SKJjkd/KhUfG1pnKwgCko/4q6D5v3cjOsFKBcOuQWm38hg/WHEg=
X-Gm-Gg: ASbGncvBmGpp1QtlAppur+zCT7lU0zAQ6MmWoXy9KYZnxO5WCT6T5xiXqPwNHEGVe8c
	Mr0Q92a+5kQ8XXd0SlZByT6Qj+35H1SqS2z9Wdbq9w57KmbR8ImDt8lSWpMO9Pjt78GUafwNqhL
	hvymRMQEUTvuH8vmX+OXMkHkbpmlvWVylXO92yxRKxAcBk0/JRqCBx5s0m5bZv7qQVlvh9LY75u
	zP+EC200fyCQhzwbvua3zASazbJl0xotCnV/tm+uKtuUuKE+OB/kZayIfJW3YqZgR1zyfAWmxKD
	K1IwEXdhW+QR34iEbMtBww2RXHqRrydWbmgB78anRVOYeTM2hE1HxDhjjmp89CAwXL0SkhXOz7U
	=
X-Google-Smtp-Source: AGHT+IGcF8p+1kAeeqUtTkgwKXgn6mbF97E2/bYy8J5UhMbcz5BE39eu+vDCag+9znaVA+I+mpt5CA==
X-Received: by 2002:a05:600c:3e0f:b0:43e:94fa:4aef with SMTP id 5b1f17b1804b1-454d541463bmr21300385e9.8.1752137904953;
        Thu, 10 Jul 2025 01:58:24 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd47543asm13248225e9.15.2025.07.10.01.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 01:58:24 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] docs: dt: submitting-patches: Avoid 'schema' in subject and add an example
Date: Thu, 10 Jul 2025 10:58:15 +0200
Message-ID: <20250710085814.21810-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1577; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=rbhhgm0mzzYRhk7iKypZV4vkGP7IKSBeOXegRqSG3Nc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBob4CmxqyCTItfrNqR2TfTiSqCnuLODTEiTFqQZ
 DOp8B7dPguJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaG+ApgAKCRDBN2bmhouD
 1wXUD/9jbnLNFo5DR1vaPBVCZC2y3AN0nwILD45Z8ErPWmxWkPAthGPxqOLIrR2VgtFP3LhcFc4
 z2U2MScFup9bE+4AU6o1Nx99sLvegsB+B8zu8K4k+rGC4GoXDLIYChG4BbpM7jjXb9FAdFVSIFV
 CqmnRG+60jeJwSjSR5BJlBksxU3cSpzag1pW4Y2U+hpcnzgh1k00ThMCamQ6CuUK9PHS4S+3mZ0
 1YaguuLvsETiVvxmtLlrewJ/WbGXJBwoNnN94n3uQW3E/9HYYQldXTyGHT4gcxPokFRHq+mEBtU
 4dUFvgiSGpJWebQDh01/ULAqmlluevyG1h5NoXPdzMG+Irouc04FxZ+HwgMh0hTsqM0WpEMbxrB
 eLprM4Dsn5mAMurO7dQlnUjIZkbKZpvenwLEGwHfV7J/B5AQoIyfdHu/gbOBl9cyu4ZU0NUQ7Ua
 KPt4PQvMAui93csoYWIoV28giEA7HanPChNQvol7PE+jN+l+ZbC9bWJNc8etfqajMfY8+d39IRn
 zbT2fueaFdB88tZu91CWhplqmaaOiRC9NhKFXfUr8/FOadwjIPWEPwbuEawADbFJXNBIzCpkTyX
 jq0WvKPJLZlKRL65MGP44zJz8pbq9mrDYD7/hs62sbxHNP0JVKzv9W9Te2wMxeYIfinYXS+yys6 XWfv3OsQaGf4lug==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Subjects should avoid also 'schema' keyword, because all bindings are
supposed to be in DT schema format.  Effectively people get confused
that subject should not contain anything else than device name after the
prefix, so add a recommended example.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/submitting-patches.rst | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/submitting-patches.rst b/Documentation/devicetree/bindings/submitting-patches.rst
index f3e23e69a638..bf32b784cb82 100644
--- a/Documentation/devicetree/bindings/submitting-patches.rst
+++ b/Documentation/devicetree/bindings/submitting-patches.rst
@@ -21,8 +21,12 @@ I. For patch submitters
        "<binding dir>: dt-bindings: ..."
 
      The 80 characters of the subject are precious. It is recommended to not
-     use "Documentation" or "doc" because that is implied. All bindings are
-     docs. Repeating "binding" again should also be avoided.
+     use "Documentation", "doc" or "schema" because that is implied. All
+     bindings are docs and all new bindings are supposed to be in Devicetree
+     schema format.  Repeating "binding" again should also be avoided, so for
+     a new device it is often enough for example::
+
+       "dt-bindings: iio: adc: Add ROHM BD79100G"
 
   2) DT binding files are written in DT schema format using json-schema
      vocabulary and YAML file format. The DT binding files must pass validation
-- 
2.43.0


