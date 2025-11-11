Return-Path: <linux-kernel+bounces-895661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAB6C4E98B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EEF594F35ED
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6053831195A;
	Tue, 11 Nov 2025 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPKIBY6q"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC0C2FC000
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 14:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762872279; cv=none; b=dN7Ipt9t6+8r5d/cFjPyWAEo54RiPqYj8u+iZhacWDkmWvuF4wmCB64WhnDnipbUok2+5x/p6WZ7yyZr84HCv2N4rv/RG8d4q1b67/8rFTE63munsRtD0OwnVAfHhp35QCA0FyPTJffVCy6Fj6GZAmhbm8Ad6r82F5cBvmGwZ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762872279; c=relaxed/simple;
	bh=y8t7dgVWv5gPJxaJppIsGqbz1EVFsOkgb6ryGsNSE+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G3gi4v+16JffxldDWe4sIfKZaEIe4vTHLF4jOuRpZ4hYscGXdDgprG0OUpiDHjD3o2TNvA34TjS74QHzE2hI0bF1dbXq98WIH1r4oEvYvD3EebGKwJZx8x266ACUl9zbTUNk+TSMD1Gu7eP+mC9k3+Mm986Yea/hpnfC35etSJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPKIBY6q; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64080ccf749so6800496a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 06:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762872275; x=1763477075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UVOB8A+PcaLDpWyQLR0l44MeTzTd0XLGPEhD0sPw9I=;
        b=TPKIBY6qIQ9C3AvQZA7QxxL9U84z8ztzpGLx59VRFZPMS2/tDejZTl5UknulTpZzJe
         GTZfMpDFwg+Z4L6KVONVjgkxqH5tQgjvKDsdEqI+VvgR9P8gd5nFo55NYW34ZgqMYh1c
         1X2ccC820SiueQgmPoMnbeH7+tTU9DmS9exVbxUsnjZZHSXsqGVNTCoGK2sfHd2XJ6Nj
         ntXkaw7mG5WqI09Iyiv/TJjxP1prkF243r7w7v6vejhGGFo5pLnDjla0DUCpDg9bUGlL
         /6T2LNG/nRwux+52rp8SA+ayusOeRYt/uMY2TkLhm+x2trxBokaGkgE8AqeLq7tkfBpR
         fUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762872275; x=1763477075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8UVOB8A+PcaLDpWyQLR0l44MeTzTd0XLGPEhD0sPw9I=;
        b=BoWtZQpqLSmv9snuob+UDqJZZRC9p0s0b0qfltzaP+Ki5y1Dj5KPTNF14p/4fJgVi2
         OmnadowTb/WUSsnAFsRgwZM6hWuqG7KBpfu4vRLz0g7sGSatbwytEBlZQz2MtCwqwFcA
         zUqXzoOXA0/YOWFW2EsFOOoLSIZ3ZWHOxtzJ+x0avj8c4OPFGlBlkTo62SChmsw9SBDg
         JWzdvYb8jy6+gfx5RK0lbErqtK1EcG2+2EFa+NkqIsjOE92DNOxZbBEjYhFrhVXcBqN3
         2HYR6ssI+x42zaG5hL53IPQmvuxlnKucvFUhmfExMYLnnNubg3ypxsFZfWhTg/Qb0x/g
         Epsg==
X-Forwarded-Encrypted: i=1; AJvYcCUffJr7owBMfMB+i/sPQDCGJvphUsVuuQA2RnqIeNgS5vmctqof1A0xJQVnuyvFoIVxOcBpImHbr8+j+kg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7ScYs8XPPHGDnL7nzPJEkzC6TNYK1CvTCz0Nk516g8Ew3HPgj
	DEjM3YmBXhQ5Xko93Pb/Y5Ldwk5x+GpmdM83eXcCnp7/VKd/0zHfNGOW
X-Gm-Gg: ASbGncuswenRPJVmSu999QWC9FTZ7T9SUCa8kJPpU1HFaue0j7P+Iirzs9xtf00CC7j
	nlK5sMx05zqDF4lZVxmKXv9n8ojfT04Ki5XYwg4zQYg5hPpS5WqGvh7KFpVnGQc/albuJiQ7e7C
	2F9It6kwCLQ7H9iBYgMoT6xq4ibzdQ06fK4QAHwLSZCDxtAV+YVVQxvKOTvO/Z86xHHsvYn5Z4c
	D7a3oYDVOwqtHbkyGlUOEIMcGcWgnq4rv0d7ek5Idktw4A7xCKyliTAY6JDdeqNf1dQhQwHkpqs
	gzZDSev+wg2Ch2FUyVB+M/+LsuYl/akX1jUJuiGDvh2bRlKpO3xCwwjZJNLRl3fIyR/0QlKszfd
	0es8Nm7oqYSySeGFCJwJEwvQF56y3Zz8d7tDwNcETSucJz6POKMyeS/XHMQYru9b3BC3MRngahK
	up0aEeszkna5rb3hT59K21dAhokM4p7ucLQc5wNCY01gA0fvio5YTupjryXA==
X-Google-Smtp-Source: AGHT+IHAWGYgmPyEAZJqTKSd2mu0gZImGplk3LiAWkfYTJ+EixWMwN0H4UGNKwJ6rKcqkEZsw5RA9w==
X-Received: by 2002:a17:907:3d90:b0:b41:4e72:309f with SMTP id a640c23a62f3a-b72e0592203mr1212517066b.50.1762872275331;
        Tue, 11 Nov 2025 06:44:35 -0800 (PST)
Received: from fedora.tux.internal (85.191.71.118.dynamic.dhcp.aura-net.dk. [85.191.71.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97ea95sm1377118366b.44.2025.11.11.06.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 06:44:34 -0800 (PST)
From: Bruno Thomsen <bruno.thomsen@gmail.com>
To: linux-hwmon@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Bruno Thomsen <bruno.thomsen@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] hwmon: tmp421: remove duplicate return in switch-case
Date: Tue, 11 Nov 2025 15:44:06 +0100
Message-ID: <20251111144406.7489-2-bruno.thomsen@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111144406.7489-1-bruno.thomsen@gmail.com>
References: <20251111144406.7489-1-bruno.thomsen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use single read permission return in switch-case that handles
attributes in tmp421_is_visible().

Signed-off-by: Bruno Thomsen <bruno.thomsen@gmail.com>
---
 drivers/hwmon/tmp421.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwmon/tmp421.c b/drivers/hwmon/tmp421.c
index 1eded169e843..23ed3fbc9c99 100644
--- a/drivers/hwmon/tmp421.c
+++ b/drivers/hwmon/tmp421.c
@@ -262,7 +262,6 @@ static umode_t tmp421_is_visible(const void *data, enum hwmon_sensor_types type,
 	switch (attr) {
 	case hwmon_temp_fault:
 	case hwmon_temp_input:
-		return 0444;
 	case hwmon_temp_label:
 		return 0444;
 	case hwmon_temp_enable:
-- 
2.51.1


