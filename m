Return-Path: <linux-kernel+bounces-867769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE95C0376D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 22:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B98433B1695
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F792D5924;
	Thu, 23 Oct 2025 20:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0xXSNNGl"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AEC270EBB
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761252798; cv=none; b=K5hikja0JTuvH1IaV2WBdHeRzdX7p8gqrGWT28CxWsyTr/CHmntmQm+xEae59oPZvdNm+/hqv+d7ggc0Bg5QbbfB2VsftOe3Zr/9Y65fDLHewNa6DTKaWhMlLE5HlYOppJrvJUKa5wLEEm+vqK4NJ3FXJJdASouLRgZzu0vztD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761252798; c=relaxed/simple;
	bh=osKoAFkbQ+bMRzkFjXuuMZNRDBV5CkEsQ+WWxrz7Ba0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mz0ehrDS9f/fh5PH0KSg8gHAXI+vMMJ8YTi/VTbv7aACHbTMxJnj1iM56HYPrBEBydrIcsGBigDWdezQ9YGY+MViNu3WqEta4BGDRQMog/OqpR6h60vN8KYgMaDpDRRKuG8JXGiISXLKGw++X6h9vpG7IQTaH8aBRnPWoJwdD48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--willmcvicker.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0xXSNNGl; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--willmcvicker.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33c6140336eso2733275a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761252796; x=1761857596; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o8cB2JKISSz6B9qz7HS2qbamQvKm9jtJ2xZpz8CPDiY=;
        b=0xXSNNGlk3OBpWsqmFbyQ7A6HsB1mLX4k8T63bSix2UHLlEGhw1771xDCq2oScOWXl
         ZhCui+UStZHYopiiP/8DE83xLBzICnJB1sep032z/qltbyUDQD2K+o4d6ZzrfnDJIxTg
         g84HQNcTAoWB2rXS9kJ1PpjOrAHpOPOmTfezds8ESFqYBdGjJ9B7AmgXDEsClprf40gX
         rQ+Rl8RMPBKu2GlggeUOVHqLLWTLnriCBvPUgGpeZmexEMOJ7NTi3dwh95xN+B8nYcld
         UgYl4n0NBENyevcY8gRR/p6ER1EV+tphjXNjJsA5KhFFDTnNWtGyiVE3MgROtExFEPbd
         gY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761252796; x=1761857596;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o8cB2JKISSz6B9qz7HS2qbamQvKm9jtJ2xZpz8CPDiY=;
        b=HuPGfvMVHUd0ykNTGPpxUncSvMH4Y3jZChAfT9lTVID1bjF/OfXxqcbTjW+QCHBi2j
         NacrQ/Wf8qyXQRU43d230EOiQq7AyEcruifGvpf73dxWHyWtJLX8DIlDFpFN7X4VkeJX
         eEuBuh4YSj6vZKBz168OqdDTzXXzRr7TEnXvF6KlJvNUtEHVarjuUCdEAVvlIykj+YDD
         0FKnwIGEmuW3kig40WNi8d8wc6VBueXZF/pGMRo16x3lSIgLAWZcj9i5VnT/NiHGcFU8
         ypFKXjO3t0k4Fru0HXjh/3H4+s3SmQyvABdL+KrfKpB3+v/GCKuV3sWV0RBiU/5pdMqB
         V+Uw==
X-Forwarded-Encrypted: i=1; AJvYcCU0iU9DPN8m5rKRhR9BZ5rjkZcUHZ/7hFQaX1BpufOag8UK+4+Ax3Rm3TU7PYj9q/XSiOEvqCkl99BrulQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwojXCXvksQL5yxLvlYTqQnz4YOq6YXSOyJlD190jTxdcPrjyJi
	lMHEc3synx9l1MQddcE6bmiSS3dwzW4/xLbgSIns/DQqcXq3PSgS6wpNejlHh3WJgtjJxwhxUgg
	70Snv7h/pcKbMv4Iv1dskisLacXLZgQ==
X-Google-Smtp-Source: AGHT+IGHJ6pvvQTONfUgausz91DB8YXTKIZ2yC/0dVMsDeXg0rMdse/dnPjwuJXay8ZVELJRf+0mhTMoklNFavlOnNM=
X-Received: from pjqf18.prod.google.com ([2002:a17:90a:a792:b0:329:e84e:1c50])
 (user=willmcvicker job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:d44c:b0:33b:da53:d116 with SMTP id 98e67ed59e1d1-33bda53d1f3mr36146909a91.26.1761252795891;
 Thu, 23 Oct 2025 13:53:15 -0700 (PDT)
Date: Thu, 23 Oct 2025 20:52:49 +0000
In-Reply-To: <20251023205257.2029526-1-willmcvicker@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251023205257.2029526-1-willmcvicker@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251023205257.2029526-8-willmcvicker@google.com>
Subject: [PATCH v5 7/7] arm64: exynos: Drop select CLKSRC_EXYNOS_MCT
From: Will McVicker <willmcvicker@google.com>
To: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Hosung Kim <hosung0.kim@samsung.com>, 
	Will McVicker <willmcvicker@google.com>, Ingo Molnar <mingo@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, Youngmin Nam <youngmin.nam@samsung.com>
Cc: Donghoon Yu <hoony.yu@samsung.com>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, John Stultz <jstultz@google.com>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, 
	"=?UTF-8?q?Andr=C3=A9=20Draszik?=" <andre.draszik@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc@vger.kernel.org, 
	kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Since the Exynos MCT driver can be built as a module for some Arm64 SoCs
like gs101, drop force-selecting it as a built-in driver by ARCH_EXYNOS
and instead depend on `default y if ARCH_EXYNOS` to select it
automatically. This allows platforms like Android to build the driver as
a module if desired.

Signed-off-by: Will McVicker <willmcvicker@google.com>
Reviewed-by: Youngmin Nam <youngmin.nam@samsung.com>
Tested-by: Youngmin Nam <youngmin.nam@samsung.com>
---
 arch/arm64/Kconfig.platforms | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 13173795c43d..fc6026c368ca 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -128,7 +128,6 @@ config ARCH_CIX
 config ARCH_EXYNOS
 	bool "Samsung Exynos SoC family"
 	select COMMON_CLK_SAMSUNG
-	select CLKSRC_EXYNOS_MCT
 	select EXYNOS_PM_DOMAINS if PM_GENERIC_DOMAINS
 	select EXYNOS_PMU
 	select PINCTRL
-- 
2.51.1.821.gb6fe4d2222-goog


