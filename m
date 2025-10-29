Return-Path: <linux-kernel+bounces-875023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A18FC18092
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 03:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED0CB3A6D16
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 02:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9202236F7;
	Wed, 29 Oct 2025 02:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXQ9GI8G"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18DF1E2307
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761704412; cv=none; b=nsaNA/+nyqG6fI2d0QjDDPG0FldKxvjKr17v5ea+/c6tBSPmW4TR0gVmQoFTPkqycsBXXfqobw6KF+7BkaecG6trFLxGqRDuFjNV8pEu9hWvfuUyXsZTFrLgqCBhB7/VpYq5J9fXGKHYoUZ5rZFw9EOQOrVlPdcSD4YG887QSz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761704412; c=relaxed/simple;
	bh=12I7O+T/BB5vXrNWDf+G6+4oR7EW0ESEut/5OnczsIY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=emd1hXhtWoZXANzRKSO5cz6pNfIi6LPq1qFtX21BpdiWS54mq7hGArHRIpiLgicUAeDpNxNQQ73niId1hH33CGd7/YAMGPYR7meaTeG+nPRy239qXEMgthr83IFjW8HidufDcZlmaH7w2fVUslK33XkZLBgYOszudH4pH/duXT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXQ9GI8G; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7c2878bdf27so4243485a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761704410; x=1762309210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FHoGag4qYuBHkU394iiXcv5SpnjOGE5n7s42K/stQF0=;
        b=cXQ9GI8GaXG3PsVhMVz9992qLMnPA922qcSi8kd7P9TWazWDx5Jf43OsPhs8YXx5o5
         3YPh5VrdSyNlSiCKLrAk4LgGdIJV4ApNYmNoKRDrl8tMjT4o8VWakYI3Td8yYS8NPMJi
         67r/roK5jAH+xLP09T+2e9yMS+BD2U81n/YDPuAqR7VP09lul21cCmfIj5ooUQIIy+u9
         y6NYMCXZVUbMHVuoC+jOOyJRbTwvypojCIaNwvapNHJ6Wtt+5Vz3yGfTFBW2G+gFs4An
         ffmk9EzDq2S0YSGsXmPRFe7rlROL/I4y1l83i1AHlkzSypWFjMueU0RWn1N/h4giyViq
         sExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761704410; x=1762309210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FHoGag4qYuBHkU394iiXcv5SpnjOGE5n7s42K/stQF0=;
        b=OgSj105YIafOeGlSs7ns27uzyKA1jglYMN7XK3ckLNJ+AoDg3NP8VJON8QylQ+XRb3
         4lYNEDOyhx8yNHLOFOP6Nrscf50MucwLe98p3900NKPcbaAlGZK605cJ/qDy49o3yEyq
         zHTWj3lwh9y1LfCGgms5FfYtQ0COp6Nx3S/MSPw3g6HbqiK0YrJUzo+K4IHHM7teMAYI
         hGKUbL1RxI/WPjjEWoHIWbmv9dQB0kDzQtNWgGNPSVEcXsmmNiKA1oKwalrG06xrupqO
         wmEfJ7tiyBF9weBXCg0AZUGvpK42Ef8ew8hBUOxwC+3HCr7AnMosCgYghU+gOOAj37fr
         g4fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwRj5B6nfqCrn2v/hB7WkUZqUBr9wDMuMmQIWEqcZ8XIJ2HtwfxVobfunMz4npfH7EpYcFhn0bMflsRyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRHMKAi7rcA+CAhXUCp0kLsOd48BVWuQviaTsdIesmEZPy5CSh
	t1UByRQekdhi3Hr+rTyUFvS+30bZUid/eHbpzSGN3B+gbSboOvxLKM1R
X-Gm-Gg: ASbGncuwuH3N+OBr1qtHfjRLE1mk/hpTVT5zOBW2s+A4C7mhaz08FIktj0PYghVTa4R
	Vr4nbokymq+JMQfNuDdhP8swibX7AZzORfm0A4HqM3s4iFbmQ2hMgBuYcOoRiv7C4k273XSBXjS
	6KUOgklbclV+oSY7i4ZdWUKAsjgsC9l3z5s4AbBBt2h/CQOJ4JGPzDRuVpUlaxNAmi0IfwM6/D2
	VSeqAx7654o9ODXZziIdpDQCEfOTDsm557O5N0pG8zS8tdF6jlB/74JLHQSgqACMkS+zSh9EjzE
	B8uk9rGQO/EJKIcKfM8iwr3ck3VZCFK8Gxj5n+JrJGRaM1nGogYi9FeXHFDMJgKC2WyXIgiUSIX
	/0d4Qayx82rHuuWyA8eRhxD+ZETBp9AHGTmVQ9Eqn+FBmuFn6YT/Ok7cm8uXc1hOFhp/Jo71v1H
	ibIluko8Zz3aqzPVE1n8TcpUNBRaIDlhGF
X-Google-Smtp-Source: AGHT+IG8RadSfTV9b/Jcr3hAcs46CGuklm2tmbfKHoIvqZk7EadHgn5d3EWjSr6/j4EfcF3GDY6P2g==
X-Received: by 2002:a05:6830:7107:b0:7bc:6cc3:a624 with SMTP id 46e09a7af769-7c68318995cmr940907a34.32.1761704409994;
        Tue, 28 Oct 2025 19:20:09 -0700 (PDT)
Received: from localhost.localdomain ([104.247.98.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c681eb5595sm499344a34.3.2025.10.28.19.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 19:20:09 -0700 (PDT)
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
Date: Wed, 29 Oct 2025 03:20:02 +0100
Message-Id: <20251029022002.5812-1-cristiandelgobbo87@gmail.com>
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


