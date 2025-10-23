Return-Path: <linux-kernel+bounces-867763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C148AC0374F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 22:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 186923B6ADF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35827274FC1;
	Thu, 23 Oct 2025 20:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wEcCSZCx"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD68238159
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761252785; cv=none; b=Z44K2SlCFHhmrkZ0HbDOobjonqhEj8NT6mI+ksSHxe/tJhnyN+UieuQdVGyofyINym9O0RfjauFVM6k/ojVEvf6UxYKuf51ryS1YhtMHuEtOw4WXNiY93K41iwWLqGu+ku8jcUsPOaLZkIz4wxaCZdJvJD8+a5Z/w4fJ6qPJT/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761252785; c=relaxed/simple;
	bh=vidsleBrv6UezkEOZ8wsCGdMuLsh7QY/kEWRWgsv0s8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WsKAZHKa+XIc3spFOHarldssZzJn7RoohNtR0p93kWle8x9qi4X7+JNs+QC0BklTMZm+WztHKxlxFI6g6zPXYliGmd2Bk45Qv0Eu1ftCGvYx4F7N6TbpN2yc7nQ3GMvK4x3Cs0kx7u4hktcSDv0H1+pdWTyuYocNBizVAAnIQsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--willmcvicker.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wEcCSZCx; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--willmcvicker.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-27ee41e062cso14171855ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761252783; x=1761857583; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GTNDlcC66j9mF3WCrjdhKpeenuKBiHXH6QybTCxkPhc=;
        b=wEcCSZCxL4O4Dfzjq6WX3cbLcHNT+dSlInHAKQeJ9ZsWpeHE+MH6/UjJLzPGFG2ZH1
         /Jne1MO4Y2aH3iS8TEX3nDtI998LY84x9mDxST5eVFZgAeNdofyxygnyveW4cS8AEYZz
         djIVNECKtRdvHvQF220kuxM7IQReqjmYyl1Dc3zZ7kSdugw0Ht2P/nsAFn8lPmF5R0fS
         9jBxgV1TNzj2MV2X43VznPXM0IgbojXQ3bh6M9c7kVgGHys/rGHGMJecRZlDmvMuqkrG
         86SCA+d/0kBnIad+egBtf1Tz6moMdUMOkYSi1Vx3SerI1RKQbd0ojhziEuClWDYwXgQ7
         sddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761252783; x=1761857583;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GTNDlcC66j9mF3WCrjdhKpeenuKBiHXH6QybTCxkPhc=;
        b=hxtoJa8svtFGycUeuNfibgyCw/QaGKv5F7veodW5j3GJsFZPbMKO1mLl3AhI5kgFPE
         XcziLBLYSiof2YMfhO0z0dOBBmooVMdTCnRPbCmJ42NOTRtL/Tw9fFzUyCfwspeT6CtP
         hTDm7M04ws0ZfCXMICZWzKxqm2dngkKlSqNpMJveCyY4l6eVHbZ5uv+58hOurTkbLBwG
         hAPsHfqTkygoQjBk8Eqa/o+AIzcB3gPn0hiQD8pTBsBmsaImnaqzjSGLJtf3db8eZ3Nx
         /9ZFogRSb0Xf2KfNZ9s7j5YO+aAFriwAUX1xRj/vQezhVpZualbUsqzac4I7EfVjG5h+
         IDTg==
X-Forwarded-Encrypted: i=1; AJvYcCWOgYCz03VsHI4wsRZIZkySh2lV93+u6+CDSzI11aXTQcmnMbQirdbH3lqxEs4/W5YD5oK7JZxAKjB+Ht0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMcSBbtl/lmJo2pzjFHc1nZCTYru0EAFsTU5I/ka7Wyhh35VK+
	BG/HGastStMBMKz47vQiUcOcMLgm45UnAWrATcYVG6ntdfbsoz9dzIsr9T9oarqgIFoStkWXfQp
	KPxUQx3W1DpL/3VoaB23tysLE7z0c3g==
X-Google-Smtp-Source: AGHT+IGZ8YUla39b6Z83W7WgxBQC43Iqqksh+N1ptF+fhn6Q2OrPyzQYe93BSwde0qjKCGwbnFHIHl9SHzvH0QPzRfM=
X-Received: from plbjh6.prod.google.com ([2002:a17:903:3286:b0:290:b136:4f08])
 (user=willmcvicker job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d60d:b0:270:e595:a440 with SMTP id d9443c01a7336-290c9cd4b48mr299453355ad.25.1761252783163;
 Thu, 23 Oct 2025 13:53:03 -0700 (PDT)
Date: Thu, 23 Oct 2025 20:52:43 +0000
In-Reply-To: <20251023205257.2029526-1-willmcvicker@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251023205257.2029526-1-willmcvicker@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251023205257.2029526-2-willmcvicker@google.com>
Subject: [PATCH v5 1/7] ARM: make register_current_timer_delay() accessible
 after init
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

The function register_current_timer_delay() is called from the
exynos_mct clocksource driver at probe time. In the event that the
exynos_mct driver is probed deferred or the platform manually unbinds
and rebinds the driver we need this function available. So drop the
__init tag.

Signed-off-by: Will McVicker <willmcvicker@google.com>
---
 arch/arm/lib/delay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
index b7fe84f68bf1..acfb87143f21 100644
--- a/arch/arm/lib/delay.c
+++ b/arch/arm/lib/delay.c
@@ -62,7 +62,7 @@ static void __timer_udelay(unsigned long usecs)
 	__timer_const_udelay(usecs * UDELAY_MULT);
 }
 
-void __init register_current_timer_delay(const struct delay_timer *timer)
+void register_current_timer_delay(const struct delay_timer *timer)
 {
 	u32 new_mult, new_shift;
 	u64 res;
-- 
2.51.1.821.gb6fe4d2222-goog


