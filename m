Return-Path: <linux-kernel+bounces-730695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F9CB0483E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 22:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52C9C17055A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 20:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A064233D9E;
	Mon, 14 Jul 2025 20:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DSsH2yy7"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABD1154BF5
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 20:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752523650; cv=none; b=mTv+8ndsuseeGIR59+iKMqLN2fP1ZFyg6QmX2CF7tdayPN1d1Wi5A3TODwEpUkCTIet9RxHaXI/luruchqYgfWlbDEX15reYUe98Bb7WkLb0TrBgNlIltLUVW+aaOcKxqVm0nq+py4xc4ymXRxWsgKkf76jmB44SAJ0Xw34yC64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752523650; c=relaxed/simple;
	bh=lhHj23COqr+Z1qDF/+jPVYoPfGo9fQ4Pg+5BhVl/gmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fAlNmcBAY89AbOlIg03k0xNFQLRTmSogd3t3WunLOhXJcgrGGeYjKt8RphjYBkbaZiLLAexCVh9wjs8Ey3bzf1xI4uJU4Q4fM+C/HO9PvbtqtkPLXYrePXoqtqNTZZs8upgA03OcwQdO4hKjlXNa6r8jfDBZ7I9PckCuHM0j6bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DSsH2yy7; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-749068b9b63so3204894b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752523648; x=1753128448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DhdO2177EcE4SnYgx1n3JtwOIGI5XgQENyhYsXV5do4=;
        b=DSsH2yy71DtFTNmrCDlDg2dp+vuvBD9Pa/uhpI4zrx5vmeQ5whtpSmohsHDhdieWYg
         I83P7I2JFD7eHxVn3tj0+8AuUoEBL0IC4Gmk3w/CDgGxZTMIVlrupndzq+GpkPr9JBkW
         CeJo4sjzR3fJWriZArb/3jHjzSA4/A+cbEYUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752523648; x=1753128448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DhdO2177EcE4SnYgx1n3JtwOIGI5XgQENyhYsXV5do4=;
        b=Ug0YiA8zGXI2sQe6d5Cb4rS79d78L4M9FJEWyYaH792VdtpuyP3/71JhWyon3b9M/6
         /LptBoGn9XsNb1csV57pTv6ii1g6IYcIEZGav2lqj+quSaWFrR/BRK4CpSvYYDzUtGEk
         FVX6XScQ7Ytwk6UvAFdANbQotWWWQXTBiFhRjICIaZlQt8+eLEDeoeusr/CpSmHrPoZ+
         drk+V1IKGMVxMEJbSx27N0koy62NDtQjUDw9L6bsvkcj6LdlohEhfgUYKQBk2YG9iaHi
         LXxIN6oXKG/dTn096NE9o8N3YpnDyGpFZEVzqOWhPJjJyf0BXltKR36TrhWFpGuhBhJ0
         Gf5w==
X-Forwarded-Encrypted: i=1; AJvYcCVtXOoTTJUV4N5vMdWXiynVCVIsud/WpYFGG40M279Y8rgSe9tz6PJVOZ8B9cmI6J3EFlykpEFy0QfJcQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRPENPfeAftQfMxayKyXhI+aq+lCvMLPIP0dQUPityJFA9Xt5U
	BJOIEdn6T7iiZar8n7xqmD3LpmLxbHnS0I4ty956QsXHY/pttuBNCf2aiaq06lI0ew==
X-Gm-Gg: ASbGncsaShk5lbIq3hCKYFjZ+7IUHifXNkqbZgwYrTee6zhOoQxkP/vdUaj0fWR3rmM
	eNTBPrrG7iCQMxWpFoeZGjjRwlA1i0f5gXcpGD7o8ltjudgNgG69FfcB4yyC5Q/d+WwjU6zPzNf
	aBxp7P4Nlz7h7wdcHEGLfEGJxXK28Ujnx8nLMYqoH18v91u1Tj2GSSlwBwAO4xPPQogiToUivIf
	+S3ovGELJBG6/FrH09fA+m98yhosNv9esHbjtHcbjCiytlmIYn86qlGZtPxy42CxiSJ85JgVbAh
	jbin3NXkI5WRUpwTXm70XxrjO+8TGBz0/a146G7t+JvqoAed95NqCKJyAFSufzKLL9tTsWjv3bA
	YPY9RaNiocjn+94Ogq8QabUjsb1RYRpkhoY+lmZ5mZFUtvvuqsCbtdfmEmeqs62j8znFWR/U2BO
	UvQ/lJwQ==
X-Google-Smtp-Source: AGHT+IH/sBAf7ZMF0haSNivYQxKsv1D44OPDHqeimprF/0WoqKmowK55eKE6ZIb1ExZDD+1b6JkFZg==
X-Received: by 2002:a05:6a00:b93:b0:748:2b23:308c with SMTP id d2e1a72fcca58-74f1e7ddd35mr17399241b3a.14.1752523648187;
        Mon, 14 Jul 2025 13:07:28 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e14:7:1728:40c9:46f6:6e5e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f53903sm10032053b3a.128.2025.07.14.13.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 13:07:27 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org
Cc: Douglas Anderson <dianders@chromium.org>,
	kernel test robot <lkp@intel.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	David Airlie <airlied@gmail.com>,
	Jayesh Choudhary <j-choudhary@ti.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: ti-sn65dsi86: Remove extra semicolon in ti_sn_bridge_probe()
Date: Mon, 14 Jul 2025 13:06:32 -0700
Message-ID: <20250714130631.1.I1cfae3222e344a3b3c770d079ee6b6f7f3b5d636@changeid>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As report by the kernel test robot, a recent patch introduced an
unnecessary semicolon. Remove it.

Fixes: 55e8ff842051 ("drm/bridge: ti-sn65dsi86: Add HPD for DisplayPort connector type")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506301704.0SBj6ply-lkp@intel.com/
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index de9c23537465..834b42a4d31f 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -1373,7 +1373,7 @@ static int ti_sn_bridge_probe(struct auxiliary_device *adev,
 			regmap_update_bits(pdata->regmap, SN_HPD_DISABLE_REG,
 					   HPD_DISABLE, 0);
 		mutex_unlock(&pdata->comms_mutex);
-	};
+	}
 
 	drm_bridge_add(&pdata->bridge);
 
-- 
2.50.0.727.gbf7dc18ff4-goog


