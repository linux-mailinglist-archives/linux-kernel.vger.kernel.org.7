Return-Path: <linux-kernel+bounces-891722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0F1C4353A
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 23:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C53043B2B72
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 22:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A79528C009;
	Sat,  8 Nov 2025 22:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OreAQ2TD"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F07284884
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 22:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762640276; cv=none; b=Xx5N4j0MzbFsUmUpXCDAJuxM5cX2wPTYRy5oIfcc/CF7MTaFtpSCijnF3qNga7WPQfWpDB5ttwmQ3KNcEIObb+ufUkwSjRRKFKoQXmvF28ccVADfNHsOkGNvwHHg8ML+b6Azm+hWN+3M7onBp4h0gdk24wI4KPWYWtxol0p1itE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762640276; c=relaxed/simple;
	bh=/52sgte9woUhDAcbwys1yM15CZcVFVv2vlQyUBAgYOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NdPgjqSTxB+Iaz4Y90zaTLFn4DiwDqufQURYwAM90QOTCaiSelmf9Yr09gNDrweX4meNwUqItoA2Ve+GXXBtTvjiHgPgBMx8X1VtBoTvqeJN9nWF1RQ08n2RSnQeJzxINfXQvANeFUDw7gx8P2LyWyY6dOyYAD02FVvpMwSRmvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OreAQ2TD; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-594285c6509so2093634e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 14:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762640273; x=1763245073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TxZAPUKdi9AxX63zPi/NWqNTntX+DYqp6OrCNhCWvus=;
        b=OreAQ2TDG1hYeqEqL87K9yAfJN0BeshhM/EFqJrdNDFQvpMM1D14OzSZGC3ge2GCMZ
         Up87yc8XJAlyX/dvnwPj5C/GZkFe9+vp+QjHR7XuemVjFx+1VQpToJho/6oI7Cfy1B1B
         LQT/o5QqjFRxW3B/fEqEYfgHZ8XrQ5Ahit0ziA1u+njoRURNvabS+6i49xCt2ML16k2z
         lgx3VjGjjAZtaktP/bZe+043AeZ7R4IFafkVdzynjpzlkGRR671aGS0zRm+FyCaMRbei
         ugwvzFJaWHWuwDJKue8Bggj5xi3xSrYpx4D6+7bOJGKsw33sbf4GVKF2JKjS4y5yE0sf
         oXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762640273; x=1763245073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TxZAPUKdi9AxX63zPi/NWqNTntX+DYqp6OrCNhCWvus=;
        b=Aqfqeh75NYtkw2bSguRG5FvLcix7rmxwQrhk8CzNjE1sV7Dk3t13HgN7Dj91vm+/hC
         iIykgCxBCaWfuETixg/3A0jjXksgBqjSBXeVbGx541BP0FMoe/YBUh33s2LsKO+MVFzH
         2mIZm8X1D/N7J5+DJQTMqN9vEc02Jh3nrQho6NP/DIZvMCQczDIxvHrGUXul2bfEND7H
         cPPVaXz+rg8mwAB+cq4hGlPOwFr3Le84wY1ubNo1E7rwvSh9XuXlWoHEETtValNTaTV/
         s/rQYeS0hbjSUIWN4RrSYataWN81h7/Q/KAGoy96/fAHk55gbXTkqnsVx291HtiCEqhN
         3gbA==
X-Forwarded-Encrypted: i=1; AJvYcCWawWhEYsKaaW5wHeESBrN23V10dKgRpONhh0YX9FFTOg+8QsMSngTj5CWbAcbCbMQPMIM7z0HEmHiacYc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz63Hm0zlBxFAuP5nOsJKKeyqoF0EN4T1ZR1b/GhHEGhyiMEQNu
	gC4RS5Lbzc8iyxtY/UEFoXm5bji72oVvKfPteVWFmBDS2mYixpsKlWeN
X-Gm-Gg: ASbGncvA/wikT03bAHYK3chs4aLJ54/dIYuSUIeR0TxW7g6boc31Ml23Sn+jyrAKByx
	cFQTEqpNAU+5hzMpC+Gm3ScGihXBfEyoW1ywxiXbK4JCMC6bZCm5dkGi6NC2v/GPMXg6mRQpNus
	j1CvrG04giYydFNDPAJ9oQ3jYcUH1SFIGlHSUr0ollfKV0FVDG+BKzxG7AQ1+eolrigXe7hANtU
	IHNLHJrlK1bdompJjqgUn3qfOb3MiMkvDW1R2BWFRm76Zl6196iAZJPtNladYtlmqlvFyIWck7L
	GW97rrZPqGSZG8DWJEn78haLNTA13ys2PchJkx/wZnGlJkxnAwSPKpRRd4tQd8YfXX5I/xXAsCX
	0e0LiSqN3s5qjiwlIYAA6U5ZdMnL3sutqGcWLx/WHjKQDxcCfamvvCzaMNOQIIrc3sODYzaMb7T
	lXwQ7wuNbYk+KrB4QUDsYQmNNBO+DhQrQMmO5jGGpO+HQWXtu7UzAM2g==
X-Google-Smtp-Source: AGHT+IHolDwBEdVgVHkXvTMdRX9qh3n0EPVAJ6MxeIpHVw17L7ivQtjPHHGLRV+poAHUxhwCFcmwTA==
X-Received: by 2002:a05:6512:2209:b0:594:27fb:e7ff with SMTP id 2adb3069b0e04-5945f1cb40amr1082915e87.51.1762640272741;
        Sat, 08 Nov 2025 14:17:52 -0800 (PST)
Received: from Shofiq.home (62-241-229-58.bb.dnainternet.fi. [62.241.229.58])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59449fd04b3sm2620347e87.0.2025.11.08.14.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 14:17:51 -0800 (PST)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: nm@ti.com
Cc: ssantosh@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH] soc: ti: knav_qmss_queue: free resources in remove callback
Date: Sun,  9 Nov 2025 00:17:41 +0200
Message-ID: <20251108221741.48610-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251105013049.45646-1-shofiqtest@gmail.com>
References: <20251105013049.45646-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the TODO in knav_queue_remove() by stopping PDSPs and
freeing queue regions and queue ranges before disabling runtime PM,
mirroring the allocations performed in the probe path.

This ensures resources are released on driver unbind and avoids
leaking queue/region state.

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 drivers/soc/ti/knav_qmss_queue.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 6e56e7609ccd..1e5f3e9faa99 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -1884,9 +1884,14 @@ static int knav_queue_probe(struct platform_device *pdev)
 
 static void knav_queue_remove(struct platform_device *pdev)
 {
-	/* TODO: Free resources */
-	pm_runtime_put_sync(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
+    struct knav_device *kdev = platform_get_drvdata(pdev);
+
+    knav_queue_stop_pdsps(kdev);
+    knav_queue_free_regions(kdev);
+    knav_free_queue_ranges(kdev);
+
+    pm_runtime_put_sync(&pdev->dev);
+    pm_runtime_disable(&pdev->dev);
 }
 
 static struct platform_driver keystone_qmss_driver = {
-- 
2.51.1


