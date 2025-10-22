Return-Path: <linux-kernel+bounces-865211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAF5BFC7EC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0ECCD35305D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD523502B3;
	Wed, 22 Oct 2025 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0iDgEC4"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A0734EEE5
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761142915; cv=none; b=SJcHGLNfSnkTLR1n1skLwnqDpTfR5Gx9PBsdpqAe0F7WDYnuE7k6Yv0Fvox9kasFZdPGl5e7EOOBmci1ikJzGVY0mEd+XpgcMYD+7QNK89Ep1PeY70xwTQzLma/SLfcDmv6banMsY17XyoUaJg1iPZgXBqJunTtlBDL4yTYjpC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761142915; c=relaxed/simple;
	bh=RyMqVUMoRxnLE2+LH/uDoKbsjsXYMu268PiHdfObUHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=drEpFn21aTurNQVYAc2B9JdXO4iZbAgEh3IlIkQ3ZvKai5nKhfIPe78X1Pa3JXHLvpw7zj4El4RYcj0rpjgERo29qUbnbHZJbQ1JUyopAv/RpTHEm1iWw+O3JeaxKN0YzhmH/8tya1TIjleE15f2bX1QW7QI58d5l2FPIOYeY5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0iDgEC4; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so4495184f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761142908; x=1761747708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hswO6VHAbXRS9t5lyAgR5F2WC+ilzEfgsXiR8FyXf7w=;
        b=U0iDgEC4ll1KzUailgHGuGg2dvZyYCcri8Ik2xZvDn4/tK8FExWCzrToiAITWWja5V
         4jA3X4YERXMM9ose00DPofRZvynA0plLfBdirZ+SLHMXJDhxw038TC+K4JWDaExEV8fZ
         fE9zZoLkSlqs6q9fItnenRl5Yfz6XTV5qf3ZY1Hhfuk6ufYWP0V1hvxwFN207DqgjV7s
         FVrvLOEccT6+4RkEzP4SfokwquimM/ZnYXqIjE3zKrKNaaeAVprEYqS+0GdE/gFxgJd+
         YzSmsWK+zrVU2RpXgH8LYJ1C5rkqUWt4hgBjFrOyBIFg4rYhMu9vxk804vRtX4fXX5i+
         xbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761142908; x=1761747708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hswO6VHAbXRS9t5lyAgR5F2WC+ilzEfgsXiR8FyXf7w=;
        b=tca8AAMEb5aBWa9zy1TaYZxv73t1iBfsrkBJW59yAZPqxfw/yYdLaCPiE721MVHljE
         AHqw2Smzis3G/FGUbt2JC0jymvJ/oBFOmUy+aef3qhnbhAGQwFmVS6XtAt1vU1fRY22f
         rjyX0f7ODvzfMtMKKREHEHmjbAmx7sPNsDwfGQ0GyqhQr8tVWyGpNebQFupF7HVHlL+B
         ajum91fovvo9FRLbZkeHSrvgWfrf4aKBJHG1LE21YuzPJUN5+jx7uhnRyjpFGU1oJTVu
         w9UuZohTRgfOXfIVXu7tqCDmMMhv0eWZ2mSTaf9UFJR7ZAoS3bOM2jaPI4ezT5QKCP7P
         +Wwg==
X-Forwarded-Encrypted: i=1; AJvYcCX1GGdbM6XyZf19Tw/BZSHp3ZoLF4dIvwDv46DHL1CTpnmoqzmXtVwQTySm3eov0xyp/ZAM4iJoMMX2yoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvNGJvVr5NwTtlH7oJ0soCqUEZ4eDIO2c0zTSsfoVJgzL4G604
	pv32HJeG35Q3UbD8q7mmKd9I1NjbM6PA5LMK1tBAaQJ0qRp5c6sgQyU5
X-Gm-Gg: ASbGncvlqN9I/usS9XHRzPqyib1SmumMXVyuX3PQa5Ok/M6msShufkDaVsqTTbscuMJ
	0Zvr7A9SyMTFyGrDzjj0HuCTdpZJxzG4mLt7qGO8jo3UlE36dUlVdZRwsH3e2AEWK2ghQKRdkOf
	uzkTwhwNCr2G72dat/G6XXiHJlVhiuNH4v+6UH4H2YT0OMkSQyc4o9SXPiFspyHFm2Gkp7yHELH
	/aA8LU/+pLY2ksqO3r38rTd//vzsnByZmCh4e7LO1bQm4VO77NvoNgBsDIyFhmeL20dffPoJ3No
	qdqPFLYV9/3jPRa4FVlLgKBKAbVsAGRdKwtVAWU88iWyh+q5evAn4FYJgGV2HX+MZLkNJcSxvEa
	/fcG/YnGJqC0CEA2WVQDMC6iPvXA8iPK1gBzJst2hMR5mliEVNfcgE21Hqy/PA3pRJ0Nay6fKoL
	yiog==
X-Google-Smtp-Source: AGHT+IFq9V87Zw7qGeTmSRrPB3JwZR7jtskG/uf8ikZdxsnRyJSInvVy1UaH8yLg4G5ahmvQ9XgogQ==
X-Received: by 2002:a05:6000:186f:b0:3f9:6657:d05 with SMTP id ffacd0b85a97d-42704d7eb23mr14938377f8f.12.1761142908345;
        Wed, 22 Oct 2025 07:21:48 -0700 (PDT)
Received: from xeon.. ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3d4csm24803518f8f.19.2025.10.22.07.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 07:21:47 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
	Dmitry Osipenko <digetx@gmail.com>,
	Charan Pedumuru <charan.pedumuru@gmail.com>,
	Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
	Aaron Kling <webgeek1234@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v5 14/23] staging: media: tegra-video: tegra20: set correct maximum width and height
Date: Wed, 22 Oct 2025 17:20:42 +0300
Message-ID: <20251022142051.70400-15-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251022142051.70400-1-clamor95@gmail.com>
References: <20251022142051.70400-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Maximum width and height for Tegra20 and Tegra30 is determined by
respective register field, rounded down to factor of 2, which is 8191U
rounded down to 8190U.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/staging/media/tegra-video/tegra20.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/tegra-video/tegra20.c b/drivers/staging/media/tegra-video/tegra20.c
index 7b8f8f810b35..3e2d746638b6 100644
--- a/drivers/staging/media/tegra-video/tegra20.c
+++ b/drivers/staging/media/tegra-video/tegra20.c
@@ -23,11 +23,10 @@
 
 #define TEGRA_VI_SYNCPT_WAIT_TIMEOUT			msecs_to_jiffies(200)
 
-/* This are just good-sense numbers. The actual min/max is not documented. */
 #define TEGRA20_MIN_WIDTH	32U
+#define TEGRA20_MAX_WIDTH	8190U
 #define TEGRA20_MIN_HEIGHT	32U
-#define TEGRA20_MAX_WIDTH	2048U
-#define TEGRA20_MAX_HEIGHT	2048U
+#define TEGRA20_MAX_HEIGHT	8190U
 
 /* --------------------------------------------------------------------------
  * Registers
-- 
2.48.1


