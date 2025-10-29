Return-Path: <linux-kernel+bounces-875025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8C3C1809E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 03:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B413A7683
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 02:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73563224B0E;
	Wed, 29 Oct 2025 02:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIUYjvd1"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32255226D00
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761704495; cv=none; b=Ba6o2cE+NG/7Y7byQlr0YnfjipCbqWzzZnZKMuLASaogloqv3B75JlBkX/+wMn2gLZrx3NOvXSPiiyvoXAQrMc1vUQ+rIqEliWVl1X4IGvv7UPnR25qvu8qewaa8KZQm3oklVYXls0PsINCeUhkt2O3BpoTHrraNZBk1oqfMYpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761704495; c=relaxed/simple;
	bh=dbwZvu9hhIyVuqMTWNgr+/TO7f8rMnKkqOT/atxJsyw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XM8YY1Oyk0OSpSHZuuChxZA54F2TI1kJdGu0A1WfDYpKxOIkouknhRWebOBjEBeqI3DW1It+si6VOY8pGSPei3h59tTfVs4EEFetPREfgsMQd1azfcFOUOg0JFufYKVa3T7VApK07xXZ8qpGuHDwAdjX6QW7ZTFZYN4i6iLemeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIUYjvd1; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-44f44a1a515so326028b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761704492; x=1762309292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cynnkWYdpDtStoLe2q3qh9uk2uD/o/JQhJvnV67pO8E=;
        b=CIUYjvd1hWpiF1cJjy0t3vPEtSPY8+Oc1jO0dz/SZjHAI7qM6JQth0EgVFPx4Gi/qO
         YpRNmhAgBU4tgOKxuANw4hSBCZeAdrUtCnSA6rJmU1i/eBe9e01DIK8j0wwhHEcEBmsQ
         VByvLn6TDlCPFnw3YYiPiB6rz5Pc9PE2ETXWOvLddBHaOsw2IyIEaG3yTOegdA/5wtKo
         SJh40ffoOSiwrRQWAV6S2IXA9EapIVHZTX015ple5rHkQZPi1hqAhGxJhMh0kXly9AFi
         lxbWtArjaShKYBpk/60Yin7dpnZs0Y8UCiWQ5nuPgc8wYPmE+D4stnYHNy5QctdRqN6q
         gJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761704492; x=1762309292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cynnkWYdpDtStoLe2q3qh9uk2uD/o/JQhJvnV67pO8E=;
        b=uBVjeJrnjeZNkij6MXv6RmcbEXnbqlcJgqF3XkCoGi38W9QIyldH15NGfaWsxHpeUi
         kb6xRSpJWSQIs9OMfQMIa5MYJkTevaA2obMy3vDig7x+2XNyUnYmh/u+yvhWX/ZEVOXf
         reMyf7eDMgYSg2TOrUfdsRpiBr9HTqMN+hEoNzX0y44IHz2Qqsy1KeHu9yb6NpLNbGQD
         DjuYHK2DlQyBsDX+K+osZET8r1wA2Aoc754gyVtthoAxfHGFuTvckYWF9+Wo6JGppNAL
         JiaQLuvxvzA3ycp+9Fda/nsJNRjKPKden/YUSgKSSq+GVrNHURNeLrSs4CmmmwUM7EEy
         7pNw==
X-Forwarded-Encrypted: i=1; AJvYcCWTmZ6m/t3APrQQaMM9iJd/XtCv3TjSxbigTXOCnc5Ho7gzW0/1SZ3Dmw/uQTzpJhbentG+Enrn/du3Xc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW/r/T9F6CiXjvaWeB5Zg5w4CQ28Se9cu5veftfp1hwOAeUGYy
	XjwFG+Qf+oEboLW0xTFzw3ity5hExjk1C0mqD0z4FQDWHaqJPQ2b1f2o
X-Gm-Gg: ASbGncsVD3YNr3Zm8dT9D7tfjrf2QkfHY1A28rn2SVGVp/WvNI7W4t0Lqzq2nkBrhHe
	2ilk/8AQEHUCIe3VVj2rGCKsEpGNKyYPnWKboXunc3/AXeh6Z4LYoPfP2tA04ePKAyc9pFngNHI
	zS2S1PUl1NDafo97EfI6bI3D/Xhml4llAX8yZQU8PLuLmz+rSofvAU6SLvAdO0+cRwzSm/zIjMc
	G/XeQ26hZNMAkiPQuPLgHARprFLQqSd+3ggXpiiWe2WCuflkBz52wKpQRERe9AURfuhmgqJHMqB
	ahtTbIhbmFQ7tJSpIRIHfcKqdS3vQ9qmoktvZ3Wv+pg0qrzEgWmOXfrr7HEkKX1AUOWGXe4iXXe
	hhxUQmxEKIm75GCOhdH40ren9XEBj5EXWIRdh/w4KCrIwOum3WPtLPBLS6KkWK2wl+cDh90ID8g
	9PVyyTTmav5FqU4hKBNReR+jOKVTBaUdvYoTCRJO3LWE4=
X-Google-Smtp-Source: AGHT+IEbzvH4doyoZTsME/vt7Aop2SgS9zRyrPlNBrd6OpJTwf4P0pZiGzx+zwlfugi8jpvZSSIqBg==
X-Received: by 2002:a05:6808:3191:b0:44d:a5cd:e803 with SMTP id 5614622812f47-44f6c79f9fdmr2633390b6e.20.1761704492254;
        Tue, 28 Oct 2025 19:21:32 -0700 (PDT)
Received: from localhost.localdomain ([104.247.98.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c5302203d2sm3775042a34.32.2025.10.28.19.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 19:21:30 -0700 (PDT)
From: Cristian Del Gobbo <cristiandelgobbo87@gmail.com>
To: sudip.mukherjee@gmail.com
Cc: teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Cristian Del Gobbo <cristiandelgobbo87@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v2] staging: sm750fb: style fixes: align call and split chained assignment
Date: Wed, 29 Oct 2025 03:21:23 +0100
Message-Id: <20251029022123.5829-1-cristiandelgobbo87@gmail.com>
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

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>

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


