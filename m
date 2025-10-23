Return-Path: <linux-kernel+bounces-867750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FFFC036E9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 22:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3D724FB94A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549EF273D75;
	Thu, 23 Oct 2025 20:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mwhUkgIR"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4EF23C50F
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761252652; cv=none; b=ciO+FRJmz2qs5m3IqBit/EvJ/H00A8pU6ZrKHjYNfQu9t7lAK77aWcJ1lJRp1ddH96R9YfNg578l9UlfrkTR1gc5L/Aybz7pnupKQOfNHeNneFVocKp+42gFhmNy4/wJa8U4ILsmfBuTN+M2hJfP/8zqZEnVyVIODwQAwPRVluc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761252652; c=relaxed/simple;
	bh=vidsleBrv6UezkEOZ8wsCGdMuLsh7QY/kEWRWgsv0s8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=owqvuLzkIbJ6R49Nd2wKXvhYjpBh7+3dQxHEC3H6uDmXTTAkoQRXWeptBNu1wDNtrvgX4pWihmF5mvxMi4xGEuIC1RQ53KCCUyCYq4Y+w3j3aMr8AoGiFGe7A99rZ0f7kFsfk7s2SFxPy2Ygzxwqu8MHsR2QMR2j7giPjM+yBo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--willmcvicker.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mwhUkgIR; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--willmcvicker.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33ba9047881so1462697a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761252650; x=1761857450; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GTNDlcC66j9mF3WCrjdhKpeenuKBiHXH6QybTCxkPhc=;
        b=mwhUkgIRgzV7DgzYp/pQsduxcK5RRAyYh0XvhJEOjXPTHtFgdKjC9yizrZ4rl99YZ9
         DGr0tH2ZqpDZNEiypG1vYDl6Q4NswMCcryEwrHlHxNHy1H28EAyS/A/Jsr5+5KmcTq3v
         rSfsgGGV0LOqR6O34ELDKlbad46u9d8YHQG9M1YOjfojQyhXXTn6au7/CIFRkuJeN5s3
         iwCda82RFQ8KDpumEtunpDJXWjqaPATY88a1HhhWzZlzDkWJWHTi8ywGQoQz3ZkDap2c
         5ZkjRHw4Lp9XhNM6eYyOYk7QjDKGp4Rk90fcA6V3jny+FH19dXIJlxbhYdYO2MHdUc3v
         fk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761252650; x=1761857450;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GTNDlcC66j9mF3WCrjdhKpeenuKBiHXH6QybTCxkPhc=;
        b=gp7KuJe3qhisUL7OY5nbG3UDkQOMheomhK48xYEZTMp1HmC1y+J5d6xusDiZOxXcoN
         3sL914C3me8CuB/kl+nJ6ZQ28tVO7uPel59WDB8Ggr4aQt+pVvZ60GWBhJ0DTHRz+fwK
         nUkViYL6PvrPdjgbbReofL4ZfUZXvxTD38llbxyzYBijSwuz5vKukRP/OitK7H25Nlk4
         BtMrCJ8g3IKyfPX59kaTQBYTViKo08gcIPn4t80+GcOaiD4gICaMhqMsTmLNsSiH9pe1
         0kimu9nEIbYFg6qeWULnCt/biyRWXPQcvIerVV/5dZc0uwjHEA2SrB1zwOoVJMvHvn9B
         eiMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/QGmxxvGT0iV5J/TPQwmBiYJTQtMhAfTFiei42EXiYoBnFqXdoQspNZ3Mx5+yJZI/lPmMVrQTxd/l36E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEzDkbd6UyK43IMQ6uAgVIXRcLc5RFU/Ga3mVH6GH5TlkNNIlL
	WGVS5lavFuUp3BbDwH5q49gfiO+1QEf72OSmrgooCpauSXPKYR2L3ZLh7sg4Qjv8T2SrJosK98d
	XzmNNXrGNz+rqUP9gKfPaBIlBIEfIuw==
X-Google-Smtp-Source: AGHT+IGNMg2DMCJiL+F+pPhnBIlXppfMVHZRBUW9I2WIAEdbh06XGL0yXf0m3s/lwp4/2Oi/pJT3D4KTbFExW6OHopg=
X-Received: from pjih1.prod.google.com ([2002:a17:90a:5801:b0:33e:28eb:7df2])
 (user=willmcvicker job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5490:b0:32d:e309:8d76 with SMTP id 98e67ed59e1d1-33fd3bbda7amr336959a91.10.1761252649957;
 Thu, 23 Oct 2025 13:50:49 -0700 (PDT)
Date: Thu, 23 Oct 2025 20:50:27 +0000
In-Reply-To: <20251023205041.2027336-1-willmcvicker@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251023205041.2027336-1-willmcvicker@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251023205041.2027336-2-willmcvicker@google.com>
Subject: [PATCH 1/7] ARM: make register_current_timer_delay() accessible after init
From: Will McVicker <willmcvicker@google.com>
To: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Peter Griffin <peter.griffin@linaro.org>, 
	Ingo Molnar <mingo@kernel.org>, Youngmin Nam <youngmin.nam@samsung.com>, 
	Will McVicker <willmcvicker@google.com>, Hosung Kim <hosung0.kim@samsung.com>
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


