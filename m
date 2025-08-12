Return-Path: <linux-kernel+bounces-764367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EBADEB221F7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD84E4E0745
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76952E5B29;
	Tue, 12 Aug 2025 08:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NNXwZqla"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67FE2E5B20
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754988815; cv=none; b=GVo46m/+zZCfO0YjEI3Z/nQoYai/rANOnrSgS4QlwOKEaH4UD7NDAYQ9HOVlFdy1/ducJPVoPu1QkXv/JCNfrGW2WNlabs8gqhQ8jN3780mMlG6VftemCb8KZwn5j5SDXEv/TzGHSl5YeDy+drnz8eZU/BXBd4pQc3kpzssVLZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754988815; c=relaxed/simple;
	bh=CT90p7o4NQd828E9Ubu/4Yaaoo+eLHYjT01GBxlSo2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ArkNLamUB13GKlxsHB+iLyzpJJUKPU7bLQoSjmbNwFR0lC6EBsF2UK8+DJAJNVKWYFsF59uWu5xLVJTLJbXSFNDI9Lj3KF+pqX+ZqVEPD6mIdGzTUFBg1PpFioEaltgo8fmzwbHIHBgcX3mbOXtZXmt1kHJAjH74aEWzh0HjZew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NNXwZqla; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23ffdea3575so34069885ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754988813; x=1755593613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xz4Qdv62lAKsjkAZ22ZFX9wEAksTHe+JhTiso/RYQVc=;
        b=NNXwZqla7ISk+dqtlRJi/DSOC3omS4cuFK7KCxLiTkVEHHlmacq8ImiHtVVEQ8HYOj
         2ZxYfj965QK2K8enJrnnmY6vU2Z32RSICzTR2rJUdIk4UHx0bAZ2JHN0jMg5ED8XYY8w
         Be3yqZW2tP/5TZAHtOAzFobDSHyEcVhXTohhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754988813; x=1755593613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xz4Qdv62lAKsjkAZ22ZFX9wEAksTHe+JhTiso/RYQVc=;
        b=eIyEI467AEy9LlZczHpd5XC5dBTRkY5YHdW7VuEhFZJqtKJfHJQZUbwsEKyn9cG0cz
         nerlZdwJPzI/9L+QabNSHbAWmn/z6Kx/dBGjUSfxj5n1tCdG31RYDAR5CRycxuj0PFcT
         /piDd8yzINektG4hMjigBjtsQERfm6SOCK9vE6TrWzllvKpyN9aCFbat4PzvyypvU3Ks
         BoVHjsR+lObBvtn7dmS0p3WDmORLgCbnQPFwJFXRVgl3+gQZj/s0eXho7FKGVz0ID2tk
         s17cY50QCfQ5zeSuTvULbf3BAPbiEAJlvrgG/nnrINFrx1lq+t1/obCM4Z+LADLhfrk9
         Tmlw==
X-Forwarded-Encrypted: i=1; AJvYcCVLBrhmZJXls51MxeKHsByHINl8qOcgjr1NhtzmM1soILrC49TXvhRCc+dVb9aFvwiI+HeUm/g0Ksag0pY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgWdL8J2r6DDNzWZHZT+U/eVc4rYfitTgzYIVxOu7mBL/R+3+H
	mOhjtxi1q+IGhL/Gtc+4zXkFKQvK8o0vvF9doi0L3AMyZAt/71MR+r1xP+aK7gfO+g==
X-Gm-Gg: ASbGncu2TENH+1tx+2cZTo48pbMk5AMtP0aNS8Jcvmb1mDgcnokUYgx/Jdokx6qV+ai
	rfY23G0T17E/I2i9GfqQra9UJLXR/m90Tb76sGT/LBWmL9ZYP3CYkap8IRtgJlMDFKJy/aJyPs5
	jVVr6fxQ/zFCWMU8tNxH25X73KDDiD07Ni3QsrlfP0b13efMBuFKd0mZ12LKbgzXbsuHOX1+lBN
	Lf2KQs4Pqbx3MjSM3yEOhIqnyvhCmOIh0tKj8YA4ML7tIBMlRouEQeEUojlTu9jrr1BHbn1A+n6
	39mGDFn71D6iCChE0vmxwYOVyqKDShaRmnXn70b8RmxxGgjjjvVp84Odw50jSBQLuN3Y4LxLPvF
	ZZcJEsnC9F77ns+GWSuGLS6KRBTHlcesxX2tDDsLY
X-Google-Smtp-Source: AGHT+IFOWCZVXUc44tmrtbFyVyCPua9bqZtg9A4wAaJCkeOc5TnmXp6aSqWf4TQcG7yMH+z4ilx1Fw==
X-Received: by 2002:a17:902:d2c4:b0:240:3e40:43b8 with SMTP id d9443c01a7336-242c228f274mr203344785ad.53.1754988813155;
        Tue, 12 Aug 2025 01:53:33 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:f81e:7c91:8fbf:672a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-243017dd480sm10014365ad.33.2025.08.12.01.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 01:53:32 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] clk: Sort include statements
Date: Tue, 12 Aug 2025 16:53:26 +0800
Message-ID: <20250812085328.3306705-1-wenst@chromium.org>
X-Mailer: git-send-email 2.51.0.rc0.215.g125493bb4a-goog
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
2.51.0.rc0.215.g125493bb4a-goog


