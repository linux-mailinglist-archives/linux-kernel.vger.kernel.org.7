Return-Path: <linux-kernel+bounces-793649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15631B3D66F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 04:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2583C1898051
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 02:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A582F21CC5A;
	Mon,  1 Sep 2025 02:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkZBipRV"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790591F5617
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 02:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756692040; cv=none; b=Wh/ydiWes2rEHWxf4/k/SIQrKgOw0alGQH9ShyEfOyLfBpR1fKC+eoFb8VKP6b2HMTV6iJSs+0nNEl0DNP2NX9W+xB9IH3VMeTm5DZmgHj2y673TZ28pjp8rYuZl5Uvpzqk7t1vHzef1dJhzoTaiN5gwyBfQnJnLtILXAe0dgo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756692040; c=relaxed/simple;
	bh=SHx/err06cat1Rq44fqyBd180FjnqLoHf/fPnd/fJJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hEDrrwdfCo2LdYb1vov3/Bg0C9ukQ+qT1HjRv9EY4of/jYf9JhiMuyL1/nHYL4GSDTPq2lZBuDBFTIyS6aGiO9s/kz6alzQ+y/Lrc6HDkPpbFFi8okEvFxIPNyi1m2djbnlmUaqFLBoUSU+4j3DHxPnos9KdNNnALFl+a2N+3Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkZBipRV; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7f6f367a248so352361585a.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 19:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756692037; x=1757296837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OaD/OWwKQXAYi1ON0/0C3vmv92rVLm893Z0kjykczRg=;
        b=lkZBipRVs6VLtGIUwNo8y6QzdA+nNJmPySjwbMkoSe0fUBCCGmxJym8mupLDq9TJ7i
         N/d0O+5Mx9uEtmyW8o/dNJJeXsNxqC1T6Ys7k7VGgnhEeGdKOYJEPZv2Lki4tRIcJftQ
         2zHzynQz0SBSxKDmj20W2Nc/y1n04C6oawX4DiNRc6DJ80NCzGKuKWurrCresnwux5Wj
         r+oMkj8SNClPnn2+m09er+GyhXSD9zY1VpwLHuvRyaoYiyaPk1frAdjVTmHCPfJFu+KY
         Wrh8owicnOA2ng1IcoqgZxSv5biXI9RTQITEvbgOZ8uQ7LGgCd8yK6wqsZwTm7nc3xC5
         SkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756692037; x=1757296837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OaD/OWwKQXAYi1ON0/0C3vmv92rVLm893Z0kjykczRg=;
        b=AJ/vhWpfYRJJODtklYYpU3S1p750edCfooGmcItoZd1osPgY5Dp7RYvbXjJ9CshykK
         Jehx7OWzZ1iGpP1Yz++cr/5auN/jgQsRaGozufbwVyb3w2Q1A5bIZLWRwykXt1EzIAqy
         XsOGUpEugZTU/ltXLBKY06UL7Gg455PcKLbRv3FSv5l8Ad4vgh5sWHUcPP9aTV9O+nlB
         hB+M7DM3QsEdIwNii1ZuMIvzVrzC+P9DaF+v3sat2kr5WUgWF0yXETlffEOv5OHEbK6V
         cQTuswuN4n7JdAK7DKznT3AJeFNfydia9r5vhX/3krs8lKUGMXk+7+PBzFNNTyPX5md7
         WP5g==
X-Gm-Message-State: AOJu0YzjL2eLfI8Jm33GUOSDVci4qUsQzbq7zU/escrQ2BgPLcw28yrW
	iIhqQ9esvbo3B0usOxS8ezIF0XChBL4LeGFWV7XSpKZ2nSDG0d4Kgu8JYs4eTg==
X-Gm-Gg: ASbGncsnydac8zGd19QndWrOham90Rx7lmQRW2ID5/5ORM3eHitliwV0RNf8tA/L2Z+
	Kb5HSPQ5ntSjiUdcRsACJbsOaOZj/dZAsYVf1XYn5BGCXjQHRbrXlm/ncptokHXmbYVJFvkC+nu
	V7ytep1bygFLYj428/RQ36ICgOKpbTxP1QPfsbe/PnLpgMfa/DE0nrB2Su8fo/P4xCSujBzLz5K
	wxeWcIaZl10docZmEcVqOncx8nsjhwjc5QRmfCi1PQlblycO1kMBaDTDuNB/x9WSUEYuB/8gyAg
	kygYGX3siiScnp+IdNdnCQcYbttTm118l3N1sWr0MQ7nolBT48x4CYUP6xGyKWk9w3D2Fvg1GON
	keQSIAjbVQdQbOlxrvaFpDPg3HihURJXk4249FajvkWQq/TI59FvTtTZt54nn5wNIPenu
X-Google-Smtp-Source: AGHT+IEQVAjYL4ImVlKXfF6ZwfIyOQerdjH8mW7wg1Cl1DAKvCXFs0uhgqOgIxuEk2EaWXkTeTHwvw==
X-Received: by 2002:a05:620a:701a:b0:7fa:40bb:71a4 with SMTP id af79cd13be357-7ff2c32f9e8mr700392485a.72.1756692037147;
        Sun, 31 Aug 2025 19:00:37 -0700 (PDT)
Received: from localhost (modemcable197.17-162-184.mc.videotron.ca. [184.162.17.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70fb263449esm32441416d6.25.2025.08.31.19.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 19:00:36 -0700 (PDT)
From: =?UTF-8?q?Jean-Fran=C3=A7ois=20Lessard?= <jefflessard3@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] auxdisplay: linedisp: display static message when length <= display size
Date: Sun, 31 Aug 2025 22:00:26 -0400
Message-ID: <20250901020033.60196-3-jefflessard3@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250901020033.60196-1-jefflessard3@gmail.com>
References: <20250901020033.60196-1-jefflessard3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, when a message shorter than the display size is written, the
content wraps around (e.g., "123" on a 4-digit display shows "1231")
without scrolling, which is confusing and unintuitive.

Change behavior to display short messages statically with space padding
(e.g. "123 ") while only scrolling messages longer than the display width.
This provides more natural behavior that aligns with user expectations
and current linedisp_display() kernel-doc.

The scroll logic is also consolidated into a helper function for clarity.

No API changes are introduced.

Signed-off-by: Jean-François Lessard <jefflessard3@gmail.com>
---
 drivers/auxdisplay/line-display.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/auxdisplay/line-display.c b/drivers/auxdisplay/line-display.c
index e44341b1e..ea23c43bb 100644
--- a/drivers/auxdisplay/line-display.c
+++ b/drivers/auxdisplay/line-display.c
@@ -36,6 +36,11 @@ static struct linedisp *to_linedisp(struct device *dev)
 	return container_of(dev, struct linedisp, dev);
 }
 
+static inline bool should_scroll(struct linedisp *linedisp)
+{
+	return linedisp->message_len > linedisp->num_chars && linedisp->scroll_rate;
+}
+
 /**
  * linedisp_scroll() - scroll the display by a character
  * @t: really a pointer to the private data structure
@@ -67,7 +72,7 @@ static void linedisp_scroll(struct timer_list *t)
 	linedisp->scroll_pos %= linedisp->message_len;
 
 	/* rearm the timer */
-	if (linedisp->message_len > num_chars && linedisp->scroll_rate)
+	if (should_scroll(linedisp))
 		mod_timer(&linedisp->timer, jiffies + linedisp->scroll_rate);
 }
 
@@ -118,8 +123,16 @@ static int linedisp_display(struct linedisp *linedisp, const char *msg,
 	linedisp->message_len = count;
 	linedisp->scroll_pos = 0;
 
-	/* update the display */
-	linedisp_scroll(&linedisp->timer);
+	if (should_scroll(linedisp)) {
+		/* display scrolling message */
+		linedisp_scroll(&linedisp->timer);
+	} else {
+		/* display static message */
+		memset(linedisp->buf, ' ', linedisp->num_chars);
+		memcpy(linedisp->buf, linedisp->message,
+		       umin(linedisp->num_chars, linedisp->message_len));
+		linedisp->ops->update(linedisp);
+	}
 
 	return 0;
 }
@@ -186,12 +199,12 @@ static ssize_t scroll_step_ms_store(struct device *dev,
 	if (err)
 		return err;
 
+	timer_delete_sync(&linedisp->timer);
+
 	linedisp->scroll_rate = msecs_to_jiffies(ms);
-	if (linedisp->message && linedisp->message_len > linedisp->num_chars) {
-		timer_delete_sync(&linedisp->timer);
-		if (linedisp->scroll_rate)
-			linedisp_scroll(&linedisp->timer);
-	}
+
+	if (should_scroll(linedisp))
+		linedisp_scroll(&linedisp->timer);
 
 	return count;
 }
-- 
2.43.0


