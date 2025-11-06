Return-Path: <linux-kernel+bounces-888886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 917EDC3C2D7
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 16:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AE86188FF96
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 15:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2901C33557E;
	Thu,  6 Nov 2025 15:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zGjlXjpL"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E9E30E0F7
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 15:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762444330; cv=none; b=cw81jGtt5+PjsrvwWzsAHcLS5Vtta5mx2VUeKFjZeabvjq9flLpOlWZsnfE0QbI311XDQjQfMOaYBLy94ds48TFXTB33BqoVVRYra5D5Pw7NnBdrT1nL6d97Z6PkI8wa2/Rz55fU+fIl2ljUt/HGb+IQ0Zgt12K8tUs2NCAskzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762444330; c=relaxed/simple;
	bh=XR9rI1E/GjUSg1P4shHRnyIGbjZqey/ajz1O0S2ON+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AainMwWse4++/pyv5+FJl1n0Vj4eN0TWyYt14t807vEEPjQws6/vAZdCK2YGmeM/UyKNKwkaGBtIQkA12CE048sx5ymw2JvZ/sqiJTHyYawPq6GA+sXiPpHwaknAU1bNdWEHPahwmslB1+yCEA4HOr/JE1m5rIVkjGujzKmHlkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zGjlXjpL; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640fb887e26so218569a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 07:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762444324; x=1763049124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/pDXK1AfCX+Hni59vZriLv6LYkpG1vOii9jrnO1YhfI=;
        b=zGjlXjpLIkRDTJcgZvoF0w4a0HcZVqZ5jKf9SpNeasD14T8doVN0/B+i4QhRNLYO1E
         fIPhu+Wkx+R3Q29gTly4f5GZtLhYZLaqb4QIBv02wCNVE79aSKG8m2gcw/HwIlM34QbN
         VaaaaidTYQC1ReaYtsAuwg6HrIfBHIDRqPUpSIYh6tQLvGfZwvvGceWDR287btnegVUT
         aMEn3so6YmY4xrjvpJm3qI+LZRb242EvTwTVhnm1DfQsTMIwf78UDhBE2OYqeZlUYleX
         NaI2q1n6zYYljH/69BisdDieqxJ+0RQi7rlkHZ3efa3Gc1/S3fIO0s12TNAGCdwbKfNE
         470g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762444324; x=1763049124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/pDXK1AfCX+Hni59vZriLv6LYkpG1vOii9jrnO1YhfI=;
        b=ZlLj2DE1bmfAK+F75OBT5nqToBeY5oUXKxlVfVydCKnkj9lXJn14NUVfVV39vobxq2
         zxRET66P8vYcEL5x2NCTtoDDS3beICpOT+xz0EwIhZF9ynLT5823kDXsCIK/f8mByxUF
         +8x3TxIHX4Ztb0FR2HwkidMzl4uhGpTN1ivmV3jO3cIX+tUoc3+4LYav4iPh4n7Xd/H1
         FFcIur9HSKsjsXuPOiYjAvBUDdx2ciSd35/3dUf1uWOHX2fRIIole6pHhCfLEXhdHz8u
         kanj/qvxSqX+/30CM6pb4fUz1Jo5F4BvSJ7oX+L8mdGDRiBjZQ49QzbLp2xLkPQ0KqSG
         6DlA==
X-Forwarded-Encrypted: i=1; AJvYcCUuFeyg/U3rYHQvQkjtDEVZX2oFHma6doFYsoSb+aJKFWYVpFyslDpfG0ueTSUBhc3xwG6kE56F4npbj8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU1YfGZt5qYK7dCL1r12Ay35yoikx6UWgNH1GS/hZITy5+sKrk
	/i1v6KSx93BqcSaWTuyBlluhmJ2HjTG6rTclaYjE1+89KXzuV0efXqQFa7onW14evig=
X-Gm-Gg: ASbGncv0LadCdYKpPeV8Az7xYMOmffk0d4ItNSwe0fmD4R6Bbm+uSApQs4/xaHFgfXj
	iridUNm4roCbA/5Cpbijg0FhEf11l4kunPsBYBTPZsKaHqBSizUkL4BauJuWkMUP165uWwJJTj3
	3CP1eJwgH9uL7laF1zxJKVHrLZrstxsFVx7bgJEWYOMjJKPQUmeM4EUgKTRIvV2AyQSlH8jtWAL
	TzD1wOM0Ncstz8e00ftfl71GF2fghySG9uhrsBXjQ3V1o+XSb2OffMi5eXPVPNkPUa9og5e3w6a
	1rar1O5Ie5Lo4t2XpgEa8bgInaecBc2ZX6+uP/Yhfu3bUROzhk3B6WnhiVPBBxqwp8s5O0XDjZ2
	8j+aOcYtCvKRlROHNSnpqF3TpWjIqtDdx3QvfmpvKvySAIXLspXqFhpzodZ10quAt4l8saJx8Nf
	Dg8Ho2s8HR/CSI/0n6aAtOPA==
X-Google-Smtp-Source: AGHT+IHUL9GfAK2sSZIr1pdLdb7oSwV39dHOCg6krXf3O+qK4JxFrJeVUTzcLdiPzK33dR3osdKvNA==
X-Received: by 2002:a05:6402:2683:b0:62f:3041:c7d4 with SMTP id 4fb4d7f45d1cf-64105b9fca9mr3869113a12.7.1762444324485;
        Thu, 06 Nov 2025 07:52:04 -0800 (PST)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f8575eesm2067292a12.22.2025.11.06.07.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:52:03 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] irqchip/irq-bcm7038-l1: Drop unused reg_mask_status() function
Date: Thu,  6 Nov 2025 16:52:01 +0100
Message-ID: <20251106155200.337399-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reg_mask_status() is not referenced anywhere leading to W=1 warning:

  irq-bcm7038-l1.c:85:28: error: unused function 'reg_mask_status' [-Werror,-Wunused-function]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/irqchip/irq-bcm7038-l1.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
index 821b288587ca..ea1446c0a09c 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -82,12 +82,6 @@ static inline unsigned int reg_status(struct bcm7038_l1_chip *intc,
 	return (0 * intc->n_words + word) * sizeof(u32);
 }
 
-static inline unsigned int reg_mask_status(struct bcm7038_l1_chip *intc,
-					   unsigned int word)
-{
-	return (1 * intc->n_words + word) * sizeof(u32);
-}
-
 static inline unsigned int reg_mask_set(struct bcm7038_l1_chip *intc,
 					unsigned int word)
 {
-- 
2.48.1


