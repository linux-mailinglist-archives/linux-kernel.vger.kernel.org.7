Return-Path: <linux-kernel+bounces-750360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE9AB15A8B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C777418A6341
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8626026D4F6;
	Wed, 30 Jul 2025 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="haw7bWrD"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E74B25A34F
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753864103; cv=none; b=idHm48iRZhNjZx9E85YIY565ZJfFzW1/lUhBDPbvpko9IbKGwvxb16A5rjYVxXC4bFelYnQxFkanySbAXqftMk7UVOvCbIpqgoB92PG6T6PosWSL8r047YAthDjPZqchl26Ux/xV6Z6/wRov1QrrbGEg88r0pU0aKkik14iDuiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753864103; c=relaxed/simple;
	bh=jK9R1dnUwKGI3zGLQm75/1AN+GpBkqgb//hlItvir0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iwwxRN72ULgdyl+Ky1K5mL8i43EswPFWvS+QiDO8ISJL9M0SkSUxOfX13NmwPZAuA99+qd5pYskOo0aLQgib1VX6rfHSJcv2k2Fb5RDak6WJivmXoZ9qjNaTr/cu9ZkhBFrWxJjDtvS1gWpzVnSAuoBkKD7fSPDys0wnsd88c+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=haw7bWrD; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b792b0b829so1224952f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 01:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753864100; x=1754468900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Bx6PIe+EYTqF7HuIJczhS/0SNZn3oEqyjSCB05qzyk=;
        b=haw7bWrDiM9Pm1HNMtZJC2IdP1cw6Z91hXNOftKkVEjYagPulEFRCXsNtf+c97neIw
         JI0ZdeuJGyAchgnFS2nHquO4kVNzpQcvn1DCDeJe9KGcl2Cv5TjsY5Xym3uWVy2dtNJj
         Ti6OlcGCgl1oRWRA7U9085Wd7YXOe+tuxGO5ONV/t6isvA4bVIIrg8asvuxys0G23Rzh
         2kSgLNzwVLJqGk8g16YBtCG9lWg0mfgN/kSI7EM+QOlWjdNIGMYRDRBbiymmDAA9YySD
         LCNQFe3A35VH9PLXzcMI8XbqEQUuaj2ipzhCOEoN2QxppGxLq1FddwqQfMUT1SblaSHb
         hdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753864100; x=1754468900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Bx6PIe+EYTqF7HuIJczhS/0SNZn3oEqyjSCB05qzyk=;
        b=XlLJH0k+y/jycUj+t+ISJGkBAKIWlbR8R7uul4WU/+xW/hLidCM/g/0v/ZP4TKAWR6
         S3pUK15KdtBSgx3/bl+U1jHFdvT2KvfImdID9ijg/yvTZUhisQb2FKoXa7aZjXMKlozF
         cbRdAjvk6BhMz3Wri5KYKvfcqUmwSO2XQn1bzVby/cX37GLuUIJ9nulP1Tn5AI8j3Mtc
         n2uql/1RsTCqNiBxqtcX54MIlQtpXylzaS4piFQGUCfZVhgO8IvofETd2Y8zC4ZTC+04
         x7Yk01qXjLisVK8qUmITyiOCSRPl5CLl5VyOtRb0NINHvv3WmCX4/QhCu/wwc9fQ9lNL
         2VTA==
X-Forwarded-Encrypted: i=1; AJvYcCV29njuL9RTH2/UgqOzNfWxBvGfs2ZkO1YJJWagoYvJpQAQw4znhjSJcSkfUQPtSQPdZk8MSdxX1iN6ViE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+UCQyWm6c7/V+Z4Fw+hVrh4hdgXfKVbgf6BtxrR1BJJlSqcy5
	G5MkjMCmyv8m+2/JbfsR22SDkkJe3NnzfRXnPswg8CRXHY7PljpJSI7tAch7hXET4S4=
X-Gm-Gg: ASbGncu0B7n0+2yRHqTZ6ZtztYGeuLbAKehoQ4EUlLfNBYf8vb69Md4HpgRe6IRseGM
	DeAzIu4bn+EhbDsya3hdyrvkWc5kkCAJYxeZUi98+0vcICXO+XkV+guLl5ygTqwmXSkyu/KHeoT
	HcgIKd+oHfDYiOD9HHCy5pra/lx3ftL1RqVM3XNHgUBL2uVfN/eHUY9qPrJbhoRGeuUD0F0Qk11
	6Zh9QNJ7S6f8J+WnBezSUV6Hr+cn/QQ36GqQnAHGY4Ya8bCkPfBVH7gTlu0P8MRnMckUf4yHoDT
	jtIhSIVlnHtWejctqDrKjxdy6uIpUYomGHuBija5raa8LpzCNEtK9S56B60w8HY3EKkTmy0qOi4
	kroOCQvQOmTZTytlZgka6cLTbRL74S4O/y2QU0ojG+sd17r7j
X-Google-Smtp-Source: AGHT+IEmcb9hU9H6TXBCXZGY9mu3nh+E8/Ix/pUCrTfAlW3MpW7+mmuyCWSXi9p6CJwBRepgaxYEfg==
X-Received: by 2002:a5d:64ef:0:b0:3b4:9721:2b2b with SMTP id ffacd0b85a97d-3b794fc2c7dmr1618429f8f.12.1753864100437;
        Wed, 30 Jul 2025 01:28:20 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588d873f80sm41992125e9.0.2025.07.30.01.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 01:28:19 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v2 02/20] clocksource/drivers/vf-pit: Add COMPILE_TEST option
Date: Wed, 30 Jul 2025 10:27:04 +0200
Message-ID: <20250730082725.183133-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730082725.183133-1-daniel.lezcano@linaro.org>
References: <20250730082725.183133-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VF PIT driver is a silent koption. In order to allow a better
compilation test coverage, let's add the COMPILE_TEST option so it can
be selected on other platforms than the Vybrid Family.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 645f517a1ac2..6f7d371904df 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -475,7 +475,7 @@ config FSL_FTM_TIMER
 	  Support for Freescale FlexTimer Module (FTM) timer.
 
 config VF_PIT_TIMER
-	bool
+	bool "Vybrid Family Programmable timer" if COMPILE_TEST
 	select CLKSRC_MMIO
 	help
 	  Support for Periodic Interrupt Timer on Freescale Vybrid Family SoCs.
-- 
2.43.0


