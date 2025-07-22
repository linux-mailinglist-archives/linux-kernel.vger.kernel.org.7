Return-Path: <linux-kernel+bounces-740411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F45B0D3D5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F748188DF1C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD2F2E172E;
	Tue, 22 Jul 2025 07:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCw916cK"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA682D29D5
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753170091; cv=none; b=NHaHr3zctBo+Tzk79YjEFeu/qMNDWCkZB5t+6kw3Am75HRJPsc0OHNoz7yZ3/rgaSFnuHmUdR9UhsVZi7tqKZ7I84MKjxo+vKgU8Rr8SR6/wWMdErLaVRtZLmb5G0cqlITB+eV6ytpnRjgIQC333SECrl41ML7dGoj/TIr9d51o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753170091; c=relaxed/simple;
	bh=LAFzkfsjMSCq3mQX3QMycHLyMEh/8g9K5shOKKAytmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kq5UmBt4JAiQZWu2tprtzuK0H93bZm2JcZzEUxkp7LPMxOxpvaYbFcs3OF8zFatAVV1QirwBxTqXwNLbPGSFTli/Bpf30NXuQhyvlp7X2hA4zVC2/6LzlSNZlCCzhwDRF6iEqX8GxHNZrN7tk+JQOTX0FD0yWQLx9RyBpJCYro0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCw916cK; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae0c571f137so971750266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 00:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753170088; x=1753774888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZNogBY7S57ztBtcwsWdypdOXKto1q8N8tm4BSbYJAQ=;
        b=BCw916cKuCO8KK3uydYMiYepSpEq6nwR+zmE+LfdNqP1kfI6v6FML9pmYELg4wcR6b
         CkMe37O484lI/0MAO4VNkEW7bFXzojUz71mGOHWaYuJosF4EI2QsRYG+xKlXe+CrI5Hc
         kK1synuVRj7HaJM//j8+8mNV4lbxYk5mp7mLD5YBgy9BTRgaycqny+AEPEKrNhTroVC7
         SwLaGCBqIuwrepuI0V/85V9385VXQM8U1/YdpNGfqUqKoAfdpqnU2KA+K55VCeW3PLKw
         Xwjdri+POzBjgOtCrez/28fCLgyXhTGmvfFBHvkqQOGBljuryh7ucDGHr7yicOxZHTeB
         SsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753170088; x=1753774888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZNogBY7S57ztBtcwsWdypdOXKto1q8N8tm4BSbYJAQ=;
        b=jryHrIR857Kf+ne56dePsffDy2F4WjWRSmtywjH2MJGmxXxp2SDHwuC7FCA4Ccdz8O
         nIHrPzZpe1ajJFi9ONqXBYvfVfNoSB4+UJDfKNiFsxxGPNxf2jfdcZV8tVa7dZrYWXdk
         WHhWzruMlNiyPfMIgYObkWQ6nvWsrq4nLv3McOGruroBjbuQWUO85f4IED19gS8ulrJY
         XkVwKUyFFjlooMw0ueix517ZuJ3uoe+e37iRbw5zeATxKZMoG/FKENOJH+jH4j5rGDsm
         K7oIYdoYv462H1FHqmXq4CcpoOweoDIoHgmu9FhVH8GCxN+BBs/3xvlpGgg9jpp7OZKx
         QY3g==
X-Forwarded-Encrypted: i=1; AJvYcCWiMrPMhGKJPqpynyNdNCuXfJiazEuZxdqQ5dw2kxEO2pj4erHZvnhLUkgt9UEoF1O23asqejlgcttZoc0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0dGEvC+99o7S8a2aGVvs7rMD7z+4wd0vBFnMlnxsjQoqezPR+
	YQROQ83+xuHtVuyEvnambuxci7qRA/RRHFoPXGMZMvi1d8Ptu9xonM8I
X-Gm-Gg: ASbGnctH1aO3fviJ1SS2bZOE+yMf6z1sALZaA00UAqFv1AMwu3rZ4S6QJpce3q6x+Ex
	xsSspNI5lYiGneKDmdQElBjGZwavPr4no9fc3Y6vx16T0YyFBijGsMVAphPCYxHs9fmUSo6HWtE
	vt0AjGzYNkp+9lPKXCUWQGinvXgBfI+Vl4CJEPqrLvpytbVwqcngc1O0+XC8yE9lntNlnlUM/kA
	NBdVX85ZoN6o/P5XkVoHoTqF0eSP00TfiL/3RtutWbMj1LOjFDE3ygpBEvdLufOf5eFrLWtKHU7
	EVi5SvMO1+bCBcMCRMMsO4U1ickyQrwfSeCgQO0sDZ1JDEvvh8lmI90l3g4jOVzqa9FAA6elQZv
	VFlqV4cMuwg4F7Pg28rg1luQ=
X-Google-Smtp-Source: AGHT+IFW90x0hbLkyLT3UYkJcBiH0wEay939st4w3DBG/C7BPZnwEOkPFBURA4+AnF45CuVZdakffg==
X-Received: by 2002:a17:906:68d2:b0:ae0:da2f:dcf3 with SMTP id a640c23a62f3a-ae9c9be2d5dmr2050002366b.59.1753170087837;
        Tue, 22 Jul 2025 00:41:27 -0700 (PDT)
Received: from tumbleweed ([95.90.185.15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c79d6c6sm821224666b.32.2025.07.22.00.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 00:41:27 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 6/7] staging: rtl8723bs: dm_CheckStatistics is empty
Date: Tue, 22 Jul 2025 09:41:14 +0200
Message-ID: <20250722074115.35044-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722074115.35044-1-straube.linux@gmail.com>
References: <20250722074115.35044-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function dm_CheckStatistics is empty, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_dm.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c b/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
index d1c875cf8e6d..928226679ab4 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
@@ -12,9 +12,6 @@
 
 /*  Global var */
 
-static void dm_CheckStatistics(struct adapter *Adapter)
-{
-}
 /*  */
 /*  functions */
 /*  */
@@ -144,10 +141,6 @@ void rtl8723b_HalDmWatchDog(struct adapter *Adapter)
 		(hw_init_completed == true) &&
 		((!fw_current_in_ps_mode) && bFwPSAwake)
 	) {
-		/*  */
-		/*  Calculate Tx/Rx statistics. */
-		/*  */
-		dm_CheckStatistics(Adapter);
 		rtw_hal_check_rxfifo_full(Adapter);
 	}
 
-- 
2.50.1


