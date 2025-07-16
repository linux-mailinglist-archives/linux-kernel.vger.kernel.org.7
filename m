Return-Path: <linux-kernel+bounces-732960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B654CB06E31
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2B8F7A7448
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 06:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB63624A046;
	Wed, 16 Jul 2025 06:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1cMsgmo"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4BD946C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 06:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752648440; cv=none; b=ZdXiARBl6oeyRZg6HeKtnr8HPaaTMKz66hXTEQ9uxfeo9KJV66LamVd03gwXYeZAv1vsOwPKDpOUlMwBIMBVJf5TJDrZv+CLva32cucqrgzdLh0aJ4yHdHG31GptzK4J1eP/6pUJSYCldLP5c/CSAVFlifiuadDGeamX5KNBE6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752648440; c=relaxed/simple;
	bh=hNELFIvgZlBymhxtJUO0XZ+CpC81+95CpDJgHsT8o+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nu80mYBkDg0nJYmuMGKwex3qUFeypa65pUDY/M959yaJkdgWUgryC/AuPc5xi0PqpbYigBhBI9WI7HH5i1Ebi0/1SX/v364cVZ9EfDn8M04XXfTMMnMKShEqi1y7JcnApqQz79FlKoBZuD7kUx1CUSYgOE3pQBRhr4s3W107LSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1cMsgmo; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-749068b9b63so4241455b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 23:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752648437; x=1753253237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EHQdd29tpIShwsvrYkr4lGkUQIkJDy/gD/+lt5GobzQ=;
        b=i1cMsgmoiwphTgTxfbRLSbJuHg2UsBql7VlZFY0QsA0HBbv2AhSreowTGiubwRQg7a
         RYuXpNj3QtsTn+Mf823TO4bwIpR8yxjG/nrqqQmXzddn4GXAIWCnvFQnyyhwn905HBtv
         GyDxl+hV+aClyKTVj0EYpvdGOAhvQtSuNTYb9SqM+W7Nh1105m/lOJSnFKFBjdprC6Jb
         5isRc9Q3wXWpaZcazvxRKa+sQHPLiZaPb6sz99ZG7pep9VrCIyrVEgLat2cW8CWWTApq
         WS6WLHbNImhgJ6MugSzNH3z5bhWkkrhFkIU4r4VjOIB5cyJPsy0dWUd1U+gk/WnyS79+
         MBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752648437; x=1753253237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EHQdd29tpIShwsvrYkr4lGkUQIkJDy/gD/+lt5GobzQ=;
        b=r5IGPHIpAafMhf8hDymPQaMmjMEd4s8/TegF0gmXihtTKJ5F9XQRGfawlNiGvT9vEo
         8ykuOsf5djkoykcCw55YJf+NXcMXoKzO25wZtG72cYy8TPYhMPI5o1rgEaotfUCMYngL
         k/JCswsv02yGVfUycTQ5FOzYcOa82MqLUcHW1LOEFbtZxET3YZk+XwUbyvv/zafhRN+c
         wu3kBw1AJYyyxQ9O6WUbfZuQzAFU/5mhlV4ZcIvAPx5IsSkIaWafLSO/L5w4WLAqy8om
         YtkJ/iP55+blM4VYdNrhCMYp0HnPxV5gY/2vED48WwS3stsKHm8Aa/OsjLNwBh9H7KKg
         F+3A==
X-Gm-Message-State: AOJu0Yz4cvOV688fgdbYzVuxgX/fWTl7TaQeIuPl/JZEkL+riEKCtyHX
	tj4a4bHE6TShnt3QKMZ59WV8WE4Oo8ATwbe5sZpdwPum1A7upSltnVK353ahof7erQ==
X-Gm-Gg: ASbGnctvD6S5CghfmrdsMWaVno36vNGvRXVFn98FInSVcK5tk/rjXNWiSFibVd8B+5w
	qdeWuTcOy5ZkydIlXkdfF58WZZMsQQximYbEF1dQ3HmNWfDuGBSZZVr6RZZ9Nfh9F4p/rqYbAni
	zdoFFCmPsiPS2ku+8Plgtly5m+Lfxht8bNC6nYVboy0aM+/5GBnudCk2abFcYCHlQdvifklzK8L
	GmZ+qHjVdS8eT/mB1wgFj5tZyx69vJDSlxtyFB5hnZBcd6gMNrJYf0kFMjglDWVxD3JiNuwuRG7
	OA0a5Q1Coids+wa/QjSh0nc0Is7cotA7qnL42yK3E/2/j8sgjmYhBYfSdQU+uTzEEi9MiI8+ODa
	uA3742Qkwh/2V2RUzjQiYYAY8f7tcXkQ+BCbdjNYJWx/J8NhZT5X3xXFSBpBJ8A==
X-Google-Smtp-Source: AGHT+IETYE96ldWPdTKgnphqu/px2YTY1JdITMLVVG64LkHYfe5glWPcOxrJqJgHLeTlYgqvEMjp7w==
X-Received: by 2002:a05:6a20:a108:b0:216:1fc7:5d51 with SMTP id adf61e73a8af0-237d7b5c23emr3873257637.37.1752648436890;
        Tue, 15 Jul 2025 23:47:16 -0700 (PDT)
Received: from max-MacBookPro.. (36-237-135-199.dynamic-ip.hinet.net. [36.237.135.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f4cb57sm13825041b3a.136.2025.07.15.23.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 23:47:16 -0700 (PDT)
From: Meng Shao Liu <sau525@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	visitorckw@gmail.com,
	Meng Shao Liu <sau525@gmail.com>
Subject: [PATCH v3 1/2] samples/kobject: fix path comment
Date: Wed, 16 Jul 2025 14:46:28 +0800
Message-ID: <5be61d284a1850f573658f1c105f0b6062e41332.1752646650.git.sau525@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The introductory comment still says the example creates
/sys/kernel/kobject-example, but the code actually creates
/sys/kernel/kobject_example.

Update both comments to reflect the actual sysfs paths. Also,
fix "tree"->"three" typo in kset-example.c.

Signed-off-by: Meng Shao Liu <sau525@gmail.com>
---
V2 -> V3: Add missing version tag to subject line.
V1 -> V2: corrected my name and thread the patch series.

 samples/kobject/kobject-example.c | 2 +-
 samples/kobject/kset-example.c    | 4 ++--
 2
 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/samples/kobject/kobject-example.c b/samples/kobject/kobject-example.c
index c9c3db197..e6d7fc18e 100644
--- a/samples/kobject/kobject-example.c
+++ b/samples/kobject/kobject-example.c
@@ -13,7 +13,7 @@
 
 /*
  * This module shows how to create a simple subdirectory in sysfs called
- * /sys/kernel/kobject-example  In that directory, 3 files are created:
+ * /sys/kernel/kobject_example  In that directory, 3 files are created:
  * "foo", "baz", and "bar".  If an integer is written to these files, it can be
  * later read out of it.
  */
diff --git a/samples/kobject/kset-example.c b/samples/kobject/kset-example.c
index 552d7e363..579ce1502 100644
--- a/samples/kobject/kset-example.c
+++ b/samples/kobject/kset-example.c
@@ -14,8 +14,8 @@
 
 /*
  * This module shows how to create a kset in sysfs called
- * /sys/kernel/kset-example
- * Then tree kobjects are created and assigned to this kset, "foo", "baz",
+ * /sys/kernel/kset_example
+ * Then three kobjects are created and assigned to this kset, "foo", "baz",
  * and "bar".  In those kobjects, attributes of the same name are also
  * created and if an integer is written to these files, it can be later
  * read out of it.
-- 
2.43.0


