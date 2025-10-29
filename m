Return-Path: <linux-kernel+bounces-875022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 686DDC18083
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 03:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B8221C6355E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 02:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2263A21ABDC;
	Wed, 29 Oct 2025 02:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTuw7Hrr"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126B12153FB
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761704299; cv=none; b=XRsogfMlNpRnVFQ4iHTk+i9g2sXryNJy/Pt5VrUy2LgjdNmBcHASGzp+gkMrkdOzZ8ss6fGQZXi6ssM6M+9JusOuZQAWU1f8L0Cd6AQAUcTUElQJVp7PgNqrnDntnTdRK0VZnJKh35n5uRLRhTI7vbUI368mDz0QgY02fXqE03k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761704299; c=relaxed/simple;
	bh=12I7O+T/BB5vXrNWDf+G6+4oR7EW0ESEut/5OnczsIY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tObxEuzFNyYuLSs4vvJFoKSgCQanlinHqwbjnjU1GjezStUKSqmsA3/ZdGd510rR/ii+5P1vczp9iW2ER0i0WOcrVjk/Fz75t+pOauTYMLSkpLLQPVCO7k/lh4bcapHeb8DMIkkLRkQR80njmSkaaUOT/cPFdvBV5I+QqVwX57I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTuw7Hrr; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7c52c19cc27so1469940a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761704297; x=1762309097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FHoGag4qYuBHkU394iiXcv5SpnjOGE5n7s42K/stQF0=;
        b=CTuw7Hrr4VfHhrxGhNhvHw4iOzew1fD4Gp8yMr2j0jqA6Br8cQW7ng5CLjfw+HIwUw
         ULc+k/IEV+E4DgE6U/NFFvgYiV3Rs/MjMGT0CFQnqo9bfmqJMycNoCOmIZhqlAvzlJYF
         nCSMt6TtA+FggEavGNdtFVGi845s4bE6JuCxgxmsD0ezfQVMUO53fWLtvBjr9UOgSbEZ
         eoHXCnlUZA2hRcKCuvFBgNlLMaQVkOj/v2qfWLimMhIQZDae8C464qMVZ883+Pgtols9
         tAa0dYOKvCJaBQuUEMmDahf28cGM1QJiY+q5e4t+Yt55FTclkLm7+ByyDAHiHSuruYhW
         rVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761704297; x=1762309097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FHoGag4qYuBHkU394iiXcv5SpnjOGE5n7s42K/stQF0=;
        b=LH1IeLaGTIDdXowZMpXWfCZ+95Z3DDu3c8JuIfYXttXdICS5y70dUYvFqZJESszqTB
         FobuZREI/2pzyptiF+51OKAxg/enYlK9FjUJbcg0abYYAN8TwZBuuPSF+r4MpKxMoE9e
         kY+DfAnzlg7Qcyk1x1Pi44uleWuS3esDfLd3MWlNwl9ybVagCZ0DYTA5tMHJTogQwTGu
         bO4DJbKLAykpcj19GeGOz5+nXp2hiLauYJVtj9W6qCrh3gz5Bwj96ZHfjyt7yBhHofaA
         caOUOrsncaC9QaJGGKZJzZmwGpWmZJwB6Kw4usYoDFCtCrwLpf4jxRYX+opai3HSMrqP
         Ekcg==
X-Forwarded-Encrypted: i=1; AJvYcCXros6+vzNVrH12KBNtn7feAz+CtPOIr6hrvPmFhzeM6ERf1oRNGbiXWR2p2XZQafJu7Qm5HiF7c5CEcQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXXzi0hVSS6NzQg052LjwrcpqLWk1ESf0fSWVtOXVfYEzcp7P3
	e//SLSC3G+3UQyxApRyzwA67TFPtt9FClIK6uxaJlgxjx4Xv6yImhqhL
X-Gm-Gg: ASbGncsyqLeQeti/T2QiTA6R3Dv13A5+tBQefAQW7w2MV9yWjbY6mpS+Llbvh/t929w
	bRHNS2PUPpNEF0Ymr1E1YFGiKSQLxumOtyT8Bc3ZAgeJ25SytlvAuBLofZthc2gpxpB8a/RmPV4
	aHmampLAVtBB5SEtp5Uz1kXW6pDbvsP4YMg7qPjeEEH7HCl8mTwWWk9zglISa2TQyDojqlPFn2T
	7jFRH1gWcsO3yuWNk9G9X5FTsYEko3l4Rxh87ew1q6g85vZ0BxOS3OU+H8+jps7iclfmiUdF4RL
	NzbBbUU0EeaDuFtDgW/s4RqyGK3djRfxbDjPtlHKAUxeYw8CPtlV/1ogpuzC71JWX52cDuJPBon
	ixM8BJN4/8ovnT0XbxiH4S4GeM9ugactlwc9NRw/0Uuj4NzD+DPmRixJ2UOiFRcDQ+QuYjUuU8y
	nY/b79vRu7XF92kmWoaD2OY85YqUiOS7jU
X-Google-Smtp-Source: AGHT+IEvILeiQZsY9hQI4HqxU57DwTh96/ZaoIpzYa8J3J/41J2DdiQ6QFO9Fmvro7ru8YzzqFGlBA==
X-Received: by 2002:a05:6830:631a:b0:7c5:2e2a:d394 with SMTP id 46e09a7af769-7c68329cc5emr1033173a34.23.1761704297050;
        Tue, 28 Oct 2025 19:18:17 -0700 (PDT)
Received: from localhost.localdomain ([104.247.98.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c5302068a6sm3732034a34.25.2025.10.28.19.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 19:18:15 -0700 (PDT)
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
Date: Wed, 29 Oct 2025 03:17:56 +0100
Message-Id: <20251029021756.5751-1-cristiandelgobbo87@gmail.com>
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


