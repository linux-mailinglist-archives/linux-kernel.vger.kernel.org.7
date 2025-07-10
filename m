Return-Path: <linux-kernel+bounces-726267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D48B00AC4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 19:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E5461742B2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A329E2F3C07;
	Thu, 10 Jul 2025 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="MibllwvI"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185952F1FE3
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 17:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752169877; cv=none; b=hSqdloqH+5GVFb6jR3ZSkmxamFT+voS86TFX0rV+IDYOhLQAscdWUgj3WqqkgwF2KzOyrqKQZt9b4ER3AwEtYXRVks/o3enIsWdyX3hxMQf/GD613+jvf6zw+h4PHpFlkrXEC/lr1EYZy/daeruRw77yUOy4yhb0CSzdUbo9fxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752169877; c=relaxed/simple;
	bh=qw54s6+dB4TTXuc48Qt7Fv1rhcl09JsKjrdaymOOvwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UMgLJR+PH8y2Y7ZNFIjqQk5DiN4WtwuVLs+FIccjk9li5cMZas7t9cW1bBz0SL9A79ZPmyQ3Wmn2QhG4B7wjZrzjd4Ojm/PaiQ/MLr+GRQWCJizR8O0AhDUJK8vdYFmN+Lg2oUb2MQrC2u2cl/Q7yX41sYuwrF8vN3h4vxM9zDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=MibllwvI; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a58d95ea53so16413441cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 10:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1752169874; x=1752774674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPxd+P8tmDwx0y+W1SNnV+rw8aIzaBC1lp7afJoBcgY=;
        b=MibllwvIk9RfL5jmcMhrM41e9sl51DsRvefvYRMavCWVWmzKH45CYZzqRRgZi8Gz6e
         vAT7aSB/oHc78Nz1O1nhIpXhp+6dY1Rg0Z+zmUJkPNyYcZEruwcDfrekYT45i88VB9ob
         I1KfjY2NZyi6A1D6Dl8X3hJVH/0gM0KQAgrkTIb9UYZcuhrzrUSUdK92W1xxv40Ukfj7
         Zk5RI6kLYnGvgmKiFHCrbh+KE27H07CCBkBI1zkGKLFRyQj6GYFdzVEQrScFkp/qMiQL
         mnFMbIWekush4sf7ICw58jYnxvjRG3409jniVY75UgdwjbuG8sqd9nDsNzlg49AYawPV
         Mc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752169874; x=1752774674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VPxd+P8tmDwx0y+W1SNnV+rw8aIzaBC1lp7afJoBcgY=;
        b=fKXkd89QZ+0saI3qhVmpn2abt0rAv0dAbf9pFpAPlQSfD1yww6fV8j2NpIeGQbt54g
         5kkPRMO7GISocBQR/1yLVdC7Yi2stl+OniZ+ZAnGJQgI3ZQFRQdjwRBhDTzqwTJIxZG7
         uAHBZTnIwybIhOSKXt0+L7+4TbQWWBCkw8ETBbRJN14A9hxdO67zeb6HnH1TvrfxZZMt
         npWNaUDvjjoELVBk30shB6KvqHG8C7UPL8qhdSw1gCa4bgnoaSI+FEO/YPLt3QzyeqxB
         0CABQi/b4YOqWTSUqTzsabbkYpGff0CtLplknUy4LDCSTdp4NlZlndYyxETD+4rGNL3r
         6eAA==
X-Forwarded-Encrypted: i=1; AJvYcCX769v9BFH5VU6xwqtHYtjYPv5i6ISH4a+sWlbokFRw8ialUrSIFFJE7516VIQI1ptm52ps7D76t2R3MyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM8UFP0fj3tZDoEtBTl+OuLyBCANUdU9JwnT+5j2TMm/IRM3HD
	K9Jn2Z1iIz6z5eyu18Euj/G1QP3MQ6LXEXN15ICybmu9Z/cael7gb5gasqP7TAo3V9o=
X-Gm-Gg: ASbGncurtoI7A4YJRo9xiiVFosrYgWTw+5r5SWbHcCsBbZIT3KTR6BNdtPolsyxYD07
	r9e9AValQZ2EexDs7d9pouRN9g4l0QStrcv9qhO1ZvAXTKySiowscJD4mp1T0y4Dn5paudS4/mJ
	2ycGpSXKZ6wQmloDtHm7MiFnt3DPpIn8GRB2q+iK16L8//kJiRByk9WtWUsyGAWuU99B1jfap9j
	md9CQ6UTSNArkkxv9bGgmFfP6xujhtqbZAiPDVLtQl9s1G1gnoh7sXM2W5yjEV+L20usiBSvWg9
	gw86L/PyjGTwqPVwtifDKazmpR+wythwUF85i5GEn5oipnDQEkoB1p+C0VOFZG5UU+u7oa8UrKI
	RCKI86Ay+j7BLSbDMglgW0UjLaB9dKi9wEJDBZztvPIdisQ==
X-Google-Smtp-Source: AGHT+IEkx+AOQpLVZceBJR6aNNu41el+MInso6QxhBVwmiG6+XiP3kC1/9JcknKd6ozM3Mhkp6rCyQ==
X-Received: by 2002:a05:622a:1441:b0:4a9:a608:43eb with SMTP id d75a77b69052e-4a9fbb4f054mr2871861cf.20.1752169873838;
        Thu, 10 Jul 2025 10:51:13 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9edeee300sm11165941cf.73.2025.07.10.10.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 10:51:13 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: lee@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: mat.jonczyk@o2.pl,
	dlan@gentoo.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	troymitchell988@gmail.com,
	guodong@riscstar.com,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/8] mfd: simple-mfd-i2c: specify max_register
Date: Thu, 10 Jul 2025 12:51:00 -0500
Message-ID: <20250710175107.1280221-3-elder@riscstar.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250710175107.1280221-1-elder@riscstar.com>
References: <20250710175107.1280221-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All devices supported by simple MFD use the same 8-bit register 8-bit
value regmap configuration.  There is an option available for a device
to specify a custom configuration, but no existing device uses it.

Rather than specify a "full" regmap configuration to change only
the max_register value, Lee Jones suggested allowing max_register
to be specified in the simple_mfd_data structure.  If regmap_config
and max_register are both supplied, the max_register field is ignored.

Signed-off-by: Alex Elder <elder@riscstar.com>
Suggested-by: Lee Jones <lee@kernel.org>
---
v8: - Use regmap_config_8r_8v, modifying it if max_register supplied

 drivers/mfd/simple-mfd-i2c.c | 8 ++++++--
 drivers/mfd/simple-mfd-i2c.h | 3 ++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
index 22159913bea03..5138aa72140b5 100644
--- a/drivers/mfd/simple-mfd-i2c.c
+++ b/drivers/mfd/simple-mfd-i2c.c
@@ -24,15 +24,16 @@
 
 #include "simple-mfd-i2c.h"
 
-static const struct regmap_config regmap_config_8r_8v = {
+static struct regmap_config regmap_config_8r_8v = {
 	.reg_bits = 8,
 	.val_bits = 8,
+	/* .max_register can be specified in simple_mfd_data */
 };
 
 static int simple_mfd_i2c_probe(struct i2c_client *i2c)
 {
 	const struct simple_mfd_data *simple_mfd_data;
-	const struct regmap_config *regmap_config;
+	struct regmap_config *regmap_config;
 	struct regmap *regmap;
 	int ret;
 
@@ -43,8 +44,11 @@ static int simple_mfd_i2c_probe(struct i2c_client *i2c)
 		regmap_config = &regmap_config_8r_8v;
 	else
 		regmap_config = simple_mfd_data->regmap_config;
+	if (simple_mfd_data && !simple_mfd_data->regmap_config)
+		regmap_config->max_register = simple_mfd_data->max_register;
 
 	regmap = devm_regmap_init_i2c(i2c, regmap_config);
+	regmap_config->max_register = 0;
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
diff --git a/drivers/mfd/simple-mfd-i2c.h b/drivers/mfd/simple-mfd-i2c.h
index 7cb2bdd347d97..ea2a96af8bce4 100644
--- a/drivers/mfd/simple-mfd-i2c.h
+++ b/drivers/mfd/simple-mfd-i2c.h
@@ -24,7 +24,8 @@
 #include <linux/regmap.h>
 
 struct simple_mfd_data {
-	const struct regmap_config *regmap_config;
+	struct regmap_config *regmap_config;
+	unsigned int max_register;	/* Ignored if regmap_config supplied */
 	const struct mfd_cell *mfd_cell;
 	size_t mfd_cell_size;
 };
-- 
2.45.2


