Return-Path: <linux-kernel+bounces-892903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5C2C46121
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 977464E80C0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BA93081CD;
	Mon, 10 Nov 2025 10:54:19 +0000 (UTC)
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F631211A14;
	Mon, 10 Nov 2025 10:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.14.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762772058; cv=none; b=NR7N4+YpWy1lwjFXiaOSlDuAeOzVHakjpZpLGnH6Ts+AbKKDEpjHRUhNVX1HlaXLFg5kFeMLqDt18G7mfQu2jl0DEc49ghztT37B+1mGPIKFvQL3FUk9NguS5kvDlfj+oOlgf3hdqiERIeXdMZKXj8vbRYr3TktiUeI6+Y6MxH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762772058; c=relaxed/simple;
	bh=8SVXE+F18W+GwJKdtUn01mMAOdlkYHPH0+mCESHIxjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rjENWWFIWe5vq5iSdIhSxkXkkCJuMFJPV5WzzvntDxcoIBrrrObsqJMW+9CXzJjE04MX5l2NU+S7sDoD4dkSrTUY+VoI3C3MPMaR0tOsdAjtqxdWSOWiMaLm4ifIrg7hvWBsRF+AvbzrqXi+mfvOQ6eDaRbdqPU18lWF5Eqk5bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org; spf=pass smtp.mailfrom=gpxsee.org; arc=none smtp.client-ip=37.205.14.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gpxsee.org
Received: from mgb4.digiteq.red (unknown [62.77.71.229])
	by mx.gpxsee.org (Postfix) with ESMTPSA id DEF783091E;
	Mon, 10 Nov 2025 11:54:06 +0100 (CET)
From: tumic@gpxsee.org
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Martin=20T=C5=AFma?= <martin.tuma@digiteqautomotive.com>
Subject: [PATCH v2 2/3] media: pci: mgb4: Add support for GMSL3 coaxial modules
Date: Mon, 10 Nov 2025 11:53:56 +0100
Message-ID: <20251110105357.1813-3-tumic@gpxsee.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110105357.1813-1-tumic@gpxsee.org>
References: <20251110105357.1813-1-tumic@gpxsee.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Martin Tůma <martin.tuma@digiteqautomotive.com>

Add support for GMSL3 modules with a coaxial interface, a variant of the
already existing module with the id #4. The FW is the same as for all other
GMSL3 modules.

Signed-off-by: Martin Tůma <martin.tuma@digiteqautomotive.com>
---
 drivers/media/pci/mgb4/mgb4_core.h |  7 +++++--
 drivers/media/pci/mgb4/mgb4_vin.c  | 27 +++++++++++++++++++++++----
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/media/pci/mgb4/mgb4_core.h b/drivers/media/pci/mgb4/mgb4_core.h
index 06ef8bb44089..bfae75f30c7c 100644
--- a/drivers/media/pci/mgb4/mgb4_core.h
+++ b/drivers/media/pci/mgb4/mgb4_core.h
@@ -21,8 +21,11 @@
 #define MGB4_IS_GMSL1(mgbdev) \
 	(((mgbdev)->module_version >> 4) == 6)
 #define MGB4_IS_GMSL3(mgbdev) \
-	((((mgbdev)->module_version >> 4) >= 2) && \
-	 (((mgbdev)->module_version >> 4) <= 4))
+	(((((mgbdev)->module_version >> 4) >= 2) && \
+	  (((mgbdev)->module_version >> 4) <= 4)) || \
+	 (((mgbdev)->module_version >> 4) == 8))
+#define MGB4_IS_GMSL3C(mgbdev) \
+	(((mgbdev)->module_version >> 4) == 8)
 #define MGB4_IS_FPDL3(mgbdev) \
 	(((mgbdev)->module_version >> 4) == 1)
 #define MGB4_HAS_VOUT(mgbdev) \
diff --git a/drivers/media/pci/mgb4/mgb4_vin.c b/drivers/media/pci/mgb4/mgb4_vin.c
index be55491b52b2..97d38f7baa98 100644
--- a/drivers/media/pci/mgb4/mgb4_vin.c
+++ b/drivers/media/pci/mgb4/mgb4_vin.c
@@ -50,6 +50,11 @@ static const struct i2c_board_info gmsl3_deser_info[] = {
 	{I2C_BOARD_INFO("deserializer2", 0x2A)},
 };
 
+static const struct i2c_board_info gmsl3c_deser_info[] = {
+	{I2C_BOARD_INFO("deserializer1", 0x6A)},
+	{I2C_BOARD_INFO("deserializer2", 0x6C)},
+};
+
 static const struct i2c_board_info gmsl1_deser_info[] = {
 	{I2C_BOARD_INFO("deserializer1", 0x2C)},
 	{I2C_BOARD_INFO("deserializer2", 0x6C)},
@@ -67,6 +72,13 @@ static const struct mgb4_i2c_kv gmsl3_i2c[] = {
 	{0x308, 0x01, 0x01}, {0x10, 0x20, 0x20}, {0x300, 0x40, 0x40}
 };
 
+static const struct mgb4_i2c_kv gmsl3c_i2c[] = {
+	{0x01, 0x03, 0x03}, {0x300, 0x0C, 0x0C}, {0x03, 0xC0, 0xC0},
+	{0x1CE, 0x0E, 0x0E}, {0x11, 0x05, 0x05}, {0x05, 0xC0, 0x40},
+	{0x307, 0x0F, 0x00}, {0xA0, 0x03, 0x00}, {0x3E0, 0x07, 0x07},
+	{0x308, 0x01, 0x01}, {0x10, 0x20, 0x20}, {0x300, 0x40, 0x40}
+};
+
 static const struct mgb4_i2c_kv gmsl1_i2c[] = {
 };
 
@@ -812,10 +824,17 @@ static int deser_init(struct mgb4_vin_dev *vindev, int id)
 	struct device *dev = &vindev->mgbdev->pdev->dev;
 
 	if (MGB4_IS_GMSL3(vindev->mgbdev)) {
-		info = &gmsl3_deser_info[id];
-		addr_size = 16;
-		values = gmsl3_i2c;
-		count = ARRAY_SIZE(gmsl3_i2c);
+		if (MGB4_IS_GMSL3C(vindev->mgbdev)) {
+			info = &gmsl3c_deser_info[id];
+			addr_size = 16;
+			values = gmsl3c_i2c;
+			count = ARRAY_SIZE(gmsl3c_i2c);
+		} else {
+			info = &gmsl3_deser_info[id];
+			addr_size = 16;
+			values = gmsl3_i2c;
+			count = ARRAY_SIZE(gmsl3_i2c);
+		}
 	} else if (MGB4_IS_FPDL3(vindev->mgbdev)) {
 		info = &fpdl3_deser_info[id];
 		addr_size = 8;
-- 
2.51.0


