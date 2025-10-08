Return-Path: <linux-kernel+bounces-845576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F5EBC56A7
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 16:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E133A5C5A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 14:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5CE29C343;
	Wed,  8 Oct 2025 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cEmKfN8u"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3E92989BA
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 14:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759933077; cv=none; b=qU6+EE5ZzF3a3Rw4c5O5pkSf2EY2sk6+wqwydL5p4qNFr6KIZ/bYANaH0CTKYe0wuhR7zevIro8+RZTpfXJhtENP5RE/qtlPjEih9hYfievAna+CIffS6OuhMivU25K+XdiCY7zJG6Mdd6awoaM1sQoXiKo1sxZ9VwXgISsLtSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759933077; c=relaxed/simple;
	bh=8b4Tcv567R/kaA9VnSrKtjEgbT3r1bB5GN0b0RJGt3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uzpSPkx2Z9rGRIYpxYrbKXYMAWfzFly8KmHnLzxjDzBkwEOKU2IrAYK0gHKstgzsGKBimcsshEZIgYxme1AdCuQMMpLg4gKOotxFmhFaa8CTK8mJ96Xif9WXSYpD9aEmyO71IynU27atHRF+7l+B2nwR5mO9n1OUDpK4Q4Vp8WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cEmKfN8u; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-639102bba31so12646713a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 07:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759933074; x=1760537874; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l0Mgl8edq5RLxNSk2dSPCx05BkpJ5f+Ni5BOyoikFEM=;
        b=cEmKfN8u3h8Di2rKsa6FW2JDyYS+808R8+KEIk31k25m/lFiq+pWB7vICJaGrkrI0J
         KQ3ww/4I5Gt5Pl5jjvIpqH5KoxQBja4cK2pbuoU53L93XipTY/z8dWM1llKm2wfH9FaK
         FTl3qdMVD7CLZy5Vl2ttdLajEX5yfvOik3964gDqPivGlDvF1l6MnOwpMdcTjWi/lq04
         GFLKV7fIyqzFlei6qeTpdprqpro6W1vf0ywoFrt0hq0jlMA4neGN4WR9iFoSuPOqFrS9
         3QBQSjDfZ/BSdKGcZrCSY9euh3AEQzmYMcd0hJ1w7CEDA6SZZXXI+NrqUNjOwGYe0hbx
         qHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759933074; x=1760537874;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l0Mgl8edq5RLxNSk2dSPCx05BkpJ5f+Ni5BOyoikFEM=;
        b=VwNKhZFHLeRCnz+EO/op+8Nb/J8O5oZDuOLuq34inKwmg63OmV7VQpsTJsZhvnezzF
         +cWanO0ris27s8yZOHk2HofENTypxNGGU8BKBcLCCoTxH8nIZ/Vb/raYaH6IOSt1036g
         j87DFEI6Hy2J3UaWAlMXa2pKOlqRk5A+vLe/T7aexcEOU7ljIFcLoMFUyAb7lDZPhbZ7
         pnmyRdAs/DUP+aEn5cbx7NWkRqnxzoZntUtCrvz3EvDBPz7FK14zrjeL5hjmuK/ZVuIF
         nMbwTf44xNtOqTtTQ23FixfOVUGgYTXDTN/TORSqHKhjcuKa+tqM0TXnrOzs5u9xQl9s
         0Bzg==
X-Forwarded-Encrypted: i=1; AJvYcCWDgjkv3/N8YjPNdSKIGVjY2gGZzlWr5J73TF/dA5SjA6j6ZwsotlzVxih83SOpTO1r548pFq+ptANd89Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4pRPYwQnhIMVg6eYXzwq37St+FVtLXVnEcqaaB1Hz6e4ozE2D
	0Topw9roZVc2EMWhUFEcp+0U0YQj/56nvm77rz6eLyW3hPXBVJZK8/ZT9C7m7WqrxMEpAf9ElU8
	vzHMbBTg=
X-Gm-Gg: ASbGncsb7asuYGimc7KTI2H+LVoXxP9KHZwC8n7ZHmpg2od08KLvGhghwC36FXLKsHB
	Ocx4LS5W2w0Jwz6GxydNDeh1zA2DUaao7MEZvmUXm1bHLZ6rGk4ctBW1GeFrvgQdWZOhYjOXali
	OpXZWRugM1F09rtPA7xpCN8GZeeO8NZST781bTi9dGux2fBuHkOGGiwWY7IeJbsXDOWIODYyg78
	ESAyRCWHr09ZbT87NYNnWKxLJsv+00e+z3vgRNz6Fn8xVrW9hFAodrC9UMLJdHejePFnSRBukKk
	e2qWdZ6N0dsCy1wsAAPF59PC7Eb9FI543rNpoZvPxqf5GQBQtAwCs9DWnYp22citJB8GTaLXiBx
	/jKXSkXaCBI69DhnqEZUOIIiBNtXDHBnRV+XjF2xrtn03kcL/k6u4GgsMmiuC+mMp1u4boaUBR0
	FSBOmyKWf1A4NHT6RGOHr6Y+kzR4y+zFjHJDH2CfiR
X-Google-Smtp-Source: AGHT+IEC+Khx6oHHPzc66dMG7HFLPgpbH+NvJ4gD7eI0FKThBdRGPlHYqDkbnKuylc90hYn877bNzQ==
X-Received: by 2002:a17:906:794f:b0:b3a:a16e:3db8 with SMTP id a640c23a62f3a-b50aa38733cmr389753666b.20.1759933074280;
        Wed, 08 Oct 2025 07:17:54 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652a9ea1sm1656287366b.16.2025.10.08.07.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 07:17:53 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 08 Oct 2025 15:17:53 +0100
Subject: [PATCH] dt-bindings: soc: samsung: exynos-sysreg: add
 power-domains
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251008-power-domains-dt-bindings-soc-samsung-exynos-sysreg-v1-1-ab41c517dec6@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJBy5mgC/x2NMQ7CMAwAv1J5xlISqFD5CmJIYxM81KliCq2q/
 p2I8W6428G4Chvcuh0qf8SkaAN/6iC9omZGocYQXOi9c1ecy5crUpmiqCG9cRQl0WxoJaHFyRb
 NyOumpanNKmfsic6XYfBhdAlaea78lPV/vT+O4wcZQ5+DhQAAAA==
X-Change-ID: 20251007-power-domains-dt-bindings-soc-samsung-exynos-sysreg-5dd349912b0c
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

Sysreg can be part of a power domain, so we need to allow the relevant
property 'power-domains'.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 .../devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml         | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
index d8b302f975474a87e4886006cf0b21cf758e4479..c27d9f33d5a0501018aa3a52962a59257b723fa7 100644
--- a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
@@ -73,6 +73,9 @@ properties:
   clocks:
     maxItems: 1
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg

---
base-commit: 3b9b1f8df454caa453c7fb07689064edb2eda90a
change-id: 20251007-power-domains-dt-bindings-soc-samsung-exynos-sysreg-5dd349912b0c

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


