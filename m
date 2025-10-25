Return-Path: <linux-kernel+bounces-870024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A887C09D91
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 19:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59D0B4F1AF6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C008D326D74;
	Sat, 25 Oct 2025 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAlH4WjY"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B0D325499
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409759; cv=none; b=uB+DTE7HpoQbO7rga+07kmUemRsyzs1euQ9pwggvn0w/YNidhuOSfyVjmTBxozjx2iioyb0cobqNPd2wN8P3bH1yTMcL9i8adbogU+zpvFTgb+wPIJWLbv3Zu9YC16t3lmRiSLBO9oLNdeeVgFmSzYf6mea2Q2c/jmhGMAd+HlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409759; c=relaxed/simple;
	bh=HkqvAUV2gBzhJnul/mGo7LdzjzJg+2pG+539ApHOXFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LZxG56qu5qj/P9uRKZSQ6FxNN3xTSQAuQuTj6rg0O3074FYsZxi713O+eVYKwhMUR2aHtGweclY3MKcQ6G0WkF7wwPhE+oRRc/M40nn8ssyRNTB23qh7SZitm7cqnP3Gc134W9kjqsdSS0Ak6wSVxeLA12VOtOI/IqTereGY7OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAlH4WjY; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4e8850b09eeso31812151cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761409757; x=1762014557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXemVp+XP5C7K8PhG6mE03zKRPQX07LLYcr9/0qBaeY=;
        b=BAlH4WjYhecUsYZEjLlGoW1SyTKA/DfDx40EXXgmemoZJ4jYYC7+wqIKNP4NSJHXh4
         avjqWcox3Te/nA0tS2z4G+zmy0sJ0vSXRhTc0M2RxOQJ5Y8C1lzrmKGkAfQxUsQc/dXr
         mQIFJraHF4L69/cCFDRwOPzJpZpJWup8ocDEkXC/6k9WCkPBQMmgbCqzPDCcO/xC9/xi
         CMCLLd9RLm3WoRij+L6FB1aEBMFItzWObRc7H/JMezDbWG4bD8xYQ5CLJvUeNvI0m87E
         wv7G85HZzmzNxgzvAWLvpOiklEdqF/u7ELxUP/4inf/COi3szM1qXvNeRbTzvDUsQFq5
         EX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761409757; x=1762014557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZXemVp+XP5C7K8PhG6mE03zKRPQX07LLYcr9/0qBaeY=;
        b=nYCT99lmaMtI/038bqlq0oA285/T3jx0QlzFKgn3QuNy2M7oL6/fmMYsCPO3brt6uD
         PTR5Lp4Xt4kbfu0xklIPFUkOnbMh+KiwNvIyY/gzBgvtZeFE2l1O86aC7I72z5rccuOu
         0bCUDz8apmVyyYrQwUA5QlbHU0OGfWK3anYfWhYB7sKcfW6jG5r1LSnaU793QErnnbdc
         +9Z79hKYItD2TjVWAoJWRJJESnZRj/s/DL7WVICTZFzQXI9skWlj6jBhaHmgX5l9KhzJ
         HQjhndK2+VudcvShrfO1kdOVLrjl5LgCgbLwBOsJSzrKluq1fFDn4HsvoM/rEewYk/a7
         Mpaw==
X-Forwarded-Encrypted: i=1; AJvYcCXKbrIHjzqHf+8KEeUp4xNyvso3HQ9p6CpSZv7Sa36NyUBKQmHXXEHBOpMVtYB2vdHMtx5oKjeFTAaMkUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+BVhY6iPF0m/vzZxLZTZqkrPimOgZ31ANEKN1WUXWkvtpGym8
	DYaQtL0eQrFa3eQhm8RTplgPGK5s7wGJ//TrotcafxbkPURMD79g2oKb
X-Gm-Gg: ASbGncutrDWWPwHWs+NU9lZBT1lk/NUvgxAB0vg9OLUtUC08Pb6RO4u8bTHQbwZHwQm
	4el5DJsdu1/0oatNGw15e10zr3QhCwhTloI2e186DMyugQrRBYKKBdrVnO0eoOjYg6bYG22EKKO
	XVIJ1PHscDkq2sW6DD3sYPbRywpJxlT9R/8tKeGzpUhLlmVxRAjx5U01sOFjELVhneLrno47N+a
	szJmppvQ0se2dZ9qdA+s6LiM96AMsn87l8PZdohH5vXRTwIErMv33h4UrmDI+IKvOlmekwoFiH0
	a99nEIBvytt4l2eoeusQjRJS6QuJrrOZjapRUFL3Z8xCArvIJgnduSPyindIk5cYyHsNlJol+mm
	lhfDyGFb+z02A6sR6Cx3VNa+AxKkdC6bKjZplJanYJH38+mdqETJDVkngoz1S8X3I+MRWTZk8
X-Google-Smtp-Source: AGHT+IHpyFrHKiL1MaHe1LWs1dN16AdeBx6FjJoNTEhnZ8XH3TR+6NumbQnfk6ta4v10mj6oyfvxsw==
X-Received: by 2002:ac8:5d8a:0:b0:4eb:a8f4:270d with SMTP id d75a77b69052e-4eba8f48ad8mr17559461cf.65.1761409756596;
        Sat, 25 Oct 2025 09:29:16 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f25c91d9csm170613485a.49.2025.10.25.09.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:29:15 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Lee Jones <lee@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 06/21] mfd: prepare to generalize BITS() macro
Date: Sat, 25 Oct 2025 12:28:42 -0400
Message-ID: <20251025162858.305236-7-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025162858.305236-1-yury.norov@gmail.com>
References: <20251025162858.305236-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding generic BITS() macro, add an #undef directive
for the existing BITS(). The following patches will drop it entirely.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 drivers/mfd/db8500-prcmu-regs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/db8500-prcmu-regs.h b/drivers/mfd/db8500-prcmu-regs.h
index 75fd1069372c..25d2d5966211 100644
--- a/drivers/mfd/db8500-prcmu-regs.h
+++ b/drivers/mfd/db8500-prcmu-regs.h
@@ -12,6 +12,7 @@
 #ifndef __DB8500_PRCMU_REGS_H
 #define __DB8500_PRCMU_REGS_H
 
+#undef BITS
 #define BITS(_start, _end) ((BIT(_end) - BIT(_start)) + BIT(_end))
 
 #define PRCM_ACLK_MGT		(0x004)
-- 
2.43.0


