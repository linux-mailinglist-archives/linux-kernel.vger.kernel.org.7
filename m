Return-Path: <linux-kernel+bounces-844473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62664BC2032
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 18:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E62E19A2D19
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 16:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916981F873B;
	Tue,  7 Oct 2025 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w40GcyIV"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFC5C2E0
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759852839; cv=none; b=X0lDc3Ci4xomS7CH9e7eIuCI+7leMXSu+wshv94NTSEpLRyivupuhUEI7LgE5hbf3RVCv1IzlQpB7AxblvRL7mGLZCKxlxwyIRfuyJRArFrE5Hazfp7Xju5nYj7WEBe7GWVsVlwQ6MneTcv+zQbZJsKvQWtU+AL3dWneRjAClVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759852839; c=relaxed/simple;
	bh=o+OJ58HWM0DIrIqi/TF3GdVjuFQu1dVzJaZpj2W8Jas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lKJSR+zlEj5vQ1x3wRu1BdW1msoS650ETv/pPhv5nqFYROQD5eSE9fLK4XlMGDaxxaWS6uI+UxWZr/Ls9nsLhDNRIWW8mJyLe47OTsgsINGGb5aT12Be5zQ8wyAo5UCo2LiLi3VhUJdGrHml6Ko1N7x4TfD3fmnvyh6ESnp+gBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w40GcyIV; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-636de696e18so10783583a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 09:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759852835; x=1760457635; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mjKb1ezpRpl7M3iFhpiWd2sjqaAYaZ6YNqsdcXvRIf4=;
        b=w40GcyIVeaZq96mjq8lWyjZCFKP7nKLPxHAyD6mlYR5Xj5Wbm5xacQRhskoYyHYey+
         8TsYI0coO/BW9q8JPk9UzvwQD6DoF3bKmKqRlx0MorFnKBcRsFnuseZd/jjybminJzFY
         pDa/xakBwVH0+XCqq/S7sEO3jvLL/riggR9aqVsvhmYBXYVGlevr8CuvnptqUmGIftpj
         dQCfqdV4c0KlSI1BBmvW87HsBvkCR5XiGRbcB1/SoUiQm0ETO9JWkV4IB3euNsketwIL
         LuMDULwDVzhXc/EjRa4/NwyLvvziTk4BvCvBFFdAycPi1c+AB978X4oOx4hdzWvlH31T
         zCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759852835; x=1760457635;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mjKb1ezpRpl7M3iFhpiWd2sjqaAYaZ6YNqsdcXvRIf4=;
        b=GRiMKNE5i/ywT1++SUFdyYK+0q1jSpyLhatCsrV4062CosLcLlLhCWcWFP26i4J5ri
         ++W6d0NSR4+p1pwqDfDDjc1MNzLIiY/qT01yh6RbaQ8PY4tPKmPXkCZsDwUjaxi6We7a
         l7ttdHT/yUSGZTZAVvvY6QipmvGcHO7NXAp+eqIEftsAbfdKTEufCAfjfu2EdTibjz+h
         jEHFY+Drx2fhrc05oyE2rVP4nMv0bbzPlGq3X90D/nKP6hGDS3/VHCQzGJKKg+LHtpFx
         xKOsxeAwQ/yP7QkM6fDpGQLDwGXY7ytwJ2nnej0OI2hlWbwko9km0zbf3zRuLNFBrJtI
         X+QQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdJDqTT+6COY8AuIjntkSYWLMGOnLFTv+5MDaJsoT67sTwyRC6evWpS91ZfVPzxiOXpOKGclhzRecdoPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmRIZQyfdETVdnLas4D96UqeWwhekDlZ6gsVwUT4R6UFs0Aeny
	dR1d6VXKIDvfZEFIgI5pN4Fqh9C6dKCler3ueMCYbwpUREqoUoFe2lBPOcYcdJBRWco=
X-Gm-Gg: ASbGncvGOK3lqk06PSuk3/xLgt26qvDIObY58sMFwDrVL7DgAenH2IHVfPhW4jr6Rkb
	PWed526ZD6IHZWrEtMJ1YFmRZSpALfIhfMv89G+I8UtTr0XL0307EkLwxBtoNIz3a0sMBFj1Gxw
	g5tUJEEWfXXcBQXHoS2ycaUqELEb+w5PYrrCz73Tfou+gPR2kxjmCpbpYEDmPuTt5fn4LduN5Un
	RAL8fiaCg5bp7iUYQqF931wsrt8Sxzk+HMck5mML3QXhzH41XeR7WSzz42hZsQUYvO4uHfYBgiV
	FeivINpSifjtaYMZCAAgfo10Ciyq3IcH9EZC3wCzcEZRmsUqnndERhFnjHwOUy1lnbUGqmo4Ttz
	NJFh2OugiA8/MDv2Pv8FIfQqPrECsGnsWnIL7IsDYg9lc9PgfKnoyMuE+NOik7TrWE+Vup3d3eU
	ZJRDFOJMNMrFOS2kCjSUUdkZiOf9MzxoO3anL8Li+S
X-Google-Smtp-Source: AGHT+IGyutPnseJcYgmno2XcoY0l08n3SSLeGdWklnJBKgIvM1+oFnfvYzhNSc6Fhvupmb0TG3Vp6g==
X-Received: by 2002:a17:907:2d0e:b0:b3d:98fa:b3fe with SMTP id a640c23a62f3a-b50ac6ca199mr13352866b.63.1759852835469;
        Tue, 07 Oct 2025 09:00:35 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b503c779df2sm96445566b.34.2025.10.07.09.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 09:00:35 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 07 Oct 2025 17:00:34 +0100
Subject: [PATCH] dt-bindings: phy: samsung,usb3-drd-phy: add power-domains
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251007-power-domains-phy-samsung-usb3-drd-phy-v1-1-3cb5f80a72ef@linaro.org>
X-B4-Tracking: v=1; b=H4sIACE55WgC/x2NMQ6DMAwAv4I8YymkJEj9SsUQGgMeSCJb0FaIv
 zdivBvuTlASJoVnc4LQwco5VejaBt5rSAshx8pgjXWdMQOW/CHBmLfASbGsP9Sw6Z4W3HV6YJR
 4y8lZ2zs/ePIBaqwIzfy9R6/xuv7tiLp+eAAAAA==
X-Change-ID: 20251007-power-domains-phy-samsung-usb3-drd-phy-b52245676e6a
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

The USB phy can be part of a power domain, so we need to allow the
relevant property 'power-domains'.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
index e906403208c02951ff2bf5ed8420d53ad70eb29c..2e14e5fbb1331d2bbb7c3e2f37df1280415c79ee 100644
--- a/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
@@ -51,6 +51,9 @@ properties:
           settings register.  For Exynos5420 this is given as 'sclk_usbphy30'
           in the CMU. It's not needed for Exynos2200.
 
+  power-domains:
+    maxItems: 1
+
   "#phy-cells":
     const: 1
 

---
base-commit: 3b9b1f8df454caa453c7fb07689064edb2eda90a
change-id: 20251007-power-domains-phy-samsung-usb3-drd-phy-b52245676e6a

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


