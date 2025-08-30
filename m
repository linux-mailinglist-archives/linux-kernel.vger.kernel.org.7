Return-Path: <linux-kernel+bounces-792986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4383EB3CB38
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 15:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 000FE2013CE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 13:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35F1279DDD;
	Sat, 30 Aug 2025 13:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TsH7eFkF"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44BE2773F9
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 13:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756560378; cv=none; b=scoLgz8qY3bgm4IqbCs6jeoqTyuKZHBLDB1zABrao+kUtU6q/OG2ghk61kaur0l49N5Ou3IFvnIAyNQNHOHE4knL2w6dAz0Y6rukX6lK1qmZTQSCLpzLRlXQmypQOp0EjdPeZaGt4iTHJPnRnUa5wS4w6YR2FGcB+AA0GV8z13o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756560378; c=relaxed/simple;
	bh=qwG4c4Xd+B3YoR0uF7y8E1dHfmZd2XS7G30El+hHeyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9K1obc9QydUyYyENzKHPijulJFUcM5dBRHizpnpiRgXFieEWEKmDI5IT2hnsfbIY0GAkFwpRdCF64aF7w1S6MkmzWE34zGr97fePpuSbtk5t/gHaXyTOXY9kxmVWNmj7SuQeSsiR1RmhZDo2b35lrmIyVYv7qMy8uyuYegkCns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TsH7eFkF; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afe7f9fdb96so38836266b.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 06:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756560373; x=1757165173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jxv0MqB/ujP6vHvTc2WwDI6QNrDWWZGMfkdvAnlFnuQ=;
        b=TsH7eFkFF9werCsKcPtU/X57EogvXskDw39mx3se32vryutXUZeD41/bBX12tkm2K5
         6xZYbtaDe8i1M0NpZnl6F+f3N3k9KTDzz3fowZ3UtcTDZ44EbvWTkFU659gCwYCYNKvA
         pt+vr6Zzp3NDWULcpUC3GeHkHQOUULHbp4rm6YhQh7bQyCN+LSQMl1wXEgjNHuJlCwgb
         wIYEEbrslzyAErutzabsfNvZjriMEAt0K0ISTqRtkfu92dxcsSe069MCNjD9POd55WI2
         2Fe80UBfQda565Ku18P/MrpboWgrEc4Nk+d6TGiJ8KJXgRZ/yhgubwMB4WseToyZE3JW
         UR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756560373; x=1757165173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jxv0MqB/ujP6vHvTc2WwDI6QNrDWWZGMfkdvAnlFnuQ=;
        b=eazTLg+9rokzk4JzlJQes54dZMuDRJ5ochgW/0WegDke2Yifp7w4aAeUI8t/UMPdTA
         VDUHaJnh5bErkUlNDBejrxVL6da9fHEXqT7JvE1fXJiiwSH6hWllQVlT8RRqOIA/P6Ys
         SbTTv9KHb3QPAt7r0Q0lnSjwIyJLz4jHjVKmN9GTB5lVtz7L7Vj5xvkc9pYzWJdGkkLu
         lagXx9lhCl/7kUhJTXv2g9YRmjttbLQ/NqcLXy4OiKPrAL1GnPe2O6EDja2ic0tjFOCA
         qCwQmwSs4VM7cFD3tpSlZqd0AytNX0gD2ElvYHqqT+iPRCK1kvdk3zoqR3aRq6NQypPc
         8O8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKFO5Xyjh7eDXkNTLxhqXtBl/JR+vdn2SLh3irovGzdoQX9YfyRxV46Yg+/UJr0eArhQSo0QQlAHB1oAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2CKjWz0msIfICt7Ph5qmM6TXIHp2NV1rv0CON90BCSxC4ai4R
	4Ifvd6BaQn1Ff6MAtueSC3wGouMAAGiKDSxW7zjQRlsrVHe/FJ97a9M13E0m7ULK0wA=
X-Gm-Gg: ASbGncvrr4ThcZ1HamOXW5yUdnKzzyO5e4FuEWDM6kXb+jOJCYirYDzDa1sC4CWNcO3
	QncxoYdbBPnSoXLi7D1+mKQsrdUznnyupQB3iAMTmVhlloMCTO0l+sjuQ0W3e7IWU5DA5sv2G/o
	9UjRlyZZg40SAkoGNeGWoWABaeh76JxFoJ4qoWY2XRzwLW0ZAfPcDjgaMp0FMqPS18671RJwKgv
	Z35fvO6fxB4MVz+ehq9SuQuGH0u+Ggc2HImw7C6NRKYphA0W1Jgxv95Uyo5ErorZMLJc0NRIcvx
	hull8K9jr/KrC5uQ3OKoSm5+M+/yZLRcbGWzgLwIjHcTC80CUEzwY0ovz3JNY6EAh0wPeZyuQCY
	yvgD30o0ZW3nEMKeNdegkQBPY7TF/3jT9kOHB70h+mvOm
X-Google-Smtp-Source: AGHT+IEZpDjBctuWqYNRlyG55Wa6Z7JlU2nXfaTVYBNjCJjgFc8SZE+7HVHp1fu8CNukponM0TaUCg==
X-Received: by 2002:a05:6402:2110:b0:61c:7c3e:f7e8 with SMTP id 4fb4d7f45d1cf-61d0d2a9310mr2165499a12.2.1756560372888;
        Sat, 30 Aug 2025 06:26:12 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff3dd9574fsm225212366b.84.2025.08.30.06.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 06:26:12 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Andi Shyti <andi.shyti@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] spi: dt-bindings: samsung: Drop S3C2443
Date: Sat, 30 Aug 2025 15:26:07 +0200
Message-ID: <20250830132605.311115-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250830132605.311115-3-krzysztof.kozlowski@linaro.org>
References: <20250830132605.311115-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=981; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=qwG4c4Xd+B3YoR0uF7y8E1dHfmZd2XS7G30El+hHeyw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBosvvuWOMibAY+sCtkr0eJY9VfamQvRG859Wy96
 p5TeNtYiMOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaLL77gAKCRDBN2bmhouD
 1xXUD/9qOZnQ376tzF5lwUEClQkuLBudqcuNOfdDxwqUDHTvhTcOAWvj2LAGTmF9dF3g1gaNxWt
 ABBXRcxT0uLEoGRNlwKDKAQ7VJ5jUAcckldLBROWWIOPCehaoLHXK/c2rgQKUh8KLyNdGOCK7CL
 ebnU5WbX8ihfVb9s9hbyaQxyLEs0KfONYlJkkdOf4Ui3n1/k1sPqAAucyy0YpiFM9//NaNmXXFu
 rNk5FvCoUTHSeeqGnpzUNc/f9GOZ8YAFoggrq/iHgZs+EIsBLvqwoR0c+x/TL0E8DI6cCu6zNJK
 tCNPtD5Zf2PCpCr26GurjsYx45fg4Gc6FAZo0DZvNDzYV1BtNkvdELIAUZP6UPGFg8bto1AOlqi
 P5CBHIp3cQ/GQfm9+jrmwQAGJ2DFl/eFBD5f6uWB6PkWQlup70I6z8pcbDhnChjj9mUYJ6Hj1yD
 qLzs1EVfH2AuYHR767ZQZaHUtV05/HkftI1Vf9h9xVi1tmOOFSMgNQaAnnbYKOi9dF55Tg7nl5E
 B6LRtTB+RGr5fh3Tf7o1uIIOK3LQ/LtXhuV3mD85MgoJp4TACcr1+BMtzyQfYkKZTIpw4Kd4O7d
 2fMfvxUSE25mvLYJ86YpePN0AOEx1vsA8n1MqUe0KoURjZrrdqvpSS0zxG4RR/U+wgJerDV+G/B W8W9Wd5GXVLh14w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Samsung S3C24xx family of SoCs was removed the Linux kernel in the
commit 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support"), in January
2023.  There are no in-kernel users of remaining S3C24xx compatibles.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/spi/samsung,spi.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/samsung,spi.yaml b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
index fe298d47b1a9..1ce8b2770a4a 100644
--- a/Documentation/devicetree/bindings/spi/samsung,spi.yaml
+++ b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
@@ -18,7 +18,6 @@ properties:
     oneOf:
       - enum:
           - google,gs101-spi
-          - samsung,s3c2443-spi # for S3C2443, S3C2416 and S3C2450
           - samsung,s3c6410-spi
           - samsung,s5pv210-spi # for S5PV210 and S5PC110
           - samsung,exynos4210-spi
-- 
2.48.1


