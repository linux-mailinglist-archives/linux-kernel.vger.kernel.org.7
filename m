Return-Path: <linux-kernel+bounces-876299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CCDC1B480
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 628EF5C438B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08463563CB;
	Wed, 29 Oct 2025 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXGyrsgQ"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E6F3559DA
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761746174; cv=none; b=NMBBGXPpX0A2jIdXrd17Gd4s14GXcIFN6r4Xjfuo48PB8y7H4edxi2O7MTNLWAXNXhdrbbXwXAytLMcVBrTaZKE7wg6Py42G7htRDgmomWpQURks0i8/0OSD4QX5FnObZpA8JR9A8chOpp8GhZlN2V2MGk/rek5Wb3MRV78i0uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761746174; c=relaxed/simple;
	bh=v5ahFBmmoGFzUch7/2SvprVd1+ErqpD5A4vWmS2SEcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZ4jH7UX4NjL5LlfXyTdg4sjPgjsAqPnqXjSx9IyMpksAjp8qvEToZeCxCrrAvgrkOyPA8ZVqYDWydL10EJrmZYCf8/TFyQ9nV9Mv6Fv5ATEln9VGZDDHn/8VbXFed+rL5NT6NZGyvRtgIMOHrFH5W9Yjq1Sm4/NHrVIxSzSc/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXGyrsgQ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b6d3effe106so1613246866b.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761746170; x=1762350970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWLsbyIMgrO4Anjvx4doEaIEZAGpDh1hvTWQGxqxKac=;
        b=QXGyrsgQIw495cgh7znPWycJd8DmXUIGvFt1GnIvoLG+PYx0aYMza4WBTHbckJrRr1
         PPpDX+TSnrahMBwbIhadjDx8NcoittoHtXBwEVUsQka3x3pY2AbwJCM2EPeovCsQqOoX
         k4+tiUmIOTbr4uMNt0CwWR9zhlSogITKvIJOLhm+FDY/vFbJ/Wdz6v/5brTjQN1JbYFi
         rPgouNUptK8lpWdKdR01xRHquSomeLJvNZcnOw1JQnv8amRYkDiuzDu2Xqa+LU7lUXxW
         /uOYDWOKCqPtDq+ubZX4e5eehfylRJQSb7IDIlKOYNX1BZTiHDZjv/3i14SXgEMyYD1N
         B6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761746170; x=1762350970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWLsbyIMgrO4Anjvx4doEaIEZAGpDh1hvTWQGxqxKac=;
        b=jtYe6L5ozwy6TRloy62D6P2BWKMa8DRzQAS/a6Rj07/R9EiXIVFKptespqYW/zHon0
         xVxE5IiUx/b5Fy0g3b/LoE9ZB86u9xSc8EaKmS8f4VdBuOwmRqZaMDQa+a/73WRo+zaN
         mJTJPrAoVTN6q9U7i3U0JzNsH3K57AIPnYYEv03NuQASBhBKyDP1OH94+yLGw0rwdLBd
         2Rf/ia+yVQMN6ho/qY3SOCt35J3IZUtJVxmQNXaKedt/IPGAKWGWyLEzB3QbflUg0rPa
         UQTLsQv7vbByysHxOW/P0gn03/tXv+7sccN5hr0KE3G/hOQVKyl8aY9AwqwtaWOmzv6Z
         OsAA==
X-Forwarded-Encrypted: i=1; AJvYcCV3JXA32EA5yyvMHfKq9yPCdpsmL58HvR/wggR7g6q35pLjusCh6xU1JsFaM2SfHFI8wnDH7iG49NkwlS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvEQEEDmLqU7Ypx3ykgBXCEoolsgcPHEHSFJQyR5rZ3pxeMyWm
	XBvp5PEW16f8mWt9ilB0OpU4Qyj5xoKKM41z4hJNPKBUcvqV/N+7aZim
X-Gm-Gg: ASbGncs36fQaTFECEGEj4/8GEv3BPkMXVh25TpOlKzf3GNGgRgAPMVzaXUN+DWF+abv
	Qm0i/MIw3N1Ynn2KkNahiNtZRFNy0o5vh14kj2ZWkaAVD9xxg9aFdCMYncfimq9CFj/KxckLxjs
	vjElOW3hktHWwS1JM4ZJRf2g/fv5oog6FU5bTou3/DKrjhwgTFdiFD5ZC7eDWw5jaGXvNrabmBA
	p0f3OSFd9isxu/i3++O97rukOPCnMxThw2W/Ff0mP+RF2XpxwLMR+3Xqh1JAE41d1HnYzGUb3HJ
	jWLGFeu5c/numv51yKyg/ZMpmzcxHizkmBSb54wotarhi7LXZZvpCDt425iCQ5x6P1NK781VicD
	+sHw2XjLQ44gZU17xqCUEIGDP7OpP7NxJ/8dcbJMi3bdLDelhv9NKcTicCh7nkoziDuEKT0Nt4G
	GzzwgTN0AZn4W7BBjEm4TkenQZjw==
X-Google-Smtp-Source: AGHT+IHsIhczBnvh9jDdmQP7dI7sF9RIy0mdsWyOBSP3lJT3RdO+FroC0QNH4bBEw0VRWYxAQ/wuNg==
X-Received: by 2002:a17:907:1c93:b0:b55:e023:5e79 with SMTP id a640c23a62f3a-b703d55cd84mr342463066b.51.1761746170153;
        Wed, 29 Oct 2025 06:56:10 -0700 (PDT)
Received: from SMW024614.wbi.nxp.com ([128.77.115.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8534d99dsm1444960766b.21.2025.10.29.06.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 06:56:09 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v3 4/8] reset: imx8mp-audiomix: Drop unneeded macros
Date: Wed, 29 Oct 2025 06:52:25 -0700
Message-ID: <20251029135229.890-5-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029135229.890-1-laurentiumihalcea111@gmail.com>
References: <20251029135229.890-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

The macros defining the mask values for the EARC, EARC PHY resets,
and the DSP RUN_STALL signal can be dropped as they are not and will
not be used anywhere else except to set the value of the "mask" field
from "struct imx8mp_reset_map". In this particular case, based on the
name of the "mask" field, you can already deduce what these values are
for, which is why defining macros for them doesn't offer any new
information, nor does it help with the code readability.

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 drivers/reset/reset-imx8mp-audiomix.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-imx8mp-audiomix.c
index eceb37ff5dc5..e9643365a62c 100644
--- a/drivers/reset/reset-imx8mp-audiomix.c
+++ b/drivers/reset/reset-imx8mp-audiomix.c
@@ -14,11 +14,7 @@
 #include <linux/reset-controller.h>
 
 #define IMX8MP_AUDIOMIX_EARC_RESET_OFFSET	0x200
-#define IMX8MP_AUDIOMIX_EARC_RESET_MASK		BIT(0)
-#define IMX8MP_AUDIOMIX_EARC_PHY_RESET_MASK	BIT(1)
-
 #define IMX8MP_AUDIOMIX_DSP_RUNSTALL_OFFSET	0x108
-#define IMX8MP_AUDIOMIX_DSP_RUNSTALL_MASK	BIT(5)
 
 struct imx8mp_reset_map {
 	unsigned int offset;
@@ -29,17 +25,17 @@ struct imx8mp_reset_map {
 static const struct imx8mp_reset_map reset_map[] = {
 	[IMX8MP_AUDIOMIX_EARC_RESET] = {
 		.offset	= IMX8MP_AUDIOMIX_EARC_RESET_OFFSET,
-		.mask	= IMX8MP_AUDIOMIX_EARC_RESET_MASK,
+		.mask = BIT(0),
 		.active_low = true,
 	},
 	[IMX8MP_AUDIOMIX_EARC_PHY_RESET] = {
 		.offset	= IMX8MP_AUDIOMIX_EARC_RESET_OFFSET,
-		.mask	= IMX8MP_AUDIOMIX_EARC_PHY_RESET_MASK,
+		.mask = BIT(1),
 		.active_low = true,
 	},
 	[IMX8MP_AUDIOMIX_DSP_RUNSTALL] = {
 		.offset	= IMX8MP_AUDIOMIX_DSP_RUNSTALL_OFFSET,
-		.mask	= IMX8MP_AUDIOMIX_DSP_RUNSTALL_MASK,
+		.mask = BIT(5),
 		.active_low = false,
 	},
 };
-- 
2.43.0


