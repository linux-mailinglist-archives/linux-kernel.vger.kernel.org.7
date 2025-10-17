Return-Path: <linux-kernel+bounces-857935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D602BE8490
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 348B81A66264
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D37343D98;
	Fri, 17 Oct 2025 11:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtNfbbO1"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5462343D63
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760700109; cv=none; b=asmFf+oRbSfnX1pk0d5JjjKSpB/vxO9WI3xh5XDciwsnyiZvyT8kXcP1t3qPfQ6LQs1mjzmYKm+MBn4k78z3CR6SUuQ7Q2/WfL4p2QWZHG6uC77/fdETrZek0UXd8fdQQdRHHsk95910MPLhdKCdLhGBIq6xZkN5rz5InenIjTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760700109; c=relaxed/simple;
	bh=3PA3zZ+Ug3aOY46+y0Bpyk/iEy6BvKUkO02G5BbMuws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQi2SbjhsY9iqmGCYlDGqHh5Evx+Mt0+8Wsfg6AGyvRTg9r0aH7Wd+TI3kEcuyBqv1wId7rs8RSe/HF1eQGxrf+u1gKrW5m+g+YD2rbwGTEwr3vLYaBjc5OvY9EOrKcdkt9BRF+3rMr4tPbxPcXcBl8e9NAmE0LdAVPs31C2J8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtNfbbO1; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-63bea08a326so2450536a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760700106; x=1761304906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4/f1Kl14CmgCOWKe9f3nn8ieC/PRwpFMREaWVG2sFY=;
        b=FtNfbbO1kBmcoTInlAWLFrZc2Umjz4n9LVviYJbBbxMtSUTHKkN5wjcYlSfCuHKp4R
         z/2gcSHyrfrs2DoFyUxosP6DqzCxeVmqowTvKPeBB+UUfe7jJ0s3vZAXykR5hhpp6xbD
         XWlypoHIfPVIYZA55mk4EyPwfz8BSVXz6qhDtcQfqvqhoXlwvzz6yH4O9NAeW00K8GtI
         L0FyzpcCuOTl+wagtvxxmM1iYgEqkGIq9FLiWYz04ZsLJNJCv4umH5Wd7ssSbI6H7YxC
         u8rhMygAVbRXl4LkYy2W7rbcDLSTBbfcyKFB5/6+z5GNFj4wNB1byDbFbvj+AV1OlKrw
         byVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760700106; x=1761304906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4/f1Kl14CmgCOWKe9f3nn8ieC/PRwpFMREaWVG2sFY=;
        b=mdN59de7QnERuARUpl08IQ9oq5ZzMxvFTuQ3ePbMylU80Jq+TRQUQMZnUZHkhZTAJc
         ydb9dUOOSqwx+C1PX2z05pqcSJ58bxlK5Cuu+NqH3Srg/o43fOs+lZGgWk30xBR+zSwe
         PgnpzbTBt/UUaFAE/YUw9Nba3UO95HrjRp0v9jEi2d/GfEdUSo8+vPkxpU+zr9paqw8C
         CzLKTcvvDxBL8b73HwcJ/xnI9ioN6CxpxSDqWCEQ+okD1p7LZP+lOAMwMWl4E1Uk7vPD
         tvx7ND3lgHtjntfyX8aYwBqSYvWzVj44NVNgvwRxrPX2MJ0d93uGlhRKeqJb+jbiB9qN
         lNKw==
X-Forwarded-Encrypted: i=1; AJvYcCX3mav10JNbEbBueTvtE9j3EmCqg4qprMJ/4h9ihhwVoZf+UVkoxyXE0Ly8MCUPBsZEWzGK3/yvpum/H8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxURGBzoz/FnEKNP4c++1dTHHi3+xZOji/yQOh3XcJzc+3RXIA
	4sc88bDw7mv0oVIeN8zWNZupTna355reQUlo4XQ9+F57NbMtsqC3Z32m
X-Gm-Gg: ASbGncssnCJjYf/Knl/FfAkuxjtQAYDGHuNK2YuP03ydfyfcANnoKDxmvCMMwbQOvnV
	lbFZJLXsj7fR0g2+AuicYrGE25AedrGufHYH7u/umSHXpqqGsM3AzAmbUCcoisLOoaMv3XKCSPi
	76E1xJAFK+D9D6qxsQquG/tb3+vApeoQUPOACS3/4EYQOeHPvRZkMEUdlwtw5pHjeM36r+D/md/
	AtMXk8fV58fKi/1h/T96+ZV6FOX6DVv7EVxUFmQXZtEabWi6Lh90gtE/LRx4fIibfu40SwVEfO5
	jJX2TRlqGWyK5uhed8Nk0RS4egiWXj/pPTB9i5tHtF2N11MuDqjhL0ikR6T6n30OR1If/bQ1501
	a2r9a78N/RFYV2rdE/1PXdKM1pLG+qghIDwtxnqYUFsfiy8rwdUYAMp60Q249w/kWdyyaEAEYPe
	lFCyigqtTRlBqvYatAj+bWX1MNeBMVY1uUa0iHDQ==
X-Google-Smtp-Source: AGHT+IHd6jblu2510v9bkHq/90oro00PKRRM0JXmjf8CbpRE4cA2knCufq3mdwx/AEKOqtQsu+8i5w==
X-Received: by 2002:a17:907:9691:b0:b64:6776:1ee2 with SMTP id a640c23a62f3a-b6473f42d78mr334179566b.52.1760700105898;
        Fri, 17 Oct 2025 04:21:45 -0700 (PDT)
Received: from SMW024614.wbi.nxp.com ([128.77.115.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccd1af35fsm788256166b.60.2025.10.17.04.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 04:21:45 -0700 (PDT)
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
Subject: [PATCH v2 1/8] reset: imx8mp-audiomix: Fix bad mask values
Date: Fri, 17 Oct 2025 04:20:18 -0700
Message-ID: <20251017112025.11997-2-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017112025.11997-1-laurentiumihalcea111@gmail.com>
References: <20251017112025.11997-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

As per the i.MX8MP TRM, section 14.2 "AUDIO_BLK_CTRL", table 14.2.3.1.1
"memory map", the definition of the EARC control register shows that the
EARC controller software reset is controlled via bit 0, while the EARC PHY
software reset is controlled via bit 1.

This means that the current definitions of IMX8MP_AUDIOMIX_EARC_RESET_MASK
and IMX8MP_AUDIOMIX_EARC_PHY_RESET_MASK are wrong since their values would
imply that the EARC controller software reset is controlled via bit 1 and
the EARC PHY software reset is controlled via bit 2. Fix them.

Fixes: a83bc87cd30a ("reset: imx8mp-audiomix: Prepare the code for more reset bits")
Cc: stable@vger.kernel.org
Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 drivers/reset/reset-imx8mp-audiomix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-imx8mp-audiomix.c
index 6b357adfe646..eceb37ff5dc5 100644
--- a/drivers/reset/reset-imx8mp-audiomix.c
+++ b/drivers/reset/reset-imx8mp-audiomix.c
@@ -14,8 +14,8 @@
 #include <linux/reset-controller.h>
 
 #define IMX8MP_AUDIOMIX_EARC_RESET_OFFSET	0x200
-#define IMX8MP_AUDIOMIX_EARC_RESET_MASK		BIT(1)
-#define IMX8MP_AUDIOMIX_EARC_PHY_RESET_MASK	BIT(2)
+#define IMX8MP_AUDIOMIX_EARC_RESET_MASK		BIT(0)
+#define IMX8MP_AUDIOMIX_EARC_PHY_RESET_MASK	BIT(1)
 
 #define IMX8MP_AUDIOMIX_DSP_RUNSTALL_OFFSET	0x108
 #define IMX8MP_AUDIOMIX_DSP_RUNSTALL_MASK	BIT(5)
-- 
2.43.0


