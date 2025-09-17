Return-Path: <linux-kernel+bounces-819975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39520B7D130
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51B9F166D87
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 04:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACAF26B2AD;
	Wed, 17 Sep 2025 04:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ai2ca+kJ"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D771D7E41
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 04:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758084697; cv=none; b=t75e9Swwq9o/MzXWP6stEuvC6dLCdE2UlyYh28R2xrwjP0r7AsbA6q6txKtbbpD0GOWX/QZuotE5ZGa9MrNPM39Zw0E819cBqM5JrghE4WT2+YQG0OIsfBU353/vD+nfKlywYK/GiPRJAX6ccSeT7Cx15x4OyYxvzh/yCwdSNkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758084697; c=relaxed/simple;
	bh=eBq9H4xIjBRAwKo2tBIMXWyZBxSf+01NnPWwxBCPU+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gQdE4/Fmc6TXm6WlZGlgicFIm8IPhtlQVUbu4T4Lwhw1g76Rz+58dEbn+793EQ1ExQbIze4FBbEQ7TkvS9mJKC5GTwPkXSE8aT3JlnQ5aE2HvVgDJiVGiYP/xmDr3OVd8SBpko2uL74QCLDA/Lx/0yALMxyk+K7z2cKgeR+kbhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ai2ca+kJ; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b523fb676efso4563445a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 21:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758084696; x=1758689496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l12+SyVuQT2nnjzs7oO7aJYiEciTeGoUNepyZVbe8Qg=;
        b=Ai2ca+kJU6nbYup7u8KSgxoE4Go7SN8uRrIhtidwGhgMl2YBbcRVJMLw5sYptsuTPQ
         8Rk0fO744+uCNbVUg/bPGGrZtdoE+foyHXZiZZmhkSXl2SLvMuNfvcKop1IKPm29i6zm
         EX1TgrxJgdsbLJ28ZHf+p2qL4ayOu/XcLajk5Ks8W1edaRb03A21GdOWUWMg7HBizhxQ
         KUr9vDbNU0opJImnTL4Di0uy6hamPvo76Ou4bu22zVVqvCHvqOrtTq3jMAr0F7TNIM/g
         mdA0yxIzJa8PnIvz6DJkmbJroade4ZZvlIRylUlDHidfRa3AQRdLdh16S0aAHfM/cBAV
         l6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758084696; x=1758689496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l12+SyVuQT2nnjzs7oO7aJYiEciTeGoUNepyZVbe8Qg=;
        b=Ev03VMbGsv3jcj1b8oQ/ryPF/YJn2koP2TxNJKXJTuKwKzkcnNcYj1LYqyjLBBCNGu
         O3zeY42u9SJUGMtdecK95ZyCU71C4kPreU5WuMpyF47UWKI+/cL91Px5I2M9sospxKEN
         B09tpCJSMVf26tci2RhCOPQP/nTO7XP/J4nNM30ZXTmQ3ysFOpY4fMwmVcr5KjkHae4Q
         lAXipCAruyKC70NPC+gOue41DI7AR5oelPtcKRVPlTIYVG/eoAujXJX+dQzNIApdB78Y
         ntx0O1sut2Ph6QFP/d6As/GKWWgFcMugyKpBtSkzFMIzttRGF4pJnFqC1CDAJ+SYpFSy
         bWTA==
X-Forwarded-Encrypted: i=1; AJvYcCXtjHO6BaJ0VFP04f/zcD9nbCeLefe/elCSbU3fCB7aSKDDwnNHVGBhkvLDiECWfIdzRykHYhkDhvjPyec=@vger.kernel.org
X-Gm-Message-State: AOJu0YxChPeZAMRR5B70tkHgm5xY3Ful6/fb1JEhbwnVTJO1Ig0mtd1a
	Tr+UlOGZ9CqrI3Vt24g5ENlpQmlAPtfyiiJIKwyVrtRmvHmZ9/EL6TOJ
X-Gm-Gg: ASbGncsZrPIYm3664dvv2CdSOvs5cbZQp73YXGxjvITO0z/iH9KYQVoiA+yNNUVP8DS
	GEcOdfgHqt6zD/wFjVrITHrpQIQv4aqiwpSKsfeyJaJfKKYWyoOqvnsMkUJ+kEbOKRc0e7hqxfZ
	PzscGQUCt0bHaqDQi0fb6I47PK9UZWEvBmX18YsQ4BWBwSBYFygIFpO0FtgrGS+/Z6WgWrq3Ax0
	BHwNaK1VT6BdodcXmnosRMdOxBI02Rm94yOaLDP52XY8LpF9BJ5IqqMBnF4e4Wkj6pUgH4J8B3Y
	3/zXJ040+TSyrT7S31561e0pURYXwO3ysQXfYdyIrsEjQeCCbXbJd2Q2sEb908XtFAyl1AgezBC
	HCKX2s3EUZy+9e8Z7L2r8ogXSNuJw3IZ/czg7j4YlJrxYX0jH
X-Google-Smtp-Source: AGHT+IGBaqGx7H5M1H4Flxyge/OwlLNw429tAgTEgBqOR1oXLDwpAnqBx8u0wVLxKgw7Vyy11rlyMg==
X-Received: by 2002:a17:902:e888:b0:246:4077:4563 with SMTP id d9443c01a7336-268137f242bmr7098995ad.34.1758084695547;
        Tue, 16 Sep 2025 21:51:35 -0700 (PDT)
Received: from orion (FL1-125-194-6-184.tky.mesh.ad.jp. [125.194.6.184])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267c19bf68esm40176265ad.111.2025.09.16.21.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 21:51:35 -0700 (PDT)
From: Masami Ichikawa <masami256@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: minbell.kim@samsung.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masami Ichikawa <masami256@gmail.com>
Subject: [PATCH] HID: hid-ntrig: Fix potential memory leak in ntrig_report_version()
Date: Wed, 17 Sep 2025 13:50:26 +0900
Message-ID: <20250917045026.601848-1-masami256@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kmalloc() was called before checking hid_is_usb(hdev). If hid_is_usb()
returned false, the function would return early and leak the allocated
memory.
It is safe to move the kmalloc() call after the hid_is_usb() check to avoid
unnecessary allocation and potential memory leak.

Fixes: 185c926283da ("HID: hid-ntrig: fix unable to handle page fault in ntrig_report_version()")
Signed-off-by: Masami Ichikawa <masami256@gmail.com>
---
 drivers/hid/hid-ntrig.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index 0f76e241e0af..52e8e7fe9681 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -142,11 +142,12 @@ static void ntrig_report_version(struct hid_device *hdev)
 	int ret;
 	char buf[20];
 	struct usb_device *usb_dev = hid_to_usb_dev(hdev);
-	unsigned char *data = kmalloc(8, GFP_KERNEL);
+	unsigned char *data = NULL;
 
 	if (!hid_is_usb(hdev))
 		return;
 
+	data = kmalloc(8, GFP_KERNEL);
 	if (!data)
 		goto err_free;
 
-- 
2.51.0


