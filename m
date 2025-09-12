Return-Path: <linux-kernel+bounces-814268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 704E1B551D5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3EFE18877B0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9805E30103C;
	Fri, 12 Sep 2025 14:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PSULSN5f"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D908528E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757687459; cv=none; b=Tnz9JdXlzM7mPUaTP68NErdjxrN/Rwuu7SzVYkufv+pVznghLd6mfsDw/lUKDnJQFJXt4BrkF9OOQNAJIKeXEcwyzmA0P8NMmP7nQKOq5C0Qz70211DJxWi3CoInN1hYJZ2QQNI/W0323J2blILs8JU75bf2XmUISKVdYv4UBjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757687459; c=relaxed/simple;
	bh=wucKZjXUVtRxrGoS9CppvLYgJwFvEG8gqGPWzlZGBag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lXvNf8f6mD4ezl7WjywRTzqnqprFbOk9BFKhJQxqPbnhKlW7k4nHObqkJCkHdawu0sY766b2YPKQSMRD63t+awJ/Cm/ki7DH981hydd40fVZFb0CWaTrdV1jXl62waXtvH0kfPtfaJ1MgcwKwcrC/iINwdiVFVfN7gH4YFop/O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PSULSN5f; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-336b0b3d753so19278111fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757687456; x=1758292256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/qUTD8uROnoCtAqaX/Ri9iIJ3aP0OlkHXH5AZacDoiM=;
        b=PSULSN5fQEZrzG3AEkIAZty38UMeDyZyA9dltEdJUV9lEDSj7xa824HwTQsKe5OLFn
         nDx8hdbTlIIIwYmvI4rnoSExWtFmq3XXfEIq6N5MBC/fWRU8l8039iQWnh+lbZueo83P
         n2QqZEUqqZI8szY2OwwnaPHDloRAzE3tRiphOt8C9w+1KVlwn5CCy4EkwIHqnQ9KgzLl
         5/rdWmZPeLWdYIK8eS6CRKfWjsZ1mtPFdAv0y9O5aT+VsT5GtJ1vS8VBb+4dHXyXJPU9
         VEtpiSdWEkFWpcIE8XTR+AgYjoF/Hmfb2E7iwNbZPkfdaimnTHBSWmccAfwLBUAuZFD2
         0ijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757687456; x=1758292256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/qUTD8uROnoCtAqaX/Ri9iIJ3aP0OlkHXH5AZacDoiM=;
        b=SG1/d1EUv1hNNJf4mPaPeajMZtnh5hzvwjIx2CqGqXgxgT7Rx4DNKL7FNoxkTb+Flw
         8JL5ZJRlr+T2+8YmwnZQVi8HIIi6LAekmE1Sstt/bHgnyzgP8kyeyUDxgk9dNXCD/DVp
         LbpMFIA/ogERSaqkL9XHiOTgzZWSUJwG44/P/q5OoggRmhp1TjbEVuETk/BUOW1N6ets
         m1vMhf0eCDSYP/k/FE4WMYzDJlfB/vQHPNkMf6SgIF6k8dUCEjNjVNxvmjZ3YUgU6XPE
         ZV5EdH7Gzg8A8+euTenPh22qwDohE1T5z5zADZoeZ4wo3N69Wi+Hlwvlmxfn0NuhpcrI
         bktw==
X-Gm-Message-State: AOJu0Yw2GPpcaa9SH5Vs9caafYeq/OBGOixGbGb7YRFaifJ6pWrLvTr9
	Q9unAtX1zW8LLj6NHAvbijjlBU4OlA5F7SAZ859nUbxm/sT+wfdO4TyfXF7fL7ilnPg=
X-Gm-Gg: ASbGnct1U3X8ScVH+1ZOB5imlMVAWftWhIm/rt/ngdN2CLSDsFTb25u+OsPQ3FQtmXw
	rrnrkNacoA/6jUX3+KVpL0HNIJWrF9Lq6gCKHXyg1B7tpsWCmRIkgv9AmrKiYGcpSHw7eZJZryR
	p/Dns9xRzx7qsZhJb4kqGWXBv134Zp5+L78rhi8xbb4GJe/w/q6dBpi6QEBg1tFxA0DfUxCXu5D
	wHr4qMhpwhkRT8cJIQgbsqrUecQpP63/ah39RrYJ+Btb5X8oEjeVlOQWDLsDBTjwJzxWD3laK6q
	Eq3T8LSMU663lYH+sg/a3kM7pRHtW9bIor3uUoLRpWBbCUaI5bk17E5gGU2UvaBfoL2c2v9N7j+
	/NkuojHtCS3oqu5uP6y8nA2QnDn8xYiLPUDV3+Cr/O3PDGVzfmEURe/28P7O8eJABwg==
X-Google-Smtp-Source: AGHT+IEVbatrp/SxHPXDJ7XzOlydV9X5r4NdpCXVehaL+u52W8sQ2+DoFuN3K9k4u9FvHmP6U/Ibmg==
X-Received: by 2002:a2e:bea6:0:b0:335:4d0e:9493 with SMTP id 38308e7fff4ca-3513fc380f1mr9860391fa.28.1757687455991;
        Fri, 12 Sep 2025 07:30:55 -0700 (PDT)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f1c6ca914sm8495711fa.67.2025.09.12.07.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 07:30:55 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Russell King <linux@armlinux.org.uk>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Mikko Rapeli <mikko.rapeli@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v3 4/4] ARM: rockchip: remove REGULATOR conditional to PM
Date: Fri, 12 Sep 2025 17:30:36 +0300
Message-ID: <20250912143036.2844523-1-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PM is explicitly enabled in lines just below so
REGULATOR can be too.

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 arch/arm/mach-rockchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index b7855cc665e94..c90193dd39283 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -13,7 +13,7 @@ config ARCH_ROCKCHIP
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select DW_APB_TIMER_OF
-	select REGULATOR if PM
+	select REGULATOR
 	select ROCKCHIP_TIMER
 	select ARM_GLOBAL_TIMER
 	select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
-- 
2.34.1


