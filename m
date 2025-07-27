Return-Path: <linux-kernel+bounces-746966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D852B12DA5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 04:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D354A2F7C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 02:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD9618FC92;
	Sun, 27 Jul 2025 02:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLGTrazj"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2D9224FA
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 02:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753583560; cv=none; b=UrMbfst3idUJQWLHwrTwv4eFafW5WD6/7wmtCUGOQGo0JJaucjhae8NTzSE0ZClhlgNOh3kfQplpvYn+bmbFylS3aTpsXu9VuZk0NhxCbNb0MIYUxbgfyaIhGKFNggXZEcy7nkjvXn2oO1WxDVx7abCwWgTYsgMzDEOKyY1OgW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753583560; c=relaxed/simple;
	bh=T5xzxCrWWoOSkwmX9gPd0ULEEQ9hUgtQU6nJfXmbnkM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AT3xjggE+d7Qo5Qy+bfL3l+TihgQycpcoHbyD0TDwL6ZPFLcaxfzwPEV4Y9dvIIkl2XWi5w5Sl8+4zW47bteR1OJULVCo3LlK31n2pwkal6aQGAW4tG4A9kBWJFXNbi+gwPBteDnLYHgvobNzQQ22cobpANNJXXZFHMI+tXnqX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLGTrazj; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-31ecdf5faaeso65780a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 19:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753583558; x=1754188358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CJFNZqHoCuSFkftjPhn3o0FfsCQ5ASEKlsZmf9V43H0=;
        b=CLGTrazjo5QxTxrAhj55lyOujEnCYYzQjmF49oUU1Wk08eDS80ylEj+NfWua1nzq7U
         YX+o1vXOT8ebGkE/r3HOr0Jnp1b77AaqUYHyf9Xt8PbeHwuh8kKgAD4cUPX+lD8z2xgz
         TpiHVD5zZtAZm43Km8Nahyv4czwAtwylbgcgQQ7kKRz5YsWTKpMGxvEy3z2o7Lj/a898
         PYQQIG/TWHaogHOjRjfmC7TaXGq+h4daInz1haZLILtoCrTGxHieachLDYFJP4s5OmRw
         RuzLZsEYVAfCux0Px/7IWjLgpbF9WvdYDgivwz2ZILs0K+A0twI4mx7M8SABwXwPeyIN
         XgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753583558; x=1754188358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CJFNZqHoCuSFkftjPhn3o0FfsCQ5ASEKlsZmf9V43H0=;
        b=h+94moIr6cAWNUby+Da6kDlT7HvxfZyItjylkPXjgGoFKJpOiS1PlW/KyLmtnffZQ5
         flglT8gI1IHFELkqwGWIVX8gdN7d3McnAO0K2x88LkiLQV3xAfvtksdhgmBud9swmOcc
         /CBSanv1dXkWhmR+XeifGNNUBKe7cU5vL7/D6uXNNHBhxIiX0jz70pGDf1KupvN/GRvH
         6Hs7NCctsb5MOnOJ384Hk9wS1Ng9lfiAnx1brn6M/Mfz8Go7mLGhwtoF0C5G7Kcsgn26
         cyhFK6bAxRQf0qWpM9eXw0ocbWgiMR1XFu8B1MveNvvfLixkM5/M1i74hnnk7cGhqKNw
         AUdA==
X-Gm-Message-State: AOJu0YyAKMPQYr4vCQUo2Kib6hIldryLqrOpuvTB2VYpuNtdq1FGf8/s
	VreMh0fvt4qIeScdRvcxxjQiI5BzqCck6pRtypZY/3fsVs7bt7+yXV0/wCzeO7in
X-Gm-Gg: ASbGncsatR93njqhb1asrE/RZZ3OOlD6tll6Q/t/+SD0ejQizycuHWfTXx3/jUlmYb6
	yfOzKVTf342WILmgTlTMWW2FKS5pHt4c4PwY2tBEEXOqCh72ZJ45O16cvReeoSbuQaBBvzbGeOb
	lPvIz/hnZ+4s73raVhRjkjOO/hgyo2wi8kYiHjZkswzNTFNOsdbcQKSqJxAtRTp2T+Z77nJN6OI
	vZItCJHepyvGMd+wGZ0d69jSDT5sxW9r3sWkXmIZIYLsiMZ0UYVepZWY31oKH5OZABNiDmgx4D/
	H6/9P7pMT278QB66IsjEUl93PwMcrwl+oRxjgLtpWbm3tbkOU6m/US10jtuo7qVs5wCrsBY4EyO
	KP3UM10nOE4SpcDgfMCkCMQ4JyMKiudMI5PTAKlxDDRcuwpeN1N3ap/z3
X-Google-Smtp-Source: AGHT+IF1Q+vutL08oIqvlMH0JTstogE78RwtfLbImzLFeSuOGKUmMrpPRwnd0KqoM05M7wiWT60uNQ==
X-Received: by 2002:a17:90b:38ce:b0:313:f83a:e473 with SMTP id 98e67ed59e1d1-31e778a4218mr10016001a91.15.1753583558382;
        Sat, 26 Jul 2025 19:32:38 -0700 (PDT)
Received: from fedora (181-162-135-125.baf.movistar.cl. [181.162.135.125])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e622511dasm4354759a91.1.2025.07.26.19.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 19:32:38 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Ignacio Pena <ignacio.pena87@gmail.com>
Subject: [PATCH] drivers/tty/pty.c: Fix typo 'peform' -> 'perform'
Date: Sat, 26 Jul 2025 22:32:42 -0400
Message-ID: <20250727023242.82815-1-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistake.

No functional change.

Signed-off-by: Ignacio Pena <ignacio.pena87@gmail.com>
---
 drivers/tty/pty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 8bb1a01fe..54b8f6416 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -277,7 +277,7 @@ static void pty_set_termios(struct tty_struct *tty,
  *	@ws: window size being set.
  *
  *	Update the termios variables and send the necessary signals to
- *	peform a terminal resize correctly
+ *	perform a terminal resize correctly
  */
 
 static int pty_resize(struct tty_struct *tty,  struct winsize *ws)
-- 
2.50.1


