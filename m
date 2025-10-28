Return-Path: <linux-kernel+bounces-874353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E004CC161EA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F8673A61FB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0D534B424;
	Tue, 28 Oct 2025 17:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLKnEa3U"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A0B20010C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761671920; cv=none; b=YK20tSqpZ6vqjtO/Yyn6e0ueXqHecUuJc8sTHAvRBscPGANidK7CxIhjNGxc0EdEzaZ2xKfK6e9vzXAQQZni9+8EgaqfrSG/49dliM/vFTCkFsqRCDjaG5Z6IEJn8B1t80leAMMlDFoVen+YgA5iYn+6W8IBA4Veb5sV1ghKszY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761671920; c=relaxed/simple;
	bh=3YsoYhxvZ3cetf/NHP7syqT/m1Ls0yUDtJYBoClYr5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ja2AfRNH+Bkt3JIwlzoybFVDLhcJrtR9uS1wJm/S5Op77iP1dQPTFEhZalP2D5Ma38VgqQgrmbK1mEa56l+If7qI1DjsJZjqDHBBF3y2aMp3NmDj+L8KcTmUbYAFFC70zU0Z+KpJc8vcuBSwF6usCWno3Uj/yY8qnShjSYLZoB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLKnEa3U; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso4308723a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761671918; x=1762276718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gq8ebwbj8nzVkzLmlwkdtxcL/+0aqujsa7ACJ5eAbKs=;
        b=FLKnEa3UOCdLxamg+SZNONMnsLiJG+jEfrAOHhb4aTRUd/sSw46rlj5p1AJjyfFX+w
         PSbazi5HPII4v1l/08lobvoox633f2xf61cHcX/LBVfgZNxBslQhT3dWXOAb8n7j1tZh
         XVlad07RzwoW6M6jO6CObEq21ITeyxxeBxqpCRqIXuSqRx2VATu3iSZPI3ACnxdINr40
         e2ciPzitIaYFY3HLBmlkLMJ460vX3vA6yf3Cuo0ClJ4xEKgoMRBwPHr5mjrSt8W4PG0u
         euZ5eCUKzSvViY63NYThQc20i3tXtkYPEOgLcVK/80wEq21stWmQdsJJRMGjFyBMAYQn
         8bYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761671918; x=1762276718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gq8ebwbj8nzVkzLmlwkdtxcL/+0aqujsa7ACJ5eAbKs=;
        b=eeo5O43hOVNi5o70vnqbhBRTEbssJNPiQ5wBPPymGvnxHnXFtHOkv20O7TBRTnLW1u
         FqJldxks397ERtnSufQhDMmN/n4DiJTBC6OCh4w9X9lupT1BaFnq9CzOHYRdak7QK/0V
         dfyU6D1Q3nuY3Gc2wrs9FpDXPn/NU2ig71zsKLRL8eAkZbw1vGLmUAUJMHCY8uTWT7Bk
         z1Y4IQqyhaACPSo1mw+wc+HobGjRa1MyaaWliSxx+gjKJ00KD5QM280sx/FZCrCKxDQf
         2E5DcLCD4GZTkR5/XaMnXPagf8czY47Qgmg+/iwGpfXzJA6cWmEa67M+HlXIOCzFOphZ
         qzFg==
X-Forwarded-Encrypted: i=1; AJvYcCWm46rrHicsOfMqcHU9NL72cas840YFktiF/cGsUyQrmO7o701rOtpZB4IIdPs6O2cgUEoDaAc4PXirAZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzVKUZ98oNwv4hQT9n8xW+4dHkF8Q0G22V4Bi+xWIHhigRUIve
	C2ohheFLg7OxQz0x3Qtxlpa0UY2tXP7LKPzTkvxcUoeza5JSc3+n8+HV
X-Gm-Gg: ASbGncvCM7CoD59NlEZJBpPZRVr5LcCnKJ+KeP3zz96sXArzw3wMpHRLAeGpMBWJmlL
	YO8+EPqw9Jh/Y/PsI1PVozRgBrJ5IKy4daiW3A6cX+7hrOJqPXmvxEWNOxzHO5puTe9eWIZjkaH
	jIJx0DI2C1TsxKDmuE5DmGgunF5wFzwfPk+fG2xLlEZoOlqpkXrJ2NjybT5dZJo/G7xA0kggvz+
	7jI6IeBkYwmdrO/zOlpRy1B8ebDkyaCmgYvScaMVpodTsweYVnMo06xgw5DHN005uOuHDlcUH+E
	UXlHUfvc3P0QqkBi8kLk2gsFqpZnHKOSBX1F84qzFaJas6zEMvv5wDrG2gSQxJnprfdyOKk2jHV
	ba2DD+ayn3L1LGyLYvXH4T6uFKo3VQALUuwLLdAxX3OqhjLgRPqdR5+xsYYAlJKUbC/Q+LlllCD
	xKHMQR5xv7GrkQlIyEhJrkSfOaaaZ9vugJw5QJ1I3gWgk552RiAT5x13ySU1rJTGj6PD96BXiiQ
	U77sg==
X-Google-Smtp-Source: AGHT+IEgb7sEYvXdsCjl14W15guK8oWtgJOvCyBmH8WJPPDjAo3zXDFbiP+7ls5RNvQFP/gOk+35Eg==
X-Received: by 2002:a17:902:d482:b0:290:6b30:fb3 with SMTP id d9443c01a7336-294cb3b2ab2mr50185105ad.16.1761671917717;
        Tue, 28 Oct 2025 10:18:37 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com (25.5.80.34.bc.googleusercontent.com. [34.80.5.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e41700sm122458285ad.95.2025.10.28.10.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:18:37 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org,
	lpieralisi@kernel.org,
	nico@fluxnic.net
Cc: jserv@ccns.ncku.edu.tw,
	marscheng@google.com,
	wllee@google.com,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] bus: arm-cci: Fix device node leak in cci_probe_ports()
Date: Tue, 28 Oct 2025 17:18:24 +0000
Message-ID: <20251028171824.2074625-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The coccicheck tool reported the following warning:

./drivers/bus/arm-cci.c:458:1-33: WARNING: Function "for_each_available_child_of_node" should have of_node_put() before break around line 465.

The for_each_available_child_of_node() loop increments the reference
count of the device node. A call to of_node_put() is required before
breaking out of the loop to avoid a reference leak.

Add the missing of_node_put() call to fix the leak.

Fixes: ed69bdd8fd9b ("drivers: bus: add ARM CCI support")
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Compile test only.

 drivers/bus/arm-cci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index b8184a903583..1f84a5528073 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -461,8 +461,10 @@ static int cci_probe_ports(struct device_node *np)
 
 		i = nb_ace + nb_ace_lite;
 
-		if (i >= nb_cci_ports)
+		if (i >= nb_cci_ports) {
+			of_node_put(cp);
 			break;
+		}
 
 		if (of_property_read_string(cp, "interface-type",
 					&match_str)) {
-- 
2.51.1.851.g4ebd6896fd-goog


