Return-Path: <linux-kernel+bounces-827098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6667CB904D7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 271433B64B3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C4527F72C;
	Mon, 22 Sep 2025 11:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eP26dmB2"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F7423D7E0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 11:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758539259; cv=none; b=iRXkfwv2M4a9mEPK8xpBLuvL6ybEakWs8AN7tJgPn0yig43CIJ/GZIYXbMT4t69Q26Yx2dv128TSaLaubsSpaGBmuxzrQnXYL8FxFIb6IQvCQK74MuzJjrv5TCa57VhDmnwPz65rgV1C0T0mV3cX2ROWPWM+NMWYPLy050F+wGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758539259; c=relaxed/simple;
	bh=ha7vhXQnkq3dGv29WIX3tV1ew5TCRs9xmyteSmU3niE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SkV4XZOhh9LqJJHBS/vZM/6OcAlVRui6E7yKbWtJuE/3VSGNT38TQdJmkt8FRRDREwYekbMNKLiYtOhEzfnhKpT+k057nkJDulCZbJRQkPQFnIUGRXErEfWhDd/+dT4C7FY04pbJgrLyQSBZbAOGTbaENN53heUFVCmQ5LJlkZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eP26dmB2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46b303f7469so11808425e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 04:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758539256; x=1759144056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hXg/GxymvCtNiazPIaxXzRrcAnchuXSa5kiiDg/krUU=;
        b=eP26dmB2aK/vUlMg49NyK4yYHnOx11SiWXDSZ8Y4Bihf0Dg0gHBhUQuXvOVQ179rzd
         Y8c+QVtfzo57LUydNe+FVYoiVRmMyw2SSxN/xNdGmfX0m1hA7b4Yq3cc0qs+znuaHuMU
         5q2UT1c8XEFMjdN4UeTecxg7VFYZMOdnK6HsIWi0/qHQKg2b874qFBpk8afSevgDQhEM
         DEiSKi/YFSmsybLIlmaApiIV/1DL4nUw3QFAtNVBurPGn5NeKRXBmQl+rkqGqVgDsgOM
         TrGPyhqqfK5SzRkkSXMp7bCxkAo/fI5Xkv5NaT3GcWjmLJMcIg+YnwqQs45wOzw9+4ja
         r72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758539256; x=1759144056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hXg/GxymvCtNiazPIaxXzRrcAnchuXSa5kiiDg/krUU=;
        b=j0tc+HVfi6+t1grxF2dxWVc0svMbPld29QZVGB07SDq65gjy7hBQnkhRnzbbg2Bunp
         GY7XBqXZ0Q9zMPqE1OZsxpiKKNm1uzHxnjbiI1HRrU8MAHrLyYHoWjg6RJZxX5z9x+RB
         MLjV60EkiquL6MRynV/boO5HcDECb4eVeOsYU/omXh+oezcJkDElx2+ZaGCEme5aXlQ1
         xrWifLRBCvoB8ohMBWAvEvtIqJCdCU5YinLqOCdvl+onbgGNdZs8qzWN8j5bNGD23mjs
         AIRAFdIeQUNnxwVbdCrABIVpKT3xq2sKzUqAFSw0DmAvkSFIOm3OeJlcVuQq1ydl7OUC
         HrZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCjv8Rw47QdSVgQWz/AA6jkFjJ2DidIP8464UvOm1G+dzY1FO0VfEU5L2KYSFMsvpxhO/JuqPmh8OqFIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT5WR0ALtC34l1F6eSVWbdWOqXf77IA1QatHopKhQBLBM2Wazd
	yyAuIUoq48koLKmULyfYzONXImSw55+XSsdmG/t26OG9iOc9je44UMnY
X-Gm-Gg: ASbGncsi5KDOfiwsgg0sAkgO0MJhYQvX4Eqi7g60z+ORb4CTAZcULsFUYChLDghkqL5
	4ip/u1Anw3LjZZV5K2CMsbYmmxLLY/g/Py3RhO08pyXUSOSGFk7eu3bwrV577grqdA/jLY75Q8d
	1mQYwYc9nky88Hwl5UbSH/155Y1etTB7KW5UEequC1t2sOkF59UXtnd4yF2LUvjkZxBTbEOh4ws
	mD4yDxffwPDuIL7kNjivpXzT8XKQcnB57OstkzxMOC7ow+L1BkXcIU+q1bWmhklQ0ZWt6nLKQVK
	F8aS5GMUaKTgGZaj22vVdZ0K8R74gVvWhHNL1L0FGPLZQO9scH4bmN6jgYfOAWnvA1/kVkM9xr+
	w99cMR0Sqnx80+kwYoqAs4WslqrnZE6M=
X-Google-Smtp-Source: AGHT+IGuwhHEO83sfFCU12OTOC2+vkw5qcfiySY1IUg+z3oQVKsK98ybPmO83IDuQ6N/NzO8qDOnLA==
X-Received: by 2002:a05:600c:1d0d:b0:45d:f7e4:87a3 with SMTP id 5b1f17b1804b1-467e6b64fdfmr112379105e9.3.1758539255657;
        Mon, 22 Sep 2025 04:07:35 -0700 (PDT)
Received: from pc.. ([105.163.156.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee073f53c4sm19524684f8f.3.2025.09.22.04.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 04:07:35 -0700 (PDT)
From: Erick Karanja <karanja99erick@gmail.com>
To: miquel.raynal@bootlin.com
Cc: richard@nod.at,
	vigneshr@ti.com,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	linux-mtd@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Erick Karanja <karanja99erick@gmail.com>
Subject: [PATCH] mtd: rawnand: atmel: Fix error handling path in atmel_nand_controller_add_nands
Date: Mon, 22 Sep 2025 14:07:27 +0300
Message-ID: <20250922110727.1423318-1-karanja99erick@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case of a jump to the  err label due to atmel_nand_create() or
atmel_nand_controller_add_nand() failure, the reference to nand_np
need to be released

Use for_each_child_of_node_scoped() to fix the issue.

Fixes: f88fc122cc34 ("mtd: nand: Cleanup/rework the atmel_nand driver")

Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
---
 drivers/mtd/nand/raw/atmel/nand-controller.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index db94d14a3807..49e00458eebe 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -1858,7 +1858,7 @@ atmel_nand_controller_legacy_add_nands(struct atmel_nand_controller *nc)
 
 static int atmel_nand_controller_add_nands(struct atmel_nand_controller *nc)
 {
-	struct device_node *np, *nand_np;
+	struct device_node *np;
 	struct device *dev = nc->dev;
 	int ret, reg_cells;
 	u32 val;
@@ -1885,7 +1885,7 @@ static int atmel_nand_controller_add_nands(struct atmel_nand_controller *nc)
 
 	reg_cells += val;
 
-	for_each_child_of_node(np, nand_np) {
+	for_each_child_of_node_scoped(np, nand_np) {
 		struct atmel_nand *nand;
 
 		nand = atmel_nand_create(nc, nand_np, reg_cells);
-- 
2.43.0


