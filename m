Return-Path: <linux-kernel+bounces-767885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD5EB25A1A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 05:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17DBD1C03F38
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 03:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A04194C96;
	Thu, 14 Aug 2025 03:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gUiZ9PnM"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2222139579
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 03:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755143604; cv=none; b=U7lc27dJVTKlDwmkxnOQC4lUf+GT0ULLfx1iQWKk4RtL+NmA5TC1GdMDDcrS/gkaJM9BRG1y0Op4uFnkX55Bf1nxlKIhJ2umplaz1NTZmijCjH+ohjCZX7b5IjUdKAs/99Zg6VkOa7XD0QO4lHXXIGnAVlsOsAAZM4FaA/MLXT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755143604; c=relaxed/simple;
	bh=WrA7wXphGq7C2+quYEdoZSP7IvuC6J33CkBNdOUJY1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HyrKqobPvxWCwdNPo5qFizV7PXKtdPg+X9gx+/q6lYpJ3NZ2PX1yZX9sbS+AJ5tZG0w6JaYlkTA1fnNyB8Ic8CqlUNyRMjZSWzdk8QjGsvTUKxf/Fe3LYnT0FGBYiKKolqt1FI1/4Txif7s279uEmZt7zRVqYWodKo3VZVezraM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gUiZ9PnM; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e2eb6d07bso541505b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 20:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755143602; x=1755748402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pl0UCqTEugdT0otZ1JL4PHmJhUzKYCzZ7agBq4X19mE=;
        b=gUiZ9PnMTuLovewnncb/LfQCqjXsZJQdVWl7OIEa3lT3VUvRPQb0G6CrlcEbNx+YPr
         LoFqARwfhOVoPRqtIWEZnfneetH+U+DNO6cX8XPF9wqyyBxRomxS3MwKjD8jyOc/X1hm
         SGuEDcy93t15wkZaEbxaUd1M/uandPR/3F/OU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755143602; x=1755748402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pl0UCqTEugdT0otZ1JL4PHmJhUzKYCzZ7agBq4X19mE=;
        b=Q/tGgQR53+3FABXoS0RcC2mTecSulEsNhH5tKUzHFwfOV+eSQN9LKtWW+ojNvygh16
         C2NCa6WxecJ5qk4pFuGCBnjSUAVmXeb6lrM5qQEIwejQ+nXViw07dp2DKrK9w0rWVFqQ
         OIbKomWAJM0zibbUDFIGLeHWJHV0sdoAZLjliNGJjS0J/u1s+Z2dkPumpDRIeTvqq3Pb
         M9QHlM9wRSOD5U+SbFPcR9K0db0eD7Ye7/n3sIj4ZOzJGtHnLstRGkIvxgoLcjrqnvFG
         +qwxuqn/K0av1k2MpU7H3oRV43BDtUJcb1Gfx0AsYx8d7Pc3VRVPnyWOYD400hsAV/ei
         lHKA==
X-Forwarded-Encrypted: i=1; AJvYcCW4NBcEXMYMOL2BVHOK8D95yVxNdShvrWfGaXtxZNSQl4K0wA4ULeusFAWc0JH+r9vix5rLRo1gPW1iLVk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr6SFgtX776FsVioK3UZAKm+XJQwmZblfzweIOm08XM9SCKAh3
	8f5gUl/wfxY/VgmVo6dnlwgv01FdpRIWU/HLnEENyin3H1Yi5cjDyuYk0Pwk6DZCmQIdRSNQimd
	FH8A=
X-Gm-Gg: ASbGncveXeYJn8TKdzLyoJ7RUFHtEV8OMKbGkOU9oOSwjUk0c3g/gTqlebc3Nfc2v/z
	RSyErXdt1oT8VpOzIpjRPlY7aWOIgmBYcAnKrRoOY9Uk+YMIk/RvJOQCbQhlwue9MDnarxMimF0
	T4U583kzIDoRwHsl/7uaGfLJkRD+q+gt/Q1xjPwndduHJ6YMpbmHD/GfTkn8E5Rmmh02EnR8exz
	LSrhw9gpMaEFe7jhFs2WPze4Be9Hgc8wZBih2mt8RV4QBxtgEypxkcJsLOsa2eJWPvdsnhU/S5T
	TRUdJWQMTtqpONg3hT8/GBybEeuYgDl0IbmurEeyH9JbG010DO9nbTKXOPfga+ujhisRgfuLcAr
	JO7cT1hsSpXSj4aXPylUV17MixJwfvyPObrG36YF+
X-Google-Smtp-Source: AGHT+IEewGnhW08uwz92qzGaMb1N+K9gny1YesoScUE9j7LXkcIxhYyAzeLPYF+E+O3U8ZcDGRXTxA==
X-Received: by 2002:a17:903:985:b0:234:f580:a11 with SMTP id d9443c01a7336-244584e4479mr23394845ad.19.1755143601765;
        Wed, 13 Aug 2025 20:53:21 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:c44f:5805:6bc2:66d4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f21c65sm342150205ad.73.2025.08.13.20.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 20:53:21 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] clk: Sort include statements
Date: Thu, 14 Aug 2025 11:53:15 +0800
Message-ID: <20250814035317.4112336-1-wenst@chromium.org>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The clk core has its include statements in some random order.

Clean it up before we add more.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/clk.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index b821b2cdb155..2eb63d610cbb 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -6,21 +6,21 @@
  * Standard functionality for the common clock API.  See Documentation/driver-api/clk.rst
  */
 
+#include <linux/clk/clk-conf.h>
+#include <linux/clkdev.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
-#include <linux/clk/clk-conf.h>
-#include <linux/module.h>
-#include <linux/mutex.h>
-#include <linux/spinlock.h>
+#include <linux/device.h>
 #include <linux/err.h>
+#include <linux/init.h>
 #include <linux/list.h>
-#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
-#include <linux/device.h>
-#include <linux/init.h>
 #include <linux/pm_runtime.h>
 #include <linux/sched.h>
-#include <linux/clkdev.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
 
 #include "clk.h"
 
-- 
2.51.0.rc1.163.g2494970778-goog


