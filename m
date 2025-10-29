Return-Path: <linux-kernel+bounces-875017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DF2C1806D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 03:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93E2B1A606EF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 02:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64BF2EAB61;
	Wed, 29 Oct 2025 02:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaYS9G2N"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39C724BBF4
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761704101; cv=none; b=cJKlYe7wU8EZ7tEKQuTKrLbOerI20vBxDsQBtyQ/wks03LdhmNvJ/1hGGZuPPn0Fu0mMGmEvT96KyEYb4ieBBDNuglQKTwT50nIIPF+0DY0OunvWQSyJdEiuISCG0XsFWlvDfL8bicvtqK/t9G2A2zFfl0fvuJvl+yydwlo1p9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761704101; c=relaxed/simple;
	bh=12I7O+T/BB5vXrNWDf+G6+4oR7EW0ESEut/5OnczsIY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cPieJbL9vnCvqeEaKuwV8R9pnxEwkiFL+IOSlcRe0ymTg3+C58qsG12gjtK4oKeFdw/U7GwYzxzPeGb3A29QJfIFeKQo3fvASz1fWy+7bZSE95ZDHtzFo9uRudbEP69CzUVD2DyWKeIoKBnOqGZ9iKACCrNHeuTirKws7r//ZEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SaYS9G2N; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-3c9c379af8aso397552fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761704099; x=1762308899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FHoGag4qYuBHkU394iiXcv5SpnjOGE5n7s42K/stQF0=;
        b=SaYS9G2N/oElX13SfAdvY8/BgZwu0ui3SYNgp3wdNQCcmBOAGAlzAOzohWApxeQIOc
         ztScGqjsVpASOAoqa2jizOtqXp42OW3FN06cwIMXPmHUSeCPIVMkzxnGmFZ3nJHf+DWq
         1eAjDLHm/EUgGQS4ohX41jM1YW7GLV/A0jv4ey0+l3Tdi8zamaXtv+G8xhpVlajvBoX3
         6bZgjWN931Vk8HZLxaL+b6Q3JO01U8vyFPIenCE8ZeeZlCUb0468763dw5QebwOo2hZu
         IWL9YHupwKnt6kIqlBlE2+QWHYS8Se7pysLcN4/rgJU3ZQNwSZ+90GQDGKBGvtvqhKKr
         DwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761704099; x=1762308899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FHoGag4qYuBHkU394iiXcv5SpnjOGE5n7s42K/stQF0=;
        b=hz6uATt7SROm0FlOR6EO3jDC79vLVXR2wvwzAXQfNU9exLR4K1NsXQKjYT8TGJKmbD
         xlY3/yvqYKQK0loC+KguXVch233JMBzek9sAYViPX1Kx7kfyxkfgDbCPJ9YhSbD0Kz3q
         Zpop1imEVIRRiGsZYqN0cU63anBhQJH7n23AKt7QwdkiP2xcipN3S6BJzgA5ozxAOV/B
         AlFs/p1HxEO9FmTjDYZC1n+4Go9Y+CI7I8WJTFNcKuvGjdXwT8K4AfqBm3YgIXsj9w4w
         CJJNZIO0Dgvb0Xy5VqO8xuvo3dwBuWdxSUhr/pB6lOVemiUK/W+G2BnMf1Oz9k5/I8aG
         BFew==
X-Forwarded-Encrypted: i=1; AJvYcCWvgD6A1DwWE0zSTHttaya6MqC0R4TicNn0rhDBR7XhdtyzvsuOkYlnP0NewDHbyOtwHm5F7/cQoTwqOI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXs3CqBgv1yvI9BDJOvyxieP7k6XEVNmQJHn4eaXqjSYnn1RHr
	u/k2/b4o/JWE+4Vs+5AMITwzHItsTHP6rQWR2yLs714ckEkbKykO3UzH
X-Gm-Gg: ASbGncuZXcHASnZUWuhNHUn4HKf5ybMsZbMCPPptdchHN6HSJcQkS7LhuOH/pLF26xm
	PLYbomwxZfSA74AfYbpHBn6zsp8yOJvWnF4le8SwXz8tHNIB5gMqMp3cmP0EeyhVKKbglFr1a/U
	wGGeMOuf7u6tD4Anv+NkgyPq5wl6v74Vb7ScNpg1ju5d9yn8q3wVomaQknfLqq/s6iDYBwPiHP2
	3LzliTaCeYfYs5GZOyIWo2IbwLZm0sdq+wK9IInLbJpm7BilS8ZXG6ReO8rXI5VkqxPAfY2EgIL
	SKZtIurQckLBYzIU9T87WXo0rSnqgq9avBnUFNgTUQXy6DQXj3ufgfC5fqwWbbIH6JuAnvsX/ZF
	fUGTUwCkGunM0La3nRO/wSR3MOQM8lBWIw3XovNehVoxpYzrCGGK6oYzTrTtrgj/P2nHABccdHb
	SzegXCaZW5Kxrzs+x7uFIkicMoW07bzzfR
X-Google-Smtp-Source: AGHT+IGfgTz8g+xqtQI6DArhNfNdTHyjQWmRw2+ZzPnzomIZgLnkO3eFgWsHbdYW5iK7yEBnpMbcNw==
X-Received: by 2002:a05:6870:e99f:b0:3d2:3429:b243 with SMTP id 586e51a60fabf-3d5e7264ca5mr2344497fac.16.1761704098667;
        Tue, 28 Oct 2025 19:14:58 -0700 (PDT)
Received: from localhost.localdomain ([104.247.98.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3d1e27123d5sm4190377fac.7.2025.10.28.19.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 19:14:57 -0700 (PDT)
From: Cristian Del Gobbo <cristiandelgobbo87@gmail.com>
To: sudip.mukherjee@gmail.com
Cc: teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Cristian Del Gobbo <cristiandelgobbo87@gmail.com>,
	Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v2] staging: sm750fb: style fixes: align call and split chained assignment
Date: Wed, 29 Oct 2025 03:14:49 +0100
Message-Id: <20251029021449.5420-1-cristiandelgobbo87@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Drop previous change that made g_fbmode[] elements const (broke build).
- Align the continued arguments of sm750_hw_cursor_set_size() with the
  opening parenthesis.
- Replace a chained assignment of red/green/blue with a temporary
  variable to satisfy checkpatch and improve readability.

No functional change intended.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

Signed-off-by: Cristian Del Gobbo <cristiandelgobbo87@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 3659af7e519d..94a99af4320e 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -121,8 +121,8 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
 	sm750_hw_cursor_disable(cursor);
 	if (fbcursor->set & FB_CUR_SETSIZE)
 		sm750_hw_cursor_set_size(cursor,
-					fbcursor->image.width,
-					fbcursor->image.height);
+					 fbcursor->image.width,
+					 fbcursor->image.height);
 
 	if (fbcursor->set & FB_CUR_SETPOS)
 		sm750_hw_cursor_set_pos(cursor,
@@ -538,7 +538,11 @@ static int lynxfb_ops_setcolreg(unsigned int regno,
 	}
 
 	if (info->var.grayscale)
-		red = green = blue = (red * 77 + green * 151 + blue * 28) >> 8;
+		int y = (red * 77 + green * 151 + blue * 28) >> 8;
+
+		red = y;
+		green = y;
+		blue = y;
 
 	if (var->bits_per_pixel == 8 &&
 	    info->fix.visual == FB_VISUAL_PSEUDOCOLOR) {
-- 
2.34.1


