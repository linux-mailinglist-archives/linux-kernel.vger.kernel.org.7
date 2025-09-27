Return-Path: <linux-kernel+bounces-834856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CC5BA5A73
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 09:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B50FB1BC1E5E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 07:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BBF2D2490;
	Sat, 27 Sep 2025 07:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHaoh/jl"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7B1145348
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 07:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758959433; cv=none; b=pqy+rnvq+ah3Vg0RdpoTK/eYAwZHYtpII2F4FAQ49adSXWZX+hbmbtSVJH0L38175Fl5ho9hqPiBnxdcnwg6ZrE1k+Xq4JNq7m9HxgL8AYMPza0OpaiJKslTSSotcfT0+Uh1Kqs6J4vvawf8kL72BF+zYunYr0tjCpxoN0Ufiwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758959433; c=relaxed/simple;
	bh=18wu7FR6Yh7UiKlpOC82WgZL7X3EtF2rIULwmTLxiL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DBj7/5vPV1vD3G1hnzOusNXPHObmEB3zLx2FKG/BiTEXkeLmxJ8whOvFHmRfE/2s8496a0kXwsPFbaHZAgPpffOPvACfMn3dlLHjJ/et2qomyUrsVSXAGZOfnz8niS9+8+LimzheVeT+y8OPQPxkEB9lJHW66U/wVobeX/2JfgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHaoh/jl; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8276e579242so314732585a.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 00:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758959431; x=1759564231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hgfPKSQNysrHS9dWJ30TPeInwwtlPIqd1YDWoMjDLSU=;
        b=gHaoh/jlihj0WCk6VC7+A4U+v1cUOJDS8wBr7VURZdtBuq1macboKr3GHMzSuM1FJ2
         bAF+1fmUspN3/uibpT89VS3crxfuxL8iy9u5KXd9iu5gjFbJAASRT6jFPoSLN40MAdyQ
         NfesaemNIJ0FrA1zGiuj9QqrX1pG9rZI73gqwVsqeIetbSlVKHh+4I89XFUC370Zhpik
         WUQ/WPw/VoGuqNem86zSxQvEBxg8+3zZZYU9eeHiPQ6XSh7oTbieEwycZyh8FTz+KtUr
         K4p/ntT+B4ZxS2u27tcTcbOGJA2CcNWLB53FLGMTClKz3aqyO4BTpykbzLR+kcDFrzno
         r8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758959431; x=1759564231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hgfPKSQNysrHS9dWJ30TPeInwwtlPIqd1YDWoMjDLSU=;
        b=lO7hdvgyptyoIDh2eQWEQokR7ljXx58URYwtuvV2q2lDtZhvpk+/pUgEXXylBSEhlm
         80onHwWBs25aRjZiKogNg5Dv4g8x/VEbj+K8vQK/2+F6/z2tBGIpZOYenVZ05zbCYTxi
         LzMrzeEgBhNPuFouyQrAarxzq/+EWVMi+Tz5EZ8XgKzZeOr+zpOVuyqrVnSe5n5ax247
         eHbLz7zxXPpqWdbtCECtDKjOhGReD1gDYa4qULQCL9pHg1oQE42roXh5JcSub5b5MFY8
         imeY3zBKayNqCAsH6qh6plRZz8XxQdpFveHSNqJ8IN3stAR0naRyGz2f8c+TVli6yCj/
         vTew==
X-Forwarded-Encrypted: i=1; AJvYcCU1GqB1TcERog6CaEDzeEqWhp2Rp+HuVaE3SkDPDzV9UCo1+7ru8JlFQByD0Mki19TjKhm7mz9EV62ALEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvdIEBPZgb7tQvX+ZLsVA0tqYIAQIEX5MYTZLGR1LQwp5ovkfA
	3OL5qsnLQe+9rxv03ObbQME7njc4JuSosL96BMIEnWj4zeK15UAMyikngmljS0I6
X-Gm-Gg: ASbGnctBHok9IGby25Bi17zZ7NHiD86n45irCq14chLmXgWD+4lgcbs4tlPOjoQG/eT
	M05xlLqAhlsbJW8//o5LFnwi3xBfE55+EyUZTNOHuARg/Y07gwcEQ2MYYgmlp985iTHBpplEmwd
	db0PLiKcA7SNhAOCN80VZSTSIPbPpFJ5jDEj09KP6dbDPJWXTeByhZ1QiOTEPdtfh2L9Go7aRfG
	2nIoIATvaQUQnQS5FLJ1lU2MY++ecEPD2wq+0j0RW4B87l1Gb94W3qIamPbBA4D5OLfbVF6kzxa
	p1cJ+CMy0xBNBn0szFerFhZNUYr4WZquSOXugxQGv+HmdYgSocNAWOLYYHq2C8ZSCi5xGR9L+6h
	fldUJBA1ifu5lTcuHVWYte4YIy9yh
X-Google-Smtp-Source: AGHT+IGDAZZkx3WIl9guUtfSPbuaq94sVuUIs0iollEMe6q0H0aWqiaDGpBWQY8KPFyB2BFDhYgIQw==
X-Received: by 2002:a05:620a:f06:b0:80b:139f:f61a with SMTP id af79cd13be357-85ae0527294mr1731949285a.23.1758959430710;
        Sat, 27 Sep 2025 00:50:30 -0700 (PDT)
Received: from arch-box ([2607:fea8:54de:2200::9c5c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c2737848csm415143585a.3.2025.09.27.00.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 00:50:29 -0700 (PDT)
From: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
To: Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>
Cc: Albin Babu Varghese <albinbabuvarghese20@gmail.com>,
	syzbot+48b0652a95834717f190@syzkaller.appspotmail.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: Add bounds checking in bit_putcs to fix vmalloc-out-of-bounds
Date: Sat, 27 Sep 2025 03:50:09 -0400
Message-ID: <20250927075010.119671-1-albinbabuvarghese20@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KASAN reports vmalloc-out-of-bounds writes in sys_imageblit during console
resize operations. The crash happens when bit_putcs renders characters 
outside the allocated framebuffer region.

Call trace: vc_do_resize -> clear_selection -> invert_screen ->
do_update_region -> fbcon_putcs -> bit_putcs -> sys_imageblit

The console resize changes dimensions but bit_putcs doesn't validate that 
the character positions fit within the framebuffer before rendering. 
This causes writes past the allocated buffer in fb_imageblit functions.

Fix by checking bounds before rendering:
- Return if dy + height > yres (would write past bottom)
- Break if dx + width > xres (would write past right edge)

Reported-by: syzbot+48b0652a95834717f190@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=48b0652a95834717f190  
Tested-by: syzbot+48b0652a95834717f190@syzkaller.appspotmail.com
Signed-off-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
---
 drivers/video/fbdev/core/bitblit.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/bitblit.c
index f9475c14f733..4c732284384a 100644
--- a/drivers/video/fbdev/core/bitblit.c
+++ b/drivers/video/fbdev/core/bitblit.c
@@ -160,6 +160,9 @@ static void bit_putcs(struct vc_data *vc, struct fb_info *info,
 	image.height = vc->vc_font.height;
 	image.depth = 1;
 
+	if (image.dy + image.height > info->var.yres)
+		return;
+
 	if (attribute) {
 		buf = kmalloc(cellsize, GFP_ATOMIC);
 		if (!buf)
@@ -173,6 +176,10 @@ static void bit_putcs(struct vc_data *vc, struct fb_info *info,
 			cnt = count;
 
 		image.width = vc->vc_font.width * cnt;
+
+		if (image.dx + image.width > info->var.xres)
+			break;
+
 		pitch = DIV_ROUND_UP(image.width, 8) + scan_align;
 		pitch &= ~scan_align;
 		size = pitch * image.height + buf_align;
-- 
2.51.0


