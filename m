Return-Path: <linux-kernel+bounces-740663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 759BAB0D76B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A5A056172C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873AA2E1C7A;
	Tue, 22 Jul 2025 10:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="R3qRy5hz"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331802DECCC
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 10:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753180638; cv=none; b=kzHXxZktcYjFneEbusCLFoUICkNfA9Oz7RwcQXR+9pQ6pFBpEjOoj4I9+3oiJgZnk86Lnln+E5wa2dz2eW/4L/SM32f7VzFTwpovBD8QZE26mQWSpcVz3gMustU8PTTtJFVtHEd+z6xz+ZIHi2Xmo0/634SRdM+YlZSnTwSdA1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753180638; c=relaxed/simple;
	bh=Uu0KyPQm4WIIkWykK1EPIZXCY66nvgOqnqJpxxXLb8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkbnOU27yVGTeGgxvPcOg9l9+cHvT6hm0jJcSTCCSX7F256I4xyOJ5mm80s00UyLKG+gqzemiOp5xHxbS9it3RFDyYOwkj1SKZZ0cdo3wD4WSifkDzXSg2wNAOsrEs8NzIiqmUJKEdVd7k0g472OiXTwFmtR5LkytgATsdDPvyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=R3qRy5hz; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60c01b983b6so10765448a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 03:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1753180635; x=1753785435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOaQOy4NwCzyitlYEvpuiMsUEgnozIVGmGmKLfL9eXI=;
        b=R3qRy5hzOLKjG9ie98wATV1+UQv1rwOTOrYld63m9Ogp/bT90sUq2o/3nl2lLN5gtS
         mq2ynhm2ndgEzOXWoTQqs/1AdyNi4xqlYhHvMyId8wrTV/OwGHnTVLHJAszLhAUaMw7F
         eBj7QAHUSkr2l+2UNr6jm+I4oLsUFc94e1NFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753180635; x=1753785435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOaQOy4NwCzyitlYEvpuiMsUEgnozIVGmGmKLfL9eXI=;
        b=MMM2bsK6mYk+kEYj9p0PU2sVL3JW7jrCS8s/EkClTzbWD0BRPt71Hpggjmc7DUycd4
         de4XJMCsSHBmmVoollIFa2/uA+ec4gACqmzRzCJgnkDnV6JMhg0A1DUFPnSfjx5AO/ha
         yoal7v7YKn3neDtS0ygA32p2qT6qth1oQXbqnQyRNmcYK/TQci0FWSTvEo9a5WAmWe6D
         EWO4dURSJ3AeFFwb9FIyt/1s1BuvTAULNzh5hhgihkgUwAmqNv4IMf1cM2OF1+VW0zaZ
         IzpSg/tPZMtFDywZ4Xtcv+YSmdcexPQcrY29mLkPJXJltuQCKibgq5/RgPwoOE3EJ98c
         RRrg==
X-Gm-Message-State: AOJu0YwaA6iKDOURS3tESoTV5oO8QTbokhHIZwm+l19Syo2ifADwiydg
	8EXyaDaiLLfRmJXoNV7nvjujp917vafUKWs64NbIvKwpM9TYqdPf6L7C6AEs0Ay0wMad8zJGajO
	sRuvG
X-Gm-Gg: ASbGncv3my+2UXl8oqG5dRdVP3mPztC7k0UrZWvtoCuEiI8KFWtPmX5vGpJReAl9Jps
	kM+ja6G5ZnmkG0zLheFqXD55mVj5TxBrU4A8mibVEvH5Z3WPsP4UwLEU8ZP4za23ejmqSiKaF1l
	jcgb8uVDLyxkxz74/pmRwRr9aVRl2v9FIf9OhToO+Ul1n3FKcROzvL0StXk8gEJ8MROPvPZ2fdd
	c6BV1tPKfSHmegH+OgQBosHL+xqE/a4VNrh1Dg6FJPfySpIlQ1r+g6ssDCc+Jzh2Xz558R0xyyD
	/Y8QIho3Y+GrDEu9KZnF+jOpoj6iRWQ6j9uoeeE1wEDezetsax2QpdFiWaKBdqAI+tFQzjaTTQr
	q4vi3ttlJrCeiwhzPDcv/ewA/KNpBmsnzMd49Aoo6l5UABsqnSTGcGijldeo=
X-Google-Smtp-Source: AGHT+IGu/rHAsJZdTDesHIy4THsJpwWha/3OdhJMXkmdfz+OLlrTD1ZQyBKwuFnDcJvQVIDplpGbew==
X-Received: by 2002:a17:907:2d20:b0:adb:2f9b:e16f with SMTP id a640c23a62f3a-af153339173mr333989466b.16.1753180635127;
        Tue, 22 Jul 2025 03:37:15 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:2bba:d7b0:8e79:c982])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca310e2sm844568766b.79.2025.07.22.03.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 03:37:14 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-input@vger.kernel.org
Subject: [PATCH 1/4] Input: imx6ul_tsc - fix typo in register name
Date: Tue, 22 Jul 2025 12:36:15 +0200
Message-ID: <20250722103706.3440777-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722103706.3440777-1-dario.binacchi@amarulasolutions.com>
References: <20250722103706.3440777-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Trimarchi <michael@amarulasolutions.com>

Replace 'SETING' with 'SETTING'.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/input/touchscreen/imx6ul_tsc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/imx6ul_tsc.c b/drivers/input/touchscreen/imx6ul_tsc.c
index 6ac8fa84ed9f..c2c6e50efc54 100644
--- a/drivers/input/touchscreen/imx6ul_tsc.c
+++ b/drivers/input/touchscreen/imx6ul_tsc.c
@@ -55,7 +55,7 @@
 #define ADC_TIMEOUT		msecs_to_jiffies(100)
 
 /* TSC registers */
-#define REG_TSC_BASIC_SETING	0x00
+#define REG_TSC_BASIC_SETTING	0x00
 #define REG_TSC_PRE_CHARGE_TIME	0x10
 #define REG_TSC_FLOW_CONTROL	0x20
 #define REG_TSC_MEASURE_VALUE	0x30
@@ -192,7 +192,7 @@ static void imx6ul_tsc_set(struct imx6ul_tsc *tsc)
 
 	basic_setting |= tsc->measure_delay_time << 8;
 	basic_setting |= DETECT_4_WIRE_MODE | AUTO_MEASURE;
-	writel(basic_setting, tsc->tsc_regs + REG_TSC_BASIC_SETING);
+	writel(basic_setting, tsc->tsc_regs + REG_TSC_BASIC_SETTING);
 
 	writel(DE_GLITCH_2, tsc->tsc_regs + REG_TSC_DEBUG_MODE2);
 
-- 
2.43.0


